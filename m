From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 15 Aug 2019 13:55:20 -0700
Subject: [Intel-wired-lan] [PATCH net 2/2] igb: Fix constant media auto
 sense switching when no cable is connected.
In-Reply-To: <20190815205520.22475-1-jeffrey.t.kirsher@intel.com>
References: <20190815205520.22475-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20190815205520.22475-2-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Manfred Rudigier <manfred.rudigier@omicronenergy.com>

At least on the i350 there is an annoying behavior that is maybe also
present on 82580 devices, but was probably not noticed yet as MAS is not
widely used.

If no cable is connected on both fiber/copper ports the media auto sense
code will constantly swap between them as part of the watchdog task and
produce many unnecessary kernel log messages.

The swap code responsible for this behavior (switching to fiber) should
not be executed if the current media type is copper and there is no signal
detected on the fiber port. In this case we can safely wait until the
AUTOSENSE_EN bit is cleared.

Signed-off-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 95fc1a178ff3..891cd072d4dd 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2064,7 +2064,8 @@ static void igb_check_swap_media(struct igb_adapter *adapter)
 	if ((hw->phy.media_type == e1000_media_type_copper) &&
 	    (!(connsw & E1000_CONNSW_AUTOSENSE_EN))) {
 		swap_now = true;
-	} else if (!(connsw & E1000_CONNSW_SERDESD)) {
+	} else if ((hw->phy.media_type != e1000_media_type_copper) &&
+	    !(connsw & E1000_CONNSW_SERDESD)) {
 		/* copper signal takes time to appear */
 		if (adapter->copper_tries < 4) {
 			adapter->copper_tries++;
