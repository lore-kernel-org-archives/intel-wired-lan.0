From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 10 Oct 2017 05:56:56 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 4e526f98c0a1b39716b61ec6e033f42e7b5ac199
Message-ID: <59dbf0a8.MeUv7GNQ7r4DqUra%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 4e526f98c0a1b39716b61ec6e033f42e7b5ac199  i40e: convert i40e_set_link_ksettings to new API

Regressions in current branch:

ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
ERROR: "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
i40e_main.c:(.text+0xa560): undefined reference to `__aeabi_uldivmod'

Error ids grouped by kconfigs:

recent_errors
??? arm-allmodconfig
??? ??? ERROR:__aeabi_uldivmod-drivers-net-ethernet-intel-i40e-i40e.ko-undefined
??? arm-allyesconfig
??? ??? i40e_main.c:(.text):undefined-reference-to-__aeabi_uldivmod
??? i386-allmodconfig
    ??? ERROR:__udivdi3-drivers-net-ethernet-intel-i40e-i40e.ko-undefined

elapsed time: 162m

configs tested: 178

arm                            qcom_defconfig
m68k                             allmodconfig
sh                           sh2007_defconfig
x86_64                 randconfig-a0-10100431
i386                               tinyconfig
i386                   randconfig-n0-10082251
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
x86_64                 randconfig-v0-10100411
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
i386                   randconfig-a0-10090129
i386                   randconfig-a1-10090129
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
blackfin             BF527-TLL6527M_defconfig
mips                            ar7_defconfig
sh                           se7705_defconfig
sh                            shmin_defconfig
sh                             shx3_defconfig
blackfin                BF527-EZKIT_defconfig
powerpc                     akebono_defconfig
powerpc                   motionpro_defconfig
powerpc                      virtex_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-s0-201741
i386                     randconfig-s1-201741
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                         mv78xx0_defconfig
mn10300                          allmodconfig
sh                        sh7763rdp_defconfig
x86_64                   randconfig-i0-201741
i386                   randconfig-b0-10100353
i386                   randconfig-b0-10100451
arm                          pxa3xx_defconfig
arm                        raumfeld_defconfig
arm                           spitz_defconfig
powerpc                  iss476-smp_defconfig
x86_64                 randconfig-b0-10100339
arm                              allyesconfig
arm                             ezx_defconfig
m68k                        mvme16x_defconfig
blackfin                    PNAV-10_defconfig
mips                         tb0219_defconfig
sparc64                          alldefconfig
x86_64                 randconfig-u0-10100414
x86_64                 randconfig-u0-10100443
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                   randconfig-x014-201741
i386                   randconfig-x013-201741
i386                   randconfig-x015-201741
i386                   randconfig-x019-201741
i386                   randconfig-x011-201741
i386                   randconfig-x018-201741
i386                   randconfig-x010-201741
i386                   randconfig-x017-201741
i386                   randconfig-x012-201741
i386                   randconfig-x016-201741
cris                             alldefconfig
powerpc                      bamboo_defconfig
arm                       spear13xx_defconfig
powerpc                      pcm030_defconfig
mips                           mtx1_defconfig
sh                          r7780mp_defconfig
x86_64                randconfig-ne0-10100415
x86_64                                    lkp
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-n0-10100438
x86_64                 randconfig-n0-10100502
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                  randconfig-sb0-10100436
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
x86_64                                  kexec
i386                   randconfig-x074-201741
i386                   randconfig-x076-201741
i386                   randconfig-x071-201741
i386                   randconfig-x077-201741
i386                   randconfig-x073-201741
i386                   randconfig-x079-201741
i386                   randconfig-x072-201741
i386                   randconfig-x078-201741
i386                   randconfig-x075-201741
i386                   randconfig-x070-201741
powerpc                       maple_defconfig
x86_64                 randconfig-x001-201741
x86_64                 randconfig-x000-201741
x86_64                 randconfig-x004-201741
x86_64                 randconfig-x008-201741
x86_64                 randconfig-x006-201741
x86_64                 randconfig-x007-201741
x86_64                 randconfig-x005-201741
x86_64                 randconfig-x009-201741
x86_64                 randconfig-x003-201741
x86_64                 randconfig-x002-201741
i386                   randconfig-x001-201741
i386                   randconfig-x008-201741
i386                   randconfig-x003-201741
i386                   randconfig-x004-201741
i386                   randconfig-x002-201741
i386                   randconfig-x006-201741
i386                   randconfig-x007-201741
i386                   randconfig-x009-201741
i386                   randconfig-x000-201741
i386                   randconfig-x005-201741

Thanks,
Fengguang
