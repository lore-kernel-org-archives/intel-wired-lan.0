From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 07 Feb 2018 05:54:56 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 afd3bf0f6cfee9c249aa4e42b258d4ea75670d08
Message-ID: <5a7a2430.DK/pvpSY0REmfoy5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: afd3bf0f6cfee9c249aa4e42b258d4ea75670d08  igb: Fix a test with HWTSTAMP_TX_ON

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: sparse: cast from restricted __be32

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:cast-from-restricted-__be32

elapsed time: 92m

configs tested: 157

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-a0-02070430
i386                   randconfig-c0-02070320
i386                               tinyconfig
i386                   randconfig-x019-201805
i386                   randconfig-x010-201805
i386                   randconfig-x015-201805
i386                   randconfig-x014-201805
i386                   randconfig-x011-201805
i386                   randconfig-x012-201805
i386                   randconfig-x017-201805
i386                   randconfig-x016-201805
i386                   randconfig-x018-201805
i386                   randconfig-x013-201805
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201805
i386                     randconfig-i0-201805
i386                     randconfig-i1-201805
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
blackfin                BF561-EZKIT_defconfig
openrisc                         allmodconfig
sh                           se7619_defconfig
x86_64                 randconfig-g0-02070433
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                 randconfig-x017-201805
x86_64                 randconfig-x018-201805
x86_64                 randconfig-x013-201805
x86_64                 randconfig-x016-201805
x86_64                 randconfig-x011-201805
x86_64                 randconfig-x014-201805
x86_64                 randconfig-x012-201805
x86_64                 randconfig-x015-201805
x86_64                 randconfig-x010-201805
x86_64                 randconfig-x019-201805
arm                        realview_defconfig
mips                          rb532_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     stx_gp3_defconfig
sh                           cayman_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                     randconfig-s0-201805
i386                     randconfig-s1-201805
arm                         at91_dt_defconfig
arm                         nhk8815_defconfig
powerpc                   motionpro_defconfig
sh                             sh03_defconfig
x86_64                 randconfig-i0-02051046
i386                   randconfig-b0-02070356
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-b0-02070124
x86_64                           allmodconfig
ia64                             allmodconfig
x86_64                 randconfig-u0-02070323
i386                   randconfig-h0-02062316
i386                   randconfig-h1-02062316
arm                          collie_defconfig
arm                       mainstone_defconfig
blackfin                  CM-BF537E_defconfig
x86_64                 randconfig-h0-02070402
arm                        spear6xx_defconfig
powerpc                     tqm8548_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-x004-201805
i386                   randconfig-x007-201805
i386                   randconfig-x002-201805
i386                   randconfig-x009-201805
i386                   randconfig-x003-201805
i386                   randconfig-x006-201805
i386                   randconfig-x005-201805
i386                   randconfig-x000-201805
i386                   randconfig-x008-201805
i386                   randconfig-x001-201805
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
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
x86_64                             acpi-redef
arm                               allnoconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
i386                   randconfig-x071-201805
i386                   randconfig-x079-201805
i386                   randconfig-x072-201805
i386                   randconfig-x077-201805
i386                   randconfig-x076-201805
i386                   randconfig-x073-201805
i386                   randconfig-x070-201805
i386                   randconfig-x075-201805
i386                   randconfig-x078-201805
i386                   randconfig-x074-201805
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                 randconfig-x008-201805
x86_64                 randconfig-x000-201805
x86_64                 randconfig-x005-201805
x86_64                 randconfig-x002-201805
x86_64                 randconfig-x007-201805
x86_64                 randconfig-x009-201805
x86_64                 randconfig-x001-201805
x86_64                 randconfig-x006-201805
x86_64                 randconfig-x003-201805
x86_64                 randconfig-x004-201805
x86_64                 randconfig-r0-02070316
i386                             allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9

Thanks,
Fengguang
