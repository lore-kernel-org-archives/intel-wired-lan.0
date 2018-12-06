From: kbuild test robot <lkp@intel.com>
Date: Thu, 06 Dec 2018 13:19:52 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 d3daa6adeda2134473d321a6c34587fcf9e8a000
Message-ID: <5c08b178.u8/Nnjg6O3oDNx/F%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: d3daa6adeda2134473d321a6c34587fcf9e8a000  ixgbe: Fix race when the VF driver does a reset

Regressions in current branch:

ERROR: "__mdiobus_register" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: "devm_mdiobus_alloc_size" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: "devm_mdiobus_free" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: "mdiobus_unregister" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11197: undefined reference to `mdiobus_unregister'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8800: undefined reference to `mdiobus_read'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8823: undefined reference to `mdiobus_write'
drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:952: undefined reference to `__mdiobus_register'
drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:955: undefined reference to `devm_mdiobus_free'
include/linux/phy.h:264: undefined reference to `devm_mdiobus_alloc_size'

Error ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-b0-12060538
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- i386-randconfig-b0-12060606
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- i386-randconfig-h0-12060610
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- i386-randconfig-sb0-12060525
|   |-- ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   `-- ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|-- i386-randconfig-sb0-12060613
|   |-- ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   `-- ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|-- x86_64-randconfig-a0-12060542
|   |-- ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   `-- ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|-- x86_64-randconfig-a0-12060629
|   |-- ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   `-- ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|-- x86_64-randconfig-b0-12060516
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- x86_64-randconfig-b0-12060548
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- x86_64-randconfig-g0-12060606
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- x86_64-randconfig-s0-12060627
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- x86_64-randconfig-s1-12060501
|   |-- ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   `-- ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|-- x86_64-randconfig-s1-12060531
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- x86_64-randconfig-s3-12060503
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- x86_64-randconfig-s3-12060627
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- x86_64-randconfig-s5-12060503
|   |-- ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   `-- ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|-- x86_64-randconfig-s5-12060530
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- x86_64-randconfig-s5-12060600
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- x86_64-randconfig-s5-12060627
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
|   `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
|-- x86_64-randconfig-u0-12060541
|   |-- ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   |-- ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
|   `-- ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
`-- x86_64-randconfig-u0-12060631
    |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
    |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
    |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
    |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
    |-- drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
    `-- include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size

TIMEOUT after 601m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 275

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
alpha                            allmodconfig
sh                          rsk7264_defconfig
arm                         hackkit_defconfig
powerpc                     tqm8540_defconfig
arm                            xcep_defconfig
m68k                        mvme16x_defconfig
x86_64                 randconfig-a0-12060509
x86_64                 randconfig-a0-12060542
x86_64                 randconfig-a0-12060629
m68k                           sun3_defconfig
powerpc                      pmac32_defconfig
arm                          nuc950_defconfig
powerpc                 canyonlands_defconfig
arm                            lart_defconfig
sh                          rsk7201_defconfig
i386                 randconfig-x010-12051023
i386                 randconfig-x011-12051023
i386                 randconfig-x012-12051023
i386                 randconfig-x013-12051023
i386                 randconfig-x014-12051023
i386                 randconfig-x015-12051023
i386                 randconfig-x016-12051023
i386                 randconfig-x017-12051023
i386                 randconfig-x018-12051023
i386                 randconfig-x019-12051023
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
nds32                             allnoconfig
nds32                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
riscv                             allnoconfig
riscv                               defconfig
mips                           ci20_defconfig
mips                      pic32mzda_defconfig
parisc                      default_defconfig
arm                        neponset_defconfig
mips                           ip27_defconfig
i386                             allyesconfig
powerpc                 mpc837x_mds_defconfig
x86_64                 randconfig-g0-12060606
i386                   randconfig-x005-201848
i386                   randconfig-x006-201848
i386                   randconfig-x007-201848
i386                   randconfig-x000-201848
i386                   randconfig-x004-201848
i386                   randconfig-x002-201848
i386                   randconfig-x009-201848
i386                   randconfig-x001-201848
i386                   randconfig-x008-201848
i386                   randconfig-x003-201848
x86_64               randconfig-x013-12051027
x86_64               randconfig-x012-12051027
x86_64               randconfig-x017-12051027
x86_64               randconfig-x019-12051027
x86_64               randconfig-x018-12051027
x86_64               randconfig-x016-12051027
x86_64               randconfig-x014-12051027
x86_64               randconfig-x011-12051027
x86_64               randconfig-x015-12051027
x86_64               randconfig-x010-12051027
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
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                 randconfig-s0-12060501
x86_64                 randconfig-s1-12060501
x86_64                 randconfig-s2-12060501
x86_64                 randconfig-s0-12060531
x86_64                 randconfig-s1-12060531
x86_64                 randconfig-s2-12060531
x86_64                 randconfig-s0-12060604
x86_64                 randconfig-s1-12060604
x86_64                 randconfig-s2-12060604
x86_64                 randconfig-s0-12060627
x86_64                 randconfig-s1-12060627
x86_64                 randconfig-s2-12060627
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
mips                        nlm_xlr_defconfig
powerpc                          g5_defconfig
m68k                       m5249evb_defconfig
powerpc64                         allnoconfig
sh                          r7780mp_defconfig
um                               alldefconfig
arm                       mainstone_defconfig
arm                           sama5_defconfig
arm                         axm55xx_defconfig
arm                     eseries_pxa_defconfig
sh                         ecovec24_defconfig
xtensa                  nommu_kc705_defconfig
arm                         lpc18xx_defconfig
arm                       netwinder_defconfig
arm                          pcm027_defconfig
powerpc                  mpc866_ads_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                   randconfig-s0-12051035
i386                   randconfig-s1-12051035
i386                   randconfig-s2-12051035
i386                   randconfig-s3-12051035
x86_64                 randconfig-s3-12060503
x86_64                 randconfig-s4-12060503
x86_64                 randconfig-s5-12060503
x86_64                 randconfig-s3-12060530
x86_64                 randconfig-s4-12060530
x86_64                 randconfig-s5-12060530
x86_64                 randconfig-s3-12060600
x86_64                 randconfig-s4-12060600
x86_64                 randconfig-s5-12060600
x86_64                 randconfig-s3-12060627
x86_64                 randconfig-s4-12060627
x86_64                 randconfig-s5-12060627
i386                             allmodconfig
arm                        oxnas_v6_defconfig
c6x                        evmc6474_defconfig
mips                           xway_defconfig
arm                       versatile_defconfig
sh                           se7705_defconfig
xtensa                              defconfig
mips                      maltaaprp_defconfig
powerpc               mpc86xx_basic_defconfig
powerpc                      pasemi_defconfig
i386                   randconfig-b0-12060538
i386                   randconfig-b0-12060606
i386                   randconfig-b0-12060620
openrisc                         alldefconfig
powerpc                    klondike_defconfig
sh                        edosk7705_defconfig
arm                           u8500_defconfig
parisc                          712_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-b0-12060516
x86_64                 randconfig-b0-12060548
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
powerpc                      obs600_defconfig
xtensa                    smp_lx200_defconfig
openrisc                          allnoconfig
s390                             allmodconfig
powerpc                      katmai_defconfig
powerpc                      tqm8xx_defconfig
arm                         ebsa110_defconfig
sh                        edosk7760_defconfig
powerpc                       ebony_defconfig
x86_64                 randconfig-u0-12060508
x86_64                 randconfig-u0-12060532
x86_64                 randconfig-u0-12060541
x86_64                 randconfig-u0-12060631
arm                          nuc960_defconfig
arm                        cerfcube_defconfig
sh                         microdev_defconfig
sh                   sh7770_generic_defconfig
powerpc                      ppc40x_defconfig
i386                   randconfig-h0-12060610
i386                   randconfig-h1-12060610
powerpc                     tqm8555_defconfig
sh                      rts7751r2d1_defconfig
xtensa                           allmodconfig
arm                            u300_defconfig
x86_64                randconfig-ne0-12060522
x86_64                randconfig-ne0-12060547
x86_64                randconfig-ne0-12060612
x86_64                randconfig-ne0-12060631
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                 randconfig-x070-12051024
i386                 randconfig-x071-12051024
i386                 randconfig-x072-12051024
i386                 randconfig-x073-12051024
i386                 randconfig-x074-12051024
i386                 randconfig-x075-12051024
i386                 randconfig-x076-12051024
i386                 randconfig-x077-12051024
i386                 randconfig-x078-12051024
i386                 randconfig-x079-12051024
arm                         lubbock_defconfig
m68k                       m5475evb_defconfig
powerpc                    adder875_defconfig
arm                         bcm2835_defconfig
mips                         cobalt_defconfig
mips                      fuloong2e_defconfig
m68k                          multi_defconfig
i386                  randconfig-sb0-12060455
i386                  randconfig-sb0-12060519
i386                  randconfig-sb0-12060525
i386                  randconfig-sb0-12060613
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64               randconfig-x000-12051028
x86_64               randconfig-x001-12051028
x86_64               randconfig-x002-12051028
x86_64               randconfig-x003-12051028
x86_64               randconfig-x004-12051028
x86_64               randconfig-x005-12051028
x86_64               randconfig-x006-12051028
x86_64               randconfig-x007-12051028
x86_64               randconfig-x008-12051028
x86_64               randconfig-x009-12051028
alpha                            alldefconfig
sh                            hp6xx_defconfig
powerpc                     virtex5_defconfig
x86_64                randconfig-ws0-12060546
parisc                           alldefconfig
powerpc                      pcm030_defconfig
sparc                             allnoconfig
x86_64                randconfig-ws0-12060541
powerpc                     ppa8548_defconfig
arm                     am200epdkit_defconfig
mips                         mpc30x_defconfig
sparc64                          allyesconfig
arm                             mxs_defconfig
mips                           ip28_defconfig
x86_64                           alldefconfig
mips                                defconfig
mips                        omega2p_defconfig
sh                           se7343_defconfig
mips                    maltaup_xpa_defconfig
x86_64                 randconfig-r0-12060503
x86_64                 randconfig-r0-12060620
x86_64                 randconfig-r0-12060627
i386                 randconfig-x076-12051027
i386                 randconfig-x073-12051027
i386                 randconfig-x070-12051027
i386                 randconfig-x077-12051027
i386                 randconfig-x078-12051027
i386                 randconfig-x079-12051027
i386                 randconfig-x071-12051027
i386                 randconfig-x075-12051027
i386                 randconfig-x072-12051027
i386                 randconfig-x074-12051027
powerpc                 mpc834x_mds_defconfig
powerpc                     rainier_defconfig
arm                         s3c6400_defconfig
powerpc                  storcenter_defconfig
mips                             allmodconfig
mips                            gpr_defconfig
i386                   randconfig-x0-12060508
i386                   randconfig-x0-12060541

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
