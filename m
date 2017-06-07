From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Jun 2017 05:43:05 -0400
Subject: [Intel-wired-lan] [next PATCH S72-V3 05/13] i40e: Fix potential out
	of bound array access
In-Reply-To: <20170607094313.32060-1-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
Message-ID: <20170607094313.32060-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

This is a fix for the static code analysis issue where dcbcfg->numapps
could be greater than size of array (i.e dcbcfg->app[I40E_DCBX_MAX_APPS]).
The fix makes sure that the array is not accessed past the size of
of the array (i.e. I40E_DCBX_MAX_APPS).

Copyright updated to 2017.

Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 0fab3a9..bf1d67e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
- * Copyright(c) 2013 - 2014 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -390,6 +390,8 @@ static void i40e_parse_cee_app_tlv(struct i40e_cee_feat_tlv *tlv,
 
 	if (!dcbcfg->numapps)
 		return;
+	if (dcbcfg->numapps > I40E_DCBX_MAX_APPS)
+		dcbcfg->numapps = I40E_DCBX_MAX_APPS;
 
 	for (i = 0; i < dcbcfg->numapps; i++) {
 		u8 up, selector;
-- 
2.9.3

