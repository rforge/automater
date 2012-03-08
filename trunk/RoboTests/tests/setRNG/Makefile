#  ../Makevars goes up real path not the link if this directory
#   is a soft link, so next works even it that case.
TST=${shell cd ../ ; pwd}

-include       Makevars.in
include $(TST)/Makevars

tests:  $(TESTS:%=%out)

include $(TST)/Makerules


