From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 09 Jan 2018 01:15:46 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 bbb9587724a75f0ca40b7f1e7259cc0e03f64cc1
Message-ID: <5a53a742.H1KWtRg3fSuXJ5+x%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: bbb9587724a75f0ca40b7f1e7259cc0e03f64cc1  igb: Clear TXSTMP when ptp_tx_work() is timeout

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:46:17: sparse: incorrect type in argument 3 (different base types)

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-int-unsigned-usertype-value-got-ed-int-unsigned-usertype-value

elapsed time: 85m

configs tested: 154

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64       nfsroot-CONFIG_DEBUG_INFO_REDUCED
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-01082204
x86_64                           allmodconfig
x86_64                randconfig-in0-01081252
i386                   randconfig-x015-201801
i386                   randconfig-x019-201801
i386                   randconfig-x010-201801
i386                   randconfig-x014-201801
i386                   randconfig-x011-201801
i386                   randconfig-x012-201801
i386                   randconfig-x017-201801
i386                   randconfig-x016-201801
i386                   randconfig-x013-201801
i386                   randconfig-x018-201801
i386                     randconfig-n0-201801
i386                     randconfig-i0-201801
i386                     randconfig-i1-201801
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
arm                         axm55xx_defconfig
arm                         palmz72_defconfig
arm                         s3c2410_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-a0-201801
i386                     randconfig-a1-201801
i386         randconfig-a1-201801-CONFIG_DEBUG_INFO_REDUCED
x86_64                 randconfig-s0-01090036
x86_64                 randconfig-s1-01090036
x86_64                 randconfig-s2-01090036
x86_64                 randconfig-x017-201801
x86_64                 randconfig-x018-201801
x86_64                 randconfig-x013-201801
x86_64                 randconfig-x016-201801
x86_64                 randconfig-x014-201801
x86_64                 randconfig-x011-201801
x86_64                 randconfig-x012-201801
x86_64                 randconfig-x015-201801
x86_64                 randconfig-x010-201801
x86_64                 randconfig-x019-201801
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201801
i386                     randconfig-s1-201801
x86_64                 randconfig-s3-01082359
x86_64                 randconfig-s4-01082359
x86_64                 randconfig-s5-01082359
i386                             allmodconfig
x86_64                   randconfig-i0-201801
i386                   randconfig-b0-01081713
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-u0-01082358
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
x86_64                randconfig-ne0-01081743
m32r                              allnoconfig
mips                      fuloong2e_defconfig
xtensa                  cadence_csp_defconfig
x86_64                 randconfig-h0-01082354
powerpc64                        allyesconfig
sh                                  defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                randconfig-ws0-01081714
i386                   randconfig-x071-201801
i386                   randconfig-x079-201801
i386                   randconfig-x077-201801
i386                   randconfig-x072-201801
i386                   randconfig-x076-201801
i386                   randconfig-x073-201801
i386                   randconfig-x070-201801
i386                   randconfig-x075-201801
i386                   randconfig-x074-201801
i386                   randconfig-x078-201801
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                 randconfig-x008-201801
x86_64                 randconfig-x000-201801
x86_64                 randconfig-x005-201801
x86_64                 randconfig-x007-201801
x86_64                 randconfig-x009-201801
x86_64                 randconfig-x002-201801
x86_64                 randconfig-x001-201801
x86_64                 randconfig-x006-201801
x86_64                 randconfig-x003-201801
x86_64                 randconfig-x004-201801
i386                   randconfig-x004-201801
i386                   randconfig-x002-201801
i386                   randconfig-x007-201801
i386                   randconfig-x009-201801
i386                   randconfig-x003-201801
i386                   randconfig-x006-201801
i386                   randconfig-x005-201801
i386                   randconfig-x000-201801
i386                   randconfig-x001-201801
i386                   randconfig-x008-201801
i386                   randconfig-x0-01090000

Thanks,
Fengguang
