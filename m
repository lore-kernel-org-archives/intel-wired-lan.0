From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Mon, 19 Jul 2021 14:07:43 -0400
Subject: [Intel-wired-lan] [PATCH v4 11/14] scsi: lpfc: Use irq_set_affinity
In-Reply-To: <20210719180746.1008665-1-nitesh@redhat.com>
References: <20210719180746.1008665-1-nitesh@redhat.com>
Message-ID: <20210719180746.1008665-12-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver uses irq_set_affinity_hint to set the affinity for the lpfc
interrupts to a mask corresponding to the local NUMA node to avoid
performance overhead on AMD architectures.

However, irq_set_affinity_hint() setting the affinity is an undocumented
side effect that this function also sets the affinity under the hood.
To remove this side effect irq_set_affinity_hint() has been marked as
deprecated and new interfaces have been introduced.

Also, as per the commit dcaa21367938 ("scsi: lpfc: Change default IRQ model
on AMD architectures"):
"On AMD architecture, revert the irq allocation to the normal style
(non-managed) and then use irq_set_affinity_hint() to set the cpu affinity
and disable user-space rebalancing."
we don't really need to set the affinity_hint as user-space rebalancing for
the lpfc interrupts is not desired.

Hence, replace the irq_set_affinity_hint() with irq_set_affinity() which
only applies the affinity for the interrupts.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 5983e05b648f..8a16bacb8c93 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -11455,7 +11455,7 @@ lpfc_irq_set_aff(struct lpfc_hba_eq_hdl *eqhdl, unsigned int cpu)
 	cpumask_clear(&eqhdl->aff_mask);
 	cpumask_set_cpu(cpu, &eqhdl->aff_mask);
 	irq_set_status_flags(eqhdl->irq, IRQ_NO_BALANCING);
-	irq_set_affinity_hint(eqhdl->irq, &eqhdl->aff_mask);
+	irq_set_affinity(eqhdl->irq, &eqhdl->aff_mask);
 }
 
 /**
@@ -11744,7 +11744,6 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 	for (--index; index >= 0; index--) {
 		eqhdl = lpfc_get_eq_hdl(index);
 		lpfc_irq_clear_aff(eqhdl);
-		irq_set_affinity_hint(eqhdl->irq, NULL);
 		free_irq(eqhdl->irq, eqhdl);
 	}
 
@@ -11905,7 +11904,6 @@ lpfc_sli4_disable_intr(struct lpfc_hba *phba)
 		for (index = 0; index < phba->cfg_irq_chann; index++) {
 			eqhdl = lpfc_get_eq_hdl(index);
 			lpfc_irq_clear_aff(eqhdl);
-			irq_set_affinity_hint(eqhdl->irq, NULL);
 			free_irq(eqhdl->irq, eqhdl);
 		}
 	} else {
-- 
2.27.0

