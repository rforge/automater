SNIPPETS=${shell  ls */*/DESCRIPTION | perl -pe 's/\/DESCRIPTION//g'  }
PACKAGES=${shell  ls -a -d */.. | perl -pe 's/\/..//g'  }

IMPORTS=${filter  ${PACKAGES},${shell perl -pe 's/,[\s]*\n/, /g' DESCRIPTION |\
  grep "Imports:"  | perl -pe 's/Imports\://' |  perl -pe 's/,//g' }}

#RESOURCES-MASK=${filter-out   RESOURCES-ONLY
# use sort here to remove duplicates (order does not matter).
#    ${sort ${DEPENDS} ${SUGGESTS} ${IMPORTS} ${NOTPARALLEL}}

#PACKAGES=${filter  ${ALLPACKAGES},

include Makevars.in
include Makevars.site


.PHONY:	R-version $(SNIPPETS) 

default: $(SNIPPETS)

test:
	echo $(PACKAGES)

$(PACKAGES): R-version
	@if [ ! -e $@/Makefile ]; then \
	    cp Makefile.packages.template $@/Makefile ; fi
	@$(MAKE) -k  --directory=$@


$(SNIPPETS): R-version $(PACKAGES)
	@if [ ! -e $@/Makefile ]; then \
	    cp Makefile.snippet.template $@/Makefile ; fi
	@#(cd $@ && $(MAKE)  -k || exit 1 )
	@$(MAKE) -k  --directory=$@

# Next is to set R-version file timestamp to the same value on all
#  test farm servers, since svn update does not preserve the timestamp.
# The first server to run with a new version of R should recognize this and
#  do the commit to update the R-version file

availableR=${shell R --slave  --version  | grep 'R version'}
committedR=${shell head -1 R-version }
Rdate=${shell tail -1 R-version }

# locking could be done in the next but may be more touble than it is worth.
# if the commit does not happen then the lock will remain and cause problems
# on all other servers. On the other hand, if not locked then the commit may 
# fail because some other server commited first (talking a few seconds between 
# update and commit here). This would only cause this server to fail on this 
# target attempt, but will be automatically fixed next time.
#svn lock   $@ -m 'updating R-version to $(availableR).' ;

#  THIS IS ASSUMING DIFFERENT VERSION IS NEWER VERSION!!!!
R-version:
	@svn update
	@if [ '$(committedR)' = '$(availableR)' ]; then \
	    touch --date "$(Rdate)"  $@ ;\
 	  else \
 	    echo changed R version ;\
	    echo '$(availableR)'             >$@ ;\
 	    date "+%Y/%m/%d %H:%M:%S.%N %Z" >>$@ ;\
	    svn commit $@ -m 'R-version updated to $(availableR).' ;\
 	  fi


cleanAll: 
	@for f in $(SNIPPETS)  ; do \
	    (cd $${f} && $(MAKE) clean ) || exit 1; done
	$(RM) */Makefile  */*/Makefile
