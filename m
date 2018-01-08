From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 09 Jan 2018 05:24:29 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 5da8ea49d04aacbb792b52d05335c6f41cf6b7c9
Message-ID: <5a53e18d.WOgHMz6fnOsaxTzr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 5da8ea49d04aacbb792b52d05335c6f41cf6b7c9  i40evf: ignore link up if not running

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:46:17: sparse: incorrect type in argument 3 (different base types)

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-int-unsigned-usertype-value-got-ed-int-unsigned-usertype-value

elapsed time: 244m

configs tested: 161

x86_64                 randconfig-a0-01090338
i386                   randconfig-c0-01090309
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
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-n0-201801
i386         randconfig-i0-201801-CONFIG_DEBUG_INFO_REDUCED
i386                     randconfig-i0-201801
i386                     randconfig-i1-201801
m32r                         opsput_defconfig
m68k                       m5475evb_defconfig
sh                        edosk7760_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                 randconfig-g0-01090314
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
score                      spct6600_defconfig
xtensa                          iss_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
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
i386                     randconfig-a1-201801
i386         randconfig-a1-201801-CONFIG_DEBUG_INFO_REDUCED
i386                     randconfig-a0-201801
x86_64                 randconfig-s0-01090309
x86_64                 randconfig-s1-01090309
x86_64                 randconfig-s2-01090309
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                          dev88_defconfig
ia64                             allyesconfig
m68k                         amcore_defconfig
mips                        nlm_xlp_defconfig
powerpc                 xes_mpc85xx_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201801
i386                     randconfig-s1-201801
x86_64                 randconfig-s3-01090355
x86_64                 randconfig-s4-01090355
x86_64                 randconfig-s5-01090355
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201801
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                              allyesconfig
arm                           u8500_defconfig
powerpc                      virtex_defconfig
x86_64                 randconfig-u0-01090334
x86_64                randconfig-ne0-01090237
mn10300                     asb2303_defconfig
um                               allmodconfig
arm                          simpad_defconfig
xtensa                           allmodconfig
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
x86_64                 randconfig-n0-01090331
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                  randconfig-sb0-01090246
x86_64                           allmodconfig
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
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                randconfig-ws0-01090245
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
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
blackfin                    PNAV-10_defconfig
openrisc                 simple_smp_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
