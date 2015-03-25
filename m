From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:04:48 -0700
Subject: [Intel-wired-lan] [next-queue S1 4/6] i40e: Increase pf reset max
	loop limit
In-Reply-To: <1427256290-24231-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427256290-24231-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427256290-24231-4-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

In some circumstances the firmware can take longer to be ready after a reset than
we're currently waiting. This patch increases the polling loop limiter to much
longer than expected.

Change-ID: I4b2c4c100dfa4abb77d02e5ecdec1cdd253b8c7e
Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index b7cacde..d596f66 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -859,7 +859,7 @@ static enum i40e_media_type i40e_get_media_type(struct i40e_hw *hw)
 }
 
 #define I40E_PF_RESET_WAIT_COUNT_A0	200
-#define I40E_PF_RESET_WAIT_COUNT	110
+#define I40E_PF_RESET_WAIT_COUNT	200
 /**
  * i40e_pf_reset - Reset the PF
  * @hw: pointer to the hardware structure
-- 
1.9.3

