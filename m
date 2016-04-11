From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 12 Apr 2016 06:01:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 179719a0dde51627fdb6a73ddcd43dfb7e3547ee BUILD DONE
Message-ID: <570c1ec7.oQi08A8MGR4Eu/Uu%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
179719a0dde51627fdb6a73ddcd43dfb7e3547ee  e1000e: Fix ptp time reset on network interruption

drivers/net/ethernet/intel/e1000e/netdev.c:7250:2: error: 'ret_val' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:ret_val-undeclared-(first-use-in-this-function)
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:ret_val-undeclared-(first-use-in-this-function)
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:ret_val-undeclared-(first-use-in-this-function)
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:ret_val-undeclared-(first-use-in-this-function)
??? xtensa-allmodconfig
    ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:ret_val-undeclared-(first-use-in-this-function)

elapsed time: 39m

configs tested: 114

i386                     randconfig-a0-201615
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
x86_64                 randconfig-x010-201615
x86_64                 randconfig-x018-201615
x86_64                 randconfig-x011-201615
x86_64                 randconfig-x013-201615
x86_64                 randconfig-x019-201615
x86_64                 randconfig-x012-201615
x86_64                 randconfig-x014-201615
x86_64                 randconfig-x016-201615
x86_64                 randconfig-x015-201615
x86_64                 randconfig-x017-201615
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201615
i386                     randconfig-s1-201615
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201615
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201615
i386                     randconfig-i1-201615
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                              rhel_gcov
i386                               tinyconfig
i386                   randconfig-x012-201615
i386                   randconfig-x013-201615
i386                   randconfig-x015-201615
i386                   randconfig-x019-201615
i386                   randconfig-x011-201615
i386                   randconfig-x018-201615
i386                   randconfig-x010-201615
i386                   randconfig-x016-201615
i386                   randconfig-x017-201615
i386                   randconfig-x014-201615
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201615
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
x86_64                           allmodconfig
x86_64                 randconfig-x000-201615
x86_64                 randconfig-x001-201615
x86_64                 randconfig-x007-201615
x86_64                 randconfig-x005-201615
x86_64                 randconfig-x006-201615
x86_64                 randconfig-x004-201615
x86_64                 randconfig-x008-201615
x86_64                 randconfig-x009-201615
x86_64                 randconfig-x003-201615
x86_64                 randconfig-x002-201615
i386                     randconfig-r0-201615
i386                   randconfig-x000-201615
i386                   randconfig-x003-201615
i386                   randconfig-x009-201615
i386                   randconfig-x005-201615
i386                   randconfig-x004-201615
i386                   randconfig-x002-201615
i386                   randconfig-x006-201615
i386                   randconfig-x007-201615
i386                   randconfig-x008-201615
i386                   randconfig-x001-201615

Thanks,
Fengguang
