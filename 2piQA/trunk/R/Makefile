#  see qc/ re filter-out  if needed
SNIPPETS=${shell  ls */*/DESCRIPTION | perl -pe 's/\/DESCRIPTION//g'  }
PACKAGES=${shell  ls -a -d */.. | perl -pe 's/\/..//g'  }


include Makevars.in

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
	    cp Makefile.snip.template $@/Makefile ; fi
	@#(cd $@ && $(MAKE)  -k || exit 1 )
	@$(MAKE) -k  --directory=$@

# Next is to set R-version file timestamp to the same value on all
#  test farm servers, since svn update does not preserve the timestamp.
# The first server to run with a new version of R should recognize this and
#  do the commit to update the R-version file

availableR=${shell R --slave  --version  | grep 'R version'}
committedR=${shell head -1 R-version }
Rdate=${shell tail -1 R-version }

#  THIS IS ASSUMING DIFFERENT VERSION IS NEWER VERSION!!!!
R-version:
	@if [ '$(committedR)' = '$(availableR)' ]; then \
	    touch --date "$(Rdate)"  $@ ;\
 	  else \
 	    echo changed R version ;\
 	    R '$(availableR)'                >$@ ;\
 	    date "+%Y/%m/%d %H:%M:%S.%N %Z" >>$@ ;\
	    echo NEED TO svn commit ;\
 	  fi


cleanAll: 
	@for f in $(SNIPPETS)  ; do \
	    (cd $${f} && $(MAKE) clean ) || exit 1; done
	$(RM) */Makefile  */*/Makefile
