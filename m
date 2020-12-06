From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun,  6 Dec 2020 14:07:00 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add Host Good Packets
 Transmitted Count
Message-ID: <20201206120700.3767534-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This counter counts the number of good (non-erred) packets
transmitted sent by the host.
A good transmit packet is considered one that is 64 or more bytes
in length (from <Destination Address> through <CRC>,
inclusively) in length

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 705bb89aded7..8913c7f7be7f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3949,6 +3949,7 @@ void igc_update_stats(struct igc_adapter *adapter)
 	adapter->stats.prc1522 += rd32(IGC_PRC1522);
 	adapter->stats.tlpic += rd32(IGC_TLPIC);
 	adapter->stats.rlpic += rd32(IGC_RLPIC);
+	adapter->stats.hgptc += rd32(IGC_HGPTC);
 
 	mpc = rd32(IGC_MPC);
 	adapter->stats.mpc += mpc;
-- 
2.25.1

