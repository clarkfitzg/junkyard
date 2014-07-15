
paper.pdf: paper.tex figure.pdf
	pdflatex paper.tex

figure.pdf: data.csv plot.R
	R CMD BATCH plot.R

data.csv: get_data.py
	python get_data.py
