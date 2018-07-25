From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 25 Jul 2018 14:52:54 -0500
Subject: [Intel-wired-lan] [PATCH v1 4/4] PCI: Remove unnecessary include of
 <linux/pci-aspm.h>
In-Reply-To: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <153254837478.92573.14742111987549518973.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Several PCI core files include pci-aspm.h even though they don't need
anything provided by that file.  Remove the unnecessary includes of it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c |    1 -
 drivers/pci/pci.c       |    1 -
 drivers/pci/probe.c     |    1 -
 drivers/pci/remove.c    |    1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 0c4653c1d2ce..91337faae60d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -23,7 +23,6 @@
 #include <linux/fs.h>
 #include <linux/capability.h>
 #include <linux/security.h>
-#include <linux/pci-aspm.h>
 #include <linux/slab.h>
 #include <linux/vgaarb.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f5c6ab14fb31..7c2f0e682fc0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -23,7 +23,6 @@
 #include <linux/string.h>
 #include <linux/log2.h>
 #include <linux/logic_pio.h>
-#include <linux/pci-aspm.h>
 #include <linux/pm_wakeup.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..1ed2852dee21 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
-#include <linux/pci-aspm.h>
 #include <linux/aer.h>
 #include <linux/acpi.h>
 #include <linux/hypervisor.h>
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 6f072eae4f7a..01ec7fcb5634 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
-#include <linux/pci-aspm.h>
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)

