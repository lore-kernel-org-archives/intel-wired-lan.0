From: kbuild test robot <lkp@intel.com>
Date: Wed, 14 Nov 2018 02:33:27 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 0e966c3dcab3cddf7400b6dbedab52d841f1bf37
Message-ID: <5beb18f7.H1bErkRdcTIJdUol%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 0e966c3dcab3cddf7400b6dbedab52d841f1bf37  igb: fix uninitialized variables

TIMEOUT after 604m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 98

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
arm                       mainstone_defconfig
sh                          polaris_defconfig
sh                   sh7724_generic_defconfig
m68k                             alldefconfig
xtensa                              defconfig
microblaze                    nommu_defconfig
powerpc64                         allnoconfig
arm                         iop13xx_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     stx_gp3_defconfig
powerpc                         wii_defconfig
powerpc               mpc834x_itxgp_defconfig
x86_64                 randconfig-a0-11132153
x86_64                 randconfig-a0-11140102
x86_64                 randconfig-a0-11140154
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
mips                  cavium_octeon_defconfig
nds32                               defconfig
openrisc                          allnoconfig
openrisc                            defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc834x_mds_defconfig
ia64                            sim_defconfig
sparc64                             defconfig
arm                  colibri_pxa270_defconfig
sh                             espt_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-11140128
i386                 randconfig-x004-11131818
i386                 randconfig-x003-11131818
i386                 randconfig-x005-11131818
i386                 randconfig-x008-11131818
i386                 randconfig-x009-11131818
i386                 randconfig-x001-11131818
i386                 randconfig-x007-11131818
i386                 randconfig-x000-11131818
i386                 randconfig-x006-11131818
i386                 randconfig-x002-11131818
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                 randconfig-s0-11140152
x86_64                 randconfig-s1-11140152
x86_64                 randconfig-s2-11140152
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
x86_64               randconfig-x009-11131125
x86_64               randconfig-x003-11131125
x86_64               randconfig-x002-11131125
x86_64               randconfig-x004-11131125
x86_64               randconfig-x007-11131125
x86_64               randconfig-x005-11131125
x86_64               randconfig-x000-11131125
x86_64               randconfig-x008-11131125
x86_64               randconfig-x006-11131125
x86_64               randconfig-x001-11131125
x86_64                 randconfig-e0-11131125
x86_64                 randconfig-e1-11131125
x86_64                 randconfig-e2-11131125
x86_64                 randconfig-e3-11131125
x86_64                randconfig-ws0-11140010
arm                         nhk8815_defconfig
mips                      malta_kvm_defconfig
arm                              alldefconfig
arm                            lart_defconfig
x86_64                randconfig-ws0-11132134
arm                              allyesconfig
x86_64                 randconfig-r0-11132142
x86_64                 randconfig-r0-11132348
i386                 randconfig-x070-11131127
i386                 randconfig-x071-11131127
i386                 randconfig-x072-11131127
i386                 randconfig-x073-11131127
i386                 randconfig-x074-11131127
i386                 randconfig-x075-11131127
i386                 randconfig-x076-11131127
i386                 randconfig-x077-11131127
i386                 randconfig-x078-11131127
i386                 randconfig-x079-11131127
i386                             alldefconfig
i386                              allnoconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
