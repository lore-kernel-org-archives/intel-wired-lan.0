From: kbuild test robot <lkp@intel.com>
Date: Mon, 06 Jan 2020 11:02:21 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD SUCCESS
 ea8ccaef9261a81b7e9ba5fff71a806c31a7a479
Message-ID: <5e12a33d.hVvvroFHmbU10IGf%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: ea8ccaef9261a81b7e9ba5fff71a806c31a7a479  i40e: Fix receive buffer starvation for AF_XDP

elapsed time: 1092m

configs tested: 145

The following configs have been built successfully.
More configs may be tested in the coming days.

sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
i386                 randconfig-f001-20200105
x86_64               randconfig-f003-20200105
x86_64               randconfig-f001-20200105
i386                 randconfig-f003-20200105
i386                 randconfig-f002-20200105
x86_64               randconfig-f002-20200105
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
x86_64               randconfig-b003-20200105
i386                 randconfig-b001-20200105
x86_64               randconfig-b002-20200105
i386                 randconfig-b003-20200105
x86_64               randconfig-b001-20200105
i386                 randconfig-b002-20200105
i386                             alldefconfig
arm                              allmodconfig
arm64                            allmodconfig
x86_64               randconfig-a002-20200105
i386                 randconfig-a001-20200105
x86_64               randconfig-a001-20200105
i386                 randconfig-a002-20200105
x86_64               randconfig-a003-20200105
i386                 randconfig-a003-20200105
i386                 randconfig-e002-20200105
x86_64               randconfig-e001-20200105
x86_64               randconfig-e002-20200105
i386                 randconfig-e003-20200105
x86_64               randconfig-e003-20200105
i386                 randconfig-e001-20200105
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
sparc64                          allmodconfig
sparc                            allyesconfig
sparc64                          allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
i386                             allyesconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
csky                 randconfig-a001-20200105
s390                 randconfig-a001-20200105
sh                   randconfig-a001-20200105
xtensa               randconfig-a001-20200105
openrisc             randconfig-a001-20200105
sparc64              randconfig-a001-20200105
nios2                randconfig-a001-20200105
h8300                randconfig-a001-20200105
c6x                  randconfig-a001-20200105
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
ia64                             alldefconfig
mips                 randconfig-a001-20200105
parisc               randconfig-a001-20200105
riscv                randconfig-a001-20200105
alpha                randconfig-a001-20200105
m68k                 randconfig-a001-20200105
nds32                randconfig-a001-20200105
mips                             allmodconfig
mips                           32r2_defconfig
mips                             allyesconfig
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
x86_64               randconfig-h003-20200105
x86_64               randconfig-h002-20200105
i386                 randconfig-h003-20200105
i386                 randconfig-h002-20200105
i386                 randconfig-h001-20200105
x86_64               randconfig-h001-20200105
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
x86_64               randconfig-d003-20200105
x86_64               randconfig-d002-20200105
x86_64               randconfig-d001-20200105
i386                 randconfig-d002-20200105
i386                 randconfig-d001-20200105
i386                 randconfig-d003-20200105
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                              allnoconfig
i386                                defconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
