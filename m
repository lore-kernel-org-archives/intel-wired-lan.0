From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 14 Oct 2015 09:32:40 -0700
Subject: [Intel-wired-lan] [next-queue v2 06/17] fm10k: Correct typecast in
	fm10k_update_xc_addr_pf
In-Reply-To: <1444840371-17328-1-git-send-email-jacob.e.keller@intel.com>
References: <1444840371-17328-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1444840371-17328-6-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since the resultant data type of the mac_update.mac_upper field is u16,
it does not make sense to typecast u8 variables to u32 first. Since
we're modifying fm10k_pf.c, also update the copyright year.

Reported-by: Matthew Vick <matthew.vick@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 8c0bdc4e4edd..b1e09756a6ef 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1,5 +1,5 @@
 /* Intel Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2014 Intel Corporation.
+ * Copyright(c) 2013 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -334,8 +334,8 @@ static s32 fm10k_update_xc_addr_pf(struct fm10k_hw *hw, u16 glort,
 						 ((u32)mac[3] << 16) |
 						 ((u32)mac[4] << 8) |
 						 ((u32)mac[5]));
-	mac_update.mac_upper = cpu_to_le16(((u32)mac[0] << 8) |
-						 ((u32)mac[1]));
+	mac_update.mac_upper = cpu_to_le16(((u16)mac[0] << 8) |
+					   ((u16)mac[1]));
 	mac_update.vlan = cpu_to_le16(vid);
 	mac_update.glort = cpu_to_le16(glort);
 	mac_update.action = add ? 0 : 1;
-- 
2.6.1.264.gbab76a9

