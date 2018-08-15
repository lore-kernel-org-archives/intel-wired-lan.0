From: kbuild test robot <lkp@intel.com>
Date: Wed, 15 Aug 2018 20:01:20 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 ef54ce1aee953f82be165ed105fb47fd4431f607
Message-ID: <5b741610.gPoYpSx8FsuyJSiw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: ef54ce1aee953f82be165ed105fb47fd4431f607  ixgbevf: enable VF ipsec offload operations

TIMEOUT after 622m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 21

alpha                            allmodconfig
alpha                            allyesconfig
i386                               tinyconfig
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
sh                               allmodconfig
sh                               allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
x86_64                           allyesconfig
xtensa                           allmodconfig

configs tested: 231

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                      jornada720_defconfig
arm                           viper_defconfig
ia64                                defconfig
mips                                defconfig
x86_64                 randconfig-a0-08151048
x86_64                 randconfig-a0-08151417
x86_64                 randconfig-a0-08151617
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
arm                           corgi_defconfig
sh                         apsh4a3a_defconfig
mips                           xway_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                  colibri_pxa270_defconfig
powerpc                      makalu_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-08150927
i386                   randconfig-c0-08151417
i386                   randconfig-c0-08151651
x86_64                              fedora-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201832
i386                   randconfig-n0-08151416
i386         randconfig-n0-201832+bisect_validate
x86_64                 randconfig-x009-201832
x86_64                 randconfig-x000-201832
x86_64                 randconfig-x004-201832
x86_64                 randconfig-x001-201832
x86_64                 randconfig-x003-201832
x86_64                 randconfig-x007-201832
x86_64                 randconfig-x008-201832
x86_64                 randconfig-x005-201832
x86_64                 randconfig-x002-201832
x86_64                 randconfig-x006-201832
ia64                             alldefconfig
ia64                              allnoconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201832
i386                     randconfig-i1-201832
i386                   randconfig-i0-08151416
i386                   randconfig-i1-08151416
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
x86_64                 randconfig-v0-08151418
mips                      fuloong2e_defconfig
mips                      pistachio_defconfig
arm                       cns3420vb_defconfig
powerpc                      walnut_defconfig
x86_64                                  kexec
x86_64                 randconfig-g0-08150939
x86_64                 randconfig-g0-08151425
i386                             allmodconfig
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
i386                     randconfig-a1-201832
i386                     randconfig-a0-201832
i386                   randconfig-a0-08151425
i386                   randconfig-a1-08151425
x86_64                 randconfig-s0-08151001
x86_64                 randconfig-s1-08151001
x86_64                 randconfig-s2-08151001
x86_64                 randconfig-s0-08151425
x86_64                 randconfig-s1-08151425
x86_64                 randconfig-s2-08151425
x86_64                 randconfig-s0-08151505
x86_64                 randconfig-s1-08151505
x86_64                 randconfig-s2-08151505
x86_64                 randconfig-s0-08151648
x86_64                 randconfig-s1-08151648
x86_64                 randconfig-s2-08151648
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                        realview_defconfig
powerpc                     redwood_defconfig
riscv                               defconfig
xtensa                           allyesconfig
sh                                  defconfig
x86_64                            allnoconfig
mips                      bmips_stb_defconfig
mips                           ip28_defconfig
sh                           se7780_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201832
i386                     randconfig-s1-201832
i386                   randconfig-s0-08151431
i386                   randconfig-s1-08151431
x86_64                           allmodconfig
x86_64                 randconfig-s3-08150929
x86_64                 randconfig-s4-08150929
x86_64                 randconfig-s5-08150929
x86_64                 randconfig-s3-08151431
x86_64                 randconfig-s4-08151431
x86_64                 randconfig-s5-08151431
x86_64                 randconfig-s3-08151638
x86_64                 randconfig-s4-08151638
x86_64                 randconfig-s5-08151638
arm                           u8500_defconfig
powerpc                       ep405_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201832
x86_64                 randconfig-i0-08151418
i386                   randconfig-b0-08151418
i386                   randconfig-b0-08151628
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
powerpc                     stx_gp3_defconfig
x86_64                 randconfig-u0-08151450
x86_64                 randconfig-u0-08151657
mips                       bmips_be_defconfig
sh                           se7619_defconfig
sh                   sh7770_generic_defconfig
sh                            shmin_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     virtex5_defconfig
powerpc                     mpc83xx_defconfig
x86_64                randconfig-ne0-08151450
x86_64                randconfig-ne0-08151613
m68k                        m5272c3_defconfig
mips                   sb1250_swarm_defconfig
sparc                            alldefconfig
x86_64                 randconfig-h0-08150938
i386                   randconfig-x002-201832
i386                   randconfig-x003-201832
i386                   randconfig-x005-201832
i386                   randconfig-x008-201832
i386                   randconfig-x000-201832
i386                   randconfig-x007-201832
i386                   randconfig-x001-201832
i386                   randconfig-x004-201832
i386                   randconfig-x009-201832
i386                   randconfig-x006-201832
x86_64                 randconfig-x019-201832
x86_64                 randconfig-x013-201832
x86_64                 randconfig-x017-201832
x86_64                 randconfig-x012-201832
x86_64                 randconfig-x018-201832
x86_64                 randconfig-x010-201832
x86_64                 randconfig-x014-201832
x86_64                 randconfig-x016-201832
x86_64                 randconfig-x011-201832
x86_64                 randconfig-x015-201832
i386                   randconfig-x018-201832
i386                   randconfig-x017-201832
i386                   randconfig-x010-201832
i386                   randconfig-x016-201832
i386                   randconfig-x013-201832
i386                   randconfig-x011-201832
i386                   randconfig-x015-201832
i386                   randconfig-x019-201832
i386                   randconfig-x014-201832
i386                   randconfig-x012-201832
i386                   randconfig-x070-201832
i386                   randconfig-x071-201832
i386                   randconfig-x072-201832
i386                   randconfig-x073-201832
i386                   randconfig-x074-201832
i386                   randconfig-x075-201832
i386                   randconfig-x076-201832
i386                   randconfig-x077-201832
i386                   randconfig-x078-201832
i386                   randconfig-x079-201832
arm                         mv78xx0_defconfig
parisc                      default_defconfig
i386                  randconfig-sb0-08150931
i386                  randconfig-sb0-08151416
mips                        bcm63xx_defconfig
powerpc                         wii_defconfig
x86_64                randconfig-ws0-08151423
x86_64                randconfig-ws0-08151420
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
s390                             allmodconfig
arm                        trizeps4_defconfig
mips                        generic_defconfig
x86_64                 randconfig-r0-08151504
m68k                          atari_defconfig
powerpc           ps3_petitboot_nfs_defconfig
s390                             allyesconfig
i386                   randconfig-x0-08150949
i386                   randconfig-x0-08151416
i386                   randconfig-x0-08151556

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
