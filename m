From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 20 Oct 2017 02:50:53 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 53d0c6455764b0a6f33eba85ca2c2e1298c0df3d
Message-ID: <59e8f40d.ouYcZvc0xWplSNMC%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 53d0c6455764b0a6f33eba85ca2c2e1298c0df3d  igb: Add support for CBS offload

Regressions in current branch:

drivers/net//ethernet/intel/i40e/i40e_main.c:9017:4: note: in expansion of macro 'dev_dbg'
drivers/net/ethernet/intel/i40e/i40e_main.c:9017:143: error: 'credits' undeclared (first use in this function)
drivers/net/ethernet/intel/i40e/i40e_main.c:9017:4: error: 'credits' undeclared (first use in this function)
drivers/net/ethernet/intel/i40e/i40e_main.c:9017:4: note: in expansion of macro 'dev_dbg'
drivers/net/ethernet/intel/i40e/i40e_main.c:9020:5: error: 'credits' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
|-- alpha-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- arm-allmodconfig
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
|-- arm64-allmodconfig
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
|-- i386-allmodconfig
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
|-- i386-randconfig-x006-201742
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- ia64-allmodconfig
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
|-- ia64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- parisc-allmodconfig
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
|-- parisc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- powerpc-allmodconfig
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
|-- powerpc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- powerpc-defconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- powerpc-ppc64_defconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- s390-allmodconfig
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
|-- s390-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- sparc-allmodconfig
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
|-- sparc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- sparc64-allmodconfig
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
|-- sparc64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- tile-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- tile-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- x86_64-allmodconfig
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
|-- x86_64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- x86_64-rhel
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-7.2
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
|-- xtensa-allmodconfig
|   |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg
`-- xtensa-allyesconfig
    |-- drivers-net-ethernet-intel-i40e-i40e_main.c:error:credits-undeclared-(first-use-in-this-function)
    `-- drivers-net-ethernet-intel-i40e-i40e_main.c:note:in-expansion-of-macro-dev_dbg

elapsed time: 209m

configs tested: 141

mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
c6x                        evmc6678_defconfig
m32r                       m32104ut_defconfig
score                      spct6600_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
i386                               tinyconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                           allmodconfig
i386                     randconfig-n0-201742
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                             allmodconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                              allmodconfig
arm                                   samsung
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm                                      arm5
arm64                            alldefconfig
arm                                        sh
arm                                     arm67
i386                     randconfig-a0-201742
i386                     randconfig-a1-201742
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                 randconfig-x018-201742
x86_64                 randconfig-x011-201742
x86_64                 randconfig-x012-201742
x86_64                 randconfig-x013-201742
x86_64                 randconfig-x019-201742
x86_64                 randconfig-x017-201742
x86_64                 randconfig-x014-201742
x86_64                 randconfig-x015-201742
x86_64                 randconfig-x016-201742
x86_64                 randconfig-x010-201742
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201742
i386                     randconfig-i1-201742
i386                     randconfig-i0-201742
i386                   randconfig-x015-201742
i386                   randconfig-x013-201742
i386                   randconfig-x014-201742
i386                   randconfig-x019-201742
i386                   randconfig-x011-201742
i386                   randconfig-x018-201742
i386                   randconfig-x010-201742
i386                   randconfig-x012-201742
i386                   randconfig-x017-201742
i386                   randconfig-x016-201742
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
i386                   randconfig-x001-201742
i386                   randconfig-x008-201742
i386                   randconfig-x002-201742
i386                   randconfig-x004-201742
i386                   randconfig-x003-201742
i386                   randconfig-x006-201742
i386                   randconfig-x007-201742
i386                   randconfig-x009-201742
i386                   randconfig-x005-201742
i386                   randconfig-x000-201742
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-x074-201742
i386                   randconfig-x077-201742
i386                   randconfig-x071-201742
i386                   randconfig-x076-201742
i386                   randconfig-x073-201742
i386                   randconfig-x079-201742
i386                   randconfig-x078-201742
i386                   randconfig-x072-201742
i386                   randconfig-x070-201742
i386                   randconfig-x075-201742
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                 randconfig-x001-201742
x86_64                 randconfig-x000-201742
x86_64                 randconfig-x004-201742
x86_64                 randconfig-x008-201742
x86_64                 randconfig-x007-201742
x86_64                 randconfig-x006-201742
x86_64                 randconfig-x005-201742
x86_64                 randconfig-x009-201742
x86_64                 randconfig-x003-201742
x86_64                 randconfig-x002-201742

Thanks,
Fengguang
