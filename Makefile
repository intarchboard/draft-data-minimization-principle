

LIBDIR := lib
include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update $(CLONE_ARGS) --init
else
	git clone -q --depth 10 $(CLONE_ARGS) \
	    -b main https://github.com/martinthomson/i-d-template $(LIBDIR)
endif

OLDMINIREV=03
OLDMINI=draft-arkko-iab-data-minimization-principle-$(OLDMINIREV).txt
MACHINE=jar@cloud2.arkko.eu
PORT=-p 8820
SCPPORT=-P 8820

jaricompilemin:
	-@ssh $(PORT) $(MACHINE) 'cd /tmp; rm *.txt *.md *.xml'
	scp $(SCPPORT) draft-arkko-iab-data-minimization-principle.md \
		history/$(OLDMINI) \
		$(MACHINE):/tmp
	ssh $(PORT) $(MACHINE) 'cd /tmp; cat draft-arkko-iab-data-minimization-principle.md  | kramdown-rfc2629 | lib/add-note.py > draft-arkko-iab-data-minimization-principle-pre.xml'
	ssh $(PORT) $(MACHINE) 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc $(VERSOPT) draft-arkko-iab-data-minimization-principle-pre.xml; cp draft-arkko-iab-data-minimization-principle-pre.txt draft-arkko-iab-data-minimization-principle.txt'
	scp $(SCPPORT) $(MACHINE):/tmp/draft-arkko-iab-data-minimization-principle.txt .
	ssh $(PORT) $(MACHINE) 'cd /tmp; rfcdiff $(OLDMINI) draft-arkko-iab-data-minimization-principle.txt'
	scp $(SCPPORT) $(MACHINE):/tmp/draft-arkko-iab-data-minimization-principle-pre.xml \
		./draft-arkko-iab-data-minimization-principle.xml
	scp $(SCPPORT) $(MACHINE):/tmp/draft-arkko-iab-data-minimization-principle.txt .
	scp $(SCPPORT) $(MACHINE):/tmp/draft-arkko-iab-data-minimization-principle-from--$(OLDMINIREV).diff.html history
	scp draft-*-data-minimization-*.txt history/draft-*-data-minimization-*.html root@cloud3.arkko.eu:/var/www/www.arkko.com/html/ietf/iab
