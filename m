From: kbuild test robot <lkp@intel.com>
Date: Thu, 12 Apr 2018 15:32:14 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD SUCCESS
 aa7087dd5224b3b32d652ae8cd465edaaf8b58fb
Message-ID: <5acf0b7e.daAN2rzZLVbHQ9kT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: aa7087dd5224b3b32d652ae8cd465edaaf8b58fb  ice: Fix initialization for num_nodes_added

elapsed time: 650m

configs tested: 159

The following configs have been built successfully.
More configs may be tested in the coming days.

blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
openrisc                          allnoconfig
powerpc64                        alldefconfig
xtensa                generic_kc705_defconfig
ia64                         bigsur_defconfig
mips                   sb1250_swarm_defconfig
sh                               alldefconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201814
x86_64                 randconfig-x000-201814
x86_64                 randconfig-x001-201814
x86_64                 randconfig-x002-201814
x86_64                 randconfig-x003-201814
x86_64                 randconfig-x004-201814
x86_64                 randconfig-x005-201814
x86_64                 randconfig-x006-201814
x86_64                 randconfig-x007-201814
x86_64                 randconfig-x008-201814
x86_64                 randconfig-x009-201814
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                  colibri_pxa300_defconfig
parisc                          712_defconfig
sh                                allnoconfig
x86_64                 randconfig-g0-04121120
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-a0-201814
i386                     randconfig-a1-201814
x86_64                 randconfig-s0-04121112
x86_64                 randconfig-s1-04121112
x86_64                 randconfig-s2-04121112
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
x86_64                 randconfig-s3-04121031
x86_64                 randconfig-s4-04121031
x86_64                 randconfig-s5-04121031
x86_64                 randconfig-s3-04121052
x86_64                 randconfig-s4-04121052
x86_64                 randconfig-s5-04121052
x86_64                 randconfig-s3-04121129
x86_64                 randconfig-s4-04121129
x86_64                 randconfig-s5-04121129
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201814
powerpc                  mpc885_ads_defconfig
sh                           se7750_defconfig
arm                         cm_x2xx_defconfig
arm                         shannon_defconfig
powerpc                      arches_defconfig
x86_64                 randconfig-u0-04121045
x86_64                 randconfig-u0-04121132
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
i386                   randconfig-h0-04121045
i386                   randconfig-h1-04121045
arm                          ep93xx_defconfig
powerpc                       maple_defconfig
x86_64                           allyesconfig
arm                         ebsa110_defconfig
x86_64                randconfig-ne0-04121035
x86_64                randconfig-ne0-04121133
i386                   randconfig-x000-201814
i386                   randconfig-x001-201814
i386                   randconfig-x002-201814
i386                   randconfig-x003-201814
i386                   randconfig-x004-201814
i386                   randconfig-x005-201814
i386                   randconfig-x006-201814
i386                   randconfig-x007-201814
i386                   randconfig-x008-201814
i386                   randconfig-x009-201814
x86_64                 randconfig-x010-201814
x86_64                 randconfig-x011-201814
x86_64                 randconfig-x012-201814
x86_64                 randconfig-x013-201814
x86_64                 randconfig-x014-201814
x86_64                 randconfig-x015-201814
x86_64                 randconfig-x016-201814
x86_64                 randconfig-x017-201814
x86_64                 randconfig-x018-201814
x86_64                 randconfig-x019-201814
i386                   randconfig-x010-201814
i386                   randconfig-x011-201814
i386                   randconfig-x012-201814
i386                   randconfig-x013-201814
i386                   randconfig-x014-201814
i386                   randconfig-x015-201814
i386                   randconfig-x016-201814
i386                   randconfig-x017-201814
i386                   randconfig-x018-201814
i386                   randconfig-x019-201814
i386                   randconfig-x070-201814
i386                   randconfig-x071-201814
i386                   randconfig-x072-201814
i386                   randconfig-x073-201814
i386                   randconfig-x074-201814
i386                   randconfig-x075-201814
i386                   randconfig-x076-201814
i386                   randconfig-x077-201814
i386                   randconfig-x078-201814
i386                   randconfig-x079-201814
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                   randconfig-x0-04121049

Thanks,
Fengguang
