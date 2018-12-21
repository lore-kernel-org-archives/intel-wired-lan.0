From: kbuild test robot <lkp@intel.com>
Date: Fri, 21 Dec 2018 13:12:58 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 f0a7c282ace3f62efcc51d309a8426468ba5aa63
Message-ID: <5c1c765a.15a73ppYsdPEt3vw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: f0a7c282ace3f62efcc51d309a8426468ba5aa63  i40e: update version number

TIMEOUT after 606m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 135

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                                defconfig
powerpc                     asp8347_defconfig
x86_64                 randconfig-a0-12210306
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
microblaze                       allmodconfig
mips                        bcm47xx_defconfig
i386                   randconfig-x010-201850
i386                   randconfig-x011-201850
i386                   randconfig-x012-201850
i386                   randconfig-x013-201850
i386                   randconfig-x014-201850
i386                   randconfig-x015-201850
i386                   randconfig-x016-201850
i386                   randconfig-x017-201850
i386                   randconfig-x018-201850
i386                   randconfig-x019-201850
nds32                             allnoconfig
nds32                               defconfig
riscv                             allnoconfig
riscv                               defconfig
microblaze                    nommu_defconfig
powerpc                      bamboo_defconfig
x86_64                 randconfig-g0-12210347
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                   randconfig-x008-201850
i386                   randconfig-x002-201850
i386                   randconfig-x006-201850
i386                   randconfig-x001-201850
i386                   randconfig-x000-201850
i386                   randconfig-x004-201850
i386                   randconfig-x009-201850
i386                   randconfig-x003-201850
i386                   randconfig-x005-201850
i386                   randconfig-x007-201850
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                 randconfig-s0-12210316
x86_64                 randconfig-s1-12210316
x86_64                 randconfig-s2-12210316
arm                              allyesconfig
arm                          imote2_defconfig
mips                          rm200_defconfig
xtensa                       common_defconfig
x86_64                 randconfig-x010-201850
x86_64                 randconfig-x011-201850
x86_64                 randconfig-x012-201850
x86_64                 randconfig-x013-201850
x86_64                 randconfig-x014-201850
x86_64                 randconfig-x015-201850
x86_64                 randconfig-x016-201850
x86_64                 randconfig-x017-201850
x86_64                 randconfig-x018-201850
x86_64                 randconfig-x019-201850
i386                             alldefconfig
i386                              allnoconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-s3-12210318
x86_64                 randconfig-s4-12210318
x86_64                 randconfig-s5-12210318
i386                             allmodconfig
arm                          nuc960_defconfig
mips                      malta_kvm_defconfig
powerpc                      mgcoge_defconfig
i386                   randconfig-b0-12210346
arm                          pxa3xx_defconfig
mips                            ar7_defconfig
powerpc64                        allmodconfig
microblaze                      mmu_defconfig
x86_64                 randconfig-b0-12210321
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
ia64                          tiger_defconfig
powerpc                 xes_mpc85xx_defconfig
x86_64                 randconfig-u0-12210304
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
arm                      jornada720_defconfig
x86_64                randconfig-ne0-12210208
riscv                              tinyconfig
i386                               tinyconfig
i386                   randconfig-x070-201850
i386                   randconfig-x071-201850
i386                   randconfig-x072-201850
i386                   randconfig-x073-201850
i386                   randconfig-x074-201850
i386                   randconfig-x075-201850
i386                   randconfig-x076-201850
i386                   randconfig-x077-201850
i386                   randconfig-x078-201850
i386                   randconfig-x079-201850
xtensa                              defconfig
i386                  randconfig-sb0-12210314
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                 randconfig-x000-201850
x86_64                 randconfig-x001-201850
x86_64                 randconfig-x002-201850
x86_64                 randconfig-x003-201850
x86_64                 randconfig-x004-201850
x86_64                 randconfig-x005-201850
x86_64                 randconfig-x006-201850
x86_64                 randconfig-x007-201850
x86_64                 randconfig-x008-201850
x86_64                 randconfig-x009-201850
arm                        mvebu_v7_defconfig
sh                           se7343_defconfig
x86_64                 randconfig-r0-12210345
powerpc               mpc85xx_basic_defconfig
sh                          r7785rp_defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
