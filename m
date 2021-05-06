From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 May 2021 08:40:04 -0700
Subject: [Intel-wired-lan] [PATCH S59 09/13] ice: fix incorrect payload
 indicator on PTYPE
In-Reply-To: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
Message-ID: <20210506154008.12880-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The entry for PTYPE 90 indicates that the payload is layer 3. This does
not match the specification in the datasheet which indicates the packet
is a MAC, IPv6, UDP packet, with a payload in layer 4.

Fix the lookup table to match the data sheet.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 2bf4c9605db1..72334a2de64f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -766,7 +766,7 @@ static const struct ice_rx_ptype_decoded ice_ptype_lkup[BIT(10)] = {
 	/* Non Tunneled IPv6 */
 	ICE_PTT(88, IP, IPV6, FRG, NONE, NONE, NOF, NONE, PAY3),
 	ICE_PTT(89, IP, IPV6, NOF, NONE, NONE, NOF, NONE, PAY3),
-	ICE_PTT(90, IP, IPV6, NOF, NONE, NONE, NOF, UDP,  PAY3),
+	ICE_PTT(90, IP, IPV6, NOF, NONE, NONE, NOF, UDP,  PAY4),
 	ICE_PTT_UNUSED_ENTRY(91),
 	ICE_PTT(92, IP, IPV6, NOF, NONE, NONE, NOF, TCP,  PAY4),
 	ICE_PTT(93, IP, IPV6, NOF, NONE, NONE, NOF, SCTP, PAY4),
-- 
2.20.1

