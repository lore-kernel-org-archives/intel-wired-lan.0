From: Colin King <colin.king@canonical.com>
Date: Fri,  2 Jul 2021 12:27:20 +0100
Subject: [Intel-wired-lan] [PATCH] iavf: remove redundant null check on key
Message-ID: <20210702112720.16006-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

The null check on pointer key has already been performed at the
start of the function and this leads to a return of -EOPNOTSUPP.
The second null check on key is therefore always false, it is
redundant and can be removed.

Addresses-Coverity: ("Logically dead code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index af43fbd8cb75..70193d8d54ed 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1873,8 +1873,7 @@ static int iavf_set_rxfh(struct net_device *netdev, const u32 *indir,
 	if (!indir)
 		return 0;
 
-	if (key)
-		memcpy(adapter->rss_key, key, adapter->rss_key_size);
+	memcpy(adapter->rss_key, key, adapter->rss_key_size);
 
 	/* Each 32 bits pointed by 'indir' is stored with a lut entry */
 	for (i = 0; i < adapter->rss_lut_size; i++)
-- 
2.31.1

