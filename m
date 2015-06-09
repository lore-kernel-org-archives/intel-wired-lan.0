From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Wed, 10 Jun 2015 01:16:03 +0300
Subject: [Intel-wired-lan] [PATCH 5/5] e1000e: i219 - k1 workaround for lpt
	is not required for spt.
In-Reply-To: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
References: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
Message-ID: <429931829ff2314c8ee78454ea5310168bc03888.1433877893.git.yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

in spt hardware does not require this driver workaround.
removed the conditional that caused k1 workaround execution on spt.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 4ce57e8..3ff9b9e 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1490,8 +1490,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 	if ((hw->adapter->pdev->device == E1000_DEV_ID_PCH_LPTLP_I218_LM) ||
 	    (hw->adapter->pdev->device == E1000_DEV_ID_PCH_LPTLP_I218_V) ||
 	    (hw->adapter->pdev->device == E1000_DEV_ID_PCH_I218_LM3) ||
-	    (hw->adapter->pdev->device == E1000_DEV_ID_PCH_I218_V3) ||
-	    (hw->mac.type == e1000_pch_spt)) {
+	    (hw->adapter->pdev->device == E1000_DEV_ID_PCH_I218_V3)) {
 		ret_val = e1000_k1_workaround_lpt_lp(hw, link);
 		if (ret_val)
 			return ret_val;
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

