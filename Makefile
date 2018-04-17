#
# Makefile for alyresume
#
# Weitian LI
# 2018-04-12
#

DEPS:= resume.cls fontawesome.sty
SRCS:= resume-zh.tex resume-en.tex
PDFS:= $(SRCS:%.tex=%.pdf)

DATE= $(shell date +%Y%m%d)
DISTDIR= resume.$(DATE)

all: $(PDFS)

resume-zh.pdf: resume-zh.tex $(DEPS)
	latexmk -xelatex $<

resume-en.pdf: resume-en.tex $(DEPS)
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

.PHONY: dist clean cleanall


# One liner to get the value of any makefile variable
# Credit: http://blog.jgc.org/2015/04/the-one-line-you-should-add-to-every.html
print-%: ; @echo $*=$($*)
