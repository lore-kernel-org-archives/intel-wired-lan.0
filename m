From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 10 Jun 2021 17:39:22 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v1 3/5] igc: Allow for Flex
 Filters to be installed
In-Reply-To: <20210611003924.492853-1-vinicius.gomes@intel.com>
References: <20210611003924.492853-1-vinicius.gomes@intel.com>
Message-ID: <20210611003924.492853-4-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Allows Flex Filters to be installed.

The previous restriction to the types of filters that can be installed
can now be lifted.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 3d46eff87638..5a7b27b2a95c 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1300,12 +1300,6 @@ static int igc_ethtool_add_nfc_rule(struct igc_adapter *adapter,
 		return -EOPNOTSUPP;
 	}
 
-	if ((fsp->flow_type & FLOW_EXT) &&
-	    fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK)) {
-		netdev_dbg(netdev, "VLAN mask not supported\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (fsp->ring_cookie >= adapter->num_rx_queues) {
 		netdev_dbg(netdev, "Invalid action\n");
 		return -EINVAL;
-- 
2.32.0

