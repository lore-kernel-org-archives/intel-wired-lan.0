From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 27 Jul 2016 02:48:28 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 f694b9029f5afb5bfa03d09f1eef39a845c382ed BUILD DONE
Message-ID: <5797b07c.KP+fvNmzN87s39BT%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
f694b9029f5afb5bfa03d09f1eef39a845c382ed  e1000e: convert systim overflow check to use flags2

drivers/net/ethernet/intel/e1000e/ich8lan.c:5889:9: error: 'FLAGS2_CHECK_SYSTIM_OVERFLOW' undeclared here (not in a function)
drivers/net/ethernet/intel/e1000e/ich8lan.c:5889: error: 'FLAGS2_CHECK_SYSTIM_OVERFLOW' undeclared here (not in a function)

Error ids grouped by kconfigs:

recent_errors
??? arm64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? i386-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? i386-randconfig-s1-201630
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? parisc-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? s390-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? x86_64-acpi-redef
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? x86_64-allyesdebian
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? x86_64-lkp
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? x86_64-randconfig-s2-07270217
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? x86_64-randconfig-x011-201630
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)
??? xtensa-allmodconfig
    ??? drivers-net-ethernet-intel-e1000e-ich8lan.c:error:FLAGS2_CHECK_SYSTIM_OVERFLOW-undeclared-here-(not-in-a-function)

elapsed time: 63m

configs tested: 120

i386                     randconfig-a0-201630
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
x86_64                 randconfig-x012-201630
x86_64                 randconfig-x015-201630
x86_64                 randconfig-x013-201630
x86_64                 randconfig-x011-201630
x86_64                 randconfig-x014-201630
x86_64                 randconfig-x010-201630
x86_64                 randconfig-x017-201630
x86_64                 randconfig-x018-201630
x86_64                 randconfig-x016-201630
x86_64                 randconfig-x019-201630
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201630
i386                     randconfig-s1-201630
x86_64                 randconfig-s0-07270217
x86_64                 randconfig-s1-07270217
x86_64                 randconfig-s2-07270217
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
i386                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201630
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201630
i386                     randconfig-i1-201630
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                 randconfig-n0-07270035
i386                   randconfig-x016-201630
i386                   randconfig-x014-201630
i386                   randconfig-x010-201630
i386                   randconfig-x017-201630
i386                   randconfig-x018-201630
i386                   randconfig-x013-201630
i386                   randconfig-x012-201630
i386                   randconfig-x019-201630
i386                   randconfig-x015-201630
i386                   randconfig-x011-201630
i386                     randconfig-n0-201630
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
x86_64                 randconfig-x002-201630
x86_64                 randconfig-x009-201630
x86_64                 randconfig-x008-201630
x86_64                 randconfig-x007-201630
x86_64                 randconfig-x003-201630
x86_64                 randconfig-x004-201630
x86_64                 randconfig-x005-201630
x86_64                 randconfig-x001-201630
x86_64                 randconfig-x006-201630
x86_64                 randconfig-x000-201630
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-r0-201630
i386                   randconfig-x002-201630
i386                   randconfig-x009-201630
i386                   randconfig-x006-201630
i386                   randconfig-x001-201630
i386                   randconfig-x003-201630
i386                   randconfig-x008-201630
i386                   randconfig-x007-201630
i386                   randconfig-x000-201630
i386                   randconfig-x004-201630
i386                   randconfig-x005-201630

Thanks,
Fengguang
