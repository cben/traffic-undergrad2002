TABLES = main34.tex mainflex.tex mainplans3.tex mainplans4.tex mainwisdoms.tex	\
         react.tex

BOOK = $(TABLES) book.ltx results/react_0.10-rand-car.ps

PRESENTATION = presentation.em presentation.xml bg2.png

SOURCES = basic.py city.py connect.py mktable.py multi.py run.py	\
          simtime.py textgrid.py utils.py

# Custom versions of the utils, with small fixes
PYDOC = ../pydoc.py
PY2PDF = ../py2pdf.py

all: book.pdf presentation.pdf source dist

.PHONY: all source dist

dist: book.zip presentation.zip source.zip source-pdf.zip

$(TABLES): mktable.py
	./mktable.py

book.dvi: $(BOOK)
	latex book.ltx

book.ps: book.dvi
	dvips book.dvi -o book.ps

book.pdf: book.ps
	ps2pdf book.ps book.pdf

book.zip: $(BOOK)
	-rm $@
	zip -9 $@ $^

presentation.xml: presentation.em
	em.py presentation.em > presentation.xml

presentation.pdf: presentation.xml bg2.png
	pythonpoint presentation.xml

presentation.zip: $(PRESENTATION)
	-rm $@
	zip -9 $@ $^

source: $(SOURCES:.py=.pdf) $(SOURCES:.py=.html)

%.pdf: %.py
	$(PY2PDF) $*.py

%.html: %.py
	$(PYDOC) -w $*

source.zip: $(SOURCES) $(SOURCES:.py=.html)
	-rm $@
	zip -9 $@ $^

source-pdf.zip: $(SOURCES:.py=.pdf)
	-rm $@
	zip -9 $@ $^

# The following are NOT run bu\y make all
bz2: results-ps.tar.bz2 results-dat.tar.bz2 results-other.tar.bz2

results-ps.tar.bz2:
	tar cjvf $@ `find results{,3,4} -name '*ps'`

results-dat.tar.bz2:
	tar cjvf $@ `find results{,3,4} -name '*dat'`

results-other.tar.bz2:
	tar cjvf $@ `find results{,3,4} -type f -not -name '*ps' -not -name '*dat'`
