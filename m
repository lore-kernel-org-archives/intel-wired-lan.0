From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 23 Jan 2018 02:56:33 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 9d574b5a972d6a03922deaa9f836e0833fae7d55
Message-ID: <5a6633e1.JNdUlAQYftPcu1EL%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 9d574b5a972d6a03922deaa9f836e0833fae7d55  fm10k: bump version number

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:3017:43: sparse: restricted __be16 degrades to integer
drivers/net/ethernet/intel/i40evf/i40evf_main.c:2607:49: sparse: invalid assignment: |=
drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: sparse: cast from restricted __be32

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_virtchnl_pf.c:sparse:restricted-__be16-degrades-to-integer
    ??? drivers-net-ethernet-intel-i40evf-i40evf_main.c:sparse:invalid-assignment:
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:cast-from-restricted-__be32

elapsed time: 125m

configs tested: 127

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
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
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
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
i386                   randconfig-a0-01221834
i386                   randconfig-a1-01221834
x86_64                 randconfig-i0-01221022
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
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
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
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig

Thanks,
Fengguang
