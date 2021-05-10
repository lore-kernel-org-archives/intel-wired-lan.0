From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Mon, 10 May 2021 12:26:48 +0200
Subject: [Intel-wired-lan] [PATCH 36/53] docs: networking: device_drivers:
 avoid using UTF-8 chars
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
Message-ID: <9d14421bef0641bb1a45dbf87865b0cd361f64d6.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+00a0 ('?'): NO-BREAK SPACE
	- U+2013 ('?'): EN DASH
	- U+2018 ('?'): LEFT SINGLE QUOTATION MARK
	- U+2019 ('?'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../device_drivers/ethernet/intel/i40e.rst           | 12 ++++++------
 .../device_drivers/ethernet/intel/iavf.rst           |  6 +++---
 .../device_drivers/ethernet/netronome/nfp.rst        | 12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
index 8a9b18573688..64024c77c9ca 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
@@ -173,7 +173,7 @@ Director rule is added from ethtool (Sideband filter), ATR is turned off by the
 driver. To re-enable ATR, the sideband can be disabled with the ethtool -K
 option. For example::
 
-  ethtool ?K [adapter] ntuple [off|on]
+  ethtool -K [adapter] ntuple [off|on]
 
 If sideband is re-enabled after ATR is re-enabled, ATR remains enabled until a
 TCP-IP flow is added. When all TCP-IP sideband rules are deleted, ATR is
@@ -466,7 +466,7 @@ network. PTP support varies among Intel devices that support this driver. Use
 "ethtool -T <netdev name>" to get a definitive list of PTP capabilities
 supported by the device.
 
-IEEE 802.1ad (QinQ)?Support
+IEEE 802.1ad (QinQ) Support
 ---------------------------
 The IEEE 802.1ad standard, informally known as QinQ, allows for multiple VLAN
 IDs within a single Ethernet frame. VLAN IDs are sometimes referred to as
@@ -523,8 +523,8 @@ of a port's bandwidth (should it be available). The sum of all the values for
 Maximum Bandwidth is not restricted, because no more than 100% of a port's
 bandwidth can ever be used.
 
-NOTE:?X710/XXV710 devices fail to enable Max VFs (64) when Multiple Functions
-per Port (MFP)?and SR-IOV are enabled. An error from i40e is logged that says
+NOTE: X710/XXV710 devices fail to enable Max VFs (64) when Multiple Functions
+per Port (MFP) and SR-IOV are enabled. An error from i40e is logged that says
 "add vsi failed for VF N, aq_err 16". To workaround the issue, enable less than
 64 virtual functions (VFs).
 
@@ -680,7 +680,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16 at 0 16 at 16 assigns
 16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
 number of queues for all tcs is 64 or number of cores, whichever is lower.)
 
-hw 1 mode channel: ?channel? with ?hw? set to 1 is a new new hardware
+hw 1 mode channel: 'channel' with 'hw' set to 1 is a new new hardware
 offload mode in mqprio that makes full use of the mqprio options, the
 TCs, the queue configurations, and the QoS parameters.
 
@@ -688,7 +688,7 @@ shaper bw_rlimit: for each tc, sets minimum and maximum bandwidth rates.
 Totals must be equal or less than port speed.
 
 For example: min_rate 1Gbit 3Gbit: Verify bandwidth limit using network
-monitoring tools such as ifstat or sar ?n DEV [interval] [number of samples]
+monitoring tools such as ifstat or sar -n DEV [interval] [number of samples]
 
 2. Enable HW TC offload on interface::
 
diff --git a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
index 52e037b11c97..25e98494b385 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
@@ -113,7 +113,7 @@ which the AVF is associated. The following are base mode features:
 - AVF device ID
 - HW mailbox is used for VF to PF communications (including on Windows)
 
-IEEE 802.1ad (QinQ)?Support
+IEEE 802.1ad (QinQ) Support
 ---------------------------
 The IEEE 802.1ad standard, informally known as QinQ, allows for multiple VLAN
 IDs within a single Ethernet frame. VLAN IDs are sometimes referred to as
@@ -171,7 +171,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16 at 0 16 at 16 assigns
 16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
 number of queues for all tcs is 64 or number of cores, whichever is lower.)
 
-hw 1 mode channel: ?channel? with ?hw? set to 1 is a new new hardware
+hw 1 mode channel: 'channel' with 'hw' set to 1 is a new new hardware
 offload mode in mqprio that makes full use of the mqprio options, the
 TCs, the queue configurations, and the QoS parameters.
 
@@ -179,7 +179,7 @@ shaper bw_rlimit: for each tc, sets minimum and maximum bandwidth rates.
 Totals must be equal or less than port speed.
 
 For example: min_rate 1Gbit 3Gbit: Verify bandwidth limit using network
-monitoring tools such as ifstat or sar ?n DEV [interval] [number of samples]
+monitoring tools such as ifstat or sar -n DEV [interval] [number of samples]
 
 NOTE:
   Setting up channels via ethtool (ethtool -L) is not supported when the
diff --git a/Documentation/networking/device_drivers/ethernet/netronome/nfp.rst b/Documentation/networking/device_drivers/ethernet/netronome/nfp.rst
index ada611fb427c..949c036e8667 100644
--- a/Documentation/networking/device_drivers/ethernet/netronome/nfp.rst
+++ b/Documentation/networking/device_drivers/ethernet/netronome/nfp.rst
@@ -62,14 +62,14 @@ actual firmware files in application-named subdirectories in
     $ tree /lib/firmware/netronome/
     /lib/firmware/netronome/
     ??? bpf
-    ??? ??? nic_AMDA0081-0001_1x40.nffw
-    ??? ??? nic_AMDA0081-0001_4x10.nffw
+    ?   ??? nic_AMDA0081-0001_1x40.nffw
+    ?   ??? nic_AMDA0081-0001_4x10.nffw
     ??? flower
-    ??? ??? nic_AMDA0081-0001_1x40.nffw
-    ??? ??? nic_AMDA0081-0001_4x10.nffw
+    ?   ??? nic_AMDA0081-0001_1x40.nffw
+    ?   ??? nic_AMDA0081-0001_4x10.nffw
     ??? nic
-    ??? ??? nic_AMDA0081-0001_1x40.nffw
-    ??? ??? nic_AMDA0081-0001_4x10.nffw
+    ?   ??? nic_AMDA0081-0001_1x40.nffw
+    ?   ??? nic_AMDA0081-0001_4x10.nffw
     ??? nic_AMDA0081-0001_1x40.nffw -> bpf/nic_AMDA0081-0001_1x40.nffw
     ??? nic_AMDA0081-0001_4x10.nffw -> bpf/nic_AMDA0081-0001_4x10.nffw
 
-- 
2.30.2

