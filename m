From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 08 Aug 2017 18:09:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 c797f902051e504309d97e47d44a4f4c543bd537
Message-ID: <59898deb.NP5YpygUYea/Hmts%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
c797f902051e504309d97e47d44a4f4c543bd537  e1000e: fix buffer overrun while the I219 is processing DMA transactions

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:668:2: warning: case value '35' not in enumerated type 'enum i40e_fc_mode' [-Wswitch]

Error ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- alpha-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- i386-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- i386-randconfig-x018-201732
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- ia64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- parisc-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- parisc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- powerpc-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- powerpc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- powerpc-defconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- powerpc-ppc64_defconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- s390-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- s390-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- sparc-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- sparc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- sparc64-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- sparc64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- tile-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- tile-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- x86_64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- x86_64-rhel
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- x86_64-rhel-7.2
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
|-- xtensa-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
`-- xtensa-allyesconfig
    `-- drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode

elapsed time: 190m

configs tested: 128

mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
i386                             allmodconfig
x86_64                           allmodconfig
i386                     randconfig-n0-201732
x86_64                 randconfig-x007-201732
x86_64                 randconfig-x001-201732
x86_64                 randconfig-x000-201732
x86_64                 randconfig-x006-201732
x86_64                 randconfig-x003-201732
x86_64                 randconfig-x004-201732
x86_64                 randconfig-x009-201732
x86_64                 randconfig-x005-201732
x86_64                 randconfig-x008-201732
x86_64                 randconfig-x002-201732
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
i386                   randconfig-a1-08071744
i386                   randconfig-a0-08071744
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
x86_64                 randconfig-x016-201732
x86_64                 randconfig-x011-201732
x86_64                 randconfig-x014-201732
x86_64                 randconfig-x019-201732
x86_64                 randconfig-x012-201732
x86_64                 randconfig-x013-201732
x86_64                 randconfig-x018-201732
x86_64                 randconfig-x015-201732
x86_64                 randconfig-x010-201732
x86_64                 randconfig-x017-201732
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                               tinyconfig
x86_64                   randconfig-i0-201732
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-x019-201732
i386                   randconfig-x013-201732
i386                   randconfig-x016-201732
i386                   randconfig-x012-201732
i386                   randconfig-x018-201732
i386                   randconfig-x010-201732
i386                   randconfig-x015-201732
i386                   randconfig-x011-201732
i386                   randconfig-x017-201732
i386                   randconfig-x014-201732
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                 randconfig-x000-08071050
i386                 randconfig-x008-08071050
i386                 randconfig-x002-08071050
i386                 randconfig-x003-08071050
i386                 randconfig-x009-08071050
i386                 randconfig-x005-08071050
i386                 randconfig-x007-08071050
i386                 randconfig-x001-08071050
i386                 randconfig-x004-08071050
i386                 randconfig-x006-08071050
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
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
i386                   randconfig-x075-201732
i386                   randconfig-x076-201732
i386                   randconfig-x071-201732
i386                   randconfig-x074-201732
i386                   randconfig-x070-201732
i386                   randconfig-x072-201732
i386                   randconfig-x079-201732
i386                   randconfig-x077-201732
i386                   randconfig-x078-201732
i386                   randconfig-x073-201732

Thanks,
Fengguang
