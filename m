From: xiakaixu1987@gmail.com <xiakaixu1987@gmail.com>
Date: Sat, 14 Nov 2020 22:55:39 +0800
Subject: [Intel-wired-lan] [PATCH] i40e: remove the useless value assignment
 in i40e_clean_adminq_subtask
Message-ID: <1605365739-11642-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kaixu Xia <kaixuxia@tencent.com>

The variable ret is overwritten by the following call
i40e_clean_arq_element() and the assignment is useless, so remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4f8a2154b93f..7d59fc2eded6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9356,7 +9356,7 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
 			dev_dbg(&pf->pdev->dev, "ARQ: Update LLDP MIB event received\n");
 #ifdef CONFIG_I40E_DCB
 			rtnl_lock();
-			ret = i40e_handle_lldp_event(pf, &event);
+			i40e_handle_lldp_event(pf, &event);
 			rtnl_unlock();
 #endif /* CONFIG_I40E_DCB */
 			break;
-- 
2.20.0

