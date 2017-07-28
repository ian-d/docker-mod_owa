This is intended as a starting point to transition off of Oracle HTTP Server (OHS) with mod_plsql, which has been deprecated. The suggested Oracle replacement is Oracle APEX [\[0\]](https://docs.oracle.com/middleware/1221/webtier/administer-ohs/whats_new.htm#CHDBGAHH). However, Oracle also provides an open-source alternative to mod_plsql called mod_owa [\[1\]](https://oss.oracle.com/projects/mod_owa/dist/documentation/modowa.htm) that is still under active development.

Running mod_owa in Apache 2.4 is a reasonable work-alike for anyone used to OHS and is fast, simple to configure, and creates a small Docker image off the official Apache httpd:2.4 image.

## You Need to Supply:
This is a starting point, and the Dockerfile relies on files that can't be distributed with this repo:
- The Oracle 12c instant client basic and the Oracle 12c instant client SDK: [\[2\]](http://www.oracle.com/technetwork/database/features/instant-client/index-097480.html)
- `mod_owa.so` from the mod_owa downloads: [\[3\]](https://oss.oracle.com/projects/mod_owa/dist/files/unix_all.tgz) (64 bit Linux)

## Configuration
This drops `tnsnames.ora` in `/opt/oracle/instantclient` and a `dads.conf` config in `/usr/local/apache2/conf/`, you'll need to modify them as needed. Again, this is just a starting point. The `OwaUserid` configuration option for mod_owa only uses ora names, so make sure any db entries used in a mod_owa locations are in `tnsnames.ora`.

[0] https://docs.oracle.com/middleware/1221/webtier/administer-ohs/whats_new.htm#CHDBGAHH  
[1] https://oss.oracle.com/projects/mod_owa/dist/documentation/modowa.htm  
[2] http://www.oracle.com/technetwork/database/features/instant-client/index-097480.html  
[3] https://oss.oracle.com/projects/mod_owa/dist/files/unix_all.tgz
