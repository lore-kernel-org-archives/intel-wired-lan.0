From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 12 Jun 2020 13:47:31 +0200
Subject: [Intel-wired-lan] [PATCH net] i40e: fix crash when Rx descriptor
 count is changed
Message-ID: <20200612114731.144630-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

When the AF_XDP buffer allocator was introduced, the Rx SW ring
"rx_bi" allocation was moved from i40e_setup_rx_descriptors()
function, and was instead done in the i40e_configure_rx_ring()
function.

This broke the ethtool set_ringparam() hook for changing the Rx
descriptor count, which was relying on i40e_setup_rx_descriptors() to
handle the alloction.

Fix this by adding an explicit i40e_alloc_rx_bi() call to
i40e_set_ringparam().

Fixes: be1222b585fd ("i40e: Separate kernel allocated rx_bi rings from AF_XDP rings")
Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index aa8026b1eb81..67806b7b2f49 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2070,6 +2070,9 @@ static int i40e_set_ringparam(struct net_device *netdev,
 			 */
 			rx_rings[i].tail = hw->hw_addr + I40E_PRTGEN_STATUS;
 			err = i40e_setup_rx_descriptors(&rx_rings[i]);
+			if (err)
+				goto rx_unwind;
+			err = i40e_alloc_rx_bi(&rx_rings[i]);
 			if (err)
 				goto rx_unwind;
 

base-commit: 18dbd4cd9b8c957025cf90a3c50102b31bde14f7
-- 
2.25.1

