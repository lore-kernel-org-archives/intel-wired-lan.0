From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Tue, 7 Aug 2018 18:22:57 -0500
Subject: [Intel-wired-lan] [PATCH 20/33] igb: e1000_82575: Mark expected
 switch fall-through
In-Reply-To: <cover.1533675546.git.gustavo@embeddedor.com>
References: <cover.1533675546.git.gustavo@embeddedor.com>
Message-ID: <2f4b0d4e33bc5701126a453b2a28e601bab7a858.1533675546.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114799 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index a795c07..bafdcf7 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -1708,6 +1708,7 @@ static s32 igb_setup_serdes_link_82575(struct e1000_hw *hw)
 	case E1000_CTRL_EXT_LINK_MODE_1000BASE_KX:
 		/* disable PCS autoneg and support parallel detect only */
 		pcs_autoneg = false;
+		/* fall through */
 	default:
 		if (hw->mac.type == e1000_82575 ||
 		    hw->mac.type == e1000_82576) {
-- 
2.7.4

