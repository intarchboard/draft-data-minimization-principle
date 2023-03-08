TARGETS_DRAFTS := draft-arkko-iab-data-minimization-principle 
TARGETS_TAGS := 
draft-arkko-iab-data-minimization-principle-00.md: draft-arkko-iab-data-minimization-principle.md
	sed -e 's/draft-arkko-iab-data-minimization-principle-latest/draft-arkko-iab-data-minimization-principle-00/g' $< >$@
