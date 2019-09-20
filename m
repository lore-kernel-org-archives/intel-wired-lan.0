From: Alice Michael <alice.michael@intel.com>
Date: Fri, 20 Sep 2019 02:17:22 -0700
Subject: [Intel-wired-lan] [next PATCH S10 08/10] i40e: allow ethtool to
 report SW and FW versions in recovery mode
In-Reply-To: <20190920091724.51767-1-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
Message-ID: <20190920091724.51767-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Let ethtool print driver and firmware versions when NIC is in
recovery mode.  Assign i40e_get_drvinfo() operation to ethtool
recovery mode operations.  Previously ethtool did not report
driver and firmware versions when NIC was in recovery mode.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 883b43ac9816..001a2fad297d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5375,6 +5375,7 @@ static int i40e_set_eee(struct net_device *netdev, struct ethtool_eee *edata)
 }
 
 static const struct ethtool_ops i40e_ethtool_recovery_mode_ops = {
+	.get_drvinfo		= i40e_get_drvinfo,
 	.set_eeprom		= i40e_set_eeprom,
 	.get_eeprom_len		= i40e_get_eeprom_len,
 	.get_eeprom		= i40e_get_eeprom,
-- 
2.21.0

