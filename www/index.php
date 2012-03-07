<HTML>
<TITLE>automateR</TITLE></a>
<hr>
<?php require("header.php") ; ?>
<hr>
<?php  require("forgeBar.php") ; ?>
<table width=100% ALIGN=CENTER CELLPADDING=5 border=0>
<?php require("navigate.php") ; ?>
<!-------------------- START OF CONTENTS -------------------------->
<BODY BGCOLOR="#FFFFFF">
<hr>
<b><i>automateR</i></b> has several sub-projects to automate certain tasks 
related to maintaining an <i>R</i> installation and site-specific testing of packages. The project does not (yet)
include any <i>R</i> packages, but the Subversion Repository has directories 
with structures for automatically doing tasks related to installing and
maintaining <i>R</i>, and regularly testing <i>R</i> code segments. 
These rely on gmake and cron jobs and should work on any system that 
supports these facilities (but has not been broadly tested).

<P>
<a href=RoboAdmin.php><b>RoboAdmin</b></a> provides tools that automatically
install new versions of <i>R</i> when they are released, and runs site
specific tests to ensure everything works with the new version. 

<P>
<a href=RoboRC.php><b>RoboRC</b></a> provides tools that automatically run
site specific tests to ensure everything works with <i>R</i> release candidates.

<P>
<a href=RoboDev.php><b>RoboDev</b></a> provides tools that automatically run
site specific tests to ensure everything works with the develeopment version 
of <i>R</i>.

<P>
<a href=RoboTests.php><b>RoboTests</b></a> provides tools that automatically
runs tests suites with a specific versions of <i>R</i> and record results
from the different test suites.

<P>
<a href=develMake.php><b>develMake</b></a> provides tools to support development
of <i>R</i> packages.


<!-------------------------------- END OF CONTENTS ------------------->
</table>

</body></html>
