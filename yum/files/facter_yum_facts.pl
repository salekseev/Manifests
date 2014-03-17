#!/usr/bin/perl

use warnings;
use strict;

my $FACT_FILE = '/etc/facter/facts.d/yum.txt';
my $PKG_CHECK = '/usr/bin/yum --security check-update';
my $PKG_SECUP = 0;
my $PKG_AVAIL = 0;
# No packages needed for security; 37 packages available

open( FH, "$PKG_CHECK|" ) || die( "Could not run $PKG_CHECK.\n$!\n" );
while ( my $line = <FH> ) {
    chomp( $line );
    if ( $line =~ m/^(\d+).*for\ security/ ) {
        $PKG_SECUP = $1;
    } elsif ( $line =~ m/(\d+).*available$/ ) {
        $PKG_AVAIL = $1;
    }
}
close( FH );

open( FH, ">$FACT_FILE" ) || die( "Could not open $FACT_FILE for writing.\n$!\n" );
print FH "yum_security_updates=$PKG_SECUP\n";
print FH "yum_available_updates=$PKG_AVAIL\n";
close( FH );

#printf( "Needed security updates: $PKG_SECUP  Total available updates: $PKG_AVAIL\n" );

exit( 0 );
### EOF
