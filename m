From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 07 Apr 2016 18:38:38 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:master]
 de6099e27ef33086d7a967bbfce078952312b74d BUILD DONE
Message-ID: <570638ae.iIj2Pb13qQ5AGQNF%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  master
de6099e27ef33086d7a967bbfce078952312b74d  Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue

include/net/sock.h:442: warning: No description found for parameter 'sk_rcu'
net/ipv4/udp.c:1695:9: sparse: incompatible types in comparison expression (different address spaces)
net/ipv6/udp.c:745:9: sparse: incompatible types in comparison expression (different address spaces)

Error ids grouped by kconfigs:

recent_errors
??? i386-allnoconfig
??? ??? include-net-sock.h:warning:No-description-found-for-parameter-sk_rcu
??? x86_64-allmodconfig
    ??? net-ipv4-udp.c:sparse:incompatible-types-in-comparison-expression-(different-address-spaces)
    ??? net-ipv6-udp.c:sparse:incompatible-types-in-comparison-expression-(different-address-spaces)

elapsed time: 386m

configs tested: 160

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                   randconfig-a0-04071131
i386                     randconfig-a0-201614
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
i386                   randconfig-c0-04071800
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
i386                             allyesconfig
parisc                         b180_defconfig
i386                             allmodconfig
x86_64               randconfig-x010-04071300
x86_64               randconfig-x011-04071300
x86_64               randconfig-x012-04071300
x86_64               randconfig-x013-04071300
x86_64               randconfig-x014-04071300
x86_64               randconfig-x015-04071300
x86_64               randconfig-x016-04071300
x86_64               randconfig-x017-04071300
x86_64               randconfig-x018-04071300
x86_64               randconfig-x019-04071300
x86_64                 randconfig-x010-201614
x86_64                 randconfig-x018-201614
x86_64                 randconfig-x011-201614
x86_64                 randconfig-x013-201614
x86_64                 randconfig-x012-201614
x86_64                 randconfig-x019-201614
x86_64                 randconfig-x014-201614
x86_64                 randconfig-x016-201614
x86_64                 randconfig-x015-201614
x86_64                 randconfig-x017-201614
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s0-04071300
i386                   randconfig-s1-04071300
i386                     randconfig-s1-201614
i386                     randconfig-s0-201614
x86_64                 randconfig-s3-04071806
x86_64                 randconfig-s4-04071806
x86_64                 randconfig-s5-04071806
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
i386                               tinyconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201614
i386                   randconfig-b0-04071747
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-04071148
i386                   randconfig-i1-04071148
i386                     randconfig-i1-201614
i386                     randconfig-i0-201614
x86_64                 randconfig-b0-04071715
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
sparc                       sparc32_defconfig
x86_64                              rhel_gcov
x86_64                 randconfig-n0-04071800
i386                 randconfig-x014-04071153
i386                 randconfig-x018-04071153
i386                 randconfig-x019-04071153
i386                 randconfig-x010-04071153
i386                 randconfig-x015-04071153
i386                 randconfig-x016-04071153
i386                 randconfig-x012-04071153
i386                 randconfig-x017-04071153
i386                 randconfig-x011-04071153
i386                 randconfig-x013-04071153
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
x86_64                                    lkp
x86_64                                   rhel
i386                   randconfig-n0-04071153
i386                     randconfig-n0-201614
x86_64                 randconfig-x000-201614
x86_64                 randconfig-x001-201614
x86_64                 randconfig-x007-201614
x86_64                 randconfig-x005-201614
x86_64                 randconfig-x006-201614
x86_64                 randconfig-x004-201614
x86_64                 randconfig-x008-201614
x86_64                 randconfig-x009-201614
x86_64                 randconfig-x003-201614
x86_64                 randconfig-x002-201614
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-r0-201614
i386                 randconfig-x000-04071149
i386                 randconfig-x001-04071149
i386                 randconfig-x002-04071149
i386                 randconfig-x003-04071149
i386                 randconfig-x004-04071149
i386                 randconfig-x005-04071149
i386                 randconfig-x006-04071149
i386                 randconfig-x007-04071149
i386                 randconfig-x008-04071149
i386                 randconfig-x009-04071149
i386                   randconfig-x000-201614
i386                   randconfig-x003-201614
i386                   randconfig-x009-201614
i386                   randconfig-x005-201614
i386                   randconfig-x004-201614
i386                   randconfig-x002-201614
i386                   randconfig-x006-201614
i386                   randconfig-x007-201614
i386                   randconfig-x008-201614
i386                   randconfig-x001-201614

Thanks,
Fengguang
