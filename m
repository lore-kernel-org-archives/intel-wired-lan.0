From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed, 13 Jan 2016 16:51:47 -0800
Subject: [Intel-wired-lan] [v2 next PATCH S27 10/15] i40e: dump descriptor
	indexes in hex
In-Reply-To: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452732712-12248-11-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The debugging helpers for showing descriptor rings were
dumping the indexes in decimal and the offsets in hex.

Put everything in hex and at least be consistent.

Also update copyright year in file header.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Ia35a21411a2ddb713772dffb4e8718889fcfc895
---
Testing Hints: echo dump desc rx <vsi> 0 > command

 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 3948587..fcae3c8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
- * Copyright(c) 2013 - 2014 Intel Corporation.
+ * Copyright(c) 2013 - 2016 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -825,20 +825,20 @@ static void i40e_dbg_dump_desc(int cnt, int vsi_seid, int ring_id, int desc_n,
 			if (!is_rx_ring) {
 				txd = I40E_TX_DESC(ring, i);
 				dev_info(&pf->pdev->dev,
-					 "   d[%03i] = 0x%016llx 0x%016llx\n",
+					 "   d[%03x] = 0x%016llx 0x%016llx\n",
 					 i, txd->buffer_addr,
 					 txd->cmd_type_offset_bsz);
 			} else if (sizeof(union i40e_rx_desc) ==
 				   sizeof(union i40e_16byte_rx_desc)) {
 				rxd = I40E_RX_DESC(ring, i);
 				dev_info(&pf->pdev->dev,
-					 "   d[%03i] = 0x%016llx 0x%016llx\n",
+					 "   d[%03x] = 0x%016llx 0x%016llx\n",
 					 i, rxd->read.pkt_addr,
 					 rxd->read.hdr_addr);
 			} else {
 				rxd = I40E_RX_DESC(ring, i);
 				dev_info(&pf->pdev->dev,
-					 "   d[%03i] = 0x%016llx 0x%016llx 0x%016llx 0x%016llx\n",
+					 "   d[%03x] = 0x%016llx 0x%016llx 0x%016llx 0x%016llx\n",
 					 i, rxd->read.pkt_addr,
 					 rxd->read.hdr_addr,
 					 rxd->read.rsvd1, rxd->read.rsvd2);
@@ -853,20 +853,20 @@ static void i40e_dbg_dump_desc(int cnt, int vsi_seid, int ring_id, int desc_n,
 		if (!is_rx_ring) {
 			txd = I40E_TX_DESC(ring, desc_n);
 			dev_info(&pf->pdev->dev,
-				 "vsi = %02i tx ring = %02i d[%03i] = 0x%016llx 0x%016llx\n",
+				 "vsi = %02i tx ring = %02i d[%03x] = 0x%016llx 0x%016llx\n",
 				 vsi_seid, ring_id, desc_n,
 				 txd->buffer_addr, txd->cmd_type_offset_bsz);
 		} else if (sizeof(union i40e_rx_desc) ==
 			   sizeof(union i40e_16byte_rx_desc)) {
 			rxd = I40E_RX_DESC(ring, desc_n);
 			dev_info(&pf->pdev->dev,
-				 "vsi = %02i rx ring = %02i d[%03i] = 0x%016llx 0x%016llx\n",
+				 "vsi = %02i rx ring = %02i d[%03x] = 0x%016llx 0x%016llx\n",
 				 vsi_seid, ring_id, desc_n,
 				 rxd->read.pkt_addr, rxd->read.hdr_addr);
 		} else {
 			rxd = I40E_RX_DESC(ring, desc_n);
 			dev_info(&pf->pdev->dev,
-				 "vsi = %02i rx ring = %02i d[%03i] = 0x%016llx 0x%016llx 0x%016llx 0x%016llx\n",
+				 "vsi = %02i rx ring = %02i d[%03x] = 0x%016llx 0x%016llx 0x%016llx 0x%016llx\n",
 				 vsi_seid, ring_id, desc_n,
 				 rxd->read.pkt_addr, rxd->read.hdr_addr,
 				 rxd->read.rsvd1, rxd->read.rsvd2);
-- 
2.1.0

