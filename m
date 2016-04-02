From: Alexander Duyck <aduyck@mirantis.com>
Date: Sat, 02 Apr 2016 00:05:14 -0700
Subject: [Intel-wired-lan] [next PATCH 1/2] i40e/i40evf: Clean up feature
	flags
In-Reply-To: <20160402070114.13504.22615.stgit@localhost.localdomain>
References: <20160402070114.13504.22615.stgit@localhost.localdomain>
Message-ID: <20160402070319.13504.88242.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The feature flags list for i40e and i40evf is beginning to become pretty
massive.  I plan to add another 4 or so features to these drivers and
duplicating the flags for each and every flags list is becoming a bit
repetitive.

The primary change here is that we now build our features list around
hw_encap_features.  After that we assign that to vlan_features,
hw_features, and finally map that onto features.  In addition we end up
throwing features onto hw_encap_features that end up having no effect such
as the Rx offloads and SCTP_CRC.  However that should have no impact and
makes things a bit easier for us as hw_encap_features is one of the less
updated features maps available.

For i40evf I went through and sanity checked a few features as well.
Specifically RXCSUM was being set as a read-only feature which didn't make
much sense.  I have updated things so we can clear the NETIF_F_RXCSUM flag
since that is really a software feature and not a hardware one anyway so
disabling it is just a matter of ignoring the result from the hardware.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---

Testing-hints:
  The only real testing required for this patch is to verify the features
  make sense after the patch has been applied.  Most of the change is to
  deal with things like the fact that we were allowing VLAN filtering to be
  toggled but didn't actually do anything to disable it when it was.

 drivers/net/ethernet/intel/i40e/i40e_main.c     |   61 +++++++++------------
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |   66 +++++++++++------------
 2 files changed, 58 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d6147f899062..9100d34913a7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9110,40 +9110,36 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	np = netdev_priv(netdev);
 	np->vsi = vsi;
 
-	netdev->hw_enc_features |= NETIF_F_IP_CSUM	       |
-				   NETIF_F_IPV6_CSUM	       |
-				   NETIF_F_TSO		       |
-				   NETIF_F_TSO6		       |
-				   NETIF_F_TSO_ECN	       |
-				   NETIF_F_GSO_GRE	       |
-				   NETIF_F_GSO_UDP_TUNNEL      |
-				   NETIF_F_GSO_UDP_TUNNEL_CSUM |
+	netdev->hw_enc_features |= NETIF_F_SG			|
+				   NETIF_F_IP_CSUM		|
+				   NETIF_F_IPV6_CSUM		|
+				   NETIF_F_HIGHDMA		|
+				   NETIF_F_SOFT_FEATURES	|
+				   NETIF_F_TSO			|
+				   NETIF_F_TSO_ECN		|
+				   NETIF_F_TSO6			|
+				   NETIF_F_GSO_GRE		|
+				   NETIF_F_GSO_UDP_TUNNEL	|
+				   NETIF_F_GSO_UDP_TUNNEL_CSUM	|
+				   NETIF_F_SCTP_CRC		|
+				   NETIF_F_RXHASH		|
+				   NETIF_F_RXCSUM		|
 				   0;
 
-	netdev->features = NETIF_F_SG		       |
-			   NETIF_F_IP_CSUM	       |
-			   NETIF_F_SCTP_CRC	       |
-			   NETIF_F_HIGHDMA	       |
-			   NETIF_F_GSO_UDP_TUNNEL      |
-			   NETIF_F_GSO_GRE	       |
-			   NETIF_F_HW_VLAN_CTAG_TX     |
-			   NETIF_F_HW_VLAN_CTAG_RX     |
-			   NETIF_F_HW_VLAN_CTAG_FILTER |
-			   NETIF_F_IPV6_CSUM	       |
-			   NETIF_F_TSO		       |
-			   NETIF_F_TSO_ECN	       |
-			   NETIF_F_TSO6		       |
-			   NETIF_F_RXCSUM	       |
-			   NETIF_F_RXHASH	       |
-			   0;
+	if (!(pf->flags & I40E_FLAG_OUTER_UDP_CSUM_CAPABLE))
+		netdev->hw_enc_features ^= NETIF_F_GSO_UDP_TUNNEL_CSUM;
+
+	/* record features VLANs can make use of */
+	netdev->vlan_features |= netdev->hw_enc_features;
 
 	if (!(pf->flags & I40E_FLAG_MFP_ENABLED))
-		netdev->features |= NETIF_F_NTUPLE;
-	if (pf->flags & I40E_FLAG_OUTER_UDP_CSUM_CAPABLE)
-		netdev->features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
+		netdev->hw_features |= NETIF_F_NTUPLE;
+
+	netdev->hw_features |= netdev->hw_enc_features	|
+			       NETIF_F_HW_VLAN_CTAG_TX	|
+			       NETIF_F_HW_VLAN_CTAG_RX;
 
-	/* copy netdev features into list of user selectable features */
-	netdev->hw_features |= netdev->features;
+	netdev->features |= netdev->hw_features | NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	if (vsi->type == I40E_VSI_MAIN) {
 		SET_NETDEV_DEV(netdev, &pf->pdev->dev);
@@ -9182,12 +9178,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 
 	ether_addr_copy(netdev->dev_addr, mac_addr);
 	ether_addr_copy(netdev->perm_addr, mac_addr);
-	/* vlan gets same features (except vlan offload)
-	 * after any tweaks for specific VSI types
-	 */
-	netdev->vlan_features = netdev->features & ~(NETIF_F_HW_VLAN_CTAG_TX |
-						     NETIF_F_HW_VLAN_CTAG_RX |
-						   NETIF_F_HW_VLAN_CTAG_FILTER);
+
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 	/* Setup netdev TC information */
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 9549f0fcdb39..a24966e4873a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2318,40 +2318,38 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 		return -ENODEV;
 	}
 
-	netdev->features |= NETIF_F_HIGHDMA |
-			    NETIF_F_SG |
-			    NETIF_F_IP_CSUM |
-			    NETIF_F_SCTP_CRC |
-			    NETIF_F_IPV6_CSUM |
-			    NETIF_F_TSO |
-			    NETIF_F_TSO6 |
-			    NETIF_F_TSO_ECN |
-			    NETIF_F_GSO_GRE |
-			    NETIF_F_GSO_UDP_TUNNEL |
-			    NETIF_F_RXCSUM |
-			    NETIF_F_GRO;
-
-	netdev->hw_enc_features |= NETIF_F_IP_CSUM	       |
-				   NETIF_F_IPV6_CSUM	       |
-				   NETIF_F_TSO		       |
-				   NETIF_F_TSO6		       |
-				   NETIF_F_TSO_ECN	       |
-				   NETIF_F_GSO_GRE	       |
-				   NETIF_F_GSO_UDP_TUNNEL      |
-				   NETIF_F_GSO_UDP_TUNNEL_CSUM;
-
-	if (adapter->flags & I40EVF_FLAG_OUTER_UDP_CSUM_CAPABLE)
-		netdev->features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
-
-	/* always clear VLAN features because they can change at every reset */
-	netdev->features &= ~(I40EVF_VLAN_FEATURES);
-	/* copy netdev features into list of user selectable features */
-	netdev->hw_features |= netdev->features;
-
-	if (vfres->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
-		netdev->vlan_features = netdev->features;
-		netdev->features |= I40EVF_VLAN_FEATURES;
-	}
+	netdev->hw_enc_features |= NETIF_F_SG			|
+				   NETIF_F_IP_CSUM		|
+				   NETIF_F_IPV6_CSUM		|
+				   NETIF_F_HIGHDMA		|
+				   NETIF_F_SOFT_FEATURES	|
+				   NETIF_F_TSO			|
+				   NETIF_F_TSO_ECN		|
+				   NETIF_F_TSO6			|
+				   NETIF_F_GSO_GRE		|
+				   NETIF_F_GSO_UDP_TUNNEL	|
+				   NETIF_F_GSO_UDP_TUNNEL_CSUM	|
+				   NETIF_F_SCTP_CRC		|
+				   NETIF_F_RXHASH		|
+				   NETIF_F_RXCSUM		|
+				   0;
+
+	if (!(adapter->flags & I40EVF_FLAG_OUTER_UDP_CSUM_CAPABLE))
+		netdev->hw_enc_features ^= NETIF_F_GSO_UDP_TUNNEL_CSUM;
+
+	/* record features VLANs can make use of */
+	netdev->vlan_features |= netdev->hw_enc_features;
+
+	/* Write features and hw_features separately to avoid polluting
+	 * with, or dropping, features that are set when we registgered.
+	 */
+	netdev->hw_features |= netdev->hw_enc_features;
+
+	netdev->features |= netdev->hw_enc_features | I40EVF_VLAN_FEATURES;
+
+	/* disable VLAN features if not supported */
+	if (!(vfres->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_VLAN))
+		netdev->features ^= I40EVF_VLAN_FEATURES;
 
 	adapter->vsi.id = adapter->vsi_res->vsi_id;
 

