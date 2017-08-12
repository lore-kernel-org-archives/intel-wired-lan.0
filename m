From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 12 Aug 2017 20:02:23 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 5544bc29613ac941c3941567394b84b8c8be7014
Message-ID: <598eee4f.vMdAk6nPM7PKma5t%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
5544bc29613ac941c3941567394b84b8c8be7014  e1000e: fix buffer overrun while the I219 is processing DMA transactions

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:668:2: warning: case value '35' not in enumerated type 'enum i40e_fc_mode' [-Wswitch]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? i386-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? i386-randconfig-x018-201732
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? parisc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? powerpc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? s390-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? sparc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? xtensa-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode

elapsed time: 92m

configs tested: 146

blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                               tinyconfig
x86_64                           allmodconfig
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
i386                     randconfig-n0-201732
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
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
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
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
i386                     randconfig-a0-201732
i386                     randconfig-a1-201732
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                     randconfig-s0-201732
i386                     randconfig-s1-201732
x86_64                   randconfig-i0-201732
i386                     randconfig-i0-201732
i386                     randconfig-i1-201732
i386                             allyesconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                             allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9

Thanks,
Fengguang
