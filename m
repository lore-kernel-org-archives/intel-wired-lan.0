From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 19 Feb 2016 02:19:11 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:master]
 7e6e18fbc033e00a4d4af3d4ea7bad0db6b7ad1b BUILD DONE
Message-ID: <56c60b1f.89ugI6ub8LpMp3NC%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  master
7e6e18fbc033e00a4d4af3d4ea7bad0db6b7ad1b  net_sched: Improve readability of filter processing

drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c:223:39: error: 'DCBX_APP_SF_DEFAULT' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? powerpc-defconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_dcb.c:error:DCBX_APP_SF_DEFAULT-undeclared-(first-use-in-this-function)
??? powerpc-ppc64_defconfig
    ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_dcb.c:error:DCBX_APP_SF_DEFAULT-undeclared-(first-use-in-this-function)

elapsed time: 107m

configs tested: 104

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201607
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                         b180_defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                             allmodconfig
x86_64                 randconfig-x012-201607
x86_64                 randconfig-x014-201607
x86_64                 randconfig-x017-201607
x86_64                 randconfig-x011-201607
x86_64                 randconfig-x013-201607
x86_64                 randconfig-x019-201607
x86_64                 randconfig-x015-201607
x86_64                 randconfig-x010-201607
x86_64                 randconfig-x016-201607
x86_64                 randconfig-x018-201607
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201607
i386                     randconfig-s1-201607
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201607
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201607
i386                     randconfig-i1-201607
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201607
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
x86_64                 randconfig-x004-201607
x86_64                 randconfig-x002-201607
x86_64                 randconfig-x000-201607
x86_64                 randconfig-x009-201607
x86_64                 randconfig-x006-201607
x86_64                 randconfig-x003-201607
x86_64                 randconfig-x005-201607
x86_64                 randconfig-x001-201607
x86_64                 randconfig-x007-201607
x86_64                 randconfig-x008-201607
x86_64         rhel+CONFIG_DEBUG_INFO_REDUCED
i386                     randconfig-r0-201607
i386                   randconfig-x001-201607
i386                   randconfig-x007-201607
i386                   randconfig-x004-201607
i386                   randconfig-x002-201607
i386                   randconfig-x008-201607
i386                   randconfig-x003-201607
i386                   randconfig-x006-201607
i386                   randconfig-x005-201607
i386                   randconfig-x009-201607
i386                   randconfig-x000-201607

Thanks,
Fengguang
