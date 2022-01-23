From: Yury Norov <yury.norov@gmail.com>
Date: Sun, 23 Jan 2022 10:38:39 -0800
Subject: [Intel-wired-lan] [PATCH 08/54] net: ethernet: replace
 bitmap_weight with bitmap_empty for intel
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
Message-ID: <20220123183925.1052919-9-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ice_vf_has_no_qs_ena() calls bitmap_weight() to check if any bit
of a given bitmap is set. It's better to use bitmap_empty() in that
case because bitmap_empty() stops traversing the bitmap as soon as it
finds first set bit, while bitmap_weight() counts all bits
unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 39b80124d282..9dd52aab68cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -267,8 +267,8 @@ ice_set_pfe_link(struct ice_vf *vf, struct virtchnl_pf_event *pfe,
  */
 static bool ice_vf_has_no_qs_ena(struct ice_vf *vf)
 {
-	return (!bitmap_weight(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF) &&
-		!bitmap_weight(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF));
+	return (bitmap_empty(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF) &&
+		bitmap_empty(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF));
 }
 
 /**
-- 
2.30.2

