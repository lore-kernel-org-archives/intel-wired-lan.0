From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 27 Apr 2015 14:57:16 -0400
Subject: [Intel-wired-lan] [net-next S5 09/15] i40evf: don't delete all the
	filters
In-Reply-To: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1430161042-28494-10-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Due to an inverted conditional, the driver was marking all of its MAC
filters for deletion every time set_rx_mode was called. Depending upon
the timing of the calls to set_rx_mode and the processing of the admin
queue, the driver would (accidentally) end up with a varying number of
functional filters.

Correct this logic so that MAC filters are added and removed correctly.
Add a check for the driver's "hardware" MAC address so that this filter
doesn't get removed incorrectly.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ib3e7c4a5b53df6835f164fe44cb778cb71f8aff8
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 23a81da..a519c05 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -891,8 +891,10 @@ static void i40evf_set_rx_mode(struct net_device *netdev)
 					break;
 				}
 			}
+			if (ether_addr_equal(f->macaddr, adapter->hw.mac.addr))
+					found = true;
 		}
-		if (found) {
+		if (!found) {
 			f->remove = true;
 			adapter->aq_required |= I40EVF_FLAG_AQ_DEL_MAC_FILTER;
 		}
-- 
1.9.3

