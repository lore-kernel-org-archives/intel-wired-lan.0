From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 19 Dec 2017 08:15:17 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 5c54325b75aa66e6f3fd313c513d543eab3fc7f6
Message-ID: <5a385a15.6dRTBFWq2eDLgSy/%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 5c54325b75aa66e6f3fd313c513d543eab3fc7f6  i40e: Disable iWARP VSI PETCP_ENA flag on netdev down events

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:46:17: sparse: incorrect type in argument 3 (different base types)

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-int-unsigned-usertype-value-got-ed-int-unsigned-usertype-value

elapsed time: 146m

configs tested: 139

x86_64                 randconfig-a0-12190649
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                               tinyconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201751
x86_64                 randconfig-x000-201751
x86_64                 randconfig-x001-201751
x86_64                 randconfig-x002-201751
x86_64                 randconfig-x003-201751
x86_64                 randconfig-x004-201751
x86_64                 randconfig-x005-201751
x86_64                 randconfig-x006-201751
x86_64                 randconfig-x007-201751
x86_64                 randconfig-x008-201751
x86_64                 randconfig-x009-201751
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                   randconfig-i0-12180843
i386                   randconfig-i1-12180843
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-x012-201751
x86_64                 randconfig-x010-201751
x86_64                 randconfig-x011-201751
x86_64                 randconfig-x015-201751
x86_64                 randconfig-x019-201751
x86_64                 randconfig-x014-201751
x86_64                 randconfig-x013-201751
x86_64                 randconfig-x016-201751
x86_64                 randconfig-x017-201751
x86_64                 randconfig-x018-201751
i386                   randconfig-a0-12171902
i386                   randconfig-a1-12171902
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                         lpc32xx_defconfig
mips                           jazz_defconfig
mips                       rbtx49xx_defconfig
parisc                           allmodconfig
powerpc                 mpc834x_mds_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s1-201751
i386                     randconfig-s0-201751
x86_64                   randconfig-i0-201751
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
i386                   randconfig-x016-201751
i386                   randconfig-x011-201751
i386                   randconfig-x014-201751
i386                   randconfig-x017-201751
i386                   randconfig-x019-201751
i386                   randconfig-x018-201751
i386                   randconfig-x010-201751
i386                   randconfig-x013-201751
i386                   randconfig-x015-201751
i386                   randconfig-x012-201751
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
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
x86_64                                  kexec
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
i386                   randconfig-x072-201751
i386                   randconfig-x078-201751
i386                   randconfig-x071-201751
i386                   randconfig-x077-201751
i386                   randconfig-x070-201751
i386                   randconfig-x074-201751
i386                   randconfig-x073-201751
i386                   randconfig-x079-201751
i386                   randconfig-x076-201751
i386                   randconfig-x075-201751
i386                             allmodconfig
i386                   randconfig-x007-201751
i386                   randconfig-x008-201751
i386                   randconfig-x009-201751
i386                   randconfig-x004-201751
i386                   randconfig-x002-201751
i386                   randconfig-x005-201751
i386                   randconfig-x001-201751
i386                   randconfig-x006-201751
i386                   randconfig-x003-201751
i386                   randconfig-x000-201751

Thanks,
Fengguang
