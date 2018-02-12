From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 13 Feb 2018 01:42:40 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 5c8afa283ce2bab06bd329da995356fc05f3eb98
Message-ID: <5a81d210.0QYI2JBu/J8uLgHa%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 5c8afa283ce2bab06bd329da995356fc05f3eb98  ixgbe: fix crash in build_skb Rx code path

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: sparse: cast from restricted __be32

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:cast-from-restricted-__be32

elapsed time: 118m

configs tested: 187

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
mn10300                           allnoconfig
powerpc                      obs600_defconfig
powerpc                      ppc40x_defconfig
arm                        mvebu_v5_defconfig
powerpc                  iss476-smp_defconfig
tile                             alldefconfig
x86_64                 randconfig-a0-02122358
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
mips                     loongson1c_defconfig
um                                allnoconfig
xtensa                           allyesconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-02122117
i386                   randconfig-x010-201806
i386                   randconfig-x019-201806
i386                   randconfig-x015-201806
i386                   randconfig-x014-201806
i386                   randconfig-x017-201806
i386                   randconfig-x012-201806
i386                   randconfig-x011-201806
i386                   randconfig-x016-201806
i386                   randconfig-x018-201806
i386                   randconfig-x013-201806
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-n0-02120117
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-i0-201806
i386                     randconfig-i1-201806
i386         randconfig-i1-201806+bisect_validate
blackfin                  CM-BF537E_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-g0-02122315
i386                             allmodconfig
x86_64                 randconfig-x017-201806
x86_64                 randconfig-x018-201806
x86_64                 randconfig-x016-201806
x86_64                 randconfig-x013-201806
x86_64                 randconfig-x011-201806
x86_64                 randconfig-x014-201806
x86_64                 randconfig-x015-201806
x86_64                 randconfig-x012-201806
x86_64                 randconfig-x019-201806
x86_64                 randconfig-x010-201806
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
i386                     randconfig-a1-201806
i386                     randconfig-a0-201806
x86_64                 randconfig-s0-02122227
x86_64                 randconfig-s1-02122227
x86_64                 randconfig-s2-02122227
x86_64                 randconfig-s0-02130009
x86_64                 randconfig-s1-02130009
x86_64                 randconfig-s2-02130009
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
arm                         cm_x300_defconfig
arm                         lpc18xx_defconfig
mips                            e55_defconfig
powerpc                    klondike_defconfig
sparc64                          allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.2
i386                   randconfig-s0-02121625
i386                   randconfig-s1-02121625
x86_64                 randconfig-s3-02122226
x86_64                 randconfig-s4-02122226
x86_64                 randconfig-s5-02122226
i386                               tinyconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                 randconfig-i0-02121058
i386                   randconfig-b0-02122155
x86_64                 randconfig-b0-02122350
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
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
arm                         at91_dt_defconfig
parisc                           allmodconfig
powerpc                     rainier_defconfig
x86_64                 randconfig-u0-02122346
i386                   randconfig-h0-02122108
i386                   randconfig-h1-02122108
x86_64                randconfig-ne0-02122231
x86_64                randconfig-ne0-02130058
x86_64                 randconfig-h0-02122134
powerpc                      katmai_defconfig
sh                          lboxre2_defconfig
i386                   randconfig-x004-201806
i386                   randconfig-x007-201806
i386                   randconfig-x002-201806
i386                   randconfig-x003-201806
i386                   randconfig-x009-201806
i386                   randconfig-x000-201806
i386                   randconfig-x005-201806
i386                   randconfig-x006-201806
i386                   randconfig-x008-201806
i386                   randconfig-x001-201806
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-x008-201806
x86_64                 randconfig-x005-201806
x86_64                 randconfig-x000-201806
x86_64                 randconfig-x002-201806
x86_64                 randconfig-x009-201806
x86_64                 randconfig-x007-201806
x86_64                 randconfig-x006-201806
x86_64                 randconfig-x001-201806
x86_64                 randconfig-x003-201806
x86_64                 randconfig-x004-201806
arm                               allnoconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
i386                   randconfig-x071-201806
i386                   randconfig-x079-201806
i386                   randconfig-x072-201806
i386                   randconfig-x077-201806
i386                   randconfig-x076-201806
i386                   randconfig-x075-201806
i386                   randconfig-x070-201806
i386                   randconfig-x073-201806
i386                   randconfig-x078-201806
i386                   randconfig-x074-201806
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                 randconfig-r0-02122346

Thanks,
Fengguang
