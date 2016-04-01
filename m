From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  1 Apr 2016 16:17:36 -0700
Subject: [Intel-wired-lan] [PATCH v1 6/9] fm10k: use 8bit notation instead
	of 10bit notation for diagram
In-Reply-To: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
References: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1459552659-22959-7-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The diagram represents bit layout of the multi-bit VLAN update message
format. Typically these diagrams are drawn using some power of 2 as the
base, to more easily grasp where fields split. Although the numbers
above can make it somewhat easy to understand which bit you're looking
at, it makes the break points not line up. Re-draw the numbers using
base 8, and mark the bit values every 8 bits at the top. This should
make it more easy to grasp the table quickly.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 865f5c2da9d0..ffe98056755b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -219,8 +219,8 @@ static s32 fm10k_update_vlan_pf(struct fm10k_hw *hw, u32 vid, u8 vsi, bool set)
 
 	/* VLAN multi-bit write:
 	 * The multi-bit write has several parts to it.
-	 *    3			  2		      1			  0
-	 *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+	 *               24              16               8               0
+	 *  7 6 5 4 3 2 1 0 7 6 5 4 3 2 1 0 7 6 5 4 3 2 1 0 7 6 5 4 3 2 1 0
 	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 	 * | RSVD0 |         Length        |C|RSVD0|        VLAN ID        |
 	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
-- 
2.8.0.rc1.177.g5628860

