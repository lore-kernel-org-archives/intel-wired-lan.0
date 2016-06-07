From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue,  7 Jun 2016 16:08:50 -0700
Subject: [Intel-wired-lan] [PATCH v2 06/18] fm10k: only warn when stop_hw
	fails with FM10K_ERR_REQUESTS_PENDING
In-Reply-To: <20160607230902.5457-1-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
Message-ID: <20160607230902.5457-7-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When stop_hw() routine fails with FM10K_ERR_REQUESTS_PENDING, this
indicates that the Tx or Rx queues did not shutdown within the time
limit. Print a more suitable message at the dev_info level instead of
dev_err.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 44393763fe77..4dfd1284a8de 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1644,7 +1644,10 @@ void fm10k_down(struct fm10k_intfc *interface)
 
 	/* Disable DMA engine for Tx/Rx */
 	err = hw->mac.ops.stop_hw(hw);
-	if (err)
+	if (err == FM10K_ERR_REQUESTS_PENDING)
+		dev_info(&interface->pdev->dev,
+			 "due to pending requests hw was not shut down gracefully\n");
+	else if (err)
 		dev_err(&interface->pdev->dev, "stop_hw failed: %d\n", err);
 
 	/* free any buffers still on the rings */
-- 
2.9.0.rc1.405.g81f467e

