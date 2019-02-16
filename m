From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Sat, 16 Feb 2019 02:04:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next] igc: Make function
 igc_write_rss_indir_tbl() static
Message-ID: <20190216020442.14206-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixes the following sparse warning:

drivers/net/ethernet/intel/igc/igc_ethtool.c:646:6: warning:
 symbol 'igc_write_rss_indir_tbl' was not declared. Should it be static?

Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index eff37a6c0afa..544239422577 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -643,7 +643,7 @@ static int igc_set_coalesce(struct net_device *netdev,
 	return 0;
 }
 
-void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
+static void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
 	u32 reg = IGC_RETA(0);



