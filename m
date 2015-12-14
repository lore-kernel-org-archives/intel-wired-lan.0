From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 14 Dec 2015 22:40:01 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 e6e5a225486d9ba8c5e89c1b2a4dc74fa3c9898f BUILD DONE
Message-ID: <566ed4c1.nxTWz7g5pTRKLO/6%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
e6e5a225486d9ba8c5e89c1b2a4dc74fa3c9898f  ixgbevf: Fix handling of napi budget when multiple queues are enabled per vector

drivers/net/ethernet/intel/igb/igb_main.c:58:22: fatal error: igb_cdev.h: No such file or directory
make[6]: *** No rule to make target 'drivers/net/ethernet/intel/igb/igb_cdev.o', needed by 'drivers/net/ethernet/intel/igb/igb.o'.

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? i386-randconfig-i0-12141106
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? i386-randconfig-i1-12141106
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? i386-randconfig-s0-201550
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? ia64-defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-acpi-redef
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-allmodconfig
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-allyesdebian
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-lkp
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-randconfig-b0-12141948
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-randconfig-b0-12142203
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-randconfig-s2-12142002
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-randconfig-s3-12141950
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-randconfig-s3-12142133
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-randconfig-s4-12141950
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-randconfig-s5-12141950
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
??? ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-igb-igb_main.c:fatal-error:igb_cdev.h:No-such-file-or-directory
    ??? make:No-rule-to-make-target-drivers-net-ethernet-intel-igb-igb_cdev.o-needed-by-drivers-net-ethernet-intel-igb-igb.o-.

elapsed time: 146m

configs tested: 174

arm                          simpad_defconfig
m68k                            q40_defconfig
sh                           se7705_defconfig
i386                   randconfig-a0-12141102
x86_64                 randconfig-a0-12142130
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                               tinyconfig
arm                  colibri_pxa300_defconfig
arm                         em_x270_defconfig
mips                        maltaup_defconfig
arm                         lubbock_defconfig
arm                            qcom_defconfig
blackfin                   CM-BF561_defconfig
mips                             allyesconfig
mips                       bmips_be_defconfig
mips                        xilfpga_defconfig
x86_64                 randconfig-v0-12142133
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
alpha                             allnoconfig
arm                          ixp4xx_defconfig
arm                           sunxi_defconfig
avr32                     atstk1002_defconfig
blackfin              BF561-ACVILON_defconfig
arm                           acs5k_defconfig
arm                          pxa910_defconfig
mips                         tb0226_defconfig
powerpc                   gef_ppc9a_defconfig
s390                        default_defconfig
x86_64               randconfig-x011-12141150
x86_64               randconfig-x016-12141150
x86_64               randconfig-x013-12141150
x86_64               randconfig-x019-12141150
x86_64               randconfig-x017-12141150
x86_64               randconfig-x012-12141150
x86_64               randconfig-x014-12141150
x86_64               randconfig-x010-12141150
x86_64               randconfig-x018-12141150
x86_64               randconfig-x015-12141150
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201550
i386                     randconfig-s1-201550
x86_64                 randconfig-s0-12142002
x86_64                 randconfig-s1-12142002
x86_64                 randconfig-s2-12142002
x86_64                           allmodconfig
x86_64                 randconfig-s3-12141950
x86_64                 randconfig-s4-12141950
x86_64                 randconfig-s5-12141950
x86_64                 randconfig-s3-12142133
x86_64                 randconfig-s4-12142133
x86_64                 randconfig-s5-12142133
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allmodconfig
mips                        msp71xx_defconfig
powerpc                     tqm8555_defconfig
sh                          landisk_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201550
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                            mps2_defconfig
openrisc                         alldefconfig
powerpc                 xes_mpc85xx_defconfig
s390                              allnoconfig
powerpc                     akebono_defconfig
powerpc                      ep88xc_defconfig
powerpc                     kilauea_defconfig
powerpc                 linkstation_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-12141106
i386                   randconfig-i1-12141106
x86_64                 randconfig-b0-12141948
x86_64                 randconfig-b0-12142203
m68k                            mac_defconfig
powerpc                     ep8248e_defconfig
powerpc                     tqm8560_defconfig
um                               allmodconfig
i386                     randconfig-n0-201550
i386                   randconfig-h0-12141945
i386                   randconfig-h1-12141945
i386                   randconfig-h0-12142128
i386                   randconfig-h1-12142128
i386                             allmodconfig
m68k                        m5272c3_defconfig
openrisc                         allmodconfig
powerpc                     virtex5_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
mips                 pnx8335_stb225_defconfig
mn10300                          allmodconfig
x86_64                 randconfig-n0-12141928
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
parisc                generic-32bit_defconfig
powerpc               mpc85xx_basic_defconfig
sh                          sdk7780_defconfig
arm                      pxa255-idp_defconfig
frv                              alldefconfig
m68k                       bvme6000_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-x000-12141102
x86_64               randconfig-x001-12141102
x86_64               randconfig-x002-12141102
x86_64               randconfig-x003-12141102
x86_64               randconfig-x004-12141102
x86_64               randconfig-x005-12141102
x86_64               randconfig-x006-12141102
x86_64               randconfig-x007-12141102
x86_64               randconfig-x008-12141102
x86_64               randconfig-x009-12141102
x86_64                                    lkp
x86_64                                   rhel
i386                   randconfig-r0-12141102
i386                 randconfig-x000-12141102
i386                 randconfig-x001-12141102
i386                 randconfig-x002-12141102
i386                 randconfig-x003-12141102
i386                 randconfig-x004-12141102
i386                 randconfig-x005-12141102
i386                 randconfig-x006-12141102
i386                 randconfig-x007-12141102
i386                 randconfig-x008-12141102
i386                 randconfig-x009-12141102

Thanks,
Fengguang
