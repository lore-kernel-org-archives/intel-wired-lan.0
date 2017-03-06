From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 06 Mar 2017 12:43:33 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 bd17d7702c8c3ef35b01d5acdad6790cecb86562
Message-ID: <58bce8f5.z5aJw5rJFJqer/3u%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
bd17d7702c8c3ef35b01d5acdad6790cecb86562  ixgbe: Add support for maximum headroom when using build_skb

drivers/net/ethernet/intel/i40e/i40e_txrx.c:1844:61: error: 'lpbk' undeclared (first use in this function)
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2306:61: error: 'lpbk' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:lpbk-undeclared-(first-use-in-this-function)
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:lpbk-undeclared-(first-use-in-this-function)
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:lpbk-undeclared-(first-use-in-this-function)
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:lpbk-undeclared-(first-use-in-this-function)
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:lpbk-undeclared-(first-use-in-this-function)
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:lpbk-undeclared-(first-use-in-this-function)
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:lpbk-undeclared-(first-use-in-this-function)
??? x86_64-rhel-7.2.dx
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:lpbk-undeclared-(first-use-in-this-function)
??? x86_64-rhel-7.2.dx2
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:lpbk-undeclared-(first-use-in-this-function)
??? x86_64-rhel-7.2.dx3
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:lpbk-undeclared-(first-use-in-this-function)
??? x86_64-rhel-7.2.dx4
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:lpbk-undeclared-(first-use-in-this-function)

elapsed time: 133m

configs tested: 192

i386                     randconfig-a0-201709
x86_64                 randconfig-a0-03061129
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-03061129
arm                         lpc18xx_defconfig
mips                     loongson1c_defconfig
powerpc                     tqm8560_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                        keystone_defconfig
powerpc                 mpc8540_ads_defconfig
sparc                            alldefconfig
powerpc64                        allmodconfig
sh                ecovec24-romimage_defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                           rhel-7.2.dx4
x86_64                           rhel-7.2.dx2
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-g0-03061025
x86_64                 randconfig-g0-03061217
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
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
arm                            dove_defconfig
arm                            mmp2_defconfig
s390                           gcov_defconfig
tile                             alldefconfig
cris                              allnoconfig
ia64                      gensparse_defconfig
powerpc                 linkstation_defconfig
powerpc                 mpc836x_mds_defconfig
sh                           se7705_defconfig
x86_64                 randconfig-x015-201710
x86_64                 randconfig-x012-201710
x86_64                 randconfig-x017-201710
x86_64                 randconfig-x010-201710
x86_64                 randconfig-x018-201710
x86_64                 randconfig-x011-201710
x86_64                 randconfig-x019-201710
x86_64                 randconfig-x013-201710
x86_64                 randconfig-x014-201710
x86_64                 randconfig-x016-201710
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s1-03060609
i386                   randconfig-s0-03060609
x86_64                 randconfig-s0-03061127
x86_64                 randconfig-s1-03061127
x86_64                 randconfig-s2-03061127
x86_64                           allmodconfig
x86_64                 randconfig-s3-03061110
x86_64                 randconfig-s4-03061110
x86_64                 randconfig-s5-03061110
x86_64                 randconfig-s3-03061202
x86_64                 randconfig-s4-03061202
x86_64                 randconfig-s5-03061202
i386                             allmodconfig
powerpc                   bluestone_defconfig
powerpc                      katmai_defconfig
sh                           se7721_defconfig
sh                   secureedge5410_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                 randconfig-i0-03060356
i386                   randconfig-b0-03061114
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                             pxa_defconfig
x86_64                randconfig-ne0-03061117
i386                 randconfig-x010-03060824
i386                 randconfig-x011-03060824
i386                 randconfig-x012-03060824
i386                 randconfig-x013-03060824
i386                 randconfig-x014-03060824
i386                 randconfig-x015-03060824
i386                 randconfig-x016-03060824
i386                 randconfig-x017-03060824
i386                 randconfig-x018-03060824
i386                 randconfig-x019-03060824
x86_64                                    lkp
x86_64                           rhel-7.2.dx3
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201710
x86_64                              defconfig
arm                         cm_x2xx_defconfig
mips                malta_kvm_guest_defconfig
x86_64                            allnoconfig
arm                           h3600_defconfig
sparc                       sparc64_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-h0-03061120
arm                         em_x270_defconfig
cris                       artpec_3_defconfig
i386                   randconfig-x070-201710
i386                   randconfig-x077-201710
i386                   randconfig-x073-201710
i386                   randconfig-x076-201710
i386                   randconfig-x072-201710
i386                   randconfig-x078-201710
i386                   randconfig-x074-201710
i386                   randconfig-x075-201710
i386                   randconfig-x079-201710
i386                   randconfig-x071-201710
x86_64                 randconfig-n0-03061052
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
m68k                         amcore_defconfig
parisc                        c8000_defconfig
sh                   rts7751r2dplus_defconfig
x86_64                randconfig-ws0-03061143
x86_64                randconfig-ws0-03061021
blackfin                BF548-EZKIT_defconfig
powerpc                     mpc83xx_defconfig
tile                             allyesconfig
x86_64                 randconfig-x004-201710
x86_64                 randconfig-x009-201710
x86_64                 randconfig-x003-201710
x86_64                 randconfig-x008-201710
x86_64                 randconfig-x002-201710
x86_64                 randconfig-x000-201710
x86_64                 randconfig-x007-201710
x86_64                 randconfig-x005-201710
x86_64                 randconfig-x006-201710
x86_64                 randconfig-x001-201710
i386                   randconfig-r0-03051812
x86_64                 randconfig-r0-03060545
i386                   randconfig-x005-201710
i386                   randconfig-x002-201710
i386                   randconfig-x006-201710
i386                   randconfig-x003-201710
i386                   randconfig-x007-201710
i386                   randconfig-x008-201710
i386                   randconfig-x001-201710
i386                   randconfig-x000-201710
i386                   randconfig-x009-201710
i386                   randconfig-x004-201710
i386                   randconfig-x0-03061143

Thanks,
Fengguang
