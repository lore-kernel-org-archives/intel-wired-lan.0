From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 16 Dec 2015 08:08:06 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 40/48]
 drivers/net/ethernet/intel/i40e/i40e_main.c:8852:8: error:
 'NETIF_F_SCTP_CSUM' undeclared
Message-ID: <201512160803.JGEOB3vi%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   63cbb805810e49b86b8e460e52f39625e20a2873
commit: 55a6cf2bbcb895183030a7020f67b7ada0bea4c0 [40/48] i40e: update features with right offload
config: x86_64-randconfig-x017-12141150 (attached as .config)
reproduce:
        git checkout 55a6cf2bbcb895183030a7020f67b7ada0bea4c0
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_config_netdev':
>> drivers/net/ethernet/intel/i40e/i40e_main.c:8852:8: error: 'NETIF_F_SCTP_CSUM' undeclared (first use in this function)
           NETIF_F_SCTP_CSUM   |
           ^
   drivers/net/ethernet/intel/i40e/i40e_main.c:8852:8: note: each undeclared identifier is reported only once for each function it appears in

vim +/NETIF_F_SCTP_CSUM +8852 drivers/net/ethernet/intel/i40e/i40e_main.c

  8846	
  8847		vsi->netdev = netdev;
  8848		np = netdev_priv(netdev);
  8849		np->vsi = vsi;
  8850	
  8851		netdev->hw_enc_features |= NETIF_F_IP_CSUM	  |
> 8852					   NETIF_F_SCTP_CSUM	  |
  8853					   NETIF_F_GSO_UDP_TUNNEL |
  8854					   NETIF_F_GSO_GRE	  |
  8855					   NETIF_F_TSO		  |

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24868 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151216/68123bab/attachment-0001.obj>
