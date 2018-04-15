#
# Makefile for alyresume
#
# Weitian LI
# 2018-04-12
#

DEPS:= resume.cls fontawesome.sty
SRCS:= resume-zh.tex resume-en.tex
PDFS:= $(SRCS:%.tex=%.pdf)

all: $(PDFS)

resume-zh.pdf: resume-zh.tex $(DEPS)
	latexmk -xelatex $<

resume-en.pdf: resume-en.tex $(DEPS)
	latexmk -xelatex $<

clean:
	for f in $(SRCS); do \
		latexmk -c $$f; \
	done
	touch $(SRCS)

cleanall:
	for f in $(SRCS); do \
		latexmk -C $$f; \
	done

.PHONY: clean cleanall


# One liner to get the value of any makefile variable
# Credit: http://blog.jgc.org/2015/04/the-one-line-you-should-add-to-every.html
print-%: ; @echo $*=$($*)
