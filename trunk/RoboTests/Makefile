include  Makevars

DIRS=${shell (ls -p -d -1 * | grep "/" )}

default: tests

testz:
	echo ${DIRS}

tests clean:
	@for f in ${DIRS}"" ; do \
	   (cd $$f ; $(MAKE) $@ );  \
	   done ; 
