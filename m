From: Yury Norov <yury.norov@gmail.com>
Date: Tue, 10 May 2022 08:47:32 -0700
Subject: [Intel-wired-lan] [PATCH 04/22] ice: use bitmap_empty() in
 ice_vf_has_no_qs_ena()
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
Message-ID: <20220510154750.212913-5-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

bitmap_empty() is better than bitmap_weight() because it may return
earlier, and improves on readability.

CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: intel-wired-lan at lists.osuosl.org
CC: netdev at vger.kernel.org
CC: linux-kernel at vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 6578059d9479..de67ac4075f0 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -740,8 +740,8 @@ bool ice_is_vf_trusted(struct ice_vf *vf)
  */
 bool ice_vf_has_no_qs_ena(struct ice_vf *vf)
 {
-	return (!bitmap_weight(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF) &&
-		!bitmap_weight(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF));
+	return bitmap_empty(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF) &&
+	       bitmap_empty(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF);
 }
 
 /**
-- 
2.32.0

