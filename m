From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:26:54 -0700
Subject: [Intel-wired-lan] [net-next 04/25] fm10k: Have the VF get the
	default VLAN during init
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-4-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently, the VFs do not read the default VLAN during initialization,
so they will not be able to indicate untagged frames properly.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
index 1721967..94f0f6a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
@@ -1,5 +1,5 @@
 /* Intel Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2014 Intel Corporation.
+ * Copyright(c) 2013 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -124,6 +124,10 @@ static s32 fm10k_init_hw_vf(struct fm10k_hw *hw)
 	/* record maximum queue count */
 	hw->mac.max_queues = i;
 
+	/* fetch default VLAN */
+	hw->mac.default_vid = (fm10k_read_reg(hw, FM10K_TXQCTL(0)) &
+			       FM10K_TXQCTL_VID_MASK) >> FM10K_TXQCTL_VID_SHIFT;
+
 	return 0;
 }
 
-- 
1.9.3

