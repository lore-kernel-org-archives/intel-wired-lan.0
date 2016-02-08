From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 08 Feb 2016 20:28:31 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 d8c20444a8271b7bf525fdf3f8b31c7c3687f20e BUILD DONE
Message-ID: <56b889ef.U51M6klRX+Xhgh/b%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
d8c20444a8271b7bf525fdf3f8b31c7c3687f20e  fm10k: use fm10k_stats structures for per-queue statistics

drivers/net/ethernet/intel/i40e/i40e_txrx.c:2066:28: error: 'I40E_TX_FLAGS_TUNNEL' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? i386-randconfig-x000-201606
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? x86_64-randconfig-x004-201606
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)

elapsed time: 69m

configs tested: 102

i386                   randconfig-a0-02081837
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                           allmodconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
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
x86_64                 randconfig-x012-201606
x86_64                 randconfig-x014-201606
x86_64                 randconfig-x017-201606
x86_64                 randconfig-x011-201606
x86_64                 randconfig-x013-201606
x86_64                 randconfig-x019-201606
x86_64                 randconfig-x015-201606
x86_64                 randconfig-x010-201606
x86_64                 randconfig-x016-201606
x86_64                 randconfig-x018-201606
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                     randconfig-s0-201606
i386                     randconfig-s1-201606
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201606
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201606
i386                     randconfig-i1-201606
i386                               tinyconfig
i386                     randconfig-n0-201606
x86_64                                   rhel
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                 randconfig-x004-201606
x86_64                 randconfig-x002-201606
x86_64                 randconfig-x000-201606
x86_64                 randconfig-x009-201606
x86_64                 randconfig-x006-201606
x86_64                 randconfig-x003-201606
x86_64                 randconfig-x005-201606
x86_64                 randconfig-x001-201606
x86_64                 randconfig-x007-201606
x86_64                 randconfig-x008-201606
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-r0-201606
i386                             allmodconfig
i386                   randconfig-x001-201606
i386                   randconfig-x007-201606
i386                   randconfig-x004-201606
i386                   randconfig-x002-201606
i386                   randconfig-x008-201606
i386                   randconfig-x003-201606
i386                   randconfig-x006-201606
i386                   randconfig-x005-201606
i386                   randconfig-x009-201606
i386                   randconfig-x000-201606

Thanks,
Fengguang
