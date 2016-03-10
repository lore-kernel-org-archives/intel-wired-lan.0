From: ajdayana <avinash.dayanand@intel.com>
Date: Thu, 10 Mar 2016 14:59:40 -0800
Subject: [Intel-wired-lan] [next PATCH S30 v3 02/13] i40e/i40evf: Remove
	I40E_MAX_USER_PRIORITY define
In-Reply-To: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1457650791-100229-3-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

This patch removes the duplicate definition of I40E_MAX_USER_PRIORITY
in i40e.h that is not needed.

Testing Hints: Make sure everything compiles.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 774a72a..fff184a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -242,7 +242,6 @@ struct i40e_fdir_filter {
 #define I40E_DCB_PRIO_TYPE_STRICT	0
 #define I40E_DCB_PRIO_TYPE_ETS		1
 #define I40E_DCB_STRICT_PRIO_CREDITS	127
-#define I40E_MAX_USER_PRIORITY	8
 /* DCB per TC information data structure */
 struct i40e_tc_info {
 	u16	qoffset;	/* Queue offset from base queue */
-- 
2.4.3

