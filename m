From: ajdayana <avinash.dayanand@intel.com>
Date: Thu, 10 Mar 2016 14:59:49 -0800
Subject: [Intel-wired-lan] [next PATCH S30 v3 11/13] i40evf: Add additional
	check for reset
In-Reply-To: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1457650791-100229-12-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If the driver happens to read a register during the time in which the
device is undergoing reset, it will receive a value of 0xdeadbeef
instead of a valid value. Unfortunately, the driver may misinterpret
this as a valid value, especially if it's just looking for individual
bits.

Add an explicit check for this value when we are looking for admin queue
errors, and trigger reset recovery if we find it.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 820ad94..d783c1b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1994,6 +1994,8 @@ static void i40evf_adminq_task(struct work_struct *work)
 
 	/* check for error indications */
 	val = rd32(hw, hw->aq.arq.len);
+	if (val == 0xdeadbeef) /* indicates device in reset */
+		goto freedom;
 	oldval = val;
 	if (val & I40E_VF_ARQLEN1_ARQVFE_MASK) {
 		dev_info(&adapter->pdev->dev, "ARQ VF Error detected\n");
-- 
2.4.3

