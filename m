From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Dec 2018 10:03:31 -0800
Subject: [Intel-wired-lan] [PATCH S10 12/15] ice: Allow for software
 timestamping
In-Reply-To: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181219180334.1104-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tony Nguyen <anthony.l.nguyen@intel.com>

Use ethtool_op_get_ts_info to provide software timestamping.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 02316e32dfb3..1f6a5f073e91 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2104,6 +2104,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.get_rxfh_indir_size	= ice_get_rxfh_indir_size,
 	.get_rxfh		= ice_get_rxfh,
 	.set_rxfh		= ice_set_rxfh,
+	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_per_queue_coalesce = ice_get_per_q_coalesce,
 	.set_per_queue_coalesce = ice_set_per_q_coalesce,
 };
-- 
2.14.5

