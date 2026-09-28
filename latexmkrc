# --- General output configuration --- old
# $bibtex = 'biber --input-directory=.. %O %S';
# $out_dir = '.build';
# $aux_dir = '.build';
# $ignore_errors = 1;
# --- General output configuration --- new
$biber = 'biber %O %S';
# $biber = 'biber --input-directory=.. %O %S';
$bibtex_use = 2;
$pdf_mode = 1;
$out_dir = '.build';
$aux_dir = '.build';
# $ignore_errors = 1;   # disabled: let real LaTeX errors surface instead of forcing a PDF
