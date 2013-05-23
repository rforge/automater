# from Makevars.in
# this is not used on individual servers, only for wrapup assessSnippets
# which needs to be run for the web site
OSTYPES=Linux Ubuntu32 Ubuntu64 Mint64

# make rules to be used at the R/ level for maintenance.

####################################################################
# from Makefile
#     Targets below will not usually be run by farm servers

####################################################################

# This target is to create directories for new OSTYPES.
# It needs to be run only once for a new OS_TAG.
# First, set the OS_TAG in Makevars.site and add it to OSTYPES in Makevars.in.
MK_OS_TAG:
	this needs to be checked
	svn add Testing/$(OS_TAG)
	for p in $(PACKAGES)"" ; do        \
	   mkdir Testing/$(OS_TAG)/$$p    ;\
	   svn add Testing/$(OS_TAG)/$$p  ;\
	   $(MAKE) -j1 --directory=$(OS_TAG)/$$p MK_OS_TAG ; done


# This target sets the R-version time stamp to a new date/time so that
# a complete remake will trigger. It is only for developement/debugging purposes.

fakeNewR-version:
	echo '$(availableR)'             >R-version 
	date "+%Y/%m/%d %H:%M:%S.%N %Z" >>R-version
	$(COMMIT) 'R-version $(availableR) time stamp reset.' R-version

cleanAll: 
	check  this
	@for f in $(PACKAGES)  ; do \
	    (cd Testing/$(OS_TAG)/$${f} && $(MAKE) clean ) || exit 1; done
	$(RM) Testing/$(OS_TAG)/*/Makefile

####################################################################
# from Makerules.package
#     Targets below will not usually be run by farm servers

####################################################################

# This target is to create directories for new OSTYPES.
# It needs to be run only once for a new OS_TAG.
# First, set the OS_TAG in Makevars.site and add it to OSTYPES in Makevars.in.
MK_OS_TAG:
	touch  -d 1990/01/01 $(PAC)-version
	$(ADD) $(PAC)-version
	$(MAKE) $(PAC)-version
	$(MAKE) Makevars.auto
	for s in $(SNIPPETS)"" ; do $(MAKE) -j1 --directory=$$s MK_OS_TAG ; done


# This target sets the R-version time stamp to a new date/time so that
# a remake will trigger. It is only for developement/debugging purposes.
# This only affects the package in the package it the specific OS_TAG

fakeNewPackage-version:
	echo '$(installedPKG)'             >$(PAC)-version 
	date "+%Y/%m/%d %H:%M:%S.%N %Z"   >>$(PAC)-version
	for f in $(SNIPPETS)""; do \
	   echo "UNKNOWN" > $$f/TESTABLE ; done 
	$(COMMIT) '$(PAC)-version $(installedPKG) time stamp reset.' \
	    $(PAC)-version

clean:
	$(RM) Makevars.auto Makevars.auto.tmp LABEL.png


####################################################################
# from Makerules.snippet
#     Targets below will NOT usually be run by farm servers

####################################################################

# This target is to create directories for new OSTYPES.
# It needs to be run only once for a new OS_TAG.
# First, set the OS_TAG in Makevars.site and add it to OSTYPES in Makevars.in.
MK_OS_TAG:
	echo "UNKNOWN"  > TESTABLE
	touch  STATUS_SUMMARY
	touch  WHYNOT.TXT
	if [ -n "$(RFILES)" ] ; then  \
	   for f in $(RFILES)""; do  touch $${f}out ; done; \
	   for f in $(RFILES)""; do  touch $${f}-STATUS ; done ; fi
	# old date is just to be sure it is older than R-version
	touch -d 1990/01/01  *

# need svn ignore SEE fixPackages
# svn propset svn:ignore "
#Makevars.auto
#Makefile
#*-trigger"   Testing/$o/$p
#also
#*-trigger"   Testing


# if TESTABLE gets set to other than UNKNOWN, but then the server that could
#  run the snip goes off-line and others cannot run it, it is a bit difficult to get back
#  to the UNKNOWN and thus untested state. R code assessSnippet() will compensate but issue
#  a warning. This target nukeTESTABLE is to get back to a proper UNKNOWN state.
#  Target nukeTESTABLE  is meant only to run at the level of a specific snippet.
#  If there are problems with many packages, consider fakeNewR-version.

nukeTESTABLE:
	echo "UNKNOWN"  > TESTABLE
	rm -f  STATUS_SUMMARY
	touch  STATUS_SUMMARY
	$(COMMIT)  "reset $(OS_TAG)  TESTABLE to UNKNOWN and cleaned STATUS_SUMMARY" )

what-if: 
	$(MAKE) --what-if=../$(PAC)-version  default

clean:
	$(RM) *.pdf *.ps *.tmp
	$(UPDATE)
