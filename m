From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 10 Aug 2017 18:39:12 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 0f06916071bcc736f85b4f1818bb204f588d2d71
Message-ID: <598c37d0.T3kUmeKVGFbvQmos%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
0f06916071bcc736f85b4f1818bb204f588d2d71  e1000e: fix buffer overrun while the I219 is processing DMA transactions

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:668:2: warning: case value '35' not in enumerated type 'enum i40e_fc_mode' [-Wswitch]

Error ids grouped by kconfigs:

recent_errors
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? arm64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? i386-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? powerpc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? s390-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-rhel-7.2+CONFIG_DEBUG_INFO_REDUCED
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? xtensa-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode

elapsed time: 217m

configs tested: 205

i386                   randconfig-c0-08101723
cris                                defconfig
powerpc                 canyonlands_defconfig
sh                              ul2_defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201732
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
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
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
m32r                              allnoconfig
m68k                             allmodconfig
powerpc                     pq2fads_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
x86_64                 randconfig-x016-201732
x86_64                 randconfig-x011-201732
x86_64                 randconfig-x014-201732
x86_64                 randconfig-x019-201732
x86_64                 randconfig-x012-201732
x86_64                 randconfig-x013-201732
x86_64                 randconfig-x018-201732
x86_64                 randconfig-x015-201732
x86_64                 randconfig-x010-201732
x86_64                 randconfig-x017-201732
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
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
x86_64                                  kexec
x86_64       rhel-7.2+CONFIG_DEBUG_INFO_REDUCED
i386                     randconfig-a0-201732
i386                     randconfig-a1-201732
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
arm                         em_x270_defconfig
powerpc                      cm5200_defconfig
sh                          urquell_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201732
i386                     randconfig-s1-201732
x86_64                 randconfig-s3-08101639
x86_64                 randconfig-s4-08101639
x86_64                 randconfig-s5-08101639
mips                          ath79_defconfig
mips                        msp71xx_defconfig
powerpc                          allmodconfig
sh                          sdk7786_defconfig
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
x86_64                   randconfig-i0-201732
i386                   randconfig-b0-08101637
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
m32r                    mappi2.opsp_defconfig
mips                           jazz_defconfig
openrisc                         alldefconfig
xtensa                    smp_lx200_defconfig
x86_64                              defconfig
arm                          iop32x_defconfig
nios2                         10m50_defconfig
i386                     randconfig-i1-201732
i386                     randconfig-i0-201732
i386                             allyesconfig
x86_64                 randconfig-b0-08101624
x86_64                           allmodconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm64                            allyesconfig
mips                          rb532_defconfig
x86_64                 randconfig-u0-08101616
i386                               tinyconfig
arm                             ezx_defconfig
powerpc                     kmeter1_defconfig
powerpc                     redwood_defconfig
powerpc                      mgcoge_defconfig
x86_64                randconfig-ne0-08101644
x86_64                randconfig-ne0-08101736
arm                        realview_defconfig
mips                       bmips_be_defconfig
sparc                            alldefconfig
i386                   randconfig-x019-201732
i386                   randconfig-x013-201732
i386                   randconfig-x016-201732
i386                   randconfig-x012-201732
i386                   randconfig-x018-201732
i386                   randconfig-x010-201732
i386                   randconfig-x015-201732
i386                   randconfig-x011-201732
i386                   randconfig-x017-201732
i386                   randconfig-x014-201732
i386                   randconfig-h0-08101741
i386                   randconfig-h1-08101741
m68k                                defconfig
s390                             allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                  randconfig-sb0-08101542
i386                   randconfig-x000-201732
i386                   randconfig-x003-201732
i386                   randconfig-x009-201732
i386                   randconfig-x004-201732
i386                   randconfig-x001-201732
i386                   randconfig-x008-201732
i386                   randconfig-x005-201732
i386                   randconfig-x007-201732
i386                   randconfig-x002-201732
i386                   randconfig-x006-201732
x86_64                 randconfig-x007-201732
x86_64                 randconfig-x001-201732
x86_64                 randconfig-x000-201732
x86_64                 randconfig-x006-201732
x86_64                 randconfig-x003-201732
x86_64                 randconfig-x004-201732
x86_64                 randconfig-x009-201732
x86_64                 randconfig-x005-201732
x86_64                 randconfig-x008-201732
x86_64                 randconfig-x002-201732
xtensa                           allmodconfig
arm                      integrator_defconfig
mn10300                           allnoconfig
openrisc                            defconfig
x86_64                randconfig-ws0-08101617
i386                   randconfig-x075-201732
i386                   randconfig-x076-201732
i386                   randconfig-x071-201732
i386                   randconfig-x074-201732
i386                   randconfig-x070-201732
i386                   randconfig-x072-201732
i386                   randconfig-x079-201732
i386                   randconfig-x077-201732
i386                   randconfig-x078-201732
i386                   randconfig-x073-201732
arm                  colibri_pxa270_defconfig
powerpc                    gamecube_defconfig
powerpc                    sam440ep_defconfig
blackfin                      H8606_defconfig
mn10300                             defconfig
powerpc                 mpc836x_rdk_defconfig
x86_64                 randconfig-r0-08101617
cris                             allyesconfig
powerpc                      tqm8xx_defconfig
sh                           se7751_defconfig

Thanks,
Fengguang
