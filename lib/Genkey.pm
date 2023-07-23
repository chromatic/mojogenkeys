package Genkey;

use Mojo::Base 'Mojolicious', -signatures;
use Deriver;

sub startup ($self) {
    $self->helper( deriver => sub($c) {
        state $deriver = Deriver->new(
            secret => delete $c->config->{decoder_key},
            master_key => $c->config->{master_key}
        );
    });

    my $r = $self->routes;

    $r->get('/newkey' => sub ($c) {
        my $index = $c->param('index');
        my $derived = $c->deriver->derive_key($index);
        $c->render(json => $derived);
    });
}

1;
