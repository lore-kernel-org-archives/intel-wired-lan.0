From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Jul 2019 02:54:01 -0700
Subject: [Intel-wired-lan] [PATCH S25 12/12] ice: fix ice_is_tc_ena
In-Reply-To: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
Message-ID: <20190725095401.24590-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

ice_is_tc_ena is used to check whether a given traffic class is
enabled. Because there are only 8 traffic classes, the function took
a u8 bitmap. This causes problems because it is cast to an unsigned
long causing a static analysis warning regarding Out-of-bounds read.

Fix this by simply updating ice_is_tc_ena to take an unsigned long.
Passing a u8 to this function should implicitly convert the value.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_type.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index d76e0cb7ef46..b538d0b9eb80 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -13,9 +13,9 @@
 #define ICE_BYTES_PER_WORD	2
 #define ICE_BYTES_PER_DWORD	4
 
-static inline bool ice_is_tc_ena(u8 bitmap, u8 tc)
+static inline bool ice_is_tc_ena(unsigned long bitmap, u8 tc)
 {
-	return test_bit(tc, (unsigned long *)&bitmap);
+	return test_bit(tc, &bitmap);
 }
 
 /* Driver always calls main vsi_handle first */
-- 
2.20.1

