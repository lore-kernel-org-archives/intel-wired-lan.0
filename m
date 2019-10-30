From: kbuild test robot <lkp@intel.com>
Date: Wed, 30 Oct 2019 15:15:03 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 ec2cafa1cdb5a5483cf4563dbc7fc1e52168587d
Message-ID: <5db93877.wSM+aCRMxmjVCQR6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: ec2cafa1cdb5a5483cf4563dbc7fc1e52168587d  i40e: implement VF stats NDO

Regressions in current branch:

drivers/net/ethernet/intel/ice/ice_dcb_lib.c:188:1-8: alloc with no test, possible model on line 191

Error ids grouped by kconfigs:

recent_errors
|-- i386-allmodconfig
|   `-- drivers-net-ethernet-intel-ice-ice_dcb_lib.c:alloc-with-no-test-possible-model-on-line
`-- x86_64-allyesconfig
    `-- drivers-net-ethernet-intel-ice-ice_dcb_lib.c:alloc-with-no-test-possible-model-on-line

elapsed time: 396m

configs tested: 113

x86_64                 randconfig-a004-201943
x86_64                 randconfig-a001-201943
i386                   randconfig-a002-201943
x86_64                 randconfig-a002-201943
i386                   randconfig-a001-201943
i386                   randconfig-a003-201943
i386                   randconfig-a004-201943
x86_64                 randconfig-a003-201943
x86_64                           allyesconfig
i386                             allmodconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
x86_64                 randconfig-e004-201943
x86_64                 randconfig-e001-201943
x86_64                 randconfig-e003-201943
x86_64                 randconfig-e002-201943
i386                   randconfig-e003-201943
i386                   randconfig-e004-201943
i386                   randconfig-e001-201943
i386                   randconfig-e002-201943
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
arc                              allyesconfig
powerpc                             defconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
mips                             allmodconfig
mips                           32r2_defconfig
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
arm                              allmodconfig
arm64                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
i386                   randconfig-b001-201943
x86_64                 randconfig-b002-201943
x86_64                 randconfig-b003-201943
i386                   randconfig-b003-201943
i386                   randconfig-b004-201943
x86_64                 randconfig-b004-201943
x86_64                 randconfig-b001-201943
i386                   randconfig-b002-201943
riscv                             allnoconfig
riscv                               defconfig
nds32                               defconfig
alpha                               defconfig
nds32                             allnoconfig
i386                   randconfig-d002-201943
x86_64                 randconfig-d002-201943
i386                   randconfig-d004-201943
x86_64                 randconfig-d004-201943
x86_64                 randconfig-d003-201943
i386                   randconfig-d003-201943
x86_64                 randconfig-d001-201943
i386                   randconfig-d001-201943
x86_64                           allmodconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm64                            allyesconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
