From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 25 Jul 2018 14:52:38 -0500
Subject: [Intel-wired-lan] [PATCH v1 2/4] ath9k: Remove unnecessary include
 of <linux/pci-aspm.h>
In-Reply-To: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <153254835812.92573.3566522887325831923.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The ath9k driver doesn't need anything provided by pci-aspm.h, so remove
the unnecessary include of it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/wireless/ath/ath9k/pci.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index 645f0fbd9179..92b2dd396436 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -18,7 +18,6 @@
 
 #include <linux/nl80211.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/module.h>
 #include "ath9k.h"
 

