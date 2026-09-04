Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCBFC624D3
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 18:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84C4B40B0F;
	Fri,  4 Sep 2026 18:12:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EKQhlpLdabrA; Fri,  4 Sep 2026 18:12:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 566C540B3C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788545561;
	b=E+1TJT5UwXRpw1C0XG/od2bJWwmFq5N6r/8bg0f5xooEGWpjFuCWf7HZCTvyB+0PhmFv
	 3hrEhmsaBlSk+xqscrtS/zVrM7Avj72FmzF9xsU7y5R2k620XPpcUH57axVHYUX1EDBRw
	 1ASvrJlwPWzDLYyDiIz1Dn7OJ8frTLmLGmaoN6yW1MevnN8tdogF9WqWZYSXXh4auGNF9
	 vsDcFv0q5UcRCT+Q8VP8ZXbrJd45QsTtiPuzOHrzSQ1JNzz+NBIQbduMhbUI1uNbfAKlG
	 DI9x/8k6McILSq6ecrWZY7xqY4loXPmmLS0CND0XXzRz80dipk1E30P1tGEXIq+UjgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788545561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R7V/eoU+rd64ycrGvlsAM6ncuvv4vVdxeflSSHRexVM=;
	b=NLqdDkDYuxkyUN4wVaex977VmxG98Gr5dBMGeWRHggrWM5/aNAmFBCFtCIX4fvMibg4f
	 WKdExkzxpYFBSa9iwWCX0r/LOEpKAYnzmAdSgaTUdsRpQNfO5ebfSqaNzoj7OuMqg/hN0
	 f36tvfuPjkeQJA0Zxr1ShLWVNo3EHMeF8oEsr/PD8LrgCmr4QUMAz7sU3RK7XfnlT9ySc
	 Mh1fWBeGQwTdtu4scgLDTZ/MwaXcsMqTWxJ+PIhUf8mmZHjjsKrle1Uue/K3B9MqaPtn9
	 8gyjW2tZ8aLQU3bxaAGHenK3LF9hq4wjdKFO0eGjcd6+kh9YA3PgR+sFWDby73W7xUw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788545561;
	bh=R7V/eoU+rd64ycrGvlsAM6ncuvv4vVdxeflSSHRexVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I0N2cO+fOYq9GjSdRJ+FdbxSvyDIkrJKqVCHHVDl8KuHQXfKXVstrHjhEhigO76il
	 MSUFFfEe+rLW+Pu1Q0zW7M0kmEm8U4GFUc6FJTFoHECxNmqkeOi68Asn68+28SFIv8
	 4KnJHjIJ9OH/HJwmJnt7g6H0ixQdJ+I31IZqEEdBg3bzlpsczzRGKDo/6gR+qSGWYl
	 UfufLfmEwYdv1r6N067g4pprOFflII01SYY7irL5lvwYeAL1qU+spxmvxWtdjupgGk
	 XBcwdTBFBDqrpazfshU4Dz9GgJvvqRG6QI62kN2AdOwHve/8lLtJxtrACWyH9HQckY
	 OjXJlgD9RFAXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 566C540B3C;
	Fri,  4 Sep 2026 18:12:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D7BA463
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 18:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13E6660B6C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 18:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 40J_1sEF1G0s for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 18:12:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C46DB6070F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788545558;
 b=LoeHeq741IXSmHRP76D8tjjCJwzyJgNdc3wjKD5cvGoAFvkfi2s8ffu5dYHa04iC2emY
 Oj/p6NKeYa/wWoPJvw/sRooZxC9ex23GxR30OqiMXJJrY8eK4R1lm5ex6B4HoztHMHjo4
 dUZBVUYFkNwNCKoNCM/puXpHIZq58JSWiaqg4oY8Ocv+XM8vAZ9GYNU5BlkZeQ18+Ssp8
 dh0yZPlMIPUd6RepKuTnVc2ncSBCue+xOzqE9gQNzKHsAJ6qUJmwBxofodDgvn0UBseT7
 DgNsET74HtdISMtfm/tVP233SHpy+tvOT03Gnexn30aIDMyHb/sRsJdyW1fuNavSrKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788545558;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=R7V/eoU+rd64ycrGvlsAM6ncuvv4vVdxeflSSHRexVM=;
 b=aIn0d4PHJXO8sXxKwRxkascCSwNmn/OZMpji9pK9bXoQQSBiEOJEiPYc3NO8Z0WE6H0T
 X5IqSqrbdVW3e7PTquKqHzubI85gLnfor0MKG8+Y4pVIQngRm2eoSdWM9OYPhQUOfdY5O
 Mn50u8L/8rat5FcBu+jrLqhaDIQT1NmyYyGrxabrtY0TKuXcNyGe73Il3gvGpL6/PCVZt
 MMyzz3wVPzr+hF0A4rCO3VAVozlu8n5JXqTNvdP7nxcWFabDbW4CllZhRSTlj1u2b6yls
 WGrrL2NLwowPkeei4NriIr0Ttd3VEulFT0m8JXbr1Wk7Cp69dfiDmzgMW/HBlfDt0IQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R8qsM1wz; 
 arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R8qsM1wz
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C46DB6070F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 18:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788545558; x=1820081558;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=reSAekbHuAUa0dhMe++2/gB99tKjcz+T+Y3IlWVe9Xk=;
 b=R8qsM1wzQvaJvQ+M3WdPrzqXg8+0B61SfPXXJNk1/L2ztnobFWeDjUbw
 N36bzCfrPwc5SwUjR4fCG9AiOIYGAnqAbPiWJT6bW6IGrEyEFOooJsUBX
 SyNAuSkT8Sc72x6xNlf5ieINk4/94d69pUJ1wsnzrJX8cFE6F2pZ0aHqs
 WWfHSeo9WjeCJgi8TsHyO2tibZzlWBMghDKCID+ySy6sxklJwUrP1wLKa
 VUTw7lDt4fJTiSd9/1V1ZOhOJUBObBTuxkubSO37m3BPGoIU/rHqSXnD6
 k++rXzOMUgBc2hdgTWnt2ATiYq/uTI1FPNpe9fN+wrVBiVhedcotRTxMc g==;
X-CSE-ConnectionGUID: Zj48ftq3Qsyal1fFPWs0PA==
X-CSE-MsgGUID: wTAvExukQ8iWbsX8XIYDaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="99385444"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="99385444"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 11:12:38 -0700
X-CSE-ConnectionGUID: l/tLKz8qSFOMT+JKLQ+/MA==
X-CSE-MsgGUID: utWEvnvnT3G3TmSMZG6AfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="269577552"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by orviesa008.jf.intel.com with ESMTP; 04 Sep 2026 11:12:36 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v3 2/3] idpf: add devlink support
Date: Fri,  4 Sep 2026 06:37:13 -0400
Message-ID: <20260904103714.978256-3-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260904103714.978256-1-paul.greenwalt@intel.com>
References: <20260904103714.978256-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a devlink instance for the idpf adapter and implement the .info_get
callback, reporting:
  - serial_number: PCI Device Serial Number, for device identification
  - fw.mgmt.api: running version of the driver-device communication
    channel (virtchnl)

This enables NIPA CI and other tools to uniquely identify devices under
test and track device capabilities. This phased implementation initially
focuses on stable, readily available information. Firmware version
information will be added in future patches as support is exposed
through virtchnl and the driver architecture allows reliable retrieval.

The adapter structure is carved out of the devlink private area, so
devlink_alloc() replaces the plain kzalloc_obj() in idpf_probe() and
devlink_free() replaces the corresponding kfree() on both the probe
error path and in idpf_remove(). The instance is registered in
idpf_probe(), before the reset worker that performs the virtchnl
handshake is queued, and unregistered in idpf_remove(), so it stays
available for the whole time the driver is bound.

The serial number is omitted on devices that do not implement the PCI
Device Serial Number extended capability, where pci_get_dsn() returns 0,
rather than reporting an all-zero serial number. The virtchnl version is
omitted until it has been negotiated, as the instance is registered
before the handshake runs.

$ devlink dev show
pci/0000:85:00.0

$ devlink dev info pci/0000:85:00.0
pci/0000:85:00.0:
  driver idpf
  serial_number 00-a0-c9-ff-ff-23-45-67
  versions:
      running:
        fw.mgmt.api 2.0

Link: https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system#device-information
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 Documentation/networking/devlink/idpf.rst     | 30 ++++++
 Documentation/networking/devlink/index.rst    |  1 +
 drivers/net/ethernet/intel/idpf/Kconfig       |  1 +
 drivers/net/ethernet/intel/idpf/Makefile      |  1 +
 .../net/ethernet/intel/idpf/idpf_devlink.c    | 98 +++++++++++++++++++
 .../net/ethernet/intel/idpf/idpf_devlink.h    | 45 +++++++++
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 13 ++-
 7 files changed, 186 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/networking/devlink/idpf.rst
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.h

diff --git a/Documentation/networking/devlink/idpf.rst b/Documentation/networking/devlink/idpf.rst
new file mode 100644
index 0000000000000..5121cffd8f476
--- /dev/null
+++ b/Documentation/networking/devlink/idpf.rst
@@ -0,0 +1,30 @@
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
+The ``idpf`` driver reports the following versions
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
+``serial_number`` attribute, on devices that implement the PCI Device Serial
+Number extended capability.
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index d4a83fdcff7fe..538494b1051bd 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -85,6 +85,7 @@ parameters, info versions, and other features it supports.
    hns3
    i40e
    ice
+   idpf
    ionic
    iosm
    ixd
diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index 586df3a4afe90..4ee8bbc401fe6 100644
--- a/drivers/net/ethernet/intel/idpf/Kconfig
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -6,6 +6,7 @@ config IDPF
 	depends on PCI_MSI
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select DIMLIB
+	select NET_DEVLINK
 	select LIBIE_CP
 	select LIBETH_XDP
 	help
diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 4aaafa175ec37..81b27a4067478 100644
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
index 0000000000000..afdb5bc2e002c
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_devlink.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 Intel Corporation */
+
+#include <linux/pci.h>
+#include <linux/unaligned.h>
+
+#include "idpf.h"
+#include "idpf_devlink.h"
+
+#define IDPF_DEVLINK_INFO_LEN		128
+
+/**
+ * idpf_info_get_dsn - format the PCI DSN as the device serial number
+ * @adapter: the idpf adapter structure
+ * @buf: buffer to store the formatted serial number
+ * @buf_size: size of @buf
+ *
+ * Return: true if the device reports a DSN, false otherwise.
+ */
+static bool idpf_info_get_dsn(struct idpf_adapter *adapter, char *buf,
+			      size_t buf_size)
+{
+	u64 dsn = pci_get_dsn(adapter->pdev);
+	u8 dsn_be[sizeof(dsn)];
+
+	if (!dsn)
+		return false;
+
+	/* Copy the DSN into an array in Big Endian format */
+	put_unaligned_be64(dsn, dsn_be);
+	snprintf(buf, buf_size, "%8phD", dsn_be);
+
+	return true;
+}
+
+/**
+ * idpf_devlink_info_get - .info_get devlink handler
+ * @devlink: devlink instance structure
+ * @req: the devlink info request
+ * @extack: extended netlink ack structure
+ *
+ * Callback for the devlink .info_get operation. Reports information about the
+ * device. The virtchnl version is only reported once it has been negotiated,
+ * as the instance is registered before the handshake runs.
+ *
+ * Return: zero on success or a negative error code on failure.
+ */
+static int idpf_devlink_info_get(struct devlink *devlink,
+				 struct devlink_info_req *req,
+				 struct netlink_ext_ack *extack)
+{
+	struct idpf_adapter *adapter = devlink_priv(devlink);
+	char buf[IDPF_DEVLINK_INFO_LEN];
+	u32 maj, min;
+	int err;
+
+	if (idpf_info_get_dsn(adapter, buf, sizeof(buf))) {
+		err = devlink_info_serial_number_put(req, buf);
+		if (err)
+			return err;
+	}
+
+	maj = READ_ONCE(adapter->virt_ver_maj);
+	min = READ_ONCE(adapter->virt_ver_min);
+	if (!maj && !min)
+		return 0;
+
+	snprintf(buf, sizeof(buf), "%u.%u", maj, min);
+
+	return devlink_info_version_running_put(req,
+					DEVLINK_INFO_VERSION_GENERIC_FW_MGMT_API,
+					buf);
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
index 0000000000000..3ace09be8dddf
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_devlink.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2026 Intel Corporation */
+
+#ifndef _IDPF_DEVLINK_H_
+#define _IDPF_DEVLINK_H_
+#include <net/devlink.h>
+
+struct idpf_adapter;
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
index 3dbbe21459990..34a69bb2e36bc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -3,6 +3,7 @@
 
 #include "idpf.h"
 #include "idpf_devids.h"
+#include "idpf_devlink.h"
 #include "idpf_lan_vf_regs.h"
 #include "idpf_virtchnl.h"
 
@@ -127,12 +128,15 @@ static void idpf_remove(struct pci_dev *pdev)
 
 	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
 
+	idpf_devlink_unregister(adapter);
+
 	/* Wait until vc_event_task is done to consider if any hard reset is
 	 * in progress else we may go ahead and release the resources but the
 	 * thread doing the hard reset might continue the init path and
 	 * end up in bad state.
 	 */
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+
 	if (adapter->num_vfs)
 		idpf_sriov_configure(pdev, 0);
 
@@ -184,7 +188,8 @@ static void idpf_remove(struct pci_dev *pdev)
 	mutex_destroy(&adapter->vc_buf_lock);
 
 	idpf_decfg_device(adapter);
-	kfree(adapter);
+
+	idpf_devlink_free(adapter);
 }
 
 /**
@@ -263,7 +268,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct idpf_adapter *adapter;
 	int err;
 
-	adapter = kzalloc_obj(*adapter);
+	adapter = idpf_adapter_alloc(dev);
 	if (!adapter)
 		return -ENOMEM;
 
@@ -349,6 +354,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_DELAYED_WORK(&adapter->stats_task, idpf_statistics_task);
 	INIT_DELAYED_WORK(&adapter->vc_event_task, idpf_vc_event_task);
 
+	idpf_devlink_register(adapter);
+
 	adapter->dev_ops.reg_ops.reset_reg_init(adapter);
 	set_bit(IDPF_HR_DRV_LOAD, adapter->flags);
 	queue_delayed_work(adapter->vc_event_wq, &adapter->vc_event_task,
@@ -367,7 +374,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_init_wq:
 	idpf_decfg_device(adapter);
 err_free:
-	kfree(adapter);
+	idpf_devlink_free(adapter);
 	return err;
 }
 
-- 
2.52.0

