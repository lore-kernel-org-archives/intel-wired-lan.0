From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 25 Aug 2016 14:06:54 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: use generic ethtool_op_get_ts_info
	callback
Message-ID: <20160825210654.30005-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This generic callback is for drivers which have software Tx timestamp
support enabled. Without this, PTP applications requesting software
timestamps may complain that the requested mode is not supported.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index adb7cb4311ba..5241e0873397 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -1182,6 +1182,7 @@ static const struct ethtool_ops fm10k_ethtool_ops = {
 	.set_rxfh		= fm10k_set_rssh,
 	.get_channels		= fm10k_get_channels,
 	.set_channels		= fm10k_set_channels,
+	.get_ts_info		= ethtool_op_get_ts_info,
 };
 
 void fm10k_set_ethtool_ops(struct net_device *dev)
-- 
2.10.0.rc0.259.g83512d9

