From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 27 Feb 2021 10:58:58 +0100
Subject: [Intel-wired-lan] [PATCH] e1000e: use proper #include guard name in
 hw.h
Message-ID: <20210227095858.604463-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The include guard for the e1000e and e1000 hw.h files are the same, so
add the proper "E" term to the hw.h file for the e1000e driver.

This resolves some static analyzer warnings, like the one found by the
"lgtm.com" tool.

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: intel-wired-lan at lists.osuosl.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/hw.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index 69a2329ea463..f7954cadd979 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright(c) 1999 - 2018 Intel Corporation. */
 
-#ifndef _E1000_HW_H_
-#define _E1000_HW_H_
+#ifndef _E1000E_HW_H_
+#define _E1000E_HW_H_
 
 #include "regs.h"
 #include "defines.h"
-- 
2.30.1

