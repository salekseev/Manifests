This new base os profile makes use of puppetforge community modules where
 possible.  Modules at topdir are used like a 'library'.  In the base, they
 are implemented via a profile class in modules/base/manifests/TYPE_profile.pp

A Server Role should include new base and its corrosponding server classes.
 server classes should leverage community modules as well where applicable.

Example
 base uses postfix to configure postfix as localhost only service
 smtp server class uses postfix to fully configure smtp server

To checkout use:
git clone ssh://git@git.symcpe.net:7999/cip/development.git

To run locally/test use:
 cd new_base
 ./scripts/test-bash.sh base   [or base::some_profile]
		
Joe DeCello
joe_decello@symantec.com
