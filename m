From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 25 Jul 2017 04:44:01 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 9d0c80b62ad6b4e5d652c1c22c5096d05ef9e550
Message-ID: <59765c11.OyXafSAd4IsnNzFl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
9d0c80b62ad6b4e5d652c1c22c5096d05ef9e550  igb: support BCM54616 PHY

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:160:28: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Wformat=]
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:160:2: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64' [-Wformat=]
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:160:2: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64' [-Wformat]
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:161:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Wformat=]
drivers/net/ethernet/intel/i40e/i40e_nvm.c:781:3-9: preceding lock on line 760
ERROR: "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? ??? drivers-net-ethernet-intel-i40e-i40e_nvm.c:preceding-lock-on-line
??? ??? ERROR:__udivdi3-drivers-net-ethernet-intel-i40e-i40e.ko-undefined
??? i386-randconfig-x014-201730
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? parisc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? s390-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? sparc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? xtensa-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64

TIMEOUT after 602m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 63

alpha                            allmodconfig
alpha                            allyesconfig
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
blackfin                         allmodconfig
blackfin                         allyesconfig
cris                             allmodconfig
cris                             allyesconfig
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-s0
i386                            randconfig-s1
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sh                               allyesconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc                               defconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                                    lkp
x86_64                          randconfig-i0
x86_64                        randconfig-x000
x86_64                        randconfig-x001
x86_64                        randconfig-x002
x86_64                        randconfig-x003
x86_64                        randconfig-x004
x86_64                        randconfig-x005
x86_64                        randconfig-x006
x86_64                        randconfig-x007
x86_64                        randconfig-x008
x86_64                        randconfig-x009
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 124

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
i386                               tinyconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-x019-201730
i386                   randconfig-x013-201730
i386                   randconfig-x016-201730
i386                   randconfig-x012-201730
i386                   randconfig-x018-201730
i386                   randconfig-x010-201730
i386                   randconfig-x015-201730
i386                   randconfig-x011-201730
i386                   randconfig-x017-201730
i386                   randconfig-x014-201730
i386                   randconfig-n0-07241914
x86_64               randconfig-x014-07241749
x86_64               randconfig-x016-07241749
x86_64               randconfig-x011-07241749
x86_64               randconfig-x017-07241749
x86_64               randconfig-x012-07241749
x86_64               randconfig-x010-07241749
x86_64               randconfig-x013-07241749
x86_64               randconfig-x019-07241749
x86_64               randconfig-x018-07241749
x86_64               randconfig-x015-07241749
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
i386                   randconfig-a0-07241749
i386                   randconfig-a1-07241749
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                             allmodconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                           allmodconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
score                      spct6600_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
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
i386                 randconfig-x078-07241842
i386                 randconfig-x072-07241842
i386                 randconfig-x077-07241842
i386                 randconfig-x074-07241842
i386                 randconfig-x071-07241842
i386                 randconfig-x073-07241842
i386                 randconfig-x070-07241842
i386                 randconfig-x075-07241842
i386                 randconfig-x079-07241842
i386                 randconfig-x076-07241842
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                   randconfig-x000-201730
i386                   randconfig-x003-201730
i386                   randconfig-x009-201730
i386                   randconfig-x004-201730
i386                   randconfig-x008-201730
i386                   randconfig-x001-201730
i386                   randconfig-x005-201730
i386                   randconfig-x007-201730
i386                   randconfig-x002-201730
i386                   randconfig-x006-201730
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
