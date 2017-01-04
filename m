From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 04 Jan 2017 15:05:00 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 6b07d327da8258671ea0bff784d884c4d30949d9
Message-ID: <586c9e9c./qfVMjArWt4yTkaL%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
6b07d327da8258671ea0bff784d884c4d30949d9  i40e: remove duplicate device id from pci table

drivers/net/ethernet/dec/tulip/uli526x.c:948:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/dlink/dl2k.c:1296:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/mdio.c:496:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/mdio.c:496: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'

Error ids grouped by kconfigs:

recent_errors
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-dec-tulip-uli526x.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-dlink-dl2k.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-mdio.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? i386-allyesconfig
??? ??? drivers-net-ethernet-dec-tulip-uli526x.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-dlink-dl2k.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-mdio.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-dec-tulip-uli526x.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-dlink-dl2k.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-mdio.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? mips-ip27_defconfig
??? ??? drivers-net-mdio.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? x86_64-lkp
??? ??? drivers-net-ethernet-dec-tulip-uli526x.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-dlink-dl2k.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-mdio.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? x86_64-randconfig-a0-01041127
    ??? drivers-net-mdio.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode

TIMEOUT after 604m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 228

powerpc                      acadia_defconfig
powerpc                   motionpro_defconfig
sh                             shx3_defconfig
arm                       imx_v6_v7_defconfig
mips                            e55_defconfig
mn10300                     asb2303_defconfig
avr32                       favr-32_defconfig
c6x                         dsk6455_defconfig
sh                  sh7785lcr_32bit_defconfig
i386                     randconfig-a0-201701
x86_64                 randconfig-a0-01040544
x86_64                 randconfig-a0-01041127
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
m68k                       m5249evb_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm5200_defconfig
i386                   randconfig-c0-01040546
i386                   randconfig-c0-01041119
arm                           acs5k_defconfig
m32r                    mappi.nommu_defconfig
tile                             allyesconfig
x86_64                randconfig-in0-01040346
arm                       omap2plus_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                          landisk_defconfig
x86_64                randconfig-it0-01040452
x86_64                 randconfig-v0-01040430
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
m68k                       m5475evb_defconfig
powerpc                 linkstation_defconfig
s390                                defconfig
sh                           se7750_defconfig
x86_64                 randconfig-x011-201701
x86_64                 randconfig-x017-201701
x86_64                 randconfig-x014-201701
x86_64                 randconfig-x016-201701
x86_64                 randconfig-x012-201701
x86_64                 randconfig-x019-201701
x86_64                 randconfig-x013-201701
x86_64                 randconfig-x010-201701
x86_64                 randconfig-x018-201701
x86_64                 randconfig-x015-201701
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                          ixp4xx_defconfig
arm                        mvebu_v7_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                           tegra_defconfig
arm64                            alldefconfig
arm64                            allmodconfig
i386                     randconfig-s0-201701
i386                     randconfig-s1-201701
x86_64                 randconfig-s0-01040449
x86_64                 randconfig-s1-01040449
x86_64                 randconfig-s2-01040449
x86_64                 randconfig-s3-01040508
x86_64                 randconfig-s4-01040508
x86_64                 randconfig-s5-01040508
arm                        multi_v7_defconfig
s390                    performance_defconfig
sh                                allnoconfig
um                                  defconfig
arm                        clps711x_defconfig
arm                         s3c6400_defconfig
arm                         vf610m4_defconfig
h8300                    h8300h-sim_defconfig
blackfin                BF561-EZKIT_defconfig
mips                         mpc30x_defconfig
powerpc                  mpc885_ads_defconfig
sh                                  defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201701
i386                   randconfig-b0-01040538
i386                   randconfig-b0-01041118
arm                            qcom_defconfig
powerpc                      ppc64e_defconfig
sh                 kfr2r09-romimage_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201701
i386                     randconfig-i0-201701
i386                             allyesconfig
x86_64                 randconfig-b0-01040452
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
mips                        jmr3927_defconfig
arm                           efm32_defconfig
mips                           ip27_defconfig
powerpc                     tqm8540_defconfig
x86_64                 randconfig-u0-01040525
x86_64                 randconfig-u0-01041137
arm                              zx_defconfig
mips                             allyesconfig
x86_64                randconfig-ne0-01040556
x86_64                randconfig-ne0-01041049
x86_64                randconfig-ne0-01041128
arm                        cerfcube_defconfig
arm                           u8500_defconfig
powerpc                      pasemi_defconfig
powerpc                    socrates_defconfig
arm                          iop32x_defconfig
m32r                             allyesconfig
mips                      pic32mzda_defconfig
mips                         tb0287_defconfig
i386                   randconfig-x010-201701
i386                   randconfig-x011-201701
i386                   randconfig-x012-201701
i386                   randconfig-x013-201701
i386                   randconfig-x014-201701
i386                   randconfig-x015-201701
i386                   randconfig-x016-201701
i386                   randconfig-x017-201701
i386                   randconfig-x018-201701
i386                   randconfig-x019-201701
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-n0-201701
i386                   randconfig-h0-01040525
i386                   randconfig-h1-01040525
i386                   randconfig-h0-01041042
i386                   randconfig-h1-01041042
i386                   randconfig-h0-01041127
i386                   randconfig-h1-01041127
blackfin             BF527-EZKIT-V2_defconfig
cris                             allmodconfig
powerpc                     ep8248e_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-h0-01041155
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
m32r                             allmodconfig
mips                           ci20_defconfig
arm                         hackkit_defconfig
arm                          pcm027_defconfig
x86_64                 randconfig-n0-01041108
m68k                          multi_defconfig
m68k                           sun3_defconfig
sh                          rsk7269_defconfig
sh                            titan_defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
blackfin                    DNP5370_defconfig
m32r                    m32700ut.up_defconfig
um                               allmodconfig
x86_64                randconfig-ws0-01040351
c6x                        evmc6678_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
powerpc                  iss476-smp_defconfig
mips                        generic_defconfig
sh                        sh7763rdp_defconfig
x86_64                 randconfig-x008-201701
x86_64                 randconfig-x001-201701
x86_64                 randconfig-x009-201701
x86_64                 randconfig-x000-201701
x86_64                 randconfig-x003-201701
x86_64                 randconfig-x006-201701
x86_64                 randconfig-x002-201701
x86_64                 randconfig-x004-201701
x86_64                 randconfig-x007-201701
x86_64                 randconfig-x005-201701
i386                     randconfig-r0-201701
arm                         bcm2835_defconfig
arm                          imote2_defconfig
ia64                            sim_defconfig
arm                    vt8500_v6_v7_defconfig
ia64                             allyesconfig
sh                           se7343_defconfig
i386                   randconfig-x003-201701
i386                   randconfig-x004-201701
i386                   randconfig-x007-201701
i386                   randconfig-x001-201701
i386                   randconfig-x006-201701
i386                   randconfig-x009-201701
i386                   randconfig-x008-201701
i386                   randconfig-x002-201701
i386                   randconfig-x000-201701
i386                   randconfig-x005-201701
i386                   randconfig-x0-01040541
i386                   randconfig-x0-01041139

Thanks,
Fengguang
