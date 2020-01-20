From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 20 Jan 2020 08:17:58 +0200
Subject: [Intel-wired-lan] [PATCH v2] igc: Fix the typo in comment
Message-ID: <20200120061758.25650-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the typo and comment to correspond to the i225 device
v1->v2:
Address community comment

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 5d38d0faeced..cb1362188c2a 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -112,7 +112,7 @@ extern char igc_driver_version[];
 #define IGC_RX_HDR_LEN			IGC_RXBUFFER_256
 
 /* Transmit and receive latency (for PTP timestamps) */
-/* FIXME: These values were estimated using the ones that i210 has as
+/* FIXME: These values were estimated using the ones that i225 has as
  * basis, they seem to provide good numbers with ptp4l/phc2sys, but we
  * need to confirm them.
  */
-- 
2.11.0

