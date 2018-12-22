From: kbuild test robot <lkp@intel.com>
Date: Sat, 22 Dec 2018 14:49:00 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 cfe722a26f45b8c030f88b5fc015ba068c268cd0
Message-ID: <5c1dde5c.5Tv8d06mAltkhLxE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: cfe722a26f45b8c030f88b5fc015ba068c268cd0  i40e: update version number

TIMEOUT after 609m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 149

sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
riscv                              tinyconfig
i386                               tinyconfig
i386                 randconfig-x012-12220509
i386                 randconfig-x011-12220509
i386                 randconfig-x019-12220509
i386                 randconfig-x010-12220509
i386                 randconfig-x015-12220509
i386                 randconfig-x017-12220509
i386                 randconfig-x014-12220509
i386                 randconfig-x013-12220509
i386                 randconfig-x016-12220509
i386                 randconfig-x018-12220509
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
nds32                             allnoconfig
nds32                               defconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                 randconfig-g0-12220306
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
i386                   randconfig-x000-201850
i386                   randconfig-x001-201850
i386                   randconfig-x002-201850
i386                   randconfig-x003-201850
i386                   randconfig-x004-201850
i386                   randconfig-x005-201850
i386                   randconfig-x006-201850
i386                   randconfig-x007-201850
i386                   randconfig-x008-201850
i386                   randconfig-x009-201850
arm                       omap2plus_defconfig
arm                              allmodconfig
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm64                            alldefconfig
sh                               allmodconfig
mips                           gcw0_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    sam440ep_defconfig
um                               allyesconfig
x86_64                 randconfig-x013-201850
x86_64                 randconfig-x011-201850
x86_64                 randconfig-x015-201850
x86_64                 randconfig-x019-201850
x86_64                 randconfig-x010-201850
x86_64                 randconfig-x016-201850
x86_64                 randconfig-x012-201850
x86_64                 randconfig-x018-201850
x86_64                 randconfig-x014-201850
x86_64                 randconfig-x017-201850
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-s3-12220445
x86_64                 randconfig-s4-12220445
x86_64                 randconfig-s5-12220445
i386                             allmodconfig
arm                          pxa168_defconfig
powerpc                     tqm8540_defconfig
sh                           sh2007_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                   randconfig-b0-12220407
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
arm                        keystone_defconfig
arm                            qcom_defconfig
x86_64                 randconfig-u0-12220455
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
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
i386                                defconfig
x86_64                randconfig-ne0-12220429
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                   randconfig-x079-201850
i386                   randconfig-x077-201850
i386                   randconfig-x073-201850
i386                   randconfig-x074-201850
i386                   randconfig-x075-201850
i386                   randconfig-x071-201850
i386                   randconfig-x078-201850
i386                   randconfig-x076-201850
i386                   randconfig-x070-201850
i386                   randconfig-x072-201850
arm                          tango4_defconfig
s390                             allyesconfig
i386                  randconfig-sb0-12220458
sh                   secureedge5410_defconfig
xtensa                           allmodconfig
x86_64                 randconfig-r0-12220558
i386                             alldefconfig
i386                              allnoconfig
arm                          pcm027_defconfig
arm                        raumfeld_defconfig
i386                   randconfig-x0-12220258

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
