From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Mon, 13 Dec 2021 13:13:10 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1 2/2] i40e: Fix ntuple setting
 change
Message-ID: <20211213121310.4508-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Previous commit disabled hw-tc-offload netdev feature flag on driver
probe. Fix checking of NETIF_F_HW_TC flag during netdev feature change.
Without this patch, it would not be possible to change ntuple
feature state.

Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a7db6db..53ca517 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12724,7 +12724,8 @@ static int i40e_set_features(struct net_device *netdev,
 	else
 		i40e_vlan_stripping_disable(vsi);
 
-	if (!(features & NETIF_F_HW_TC) && pf->num_cloud_filters) {
+	if (!(features & NETIF_F_HW_TC) &&
+	    (netdev->features & NETIF_F_HW_TC) && pf->num_cloud_filters) {
 		dev_err(&pf->pdev->dev,
 			"Offloaded tc filters active, can't turn hw_tc_offload off");
 		return -EINVAL;
-- 
2.27.0

