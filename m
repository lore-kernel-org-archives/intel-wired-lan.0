From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 30 Jul 2020 19:04:51 +0300
Subject: [Intel-wired-lan] [PATCH v1] ice: devlink: use %*phD to print small
 buffer
Message-ID: <20200730160451.40810-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use %*phD format to print small buffer as hex string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index dbbd8b6f9d1a..a9105ad5b983 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -13,9 +13,7 @@ static int ice_info_get_dsn(struct ice_pf *pf, char *buf, size_t len)
 	/* Copy the DSN into an array in Big Endian format */
 	put_unaligned_be64(pci_get_dsn(pf->pdev), dsn);
 
-	snprintf(buf, len, "%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x",
-		 dsn[0], dsn[1], dsn[2], dsn[3],
-		 dsn[4], dsn[5], dsn[6], dsn[7]);
+	snprintf(buf, len, "%8phD", dsn);
 
 	return 0;
 }
-- 
2.27.0

