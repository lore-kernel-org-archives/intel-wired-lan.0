From: Karen Sornek <karen.sornek@intel.com>
Date: Thu, 10 Sep 2020 12:36:19 +0200
Subject: [Intel-wired-lan] [PATCH] igbvf: Refactor traces
Message-ID: <20200910103619.10467-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Refactoring "PF still resetting" and changing "Failed
 to add vlan id" to "Vlan id is not added"
messages because previous version looked like a bug
- it informed about changes that worked as
designed but might confuse users

Signed-off-by: Karen Sornek <karen.sornek@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 19269f5..9c6fd8d 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1230,7 +1230,7 @@ static int igbvf_vlan_rx_add_vid(struct net_device *netdev,
 	spin_lock_bh(&hw->mbx_lock);
 
 	if (hw->mac.ops.set_vfta(hw, vid, true)) {
-		dev_err(&adapter->pdev->dev, "Failed to add vlan id %d\n", vid);
+		dev_warn(&adapter->pdev->dev, "Vlan id %d\n is not added", vid);
 		spin_unlock_bh(&hw->mbx_lock);
 		return -EINVAL;
 	}
@@ -1514,7 +1514,7 @@ static void igbvf_reset(struct igbvf_adapter *adapter)
 
 	/* Allow time for pending master requests to run */
 	if (mac->ops.reset_hw(hw))
-		dev_err(&adapter->pdev->dev, "PF still resetting\n");
+		dev_warn(&adapter->pdev->dev, "PF still resetting\n");
 
 	mac->ops.init_hw(hw);
 
-- 
2.18.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

