From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 13 Feb 2020 13:31:25 -0800
Subject: [Intel-wired-lan] [PATCH S39 v2 11/15] ice: increase PF reset wait
 timeout to 300 milliseconds
In-Reply-To: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
Message-ID: <20200213213129.34023-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Increase the maximum time that the driver will wait for a PF reset from
200 milliseconds to 300 milliseconds, to account for possibility of
a slightly longer than expected PF reset.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index f70e601610fc..6d7d7dbf29fe 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6,7 +6,7 @@
 #include "ice_adminq_cmd.h"
 #include "ice_flow.h"
 
-#define ICE_PF_RESET_WAIT_COUNT	200
+#define ICE_PF_RESET_WAIT_COUNT	300
 
 /**
  * ice_set_mac_type - Sets MAC type
-- 
2.20.1

