From: Alice Michael <alice.michael@intel.com>
Date: Tue, 23 Jul 2019 06:03:43 -0400
Subject: [Intel-wired-lan] [next PATCH S8 10/12] i40e: allow reset in
 recovery mode
In-Reply-To: <20190723100345.57522-1-alice.michael@intel.com>
References: <20190723100345.57522-1-alice.michael@intel.com>
Message-ID: <20190723100345.57522-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Driver waits after issuing a reset. When a reset takes too long a driver
gives up. Implemented by invoking PF reset in a loop. After defined
number of unsuccessful PF reset trials it returns error.
Without this patch PF reset fails when NIC is in recovery mode.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 67 ++++++++++++++++++---
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8d6b9515b595..fdf43d87e983 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14564,6 +14564,51 @@ static bool i40e_check_recovery_mode(struct i40e_pf *pf)
 	return false;
 }
 
+/**
+ * i40e_pf_loop_reset - perform reset in a loop.
+ * @pf: board private structure
+ *
+ * This function is useful when a NIC is about to enter recovery mode.
+ * When a NIC's internal data structures are corrupted the NIC's
+ * firmware is going to enter recovery mode.
+ * Right after a POR it takes about 7 minutes for firmware to enter
+ * recovery mode. Until that time a NIC is in some kind of intermediate
+ * state. After that time period the NIC almost surely enters
+ * recovery mode. The only way for a driver to detect intermediate
+ * state is to issue a series of pf-resets and check a return value.
+ * If a PF reset returns success then the firmware could be in recovery
+ * mode so the caller of this code needs to check for recovery mode
+ * if this function returns success. There is a little chance that
+ * firmware will hang in intermediate state forever.
+ * Since waiting 7 minutes is quite a lot of time this function waits
+ * 10 seconds and then gives up by returning an error.
+ *
+ * Return 0 on success, negative on failure.
+ **/
+static i40e_status i40e_pf_loop_reset(struct i40e_pf *pf)
+{
+	const unsigned short MAX_CNT = 1000;
+	const unsigned short MSECS = 10;
+	struct i40e_hw *hw = &pf->hw;
+	i40e_status ret;
+	int cnt;
+
+	for (cnt = 0; cnt < MAX_CNT; ++cnt) {
+		ret = i40e_pf_reset(hw);
+		if (!ret)
+			break;
+		msleep(MSECS);
+	}
+
+	if (cnt == MAX_CNT) {
+		dev_info(&pf->pdev->dev, "PF reset failed: %d\n", ret);
+		return ret;
+	}
+
+	pf->pfr_count++;
+	return ret;
+}
+
 /**
  * i40e_init_recovery_mode - initialize subsystems needed in recovery mode
  * @pf: board private structure
@@ -14792,14 +14837,22 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Reset here to make sure all is clean and to define PF 'n' */
 	i40e_clear_hw(hw);
-	if (!i40e_check_recovery_mode(pf)) {
-		err = i40e_pf_reset(hw);
-		if (err) {
-			dev_info(&pdev->dev, "Initial pf_reset failed: %d\n", err);
-			goto err_pf_reset;
-		}
-		pf->pfr_count++;
+
+	err = i40e_set_mac_type(hw);
+	if (err) {
+		dev_warn(&pdev->dev, "unidentified MAC or BLANK NVM: %d\n",
+			 err);
+		goto err_pf_reset;
 	}
+
+	err = i40e_pf_loop_reset(pf);
+	if (err) {
+		dev_info(&pdev->dev, "Initial pf_reset failed: %d\n", err);
+		goto err_pf_reset;
+	}
+
+	i40e_check_recovery_mode(pf);
+
 	hw->aq.num_arq_entries = I40E_AQ_LEN;
 	hw->aq.num_asq_entries = I40E_AQ_LEN;
 	hw->aq.arq_buf_size = I40E_MAX_AQ_BUF_SIZE;
-- 
2.21.0

