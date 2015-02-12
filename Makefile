FILES=report.pdf

all: report.pdf

watch:
	wr "make" report.md citations.bib templates/template.latex

%.tex: %.md citations.bib templates/template.latex
	pandoc $*.md --filter pandoc-citeproc --latex-engine=xelatex --template=templates/template.latex -S -o $*.tex

%.pdf: %.tex
	xelatex $*.tex -o $*.pdf # Run twice to update labels
	@echo "Updating Labels..."
	@xelatex $*.tex -o $*.pdf 2>&1 > /dev/null

clean:
	rm -f report.pdf report.log report.out report.aux references.bibtex texput.log


