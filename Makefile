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

DOCKER_CLI?=	sudo docker
DOCKER_IMAGE:=	resume:test
DOCKER_CHOWN:=	chown -R $(shell id -u):$(shell id -g) .

# build the resume within an docker container
docker:
	$(DOCKER_CLI) image inspect -f 'ok' $(DOCKER_IMAGE) 2>/dev/null || \
	{ \
		rm -rf _empty && \
		mkdir _empty && \
		$(DOCKER_CLI) build --tag $(DOCKER_IMAGE) \
			-f Dockerfile _empty && \
		rmdir _empty; \
	}
	$(DOCKER_CLI) run --rm --volume $(PWD):/build $(DOCKER_IMAGE) \
		sh -c "cd /build && make clean && make && $(DOCKER_CHOWN)"

podman: DOCKER_CLI=podman
podman: DOCKER_CHOWN=:
podman: docker

.PHONY: docker podman
