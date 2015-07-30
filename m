From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 30 Jul 2015 09:22:39 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 a364c3dd87afb7925784973f27e7eb65b9ad80bb BUILD DONE
Message-ID: <55b97c5f.ZujCV9H90HeuOPlt%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
a364c3dd87afb7925784973f27e7eb65b9ad80bb  ixgbe: Add new X550EM SFP+ device ID

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:1499:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u32' [-Wformat=]
drivers/net/ethernet/intel/i40e/i40e_main.c:2911:18: error: 'I40E_FLAG_IWARP_ENABLED' undeclared (first use in this function)
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:153:1-7: WARNING: end returns can be simpified

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:WARNING:end-returns-can-be-simpified
??? i386-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? i386-randconfig-x003-07271403
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:I40E_FLAG_IWARP_ENABLED-undeclared-(first-use-in-this-function)

elapsed time: 114m

configs tested: 96

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                     randconfig-a0-201530
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                             allyesconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
x86_64                            allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201530
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201530
i386                     randconfig-i0-201530
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                     randconfig-n1-201530
i386                     randconfig-n0-201530
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                                    lkp
x86_64                                   rhel
arm                                    sa1100
arm                          prima2_defconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                       spear13xx_defconfig
arm                                  iop-adma
arm                       imx_v6_v7_defconfig
arm                          marzen_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
x86_64               randconfig-x001-07271403
x86_64               randconfig-x006-07271403
x86_64               randconfig-x007-07271403
x86_64               randconfig-x002-07271403
x86_64               randconfig-x005-07271403
x86_64               randconfig-x009-07271403
x86_64               randconfig-x004-07271403
x86_64               randconfig-x003-07271403
x86_64               randconfig-x000-07271403
x86_64               randconfig-x008-07271403
i386                     randconfig-r0-201530
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
x86_64                           allmodconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
i386                 randconfig-x001-07271403
i386                 randconfig-x008-07271403
i386                 randconfig-x004-07271403
i386                 randconfig-x003-07271403
i386                 randconfig-x002-07271403
i386                 randconfig-x009-07271403
i386                 randconfig-x006-07271403
i386                 randconfig-x005-07271403
i386                 randconfig-x000-07271403
i386                 randconfig-x007-07271403
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
