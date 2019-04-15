#include <dirac_quda.h>
#include <blas_quda.h>

namespace quda {

  DiracStaggeredSextet::DiracStaggeredSextet(const DiracParam &param) : Dirac(param) { }

  DiracStaggeredSextet::DiracStaggeredSextet(const DiracStaggeredSextet &dirac) : Dirac(dirac) { }

  DiracStaggeredSextet::~DiracStaggeredSextet() { }

  DiracStaggeredSextet& DiracStaggeredSextet::operator=(const DiracStaggeredSextet &dirac)
  {
    if (&dirac != this) {
      Dirac::operator=(dirac);
    }
    return *this;
  }

  void DiracStaggeredSextet::checkParitySpinor(const ColorSpinorField &in, const ColorSpinorField &out) const
  {
    if (in.Ndim() != 5 || out.Ndim() != 5) {
      errorQuda("Staggered dslash requires 5-d fermion fields");
    }

    if (in.Precision() != out.Precision()) {
      errorQuda("Input and output spinor precisions don't match in dslash_quda");
    }

    if (in.Stride() != out.Stride()) {
      errorQuda("Input %d and output %d spinor strides don't match in dslash_quda", in.Stride(), out.Stride());
    }

    if (in.SiteSubset() != QUDA_PARITY_SITE_SUBSET || out.SiteSubset() != QUDA_PARITY_SITE_SUBSET) {
      errorQuda("ColorSpinorFields are not single parity, in = %d, out = %d", 
		in.SiteSubset(), out.SiteSubset());
    }

    if ((out.Volume()/out.X(4) != 2*gauge->VolumeCB() && out.SiteSubset() == QUDA_FULL_SITE_SUBSET) ||
	(out.Volume()/out.X(4) != gauge->VolumeCB() && out.SiteSubset() == QUDA_PARITY_SITE_SUBSET) ) {
      errorQuda("Spinor volume %d doesn't match gauge volume %d", out.Volume(), gauge->VolumeCB());
    }
  }


  void DiracStaggeredSextet::Dslash(ColorSpinorField &out, const ColorSpinorField &in, 
			      const QudaParity parity) const
  {
    checkParitySpinor(in, out);

    if (checkLocation(out, in) == QUDA_CUDA_FIELD_LOCATION) {
      ApplyStaggeredSextet(out, in, *gauge, 0., in, parity, dagger, commDim, profile);
    } else {
      errorQuda("Not supported");
    }

    flops += 4794ll*in.Volume(); // 594 flops per gauge * sextet multiplication
  }

  void DiracStaggeredSextet::DslashXpay(ColorSpinorField &out, const ColorSpinorField &in, 
				  const QudaParity parity, const ColorSpinorField &x,
				  const double &k) const
  {    
    checkParitySpinor(in, out);
    if (checkLocation(out, in, x) == QUDA_CUDA_FIELD_LOCATION) {
      ApplyStaggeredSextet(out, in, *gauge, k, x, parity, dagger, commDim, profile);
    } else {
      errorQuda("Not supported");
    }  

    flops += (4794ll + 12ll)*in.Volume();
  }

  // Full staggered operator
  void DiracStaggeredSextet::M(ColorSpinorField &out, const ColorSpinorField &in) const
  {
    // Due to the staggered convention, this is applying
    // (  2m     -D_eo ) (x_e) = (b_e)
    // ( -D_oe   2m    ) (x_o) = (b_o)
    checkFullSpinor(out, in);
    ApplyStaggeredSextet(out, in, *gauge, 2. * mass, in, QUDA_INVALID_PARITY, dagger, commDim, profile);
  }

  void DiracStaggeredSextet::MdagM(ColorSpinorField &out, const ColorSpinorField &in) const
  {
    bool reset = newTmp(&tmp1, in);
    printfQuda("Calling DiracStaggeredSextet::MdagM \n");
    //even
    Dslash(tmp1->Even(), in.Even(), QUDA_ODD_PARITY);  
    DslashXpay(out.Even(), tmp1->Even(), QUDA_EVEN_PARITY, in.Even(), 4*mass*mass);
  
    //odd
    Dslash(tmp1->Even(), in.Odd(), QUDA_EVEN_PARITY);  
    DslashXpay(out.Odd(), tmp1->Even(), QUDA_ODD_PARITY, in.Odd(), 4*mass*mass);    

    deleteTmp(&tmp1, reset);
  }

  void DiracStaggeredSextet::prepare(ColorSpinorField* &src, ColorSpinorField* &sol,
			       ColorSpinorField &x, ColorSpinorField &b, 
			       const QudaSolutionType solType) const
  {
    if (solType == QUDA_MATPC_SOLUTION || solType == QUDA_MATPCDAG_MATPC_SOLUTION) {
      errorQuda("Preconditioned solution requires a preconditioned solve_type");
    }

    src = &b;
    sol = &x;  
  }

  void DiracStaggeredSextet::reconstruct(ColorSpinorField &x, const ColorSpinorField &b,
				   const QudaSolutionType solType) const
  {
    // do nothing
  }

  void DiracStaggeredSextet::createCoarseOp(GaugeField &Y, GaugeField &X, const Transfer &T,
           double kappa, double mass, double mu, double mu_factor) const {
    errorQuda("Cannot coarsen a staggered operator (yet!), we're just getting the functions in place.");
    //CoarseStaggeredOp(Y, X, T, *gauge, mass, QUDA_STAGGERED_DIRAC, QUDA_MATPC_INVALID);
  }


  DiracStaggeredSextetPC::DiracStaggeredSextetPC(const DiracParam &param)
    : DiracStaggeredSextet(param)
  {

  }

  DiracStaggeredSextetPC::DiracStaggeredSextetPC(const DiracStaggeredSextetPC &dirac) 
    : DiracStaggeredSextet(dirac)
  {

  }

  DiracStaggeredSextetPC::~DiracStaggeredSextetPC()
  {

  }

  DiracStaggeredSextetPC& DiracStaggeredSextetPC::operator=(const DiracStaggeredSextetPC &dirac)
  {
    if (&dirac != this) {
      DiracStaggeredSextet::operator=(dirac);
    }
 
    return *this;
  }

  // Unlike with clover, for ex, we don't need a custom Dslash or DslashXpay.
  // That's because the convention for preconditioned staggered is to
  // NOT divide out the factor of "2m", i.e., for the even system we invert
  // (4m^2 - D_eo D_oe), not (1 - (1/(4m^2)) D_eo D_oe).

  void DiracStaggeredSextetPC::M(ColorSpinorField &out, const ColorSpinorField &in) const
  {
    bool reset = newTmp(&tmp1, in);
  
    QudaParity parity = QUDA_INVALID_PARITY;
    QudaParity other_parity = QUDA_INVALID_PARITY;
    if (matpcType == QUDA_MATPC_EVEN_EVEN) {
      parity = QUDA_EVEN_PARITY;
      other_parity = QUDA_ODD_PARITY;
    } else if (matpcType == QUDA_MATPC_ODD_ODD) {
      parity = QUDA_ODD_PARITY;
      other_parity = QUDA_EVEN_PARITY;
    } else {
      errorQuda("Invalid matpcType(%d) in function\n", matpcType);    
    }

    // Convention note: Dslash applies D_eo, DslashXpay applies 4m^2 - D_oe!
    // Note the minus sign convention in the Xpay version.
    // This applies equally for the e <-> o permutation.

    Dslash(*tmp1, in, other_parity);  
    DslashXpay(out, *tmp1, parity, in, 4*mass*mass);

    deleteTmp(&tmp1, reset);
  }

  void DiracStaggeredSextetPC::MdagM(ColorSpinorField &out, const ColorSpinorField &in) const
  {
    errorQuda("MdagM is no longer defined for DiracStaggeredSextetPC. Use M instead.\n");
    /*
    // need extra temporary because for multi-gpu the input
    // and output fields cannot alias
    bool reset = newTmp(&tmp2, in);
    M(*tmp2, in);
    M(out, *tmp2); // doesn't need to be Mdag b/c M is normal!
    deleteTmp(&tmp2, reset);
    */
  }

  void DiracStaggeredSextetPC::prepare(ColorSpinorField* &src, ColorSpinorField* &sol,
				 ColorSpinorField &x, ColorSpinorField &b, 
				 const QudaSolutionType solType) const
  {
    // we desire solution to preconditioned system
    if (solType == QUDA_MATPC_SOLUTION || solType == QUDA_MATPCDAG_MATPC_SOLUTION) {
      src = &b;
      sol = &x;
      return;
    }
  
    // we desire solution to full system.
    // See sign convention comment in DiracStaggeredSextetPC::M().
    if (matpcType == QUDA_MATPC_EVEN_EVEN) {
      // With the convention given in DiracStaggeredSextet::M(),
      // the source is src = 2m b_e + D_eo b_o
      // But remember, DslashXpay actually applies
      // -D_eo. Flip the sign on 2m to compensate, and
      // then flip the overall sign.
      src = &(x.Odd());
      DslashXpay(*src, b.Odd(), QUDA_EVEN_PARITY, b.Even(), -2*mass);
      blas::ax(-1.0, *src);
      sol = &(x.Even());
    } else if (matpcType == QUDA_MATPC_ODD_ODD) {
      // See above, permute e <-> o
      src = &(x.Even());
      DslashXpay(*src, b.Even(), QUDA_ODD_PARITY, b.Odd(), -2*mass);
      blas::ax(-1.0, *src);
      sol = &(x.Odd());
    } else {
      errorQuda("MatPCType %d not valid for DiracStaggeredSextetPC", matpcType);
    }

    // here we use final solution to store parity solution and parity source
    // b is now up for grabs if we want

  }

  void DiracStaggeredSextetPC::reconstruct(ColorSpinorField &x, const ColorSpinorField &b,
				     const QudaSolutionType solType) const
  {

    if (solType == QUDA_MATPC_SOLUTION || solType == QUDA_MATPCDAG_MATPC_SOLUTION) {
      return;
    }

    checkFullSpinor(x, b);

    // create full solution
    // See sign convention comment in DiracStaggeredSextetPC::M()
    if (matpcType == QUDA_MATPC_EVEN_EVEN) {
      
      // With the convention given in DiracStaggeredSextet::M(),
      // the reconstruct is x_o = 1/(2m) (b_o + D_oe x_e)
      // But remember: DslashXpay actually applies -D_oe, 
      // so just like above we need to flip the sign
      // on b_o. We then correct this by applying an additional
      // minus sign when we rescale by 2m.
      DslashXpay(x.Odd(), x.Even(), QUDA_ODD_PARITY, b.Odd(), -1.0);
      blas::ax(-0.5/mass, x.Odd());
    } else if (matpcType == QUDA_MATPC_ODD_ODD) {
      // See above, permute e <-> o
      DslashXpay(x.Even(), x.Odd(), QUDA_EVEN_PARITY, b.Even(), -1.0);
      blas::ax(-0.5/mass, x.Even());
    } else {
      errorQuda("MatPCType %d not valid for DiracStaggeredSextetPC", matpcType);
    }

  }



} // namespace quda
