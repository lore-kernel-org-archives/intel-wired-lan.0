From: kbuild test robot <lkp@intel.com>
Date: Sun, 24 Nov 2019 23:19:44 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:master] BUILD SUCCESS
 ab818362c9054beb950b97a09ce7b0d56f5a32a1
Message-ID: <5dda9f90.SfhvYVFrz4/pKDhn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  master
branch HEAD: ab818362c9054beb950b97a09ce7b0d56f5a32a1  net: use rhashtable_lookup() instead of rhashtable_lookup_fast()

elapsed time: 888m

configs tested: 125

The following configs have been built successfully.
More configs may be tested in the coming days.

x86_64               randconfig-g001-20191124
x86_64               randconfig-g002-20191124
x86_64               randconfig-g003-20191124
i386                 randconfig-g002-20191124
i386                 randconfig-g003-20191124
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
x86_64               randconfig-f001-20191124
x86_64               randconfig-f002-20191124
x86_64               randconfig-f003-20191124
i386                 randconfig-f001-20191124
i386                 randconfig-f002-20191124
i386                 randconfig-f003-20191124
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-c002-20191124
i386                 randconfig-c001-20191124
i386                 randconfig-c002-20191124
i386                 randconfig-c003-20191124
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64               randconfig-h002-20191124
x86_64               randconfig-h003-20191124
i386                 randconfig-h001-20191124
i386                 randconfig-h003-20191124
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
arc                 randconfig-a0031-20191124
arm                  randconfig-a001-20191124
arm64                randconfig-a001-20191124
ia64                 randconfig-a001-20191124
powerpc              randconfig-a001-20191124
sparc                randconfig-a001-20191124
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64               randconfig-c001-20191124
x86_64               randconfig-c003-20191124
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
alpha                               defconfig
nds32                             allnoconfig
nds32                               defconfig
riscv                             allnoconfig
riscv                               defconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
arm                              allmodconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
x86_64               randconfig-d001-20191124
x86_64               randconfig-d002-20191124
x86_64               randconfig-d003-20191124
i386                 randconfig-d002-20191124
x86_64               randconfig-a001-20191124
x86_64               randconfig-a002-20191124
x86_64               randconfig-a003-20191124
i386                 randconfig-a001-20191124
i386                 randconfig-a002-20191124
i386                 randconfig-a003-20191124
c6x                              allyesconfig
i386                 randconfig-g001-20191124
mips                             allmodconfig
x86_64               randconfig-h001-20191124
i386                 randconfig-h002-20191124
i386                 randconfig-d001-20191124
i386                 randconfig-d003-20191124
x86_64               randconfig-e001-20191124
x86_64               randconfig-e002-20191124
x86_64               randconfig-e003-20191124
i386                 randconfig-e001-20191124
i386                 randconfig-e002-20191124
i386                 randconfig-e003-20191124
m68k                             allmodconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
