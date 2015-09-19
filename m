From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Sat, 19 Sep 2015 05:08:44 -0600
Subject: [Intel-wired-lan] [next-queue v2 5/8] ixgbe: fix multiple
	kernel-doc errors
In-Reply-To: <1442660927-30431-1-git-send-email-sakiwit@gmail.com>
References: <1442660927-30431-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1442660927-30431-5-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

The commit dfaf891dd3e1 ("ixgbe: Refactor the RSS configuration code")
introduced a few kernel-doc errors:

1) The function name is missing;
2) The format is wrong;
3) The short description is redundant.

Fix all the above for the correct execution of the kernel doc.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
v2: No changes.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 708957c75936..e60e969c1c78 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3308,8 +3308,7 @@ static void ixgbe_configure_srrctl(struct ixgbe_adapter *adapter,
 }
 
 /**
- * Return a number of entries in the RSS indirection table
- *
+ * ixgbe_rss_indir_tbl_entries - Return RSS indirection table entries
  * @adapter: device handle
  *
  *  - 82598/82599/X540:     128
@@ -3327,8 +3326,7 @@ u32 ixgbe_rss_indir_tbl_entries(struct ixgbe_adapter *adapter)
 }
 
 /**
- * Write the RETA table to HW
- *
+ * ixgbe_store_reta - Write the RETA table to HW
  * @adapter: device handle
  *
  * Write the RSS redirection table stored in adapter.rss_indir_tbl[] to HW.
@@ -3367,8 +3365,7 @@ void ixgbe_store_reta(struct ixgbe_adapter *adapter)
 }
 
 /**
- * Write the RETA table to HW (for x550 devices in SRIOV mode)
- *
+ * ixgbe_store_vfreta - Write the RETA table to HW (x550 devices in SRIOV mode)
  * @adapter: device handle
  *
  * Write the RSS redirection table stored in adapter.rss_indir_tbl[] to HW.
