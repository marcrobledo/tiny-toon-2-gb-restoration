@echo off

REM delete current assembled rom
IF EXIST .\roms\tiny_toon_2_en_restored.gb del .\roms\tiny_toon_2_en_restored.gb

cd src
:begin
set assemble=1
echo assembling...
..\rgbds\rgbasm -otiny_toon_2_en_restored.obj main.asm
if errorlevel 1 goto error
echo linking...
REM -n generates a sym file with subroutines name and offsets for debugger
..\rgbds\rgblink -o../roms/tiny_toon_2_en_restored.gb -O./../roms/tiny_toon_2_en.gb -n../roms/tiny_toon_2_en_restored.sym tiny_toon_2_en_restored.obj 
if errorlevel 1 goto error
echo fixing...
..\rgbds\rgbfix -p0 -v ../roms/tiny_toon_2_en_restored.gb
del tiny_toon_2_en_restored.obj
goto end
:error
pause
:end
cd..
