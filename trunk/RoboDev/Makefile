
# This will build R every day during the pre-release cycle.
# Only site-library is installed, but in other respects this is similar to
# RoboAdmin.  ${ROBOADMIN}/Makevars.site is used to find package to install
# and tests/  uses the  tests in ${ROBOADMIN}/tests/

include Makevars

include ${ROBOADMIN}/Makevars.site

default: latest-ok installR site-library 

#latest-ok is just to provide more meaningful error messages when getDates 
# failed to get the version info. 
#Do not make this a prereq, since phony is alway run
.PHONY: latest-ok
latest-ok:
	@echo making $@ ...
	@test -d "R-src" || \
	   (echo "Error. R-src/ does not exist. Did you run ./getPreRelDates" ; \
	    exit 1)
	@test -z "`grep 'ERROR' R-src/Rver.log`" || \
	          (echo from   R-src/Rver.log: ; cat  R-src/Rver.log; exit 1 )
	@test -n "$(RPATH)" || \
	   (echo "Error. latest indicator is empty. HTTP probably failed." ; \
	    exit 1)
	

installR: check
	@echo making $@ ...
	(cd $(RPATH) ; make install )
	@test -z "$(RUSERS)" || \
	  echo "A new R has been installed in $(RPATH)" | \
	           mail -s "$(RPATH) now available" $(RUSERS) 
	@$(MKDIR) FLAGS
	@touch FLAGS/$@

.INTERMEDIATE:build

#   bin/R seems to get touched install, so use bin/Rcmd here
build: $(RPATH)/bin/Rcmd

check: build
	@echo making $@ ...
	(cd $(RPATH) ; make check )
	@$(MKDIR) FLAGS
	@touch FLAGS/$@

check-all: build
	@echo making $@ ...
	(cd $(RPATH) ; make check-all )
	@$(MKDIR) FLAGS
	@touch FLAGS/$@

# do not use dir for time stamp, as it will change when libraries are installed
#   mail in Ubuntu requires mailutils
$(RPATH)/bin/Rcmd: $(ROBOHOME)/R-src/$(LATEST).tar.gz
	@echo making $@ ...
	test -d "$(RRPATH)" || mv $(RPATH) $(RPATH).pre$(LATEST)
	@gunzip -c $< | tar xf -
	(cd $(RPATH) ; ./configure --prefix=$(RPATH) )
	(cd $(RPATH) ; make )
	@touch $@

$(ROBOHOME)/R-src/$(LATEST).tar.gz:
	@echo making $@ ...
	(cd R-src ; wget -o Rwget.log "$(BASE)/$(LATEST).tar.gz")

	
### site-library  ## typically installed with new R version and not updated 
site-library: $(SITE:%=$(RPATH)/site-library/%) $(OTHERREPOSPKGS:%=$(RPATH)/site-library/%)
	@echo making $@ ...
	@test -z "$(RUSERS)" || \
	  echo "New packages have been installed in $(RPATH)/site-library" | \
	           mail -s "R site-library packages installed" $(RUSERS) 
	@touch FLAGS/$@

$(SITE:%=$(RPATH)/site-library/%): installR
	@echo making $@ ...
	@$(MKDIR) $(RPATH)/site-library
	$(R) 'install.packages(pkgs="$(notdir $@)", lib="$(RPATH)/site-library", repos=$(REPOS), INSTALL_opts="--byte-compile") ; q(status=0)'
	@#do not touch $@ or failed install looks like success to make

$(OTHERREPOSPKGS:%=$(RPATH)/site-library/%): installR
	@echo making $@ ...
	@$(MKDIR) $(RPATH)/site-library
	$(R) 'install.packages(pkgs="$(notdir $@)", lib="$(RPATH)/site-library", repos=$(OTHERREPOS), INSTALL_opts="--byte-compile") ; q(status=0)'
	@#do not touch $@ or failed install looks like success to make

update-site-library: site-library #Note - normal policy is not to do this
	@echo making $@ ...
	$(R) 'update.packages(lib.loc="$(RPATH)/site-library", repos=$(REPOS), INSTALL_opts="--byte-compile", ask=FALSE) ; q(status=0)'
	test -z "$(OTHERREPOS)" ||  $(R) \
	   'update.packages(lib.loc="$(RPATH)/site-library", repos=$(OTHERREPOS), INSTALL_opts="--byte-compile", ask=FALSE) ; q(status=0)'
	@touch FLAGS/$@

.PHONY: tests testsite clean reallyclean

tests testsite: 
	@(cd tests ; $(MAKE) $@)

clean:
	@$(RM) FLAGS testFame.db Rplots.pdf  R-patched
	@(cd tests ; $(MAKE) clean)
	$(RM) R-src

reallyclean: clean


