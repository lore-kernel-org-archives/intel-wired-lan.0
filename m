From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  5 Oct 2018 09:33:55 -0700
Subject: [Intel-wired-lan] [net-next 1/2] ixgbevf: add support for software
 timestamps
Message-ID: <20181005163356.23996-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a call to skb_tx_timestamp in the ixgbevf_tx_map function. This
enables software timestamping for packets sent over this device driver.
The call is placed just prior to when we notify hardware of the new
packet, in order to software timestamp as close as possible to when the
hardware will transmit.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 98707ee11d72..d8ebd75bf41e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4016,6 +4016,8 @@ static void ixgbevf_tx_map(struct ixgbevf_ring *tx_ring,
 	/* set the timestamp */
 	first->time_stamp = jiffies;
 
+	skb_tx_timestamp(skb);
+
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.  (Only applicable for weak-ordered
 	 * memory model archs, such as IA-64).
-- 
2.18.0.219.gaf81d287a9da

