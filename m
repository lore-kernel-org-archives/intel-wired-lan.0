From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 14 Jun 2017 16:05:41 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:10GbE] BUILD SUCCESS
 a09c0fc3f5d775231f1884e0e66c495065a461ee
Message-ID: <5940ee55.+qw5a8Qqg7+wv+s0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  10GbE
a09c0fc3f5d775231f1884e0e66c495065a461ee  ixgbe: pci_set_drvdata must be called before register_netdev

elapsed time: 99m

configs tested: 139

The following configs have been built successfully.
More configs may be tested in the coming days.

sh                               allmodconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
x86_64                 randconfig-a0-06141525
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                   randconfig-c0-06141444
cris                       artpec_3_defconfig
m68k                             allyesconfig
powerpc                     tqm5200_defconfig
x86_64                 randconfig-g0-06141533
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                   randconfig-a0-06111806
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
x86_64                 randconfig-x010-201724
x86_64                 randconfig-x019-201724
x86_64                 randconfig-x015-201724
x86_64                 randconfig-x014-201724
x86_64                 randconfig-x012-201724
x86_64                 randconfig-x018-201724
x86_64                 randconfig-x017-201724
x86_64                 randconfig-x016-201724
x86_64                 randconfig-x013-201724
x86_64                 randconfig-x011-201724
i386                               tinyconfig
mips                            ar7_defconfig
mips                      malta_kvm_defconfig
powerpc                             defconfig
powerpc                    ge_imp3a_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201724
i386                   randconfig-b0-06141516
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-u0-06141520
blackfin             BF527-EZKIT-V2_defconfig
ia64                            zx1_defconfig
x86_64                randconfig-ne0-06141516
i386                 randconfig-x013-06140628
i386                 randconfig-x017-06140628
i386                 randconfig-x016-06140628
i386                 randconfig-x018-06140628
i386                 randconfig-x015-06140628
i386                 randconfig-x011-06140628
i386                 randconfig-x019-06140628
i386                 randconfig-x010-06140628
i386                 randconfig-x012-06140628
i386                 randconfig-x014-06140628
x86_64                randconfig-ws0-06132201
x86_64                randconfig-ws0-06140445
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
i386                 randconfig-x070-06120530
i386                 randconfig-x071-06120530
i386                 randconfig-x075-06120530
i386                 randconfig-x079-06120530
i386                 randconfig-x073-06120530
i386                 randconfig-x077-06120530
i386                 randconfig-x072-06120530
i386                 randconfig-x074-06120530
i386                 randconfig-x076-06120530
i386                 randconfig-x078-06120530
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                 randconfig-x006-201724
x86_64                 randconfig-x007-201724
x86_64                 randconfig-x001-201724
x86_64                 randconfig-x004-201724
x86_64                 randconfig-x005-201724
x86_64                 randconfig-x000-201724
x86_64                 randconfig-x008-201724
x86_64                 randconfig-x002-201724
x86_64                 randconfig-x003-201724
x86_64                 randconfig-x009-201724
i386                     randconfig-r0-201724
x86_64                 randconfig-r0-06111139
i386                   randconfig-x006-201724
i386                   randconfig-x009-201724
i386                   randconfig-x008-201724
i386                   randconfig-x002-201724
i386                   randconfig-x001-201724
i386                   randconfig-x000-201724
i386                   randconfig-x005-201724
i386                   randconfig-x007-201724
i386                   randconfig-x004-201724
i386                   randconfig-x003-201724
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig

Thanks,
Fengguang
