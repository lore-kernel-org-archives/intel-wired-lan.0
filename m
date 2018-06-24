From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 25 Jun 2018 02:13:07 +0800
Subject: [Intel-wired-lan] [RFC PATCH] igc: igc_has_link() can be static
In-Reply-To: <20180624084528.10419-1-sasha.neftin@intel.com>
References: <20180624084528.10419-1-sasha.neftin@intel.com>
Message-ID: <20180624181307.GA66799@lkp-hsx03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: d32b0b485e39 ("igc: Add watchdog")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 igc_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7fb21af..ed27584 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2334,7 +2334,7 @@ static void igc_free_q_vector(struct igc_adapter *adapter, int v_idx)
  *  igc_has_link - check shared code for link and determine up/down
  *  @adapter: pointer to driver private info
  **/
-bool igc_has_link(struct igc_adapter *adapter)
+static bool igc_has_link(struct igc_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	bool link_active = false;
