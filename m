From: kernel test robot <lkp@intel.com>
Date: Sun, 10 Oct 2021 05:14:03 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 45f840993bd1843d39fc79a01eab2995a290ad4b
Message-ID: <6162061b.0A1OWVbfIeDpsAPm%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 45f840993bd1843d39fc79a01eab2995a290ad4b  ice: Refactor PR ethtool ops

Error/Warning reports:

https://lore.kernel.org/lkml/202110100446.b8Uk47Yx-lkp at intel.com
https://lore.kernel.org/lkml/202110100452.v4ILSJCw-lkp at intel.com

Error/Warning in current branch:

ERROR: modpost: "ice_gnss_exit" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_gnss_init" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_gnss_is_gps_present" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
csky-linux-ld: ice_main.c:(.text+0x7c30): undefined reference to `ice_gnss_init'
ice_lib.c:(.text+0x35b2): undefined reference to `ice_gnss_is_gps_present'
ice_main.c:(.text+0x310e): undefined reference to `ice_gnss_exit'
ice_main.c:(.text+0x3b10): undefined reference to `ice_gnss_init'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- csky-randconfig-r031-20211009
|   |-- csky-linux-ld:ice_main.c:(.text):undefined-reference-to-ice_gnss_init
|   |-- ice_lib.c:(.text):undefined-reference-to-ice_gnss_is_gps_present
|   |-- ice_main.c:(.text):undefined-reference-to-ice_gnss_exit
|   `-- ice_main.c:(.text):undefined-reference-to-ice_gnss_init
`-- x86_64-randconfig-s021-20211009
    |-- ERROR:ice_gnss_exit-drivers-net-ethernet-intel-ice-ice.ko-undefined
    |-- ERROR:ice_gnss_init-drivers-net-ethernet-intel-ice-ice.ko-undefined
    `-- ERROR:ice_gnss_is_gps_present-drivers-net-ethernet-intel-ice-ice.ko-undefined

elapsed time: 1555m

configs tested: 214
configs skipped: 5

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211009
powerpc              randconfig-c003-20211009
sh                           se7206_defconfig
sh                   sh7724_generic_defconfig
powerpc                      pasemi_defconfig
x86_64                              defconfig
arm                        cerfcube_defconfig
nios2                         10m50_defconfig
mips                       capcella_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    sam440ep_defconfig
powerpc                      tqm8xx_defconfig
sh                          rsk7269_defconfig
arm                             mxs_defconfig
m68k                        mvme147_defconfig
sh                            shmin_defconfig
arc                         haps_hs_defconfig
mips                    maltaup_xpa_defconfig
mips                          rb532_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                          iss_defconfig
sh                        sh7763rdp_defconfig
mips                        jmr3927_defconfig
mips                       rbtx49xx_defconfig
arm                           h5000_defconfig
m68k                        m5272c3_defconfig
mips                        omega2p_defconfig
sh                        dreamcast_defconfig
mips                           gcw0_defconfig
powerpc                     pq2fads_defconfig
mips                         mpc30x_defconfig
m68k                          multi_defconfig
arm                         axm55xx_defconfig
arm                           stm32_defconfig
powerpc                     pseries_defconfig
xtensa                           alldefconfig
arm                          moxart_defconfig
sh                           se7724_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                       cns3420vb_defconfig
mips                           rs90_defconfig
xtensa                              defconfig
powerpc                     mpc83xx_defconfig
powerpc                          allyesconfig
sh                      rts7751r2d1_defconfig
m68k                          atari_defconfig
sh                   sh7770_generic_defconfig
arm                        mvebu_v7_defconfig
powerpc                 mpc8560_ads_defconfig
sh                            titan_defconfig
sh                             espt_defconfig
arm                      jornada720_defconfig
powerpc                  mpc885_ads_defconfig
arm                       imx_v4_v5_defconfig
arm                          collie_defconfig
sh                               allmodconfig
powerpc                 mpc837x_rdb_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc832x_mds_defconfig
arm                            xcep_defconfig
ia64                             alldefconfig
powerpc                  storcenter_defconfig
powerpc                    gamecube_defconfig
sh                        edosk7705_defconfig
mips                        bcm63xx_defconfig
mips                     loongson1b_defconfig
arm64                            alldefconfig
riscv                             allnoconfig
arm                          ixp4xx_defconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
sh                           se7712_defconfig
sh                   secureedge5410_defconfig
sh                          rsk7264_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                          g5_defconfig
arm                        keystone_defconfig
riscv                               defconfig
arm                        vexpress_defconfig
powerpc                      ppc40x_defconfig
um                                  defconfig
mips                           ip22_defconfig
mips                   sb1250_swarm_defconfig
arm                        realview_defconfig
arm                       versatile_defconfig
powerpc                 mpc836x_mds_defconfig
arm                          gemini_defconfig
m68k                            q40_defconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                               j2_defconfig
sh                           se7619_defconfig
sh                           se7721_defconfig
m68k                        m5307c3_defconfig
arm                   milbeaut_m10v_defconfig
arm                  colibri_pxa270_defconfig
arm                            mps2_defconfig
sh                          lboxre2_defconfig
mips                           xway_defconfig
arm                     eseries_pxa_defconfig
arm                          ep93xx_defconfig
x86_64               randconfig-c001-20211009
arm                  randconfig-c002-20211009
x86_64               randconfig-c001-20211008
i386                 randconfig-c001-20211008
arm                  randconfig-c002-20211008
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20211009
x86_64               randconfig-a005-20211009
x86_64               randconfig-a001-20211009
x86_64               randconfig-a002-20211009
x86_64               randconfig-a004-20211009
x86_64               randconfig-a006-20211009
i386                 randconfig-a001-20211009
i386                 randconfig-a003-20211009
i386                 randconfig-a005-20211009
i386                 randconfig-a004-20211009
i386                 randconfig-a002-20211009
i386                 randconfig-a006-20211009
x86_64               randconfig-a015-20211008
x86_64               randconfig-a012-20211008
x86_64               randconfig-a016-20211008
x86_64               randconfig-a013-20211008
x86_64               randconfig-a011-20211008
x86_64               randconfig-a014-20211008
i386                 randconfig-a013-20211008
i386                 randconfig-a016-20211008
i386                 randconfig-a014-20211008
i386                 randconfig-a011-20211008
i386                 randconfig-a012-20211008
i386                 randconfig-a015-20211008
arc                  randconfig-r043-20211008
s390                 randconfig-r044-20211008
riscv                randconfig-r042-20211008
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20211009
i386                 randconfig-c001-20211009
arm                  randconfig-c002-20211009
s390                 randconfig-c005-20211009
powerpc              randconfig-c003-20211009
riscv                randconfig-c006-20211009
mips                 randconfig-c004-20211009
x86_64               randconfig-a003-20211008
x86_64               randconfig-a005-20211008
x86_64               randconfig-a001-20211008
x86_64               randconfig-a002-20211008
x86_64               randconfig-a004-20211008
x86_64               randconfig-a006-20211008
i386                 randconfig-a001-20211008
i386                 randconfig-a003-20211008
i386                 randconfig-a005-20211008
i386                 randconfig-a004-20211008
i386                 randconfig-a002-20211008
i386                 randconfig-a006-20211008
x86_64               randconfig-a015-20211009
x86_64               randconfig-a012-20211009
x86_64               randconfig-a016-20211009
x86_64               randconfig-a013-20211009
x86_64               randconfig-a011-20211009
x86_64               randconfig-a014-20211009
i386                 randconfig-a013-20211009
i386                 randconfig-a016-20211009
i386                 randconfig-a014-20211009
i386                 randconfig-a012-20211009
i386                 randconfig-a011-20211009
i386                 randconfig-a015-20211009
hexagon              randconfig-r045-20211009
hexagon              randconfig-r041-20211009
s390                 randconfig-r044-20211009
riscv                randconfig-r042-20211009
hexagon              randconfig-r045-20211008
hexagon              randconfig-r041-20211008

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
