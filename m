From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed,  5 Oct 2016 09:30:42 -0700
Subject: [Intel-wired-lan] [next PATCH S49-V2 12/15] i40e: correct check for
	reading TSYNINDX from the receive descriptor
In-Reply-To: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475685046-16900-13-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When hardware has taken a timestamp for a received packet, it indicates
which RXTIME register the timestamp was placed in by some bits in the
receive descriptor. It uses 3 bits, one to indicate if the descriptor
index is valid (ie: there was a timestamp) and 2 bits to indicate which
of the 4 registers to read. However, the driver currently does not check
the TSYNVALID bit and only checks the index. It assumes a zero index
means no timestamp, and a non zero index means a timestamp occurred.
While this appears to be true, it prevents ever reading a timestamp in
RXTIME[0], and causes the first timestamp the device captures to be
ignored.

Fix this by using the TSYNVALID bit correctly as the true indicator of
whether the packet has an associated timestamp.

Also rename the variable rsyn to tsyn as this is more descriptive and
matches the register names.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I4437e8f3a3df2c2ddb458b0fb61420f3dafc4c12
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index daade4fe..c9eb6b8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1410,11 +1410,12 @@ void i40e_process_skb_fields(struct i40e_ring *rx_ring,
 	u64 qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
 	u32 rx_status = (qword & I40E_RXD_QW1_STATUS_MASK) >>
 			I40E_RXD_QW1_STATUS_SHIFT;
-	u32 rsyn = (rx_status & I40E_RXD_QW1_STATUS_TSYNINDX_MASK) >>
+	u32 tsynvalid = rx_status & I40E_RXD_QW1_STATUS_TSYNVALID_MASK;
+	u32 tsyn = (rx_status & I40E_RXD_QW1_STATUS_TSYNINDX_MASK) >>
 		   I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT;
 
-	if (unlikely(rsyn)) {
-		i40e_ptp_rx_hwtstamp(rx_ring->vsi->back, skb, rsyn);
+	if (unlikely(tsynvalid)) {
+		i40e_ptp_rx_hwtstamp(rx_ring->vsi->back, skb, tsyn);
 		rx_ring->last_rx_timestamp = jiffies;
 	}
 
-- 
2.4.11

