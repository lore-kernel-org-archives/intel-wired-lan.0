From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 24 Mar 2017 17:54:37 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 1ce58d25ddb7a821ec1cf29a7a3cab13833ce43b
Message-ID: <58d4ecdd.AXceILT+QWPmQKU7%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
1ce58d25ddb7a821ec1cf29a7a3cab13833ce43b  Subject: i40e: initialize params before notifying of l2_param_changes  Colin Ian King <colin.king@canonical.com>

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3119:32-37: ERROR: invalid reference to the index variable of the iterator on line 3073

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line

elapsed time: 266m

configs tested: 168

i386                     randconfig-a0-201712
x86_64                 randconfig-a0-03241518
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc836x_mds_defconfig
x86_64                randconfig-in0-03241439
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
frv                               allnoconfig
ia64                            zx1_defconfig
powerpc                          allyesconfig
powerpc                 mpc834x_itx_defconfig
powerpc               mpc834x_itxgp_defconfig
x86_64                 randconfig-x015-201712
x86_64                 randconfig-x012-201712
x86_64                 randconfig-x017-201712
x86_64                 randconfig-x010-201712
x86_64                 randconfig-x018-201712
x86_64                 randconfig-x011-201712
x86_64                 randconfig-x019-201712
x86_64                 randconfig-x016-201712
x86_64                 randconfig-x013-201712
x86_64                 randconfig-x014-201712
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
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
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201712
i386                     randconfig-s1-201712
x86_64                 randconfig-s0-03241447
x86_64                 randconfig-s1-03241447
x86_64                 randconfig-s2-03241447
x86_64                 randconfig-s3-03241416
x86_64                 randconfig-s4-03241416
x86_64                 randconfig-s5-03241416
i386                             allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201712
i386                   randconfig-b0-03241531
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                     randconfig-i0-201712
i386                     randconfig-i1-201712
x86_64                           allmodconfig
blackfin                   CM-BF533_defconfig
mips                        bcm47xx_defconfig
mips                           mtx1_defconfig
x86_64                 randconfig-u0-03241554
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
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
arm                       mainstone_defconfig
powerpc                     rainier_defconfig
x86_64                randconfig-ne0-03241455
x86_64                randconfig-ne0-03241706
i386                     randconfig-n0-201712
parisc                        c8000_defconfig
powerpc                 canyonlands_defconfig
arm                        spear6xx_defconfig
blackfin                   CM-BF527_defconfig
i386                   randconfig-x070-201712
i386                   randconfig-x071-201712
i386                   randconfig-x072-201712
i386                   randconfig-x073-201712
i386                   randconfig-x074-201712
i386                   randconfig-x075-201712
i386                   randconfig-x076-201712
i386                   randconfig-x077-201712
i386                   randconfig-x078-201712
i386                   randconfig-x079-201712
x86_64                                  kexec
x86_64                               rhel-7.2
x86_64                 randconfig-x009-201712
x86_64                 randconfig-x004-201712
x86_64                 randconfig-x003-201712
x86_64                 randconfig-x008-201712
x86_64                 randconfig-x002-201712
x86_64                 randconfig-x005-201712
x86_64                 randconfig-x000-201712
x86_64                 randconfig-x007-201712
x86_64                 randconfig-x006-201712
x86_64                 randconfig-x001-201712
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                   rhel
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
sh                           se7705_defconfig
i386                     randconfig-r0-201712
x86_64                 randconfig-r0-03241525
i386                   randconfig-x005-201712
i386                   randconfig-x002-201712
i386                   randconfig-x006-201712
i386                   randconfig-x003-201712
i386                   randconfig-x007-201712
i386                   randconfig-x008-201712
i386                   randconfig-x001-201712
i386                   randconfig-x000-201712
i386                   randconfig-x004-201712
i386                   randconfig-x009-201712
i386                   randconfig-x0-03241531

Thanks,
Fengguang
