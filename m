From: Mitch Williams <mitch.a.williams@intel.com>
Date: Fri,  2 Oct 2015 10:19:46 -0700
Subject: [Intel-wired-lan] [net PATCH] i40e/i40evf: set aq count after
	memory allocation
Message-ID: <1443806386-150326-1-git-send-email-mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The standard way to check if the AQ is enabled is to look at the
count field. So we should only set this field after we have
successfully allocated memory. To do otherwise is to incite
panic among the populace.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 4 ++--
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 62488a6..c0e943a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -386,7 +386,6 @@ static i40e_status i40e_init_asq(struct i40e_hw *hw)
 
 	hw->aq.asq.next_to_use = 0;
 	hw->aq.asq.next_to_clean = 0;
-	hw->aq.asq.count = hw->aq.num_asq_entries;
 
 	/* allocate the ring memory */
 	ret_code = i40e_alloc_adminq_asq_ring(hw);
@@ -404,6 +403,7 @@ static i40e_status i40e_init_asq(struct i40e_hw *hw)
 		goto init_adminq_free_rings;
 
 	/* success! */
+	hw->aq.asq.count = hw->aq.num_asq_entries;
 	goto init_adminq_exit;
 
 init_adminq_free_rings:
@@ -445,7 +445,6 @@ static i40e_status i40e_init_arq(struct i40e_hw *hw)
 
 	hw->aq.arq.next_to_use = 0;
 	hw->aq.arq.next_to_clean = 0;
-	hw->aq.arq.count = hw->aq.num_arq_entries;
 
 	/* allocate the ring memory */
 	ret_code = i40e_alloc_adminq_arq_ring(hw);
@@ -463,6 +462,7 @@ static i40e_status i40e_init_arq(struct i40e_hw *hw)
 		goto init_adminq_free_rings;
 
 	/* success! */
+	hw->aq.arq.count = hw->aq.num_arq_entries;
 	goto init_adminq_exit;
 
 init_adminq_free_rings:
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
index 7f52ee1..8ce43b9 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
@@ -384,7 +384,6 @@ static i40e_status i40e_init_asq(struct i40e_hw *hw)
 
 	hw->aq.asq.next_to_use = 0;
 	hw->aq.asq.next_to_clean = 0;
-	hw->aq.asq.count = hw->aq.num_asq_entries;
 
 	/* allocate the ring memory */
 	ret_code = i40e_alloc_adminq_asq_ring(hw);
@@ -402,6 +401,7 @@ static i40e_status i40e_init_asq(struct i40e_hw *hw)
 		goto init_adminq_free_rings;
 
 	/* success! */
+	hw->aq.asq.count = hw->aq.num_asq_entries;
 	goto init_adminq_exit;
 
 init_adminq_free_rings:
@@ -443,7 +443,6 @@ static i40e_status i40e_init_arq(struct i40e_hw *hw)
 
 	hw->aq.arq.next_to_use = 0;
 	hw->aq.arq.next_to_clean = 0;
-	hw->aq.arq.count = hw->aq.num_arq_entries;
 
 	/* allocate the ring memory */
 	ret_code = i40e_alloc_adminq_arq_ring(hw);
@@ -461,6 +460,7 @@ static i40e_status i40e_init_arq(struct i40e_hw *hw)
 		goto init_adminq_free_rings;
 
 	/* success! */
+	hw->aq.arq.count = hw->aq.num_arq_entries;
 	goto init_adminq_exit;
 
 init_adminq_free_rings:
-- 
2.4.3

