From: kbuild test robot <lkp@intel.com>
Date: Fri, 15 Apr 2016 05:30:57 +0800
Subject: [Intel-wired-lan] [next-queue PATCH v2 2/3] ixgbe/ixgbevf: Add
 support for GSO partial
In-Reply-To: <20160414211931.14141.18864.stgit@ahduyck-xeon-server>
Message-ID: <201604150504.9z4FjyEc%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alexander,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[cannot apply to v4.6-rc3 next-20160414]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/Add-support-for-GSO-partial-to-Intel-NIC-drivers/20160415-052212
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: xtensa-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_features_check':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9012:41: error: 'NETIF_F_TSO_MANGLEID' undeclared (first use in this function)
     if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
                                            ^
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9012:41: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_probe':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9389:8: error: 'struct net_device' has no member named 'gso_partial_features'
     netdev->gso_partial_features = IXGBE_GSO_PARTIAL_FEATURES;
           ^
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9390:22: error: 'NETIF_F_GSO_PARTIAL' undeclared (first use in this function)
     netdev->features |= NETIF_F_GSO_PARTIAL |
                         ^
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9415:46: error: 'NETIF_F_TSO_MANGLEID' undeclared (first use in this function)
     netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
                                                 ^
--
   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function 'ixgbevf_features_check':
>> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:3914:41: error: 'NETIF_F_TSO_MANGLEID' undeclared (first use in this function)
     if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
                                            ^
   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:3914:41: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function 'ixgbevf_probe':
>> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:4056:8: error: 'struct net_device' has no member named 'gso_partial_features'
     netdev->gso_partial_features = IXGBEVF_GSO_PARTIAL_FEATURES;
           ^
>> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:4057:25: error: 'NETIF_F_GSO_PARTIAL' undeclared (first use in this function)
     netdev->hw_features |= NETIF_F_GSO_PARTIAL |
                            ^
   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:4065:46: error: 'NETIF_F_TSO_MANGLEID' undeclared (first use in this function)
     netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
                                                 ^

vim +/NETIF_F_TSO_MANGLEID +9012 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  9006					    NETIF_F_TSO |
  9007					    NETIF_F_TSO6);
  9008	
  9009		/* We can only support IPV4 TSO in tunnels if we can mangle the
  9010		 * inner IP ID field, so strip TSO if MANGLEID is not supported.
  9011		 */
> 9012		if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
  9013			features &= ~NETIF_F_TSO;
  9014	
  9015		return features;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44869 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160415/b5ea968a/attachment-0001.obj>
