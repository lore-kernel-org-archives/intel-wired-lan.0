From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 14 Jun 2015 09:22:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 aabe960a9b11c3bfd2fec9b8338dc3cd32da8b12 BUILD DONE
Message-ID: <557cd748.m4DnS1Lj7QPddjOI%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
aabe960a9b11c3bfd2fec9b8338dc3cd32da8b12  ixgbe: Assign set_phy_power dynamically where needed.

drivers/net/ethernet/intel/i40e/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40e/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'
drivers/net/ethernet/intel/i40e/i40e_main.c:7601:2: warning: left shift count >= width of type
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'

elapsed time: 29m

configs tested: 95

avr32                       mimc200_defconfig
m68k                             alldefconfig
sh                        edosk7705_defconfig
mips                   sb1250_swarm_defconfig
parisc                        c3000_defconfig
powerpc                     pq2fads_defconfig
alpha                            allyesconfig
mn10300                          alldefconfig
sh                          lboxre2_defconfig
x86_64                 randconfig-a0-06140849
x86_64                 randconfig-a0-06140854
x86_64                 randconfig-a0-06140907
i386                   randconfig-c0-06140850
x86_64                 randconfig-v0-06140850
x86_64                 randconfig-v0-06140856
x86_64                 randconfig-v0-06140902
x86_64                 randconfig-v0-06140907
x86_64                 randconfig-v0-06140913
arm                         s5pv210_defconfig
mn10300                          allyesconfig
powerpc                        cell_defconfig
s390                    performance_defconfig
arm                         ebsa110_defconfig
arm                       imx_v6_v7_defconfig
blackfin                BF533-EZKIT_defconfig
mips                                defconfig
arm                  colibri_pxa270_defconfig
microblaze                    nommu_defconfig
powerpc                     redwood_defconfig
sh                             espt_defconfig
i386                   randconfig-b0-06140850
i386                   randconfig-b0-06140857
i386                   randconfig-b0-06140905
i386                   randconfig-b0-06140911
i386                   randconfig-b0-06140917
arm                          badge4_defconfig
arm                         vf610m4_defconfig
mips                        nlm_xlp_defconfig
sh                                allnoconfig
openrisc                          allnoconfig
powerpc                      obs600_defconfig
s390                             alldefconfig
sh                         ecovec24_defconfig
arm                           efm32_defconfig
arm                          prima2_defconfig
mips                            e55_defconfig
mips                           ip32_defconfig
arm                            lart_defconfig
arm                             rpc_defconfig
openrisc                            defconfig
arm                          pxa3xx_defconfig
powerpc                     tqm8540_defconfig
powerpc                      tqm8xx_defconfig
sh                               alldefconfig
x86_64                 randconfig-b0-06140850
x86_64                 randconfig-b0-06140901
x86_64                 randconfig-b0-06140907
x86_64                 randconfig-b0-06140913
x86_64                 randconfig-b0-06140918
blackfin            BF561-EZKIT-SMP_defconfig
ia64                             alldefconfig
powerpc                mpc7448_hpc2_defconfig
sh                           se7721_defconfig
i386                   randconfig-h0-06140854
i386                   randconfig-h1-06140854
x86_64                 randconfig-h0-06140849
x86_64                 randconfig-h0-06140857
x86_64                 randconfig-h0-06140907
x86_64                 randconfig-h0-06140915
x86_64                 randconfig-n0-06140849
x86_64                 randconfig-n0-06140857
x86_64                 randconfig-n0-06140903
arm                  colibri_pxa300_defconfig
blackfin                 BlackStamp_defconfig
sh                          polaris_defconfig
sh                              ul2_defconfig
xtensa                           allyesconfig
i386                  randconfig-sb0-06140850
i386                  randconfig-sb0-06140856
i386                  randconfig-sb0-06140904
i386                  randconfig-sb0-06140909
arm                            qcom_defconfig
sh                        edosk7760_defconfig
sh                           se7750_defconfig
arm                          iop32x_defconfig
sh                             shx3_defconfig
mips                            gpr_defconfig
sh                ecovec24-romimage_defconfig
sh                           se7712_defconfig
x86_64                 randconfig-r0-06140850
x86_64                 randconfig-r0-06140858
x86_64                 randconfig-s0-06140902
x86_64                 randconfig-s0-06140913
i386                   randconfig-x0-06140849
i386                   randconfig-x0-06140904

Thanks,
Fengguang
