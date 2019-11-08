From: Arkady Gilinsky <arkady.gilinsky@harmonicinc.com>
Date: Fri, 8 Nov 2019 11:57:36 +0000
Subject: [Intel-wired-lan] [v2 PATCH net] i40e/iavf: Fix msg interface
 between VF and PF
Message-ID: <1573214249.10368.25.camel@harmonicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From af0e91423ea6ea37b48ee8b555314fd01964335d Mon Sep 17 00:00:00 2001
From: Arkady Gilinsky <arkady.gilinsky@harmonicinc.com>
Date: Fri, 8 Nov 2019 13:48:03 +0200
Subject: [[v2] PATCH net] i40e/iavf: Fix msg interface between VF and PF

?* The original issue was that iavf driver passing TX/RX queues
???as bitmap in iavf_disable_queues and the i40e driver
???interprets this message as an absolute number in
???i40e_vc_disable_queues_msg, so the validation in the
???latter function always fail.
???The commit fixes the issue and adds validation of the
???queue bitmap to the i40e_vc_enable_queues_msg function.

Signed-off-by: Arkady Gilinsky <arkady.gilinsky@harmonicinc.com>
---
?drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 8 +++++---
?1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3d2440838822..573252e9fb78 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2347,7 +2347,9 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg)
?		goto error_param;
?	}
?
-	if ((0 == vqs->rx_queues) && (0 == vqs->tx_queues)) {
+	if ((vqs->rx_queues == 0 && vqs->tx_queues == 0) ||
+	????vqs->rx_queues >= BIT(I40E_MAX_VF_QUEUES) ||
+	????vqs->tx_queues >= BIT(I40E_MAX_VF_QUEUES)) {
?		aq_ret = I40E_ERR_PARAM;
?		goto error_param;
?	}
@@ -2410,8 +2412,8 @@ static int i40e_vc_disable_queues_msg(struct i40e_vf *vf, u8 *msg)
?	}
?
?	if ((vqs->rx_queues == 0 && vqs->tx_queues == 0) ||
-	????vqs->rx_queues > I40E_MAX_VF_QUEUES ||
-	????vqs->tx_queues > I40E_MAX_VF_QUEUES) {
+	????vqs->rx_queues >= BIT(I40E_MAX_VF_QUEUES) ||
+	????vqs->tx_queues >= BIT(I40E_MAX_VF_QUEUES)) {
?		aq_ret = I40E_ERR_PARAM;
?		goto error_param;
?	}
--?
2.11.0

