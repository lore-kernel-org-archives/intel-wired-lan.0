From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Thu, 24 Mar 2016 16:23:32 -0700
Subject: [Intel-wired-lan] [PATCH 11/11] ixgbe: Bump version number
In-Reply-To: <20160324231833.108409.65944.stgit@mdrustad-wks.jf.intel.com>
References: <20160324231833.108409.65944.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160324232332.108409.36283.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update ixgbe version number.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0d5893a60e08..cf95f8098f1f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -70,7 +70,7 @@ char ixgbe_default_device_descr[] =
 static char ixgbe_default_device_descr[] =
 			      "Intel(R) 10 Gigabit Network Connection";
 #endif
-#define DRV_VERSION "4.2.1-k"
+#define DRV_VERSION "4.4.0-k"
 const char ixgbe_driver_version[] = DRV_VERSION;
 static const char ixgbe_copyright[] =
 				"Copyright (c) 1999-2016 Intel Corporation.";

