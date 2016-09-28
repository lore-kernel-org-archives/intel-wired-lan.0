From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 28 Sep 2016 16:01:48 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: do not disable FEC from the driver
Message-ID: <20160928230148.7162.97867.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

FEC is configured by the NVM and the driver should not be
overriding it.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 3796482..6a2a09a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1982,8 +1982,6 @@ static s32 ixgbe_setup_kr_speed_x550em(struct ixgbe_hw *hw,
 		return status;
 
 	reg_val |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_ENABLE;
-	reg_val &= ~(IXGBE_KRM_LINK_CTRL_1_TETH_AN_FEC_REQ |
-		     IXGBE_KRM_LINK_CTRL_1_TETH_AN_CAP_FEC);
 	reg_val &= ~(IXGBE_KRM_LINK_CTRL_1_TETH_AN_CAP_KR |
 		     IXGBE_KRM_LINK_CTRL_1_TETH_AN_CAP_KX);
 

