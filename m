From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 11 Sep 2017 20:36:30 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 41b1c9748ccae5d2f00d6f9e4d723906641a8ec3
Message-ID: <59b6834e.Cqy5AooLwaVjdBk2%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
41b1c9748ccae5d2f00d6f9e4d723906641a8ec3  e1000e: changed some expensive calls of udelay to usleep_range

elapsed time: 166m

configs tested: 158

The following configs have been built successfully.
More configs may be tested in the coming days.

i386                               tinyconfig
i386                   randconfig-x019-201737
i386                   randconfig-x013-201737
i386                   randconfig-x012-201737
i386                   randconfig-x016-201737
i386                   randconfig-x018-201737
i386                   randconfig-x010-201737
i386                   randconfig-x011-201737
i386                   randconfig-x015-201737
i386                   randconfig-x014-201737
i386                   randconfig-x017-201737
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-n0-201737
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                             allmodconfig
x86_64                 randconfig-x016-201737
x86_64                 randconfig-x011-201737
x86_64                 randconfig-x012-201737
x86_64                 randconfig-x014-201737
x86_64                 randconfig-x019-201737
x86_64                 randconfig-x018-201737
x86_64                 randconfig-x013-201737
x86_64                 randconfig-x015-201737
x86_64                 randconfig-x010-201737
x86_64                 randconfig-x017-201737
arm                       omap2plus_defconfig
arm                                    sa1100
arm                              allmodconfig
arm                                   samsung
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm                                      arm5
arm64                            alldefconfig
arm                                        sh
arm                                     arm67
i386                   randconfig-a1-09110849
i386                   randconfig-a0-09110849
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                         palmz72_defconfig
arm                           spitz_defconfig
m68k                            mac_defconfig
mips                        workpad_defconfig
sh                           se7619_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                   randconfig-s0-09110217
i386                   randconfig-s1-09110217
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                         ebsa110_defconfig
ia64                          tiger_defconfig
powerpc                 mpc837x_mds_defconfig
x86_64                 randconfig-i0-09110900
i386                   randconfig-b0-09111925
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-i1-09110541
i386                   randconfig-i0-09110541
powerpc                 canyonlands_defconfig
cris                        etraxfs_defconfig
m32r                    mappi.nommu_defconfig
x86_64                randconfig-ne0-09111925
i386                   randconfig-x076-201737
i386                   randconfig-x075-201737
i386                   randconfig-x071-201737
i386                   randconfig-x070-201737
i386                   randconfig-x074-201737
i386                   randconfig-x079-201737
i386                   randconfig-x072-201737
i386                   randconfig-x073-201737
i386                   randconfig-x078-201737
i386                   randconfig-x077-201737
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                           allmodconfig
i386                   randconfig-x003-201737
i386                   randconfig-x000-201737
i386                   randconfig-x004-201737
i386                   randconfig-x009-201737
i386                   randconfig-x005-201737
i386                   randconfig-x001-201737
i386                   randconfig-x008-201737
i386                   randconfig-x007-201737
i386                   randconfig-x006-201737
i386                   randconfig-x002-201737
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-x001-201737
x86_64                 randconfig-x007-201737
x86_64                 randconfig-x000-201737
x86_64                 randconfig-x006-201737
x86_64                 randconfig-x003-201737
x86_64                 randconfig-x009-201737
x86_64                 randconfig-x004-201737
x86_64                 randconfig-x008-201737
x86_64                 randconfig-x005-201737
x86_64                 randconfig-x002-201737
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
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig

Thanks,
Fengguang
