From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri,  5 Jun 2015 12:20:32 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 08/10] i40e:
	Add IWARP support for X722
In-Reply-To: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
References: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1433521234-33355-9-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

X722 supports IWARP, this patch handles checking for PE critical errors.
Since the driver doesn't support the IWARP interface for now, this patch
just does bare minimum to log a message oif a PE critical error
happens.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 17a5345..382642f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2908,6 +2908,9 @@ static void i40e_enable_misc_int_causes(struct i40e_pf *pf)
 	      I40E_PFINT_ICR0_ENA_VFLR_MASK          |
 	      I40E_PFINT_ICR0_ENA_ADMINQ_MASK;
 
+	if (pf->flags & I40E_FLAG_IWARP_ENABLED)
+		val |= I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK;
+
 	if (pf->flags & I40E_FLAG_PTP)
 		val |= I40E_PFINT_ICR0_ENA_TIMESYNC_MASK;
 
@@ -3198,6 +3201,13 @@ static irqreturn_t i40e_intr(int irq, void *data)
 	    (icr0 & I40E_PFINT_ICR0_SWINT_MASK))
 		pf->sw_int_count++;
 
+	if ((pf->flags & I40E_FLAG_IWARP_ENABLED) &&
+	    (ena_mask & I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK)) {
+		ena_mask &= ~I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK;
+		icr0 &= ~I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK;
+		dev_info(&pf->pdev->dev, "cleared PE_CRITERR\n");
+	}
+
 	/* only q0 is used in MSI/Legacy mode, and none are used in MSIX */
 	if (icr0 & I40E_PFINT_ICR0_QUEUE_0_MASK) {
 
-- 
1.9.3

