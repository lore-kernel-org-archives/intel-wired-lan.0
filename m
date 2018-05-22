From: kbuild test robot <lkp@intel.com>
Date: Tue, 22 May 2018 12:01:25 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 c241a874461c2344490b79f2e36cc27338403d30
Message-ID: <5b039615.Rbras8Kd/+9GIojW%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: c241a874461c2344490b79f2e36cc27338403d30  i40iw/i40e: Remove link dependency on i40e

Regressions in current branch:

drivers/infiniband/hw/i40iw/i40iw_main.c:110:6: sparse: symbol 'i40iw_open_inc_ref' was not declared. Should it be static?
drivers/infiniband/hw/i40iw/i40iw_main.c:118:6: sparse: symbol 'i40iw_open_dec_ref' was not declared. Should it be static?

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-infiniband-hw-i40iw-i40iw_main.c:sparse:symbol-i40iw_open_dec_ref-was-not-declared.-Should-it-be-static
    ??? drivers-infiniband-hw-i40iw-i40iw_main.c:sparse:symbol-i40iw_open_inc_ref-was-not-declared.-Should-it-be-static

elapsed time: 346m

configs tested: 224

mips                        bcm47xx_defconfig
sh                   secureedge5410_defconfig
m68k                       m5249evb_defconfig
powerpc                     skiroot_defconfig
arm64                             allnoconfig
x86_64                 randconfig-a0-05220638
x86_64                 randconfig-a0-05220933
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-05221035
alpha                            allmodconfig
arm                            dove_defconfig
x86_64                randconfig-in0-05220615
arm64                               defconfig
powerpc                      mgcoge_defconfig
powerpc                         ps3_defconfig
x86_64                randconfig-it0-05220617
i386                               tinyconfig
i386                   randconfig-x012-201820
i386                   randconfig-x014-201820
i386                   randconfig-x017-201820
i386                   randconfig-x016-201820
i386                   randconfig-x018-201820
i386                   randconfig-x013-201820
i386                   randconfig-x011-201820
i386                   randconfig-x015-201820
i386                   randconfig-x019-201820
i386                   randconfig-x010-201820
x86_64                              fedora-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201820
x86_64                 randconfig-x003-201820
x86_64                 randconfig-x007-201820
x86_64                 randconfig-x000-201820
x86_64                 randconfig-x005-201820
x86_64                 randconfig-x004-201820
x86_64                 randconfig-x001-201820
x86_64                 randconfig-x008-201820
x86_64                 randconfig-x002-201820
x86_64                 randconfig-x006-201820
x86_64                 randconfig-x009-201820
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201820
i386                     randconfig-i1-201820
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm                       netwinder_defconfig
arm                          prima2_defconfig
x86_64                 randconfig-v0-05220642
arm                     am200epdkit_defconfig
powerpc                   bluestone_defconfig
mips                      pistachio_defconfig
sh                              ul2_defconfig
arm                        realview_defconfig
microblaze                       allyesconfig
x86_64                                  kexec
x86_64                 randconfig-g0-05220537
x86_64                 randconfig-g0-05220654
x86_64                 randconfig-g0-05221019
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
x86_64                 randconfig-x011-201820
x86_64                 randconfig-x015-201820
x86_64                 randconfig-x018-201820
x86_64                 randconfig-x010-201820
x86_64                 randconfig-x019-201820
x86_64                 randconfig-x014-201820
x86_64                 randconfig-x013-201820
x86_64                 randconfig-x016-201820
x86_64                 randconfig-x017-201820
x86_64                 randconfig-x012-201820
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
i386                     randconfig-a0-201820
i386                     randconfig-a1-201820
x86_64                 randconfig-s0-05220616
x86_64                 randconfig-s1-05220616
x86_64                 randconfig-s2-05220616
x86_64                 randconfig-s0-05220658
x86_64                 randconfig-s1-05220658
x86_64                 randconfig-s2-05220658
x86_64                 randconfig-s0-05221034
x86_64                 randconfig-s1-05221034
x86_64                 randconfig-s2-05221034
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                         lubbock_defconfig
powerpc                      obs600_defconfig
sh                           se7343_defconfig
sparc64                          allyesconfig
arm                      integrator_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s1-201820
i386                     randconfig-s0-201820
x86_64                           allmodconfig
x86_64                 randconfig-s3-05220611
x86_64                 randconfig-s4-05220611
x86_64                 randconfig-s5-05220611
x86_64                 randconfig-s3-05220703
x86_64                 randconfig-s4-05220703
x86_64                 randconfig-s5-05220703
x86_64                 randconfig-s3-05221040
x86_64                 randconfig-s4-05221040
x86_64                 randconfig-s5-05221040
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                            u300_defconfig
m68k                             allyesconfig
x86_64                   randconfig-i0-201820
i386                   randconfig-b0-05220458
i386                   randconfig-b0-05220659
i386                   randconfig-b0-05221011
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-b0-05220919
arm                          pxa3xx_defconfig
sh                          kfr2r09_defconfig
mips                malta_kvm_guest_defconfig
sh                          rsk7201_defconfig
x86_64                 randconfig-u0-05220544
x86_64                 randconfig-u0-05220729
x86_64                 randconfig-u0-05221037
x86_64                 randconfig-u0-05221109
arm                         orion5x_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     kilauea_defconfig
sparc                       sparc32_defconfig
xtensa                  cadence_csp_defconfig
i386                   randconfig-h0-05220603
i386                   randconfig-h1-05220603
mips                      pic32mzda_defconfig
powerpc                      katmai_defconfig
mips                        bcm63xx_defconfig
xtensa                           allmodconfig
x86_64                randconfig-ne0-05220515
x86_64                randconfig-ne0-05220654
x86_64                randconfig-ne0-05221034
sh                        dreamcast_defconfig
x86_64                 randconfig-h0-05220633
i386                  randconfig-sb0-05220614
i386                   randconfig-x008-201820
i386                   randconfig-x009-201820
i386                   randconfig-x005-201820
i386                   randconfig-x003-201820
i386                   randconfig-x000-201820
i386                   randconfig-x001-201820
i386                   randconfig-x004-201820
i386                   randconfig-x006-201820
i386                   randconfig-x002-201820
i386                   randconfig-x007-201820
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
sh                               alldefconfig
x86_64                randconfig-ws0-05220639
x86_64                randconfig-ws0-05220550
i386                   randconfig-x078-201820
i386                   randconfig-x079-201820
i386                   randconfig-x070-201820
i386                   randconfig-x076-201820
i386                   randconfig-x075-201820
i386                   randconfig-x074-201820
i386                   randconfig-x071-201820
i386                   randconfig-x073-201820
i386                   randconfig-x077-201820
i386                   randconfig-x072-201820
m68k                            mac_defconfig
powerpc                          g5_defconfig
mips                         cobalt_defconfig
openrisc                 simple_smp_defconfig
x86_64                 randconfig-r0-05220605
arm                             mxs_defconfig
i386                   randconfig-x0-05220611
i386                   randconfig-x0-05221021

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
