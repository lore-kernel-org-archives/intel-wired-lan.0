Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1250C5B572
	for <intel-wired-lan@archiver.kernel.org>; Sat, 15 Aug 2026 01:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5980A40C6A;
	Sat, 15 Aug 2026 01:26:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QkBOjqBBf0l9; Sat, 15 Aug 2026 01:26:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E1E840CBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786757177;
	bh=jNWMAxc6IKo4vE0V7oV2n573UldznWSWgllJlF2jLno=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ismf6U4fXpczuPBpStI/dhL/k3fO72ht6KRyFEq3OtbDsb7BBHTZTaE0erbDVzC4u
	 oJ6nReZPzrY/6cFt6lJOp32wn8i4ocAXYv1XkvlNkHJeZpHXc6Wxv/iKu5CbxMU50t
	 Tk1ZOjfvOuaWzAs1L6eSWk9xPBbHs0wSs8Ao7kViFp9kiu41XBxG7W1ThOEdqejsbA
	 0aAfS0oMx/zlDAXPJYileHlzNnj8Mkq5fDf3MdvcQpQo4Dm1o4veEIcjw7+mJGRLmO
	 B5Yd4Z1+U1CRMYcOo58bL/0t+LInZpUfKolhdUkTRTwW33gK56jbRkumBPqAv4PG3w
	 nZLfoFYlWk4KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E1E840CBC;
	Sat, 15 Aug 2026 01:26:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0289A2BB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD49640BD2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XVeVws6hxxM6 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 15 Aug 2026 01:26:15 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B9D0740BC0
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9D0740BC0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lDtQDs4L
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9D0740BC0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786757175; x=1818293175;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DqNEJHngMI5Aj5jr60He9n9Z3oFvJWI3UNo7njmOW+Q=;
 b=lDtQDs4L5abQXokODX4bqBGbtt0OcoxR69IECLuJdzdp3HNPzK9ve9ed
 /qeF1tn7QT8YKDNO9UZJfL6ehyutgS89tyRtiy5ObvQuWcMsQw3zmW3u+
 G1uhpg3ED4RCtOP2fW1DsD6i5KasqFmaGrienBMYrj8S7VduSDjTMpfsx
 ysT4CfAI1KYOW7WlPr70hsQeM6r0n7UsXrLKuILWSkGaqD1Z3Sz+6NoI0
 1Djf2NJkRvNDUD3qys+qxsvo6BLvSCJjlQp9FUxxIl/2Rz3ee7NBMZV+R
 7FcQzbExmvyGBxCF9/HCdmGLZOT1L/SpdZUa6V2Wp4r/gdMk99bStVzts g==;
X-CSE-ConnectionGUID: Xy6V5Z24SNmBHFvnv0LRgQ==
X-CSE-MsgGUID: VMNDIJSsQjyT9Izqvb/+HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87194382"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; d="scan'208";a="87194382"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 18:26:15 -0700
X-CSE-ConnectionGUID: K9lZFHETTEmkRuXx7ows8A==
X-CSE-MsgGUID: 102eXBiAT3GQbhGdICh7jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; d="scan'208";a="287844739"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2026 18:26:14 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Fri, 14 Aug 2026 13:49:18 -0400
Message-ID: <20260814174919.4177289-3-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260814174919.4177289-1-paul.greenwalt@intel.com>
References: <20260814174919.4177289-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Intel-wired-lan] [PATCH iwl-next 2/3] idpf: add devlink info
 support
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add devlink info support for idpf, reporting:
  - serial_number: device serial number (DSN) for device identification
  - fw.mgmt.api: running version reporting driver-device communication
    version

This enables NIPA CI and other tools to uniquely identify devices under
test and track device capabilities. This phased implementation initially
focuses on stable, readily available information (serial number and
virtchnl version from negotiation). Firmware version information will be
added in future patches as support is exposed through virtchnl and the
driver architecture allows reliable retrieval.

$ devlink dev show
pci/0000:85:00.0

$ devlink dev info pci/0000:85:00.0
pci/0000:85:00.0:
  driver idpf
  serial_number 00-a0-c9-ff-ff-23-45-67
  versions:
      running:
        fw.mgmt.api 2.0

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Link: https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system#device-information
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 Documentation/networking/devlink/idpf.rst     | 29 +++++++
 Documentation/networking/devlink/index.rst    |  1 +
 drivers/net/ethernet/intel/idpf/Makefile      |  1 +
 .../net/ethernet/intel/idpf/idpf_devlink.c    | 79 +++++++++++++++++++
 .../net/ethernet/intel/idpf/idpf_devlink.h    | 45 +++++++++++
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 12 ++-
 6 files changed, 164 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/networking/devlink/idpf.rst
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.h

diff --git a/Documentation/networking/devlink/idpf.rst b/Documentation/networking/devlink/idpf.rst
new file mode 100644
index 000000000000..9262844a1b3f
--- /dev/null
+++ b/Documentation/networking/devlink/idpf.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+idpf devlink support
+====================
+
+This document describes the devlink features implemented by the ``idpf``
+device driver.
+
+Info versions
+=============
+
+The following table lists the version reported by the ``idpf`` driver.
+
+.. list-table:: devlink info versions implemented
+    :widths: 5 5 5 90
+
+    * - Name
+      - Type
+      - Example
+      - Description
+    * - ``fw.mgmt.api``
+      - running
+      - 2.0
+      - 2-digit version number (major.minor) of the communication channel
+        (virtchnl) used by the device.
+
+The driver also reports the PCI Device Serial Number through the
+``serial_number`` attribute.
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index e371be30b99e..09e49b74712c 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -85,6 +85,7 @@ parameters, info versions, and other features it supports.
    hns3
    i40e
    ice
+   idpf
    ionic
    iosm
    ixgbe
diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 4aaafa175ec3..81b27a406747 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_IDPF) += idpf.o
 
 idpf-y := \
 	idpf_dev.o		\
+	idpf_devlink.o		\
 	idpf_ethtool.o		\
 	idpf_idc.o		\
 	idpf_lib.o		\
diff --git a/drivers/net/ethernet/intel/idpf/idpf_devlink.c b/drivers/net/ethernet/intel/idpf/idpf_devlink.c
new file mode 100644
index 000000000000..70de76c88aa5
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_devlink.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 Intel Corporation */
+
+#include "idpf.h"
+#include "idpf_devlink.h"
+
+/**
+ * idpf_info_get_dsn - format the DSN as the serial number
+ * @adapter: the idpf adapter structure
+ * @buf: buffer to store the formatted serial number
+ */
+static void idpf_info_get_dsn(struct idpf_adapter *adapter, char *buf)
+{
+	u8 dsn[8];
+
+	/* Copy the DSN into an array in Big Endian format */
+	put_unaligned_be64(pci_get_dsn(adapter->pdev), dsn);
+
+	snprintf(buf, IDPF_DEVLINK_INFO_LEN, "%8phD", dsn);
+}
+
+/**
+ * idpf_devlink_info_get - get IDPF devlink info
+ * @devlink: devlink instance structure
+ * @req: the devlink info request
+ * @extack: extended netlink ack structure
+ *
+ * Callback for the devlink .info_get operation. Reports information about the
+ * device.
+ *
+ * Return: zero on success or a negative error code on failure.
+ */
+static int idpf_devlink_info_get(struct devlink *devlink,
+				 struct devlink_info_req *req,
+				 struct netlink_ext_ack *extack)
+{
+	struct idpf_adapter *adapter = devlink_priv(devlink);
+	char buf[IDPF_DEVLINK_INFO_LEN];
+	int err;
+
+	idpf_info_get_dsn(adapter, buf);
+	err = devlink_info_serial_number_put(req, buf);
+	if (err)
+		return err;
+
+	snprintf(buf, sizeof(buf), "%u.%u",
+		 adapter->virt_ver_maj, adapter->virt_ver_min);
+
+	err = devlink_info_version_running_put(req, "fw.mgmt.api", buf);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static const struct devlink_ops idpf_devlink_ops = {
+	.info_get = idpf_devlink_info_get,
+};
+
+/**
+ * idpf_adapter_alloc - allocate devlink and return adapter
+ * @dev: IDPF device to allocate for
+ *
+ * Allocate a devlink instance for this device and return the private area as
+ * the adapter structure.
+ *
+ * Return: adapter structure on success, NULL on failure
+ */
+struct idpf_adapter *idpf_adapter_alloc(struct device *dev)
+{
+	struct devlink *devlink;
+
+	devlink = devlink_alloc(&idpf_devlink_ops, sizeof(struct idpf_adapter),
+				dev);
+	if (!devlink)
+		return NULL;
+
+	return devlink_priv(devlink);
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_devlink.h b/drivers/net/ethernet/intel/idpf/idpf_devlink.h
new file mode 100644
index 000000000000..ff18b4e7358d
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_devlink.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026, Intel Corporation. */
+
+#ifndef _IDPF_DEVLINK_H_
+#define _IDPF_DEVLINK_H_
+#include <net/devlink.h>
+
+#define IDPF_DEVLINK_INFO_LEN	128
+
+struct idpf_adapter *idpf_adapter_alloc(struct device *dev);
+
+/**
+ * idpf_devlink_free - teardown the devlink
+ * @adapter: IDPF adapter structure to free
+ */
+static inline void idpf_devlink_free(struct idpf_adapter *adapter)
+{
+	struct devlink *devlink = priv_to_devlink(adapter);
+
+	devlink_free(devlink);
+}
+
+/**
+ * idpf_devlink_register - register the devlink
+ * @adapter: IDPF adapter structure
+ */
+static inline void idpf_devlink_register(struct idpf_adapter *adapter)
+{
+	struct devlink *devlink = priv_to_devlink(adapter);
+
+	devlink_register(devlink);
+}
+
+/**
+ * idpf_devlink_unregister - unregister the devlink
+ * @adapter: IDPF adapter structure
+ */
+static inline void idpf_devlink_unregister(struct idpf_adapter *adapter)
+{
+	struct devlink *devlink = priv_to_devlink(adapter);
+
+	devlink_unregister(devlink);
+}
+
+#endif /* _IDPF_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 6f9579c39342..a1156b142119 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -3,6 +3,7 @@
 
 #include "idpf.h"
 #include "idpf_devids.h"
+#include "idpf_devlink.h"
 #include "idpf_lan_vf_regs.h"
 #include "idpf_virtchnl.h"
 
@@ -123,6 +124,8 @@ static void idpf_remove(struct pci_dev *pdev)
 
 	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
 
+	idpf_devlink_unregister(adapter);
+
 	/* Wait until vc_event_task is done to consider if any hard reset is
 	 * in progress else we may go ahead and release the resources but the
 	 * thread doing the hard reset might continue the init path and
@@ -181,7 +184,8 @@ static void idpf_remove(struct pci_dev *pdev)
 
 	idpf_decfg_device(adapter);
 	pci_set_drvdata(pdev, NULL);
-	kfree(adapter);
+
+	idpf_devlink_free(adapter);
 }
 
 /**
@@ -260,7 +264,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct idpf_adapter *adapter;
 	int err;
 
-	adapter = kzalloc_obj(*adapter);
+	adapter = idpf_adapter_alloc(dev);
 	if (!adapter)
 		return -ENOMEM;
 
@@ -346,6 +350,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_DELAYED_WORK(&adapter->stats_task, idpf_statistics_task);
 	INIT_DELAYED_WORK(&adapter->vc_event_task, idpf_vc_event_task);
 
+	idpf_devlink_register(adapter);
+
 	adapter->dev_ops.reg_ops.reset_reg_init(adapter);
 	set_bit(IDPF_HR_DRV_LOAD, adapter->flags);
 	queue_delayed_work(adapter->vc_event_wq, &adapter->vc_event_task,
@@ -365,7 +371,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	idpf_decfg_device(adapter);
 err_free:
 	pci_set_drvdata(pdev, NULL);
-	kfree(adapter);
+	idpf_devlink_free(adapter);
 	return err;
 }
 
-- 
2.52.0

