From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 06 Apr 2017 15:43:18 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 63b69952decb50904f16d333f785ee52067ba25e
Message-ID: <58e5f196.ATp7GCqG0TTcE9Xq%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
63b69952decb50904f16d333f785ee52067ba25e  i40e/i40evf: Use build_skb to build frames

drivers/net/ethernet/intel/i40e/i40e_main.c:11361:15: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_main.c:11362:3: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:1346:8: error: 'struct sk_buff' has no member named 'offload_fwd_mark'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:36: error: 'size' undeclared (first use in this function)
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:5: error: 'size' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? parisc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? powerpc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? s390-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? x86_64-randconfig-s5-04061428
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? xtensa-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function

elapsed time: 121m

configs tested: 203

x86_64                              defconfig
blackfin                  CM-BF537E_defconfig
m32r                    m32700ut.up_defconfig
i386                     randconfig-a0-201714
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
m32r                         opsput_defconfig
mips                       rbtx49xx_defconfig
sh                   secureedge5410_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-04061429
i386                   randconfig-c0-04061447
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
m68k                            mac_defconfig
openrisc                         allmodconfig
sh                            migor_defconfig
arm                         assabet_defconfig
openrisc                          allnoconfig
powerpc                     tqm8560_defconfig
x86_64                 randconfig-g0-04061422
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                          ks8695_defconfig
blackfin                BF548-EZKIT_defconfig
h8300                       h8s-sim_defconfig
parisc                      default_defconfig
sh                          rsk7201_defconfig
powerpc                      cm5200_defconfig
powerpc               mpc85xx_basic_defconfig
sh                        edosk7705_defconfig
x86_64                 randconfig-x012-201714
x86_64                 randconfig-x015-201714
x86_64                 randconfig-x017-201714
x86_64                 randconfig-x010-201714
x86_64                 randconfig-x018-201714
x86_64                 randconfig-x011-201714
x86_64                 randconfig-x019-201714
x86_64                 randconfig-x013-201714
x86_64                 randconfig-x014-201714
x86_64                 randconfig-x016-201714
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
x86_64                                   rhel
x86_64                               rhel-7.2
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201714
i386                     randconfig-s1-201714
x86_64                 randconfig-s0-04061437
x86_64                 randconfig-s1-04061437
x86_64                 randconfig-s2-04061437
x86_64                           allmodconfig
x86_64                 randconfig-s3-04061428
x86_64                 randconfig-s4-04061428
x86_64                 randconfig-s5-04061428
x86_64                 randconfig-s3-04061449
x86_64                 randconfig-s4-04061449
x86_64                 randconfig-s5-04061449
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201714
i386                   randconfig-b0-04061438
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201714
i386                     randconfig-i1-201714
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
avr32        atngw100mkii_evklcd101_defconfig
powerpc                         ps3_defconfig
x86_64                 randconfig-u0-04061431
x86_64                 randconfig-u0-04061506
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                           usrv_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
m32r                    mappi2.opsp_defconfig
tile                             allmodconfig
x86_64                randconfig-ne0-04061438
arm                          exynos_defconfig
arm                          nuc910_defconfig
mn10300                           allnoconfig
i386                   randconfig-x010-201714
i386                   randconfig-x014-201714
i386                   randconfig-x016-201714
i386                   randconfig-x017-201714
i386                   randconfig-x013-201714
i386                   randconfig-x019-201714
i386                   randconfig-x011-201714
i386                   randconfig-x012-201714
i386                   randconfig-x015-201714
i386                   randconfig-x018-201714
i386                     randconfig-n0-201714
i386                   randconfig-h0-04061329
i386                   randconfig-h1-04061329
arm                        trizeps4_defconfig
sh                             shx3_defconfig
x86_64                 randconfig-h0-04061423
x86_64                 randconfig-n0-04061412
i386                  randconfig-sb0-04061340
x86_64                 randconfig-x004-201714
x86_64                 randconfig-x009-201714
x86_64                 randconfig-x003-201714
x86_64                 randconfig-x008-201714
x86_64                 randconfig-x002-201714
x86_64                 randconfig-x000-201714
x86_64                 randconfig-x007-201714
x86_64                 randconfig-x005-201714
x86_64                 randconfig-x001-201714
x86_64                 randconfig-x006-201714
x86_64                randconfig-ws0-04061341
x86_64                randconfig-ws0-04061449
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
i386                 randconfig-x071-04050905
i386                 randconfig-x070-04050905
i386                 randconfig-x077-04050905
i386                 randconfig-x072-04050905
i386                 randconfig-x074-04050905
i386                 randconfig-x076-04050905
i386                 randconfig-x073-04050905
i386                 randconfig-x079-04050905
i386                 randconfig-x075-04050905
i386                 randconfig-x078-04050905
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                   motionpro_defconfig
powerpc                     sbc8548_defconfig
sparc                       sparc64_defconfig
i386                     randconfig-r0-201714
x86_64                 randconfig-r0-04061414
i386                             allmodconfig
blackfin                    DNP5370_defconfig
blackfin                      H8606_defconfig
blackfin                            defconfig
i386                   randconfig-x006-201714
i386                   randconfig-x005-201714
i386                   randconfig-x002-201714
i386                   randconfig-x007-201714
i386                   randconfig-x003-201714
i386                   randconfig-x001-201714
i386                   randconfig-x008-201714
i386                   randconfig-x000-201714
i386                   randconfig-x009-201714
i386                   randconfig-x004-201714
i386                   randconfig-x0-04061436

Thanks,
Fengguang
