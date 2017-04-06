From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 06 Apr 2017 10:10:18 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 6f5a28bbe353e09cf16aedcb9fc44cf6fd4ae3b6
Message-ID: <58e5a38a.Nel1a4Ec/MTRAacJ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
6f5a28bbe353e09cf16aedcb9fc44cf6fd4ae3b6  i40e/i40evf: Use build_skb to build frames

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
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? xtensa-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function

elapsed time: 283m

configs tested: 143

i386                     randconfig-a0-201714
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                                  kexec
x86_64                                   rhel
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
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
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
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
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s0-201714
i386                     randconfig-s1-201714
i386                               tinyconfig
i386                             allmodconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201714
i386                     randconfig-i0-201714
i386                     randconfig-i1-201714
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
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
i386                   randconfig-n0-04051821
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
x86_64                           allmodconfig
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
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
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
i386                     randconfig-r0-201714
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

Thanks,
Fengguang
