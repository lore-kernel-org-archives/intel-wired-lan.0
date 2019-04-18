From: kbuild test robot <lkp@intel.com>
Date: Fri, 19 Apr 2019 03:23:37 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:100GbE] BUILD REGRESSION
 711987bbad18e6d5fc5d8ff07c8991700e2ed1b6
Message-ID: <5cb8ceb9.4SrqTphU5vtoZxVZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  100GbE
branch HEAD: 711987bbad18e6d5fc5d8ff07c8991700e2ed1b6  ice: Calculate ITR increment based on direct calculation

Regressions in current branch:

ERROR: "__divdi3" [net/sched/sch_taprio.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? ERROR:__divdi3-net-sched-sch_taprio.ko-undefined
??? m68k-allmodconfig
??? ??? ERROR:__divdi3-net-sched-sch_taprio.ko-undefined
??? mips-allmodconfig
    ??? ERROR:__divdi3-net-sched-sch_taprio.ko-undefined

elapsed time: 203m

configs tested: 186

i386                   randconfig-x010-201915
i386                   randconfig-x018-201915
i386                   randconfig-x017-201915
i386                   randconfig-x013-201915
i386                   randconfig-x011-201915
i386                   randconfig-x014-201915
i386                   randconfig-x019-201915
i386                   randconfig-x015-201915
i386                   randconfig-x016-201915
i386                   randconfig-x012-201915
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n2-201915
i386                     randconfig-n3-201915
i386                     randconfig-n0-201915
i386                     randconfig-n1-201915
x86_64                 randconfig-x001-201915
x86_64                 randconfig-x004-201915
x86_64                 randconfig-x000-201915
x86_64                 randconfig-x003-201915
x86_64                 randconfig-x007-201915
x86_64                 randconfig-x008-201915
x86_64                 randconfig-x002-201915
x86_64                 randconfig-x006-201915
x86_64                 randconfig-x009-201915
x86_64                 randconfig-x005-201915
i386                     randconfig-i1-201915
i386                     randconfig-i0-201915
i386                     randconfig-i3-201915
i386                     randconfig-i2-201915
x86_64                           allyesconfig
i386                             allmodconfig
x86_64                 randconfig-x015-201915
x86_64                 randconfig-x016-201915
x86_64                 randconfig-x012-201915
x86_64                 randconfig-x017-201915
x86_64                 randconfig-x013-201915
x86_64                 randconfig-x018-201915
x86_64                 randconfig-x010-201915
x86_64                 randconfig-x014-201915
x86_64                 randconfig-x019-201915
x86_64                 randconfig-x011-201915
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
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
arm64                            alldefconfig
arm64                            allmodconfig
i386                     randconfig-a1-201915
i386                     randconfig-a2-201915
i386                     randconfig-a0-201915
i386                     randconfig-a3-201915
sh                      rts7751r2d1_defconfig
arm64                     tizen_tm2_defconfig
powerpc64                        allmodconfig
mips                  mips_paravirt_defconfig
powerpc                     tqm5200_defconfig
h8300                     edosk2674_defconfig
powerpc                      pcm030_defconfig
arm                          exynos_defconfig
c6x                         dsk6455_defconfig
alpha                            alldefconfig
arm                        oxnas_v6_defconfig
x86_64                 randconfig-u0-04190305
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
riscv                              tinyconfig
i386                               tinyconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
nds32                             allnoconfig
nds32                               defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                 randconfig-m0-04170939
i386                   randconfig-m2-04170939
i386                   randconfig-m1-04170939
i386                   randconfig-m3-04170939
i386                   randconfig-m0-04170939
x86_64                 randconfig-m2-04170939
x86_64                 randconfig-m1-04170939
x86_64                 randconfig-m3-04170939
riscv                             allnoconfig
riscv                               defconfig
i386                   randconfig-l2-04180125
x86_64                 randconfig-l2-04180125
x86_64                 randconfig-l0-04180125
x86_64                 randconfig-l1-04180125
i386                   randconfig-l0-04180125
i386                   randconfig-l1-04180125
x86_64                 randconfig-l3-04180125
i386                   randconfig-l3-04180125
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
x86_64                   randconfig-i1-201915
x86_64                   randconfig-i2-201915
x86_64                   randconfig-i3-201915
x86_64                   randconfig-i0-201915
x86_64                           allmodconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
x86_64                   randconfig-g0-201915
x86_64                   randconfig-g3-201915
x86_64                   randconfig-g2-201915
x86_64                   randconfig-g1-201915
i386                   randconfig-x002-201915
i386                   randconfig-x001-201915
i386                   randconfig-x005-201915
i386                   randconfig-x007-201915
i386                   randconfig-x000-201915
i386                   randconfig-x004-201915
i386                   randconfig-x008-201915
i386                   randconfig-x009-201915
i386                   randconfig-x006-201915
i386                   randconfig-x003-201915
i386                   randconfig-x077-201915
i386                   randconfig-x074-201915
i386                   randconfig-x070-201915
i386                   randconfig-x072-201915
i386                   randconfig-x075-201915
i386                   randconfig-x071-201915
i386                   randconfig-x079-201915
i386                   randconfig-x078-201915
i386                   randconfig-x073-201915
i386                   randconfig-x076-201915
i386                              allnoconfig
i386                                defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
