From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 25 Jan 2018 02:42:33 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 cc0ccd63a667130d87644dbf1a91718b8c2ab519
Message-ID: <5a68d399.mKdjkwh6XNRBq1hk%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: cc0ccd63a667130d87644dbf1a91718b8c2ab519  igb: Do not call netif_device_detach() when PCIe link goes missing

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: sparse: cast from restricted __be32

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:cast-from-restricted-__be32

elapsed time: 71m

configs tested: 181

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-a0-01250043
arm                      footbridge_defconfig
powerpc                      ppc40x_defconfig
sparc64                          allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-01250035
x86_64                randconfig-it0-01250033
i386                   randconfig-x015-201803
i386                   randconfig-x010-201803
i386                   randconfig-x019-201803
i386                   randconfig-x014-201803
i386                   randconfig-x017-201803
i386                   randconfig-x011-201803
i386                   randconfig-x012-201803
i386                   randconfig-x016-201803
i386                   randconfig-x013-201803
i386                   randconfig-x018-201803
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201803
x86_64                 randconfig-x008-201803
x86_64                 randconfig-x005-201803
x86_64                 randconfig-x000-201803
x86_64                 randconfig-x009-201803
x86_64                 randconfig-x007-201803
x86_64                 randconfig-x002-201803
x86_64                 randconfig-x001-201803
x86_64                 randconfig-x006-201803
x86_64                 randconfig-x003-201803
x86_64                 randconfig-x004-201803
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-i0-201803
i386                     randconfig-i1-201803
x86_64                 randconfig-v0-01250141
ia64                        generic_defconfig
m32r                      mappi.smp_defconfig
mips                        omega2p_defconfig
x86_64                 randconfig-x017-201803
x86_64                 randconfig-x018-201803
x86_64                 randconfig-x016-201803
x86_64                 randconfig-x013-201803
x86_64                 randconfig-x014-201803
x86_64                 randconfig-x011-201803
x86_64                 randconfig-x012-201803
x86_64                 randconfig-x015-201803
x86_64                 randconfig-x019-201803
x86_64                 randconfig-x010-201803
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
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
i386                   randconfig-a1-01241352
i386                   randconfig-a0-01241352
x86_64                 randconfig-s0-01250146
x86_64                 randconfig-s1-01250146
x86_64                 randconfig-s2-01250146
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
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
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                          exynos_defconfig
arm                            pleb_defconfig
m68k                          hp300_defconfig
sh                 kfr2r09-romimage_defconfig
sh                   sh7770_generic_defconfig
arm                           omap1_defconfig
blackfin                BF527-EZKIT_defconfig
m68k                       m5475evb_defconfig
mips                         tb0226_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201803
i386                     randconfig-s1-201803
x86_64                           allmodconfig
x86_64                 randconfig-s3-01250043
x86_64                 randconfig-s4-01250043
x86_64                 randconfig-s5-01250043
x86_64                   randconfig-i0-201803
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
blackfin                       IP0X_defconfig
x86_64                 randconfig-u0-01250153
x86_64                 randconfig-u0-01250214
arm                       mainstone_defconfig
arm                         hackkit_defconfig
mips                        workpad_defconfig
x86_64                 randconfig-h0-01242319
x86_64                 randconfig-n0-01242347
blackfin                BF561-EZKIT_defconfig
mn10300                          allmodconfig
s390                                defconfig
i386                  randconfig-sb0-01250139
i386                   randconfig-x004-201803
i386                   randconfig-x002-201803
i386                   randconfig-x007-201803
i386                   randconfig-x003-201803
i386                   randconfig-x009-201803
i386                   randconfig-x000-201803
i386                   randconfig-x006-201803
i386                   randconfig-x005-201803
i386                   randconfig-x001-201803
i386                   randconfig-x008-201803
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
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
x86_64                randconfig-ws0-01250025
x86_64                randconfig-ws0-01250105
i386                   randconfig-x071-201803
i386                   randconfig-x079-201803
i386                   randconfig-x077-201803
i386                   randconfig-x072-201803
i386                   randconfig-x076-201803
i386                   randconfig-x075-201803
i386                   randconfig-x073-201803
i386                   randconfig-x070-201803
i386                   randconfig-x074-201803
i386                   randconfig-x078-201803
c6x                        evmc6472_defconfig
cris                        etraxfs_defconfig
i386                             allmodconfig
i386                   randconfig-x0-01250111

Thanks,
Fengguang
