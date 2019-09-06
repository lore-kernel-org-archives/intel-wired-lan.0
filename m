From: kbuild test robot <lkp@intel.com>
Date: Sat, 07 Sep 2019 04:20:08 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 7e6c9b4197609015b48161f9651b0d4212e9f8cf
Message-ID: <5d72bf78.scUcXWUpZ3NuD2Zl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 7e6c9b4197609015b48161f9651b0d4212e9f8cf  ice: Bump version

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_xsk.c:162:9: error: implicit declaration of function 'i40e_xsk_async_xmit'; did you mean 'i40e_xdp_xmit'? [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
`-- i386-allmodconfig
    `-- drivers-net-ethernet-intel-i40e-i40e_xsk.c:error:implicit-declaration-of-function-i40e_xsk_async_xmit-did-you-mean-i40e_xdp_xmit

elapsed time: 188m

configs tested: 110

s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                nfsroot
x86_64                                   rhel
x86_64                               rhel-7.6
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-c001-201935
x86_64                 randconfig-c002-201935
x86_64                 randconfig-c003-201935
x86_64                 randconfig-c004-201935
i386                   randconfig-c001-201935
i386                   randconfig-c002-201935
i386                   randconfig-c003-201935
i386                   randconfig-c004-201935
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
alpha                               defconfig
nds32                             allnoconfig
nds32                               defconfig
riscv                             allnoconfig
riscv                               defconfig
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
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                 randconfig-b001-201935
x86_64                 randconfig-b002-201935
x86_64                 randconfig-b003-201935
x86_64                 randconfig-b004-201935
i386                   randconfig-b001-201935
i386                   randconfig-b002-201935
i386                   randconfig-b003-201935
i386                   randconfig-b004-201935
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allyesconfig
x86_64                           allmodconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                 randconfig-e001-201935
x86_64                 randconfig-e002-201935
x86_64                 randconfig-e003-201935
x86_64                 randconfig-e004-201935
i386                   randconfig-e001-201935
i386                   randconfig-e002-201935
i386                   randconfig-e003-201935
i386                   randconfig-e004-201935
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
