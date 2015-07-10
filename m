From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 10 Jul 2015 19:35:58 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][next PATCH S8 03/15]
	i40e/i40evf: Move helper functions to a header file
In-Reply-To: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
References: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1436571370-103673-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

A new header file i40e_helper.h is added to both the PF and VF driver
with functions used by both drivers.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I3c6daedc2ff6f32bc7624bf5eaef05899d35f28b
---
 drivers/net/ethernet/intel/i40e/i40e_helper.h   | 102 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c     |  72 +----------------
 drivers/net/ethernet/intel/i40evf/i40e_helper.h | 102 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |  80 +------------------
 4 files changed, 206 insertions(+), 150 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_helper.h
 create mode 100644 drivers/net/ethernet/intel/i40evf/i40e_helper.h

diff --git a/drivers/net/ethernet/intel/i40e/i40e_helper.h b/drivers/net/ethernet/intel/i40e/i40e_helper.h
new file mode 100644
index 0000000..0eb1c75
--- /dev/null
+++ b/drivers/net/ethernet/intel/i40e/i40e_helper.h
@@ -0,0 +1,102 @@
+/*******************************************************************************
+ *
+ * Intel Ethernet Controller XL710 Family Linux Driver
+ * Copyright(c) 2013 - 2015 Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * The full GNU General Public License is included in this distribution in
+ * the file called "COPYING".
+ *
+ * Contact Information:
+ * e1000-devel Mailing List <e1000-devel@lists.sourceforge.net>
+ * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
+ *
+ ******************************************************************************/
+
+#ifndef _I40E_HELPER_H_
+#define _I40E_HELPER_H_
+
+/**
+ * i40e_allocate_dma_mem_d - OS specific memory alloc for shared code
+ * @hw:   pointer to the HW structure
+ * @mem:  ptr to mem struct to fill out
+ * @size: size of memory requested
+ * @alignment: what to align the allocation to
+ **/
+inline int i40e_allocate_dma_mem_d(struct i40e_hw *hw,
+				   struct i40e_dma_mem *mem,
+				   u64 size, u32 alignment)
+{
+	struct i40e_pf *nf = (struct i40e_pf *)hw->back;
+
+	mem->size = ALIGN(size, alignment);
+	mem->va = dma_zalloc_coherent(&nf->pdev->dev, mem->size,
+				      &mem->pa, GFP_KERNEL);
+	if (!mem->va)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * i40e_free_dma_mem_d - OS specific memory free for shared code
+ * @hw:   pointer to the HW structure
+ * @mem:  ptr to mem struct to free
+ **/
+inline int i40e_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
+{
+	struct i40e_pf *nf = (struct i40e_pf *)hw->back;
+
+	dma_free_coherent(&nf->pdev->dev, mem->size, mem->va, mem->pa);
+	mem->va = NULL;
+	mem->pa = 0;
+	mem->size = 0;
+
+	return 0;
+}
+
+/**
+ * i40e_allocate_virt_mem_d - OS specific memory alloc for shared code
+ * @hw:   pointer to the HW structure
+ * @mem:  ptr to mem struct to fill out
+ * @size: size of memory requested
+ **/
+inline int i40e_allocate_virt_mem_d(struct i40e_hw *hw,
+				    struct i40e_virt_mem *mem,
+				    u32 size)
+{
+	mem->size = size;
+	mem->va = kzalloc(size, GFP_KERNEL);
+
+	if (!mem->va)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * i40e_free_virt_mem_d - OS specific memory free for shared code
+ * @hw:   pointer to the HW structure
+ * @mem:  ptr to mem struct to free
+ **/
+inline int i40e_free_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem)
+{
+	/* it's ok to kfree a NULL pointer */
+	kfree(mem->va);
+	mem->va = NULL;
+	mem->size = 0;
+
+	return 0;
+}
+#endif /* _I40E_HELPER_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e9253e4..18bc8c5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -26,6 +26,7 @@
 
 /* Local includes */
 #include "i40e.h"
+#include "i40e_helper.h"
 #include "i40e_diag.h"
 #ifdef CONFIG_I40E_VXLAN
 #include <net/vxlan.h>
@@ -95,77 +96,6 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 /**
- * i40e_allocate_dma_mem_d - OS specific memory alloc for shared code
- * @hw:   pointer to the HW structure
- * @mem:  ptr to mem struct to fill out
- * @size: size of memory requested
- * @alignment: what to align the allocation to
- **/
-int i40e_allocate_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem,
-			    u64 size, u32 alignment)
-{
-	struct i40e_pf *pf = (struct i40e_pf *)hw->back;
-
-	mem->size = ALIGN(size, alignment);
-	mem->va = dma_zalloc_coherent(&pf->pdev->dev, mem->size,
-				      &mem->pa, GFP_KERNEL);
-	if (!mem->va)
-		return -ENOMEM;
-
-	return 0;
-}
-
-/**
- * i40e_free_dma_mem_d - OS specific memory free for shared code
- * @hw:   pointer to the HW structure
- * @mem:  ptr to mem struct to free
- **/
-int i40e_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
-{
-	struct i40e_pf *pf = (struct i40e_pf *)hw->back;
-
-	dma_free_coherent(&pf->pdev->dev, mem->size, mem->va, mem->pa);
-	mem->va = NULL;
-	mem->pa = 0;
-	mem->size = 0;
-
-	return 0;
-}
-
-/**
- * i40e_allocate_virt_mem_d - OS specific memory alloc for shared code
- * @hw:   pointer to the HW structure
- * @mem:  ptr to mem struct to fill out
- * @size: size of memory requested
- **/
-int i40e_allocate_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem,
-			     u32 size)
-{
-	mem->size = size;
-	mem->va = kzalloc(size, GFP_KERNEL);
-
-	if (!mem->va)
-		return -ENOMEM;
-
-	return 0;
-}
-
-/**
- * i40e_free_virt_mem_d - OS specific memory free for shared code
- * @hw:   pointer to the HW structure
- * @mem:  ptr to mem struct to free
- **/
-int i40e_free_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem)
-{
-	/* it's ok to kfree a NULL pointer */
-	kfree(mem->va);
-	mem->va = NULL;
-	mem->size = 0;
-
-	return 0;
-}
-
-/**
  * i40e_get_lump - find a lump of free generic resource
  * @pf: board private structure
  * @pile: the pile of resource to search
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_helper.h b/drivers/net/ethernet/intel/i40evf/i40e_helper.h
new file mode 100644
index 0000000..6e88a3b
--- /dev/null
+++ b/drivers/net/ethernet/intel/i40evf/i40e_helper.h
@@ -0,0 +1,102 @@
+/*******************************************************************************
+ *
+ * Intel Ethernet Controller XL710 Family Linux Driver
+ * Copyright(c) 2013 - 2015 Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * The full GNU General Public License is included in this distribution in
+ * the file called "COPYING".
+ *
+ * Contact Information:
+ * e1000-devel Mailing List <e1000-devel@lists.sourceforge.net>
+ * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
+ *
+ ******************************************************************************/
+
+#ifndef _I40E_HELPER_H_
+#define _I40E_HELPER_H_
+
+/**
+ * i40evf_allocate_dma_mem_d - OS specific memory alloc for shared code
+ * @hw:   pointer to the HW structure
+ * @mem:  ptr to mem struct to fill out
+ * @size: size of memory requested
+ * @alignment: what to align the allocation to
+ **/
+inline int i40evf_allocate_dma_mem_d(struct i40e_hw *hw,
+				     struct i40e_dma_mem *mem,
+				     u64 size, u32 alignment)
+{
+	struct i40evf_adapter *nf = (struct i40evf_adapter *)hw->back;
+
+	mem->size = ALIGN(size, alignment);
+	mem->va = dma_zalloc_coherent(&nf->pdev->dev, mem->size,
+				      &mem->pa, GFP_KERNEL);
+	if (!mem->va)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * i40evf_free_dma_mem_d - OS specific memory free for shared code
+ * @hw:   pointer to the HW structure
+ * @mem:  ptr to mem struct to free
+ **/
+inline int i40evf_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
+{
+	struct i40evf_adapter *nf = (struct i40evf_adapter *)hw->back;
+
+	dma_free_coherent(&nf->pdev->dev, mem->size, mem->va, mem->pa);
+	mem->va = NULL;
+	mem->pa = 0;
+	mem->size = 0;
+
+	return 0;
+}
+
+/**
+ * i40evf_allocate_virt_mem_d - OS specific memory alloc for shared code
+ * @hw:   pointer to the HW structure
+ * @mem:  ptr to mem struct to fill out
+ * @size: size of memory requested
+ **/
+inline int i40evf_allocate_virt_mem_d(struct i40e_hw *hw,
+				      struct i40e_virt_mem *mem,
+				      u32 size)
+{
+	mem->size = size;
+	mem->va = kzalloc(size, GFP_KERNEL);
+
+	if (!mem->va)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * i40evf_free_virt_mem_d - OS specific memory free for shared code
+ * @hw:   pointer to the HW structure
+ * @mem:  ptr to mem struct to free
+ **/
+inline int i40evf_free_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem)
+{
+	/* it's ok to kfree a NULL pointer */
+	kfree(mem->va);
+	mem->va = NULL;
+	mem->size = 0;
+
+	return 0;
+}
+#endif /* _I40E_HELPER_H_ */
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index c1d2469..fc9e7fa 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -25,6 +25,7 @@
  ******************************************************************************/
 
 #include "i40evf.h"
+#include "i40e_helper.h"
 #include "i40e_prototype.h"
 static int i40evf_setup_all_tx_resources(struct i40evf_adapter *adapter);
 static int i40evf_setup_all_rx_resources(struct i40evf_adapter *adapter);
@@ -62,85 +63,6 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 /**
- * i40evf_allocate_dma_mem_d - OS specific memory alloc for shared code
- * @hw:   pointer to the HW structure
- * @mem:  ptr to mem struct to fill out
- * @size: size of memory requested
- * @alignment: what to align the allocation to
- **/
-i40e_status i40evf_allocate_dma_mem_d(struct i40e_hw *hw,
-				      struct i40e_dma_mem *mem,
-				      u64 size, u32 alignment)
-{
-	struct i40evf_adapter *adapter = (struct i40evf_adapter *)hw->back;
-
-	if (!mem)
-		return I40E_ERR_PARAM;
-
-	mem->size = ALIGN(size, alignment);
-	mem->va = dma_alloc_coherent(&adapter->pdev->dev, mem->size,
-				     (dma_addr_t *)&mem->pa, GFP_KERNEL);
-	if (mem->va)
-		return 0;
-	else
-		return I40E_ERR_NO_MEMORY;
-}
-
-/**
- * i40evf_free_dma_mem_d - OS specific memory free for shared code
- * @hw:   pointer to the HW structure
- * @mem:  ptr to mem struct to free
- **/
-i40e_status i40evf_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
-{
-	struct i40evf_adapter *adapter = (struct i40evf_adapter *)hw->back;
-
-	if (!mem || !mem->va)
-		return I40E_ERR_PARAM;
-	dma_free_coherent(&adapter->pdev->dev, mem->size,
-			  mem->va, (dma_addr_t)mem->pa);
-	return 0;
-}
-
-/**
- * i40evf_allocate_virt_mem_d - OS specific memory alloc for shared code
- * @hw:   pointer to the HW structure
- * @mem:  ptr to mem struct to fill out
- * @size: size of memory requested
- **/
-i40e_status i40evf_allocate_virt_mem_d(struct i40e_hw *hw,
-				       struct i40e_virt_mem *mem, u32 size)
-{
-	if (!mem)
-		return I40E_ERR_PARAM;
-
-	mem->size = size;
-	mem->va = kzalloc(size, GFP_KERNEL);
-
-	if (mem->va)
-		return 0;
-	else
-		return I40E_ERR_NO_MEMORY;
-}
-
-/**
- * i40evf_free_virt_mem_d - OS specific memory free for shared code
- * @hw:   pointer to the HW structure
- * @mem:  ptr to mem struct to free
- **/
-i40e_status i40evf_free_virt_mem_d(struct i40e_hw *hw,
-				   struct i40e_virt_mem *mem)
-{
-	if (!mem)
-		return I40E_ERR_PARAM;
-
-	/* it's ok to kfree a NULL pointer */
-	kfree(mem->va);
-
-	return 0;
-}
-
-/**
  * i40evf_debug_d - OS dependent version of debug printing
  * @hw:  pointer to the HW structure
  * @mask: debug level mask
-- 
1.9.3

