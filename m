From: Alexander Duyck <aduyck@mirantis.com>
Date: Sun, 24 Jan 2016 21:17:50 -0800
Subject: [Intel-wired-lan] [next PATCH v3 14/15] i40e: Update feature flags
 to reflect newly enabled features
In-Reply-To: <20160125050602.12004.38884.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
Message-ID: <20160125051750.12004.24225.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Recent changes should have enabled support for IPv6 based tunnels and
support for TSO with outer UDP checksums.  As such we can update the
feature flags to reflect that.

In addition we can clean-up the flags that aren't needed such as SCTP and
RXCSUM since having the bits there doesn't add any value.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e3a903f01d73..1d969acf9517 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9023,12 +9023,14 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	np = netdev_priv(netdev);
 	np->vsi = vsi;
 
-	netdev->hw_enc_features |= NETIF_F_IP_CSUM	  |
-				   NETIF_F_RXCSUM	  |
-				   NETIF_F_SCTP_CRC	  |
-				   NETIF_F_GSO_UDP_TUNNEL |
-				   NETIF_F_GSO_GRE	  |
-				   NETIF_F_TSO		  |
+	netdev->hw_enc_features |= NETIF_F_IP_CSUM	       |
+				   NETIF_F_IPV6_CSUM	       |
+				   NETIF_F_TSO		       |
+				   NETIF_F_TSO6		       |
+				   NETIF_F_TSO_ECN	       |
+				   NETIF_F_GSO_GRE	       |
+				   NETIF_F_GSO_UDP_TUNNEL      |
+				   NETIF_F_GSO_UDP_TUNNEL_CSUM |
 				   0;
 
 	netdev->features = NETIF_F_SG		       |
@@ -9050,6 +9052,8 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 
 	if (!(pf->flags & I40E_FLAG_MFP_ENABLED))
 		netdev->features |= NETIF_F_NTUPLE;
+	if (pf->flags & I40E_FLAG_OUTER_UDP_CSUM_CAPABLE)
+		netdev->features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
 
 	/* copy netdev features into list of user selectable features */
 	netdev->hw_features |= netdev->features;

