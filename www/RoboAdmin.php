<hr>
<?php require("header.php") ; ?>
<hr>
<?php  require("forgeBar.php") ; ?>
<table width=100% ALIGN=CENTER CELLPADDING=5 border=0>
<?php require("navigate.php") ; ?>
<!-------------------- START OF CONTENTS -------------------------->
<BODY BGCOLOR="#FFFFFF">
<b>RoboAdmin</b>
<hr>
<P>
<b>RoboAdmin</b> provides tools which automatically
install new versions of <i>R</i> when they are released, installs a specified
list of packages in <i>site-library</i> and in <i>site-library-fresh</i>, and 
does regular updates of the packages in <i>site-library-fresh</i>. When
<i>R</i> or package updates are done, a set of site-specific tests are run, and support
people automatically notified if these fail. 
Users can also be autmatically notified when a new version of R is available.
<P>
The process does not remove old versions of R. Users are responsible for setting 
their path to select the version they use. The <i>site-library</i> is only
updated at the same time as a new version of R is installed, so users can be 
guaranteed a consistent environment once they set their path to a specific version. 
If they do want the latest available packages then they can do this by setting 
<i>site-library-fresh</i> to be used in their <i>R</i> session.
<P>
See the README files in the top level directory for more details, and the 
sub-directories in the tests-examples/ directory for examples of site 
specifice testing.
<P>
<b>RoboAdmin</b> is available by anonymous checkout from the code repository.
