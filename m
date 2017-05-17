From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 17 May 2017 15:18:01 -0700
Subject: [Intel-wired-lan] [PATCH 5/5] ixgbe: fix incorrect status check
In-Reply-To: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
References: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
Message-ID: <20170517221801.15538.81934.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Check for ret_val instead of !ret_val to allow the rest of
the code to execute and configure the speed properly.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index cb5d363..47c8f24 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1798,7 +1798,7 @@ static s32 ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 	if (ret_val == IXGBE_ERR_SFP_NOT_PRESENT)
 		return 0;
 
-	if (!ret_val)
+	if (ret_val)
 		return ret_val;
 
 	/* Configure internal PHY for KR/KX. */

