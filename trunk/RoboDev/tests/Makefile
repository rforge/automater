include ../Makevars

DIRS=${shell (cd $(ROBOADMIN)/tests; ls -p -d -1 * | grep "/" )}

default: tests

testz:
	echo ${DIRS}

#dir is created if it does not exist, and Makefile.default copied there. If a 
#test requires a special Makefile then the directory and Makefile need to exist.
tests testsite clean:
	@for f in ${DIRS}"" ; do \
	   mkdir -p $$f ; \
	   if [ ! -f $$f/Makefile ]; then cp Makefile.default $$f/Makefile; fi ;\
	   (cd $$f ; $(MAKE) $@ );  \
	   done ; 
