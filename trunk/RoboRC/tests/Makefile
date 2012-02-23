include ../Makevars

#DIRS=${shell (cd $(ROBOADMIN)/tests; ls -p -d -1 * | grep "/" )}

tests: RoboAdminTests

RoboAdminTests: RoboAdmin/DirTime
	(cd RoboAdmin/tests ; $(MAKE)  testsite ) 

RoboAdmin/DirTime: $(RPATH)/bin/Rcmd
	rm -rf RoboAdmin
	mkdir RoboAdmin
	cp -r $(ROBOHOME)/Makevars.in    RoboAdmin
	cp -r $(ROBOHOME)/Makevars       RoboAdmin
	cp -r $(ROBOADMIN)/Makevars.site RoboAdmin
	cp -r $(ROBOADMIN)/tests         RoboAdmin
	(cd RoboAdmin/tests ; $(MAKE) clean )
	touch $@

clean:
	rm -rf RoboAdmin
