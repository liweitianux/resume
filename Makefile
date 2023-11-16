DEPS:= resume.cls
SRCS:= resume-zh.tex resume-en.tex
PDFS:= $(SRCS:%.tex=%.pdf)
PDFCAT:= resume-zh+en.pdf

DATE= $(shell date +%Y%m%d)
DISTDIR= resume.$(DATE)

all: $(PDFCAT)
en: resume-en.pdf
zh: resume-zh.pdf

$(PDFCAT): $(PDFS)
	gs -dBATCH -dNOPAUSE -dPrinted=false \
		-sDEVICE=pdfwrite \
		-sOutputFile=$@ \
		$(PDFS)

%.pdf: %.tex $(DEPS)
	latexmk -xelatex $<

dist: all
	mkdir $(DISTDIR)
	cp Makefile $(DEPS) $(SRCS) $(PDFS) $(DISTDIR)/
	tar -cjf $(DISTDIR).tar.bz2 $(DISTDIR)/
	rm -r $(DISTDIR)

clean:
	for f in $(SRCS); do \
		latexmk -c $$f; \
	done
	touch $(SRCS)

cleanall:
	for f in $(SRCS); do \
		latexmk -C $$f; \
	done

.PHONY: all en zh dist clean cleanall
