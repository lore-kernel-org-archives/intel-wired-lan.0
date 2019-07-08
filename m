From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:30 -0700
Subject: [Intel-wired-lan] [PATCH 13/19] fm10k: remove needless assignment
 of err local variable
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-14-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The local variable err in several functions in the fm10k_netdev.c file
is initialized with a value that is never used. The err value is
immediately re-assigned in all cases where it will be checked. Remove
the unnecessary initializers.

This was detected by cppcheck and resolves the following warnings
produced by that tool:

[fm10k_netdev.c:999] -> [fm10k_netdev.c:1004]: (style) Variable 'err' is
reassigned a value before the old one has been used.

[fm10k_netdev.c:1019] -> [fm10k_netdev.c:1024]: (style) Variable 'err'
is reassigned a value before the old one has been used.

[fm10k_netdev.c:64]: (style) Variable 'err' is assigned a value that is
never used.

[fm10k_netdev.c:131]: (style) Variable 'err' is assigned a value that
is never used.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 259da075093f..4704395c0f66 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2013 - 2018 Intel Corporation. */
+/* Copyright(c) 2013 - 2019 Intel Corporation. */
 
 #include "fm10k.h"
 #include <linux/vmalloc.h>
@@ -54,7 +54,7 @@ int fm10k_setup_tx_resources(struct fm10k_ring *tx_ring)
  **/
 static int fm10k_setup_all_tx_resources(struct fm10k_intfc *interface)
 {
-	int i, err = 0;
+	int i, err;
 
 	for (i = 0; i < interface->num_tx_queues; i++) {
 		err = fm10k_setup_tx_resources(interface->tx_ring[i]);
@@ -121,7 +121,7 @@ int fm10k_setup_rx_resources(struct fm10k_ring *rx_ring)
  **/
 static int fm10k_setup_all_rx_resources(struct fm10k_intfc *interface)
 {
-	int i, err = 0;
+	int i, err;
 
 	for (i = 0; i < interface->num_rx_queues; i++) {
 		err = fm10k_setup_rx_resources(interface->rx_ring[i]);
@@ -871,7 +871,7 @@ static int fm10k_uc_vlan_unsync(struct net_device *netdev,
 	u16 glort = interface->glort;
 	u16 vid = interface->vid;
 	bool set = !!(vid / VLAN_N_VID);
-	int err = -EHOSTDOWN;
+	int err;
 
 	/* drop any leading bits on the VLAN ID */
 	vid &= VLAN_N_VID - 1;
@@ -891,7 +891,7 @@ static int fm10k_mc_vlan_unsync(struct net_device *netdev,
 	u16 glort = interface->glort;
 	u16 vid = interface->vid;
 	bool set = !!(vid / VLAN_N_VID);
-	int err = -EHOSTDOWN;
+	int err;
 
 	/* drop any leading bits on the VLAN ID */
 	vid &= VLAN_N_VID - 1;
-- 
2.22.0.214.g8dca754b1e87

