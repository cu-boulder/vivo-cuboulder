VIVO-FIS 
----------
#### Experts Release 1

This project is a three tier build for the VIVO Environment like those found at Cornell and other
VIVO Institutions.  This project will use a variety of build files for the various server
environments at CU along with a development build that takes advantage of seperate source 
locations for VIVO and VITRO.  We'll also bulk up the deployment of VIVO with some git deployment
scripts that allow with a blank repository on the other end a user to redeploy VIVO from a git
push.


There is also an automated [Ansible](https://github.com/ansible/ansible) build utility located [here](https://github.com/cu-boulder/fis_vivo_deployment).

Manual Deployment of Submodules - faceted search (people, equipment), expertsmap -- This needs to be done prior to the ant build
----------------------------------------------------------------------------------------------
 In your vivo instance vivo-cub directory:
 Verify the facetview submodule was downloaded:
 1. cd plugins/facetedsearch
  a. git status; git branch  should show that you're on the facetedsearch repo
 2. If the directory is empty or repo needs to be refreshed do:
  a. go to instance/vivo-cub directory: cd ../..;  git submodule update --init --recursive
 Next copy the facetedsearch files to the correct location in the local vivo directory:
 1. cp plugins/facetedsearch/html/people.html themes/cu-boulder/templates/people.ftl
 2. cp -rp plugins/facetedsearch/html/facetview2 themes/cu-boulder/templates
 Verify expertsmap submodule was downloaded:
  1. cd plugins/expertsmap
  a. git status; git branch  should show that you're on the expertsmap repo
 2. If the directory is empty or repo needs to be refreshed do:
  a. go to instance/vivo-cub directory: cd ../..;  git submodule update --init --recursive
 Next copy the expertsmap files to the correct location in the local vivo directory:
 1. vivo-cub$ cp plugins/expertsmap/templates/expertsmap.html themes/cu-boulder/templates/expertsmap.ftl
 2.vivo-cub$ cp -rp plugins/expertsmap/ themes/cu-boulder/expmap
 3. Copy images: cp -rp plugins/expertsmap/images/ themes/cu-boulder/expertsmap


Command Line Deployment
----------------------------------------------------------------------------------------------
There are a variety of deploy.properties files associated with CU Boulder.  They start with 
deploy.properties and end with their intended purpose.

  ex.
    deploy.properties.staging = deployment file for the staging server
    deploy.properties.vivo-cub = deployment file for developing cu boulder along side source
      code for VIVO and VITRO

You will still use the ANT command to deploy VIVO on these servers.  However you'll need to copy 
the appropriate file to the base. So say I wanted to deploy vivo on 
staging for CU Boulder I would from the root project folder

  ```bash
  $ cd /fis-vivo/config
  $ cp build.xml.vivo-cub-staging ../../build.xml
  $ cp build.properties.vivo-cub-staging ../../build.properties
  $ cp runtime.properties.vivo-cub-staging ../../runtime.properties
  $ cd ../../
  $ ant all
  ```

Manual Changes via VIVO SiteAdmin GUI
----------------------------------------------------------------------------------------------
1. Change Awards class to be in Honors class group instead of Research classgroup
2. Add internal and external awarding organization to the Organization page classgroup browser -- should automate this in the menu.n3 file
3. Manually make an /expertsmap page to resolve the experts map ( Future is to create this page in .n3 file in rdf code just like people page)
 a. SiteAdmin -> Page management 
 b. scroll down and click "Add Page" button
 c. Title = Expertsmap; Pretty URL = /expertsmap; select "Custom template containing all content"; Select Page Permissions = Anyone can view this page
 d. Save


GIT Release
-----------------------------------------------------------------------------------------------
> NOTE: This has not been used since the pre-1.7 release in 2014. Documentation may be outdated.

Releasing a site using git flow is a rather straight forward process of migrating the code from the develop 
branch to the master branch. This process is made very simply by git flow release.

  ```git flow release start version-name```

Release allows you to modify the code for version changes after all major changes have been done. While on the 
release branch you should never make serious code changes!


## Step 1. identify your version

Run "git tag" to see the tagged versions of vivo in the system. You'll probably get a list that looks like

  ```
  1.5.1-vivo-1.0
  1.5.1-vivo-1.1
  pre-experts
  experts-release-1
  ```

This will help you determine the version for your release. If you have updated the code base to reflect a newer 
version of VIVO, update the first number and reset our version number to 1.0 (ex 1.6-vivo-1.0). If you have made 
a minor change to our code base you can either add an incremental number to the last number (ex 1.5.1-vivo-1.1.1) 
or increment the last digit (ex 1.5.1-vivo-1.2). If you are making major modifications for an announced release 
increment the first digit in the second number (ex 1.5.1-vivo-2.0).

We are following a standard set forth by several open source communities (such as Ubuntu) who reflect the upstream 
version number as the first set of digits when they have made modifications to a package and their revision as the 
second set.


## Step 2. Start the release process

Now that we have our new version number we can begin the release

  ```git flow release start version-name```


## Step 3. Increment our version in revisionInfo

There is a file that is read at the root of vivo and when logged in displays information in the footer and on  
http://vivo.site.edu/revisionInfo. The first line is the version for cuboulder-vivo, this is always the revision 
number you used for the git flow process. The second line is the revision of the release. Instead of starting over 
at 1 with each release, I followed what appears to be the vivo way of using the number of commits. Since each release 
adds 2 commits, one for the changes made during the release process and one for the merge, increment the number of 
commits on develop by 2.


## Step 4. Create Release Log

There is a new folder in our git repository called changelog. In here is a file for each revision with the commits 
history between that revision and its predecessor. The command to generate this log file is

  ```git log --no-merges HEAD ^last-revision-number > ChangeLog/this-revision-number```

The first parameter excludes merges since those don't contain code changes, but all of the changes made on the branch 
that is being merged in. The second set of parameters tells it to start at the HEAD and work back to the tag marked 
by the last revision number. Finally we send this information to a new file in ChangeLog? named for the current 
revision we're attempting to release.


## Step 5. Create Release Notes

To make it easy on us to review the changes made over time we'll append to release_notes.txt information about the 
current release. Though we could read/cat/grep the ChangeLog? file in the future, its much easier to put some of this 
into writing and commit it to the git history. The first step to adding to the release notes is to get a shorter 
version of the git log.

  ```git shortlog --no-merges HEAD ^last-revision-number```

This prints to the screen the same information as git log, but in a more condensed format grouped by author and using 
only the commit messages and not the date time or revision numbers. We'll copy this output and open the release_notes.txt 
file. Once open you should see a page that looks like this

	/-------------------------------------------------------------
	- Release Notes for the VIVO Project at 
	- the University of Colorado	
	-	
	- created 12/21/2012 - svw
	- updated 01/02/2012 - svw
	-
	- Code Authors - Alex Viggio, Vance Howard, Stephen Williams
	-------------------------------------------------------------/
	
	/*************************************************************
	* Release 1.5.1-vivo-1.1
	* Minor revisions to release procedures and update of selenium
	* scripts to properly define faculty
	* 01/02/2013
	*************************************************************/

	Stephen V. Williams (5):
	      Change Logs not released ...
	      new setup procedure for cythna
	      addition of revision information
	      removed about.ftl per ticket 1083
	      changed migration scripts for new production settings, fixed selenium scripts from adding vivo:FacultyMember
	
	
	/*************************************************************
	* Release 1.5.1-vivo-1.0
	* First release to production targeting the 1.5.1 code base
	* for VIVO
	* 12/21/2012
	*************************************************************/
	
	Alex Viggio (16):
	      first commit
	      added original VIVO 1.2 and Harvester 1.1.1 source files
	      cleanup	
	      cleanup
	      ignore Mac OS X noise
	      added CU-Boulder theme and deploy files
	      Modified search to exclude images, and web.xml
	      Fixes issue with random borders being added to thumbnails
	      PelletReasonerSetupPseudocompleteIgnoreDataproperties
	      Override default images
	      modified TOS
	      Modified templates
	      added ozy config files
	      Changes made in place on ozy to get Tomcat vhost working
	      Update themes/uccs/templates/identity.ftl
	      Update themes/uccs/templates/page-home.ftl
	
	Stephen V. Williams (79):
	      Add new ignore commands for eclipse files (.project, .classpath, and bin/)
	      Reconfigured fis-vivo-1.2 for 3rd level build based on diff between fis-vivo-1.2 and vivo-1.2 release
	      Modifications from production to the fis-vivo-1.2

Create a new space between the header and the first release on the page and past your shortlog into the document. Then copy 
the header of the previous release and modify it for version information, date, and brief description of the changes made. Copy 
this release header to use in the merge message at the end of this process then save the file.


## Step 6. Commit Changes

Like most things in git, everything needs to be commited before it can be merged with other revisions. Run `git add .` and 
`git commit` to commit the release notes. revisionInfo, and change log to the git repository. For the message at this point I 
simply write "Release Documents for " and the revision number. Once everything is committed we're ready for the last step.


## Step 7. Release Finish

Run the command

  ```git flow release finish version-name```

This will begin the merge process with master. You'll have to supply messages for each of the merges, master and back to develop. 
This is where I copy in the header of the release notes for this version.

When the process is complete you should be sent back to develop and the revision number for develop and master should be equal. 
Then just push both repositories to git hub and push the tags

  ```bash
  $ git push
  $ git push --tags
  ```
