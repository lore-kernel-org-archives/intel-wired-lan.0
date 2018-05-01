From: kbuild test robot <lkp@intel.com>
Date: Tue, 01 May 2018 11:10:28 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:40GbE] BUILD INCOMPLETE
 bf1099b5ea853bddaa0dc4b1c594a2fdbebaf4c9
Message-ID: <5ae7daa4.N8f2lVujWFkDuLzt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  40GbE
branch HEAD: bf1099b5ea853bddaa0dc4b1c594a2fdbebaf4c9  i40e: use %pI4b instead of byte swapping before dev_err

TIMEOUT after 609m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 227

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
powerpc                      makalu_defconfig
s390                             allyesconfig
mips                      maltasmvp_defconfig
mips                        nlm_xlp_defconfig
m68k                             alldefconfig
mips                  maltasmvp_eva_defconfig
x86_64                 randconfig-a0-05010149
x86_64                 randconfig-a0-05010357
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
mips                              allnoconfig
powerpc64                        allyesconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-05010140
i386                   randconfig-c0-05010224
arm                          ks8695_defconfig
microblaze                       allmodconfig
x86_64                randconfig-it0-04302232
i386                   randconfig-x014-201817
i386                   randconfig-x013-201817
i386                   randconfig-x012-201817
i386                   randconfig-x015-201817
i386                   randconfig-x016-201817
i386                   randconfig-x019-201817
i386                   randconfig-x010-201817
i386                   randconfig-x018-201817
i386                   randconfig-x017-201817
i386                   randconfig-x011-201817
x86_64                              federa-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201817
x86_64                 randconfig-x006-201817
x86_64                 randconfig-x002-201817
x86_64                 randconfig-x005-201817
x86_64                 randconfig-x004-201817
x86_64                 randconfig-x009-201817
x86_64                 randconfig-x001-201817
x86_64                 randconfig-x008-201817
x86_64                 randconfig-x000-201817
x86_64                 randconfig-x007-201817
x86_64                 randconfig-x003-201817
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201817
i386                     randconfig-i1-201817
x86_64                 randconfig-v0-04301002
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
openrisc                         allyesconfig
x86_64                                  kexec
x86_64                 randconfig-g0-04301358
i386                             allmodconfig
x86_64                 randconfig-x010-201817
x86_64                 randconfig-x011-201817
x86_64                 randconfig-x012-201817
x86_64                 randconfig-x013-201817
x86_64                 randconfig-x014-201817
x86_64                 randconfig-x015-201817
x86_64                 randconfig-x016-201817
x86_64                 randconfig-x017-201817
x86_64                 randconfig-x018-201817
x86_64                 randconfig-x019-201817
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
i386                     randconfig-a0-201817
i386                     randconfig-a1-201817
x86_64                 randconfig-s0-05010148
x86_64                 randconfig-s1-05010148
x86_64                 randconfig-s2-05010148
x86_64                 randconfig-s0-05010632
x86_64                 randconfig-s1-05010632
x86_64                 randconfig-s2-05010632
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                         axm55xx_defconfig
arm                          collie_defconfig
ia64                             allyesconfig
sh                     magicpanelr2_defconfig
arm                             mxs_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc64                        allmodconfig
sh                           se7343_defconfig
powerpc                      obs600_defconfig
powerpc                     sbc834x_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7712_defconfig
arm                      jornada720_defconfig
mips                       capcella_defconfig
powerpc                        fsp2_defconfig
sh                           se7721_defconfig
arm                           acs5k_defconfig
h8300                       h8s-sim_defconfig
mips                         tb0226_defconfig
i386                             allyesconfig
mips                        bcm63xx_defconfig
powerpc                     redwood_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201817
i386                     randconfig-s1-201817
x86_64                           allmodconfig
x86_64                 randconfig-s3-05010140
x86_64                 randconfig-s4-05010140
x86_64                 randconfig-s5-05010140
x86_64                 randconfig-s3-05010224
x86_64                 randconfig-s4-05010224
x86_64                 randconfig-s5-05010224
x86_64                 randconfig-s3-05010637
x86_64                 randconfig-s4-05010637
x86_64                 randconfig-s5-05010637
x86_64                 randconfig-s3-05010705
x86_64                 randconfig-s4-05010705
x86_64                 randconfig-s5-05010705
x86_64                 randconfig-s3-05010826
x86_64                 randconfig-s4-05010826
x86_64                 randconfig-s5-05010826
x86_64                 randconfig-s3-05010903
x86_64                 randconfig-s4-05010903
x86_64                 randconfig-s5-05010903
x86_64                 randconfig-s3-05010954
x86_64                 randconfig-s4-05010954
x86_64                 randconfig-s5-05010954
alpha                            allyesconfig
arm                          iop33x_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201817
i386                   randconfig-b0-04301506
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
powerpc                 xes_mpc85xx_defconfig
s390                              allnoconfig
c6x                        evmc6457_defconfig
parisc                         a500_defconfig
mips                       markeins_defconfig
sparc                            allmodconfig
x86_64                 randconfig-u0-05010143
x86_64                 randconfig-u0-05010251
x86_64                 randconfig-u0-05010911
i386                   randconfig-h0-04292232
i386                   randconfig-h1-04292232
mips                             allmodconfig
mips                            gpr_defconfig
x86_64                randconfig-ne0-04302200
x86_64                 randconfig-h0-04300745
i386                   randconfig-x000-201817
i386                   randconfig-x001-201817
i386                   randconfig-x002-201817
i386                   randconfig-x003-201817
i386                   randconfig-x004-201817
i386                   randconfig-x005-201817
i386                   randconfig-x006-201817
i386                   randconfig-x007-201817
i386                   randconfig-x008-201817
i386                   randconfig-x009-201817
i386                   randconfig-x070-201817
i386                   randconfig-x071-201817
i386                   randconfig-x072-201817
i386                   randconfig-x073-201817
i386                   randconfig-x074-201817
i386                   randconfig-x075-201817
i386                   randconfig-x076-201817
i386                   randconfig-x077-201817
i386                   randconfig-x078-201817
i386                   randconfig-x079-201817
arm                            mps2_defconfig
arm                         vf610m4_defconfig
i386                  randconfig-sb0-04300828
arm                         bcm2835_defconfig
sh                              ul2_defconfig
x86_64                randconfig-ws0-04300144
openrisc                          allnoconfig
parisc                           allmodconfig
i386                   randconfig-x0-04301414

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
