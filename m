From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:22 -0700
Subject: [Intel-wired-lan] [PATCH net-next 02/15] iavf: obtain the
 crit_section lock in iavf_open() immediately
In-Reply-To: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604165335.33329-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nicholas Nunley <nicholas.d.nunley@intel.com>

iavf_open() checks for IAVF_FLAG_PF_COMMS_FAILED outside of the
crit_section lock so that it can return early if possible, without needing
to acquire the lock. This is perfectly fine, but once the lock is actually
obtained the code assumes the value hasn't changed. This is not correct,
since the IAVF_FLAG_PF_COMMS_FAILED field can certainly change by the time
the lock is obtained, especially if iavf_open() has to wait for it while
iavf_reset_task() runs on another thread.

To avoid this, simply grab the lock before checking the value.

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index bf96a9dab962..4c55773c6ee1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3196,15 +3196,16 @@ static int iavf_open(struct net_device *netdev)
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int err;
 
-	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) {
-		dev_err(&adapter->pdev->dev, "Unable to open device due to PF driver failure.\n");
-		return -EIO;
-	}
-
 	while (test_and_set_bit(__IAVF_IN_CRITICAL_TASK,
 				&adapter->crit_section))
 		usleep_range(500, 1000);
 
+	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) {
+		dev_err(&adapter->pdev->dev, "Unable to open device due to PF driver failure.\n");
+		err = -EIO;
+		goto err_unlock;
+	}
+
 	if (adapter->state != __IAVF_DOWN) {
 		err = -EBUSY;
 		goto err_unlock;
-- 
2.20.1

