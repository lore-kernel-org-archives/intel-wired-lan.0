From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Feb 2019 15:08:17 -0800
Subject: [Intel-wired-lan] [next PATCH S2-V2 03/12] i40e: don't allow
 changes to HW vlan stripping on active port vlans
In-Reply-To: <20190206230826.24970-1-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
Message-ID: <20190206230826.24970-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nicholas Nunley <nicholas.d.nunley@intel.com>

Modifying the vlan stripping options when a port vlan is configured
will break traffic for the VSI, and conceptually doesn't make sense,
so don't allow this.

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d975e25107c1..3b6768980d8c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2654,6 +2654,10 @@ void i40e_vlan_stripping_enable(struct i40e_vsi *vsi)
 	struct i40e_vsi_context ctxt;
 	i40e_status ret;
 
+	/* Don't modify stripping options if a port vlan is active */
+	if (vsi->info.pvid)
+		return;
+
 	if ((vsi->info.valid_sections &
 	     cpu_to_le16(I40E_AQ_VSI_PROP_VLAN_VALID)) &&
 	    ((vsi->info.port_vlan_flags & I40E_AQ_VSI_PVLAN_MODE_MASK) == 0))
@@ -2684,6 +2688,10 @@ void i40e_vlan_stripping_disable(struct i40e_vsi *vsi)
 	struct i40e_vsi_context ctxt;
 	i40e_status ret;
 
+	/* Don't modify stripping options if a port vlan is active */
+	if (vsi->info.pvid)
+		return;
+
 	if ((vsi->info.valid_sections &
 	     cpu_to_le16(I40E_AQ_VSI_PROP_VLAN_VALID)) &&
 	    ((vsi->info.port_vlan_flags & I40E_AQ_VSI_PVLAN_EMOD_MASK) ==
-- 
2.19.2

