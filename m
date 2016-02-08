From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 08 Feb 2016 19:33:48 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 97e62110c6b248642478de6cdf5f3c9f370837fd BUILD DONE
Message-ID: <56b87d1c.7ZdObXbaw2EP/ebp%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
97e62110c6b248642478de6cdf5f3c9f370837fd  igb: Add I210 cable fault detection to self test

drivers/net/ethernet/intel/i40e/i40e_txrx.c:2066:28: error: 'I40E_TX_FLAGS_TUNNEL' undeclared (first use in this function)
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2445:17: error: 'I40E_TX_FLAGS_TUNNEL' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? x86_64-randconfig-s4-02081815
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:error:I40E_TX_FLAGS_TUNNEL-undeclared-(first-use-in-this-function)

elapsed time: 110m

configs tested: 135

blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
i386                   randconfig-a0-02081837
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-02081711
i386                   randconfig-c0-02081801
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                 randconfig-v0-02081536
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
i386                             allmodconfig
m32r                   mappi2.vdec2_defconfig
mips                        workpad_defconfig
powerpc                     asp8347_defconfig
powerpc                      virtex_defconfig
xtensa                generic_kc705_defconfig
arm                     eseries_pxa_defconfig
ia64                        generic_defconfig
m68k                           sun3_defconfig
sh                   rts7751r2dplus_defconfig
x86_64                 randconfig-x012-201606
x86_64                 randconfig-x014-201606
x86_64                 randconfig-x017-201606
x86_64                 randconfig-x011-201606
x86_64                 randconfig-x013-201606
x86_64                 randconfig-x019-201606
x86_64                 randconfig-x015-201606
x86_64                 randconfig-x010-201606
x86_64                 randconfig-x016-201606
x86_64                 randconfig-x018-201606
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
i386                     randconfig-s0-201606
i386                     randconfig-s1-201606
i386         randconfig-s0-201606+CONFIG_DEBUG_INFO_REDUCED
x86_64                 randconfig-s0-02081744
x86_64                 randconfig-s1-02081744
x86_64                 randconfig-s2-02081744
x86_64                           allmodconfig
x86_64                 randconfig-s3-02081741
x86_64                 randconfig-s4-02081741
x86_64                 randconfig-s5-02081741
x86_64                 randconfig-s3-02081815
x86_64                 randconfig-s4-02081815
x86_64                 randconfig-s5-02081815
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201606
i386                   randconfig-b0-02081649
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201606
i386                     randconfig-i1-201606
x86_64                 randconfig-b0-02081611
x86_64                 randconfig-b0-02081822
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201606
ia64                             alldefconfig
ia64                              allnoconfig
x86_64                 randconfig-h0-02081606
x86_64                 randconfig-n0-02081730
x86_64                 randconfig-n0-02081802
x86_64                 randconfig-n0-02081819
x86_64                 randconfig-n0-02081843
i386                  randconfig-sb0-02081711
x86_64                 randconfig-x000-201606
x86_64                 randconfig-x001-201606
x86_64                 randconfig-x002-201606
x86_64                 randconfig-x003-201606
x86_64                 randconfig-x004-201606
x86_64                 randconfig-x005-201606
x86_64                 randconfig-x006-201606
x86_64                 randconfig-x007-201606
x86_64                 randconfig-x008-201606
x86_64                 randconfig-x009-201606
i386                     randconfig-r0-201606
i386                   randconfig-x000-201606
i386                   randconfig-x001-201606
i386                   randconfig-x002-201606
i386                   randconfig-x003-201606
i386                   randconfig-x004-201606
i386                   randconfig-x005-201606
i386                   randconfig-x006-201606
i386                   randconfig-x007-201606
i386                   randconfig-x008-201606
i386                   randconfig-x009-201606

Thanks,
Fengguang
