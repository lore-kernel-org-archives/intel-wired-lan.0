From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 09 Dec 2015 04:12:50 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 95cb5886d6feb2a3306f13d0abc21f189db01c14 BUILD DONE
Message-ID: <566739c2.BnoOzyybhgXGWvMc%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
95cb5886d6feb2a3306f13d0abc21f189db01c14  i40e: Look up MAC address in Open Firmware or IDPROM

drivers/net/ethernet/intel/fm10k/fm10k_netdev.c:1195:1: warning: label 'err_mbx_irq' defined but not used [-Wunused-label]
drivers/net/ethernet/intel/fm10k/fm10k_netdev.c:1197:1: warning: label 'err_queueing_scheme' defined but not used [-Wunused-label]

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-fm10k-fm10k_netdev.c:warning:label-err_mbx_irq-defined-but-not-used
??? ??? drivers-net-ethernet-intel-fm10k-fm10k_netdev.c:warning:label-err_queueing_scheme-defined-but-not-used
??? i386-allyesconfig
??? ??? drivers-net-ethernet-intel-fm10k-fm10k_netdev.c:warning:label-err_mbx_irq-defined-but-not-used
??? ??? drivers-net-ethernet-intel-fm10k-fm10k_netdev.c:warning:label-err_queueing_scheme-defined-but-not-used
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-fm10k-fm10k_netdev.c:warning:label-err_mbx_irq-defined-but-not-used
??? ??? drivers-net-ethernet-intel-fm10k-fm10k_netdev.c:warning:label-err_queueing_scheme-defined-but-not-used
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-intel-fm10k-fm10k_netdev.c:warning:label-err_mbx_irq-defined-but-not-used
??? ??? drivers-net-ethernet-intel-fm10k-fm10k_netdev.c:warning:label-err_queueing_scheme-defined-but-not-used
??? x86_64-randconfig-x009-12070929
    ??? drivers-net-ethernet-intel-fm10k-fm10k_netdev.c:warning:label-err_mbx_irq-defined-but-not-used
    ??? drivers-net-ethernet-intel-fm10k-fm10k_netdev.c:warning:label-err_queueing_scheme-defined-but-not-used

elapsed time: 94m

configs tested: 112

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201549
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
parisc                         b180_defconfig
i386                             allmodconfig
x86_64                 randconfig-x014-201549
x86_64                 randconfig-x018-201549
x86_64                 randconfig-x016-201549
x86_64                 randconfig-x015-201549
x86_64                 randconfig-x019-201549
x86_64                 randconfig-x011-201549
x86_64                 randconfig-x017-201549
x86_64                 randconfig-x013-201549
x86_64                 randconfig-x010-201549
x86_64                 randconfig-x012-201549
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201549
i386                     randconfig-s1-201549
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                        neponset_defconfig
m32r                   mappi2.vdec2_defconfig
s390                       zfcpdump_defconfig
sh                           se7206_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201549
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201549
i386                     randconfig-i1-201549
i386                             allyesconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201549
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                       imx_v6_v7_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                          prima2_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                       spear13xx_defconfig
x86_64               randconfig-x008-12070929
x86_64               randconfig-x001-12070929
x86_64               randconfig-x006-12070929
x86_64               randconfig-x002-12070929
x86_64               randconfig-x000-12070929
x86_64               randconfig-x005-12070929
x86_64               randconfig-x007-12070929
x86_64               randconfig-x003-12070929
x86_64               randconfig-x004-12070929
x86_64               randconfig-x009-12070929
i386                     randconfig-r0-201549
i386                 randconfig-x008-12070758
i386                 randconfig-x006-12070758
i386                 randconfig-x002-12070758
i386                 randconfig-x001-12070758
i386                 randconfig-x000-12070758
i386                 randconfig-x009-12070758
i386                 randconfig-x004-12070758
i386                 randconfig-x003-12070758
i386                 randconfig-x007-12070758
i386                 randconfig-x005-12070758

Thanks,
Fengguang
