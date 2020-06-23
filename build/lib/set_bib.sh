
/opt/openmpi-4.0.0-gcc-7.4.0-dyn/bin/mpicxx -fPIC -Wall -Wno-unknown-pragmas -g -fno-inline  -shared -Wl,-soname,libquda.so -o libquda.so CMakeFiles/quda.dir/dslash_coarse.cu.o CMakeFiles/quda.dir/dslash_coarse_dagger.cu.o CMakeFiles/quda.dir/coarse_op.cu.o CMakeFiles/quda.dir/coarsecoarse_op.cu.o CMakeFiles/quda.dir/coarse_op_preconditioned.cu.o CMakeFiles/quda.dir/staggered_coarse_op.cu.o CMakeFiles/quda.dir/block_orthogonalize.cu.o CMakeFiles/quda.dir/prolongator.cu.o CMakeFiles/quda.dir/restrictor.cu.o CMakeFiles/quda.dir/staggered_prolong_restrict.cu.o CMakeFiles/quda.dir/gauge_phase.cu.o CMakeFiles/quda.dir/gauge_ape.cu.o CMakeFiles/quda.dir/gauge_stout.cu.o CMakeFiles/quda.dir/gauge_wilson_flow.cu.o CMakeFiles/quda.dir/gauge_plaq.cu.o CMakeFiles/quda.dir/laplace.cu.o CMakeFiles/quda.dir/color_spinor_util.cu.o CMakeFiles/quda.dir/color_spinor_pack.cu.o CMakeFiles/quda.dir/covDev.cu.o CMakeFiles/quda.dir/extract_gauge_ghost.cu.o CMakeFiles/quda.dir/extract_gauge_ghost_mg.cu.o CMakeFiles/quda.dir/max_gauge.cu.o CMakeFiles/quda.dir/gauge_update_quda.cu.o CMakeFiles/quda.dir/max_clover.cu.o CMakeFiles/quda.dir/llfat_quda.cu.o CMakeFiles/quda.dir/gauge_force.cu.o CMakeFiles/quda.dir/gauge_random.cu.o CMakeFiles/quda.dir/gauge_field_strength_tensor.cu.o CMakeFiles/quda.dir/clover_quda.cu.o CMakeFiles/quda.dir/dslash_quda.cu.o CMakeFiles/quda.dir/dslash_staggered.cu.o CMakeFiles/quda.dir/dslash_improved_staggered.cu.o CMakeFiles/quda.dir/dslash_wilson.cu.o CMakeFiles/quda.dir/dslash_wilson_clover.cu.o CMakeFiles/quda.dir/dslash5_domain_wall.cu.o CMakeFiles/quda.dir/dslash_wilson_clover_preconditioned.cu.o CMakeFiles/quda.dir/dslash_twisted_mass.cu.o CMakeFiles/quda.dir/dslash_twisted_mass_preconditioned.cu.o CMakeFiles/quda.dir/dslash_ndeg_twisted_mass.cu.o CMakeFiles/quda.dir/dslash_ndeg_twisted_mass_preconditioned.cu.o CMakeFiles/quda.dir/dslash_twisted_clover.cu.o CMakeFiles/quda.dir/dslash_twisted_clover_preconditioned.cu.o CMakeFiles/quda.dir/dslash_wilson_clover_hasenbusch_twist.cu.o CMakeFiles/quda.dir/dslash_wilson_clover_hasenbusch_twist_preconditioned.cu.o CMakeFiles/quda.dir/dslash_domain_wall_4d.cu.o CMakeFiles/quda.dir/dslash_domain_wall_5d.cu.o CMakeFiles/quda.dir/mdw_fused_dslash.cu.o CMakeFiles/quda.dir/dslash5_mobius_eofa.cu.o CMakeFiles/quda.dir/dslash_pack2.cu.o CMakeFiles/quda.dir/blas_quda.cu.o CMakeFiles/quda.dir/multi_blas_quda.cu.o CMakeFiles/quda.dir/reduce_quda.cu.o CMakeFiles/quda.dir/multi_reduce_quda.cu.o CMakeFiles/quda.dir/contract.cu.o CMakeFiles/quda.dir/clover_deriv_quda.cu.o CMakeFiles/quda.dir/clover_invert.cu.o CMakeFiles/quda.dir/copy_gauge_extended.cu.o CMakeFiles/quda.dir/extract_gauge_ghost_extended.cu.o CMakeFiles/quda.dir/copy_color_spinor.cu.o CMakeFiles/quda.dir/spinor_noise.cu.o CMakeFiles/quda.dir/copy_color_spinor_dd.cu.o CMakeFiles/quda.dir/copy_color_spinor_ds.cu.o CMakeFiles/quda.dir/copy_color_spinor_dh.cu.o CMakeFiles/quda.dir/copy_color_spinor_dq.cu.o CMakeFiles/quda.dir/copy_color_spinor_ss.cu.o CMakeFiles/quda.dir/copy_color_spinor_sd.cu.o CMakeFiles/quda.dir/copy_color_spinor_sh.cu.o CMakeFiles/quda.dir/copy_color_spinor_sq.cu.o CMakeFiles/quda.dir/copy_color_spinor_hd.cu.o CMakeFiles/quda.dir/copy_color_spinor_hs.cu.o CMakeFiles/quda.dir/copy_color_spinor_hh.cu.o CMakeFiles/quda.dir/copy_color_spinor_hq.cu.o CMakeFiles/quda.dir/copy_color_spinor_qd.cu.o CMakeFiles/quda.dir/copy_color_spinor_qs.cu.o CMakeFiles/quda.dir/copy_color_spinor_qh.cu.o CMakeFiles/quda.dir/copy_color_spinor_qq.cu.o CMakeFiles/quda.dir/copy_color_spinor_mg_dd.cu.o CMakeFiles/quda.dir/copy_color_spinor_mg_ds.cu.o CMakeFiles/quda.dir/copy_color_spinor_mg_sd.cu.o CMakeFiles/quda.dir/copy_color_spinor_mg_ss.cu.o CMakeFiles/quda.dir/copy_color_spinor_mg_sh.cu.o CMakeFiles/quda.dir/copy_color_spinor_mg_sq.cu.o CMakeFiles/quda.dir/copy_color_spinor_mg_hs.cu.o CMakeFiles/quda.dir/copy_color_spinor_mg_hh.cu.o CMakeFiles/quda.dir/copy_color_spinor_mg_hq.cu.o CMakeFiles/quda.dir/copy_color_spinor_mg_qs.cu.o CMakeFiles/quda.dir/copy_color_spinor_mg_qh.cu.o CMakeFiles/quda.dir/copy_color_spinor_mg_qq.cu.o CMakeFiles/quda.dir/copy_gauge_double.cu.o CMakeFiles/quda.dir/copy_gauge_single.cu.o CMakeFiles/quda.dir/copy_gauge_half.cu.o CMakeFiles/quda.dir/copy_gauge_quarter.cu.o CMakeFiles/quda.dir/copy_gauge.cu.o CMakeFiles/quda.dir/copy_gauge_mg.cu.o CMakeFiles/quda.dir/copy_clover.cu.o CMakeFiles/quda.dir/staggered_oprod.cu.o CMakeFiles/quda.dir/clover_trace_quda.cu.o CMakeFiles/quda.dir/ks_force_quda.cu.o CMakeFiles/quda.dir/hisq_paths_force_quda.cu.o CMakeFiles/quda.dir/unitarize_force_quda.cu.o CMakeFiles/quda.dir/unitarize_links_quda.cu.o CMakeFiles/quda.dir/extended_color_spinor_utilities.cu.o CMakeFiles/quda.dir/blas_cublas.cu.o CMakeFiles/quda.dir/blas_magma.cu.o CMakeFiles/quda.dir/pgauge_exchange.cu.o CMakeFiles/quda.dir/pgauge_init.cu.o CMakeFiles/quda.dir/pgauge_heatbath.cu.o CMakeFiles/quda.dir/random.cu.o CMakeFiles/quda.dir/gauge_fix_ovr_extra.cu.o CMakeFiles/quda.dir/gauge_fix_fft.cu.o CMakeFiles/quda.dir/gauge_fix_ovr.cu.o CMakeFiles/quda.dir/pgauge_det_trace.cu.o CMakeFiles/quda.dir/clover_outer_product.cu.o CMakeFiles/quda.dir/clover_sigma_outer_product.cu.o CMakeFiles/quda.dir/momentum.cu.o CMakeFiles/quda.dir/gauge_qcharge.cu.o CMakeFiles/quda.dir/checksum.cu.o CMakeFiles/quda_cpp.dir/dirac_coarse.cpp.o CMakeFiles/quda_cpp.dir/eig_trlm.cpp.o CMakeFiles/quda_cpp.dir/eig_block_trlm.cpp.o CMakeFiles/quda_cpp.dir/vector_io.cpp.o CMakeFiles/quda_cpp.dir/eigensolve_quda.cpp.o CMakeFiles/quda_cpp.dir/quda_arpack_interface.cpp.o CMakeFiles/quda_cpp.dir/multigrid.cpp.o CMakeFiles/quda_cpp.dir/transfer.cpp.o CMakeFiles/quda_cpp.dir/inv_bicgstab_quda.cpp.o CMakeFiles/quda_cpp.dir/timer.cpp.o CMakeFiles/quda_cpp.dir/solver.cpp.o CMakeFiles/quda_cpp.dir/inv_cg_quda.cpp.o CMakeFiles/quda_cpp.dir/inv_bicgstabl_quda.cpp.o CMakeFiles/quda_cpp.dir/inv_multi_cg_quda.cpp.o CMakeFiles/quda_cpp.dir/inv_eigcg_quda.cpp.o CMakeFiles/quda_cpp.dir/gauge_laplace.cpp.o CMakeFiles/quda_cpp.dir/gauge_observable.cpp.o CMakeFiles/quda_cpp.dir/inv_cg3_quda.cpp.o CMakeFiles/quda_cpp.dir/inv_ca_gcr.cpp.o CMakeFiles/quda_cpp.dir/inv_ca_cg.cpp.o CMakeFiles/quda_cpp.dir/inv_gcr_quda.cpp.o CMakeFiles/quda_cpp.dir/inv_mr_quda.cpp.o CMakeFiles/quda_cpp.dir/inv_sd_quda.cpp.o CMakeFiles/quda_cpp.dir/inv_xsd_quda.cpp.o CMakeFiles/quda_cpp.dir/inv_pcg_quda.cpp.o CMakeFiles/quda_cpp.dir/inv_mre.cpp.o CMakeFiles/quda_cpp.dir/interface_quda.cpp.o CMakeFiles/quda_cpp.dir/util_quda.cpp.o CMakeFiles/quda_cpp.dir/color_spinor_field.cpp.o CMakeFiles/quda_cpp.dir/gauge_covdev.cpp.o CMakeFiles/quda_cpp.dir/cpu_color_spinor_field.cpp.o CMakeFiles/quda_cpp.dir/cuda_color_spinor_field.cpp.o CMakeFiles/quda_cpp.dir/dirac.cpp.o CMakeFiles/quda_cpp.dir/clover_field.cpp.o CMakeFiles/quda_cpp.dir/lattice_field.cpp.o CMakeFiles/quda_cpp.dir/gauge_field.cpp.o CMakeFiles/quda_cpp.dir/cpu_gauge_field.cpp.o CMakeFiles/quda_cpp.dir/cuda_gauge_field.cpp.o CMakeFiles/quda_cpp.dir/dirac_clover.cpp.o CMakeFiles/quda_cpp.dir/dirac_wilson.cpp.o CMakeFiles/quda_cpp.dir/dirac_staggered.cpp.o CMakeFiles/quda_cpp.dir/dirac_clover_hasenbusch_twist.cpp.o CMakeFiles/quda_cpp.dir/dirac_improved_staggered.cpp.o CMakeFiles/quda_cpp.dir/dirac_domain_wall.cpp.o CMakeFiles/quda_cpp.dir/dirac_domain_wall_4d.cpp.o CMakeFiles/quda_cpp.dir/dirac_mobius.cpp.o CMakeFiles/quda_cpp.dir/dirac_twisted_clover.cpp.o CMakeFiles/quda_cpp.dir/dirac_twisted_mass.cpp.o CMakeFiles/quda_cpp.dir/comm_common.cpp.o CMakeFiles/quda_cpp.dir/milc_interface.cpp.o CMakeFiles/quda_cpp.dir/inv_mpcg_quda.cpp.o CMakeFiles/quda_cpp.dir/inv_mpbicgstab_quda.cpp.o CMakeFiles/quda_cpp.dir/inv_gmresdr_quda.cpp.o CMakeFiles/quda_cpp.dir/quda_cuda_api.cpp.o CMakeFiles/quda_cpp.dir/deflation.cpp.o CMakeFiles/quda_cpp.dir/instantiate.cpp.o CMakeFiles/quda_cpp.dir/version.cpp.o CMakeFiles/quda_cpp.dir/comm_mpi.cpp.o targets/cuda/CMakeFiles/quda_cuda_target.dir/malloc.cpp.o targets/cuda/CMakeFiles/quda_cuda_target.dir/tune.cpp.o   -L/usr/local/cuda-10.1/targets/x86_64-linux/lib/stubs  -lcuda -L/usr/local/cuda-10.1/lib64 -lcudadevrt -lcudart_static -lrt -ldl 
