# [[[ HEADER ]]]
package RPerl::HelperFunctions_cpp;
use strict;
use warnings;
use RPerl::Config; # get Carp, English, $RPerl::INCLUDE_PATH without 'use RPerl;'

#use RPerl;  # DEV NOTE: need to use HelperFunctions in RPerl::DataStructure::Array for type checking SvIOKp() etc; remove dependency on RPerl void__method type so HelperFunctions can be loaded by RPerl type system
our $VERSION = 0.002_010;

# [[[ CRITICS ]]]
## no critic qw(ProhibitStringyEval) # SYSTEM DEFAULT 1: allow eval()

# [[[ SUBROUTINES ]]]
#our void__method $cpp_load = sub {  # DEV NOTE: remove dependency on RPerl
sub cpp_load {
    my $need_load_cpp = 0;
    if (    ( exists $main::{'RPerl__HelperFunctions__ops'} )
        and ( defined &{ $main::{'RPerl__HelperFunctions__ops'} } ) )
    {
#        RPerl::diag "in HelperFunctions_cpp::cpp_load, RPerl__HelperFunctions__ops() exists & defined\n";
#        RPerl::diag q{in HelperFunctions_cpp::cpp_load, have RPerl__HelperFunctions__ops() retval = '} . main::RPerl__HelperFunctions__ops() . "'\n";
        if ( main::RPerl__HelperFunctions__ops() ne 'CPP' ) {
            $need_load_cpp = 1;
        }
    }
    else {
#        RPerl::diag "in HelperFunctions_cpp::cpp_load, RPerl__HelperFunctions__ops() does not exist or undefined\n";
        $need_load_cpp = 1;
    }

    if ($need_load_cpp) {

#        RPerl::diag "in HelperFunctions_cpp::cpp_load, need load CPP code\n";

#BEGIN { RPerl::diag "[[[ BEGIN 'use Inline' STAGE for 'RPerl/HelperFunctions.cpp' ]]]\n"x3; }
        my $eval_string = <<"EOF";
package main;
use RPerl::Inline;
use Inline (CPP => "$RPerl::INCLUDE_PATH/RPerl/HelperFunctions.cpp", \@RPerl::Inline::ARGS);
1;
EOF

#        RPerl::diag "in HelperFunctions_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

        eval $eval_string or croak( $OS_ERROR . "\n" . $EVAL_ERROR );
        if ($EVAL_ERROR) { croak($EVAL_ERROR); }

#RPerl::diag "[[[ END 'use Inline' STAGE for 'RPerl/HelperFunctions.cpp' ]]]\n"x3;
    }

#	else { RPerl::diag "in HelperFunctions_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
}

1;
1;
