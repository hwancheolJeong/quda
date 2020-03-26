#pragma once

#include <complex>
#include <quda.h>
#include <quda_internal.h>
#include <dirac_quda.h>
#include <dslash_quda.h>
#include <invert_quda.h>
#include <util_quda.h>
#include <blas_quda.h>

#include <command_line_params.h>
#include <host_utils.h>
#include <misc.h>


void display_driver_info();

namespace quda
{
  void spinDiluteQuda(const ColorSpinorField &x, const ColorSpinorField &y, const int alpha);
  void evecProjectQuda(const ColorSpinorField &x, const ColorSpinorField &y, void *result);
}

void laphSourceConstruct(std::vector<quda::ColorSpinorField*> &quarks, std::vector<quda::ColorSpinorField*> &evecs, const std::complex<double> *noise, const int dil_scheme);
void laphSourceInvert(std::vector<quda::ColorSpinorField*> &quarks, QudaInvertParam *inv_param, const int *X);
void laphSinkProject(std::vector<quda::ColorSpinorField*> &quarks, std::vector<quda::ColorSpinorField*> &evecs, void **host_sinks, const int dil_scheme);
