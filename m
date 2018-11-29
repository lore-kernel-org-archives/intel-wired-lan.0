From: kbuild test robot <lkp@intel.com>
Date: Thu, 29 Nov 2018 13:43:03 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 2ad37e4df69d0f0331cbc4d5d278c7c133522e8d
Message-ID: <5bff7c67.H/DqUMHq2PMHeapQ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 2ad37e4df69d0f0331cbc4d5d278c7c133522e8d  i40e: extend PTP gettime function to read system clock

TIMEOUT after 602m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 223

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
riscv                              tinyconfig
i386                               tinyconfig
powerpc                     virtex5_defconfig
xtensa                  nommu_kc705_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
powerpc                     redwood_defconfig
sh                               allmodconfig
powerpc                      ep88xc_defconfig
powerpc                      katmai_defconfig
i386                   randconfig-x010-201847
i386                   randconfig-x011-201847
i386                   randconfig-x012-201847
i386                   randconfig-x013-201847
i386                   randconfig-x014-201847
i386                   randconfig-x015-201847
i386                   randconfig-x016-201847
i386                   randconfig-x017-201847
i386                   randconfig-x018-201847
i386                   randconfig-x019-201847
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-x001-201847
x86_64                 randconfig-x005-201847
x86_64                 randconfig-x002-201847
x86_64                 randconfig-x000-201847
x86_64                 randconfig-x009-201847
x86_64                 randconfig-x007-201847
x86_64                 randconfig-x008-201847
x86_64                 randconfig-x003-201847
x86_64                 randconfig-x006-201847
x86_64                 randconfig-x004-201847
nds32                             allnoconfig
nds32                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
riscv                             allnoconfig
riscv                               defconfig
m68k                          atari_defconfig
mips                            e55_defconfig
arm                             mxs_defconfig
xtensa                              defconfig
x86_64                 randconfig-g0-11291222
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
i386                   randconfig-x002-201847
i386                   randconfig-x004-201847
i386                   randconfig-x000-201847
i386                   randconfig-x007-201847
i386                   randconfig-x006-201847
i386                   randconfig-x005-201847
i386                   randconfig-x001-201847
i386                   randconfig-x009-201847
i386                   randconfig-x003-201847
i386                   randconfig-x008-201847
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-s0-11291216
x86_64                 randconfig-s1-11291216
x86_64                 randconfig-s2-11291216
x86_64                 randconfig-s0-11291253
x86_64                 randconfig-s1-11291253
x86_64                 randconfig-s2-11291253
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
arm                    vt8500_v6_v7_defconfig
microblaze                        allnoconfig
sh                   rts7751r2dplus_defconfig
sh                           se7722_defconfig
arm                           acs5k_defconfig
powerpc                        icon_defconfig
sh                ecovec24-romimage_defconfig
sh                            migor_defconfig
c6x                        evmc6457_defconfig
h8300                       h8s-sim_defconfig
mips                         bigsur_defconfig
arm                            lart_defconfig
arm                        raumfeld_defconfig
m68k                            mac_defconfig
powerpc                         wii_defconfig
arm                          iop32x_defconfig
c6x                        evmc6472_defconfig
parisc                           allmodconfig
powerpc                     ep8248e_defconfig
arm                          lpd270_defconfig
mips                          lasat_defconfig
powerpc                     sequoia_defconfig
ia64                        generic_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     mpc512x_defconfig
sparc                            allmodconfig
ia64                         bigsur_defconfig
parisc                        c8000_defconfig
arm                         mv78xx0_defconfig
powerpc                     asp8347_defconfig
riscv                            alldefconfig
sh                         microdev_defconfig
x86_64                 randconfig-x017-201847
x86_64                 randconfig-x012-201847
x86_64                 randconfig-x016-201847
x86_64                 randconfig-x011-201847
x86_64                 randconfig-x013-201847
x86_64                 randconfig-x014-201847
x86_64                 randconfig-x019-201847
x86_64                 randconfig-x018-201847
x86_64                 randconfig-x010-201847
x86_64                 randconfig-x015-201847
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201847
i386                     randconfig-s1-201847
i386                     randconfig-s3-201847
i386                     randconfig-s2-201847
x86_64                 randconfig-s3-11291210
x86_64                 randconfig-s4-11291210
x86_64                 randconfig-s5-11291210
x86_64                 randconfig-s3-11291303
x86_64                 randconfig-s4-11291303
x86_64                 randconfig-s5-11291303
x86_64                           allmodconfig
m68k                        m5407c3_defconfig
powerpc               mpc85xx_basic_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         cm_x2xx_defconfig
xtensa                  cadence_csp_defconfig
arm                          moxart_defconfig
powerpc                      pmac32_defconfig
arm                           stm32_defconfig
parisc                          712_defconfig
arm                       multi_v4t_defconfig
sparc                             allnoconfig
powerpc                      ppc64e_defconfig
um                               allyesconfig
x86_64                 randconfig-u0-11291202
x86_64                 randconfig-u0-11291224
x86_64                 randconfig-u0-11291232
x86_64                 randconfig-u0-11291307
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
sh                          sdk7786_defconfig
sh                        sh7785lcr_defconfig
i386                   randconfig-h0-11291155
i386                   randconfig-h1-11291155
m68k                       m5208evb_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                              ul2_defconfig
powerpc64                        allyesconfig
xtensa                            allnoconfig
x86_64                randconfig-ne0-11291244
x86_64                randconfig-ne0-11291310
i386                   randconfig-x077-201847
i386                   randconfig-x071-201847
i386                   randconfig-x075-201847
i386                   randconfig-x072-201847
i386                   randconfig-x073-201847
i386                   randconfig-x070-201847
i386                   randconfig-x074-201847
i386                   randconfig-x079-201847
i386                   randconfig-x076-201847
i386                   randconfig-x078-201847
arm                         ebsa110_defconfig
sh                            hp6xx_defconfig
i386                  randconfig-sb0-11291154
powerpc                 mpc836x_mds_defconfig
um                               alldefconfig
mips                        maltaup_defconfig
openrisc                 simple_smp_defconfig
alpha                             allnoconfig
mips                        nlm_xlr_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          rsk7264_defconfig
x86_64                 randconfig-r0-11291219
x86_64                 randconfig-r0-11291307
x86_64                 randconfig-r0-11291320
arm                          ep93xx_defconfig
arm                         s3c6400_defconfig
m68k                            q40_defconfig
mips                  cavium_octeon_defconfig
arm                     davinci_all_defconfig
arm                         lubbock_defconfig
m68k                                defconfig
i386                   randconfig-x0-11291231
i386                   randconfig-x0-11291325

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
