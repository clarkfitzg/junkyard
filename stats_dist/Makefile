# Names of all figures to include
FIGURES := sin.pdf cos.pdf fake.pdf

############################################################

slides.pdf : slides.tex $(FIGURES)
	pdflatex slides.tex

# foo.py generates foo.pdf
%.pdf : %.py
	python $<
