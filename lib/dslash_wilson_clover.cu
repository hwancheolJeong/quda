#include <gauge_field.h>
#include <color_spinor_field.h>
#include <clover_field.h>
#include <dslash.h>
#include <worker.h>

#include <dslash_policy.cuh>
#include <kernels/dslash_wilson_clover.cuh>

/**
   This is the Wilson-clover linear operator
*/

namespace quda
{

  template <typename Float, int nDim, int nColor, typename Arg>
  class WilsonClover : public Dslash<wilsonClover, Float, Arg>
  {
    using Dslash = Dslash<wilsonClover, Float, Arg>;
    using Dslash::arg;
    using Dslash::in;

  public:
    WilsonClover(Arg &arg, const ColorSpinorField &out, const ColorSpinorField &in) : Dslash(arg, out, in) {}

    virtual ~WilsonClover() {}

    void apply(const cudaStream_t &stream)
    {
      TuneParam tp = tuneLaunch(*this, getTuning(), getVerbosity());
      Dslash::setParam(tp);
      if (arg.xpay)
        Dslash::template instantiate<packShmem, nDim, true>(tp, stream);
      else
        errorQuda("Wilson-clover operator only defined for xpay=true");
    }

    long long flops() const
    {
      int clover_flops = 504;
      long long flops = Dslash::flops();

      switch (arg.kernel_type) {
      case INTERIOR_KERNEL:
      case KERNEL_POLICY: flops += clover_flops * in.Volume(); break;
      default: break; // all clover flops are in the interior kernel
      }
      return flops;
    }

    long long bytes() const
    {
      bool isFixed = (in.Precision() == sizeof(short) || in.Precision() == sizeof(char)) ? true : false;
      int clover_bytes = 72 * in.Precision() + (isFixed ? 2 * sizeof(float) : 0);
      long long bytes = Dslash::bytes();

      switch (arg.kernel_type) {
      case INTERIOR_KERNEL:
      case KERNEL_POLICY: bytes += clover_bytes * in.Volume(); break;
      default: break;
      }

      return bytes;
    }
  };

  template <typename Float, int nColor, QudaReconstructType recon> struct WilsonCloverApply {

    inline WilsonCloverApply(ColorSpinorField &out, const ColorSpinorField &in, const GaugeField &U, const CloverField &A,
        double a, const ColorSpinorField &x, int parity, bool dagger, const int *comm_override, TimeProfile &profile)
    {
      constexpr int nDim = 4;
      WilsonCloverArg<Float, nColor, recon> arg(out, in, U, A, a, 0.0, x, parity, dagger, comm_override);
      WilsonClover<Float, nDim, nColor, WilsonCloverArg<Float, nColor, recon>> wilson(arg, out, in);

      dslash::DslashPolicyTune<decltype(wilson)> policy(wilson,
          const_cast<cudaColorSpinorField *>(static_cast<const cudaColorSpinorField *>(&in)), in.VolumeCB(),
          in.GhostFaceCB(), profile);
      policy.apply(0);

      checkCudaError();
    }
  };

  // Apply the Wilson-clover operator
  // out(x) = M*in = (A(x) + a * \sum_mu U_{-\mu}(x)in(x+mu) + U^\dagger_mu(x-mu)in(x-mu))
  // Uses the kappa normalization for the Wilson operator.
  void ApplyWilsonClover(ColorSpinorField &out, const ColorSpinorField &in, const GaugeField &U, const CloverField &A,
      double a, const ColorSpinorField &x, int parity, bool dagger, const int *comm_override, TimeProfile &profile)
  {
#ifdef GPU_CLOVER_DIRAC
    if (in.V() == out.V()) errorQuda("Aliasing pointers");
    if (in.FieldOrder() != out.FieldOrder())
      errorQuda("Field order mismatch in = %d, out = %d", in.FieldOrder(), out.FieldOrder());

    // check all precisions match
    checkPrecision(out, in, U, A);

    // check all locations match
    checkLocation(out, in, U, A);

    instantiate<WilsonCloverApply>(out, in, U, A, a, x, parity, dagger, comm_override, profile);
#else
    errorQuda("Clover dslash has not been built");
#endif
  }

} // namespace quda
