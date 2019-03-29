From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Mar 2019 15:08:32 -0700
Subject: [Intel-wired-lan] [next PATCH S4 03/11] i40e: Setting VF to VLAN 0
 requires restart
In-Reply-To: <20190329220840.51187-1-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
Message-ID: <20190329220840.51187-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Grzegorz Siwik <grzegorz.siwik@intel.com>

This patch fixes a bug where changing VLAN to 0 was not set until VF
restart.

Now we are setting pvid info to 0 when we have to change VLAN to 0.
Without this change when VF VLAN was changed to 0 nothing happened until
VF restart. For changing to VLAN different than 0 it worked correctly.

Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9fe040f4049d..af0670ea940e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2970,9 +2970,9 @@ int i40e_vsi_add_pvid(struct i40e_vsi *vsi, u16 vid)
  **/
 void i40e_vsi_remove_pvid(struct i40e_vsi *vsi)
 {
-	i40e_vlan_stripping_disable(vsi);
-
 	vsi->info.pvid = 0;
+
+	i40e_vlan_stripping_disable(vsi);
 }
 
 /**
-- 
2.19.2

