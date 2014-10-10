# Copied somewhat from Rob Hyndman
# http://robjhyndman.com/hyndsight/makefiles/

# Name of the paper
TEXFILE= paper

$(TEXFILE).pdf : $(TEXFILE).tex regress.pdf
	pdflatex $(TEXFILE).tex

regress.pdf : regress.R
	R CMD BATCH --vanilla regress.R 

view :
	open $(TEXFILE).pdf

clean :
	rm *.aux *.log *.nav *.out *.snm *.toc *.vrb *.Rout
