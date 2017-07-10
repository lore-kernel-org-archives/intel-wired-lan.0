From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 10 Jul 2017 13:23:05 -0700
Subject: [Intel-wired-lan] [PATCH v3 02/16] fm10k: fix typos on fall through
	comments
In-Reply-To: <20170710202319.22110-1-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
Message-ID: <20170710202319.22110-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Newer versions of GCC since version 7 now warn when a case statement may
fall through without an explicit comment. "Fallthough" does not count as
it is misspelled. Fix the typos for these comments to appease the new
warnings.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c |  4 ++--
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c  | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
index 334088a101c3..244d3ad58ca7 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2016 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -1586,7 +1586,7 @@ s32 fm10k_pfvf_mbx_init(struct fm10k_hw *hw, struct fm10k_mbx_info *mbx,
 			mbx->mbmem_reg = FM10K_MBMEM_VF(id, 0);
 			break;
 		}
-		/* fallthough */
+		/* fall through */
 	default:
 		return FM10K_MBX_ERR_NO_MBX;
 	}
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 40ee0242a80a..9e4fb3a44376 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2016 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -1334,19 +1334,19 @@ static u8 fm10k_iov_supported_xcast_mode_pf(struct fm10k_vf_info *vf_info,
 	case FM10K_XCAST_MODE_PROMISC:
 		if (vf_flags & FM10K_VF_FLAG_PROMISC_CAPABLE)
 			return FM10K_XCAST_MODE_PROMISC;
-		/* fallthough */
+		/* fall through */
 	case FM10K_XCAST_MODE_ALLMULTI:
 		if (vf_flags & FM10K_VF_FLAG_ALLMULTI_CAPABLE)
 			return FM10K_XCAST_MODE_ALLMULTI;
-		/* fallthough */
+		/* fall through */
 	case FM10K_XCAST_MODE_MULTI:
 		if (vf_flags & FM10K_VF_FLAG_MULTI_CAPABLE)
 			return FM10K_XCAST_MODE_MULTI;
-		/* fallthough */
+		/* fall through */
 	case FM10K_XCAST_MODE_NONE:
 		if (vf_flags & FM10K_VF_FLAG_NONE_CAPABLE)
 			return FM10K_XCAST_MODE_NONE;
-		/* fallthough */
+		/* fall through */
 	default:
 		break;
 	}
-- 
2.13.0.615.gb09ed6e59a40

