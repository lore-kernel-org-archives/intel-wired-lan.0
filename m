From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 11 Nov 2016 12:39:33 -0800
Subject: [Intel-wired-lan] [next PATCH S54 09/15] i40e: fold the
	i40e_is_vsi_in_vlan check into i40e_put_mac_in_vlan
In-Reply-To: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478896779-13697-10-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Fold the check for determining when to call i40e_put_mac_in_vlan directly 
into the function so that we don't need to decide which function to use 
ahead of time. This allows us to just call i40e_put_mac_in_vlan directly 
without having to check ahead of time.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Ifff526940748ac14b8418be5df5a149502eed137
---
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 11 ++++-------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  8 ++------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4630a71..aa61bbb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1503,6 +1503,9 @@ struct i40e_mac_filter *i40e_put_mac_in_vlan(struct i40e_vsi *vsi,
 		return i40e_add_filter(vsi, macaddr,
 				       le16_to_cpu(vsi->info.pvid));
 
+	if (!i40e_is_vsi_in_vlan(vsi))
+		return i40e_add_filter(vsi, macaddr, I40E_VLAN_ANY);
+
 	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
 		if (f->state == I40E_FILTER_REMOVE)
 			continue;
@@ -1761,14 +1764,8 @@ static int i40e_addr_sync(struct net_device *netdev, const u8 *addr)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
-	struct i40e_mac_filter *f;
-
-	if (i40e_is_vsi_in_vlan(vsi))
-		f = i40e_put_mac_in_vlan(vsi, addr);
-	else
-		f = i40e_add_filter(vsi, addr, I40E_VLAN_ANY);
 
-	if (f)
+	if (i40e_put_mac_in_vlan(vsi, addr))
 		return 0;
 	else
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a6198b7..0cdbdd3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1942,12 +1942,8 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 		struct i40e_mac_filter *f;
 
 		f = i40e_find_mac(vsi, al->list[i].addr);
-		if (!f) {
-			if (i40e_is_vsi_in_vlan(vsi))
-				f = i40e_put_mac_in_vlan(vsi, al->list[i].addr);
-			else
-				f = i40e_add_filter(vsi, al->list[i].addr, -1);
-		}
+		if (!f)
+			f = i40e_put_mac_in_vlan(vsi, al->list[i].addr);
 
 		if (!f) {
 			dev_err(&pf->pdev->dev,
-- 
2.4.11

