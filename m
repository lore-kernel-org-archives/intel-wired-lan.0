From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 25 Jan 2018 02:38:17 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 6cf71fc56874cb7823f678ebeadfc0ede9acc497
Message-ID: <5a68d299.eNaCtdb+fQGLCgov%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 6cf71fc56874cb7823f678ebeadfc0ede9acc497  i40e: Add and delete cloud filter

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: sparse: cast from restricted __be32

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:cast-from-restricted-__be32

elapsed time: 159m

configs tested: 204

arm                        raumfeld_defconfig
sparc64                          allyesconfig
xtensa                            allnoconfig
x86_64                 randconfig-a0-01250043
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                               tinyconfig
x86_64                           allmodconfig
arm                          pxa910_defconfig
mips                      pic32mzda_defconfig
sparc                            allmodconfig
x86_64                randconfig-it0-01250033
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201803
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-i0-201803
i386                     randconfig-i1-201803
x86_64                 randconfig-v0-01250025
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
ia64                        generic_defconfig
m32r                      mappi.smp_defconfig
mips                        omega2p_defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
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
i386                   randconfig-a1-01241352
i386                   randconfig-a0-01241352
x86_64                 randconfig-s0-01250059
x86_64                 randconfig-s1-01250059
x86_64                 randconfig-s2-01250059
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                         lubbock_defconfig
blackfin                BF538-EZKIT_defconfig
mips                        qi_lb60_defconfig
sh                               alldefconfig
frv                               allnoconfig
mips                        workpad_defconfig
sh                        edosk7705_defconfig
sh                          sdk7780_defconfig
um                               alldefconfig
i386                     randconfig-s0-201803
i386                     randconfig-s1-201803
x86_64                 randconfig-s3-01250043
x86_64                 randconfig-s4-01250043
x86_64                 randconfig-s5-01250043
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
x86_64                   randconfig-i0-201803
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
arm                         s5pv210_defconfig
mips                       markeins_defconfig
parisc                          712_defconfig
blackfin                       IP0X_defconfig
x86_64                 randconfig-u0-01250058
x86_64                 randconfig-u0-01250127
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
i386                   randconfig-h0-01241830
i386                   randconfig-h1-01241830
arm                       mainstone_defconfig
x86_64                randconfig-ne0-01250032
arm                    vt8500_v6_v7_defconfig
m32r                             allyesconfig
powerpc                      makalu_defconfig
x86_64                 randconfig-h0-01242319
arm                              allyesconfig
sh                            migor_defconfig
x86_64                 randconfig-n0-01242347
blackfin                BF561-EZKIT_defconfig
mn10300                          allmodconfig
s390                                defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                  randconfig-sb0-01250024
i386                  randconfig-sb0-01250139
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arm                            netx_defconfig
microblaze                        allnoconfig
parisc                           allmodconfig
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
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
mips                    maltaup_xpa_defconfig
powerpc                     tqm5200_defconfig
s390                              allnoconfig
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
x86_64                 randconfig-r0-01242317
nios2                         3c120_defconfig
sh                               j2_defconfig
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
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                   randconfig-x0-01250111

Thanks,
Fengguang
