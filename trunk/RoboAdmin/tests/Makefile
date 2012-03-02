DIRS=${shell ls -p -d -1 * | grep "/" }

tests: testsite testfresh checksite checkfresh 

testsite testfresh testdevel clean:
	@for f in ${DIRS}"" ; do \
	   if [ ! -f $$f/Makefile ]; then cp Makefile.default $$f/Makefile; fi ;\
	   (cd $$f ; $(MAKE) $@ );  \
	   done ; 

checktests: checksite checkfresh checkdevel

checksite:
	@for f in ${DIRS}"" ; do \
	   if [ -f $$f/*.Rout.fail ]; then \
	      echo see errors in $$f/*.Rout.fail. Tail: ;\
	      tail -5 $$f/*.Rout.fail ;\
	      grep "there is no package" $$f/*.fail ;\
	      fi ;\
	   done ; 

checkfresh:
	@for f in ${DIRS}"" ; do \
	   if [ -f $$f/*.Routfresh.fail ]; then \
	      echo see errors in $$f/*fresh.Rout.fail. Tail: ;\
	      tail -5 $$f/*.Routfresh.fail ;\
	      grep "there is no package" $$f/*fresh.fail ;\
	      fi ;\
	   done ; 

checkdevel:
	@for f in ${DIRS}"" ; do \
	   if [ -f $$f/*.Routdevel.fail ]; then \
	      echo see errors in $$f/*devel.Rout.fail. Tail:  ;\
	      tail -5 $$f/*.Routdevel.fail ;\
	      grep "there is no package" $$f/*devel.fail ;\
	      fi ;\
	   done ; 
