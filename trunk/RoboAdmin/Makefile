
# BEWARE that the default is run often by a cron job, so following should 
#    usually only need to do fresh (update -site-library-fresh). 
#  Other targets should only trigger if getDates indicates 
#    a new R version is released.

include Makevars

include Makevars.site

default: latest-ok installR site-library site-library-fresh \
  site-library-fresh-notdevel  site-library-devel  fresh

site: site-library

fresh: update-site-library-fresh

devel: update-site-library-devel

notdevel: update-site-library-fresh-notdevel

# Note tframePlus needs WriteXLS which needs Perl
# bitops from CRAN is needed for RCurl
#  install.packages(pkgs=c("RCurl","SSOAP"), 
#    lib=Sys.getenv("R_LIBS"), 
#    repos="http://www.omegahat.org/R", dependencies=TRUE)
#ROracle

#latest-ok is just to provide more meaningful error messages when getDates 
# failed to get the version info. 
#Do not make this a prereq, since phony is alway run
.PHONY: latest-ok
latest-ok:
	@echo making $@ ...
	@test -z "`grep 'ERROR' R-src/Rver.log`" || \
	          (echo from   R-src/Rver.log: ; cat  R-src/Rver.log; exit 1 )
	@test -n "$(LATEST)" || \
	   (echo "Error. latest indicator is empty. HTTP probably failed." ; \
	    exit 1)
	

installR: check
	@echo making $@ ...
	(cd $(ROBOHOME)/$(LATEST) ; make install )
	@test -z "$(RUSERS)" || \
	  echo "A new R has been installed in $(ROBOHOME)/$(LATEST)" | \
	           mail -s "$(LATEST) now available" $(RUSERS) 
	@$(MKDIR) FLAGS
	@touch FLAGS/$@

.INTERMEDIATE:build

#   bin/R seems to get touched install, so use bin/Rcmd here
build: $(ROBOHOME)/$(LATEST)/bin/Rcmd

check: build
	@echo making $@ ...
	(cd $(ROBOHOME)/$(LATEST) ; make check )
	@$(MKDIR) FLAGS
	@touch FLAGS/$@

check-all: build
	@echo making $@ ...
	(cd $(ROBOHOME)/$(LATEST) ; make check-all )
	@$(MKDIR) FLAGS
	@touch FLAGS/$@

# do not use dir for time stamp, as it will change when libraries are installed
#   mail in Ubuntu requires mailutils
$(ROBOHOME)/$(LATEST)/bin/Rcmd: $(ROBOHOME)/R-src/$(LATEST).tar.gz
	@echo making $@ ...
	@test -z "$(RSUPPORT)" || echo "Starting build of new version of R in$(ROBOHOME)/$(LATEST)" | \
	           mail -s "$(LATEST) building" $(RSUPPORT) 
	@$(RM) $(LATEST)
	@gunzip -c $< | tar xf -
	(cd $(ROBOHOME)/$(LATEST) ; ./configure --prefix=$(ROBOHOME)/$(LATEST) )
	(cd $(ROBOHOME)/$(LATEST) ; make )
	@touch $@

$(ROBOHOME)/R-src/$(LATEST).tar.gz: R-src/latestdt
	@echo making $@ ...
	(cd R-src ; wget -o Rwget.log "$(BASE)/$(LATEST).tar.gz")
	
### site-library  ## typically installed with new R version and not updated 
site-library: $(SITE:%=$(LATEST)/site-library/%) $(OTHERREPOSPKGS:%=$(LATEST)/site-library/%)
	@echo making $@ ...
	@test -z "$(RUSERS)" || \
	  echo "New packages have been installed in $(ROBOHOME)/$(LATEST)/site-library" | \
	           mail -s "R site-library packages installed" $(RUSERS) 
	@touch FLAGS/$@

$(SITE:%=$(LATEST)/site-library/%): installR
	@echo making $@ ...
	@$(MKDIR) $(ROBOHOME)/$(LATEST)/site-library
	$(R) 'install.packages(pkgs="$(notdir $@)", lib="$(ROBOHOME)/$(LATEST)/site-library", repos=$(REPOS), INSTALL_opts="--byte-compile") ; q(status=0)'
	@#do not touch $@ or failed install looks like success to make

$(OTHERREPOSPKGS:%=$(LATEST)/site-library/%): installR
	@echo making $@ ...
	@$(MKDIR) $(ROBOHOME)/$(LATEST)/site-library
	$(R) 'install.packages(pkgs="$(notdir $@)", lib="$(ROBOHOME)/$(LATEST)/site-library", repos=$(OTHERREPOS), INSTALL_opts="--byte-compile") ; q(status=0)'
	@#do not touch $@ or failed install looks like success to make

update-site-library: site-library
	@echo making $@ ...
	$(R) 'update.packages(lib.loc="$(ROBOHOME)/$(LATEST)/site-library", repos=$(REPOS), INSTALL_opts="--byte-compile", ask=FALSE) ; q(status=0)'
	test -z "$(OTHERREPOS)" ||  $(R) \
	   'update.packages(lib.loc="$(ROBOHOME)/$(LATEST)/site-library", repos=$(OTHERREPOS), INSTALL_opts="--byte-compile", ask=FALSE) ; q(status=0)'
	test -z "$(RUSERS)" || \
	  echo "Some package updates have been done in $(ROBOHOME)/$(LATEST)/site-library" | \
	           mail -s "R site-library updated" $(RUSERS) 
	@touch FLAGS/$@

### site-library-fresh ##  updated as needed 
site-library-fresh: $(FRESH:%=$(LATEST)/site-library-fresh/%)

$(FRESH:%=$(LATEST)/site-library-fresh/%): installR
	@echo making $@ ...
	@$(MKDIR) $(LATEST)/site-library-fresh
	$(R) 'install.packages(pkgs="$(notdir $@)", lib="$(ROBOHOME)/$(LATEST)/site-library-fresh", repos=$(REPOS), INSTALL_opts="--byte-compile") ;  q(status=0)'
	@#touch $@

update-site-library-fresh: site-library-fresh
	@echo making $@ ...
	$(R) 'update.packages(lib.loc="$(ROBOHOME)/$(LATEST)/site-library-fresh", repos=$(REPOS), INSTALL_opts="--byte-compile", ask=FALSE) ; q(status=0)'
	@test -z "$(OTHERREPOS)" || $(R) \
	   'update.packages(lib.loc="$(ROBOHOME)/$(LATEST)/site-library-fresh", repos=$(OTHERREPOS), INSTALL_opts="--byte-compile", ask=FALSE) ; q(status=0)' 
	@#touch FLAGS/$@ do not touch. always update


### site-library-fresh-notdevel ##  updated as needed ## use for for qc testing
site-library-fresh-notdevel: $(FRESHnotDEVEL:%=$(LATEST)/site-library-fresh-notdevel/%)

$(FRESHnotDEVEL:%=$(LATEST)/site-library-fresh-notdevel/%): installR
	@echo making $@ ...
	@$(MKDIR) $(LATEST)/site-library-fresh-notdevel
	$(R) 'install.packages(pkgs="$(notdir $@)", lib="$(ROBOHOME)/$(LATEST)/site-library-fresh-notdevel", repos=$(REPOS), INSTALL_opts="--byte-compile") ; q(status=0)'
	@#touch $@

update-site-library-fresh-notdevel: site-library-fresh-notdevel
	@echo making $@ ...
	$(R) 'update.packages(lib.loc="$(ROBOHOME)/$(LATEST)/site-library-fresh-notdevel", repos=$(REPOS), INSTALL_opts="--byte-compile", ask=FALSE) ; q(status=0)'
	@test -z "$(OTHERREPOS)" ||  $(R) \
	   'update.packages(lib.loc="$(ROBOHOME)/$(LATEST)/site-library-fresh-notdevel", repos=$(OTHERREPOS), INSTALL_opts="--byte-compile", ask=FALSE) ; q(status=0)'

### site-library-devel ## most recent versions (usually tested and working)
site-library-devel: $(DEVEL:%=$(LATEST)/site-library-devel/%)

$(DEVEL:%=$(LATEST)/site-library-devel/%): installR
	@echo making $@ ...
	@$(MKDIR) $(LATEST)/site-library-devel
	$(R) 'install.packages(pkgs="$(notdir $@)", lib="$(ROBOHOME)/$(LATEST)/site-library-devel", repos=$(DEVELREPOS), INSTALL_opts="--byte-compile") ; q(status=0)'
	@#touch $@

update-site-library-devel: site-library-devel
	@echo making $@ ...
	$(R) 'update.packages(lib.loc="$(ROBOHOME)/$(LATEST)/site-library-devel", repos=$(DEVELREPOS), INSTALL_opts="--byte-compile", ask=FALSE) ; q(status=0)'
	@test -z "$(OTHERDEVELREPOS)" || $(R) \
	    'update.packages(lib.loc="$(ROBOHOME)/$(LATEST)/site-library-devel", repos=$(OTHERDEVELREPOS), INSTALL_opts="--byte-compile", ask=FALSE) ; q(status=0)'

.PHONY: tests testfresh clean reallyclean

tests testsite testfresh: 
	@(cd tests ; $(MAKE) $@)

clean:
	@echo this does not remove the built or installed R, or packages
	$(RM) FLAGS testFame.db Rplots.pdf 
	@(cd tests ; $(MAKE) clean)

reallyclean: clean
	@echo this does not remove the built or installed R, or packages
	@echo WARNING reallyclean removes R-src/index.html src/latest src/latestdt
	@echo so run ./getDates before make
	$(RM) R-src/index.html R-src/latest R-src/latestdt


