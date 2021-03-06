FILES=report.pdf

all: report.pdf

watch:
	wr --exec "make" report.md citations.bib templates/template.latex

%.tex: %.md citations.bib templates/template.latex
	pandoc $*.md --filter pandoc-citeproc --latex-engine=xelatex --template=templates/template.latex -S -o $*.tex

%.pdf: %.tex
	xelatex $*.tex -o $*.pdf -halt-on-error -no-file-line-error# Run twice to update labels
	@echo "Updating Labels..."
	@xelatex $*.tex -o $*.pdf 2>&1 > /dev/null

clean:
	rm -f report.pdf report.log report.out report.aux references.bibtex texput.log pandoc_template.tar.gz

archive: pandoc_template.tar.gz

pandoc_template.tar.gz:
	git archive --format tar.gz HEAD > pandoc_template.tar.gz
