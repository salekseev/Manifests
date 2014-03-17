#!/usr/bin/perl

use strict;
use warnings;
use Sys::Hostname;

my $host = hostname;
my $HN   = {};

### Parse hostname and create facts
if ( $host =~ m/^(\w)([\d\w]{2})(\d{3})(\w{3}\d)(\d{3})/ ) {
    $HN->{'host_type'} = $1;
    $HN->{'host_row'}  = $2;
    $HN->{'host_cab'}  = $3;
    $HN->{'host_site'} = $4;
    $HN->{'host_num'}  = $5;

    ### Convenience
    $HN->{'host_name'} = $host;

    ### Strip leading 0s
    $HN->{'host_row'}  =~ s/^0+//;
    $HN->{'host_cab'}  =~ s/^0+//;

    $HN->{'host_tile'} = $HN->{'host_row'} . $HN->{'host_cab'};
} else {
    printf( "host_info=na\n" );
}

### Print facts to STDOUT for Facter
foreach my $hkey ( keys( %{$HN} ) ) {
    printf( "%s=%s\n", $hkey, $HN->{$hkey} );
}

exit( 0 );
### EOF
