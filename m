From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 12 Aug 2016 08:39:44 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 e0a2fe0395f105ef5032ef994c4ae55470d93011 BUILD DONE
Message-ID: <57ad1ad0./WGC0qnRpxB+6O/J%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
e0a2fe0395f105ef5032ef994c4ae55470d93011  Subject: [1/1,v3] net: i40e: use matching format identifiers Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,  Shannon Nelson <shannon.nelson@intel.com>, linux-kernel at vger.kernel.org,  John Ronciak <john.ronciak@intel.com>, intel-wired-lan at lists.osuosl.org,  netdev at vger.kernel.org, David Miller <davem@davemloft.net>

drivers/net/ethernet/intel/igb/igb_main.c:8457:20-24: ERROR: adapter is NULL but dereferenced.

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-igb-igb_main.c:ERROR:adapter-is-NULL-but-dereferenced.

elapsed time: 201m

configs tested: 134

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201632
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64       allyesdebian+CONFIG_DEBUG_INFO_REDUCED
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
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
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                         b180_defconfig
arm                          nuc960_defconfig
arm                            zeus_defconfig
sh                          sdk7780_defconfig
sparc                       sparc32_defconfig
arm                           acs5k_defconfig
arm                           stm32_defconfig
blackfin             BF527-TLL6527M_defconfig
m68k                            mac_defconfig
mips                       capcella_defconfig
x86_64                 randconfig-x013-201632
x86_64                 randconfig-x012-201632
x86_64                 randconfig-x015-201632
x86_64                 randconfig-x011-201632
x86_64                 randconfig-x014-201632
x86_64                 randconfig-x010-201632
x86_64                 randconfig-x017-201632
x86_64                 randconfig-x018-201632
x86_64                 randconfig-x016-201632
x86_64                 randconfig-x019-201632
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201632
i386                     randconfig-s1-201632
x86_64                 randconfig-s0-08120524
x86_64                 randconfig-s1-08120524
x86_64                 randconfig-s2-08120524
x86_64                 randconfig-s3-08120534
x86_64                 randconfig-s4-08120534
x86_64                 randconfig-s5-08120534
x86_64                 randconfig-s3-08120612
x86_64                 randconfig-s4-08120612
x86_64                 randconfig-s5-08120612
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201632
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201632
i386                     randconfig-i1-201632
i386                   randconfig-x010-201632
i386                   randconfig-x011-201632
i386                   randconfig-x012-201632
i386                   randconfig-x013-201632
i386                   randconfig-x014-201632
i386                   randconfig-x015-201632
i386                   randconfig-x016-201632
i386                   randconfig-x017-201632
i386                   randconfig-x018-201632
i386                   randconfig-x019-201632
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201632
x86_64                 randconfig-x002-201632
x86_64                 randconfig-x008-201632
x86_64                 randconfig-x009-201632
x86_64                 randconfig-x007-201632
x86_64                 randconfig-x003-201632
x86_64                 randconfig-x004-201632
x86_64                 randconfig-x005-201632
x86_64                 randconfig-x000-201632
x86_64                 randconfig-x001-201632
x86_64                 randconfig-x006-201632
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-r0-201632
i386                   randconfig-x000-201632
i386                   randconfig-x001-201632
i386                   randconfig-x002-201632
i386                   randconfig-x003-201632
i386                   randconfig-x004-201632
i386                   randconfig-x005-201632
i386                   randconfig-x006-201632
i386                   randconfig-x007-201632
i386                   randconfig-x008-201632
i386                   randconfig-x009-201632

Thanks,
Fengguang
