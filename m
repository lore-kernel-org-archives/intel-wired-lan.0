From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 13 Mar 2018 19:45:52 -0700
Subject: [Intel-wired-lan] [next-queue PATCH] i40evf: Reorder
 configure_clsflower to avoid deadlock on error
Message-ID: <20180314024552.7086.86874.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

While doing some code review I noticed that we can get into a state where
we exit with the "IN_CRITICAL_TASK" bit set while notifying the PF of
flower filters. This patch is meant to address that plus tweak the ordering
of the while loop waiting on it slightly so that we don't wait an extra
period after we have failed for the last time.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 52a017c42ffd..57e74f845dc4 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2792,14 +2792,7 @@ static int i40evf_configure_clsflower(struct i40evf_adapter *adapter,
 {
 	int tc = tc_classid_to_hwtc(adapter->netdev, cls_flower->classid);
 	struct i40evf_cloud_filter *filter = NULL;
-	int err = 0, count = 50;
-
-	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
-				&adapter->crit_section)) {
-		udelay(1);
-		if (--count == 0)
-			return -EINVAL;
-	}
+	int err = -EINVAL, count = 50;
 
 	if (tc < 0) {
 		dev_err(&adapter->pdev->dev, "Invalid traffic class\n");
@@ -2807,10 +2800,16 @@ static int i40evf_configure_clsflower(struct i40evf_adapter *adapter,
 	}
 
 	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
-	if (!filter) {
-		err = -ENOMEM;
-		goto clearout;
+	if (!filter)
+		return -ENOMEM;
+
+	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
+				&adapter->crit_section)) {
+		if (--count == 0)
+			goto err;
+		udelay(1);
 	}
+
 	filter->cookie = cls_flower->cookie;
 
 	/* set the mask to all zeroes to begin with */
@@ -2835,7 +2834,7 @@ static int i40evf_configure_clsflower(struct i40evf_adapter *adapter,
 err:
 	if (err)
 		kfree(filter);
-clearout:
+
 	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 	return err;
 }

