From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 25 Mar 2021 17:38:30 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 07/11] igb: override two
 checker warnings
In-Reply-To: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
Message-ID: <20210326003834.3886241-8-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The igb PTP code was using htons() on a constant to try to
byte swap the value before writing it to a register. This byte
swap has the consequence of triggering sparse conflicts between
the register write which expect cpu ordered input, and the code
which generated a big endian constant. Just override the cast
to make sure code doesn't change but silence the warning.

Can't do a __swab16 in this case because big endian systems
would then write the wrong value.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
Warning Detail
  CHECK   .../igb/igb_ptp.c
.../igb/igb_ptp.c:1137:17: warning: incorrect type in argument 1 (different base types)
.../igb/igb_ptp.c:1137:17:    expected unsigned int val
.../igb/igb_ptp.c:1137:17:    got restricted __be16 [usertype]
.../igb/igb_ptp.c:1142:25: warning: incorrect type in argument 1 (different base types)
.../igb/igb_ptp.c:1142:25:    expected unsigned int val
.../igb/igb_ptp.c:1142:25:    got restricted __be16 [usertype]
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index ba61fe9bfaf4..de08ae8db4d5 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1134,12 +1134,12 @@ static int igb_ptp_set_timestamp_mode(struct igb_adapter *adapter,
 			| E1000_FTQF_MASK); /* mask all inputs */
 		ftqf &= ~E1000_FTQF_MASK_PROTO_BP; /* enable protocol check */
 
-		wr32(E1000_IMIR(3), htons(PTP_EV_PORT));
+		wr32(E1000_IMIR(3), (__force unsigned int)htons(PTP_EV_PORT));
 		wr32(E1000_IMIREXT(3),
 		     (E1000_IMIREXT_SIZE_BP | E1000_IMIREXT_CTRL_BP));
 		if (hw->mac.type == e1000_82576) {
 			/* enable source port check */
-			wr32(E1000_SPQF(3), htons(PTP_EV_PORT));
+			wr32(E1000_SPQF(3), (__force unsigned int)htons(PTP_EV_PORT));
 			ftqf &= ~E1000_FTQF_MASK_SOURCE_PORT_BP;
 		}
 		wr32(E1000_FTQF(3), ftqf);
-- 
2.30.2

