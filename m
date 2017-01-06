From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 07 Jan 2017 05:03:59 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 95e7fea4a31500cf82efff684e242990951c2d8e
Message-ID: <5870063f.XSlDmJ4v6ifvllYX%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
95e7fea4a31500cf82efff684e242990951c2d8e  ixgbe: Add function for checking to see if we can reuse page

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:1955:46: error: 'rx_ring' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:rx_ring-undeclared-(first-use-in-this-function)
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:rx_ring-undeclared-(first-use-in-this-function)
??? ia64-allyesconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:rx_ring-undeclared-(first-use-in-this-function)

elapsed time: 257m

configs tested: 142

i386                     randconfig-a0-201701
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
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
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
m68k                        m5407c3_defconfig
powerpc                      walnut_defconfig
sh                        apsh4ad0a_defconfig
x86_64                 randconfig-g0-01070243
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
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
x86_64                 randconfig-x010-201701
x86_64                 randconfig-x011-201701
x86_64                 randconfig-x012-201701
x86_64                 randconfig-x013-201701
x86_64                 randconfig-x014-201701
x86_64                 randconfig-x015-201701
x86_64                 randconfig-x016-201701
x86_64                 randconfig-x017-201701
x86_64                 randconfig-x018-201701
x86_64                 randconfig-x019-201701
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201701
i386                     randconfig-s1-201701
x86_64                 randconfig-s0-01070350
x86_64                 randconfig-s1-01070350
x86_64                 randconfig-s2-01070350
i386                             allmodconfig
x86_64                   randconfig-i0-201701
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201701
i386                     randconfig-i1-201701
arm                          iop32x_defconfig
x86_64                randconfig-ne0-01070315
x86_64                randconfig-ne0-01070339
i386                               tinyconfig
powerpc               ps3_petitboot_defconfig
powerpc                     sbc8548_defconfig
powerpc                      virtex_defconfig
sh                            shmin_defconfig
i386                   randconfig-x011-201701
i386                   randconfig-x018-201701
i386                   randconfig-x015-201701
i386                   randconfig-x017-201701
i386                   randconfig-x012-201701
i386                   randconfig-x014-201701
i386                   randconfig-x013-201701
i386                   randconfig-x010-201701
i386                   randconfig-x019-201701
i386                   randconfig-x016-201701
i386                     randconfig-n0-201701
i386                   randconfig-h0-01070213
i386                   randconfig-h1-01070213
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                   rhel
x86_64                               rhel-7.2
sh                           se7343_defconfig
xtensa                  cadence_csp_defconfig
x86_64                                  kexec
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
x86_64                 randconfig-x008-201701
x86_64                 randconfig-x001-201701
x86_64                 randconfig-x009-201701
x86_64                 randconfig-x000-201701
x86_64                 randconfig-x003-201701
x86_64                 randconfig-x006-201701
x86_64                 randconfig-x002-201701
x86_64                 randconfig-x004-201701
x86_64                 randconfig-x007-201701
x86_64                 randconfig-x005-201701
i386                     randconfig-r0-201701
i386                   randconfig-x000-201701
i386                   randconfig-x001-201701
i386                   randconfig-x002-201701
i386                   randconfig-x003-201701
i386                   randconfig-x004-201701
i386                   randconfig-x005-201701
i386                   randconfig-x006-201701
i386                   randconfig-x007-201701
i386                   randconfig-x008-201701
i386                   randconfig-x009-201701
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9

Thanks,
Fengguang
