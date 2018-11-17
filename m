From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 16 Nov 2018 16:19:24 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v1 2/2] Documentation: igb: Add
 a section about CBS
In-Reply-To: <20181117001924.1525-1-vinicius.gomes@intel.com>
References: <20181117001924.1525-1-vinicius.gomes@intel.com>
Message-ID: <20181117001924.1525-2-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add some pointers to the definition of the CBS algorithm, and some
notes about the limits of its implementation in the i210 family of
controllers.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 Documentation/networking/igb.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/networking/igb.rst b/Documentation/networking/igb.rst
index ba16b86d5593..e87a4a72ea2d 100644
--- a/Documentation/networking/igb.rst
+++ b/Documentation/networking/igb.rst
@@ -177,6 +177,25 @@ rate limit using the IProute2 tool. Download the latest version of the
 IProute2 tool from Sourceforge if your version does not have all the features
 you require.
 
+Credit Based Shaper (Qav Mode)
+------------------------------
+When enabling the CBS qdisc in the hardware offload mode, traffic shaping using
+the CBS (described in the IEEE 802.1Q-2018 Section 8.6.8.2 and discussed in the
+Annex L) algorithm will run in the i210 controller, so it's more accurate and
+uses less CPU.
+
+When using offloaded CBS, and the traffic rate obeys the configured rate
+(doesn't go above it), CBS should have little to no effect in the latency.
+
+The offloaded version of the algorithm has some limits, caused by how the idle
+slope is expressed in the adapter's registers. It can only represent idle slopes
+in 16.38431 kbps units, which means that if a idle slope of 2576kbps is
+requested, the controller will be configured to use a idle slope of ~2589 kbps,
+because the driver rounds the value up. For more details, see the comments on
+:c:func:`igb_config_tx_modes()`.
+
+NOTE: This feature is exclusive to i210 models.
+
 
 Support
 =======
-- 
2.19.1

