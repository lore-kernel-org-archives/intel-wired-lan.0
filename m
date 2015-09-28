From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:40 -0400
Subject: [Intel-wired-lan] [next PATCH S16 11/15] i40evf: correctly populate
	vlan_features
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-12-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The vlan_features field was correctly being set to the same value as the
netdev features field. However, this was being done before the features
were actually being set up, leaving the vlan_features empty.

Also, after a reset, vlan_features will be incorrectly assigned the
previous netdev feature flags, which can contain VLAN feature bits. This
makes the VLAN code angry and will cause a stack dump.

To fix these issues, set up the netdev features first, then mask out the
VLAN feature bits when assigning vlan_features.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ib0548869dc83cf6a841cb8697dd94c12359ba4d2
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 5e13363..9e754d0 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2123,7 +2123,10 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 
 	if (adapter->vf_res->vf_offload_flags
 	    & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
-		netdev->vlan_features = netdev->features;
+		netdev->vlan_features = netdev->features &
+					~(NETIF_F_HW_VLAN_CTAG_TX |
+					  NETIF_F_HW_VLAN_CTAG_RX |
+					  NETIF_F_HW_VLAN_CTAG_FILTER);
 		netdev->features |= NETIF_F_HW_VLAN_CTAG_TX |
 				    NETIF_F_HW_VLAN_CTAG_RX |
 				    NETIF_F_HW_VLAN_CTAG_FILTER;
-- 
1.9.3

