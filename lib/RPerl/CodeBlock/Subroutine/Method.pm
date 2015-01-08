package RPerl::CodeBlock::Subroutine::Method;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_002;

## no critic qw(Capitalization ProhibitMultiplePackages)  # SYSTEM DEFAULT 3: allow multiple lower case package names

use parent qw(RPerl::CodeBlock::Subroutine);
our %properties = (); ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 3: allow OO properties

# [[[ SETUP ]]]
# [[[ SETUP ]]]
# [[[ SETUP ]]]

# a method is a subroutine belonging to a class or object
package method;
use parent ('RPerl::CodeBlock::Subroutine::Method');

# [[[ SCALAR & SCALAR REF METHODS ]]]
# [[[ SCALAR & SCALAR REF METHODS ]]]
# [[[ SCALAR & SCALAR REF METHODS ]]]

# method with void return type
package void__method;
use parent -norequire, ('method');

# method with integer return type
package integer__method;
use parent -norequire, ('method');

# method with (ref to integer) return type
package integer_ref__method;
use parent -norequire, ('method');

# method with float return type
package float__method;
use parent -norequire, ('method');

# method with (ref to float) return type
package float_ref__method;
use parent -norequire, ('method');

# method with number return type
package number__method;
use parent -norequire, ('method');

# method with (ref to number) return type
package number_ref__method;
use parent -norequire, ('method');

# method with char return type
package char__method;
use parent -norequire, ('method');

# method with (ref to char) return type
package char_ref__method;
use parent -norequire, ('method');

# method with string return type
package string__method;
use parent -norequire, ('method');

# method with (ref to string) return type
package string_ref__method;
use parent -norequire, ('method');

# method with scalartype return type
package scalartype__method;
use parent -norequire, ('method');

# method with (ref to scalartype) return type
package scalartype_ref__method;
use parent -norequire, ('method');

# method with unknown return type
package unknown__method;
use parent -norequire, ('method');

# method with (ref to unknown) return type
package unknown_ref__method;
use parent -norequire, ('method');

# method with object return type
package object__method;
use parent -norequire, ('method');

# method with (ref to object) return type
package object_ref__method;
use parent -norequire, ('method');

# [[[ HASH METHODS ]]]
# [[[ HASH METHODS ]]]
# [[[ HASH METHODS ]]]

package integer__hash_ref__method;
use parent -norequire, ('method');

package number__hash_ref__method;
use parent -norequire, ('method');

package string__hash_ref__method;
use parent -norequire, ('method');

# [[[ ARRAY METHODS ]]]
# [[[ ARRAY METHODS ]]]
# [[[ ARRAY METHODS ]]]

package integer__array_ref__method;
use parent -norequire, ('method');

package number__array_ref__method;
use parent -norequire, ('method');

package string__array_ref__method;
use parent -norequire, ('method');

package object__array_ref__method;
use parent -norequire, ('method');

1;
