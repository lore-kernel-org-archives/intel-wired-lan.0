From: kbuild test robot <lkp@intel.com>
Date: Wed, 05 Dec 2018 18:17:34 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 7e1ab79ec66131e03715c31928e09efd1c749cef
Message-ID: <5c07a5be.inOKDedFPddnvByZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 7e1ab79ec66131e03715c31928e09efd1c749cef  i40e: fix VLAN.TCI == 0 RX HW offload

Regressions in current branch:

ERROR: "__mdiobus_register" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: "devm_mdiobus_alloc_size" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: "devm_mdiobus_free" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: "mdiobus_unregister" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11195: undefined reference to `mdiobus_unregister'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11197: undefined reference to `mdiobus_unregister'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8799: undefined reference to `mdiobus_read'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8800: undefined reference to `mdiobus_read'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8822: undefined reference to `mdiobus_write'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8823: undefined reference to `mdiobus_write'
drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:952: undefined reference to `__mdiobus_register'
drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:955: undefined reference to `devm_mdiobus_free'
include/linux/phy.h:264: undefined reference to `devm_mdiobus_alloc_size'

Error ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-s1-12051035
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- i386-randconfig-s2-12051035
|   |-- ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   `-- ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|-- x86_64-randconfig-a0-12051544
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- x86_64-randconfig-a0-12051559
|   |-- ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   `-- ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
`-- x86_64-randconfig-ws0-12051445
    |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
    |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
    |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
    |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
    |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
    `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size

TIMEOUT after 600m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 119

alpha                            allmodconfig
alpha                            allyesconfig
alpha                               defconfig
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
i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-a2
i386                            randconfig-a3
i386                            randconfig-f0
i386                            randconfig-f1
i386                            randconfig-f2
i386                            randconfig-f3
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-i2
i386                            randconfig-i3
i386                            randconfig-j0
i386                            randconfig-j1
i386                            randconfig-j2
i386                            randconfig-j3
i386                            randconfig-k0
i386                            randconfig-k1
i386                            randconfig-k2
i386                            randconfig-k3
i386                            randconfig-n0
i386                            randconfig-n1
i386                            randconfig-n2
i386                            randconfig-n3
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                                   jz4740
mips                                     txx9
nds32                            allmodconfig
nds32                             allnoconfig
nds32                            allyesconfig
nds32                               defconfig
parisc                           allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                        default_defconfig
sh                               allmodconfig
sh                               allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
x86_64                             acpi-redef
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                           allyesdebian
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                nfsroot
x86_64                          randconfig-e0
x86_64                          randconfig-e1
x86_64                          randconfig-e2
x86_64                          randconfig-e3
x86_64                          randconfig-f0
x86_64                          randconfig-f1
x86_64                          randconfig-f2
x86_64                          randconfig-f3
x86_64                          randconfig-g0
x86_64                          randconfig-g1
x86_64                          randconfig-g2
x86_64                          randconfig-g3
x86_64                          randconfig-h0
x86_64                          randconfig-h1
x86_64                          randconfig-h2
x86_64                          randconfig-h3
x86_64                          randconfig-i0
x86_64                          randconfig-i1
x86_64                          randconfig-i2
x86_64                          randconfig-i3
x86_64                          randconfig-j0
x86_64                          randconfig-j1
x86_64                          randconfig-j2
x86_64                          randconfig-j3
x86_64                          randconfig-k0
x86_64                          randconfig-k1
x86_64                          randconfig-k2
x86_64                          randconfig-k3
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                         rhel-7.2-clear
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 88

openrisc                          allnoconfig
sh                ecovec24-romimage_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     mpc512x_defconfig
x86_64                 randconfig-a0-12051544
x86_64                 randconfig-a0-12051559
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64               randconfig-x004-12051024
x86_64               randconfig-x008-12051024
x86_64               randconfig-x005-12051024
x86_64               randconfig-x007-12051024
x86_64               randconfig-x002-12051024
x86_64               randconfig-x006-12051024
x86_64               randconfig-x003-12051024
x86_64               randconfig-x000-12051024
x86_64               randconfig-x001-12051024
x86_64               randconfig-x009-12051024
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                 randconfig-x003-12051027
i386                 randconfig-x006-12051027
i386                 randconfig-x008-12051027
i386                 randconfig-x005-12051027
i386                 randconfig-x002-12051027
i386                 randconfig-x004-12051027
i386                 randconfig-x000-12051027
i386                 randconfig-x009-12051027
i386                 randconfig-x007-12051027
i386                 randconfig-x001-12051027
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
x86_64               randconfig-x010-12051035
x86_64               randconfig-x017-12051035
x86_64               randconfig-x014-12051035
x86_64               randconfig-x019-12051035
x86_64               randconfig-x018-12051035
x86_64               randconfig-x015-12051035
x86_64               randconfig-x012-12051035
x86_64               randconfig-x011-12051035
x86_64               randconfig-x013-12051035
x86_64               randconfig-x016-12051035
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                   randconfig-s0-12051035
i386                   randconfig-s3-12051035
i386                   randconfig-s2-12051035
i386                   randconfig-s1-12051035
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
riscv                              tinyconfig
i386                               tinyconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
arm                        mini2440_defconfig
sh                           se7705_defconfig
x86_64                randconfig-ws0-12051445
i386                             allmodconfig
powerpc                   motionpro_defconfig
sh                   sh7724_generic_defconfig
m68k                       m5208evb_defconfig
powerpc                        icon_defconfig
sh                           se7724_defconfig
arm                      tct_hammer_defconfig
sh                          rsk7201_defconfig
arm                       aspeed_g4_defconfig
powerpc                     asp8347_defconfig
i386                   randconfig-x0-12051552
i386                   randconfig-x0-12051603
i386                   randconfig-x0-12051634
i386                   randconfig-x0-12051650
i386                   randconfig-x0-12051714
i386                   randconfig-x0-12051725
i386                   randconfig-x0-12051805

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
