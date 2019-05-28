From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 May 2019 10:59:21 -0700
Subject: [Intel-wired-lan] [next PATCH S6 7/7] i40e: update copyright string
In-Reply-To: <20190528175921.30534-1-alice.michael@intel.com>
References: <20190528175921.30534-1-alice.michael@intel.com>
Message-ID: <20190528175921.30534-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It was found that the string that prints our copyright was
not up to date.  Updating to reflect our copyright.

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index fb25e8222fb5..c58b114d6234 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -32,7 +32,7 @@ static const char i40e_driver_string[] =
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
 const char i40e_driver_version_str[] = DRV_VERSION;
-static const char i40e_copyright[] = "Copyright (c) 2013 - 2014 Intel Corporation.";
+static const char i40e_copyright[] = "Copyright (c) 2013 - 2019 Intel Corporation.";
 
 /* a bit of forward declarations */
 static void i40e_vsi_reinit_locked(struct i40e_vsi *vsi);
-- 
2.19.2

