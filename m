From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 10 Jul 2017 13:23:09 -0700
Subject: [Intel-wired-lan] [PATCH v3 06/16] fm10k: simplify reading PFVFLRE
	register
In-Reply-To: <20170710202319.22110-1-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
Message-ID: <20170710202319.22110-6-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We're doing a really convoluted bitshift and read for the PFVFLRE
register. Just reading the PFVFLRE(1), shifting it by 32, then reading
PFVFLRE(0) should be sufficient.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
index d8356c494f06..dfc88a463735 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2016 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -67,10 +67,8 @@ s32 fm10k_iov_event(struct fm10k_intfc *interface)
 
 	/* read VFLRE to determine if any VFs have been reset */
 	do {
-		vflre = fm10k_read_reg(hw, FM10K_PFVFLRE(0));
+		vflre = fm10k_read_reg(hw, FM10K_PFVFLRE(1));
 		vflre <<= 32;
-		vflre |= fm10k_read_reg(hw, FM10K_PFVFLRE(1));
-		vflre = (vflre << 32) | (vflre >> 32);
 		vflre |= fm10k_read_reg(hw, FM10K_PFVFLRE(0));
 
 		i = iov_data->num_vfs;
-- 
2.13.0.615.gb09ed6e59a40

