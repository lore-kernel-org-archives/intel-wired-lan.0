From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 25 Sep 2015 07:43:40 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 12369564f1316dd3ccdec7c22255362ec476fd7d BUILD DONE
Message-ID: <56048aac.Vk5SbwKuO2oc2lxW%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
12369564f1316dd3ccdec7c22255362ec476fd7d  i40e/i40evf: refactor tx timeout logic

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked'
drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? i386-randconfig-x000-09220931
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? tile-allyesconfig
    ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked

elapsed time: 121m

configs tested: 133

i386                     randconfig-a0-201538
x86_64                 randconfig-a0-09250633
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
powerpc                     kilauea_defconfig
sh                        dreamcast_defconfig
tile                                defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-09250645
x86_64                           allmodconfig
x86_64                 randconfig-v0-09250119
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
i386                             allmodconfig
avr32                     atstk1006_defconfig
mips                        jmr3927_defconfig
mips                          malta_defconfig
powerpc                     sequoia_defconfig
sh                           cayman_defconfig
x86_64               randconfig-x010-09232308
x86_64               randconfig-x014-09232308
x86_64               randconfig-x018-09232308
x86_64               randconfig-x017-09232308
x86_64               randconfig-x012-09232308
x86_64               randconfig-x016-09232308
x86_64               randconfig-x013-09232308
x86_64               randconfig-x011-09232308
x86_64               randconfig-x015-09232308
x86_64               randconfig-x019-09232308
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                                     txx9
powerpc                           allnoconfig
i386                     randconfig-s1-201538
i386                     randconfig-s0-201538
x86_64                 randconfig-s0-09250550
x86_64                 randconfig-s1-09250550
x86_64                 randconfig-s2-09250550
x86_64                 randconfig-s3-09250550
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
x86_64                            allnoconfig
arm                                 defconfig
x86_64                   randconfig-i0-201538
i386                   randconfig-b0-09250620
arm                      acs5k_tiny_defconfig
m68k                            mac_defconfig
powerpc                       maple_defconfig
um                               allmodconfig
i386                     randconfig-i1-201538
i386                     randconfig-i0-201538
x86_64                 randconfig-b0-09250615
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                              zx_defconfig
mips                           mtx1_defconfig
powerpc                       ep405_defconfig
powerpc64                        allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201538
i386                   randconfig-h0-09250611
i386                   randconfig-h1-09250611
mips                        msp71xx_defconfig
powerpc                 xes_mpc85xx_defconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                 randconfig-n0-09250559
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                       imx_v6_v7_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                          prima2_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                       spear13xx_defconfig
blackfin                BF561-EZKIT_defconfig
sparc                             allnoconfig
i386                  randconfig-sb0-09250600
mips                      fuloong2e_defconfig
mn10300                             defconfig
sh                   rts7751r2dplus_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-r0-201538
x86_64                 randconfig-r0-09250033
i386                 randconfig-x007-09220931
i386                 randconfig-x001-09220931
i386                 randconfig-x002-09220931
i386                 randconfig-x005-09220931
i386                 randconfig-x008-09220931
i386                 randconfig-x003-09220931
i386                 randconfig-x006-09220931
i386                 randconfig-x000-09220931
i386                 randconfig-x004-09220931
i386                 randconfig-x009-09220931
i386                   randconfig-x0-09250110

Thanks,
Fengguang
