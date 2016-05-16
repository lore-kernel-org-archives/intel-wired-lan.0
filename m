From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:35 -0700
Subject: [Intel-wired-lan] [next PATCH S37 05/15] i40evf: report RSS hash
	capability to stack
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Set the NETIF_F_RXHASH flag to tell the stack that the device hashes
packets.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I0394366ad8e8bf90bb2815d757a402c39628ccb2
---
Testing Hints : Use ethtool -k to see that the device support receive
hashing.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 642bb45..ae67be4 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2233,6 +2233,7 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 				   NETIF_F_GSO_IPIP		|
 				   NETIF_F_GSO_SIT		|
 				   NETIF_F_GSO_UDP_TUNNEL	|
+				   NETIF_F_RXHASH	        |
 				   NETIF_F_GSO_UDP_TUNNEL_CSUM	|
 				   NETIF_F_GSO_PARTIAL		|
 				   NETIF_F_SCTP_CRC		|
-- 
2.4.11

