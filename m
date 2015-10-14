From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 14 Oct 2015 21:56:49 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 67bc86a2aa1ebfaee41644b460f2ec2a58916be1 BUILD DONE
Message-ID: <561e5f21.eXWvNSaC3CdY+ff/%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
67bc86a2aa1ebfaee41644b460f2ec2a58916be1  i40e: fix unconditional execution of cpu_to_le16()

drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]

Error ids grouped by kconfigs:

recent_errors
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? x86_64-rhel+CONFIG_DEBUG_INFO_REDUCED
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function

elapsed time: 469m

configs tested: 151

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201541
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                            allnoconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-10141504
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                 randconfig-v0-10141513
x86_64                 randconfig-v0-10141525
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                         b180_defconfig
i386                             allmodconfig
ia64                              allnoconfig
m32r                    m32700ut.up_defconfig
sh                          lboxre2_defconfig
um                                  defconfig
blackfin                  CM-BF537E_defconfig
powerpc                         c2k_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      ppc40x_defconfig
arm                           u8500_defconfig
arm                            xcep_defconfig
mips                                defconfig
s390                        default_defconfig
sh                             shx3_defconfig
arm                          pxa3xx_defconfig
arm                         s3c6400_defconfig
avr32                     atstk1002_defconfig
powerpc                      bamboo_defconfig
um                           x86_64_defconfig
m68k                          atari_defconfig
mips                    maltaup_xpa_defconfig
sh                           se7712_defconfig
xtensa                           alldefconfig
mips                             allyesconfig
mips                           ip32_defconfig
mips                          lasat_defconfig
mips                      malta_kvm_defconfig
x86_64               randconfig-x010-10130227
x86_64               randconfig-x011-10130227
x86_64               randconfig-x012-10130227
x86_64               randconfig-x013-10130227
x86_64               randconfig-x014-10130227
x86_64               randconfig-x015-10130227
x86_64               randconfig-x016-10130227
x86_64               randconfig-x017-10130227
x86_64               randconfig-x018-10130227
x86_64               randconfig-x019-10130227
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201541
i386                     randconfig-s1-201541
x86_64                 randconfig-s0-10141508
x86_64                 randconfig-s1-10141508
x86_64                 randconfig-s2-10141508
x86_64                 randconfig-s0-10141526
x86_64                 randconfig-s1-10141526
x86_64                 randconfig-s2-10141526
x86_64                 randconfig-s3-10141516
x86_64                 randconfig-s4-10141516
x86_64                 randconfig-s5-10141516
x86_64                 randconfig-s3-10141526
x86_64                 randconfig-s4-10141526
x86_64                 randconfig-s5-10141526
x86_64                 randconfig-s3-10142016
x86_64                 randconfig-s4-10142016
x86_64                 randconfig-s5-10142016
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
i386                   randconfig-b0-10141507
i386                   randconfig-b0-10141514
i386                   randconfig-b0-10141523
i386                   randconfig-b0-10141531
i386                   randconfig-b0-10141811
i386                   randconfig-b0-10141834
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201541
i386                     randconfig-i1-201541
i386                             allyesconfig
x86_64                 randconfig-b0-10141507
x86_64                 randconfig-b0-10141524
x86_64                           allmodconfig
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64         rhel+CONFIG_DEBUG_INFO_REDUCED
i386                   randconfig-h0-10141540
i386                   randconfig-h1-10141540
x86_64                 randconfig-h0-10141807
i386                  randconfig-sb0-10141547
i386                  randconfig-sb0-10141801
i386                  randconfig-sb0-10141844
ia64                             alldefconfig
ia64                                defconfig
i386                     randconfig-r0-201541
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
i386                   randconfig-x0-10141501

Thanks,
Fengguang
