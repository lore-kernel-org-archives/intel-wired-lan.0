From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 31 Mar 2017 00:29:46 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 611576e4d243e7f03e7cf5f14546474cad90cfb0
Message-ID: <58dd327a.EP+lunFLRuOi6TXq%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
611576e4d243e7f03e7cf5f14546474cad90cfb0  ixgbe: clean macvlan MAC filter table on VF reset

drivers/net/ethernet/intel/i40e/i40e_main.c:11336:3: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_main.c:11343:15: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_main.c:11344:3: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:1337:8: error: 'struct sk_buff' has no member named 'offload_fwd_mark'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:36: error: 'size' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? i386-randconfig-s0-201713
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? x86_64-randconfig-r0-03302107
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? x86_64-randconfig-s0-03301852
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
??? x86_64-rhel-7.2
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:vf-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark

elapsed time: 78m

configs tested: 154

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201713
x86_64                 randconfig-a0-03302321
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-v0-03302004
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                             allmodconfig
x86_64                 randconfig-x010-201713
x86_64                 randconfig-x011-201713
x86_64                 randconfig-x012-201713
x86_64                 randconfig-x013-201713
x86_64                 randconfig-x014-201713
x86_64                 randconfig-x015-201713
x86_64                 randconfig-x016-201713
x86_64                 randconfig-x017-201713
x86_64                 randconfig-x018-201713
x86_64                 randconfig-x019-201713
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201713
i386                     randconfig-s1-201713
x86_64                 randconfig-s0-03301852
x86_64                 randconfig-s1-03301852
x86_64                 randconfig-s2-03301852
x86_64                 randconfig-s3-03301743
x86_64                 randconfig-s4-03301743
x86_64                 randconfig-s5-03301743
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201713
i386                   randconfig-b0-03302031
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-03270128
i386                   randconfig-i1-03270128
x86_64                 randconfig-b0-03301753
x86_64                           allmodconfig
arm                            zeus_defconfig
ia64                         bigsur_defconfig
mips                  mips_paravirt_defconfig
x86_64                 randconfig-u0-03301900
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
x86_64                randconfig-ne0-03302030
i386                   randconfig-x010-201713
i386                   randconfig-x011-201713
i386                   randconfig-x012-201713
i386                   randconfig-x013-201713
i386                   randconfig-x014-201713
i386                   randconfig-x015-201713
i386                   randconfig-x016-201713
i386                   randconfig-x017-201713
i386                   randconfig-x018-201713
i386                   randconfig-x019-201713
i386                   randconfig-h0-03302209
i386                   randconfig-h1-03302209
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                   rhel
x86_64                               rhel-7.2
m32r                                defconfig
m68k                        m5307c3_defconfig
i386                   randconfig-x070-201713
i386                   randconfig-x071-201713
i386                   randconfig-x072-201713
i386                   randconfig-x073-201713
i386                   randconfig-x074-201713
i386                   randconfig-x075-201713
i386                   randconfig-x076-201713
i386                   randconfig-x077-201713
i386                   randconfig-x078-201713
i386                   randconfig-x079-201713
x86_64                                  kexec
i386                  randconfig-sb0-03302044
x86_64                 randconfig-x000-201713
x86_64                 randconfig-x001-201713
x86_64                 randconfig-x002-201713
x86_64                 randconfig-x003-201713
x86_64                 randconfig-x004-201713
x86_64                 randconfig-x005-201713
x86_64                 randconfig-x006-201713
x86_64                 randconfig-x007-201713
x86_64                 randconfig-x008-201713
x86_64                 randconfig-x009-201713
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
i386                     randconfig-r0-201713
x86_64                 randconfig-r0-03302107
i386                   randconfig-x002-201713
i386                   randconfig-x005-201713
i386                   randconfig-x006-201713
i386                   randconfig-x003-201713
i386                   randconfig-x007-201713
i386                   randconfig-x008-201713
i386                   randconfig-x001-201713
i386                   randconfig-x000-201713
i386                   randconfig-x004-201713
i386                   randconfig-x009-201713

Thanks,
Fengguang
