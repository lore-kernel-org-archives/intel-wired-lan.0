From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 28 Sep 2017 08:52:15 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 5fea00b5d98e65580816bc0b69547ba5913864e1
Message-ID: <59cc47bf.+J5QpZo4TqS4byaH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
5fea00b5d98e65580816bc0b69547ba5913864e1  ixgbe: Return error when getting PHY address if PHY access is not supported

arch/x86/include/asm/cmpxchg.h:127:3: error: call to '__cmpxchg_wrong_size' declared with attribute error: Bad argument size for cmpxchg
arch/x86/include/asm/cmpxchg.h:133:2: note: in expansion of macro '__raw_cmpxchg'
arch/x86/include/asm/cmpxchg.h:148:2: note: in expansion of macro '__cmpxchg'
ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? arm-allmodconfig
??? ??? ERROR:__aeabi_uldivmod-drivers-net-ethernet-intel-i40e-i40e.ko-undefined
??? i386-allmodconfig
??? ??? arch-x86-include-asm-cmpxchg.h:error:call-to-__cmpxchg_wrong_size-declared-with-attribute-error:Bad-argument-size-for-cmpxchg
??? ??? arch-x86-include-asm-cmpxchg.h:note:in-expansion-of-macro-__cmpxchg
??? ??? arch-x86-include-asm-cmpxchg.h:note:in-expansion-of-macro-__raw_cmpxchg
??? i386-randconfig-x0-09280653
    ??? arch-x86-include-asm-cmpxchg.h:error:call-to-__cmpxchg_wrong_size-declared-with-attribute-error:Bad-argument-size-for-cmpxchg
    ??? arch-x86-include-asm-cmpxchg.h:note:in-expansion-of-macro-__cmpxchg
    ??? arch-x86-include-asm-cmpxchg.h:note:in-expansion-of-macro-__raw_cmpxchg

elapsed time: 146m

configs tested: 174

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                           allyesdebian
x86_64                             acpi-redef
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
mips                          malta_defconfig
powerpc                      ppc6xx_defconfig
blackfin                  TCM-BF518_defconfig
blackfin                          allnoconfig
mips                            e55_defconfig
i386                   randconfig-c0-09280558
x86_64                           allmodconfig
blackfin                         alldefconfig
i386                   randconfig-n0-09250914
x86_64                 randconfig-v0-09280458
arm64                            allmodconfig
m68k                            mac_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc836x_mds_defconfig
i386                             allmodconfig
x86_64                 randconfig-x011-201739
x86_64                 randconfig-x016-201739
x86_64                 randconfig-x018-201739
x86_64                 randconfig-x013-201739
x86_64                 randconfig-x019-201739
x86_64                 randconfig-x014-201739
x86_64                 randconfig-x012-201739
x86_64                 randconfig-x015-201739
x86_64                 randconfig-x017-201739
x86_64                 randconfig-x010-201739
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                          ixp4xx_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm64                            alldefconfig
i386                   randconfig-a1-09250859
i386                   randconfig-a0-09250859
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                     randconfig-s1-201739
i386                     randconfig-s0-201739
frv                              allyesconfig
xtensa                          iss_defconfig
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
x86_64                   randconfig-i0-201739
sparc64                           allnoconfig
sparc                               defconfig
sparc64                             defconfig
m68k                         amcore_defconfig
i386                     randconfig-i1-201739
i386                     randconfig-i0-201739
m68k                             allmodconfig
mips                           jazz_defconfig
x86_64                 randconfig-u0-09280837
i386                               tinyconfig
x86_64                randconfig-ne0-09280601
mips                malta_kvm_guest_defconfig
i386                   randconfig-x013-201739
i386                   randconfig-x019-201739
i386                   randconfig-x018-201739
i386                   randconfig-x016-201739
i386                   randconfig-x012-201739
i386                   randconfig-x015-201739
i386                   randconfig-x011-201739
i386                   randconfig-x010-201739
i386                   randconfig-x017-201739
i386                   randconfig-x014-201739
c6x                         dsk6455_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                             shx3_defconfig
sparc                            allyesconfig
powerpc                       holly_defconfig
sh                          kfr2r09_defconfig
m32r                           usrv_defconfig
mips                        maltaup_defconfig
powerpc                          alldefconfig
m68k                       m5475evb_defconfig
sh                                allnoconfig
sh                            titan_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                randconfig-ws0-09280615
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
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
i386                 randconfig-x077-09280331
i386                 randconfig-x078-09280331
i386                 randconfig-x073-09280331
i386                 randconfig-x075-09280331
i386                 randconfig-x079-09280331
i386                 randconfig-x072-09280331
i386                 randconfig-x074-09280331
i386                 randconfig-x076-09280331
i386                 randconfig-x071-09280331
i386                 randconfig-x070-09280331
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
tile                             allyesconfig
arm                        mini2440_defconfig
um                               alldefconfig
x86_64                 randconfig-x000-201739
x86_64                 randconfig-x007-201739
x86_64                 randconfig-x001-201739
x86_64                 randconfig-x006-201739
x86_64                 randconfig-x004-201739
x86_64                 randconfig-x009-201739
x86_64                 randconfig-x003-201739
x86_64                 randconfig-x002-201739
x86_64                 randconfig-x005-201739
x86_64                 randconfig-x008-201739
arm                         cm_x2xx_defconfig
mips                         cobalt_defconfig
mips                       lemote2f_defconfig
i386                   randconfig-x000-201739
i386                   randconfig-x003-201739
i386                   randconfig-x009-201739
i386                   randconfig-x004-201739
i386                   randconfig-x008-201739
i386                   randconfig-x001-201739
i386                   randconfig-x005-201739
i386                   randconfig-x002-201739
i386                   randconfig-x006-201739
i386                   randconfig-x007-201739
i386                   randconfig-x0-09280653

Thanks,
Fengguang
