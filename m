From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 18 Oct 2017 02:59:22 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 90c8837f835007dedec45152ae02d3d71e1e737f
Message-ID: <59e6530a.hTQy6qH76FAdUkK+%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 90c8837f835007dedec45152ae02d3d71e1e737f  Subject: [v2] i40e: avoid 64-bit division where possible X-Patchwork-Submitter: Arnd Bergmann <arnd@arndb.de> Cc: Arnd Bergmann <arnd@arndb.de>, netdev at vger.kernel.org, Mitch Williams  <mitch.a.williams@intel.com>, linux-kernel at vger.kernel.org,  intel-wired-lan at lists.osuosl.org, =?utf-8?b?QmrDtnJuIFTDtnBlbA==?=  <bjorn.topel@intel.com>,  Filip Sadowski <filip.sadowski@intel.com>,  "David S. Miller" <davem@davemloft.net> List-Id: Intel Wired Ethernet Linux Kernel Driver Development  <intel-wired-lan.osuosl.org>

elapsed time: 71m

configs tested: 163

The following configs have been built successfully.
More configs may be tested in the coming days.

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     tqm8540_defconfig
sh                           se7705_defconfig
x86_64                 randconfig-a0-10180129
m68k                        m5272c3_defconfig
parisc                           allmodconfig
xtensa                          iss_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-10180134
x86_64                randconfig-in0-10172212
powerpc                    amigaone_defconfig
powerpc                     kmeter1_defconfig
s390                                defconfig
x86_64                randconfig-it0-10180143
x86_64                 randconfig-v0-10180120
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
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                       imx_v6_v7_defconfig
arm                          ixp4xx_defconfig
arm                        mvebu_v7_defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                           tegra_defconfig
arm64                            alldefconfig
arm64                            allmodconfig
i386                     randconfig-a0-201742
i386                     randconfig-a1-201742
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
blackfin                BF609-EZKIT_defconfig
ia64                      gensparse_defconfig
mips                       lemote2f_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      ep88xc_defconfig
x86_64                 randconfig-x018-201742
x86_64                 randconfig-x011-201742
x86_64                 randconfig-x012-201742
x86_64                 randconfig-x013-201742
x86_64                 randconfig-x019-201742
x86_64                 randconfig-x017-201742
x86_64                 randconfig-x014-201742
x86_64                 randconfig-x015-201742
x86_64                 randconfig-x016-201742
x86_64                 randconfig-x010-201742
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                               tinyconfig
x86_64                   randconfig-i0-201742
i386                   randconfig-b0-10180144
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-b0-10180142
blackfin                BF538-EZKIT_defconfig
microblaze                       allyesconfig
powerpc                     stx_gp3_defconfig
x86_64                 randconfig-u0-10180138
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
x86_64                randconfig-ne0-10180129
i386                   randconfig-x074-201742
i386                   randconfig-x077-201742
i386                   randconfig-x071-201742
i386                   randconfig-x076-201742
i386                   randconfig-x073-201742
i386                   randconfig-x079-201742
i386                   randconfig-x078-201742
i386                   randconfig-x072-201742
i386                   randconfig-x070-201742
i386                   randconfig-x075-201742
i386                  randconfig-sb0-10180027
i386                   randconfig-x001-201742
i386                   randconfig-x008-201742
i386                   randconfig-x002-201742
i386                   randconfig-x004-201742
i386                   randconfig-x003-201742
i386                   randconfig-x006-201742
i386                   randconfig-x007-201742
i386                   randconfig-x009-201742
i386                   randconfig-x005-201742
i386                   randconfig-x000-201742
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
x86_64                 randconfig-x001-201742
x86_64                 randconfig-x000-201742
x86_64                 randconfig-x004-201742
x86_64                 randconfig-x008-201742
x86_64                 randconfig-x007-201742
x86_64                 randconfig-x006-201742
x86_64                 randconfig-x005-201742
x86_64                 randconfig-x009-201742
x86_64                 randconfig-x003-201742
x86_64                 randconfig-x002-201742
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      tqm8xx_defconfig
x86_64                randconfig-ws0-10172150
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
arm                    vt8500_v6_v7_defconfig
m68k                            q40_defconfig
powerpc64                        allmodconfig
x86_64                 randconfig-r0-10180109

Thanks,
Fengguang
