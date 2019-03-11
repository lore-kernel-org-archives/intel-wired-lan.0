From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 12 Mar 2019 00:34:35 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix the typo in igc_base.h
 header definition
Message-ID: <20190311223435.6909-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the underline for the _IGC_BASE_H_.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
index 76d4991d7284..58d1109d7f3f 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.h
+++ b/drivers/net/ethernet/intel/igc/igc_base.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c)  2018 Intel Corporation */
 
-#ifndef _IGC_BASE_H
-#define _IGC_BASE_H
+#ifndef _IGC_BASE_H_
+#define _IGC_BASE_H_
 
 /* forward declaration */
 void igc_rx_fifo_flush_base(struct igc_hw *hw);
-- 
2.11.0

