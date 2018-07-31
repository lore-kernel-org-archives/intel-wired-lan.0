From: kbuild test robot <lkp@intel.com>
Date: Tue, 31 Jul 2018 16:42:36 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 b19e2275983c679ee67051d3f5307041956d1ecc
Message-ID: <5b6020fc.6bB7lULaStI8jg6G%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: b19e2275983c679ee67051d3f5307041956d1ecc  i40e/i40evf: remove redundant functions i40evf_aq_{set/get}_phy_register

TIMEOUT after 609m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 193

powerpc               mpc86xx_basic_defconfig
s390                    performance_defconfig
m68k                            mac_defconfig
mips                     loongson1c_defconfig
x86_64                 randconfig-a0-07311332
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
arm                      jornada720_defconfig
arm                         s3c6400_defconfig
m68k                          sun3x_defconfig
sh                          rsk7203_defconfig
i386                   randconfig-c0-07311258
i386                 randconfig-x010-07310844
i386                 randconfig-x011-07310844
i386                 randconfig-x012-07310844
i386                 randconfig-x013-07310844
i386                 randconfig-x014-07310844
i386                 randconfig-x015-07310844
i386                 randconfig-x016-07310844
i386                 randconfig-x017-07310844
i386                 randconfig-x018-07310844
i386                 randconfig-x019-07310844
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-n0-07310844
x86_64               randconfig-x000-07310845
x86_64               randconfig-x001-07310845
x86_64               randconfig-x002-07310845
x86_64               randconfig-x003-07310845
x86_64               randconfig-x004-07310845
x86_64               randconfig-x005-07310845
x86_64               randconfig-x006-07310845
x86_64               randconfig-x007-07310845
x86_64               randconfig-x008-07310845
x86_64               randconfig-x009-07310845
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                   randconfig-i0-07310845
i386                   randconfig-i1-07310845
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
mips                       rbtx49xx_defconfig
powerpc                    gamecube_defconfig
powerpc                      cm5200_defconfig
sh                ecovec24-romimage_defconfig
mips                        msp71xx_defconfig
powerpc                     ppa8548_defconfig
x86_64                 randconfig-v0-07311403
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
ia64                             allyesconfig
powerpc                 mpc8540_ads_defconfig
x86_64                 randconfig-g0-07311211
i386                             allmodconfig
x86_64               randconfig-x010-07310851
x86_64               randconfig-x011-07310851
x86_64               randconfig-x012-07310851
x86_64               randconfig-x013-07310851
x86_64               randconfig-x014-07310851
x86_64               randconfig-x015-07310851
x86_64               randconfig-x016-07310851
x86_64               randconfig-x017-07310851
x86_64               randconfig-x018-07310851
x86_64               randconfig-x019-07310851
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
i386                   randconfig-a0-07310851
i386                   randconfig-a1-07310851
x86_64                 randconfig-s0-07310851
x86_64                 randconfig-s1-07310851
x86_64                 randconfig-s2-07310851
x86_64                 randconfig-s0-07311446
x86_64                 randconfig-s1-07311446
x86_64                 randconfig-s2-07311446
x86_64                 randconfig-s0-07311611
x86_64                 randconfig-s1-07311611
x86_64                 randconfig-s2-07311611
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
c6x                         dsk6455_defconfig
microblaze                       allmodconfig
mips                malta_kvm_guest_defconfig
powerpc                     asp8347_defconfig
powerpc                       eiger_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     rainier_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64                              fedora-25
x86_64                                   rhel
x86_64                               rhel-7.2
i386                   randconfig-s0-07310852
i386                   randconfig-s1-07310852
x86_64                 randconfig-s3-07311416
x86_64                 randconfig-s4-07311416
x86_64                 randconfig-s5-07311416
x86_64                 randconfig-i0-07310839
mips                        omega2p_defconfig
powerpc                     powernv_defconfig
xtensa                           alldefconfig
x86_64                 randconfig-b0-07311107
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
powerpc                      pmac32_defconfig
xtensa                    smp_lx200_defconfig
x86_64                 randconfig-u0-07311521
mips                      maltaaprp_defconfig
powerpc                     mpc5200_defconfig
mips                       markeins_defconfig
x86_64                randconfig-ne0-07311309
ia64                                defconfig
mips                                defconfig
ia64                              allnoconfig
powerpc                 mpc836x_mds_defconfig
ia64                             alldefconfig
x86_64                 randconfig-h0-07310840
x86_64                 randconfig-h0-07311112
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                  randconfig-sb0-07310931
x86_64                           allmodconfig
i386                 randconfig-x000-07310854
i386                 randconfig-x001-07310854
i386                 randconfig-x002-07310854
i386                 randconfig-x003-07310854
i386                 randconfig-x004-07310854
i386                 randconfig-x005-07310854
i386                 randconfig-x006-07310854
i386                 randconfig-x007-07310854
i386                 randconfig-x008-07310854
i386                 randconfig-x009-07310854
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
arm                  colibri_pxa270_defconfig
arm                         lpc18xx_defconfig
i386                 randconfig-x070-07310845
i386                 randconfig-x071-07310845
i386                 randconfig-x072-07310845
i386                 randconfig-x073-07310845
i386                 randconfig-x074-07310845
i386                 randconfig-x075-07310845
i386                 randconfig-x076-07310845
i386                 randconfig-x077-07310845
i386                 randconfig-x078-07310845
i386                 randconfig-x079-07310845
powerpc                   bluestone_defconfig
powerpc               mpc834x_itxgp_defconfig
x86_64                                  kexec
i386                   randconfig-x0-07311106

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
