From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 15 Apr 2017 12:22:02 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 4dfa5bad7d4bbb8ed2cd3e9068c3b063c68ec21b
Message-ID: <58f19fea.diT7gFmrOpo67YSf%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
4dfa5bad7d4bbb8ed2cd3e9068c3b063c68ec21b  ixgbevf: Check for RSS key before setting value

drivers/net/ethernet/intel/i40e/i40e_main.c:11437:15: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_main.c:11438:3: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:1376:8: error: 'struct sk_buff' has no member named 'offload_fwd_mark'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2173:36: error: 'size' undeclared (first use in this function)
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2173:5: error: 'size' undeclared (first use in this function)

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
??? x86_64-randconfig-u0-04151012
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? x86_64-rhel-7.2+CONFIG_DEBUG_INFO_REDUCED
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? xtensa-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function

elapsed time: 118m

configs tested: 195

i386                              allnoconfig
arm                        multi_v7_defconfig
sparc                             allnoconfig
i386                   randconfig-a0-04150017
x86_64                 randconfig-a0-04150906
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      obs600_defconfig
powerpc64                        allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-04150850
x86_64                           allmodconfig
arm                        mvebu_v7_defconfig
m32r                           usrv_defconfig
m68k                          sun3x_defconfig
x86_64                randconfig-in0-04142223
powerpc                     redwood_defconfig
powerpc                     sequoia_defconfig
x86_64                randconfig-it0-04142105
blackfin                      H8606_defconfig
sh                               alldefconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64       rhel-7.2+CONFIG_DEBUG_INFO_REDUCED
x86_64                 randconfig-g0-04150903
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64       nfsroot+CONFIG_DEBUG_INFO_REDUCED
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
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
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201715
i386                     randconfig-s1-201715
x86_64                 randconfig-s0-04150904
x86_64                 randconfig-s1-04150904
x86_64                 randconfig-s2-04150904
x86_64                 randconfig-s3-04150948
x86_64                 randconfig-s4-04150948
x86_64                 randconfig-s5-04150948
x86_64                              defconfig
blackfin                  CM-BF537U_defconfig
mips                       markeins_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-i0-04150024
i386                   randconfig-b0-04150806
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         cm_x2xx_defconfig
arm                             mxs_defconfig
powerpc                 mpc832x_mds_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-04150024
i386                   randconfig-i1-04150024
x86_64                 randconfig-b0-04151019
arm                             pxa_defconfig
blackfin                BF527-EZKIT_defconfig
xtensa                           allyesconfig
x86_64                 randconfig-u0-04151012
i386                               tinyconfig
arm                         lubbock_defconfig
s390                             allmodconfig
x86_64                randconfig-ne0-04151017
c6x                         dsk6455_defconfig
frv                               allnoconfig
mips                      pic32mzda_defconfig
sh                        sh7757lcr_defconfig
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
x86_64                                    lkp
i386                   randconfig-n0-04150026
i386                   randconfig-h0-04150459
i386                   randconfig-h1-04150459
arm                         hackkit_defconfig
cris                       artpec_3_defconfig
m68k                             allmodconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-h0-04150706
mips                                defconfig
sh                   sh7770_generic_defconfig
x86_64                 randconfig-n0-04150755
arm64                            alldefconfig
arm64                               defconfig
avr32                       favr-32_defconfig
i386                  randconfig-sb0-04150249
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
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
x86_64                 randconfig-x004-201715
x86_64                 randconfig-x009-201715
x86_64                 randconfig-x003-201715
x86_64                 randconfig-x008-201715
x86_64                 randconfig-x002-201715
x86_64                 randconfig-x007-201715
x86_64                 randconfig-x000-201715
x86_64                 randconfig-x005-201715
x86_64                 randconfig-x001-201715
x86_64                 randconfig-x006-201715
i386                   randconfig-r0-04150016
x86_64                 randconfig-r0-04150814
blackfin               BF518F-EZBRD_defconfig
sparc                            alldefconfig
um                                  defconfig
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
i386                                defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                   randconfig-x0-04151045

Thanks,
Fengguang
