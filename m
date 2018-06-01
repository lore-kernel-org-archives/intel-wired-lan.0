From: kbuild test robot <lkp@intel.com>
Date: Fri, 01 Jun 2018 14:11:45 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 bc8521aff7d84330aa474bc6d77e250a3a7e7333
Message-ID: <5b10e3a1.0biqCuKPTuqljgGp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: bc8521aff7d84330aa474bc6d77e250a3a7e7333  checkpatch.pl: seed camelcase from the provided kernel tree root

TIMEOUT after 600m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 228

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     pseries_defconfig
x86_64                 randconfig-a0-06010555
x86_64                 randconfig-a0-06011338
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
powerpc                      cm5200_defconfig
powerpc                     tqm8560_defconfig
arm                            hisi_defconfig
powerpc                    ge_imp3a_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-06010531
i386                   randconfig-c0-06011333
powerpc                 mpc834x_itx_defconfig
sh                               alldefconfig
i386                   randconfig-x010-201821
i386                   randconfig-x011-201821
i386                   randconfig-x012-201821
i386                   randconfig-x013-201821
i386                   randconfig-x014-201821
i386                   randconfig-x015-201821
i386                   randconfig-x016-201821
i386                   randconfig-x017-201821
i386                   randconfig-x018-201821
i386                   randconfig-x019-201821
x86_64                              fedora-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201821
i386         randconfig-n0-201821-CONFIG_DEBUG_INFO_REDUCED
x86_64                 randconfig-x000-201821
x86_64                 randconfig-x001-201821
x86_64                 randconfig-x002-201821
x86_64                 randconfig-x003-201821
x86_64                 randconfig-x004-201821
x86_64                 randconfig-x005-201821
x86_64                 randconfig-x006-201821
x86_64                 randconfig-x007-201821
x86_64                 randconfig-x008-201821
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
arm                    vt8500_v6_v7_defconfig
mips                        qi_lb60_defconfig
x86_64                 randconfig-v0-05312109
i386                             allmodconfig
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
i386                     randconfig-a0-201821
i386         randconfig-a0-201821-CONFIG_DEBUG_INFO_REDUCED
i386                     randconfig-a1-201821
x86_64                 randconfig-s0-06010407
x86_64                 randconfig-s1-06010407
x86_64                 randconfig-s2-06010407
x86_64                 randconfig-s0-06011315
x86_64                 randconfig-s1-06011315
x86_64                 randconfig-s2-06011315
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                          nuc910_defconfig
arm                        spear6xx_defconfig
powerpc                      makalu_defconfig
powerpc                   motionpro_defconfig
arm                              alldefconfig
arm                            pleb_defconfig
arm                         shannon_defconfig
arm                      acs5k_tiny_defconfig
arm                         hackkit_defconfig
mips                          lasat_defconfig
powerpc                 mpc834x_mds_defconfig
h8300                       h8s-sim_defconfig
mips                        nlm_xlp_defconfig
powerpc                     taishan_defconfig
sh                   secureedge5410_defconfig
arm                        realview_defconfig
powerpc                     skiroot_defconfig
powerpc                      walnut_defconfig
powerpc64                           defconfig
arm                           viper_defconfig
mips                              allnoconfig
mips                malta_kvm_guest_defconfig
sh                     magicpanelr2_defconfig
arm                         em_x270_defconfig
arm                       multi_v4t_defconfig
arm                         s3c2410_defconfig
mips                           ip32_defconfig
arm                  colibri_pxa270_defconfig
parisc                          712_defconfig
sh                          r7785rp_defconfig
ia64                             allmodconfig
mips                         db1xxx_defconfig
mips                     loongson1c_defconfig
sparc64                             defconfig
x86_64                 randconfig-x010-201821
x86_64                 randconfig-x011-201821
x86_64                 randconfig-x012-201821
x86_64                 randconfig-x013-201821
x86_64                 randconfig-x014-201821
x86_64                 randconfig-x015-201821
x86_64                 randconfig-x016-201821
x86_64                 randconfig-x017-201821
x86_64                 randconfig-x018-201821
x86_64                 randconfig-x019-201821
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201821
i386                     randconfig-s1-201821
x86_64                 randconfig-s3-06010451
x86_64                 randconfig-s4-06010451
x86_64                 randconfig-s5-06010451
x86_64                 randconfig-s3-06011241
x86_64                 randconfig-s4-06011241
x86_64                 randconfig-s5-06011241
x86_64                 randconfig-s3-06011325
x86_64                 randconfig-s4-06011325
x86_64                 randconfig-s5-06011325
sparc                            allyesconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201821
i386                   randconfig-b0-06010430
i386                   randconfig-b0-06011321
sparc                               defconfig
sparc64                           allnoconfig
ia64                         bigsur_defconfig
x86_64                 randconfig-b0-05312122
mips                  maltasmvp_eva_defconfig
arm                            lart_defconfig
powerpc                    socrates_defconfig
arm                             ezx_defconfig
arm                          imote2_defconfig
x86_64                 randconfig-u0-06010413
x86_64                 randconfig-u0-06011318
i386                               tinyconfig
powerpc                          allyesconfig
x86_64                randconfig-ne0-06010403
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
x86_64                           allmodconfig
powerpc                   currituck_defconfig
powerpc                     powernv_defconfig
x86_64                randconfig-ws0-06010500
mips                      maltaaprp_defconfig
x86_64                randconfig-ws0-05301812
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
x86_64                                  kexec
mips                        jmr3927_defconfig
powerpc                     tqm8541_defconfig
x86_64                 randconfig-r0-06010500
mips                    maltaup_xpa_defconfig
mips                        vocore2_defconfig
arm                        keystone_defconfig
sh                           se7780_defconfig
arm                         lpc18xx_defconfig
arm                          pxa3xx_defconfig
i386                   randconfig-x0-06010450

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
