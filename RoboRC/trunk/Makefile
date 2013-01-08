
# This will build R every day during the pre-release cycle.
# (Hopefully) works with R-rc and R-beta (using latest in /src/base-prerelease).
# The target R version is called R-test. Any previous R-test is removed.
# Only site-library is installed, but in other respects the installed R-test
#  is similar to RoboAdmin.  ${ROBOADMIN}/Makevars.site is used to find packages
# to install and tests/  uses the  tests in ${ROBOADMIN}/tests/

include Makevars

include ${ROBOADMIN}/Makevars.site

default: latest-ok installR site-library tests

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
	@test -n "$(LATEST)" || \
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

# do not use $(RPATH) dir for time stamp, it changes when libraries are installed
#   mail in Ubuntu requires mailutils
$(RPATH)/bin/Rcmd: $(ROBOHOME)/R-src/$(LATEST).tar.gz
	@echo making $@ ...
	@gunzip -c $< | tar xf -
	@rm -rf R-test
	@if    [ -d "R-beta" ]; then   mv R-beta R-test ;\
	  elif [ -d "R-rc"   ]; then   mv R-rc   R-test ;\
	  elif [ -d "R-patched"   ]; then   \
	    echo   "Only R-patched exists. Has new R been released?";\
	    echo   "(If so, stop any cron job that runs this.)" ; \
	    exit 1;\
	  fi
	(cd $(RPATH)/ ; ./configure --prefix=$(RPATH)/  --enable-R-shlib )
	(cd $(RPATH)// ; make )
	@touch $@

$(ROBOHOME)/R-src/$(LATEST).tar.gz: R-src/latestdt
	@echo making $@ ...
	rm -rf R-src/$(LATEST).tar.gz
	(cd R-src ; wget -o Rwget.log "$(BASE)/$(LATEST).tar.gz")
	@#wget seems to use web file date with UTC shift, so touch is important
	@touch $@

	
site-library: $(SITE:%=$(RPATH)/site-library/%) $(OTHERREPOSPKGS:%=$(RPATH)/site-library/%)
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

.PHONY: tests clean reallyclean

tests: site-library
	@(cd tests ; $(MAKE) $@)

clean:
	@$(RM) FLAGS testFame.db Rplots.pdf  R-patched
	@(cd tests ; $(MAKE) clean)
	$(RM) R-src

reallyclean: clean


