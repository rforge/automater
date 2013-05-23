PACKAGES:=${shell  ls -a -d ../Packages/*/..  | perl -pe 's/\/\.\.//g' | perl -pe 's/\.\.\/Packages\///g' }

include Makevars.site
include Makevars.in

# need  to do make checkVersions first, but it is not default

default:  $(PACKAGES)

test:
	@echo $(2piHOME)
	@echo $(PACKAGES)
	@echo $(R)
	@echo $(MKR)

$(PACKAGES):%: $(OS_TAG)/%

.PHONY:  $(PACKAGES:%=$(OS_TAG)/%) 

$(PACKAGES:%=$(OS_TAG)/%):%:  %/Makefile  # PHONY  
	@$(MAKE) -k  --directory=$@

$(PACKAGES:%=$(OS_TAG)/%/Makefile):
	@echo "# this gets generated automatically in each package dir"  >$@
	@# Makevars.site specifies wher R is, which is needed in Makevars.in
	@echo "include $(2piHOME)/Makevars.site"                        >>$@
	@echo "include $(2piHOME)/Makevars.in"                          >>$@
	@echo '-include Makevars-$$(PAC).site'                          >>$@
	@echo "include $(2piHOME)/Makerules.package"                    >>$@


# R-version and $(PAC)-version are pre-reqs so cannot be PHONY or the 
#  other targets always run too.
# "make checkVersions" updates them, and needs to be run first.
# The result is that "make checkVersions ; make"  is needed.

checkVersions: checkRversion $(PACKAGES:%=$(OS_TAG)/%/checkVersion)

# This target actually updates R-version. That cannot be PHONY because
# it is a pre-req for everything else. This is effectively PHONY because
# it does not produce a file checkRVersion.

checkRversion: checkNewPackages
	@$(RSYNC)  -tuq $(CENTRAL)/R-version  .

checkNewPackages:  
	@#pull
	@$(RSYNC) -tru $(CENTRAL)/../Packages/  ../Packages/
	$(RSYNC) -tru $(CENTRAL)/$(OS_TAG)/     $(OS_TAG)/

$(PACKAGES:%=$(OS_TAG)/%/checkVersion):%/checkVersion:  %/Makefile  checkNewPackages 
	@$(MAKE) -k  --directory=$(dir $@) checkVersion

clean:
	$(RM) */*/Makefile */*/Makevars.auto  */*/*/Makefile
