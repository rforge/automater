include ../Makevars

#DIRS=${shell (cd $(ROBOADMIN)/tests; ls -p -d -1 * | grep "/" )}

default: RoboAdmin

RoboAdmin:
	mkdir RoboAdmin
	cp -r $(ROBOHOME)/Makevars.in    RoboAdmin
	cp -r $(ROBOHOME)/Makevars       RoboAdmin
	cp -r $(ROBOADMIN)/Makevars.site RoboAdmin
	cp -r $(ROBOADMIN)/tests         RoboAdmin
	(cd RoboAdmin/tests ; make clean ) 
	(cd RoboAdmin/tests ; make  testsite ) 

clean:
	rm -rf RoboAdmin
