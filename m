From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:30:13 -0700
Subject: [Intel-wired-lan] [next-queue S2 03/15] i40e: Print some more info
	to help figure out the cause of HMC error
In-Reply-To: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427257825-24519-3-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

HMC_ERRORINFO and HMC_ERRORDATA helps explain the cause of HMC error.

Change-ID: I053bbc175a5f4c5c3e9ec2ea7400d5c56aaa4ec1
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 845bcee..77e3b84 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3197,6 +3197,9 @@ static irqreturn_t i40e_intr(int irq, void *data)
 	if (icr0 & I40E_PFINT_ICR0_HMC_ERR_MASK) {
 		icr0 &= ~I40E_PFINT_ICR0_HMC_ERR_MASK;
 		dev_info(&pf->pdev->dev, "HMC error interrupt\n");
+		dev_info(&pf->pdev->dev, "HMC error info 0x%x, HMC error data 0x%x\n",
+			 rd32(hw, I40E_PFHMC_ERRORINFO),
+			 rd32(hw, I40E_PFHMC_ERRORDATA));
 	}
 
 	if (icr0 & I40E_PFINT_ICR0_TIMESYNC_MASK) {
-- 
1.9.3

