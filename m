From: kbuild test robot <lkp@intel.com>
Date: Fri, 07 Dec 2018 14:03:05 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 a73457fe8784cca7512719229887550c067cfad2
Message-ID: <5c0a0d19.Ca22WXt/SPbW6XOy%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: a73457fe8784cca7512719229887550c067cfad2  i40e: DRY rx_ptype handling code

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11195: undefined reference to `mdiobus_unregister'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11197: undefined reference to `mdiobus_unregister'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8799: undefined reference to `mdiobus_read'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8800: undefined reference to `mdiobus_read'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8822: undefined reference to `mdiobus_write'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8823: undefined reference to `mdiobus_write'
drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:952: undefined reference to `__mdiobus_register'
drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:955: undefined reference to `devm_mdiobus_free'
ERROR: "devm_mdiobus_alloc_size" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: "devm_mdiobus_free" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: "__mdiobus_register" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: "mdiobus_unregister" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
include/linux/phy.h:264: undefined reference to `devm_mdiobus_alloc_size'

Error ids grouped by kconfigs:

recent_errors
??? i386-randconfig-b0-12060250
??? ??? ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? i386-randconfig-c0-12061213
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
??? ??? include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
??? i386-randconfig-h1-12060253
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
??? ??? include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
??? i386-randconfig-s1-12051035
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
??? ??? include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
??? i386-randconfig-s2-12051035
??? ??? ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? i386-randconfig-sb0-12060303
??? ??? ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? i386-randconfig-x0-12060259
??? ??? ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? x86_64-randconfig-b0-12060306
??? ??? ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? x86_64-randconfig-b0-12060404
??? ??? ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? x86_64-randconfig-b0-12060425
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
??? ??? include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
??? x86_64-randconfig-h0-12061302
??? ??? ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? x86_64-randconfig-ne0-12060256
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
??? ??? include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
??? x86_64-randconfig-s0-12060219
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
??? ??? include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
??? x86_64-randconfig-s0-12060254
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
??? ??? include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
??? x86_64-randconfig-s1-12060219
??? ??? ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? x86_64-randconfig-s5-12060309
??? ??? ERROR:devm_mdiobus_alloc_size-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:devm_mdiobus_free-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:__mdiobus_register-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? ??? ERROR:mdiobus_unregister-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? x86_64-randconfig-u0-12060240
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
??? ??? include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size
??? x86_64-randconfig-ws0-12060221
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_read
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_unregister
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:undefined-reference-to-mdiobus_write
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-devm_mdiobus_free
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:undefined-reference-to-__mdiobus_register
    ??? include-linux-phy.h:undefined-reference-to-devm_mdiobus_alloc_size

elapsed time: 2310m

configs tested: 267

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
mips                     decstation_defconfig
sh                           se7750_defconfig
arm                       multi_v4t_defconfig
sparc64                          allyesconfig
arm                          iop33x_defconfig
sh                ecovec24-romimage_defconfig
powerpc                          allmodconfig
sh                     sh7710voipgw_defconfig
x86_64                 randconfig-a0-12060238
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
s390                          debug_defconfig
sh                           se7751_defconfig
powerpc                      chrp32_defconfig
powerpc                     ppa8548_defconfig
arm                          pxa3xx_defconfig
sparc                       sparc32_defconfig
arm                          pxa168_defconfig
openrisc                          allnoconfig
sh                               alldefconfig
sh                            shmin_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-12061213
mips                           ci20_defconfig
powerpc                     pseries_defconfig
arm                      footbridge_defconfig
sh                         ap325rxa_defconfig
m68k                            q40_defconfig
mips                         bigsur_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64               randconfig-x000-12051024
x86_64               randconfig-x001-12051024
x86_64               randconfig-x002-12051024
x86_64               randconfig-x003-12051024
x86_64               randconfig-x004-12051024
x86_64               randconfig-x005-12051024
x86_64               randconfig-x006-12051024
x86_64               randconfig-x007-12051024
x86_64               randconfig-x008-12051024
x86_64               randconfig-x009-12051024
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
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64               randconfig-x010-12051027
x86_64               randconfig-x011-12051027
x86_64               randconfig-x012-12051027
x86_64               randconfig-x013-12051027
x86_64               randconfig-x014-12051027
x86_64               randconfig-x015-12051027
x86_64               randconfig-x016-12051027
x86_64               randconfig-x017-12051027
x86_64               randconfig-x018-12051027
x86_64               randconfig-x019-12051027
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
x86_64                 randconfig-s0-12060219
x86_64                 randconfig-s1-12060219
x86_64                 randconfig-s2-12060219
x86_64                 randconfig-s0-12060254
x86_64                 randconfig-s1-12060254
x86_64                 randconfig-s2-12060254
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                        stmark2_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     tqm8555_defconfig
arm                         em_x270_defconfig
arm                      pxa255-idp_defconfig
m68k                         apollo_defconfig
mips                        msp71xx_defconfig
arm                         vf610m4_defconfig
powerpc                 mpc8315_rdb_defconfig
riscv                            allyesconfig
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
i386                   randconfig-s0-12051035
i386                   randconfig-s3-12051035
i386                   randconfig-s2-12051035
i386                   randconfig-s1-12051035
x86_64                 randconfig-s3-12060309
x86_64                 randconfig-s4-12060309
x86_64                 randconfig-s5-12060309
arm                            mmp2_defconfig
m68k                       m5208evb_defconfig
m68k                          multi_defconfig
i386                   randconfig-b0-12060250
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
ia64                             allmodconfig
s390                             alldefconfig
sh                         ecovec24_defconfig
arm                         lpc18xx_defconfig
mips                           mtx1_defconfig
powerpc                      acadia_defconfig
i386                                defconfig
ia64                            zx1_defconfig
s390                       zfcpdump_defconfig
alpha                            alldefconfig
powerpc                 mpc834x_mds_defconfig
um                                allnoconfig
arm                         s5pv210_defconfig
powerpc                      obs600_defconfig
sh                           se7705_defconfig
x86_64                 randconfig-b0-12060306
x86_64                 randconfig-b0-12060404
x86_64                 randconfig-b0-12060425
mips                  maltasmvp_eva_defconfig
mips                        bcm47xx_defconfig
mips                      maltasmvp_defconfig
x86_64                 randconfig-u0-12060212
x86_64                 randconfig-u0-12060217
x86_64                 randconfig-u0-12060222
x86_64                 randconfig-u0-12060235
x86_64                 randconfig-u0-12060240
x86_64                 randconfig-u0-12060312
x86_64                              fedora-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                         rhel-7.2-clear
m68k                           sun3_defconfig
mips                     loongson1c_defconfig
powerpc                  mpc885_ads_defconfig
arm                        realview_defconfig
sh                          landisk_defconfig
sh                            migor_defconfig
i386                 randconfig-x010-12051027
i386                 randconfig-x011-12051027
i386                 randconfig-x012-12051027
i386                 randconfig-x013-12051027
i386                 randconfig-x014-12051027
i386                 randconfig-x015-12051027
i386                 randconfig-x016-12051027
i386                 randconfig-x017-12051027
i386                 randconfig-x018-12051027
i386                 randconfig-x019-12051027
i386                   randconfig-h0-12060253
i386                   randconfig-h1-12060253
x86_64                randconfig-ne0-12060256
m68k                       bvme6000_defconfig
arm                          collie_defconfig
microblaze                        allnoconfig
powerpc                     virtex5_defconfig
mips                          lasat_defconfig
powerpc64                        alldefconfig
x86_64                 randconfig-h0-12061302
i386                 randconfig-x076-12051024
i386                 randconfig-x073-12051024
i386                 randconfig-x070-12051024
i386                 randconfig-x077-12051024
i386                 randconfig-x078-12051024
i386                 randconfig-x079-12051024
i386                 randconfig-x071-12051024
i386                 randconfig-x075-12051024
i386                 randconfig-x074-12051024
i386                 randconfig-x072-12051024
powerpc                     skiroot_defconfig
xtensa                generic_kc705_defconfig
m68k                       m5475evb_defconfig
i386                  randconfig-sb0-12060218
i386                  randconfig-sb0-12060244
i386                  randconfig-sb0-12060255
i386                  randconfig-sb0-12060303
i386                 randconfig-x003-12051026
i386                 randconfig-x006-12051026
i386                 randconfig-x008-12051026
i386                 randconfig-x005-12051026
i386                 randconfig-x002-12051026
i386                 randconfig-x004-12051026
i386                 randconfig-x000-12051026
i386                 randconfig-x009-12051026
i386                 randconfig-x007-12051026
i386                 randconfig-x001-12051026
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64               randconfig-x004-12051028
x86_64               randconfig-x008-12051028
x86_64               randconfig-x005-12051028
x86_64               randconfig-x003-12051028
x86_64               randconfig-x006-12051028
x86_64               randconfig-x002-12051028
x86_64               randconfig-x007-12051028
x86_64               randconfig-x009-12051028
x86_64               randconfig-x001-12051028
x86_64               randconfig-x000-12051028
arm                           spitz_defconfig
sh                          rsk7264_defconfig
mips                    maltaup_xpa_defconfig
mips                       markeins_defconfig
x86_64                randconfig-ws0-12060145
x86_64                randconfig-ws0-12060221
x86_64                randconfig-ws0-12060304
mips                        nlm_xlr_defconfig
x86_64                randconfig-ws0-12060254
mips                        vocore2_defconfig
xtensa                  cadence_csp_defconfig
x86_64                 randconfig-r0-12060254
i386                             alldefconfig
i386                              allnoconfig
riscv                              tinyconfig
i386                               tinyconfig
i386                             allmodconfig
m68k                        m5407c3_defconfig
um                               allyesconfig
i386                   randconfig-x0-12060218
i386                   randconfig-x0-12060259

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
