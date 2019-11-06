From: kbuild test robot <lkp@intel.com>
Date: Wed, 06 Nov 2019 13:02:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 eae897a054c3e3a4a48ef279e2193f8307c2349d
Message-ID: <5dc253f7.6eZN5MXNYn0sUXr/%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: eae897a054c3e3a4a48ef279e2193f8307c2349d  ice: fix potential infinite loop because loop counter being too small

Regressions in current branch:

drivers/net/ethernet/intel/ice/ice_dcb_lib.c:188:1-8: alloc with no test, possible model on line 191

Error ids grouped by kconfigs:

recent_errors
|-- i386-allmodconfig
|   `-- drivers-net-ethernet-intel-ice-ice_dcb_lib.c:alloc-with-no-test-possible-model-on-line
`-- x86_64-allyesconfig
    `-- drivers-net-ethernet-intel-ice-ice_dcb_lib.c:alloc-with-no-test-possible-model-on-line

elapsed time: 2121m

configs tested: 137

x86_64                 randconfig-c001-201944
x86_64                 randconfig-c002-201944
x86_64                 randconfig-c003-201944
x86_64                 randconfig-c004-201944
i386                   randconfig-c001-201944
i386                   randconfig-c002-201944
i386                   randconfig-c003-201944
i386                   randconfig-c004-201944
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
x86_64                 randconfig-g002-201944
i386                   randconfig-g004-201944
x86_64                 randconfig-g001-201944
i386                   randconfig-g002-201944
x86_64                 randconfig-g004-201944
x86_64                 randconfig-g003-201944
i386                   randconfig-g003-201944
i386                   randconfig-g001-201944
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-b001-201944
x86_64                 randconfig-b002-201944
i386                   randconfig-b003-201944
x86_64                 randconfig-b003-201944
i386                   randconfig-b004-201944
x86_64                 randconfig-b001-201944
x86_64                 randconfig-b004-201944
i386                   randconfig-b002-201944
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-f002-201944
i386                   randconfig-f001-201944
x86_64                 randconfig-f003-201944
x86_64                 randconfig-f004-201944
x86_64                 randconfig-f002-201944
i386                   randconfig-f003-201944
i386                   randconfig-f004-201944
x86_64                 randconfig-f001-201944
x86_64                 randconfig-a004-201944
x86_64                 randconfig-a001-201944
x86_64                 randconfig-a002-201944
i386                   randconfig-a002-201944
i386                   randconfig-a001-201944
i386                   randconfig-a003-201944
i386                   randconfig-a004-201944
x86_64                 randconfig-a003-201944
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
x86_64                           allyesconfig
i386                             allmodconfig
x86_64                           allmodconfig
i386                             alldefconfig
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
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
nds32                             allnoconfig
nds32                               defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                 randconfig-e004-201944
x86_64                 randconfig-e001-201944
x86_64                 randconfig-e003-201944
x86_64                 randconfig-e002-201944
i386                   randconfig-e003-201944
i386                   randconfig-e001-201944
i386                   randconfig-e004-201944
i386                   randconfig-e002-201944
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                              allnoconfig
i386                                defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
i386                   randconfig-d002-201944
x86_64                 randconfig-d002-201944
x86_64                 randconfig-d004-201944
i386                   randconfig-d004-201944
x86_64                 randconfig-d003-201944
i386                   randconfig-d003-201944
x86_64                 randconfig-d001-201944
i386                   randconfig-d001-201944
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
