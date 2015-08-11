From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Tue, 11 Aug 2015 13:11:58 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Advance version to 4.2.1
Message-ID: <20150811201158.123478.5775.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With the addition of X550em_x SFP+ support, the driver is now
functionally equivalent to what will be the 4.2.1 driver when
released, so change the version to match.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index fb5528d5ace9..33138568f5a5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -79,7 +79,7 @@ char ixgbe_default_device_descr[] =
 static char ixgbe_default_device_descr[] =
 			      "Intel(R) 10 Gigabit Network Connection";
 #endif
-#define DRV_VERSION "4.0.1-k"
+#define DRV_VERSION "4.2.1-k"
 const char ixgbe_driver_version[] = DRV_VERSION;
 static const char ixgbe_copyright[] =
 				"Copyright (c) 1999-2015 Intel Corporation.";

