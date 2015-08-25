From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 25 Aug 2015 10:44:32 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 34622407e301a32926e601ffdf0ff1f85ede266a BUILD DONE
Message-ID: <55dbd690.7aHveEWTnjLseMHZ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
34622407e301a32926e601ffdf0ff1f85ede266a  Subject: [4/4] i40e: geneve tunnel offload support

include/net/vxlan.h:246:30: error: redefinition of 'vxlan_get_sk_family'

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? include-net-vxlan.h:error:redefinition-of-vxlan_get_sk_family
??? i386-allmodconfig
??? ??? include-net-vxlan.h:error:redefinition-of-vxlan_get_sk_family
??? ia64-allyesconfig
??? ??? include-net-vxlan.h:error:redefinition-of-vxlan_get_sk_family
??? parisc-allyesconfig
??? ??? include-net-vxlan.h:error:redefinition-of-vxlan_get_sk_family
??? powerpc-allyesconfig
??? ??? include-net-vxlan.h:error:redefinition-of-vxlan_get_sk_family
??? s390-allyesconfig
??? ??? include-net-vxlan.h:error:redefinition-of-vxlan_get_sk_family
??? sparc64-allyesconfig
??? ??? include-net-vxlan.h:error:redefinition-of-vxlan_get_sk_family
??? sparc-allyesconfig
??? ??? include-net-vxlan.h:error:redefinition-of-vxlan_get_sk_family
??? tile-allyesconfig
??? ??? include-net-vxlan.h:error:redefinition-of-vxlan_get_sk_family
??? x86_64-allmodconfig
??? ??? include-net-vxlan.h:error:redefinition-of-vxlan_get_sk_family
??? x86_64-allyesconfig
??? ??? include-net-vxlan.h:error:redefinition-of-vxlan_get_sk_family
??? xtensa-allyesconfig
    ??? include-net-vxlan.h:error:redefinition-of-vxlan_get_sk_family

elapsed time: 79m

configs tested: 95

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                     randconfig-a0-201534
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                            allnoconfig
arm                                    sa1100
arm                          prima2_defconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                       spear13xx_defconfig
arm                                  iop-adma
arm                       imx_v6_v7_defconfig
arm                          marzen_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201534
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201534
i386                     randconfig-i0-201534
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
i386                     randconfig-n1-201534
i386                     randconfig-n0-201534
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                                   rhel
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                 randconfig-x004-201534
x86_64                 randconfig-x001-201534
x86_64                 randconfig-x000-201534
x86_64                 randconfig-x006-201534
x86_64                 randconfig-x003-201534
x86_64                 randconfig-x002-201534
x86_64                 randconfig-x005-201534
x86_64                 randconfig-x009-201534
x86_64                 randconfig-x007-201534
x86_64                 randconfig-x008-201534
i386                     randconfig-r0-201534
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
i386                   randconfig-x000-201534
i386                   randconfig-x001-201534
i386                   randconfig-x008-201534
i386                   randconfig-x004-201534
i386                   randconfig-x007-201534
i386                   randconfig-x005-201534
i386                   randconfig-x003-201534
i386                   randconfig-x002-201534
i386                   randconfig-x009-201534
i386                   randconfig-x006-201534
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
