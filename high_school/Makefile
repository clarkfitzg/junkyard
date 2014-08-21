target := data_pres

# variable for everything in the `figs` directory
figs := $(wildcard figs/*)

$(target).pdf : $(target).tex $(figs) normal.pdf
	pdflatex $(target).tex

normal.pdf : normal.R
	R CMD BATCH --vanilla normal.R

clean :
	rm *.aux *.log *.nav *.out *.snm *.toc *.vrb *.Rout
