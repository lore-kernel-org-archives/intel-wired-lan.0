From: Colin King <colin.king@canonical.com>
Date: Wed, 16 Jan 2019 18:53:16 +0000
Subject: [Intel-wired-lan] [PATCH] igb: fix various indentation issues
Message-ID: <20190116185316.24814-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

There are some lines that have indentation issues, fix these

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 7426060b678f..179fe6d2c660 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3158,8 +3158,8 @@ static int igb_set_eee(struct net_device *netdev,
 	} else if (!edata->eee_enabled) {
 		dev_err(&adapter->pdev->dev,
 			"Setting EEE options are not supported with EEE disabled\n");
-			return -EINVAL;
-		}
+		return -EINVAL;
+	}
 
 	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised);
 	if (hw->dev_spec._82575.eee_disable != !edata->eee_enabled) {
-- 
2.19.1

