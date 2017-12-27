From: Alice Michael <alice.michael@intel.com>
Date: Wed, 27 Dec 2017 07:32:38 -0500
Subject: [Intel-wired-lan] [next PATCH S84-V2 09/13] i40e: Fix compilation
 issue with DPDK
In-Reply-To: <20171227123242.22356-1-alice.michael@intel.com>
References: <20171227123242.22356-1-alice.michael@intel.com>
Message-ID: <20171227123242.22356-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

When using GCC 6.3.0 and EXTRA_CFLAGS=-Og, the compiler is not smart
enough to see that when you have an integrated VF that just one of the
if statemets has to be true so that ntu is always set.  Fix the
way that the code is for integrated VFs so that the compiler won't
complain.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 2 +-
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index c4fa06d..e789716 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -976,7 +976,7 @@ i40e_status i40e_clean_arq_element(struct i40e_hw *hw,
 	}
 
 	/* set next_to_use to head */
-	ntu = (rd32(hw, hw->aq.arq.head) & I40E_PF_ARQH_ARQH_MASK);
+	ntu = rd32(hw, hw->aq.arq.head) & I40E_PF_ARQH_ARQH_MASK;
 	if (ntu == ntc) {
 		/* nothing to do - shouldn't need to update ring's values */
 		ret_code = I40E_ERR_ADMIN_QUEUE_NO_WORK;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
index ae3a740..d1aab6b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
@@ -906,7 +906,7 @@ i40e_status i40evf_clean_arq_element(struct i40e_hw *hw,
 	}
 
 	/* set next_to_use to head */
-	ntu = (rd32(hw, hw->aq.arq.head) & I40E_VF_ARQH1_ARQH_MASK);
+	ntu = rd32(hw, hw->aq.arq.head) & I40E_VF_ARQH1_ARQH_MASK;
 	if (ntu == ntc) {
 		/* nothing to do - shouldn't need to update ring's values */
 		ret_code = I40E_ERR_ADMIN_QUEUE_NO_WORK;
-- 
2.9.5

