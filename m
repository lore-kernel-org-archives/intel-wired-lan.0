From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:42 -0700
Subject: [Intel-wired-lan] [next PATCH S37 12/15] i40evf: always activate
	correct MAC address filter
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-13-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Always add MAC address at the tail of the MAC filter list. Since the
device's "real" MAC address is added first, it will always be at the
beginning of the list. This prevents an issue where the "real" MAC
filter might not get added if too many other filters are added before
bringing the interface up.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I34a8aeebeb0cb87a44b24118adc4176c7b943c1c
---
Testing Hints : Add a lot of MAC filters before bringing the interface
up. Ensure it still works on the base MAC address.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index ae67be4..41581ad 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -825,7 +825,7 @@ i40evf_mac_filter *i40evf_add_filter(struct i40evf_adapter *adapter,
 
 		ether_addr_copy(f->macaddr, macaddr);
 
-		list_add(&f->list, &adapter->mac_filter_list);
+		list_add_tail(&f->list, &adapter->mac_filter_list);
 		f->add = true;
 		adapter->aq_required |= I40EVF_FLAG_AQ_ADD_MAC_FILTER;
 	}
-- 
2.4.11

