From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 17 Sep 2020 13:13:47 -0700
Subject: [Intel-wired-lan] [PATCH S53 15/15] ice: Add space to unknown speed
In-Reply-To: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
Message-ID: <20200917201347.81570-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Simon Perron Caissy <simon.perron.caissy@intel.com>

Add space to the end of 'Unknown' string  in  order to avoid
concatenation with 'bps' string when formatting netdev log message.

Signed-off-by: Simon Perron Caissy <simon.perron.caissy@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ac1fc443d9f5..c8ddb24d3e3b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -668,7 +668,7 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 		speed = "100 M";
 		break;
 	default:
-		speed = "Unknown";
+		speed = "Unknown ";
 		break;
 	}
 
-- 
2.20.1

