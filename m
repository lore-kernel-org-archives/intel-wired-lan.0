From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 25 Jul 2018 14:52:48 -0500
Subject: [Intel-wired-lan] [PATCH v1 3/4] iwlwifi: Remove unnecessary
 include of <linux/pci-aspm.h>
In-Reply-To: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <153254836793.92573.16383045269302376209.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bjorn Helgaas <bhelgaas@google.com>

This part of the iwlwifi driver doesn't need anything provided by
pci-aspm.h, so remove the unnecessary include of it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 38234bda9017..d6c55e111fda 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -72,7 +72,6 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/acpi.h>
 
 #include "fw/acpi.h"

