From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon,  4 May 2020 09:43:48 -0700
Subject: [Intel-wired-lan] [net-next v3 8/9] i40e: Move client header
 location
In-Reply-To: <20200504164349.1523441-1-jeffrey.t.kirsher@intel.com>
References: <20200504164349.1523441-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20200504164349.1523441-8-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shiraz Saleem <shiraz.saleem@intel.com>

Move i40e_client.h to include/linux/net/intel/*
since its shared between i40iw and i40e.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/infiniband/hw/i40iw/Makefile                            | 1 -
 drivers/infiniband/hw/i40iw/i40iw.h                             | 2 +-
 drivers/net/ethernet/intel/i40e/i40e.h                          | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c                   | 2 +-
 .../intel/i40e => include/linux/net/intel}/i40e_client.h        | 0
 5 files changed, 3 insertions(+), 4 deletions(-)
 rename {drivers/net/ethernet/intel/i40e => include/linux/net/intel}/i40e_client.h (100%)

diff --git a/drivers/infiniband/hw/i40iw/Makefile b/drivers/infiniband/hw/i40iw/Makefile
index 8942f8229945..34da9eba8a7c 100644
--- a/drivers/infiniband/hw/i40iw/Makefile
+++ b/drivers/infiniband/hw/i40iw/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y :=  -I $(srctree)/drivers/net/ethernet/intel/i40e
 
 obj-$(CONFIG_INFINIBAND_I40IW) += i40iw.o
 
diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index 3c62c9327a9c..1ba7561f9cbb 100644
--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -45,6 +45,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/crc32c.h>
+#include <linux/net/intel/i40e_client.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_pack.h>
@@ -57,7 +58,6 @@
 #include "i40iw_d.h"
 #include "i40iw_hmc.h"
 
-#include <i40e_client.h>
 #include "i40iw_type.h"
 #include "i40iw_p.h"
 #include <rdma/i40iw-abi.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index e95b8da45e07..5ff0828a6f50 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -38,7 +38,7 @@
 #include <net/xdp_sock.h>
 #include "i40e_type.h"
 #include "i40e_prototype.h"
-#include "i40e_client.h"
+#include <linux/net/intel/i40e_client.h>
 #include <linux/avf/virtchnl.h>
 #include "i40e_virtchnl_pf.h"
 #include "i40e_txrx.h"
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index e81530ca08d0..befd3018183f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -3,10 +3,10 @@
 
 #include <linux/list.h>
 #include <linux/errno.h>
+#include <linux/net/intel/i40e_client.h>
 
 #include "i40e.h"
 #include "i40e_prototype.h"
-#include "i40e_client.h"
 
 static const char i40e_client_interface_version_str[] = I40E_CLIENT_VERSION_STR;
 static struct i40e_client *registered_client;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.h b/include/linux/net/intel/i40e_client.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40e/i40e_client.h
rename to include/linux/net/intel/i40e_client.h
-- 
2.26.2

