# [[[ HEADER ]]]
package RPerl::Algorithm::Sort_cpp;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitStringyEval) # SYSTEM DEFAULT 1: allow eval()

# [[[ INCLUDES ]]]
use RPerl::Algorithm_cpp;

# [[[ SUBROUTINES ]]]
our void__method $cpp_load = sub {
    my $need_load_cpp = 0;
    if (    ( exists $main::{'RPerl__Algorithm__Sort__ops'} )
        and ( defined &{ $main::{'RPerl__Algorithm__Sort__ops'} } ) )
    {
#        RPerl::diag "in Sort_cpp::cpp_load, RPerl__Algorithm__Sort__ops() exists & defined\n";
#        RPerl::diag q{in Sort_cpp::cpp_load, have RPerl__Algorithm__Sort__ops() retval = '} . main::RPerl__Algorithm__Sort__ops() . "'\n";
        if ( main::RPerl__Algorithm__Sort__ops() ne 'CPP' ) {
            $need_load_cpp = 1;
        }
    }
    else {
#        RPerl::diag "in Sort_cpp::cpp_load, RPerl__Algorithm__Sort__ops() does not exist or undefined\n";
        $need_load_cpp = 1;
    }

    if ($need_load_cpp) {

        #        RPerl::diag "in Sort_cpp::cpp_load, need load CPP code\n";

        my $eval_string = <<"EOF";
package main;
use RPerl::Inline;
BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for 'RPerl/Algorithm/Sort.cpp' ]]]\n" x 0); }
use Inline (CPP => "$RPerl::INCLUDE_PATH/RPerl/Algorithm/Sort.cpp", \@RPerl::Inline::ARGS);
RPerl::diag("[[[ END 'use Inline' STAGE for 'RPerl/Algorithm/Sort.cpp' ]]]\n" x 0);
1;
EOF

#        RPerl::diag "in Sort_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

        eval $eval_string or croak( $OS_ERROR . "\n" . $EVAL_ERROR );
        if ($EVAL_ERROR) { croak($EVAL_ERROR); }
    }

#    else { RPerl::diag "in Sort_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

1;
1;
