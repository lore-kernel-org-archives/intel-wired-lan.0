From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 15 Mar 2017 10:03:27 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 fdb6e5d720b1be66e11d3ef0e509c7fdefba806b
Message-ID: <58c8a0ef.eEiEH/6rwNugJ8o9%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
fdb6e5d720b1be66e11d3ef0e509c7fdefba806b  ixgbe: Add support for maximum headroom when using build_skb

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3098:32-37: ERROR: invalid reference to the index variable of the iterator on line 3052

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line

elapsed time: 150m

configs tested: 177

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                       imx_v6_v7_defconfig
mips                        xilfpga_defconfig
powerpc                     pq2fads_defconfig
i386                     randconfig-a0-201711
x86_64                 randconfig-a0-03150759
mips                          lasat_defconfig
powerpc                     tqm5200_defconfig
sh                   sh7770_generic_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-03150808
x86_64                           allmodconfig
x86_64                randconfig-it0-03150804
x86_64                 randconfig-v0-03150715
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
avr32                     atstk1006_defconfig
m68k                        mvme147_defconfig
sh                           se7780_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-g0-03150724
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
i386                             allmodconfig
avr32                     atstk1003_defconfig
powerpc                         c2k_defconfig
sh                               allmodconfig
tile                              allnoconfig
um                             i386_defconfig
x86_64                 randconfig-x015-201711
x86_64                 randconfig-x012-201711
x86_64                 randconfig-x017-201711
x86_64                 randconfig-x010-201711
x86_64                 randconfig-x018-201711
x86_64                 randconfig-x011-201711
x86_64                 randconfig-x019-201711
x86_64                 randconfig-x014-201711
x86_64                 randconfig-x013-201711
x86_64                 randconfig-x016-201711
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201711
i386                     randconfig-s1-201711
x86_64                 randconfig-s3-03150656
x86_64                 randconfig-s4-03150656
x86_64                 randconfig-s5-03150656
arm                          collie_defconfig
mn10300                          allmodconfig
powerpc                     ppa8548_defconfig
s390                              allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201711
i386                   randconfig-b0-03150801
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201711
i386                     randconfig-i1-201711
i386                             allyesconfig
m68k                            q40_defconfig
mips                       rbtx49xx_defconfig
sparc64                          alldefconfig
x86_64                 randconfig-u0-03150759
i386                   randconfig-x014-201711
i386                   randconfig-x010-201711
i386                   randconfig-x016-201711
i386                   randconfig-x017-201711
i386                   randconfig-x013-201711
i386                   randconfig-x019-201711
i386                   randconfig-x015-201711
i386                   randconfig-x012-201711
i386                   randconfig-x011-201711
i386                   randconfig-x018-201711
x86_64                randconfig-ne0-03150805
i386                               tinyconfig
arm                         bcm2835_defconfig
arm                         cm_x300_defconfig
arm                        mvebu_v7_defconfig
sh                               allyesconfig
i386                     randconfig-n0-201711
i386                   randconfig-h0-03150721
i386                   randconfig-h1-03150721
mips                         cobalt_defconfig
sparc                            allmodconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                              defconfig
blackfin              BF561-ACVILON_defconfig
x86_64                                  kexec
x86_64                               rhel-7.2
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
x86_64                 randconfig-x004-201711
x86_64                 randconfig-x009-201711
x86_64                 randconfig-x003-201711
x86_64                 randconfig-x008-201711
x86_64                 randconfig-x002-201711
x86_64                 randconfig-x007-201711
x86_64                 randconfig-x000-201711
x86_64                 randconfig-x005-201711
x86_64                 randconfig-x006-201711
x86_64                 randconfig-x001-201711
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                randconfig-ws0-03150715
i386                   randconfig-x077-201711
i386                   randconfig-x070-201711
i386                   randconfig-x073-201711
i386                   randconfig-x076-201711
i386                   randconfig-x072-201711
i386                   randconfig-x078-201711
i386                   randconfig-x074-201711
i386                   randconfig-x075-201711
i386                   randconfig-x079-201711
i386                   randconfig-x071-201711
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
avr32                      atngw100_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                           x86_64_defconfig
i386                     randconfig-r0-201711
x86_64                 randconfig-r0-03150700
i386                   randconfig-x002-201711
i386                   randconfig-x005-201711
i386                   randconfig-x006-201711
i386                   randconfig-x003-201711
i386                   randconfig-x007-201711
i386                   randconfig-x008-201711
i386                   randconfig-x001-201711
i386                   randconfig-x000-201711
i386                   randconfig-x009-201711
i386                   randconfig-x004-201711
i386                   randconfig-x0-03150707

Thanks,
Fengguang
