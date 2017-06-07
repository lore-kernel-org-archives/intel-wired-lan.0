From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Jun 2017 05:43:07 -0400
Subject: [Intel-wired-lan] [next PATCH S72-V3 07/13] i40e: Add message for
	unsupported MFP mode
In-Reply-To: <20170607094313.32060-1-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
Message-ID: <20170607094313.32060-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch adds a check and message if the device is in
MFP mode as changing RSS input set is not supported in
MFP mode.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9d3233c..9692a52 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2711,6 +2711,12 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 	u8 flow_pctype = 0;
 	u64 i_set, i_setc;
 
+	if (pf->flags & I40E_FLAG_MFP_ENABLED) {
+		dev_err(&pf->pdev->dev,
+			"Change of RSS hash input set is not supported when MFP mode is enabled\n");
+		return -EOPNOTSUPP;
+	}
+
 	/* RSS does not support anything other than hashing
 	 * to queues on src and dst IPs and ports
 	 */
-- 
2.9.3

