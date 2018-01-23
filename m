From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 23 Jan 2018 08:54:03 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 5510824c7809d685eecd14947f465fc59780ba28
Message-ID: <5a6687ab.a9Okdj97XRxTsZRZ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 5510824c7809d685eecd14947f465fc59780ba28  igb: add VF trust infrastructure

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:3017:43: sparse: restricted __be16 degrades to integer
drivers/net/ethernet/intel/i40evf/i40evf_main.c:2607:49: sparse: invalid assignment: |=
drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: sparse: cast from restricted __be32

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_virtchnl_pf.c:sparse:restricted-__be16-degrades-to-integer
    ??? drivers-net-ethernet-intel-i40evf-i40evf_main.c:sparse:invalid-assignment:
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:cast-from-restricted-__be32

elapsed time: 111m

configs tested: 176

x86_64                 randconfig-a0-01230614
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
arm                        raumfeld_defconfig
powerpc                   lite5200b_defconfig
powerpc                      walnut_defconfig
x86_64                randconfig-in0-01220137
x86_64                randconfig-it0-01230738
m68k                       bvme6000_defconfig
openrisc                    or1ksim_defconfig
powerpc64                           defconfig
x86_64                           allyesconfig
mips                         mpc30x_defconfig
sh                            hp6xx_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-g0-01230731
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
x86_64                 randconfig-x017-201803
x86_64                 randconfig-x018-201803
x86_64                 randconfig-x016-201803
x86_64                 randconfig-x013-201803
x86_64                 randconfig-x014-201803
x86_64                 randconfig-x011-201803
x86_64                 randconfig-x012-201803
x86_64                 randconfig-x015-201803
x86_64                 randconfig-x019-201803
x86_64                 randconfig-x010-201803
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
i386                     randconfig-a1-201803
i386                     randconfig-a0-201803
x86_64                 randconfig-s0-01230717
x86_64                 randconfig-s1-01230717
x86_64                 randconfig-s2-01230717
frv                                 defconfig
mn10300                     asb2364_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF548-EZKIT_defconfig
m68k                       m5275evb_defconfig
mips                        bcm47xx_defconfig
tile                             alldefconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                 randconfig-i0-01221022
i386                   randconfig-b0-01230725
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
blackfin                BF609-EZKIT_defconfig
m68k                        mvme16x_defconfig
parisc                           allmodconfig
powerpc                    klondike_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-b0-01230353
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
i386                   randconfig-x015-201803
i386                   randconfig-x010-201803
i386                   randconfig-x019-201803
i386                   randconfig-x014-201803
i386                   randconfig-x017-201803
i386                   randconfig-x011-201803
i386                   randconfig-x012-201803
i386                   randconfig-x016-201803
i386                   randconfig-x013-201803
i386                   randconfig-x018-201803
x86_64                 randconfig-h0-01230530
arm                            lart_defconfig
sh                          urquell_defconfig
i386                   randconfig-x071-201803
i386                   randconfig-x079-201803
i386                   randconfig-x077-201803
i386                   randconfig-x072-201803
i386                   randconfig-x076-201803
i386                   randconfig-x075-201803
i386                   randconfig-x073-201803
i386                   randconfig-x070-201803
i386                   randconfig-x074-201803
i386                   randconfig-x078-201803
x86_64                                  kexec
x86_64                               rhel-7.2
x86_64                 randconfig-n0-01230705
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-x004-201803
i386                   randconfig-x002-201803
i386                   randconfig-x007-201803
i386                   randconfig-x003-201803
i386                   randconfig-x009-201803
i386                   randconfig-x000-201803
i386                   randconfig-x006-201803
i386                   randconfig-x005-201803
i386                   randconfig-x001-201803
i386                   randconfig-x008-201803
x86_64                           allmodconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
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
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64                                   rhel
arm                            xcep_defconfig
blackfin                BF533-STAMP_defconfig
powerpc                         ps3_defconfig
x86_64                 randconfig-x008-201803
x86_64                 randconfig-x005-201803
x86_64                 randconfig-x000-201803
x86_64                 randconfig-x009-201803
x86_64                 randconfig-x007-201803
x86_64                 randconfig-x002-201803
x86_64                 randconfig-x001-201803
x86_64                 randconfig-x006-201803
x86_64                 randconfig-x003-201803
x86_64                 randconfig-x004-201803
x86_64                 randconfig-r0-01230708
alpha                            allyesconfig
arm                           spitz_defconfig
i386                   randconfig-x0-01230703

Thanks,
Fengguang
