From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 07 Sep 2017 09:57:27 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 c0b59b2886df475ed66cf9a6bfc46dbf514a327f
Message-ID: <59b0a787.iahmOXcEcGCBEpd9%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
c0b59b2886df475ed66cf9a6bfc46dbf514a327f  ixgbe: add counter for times rx pages gets allocated, not recycled

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
??? i386-randconfig-x013-201736
    ??? arch-x86-include-asm-cmpxchg.h:error:call-to-__cmpxchg_wrong_size-declared-with-attribute-error:Bad-argument-size-for-cmpxchg
    ??? arch-x86-include-asm-cmpxchg.h:note:in-expansion-of-macro-__cmpxchg
    ??? arch-x86-include-asm-cmpxchg.h:note:in-expansion-of-macro-__raw_cmpxchg
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:note:in-expansion-of-macro-cmpxchg
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:__ret-may-be-used-uninitialized-in-this-function

elapsed time: 65m

configs tested: 111

blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                     randconfig-n0-201736
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-x016-201736
x86_64                 randconfig-x011-201736
x86_64                 randconfig-x012-201736
x86_64                 randconfig-x014-201736
x86_64                 randconfig-x019-201736
x86_64                 randconfig-x013-201736
x86_64                 randconfig-x018-201736
x86_64                 randconfig-x015-201736
x86_64                 randconfig-x010-201736
x86_64                 randconfig-x017-201736
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-a0-201736
i386                     randconfig-a1-201736
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s1-201736
i386                     randconfig-s0-201736
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201736
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-x019-201736
i386                   randconfig-x013-201736
i386                   randconfig-x012-201736
i386                   randconfig-x016-201736
i386                   randconfig-x018-201736
i386                   randconfig-x010-201736
i386                   randconfig-x011-201736
i386                   randconfig-x015-201736
i386                   randconfig-x014-201736
i386                   randconfig-x017-201736
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
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
i386                   randconfig-x076-201736
i386                   randconfig-x075-201736
i386                   randconfig-x071-201736
i386                   randconfig-x070-201736
i386                   randconfig-x074-201736
i386                   randconfig-x079-201736
i386                   randconfig-x072-201736
i386                   randconfig-x078-201736
i386                   randconfig-x073-201736
i386                   randconfig-x077-201736
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                 randconfig-x001-201736
x86_64                 randconfig-x007-201736
x86_64                 randconfig-x000-201736
x86_64                 randconfig-x006-201736
x86_64                 randconfig-x003-201736
x86_64                 randconfig-x009-201736
x86_64                 randconfig-x004-201736
x86_64                 randconfig-x008-201736
x86_64                 randconfig-x005-201736
x86_64                 randconfig-x002-201736
i386                             allmodconfig
i386                   randconfig-x003-201736
i386                   randconfig-x000-201736
i386                   randconfig-x004-201736
i386                   randconfig-x009-201736
i386                   randconfig-x005-201736
i386                   randconfig-x001-201736
i386                   randconfig-x008-201736
i386                   randconfig-x007-201736
i386                   randconfig-x006-201736
i386                   randconfig-x002-201736
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig

Thanks,
Fengguang
