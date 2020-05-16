From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:36:39 -0700
Subject: [Intel-wired-lan] [PATCH S43 10/15] ice: remove unused macro
In-Reply-To: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516003644.4658-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver had an unused define that can be removed.  Found by
compiler -Werror=unused-macros check.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index 93cf70d06fe5..87f91b750d59 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -7,8 +7,6 @@
 #include "ice_dcb_nl.h"
 #include <net/dcbnl.h>
 
-#define ICE_APP_PROT_ID_ROCE	0x8915
-
 /**
  * ice_dcbnl_devreset - perform enough of a ifdown/ifup to sync DCBNL info
  * @netdev: device associated with interface that needs reset
-- 
2.20.1

