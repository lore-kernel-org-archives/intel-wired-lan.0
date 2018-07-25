From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 25 Jul 2018 14:52:23 -0500
Subject: [Intel-wired-lan] [PATCH v1 1/4] igb: Remove unnecessary include of
 <linux/pci-aspm.h>
In-Reply-To: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <153254834342.92573.16877025672192312745.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The igb driver doesn't need anything provided by pci-aspm.h, so remove
the unnecessary include of it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index f707709969ac..c77fda05f683 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -22,7 +22,6 @@
 #include <linux/if.h>
 #include <linux/if_vlan.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/ip.h>

