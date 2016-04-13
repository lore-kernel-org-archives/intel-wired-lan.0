From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 13 Apr 2016 16:08:30 -0700
Subject: [Intel-wired-lan] [PATCH v2 09/13] igbvf: remove unused variable
	and dead code
In-Reply-To: <1460588914-20143-1-git-send-email-jacob.e.keller@intel.com>
References: <1460588914-20143-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1460588914-20143-10-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The variable rdlen is set but never used, and thus setting it is dead
code. Remove it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index c12442252adb..78af4c7716d3 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1367,7 +1367,7 @@ static void igbvf_configure_rx(struct igbvf_adapter *adapter)
 	struct e1000_hw *hw = &adapter->hw;
 	struct igbvf_ring *rx_ring = adapter->rx_ring;
 	u64 rdba;
-	u32 rdlen, rxdctl;
+	u32 rxdctl;
 
 	/* disable receives */
 	rxdctl = er32(RXDCTL(0));
@@ -1375,8 +1375,6 @@ static void igbvf_configure_rx(struct igbvf_adapter *adapter)
 	e1e_flush();
 	msleep(10);
 
-	rdlen = rx_ring->count * sizeof(union e1000_adv_rx_desc);
-
 	/* Setup the HW Rx Head and Tail Descriptor Pointers and
 	 * the Base and Length of the Rx Descriptor Ring
 	 */
-- 
2.8.1.102.ga49ec4a

