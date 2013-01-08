
#Typically do   make update ; make tests
# (make can be made to trigger  update, but it may not away be wanted and
#  it is hard to  get TESTS set propoerly if update has not been run. )

#  ../Makevars goes up real path not sym link, so
TST=${shell cd ../ ; pwd}

-include       Makevars.in
include $(TST)/Makevars

#tests: $(UPDATE) $(TESTS:%=%out)
tests:  $(TESTS:%=%out)

include $(TST)/Makerules


