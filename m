From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  2 Aug 2019 01:25:33 -0700
Subject: [Intel-wired-lan] [PATCH S26 15/15] ice: Cleanup defines in
 ice_type.h
In-Reply-To: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
Message-ID: <20190802082533.23083-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Conventionally, if the #defines/other are not needed by other header
files being included, #includes are done first followed by #defines
and other stuff. Move the #defines before the #includes to follow this
convention.

Suggested by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_type.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index b538d0b9eb80..40b028e73234 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -4,15 +4,15 @@
 #ifndef _ICE_TYPE_H_
 #define _ICE_TYPE_H_
 
+#define ICE_BYTES_PER_WORD	2
+#define ICE_BYTES_PER_DWORD	4
+
 #include "ice_status.h"
 #include "ice_hw_autogen.h"
 #include "ice_osdep.h"
 #include "ice_controlq.h"
 #include "ice_lan_tx_rx.h"
 
-#define ICE_BYTES_PER_WORD	2
-#define ICE_BYTES_PER_DWORD	4
-
 static inline bool ice_is_tc_ena(unsigned long bitmap, u8 tc)
 {
 	return test_bit(tc, &bitmap);
-- 
2.20.1

