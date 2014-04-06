DIRS=${shell ls -p -d -1 * | grep "/" }


default tests: testsite testfresh 

.PHONY: testsite testfresh clean

clean:
	@for f in ${DIRS}"" ; do \
	   (cd $$f ; $(MAKE) $@ );  \
	   done ; 

testsite:
	@if [ -z "${DIRS}" ]; then \
	   echo There are no tests installed ;\
	   exit 1;\
	   fi
	@for f in ${DIRS}"" ; do \
	   (cd $$f ; $(MAKE) testsite );  \
	   done ; 
	@for f in ${DIRS}"" ; do \
	   if [ -f $$f/*.Rout.fail ]; then \
	      echo see errors in $$f/*.Rout.fail. Tail: ;\
	      tail -5 $$f/*.Rout.fail ;\
	      grep "there is no package" $$f/*.fail ;\
	      fi ;\
	   done ; 

testfresh:
	@if [ -z "${DIRS}" ]; then \
	   echo There are no tests installed ;\
	   exit 1;\
	   fi 
	@for f in ${DIRS}"" ; do \
	   (cd $$f ; $(MAKE) $@ );  \
	   done ; 
	@for f in ${DIRS}"" ; do \
	   if [ -f $$f/*.Routfresh.fail ]; then \
	      echo see errors in $$f/*.Routfresh.fail. Tail: ;\
	      tail -5 $$f/*.Routfresh.fail ;\
	      grep "there is no package" $$f/*fresh.fail ;\
	      fi ;\
	   done ; 

updateAll:
	@if [ -z "${DIRS}" ]; then \
	   echo There are no tests installed ;\
	   exit 1;\
	   fi
	@for f in ${DIRS}"" ; do \
	   (cd $$f ; svn update );  \
	   (cd $$f ; svn status );  \
	   done ; 
