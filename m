From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 22 Apr 2015 14:40:30 -0700
Subject: [Intel-wired-lan] [PATCH 1/8] clarify implementation of ethtool's
	get_ts_info op
Message-ID: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds some clarification about the intended way to implement
both SIOCSHWTSTAMP and ethtool's get_ts_info. The HWTSTAMP API has
several Rx filters which are very specific, as well as more general
filters. The specific filters really only exist to support some broken
hardware which can't fully implement the generic filters. This patch
adds clarification that it is okay to support the specific filters in
SIOCSHWTSTAMP by upscaling them to the generic filters. In addition,
update the header for ethtool_ts_info to specify that drivers ought to
only report the filters they support without upscaling in this manner.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/networking/timestamping.txt | 7 +++++++
 include/uapi/linux/ethtool.h              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/networking/timestamping.txt b/Documentation/networking/timestamping.txt
index 5f0922613f1a..a977339fbe0a 100644
--- a/Documentation/networking/timestamping.txt
+++ b/Documentation/networking/timestamping.txt
@@ -359,6 +359,13 @@ the requested fine-grained filtering for incoming packets is not
 supported, the driver may time stamp more than just the requested types
 of packets.
 
+Drivers are free to use a more permissive configuration than the requested
+configuration. It is expected that drivers should only implement directly the
+most generic mode that can be supported. For example if the hardware can
+support HWTSTAMP_FILTER_V2_EVENT, then it should generally always upscale
+HWTSTAMP_FILTER_V2_L2_SYNC_MESSAGE, and so forth, as HWTSTAMP_FILTER_V2_EVENT
+is more generic (and more useful to applications).
+
 A driver which supports hardware time stamping shall update the struct
 with the actual, possibly more permissive configuration. If the
 requested packets cannot be time stamped, then nothing should be
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 2e49fc880d29..c1e1d9a001ba 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1062,6 +1062,11 @@ struct ethtool_sfeatures {
  * the 'hwtstamp_tx_types' and 'hwtstamp_rx_filters' enumeration values,
  * respectively.  For example, if the device supports HWTSTAMP_TX_ON,
  * then (1 << HWTSTAMP_TX_ON) in 'tx_types' will be set.
+ *
+ * Drivers should only report the filters they actually support without
+ * upscaling in the SIOCSHWTSTAMP ioctl. If the SIOCSHWSTAMP request for
+ * HWTSTAMP_FILTER_V1_SYNC is supported by HWTSTAMP_FILTER_V1_EVENT, then the
+ * driver should only report HWTSTAMP_FILTER_V1_EVENT in this op.
  */
 struct ethtool_ts_info {
 	__u32	cmd;
-- 
2.1.0

