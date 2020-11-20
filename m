From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Fri, 20 Nov 2020 12:28:18 -0600
Subject: [Intel-wired-lan] [PATCH 029/141] e1000: Fix fall-through warnings
 for Clang
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
Message-ID: <ea9567cc53425566b874484143c4b44619b17ae7.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of just letting the code
fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/e1000/e1000_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 4c0c9433bd60..19cf36360933 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -1183,6 +1183,7 @@ static s32 e1000_copper_link_igp_setup(struct e1000_hw *hw)
 			break;
 		case e1000_ms_auto:
 			phy_data &= ~CR_1000T_MS_ENABLE;
+			break;
 		default:
 			break;
 		}
-- 
2.27.0

