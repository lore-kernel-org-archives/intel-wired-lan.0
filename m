From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 10 Jul 2017 13:23:07 -0700
Subject: [Intel-wired-lan] [PATCH v3 04/16] fm10k: add missing fall through
	comment
In-Reply-To: <20170710202319.22110-1-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
Message-ID: <20170710202319.22110-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Newer versions of GCC starting with 7 now additionally warn when a case
statement may fall through without an explicit comment mentioning it.
Add such a comment to silence the warning, as this is expected.

Unfortunately the comment must come directly before the next case
statement, so we put it outside the #ifdef. Otherwise, the compiler
cannot properly detect it and thus the warning is displayed regardless.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 9dffaba85ae6..189d52a8a605 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -876,6 +876,7 @@ static void fm10k_tx_csum(struct fm10k_ring *tx_ring,
 	case IPPROTO_GRE:
 		if (skb->encapsulation)
 			break;
+		/* fall through */
 	default:
 		if (unlikely(net_ratelimit())) {
 			dev_warn(tx_ring->dev,
-- 
2.13.0.615.gb09ed6e59a40

