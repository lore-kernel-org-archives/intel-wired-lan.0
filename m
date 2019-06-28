From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Fri, 28 Jun 2019 09:30:17 -0300
Subject: [Intel-wired-lan] [PATCH 24/39] docs: driver-model: move it to the
 driver-api book
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
Message-ID: <920ff36c66233113b1825ab504fe675ed5a5bd7b.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The audience for the Kernel driver-model is clearly Kernel hackers.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/{ => driver-api}/driver-model/binding.rst       | 0
 Documentation/{ => driver-api}/driver-model/bus.rst           | 0
 Documentation/{ => driver-api}/driver-model/class.rst         | 0
 .../{ => driver-api}/driver-model/design-patterns.rst         | 0
 Documentation/{ => driver-api}/driver-model/device.rst        | 0
 Documentation/{ => driver-api}/driver-model/devres.rst        | 0
 Documentation/{ => driver-api}/driver-model/driver.rst        | 0
 Documentation/{ => driver-api}/driver-model/index.rst         | 2 --
 Documentation/{ => driver-api}/driver-model/overview.rst      | 0
 Documentation/{ => driver-api}/driver-model/platform.rst      | 0
 Documentation/{ => driver-api}/driver-model/porting.rst       | 2 +-
 Documentation/driver-api/gpio/driver.rst                      | 2 +-
 Documentation/driver-api/index.rst                            | 1 +
 Documentation/eisa.txt                                        | 4 ++--
 Documentation/filesystems/sysfs.txt                           | 2 +-
 Documentation/hwmon/submitting-patches.rst                    | 2 +-
 Documentation/translations/zh_CN/filesystems/sysfs.txt        | 2 +-
 drivers/base/platform.c                                       | 2 +-
 drivers/gpio/gpio-cs5535.c                                    | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c                     | 2 +-
 drivers/staging/unisys/Documentation/overview.txt             | 4 ++--
 include/linux/device.h                                        | 2 +-
 include/linux/platform_device.h                               | 2 +-
 scripts/coccinelle/free/devm_free.cocci                       | 2 +-
 24 files changed, 16 insertions(+), 17 deletions(-)
 rename Documentation/{ => driver-api}/driver-model/binding.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/bus.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/class.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/design-patterns.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/device.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/devres.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/driver.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/index.rst (96%)
 rename Documentation/{ => driver-api}/driver-model/overview.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/platform.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/porting.rst (99%)

diff --git a/Documentation/driver-model/binding.rst b/Documentation/driver-api/driver-model/binding.rst
similarity index 100%
rename from Documentation/driver-model/binding.rst
rename to Documentation/driver-api/driver-model/binding.rst
diff --git a/Documentation/driver-model/bus.rst b/Documentation/driver-api/driver-model/bus.rst
similarity index 100%
rename from Documentation/driver-model/bus.rst
rename to Documentation/driver-api/driver-model/bus.rst
diff --git a/Documentation/driver-model/class.rst b/Documentation/driver-api/driver-model/class.rst
similarity index 100%
rename from Documentation/driver-model/class.rst
rename to Documentation/driver-api/driver-model/class.rst
diff --git a/Documentation/driver-model/design-patterns.rst b/Documentation/driver-api/driver-model/design-patterns.rst
similarity index 100%
rename from Documentation/driver-model/design-patterns.rst
rename to Documentation/driver-api/driver-model/design-patterns.rst
diff --git a/Documentation/driver-model/device.rst b/Documentation/driver-api/driver-model/device.rst
similarity index 100%
rename from Documentation/driver-model/device.rst
rename to Documentation/driver-api/driver-model/device.rst
diff --git a/Documentation/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
similarity index 100%
rename from Documentation/driver-model/devres.rst
rename to Documentation/driver-api/driver-model/devres.rst
diff --git a/Documentation/driver-model/driver.rst b/Documentation/driver-api/driver-model/driver.rst
similarity index 100%
rename from Documentation/driver-model/driver.rst
rename to Documentation/driver-api/driver-model/driver.rst
diff --git a/Documentation/driver-model/index.rst b/Documentation/driver-api/driver-model/index.rst
similarity index 96%
rename from Documentation/driver-model/index.rst
rename to Documentation/driver-api/driver-model/index.rst
index 9f85d579ce56..755016422269 100644
--- a/Documentation/driver-model/index.rst
+++ b/Documentation/driver-api/driver-model/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ============
 Driver Model
 ============
diff --git a/Documentation/driver-model/overview.rst b/Documentation/driver-api/driver-model/overview.rst
similarity index 100%
rename from Documentation/driver-model/overview.rst
rename to Documentation/driver-api/driver-model/overview.rst
diff --git a/Documentation/driver-model/platform.rst b/Documentation/driver-api/driver-model/platform.rst
similarity index 100%
rename from Documentation/driver-model/platform.rst
rename to Documentation/driver-api/driver-model/platform.rst
diff --git a/Documentation/driver-model/porting.rst b/Documentation/driver-api/driver-model/porting.rst
similarity index 99%
rename from Documentation/driver-model/porting.rst
rename to Documentation/driver-api/driver-model/porting.rst
index ae4bf843c1d6..931ea879af3f 100644
--- a/Documentation/driver-model/porting.rst
+++ b/Documentation/driver-api/driver-model/porting.rst
@@ -9,7 +9,7 @@ Patrick Mochel
 
 Overview
 
-Please refer to `Documentation/driver-model/*.rst` for definitions of
+Please refer to `Documentation/driver-api/driver-model/*.rst` for definitions of
 various driver types and concepts.
 
 Most of the work of porting devices drivers to the new model happens
diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index 349f2dc33029..921c71a3d683 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -399,7 +399,7 @@ symbol:
   will pass the struct gpio_chip* for the chip to all IRQ callbacks, so the
   callbacks need to embed the gpio_chip in its state container and obtain a
   pointer to the container using container_of().
-  (See Documentation/driver-model/design-patterns.rst)
+  (See Documentation/driver-api/driver-model/design-patterns.rst)
 
 - gpiochip_irqchip_add_nested(): adds a nested cascaded irqchip to a gpiochip,
   as discussed above regarding different types of cascaded irqchips. The
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index fea0034afa56..93d187bf4853 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -14,6 +14,7 @@ available subsections can be seen below.
 .. toctree::
    :maxdepth: 2
 
+   driver-model/index
    basics
    infrastructure
    early-userspace/index
diff --git a/Documentation/eisa.txt b/Documentation/eisa.txt
index f388545a85a7..c07565ba57da 100644
--- a/Documentation/eisa.txt
+++ b/Documentation/eisa.txt
@@ -103,7 +103,7 @@ id_table	an array of NULL terminated EISA id strings,
 		(driver_data).
 
 driver		a generic driver, such as described in
-		Documentation/driver-model/driver.rst. Only .name,
+		Documentation/driver-api/driver-model/driver.rst. Only .name,
 		.probe and .remove members are mandatory.
 =============== ====================================================
 
@@ -152,7 +152,7 @@ state    set of flags indicating the state of the device. Current
 	 flags are EISA_CONFIG_ENABLED and EISA_CONFIG_FORCED.
 res	 set of four 256 bytes I/O regions allocated to this device
 dma_mask DMA mask set from the parent device.
-dev	 generic device (see Documentation/driver-model/device.rst)
+dev	 generic device (see Documentation/driver-api/driver-model/device.rst)
 ======== ============================================================
 
 You can get the 'struct eisa_device' from 'struct device' using the
diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.txt
index 5b5311f9358d..ddf15b1b0d5a 100644
--- a/Documentation/filesystems/sysfs.txt
+++ b/Documentation/filesystems/sysfs.txt
@@ -319,7 +319,7 @@ quick way to lookup the sysfs interface for a device from the result of
 a stat(2) operation.
 
 More information can driver-model specific features can be found in
-Documentation/driver-model/. 
+Documentation/driver-api/driver-model/.
 
 
 TODO: Finish this section.
diff --git a/Documentation/hwmon/submitting-patches.rst b/Documentation/hwmon/submitting-patches.rst
index d5b05d3e54ba..452fc28d8e0b 100644
--- a/Documentation/hwmon/submitting-patches.rst
+++ b/Documentation/hwmon/submitting-patches.rst
@@ -89,7 +89,7 @@ increase the chances of your change being accepted.
   console. Excessive logging can seriously affect system performance.
 
 * Use devres functions whenever possible to allocate resources. For rationale
-  and supported functions, please see Documentation/driver-model/devres.rst.
+  and supported functions, please see Documentation/driver-api/driver-model/devres.rst.
   If a function is not supported by devres, consider using devm_add_action().
 
 * If the driver has a detect function, make sure it is silent. Debug messages
diff --git a/Documentation/translations/zh_CN/filesystems/sysfs.txt b/Documentation/translations/zh_CN/filesystems/sysfs.txt
index 452271dda141..ee1f37da5b23 100644
--- a/Documentation/translations/zh_CN/filesystems/sysfs.txt
+++ b/Documentation/translations/zh_CN/filesystems/sysfs.txt
@@ -288,7 +288,7 @@ dev/ ???????? char/ ? block/???????????
 ???????/sys/dev ???????? stat(2) ???????
 ?? sysfs ????????
 
-???? driver-model ???????? Documentation/driver-model/
+???? driver-model ???????? Documentation/driver-api/driver-model/
 ????
 
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 713903290385..506a0175a5a7 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
  *
- * Please see Documentation/driver-model/platform.rst for more
+ * Please see Documentation/driver-api/driver-model/platform.rst for more
  * information.
  */
 
diff --git a/drivers/gpio/gpio-cs5535.c b/drivers/gpio/gpio-cs5535.c
index 3611a0571667..53b24e3ae7de 100644
--- a/drivers/gpio/gpio-cs5535.c
+++ b/drivers/gpio/gpio-cs5535.c
@@ -41,7 +41,7 @@ MODULE_PARM_DESC(mask, "GPIO channel mask.");
 
 /*
  * FIXME: convert this singleton driver to use the state container
- * design pattern, see Documentation/driver-model/design-patterns.rst
+ * design pattern, see Documentation/driver-api/driver-model/design-patterns.rst
  */
 static struct cs5535_gpio_chip {
 	struct gpio_chip chip;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 41c90f2ddb31..63db08d9bafa 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2286,7 +2286,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	struct ice_hw *hw;
 	int err;
 
-	/* this driver uses devres, see Documentation/driver-model/devres.rst */
+	/* this driver uses devres, see Documentation/driver-api/driver-model/devres.rst */
 	err = pcim_enable_device(pdev);
 	if (err)
 		return err;
diff --git a/drivers/staging/unisys/Documentation/overview.txt b/drivers/staging/unisys/Documentation/overview.txt
index 9ab30af265a5..f8a4144b239c 100644
--- a/drivers/staging/unisys/Documentation/overview.txt
+++ b/drivers/staging/unisys/Documentation/overview.txt
@@ -15,7 +15,7 @@ normally be unsharable, specifically:
 * visorinput - keyboard and mouse
 
 These drivers conform to the standard Linux bus/device model described
-within Documentation/driver-model/, and utilize a driver named visorbus to
+within Documentation/driver-api/driver-model/, and utilize a driver named visorbus to
 present the virtual busses involved. Drivers in the 'visor*' driver set are
 commonly referred to as "guest drivers" or "client drivers".  All drivers
 except visorbus expose a device of a specific usable class to the Linux guest
@@ -141,7 +141,7 @@ called automatically by the visorbus driver at appropriate times:
 -----------------------------------
 
 Because visorbus is a standard Linux bus driver in the model described in
-Documentation/driver-model/, the hierarchy of s-Par virtual devices is
+Documentation/driver-api/driver-model/, the hierarchy of s-Par virtual devices is
 published in the sysfs tree beneath /bus/visorbus/, e.g.,
 /sys/bus/visorbus/devices/ might look like:
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 4f65c424e5fd..93b12aec9bff 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -6,7 +6,7 @@
  * Copyright (c) 2004-2009 Greg Kroah-Hartman <gregkh@suse.de>
  * Copyright (c) 2008-2009 Novell Inc.
  *
- * See Documentation/driver-model/ for more information.
+ * See Documentation/driver-api/driver-model/ for more information.
  */
 
 #ifndef _DEVICE_H_
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index beb25f277889..9bc36b589827 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2001-2003 Patrick Mochel <mochel@osdl.org>
  *
- * See Documentation/driver-model/ for more information.
+ * See Documentation/driver-api/driver-model/ for more information.
  */
 
 #ifndef _PLATFORM_DEVICE_H_
diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/free/devm_free.cocci
index fefd0331a2de..441799b5359b 100644
--- a/scripts/coccinelle/free/devm_free.cocci
+++ b/scripts/coccinelle/free/devm_free.cocci
@@ -3,7 +3,7 @@
 /// functions.  Values allocated using the devm_functions are freed when
 /// the device is detached, and thus the use of the standard freeing
 /// function would cause a double free.
-/// See Documentation/driver-model/devres.rst for more information.
+/// See Documentation/driver-api/driver-model/devres.rst for more information.
 ///
 /// A difficulty of detecting this problem is that the standard freeing
 /// function might be called from a different function than the one
-- 
2.21.0

