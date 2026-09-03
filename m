Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A40C624A4
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 16:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEE1340B0E;
	Thu,  3 Sep 2026 16:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ME9Z8RaBeFYO; Thu,  3 Sep 2026 16:03:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E48DC40B11
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788451405;
	b=sHEVKG374tN5VU08f3nnuMDdGdoFHdmtdXGDueYnwwIkvxO2jcrseXHQdfCYpsX9nLXq
	 uJJy4T8+QlaKQ5vaBO1maaUlGTn6R3W5YFgmanSozAaERyPX+Mx03qoFgqgxSumzliCjK
	 IbTzUwK6wvJ/g05kSfQGY25Zb9P9jBrsDGrhN8XTDDyv4MIHycgIfIQQHWDw5AjXlvDBR
	 eFRIXY3YhhmZe9dcHYvaPXVvFdJremsNsJKIY05k8sdGOLxb+VXldaoukJeDTJEfMePyJ
	 bCQRigfRPmdP1JjiXxz4KYJx0YcLv2/VSRHNhlVmaZDHShWyGeuroRxx2KSO2H8P9Nw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788451405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uGKL9Atpy3p6CHi7/myaGwilo4TnacHArZuaLIjfNh0=;
	b=J4vGcUqJwNyUydGe2B5Eaox//8tIktUK0orOqaqJDdCSb1+ahtEW3k9gGn2Qd7wMYAGl
	 lWaA9YI69pGq6cb3ANFKpWLtOqugvCdXUK6+crtDwVDHgQhsD6uVRScxfOFq9UwUa1ul3
	 w0hBw7sNm0fCwwcb2W7wdFA22OP/qoZu0tEGa15oUqSEMc/z3h1V9TYgwe8QXimGbQFgV
	 HDaYjMzxN0d3MdnZG+LWW2ElmfXrJey7BaitVEUsCv5KqYs6jMj592Y2mf6rz+S55+ysr
	 Ib9OmxPq2ktnPtuiIBiIlBKjcf9ZtGOrLmEbHK+mxXyjCx2RAgwBLGz5Oip5uremw5Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="X2/W05lP";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788451404;
	bh=uGKL9Atpy3p6CHi7/myaGwilo4TnacHArZuaLIjfNh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3bAA31dNGM/Q0USaADHg5+h/NhakB9KX9tPi6S69csuJ74vlcuiyhl5gR6vR6QvA0
	 FM/qSBm4V3mIaZ4hGE+qjx4bg/uE7ClnV2w5/qN/jYnDwbxdzhz5jZMfYqM/Mzvd2s
	 zFBwWCxdOruKgyNeZU0c2vrto4WYMQnFlzi362tFpDTSxyU0UxCZgJMtD1Y7sXCV3n
	 dYbWA8KamfdfPD0T9Ksf10azVplfbjoNq1yG17xqXmipyIZe0liJNf4lyYyA7yR2bf
	 hM4e77VRQBQi0t6Fy7iGy95isRlDYDmli4Rck8K9/Rgf261hf8E/pMcvn9YX4K+Csb
	 E/IEHlwTy8clA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E48DC40B11;
	Thu,  3 Sep 2026 16:03:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E44482FD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D65F840B1C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzD3c-0pW5vQ for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 16:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C5A4E40B0F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788451400;
 b=j/63CvHblXcrxMBKsUGt5NtlYrSAU/sMs5uEHlO+fA5MMNxjfJvillsEKDM/YGjx9ATs
 a7kt4Hb6Yx2Ps6iHeZStswHowNFuZjwiOjKREwnUxdKmNs81Y/X17m7hmagvfwPflaLV/
 oEtITewfDAIrXYdD91PG77HV4Qrn5wYIOja6Fn6/wiaSBzJ/OwOCj1x8CUWp+BiOr44Ct
 oQjDpSpYBc8TeG/mWxfbxX/FmMq7pv7M+egMMdBVRWp9rpm8rZ40He3q2LqgKozjdWlE5
 pq/GfTMu5/Dgqkt0v1kig+6GD3X1ERkjfv9xGoMDEtShoeXlD4/7vXT0Wf5DycIMQig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788451400;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=uGKL9Atpy3p6CHi7/myaGwilo4TnacHArZuaLIjfNh0=;
 b=JFR0CkWqyMO22yzPurzGtm0izIcQ70eK70ETOdmXtjKm/eXJcOO7ykHZKji427lmV9xH
 rqkwhhWYA20sMyU5o4JcxGJKw6mdAXUO0E234gJznm14aBx2HPMD3IrYGSt7UxwVZhvlN
 KgX8bFP7UbJO7yzIPmPSTEGZqK7foV11eAxWfREc202NBdCuS0x8r+O4xg4YSHwqXApBV
 bFmX21gQMcNTEdT3OtpVpZQkRImygwdbI4z+u8o0kDkXcdTWOekg+nKT0LVfoBji+tADl
 xyak7RX7w9oQJ7Hmb8nWW2rnRWqx7P+/yXcCK4C+ou2lLRr+AkQIEoY9Csbih9xtDXA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="X2/W05lP"; 
 arc=none smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=X2/W05lP
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5A4E40B0F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788451401; x=1819987401;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W4YP93/DgpQKBhXh3b1WUKsLED9iW9euunfgDxqqMkw=;
 b=X2/W05lPip50ih+7rbETWLZZfK0e99csvce5rC+qPZWACTc7iTndltoL
 4O2x5ggTPU+JfVl1Xoi+0p9K3itDm0JiPq7U8/YgeuRRWx5eYDV2kxR5d
 rRHDwzqqJcam94sE3A8H3Hx6Fhgr5kOdomXJNGKNmu34OtLoMZCYtFJBB
 jvLVZ4kaC+6UMNfxo+23/ShcFOCkdCc9+Ad2ZW7Ke8/X6y2RyHeg2w53N
 AiO2LbJUQKNa22FGIZ1dI1lpWY9kbruZ+H6SlmqxyyqjdKqQfl21zkxQF
 mdrQAPxEYlWX5rFqGwFOCjx7XyGvAmMXG9+GUTrzX25FX2Il0vw39L942 A==;
X-CSE-ConnectionGUID: +h5X4blaT3GhnGz2EPoLMA==
X-CSE-MsgGUID: gsStZx/WSqeFWnZoDna4jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76492958"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="76492958"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 09:03:21 -0700
X-CSE-ConnectionGUID: TLsDDHGbRpu6oZjc8mZdcQ==
X-CSE-MsgGUID: FVrZ6RyYQqav2YNzE0OtEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="293270212"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by fmviesa002.fm.intel.com with ESMTP; 03 Sep 2026 09:03:20 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v2 3/4] idpf: add devlink info support
Date: Thu,  3 Sep 2026 04:27:41 -0400
Message-ID: <20260903082742.43837-4-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260903082742.43837-1-paul.greenwalt@intel.com>
References: <20260903082742.43837-1-paul.greenwalt@intel.com>
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

Implement the devlink .info_get callback for idpf, reporting:
  - serial_number: PCI Device Serial Number, for device identification
  - fw.mgmt.api: running version of the driver-device communication
    channel (virtchnl)

This enables NIPA CI and other tools to uniquely identify devices under
test and track device capabilities. This phased implementation initially
focuses on stable, readily available information. Firmware version
information will be added in future patches as support is exposed
through virtchnl and the driver architecture allows reliable retrieval.

The serial number is omitted on devices that do not implement the PCI
Device Serial Number extended capability, where pci_get_dsn() returns 0,
rather than reporting an all-zero serial number.

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
 Documentation/networking/devlink/idpf.rst     | 30 +++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 .../net/ethernet/intel/idpf/idpf_devlink.c    | 65 +++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 Documentation/networking/devlink/idpf.rst

diff --git a/Documentation/networking/devlink/idpf.rst b/Documentation/networking/devlink/idpf.rst
new file mode 100644
index 000000000000..91e25b872f4f
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
+``serial_number`` attribute, on devices that implement the PCI Device Serial
+Number extended capability.
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index d4a83fdcff7f..538494b1051b 100644
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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_devlink.c b/drivers/net/ethernet/intel/idpf/idpf_devlink.c
index 1669bdfc950b..527c7714f9f7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_devlink.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_devlink.c
@@ -1,10 +1,75 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2026 Intel Corporation */
 
+#include <linux/pci.h>
+#include <linux/unaligned.h>
+
 #include "idpf.h"
 #include "idpf_devlink.h"
 
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
+ * device. The instance is registered only after the virtchnl handshake has
+ * completed, so the reported version is the one negotiated by the most recent
+ * successful handshake.
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
+	if (idpf_info_get_dsn(adapter, buf, sizeof(buf))) {
+		err = devlink_info_serial_number_put(req, buf);
+		if (err)
+			return err;
+	}
+
+	snprintf(buf, sizeof(buf), "%u.%u",
+		 adapter->virt_ver_maj, adapter->virt_ver_min);
+
+	return devlink_info_version_running_put(req,
+					DEVLINK_INFO_VERSION_GENERIC_FW_MGMT_API,
+					buf);
+}
+
 static const struct devlink_ops idpf_devlink_ops = {
+	.info_get = idpf_devlink_info_get,
 };
 
 /**
-- 
2.52.0

