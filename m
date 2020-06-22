From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jun 2020 12:00:55 +0200
Subject: [Intel-wired-lan] [PATCH 10/11] of: mdio: provide
 devm_of_mdiobus_register()
In-Reply-To: <20200622100056.10151-1-brgl@bgdev.pl>
References: <20200622100056.10151-1-brgl@bgdev.pl>
Message-ID: <20200622100056.10151-11-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement a managed variant of of_mdiobus_register(). We need to
reimplement the devres structure and the release callback because we
can't put this function in drivers/net/phy/mdio_devres.c or we'd hit
circular dependencies between module symbols. We also don't want to
build this bit if OF is not selected in Kconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/of/of_mdio.c                          | 43 +++++++++++++++++++
 include/linux/of_mdio.h                       |  3 ++
 3 files changed, 47 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index e0333d66a7f4..eaaaafc21134 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -343,6 +343,7 @@ MDIO
   devm_mdiobus_alloc()
   devm_mdiobus_alloc_size()
   devm_mdiobus_register()
+  devm_of_mdiobus_register()
 
 MEM
   devm_free_pages()
diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index a04afe79529c..83e98c6ec96b 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -330,6 +330,49 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 }
 EXPORT_SYMBOL(of_mdiobus_register);
 
+/* This duplicates the devres code from drivers/net/phy/mdio_devres.c but
+ * if we put devm_of_mdiobus_register() over there we'd hit circular symbol
+ * dependencies between the libphy and of_mdio modules.
+ */
+struct mdiobus_devres {
+	struct mii_bus *mii;
+};
+
+static void devm_mdiobus_unregister(struct device *dev, void *this)
+{
+	struct mdiobus_devres *dr = this;
+
+	mdiobus_unregister(dr->mii);
+}
+
+/**
+ * devm_of_mdiobus_register - Resource managed variant of of_mdiobus_register()
+ * @dev:	Device to register mii_bus for
+ * @mdio:	MII bus structure to register
+ * @np:		Device node to parse
+ */
+int devm_of_mdiobus_register(struct device *dev, struct mii_bus *mdio,
+			     struct device_node *np)
+{
+	struct mdiobus_devres *dr;
+	int ret;
+
+	dr = devres_alloc(devm_mdiobus_unregister, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = of_mdiobus_register(mdio, np);
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
+
+	dr->mii = mdio;
+	devres_add(dev, dr);
+	return 0;
+}
+EXPORT_SYMBOL(devm_of_mdiobus_register);
+
 /**
  * of_phy_find_device - Give a PHY node, find the phy_device
  * @phy_np: Pointer to the phy's device tree node
diff --git a/include/linux/of_mdio.h b/include/linux/of_mdio.h
index ba8e157f24ad..1efb88d9f892 100644
--- a/include/linux/of_mdio.h
+++ b/include/linux/of_mdio.h
@@ -8,12 +8,15 @@
 #ifndef __LINUX_OF_MDIO_H
 #define __LINUX_OF_MDIO_H
 
+#include <linux/device.h>
 #include <linux/phy.h>
 #include <linux/of.h>
 
 #if IS_ENABLED(CONFIG_OF_MDIO)
 bool of_mdiobus_child_is_phy(struct device_node *child);
 int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np);
+int devm_of_mdiobus_register(struct device *dev, struct mii_bus *mdio,
+			     struct device_node *np);
 struct phy_device *of_phy_find_device(struct device_node *phy_np);
 struct phy_device *
 of_phy_connect(struct net_device *dev, struct device_node *phy_np,
-- 
2.26.1

