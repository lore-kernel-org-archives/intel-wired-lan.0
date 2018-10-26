From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 11:44:42 -0700
Subject: [Intel-wired-lan] [PATCH S9 10/15] ice: Constify global structures
 that can/should be
In-Reply-To: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026184447.13547-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Indicate these structs should not be modified and take advantage of some
compiler optimizations by making these structs const.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 4d3e3113741d..990d660f527a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -62,7 +62,7 @@ static const struct ice_stats ice_gstrings_vsi_stats[] = {
  * The PF_STATs are appended to the netdev stats only when ethtool -S
  * is queried on the base PF netdev.
  */
-static struct ice_stats ice_gstrings_pf_stats[] = {
+static const struct ice_stats ice_gstrings_pf_stats[] = {
 	ICE_PF_STAT("tx_bytes", stats.eth.tx_bytes),
 	ICE_PF_STAT("rx_bytes", stats.eth.rx_bytes),
 	ICE_PF_STAT("tx_unicast", stats.eth.tx_unicast),
@@ -104,7 +104,7 @@ static struct ice_stats ice_gstrings_pf_stats[] = {
 	ICE_PF_STAT("mac_remote_faults", stats.mac_remote_faults),
 };
 
-static u32 ice_regs_dump_list[] = {
+static const u32 ice_regs_dump_list[] = {
 	PFGEN_STATE,
 	PRTGEN_STATUS,
 	QRX_CTRL(0),
-- 
2.14.3

