# Copied somewhat from Rob Hyndman
# http://robjhyndman.com/hyndsight/makefiles/

# Name of the paper
TEXFILE= paper

$(TEXFILE).pdf : $(TEXFILE).tex hw1.R
	pdflatex $(TEXFILE).tex

nonlinear.pdf : nonlinear.R
	R CMD BATCH --vanilla nonlinear.R 

view :
	open $(TEXFILE).pdf

clean :
	rm *.aux *.log *.nav *.out *.snm *.toc *.vrb *.Rout
