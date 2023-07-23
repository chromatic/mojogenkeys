#!/usr/bin/env perl

use Modern::Perl;
use Crypt::Lite;

exit main( @ARGV );

sub main( $master_hd_key, $passphrase ) {
    my $crypt = Crypt::Lite->new( debug => 0 );
    say $crypt->encrypt( $master_hd_key, $passphrase );

    return 0;
}


