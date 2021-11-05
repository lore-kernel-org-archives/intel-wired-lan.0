From: Maciej Machnikowski <maciej.machnikowski@intel.com>
Date: Fri,  5 Nov 2021 21:53:31 +0100
Subject: [Intel-wired-lan] [PATCH v2 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <20211105205331.2024623-1-maciej.machnikowski@intel.com>
References: <20211105205331.2024623-1-maciej.machnikowski@intel.com>
Message-ID: <20211105205331.2024623-7-maciej.machnikowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add Documentation/networking/synce.rst describing new RTNL messages
and respective NDO ops supporting SyncE (Synchronous Ethernet).

Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
---
 Documentation/networking/synce.rst | 117 +++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/networking/synce.rst

diff --git a/Documentation/networking/synce.rst b/Documentation/networking/synce.rst
new file mode 100644
index 000000000000..4ca41fb9a481
--- /dev/null
+++ b/Documentation/networking/synce.rst
@@ -0,0 +1,117 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Synchronous Ethernet
+====================
+
+Synchronous Ethernet networks use a physical layer clock to syntonize
+the frequency across different network elements.
+
+Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
+Equipment Clock (EEC) and a PHY that has dedicated outputs of recovered clocks
+and a dedicated TX clock input that is used as to transmit data to other nodes.
+
+The SyncE capable PHY is able to recover the incomning frequency of the data
+stream on RX lanes and redirect it (sometimes dividing it) to recovered
+clock outputs. In SyncE PHY the TX frequency is directly dependent on the
+input frequency - either on the PHY CLK input, or on a dedicated
+TX clock input.
+
+      ????????????????????????
+      ? RX        ? TX       ?
+  1   ? lanes     ? lanes    ? 1
+  ????????????    ?          ???????
+  2   ?      ?    ?          ? 2
+  ????????   ?    ?          ???????
+  3   ?  ?   ?    ?          ? 3
+  ????????   ?    ?          ???????
+      ? ??????    ?          ?
+      ? \____/    ?          ?
+      ????????????????????????
+        1? 2?        ?
+ RCLK out?  ?        ? TX CLK in
+         ?  ?        ?
+       ???????????????????
+       ?                 ?
+       ?       EEC       ?
+       ?                 ?
+       ???????????????????
+
+The EEC can synchronize its frequency to one of the synchronization inputs
+either clocks recovered on traffic interfaces or (in advanced deployments)
+external frequency sources.
+
+Some EEC implementations can select synchronization source through
+priority tables and synchronization status messaging and provide necessary
+filtering and holdover capabilities.
+
+The following interface can be applicable to diffferent packet network types
+following ITU-T G.8261/G.8262 recommendations.
+
+Interface
+=========
+
+The following RTNL messages are used to read/configure SyncE recovered
+clocks.
+
+RTM_GETRCLKRANGE
+-----------------
+Reads the allowed pin index range for the recovered clock outputs.
+This can be aligned to PHY outputs or to EEC inputs, whichever is
+better for a given application.
+Will call the ndo_get_rclk_range function to read the allowed range
+of output pin indexes.
+Will call ndo_get_rclk_range to determine the allowed recovered clock
+range and return them in the IFLA_RCLK_RANGE_MIN_PIN and the
+IFLA_RCLK_RANGE_MAX_PIN attributes
+
+RTM_GETRCLKSTATE
+-----------------
+Read the state of recovered pins that output recovered clock from
+a given port. The message will contain the number of assigned clocks
+(IFLA_RCLK_STATE_COUNT) and an N pin indexes in IFLA_RCLK_STATE_OUT_IDX
+To support multiple recovered clock outputs from the same port, this message
+will return the IFLA_RCLK_STATE_COUNT attribute containing the number of
+active recovered clock outputs (N) and N IFLA_RCLK_STATE_OUT_IDX attributes
+listing the active output indexes.
+This message will call the ndo_get_rclk_range to determine the allowed
+recovered clock indexes and then will loop through them, calling
+the ndo_get_rclk_state for each of them.
+
+RTM_SETRCLKSTATE
+-----------------
+Sets the redirection of the recovered clock for a given pin. This message
+expects one attribute:
+struct if_set_rclk_msg {
+	__u32 ifindex; /* interface index */
+	__u32 out_idx; /* output index (from a valid range)
+	__u32 flags; /* configuration flags */
+};
+
+Supported flags are:
+SET_RCLK_FLAGS_ENA - if set in flags - the given output will be enabled,
+		     if clear - the output will be disabled.
+
+RTM_GETEECSTATE
+----------------
+Reads the state of the EEC or equivalent physical clock synchronizer.
+This message returns the following attributes:
+IFLA_EEC_STATE - current state of the EEC or equivalent clock generator.
+		 The states returned in this attribute are aligned to the
+		 ITU-T G.781 and are:
+		  IF_EEC_STATE_INVALID - state is not valid
+		  IF_EEC_STATE_FREERUN - clock is free-running
+		  IF_EEC_STATE_LOCKED - clock is locked to the reference,
+		                        but the holdover memory is not valid
+		  IF_EEC_STATE_LOCKED_HO_ACQ - clock is locked to the reference
+		                               and holdover memory is valid
+		  IF_EEC_STATE_HOLDOVER - clock is in holdover mode
+State is read from the netdev calling the:
+int (*ndo_get_eec_state)(struct net_device *dev, enum if_eec_state *state,
+			 u32 *src_idx, struct netlink_ext_ack *extack);
+
+IFLA_EEC_SRC_IDX - optional attribute returning the index of the reference that
+		   is used for the current IFLA_EEC_STATE, i.e., the index of
+		   the pin that the EEC is locked to.
+
+Will be returned only if the ndo_get_eec_src is implemented.
\ No newline at end of file
-- 
2.26.3

