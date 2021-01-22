From: Brett Creeley <brett.creeley@intel.com>
Date: Thu, 21 Jan 2021 17:58:46 -0800
Subject: [Intel-wired-lan] [PATCH net 1/2] ice: Don't allow more channels
 than LAN MSI-X available
Message-ID: <20210122015847.21825-1-brett.creeley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently users could create more channels than LAN MSI-X available.
This is happening because there is no check against pf->num_lan_msix
when checking the max allowed channels and will cause performance issues
if multiple Tx and Rx queues are tied to a single MSI-X. Fix this by not
allowing more channels than LAN MSI-X available in pf->num_lan_msix.

Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 41427302332c..aebebd2102da 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3265,8 +3265,8 @@ ice_set_rxfh(struct net_device *netdev, const u32 *indir, const u8 *key,
  */
 static int ice_get_max_txq(struct ice_pf *pf)
 {
-	return min_t(int, num_online_cpus(),
-		     pf->hw.func_caps.common_cap.num_txq);
+	return min3(pf->num_lan_msix, (u16)num_online_cpus(),
+		    (u16)pf->hw.func_caps.common_cap.num_txq);
 }
 
 /**
@@ -3275,8 +3275,8 @@ static int ice_get_max_txq(struct ice_pf *pf)
  */
 static int ice_get_max_rxq(struct ice_pf *pf)
 {
-	return min_t(int, num_online_cpus(),
-		     pf->hw.func_caps.common_cap.num_rxq);
+	return min3(pf->num_lan_msix, (u16)num_online_cpus(),
+		    (u16)pf->hw.func_caps.common_cap.num_rxq);
 }
 
 /**
-- 
2.26.2

