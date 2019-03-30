From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 29 Mar 2019 17:04:56 -0700
Subject: [Intel-wired-lan] [next S4 v2 04/11] i40e: add functions stubs to
 support EEE
Message-ID: <20190330000456.23221-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This patch adds functions stubs to support EEE on/off.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2: fixed merge issue

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 2c81afbd7c58..ffeab550b1aa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5141,6 +5141,16 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
 	return 0;
 }
 
+static int i40e_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
+{
+	return -EOPNOTSUPP;
+}
+
+static int i40e_set_eee(struct net_device *netdev, struct ethtool_eee *edata)
+{
+	return -EOPNOTSUPP;
+}
+
 static const struct ethtool_ops i40e_ethtool_recovery_mode_ops = {
 	.set_eeprom		= i40e_set_eeprom,
 	.get_eeprom_len		= i40e_get_eeprom_len,
@@ -5168,6 +5178,8 @@ static const struct ethtool_ops i40e_ethtool_ops = {
 	.set_rxnfc		= i40e_set_rxnfc,
 	.self_test		= i40e_diag_test,
 	.get_strings		= i40e_get_strings,
+	.get_eee		= i40e_get_eee,
+	.set_eee		= i40e_set_eee,
 	.set_phys_id		= i40e_set_phys_id,
 	.get_sset_count		= i40e_get_sset_count,
 	.get_ethtool_stats	= i40e_get_ethtool_stats,
-- 
2.20.1

