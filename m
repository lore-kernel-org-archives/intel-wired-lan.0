From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 06 Sep 2017 19:11:54 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 83f7dc72348ff8bedf4bc1cb97d6e887143d26c4
Message-ID: <59afd7fa.+z5GE8iOT+Df6LoI%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
83f7dc72348ff8bedf4bc1cb97d6e887143d26c4  ixgbe: add counter for times rx pages gets allocated, not recycled

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

elapsed time: 130m

configs tested: 202

arm                       versatile_defconfig
s390                             allmodconfig
x86_64                 randconfig-a0-09061702
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
arm                         mv78xx0_defconfig
powerpc                     sbc8548_defconfig
sparc                            allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-09061637
x86_64                           allmodconfig
mips                malta_kvm_guest_defconfig
s390                       zfcpdump_defconfig
sh                      rts7751r2d1_defconfig
x86_64                randconfig-in0-09061246
parisc                           allmodconfig
sh                         ecovec24_defconfig
x86_64                randconfig-it0-09061623
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
i386                     randconfig-n0-201736
arm                           viper_defconfig
powerpc               mpc86xx_basic_defconfig
sh                            migor_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-v0-09061621
openrisc                         allmodconfig
sh                        sh7757lcr_defconfig
x86_64                 randconfig-g0-09061631
x86_64                 randconfig-x010-201736
x86_64                 randconfig-x011-201736
x86_64                 randconfig-x012-201736
x86_64                 randconfig-x013-201736
x86_64                 randconfig-x014-201736
x86_64                 randconfig-x015-201736
x86_64                 randconfig-x016-201736
x86_64                 randconfig-x017-201736
x86_64                 randconfig-x018-201736
x86_64                 randconfig-x019-201736
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
i386                     randconfig-a0-201736
i386                     randconfig-a1-201736
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
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
blackfin          BF527-AD7160-EVAL_defconfig
cris                             allyesconfig
mips                            gpr_defconfig
powerpc                 canyonlands_defconfig
i386                     randconfig-s0-201736
i386                     randconfig-s1-201736
arm                     am200epdkit_defconfig
arm                          badge4_defconfig
arm                         lpc32xx_defconfig
arm                          lpd270_defconfig
x86_64                   randconfig-i0-201736
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                        evmc6474_defconfig
m68k                        mvme147_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201736
i386                     randconfig-i1-201736
x86_64                 randconfig-b0-09061259
arm                         nhk8815_defconfig
m68k                       m5249evb_defconfig
powerpc                    adder875_defconfig
i386                               tinyconfig
x86_64                randconfig-ne0-09061551
mips                  cavium_octeon_defconfig
parisc                           allyesconfig
powerpc                          g5_defconfig
sh                          kfr2r09_defconfig
mn10300                          allyesconfig
sh                   sh7724_generic_defconfig
microblaze                       allyesconfig
powerpc                      ep88xc_defconfig
powerpc                    klondike_defconfig
powerpc64                        allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
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
arm                             ezx_defconfig
mips                      malta_kvm_defconfig
powerpc                    mvme5100_defconfig
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
m68k                         apollo_defconfig
sh                           se7619_defconfig
x86_64                randconfig-ws0-09061615
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
parisc                generic-64bit_defconfig
sh                          polaris_defconfig
tile                              allnoconfig
x86_64                 randconfig-x000-201736
x86_64                 randconfig-x001-201736
x86_64                 randconfig-x002-201736
x86_64                 randconfig-x003-201736
x86_64                 randconfig-x004-201736
x86_64                 randconfig-x005-201736
x86_64                 randconfig-x006-201736
x86_64                 randconfig-x007-201736
x86_64                 randconfig-x008-201736
x86_64                 randconfig-x009-201736
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
i386                             allmodconfig
ia64                             allmodconfig
sparc                       sparc64_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
i386                   randconfig-x0-09061639

Thanks,
Fengguang
