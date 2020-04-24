From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 24 Apr 2020 13:16:15 -0700
Subject: [Intel-wired-lan] [PATCH 11/19] igc: Fix NFC rule overwrite cases
In-Reply-To: <20200424201623.10971-1-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
Message-ID: <20200424201623.10971-12-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the 'loc' argument is passed in ethtool, the input rule overwrites
any rule present in that location. In this situation we must disable the
old rule otherwise it is left enabled in hardware. This patch fixes
the issue by always calling igc_disable_nfc_rule() when deleting the
old rule, no matter the value of 'input' argument.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 38ac61c04e5c..e975efea4a15 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1270,8 +1270,7 @@ static int igc_ethtool_update_nfc_rule(struct igc_adapter *adapter,
 
 	/* if there is an old rule occupying our place remove it */
 	if (rule && rule->location == location) {
-		if (!input)
-			err = igc_disable_nfc_rule(adapter, rule);
+		err = igc_disable_nfc_rule(adapter, rule);
 
 		hlist_del(&rule->nfc_node);
 		kfree(rule);
-- 
2.26.0

