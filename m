From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 08 Apr 2017 06:19:36 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 47b8a06cd94fd814098bbc3b6effabe47c0c8428
Message-ID: <58e81078.YP4/JkodPHzKulV5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
47b8a06cd94fd814098bbc3b6effabe47c0c8428  i40e/i40evf: Remove VF Rx csum offload for tunneled packets.

drivers/net/ethernet/intel/i40e/i40e_main.c:11369:15: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_main.c:11370:3: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
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
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? s390-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? xtensa-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function

elapsed time: 145m

configs tested: 163

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201714
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
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
m68k                            q40_defconfig
mips                     loongson1b_defconfig
sh                   secureedge5410_defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                 randconfig-g0-04080234
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
arm                     davinci_all_defconfig
m32r                              allnoconfig
sh                           se7619_defconfig
xtensa                           alldefconfig
i386                                defconfig
blackfin                            defconfig
cris                        etraxfs_defconfig
mips                           ip28_defconfig
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
i386                             alldefconfig
i386                              allnoconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201714
i386                     randconfig-s1-201714
x86_64                 randconfig-s0-04080500
x86_64                 randconfig-s1-04080500
x86_64                 randconfig-s2-04080500
x86_64                           allmodconfig
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
i386                   randconfig-b0-04080236
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201714
i386                     randconfig-i1-201714
mips                malta_qemu_32r6_defconfig
mips                           xway_defconfig
x86_64                randconfig-ne0-04080333
i386                               tinyconfig
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
i386                     randconfig-n0-201714
arm                            xcep_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                          hp300_defconfig
mips                           ci20_defconfig
tile                              allnoconfig
x86_64                               rhel-7.2
x86_64                 randconfig-h0-04080518
powerpc                     ep8248e_defconfig
x86_64                 randconfig-n0-04080309
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-x000-201714
x86_64                 randconfig-x001-201714
x86_64                 randconfig-x002-201714
x86_64                 randconfig-x003-201714
x86_64                 randconfig-x004-201714
x86_64                 randconfig-x005-201714
x86_64                 randconfig-x006-201714
x86_64                 randconfig-x007-201714
x86_64                 randconfig-x008-201714
x86_64                 randconfig-x009-201714
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
i386                   randconfig-x0-04080215

Thanks,
Fengguang
