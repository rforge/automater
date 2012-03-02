DIRS=${shell ls -p -d -1 * | grep "/" }

default:checksite checkfresh checkdevel

tests: testsite 

.PHONT: testsite testfresh testdevel clean

clean:
	@for f in ${DIRS}"" ; do \
	   if [ ! -f $$f/Makefile ]; then cp Makefile.default $$f/Makefile; fi ;\
	   (cd $$f ; $(MAKE) $@ );  \
	   done ; 

testsite:
	@for f in ${DIRS}"" ; do \
	   if [ ! -f $$f/Makefile ]; then cp Makefile.default $$f/Makefile; fi ;\
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
	@for f in ${DIRS}"" ; do \
	   if [ ! -f $$f/Makefile ]; then cp Makefile.default $$f/Makefile; fi ;\
	   (cd $$f ; $(MAKE) $@ );  \
	   done ; 
	@for f in ${DIRS}"" ; do \
	   if [ -f $$f/*.Routfresh.fail ]; then \
	      echo see errors in $$f/*.Routfresh.fail. Tail: ;\
	      tail -5 $$f/*.Routfresh.fail ;\
	      grep "there is no package" $$f/*fresh.fail ;\
	      fi ;\
	   done ; 

testdevel:
	@for f in ${DIRS}"" ; do \
	   if [ ! -f $$f/Makefile ]; then cp Makefile.default $$f/Makefile; fi ;\
	   (cd $$f ; $(MAKE) $@ );  \
	   done ; 
	@for f in ${DIRS}"" ; do \
	   if [ -f $$f/*.Routdevel.fail ]; then \
	      echo see errors in $$f/*.Routdevel.fail. Tail:  ;\
	      tail -5 $$f/*.Routdevel.fail ;\
	      grep "there is no package" $$f/*devel.fail ;\
	      fi ;\
	   done ; 
