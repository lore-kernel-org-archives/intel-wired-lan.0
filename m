From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 15 Oct 2015 21:04:08 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 05934a69a51d89a3733cb5ffd16545907214ad97 BUILD DONE
Message-ID: <561fa448.sx5AR98chr/W1NA8%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
05934a69a51d89a3733cb5ffd16545907214ad97  e1000e: fix division by zero on jumbo MTUs

drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]

Error ids grouped by kconfigs:

recent_errors
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function

elapsed time: 200m

configs tested: 177

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
m68k                                defconfig
mips                        maltaup_defconfig
mn10300                          allyesconfig
i386                     randconfig-a0-201541
x86_64                 randconfig-a0-10141704
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                            allnoconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-10151701
i386                   randconfig-c0-10151857
x86_64                           allmodconfig
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
x86_64                 randconfig-v0-10141709
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                         b180_defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                             allmodconfig
arm                         s3c6400_defconfig
parisc                      default_defconfig
powerpc                         ps3_defconfig
sh                         apsh4a3a_defconfig
sh                              ul2_defconfig
frv                               allnoconfig
mips                              allnoconfig
mips                           ip27_defconfig
openrisc                         alldefconfig
sh                          r7785rp_defconfig
arm                     davinci_all_defconfig
arm                          nuc910_defconfig
m32r                        oaks32r_defconfig
mips                      malta_kvm_defconfig
powerpc                      ppc40x_defconfig
arm                            lart_defconfig
ia64                              allnoconfig
m32r                      mappi.smp_defconfig
powerpc                  gef_sbc610_defconfig
x86_64               randconfig-x010-10130227
x86_64               randconfig-x011-10130227
x86_64               randconfig-x012-10130227
x86_64               randconfig-x013-10130227
x86_64               randconfig-x014-10130227
x86_64               randconfig-x015-10130227
x86_64               randconfig-x016-10130227
x86_64               randconfig-x017-10130227
x86_64               randconfig-x018-10130227
x86_64               randconfig-x019-10130227
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201541
i386                     randconfig-s1-201541
x86_64                 randconfig-s0-10151747
x86_64                 randconfig-s1-10151747
x86_64                 randconfig-s2-10151747
x86_64                 randconfig-s0-10152002
x86_64                 randconfig-s1-10152002
x86_64                 randconfig-s2-10152002
x86_64                 randconfig-s3-10151652
x86_64                 randconfig-s4-10151652
x86_64                 randconfig-s5-10151652
x86_64                 randconfig-s3-10151821
x86_64                 randconfig-s4-10151821
x86_64                 randconfig-s5-10151821
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                         axm55xx_defconfig
arm                         em_x270_defconfig
arm                      footbridge_defconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201541
i386                   randconfig-b0-10151721
i386                   randconfig-b0-10151913
i386                   randconfig-b0-10152006
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                          collie_defconfig
arm64                            allmodconfig
mips                          sead3_defconfig
powerpc                 mpc832x_rdb_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201541
i386                     randconfig-i1-201541
x86_64                 randconfig-b0-10141703
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
i386                     randconfig-n0-201541
i386                   randconfig-h0-10141540
i386                   randconfig-h1-10141540
arm                            netx_defconfig
arm                          pcm027_defconfig
powerpc                          allmodconfig
x86_64                                   rhel
x86_64                 randconfig-h0-10151712
arm                        mvebu_v5_defconfig
i386                  randconfig-sb0-10141904
x86_64                 randconfig-x000-201541
x86_64                 randconfig-x001-201541
x86_64                 randconfig-x002-201541
x86_64                 randconfig-x003-201541
x86_64                 randconfig-x004-201541
x86_64                 randconfig-x005-201541
x86_64                 randconfig-x006-201541
x86_64                 randconfig-x007-201541
x86_64                 randconfig-x008-201541
x86_64                 randconfig-x009-201541
ia64                             alldefconfig
ia64                                defconfig
x86_64                                    lkp
i386                     randconfig-r0-201541
x86_64                 randconfig-r0-10131108
x86_64                           allyesconfig
blackfin                 BlackStamp_defconfig
powerpc                mpc8610_hpcd_defconfig
i386                 randconfig-x000-10121721
i386                 randconfig-x001-10121721
i386                 randconfig-x002-10121721
i386                 randconfig-x003-10121721
i386                 randconfig-x004-10121721
i386                 randconfig-x005-10121721
i386                 randconfig-x006-10121721
i386                 randconfig-x007-10121721
i386                 randconfig-x008-10121721
i386                 randconfig-x009-10121721
i386                   randconfig-x0-10141708

Thanks,
Fengguang
