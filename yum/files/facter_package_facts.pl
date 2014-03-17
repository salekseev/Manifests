#!/usr/bin/perl

use warnings;
use strict;

use Data::Dumper;


my $PKG_DIR   = '/etc/facter/packages.d';
my $FACT_FILE = '/etc/facter/facts.d/packages.txt';
my $RPM       = '/bin/rpm -qi';
my $PKGS      = {};


my $dir = opendir( PKG_DIR, $PKG_DIR ) || die( "Could not open directory $PKG_DIR\n$!\n" );
while ( my $package = readdir( PKG_DIR ) ) {
    my $pkg_path = "$PKG_DIR/$package";
    next if ( $package =~ m/^\./ );
    next if ( ! -f $pkg_path     );

    my $version   = '0';
    my $release   = '0';

    open( FH, "$RPM $package|" ) || die( "Could not open $RPM $pkg_path.\n$!\n" );
    while ( my $line = <FH> ) {
        chomp( $line );
        if ( $line =~ m/^version\s*:\s*([^\s]+)/i ) {
            $version = $1;
        } elsif ( $line =~ m/^release\s*:\s*([^\s]+)/i ) {
            $release = $1;
        }
    }
    close( FH );

    $package =~ s/\-/\_/g;
    $PKGS->{$package} = $version . '-' . $release;
}
closedir( PKG_DIR );

open( FH, ">$FACT_FILE" ) || die( "Could not open $FACT_FILE for writing.\n$!\n" );
foreach my $package_version ( sort( keys( %{$PKGS} ) ) ) {
    print FH "package_version_$package_version=$PKGS->{$package_version}\n";
}
close( FH );

exit( 0 );

### EOF
