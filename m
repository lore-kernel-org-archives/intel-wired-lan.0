From: kbuild test robot <lkp@intel.com>
Date: Tue, 03 Jul 2018 08:04:31 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 5e0ee95a23fdff87fa9e34ceae2ed973879e4ec4
Message-ID: <5b3abd8f.Jr5zy35bfWmVo31v%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 5e0ee95a23fdff87fa9e34ceae2ed973879e4ec4  ixgbe: Be more careful when modifying MAC filters

TIMEOUT after 605m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 23

alpha                            allmodconfig
alpha                            allyesconfig
i386                               tinyconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sh                               allyesconfig
sparc                            allmodconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
x86_64                           allyesconfig
x86_64                          randconfig-i0
xtensa                           allmodconfig

configs tested: 187

sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-x016-201826
i386                   randconfig-x014-201826
i386                   randconfig-x017-201826
i386                   randconfig-x012-201826
i386                   randconfig-x018-201826
i386                   randconfig-x011-201826
i386                   randconfig-x013-201826
i386                   randconfig-x019-201826
i386                   randconfig-x015-201826
i386                   randconfig-x010-201826
x86_64                              fedora-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201826
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201826
i386                     randconfig-i1-201826
arm                            xcep_defconfig
powerpc                     stx_gp3_defconfig
x86_64                 randconfig-v0-07021353
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
sh                          kfr2r09_defconfig
xtensa                           allyesconfig
x86_64                 randconfig-g0-07021349
x86_64                 randconfig-g0-07030011
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
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
i386                     randconfig-a0-201826
i386                     randconfig-a1-201826
x86_64                 randconfig-s0-07021744
x86_64                 randconfig-s1-07021744
x86_64                 randconfig-s2-07021744
x86_64                 randconfig-s0-07022331
x86_64                 randconfig-s1-07022331
x86_64                 randconfig-s2-07022331
x86_64                 randconfig-s0-07030245
x86_64                 randconfig-s1-07030245
x86_64                 randconfig-s2-07030245
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                     asp8347_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                         microdev_defconfig
m68k                           sun3_defconfig
openrisc                         allmodconfig
arm                          moxart_defconfig
powerpc                      katmai_defconfig
sparc64                             defconfig
arm                         vf610m4_defconfig
mips                           ip22_defconfig
mips                      maltaaprp_defconfig
sh                        apsh4ad0a_defconfig
arm                              zx_defconfig
mips                      pic32mzda_defconfig
powerpc                     mpc83xx_defconfig
powerpc               mpc85xx_basic_defconfig
arm                         palmz72_defconfig
mips                  maltasmvp_eva_defconfig
arm                    vt8500_v6_v7_defconfig
sparc64                          alldefconfig
x86_64                 randconfig-x015-201826
x86_64                 randconfig-x011-201826
x86_64                 randconfig-x018-201826
x86_64                 randconfig-x010-201826
x86_64                 randconfig-x014-201826
x86_64                 randconfig-x019-201826
x86_64                 randconfig-x017-201826
x86_64                 randconfig-x016-201826
x86_64                 randconfig-x013-201826
x86_64                 randconfig-x012-201826
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
i386                     randconfig-s0-201826
i386                     randconfig-s1-201826
x86_64                           allmodconfig
x86_64                 randconfig-s3-07022124
x86_64                 randconfig-s4-07022124
x86_64                 randconfig-s5-07022124
x86_64                 randconfig-s3-07030008
x86_64                 randconfig-s4-07030008
x86_64                 randconfig-s5-07030008
microblaze                       allmodconfig
x86_64                 randconfig-u0-07022136
x86_64                 randconfig-u0-07022357
i386                   randconfig-h0-07020620
i386                   randconfig-h1-07020620
x86_64                randconfig-ne0-07021925
x86_64                 randconfig-h0-07020301
i386                   randconfig-x070-201826
i386                   randconfig-x071-201826
i386                   randconfig-x072-201826
i386                   randconfig-x073-201826
i386                   randconfig-x074-201826
i386                   randconfig-x075-201826
i386                   randconfig-x076-201826
i386                   randconfig-x077-201826
i386                   randconfig-x078-201826
i386                   randconfig-x079-201826
i386                   randconfig-x009-201826
i386                   randconfig-x008-201826
i386                   randconfig-x001-201826
i386                   randconfig-x003-201826
i386                   randconfig-x000-201826
i386                   randconfig-x005-201826
i386                   randconfig-x006-201826
i386                   randconfig-x004-201826
i386                   randconfig-x002-201826
i386                   randconfig-x007-201826
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
sparc                               defconfig
sparc64                           allnoconfig
x86_64                                  kexec
x86_64                randconfig-ws0-07021802
arm                       spear13xx_defconfig
sparc                            allyesconfig
x86_64                randconfig-ws0-07021730
arm64                            allyesconfig
sh                        edosk7760_defconfig
x86_64                 randconfig-x003-201826
x86_64                 randconfig-x007-201826
x86_64                 randconfig-x004-201826
x86_64                 randconfig-x005-201826
x86_64                 randconfig-x000-201826
x86_64                 randconfig-x001-201826
x86_64                 randconfig-x008-201826
x86_64                 randconfig-x006-201826
x86_64                 randconfig-x002-201826
x86_64                 randconfig-x009-201826
x86_64                 randconfig-r0-07021742
i386                   randconfig-x0-07021725

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
