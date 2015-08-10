From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 11 Aug 2015 03:08:00 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 ed5eb2432f26a6f5f687b6c6ecca6302ca43ba3f BUILD DONE
Message-ID: <55c8f690.BZmloOEEWI7qwMAI%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
ed5eb2432f26a6f5f687b6c6ecca6302ca43ba3f  ixgbe: Add new X550EM SFP+ device ID

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:1499:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u32' [-Wformat=]

Error ids grouped by kconfigs:

recent_errors
??? arm-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? i386-randconfig-x002-08101704
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? parisc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32

elapsed time: 203m

configs tested: 193

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
arm                         s3c6400_defconfig
mips                           ip22_defconfig
parisc                           allmodconfig
i386                     randconfig-a0-201532
x86_64                 randconfig-a0-08110114
x86_64                 randconfig-a0-08110219
x86_64                 randconfig-a0-08110235
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                            allnoconfig
blackfin                         alldefconfig
mips                        qi_lb60_defconfig
mips                          sead3_defconfig
arm                          ixp4xx_defconfig
mips                      malta_kvm_defconfig
powerpc                     asp8347_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-08110143
i386                   randconfig-c0-08110214
arm                              allyesconfig
arm                          lpd270_defconfig
sh                            shmin_defconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-v0-08110052
x86_64                 randconfig-v0-08110213
x86_64                 randconfig-v0-08110238
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
mips                    maltaup_xpa_defconfig
powerpc                  gef_sbc610_defconfig
s390                        default_defconfig
arm                         at91_dt_defconfig
arm                       imx_v4_v5_defconfig
sh                           sh2007_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201532
i386                   randconfig-b0-08110124
i386                   randconfig-b0-08110214
i386                   randconfig-b0-08110226
i386                   randconfig-b0-08110251
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
blackfin                       IP0X_defconfig
powerpc                     kilauea_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     sequoia_defconfig
avr32            atngw100_evklcd100_defconfig
m68k                             alldefconfig
powerpc                     kmp204x_defconfig
sh                              ul2_defconfig
blackfin          BF527-AD7160-EVAL_defconfig
ia64                            zx1_defconfig
mips                        bcm63xx_defconfig
mn10300                           allnoconfig
arm                        keystone_defconfig
blackfin                   CM-BF527_defconfig
mn10300                     asb2364_defconfig
sh                           cayman_defconfig
arm                            mmp2_defconfig
powerpc                 mpc836x_mds_defconfig
s390                                defconfig
sh                           se7721_defconfig
avr32                        merisc_defconfig
powerpc               corenet_basic_defconfig
powerpc                      ppc40x_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201532
i386                     randconfig-i0-201532
x86_64                 randconfig-b0-08110121
x86_64                 randconfig-b0-08110200
x86_64                 randconfig-b0-08110212
x86_64                 randconfig-b0-08110230
x86_64                 randconfig-b0-08110240
x86_64                 randconfig-b0-08110251
x86_64                           allmodconfig
m32r                        oaks32r_defconfig
m68k                              allnoconfig
sparc                            allmodconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201532
i386                   randconfig-h0-08102335
i386                   randconfig-h1-08102335
i386                             alldefconfig
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
alpha                            alldefconfig
sh                           se7343_defconfig
arm                     eseries_pxa_defconfig
arm                          pxa3xx_defconfig
frv                                 defconfig
x86_64                 randconfig-h0-08110155
x86_64                 randconfig-h0-08110246
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64                 randconfig-n0-03151309
x86_64                 randconfig-n0-03151331
x86_64                 randconfig-n0-03151354
x86_64                 randconfig-n0-03151405
x86_64                 randconfig-n0-03151422
arm                                    sa1100
arm                          prima2_defconfig
arm                               allnoconfig
arm                                   samsung
arm                       spear13xx_defconfig
arm                                  iop-adma
arm                       imx_v6_v7_defconfig
arm                          marzen_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
blackfin                    PNAV-10_defconfig
blackfin                  TCM-BF518_defconfig
powerpc                  mpc866_ads_defconfig
arm                          moxart_defconfig
powerpc64                        allmodconfig
m68k                          amiga_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                  randconfig-sb0-08110112
i386                  randconfig-sb0-08110233
arm                            zeus_defconfig
m68k                        mvme16x_defconfig
powerpc                       eiger_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     ppa8548_defconfig
x86_64                 randconfig-x001-201532
x86_64                 randconfig-x004-201532
x86_64                 randconfig-x006-201532
x86_64                 randconfig-x000-201532
x86_64                 randconfig-x003-201532
x86_64                 randconfig-x009-201532
x86_64                 randconfig-x002-201532
x86_64                 randconfig-x005-201532
x86_64                 randconfig-x008-201532
x86_64                 randconfig-x007-201532
i386                     randconfig-r0-201532
x86_64                 randconfig-r0-08110046
powerpc64                        allyesconfig
sh                               allyesconfig
um                               allmodconfig
arm                      jornada720_defconfig
powerpc                         c2k_defconfig
sh                        dreamcast_defconfig
i386                 randconfig-x000-08101704
i386                 randconfig-x006-08101704
i386                 randconfig-x003-08101704
i386                 randconfig-x005-08101704
i386                 randconfig-x001-08101704
i386                 randconfig-x008-08101704
i386                 randconfig-x009-08101704
i386                 randconfig-x002-08101704
i386                 randconfig-x007-08101704
i386                 randconfig-x004-08101704
i386                   randconfig-x0-08110136
i386                   randconfig-x0-08110202
i386                   randconfig-x0-08110211
i386                   randconfig-x0-08110224
i386                   randconfig-x0-08110235
i386                   randconfig-x0-08110247

Thanks,
Fengguang
