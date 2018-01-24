From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 25 Jan 2018 07:03:09 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:1GbE] BUILD SUCCESS
 3a53285228165225a7f76c7d5ff1ddc0213ce0e4
Message-ID: <5a6910ad.AEcaUAeMNTLIFbIg%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  1GbE
branch HEAD: 3a53285228165225a7f76c7d5ff1ddc0213ce0e4  igb: Clear TXSTMP when ptp_tx_work() is timeout

elapsed time: 127m

configs tested: 170

The following configs have been built successfully.
More configs may be tested in the coming days.

sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
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
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-n0-201803
i386                     randconfig-i0-201803
i386                     randconfig-i1-201803
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                         em_x270_defconfig
frv                                 defconfig
powerpc                      ppc40x_defconfig
blackfin                  CM-BF537U_defconfig
powerpc                     ksi8560_defconfig
sh                   sh7724_generic_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                   randconfig-a1-01241352
i386                   randconfig-a0-01241352
x86_64                           alldefconfig
parisc                generic-64bit_defconfig
powerpc                     sbc8548_defconfig
powerpc                         wii_defconfig
sh                             shx3_defconfig
blackfin                         allmodconfig
powerpc                     akebono_defconfig
blackfin                            defconfig
m32r                       mappi.up_defconfig
powerpc                    amigaone_defconfig
powerpc                       ep405_defconfig
powerpc                     sbc834x_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s0-201803
i386                     randconfig-s1-201803
x86_64                   randconfig-i0-201803
blackfin                         alldefconfig
h8300                    h8300h-sim_defconfig
m68k                       m5208evb_defconfig
arm                           h5000_defconfig
mips                        omega2p_defconfig
sh                           cayman_defconfig
ia64                      gensparse_defconfig
powerpc                       eiger_defconfig
powerpc                    gamecube_defconfig
arm                      footbridge_defconfig
sparc                             allnoconfig
xtensa                              defconfig
m32r                           usrv_defconfig
x86_64                 randconfig-u0-01250630
c6x                        evmc6678_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                               tinyconfig
arm                              zx_defconfig
ia64                         bigsur_defconfig
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
arm                         ebsa110_defconfig
sh                          rsk7201_defconfig
x86_64                           allmodconfig
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
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
mips                 pnx8335_stb225_defconfig
sh                          kfr2r09_defconfig
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
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
h8300                     edosk2674_defconfig
powerpc                     tqm8540_defconfig
powerpc                 xes_mpc85xx_defconfig

Thanks,
Fengguang
