From: kbuild test robot <lkp@intel.com>
Date: Thu, 14 Mar 2019 12:01:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 025312efbda97232ca518437dc1dd738a7b2391d
Message-ID: <5c89d227.HUzRS80Urt0BwbOd%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 025312efbda97232ca518437dc1dd738a7b2391d  i40e: Add macvlan support on i40e

TIMEOUT after 606m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 123

alpha                            allmodconfig
alpha                            allyesconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-a2
i386                            randconfig-a3
i386                            randconfig-f0
i386                            randconfig-f1
i386                            randconfig-f2
i386                            randconfig-f3
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-i2
i386                            randconfig-i3
i386                            randconfig-j0
i386                            randconfig-j1
i386                            randconfig-j2
i386                            randconfig-j3
i386                            randconfig-k0
i386                            randconfig-k1
i386                            randconfig-k2
i386                            randconfig-k3
i386                            randconfig-n0
i386                            randconfig-n1
i386                            randconfig-n2
i386                            randconfig-n3
i386                            randconfig-s0
i386                            randconfig-s1
i386                            randconfig-s2
i386                            randconfig-s3
i386                          randconfig-x000
i386                          randconfig-x001
i386                          randconfig-x002
i386                          randconfig-x003
i386                          randconfig-x004
i386                          randconfig-x005
i386                          randconfig-x006
i386                          randconfig-x007
i386                          randconfig-x008
i386                          randconfig-x009
i386                               tinyconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                             allyesconfig
nds32                            allmodconfig
nds32                            allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                              tinyconfig
s390                             allmodconfig
s390                             allyesconfig
s390                        default_defconfig
sh                               allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allyesconfig
x86_64                           allmodconfig
x86_64                          randconfig-e0
x86_64                          randconfig-e1
x86_64                          randconfig-e2
x86_64                          randconfig-e3
x86_64                          randconfig-f0
x86_64                          randconfig-f1
x86_64                          randconfig-f2
x86_64                          randconfig-f3
x86_64                          randconfig-g0
x86_64                          randconfig-g1
x86_64                          randconfig-g2
x86_64                          randconfig-g3
x86_64                          randconfig-h0
x86_64                          randconfig-h1
x86_64                          randconfig-h2
x86_64                          randconfig-h3
x86_64                          randconfig-i0
x86_64                          randconfig-i1
x86_64                          randconfig-i2
x86_64                          randconfig-i3
x86_64                          randconfig-j0
x86_64                          randconfig-j1
x86_64                          randconfig-j2
x86_64                          randconfig-j3
x86_64                          randconfig-k0
x86_64                          randconfig-k1
x86_64                          randconfig-k2
x86_64                          randconfig-k3
x86_64                        randconfig-x000
x86_64                        randconfig-x001
x86_64                        randconfig-x002
x86_64                        randconfig-x003
x86_64                        randconfig-x004
x86_64                        randconfig-x005
x86_64                        randconfig-x006
x86_64                        randconfig-x007
x86_64                        randconfig-x008
x86_64                        randconfig-x009
x86_64                        randconfig-x010
x86_64                        randconfig-x011
x86_64                        randconfig-x012
x86_64                        randconfig-x013
x86_64                        randconfig-x014
x86_64                        randconfig-x015
x86_64                        randconfig-x016
x86_64                        randconfig-x017
x86_64                        randconfig-x018
x86_64                        randconfig-x019
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 118

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
arm                          simpad_defconfig
mips                           ip32_defconfig
mips                    maltaup_xpa_defconfig
sh                         ecovec24_defconfig
parisc                      default_defconfig
sh                           se7750_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-x010-201910
i386                   randconfig-x011-201910
i386                   randconfig-x012-201910
i386                   randconfig-x013-201910
i386                   randconfig-x014-201910
i386                   randconfig-x015-201910
i386                   randconfig-x016-201910
i386                   randconfig-x017-201910
i386                   randconfig-x018-201910
i386                   randconfig-x019-201910
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-s0-03141123
x86_64                 randconfig-s1-03141123
x86_64                 randconfig-s2-03141123
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
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
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
nds32                             allnoconfig
nds32                               defconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                 randconfig-m0-03132108
x86_64                 randconfig-m2-03132108
i386                   randconfig-m2-03132108
i386                   randconfig-m3-03132108
i386                   randconfig-m1-03132108
x86_64                 randconfig-m3-03132108
x86_64                 randconfig-m1-03132108
i386                   randconfig-m0-03132108
riscv                             allnoconfig
riscv                               defconfig
x86_64                 randconfig-l0-03140711
i386                   randconfig-l3-03140711
x86_64                 randconfig-l3-03140711
x86_64                 randconfig-l1-03140711
i386                   randconfig-l1-03140711
i386                   randconfig-l2-03140711
i386                   randconfig-l0-03140711
x86_64                 randconfig-l2-03140711
i386                 randconfig-x079-03132349
i386                 randconfig-x073-03132349
i386                 randconfig-x076-03132349
i386                 randconfig-x077-03132349
i386                 randconfig-x074-03132349
i386                 randconfig-x072-03132349
i386                 randconfig-x070-03132349
i386                 randconfig-x075-03132349
i386                 randconfig-x078-03132349
i386                 randconfig-x071-03132349
x86_64                           allyesconfig
i386                             allmodconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
