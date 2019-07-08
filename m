From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:18 -0700
Subject: [Intel-wired-lan] [PATCH 01/19] fm10k: reduce scope of the err
 variable
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reduce the scope of the err local variable in the fm10k_dcbnl_ieee_setets
function.

This was detected using cppcheck, and resolves the following style
warning:

[fm10k_dcbnl.c:37]: (style) The scope of the variable 'err' can be reduced.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c b/drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c
index 20768ac7f17e..c45315472245 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2013 - 2018 Intel Corporation. */
+/* Copyright(c) 2013 - 2019 Intel Corporation. */
 
 #include "fm10k.h"
 
@@ -36,7 +36,7 @@ static int fm10k_dcbnl_ieee_getets(struct net_device *dev, struct ieee_ets *ets)
 static int fm10k_dcbnl_ieee_setets(struct net_device *dev, struct ieee_ets *ets)
 {
 	u8 num_tc = 0;
-	int i, err;
+	int i;
 
 	/* verify type and determine num_tcs needed */
 	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
@@ -57,7 +57,7 @@ static int fm10k_dcbnl_ieee_setets(struct net_device *dev, struct ieee_ets *ets)
 
 	/* update TC hardware mapping if necessary */
 	if (num_tc != netdev_get_num_tc(dev)) {
-		err = fm10k_setup_tc(dev, num_tc);
+		int err = fm10k_setup_tc(dev, num_tc);
 		if (err)
 			return err;
 	}
-- 
2.22.0.214.g8dca754b1e87

