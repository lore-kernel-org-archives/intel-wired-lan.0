From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 15 Aug 2017 06:06:33 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 cab899d8cc8b8d2cfe64bada0e11df77c8f4aa3b
Message-ID: <59921ee9.x31gCdKtGMjYwsR5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
cab899d8cc8b8d2cfe64bada0e11df77c8f4aa3b  e1000e: fix buffer overrun while the I219 is processing DMA transactions

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:668:2: warning: case value '35' not in enumerated type 'enum i40e_fc_mode' [-Wswitch]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? i386-randconfig-x016-201733
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? i386-randconfig-x018-201733
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode

elapsed time: 214m

configs tested: 182

arm                        keystone_defconfig
mips                      loongson3_defconfig
sh                     sh7710voipgw_defconfig
x86_64                randconfig-in0-08150345
x86_64                randconfig-it0-08150216
i386                   randconfig-x019-201733
i386                   randconfig-x013-201733
i386                   randconfig-x016-201733
i386                   randconfig-x012-201733
i386                   randconfig-x018-201733
i386                   randconfig-x010-201733
i386                   randconfig-x015-201733
i386                   randconfig-x011-201733
i386                   randconfig-x017-201733
i386                   randconfig-x014-201733
i386                   randconfig-n0-08141229
x86_64                 randconfig-x007-201733
x86_64                 randconfig-x001-201733
x86_64                 randconfig-x000-201733
x86_64                 randconfig-x006-201733
x86_64                 randconfig-x003-201733
x86_64                 randconfig-x004-201733
x86_64                 randconfig-x009-201733
x86_64                 randconfig-x005-201733
x86_64                 randconfig-x008-201733
x86_64                 randconfig-x002-201733
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
arm                         s3c2410_defconfig
sh                         ap325rxa_defconfig
sh                          r7785rp_defconfig
x86_64                 randconfig-v0-08150401
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-x010-201733
x86_64                 randconfig-x011-201733
x86_64                 randconfig-x012-201733
x86_64                 randconfig-x013-201733
x86_64                 randconfig-x014-201733
x86_64                 randconfig-x015-201733
x86_64                 randconfig-x016-201733
x86_64                 randconfig-x017-201733
x86_64                 randconfig-x018-201733
x86_64                 randconfig-x019-201733
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
i386                   randconfig-a0-08140413
i386                   randconfig-a1-08140413
x86_64                 randconfig-s0-08150357
x86_64                 randconfig-s1-08150357
x86_64                 randconfig-s2-08150357
x86_64                 randconfig-s0-08150542
x86_64                 randconfig-s1-08150542
x86_64                 randconfig-s2-08150542
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                   randconfig-s1-08141822
i386                   randconfig-s0-08141822
i386                             allmodconfig
arm                      footbridge_defconfig
arm                       multi_v4t_defconfig
mips                        bcm63xx_defconfig
powerpc                   motionpro_defconfig
x86_64                   randconfig-i0-201733
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                          ks8695_defconfig
mips                           jazz_defconfig
powerpc                 canyonlands_defconfig
sparc                            allyesconfig
i386                     randconfig-i1-201733
i386                     randconfig-i0-201733
x86_64                 randconfig-b0-08150322
x86_64                           allmodconfig
arm                                 defconfig
um                               alldefconfig
xtensa                  cadence_csp_defconfig
arm                            xcep_defconfig
m68k                       m5275evb_defconfig
powerpc                          g5_defconfig
x86_64                 randconfig-u0-08150516
i386                               tinyconfig
mips                          ath79_defconfig
mips                      malta_kvm_defconfig
blackfin                BF537-STAMP_defconfig
powerpc                          allyesconfig
arm                         lpc18xx_defconfig
mips                   sb1250_swarm_defconfig
i386                   randconfig-x075-201733
i386                   randconfig-x076-201733
i386                   randconfig-x071-201733
i386                   randconfig-x074-201733
i386                   randconfig-x070-201733
i386                   randconfig-x072-201733
i386                   randconfig-x079-201733
i386                   randconfig-x077-201733
i386                   randconfig-x073-201733
i386                   randconfig-x078-201733
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-x000-201733
i386                   randconfig-x003-201733
i386                   randconfig-x009-201733
i386                   randconfig-x004-201733
i386                   randconfig-x001-201733
i386                   randconfig-x008-201733
i386                   randconfig-x005-201733
i386                   randconfig-x007-201733
i386                   randconfig-x002-201733
i386                   randconfig-x006-201733
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
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
m32r                      mappi.smp_defconfig
mips                         mpc30x_defconfig
arm                           acs5k_defconfig
arm                          iop33x_defconfig
sh                             espt_defconfig
i386                   randconfig-x0-08150313

Thanks,
Fengguang
