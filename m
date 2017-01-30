From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 30 Jan 2017 12:29:32 -0800
Subject: [Intel-wired-lan] [next PATCH S59 1/6] i40e: fix ethtool to get
	EEPROM data from X722 interface
In-Reply-To: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
References: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1485808177-6333-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lihong Yang <lihong.yang@intel.com>

Currently ethtool -e will error out with a X722 interface
as its EEPROM has a scope limit at offset 0x5B9FFF.
This patch fixes the issue by setting the EEPROM length to
the scope limit to avoid NVM read failure beyond that.

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
Change-ID: I0b7d4dd6c7f2a57cace438af5dffa0f44c229372
---
Testing Hints: ethtool -e X722-interface.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index ccb3b77..b852ba3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1165,6 +1165,11 @@ static int i40e_get_eeprom_len(struct net_device *netdev)
 	struct i40e_hw *hw = &np->vsi->back->hw;
 	u32 val;
 
+#define X722_EEPROM_SCOPE_LIMIT 0x5B9FFF
+	if (hw->mac.type == I40E_MAC_X722) {
+		val = X722_EEPROM_SCOPE_LIMIT + 1;
+		return val;
+	}
 	val = (rd32(hw, I40E_GLPCI_LBARCTRL)
 		& I40E_GLPCI_LBARCTRL_FL_SIZE_MASK)
 		>> I40E_GLPCI_LBARCTRL_FL_SIZE_SHIFT;
-- 
2.4.11

