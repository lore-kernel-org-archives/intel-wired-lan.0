From: kbuild test robot <lkp@intel.com>
Date: Tue, 28 Aug 2018 16:26:52 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 2e2b5d94cbb1a83c807debcc582c1c0d064b8068
Message-ID: <5b85074c.Fl10eEXNsogMvuaU%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 2e2b5d94cbb1a83c807debcc582c1c0d064b8068  Documentation: igbvf: Update kernel documentation

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_main.c:13946:2-8: ERROR: missing iounmap; ioremap on line 13817 and execution via conditional on line 13945
drivers/net/ethernet/intel/igc/igc_i225.c:471:5-12: Unneeded variable: "ret_val". Return "0" on line 490
drivers/net/ethernet/intel/igc/igc_mac.c:275:5-12: Unneeded variable: "ret_val". Return "0" on line 297

Error ids grouped by kconfigs:

recent_errors
`-- i386-allmodconfig
    |-- drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line
    |-- drivers-net-ethernet-intel-igc-igc_i225.c:Unneeded-variable:ret_val-Return-on-line
    `-- drivers-net-ethernet-intel-igc-igc_mac.c:Unneeded-variable:ret_val-Return-on-line

TIMEOUT after 607m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 45

alpha                            allmodconfig
alpha                            allyesconfig
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
i386                          randconfig-x070
i386                          randconfig-x071
i386                          randconfig-x072
i386                          randconfig-x073
i386                          randconfig-x074
i386                          randconfig-x075
i386                          randconfig-x076
i386                          randconfig-x077
i386                          randconfig-x078
i386                          randconfig-x079
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
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                                    lkp
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 109

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                   randconfig-x018-201834
i386                   randconfig-x017-201834
i386                   randconfig-x010-201834
i386                   randconfig-x013-201834
i386                   randconfig-x016-201834
i386                   randconfig-x011-201834
i386                   randconfig-x019-201834
i386                   randconfig-x015-201834
i386                   randconfig-x012-201834
i386                   randconfig-x014-201834
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201834
x86_64                 randconfig-x000-201834
x86_64                 randconfig-x009-201834
x86_64                 randconfig-x001-201834
x86_64                 randconfig-x004-201834
x86_64                 randconfig-x003-201834
x86_64                 randconfig-x008-201834
x86_64                 randconfig-x007-201834
x86_64                 randconfig-x006-201834
x86_64                 randconfig-x005-201834
x86_64                 randconfig-x002-201834
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201834
i386                     randconfig-i1-201834
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                   randconfig-a0-08280857
i386                   randconfig-a1-08280857
x86_64               randconfig-x014-08280925
x86_64               randconfig-x016-08280925
x86_64               randconfig-x010-08280925
x86_64               randconfig-x013-08280925
x86_64               randconfig-x011-08280925
x86_64               randconfig-x018-08280925
x86_64               randconfig-x017-08280925
x86_64               randconfig-x012-08280925
x86_64               randconfig-x019-08280925
x86_64               randconfig-x015-08280925
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                   randconfig-s0-08280925
i386                   randconfig-s1-08280925
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                 randconfig-i0-08280848
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                               tinyconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                 randconfig-x002-08271637
i386                 randconfig-x009-08271637
i386                 randconfig-x004-08271637
i386                 randconfig-x005-08271637
i386                 randconfig-x003-08271637
i386                 randconfig-x007-08271637
i386                 randconfig-x006-08271637
i386                 randconfig-x000-08271637
i386                 randconfig-x008-08271637
i386                 randconfig-x001-08271637
i386                 randconfig-x000-08280950
i386                 randconfig-x001-08280950
i386                 randconfig-x002-08280950
i386                 randconfig-x003-08280950
i386                 randconfig-x004-08280950
i386                 randconfig-x005-08280950
i386                 randconfig-x006-08280950
i386                 randconfig-x007-08280950
i386                 randconfig-x008-08280950
i386                 randconfig-x009-08280950

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
