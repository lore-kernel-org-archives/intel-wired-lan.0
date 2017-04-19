From: Alice Michael <alice.michael@intel.com>
Date: Wed, 19 Apr 2017 09:25:59 -0400
Subject: [Intel-wired-lan] [next PATCH S71 10/10] i40evf: allocate queues
	before we setup the interrupts and q_vectors
In-Reply-To: <20170419132559.20459-1-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
Message-ID: <20170419132559.20459-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This matches the ordering of how we free stuff during reset and remove.
It also makes logical sense because we set the interrupts based on the
number of queues. Currently this doesn't really matter in practice.
However a future patch moves the assignment of num_active_queues into
i40evf_alloc_queues, which is required by
i40evf_set_interrupt_capability.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 89035ee..445a97a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1508,6 +1508,13 @@ int i40evf_init_interrupt_scheme(struct i40evf_adapter *adapter)
 {
 	int err;
 
+	err = i40evf_alloc_queues(adapter);
+	if (err) {
+		dev_err(&adapter->pdev->dev,
+			"Unable to allocate memory for queues\n");
+		goto err_alloc_queues;
+	}
+
 	rtnl_lock();
 	err = i40evf_set_interrupt_capability(adapter);
 	rtnl_unlock();
@@ -1524,23 +1531,16 @@ int i40evf_init_interrupt_scheme(struct i40evf_adapter *adapter)
 		goto err_alloc_q_vectors;
 	}
 
-	err = i40evf_alloc_queues(adapter);
-	if (err) {
-		dev_err(&adapter->pdev->dev,
-			"Unable to allocate memory for queues\n");
-		goto err_alloc_queues;
-	}
-
 	dev_info(&adapter->pdev->dev, "Multiqueue %s: Queue pair count = %u",
 		 (adapter->num_active_queues > 1) ? "Enabled" : "Disabled",
 		 adapter->num_active_queues);
 
 	return 0;
-err_alloc_queues:
-	i40evf_free_q_vectors(adapter);
 err_alloc_q_vectors:
 	i40evf_reset_interrupt_capability(adapter);
 err_set_interrupt:
+	i40evf_free_queues(adapter);
+err_alloc_queues:
 	return err;
 }
 
-- 
2.9.3

