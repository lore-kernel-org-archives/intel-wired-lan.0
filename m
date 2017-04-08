From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 08 Apr 2017 17:33:15 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 351268d714a036980895a67fd182a9efe27acba1
Message-ID: <58e8ae5b.9JM8nCeAXKoA3xeR%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
351268d714a036980895a67fd182a9efe27acba1  i40e/i40evf: Remove VF Rx csum offload for tunneled packets.

drivers/net/ethernet/intel/i40e/i40e_main.c:11369:15: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_main.c:11370:3: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:1346:8: error: 'struct sk_buff' has no member named 'offload_fwd_mark'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:36: error: 'size' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? i386-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark

elapsed time: 235m

configs tested: 166

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
avr32                        merisc_defconfig
blackfin                BF537-STAMP_defconfig
i386                     randconfig-a0-201714
x86_64                 randconfig-a0-04081425
i386                               tinyconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-04081501
x86_64                           allmodconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                 randconfig-x010-201714
x86_64                 randconfig-x011-201714
x86_64                 randconfig-x012-201714
x86_64                 randconfig-x013-201714
x86_64                 randconfig-x014-201714
x86_64                 randconfig-x015-201714
x86_64                 randconfig-x016-201714
x86_64                 randconfig-x017-201714
x86_64                 randconfig-x018-201714
x86_64                 randconfig-x019-201714
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
i386                     randconfig-s0-201714
i386                     randconfig-s1-201714
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
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
x86_64                   randconfig-i0-201714
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201714
i386                     randconfig-i1-201714
i386                             allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
arm                      jornada720_defconfig
powerpc                     mpc5200_defconfig
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
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201714
i386                   randconfig-h0-04081204
i386                   randconfig-h1-04081204
cris                    etrax-100lx_defconfig
mips                       bmips_be_defconfig
powerpc                 mpc8560_ads_defconfig
i386                             alldefconfig
m68k                       m5249evb_defconfig
x86_64                 randconfig-n0-04081645
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64                randconfig-ws0-04081221
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
i386                   randconfig-x070-201714
i386                   randconfig-x071-201714
i386                   randconfig-x072-201714
i386                   randconfig-x073-201714
i386                   randconfig-x074-201714
i386                   randconfig-x075-201714
i386                   randconfig-x076-201714
i386                   randconfig-x077-201714
i386                   randconfig-x078-201714
i386                   randconfig-x079-201714
i386                              allnoconfig
i386                                defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
c6x                        evmc6472_defconfig
powerpc                      walnut_defconfig
xtensa                generic_kc705_defconfig
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
