set INDIR=..\lib\
set INPREFIX=oms

set OUTDIR=.\tmp\
set OUTNAME=%INPREFIX%.min.js
set OUTFILE=%OUTDIR%%OUTNAME%

call coffee --output %OUTDIR% --compile %INDIR%%INPREFIX%.coffee

set theValue=
for /f "delims=" %%a in ('cygpath -m /usr/local/closure-compiler/compiler.jar') do @set JARPATH=%%a

java -jar "%JARPATH%" ^
  --compilation_level ADVANCED_OPTIMIZATIONS ^
  --js "%OUTDIR%%INPREFIX%.js" ^
  --externs google_maps_api_v3_7.js ^
  --output_wrapper '(function(){%%output%%}).call(this);' ^
  > "%OUTFILE%"

echo /* %date% %time% */ >> "%OUTFILE%"

rem cp $OUTFILE ../../gh-pages/bin
rem cp ${OUTDIR}${INPREFIX}.js ../../gh-pages/bin