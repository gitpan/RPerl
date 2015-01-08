#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.004_010;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  # DEVELOPER DEFAULT 2: allow string test values
## no critic qw(ProhibitStringyEval) # SYSTEM DEFAULT 1: allow eval()
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireCheckingReturnValueOfEval)  # SYSTEM DEFAULT 4: allow eval() test code blocks

use RPerl::Test;
use Test::More tests => 268;
use Test::Exception;
my $ERROR_MAX = 0.00000001;

BEGIN {
    if ( $ENV{TEST_VERBOSE} ) {
        Test::More::diag(
            "[[[ Beginning Scalar Type Pre-Test Loading, RPerl Type System ]]]"
        );
    }
    lives_and( sub { use_ok('RPerl'); }, q{use_ok('RPerl') lives} );

    foreach my string $type (qw(Integer Number String)) {
        lives_and(
            sub { use_ok( 'RPerl::DataType::' . $type . '_cpp' ); },
            q{use_ok('RPerl::DataType::' . $type . '_cpp') lives}
        );
    }
}

# use Data::Dumper() to stringify a string
#our string $string__dumperify = sub {  # NEED FIX: RPerl subroutines disabled here
sub string__dumperify {
    ( my string $input_string ) = @_;

#    RPerl::diag "in 04_type_scalar.t string__dumperify(), received have \$input_string =\n$input_string\n\n";
    $input_string = Dumper( [$input_string] );
    $input_string =~ s/^\s+|\s+$//xmsg;    # strip leading whitespace
    my @input_string_split = split "\n", $input_string;
    $input_string = $input_string_split[1];    # only select the data line
    return $input_string;
}

#RPerl::diag 'in 04_type_scalar.t, before mode loop, have $RPerl::Test::properties_class{modes} = ' . "\n" . Dumper($RPerl::Test::properties_class{modes}) . "\n";

foreach
    my scalartype__hash_ref $mode ( @{ $RPerl::Test::properties_class{modes} } ) ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 3: allow OO properties
{
#    RPerl::diag 'in 04_type_scalar.t, top of mode loop, have $mode = ' . "\n" . Dumper($mode) . "\n";
    if ( $ENV{TEST_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning RPerl Scalar Type Tests, '
                . RPerl::Test::description($mode)
                . ' ]]]' );
    }

    my $ops   = $mode->{ops};
    my $types = $mode->{types};

    lives_ok( sub { RPerl::Test::enable($mode) },
        q{mode '} . RPerl::Test::description($mode) . q{' enabled} );

    foreach my string $type (qw(Integer Number String)) {
        if ( $ops eq 'CPP' ) {

            # force reload
            delete $main::{ 'RPerl__DataType__' . $type . '__ops' };

            my $package = 'RPerl::DataType::' . $type . '_cpp';
            lives_and(
                sub { require_ok($package); },
                'require_ok(' . $package . ') lives'
            );
            lives_ok( sub { eval( $package . '::cpp_load();' ) },
                $package . '::cpp_load() lives' );
        }

        my string $type_lc = lc $type;
        lives_and(
            sub {
                is( __PACKAGE__->can( $type_lc . '__ops' )->(),
                    $ops, $type_lc . '__ops() returns ' . $ops );
            },
            q{integer__ops() lives}
        );

        lives_and(
            sub {
                is( __PACKAGE__->can( $type_lc . '__types' )->(),
                    $types, $type_lc . '__types() returns ' . $types );
            },
            q{integer__types() lives}
        );
    }

    # [[[ INTEGER TESTS ]]]
    # [[[ INTEGER TESTS ]]]
    # [[[ INTEGER TESTS ]]]

    my string $OPS_TYPES     = RPerl::Test::id($mode);
    my integer $OPS_TYPES_ID = $mode->{index};

    throws_ok(    # TIV00
        sub { integer__stringify() },
        "/(EIV00.*$OPS_TYPES)|(Usage.*integer__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TIV00 integer__stringify() throws correct exception}
    );
    throws_ok(                                               # TIV01
        sub { integer__stringify(undef) },
        "/EIV00.*$OPS_TYPES/",
        q{TIV01 integer__stringify(undef) throws correct exception}
    );
    lives_and(                                               # TIV02
        sub {
            is( integer__stringify(3), '3',
                q{TIV02 integer__stringify(3) returns correct value} );
        },
        q{TIV02 integer__stringify(3) lives}
    );
    lives_and(                                               # TIV03
        sub {
            is( integer__stringify(-17), '-17',
                q{TIV03 integer__stringify(-17) returns correct value} );
        },
        q{TIV03 integer__stringify(-17) lives}
    );
    throws_ok(                                               # TIV04
        sub { integer__stringify(-17.3) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV04 integer__stringify(-17.3) throws correct exception}
    );
    throws_ok(                                               # TIV05
        sub { integer__stringify('-17.3') },
        "/EIV01.*$OPS_TYPES/",
        q{TIV05 integer__stringify('-17.3') throws correct exception}
    );
    throws_ok(                                               # TIV06
        sub { integer__stringify( [3] ) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV06 integer__stringify([3]) throws correct exception}
    );
    throws_ok(                                               # TIV07
        sub { integer__stringify( { a_key => 3 } ) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV07 integer__stringify({a_key => 3}) throws correct exception}
    );
    lives_and(                                               # TIV08
        sub {
            is( integer__stringify(-1_234_567_890), '-1234567890',
                q{TIV08 integer__stringify(-1_234_567_890) returns correct value}
            );
        },
        q{TIV08 integer__stringify(-1_234_567_890) lives}
    );
    throws_ok(                                               # TIV09
        sub {
            integer__stringify(
                -1_234_567_890_000_000_000_000_000_000_000_000);
        },
        "/EIV01.*$OPS_TYPES/",
        q{TIV09 integer__stringify(-1_234_567_890_000_000_000_000_000_000_000_000) throws correct exception}
    );
    lives_and(                                               # TIV10
        sub {
            is( integer__typetest0(),
                ( 3 + $OPS_TYPES_ID ),
                q{TIV10 integer__typetest0() returns correct value}
            );
        },
        q{TIV10 integer__typetest0() lives}
    );
    throws_ok(                                               # TIV20
        sub { integer__typetest1() },
        "/(EIV00.*$OPS_TYPES)|(Usage.*integer__typetest1)/"
        ,    # DEV NOTE: 2 different error messages, RPerl & C
        q{TIV20 integer__typetest1() throws correct exception}
    );
    throws_ok(    # TIV21
        sub { integer__typetest1(undef) },
        "/EIV00.*$OPS_TYPES/",
        q{TIV21 integer__typetest1(undef) throws correct exception}
    );
    lives_and(    # TIV22
        sub {
            is( integer__typetest1(3),
                ( ( 3 * 2 ) + $OPS_TYPES_ID ),
                q{TIV22 integer__typetest1(3) returns correct value}
            );
        },
        q{TIV22 integer__typetest1(3) lives}
    );
    lives_and(    # TIV23
        sub {
            is( integer__typetest1(-17),
                ( ( -17 * 2 ) + $OPS_TYPES_ID ),
                q{TIV23 integer__typetest1(-17) returns correct value}
            );
        },
        q{TIV23 integer__typetest1(-17) lives}
    );
    throws_ok(    # TIV24
        sub { integer__typetest1(-17.3) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV24 integer__typetest1(-17.3) throws correct exception}
    );
    throws_ok(    # TIV25
        sub { integer__typetest1('-17.3') },
        "/EIV01.*$OPS_TYPES/",
        q{TIV25 integer__typetest1('-17.3') throws correct exception}
    );
    throws_ok(    # TIV26
        sub { integer__typetest1( [3] ) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV26 integer__typetest1([3]) throws correct exception}
    );
    throws_ok(    # TIV27
        sub { integer__typetest1( { a_key => 3 } ) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV27 integer__typetest1({a_key => 3}) throws correct exception}
    );
    lives_and(    # TIV28
        sub {
            is( integer__typetest1(-234_567_890),
                ( ( -234_567_890 * 2 ) + $OPS_TYPES_ID ),
                q{TIV28 integer__typetest1(-234_567_890) returns correct value}
            );
        },
        q{TIV28 integer__typetest1(-234_567_890) lives}
    );
    throws_ok(    # TIV29
        sub {
            integer__typetest1(
                -1_234_567_890_000_000_000_000_000_000_000_000);
        },
        "/EIV01.*$OPS_TYPES/",
        q{TIV29 integer__typetest1(-1_234_567_890_000_000_000_000_000_000_000_000) throws correct exception}
    );

    # [[[ NUMBER TESTS ]]]
    # [[[ NUMBER TESTS ]]]
    # [[[ NUMBER TESTS ]]]

    throws_ok(    # TNV00
        sub { number__stringify() },
        "/(ENV00.*$OPS_TYPES)|(Usage.*number__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TNV00 number__stringify() throws correct exception}
    );
    throws_ok(                                              # TNV01
        sub { number__stringify(undef) },
        "/ENV00.*$OPS_TYPES/",
        q{TNV01 number__stringify(undef) throws correct exception}
    );
    lives_and(                                              # TNV02
        sub {
            is( number__stringify(3), '3',
                q{TNV02 number__stringify(3) returns correct value} );
        },
        q{TNV02 number__stringify(3) lives}
    );
    lives_and(                                              # TNV03
        sub {
            is( number__stringify(-17), '-17',
                q{TNV03 number__stringify(-17) returns correct value} );
        },
        q{TNV03 number__stringify(-17) lives}
    );
    lives_and(                                              # TNV04
        sub {
            is( number__stringify(-17.3),
                '-17.3',
                q{TNV04 number__stringify(-17.3) returns correct value} );
        },
        q{TNV04 number__stringify(-17.3) lives}
    );
    throws_ok(                                              # TNV05
        sub { number__stringify('-17.3') },
        "/ENV01.*$OPS_TYPES/",
        q{TNV05 number__stringify('-17.3') throws correct exception}
    );
    throws_ok(                                              # TNV06
        sub { number__stringify( [3] ) },
        "/ENV01.*$OPS_TYPES/",
        q{TNV06 number__stringify([3]) throws correct exception}
    );
    throws_ok(                                              # TNV07
        sub { number__stringify( { a_key => 3 } ) },
        "/ENV01.*$OPS_TYPES/",
        q{TNV07 number__stringify({a_key => 3}) throws correct exception}
    );
    lives_and(                                              # TNV08
        sub {
            is( number__stringify(
                    3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679
                ),
                '3.14159265358979',
                q{TNV08 number__stringify(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) returns correct value}
            );
        },
        q{TNV08 number__stringify(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) lives}
    );
    lives_and(                                              # TNV10
        sub {
            cmp_ok(
                abs(number__typetest0() - ( 3.14285714285714 + $OPS_TYPES_ID )
                ),    ## PERLTIDY BUG comma on newline
                '<',
                $ERROR_MAX,
                q{TNV10 number__typetest0() returns correct value}
            );
        },
        q{TNV10 number__typetest0() lives}
    );
    throws_ok(        # TNV20
        sub { number__typetest1() },
        "/(ENV00.*$OPS_TYPES)|(Usage.*number__typetest1)/"
        ,             # DEV NOTE: 2 different error messages, RPerl & C
        q{TNV20 number__typetest1() throws correct exception}
    );
    throws_ok(        # TNV21
        sub { number__typetest1(undef) },
        "/ENV00.*$OPS_TYPES/",
        q{TNV21 number__typetest1(undef) throws correct exception}
    );
    lives_and(        # TNV22
        sub {
            is( number__typetest1(3),
                ( ( 3 * 2 ) + $OPS_TYPES_ID ),
                q{TNV22 number__typetest1(3) returns correct value}
            );
        },
        q{TNV22 number__typetest1(3) lives}
    );
    lives_and(        # TNV23
        sub {
            is( number__typetest1(-17),
                ( ( -17 * 2 ) + $OPS_TYPES_ID ),
                q{TNV23 number__typetest1(-17) returns correct value}
            );
        },
        q{TNV23 number__typetest1(-17) lives}
    );
    lives_and(        # TNV24
        sub {
            is( number__typetest1(-17.3),
                ( ( -17.3 * 2 ) + $OPS_TYPES_ID ),
                q{TNV24 number__typetest1(-17.3) returns correct value}
            );
        },
        q{TNV24 number__typetest1(-17.3) lives}
    );
    throws_ok(        # TNV25
        sub { number__typetest1('-17.3') },
        "/ENV01.*$OPS_TYPES/",
        q{TNV25 number__typetest1('-17.3') throws correct exception}
    );
    throws_ok(        # TNV26
        sub { number__typetest1( [3] ) },
        "/ENV01.*$OPS_TYPES/",
        q{TNV26 number__typetest1([3]) throws correct exception}
    );
    throws_ok(        # TNV27
        sub { number__typetest1( { a_key => 3 } ) },
        "/ENV01.*$OPS_TYPES/",
        q{TNV27 number__typetest1({a_key => 3}) throws correct exception}
    );
    lives_and(        # TNV28
        sub {
            cmp_ok(
                abs(number__typetest1(
                        3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679
                    ) - ( ( 3.14159265358979 * 2 ) + $OPS_TYPES_ID )
                ),
                '<',
                $ERROR_MAX,
                q{TNV28 number__typetest1(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) returns correct value}
            );
        },
        q{TNV28 number__typetest1(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) lives}
    );

    # [[[ STRING TESTS ]]]
    # [[[ STRING TESTS ]]]
    # [[[ STRING TESTS ]]]

    throws_ok(    # TPV00
        sub { string__stringify() },
        "/(EPV00.*$OPS_TYPES)|(Usage.*string__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TPV00 string__stringify() throws correct exception}
    );
    throws_ok(                                              # TPV01
        sub { string__stringify(undef) },
        "/EPV00.*$OPS_TYPES/",
        q{TPV01 string__stringify(undef) throws correct exception}
    );
    throws_ok(                                              # TPV02
        sub { string__stringify(3) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV02 string__stringify(3) throws correct exception}
    );
    throws_ok(                                              # TPV03
        sub { string__stringify(-17) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV03 string__stringify(-17) throws correct exception}
    );
    throws_ok(                                              # TPV04
        sub { string__stringify(-17.3) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV04 string__stringify(-17.3) throws correct exception}
    );
    lives_and(                                              # TPV05
        sub {
            is( string__stringify('-17.3'),
                "'-17.3'",
                q{TPV05 string__stringify('-17.3') returns correct value} );
        },
        q{TPV05 string__stringify('-17.3') lives}
    );
    throws_ok(                                              # TPV06
        sub { string__stringify( [3] ) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV06 string__stringify([3]) throws correct exception}
    );
    throws_ok(                                              # TPV07
        sub { string__stringify( { a_key => 3 } ) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV07 string__stringify({a_key => 3}) throws correct exception}
    );
    lives_and(                                              # TPV08
        sub {
            is( string__stringify('Melange'),
                "'Melange'",
                q{TPV08 string__stringify('Melange') returns correct value} );
        },
        q{TPV08 string__stringify('Melange') lives}
    );
    lives_and(                                              # TPV09
        sub {
            is( string__stringify(
                    "\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n"
                ),
                "'\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n'",
                q{TPV09 string__stringify("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n") returns correct value}
            );
        },
        q{TPV09 string__stringify("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n") lives}
    );

    lives_and(                                              # TPV10
        sub {
            is( string__stringify(
                    '\'I am a single-quoted string, in a single-quoted string with back-slash control chars\', the first string said introspectively.'
                ),
                string__dumperify(
                    '\'I am a single-quoted string, in a single-quoted string with back-slash control chars\', the first string said introspectively.'
                ),
                q{TPV10 string__stringify('\'I am a single-quoted string...\', the first string said introspectively.') returns correct value}
            );
        },
        q{TPV10 string__stringify('\'I am a single-quoted string...\', the first string said introspectively.') lives}
    );
    lives_and(    # TPV11
        sub {
            is( string__stringify(
                    '"I am a double-quoted string, in a single-quoted string with no back-slash chars", the second string observed.'
                ),
                string__dumperify(
                    '"I am a double-quoted string, in a single-quoted string with no back-slash chars", the second string observed.'
                ),
                q{TPV11 string__stringify('"I am a double-quoted string...", the second string observed.') returns correct value}
            );
        },
        q{TPV11 string__stringify('"I am a double-quoted string...", the second string observed.') lives}
    );
    lives_and(    # TPV12
        sub {
            is( string__stringify(
                    "'I am a single-quoted string, in a double-quoted string with no back-slash chars', the third string added."
                ),
                string__dumperify(
                    "'I am a single-quoted string, in a double-quoted string with no back-slash chars', the third string added."
                ),
                q{TPV12 string__stringify("'I am a single-quoted string...', the third string added.") returns correct value}
            );
        },
        q{TPV12 string__stringify("'I am a single-quoted string...', the third string added.") lives}
    );
    lives_and(    # TPV13
        sub {
            is( string__stringify(
                    "\"I am a double-quoted string, in a double-quoted string with back-slash control chars\", the fourth string offered."
                ),
                string__dumperify(
                    "\"I am a double-quoted string, in a double-quoted string with back-slash control chars\", the fourth string offered."
                ),
                q{TPV13 string__stringify("\"I am a double-quoted string...\", the fourth string offered.") returns correct value}
            );
        },
        q{TPV13 string__stringify("\"I am a double-quoted string...\", the fourth string offered.") lives}
    );
    lives_and(    # TPV14
        sub {
            is( string__stringify(
                    '\'I am a single-quoted string, in a single-quoted string with back-slash control and \ display \ chars\', the fifth string shouted.'
                ),
                string__dumperify(
                    '\'I am a single-quoted string, in a single-quoted string with back-slash control and \ display \ chars\', the fifth string shouted.'
                ),
                q{TPV14 string__stringify('\'I am a single-quoted string... and \ display \ chars\', the fifth string shouted.') returns correct value}
            );
        },
        q{TPV14 string__stringify('\'I am a single-quoted string... and \ display \ chars\', the fifth string shouted.') lives}
    );
    lives_and(    # TPV15
        sub {
            is( string__stringify(
                    '"I am a double-quoted string, in a single-quoted string with back-slash \ display \ chars", the sixth string hollered.'
                ),
                string__dumperify(
                    '"I am a double-quoted string, in a single-quoted string with back-slash \ display \ chars", the sixth string hollered.'
                ),
                q{TPV15 string__stringify('"I am a double-quoted string... \ display \ chars", the sixth string hollered.') returns correct value}
            );
        },
        q{TPV15 string__stringify('"I am a double-quoted string... \ display \ chars", the sixth string hollered.') lives}
    );
    lives_and(    # TPV16
        sub {
            is( string__stringify(
                    "'I am a single-quoted string, in a double-quoted string with back-slash \\ display \\ chars', the seventh string yelled."
                ),
                string__dumperify(
                    "'I am a single-quoted string, in a double-quoted string with back-slash \\ display \\ chars', the seventh string yelled."
                ),
                q{TPV16 string__stringify("'I am a single-quoted string... \\ display \\ chars', the seventh string yelled.") returns correct value}
            );
        },
        q{TPV16 string__stringify("'I am a single-quoted string... \\ display \\ chars', the seventh string yelled.") lives}
    );
    lives_and(    # TPV17
        sub {
            is( string__stringify(
                    "\"I am a double-quoted string, in a double-quoted string with back-slash control and \\ display \\ chars\", the eighth string belted."
                ),
                string__dumperify(
                    "\"I am a double-quoted string, in a double-quoted string with back-slash control and \\ display \\ chars\", the eighth string belted."
                ),
                q{TPV17 string__stringify("\"I am a double-quoted string... and \\ display \\ chars\", the eighth string belted.") returns correct value}
            );
        },
        q{TPV17 string__stringify("\"I am a double-quoted string... and \\ display \\ chars\", the eighth string belted.") lives}
    );
    lives_and(    # TPV20
        sub {
            is( string__stringify(
                    q{'I am a single-quoted string, in a single-quoted q{} string with no back-slash chars', the ninth string chimed in.}
                ),
                string__dumperify(
                    q{'I am a single-quoted string, in a single-quoted q{} string with no back-slash chars', the ninth string chimed in.}
                ),
                q{TPV20 string__stringify(q{'I am a single-quoted string...', the ninth string chimed in.}) returns correct value}
            );
        },
        q{TPV20 string__stringify(q{'I am a single-quoted string...', the ninth string chimed in.}) lives}
    );
    lives_and(    # TPV21
        sub {
            is( string__stringify(
                    q{"I am a double-quoted string, in a single-quoted q{} string with no back-slash chars", the tenth string opined.}
                ),
                string__dumperify(
                    q{"I am a double-quoted string, in a single-quoted q{} string with no back-slash chars", the tenth string opined.}
                ),
                q{TPV21 string__stringify(q{"I am a double-quoted string...", the tenth string opined.}) returns correct value}
            );
        },
        q{TPV21 string__stringify(q{"I am a double-quoted string...", the tenth string opined.}) lives}
    );
    lives_and(    # TPV22
        sub {
            is( string__stringify(
                    qq{'I am a single-quoted string, in a double-quoted qq{} string with no back-slash chars', the eleventh string asserted.}
                ),
                string__dumperify(
                    qq{'I am a single-quoted string, in a double-quoted qq{} string with no back-slash chars', the eleventh string asserted.}
                ),
                q{TPV22 string__stringify(qq{'I am a single-quoted string...', the eleventh string asserted.}) returns correct value}
            );
        },
        q{TPV22 string__stringify(qq{'I am a single-quoted string...', the eleventh string asserted.}) lives}
    );
    lives_and(    # TPV23
        sub {
            is( string__stringify(
                    qq{"I am a double-quoted string, in a double-quoted qq{} string with no back-slash chars", the twelfth string insisted.}
                ),
                string__dumperify(
                    qq{"I am a double-quoted string, in a double-quoted qq{} string with no back-slash chars", the twelfth string insisted.}
                ),
                q{TPV23 string__stringify(qq{"I am a double-quoted string...", the twelfth string insisted.}) returns correct value}
            );
        },
        q{TPV23 string__stringify(qq{"I am a double-quoted string...", the twelfth string insisted.}) lives}
    );
    lives_and(    # TPV24
        sub {
            is( string__stringify(
                    q{'I am a single-quoted string, in a single-quoted q{} string with back-slash \ display \ chars', the thirteenth string whispered.}
                ),
                string__dumperify(
                    q{'I am a single-quoted string, in a single-quoted q{} string with back-slash \ display \ chars', the thirteenth string whispered.}
                ),
                q{TPV24 string__stringify(q{'I am a single-quoted string... \ display \ chars', the thirteenth string whispered.}) returns correct value}
            );
        },
        q{TPV24 string__stringify(q{'I am a single-quoted string... \ display \ chars', the thirteenth string whispered.}) lives}
    );
    lives_and(    # TPV25
        sub {
            is( string__stringify(
                    q{"I am a double-quoted string, in a single-quoted q{} string with back-slash \ display \ chars", the fourteenth string breathed.}
                ),
                string__dumperify(
                    q{"I am a double-quoted string, in a single-quoted q{} string with back-slash \ display \ chars", the fourteenth string breathed.}
                ),
                q{TPV25 string__stringify(q{"I am a double-quoted string... \ display \ chars", the fourteenth string breathed.}) returns correct value}
            );
        },
        q{TPV25 string__stringify(q{"I am a double-quoted string... \ display \ chars", the fourteenth string breathed.}) lives}
    );
    lives_and(    # TPV26
        sub {
            is( string__stringify(
                    qq{'I am a single-quoted string, in a double-quoted qq{} string with back-slash \\ display \\ chars', the fifteenth string mouthed.}
                ),
                string__dumperify(
                    qq{'I am a single-quoted string, in a double-quoted qq{} string with back-slash \\ display \\ chars', the fifteenth string mouthed.}
                ),
                q{TPV26 string__stringify(qq{'I am a single-quoted string... back-slash \\ display \\ chars', the fifteenth string mouthed.}) returns correct value}
            );
        },
        q{TPV26 string__stringify(qq{'I am a single-quoted string... back-slash \\ display \\ chars', the fifteenth string mouthed.}) lives}
    );
    lives_and(    # TPV27
        sub {
            is( string__stringify(
                    qq{"I am a double-quoted string, in a double-quoted qq{} string with back-slash \\ display \\ chars", the sixteenth string implied.}
                ),
                string__dumperify(
                    qq{"I am a double-quoted string, in a double-quoted qq{} string with back-slash \\ display \\ chars", the sixteenth string implied.}
                ),
                q{TPV27 string__stringify(qq{"I am a double-quoted string... back-slash \\ display \\ chars", the sixteenth string implied.}) returns correct value}
            );
        },
        q{TPV27 string__stringify(qq{"I am a double-quoted string... back-slash \\ display \\ chars", the sixteenth string implied.}) lives}
    );
    lives_and(    # TPV30
        sub {
            is( string__typetest0(),
                "Spice $OPS_TYPES",
                q{TPV30 string__typetest0() returns correct value}
            );
        },
        q{TPV30 string__typetest0() lives}
    );
    throws_ok(    # TPV40
        sub { string__typetest1() },
        "/(EPV00.*$OPS_TYPES)|(Usage.*string__typetest1)/"
        ,         # DEV NOTE: 2 different error messages, RPerl & C
        q{TPV40 string__typetest1() throws correct exception}
    );
    throws_ok(    # TPV41
        sub { string__typetest1(undef) },
        "/EPV00.*$OPS_TYPES/",
        q{TPV41 string__typetest1(undef) throws correct exception}
    );
    throws_ok(    # TPV42
        sub { string__typetest1(3) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV42 string__typetest1(3) throws correct exception}
    );
    throws_ok(    # TPV43
        sub { string__typetest1(-17) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV43 string__typetest1(-17) throws correct exception}
    );
    throws_ok(    # TPV44
        sub { string__typetest1(-17.3) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV44 string__typetest1(-17.3) throws correct exception}
    );
    lives_and(    # TPV45
        sub {
            is( string__typetest1('-17.3'),
                "'-17.3' $OPS_TYPES",
                q{TPV45 string__typetest1('-17.3') returns correct value}
            );
        },
        q{TPV45 string__typetest1('-17.3') lives}
    );
    throws_ok(    # TPV46
        sub { string__typetest1( [3] ) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV46 string__typetest1([3]) throws correct exception}
    );
    throws_ok(    # TPV47
        sub { string__typetest1( { a_key => 3 } ) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV47 string__typetest1({a_key => 3}) throws correct exception}
    );
    lives_and(    # TPV48
        sub {
            is( string__typetest1('Melange'),
                "'Melange' $OPS_TYPES",
                q{TPV48 string__typetest1('Melange') returns correct value}
            );
        },
        q{TPV48 string__typetest1('Melange') lives}
    );
    lives_and(    # TPV49
        sub {
            is( string__typetest1(
                    "\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n"
                ),
                "'\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n' $OPS_TYPES",
                q{TPV49 string__typetest1("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n") returns correct value}
            );
        },
        q{TPV49 string__typetest1("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n") lives}
    );
}

done_testing();
