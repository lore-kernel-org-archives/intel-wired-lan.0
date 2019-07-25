From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Jul 2019 01:55:35 -0700
Subject: [Intel-wired-lan] [PATCH S23 v4 09/15] ice: Do not always bring up
 PF VSI in ice_ena_vsi()
In-Reply-To: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
References: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
Message-ID: <20190725085541.55104-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

During rebuild ice_ena_vsi() is called to recover the VSI state.
This function assumes the PF VSI is always to be enabled, however,
it's possible that during reset/rebuild the interface can be
brought down.  If this occurs, we can attempt to bring up the PF
VSI on a downed interface which can lead to various crashes. If
the interface is not running, do not bring up the associated VSI.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6f02c29d7830..be872336e08e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3737,8 +3737,6 @@ static int ice_ena_vsi(struct ice_vsi *vsi, bool locked)
 				err = netd->netdev_ops->ndo_open(netd);
 				rtnl_unlock();
 			}
-		} else {
-			err = ice_vsi_open(vsi);
 		}
 	}
 
-- 
2.20.1

