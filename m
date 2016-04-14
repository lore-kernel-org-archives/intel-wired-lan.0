From: kbuild test robot <lkp@intel.com>
Date: Fri, 15 Apr 2016 06:09:52 +0800
Subject: [Intel-wired-lan] [next-queue PATCH v2 3/3] igb/igbvf: Add
 support for GSO partial
In-Reply-To: <20160414211938.14141.76178.stgit@ahduyck-xeon-server>
Message-ID: <201604150631.bBcWPJNY%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alexander,

[auto build test WARNING on jkirsher-next-queue/dev-queue]
[cannot apply to v4.6-rc3 next-20160414]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/Add-support-for-GSO-partial-to-Intel-NIC-drivers/20160415-052212
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: i386-randconfig-x019-201615 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from drivers/net/ethernet/intel/igb/igb_main.c:26:
   drivers/net/ethernet/intel/igb/igb_main.c: In function 'igb_features_check':
   drivers/net/ethernet/intel/igb/igb_main.c:2118:41: error: 'NETIF_F_TSO_MANGLEID' undeclared (first use in this function)
     if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
                                            ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^
>> drivers/net/ethernet/intel/igb/igb_main.c:2118:2: note: in expansion of macro 'if'
     if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
     ^
   drivers/net/ethernet/intel/igb/igb_main.c:2118:41: note: each undeclared identifier is reported only once for each function it appears in
     if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
                                            ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^
>> drivers/net/ethernet/intel/igb/igb_main.c:2118:2: note: in expansion of macro 'if'
     if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
     ^
   drivers/net/ethernet/intel/igb/igb_main.c: In function 'igb_probe':
   drivers/net/ethernet/intel/igb/igb_main.c:2426:8: error: 'struct net_device' has no member named 'gso_partial_features'
     netdev->gso_partial_features = IGB_GSO_PARTIAL_FEATURES;
           ^
   drivers/net/ethernet/intel/igb/igb_main.c:2427:22: error: 'NETIF_F_GSO_PARTIAL' undeclared (first use in this function)
     netdev->features |= NETIF_F_GSO_PARTIAL | IGB_GSO_PARTIAL_FEATURES;
                         ^
   drivers/net/ethernet/intel/igb/igb_main.c:2441:46: error: 'NETIF_F_TSO_MANGLEID' undeclared (first use in this function)
     netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
                                                 ^

vim +/if +2118 drivers/net/ethernet/intel/igb/igb_main.c

  2102			return features & ~(NETIF_F_HW_CSUM |
  2103					    NETIF_F_SCTP_CRC |
  2104					    NETIF_F_HW_VLAN_CTAG_TX |
  2105					    NETIF_F_TSO |
  2106					    NETIF_F_TSO6);
  2107	
  2108		network_hdr_len = skb_checksum_start(skb) - skb_network_header(skb);
  2109		if (unlikely(network_hdr_len >  IGB_MAX_NETWORK_HDR_LEN))
  2110			return features & ~(NETIF_F_HW_CSUM |
  2111					    NETIF_F_SCTP_CRC |
  2112					    NETIF_F_TSO |
  2113					    NETIF_F_TSO6);
  2114	
  2115		/* We can only support IPV4 TSO in tunnels if we can mangle the
  2116		 * inner IP ID field, so strip TSO if MANGLEID is not supported.
  2117		 */
> 2118		if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
  2119			features &= ~NETIF_F_TSO;
  2120	
  2121		return features;
  2122	}
  2123	
  2124	static const struct net_device_ops igb_netdev_ops = {
  2125		.ndo_open		= igb_open,
  2126		.ndo_stop		= igb_close,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25883 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160415/368fa997/attachment-0001.obj>
