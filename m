From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 30 Sep 2017 04:21:00 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 21a07c1731c51a09c159205ad6706022529ccd6f
Message-ID: <59ceab2c.e3/sgdKaVwPCN0Tq%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
21a07c1731c51a09c159205ad6706022529ccd6f  ixgbe: Update adaptive ITR algorithm

ERROR: "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
i40e_main.c:(.text+0x7371): undefined reference to `__udivdi3'
i40e_main.c:(.text+0x9989): undefined reference to `__udivdi3'

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? ERROR:__udivdi3-drivers-net-ethernet-intel-i40e-i40e.ko-undefined
??? i386-allyesconfig
??? ??? i40e_main.c:(.text):undefined-reference-to-__udivdi3
??? i386-randconfig-x0-09300314
    ??? i40e_main.c:(.text):undefined-reference-to-__udivdi3

elapsed time: 92m

configs tested: 171

arm64                            allmodconfig
blackfin                   CM-BF561_defconfig
powerpc                    sam440ep_defconfig
arm                           corgi_defconfig
arm                             rpc_defconfig
m32r                    mappi.nommu_defconfig
microblaze                       allyesconfig
parisc                         b180_defconfig
powerpc                      walnut_defconfig
x86_64                randconfig-it0-09300108
i386                     randconfig-n0-201739
x86_64                 randconfig-v0-09300329
i386                             allyesconfig
arm                      jornada720_defconfig
x86_64                 randconfig-g0-09300333
i386                             allmodconfig
x86_64                 randconfig-x011-201739
x86_64                 randconfig-x016-201739
x86_64                 randconfig-x018-201739
x86_64                 randconfig-x013-201739
x86_64                 randconfig-x019-201739
x86_64                 randconfig-x014-201739
x86_64                 randconfig-x012-201739
x86_64                 randconfig-x015-201739
x86_64                 randconfig-x017-201739
x86_64                 randconfig-x010-201739
x86_64                 randconfig-s0-09300132
x86_64                 randconfig-s1-09300132
x86_64                 randconfig-s2-09300132
alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                         axm55xx_defconfig
mips                    maltaup_xpa_defconfig
powerpc               corenet_basic_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201739
i386                     randconfig-s1-201739
x86_64                           allmodconfig
cris                              allnoconfig
powerpc                   currituck_defconfig
powerpc                    gamecube_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201739
i386                   randconfig-b0-09300305
mips                            ar7_defconfig
mips                      bmips_stb_defconfig
mips                      fuloong2e_defconfig
um                           x86_64_defconfig
i386                     randconfig-i0-201739
i386                     randconfig-i1-201739
x86_64                 randconfig-b0-09300257
blackfin             BF527-EZKIT-V2_defconfig
m68k                       m5208evb_defconfig
sh                          sdk7786_defconfig
x86_64                 randconfig-u0-09300246
m32r                             allmodconfig
mips                        maltaup_defconfig
i386                   randconfig-x013-201739
i386                   randconfig-x019-201739
i386                   randconfig-x018-201739
i386                   randconfig-x016-201739
i386                   randconfig-x012-201739
i386                   randconfig-x015-201739
i386                   randconfig-x011-201739
i386                   randconfig-x010-201739
i386                   randconfig-x017-201739
i386                   randconfig-x014-201739
arm                           sunxi_defconfig
xtensa                  audio_kc705_defconfig
arm                      acs5k_tiny_defconfig
sparc64                             defconfig
x86_64                 randconfig-n0-09300303
arm                          moxart_defconfig
cris                                defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                  randconfig-sb0-09300328
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
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
powerpc                      chrp32_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     pseries_defconfig
x86_64                randconfig-ws0-09300309
arm                          gemini_defconfig
powerpc               mpc86xx_basic_defconfig
powerpc                      pasemi_defconfig
x86_64                randconfig-ws0-09300319
i386                   randconfig-x075-201739
i386                   randconfig-x076-201739
i386                   randconfig-x071-201739
i386                   randconfig-x074-201739
i386                   randconfig-x070-201739
i386                   randconfig-x077-201739
i386                   randconfig-x073-201739
i386                   randconfig-x078-201739
i386                   randconfig-x072-201739
i386                   randconfig-x079-201739
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
mips                        bcm63xx_defconfig
sparc64                          allmodconfig
x86_64                 randconfig-x000-201739
x86_64                 randconfig-x007-201739
x86_64                 randconfig-x001-201739
x86_64                 randconfig-x006-201739
x86_64                 randconfig-x004-201739
x86_64                 randconfig-x009-201739
x86_64                 randconfig-x003-201739
x86_64                 randconfig-x002-201739
x86_64                 randconfig-x005-201739
x86_64                 randconfig-x008-201739
i386                   randconfig-x000-201739
i386                   randconfig-x003-201739
i386                   randconfig-x009-201739
i386                   randconfig-x004-201739
i386                   randconfig-x008-201739
i386                   randconfig-x001-201739
i386                   randconfig-x005-201739
i386                   randconfig-x002-201739
i386                   randconfig-x006-201739
i386                   randconfig-x007-201739
i386                   randconfig-x0-09300314

Thanks,
Fengguang
