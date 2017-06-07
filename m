From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Jun 2017 05:43:04 -0400
Subject: [Intel-wired-lan] [next PATCH S72-V3 04/13] i40e: comment that
	udp_port must be in host byte order
In-Reply-To: <20170607094313.32060-1-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
Message-ID: <20170607094313.32060-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The firmware expects the port number passed when setting up
the UDP tunnel configuration to be in Little Endian format.
The i40e_aq_add_udp_tunnel command byte swaps the value from
host order to Little Endian.

Since commit fe0b0cd97b4f ("i40e: send correct port number to
AdminQ when enabling UDP tunnels") we've correctly
sent the value in host order.

Let's also add a comment to the function explaining that it must
be in host order, as the port numbers are commonly stored as Big
Endian values.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index cbad4eb..8e082a9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -3614,11 +3614,15 @@ i40e_status i40e_aq_get_cee_dcb_config(struct i40e_hw *hw,
 /**
  * i40e_aq_add_udp_tunnel
  * @hw: pointer to the hw struct
- * @udp_port: the UDP port to add
+ * @udp_port: the UDP port to add in Host byte order
  * @header_len: length of the tunneling header length in DWords
  * @protocol_index: protocol index type
  * @filter_index: pointer to filter index
  * @cmd_details: pointer to command details structure or NULL
+ *
+ * Note: Firmware expects the udp_port value to be in Little Endian format,
+ * and this function will call cpu_to_le16 to convert from Host byte order to
+ * Little Endian order.
  **/
 i40e_status i40e_aq_add_udp_tunnel(struct i40e_hw *hw,
 				u16 udp_port, u8 protocol_index,
-- 
2.9.3

