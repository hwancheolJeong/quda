#include <utility>
#include <quda_internal.h>
#include <gauge_field.h>
#include <ks_improved_force.h>
#include <tune_quda.h>
#include <instantiate.h>
#include <tunable_nd.h>
#include <kernels/staggered_two_link.cuh>

namespace quda {

using namespace staggered_quark_smearing;

    template <typename Arg> class TwoLink_ : public TunableKernel3D {
      Arg &arg;
      const GaugeField &outA;
      unsigned int minThreads() const { return arg.threads.x; }

    public:
      TwoLink_(Arg &arg, const GaugeField &link, const GaugeField &outA) :
        TunableKernel3D(link, 2, 1),
        arg(arg),
        outA(outA)
      {
        strcat(aux, (std::string(comm_dim_partitioned_string()) + "threads=" + std::to_string(arg.threads.x)).c_str());
        strcat(aux, ",TWO_LINK");

        apply(device::get_default_stream());
      }

      void apply(const qudaStream_t &stream)
      {
        TuneParam tp = tuneLaunch(*this, getTuning(), getVerbosity());
        launch<TwoLink>(tp, stream, arg);
      }

      void preTune() {
        outA.backup();
      }

      void postTune() {
        outA.restore();
      }

      long long flops() const { return 2*arg.threads.x*792ll;}

      long long bytes() const { return 2*arg.threads.x*( 2*arg.link.Bytes() + arg.outA.Bytes() );}
    };

    template <typename real, int nColor, QudaReconstructType recon>
    struct ComputeTwoLink {
      ComputeTwoLink(GaugeField &newTwoLink, const GaugeField &link)
      {
        TwoLinkArg<real, nColor> arg(newTwoLink, link);
        TwoLink_<decltype(arg)>  twolnk(arg, link, newTwoLink);
      }
    };

#if defined(GPU_STAGGERED_DIRAC) && defined(GPU_TWOLINK_GSMEAR)
    void computeTwoLink(GaugeField &newTwoLink, const GaugeField &link)
    {
      checkNative(newTwoLink, link);
      checkLocation(newTwoLink, link);
      checkPrecision(newTwoLink, link);

      instantiate<ComputeTwoLink, ReconstructNone>(newTwoLink, link);
      return;
    }
#elif !defined(GPU_STAGGERED_DIRAC)
    void computeTwoLink(GaugeField &newTwoLink, const GaugeField &link)
    {
      errorQuda("Staggered dslash has not been built");
    }
#elif !defined(GPU_TWOLINK_GSMEAR)
    void computeTwoLink(GaugeField &newTwoLink, const GaugeField &link)
    {
      errorQuda("Two-link Gaussian quark smearing is not enabled");
    }
#endif
} // namespace quda
