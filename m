Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B9FC624D4
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 16:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8C8260B43;
	Thu,  3 Sep 2026 16:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6W2KH8dOkKTb; Thu,  3 Sep 2026 16:03:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 02B2860B8C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788451404;
	b=c0u9Lex3KfXtGShSIGb8lLb39PYIcCT2XjZ5ZgnKNbw8qlJniwcyMcocvaB3M8zzx+Y8
	 262shDTduf1T++nn2miJDqOKeRfX1JNXSh2jmX6x0sxQah/EhGYwmDqoIx6lYWGLxHZ66
	 OQrfPVMlg/G3DALQpoWqqYfVftCTJ3dJCj/4ZlXAfhHVsLh4kSfVlln0QtxuSRg07KoxL
	 Z7YmbwxS6Pq8fZ7pQ4ncEaUP2ppYIq0FM3DC87PPcz09zoiH3EmkVG6W/qf1hX/3KAlhy
	 VIMkAlYWaiuFpRjo9H6cfd63psdIfTneNKGFKos3XmkMEh11s5SJp1YYtxt7zms5dUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788451404;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=710srhC4gG/AYNBFkp9ZMf01pV5IAHrpGxV1Kl4y3KM=;
	b=aKjwM2vUQ27RPuRXQJLkLpW17N0wWgWX5Uv+1Yob1ZzthSvN+E0ecBbTcyVttcFDieHt
	 2U0Ae5JWWCKEUQkGePl+Q8AVh8S8fcQj4hq3RKKD/QztfJtPylZ0Uc5ppMq2E+VG4GX0D
	 fio8RDSqwY/LF/SSpZnwawDGCozpmg4sfcpy1ZYYpc2ZJgXiQty42zReS0xCXH4xXQOoB
	 QFI8iZS/iFmuXrB6U/9J+X8W5vkxWZkzuPl6Kp1zVb4imx79kBKtDjP7kZm0LS10xX1FZ
	 PBSm4x1GB+6BdQe2l2S8vFhEgKVLqnajZw8p9a3ltbJTbRSMBx1IlOJpsQP8uzPkFfQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=abjpiFHQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788451404;
	bh=710srhC4gG/AYNBFkp9ZMf01pV5IAHrpGxV1Kl4y3KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p3YmHBFQbcawtY/Qg9xrZvgAVFWqMWShTqLTNdSDd6UkD5XC4PYh50y9z/QcOhwjQ
	 jC73B8AGlMT/MzlEziN56xAd9pjLE+ih0pcdR36W3UswB3IfHSoqEnur34LfeeaGPl
	 uxqd9dLRACMmQGqx9EU1I7xBirX/YQfQe6mbulvFEpUCxCeb+yJfmXLk2xT8RdGw7x
	 h8SNjKNPVO7AqRaTHxLepBT2sGXOATzXl/eqG4/XzcgKDKrN9vqZ4zZgT+PBnLjkfP
	 5wm2QrCILLFKF8Suj8d6JmDIWcdvVuaqXrZNJo91F/ZiS3yGlAnyCVe5eGwU4C64Yq
	 6BObVrFARUO2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02B2860B8C;
	Thu,  3 Sep 2026 16:03:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AECC5279
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94AE060B43
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RkbBxkUmTPQe for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 16:03:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8746E607F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788451400;
 b=OmPokD34Y28uofwxF9A1chGPJSyQSqubEATZngeAPo494ECBbeQ32srBmt6dCc0RRwaS
 4xF2C83wx1Yixzc0IXZFj9K091PhNfG35GSsmLG4NRZY6wrQRWcZydlPzhRCPVzXrXQfq
 sqHOCg5+JgpeAnmqEshrXvMiNupl3myIud7VlvhRhBOXHuGTlEkJ+/HfKBj8NWqgcWspt
 XFTDM6TuCMU6s/iNn/tShqY9NuPINfNFdw9q/JYKxPlPSRQx1vWZot2Eu3cgMBPvXD91Y
 UmhjijHS0JG+XNL9vC1EmfPfTUrAKxknwVCHDvr7LTwkce1VoBJZVmzvZE650u+Ezew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788451400;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=710srhC4gG/AYNBFkp9ZMf01pV5IAHrpGxV1Kl4y3KM=;
 b=eO9KuohSBRaeZy+GCWmktgAhFo5jMyrLDiaOcawPhrazjPokHB/4TefHZmAwUKXixogj
 JCQ2hx/Y0faIoVcxjhiNThvqaLYgUuikR2UQcNLmCxGEsV5SlmWVYxr5pJSsBlwbrlM1t
 Y1ZeBEtv8jBjiv/3WbFselKDwTKeh5b34QhrE2C7yaC0I7HRuHN5zyDmJNtyL/3lACsiZ
 BGkRBeKZ0rkNmqDzIcUKwVI76uAil4qpoH/yvECwSwtoH3QqDRnZC8wVWPnryIdboPsRg
 X+iLQ3Zp/vNBaMfhW9yFT80NMejEjWyHguOqYNM3+HrNg9BbpWR1JjiItWT8qB/vP0A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=abjpiFHQ; 
 arc=none smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=abjpiFHQ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8746E607F5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788451401; x=1819987401;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JG5mn82ubqWcBMOFaq68GYTBVFf4chW8xRtW6VImgvU=;
 b=abjpiFHQC3IoTGmGEG6Yl0TY4LIi8goroUcIztUHz0P2JSuy+6jlHgNd
 Jr0uTWLiWvytgdExVa+VytkQQGc5pJobtjhfaEDBY5FQkujfnD4EifMuC
 Ve+wDZfWHCW32pvKJkgifER2uM+fg/p0Yzr3CeCAcE4WcLLnt0jIiA6kH
 DBbIzb1MQqdDvTQ0OD+PcOIri194H9Tvsl5S0HNdXJp3R0zAET/ZUDOXg
 2YfV5CFDwsFsoIO71r6YAPffdSYCgz2XgpoARdKbMW7sHw//4ipVspjjg
 D8mGU9ZmYXNnuMdlvjzbI1kvwzVToxGgSlYgkYD23XNz1fLGLz+Q9Mj4a A==;
X-CSE-ConnectionGUID: oMZiIgazQH2i2wBsFUQfFA==
X-CSE-MsgGUID: 2FcY8KZFT4mDOdWzA3T/0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76492954"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="76492954"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 09:03:20 -0700
X-CSE-ConnectionGUID: 53BrVZlVSV+cLASDOshafw==
X-CSE-MsgGUID: 5NwxMmNkTt6vebyIhHZ8CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="293270207"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by fmviesa002.fm.intel.com with ESMTP; 03 Sep 2026 09:03:19 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v2 2/4] idpf: add devlink support
Date: Thu,  3 Sep 2026 04:27:40 -0400
Message-ID: <20260903082742.43837-3-paul.greenwalt@intel.com>
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

Add a devlink instance for the idpf adapter. The adapter structure is
carved out of the devlink private area, so devlink_alloc() replaces the
plain kzalloc_obj() in idpf_probe() and devlink_free() replaces the
corresponding kfree() on both the probe error path and in idpf_remove().

The instance is registered from idpf_init_hard_reset(), once
idpf_vc_core_init() has succeeded, rather than from idpf_probe(). Device
information is only meaningful after the virtchnl handshake has
completed, and registering in idpf_probe() would expose the instance to
userspace while the adapter is still being brought up. Since
idpf_init_hard_reset() also runs for every function and PCI reset,
registration is guarded by IDPF_DEVLINK_REGISTERED so that it happens at
most once; devlink_register() warns on an already registered instance.

idpf_remove() unregisters only after cancel_delayed_work_sync() has
quiesced the init/reset worker, so the worker cannot register the
instance again after teardown has started, and only if registration
actually happened - a probe that never completed the handshake leaves
the instance unregistered, and devlink_unregister() warns in that case.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/idpf/Kconfig       |  1 +
 drivers/net/ethernet/intel/idpf/Makefile      |  1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  4 +-
 .../net/ethernet/intel/idpf/idpf_devlink.c    | 29 ++++++++++++
 .../net/ethernet/intel/idpf/idpf_devlink.h    | 45 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  8 ++++
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 15 +++++--
 7 files changed, 99 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.h

diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index 586df3a4afe9..4ee8bbc401fe 100644
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
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index df9e42bfeaa2..b72f31560fd2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -81,7 +81,7 @@ enum idpf_state {
 };
 
 /**
- * enum idpf_flags - Hard reset causes.
+ * enum idpf_flags - Adapter state flags
  * @IDPF_HR_FUNC_RESET: Hard reset when TxRx timeout
  * @IDPF_HR_DRV_LOAD: Set on driver load for a clean HW
  * @IDPF_HR_RESET_IN_PROG: Reset in progress
@@ -89,6 +89,7 @@ enum idpf_state {
  * @IDPF_MB_INTR_MODE: Mailbox in interrupt mode
  * @IDPF_VC_CORE_INIT: virtchnl core has been init
  * @IDPF_PCI_CB_RESET: Reset via the PCI callbacks
+ * @IDPF_DEVLINK_REGISTERED: devlink instance is registered with userspace
  * @IDPF_FLAGS_NBITS: Must be last
  */
 enum idpf_flags {
@@ -99,6 +100,7 @@ enum idpf_flags {
 	IDPF_MB_INTR_MODE,
 	IDPF_VC_CORE_INIT,
 	IDPF_PCI_CB_RESET,
+	IDPF_DEVLINK_REGISTERED,
 	IDPF_FLAGS_NBITS,
 };
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_devlink.c b/drivers/net/ethernet/intel/idpf/idpf_devlink.c
new file mode 100644
index 000000000000..1669bdfc950b
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_devlink.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 Intel Corporation */
+
+#include "idpf.h"
+#include "idpf_devlink.h"
+
+static const struct devlink_ops idpf_devlink_ops = {
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
index 000000000000..3ace09be8ddd
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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5d61ecb73a40..a375028c7080 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2023 Intel Corporation */
 
 #include "idpf.h"
+#include "idpf_devlink.h"
 #include "idpf_virtchnl.h"
 #include "idpf_ptp.h"
 #include "xdp.h"
@@ -1968,6 +1969,13 @@ static void idpf_init_hard_reset(struct idpf_adapter *adapter)
 	 * vports are not allocated at this point if the init task failed.
 	 */
 	if (!err) {
+		/* Expose the instance only once the device has been brought up
+		 * far enough to answer info requests. This runs on every hard
+		 * reset, so registration must happen at most once.
+		 */
+		if (!test_and_set_bit(IDPF_DEVLINK_REGISTERED, adapter->flags))
+			idpf_devlink_register(adapter);
+
 		idpf_attach_and_open(adapter);
 		idpf_idc_init(adapter);
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index fc67d8f02569..ba09a130f200 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -3,6 +3,7 @@
 
 #include "idpf.h"
 #include "idpf_devids.h"
+#include "idpf_devlink.h"
 #include "idpf_lan_vf_regs.h"
 #include "idpf_virtchnl.h"
 
@@ -134,6 +135,13 @@ static void idpf_remove(struct pci_dev *pdev)
 	 * end up in bad state.
 	 */
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+
+	/* IDPF_REMOVE_IN_PROG, set above, makes idpf_vc_event_task() return
+	 * early, so the instance cannot be registered again after this point.
+	 */
+	if (test_and_clear_bit(IDPF_DEVLINK_REGISTERED, adapter->flags))
+		idpf_devlink_unregister(adapter);
+
 	if (adapter->num_vfs)
 		idpf_sriov_configure(pdev, 0);
 
@@ -185,7 +193,8 @@ static void idpf_remove(struct pci_dev *pdev)
 	mutex_destroy(&adapter->vc_buf_lock);
 
 	idpf_decfg_device(adapter);
-	kfree(adapter);
+
+	idpf_devlink_free(adapter);
 }
 
 /**
@@ -264,7 +273,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct idpf_adapter *adapter;
 	int err;
 
-	adapter = kzalloc_obj(*adapter);
+	adapter = idpf_adapter_alloc(dev);
 	if (!adapter)
 		return -ENOMEM;
 
@@ -368,7 +377,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_init_wq:
 	idpf_decfg_device(adapter);
 err_free:
-	kfree(adapter);
+	idpf_devlink_free(adapter);
 	return err;
 }
 
-- 
2.52.0

