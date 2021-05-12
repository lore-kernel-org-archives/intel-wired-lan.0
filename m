From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Wed, 12 May 2021 14:50:30 +0200
Subject: [Intel-wired-lan] [PATCH v2 26/40] docs: networking:
 device_drivers: Use ASCII subset instead of UTF-8 alternate symbols
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
Message-ID: <aa49206f65b7302f6d579d3be726242dedebdb79.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+00a0 ('?'): NO-BREAK SPACE
	- U+2018 ('?'): LEFT SINGLE QUOTATION MARK
	- U+2019 ('?'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../device_drivers/ethernet/intel/i40e.rst           |  8 ++++----
 .../device_drivers/ethernet/intel/iavf.rst           |  4 ++--
 .../device_drivers/ethernet/netronome/nfp.rst        | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
index 2d3f6bd969a2..d0e9b783a224 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
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
 
diff --git a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
index 25330b7b5168..b70eea67c3d9 100644
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

