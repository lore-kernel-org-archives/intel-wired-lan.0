From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Mon, 14 Mar 2016 11:05:40 -0700
Subject: [Intel-wired-lan] [PATCH V2 1/5] ixgbe: Delete some unused register
	definitions
In-Reply-To: <20160314180316.8397.65394.stgit@mdrustad-wks.jf.intel.com>
References: <20160314180316.8397.65394.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160314180540.8397.68119.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I noticed the SRAMREL registers are not referenced for any device,
so delete the definitions.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index bc012ab48475..d02a0a3fa1d8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -143,13 +143,6 @@
 #define IXGBE_GRC_X550EM_a	0x15F64
 #define IXGBE_GRC(_hw)		IXGBE_BY_MAC((_hw), GRC)
 
-#define IXGBE_SRAMREL_8259X	0x10210
-#define IXGBE_SRAMREL_X540	IXGBE_SRAMREL_8259X
-#define IXGBE_SRAMREL_X550	IXGBE_SRAMREL_8259X
-#define IXGBE_SRAMREL_X550EM_x	IXGBE_SRAMREL_8259X
-#define IXGBE_SRAMREL_X550EM_a	0x15F6C
-#define IXGBE_SRAMREL(_hw)	IXGBE_BY_MAC((_hw), SRAMREL)
-
 /* General Receive Control */
 #define IXGBE_GRC_MNG  0x00000001 /* Manageability Enable */
 #define IXGBE_GRC_APME 0x00000002 /* APM enabled in EEPROM */
@@ -2948,7 +2941,6 @@ union ixgbe_atr_hash_dword {
 	IXGBE_CAT(EEC, m),		\
 	IXGBE_CAT(FLA, m),		\
 	IXGBE_CAT(GRC, m),		\
-	IXGBE_CAT(SRAMREL, m),		\
 	IXGBE_CAT(FACTPS, m),		\
 	IXGBE_CAT(SWSM, m),		\
 	IXGBE_CAT(SWFW_SYNC, m),	\

