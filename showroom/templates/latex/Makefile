# Copied somewhat from Rob Hyndman
# http://robjhyndman.com/hyndsight/makefiles/

# Name of the paper
TEXFILE= paper

$(TEXFILE).pdf : $(TEXFILE).tex normal_R.pdf normal_py.pdf normal.R normal.py
	pdflatex $(TEXFILE).tex

normal_R.pdf : normal.R
	R CMD BATCH --vanilla normal.R 

normal_py.pdf : normal.py
	python normal.py

view :
	open $(TEXFILE).pdf

clean :
	rm *.aux *.log *.nav *.out *.snm *.toc *.vrb *.Rout
