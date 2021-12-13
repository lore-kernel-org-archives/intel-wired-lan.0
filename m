From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Mon, 13 Dec 2021 13:13:01 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1 1/2] i40e: Disable
 hw-tc-offload feature on driver load.
Message-ID: <20211213121301.4393-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

After loading driver hw-tc-offload is enabled by default. Change the
behaviour of driver to disable hw-tc-offload by default.

Signed-off-by: Norbert Zulinski <norbertx.zulinski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5322f44..a7db6db 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13476,6 +13476,8 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	netdev->features |= hw_features | NETIF_F_HW_VLAN_CTAG_FILTER;
 	netdev->hw_enc_features |= NETIF_F_TSO_MANGLEID;
 
+	netdev->features &= ~NETIF_F_HW_TC;
+
 	if (vsi->type == I40E_VSI_MAIN) {
 		SET_NETDEV_DEV(netdev, &pf->pdev->dev);
 		ether_addr_copy(mac_addr, hw->mac.perm_addr);
-- 
2.27.0

