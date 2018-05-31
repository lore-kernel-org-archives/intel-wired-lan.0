From: kbuild test robot <lkp@intel.com>
Date: Thu, 31 May 2018 12:41:44 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 ed1478d17c3cdbab3505566f63fe24cdb1c952b0
Message-ID: <5b0f7d08.JWmrEKrbBMS+Szky%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: ed1478d17c3cdbab3505566f63fe24cdb1c952b0  ixgbe: check ipsec ip addr against mgmt filters

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:487:56: sparse: restricted __be32 degrades to integer

Error ids grouped by kconfigs:

recent_errors
`-- x86_64-allmodconfig
    `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:restricted-__be32-degrades-to-integer

TIMEOUT after 607m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 33

alpha                            allmodconfig
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
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
x86_64                            allnoconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                              defconfig
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 196

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
alpha                            allyesconfig
powerpc                     mpc83xx_defconfig
x86_64                 randconfig-a0-05301837
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
arm                        mvebu_v5_defconfig
arm                            xcep_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-05301800
x86_64                randconfig-in0-05301735
i386                   randconfig-x012-201821
i386                   randconfig-x017-201821
i386                   randconfig-x014-201821
i386                   randconfig-x016-201821
i386                   randconfig-x018-201821
i386                   randconfig-x013-201821
i386                   randconfig-x011-201821
i386                   randconfig-x015-201821
i386                   randconfig-x019-201821
i386                   randconfig-x010-201821
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                              fedora-25
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201821
x86_64                 randconfig-x003-201821
x86_64                 randconfig-x007-201821
x86_64                 randconfig-x000-201821
x86_64                 randconfig-x005-201821
x86_64                 randconfig-x004-201821
x86_64                 randconfig-x001-201821
x86_64                 randconfig-x008-201821
x86_64                 randconfig-x002-201821
x86_64                 randconfig-x006-201821
x86_64                 randconfig-x009-201821
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201821
i386                     randconfig-i1-201821
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
arm                          nuc950_defconfig
sh                          lboxre2_defconfig
x86_64                 randconfig-v0-05291327
x86_64                           allyesconfig
x86_64                 randconfig-g0-05300930
x86_64                 randconfig-g0-05310449
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                              allmodconfig
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
arm64                            allmodconfig
i386                   randconfig-a0-05291352
i386                   randconfig-a1-05291352
x86_64                 randconfig-s0-05310151
x86_64                 randconfig-s1-05310151
x86_64                 randconfig-s2-05310151
x86_64                 randconfig-s0-05310419
x86_64                 randconfig-s1-05310419
x86_64                 randconfig-s2-05310419
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
m68k                             allyesconfig
mips                         cobalt_defconfig
powerpc                    klondike_defconfig
mips                          ath79_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          rsk7203_defconfig
x86_64                 randconfig-x011-201821
x86_64                 randconfig-x015-201821
x86_64                 randconfig-x018-201821
x86_64                 randconfig-x010-201821
x86_64                 randconfig-x019-201821
x86_64                 randconfig-x014-201821
x86_64                 randconfig-x013-201821
x86_64                 randconfig-x016-201821
x86_64                 randconfig-x017-201821
x86_64                 randconfig-x012-201821
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201821
i386                     randconfig-s1-201821
x86_64                           allmodconfig
x86_64                 randconfig-s3-05310227
x86_64                 randconfig-s4-05310227
x86_64                 randconfig-s5-05310227
x86_64                 randconfig-s3-05310445
x86_64                 randconfig-s4-05310445
x86_64                 randconfig-s5-05310445
i386                             allmodconfig
arm                          iop32x_defconfig
powerpc                       maple_defconfig
s390                    performance_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201821
i386                   randconfig-b0-05292000
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
mips                           ip27_defconfig
mips                        jmr3927_defconfig
powerpc                        icon_defconfig
microblaze                          defconfig
mips                          rb532_defconfig
powerpc                     tqm8560_defconfig
x86_64                 randconfig-b0-05301738
x86_64                 randconfig-b0-05310524
arm                         em_x270_defconfig
parisc                           allyesconfig
x86_64                 randconfig-u0-05301010
i386                   randconfig-h0-05301415
i386                   randconfig-h1-05301415
powerpc                 mpc8313_rdb_defconfig
x86_64                randconfig-ne0-05301744
arm                       imx_v4_v5_defconfig
m68k                       bvme6000_defconfig
ia64                            zx1_defconfig
powerpc                      cm5200_defconfig
x86_64                 randconfig-h0-05301849
i386                   randconfig-x078-201821
i386                   randconfig-x079-201821
i386                   randconfig-x070-201821
i386                   randconfig-x075-201821
i386                   randconfig-x076-201821
i386                   randconfig-x074-201821
i386                   randconfig-x071-201821
i386                   randconfig-x073-201821
i386                   randconfig-x077-201821
i386                   randconfig-x072-201821
powerpc                   currituck_defconfig
powerpc                     powernv_defconfig
x86_64                randconfig-ws0-05301017
x86_64                randconfig-ws0-05301812
x86_64                                  kexec
x86_64                 randconfig-r0-05301018
i386                   randconfig-x008-201821
i386                   randconfig-x009-201821
i386                   randconfig-x005-201821
i386                   randconfig-x000-201821
i386                   randconfig-x003-201821
i386                   randconfig-x001-201821
i386                   randconfig-x004-201821
i386                   randconfig-x006-201821
i386                   randconfig-x002-201821
i386                   randconfig-x007-201821
i386                   randconfig-x0-05300839

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
