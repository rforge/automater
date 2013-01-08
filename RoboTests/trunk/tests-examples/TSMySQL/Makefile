#Typically do   make update ; make tests
# (make can be made to trigger  update, but it may not away be wanted and
#  it is hard to  get TESTS set propoerly if update has not been run. )

include    Makevars.in
include ../Makevars

# to avoid database conflicts
.NOTPARALLEL: $(TESTS:%=%out) 

tests:  $(TESTS:%=%out)
#tests: $(UPDATE) $(TESTS:%=%out)

include ../Makerules
