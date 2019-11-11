From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 11 Nov 2019 09:04:12 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Fix the parameter description for
 igc_alloc_rx_buffers
Message-ID: <20191111070412.8845-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The function description for igc_alloc_rx_buffers has not reflected
the function meaning. Add meaningful description.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ac420a9b4d2b..833770fd16d2 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1566,7 +1566,8 @@ static void igc_put_rx_buffer(struct igc_ring *rx_ring,
 
 /**
  * igc_alloc_rx_buffers - Replace used receive buffers; packet split
- * @adapter: address of board private structure
+ * @rx_ring: rx descriptor ring
+ * @cleaned_count: number of buffers to clean
  */
 static void igc_alloc_rx_buffers(struct igc_ring *rx_ring, u16 cleaned_count)
 {
-- 
2.11.0

