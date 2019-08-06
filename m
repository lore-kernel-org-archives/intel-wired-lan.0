From: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
Date: Tue,  6 Aug 2019 10:33:48 -0300
Subject: [Intel-wired-lan] [PATCH 2/2] i40e: Implement debug macro hw_dbg
 using pr_debug
In-Reply-To: <20190806133348.17924-1-maurosr@linux.vnet.ibm.com>
References: <20190806133348.17924-1-maurosr@linux.vnet.ibm.com>
Message-ID: <20190806133348.17924-2-maurosr@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There are several uses of hw_dbg in the code, producing no output. This
patch implments it using pr_debug.

Initially the intention was to implement it using netdev_dbg, analogously
to what is done in ixgbe for instance. That approach was avoided due to
some early usages of hw_dbg, like i40e_pf_reset, before the vsi structure
initialization causing NULL pointer dereference during the driver probe if
the dbg messages were turned on as soon as the module is probed.

Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 1 +
 drivers/net/ethernet/intel/i40e/i40e_hmc.c    | 1 +
 drivers/net/ethernet/intel/i40e/i40e_osdep.h  | 7 ++++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 906cf68d3453..a51678166ff9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include "i40e.h"
 #include "i40e_type.h"
 #include "i40e_adminq.h"
 #include "i40e_prototype.h"
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
index 19ce93d7fd0a..163ee8c6311c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include "i40e.h"
 #include "i40e_osdep.h"
 #include "i40e_register.h"
 #include "i40e_status.h"
diff --git a/drivers/net/ethernet/intel/i40e/i40e_osdep.h b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
index a07574bff550..c0c9ce3eab23 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
@@ -18,7 +18,12 @@
  * actual OS primitives
  */
 
-#define hw_dbg(hw, S, A...)	do {} while (0)
+#define hw_dbg(hw, S, A...)							\
+do {										\
+	int domain = pci_domain_nr(((struct i40e_pf *)(hw)->back)->pdev->bus);	\
+	pr_debug("i40e %04x:%02x:%02x.%x " S, domain, (hw)->bus.bus_id,		\
+		 (hw)->bus.device, (hw)->bus.func, ## A);			\
+} while (0)
 
 #define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
 #define rd32(a, reg)		readl((a)->hw_addr + (reg))
-- 
2.21.0

