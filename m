From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 15 Feb 2018 03:57:42 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 e05f9c1fe5ec7f39f05becb2100715e7d39d1739
Message-ID: <5a8494b6.NwEZ8wViGtVJEIE6%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: e05f9c1fe5ec7f39f05becb2100715e7d39d1739  i40e/i40evf: use SW variables for hang detection

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: sparse: cast from restricted __be32

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:cast-from-restricted-__be32

elapsed time: 133m

configs tested: 161

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
cris                             allyesconfig
parisc                          712_defconfig
sh                           cayman_defconfig
x86_64                 randconfig-a0-02150123
alpha                            alldefconfig
arm                         axm55xx_defconfig
xtensa                  cadence_csp_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-02150227
x86_64                           allmodconfig
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
i386                     randconfig-n0-201806
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-i0-201806
i386                     randconfig-i1-201806
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                      footbridge_defconfig
arm                    vt8500_v6_v7_defconfig
sh                          lboxre2_defconfig
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
i386                     randconfig-a1-201806
i386                     randconfig-a0-201806
x86_64                 randconfig-s0-02150231
x86_64                 randconfig-s1-02150231
x86_64                 randconfig-s2-02150231
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
blackfin                  CM-BF537E_defconfig
cris                             allmodconfig
mips                  maltasmvp_eva_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                                   rhel
x86_64                               rhel-7.2
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201806
i386                     randconfig-s1-201806
i386         randconfig-s1-201806-CONFIG_DEBUG_INFO_REDUCED
x86_64                 randconfig-s3-02150142
x86_64                 randconfig-s4-02150142
x86_64                 randconfig-s5-02150142
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201806
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
powerpc                   bluestone_defconfig
powerpc                     sbc834x_defconfig
sh                      rts7751r2d1_defconfig
x86_64                 randconfig-u0-02150151
i386                               tinyconfig
x86_64                randconfig-ne0-02150211
x86_64                 randconfig-h0-02150210
blackfin             BF527-EZKIT-V2_defconfig
powerpc               mpc85xx_basic_defconfig
sh                         ap325rxa_defconfig
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
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9

Thanks,
Fengguang
