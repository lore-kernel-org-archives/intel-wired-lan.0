From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 02 Sep 2017 07:29:12 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 08f91a425600cdae9ff6637b7619ef6e25aa3938
Message-ID: <59a9ed48.0mM9EbpuFHWpk16k%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
08f91a425600cdae9ff6637b7619ef6e25aa3938  igb: check memory allocation failure

arch/x86/include/asm/cmpxchg.h:127:3: error: call to '__cmpxchg_wrong_size' declared with attribute error: Bad argument size for cmpxchg
arch/x86/include/asm/cmpxchg.h:133:2: note: in expansion of macro '__raw_cmpxchg'
arch/x86/include/asm/cmpxchg.h:148:2: note: in expansion of macro '__cmpxchg'
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4155:5: warning: '__ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4155:6: note: in expansion of macro 'cmpxchg'

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? arch-x86-include-asm-cmpxchg.h:error:call-to-__cmpxchg_wrong_size-declared-with-attribute-error:Bad-argument-size-for-cmpxchg
??? ??? arch-x86-include-asm-cmpxchg.h:note:in-expansion-of-macro-__cmpxchg
??? ??? arch-x86-include-asm-cmpxchg.h:note:in-expansion-of-macro-__raw_cmpxchg
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:note:in-expansion-of-macro-cmpxchg
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:__ret-may-be-used-uninitialized-in-this-function
??? i386-randconfig-x002-201735
    ??? arch-x86-include-asm-cmpxchg.h:error:call-to-__cmpxchg_wrong_size-declared-with-attribute-error:Bad-argument-size-for-cmpxchg
    ??? arch-x86-include-asm-cmpxchg.h:note:in-expansion-of-macro-__cmpxchg
    ??? arch-x86-include-asm-cmpxchg.h:note:in-expansion-of-macro-__raw_cmpxchg
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:note:in-expansion-of-macro-cmpxchg
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:__ret-may-be-used-uninitialized-in-this-function

elapsed time: 135m

configs tested: 137

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                   randconfig-x019-201735
i386                   randconfig-x013-201735
i386                   randconfig-x012-201735
i386                   randconfig-x016-201735
i386                   randconfig-x018-201735
i386                   randconfig-x010-201735
i386                   randconfig-x011-201735
i386                   randconfig-x015-201735
i386                   randconfig-x014-201735
i386                   randconfig-x017-201735
i386                     randconfig-n0-201735
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                              allmodconfig
arm                                   samsung
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm                                      arm5
arm64                            alldefconfig
arm                                        sh
arm                                     arm67
i386                     randconfig-a0-201735
i386                     randconfig-a1-201735
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                               allnoconfig
m32r                   mappi2.vdec2_defconfig
mips                  cavium_octeon_defconfig
mips                        qi_lb60_defconfig
powerpc                      bamboo_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                     randconfig-s1-201735
i386                     randconfig-s0-201735
x86_64                           allmodconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201735
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                               tinyconfig
i386                             allmodconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-x003-201735
i386                   randconfig-x000-201735
i386                   randconfig-x004-201735
i386                   randconfig-x009-201735
i386                   randconfig-x005-201735
i386                   randconfig-x008-201735
i386                   randconfig-x001-201735
i386                   randconfig-x007-201735
i386                   randconfig-x006-201735
i386                   randconfig-x002-201735
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
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
x86_64                 randconfig-x001-201735
x86_64                 randconfig-x007-201735
x86_64                 randconfig-x000-201735
x86_64                 randconfig-x006-201735
x86_64                 randconfig-x003-201735
x86_64                 randconfig-x009-201735
x86_64                 randconfig-x004-201735
x86_64                 randconfig-x008-201735
x86_64                 randconfig-x005-201735
x86_64                 randconfig-x002-201735
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
i386                   randconfig-x076-201735
i386                   randconfig-x075-201735
i386                   randconfig-x071-201735
i386                   randconfig-x070-201735
i386                   randconfig-x074-201735
i386                   randconfig-x079-201735
i386                   randconfig-x072-201735
i386                   randconfig-x073-201735
i386                   randconfig-x078-201735
i386                   randconfig-x077-201735

Thanks,
Fengguang
