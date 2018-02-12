From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 13 Feb 2018 07:06:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:40GbE] BUILD REGRESSION
 a0073a4b8b5906b2a7eab5e9d4a91759b56bc96f
Message-ID: <5a821de8.gY0yEqdAdp2T+xUy%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  40GbE
branch HEAD: a0073a4b8b5906b2a7eab5e9d4a91759b56bc96f  i40e/i40evf: Add support for new mechanism of updating adaptive ITR

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4454:6: error: implicit declaration of function 'cmpxchg64'; did you mean 'cmpxchg'? [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? mips-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:error:implicit-declaration-of-function-cmpxchg64-did-you-mean-cmpxchg

elapsed time: 138m

configs tested: 190

alpha                             allnoconfig
mips                        workpad_defconfig
sh                               allyesconfig
x86_64                 randconfig-a0-02130447
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                               tinyconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-02130515
i386                   randconfig-x010-201806
i386                   randconfig-x019-201806
i386                   randconfig-x015-201806
i386                   randconfig-x014-201806
i386                   randconfig-x017-201806
i386                   randconfig-x012-201806
i386                   randconfig-x011-201806
i386                   randconfig-x016-201806
i386                   randconfig-x018-201806
i386                   randconfig-x013-201806
i386                   randconfig-n0-02120117
x86_64                 randconfig-x008-201806
x86_64                 randconfig-x005-201806
x86_64                 randconfig-x000-201806
x86_64                 randconfig-x002-201806
x86_64                 randconfig-x009-201806
x86_64                 randconfig-x007-201806
x86_64                 randconfig-x006-201806
x86_64                 randconfig-x001-201806
x86_64                 randconfig-x003-201806
x86_64                 randconfig-x004-201806
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201806
i386                     randconfig-i1-201806
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
arm                     am200epdkit_defconfig
arm                      pxa255-idp_defconfig
blackfin                      H8606_defconfig
x86_64                 randconfig-g0-02130326
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                       imx_v6_v7_defconfig
arm                          ixp4xx_defconfig
arm                        mvebu_v7_defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                           tegra_defconfig
arm64                            alldefconfig
arm64                            allmodconfig
i386                     randconfig-a1-201806
i386                     randconfig-a0-201806
x86_64                 randconfig-s0-02130447
x86_64                 randconfig-s1-02130447
x86_64                 randconfig-s2-02130447
x86_64                 randconfig-s0-02130540
x86_64                 randconfig-s1-02130540
x86_64                 randconfig-s2-02130540
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                          iop33x_defconfig
arm                            u300_defconfig
mips                       lemote2f_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                          urquell_defconfig
x86_64                 randconfig-x017-201806
x86_64                 randconfig-x018-201806
x86_64                 randconfig-x016-201806
x86_64                 randconfig-x013-201806
x86_64                 randconfig-x011-201806
x86_64                 randconfig-x014-201806
x86_64                 randconfig-x015-201806
x86_64                 randconfig-x012-201806
x86_64                 randconfig-x019-201806
x86_64                 randconfig-x010-201806
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s0-02121625
i386                   randconfig-s1-02121625
x86_64                 randconfig-s3-02130517
x86_64                 randconfig-s4-02130517
x86_64                 randconfig-s5-02130517
x86_64                 randconfig-i0-02121058
i386                   randconfig-b0-02130326
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-b0-02130438
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
parisc                           allmodconfig
powerpc                     rainier_defconfig
x86_64                 randconfig-u0-02130230
i386                   randconfig-h0-02130405
i386                   randconfig-h1-02130405
arm                      acs5k_tiny_defconfig
mips                           ci20_defconfig
x86_64                randconfig-ne0-02130443
arm                         lpc32xx_defconfig
frv                               allnoconfig
x86_64                 randconfig-h0-02130414
openrisc                         allmodconfig
x86_64                 randconfig-n0-02130415
i386                  randconfig-sb0-02130435
x86_64                randconfig-ws0-02130000
c6x                        evmc6474_defconfig
s390                             alldefconfig
i386                   randconfig-x071-201806
i386                   randconfig-x079-201806
i386                   randconfig-x072-201806
i386                   randconfig-x077-201806
i386                   randconfig-x076-201806
i386                   randconfig-x075-201806
i386                   randconfig-x070-201806
i386                   randconfig-x073-201806
i386                   randconfig-x078-201806
i386                   randconfig-x074-201806
x86_64                                  kexec
x86_64                              federa-25
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                 randconfig-r0-02130512
i386                   randconfig-x004-201806
i386                   randconfig-x007-201806
i386                   randconfig-x002-201806
i386                   randconfig-x003-201806
i386                   randconfig-x009-201806
i386                   randconfig-x000-201806
i386                   randconfig-x005-201806
i386                   randconfig-x006-201806
i386                   randconfig-x008-201806
i386                   randconfig-x001-201806
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                   randconfig-x0-02130231

Thanks,
Fengguang
