From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 14 Feb 2018 05:33:04 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 0d15b42fe361f7a91cf3b620e2042813fe72d339
Message-ID: <5a835990.c3CCP3f/EBL2LnV0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 0d15b42fe361f7a91cf3b620e2042813fe72d339  i40e/i40evf: use SW variables for hang detection

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: sparse: cast from restricted __be32

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:cast-from-restricted-__be32

elapsed time: 113m

configs tested: 131

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-i0-201806
i386                     randconfig-i1-201806
i386                     randconfig-a1-201806
i386                     randconfig-a0-201806
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
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
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201806
i386                     randconfig-s1-201806
x86_64                           allmodconfig
i386                             allmodconfig
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
x86_64                   randconfig-i0-201806
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                                  kexec
x86_64                               rhel-7.2
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

Thanks,
Fengguang
