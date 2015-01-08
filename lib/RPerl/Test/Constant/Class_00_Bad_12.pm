# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'Global symbol "$TYPED_PIE" requires explicit package name' >>>

# [[[ HEADER ]]]
package RPerl::Test::Constant::Class_00_Bad_12;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ CONSTANTS ]]]
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 4: allow constants
use constant PI  => my number $TYPED_PI  = 3.141_59;
use constant PIE =>  string $TYPED_PIE = 'pecan';

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 3: allow OO properties
    empty_property => my integer $TYPED_empty_property = 2
);

# [[[ OO METHODS ]]]
our void__method $empty_method = sub { return 2; };

1;                  # end of class
