From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Tue, 13 Oct 2015 01:06:30 -0600
Subject: [Intel-wired-lan] [next-queue v2 4/6] i40evf: clean up local
	variable initialization
In-Reply-To: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
References: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1444719992-301-4-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

In i40evf_msix_aq(), the first two lines of rd32() are mainly to clear
the registers. If we initialize 'val' at this point, it will be
overwritten immediately. We shall simply discard the return value here.

When we initialize 'val', we might as well include the mask in one step.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
v2: No changes except for the serial number.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 3b638f68b249..7d6d30c53060 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -308,11 +308,11 @@ static irqreturn_t i40evf_msix_aq(int irq, void *data)
 	u32 val;
 
 	/* handle non-queue interrupts, these reads clear the registers */
-	val = rd32(hw, I40E_VFINT_ICR01);
-	val = rd32(hw, I40E_VFINT_ICR0_ENA1);
+	rd32(hw, I40E_VFINT_ICR01);
+	rd32(hw, I40E_VFINT_ICR0_ENA1);
 
-	val = rd32(hw, I40E_VFINT_DYN_CTL01);
-	val = val | I40E_VFINT_DYN_CTL01_CLEARPBA_MASK;
+	val = rd32(hw, I40E_VFINT_DYN_CTL01) |
+	      I40E_VFINT_DYN_CTL01_CLEARPBA_MASK;
 	wr32(hw, I40E_VFINT_DYN_CTL01, val);
 
 	/* schedule work on the private workqueue */
