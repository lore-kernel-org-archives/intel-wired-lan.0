From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 08 Mar 2017 23:00:24 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 38b663a64bd1d0738b147787adbb967c31aeb76a
Message-ID: <58c01c88.A6qUYA+turAfqnSq%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
38b663a64bd1d0738b147787adbb967c31aeb76a  ixgbe: Add support for maximum headroom when using build_skb

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3102:32-37: ERROR: invalid reference to the index variable of the iterator on line 3056

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line

elapsed time: 190m

configs tested: 187

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                           tegra_defconfig
m68k                          multi_defconfig
mips                      pic32mzda_defconfig
i386                     randconfig-a0-201710
x86_64                 randconfig-a0-03082030
powerpc                    amigaone_defconfig
powerpc                     asp8347_defconfig
um                               allyesconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-03082015
x86_64                randconfig-in0-03082020
arm                          lpd270_defconfig
arm                        magician_defconfig
arm64                               defconfig
x86_64                randconfig-it0-03082029
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-v0-03081920
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                            hisi_defconfig
arm                         s3c2410_defconfig
arm                           spitz_defconfig
x86_64                 randconfig-g0-03081942
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
arm                            qcom_defconfig
parisc                           allmodconfig
um                                allnoconfig
xtensa                  audio_kc705_defconfig
x86_64                 randconfig-x015-201710
x86_64                 randconfig-x012-201710
x86_64                 randconfig-x017-201710
x86_64                 randconfig-x010-201710
x86_64                 randconfig-x018-201710
x86_64                 randconfig-x011-201710
x86_64                 randconfig-x019-201710
x86_64                 randconfig-x013-201710
x86_64                 randconfig-x014-201710
x86_64                 randconfig-x016-201710
m68k                           sun3_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s0-201710
i386                     randconfig-s1-201710
x86_64                 randconfig-s0-03082041
x86_64                 randconfig-s1-03082041
x86_64                 randconfig-s2-03082041
x86_64                 randconfig-s3-03082038
x86_64                 randconfig-s4-03082038
x86_64                 randconfig-s5-03082038
i386                               tinyconfig
ia64                             alldefconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     sbc834x_defconfig
x86_64                   randconfig-i0-201710
i386                   randconfig-b0-03082025
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201710
i386                     randconfig-i1-201710
x86_64                           allmodconfig
arm                         bcm2835_defconfig
mips                             allmodconfig
tile                              allnoconfig
x86_64                 randconfig-u0-03082024
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
arm                        mvebu_v5_defconfig
arm                       omap2plus_defconfig
powerpc               corenet_basic_defconfig
x86_64                randconfig-ne0-03082019
x86_64                           allyesconfig
arm                        mini2440_defconfig
m68k                        mvme147_defconfig
i386                   randconfig-x014-201710
i386                   randconfig-x010-201710
i386                   randconfig-x016-201710
i386                   randconfig-x017-201710
i386                   randconfig-x013-201710
i386                   randconfig-x019-201710
i386                   randconfig-x012-201710
i386                   randconfig-x015-201710
i386                   randconfig-x011-201710
i386                   randconfig-x018-201710
i386                     randconfig-n0-201710
i386                   randconfig-h0-03081911
i386                   randconfig-h1-03081911
x86_64                                  kexec
x86_64                               rhel-7.2
x86_64       rhel-7.2+CONFIG_DEBUG_INFO_REDUCED
x86_64                 randconfig-n0-03082141
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
i386                  randconfig-sb0-03081848
x86_64                randconfig-ws0-03082001
x86_64                randconfig-ws0-03081933
i386                 randconfig-x073-03081212
i386                 randconfig-x074-03081212
i386                 randconfig-x071-03081212
i386                 randconfig-x078-03081212
i386                 randconfig-x079-03081212
i386                 randconfig-x072-03081212
i386                 randconfig-x077-03081212
i386                 randconfig-x070-03081212
i386                 randconfig-x076-03081212
i386                 randconfig-x075-03081212
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                 randconfig-x004-201710
x86_64                 randconfig-x009-201710
x86_64                 randconfig-x003-201710
x86_64                 randconfig-x008-201710
x86_64                 randconfig-x002-201710
x86_64                 randconfig-x000-201710
x86_64                 randconfig-x007-201710
x86_64                 randconfig-x005-201710
x86_64                 randconfig-x006-201710
x86_64                 randconfig-x001-201710
x86_64                                   rhel
i386                     randconfig-r0-201710
x86_64                 randconfig-r0-03081916
arm                           sama5_defconfig
blackfin                BF548-EZKIT_defconfig
powerpc                     tqm8560_defconfig
i386                   randconfig-x005-201710
i386                   randconfig-x002-201710
i386                   randconfig-x006-201710
i386                   randconfig-x003-201710
i386                   randconfig-x007-201710
i386                   randconfig-x008-201710
i386                   randconfig-x001-201710
i386                   randconfig-x000-201710
i386                   randconfig-x009-201710
i386                   randconfig-x004-201710
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
i386                   randconfig-x0-03081853

Thanks,
Fengguang
