From: Tom Seewald <tseewald@gmail.com>
Date: Sun, 21 Feb 2021 22:00:05 -0600
Subject: [Intel-wired-lan] [PATCH net 2/2] igb: Fix duplicate include guard
In-Reply-To: <20210222040005.20126-1-tseewald@gmail.com>
References: <20210222040005.20126-1-tseewald@gmail.com>
Message-ID: <20210222040005.20126-2-tseewald@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The include guard "_E1000_HW_H_" is used by two separate header files in
two different drivers (e1000/e1000_hw.h and igb/e1000_hw.h). Using the
same include guard macro in more than one header file may cause
unexpected behavior from the compiler. Fix this by renaming the
duplicate guard in the igb driver.

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Signed-off-by: Tom Seewald <tseewald@gmail.com>
---
 drivers/net/ethernet/intel/igb/e1000_hw.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_hw.h b/drivers/net/ethernet/intel/igb/e1000_hw.h
index 5d87957b2627..44111f65afc7 100644
--- a/drivers/net/ethernet/intel/igb/e1000_hw.h
+++ b/drivers/net/ethernet/intel/igb/e1000_hw.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright(c) 2007 - 2018 Intel Corporation. */
 
-#ifndef _E1000_HW_H_
-#define _E1000_HW_H_
+#ifndef _E1000_IGB_HW_H_
+#define _E1000_IGB_HW_H_
 
 #include <linux/types.h>
 #include <linux/delay.h>
@@ -551,4 +551,4 @@ s32 igb_write_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value);
 
 void igb_read_pci_cfg(struct e1000_hw *hw, u32 reg, u16 *value);
 void igb_write_pci_cfg(struct e1000_hw *hw, u32 reg, u16 *value);
-#endif /* _E1000_HW_H_ */
+#endif /* _E1000_IGB_HW_H_ */
-- 
2.20.1

