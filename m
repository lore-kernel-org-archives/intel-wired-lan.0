From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed,  9 Dec 2015 15:50:32 -0800
Subject: [Intel-wired-lan] [next PATCH S23 12/13] i40e: update features with
	right offload
In-Reply-To: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1449705033-4968-13-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Synchronize code bases and add SCTP offload support.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Brandeburg, Jesse <jesse.brandeburg@intel.com>
Change-ID: I9f99071f7176225479026930c387bf681a47494e
---
Testing Hints: Test SCTP in a tunnel like vxlan and make sure
TSO is still working.  Test GRE tunnels and make sure they
work.  See already applied GRE upstream commit for instructions.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 747387f..cc83332 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8847,10 +8847,12 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	np = netdev_priv(netdev);
 	np->vsi = vsi;
 
-	netdev->hw_enc_features |= NETIF_F_IP_CSUM	 |
-				  NETIF_F_GSO_UDP_TUNNEL |
-				  NETIF_F_GSO_GRE	 |
-				  NETIF_F_TSO;
+	netdev->hw_enc_features |= NETIF_F_IP_CSUM	  |
+				   NETIF_F_SCTP_CSUM	  |
+				   NETIF_F_GSO_UDP_TUNNEL |
+				   NETIF_F_GSO_GRE        |
+				   NETIF_F_TSO		  |
+				   0;
 
 	netdev->features = NETIF_F_SG		       |
 			   NETIF_F_IP_CSUM	       |
-- 
2.1.0

