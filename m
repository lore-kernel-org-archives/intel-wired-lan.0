From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:52 -0800
Subject: [Intel-wired-lan] [PART2 PATCH 9/9] i40e: document drivers use of
	ntuple filters
In-Reply-To: <20170206223852.31177-1-jacob.e.keller@intel.com>
References: <20170206223852.31177-1-jacob.e.keller@intel.com>
Message-ID: <20170206223852.31177-10-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add documentation describing the drivers use of ethtool ntuple filters,
including the limitations that it has due to hardware, as well as how it
reads and parses the user-def data block.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/networking/i40e.txt | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/networking/i40e.txt b/Documentation/networking/i40e.txt
index a251bf4fe9c9..57e616ed10b0 100644
--- a/Documentation/networking/i40e.txt
+++ b/Documentation/networking/i40e.txt
@@ -63,6 +63,78 @@ Additional Configurations
   The latest release of ethtool can be found from
   https://www.kernel.org/pub/software/network/ethtool
 
+
+  Flow Director n-ntuple traffic filters (FDir)
+  ---------------------------------------------
+  The driver utilizes the ethtool interface for configuring ntuple filters,
+  via "ethtool -N <device> <filter>".
+
+  The sctp4, ip4, udp4, and tcp4 flow types are supported with the standard
+  fields including src-ip, dst-ip, src-port and dst-port. The driver only
+  supports fully enabling or fully masking the fields, so use of the mask
+  fields for partial matches is not supported.
+
+  Additionally, the driver supports using the action to specify filters for a
+  Virtual Function. You can specify the action as a 64bit value, where the
+  lower 32 bits represents the queue number, while the next 8 bits represent
+  which VF. Note that 0 is the PF, so the VF identifier is offset by 1. For
+  example:
+
+    ... action 0x800000002 ...
+
+  Would indicate to direct traffic for Virtual Function 7 (8 minus 1) on queue
+  2 of that VF.
+
+  The driver also supports using the user-defined field to specify 2 bytes of
+  arbitrary data to match within the packet payload in addition to the regular
+  fields. The data is specified in the lower 32bits of the user-def field in
+  the following way:
+
+  +----------------------------+---------------------------+
+  | 31    28    24    20    16 | 15    12     8     4     0|
+  +----------------------------+---------------------------+
+  | offset into packet payload |  2 bytes of flexible data |
+  +----------------------------+---------------------------+
+
+  As an example,
+
+    ... user-def 0x4FFFF ....
+
+  means to match the value 0xFFFF 4 bytes into the packet payload. Note that
+  the offset is based on the beginning of the payload, and not the beginning
+  of the packet. Thus
+
+    flow-type tcp4 ... user-def 0x8BEAF ....
+
+  would match TCP/IPv4 packets which have the value 0xBEAF 8bytes into the
+  TCP/IPv4 payload.
+
+  For ICMP, the hardware parses the ICMP header as 4 bytes of header and 4
+  bytes of payload, so if you want to match an ICMP frames payload you may need
+  to add 4 to the offset in order to match the data.
+
+  Furthermore, the offset can only be up to a value of 64, as the hardware
+  will only read up to 64 bytes of data from the payload. It must also be even
+  as the flexible data is 2 bytes long and must be aligned to byte 0 of the
+  packet payload.
+
+  When programming filters, the hardware is limited to using a single input
+  set for each flow type. This means that it is an error to program two
+  different filters with the same type that don't match on the same fields.
+  Thus the second of the following two commands will fail:
+
+    ethtool -N <device> flow-type tcp4 src-ip 192.168.0.7 action 5
+    ethtool -N <device> flow-type tcp4 dst-ip 192.168.15.18 action 1
+
+  This is because the first filter will be accepted and reprogram the input
+  set for TCPv4 filters, but the second filter will be unable to reprogram the
+  input set until all the conflicting TCPv4 filters are first removed.
+
+  Note that the user-defined flexible offset is also considered part of the
+  input set and cannot be programmed separately for multiple filters of the
+  same type. However, the flexible data is not part of the input set and
+  multiple filters may use the same offset but match against different data.
+
   Data Center Bridging (DCB)
   --------------------------
   DCB configuration is not currently supported.
-- 
2.12.0.rc0.151.g8a5726c42288

