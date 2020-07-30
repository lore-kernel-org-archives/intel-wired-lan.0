From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 29 Jul 2020 17:19:18 -0700
Subject: [Intel-wired-lan] [PATCH S51 09/13] ice: Graceful error handling in
 HW table calloc failure
In-Reply-To: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
Message-ID: <20200730001922.52568-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Surabhi Boob <surabhi.boob@intel.com>

In the ice_init_hw_tbls, if the devm_kcalloc for es->written fails, catch
that error and bail out gracefully, instead of continuing with a NULL
pointer.

Fixes: 32d63fa1e9f3 ("ice: Initialize DDP package structures")
Signed-off-by: Surabhi Boob <surabhi.boob@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index d59869b2c65e..d8ada9675650 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -3152,9 +3152,13 @@ enum ice_status ice_init_hw_tbls(struct ice_hw *hw)
 					     sizeof(*es->ref_count),
 					     GFP_KERNEL);
 
+		if (!es->ref_count)
+			goto err;
+
 		es->written = devm_kcalloc(ice_hw_to_dev(hw), es->count,
 					   sizeof(*es->written), GFP_KERNEL);
-		if (!es->ref_count)
+
+		if (!es->written)
 			goto err;
 	}
 	return 0;
-- 
2.20.1

