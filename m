From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Fri, 20 Nov 2020 12:28:43 -0600
Subject: [Intel-wired-lan] [PATCH 033/141] fm10k: Fix fall-through warnings
 for Clang
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
Message-ID: <d5e3348c525d15d655f14f4f2321edbbada51cd3.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding a couple of break statements instead of
just letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
index 8e2e92bf3cd4..3e970e20695d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -1039,6 +1039,7 @@ static s32 fm10k_mbx_create_reply(struct fm10k_hw *hw,
 	case FM10K_STATE_CLOSED:
 		/* generate new header based on data */
 		fm10k_mbx_create_disconnect_hdr(mbx);
+		break;
 	default:
 		break;
 	}
@@ -2017,6 +2018,7 @@ static s32 fm10k_sm_mbx_process_reset(struct fm10k_hw *hw,
 	case FM10K_STATE_CONNECT:
 		/* Update remote value to match local value */
 		mbx->remote = mbx->local;
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

