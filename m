From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Tue, 11 May 2021 17:01:32 +0200
Subject: [Intel-wired-lan] [PATCH 5/5] docs: networking: device_drivers: fix
 bad usage of UTF-8 chars
In-Reply-To: <cover.1620744606.git.mchehab+huawei@kernel.org>
References: <cover.1620744606.git.mchehab+huawei@kernel.org>
Message-ID: <95eb2a48d0ca3528780ce0dfce64359977fa8cb3.1620744606.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Probably because the original file was pre-processed by some
tool, both i40e.rst and iavf.rst files are using this character:

	- U+2013 ('?'): EN DASH

meaning an hyphen when calling a command line application, which
is obviously wrong. So, replace them by an hyphen, ensuring
that it will be properly displayed as literals when building
the documentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../networking/device_drivers/ethernet/intel/i40e.rst         | 4 ++--
 .../networking/device_drivers/ethernet/intel/iavf.rst         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
index 8a9b18573688..2d3f6bd969a2 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
@@ -173,7 +173,7 @@ Director rule is added from ethtool (Sideband filter), ATR is turned off by the
 driver. To re-enable ATR, the sideband can be disabled with the ethtool -K
 option. For example::
 
-  ethtool ?K [adapter] ntuple [off|on]
+  ethtool -K [adapter] ntuple [off|on]
 
 If sideband is re-enabled after ATR is re-enabled, ATR remains enabled until a
 TCP-IP flow is added. When all TCP-IP sideband rules are deleted, ATR is
@@ -688,7 +688,7 @@ shaper bw_rlimit: for each tc, sets minimum and maximum bandwidth rates.
 Totals must be equal or less than port speed.
 
 For example: min_rate 1Gbit 3Gbit: Verify bandwidth limit using network
-monitoring tools such as ifstat or sar ?n DEV [interval] [number of samples]
+monitoring tools such as `ifstat` or `sar -n DEV [interval] [number of samples]`
 
 2. Enable HW TC offload on interface::
 
diff --git a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
index 52e037b11c97..25330b7b5168 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
@@ -179,7 +179,7 @@ shaper bw_rlimit: for each tc, sets minimum and maximum bandwidth rates.
 Totals must be equal or less than port speed.
 
 For example: min_rate 1Gbit 3Gbit: Verify bandwidth limit using network
-monitoring tools such as ifstat or sar ?n DEV [interval] [number of samples]
+monitoring tools such as ``ifstat`` or ``sar -n DEV [interval] [number of samples]``
 
 NOTE:
   Setting up channels via ethtool (ethtool -L) is not supported when the
-- 
2.30.2

