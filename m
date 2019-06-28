From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 28 Jun 2019 08:03:27 -0700
Subject: [Intel-wired-lan] [PATCH S23 v2 09/15] ice: Do not always bring up
 PF VSI in ice_ena_vsi()
In-Reply-To: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
Message-ID: <20190628150332.59155-9-anthony.l.nguyen@intel.com>
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
index e6f092ae119e..e4dfde18e78d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4059,8 +4059,6 @@ static int ice_ena_vsi(struct ice_vsi *vsi, bool locked)
 				err = netd->netdev_ops->ndo_open(netd);
 				rtnl_unlock();
 			}
-		} else {
-			err = ice_vsi_open(vsi);
 		}
 	}
 
-- 
2.20.1

