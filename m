From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Thu, 14 Apr 2016 06:19:28 -0700
Subject: [Intel-wired-lan] [next PATCH S35 08/14] i40e: Add message for
	unsupported MFP mode
In-Reply-To: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460639974-2556-9-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch adds a check and message if the device is in
MFP mode as changing RSS input set is not supported in
MFP mode per the DCR.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-Id: I4c066c6124fd77ce9d3587ac1164e07b49c49d89
---
Testing Hints : Check that trying to
change RSS Hash options with ethtool returns a not
supported message.  There should also be a similar
message in the log.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 3409702..35c211f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2318,6 +2318,12 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
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
2.4.3

