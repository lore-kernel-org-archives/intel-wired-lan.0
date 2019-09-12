From: kbuild test robot <lkp@intel.com>
Date: Thu, 12 Sep 2019 09:25:20 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:10GbE] BUILD SUCCESS
 bf280c0387ebbf8eebad1036fca8f7b85ebfde32
Message-ID: <5d799e80.+Wc7moAYFZ9V8fWK%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/net-queue.git  10GbE
branch HEAD: bf280c0387ebbf8eebad1036fca8f7b85ebfde32  ixgbe: fix double clean of Tx descriptors with xdp

elapsed time: 487m

configs tested: 116

The following configs have been built successfully.
More configs may be tested in the coming days.

c6x                        evmc6678_defconfig
mips                             allmodconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                                   jz4740
mips                                     txx9
nds32                               defconfig
sparc                            allyesconfig
x86_64                 randconfig-a001-201936
x86_64                 randconfig-a002-201936
x86_64                 randconfig-a003-201936
x86_64                 randconfig-a004-201936
i386                   randconfig-a001-201936
i386                   randconfig-a002-201936
i386                   randconfig-a003-201936
i386                   randconfig-a004-201936
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                           allyesconfig
i386                             allmodconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-g003-201936
i386                   randconfig-g004-201936
x86_64                 randconfig-g001-201936
x86_64                 randconfig-g002-201936
i386                   randconfig-g001-201936
x86_64                 randconfig-g004-201936
i386                   randconfig-g002-201936
i386                   randconfig-g003-201936
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
s390                             allmodconfig
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
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                 randconfig-b001-201936
x86_64                 randconfig-b002-201936
x86_64                 randconfig-b003-201936
x86_64                 randconfig-b004-201936
i386                   randconfig-b001-201936
i386                   randconfig-b002-201936
i386                   randconfig-b003-201936
i386                   randconfig-b004-201936
x86_64                 randconfig-f001-201936
x86_64                 randconfig-f002-201936
x86_64                 randconfig-f003-201936
x86_64                 randconfig-f004-201936
i386                   randconfig-f001-201936
i386                   randconfig-f002-201936
i386                   randconfig-f003-201936
i386                   randconfig-f004-201936
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                 randconfig-e001-201936
x86_64                 randconfig-e002-201936
x86_64                 randconfig-e003-201936
x86_64                 randconfig-e004-201936
i386                   randconfig-e001-201936
i386                   randconfig-e002-201936
i386                   randconfig-e003-201936
i386                   randconfig-e004-201936
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                           allmodconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
