DIRS=${shell ls -p -d -1 * | grep "/" }

default: tests


tests testsite testfresh clean:
	@for f in ${DIRS}"" ; do \
	   if [ ! -f $$f/Makefile ]; then cp Makefile.default $$f/Makefile; fi ;\
	   (cd $$f ; $(MAKE) $@ );  \
	   done ; 
