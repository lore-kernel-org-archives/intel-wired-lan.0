From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 11 Nov 2016 12:39:32 -0800
Subject: [Intel-wired-lan] [next PATCH S54 08/15] i40e: don't allow
	i40e_vsi_(add|kill)_vlan to operate when VID<1
In-Reply-To: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478896779-13697-9-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Now that we have the separate i40e_(add|rm)_vlan_all_mac functions, we
should not be using the i40e_vsi_kill_vlan or i40e_vsi_add_vlan
functions when PVID is set or when VID is less than 1. This allows us to
remove some checks in i40e_vsi_add_vlan and ensures that callers which
need to handle VID=0 or VID=-1 don't accidentally invoke the VLAN mode
handling used to convert filters when entering VLAN mode. We also update
the functions to take u16 instead of s16 as well since they no longer
expect to be called with VID=I40E_VLAN_ANY.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Ibddf44a8bb840dde8ceef2a4fdb92fd953b05a57
---
Testing-hints:
  Ensure that add/remove VLAN works correctly for PFs, and for VFs when
  not assigning a PVID.

 drivers/net/ethernet/intel/i40e/i40e.h      |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 03b95cf..dd8c3f3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -854,9 +854,9 @@ int i40e_close(struct net_device *netdev);
 int i40e_vsi_open(struct i40e_vsi *vsi);
 void i40e_vlan_stripping_disable(struct i40e_vsi *vsi);
 int i40e_add_vlan_all_mac(struct i40e_vsi *vsi, s16 vid);
-int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid);
+int i40e_vsi_add_vlan(struct i40e_vsi *vsi, u16 vid);
 void i40e_rm_vlan_all_mac(struct i40e_vsi *vsi, s16 vid);
-void i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid);
+void i40e_vsi_kill_vlan(struct i40e_vsi *vsi, u16 vid);
 struct i40e_mac_filter *i40e_put_mac_in_vlan(struct i40e_vsi *vsi,
 					     const u8 *macaddr);
 int i40e_del_mac_all_vlan(struct i40e_vsi *vsi, const u8 *macaddr);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e8cb82b..4630a71 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2562,12 +2562,15 @@ int i40e_add_vlan_all_mac(struct i40e_vsi *vsi, s16 vid)
 /**
  * i40e_vsi_add_vlan - Add vsi membership for given vlan
  * @vsi: the vsi being configured
- * @vid: vlan id to be added (0 = untagged only , -1 = any)
+ * @vid: vlan id to be added
  **/
-int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
+int i40e_vsi_add_vlan(struct i40e_vsi *vsi, u16 vid)
 {
 	int err;
 
+	if (!(vid > 0) || vsi->info.pvid)
+		return -EINVAL;
+
 	/* Locked once because all functions invoked below iterates list*/
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 	err = i40e_add_vlan_all_mac(vsi, vid);
@@ -2610,10 +2613,13 @@ void i40e_rm_vlan_all_mac(struct i40e_vsi *vsi, s16 vid)
 /**
  * i40e_vsi_kill_vlan - Remove vsi membership for given vlan
  * @vsi: the vsi being configured
- * @vid: vlan id to be removed (0 = untagged only , -1 = any)
+ * @vid: vlan id to be removed
  **/
-void i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid)
+void i40e_vsi_kill_vlan(struct i40e_vsi *vsi, u16 vid)
 {
+	if (!(vid > 0) || vsi->info.pvid)
+		return;
+
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 	i40e_rm_vlan_all_mac(vsi, vid);
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
-- 
2.4.11

