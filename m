From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 04 Apr 2017 17:03:34 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 b9aa51409b21ff3e9b24506a6a2de529da0a95e4
Message-ID: <58e36166.tiiuarIlKQzTF445%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
b9aa51409b21ff3e9b24506a6a2de529da0a95e4  ixgbevf: fix size of queue stats length

drivers/net/ethernet/intel/i40e/i40e_main.c:11335:15: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_main.c:11336:3: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:1337:8: error: 'struct sk_buff' has no member named 'offload_fwd_mark'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:36: error: 'size' undeclared (first use in this function)
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:5: error: 'size' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
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
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
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
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function

elapsed time: 86m

configs tested: 140

i386                     randconfig-a0-201714
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                               tinyconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
mips                           ip32_defconfig
mips                        jmr3927_defconfig
mips                      pistachio_defconfig
powerpc                          alldefconfig
powerpc                      pmac32_defconfig
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
x86_64                                   rhel
x86_64                               rhel-7.2
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201714
i386                     randconfig-s1-201714
x86_64                 randconfig-s3-04041540
x86_64                 randconfig-s4-04041540
x86_64                 randconfig-s5-04041540
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201714
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201714
i386                     randconfig-i1-201714
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
i386                   randconfig-h0-04041442
i386                   randconfig-h1-04041442
microblaze                       allyesconfig
mips                           jazz_defconfig
powerpc                     sbc8548_defconfig
cris                             alldefconfig
sh                        sh7763rdp_defconfig
x86_64                 randconfig-n0-04041626
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
i386                     randconfig-r0-201714
i386                             allmodconfig
i386                   randconfig-x000-201714
i386                   randconfig-x001-201714
i386                   randconfig-x002-201714
i386                   randconfig-x003-201714
i386                   randconfig-x004-201714
i386                   randconfig-x005-201714
i386                   randconfig-x006-201714
i386                   randconfig-x007-201714
i386                   randconfig-x008-201714
i386                   randconfig-x009-201714
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig

Thanks,
Fengguang
