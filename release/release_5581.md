Go to SiteAdmin -> Ingest Tools -> Manage Jena Models
Find - vitro-kb-applicationMetadata  ; click clear statements
 * this can take a while, to see if it's cleared click: Output Model; make sure there are no statements in there

Find - asserted-tbox  ; click clear statements; click Output Model; make sure there are no statements in there

In Unix; go to the top level vivo directory eg; vivo-cub-staging/vivo-cub
ant all

sudo service tomcat.tomcat-cub-staging stop
 ( if it doesn't stop you will have to sudo kill -9 the process )

sudo service tomcat.tomcat-cub-staging start

tail -f /usr/local/tomcat.local/tomcat-cub-staging/logs/vivo.all.log
if you start seeing that it's computing the abox and it slowly scrolls through a few hundred thousand items, you will have to kill -9 the tomcat process; then restart it

Finally, a harvest needs to be run against ALL models, this is because deleting from the asserted-tbox blows away most data.
