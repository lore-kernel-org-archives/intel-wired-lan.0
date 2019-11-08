From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  8 Nov 2019 06:23:30 -0800
Subject: [Intel-wired-lan] [PATCH S33 14/15] ice: remove pointless NULL
 check of port_info
In-Reply-To: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
Message-ID: <20191108142331.10221-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The code in ice_sched_cleanup_all checks whether the port info is NULL
prior to calling ice_sched_clear_port. However, ice_sched_clear_port
already checks whether port info is non-NULL.

More importantly, it also checks whether the port structure has been
initialized by checking its port_state field as well.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index b1bdb40a1bee..9c64b5cd0c91 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -798,8 +798,7 @@ void ice_sched_cleanup_all(struct ice_hw *hw)
 		hw->layer_info = NULL;
 	}
 
-	if (hw->port_info)
-		ice_sched_clear_port(hw->port_info);
+	ice_sched_clear_port(hw->port_info);
 
 	hw->num_tx_sched_layers = 0;
 	hw->num_tx_sched_phys_layers = 0;
-- 
2.20.1

