From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 28 Feb 2018 15:14:11 -0800
Subject: [Intel-wired-lan] [PATCH v2] intel: add SPDX identifiers to all the
 Intel drivers
Message-ID: <20180228231411.13304-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the SPDX identifiers to all the Intel wired LAN driver files, as
outlined in Documentation/process/license-rules.rst.

v2: Since "GPL-2.0" and "GPL-2.0+" is deprecated, updated the patch to
    use "GPL-2.0-only" and "GPL-2.0-or-later" respectively.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/e100.c                   | 1 +
 drivers/net/ethernet/intel/e1000/Makefile           | 1 +
 drivers/net/ethernet/intel/e1000/e1000.h            | 1 +
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c    | 1 +
 drivers/net/ethernet/intel/e1000/e1000_hw.c         | 1 +
 drivers/net/ethernet/intel/e1000/e1000_hw.h         | 1 +
 drivers/net/ethernet/intel/e1000/e1000_main.c       | 1 +
 drivers/net/ethernet/intel/e1000/e1000_osdep.h      | 1 +
 drivers/net/ethernet/intel/e1000/e1000_param.c      | 1 +
 drivers/net/ethernet/intel/e1000e/80003es2lan.c     | 1 +
 drivers/net/ethernet/intel/e1000e/80003es2lan.h     | 1 +
 drivers/net/ethernet/intel/e1000e/82571.c           | 1 +
 drivers/net/ethernet/intel/e1000e/82571.h           | 1 +
 drivers/net/ethernet/intel/e1000e/Makefile          | 1 +
 drivers/net/ethernet/intel/e1000e/defines.h         | 1 +
 drivers/net/ethernet/intel/e1000e/e1000.h           | 1 +
 drivers/net/ethernet/intel/e1000e/ethtool.c         | 1 +
 drivers/net/ethernet/intel/e1000e/hw.h              | 1 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c         | 1 +
 drivers/net/ethernet/intel/e1000e/ich8lan.h         | 1 +
 drivers/net/ethernet/intel/e1000e/mac.c             | 1 +
 drivers/net/ethernet/intel/e1000e/mac.h             | 1 +
 drivers/net/ethernet/intel/e1000e/manage.c          | 1 +
 drivers/net/ethernet/intel/e1000e/manage.h          | 1 +
 drivers/net/ethernet/intel/e1000e/netdev.c          | 1 +
 drivers/net/ethernet/intel/e1000e/nvm.c             | 1 +
 drivers/net/ethernet/intel/e1000e/nvm.h             | 1 +
 drivers/net/ethernet/intel/e1000e/param.c           | 1 +
 drivers/net/ethernet/intel/e1000e/phy.c             | 1 +
 drivers/net/ethernet/intel/e1000e/phy.h             | 1 +
 drivers/net/ethernet/intel/e1000e/ptp.c             | 1 +
 drivers/net/ethernet/intel/e1000e/regs.h            | 1 +
 drivers/net/ethernet/intel/fm10k/Makefile           | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k.h            | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_common.c     | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_common.h     | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c      | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c    | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c    | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c        | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_main.c       | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c        | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.h        | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c     | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c        | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c         | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_pf.h         | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_tlv.c        | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_tlv.h        | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_type.h       | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c         | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_vf.h         | 1 +
 drivers/net/ethernet/intel/i40e/Makefile            | 1 +
 drivers/net/ethernet/intel/i40e/i40e.h              | 1 +
 drivers/net/ethernet/intel/i40e/i40e_adminq.c       | 1 +
 drivers/net/ethernet/intel/i40e/i40e_adminq.h       | 1 +
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 1 +
 drivers/net/ethernet/intel/i40e/i40e_alloc.h        | 1 +
 drivers/net/ethernet/intel/i40e/i40e_client.c       | 1 +
 drivers/net/ethernet/intel/i40e/i40e_client.h       | 1 +
 drivers/net/ethernet/intel/i40e/i40e_common.c       | 1 +
 drivers/net/ethernet/intel/i40e/i40e_dcb.c          | 1 +
 drivers/net/ethernet/intel/i40e/i40e_dcb.h          | 1 +
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c       | 1 +
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_devids.h       | 1 +
 drivers/net/ethernet/intel/i40e/i40e_diag.c         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_diag.h         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_hmc.c          | 1 +
 drivers/net/ethernet/intel/i40e/i40e_hmc.h          | 1 +
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_nvm.c          | 1 +
 drivers/net/ethernet/intel/i40e/i40e_osdep.h        | 1 +
 drivers/net/ethernet/intel/i40e/i40e_prototype.h    | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c          | 1 +
 drivers/net/ethernet/intel/i40e/i40e_register.h     | 1 +
 drivers/net/ethernet/intel/i40e/i40e_status.h       | 1 +
 drivers/net/ethernet/intel/i40e/i40e_trace.h        | 1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.h         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_type.h         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c  | 1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h  | 1 +
 drivers/net/ethernet/intel/i40evf/Makefile          | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c     | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_adminq.h     | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_alloc.h      | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_common.c     | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_devids.h     | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_hmc.h        | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_lan_hmc.h    | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_osdep.h      | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_prototype.h  | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_register.h   | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_status.h     | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_trace.h      | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c       | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h       | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h       | 1 +
 drivers/net/ethernet/intel/i40evf/i40evf.h          | 1 +
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c  | 1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c     | 1 +
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 1 +
 drivers/net/ethernet/intel/igb/Makefile             | 1 +
 drivers/net/ethernet/intel/igb/e1000_82575.c        | 1 +
 drivers/net/ethernet/intel/igb/e1000_82575.h        | 1 +
 drivers/net/ethernet/intel/igb/e1000_defines.h      | 1 +
 drivers/net/ethernet/intel/igb/e1000_hw.h           | 1 +
 drivers/net/ethernet/intel/igb/e1000_i210.c         | 1 +
 drivers/net/ethernet/intel/igb/e1000_i210.h         | 1 +
 drivers/net/ethernet/intel/igb/e1000_mac.c          | 1 +
 drivers/net/ethernet/intel/igb/e1000_mac.h          | 1 +
 drivers/net/ethernet/intel/igb/e1000_mbx.c          | 1 +
 drivers/net/ethernet/intel/igb/e1000_mbx.h          | 1 +
 drivers/net/ethernet/intel/igb/e1000_nvm.c          | 1 +
 drivers/net/ethernet/intel/igb/e1000_nvm.h          | 1 +
 drivers/net/ethernet/intel/igb/e1000_phy.c          | 1 +
 drivers/net/ethernet/intel/igb/e1000_phy.h          | 1 +
 drivers/net/ethernet/intel/igb/e1000_regs.h         | 1 +
 drivers/net/ethernet/intel/igb/igb.h                | 1 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c        | 1 +
 drivers/net/ethernet/intel/igb/igb_hwmon.c          | 1 +
 drivers/net/ethernet/intel/igb/igb_main.c           | 1 +
 drivers/net/ethernet/intel/igb/igb_ptp.c            | 1 +
 drivers/net/ethernet/intel/igbvf/Makefile           | 1 +
 drivers/net/ethernet/intel/igbvf/defines.h          | 1 +
 drivers/net/ethernet/intel/igbvf/ethtool.c          | 1 +
 drivers/net/ethernet/intel/igbvf/igbvf.h            | 1 +
 drivers/net/ethernet/intel/igbvf/mbx.c              | 1 +
 drivers/net/ethernet/intel/igbvf/mbx.h              | 1 +
 drivers/net/ethernet/intel/igbvf/netdev.c           | 1 +
 drivers/net/ethernet/intel/igbvf/regs.h             | 1 +
 drivers/net/ethernet/intel/igbvf/vf.c               | 1 +
 drivers/net/ethernet/intel/igbvf/vf.h               | 1 +
 drivers/net/ethernet/intel/ixgb/Makefile            | 1 +
 drivers/net/ethernet/intel/ixgb/ixgb.h              | 1 +
 drivers/net/ethernet/intel/ixgb/ixgb_ee.h           | 1 +
 drivers/net/ethernet/intel/ixgb/ixgb_hw.h           | 1 +
 drivers/net/ethernet/intel/ixgb/ixgb_ids.h          | 1 +
 drivers/net/ethernet/intel/ixgb/ixgb_osdep.h        | 1 +
 drivers/net/ethernet/intel/ixgbe/Makefile           | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h            | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c      | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c      | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c     | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h     | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.h        | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c  | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.h  | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.h  | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h       | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h      | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h        | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_model.h      | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h        | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h      | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h       | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h       | 1 +
 drivers/net/ethernet/intel/ixgbevf/Makefile         | 1 +
 drivers/net/ethernet/intel/ixgbevf/defines.h        | 1 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h        | 1 +
 drivers/net/ethernet/intel/ixgbevf/mbx.h            | 1 +
 drivers/net/ethernet/intel/ixgbevf/regs.h           | 1 +
 drivers/net/ethernet/intel/ixgbevf/vf.h             | 1 +
 168 files changed, 168 insertions(+)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 29486478836e..a750a5fe373a 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
 
   Intel PRO/100 Linux driver
diff --git a/drivers/net/ethernet/intel/e1000/Makefile b/drivers/net/ethernet/intel/e1000/Makefile
index 4a6ab1522451..f17b6b2aa4e0 100644
--- a/drivers/net/ethernet/intel/e1000/Makefile
+++ b/drivers/net/ethernet/intel/e1000/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 ################################################################################
 #
 # Intel PRO/1000 Linux driver
diff --git a/drivers/net/ethernet/intel/e1000/e1000.h b/drivers/net/ethernet/intel/e1000/e1000.h
index 8fd2458060a0..c4355f68cb84 100644
--- a/drivers/net/ethernet/intel/e1000/e1000.h
+++ b/drivers/net/ethernet/intel/e1000/e1000.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel PRO/1000 Linux driver
diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index dc71e87c3260..ea9de00d9679 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  * Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2006 Intel Corporation.
diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 3bac9df1c099..5fb268b4a203 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
 *
   Intel PRO/1000 Linux driver
diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.h b/drivers/net/ethernet/intel/e1000/e1000_hw.h
index 5cf7268cc4e1..cfe4d9ca2d0f 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.h
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel PRO/1000 Linux driver
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3dd4aeb2706d..0744961d2513 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
 
   Intel PRO/1000 Linux driver
diff --git a/drivers/net/ethernet/intel/e1000/e1000_osdep.h b/drivers/net/ethernet/intel/e1000/e1000_osdep.h
index 33e7c45a4fe4..950c1526c094 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_osdep.h
+++ b/drivers/net/ethernet/intel/e1000/e1000_osdep.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel PRO/1000 Linux driver
diff --git a/drivers/net/ethernet/intel/e1000/e1000_param.c b/drivers/net/ethernet/intel/e1000/e1000_param.c
index c9cde352b1c8..d78001983ad3 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_param.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_param.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
 
   Intel PRO/1000 Linux driver
diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.c b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
index cd391376036c..a3d5209d03f6 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.c
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.h b/drivers/net/ethernet/intel/e1000e/80003es2lan.h
index a2162e11673e..256a5a99b113 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.h
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/82571.c b/drivers/net/ethernet/intel/e1000e/82571.c
index 6b03c8553e59..18b807c58cf3 100644
--- a/drivers/net/ethernet/intel/e1000e/82571.c
+++ b/drivers/net/ethernet/intel/e1000e/82571.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/82571.h b/drivers/net/ethernet/intel/e1000e/82571.h
index abc6a9abff98..298463cbd40c 100644
--- a/drivers/net/ethernet/intel/e1000e/82571.h
+++ b/drivers/net/ethernet/intel/e1000e/82571.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/Makefile b/drivers/net/ethernet/intel/e1000e/Makefile
index 106de493373c..de221d190a4c 100644
--- a/drivers/net/ethernet/intel/e1000e/Makefile
+++ b/drivers/net/ethernet/intel/e1000e/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 ################################################################################
 #
 # Intel PRO/1000 Linux driver
diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index afb7ebe20b24..1b7240383f9e 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 2311b31bdcac..b48398799c19 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 003cbd605799..b557c2011139 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index d803b1a12349..7b30c7322180 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 31277d3bb7dc..e6d83d9cd6fc 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 00a36df02a3f..59735958664b 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index f457c5703d0c..cac29543f092 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/mac.h b/drivers/net/ethernet/intel/e1000e/mac.h
index 8284618af9ff..20ca24f80719 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.h
+++ b/drivers/net/ethernet/intel/e1000e/mac.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/manage.c b/drivers/net/ethernet/intel/e1000e/manage.c
index cc9b3befc2bc..86dcdaf8e5ba 100644
--- a/drivers/net/ethernet/intel/e1000e/manage.c
+++ b/drivers/net/ethernet/intel/e1000e/manage.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/manage.h b/drivers/net/ethernet/intel/e1000e/manage.h
index 0b9ea5952b07..97fee39308b2 100644
--- a/drivers/net/ethernet/intel/e1000e/manage.h
+++ b/drivers/net/ethernet/intel/e1000e/manage.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 26121edddc56..3cf4a3aeb05c 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index 2efd80dfd88e..641dedc4e4b9 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.h b/drivers/net/ethernet/intel/e1000e/nvm.h
index 5d46967e0d1f..f77545ad1eea 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.h
+++ b/drivers/net/ethernet/intel/e1000e/nvm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/param.c b/drivers/net/ethernet/intel/e1000e/param.c
index 47da51864543..08e7c4753f90 100644
--- a/drivers/net/ethernet/intel/e1000e/param.c
+++ b/drivers/net/ethernet/intel/e1000e/param.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index 86ff0969efb6..2ce221651e06 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/phy.h b/drivers/net/ethernet/intel/e1000e/phy.h
index 3027f63ee793..62f444368c94 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.h
+++ b/drivers/net/ethernet/intel/e1000e/phy.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index b366885487a8..e88c6a8c3684 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/e1000e/regs.h b/drivers/net/ethernet/intel/e1000e/regs.h
index 0cb4d365e5ad..2335eeeec6e6 100644
--- a/drivers/net/ethernet/intel/e1000e/regs.h
+++ b/drivers/net/ethernet/intel/e1000e/regs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel PRO/1000 Linux driver
  * Copyright(c) 1999 - 2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/Makefile b/drivers/net/ethernet/intel/fm10k/Makefile
index cac645329cea..399a0e18ecce 100644
--- a/drivers/net/ethernet/intel/fm10k/Makefile
+++ b/drivers/net/ethernet/intel/fm10k/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 ################################################################################
 #
 # Intel(R) Ethernet Switch Host Interface Driver
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 46973fb234c5..f41da27c2c8d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2017 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.c b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
index c58a5377a287..9804e432c398 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2018 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.h b/drivers/net/ethernet/intel/fm10k/fm10k_common.h
index d51f9c7a47ff..f2dab96fe791 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_common.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2016 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c b/drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c
index db4bd8bf9722..b4aa3047deea 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2016 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
index 14df09e2d964..134776ef0404 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2016 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index c7234f35f8ff..a2a08fbcef3b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2017 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
index 760cfa52d02c..1f9b34a76595 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2017 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 2c93d719438f..409554d7fca7 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2017 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
index 244d3ad58ca7..d89a3d057f80 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2017 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.h b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.h
index 35c1dbad1330..e0870bf4d873 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2016 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 75c99aed3c41..a7aea686da68 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2018 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 50f53e403ef5..cdc597a13c80 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2018 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index bee192fe2ffb..38863ebbaffd 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2018 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
index e04d41f1a532..afdcae9ca133 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2017 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c
index 9d0d31da426b..3f3eda3be1be 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2018 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.h b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.h
index a1f1027fe184..9b8c9449f117 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2016 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_type.h b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
index 6bb16c13d9d6..9e956a50bc44 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_type.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2016 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
index 337ba65a9411..b50b3fc8717c 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2016 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_vf.h b/drivers/net/ethernet/intel/fm10k/fm10k_vf.h
index 2662f33c0c71..31ba3ce68212 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_vf.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_vf.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Ethernet Switch Host Interface Driver
  * Copyright(c) 2013 - 2016 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/i40e/Makefile b/drivers/net/ethernet/intel/i40e/Makefile
index 3da482c3d68d..315bb688b327 100644
--- a/drivers/net/ethernet/intel/i40e/Makefile
+++ b/drivers/net/ethernet/intel/i40e/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 ################################################################################
 #
 # Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 36d9401a6258..956299c45d5f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index e78971605e0b..8db497109705 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index 2349fbe04bd2..870f886e4d41 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 0dfc52772c45..dee4f594039f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_alloc.h b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
index 926811ad44ac..cc5a96486834 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 0de9610c1d8d..0680a627d27b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.h b/drivers/net/ethernet/intel/i40e/i40e_client.h
index ba55c889e4c5..70c69e02b906 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index ef5a868aae46..6ee310257cf7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 55079fe3ed63..b7b0e1389c69 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.h b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
index 92d01042c1f6..c94500c2ce83 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
index 886e667f2f1c..0b789bafe5fe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index b829fd365693..e37d88106aaa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devids.h b/drivers/net/ethernet/intel/i40e/i40e_devids.h
index 8e46098bad57..e48718eda8b8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_devids.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_diag.c b/drivers/net/ethernet/intel/i40e/i40e_diag.c
index 76ed56641864..a29a3c4f52fe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_diag.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_diag.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_diag.h b/drivers/net/ethernet/intel/i40e/i40e_diag.h
index 0b5911652084..4d2fea1262ad 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_diag.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_diag.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 89807e32a898..f9493f11fbb2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
index a7c7b1d9b7c8..557fa2547ed1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
index d90669211392..94d0cb3696a6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
index daa9204426d4..3cc87343c19d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h
index e74128db5be5..9ac3e791fe1e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index be9a1467a1a1..4b34bbc83b99 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 76a5cb04e4fe..53cc158834b4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_osdep.h b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
index 80e66da6b145..92c2595dee69 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 83798b7841b9..57f67204e8bc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 97381238eb7c..f45a3173aefe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index c234758dad15..907e88dabc61 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_status.h b/drivers/net/ethernet/intel/i40e/i40e_status.h
index afb72e711d43..ae7aea54dc04 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_status.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_status.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_trace.h b/drivers/net/ethernet/intel/i40e/i40e_trace.h
index d3e55f54a05e..d66bf428190a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel(R) 40-10 Gigabit Ethernet Connection Network Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 97cfe944b568..91dfe1c2fd58 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 3c80ea784389..2444f338bb0c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index b0eed8c0b2f2..7485bd47fdd0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index e23975c67417..6049a5640f26 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 6852599b2379..d53f444bf0a4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
diff --git a/drivers/net/ethernet/intel/i40evf/Makefile b/drivers/net/ethernet/intel/i40evf/Makefile
index a393f4a07f06..dce5164844c2 100644
--- a/drivers/net/ethernet/intel/i40evf/Makefile
+++ b/drivers/net/ethernet/intel/i40evf/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 ################################################################################
 #
 # Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
index d1aab6b8bfb1..c85d80b02318 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq.h
index e0bfaa3d4a21..63473c4783bf 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 815de8d9c3fb..2d2a1fdd8b4e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_alloc.h b/drivers/net/ethernet/intel/i40evf/i40e_alloc.h
index 8e6a6dd9212b..f45a41a64312 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_alloc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index 67bf5cebb76f..b7bd9e8f7f25 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_devids.h b/drivers/net/ethernet/intel/i40evf/i40e_devids.h
index 0469e4bfd3ec..de848c5fa5af 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_devids.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_hmc.h b/drivers/net/ethernet/intel/i40evf/i40e_hmc.h
index 00ed24bfce13..b9cb5790a7c1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_hmc.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_hmc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_lan_hmc.h b/drivers/net/ethernet/intel/i40evf/i40e_lan_hmc.h
index a5d79877354c..ed93dd0ec95e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_lan_hmc.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_lan_hmc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_osdep.h b/drivers/net/ethernet/intel/i40evf/i40e_osdep.h
index a90737786c34..033656b8fcc3 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_osdep.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_prototype.h b/drivers/net/ethernet/intel/i40evf/i40e_prototype.h
index 47c429931a57..6ed5f7a5791b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_prototype.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_register.h b/drivers/net/ethernet/intel/i40evf/i40e_register.h
index 10febcfd7cd8..fd6d5413759e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_register.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_status.h b/drivers/net/ethernet/intel/i40evf/i40e_status.h
index 5b222246e08b..a9b441b05afa 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_status.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_status.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_trace.h b/drivers/net/ethernet/intel/i40evf/i40e_trace.h
index 9a5100b2b7c7..00ab682a4094 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_trace.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_trace.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel(R) 40-10 Gigabit Ethernet Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index e088d23eb083..1ae112ff3509 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 9129447d079b..4fdccf39b81e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 54951c84a481..5907a40483e1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index e46555ad7122..8550f78fad79 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index e6793255de0b..4a7541485b3d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index dae121877935..f30d3a37ab69 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 3c76c817ca1a..6d9b2c6a8842 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
diff --git a/drivers/net/ethernet/intel/igb/Makefile b/drivers/net/ethernet/intel/igb/Makefile
index 5bcb2de75933..2e7d80438e48 100644
--- a/drivers/net/ethernet/intel/igb/Makefile
+++ b/drivers/net/ethernet/intel/igb/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 ################################################################################
 #
 # Intel 82575 PCI-Express Ethernet Linux driver
diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index c37cc8bccf47..02889dcd0a45 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.h b/drivers/net/ethernet/intel/igb/e1000_82575.h
index acf06051e111..b34366f775e0 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.h
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 83cabff1e0ab..75d46f5b1021 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_hw.h b/drivers/net/ethernet/intel/igb/e1000_hw.h
index 6c9485ab4b57..34a1d96ff9f0 100644
--- a/drivers/net/ethernet/intel/igb/e1000_hw.h
+++ b/drivers/net/ethernet/intel/igb/e1000_hw.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 07d48f2e3369..44fc5ce046de 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.h b/drivers/net/ethernet/intel/igb/e1000_i210.h
index b2964a2a60b1..912484400e87 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.h
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index 5eff82678f0b..49c6f96a1621 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.h b/drivers/net/ethernet/intel/igb/e1000_mac.h
index 90c8893c3eed..3e3641835cf1 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.h
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_mbx.c b/drivers/net/ethernet/intel/igb/e1000_mbx.c
index bffd58f7b2a1..e78df7edecca 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mbx.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mbx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_mbx.h b/drivers/net/ethernet/intel/igb/e1000_mbx.h
index a62b08e1572e..28c5c01d46ca 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mbx.h
+++ b/drivers/net/ethernet/intel/igb/e1000_mbx.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
index 3582c5cf8843..da648c3180e5 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  * This program is free software; you can redistribute it and/or modify it
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.h b/drivers/net/ethernet/intel/igb/e1000_nvm.h
index febc9cdb7391..12e4ccfa5536 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.h
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
index 413025bdcb50..b85e7e052e66 100644
--- a/drivers/net/ethernet/intel/igb/e1000_phy.c
+++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2015 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.h b/drivers/net/ethernet/intel/igb/e1000_phy.h
index 9b622b33bb5a..f214aecc32e3 100644
--- a/drivers/net/ethernet/intel/igb/e1000_phy.h
+++ b/drivers/net/ethernet/intel/igb/e1000_phy.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/e1000_regs.h b/drivers/net/ethernet/intel/igb/e1000_regs.h
index 568c96842f28..b03c823cab14 100644
--- a/drivers/net/ethernet/intel/igb/e1000_regs.h
+++ b/drivers/net/ethernet/intel/igb/e1000_regs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 55d6f17d5799..23242fe59db8 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 606e6761758f..15020b3045a1 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/igb_hwmon.c b/drivers/net/ethernet/intel/igb/igb_hwmon.c
index 44b6a68f1af7..480fe90c48de 100644
--- a/drivers/net/ethernet/intel/igb/igb_hwmon.c
+++ b/drivers/net/ethernet/intel/igb/igb_hwmon.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 229b72aab17d..5c474498f3c1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* Intel(R) Gigabit Ethernet Linux driver
  * Copyright(c) 2007-2014 Intel Corporation.
  *
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 0746b19ec6d3..1805efe73628 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* PTP Hardware Clock (PHC) driver for the Intel 82576 and 82580
  *
  * Copyright (C) 2011 Richard Cochran <richardcochran@gmail.com>
diff --git a/drivers/net/ethernet/intel/igbvf/Makefile b/drivers/net/ethernet/intel/igbvf/Makefile
index 044b0ad5fcb9..c134062cd7fa 100644
--- a/drivers/net/ethernet/intel/igbvf/Makefile
+++ b/drivers/net/ethernet/intel/igbvf/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 ################################################################################
 #
 # Intel(R) 82576 Virtual Function Linux driver
diff --git a/drivers/net/ethernet/intel/igbvf/defines.h b/drivers/net/ethernet/intel/igbvf/defines.h
index f1789d192e24..169c981d4c4c 100644
--- a/drivers/net/ethernet/intel/igbvf/defines.h
+++ b/drivers/net/ethernet/intel/igbvf/defines.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel(R) 82576 Virtual Function Linux driver
diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
index a127688e83e6..6012345fbdd5 100644
--- a/drivers/net/ethernet/intel/igbvf/ethtool.c
+++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
 
   Intel(R) 82576 Virtual Function Linux driver
diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
index bf69f01f8467..3a787729db13 100644
--- a/drivers/net/ethernet/intel/igbvf/igbvf.h
+++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel(R) 82576 Virtual Function Linux driver
diff --git a/drivers/net/ethernet/intel/igbvf/mbx.c b/drivers/net/ethernet/intel/igbvf/mbx.c
index c9a441632e9f..2c368391478a 100644
--- a/drivers/net/ethernet/intel/igbvf/mbx.c
+++ b/drivers/net/ethernet/intel/igbvf/mbx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
 
   Intel(R) 82576 Virtual Function Linux driver
diff --git a/drivers/net/ethernet/intel/igbvf/mbx.h b/drivers/net/ethernet/intel/igbvf/mbx.h
index 30d58c4a444e..ef6eafe838f8 100644
--- a/drivers/net/ethernet/intel/igbvf/mbx.h
+++ b/drivers/net/ethernet/intel/igbvf/mbx.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel(R) 82576 Virtual Function Linux driver
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 4214c1519a87..fa078761b76d 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
 
   Intel(R) 82576 Virtual Function Linux driver
diff --git a/drivers/net/ethernet/intel/igbvf/regs.h b/drivers/net/ethernet/intel/igbvf/regs.h
index 86a7c120b574..e2620b955d39 100644
--- a/drivers/net/ethernet/intel/igbvf/regs.h
+++ b/drivers/net/ethernet/intel/igbvf/regs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel(R) 82576 Virtual Function Linux driver
diff --git a/drivers/net/ethernet/intel/igbvf/vf.c b/drivers/net/ethernet/intel/igbvf/vf.c
index 9577ccf4b26a..7ae2e54e716f 100644
--- a/drivers/net/ethernet/intel/igbvf/vf.c
+++ b/drivers/net/ethernet/intel/igbvf/vf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
 
   Intel(R) 82576 Virtual Function Linux driver
diff --git a/drivers/net/ethernet/intel/igbvf/vf.h b/drivers/net/ethernet/intel/igbvf/vf.h
index d213eefb6169..75ca811eb3bd 100644
--- a/drivers/net/ethernet/intel/igbvf/vf.h
+++ b/drivers/net/ethernet/intel/igbvf/vf.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel(R) 82576 Virtual Function Linux driver
diff --git a/drivers/net/ethernet/intel/ixgb/Makefile b/drivers/net/ethernet/intel/ixgb/Makefile
index 0b20c5e62ffe..f5e1d1e97b52 100644
--- a/drivers/net/ethernet/intel/ixgb/Makefile
+++ b/drivers/net/ethernet/intel/ixgb/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 ################################################################################
 #
 # Intel PRO/10GbE Linux driver
diff --git a/drivers/net/ethernet/intel/ixgb/ixgb.h b/drivers/net/ethernet/intel/ixgb/ixgb.h
index 1180cd59b570..4b8ed35647b6 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb.h
+++ b/drivers/net/ethernet/intel/ixgb/ixgb.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel PRO/10GbE Linux driver
diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_ee.h b/drivers/net/ethernet/intel/ixgb/ixgb_ee.h
index 5680f64314b8..755816738c75 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_ee.h
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_ee.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel PRO/10GbE Linux driver
diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_hw.h b/drivers/net/ethernet/intel/ixgb/ixgb_hw.h
index 0bd5d72e1af5..63c0e5f07a6b 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_hw.h
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_hw.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel PRO/10GbE Linux driver
diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_ids.h b/drivers/net/ethernet/intel/ixgb/ixgb_ids.h
index 32c1b302d791..4bee42d5b2ad 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_ids.h
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_ids.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel PRO/10GbE Linux driver
diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_osdep.h b/drivers/net/ethernet/intel/ixgb/ixgb_osdep.h
index 8fc905192231..e97d9249c951 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_osdep.h
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_osdep.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel PRO/10GbE Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile b/drivers/net/ethernet/intel/ixgbe/Makefile
index 8319465eb38d..e6719bc5be80 100644
--- a/drivers/net/ethernet/intel/ixgbe/Makefile
+++ b/drivers/net/ethernet/intel/ixgbe/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 ################################################################################
 #
 # Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index c1e3a0039ea5..fac18aa20073 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index a0ebd9ecf243..a0deb92aa0a3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index 4dfc81dbee4b..e45e844ae920 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 61188f343955..458b027712e7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
index 4d4c02366cb3..7359d0b40c77 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.h
index fc0a2dd52499..4ee2b9499387 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c
index f94c7e82a30b..44fbcadd9741 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.h
index 3164f5453b8f..97054956b130 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.h
index 90c370230e20..b60c02b5f637 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h
index 38385876effb..4997ae8d6503 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
index da3ce7849e85..4b3d73f9f169 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
index 811cb4f64a5b..c6a0730febd2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_model.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_model.h
index 538a1c5475b6..b4c5a79c4243 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_model.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_model.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel 10 Gigabit PCI Express Linux drive
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index b0cac961df3b..0b7bc95937be 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
index cf67b9b18ed7..5ce75d2d26b0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index ca45359686d3..8fc2fdf80733 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
index e21cd48491d3..515e65e6c94b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
  *
  * Intel 10 Gigabit PCI Express Linux driver
diff --git a/drivers/net/ethernet/intel/ixgbevf/Makefile b/drivers/net/ethernet/intel/ixgbevf/Makefile
index 4ce4c97ef5ad..fe57e900d897 100644
--- a/drivers/net/ethernet/intel/ixgbevf/Makefile
+++ b/drivers/net/ethernet/intel/ixgbevf/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 ################################################################################
 #
 # Intel 82599 Virtual Function driver
diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index 8617cae2f801..ce549568f6f7 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 82599 Virtual Function driver
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index f65ca156af2d..7778c30b6ca5 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 82599 Virtual Function driver
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.h b/drivers/net/ethernet/intel/ixgbevf/mbx.h
index bc0442acae78..944f2edc6acc 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.h
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 82599 Virtual Function driver
diff --git a/drivers/net/ethernet/intel/ixgbevf/regs.h b/drivers/net/ethernet/intel/ixgbevf/regs.h
index 2764fd16261f..f53665c3ec1b 100644
--- a/drivers/net/ethernet/intel/ixgbevf/regs.h
+++ b/drivers/net/ethernet/intel/ixgbevf/regs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 82599 Virtual Function driver
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.h b/drivers/net/ethernet/intel/ixgbevf/vf.h
index c651fefcc3d2..6ed061c25790 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*******************************************************************************
 
   Intel 82599 Virtual Function driver
-- 
2.14.3

