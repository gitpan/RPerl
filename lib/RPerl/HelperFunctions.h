#ifndef __CPP__INCLUDED__RPerl__HelperFunctions_h
#define __CPP__INCLUDED__RPerl__HelperFunctions_h 0.002_011


// START HERE: implement RPerl__diag, use in files called by 07_oo_inherit.t
// START HERE: implement RPerl__diag, use in files called by 07_oo_inherit.t
// START HERE: implement RPerl__diag, use in files called by 07_oo_inherit.t

/*
#include <stdlib.h>  // for getenv()
#include <stdio.h>  // for ostream object type

ostringstream RPerl__diag;

ostream& operator<<(ostream& ostream_object, const char* char_star_input)
{
        if (getenv("TEST_VERBOSE") { cerr << char_star_input; }
        return ostream_object;
}

ostream& operator<<(ostream& ostream_object, std::string string_input)
{
        if (getenv("TEST_VERBOSE") { cerr << string_input; }
        return ostream_object;
}
*/

// <<< DEBUG DEFINES >>>
#define TEST_VERBOSE 1  // NEED FIX: access actual environmental variable TEST_VERBOSE!
#define TEST_VERBOSE2 1
#define TEST_VERBOSE3 1  // NEED FIX: these debug statements cause memory leaks by increasing the refcounts of data_i, data_i_plus_1, and swap

// <<< HELPER MACROS >>>
#define SvAROKp(input_av_ref) (SvROK(input_av_ref) && (SvTYPE(SvRV(input_av_ref)) == SVt_PVAV))  // DEV NOTE: look P5P, I invented macros that should probably be in the P5 core!
#define SvHROKp(input_hv_ref) (SvROK(input_hv_ref) && (SvTYPE(SvRV(input_hv_ref)) == SVt_PVHV))
#define AV_ELEMENT(av,index) ((av_fetch(av,index,0)!=NULL)?*av_fetch(av,index,0):newSV(0))
#define SV_REFERENCE_COUNT(sv) (SvREFCNT(sv))

// <<< HELPER FUNCTION DECLARATIONS >>>
int RPerl_SvIOKp(SV* input_sv);
int RPerl_SvNOKp(SV* input_sv);
int RPerl_SvPOKp(SV* input_sv);
int RPerl_SvAROKp(SV* input_av_ref);
int RPerl_SvHROKp(SV* input_hv_ref);

void RPerl_object_property_init(SV* initee); // NEED ANSWER: what in the hades does this property init function even do?  why do we need it???
char* RPerl_DUMPER__perl_from_c(SV* dumpee);

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
SV* RPerl__HelperFunctions__ops() { return(newSVpv("CPP", 3)); }

#endif
