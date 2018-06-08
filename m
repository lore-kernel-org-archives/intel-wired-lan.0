From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 8 Jun 2018 09:10:42 -0700
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD
 REGRESSION 84fae5c48a8a73b53ae0add767cb666a93d81f20
In-Reply-To: <5b1aa7c3.dm1H6pKKkqozkhmy%lkp@intel.com>
References: <5b1aa7c3.dm1H6pKKkqozkhmy%lkp@intel.com>
Message-ID: <7bdabca7-19c9-29f7-29bf-b29f8c95902e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jeff - please remove the 2nd commit of
	ixgbe: check ipsec ip addr against mgmt filters
	6ce786b2c8ee7e571637fbb93d91e8c48e3a6c34

sln


On 6/8/2018 8:58 AM, kbuild test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
> branch HEAD: 84fae5c48a8a73b53ae0add767cb666a93d81f20  i40e: implement AF_XDP zero-copy support for Rx
> 
> Regressions in current branch:
> 
> drivers/net/ethernet/intel/i40e/i40e_xsk.c:330:20: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> drivers/net/ethernet/intel/i40e/i40e_xsk.c:330:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:496:56: sparse: restricted __be32 degrades to integer
> drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:543:12: error: redefinition of 'ixgbe_ipsec_check_mgmt_ip'
> 
> Error ids grouped by kconfigs:
> 
> recent_errors
> ??? i386-allmodconfig
> ??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-from-pointer-to-integer-of-different-size
> ??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? i386-randconfig-i1-201822
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? i386-randconfig-s1-201822
> ??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-from-pointer-to-integer-of-different-size
> ??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
> ??? i386-randconfig-x006-201822
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? i386-randconfig-x009-201822
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? i386-randconfig-x072-201822
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? i386-randconfig-x073-201822
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? i386-randconfig-x076-201822
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? ia64-allmodconfig
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? microblaze-allmodconfig
> ??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-from-pointer-to-integer-of-different-size
> ??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? sparc64-allyesconfig
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? sparc-allyesconfig
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? x86_64-allmodconfig
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:restricted-__be32-degrades-to-integer
> ??? x86_64-randconfig-x001-201822
> ??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> ??? x86_64-randconfig-x006-201822
>      ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
> 
> elapsed time: 76m
> 
> configs tested: 113
> 
> i386                   randconfig-x010-201822
> i386                   randconfig-x011-201822
> i386                   randconfig-x012-201822
> i386                   randconfig-x013-201822
> i386                   randconfig-x014-201822
> i386                   randconfig-x015-201822
> i386                   randconfig-x016-201822
> i386                   randconfig-x017-201822
> i386                   randconfig-x018-201822
> i386                   randconfig-x019-201822
> x86_64                              fedora-25
> x86_64                                    lkp
> x86_64                                   rhel
> x86_64                               rhel-7.2
> microblaze                      mmu_defconfig
> microblaze                    nommu_defconfig
> i386                     randconfig-n0-201822
> powerpc                           allnoconfig
> powerpc                             defconfig
> powerpc                       ppc64_defconfig
> s390                        default_defconfig
> i386                     randconfig-i0-201822
> i386                     randconfig-i1-201822
> x86_64                             acpi-redef
> x86_64                           allyesdebian
> x86_64                                nfsroot
> i386                   randconfig-a0-06082326
> i386                   randconfig-a1-06082326
> alpha                               defconfig
> parisc                            allnoconfig
> parisc                         b180_defconfig
> parisc                        c3000_defconfig
> parisc                              defconfig
> microblaze                       allmodconfig
> powerpc                          g5_defconfig
> powerpc                 mpc85xx_cds_defconfig
> powerpc                      ppc44x_defconfig
> x86_64                 randconfig-x011-201822
> x86_64                 randconfig-x015-201822
> x86_64                 randconfig-x018-201822
> x86_64                 randconfig-x010-201822
> x86_64                 randconfig-x014-201822
> x86_64                 randconfig-x019-201822
> x86_64                 randconfig-x013-201822
> x86_64                 randconfig-x017-201822
> x86_64                 randconfig-x016-201822
> x86_64                 randconfig-x012-201822
> i386                             alldefconfig
> i386                              allnoconfig
> i386                                defconfig
> m68k                       m5475evb_defconfig
> m68k                          multi_defconfig
> m68k                           sun3_defconfig
> i386                     randconfig-s0-201822
> i386                     randconfig-s1-201822
> x86_64                           allmodconfig
> x86_64                 randconfig-s3-06082230
> x86_64                 randconfig-s4-06082230
> x86_64                 randconfig-s5-06082230
> openrisc                    or1ksim_defconfig
> um                             i386_defconfig
> um                           x86_64_defconfig
> i386                               tinyconfig
> x86_64                   randconfig-i0-201822
> i386                   randconfig-x009-201822
> i386                   randconfig-x008-201822
> i386                   randconfig-x005-201822
> i386                   randconfig-x001-201822
> i386                   randconfig-x003-201822
> i386                   randconfig-x000-201822
> i386                   randconfig-x004-201822
> i386                   randconfig-x006-201822
> i386                   randconfig-x002-201822
> i386                   randconfig-x007-201822
> mips                           32r2_defconfig
> mips                         64r6el_defconfig
> mips                              allnoconfig
> mips                      fuloong2e_defconfig
> mips                                   jz4740
> mips                      malta_kvm_defconfig
> mips                                     txx9
> sparc                               defconfig
> sparc64                           allnoconfig
> sparc64                             defconfig
> ia64                             alldefconfig
> ia64                              allnoconfig
> ia64                                defconfig
> c6x                        evmc6678_defconfig
> h8300                    h8300h-sim_defconfig
> nios2                         10m50_defconfig
> xtensa                       common_defconfig
> xtensa                          iss_defconfig
> i386                   randconfig-x078-201822
> i386                   randconfig-x079-201822
> i386                   randconfig-x070-201822
> i386                   randconfig-x074-201822
> i386                   randconfig-x076-201822
> i386                   randconfig-x075-201822
> i386                   randconfig-x071-201822
> i386                   randconfig-x073-201822
> i386                   randconfig-x077-201822
> i386                   randconfig-x072-201822
> x86_64                 randconfig-x003-201822
> x86_64                 randconfig-x007-201822
> x86_64                 randconfig-x000-201822
> x86_64                 randconfig-x004-201822
> x86_64                 randconfig-x005-201822
> x86_64                 randconfig-x001-201822
> x86_64                 randconfig-x008-201822
> x86_64                 randconfig-x002-201822
> x86_64                 randconfig-x006-201822
> x86_64                 randconfig-x009-201822
> i386                             allmodconfig
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
