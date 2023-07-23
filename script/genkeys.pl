#!/usr/bin/env perl

use 5.36.0;
use Mojo::Base -strict;
use lib 'lib';

use Mojo::Server;
use Path::Tiny;
use Term::ReadKey;

exit main( @ARGV );

sub main ($keyfile, @rest) {
    my $key = path($keyfile)->slurp_utf8;

    # Start command line interface for application
    my $app = Mojo::Server->new->build_app('Genkey');

    $app->config( master_key => $key, decoder_key => _get_secret() );

    sub _get_secret {
        ReadMode(2);
        my $secret;

        say "Read secret key:";
        do {
            chomp($secret = ReadLine(0));
        } until ($secret);

        ReadMode(0);

        return $secret;
    }

    return $app->start(@rest);
}
