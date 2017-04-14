From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 14 Apr 2017 13:46:18 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 67489ba9aec0ee4bcabf673186d2e439d55ad8d6
Message-ID: <58f0622a.rGqVIaDmcJDVX598%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
67489ba9aec0ee4bcabf673186d2e439d55ad8d6  Subject: ixgbe: Allow setting zero MAC address for VF

drivers/net/ethernet/intel/i40e/i40e_main.c:11369:15: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_main.c:11370:3: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:1372:8: error: 'struct sk_buff' has no member named 'offload_fwd_mark'
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
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? i386-randconfig-x074-201715
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
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
??? x86_64-randconfig-a0-04140958
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
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

elapsed time: 175m

configs tested: 190

arm                           u8500_defconfig
powerpc                      pcm030_defconfig
s390                             alldefconfig
i386                     randconfig-a0-201715
x86_64                 randconfig-a0-04140958
powerpc                   currituck_defconfig
sh                               alldefconfig
sh                         microdev_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-04140952
blackfin            BF561-EZKIT-SMP_defconfig
mips                          ath25_defconfig
powerpc                      chrp32_defconfig
arm                          prima2_defconfig
mips                              allnoconfig
parisc                           alldefconfig
x86_64                randconfig-it0-04141053
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-g0-04141115
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                 randconfig-x012-201715
x86_64                 randconfig-x015-201715
x86_64                 randconfig-x017-201715
x86_64                 randconfig-x010-201715
x86_64                 randconfig-x018-201715
x86_64                 randconfig-x011-201715
x86_64                 randconfig-x019-201715
x86_64                 randconfig-x014-201715
x86_64                 randconfig-x013-201715
x86_64                 randconfig-x016-201715
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
i386                     randconfig-s0-201715
i386                     randconfig-s1-201715
x86_64                 randconfig-s0-04140944
x86_64                 randconfig-s1-04140944
x86_64                 randconfig-s2-04140944
x86_64                 randconfig-s0-04141151
x86_64                 randconfig-s1-04141151
x86_64                 randconfig-s2-04141151
x86_64                           allmodconfig
x86_64                 randconfig-s3-04141102
x86_64                 randconfig-s4-04141102
x86_64                 randconfig-s5-04141102
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
i386                             allmodconfig
arm                  colibri_pxa300_defconfig
avr32        atngw100mkii_evklcd100_defconfig
openrisc                         allmodconfig
xtensa                generic_kc705_defconfig
x86_64                   randconfig-i0-201715
i386                   randconfig-b0-04140927
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201715
i386                     randconfig-i1-201715
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
x86_64                 randconfig-u0-04141048
i386                   randconfig-x010-201715
i386                   randconfig-x014-201715
i386                   randconfig-x016-201715
i386                   randconfig-x017-201715
i386                   randconfig-x013-201715
i386                   randconfig-x019-201715
i386                   randconfig-x011-201715
i386                   randconfig-x015-201715
i386                   randconfig-x012-201715
i386                   randconfig-x018-201715
mn10300                          allmodconfig
nios2                         3c120_defconfig
arm                           sama5_defconfig
cris                        etraxfs_defconfig
microblaze                          defconfig
x86_64                randconfig-ne0-04141112
arm                           spitz_defconfig
mips                        generic_defconfig
mips                           ip32_defconfig
sh                     sh7710voipgw_defconfig
i386                     randconfig-n0-201715
i386                   randconfig-h0-04140813
i386                   randconfig-h1-04140813
x86_64                                   rhel
x86_64                               rhel-7.2
i386                   randconfig-x070-201715
i386                   randconfig-x071-201715
i386                   randconfig-x072-201715
i386                   randconfig-x073-201715
i386                   randconfig-x074-201715
i386                   randconfig-x075-201715
i386                   randconfig-x076-201715
i386                   randconfig-x077-201715
i386                   randconfig-x078-201715
i386                   randconfig-x079-201715
i386                  randconfig-sb0-04140903
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64                 randconfig-x000-201715
x86_64                 randconfig-x001-201715
x86_64                 randconfig-x002-201715
x86_64                 randconfig-x003-201715
x86_64                 randconfig-x004-201715
x86_64                 randconfig-x005-201715
x86_64                 randconfig-x006-201715
x86_64                 randconfig-x007-201715
x86_64                 randconfig-x008-201715
x86_64                 randconfig-x009-201715
i386                     randconfig-r0-201715
i386                   randconfig-x006-201715
i386                   randconfig-x002-201715
i386                   randconfig-x005-201715
i386                   randconfig-x007-201715
i386                   randconfig-x003-201715
i386                   randconfig-x001-201715
i386                   randconfig-x008-201715
i386                   randconfig-x000-201715
i386                   randconfig-x009-201715
i386                   randconfig-x004-201715
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                   randconfig-x0-04140937

Thanks,
Fengguang
