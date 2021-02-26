From: Jithu Joseph <jithu.joseph@intel.com>
Date: Thu, 25 Feb 2021 16:23:00 -0800
Subject: [Intel-wired-lan] [PATCH v5 1/9] igc: Move igc_xdp_is_enabled()
In-Reply-To: <20210226002308.2348-1-jithu.joseph@intel.com>
References: <20210226002308.2348-1-jithu.joseph@intel.com>
Message-ID: <20210226002308.2348-2-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Andre Guedes <andre.guedes@intel.com>

Move the helper igc_xdp_is_enabled() to igc_xdp.h so it can be reused in
igc_xdp.c by upcoming patches that will introduce AF_XDP zero-copy
support to the driver.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 5 -----
 drivers/net/ethernet/intel/igc/igc_xdp.h  | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1b497d3c952c..a659e6f24886 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -515,11 +515,6 @@ static int igc_setup_all_rx_resources(struct igc_adapter *adapter)
 	return err;
 }
 
-static bool igc_xdp_is_enabled(struct igc_adapter *adapter)
-{
-	return !!adapter->xdp_prog;
-}
-
 /**
  * igc_configure_rx_ring - Configure a receive ring after Reset
  * @adapter: board private structure
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.h b/drivers/net/ethernet/intel/igc/igc_xdp.h
index cfecb515b718..412aa369e6ba 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.h
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.h
@@ -10,4 +10,9 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 int igc_xdp_register_rxq_info(struct igc_ring *ring);
 void igc_xdp_unregister_rxq_info(struct igc_ring *ring);
 
+static inline bool igc_xdp_is_enabled(struct igc_adapter *adapter)
+{
+	return !!adapter->xdp_prog;
+}
+
 #endif /* _IGC_XDP_H_ */
-- 
2.17.1

