From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 19 May 2022 18:15:30 -0700
Subject: [Intel-wired-lan] [PATCH net-next v5 03/11] igc: Add support for
 receiving frames with all zeroes address
In-Reply-To: <20220520011538.1098888-1-vinicius.gomes@intel.com>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
Message-ID: <20220520011538.1098888-4-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The frame preemption verification (as defined by IEEE 802.3-2018
Section 99.4.3) handshake is done by the driver, the default
configuration of the driver is to only receive frames with the driver
address.

So, in preparation for that add a second address to the list of
acceptable addresses.

Because the frame preemption "disable verify" toggle only affects the
transmission of verification frames, this needs to always be enabled.
As that address is invalid, the impact in practical scenarios should
be minimal. But still a bummer that we have to do this.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 2 ++
 drivers/net/ethernet/intel/igc/igc_main.c | 7 +++++++
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 1e7e7071f64d..31e7b4c72894 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -622,6 +622,8 @@ struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
 int igc_add_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
 void igc_del_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
 
+int igc_enable_empty_addr_recv(struct igc_adapter *adapter);
+
 void igc_ptp_init(struct igc_adapter *adapter);
 void igc_ptp_reset(struct igc_adapter *adapter);
 void igc_ptp_suspend(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ae17af44fe02..bcbf35b32ef3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3586,6 +3586,13 @@ static int igc_uc_unsync(struct net_device *netdev, const unsigned char *addr)
 	return 0;
 }
 
+int igc_enable_empty_addr_recv(struct igc_adapter *adapter)
+{
+	u8 empty[ETH_ALEN] = { };
+
+	return igc_add_mac_filter(adapter, IGC_MAC_FILTER_TYPE_DST, empty, -1);
+}
+
 /**
  * igc_set_rx_mode - Secondary Unicast, Multicast and Promiscuous mode set
  * @netdev: network interface device structure
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 0fce22de2ab8..270a08196f49 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -235,6 +235,13 @@ int igc_tsn_reset(struct igc_adapter *adapter)
 	unsigned int new_flags;
 	int err = 0;
 
+	/* Frame preemption verification requires that packets with
+	 * the all zeroes MAC address are allowed to be received. Add
+	 * the all zeroes destination address to the list of
+	 * acceptable addresses.
+	 */
+	igc_enable_empty_addr_recv(adapter);
+
 	new_flags = igc_tsn_new_flags(adapter);
 
 	if (!(new_flags & IGC_FLAG_TSN_ANY_ENABLED))
-- 
2.35.3

