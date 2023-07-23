use Object::Pad;

class Deriver {
    use Crypt::Lite;
    use Finance::Libdogecoin::FFI;

    has $key;

    ADJUSTPARAMS( $params ) {
        $key = Crypt::Lite->new->decrypt($params->{master_key}, $params->{secret});
    }

    method derive_key ($index) {
        my $path = "m/44'/3'/0'/0/$index";
        Finance::Libdogecoin::FFI::context_start();
        my $key = Finance::Libdogecoin::FFI::get_derived_hd_key_by_path($key, $path, 0);
        Finance::Libdogecoin::FFI::context_stop();

        return { key => $key, path => $path };
    }
}
