From: Joshua Hay <joshua.a.hay@intel.com>
Date: Mon, 11 Jan 2016 15:18:20 -0800
Subject: [Intel-wired-lan] [next PATCH S27 08/15] i40e/i40evf: don't lose
	interrupts
In-Reply-To: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
References: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452554307-20937-9-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

While re-enabling interrupts the driver would clear all pending
causes. This meant that if an interrupt was generated while the driver
was cleaning or polling with interrupts disabled, then that interrupt
was lost.  This could cause a queue to become dead, especially for
receive.  Refactored the enable_icr0 function in order to allow
it to be decided by the caller whether the CLEARPBA (clear pending
events) bit will be set while re-enabling the interrupt.

Also update copyright year in file headers.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Ic1db100a05e13c98919057696db147a258ca365a
---
Testing Hints: use pktgen or a traffic generator to send packets to
the device and force it to enter polling.  If all queues are in use,
usually a few of the queues will quit receiving.

 drivers/net/ethernet/intel/i40e/i40e.h             |  7 +++++--
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 11 ++++++-----
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  6 ++++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 ++--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  4 +++-
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index cffa834..e13a179 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1,7 +1,7 @@
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
- * Copyright(c) 2013 - 2015 Intel Corporation.
+ * Copyright(c) 2013 - 2016 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -766,6 +766,9 @@ static inline void i40e_irq_dynamic_enable(struct i40e_vsi *vsi, int vector)
 	struct i40e_hw *hw = &pf->hw;
 	u32 val;
 
+	/* definitely clear the PBA here, as this function is meant to
+	 * clean out all previous interrupts AND enable the interrupt
+	 */
 	val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
 	      I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
 	      (I40E_ITR_NONE << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT);
@@ -774,7 +777,7 @@ static inline void i40e_irq_dynamic_enable(struct i40e_vsi *vsi, int vector)
 }
 
 void i40e_irq_dynamic_disable_icr0(struct i40e_pf *pf);
-void i40e_irq_dynamic_enable_icr0(struct i40e_pf *pf);
+void i40e_irq_dynamic_enable_icr0(struct i40e_pf *pf, bool clearpba);
 #ifdef I40E_FCOE
 struct rtnl_link_stats64 *i40e_get_netdev_stats_struct(
 					     struct net_device *netdev,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 25cf075..f28a999 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3262,14 +3262,15 @@ void i40e_irq_dynamic_disable_icr0(struct i40e_pf *pf)
 /**
  * i40e_irq_dynamic_enable_icr0 - Enable default interrupt generation for icr0
  * @pf: board private structure
+ * @clearpba: true when all pending interrupt events should be cleared
  **/
-void i40e_irq_dynamic_enable_icr0(struct i40e_pf *pf)
+void i40e_irq_dynamic_enable_icr0(struct i40e_pf *pf, bool clearpba)
 {
 	struct i40e_hw *hw = &pf->hw;
 	u32 val;
 
 	val = I40E_PFINT_DYN_CTL0_INTENA_MASK   |
-	      I40E_PFINT_DYN_CTL0_CLEARPBA_MASK |
+	      (clearpba ? I40E_PFINT_DYN_CTL0_CLEARPBA_MASK : 0) |
 	      (I40E_ITR_NONE << I40E_PFINT_DYN_CTL0_ITR_INDX_SHIFT);
 
 	wr32(hw, I40E_PFINT_DYN_CTL0, val);
@@ -3401,7 +3402,7 @@ static int i40e_vsi_enable_irq(struct i40e_vsi *vsi)
 		for (i = 0; i < vsi->num_q_vectors; i++)
 			i40e_irq_dynamic_enable(vsi, i);
 	} else {
-		i40e_irq_dynamic_enable_icr0(pf);
+		i40e_irq_dynamic_enable_icr0(pf, true);
 	}
 
 	i40e_flush(&pf->hw);
@@ -3547,7 +3548,7 @@ enable_intr:
 	wr32(hw, I40E_PFINT_ICR0_ENA, ena_mask);
 	if (!test_bit(__I40E_DOWN, &pf->state)) {
 		i40e_service_event_schedule(pf);
-		i40e_irq_dynamic_enable_icr0(pf);
+		i40e_irq_dynamic_enable_icr0(pf, false);
 	}
 
 	return ret;
@@ -7855,7 +7856,7 @@ static int i40e_setup_misc_vector(struct i40e_pf *pf)
 
 	i40e_flush(hw);
 
-	i40e_irq_dynamic_enable_icr0(pf);
+	i40e_irq_dynamic_enable_icr0(pf, true);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index a01192a..c2f0b7c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1810,7 +1810,9 @@ static u32 i40e_buildreg_itr(const int type, const u16 itr)
 	u32 val;
 
 	val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
-	      I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
+	      /* Don't clear PBA because that can cause lost interrupts that
+	       * came in while we were cleaning/polling
+	       */
 	      (type << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT) |
 	      (itr << I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT);
 
@@ -1983,7 +1985,7 @@ tx_only:
 		qval = rd32(hw, I40E_QINT_TQCTL(0)) |
 		       I40E_QINT_TQCTL_CAUSE_ENA_MASK;
 		wr32(hw, I40E_QINT_TQCTL(0), qval);
-		i40e_irq_dynamic_enable_icr0(vsi->back);
+		i40e_irq_dynamic_enable_icr0(vsi->back, false);
 	}
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 1635c7a..3e0d87e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
- * Copyright(c) 2013 - 2015 Intel Corporation.
+ * Copyright(c) 2013 - 2016 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -980,7 +980,7 @@ err_alloc:
 		i40e_free_vfs(pf);
 err_iov:
 	/* Re-enable interrupt 0. */
-	i40e_irq_dynamic_enable_icr0(pf);
+	i40e_irq_dynamic_enable_icr0(pf, false);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 6a0d190..155f2c1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1248,7 +1248,9 @@ static u32 i40e_buildreg_itr(const int type, const u16 itr)
 	u32 val;
 
 	val = I40E_VFINT_DYN_CTLN1_INTENA_MASK |
-	      I40E_VFINT_DYN_CTLN1_CLEARPBA_MASK |
+	      /* Don't clear PBA because that can cause lost interrupts that
+	       * came in while we were cleaning/polling
+	       */
 	      (type << I40E_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
 	      (itr << I40E_VFINT_DYN_CTLN1_INTERVAL_SHIFT);
 
-- 
2.1.0

