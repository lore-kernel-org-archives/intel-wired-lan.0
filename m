From: Yue Haibing <yuehaibing@huawei.com>
Date: Tue, 19 Mar 2019 22:55:07 +0800
Subject: [Intel-wired-lan] [PATCH net-next] igc: Make
 igc_write_rss_indir_tbl static
Message-ID: <20190319145507.22388-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

drivers/net/ethernet/intel/igc/igc_ethtool.c:646:6:
 warning: symbol 'igc_write_rss_indir_tbl' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index eff37a6..5442394 100644
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
-- 
2.7.4


