From: kbuild test robot <lkp@intel.com>
Date: Thu, 31 May 2018 05:19:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 23/23]
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:487:56: sparse: restricted
 __be32 degrades to integer
Message-ID: <201805310540.szHDcL2j%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   ed1478d17c3cdbab3505566f63fe24cdb1c952b0
commit: ed1478d17c3cdbab3505566f63fe24cdb1c952b0 [23/23] ixgbe: check ipsec ip addr against mgmt filters
reproduce:
        # apt-get install sparse
        git checkout ed1478d17c3cdbab3505566f63fe24cdb1c952b0
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:487:56: sparse: restricted __be32 degrades to integer
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:494:48: sparse: restricted __be32 degrades to integer
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:509:59: sparse: restricted __be32 degrades to integer
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:519:59: sparse: restricted __be32 degrades to integer

vim +487 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c

   472	
   473		manc = IXGBE_READ_REG(hw, IXGBE_MANC);
   474		manc_ipv4 = !!(manc & MANC_EN_IPV4_FILTER);
   475		mfval = IXGBE_READ_REG(hw, IXGBE_MFVAL);
   476		bmcipval = IXGBE_READ_REG(hw, IXGBE_BMCIPVAL);
   477	
   478		if (xs->props.family == AF_INET) {
   479			/* are there any IPv4 filters to check? */
   480			if (manc_ipv4) {
   481				/* the 4 ipv4 filters are all in MIPAF(3, i) */
   482				for (i = 0; i < num_filters; i++) {
   483					if (!(mfval & BIT(MFVAL_IPV4_FILTER_SHIFT + i)))
   484						continue;
   485	
   486					reg = IXGBE_READ_REG(hw, MIPAF_ARR(3, i));
 > 487					if (reg == xs->id.daddr.a4)
   488						return 1;
   489				}
   490			}
   491	
   492			if ((bmcipval & BMCIP_MASK) == BMCIP_V4) {
   493				reg = IXGBE_READ_REG(hw, IXGBE_BMCIP(3));
   494				if (reg == xs->id.daddr.a4)
   495					return 1;
   496			}
   497	
   498		} else {
   499			/* if there are ipv4 filters, they are in the last ipv6 slot */
   500			if (manc_ipv4)
   501				num_filters = 3;
   502	
   503			for (i = 0; i < num_filters; i++) {
   504				if (!(mfval & BIT(MFVAL_IPV6_FILTER_SHIFT + i)))
   505					continue;
   506	
   507				for (j = 0; j < 4; j++) {
   508					reg = IXGBE_READ_REG(hw, MIPAF_ARR(i, j));
   509					if (reg != xs->id.daddr.a6[j])
   510						break;
   511				}
   512				if (j == 4)   /* did we match all 4 words? */
   513					return 1;
   514			}
   515	
   516			if ((bmcipval & BMCIP_MASK) == BMCIP_V6) {
   517				for (j = 0; j < 4; j++) {
   518					reg = IXGBE_READ_REG(hw, IXGBE_BMCIP(j));
   519					if (reg != xs->id.daddr.a6[j])
   520						break;
   521				}
   522				if (j == 4)   /* did we match all 4 words? */
   523					return 1;
   524			}
   525		}
   526	
   527		return 0;
   528	}
   529	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
