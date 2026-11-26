Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AC606A329
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=c3TuGlRb;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eHBBJ2Rf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9548B60B11;
	Thu, 26 Nov 2026 20:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zKJvoavmKL81; Thu, 26 Nov 2026 20:33:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 503D660B0F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725196;
	b=eqwSZ0FKvokqSBZSSjBUnn2REKBiEUCFis0dF6MuCqEmxs/agY8Mby4gW/dyFgKa8ofi
	 KiIrmYXHbM5LNXAxZ7H+7kQqRmXVX4eZ0THwBOs9DEzD6JIgqVyw0FgLdsp4q5qWwbSQH
	 1jPZrK32YVGxfr1q4B8NTabVY4P/OxpKcqK3VrScrqw5Q/vWRBQTUTP9YKPtIW2hLZ/5n
	 SUwGIqkPmQn+nejrKXCBhwO1bjwnMfKK68yTBK9AKyaG/IvMskkjiKUaW3+IyK21WKssj
	 WcU4eTX2DTNONyJ1Te5wzEg91rp870A3bQQk3IkzA229Iq98FbntR7T8T1vp+tkhAQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725196;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1gAIuUl3mzk4EiOubnRQz26vNXagbUlKxFHlUdsrkEo=;
	b=mbjoxZxllC6hGKPwW7GhISrFZx50dX68FaQwoyPmi7E/JvsuO6eMKiKs+otWkI1BmFbW
	 Fg3n/SKDjwtdfYb1expYnkJ4TLELtZ6jruV8d3/lGmDMqumCeYcSCha4jPK/Z1GSRqJdO
	 3B4KkS60+VWo35eQINNtXk+/Zg4wCJIUMzKCLfQbqGmBmv5s+6Eqj5V8y22LhcRwmAfRT
	 Pdb4VfQVbMdBDExawrnoai8+alFOTiGdwyT7GDZx62xbSk9fe8t9yFIuR5gGNpFiQOplu
	 kmkjMJSrsqA1Gkv4Y9ACGbpkMIHDTnB6CNBrd3dQVvhJT/SnwSkbzVAQCK67eecQwEA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725196;
	bh=1gAIuUl3mzk4EiOubnRQz26vNXagbUlKxFHlUdsrkEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c3TuGlRblN94FZCYD2pNVihdIEAE0pLkRvZNNh7itFT0Bewc+l/rDWCKjZEsynLTE
	 CkmGs3k8dKdGQNxODkh/ybJDvNm9dCjLQhHjrmeaqG7T4GRhjxB3yUtVe7+onl2J+j
	 ccR4095SphciKEpptFQZ6AzLbx+P/+dEOQY+DP6t5oc3DXv6ly8NZ6BIupN4+CEvzq
	 cexrXdU5xl2IkwLqWxl5exqrRwIb/uN23cOqn0jHlWYuYcE2ifrnp3HNhTkxgenUmz
	 sWWdaJIUnDGhyNfY/rNw3cMnByyZxL4HSB1Lu3tVUYn2EzbugrQ59gVmDSmkANB8VQ
	 QUDwa2sTf3wvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 503D660B0F;
	Thu, 26 Nov 2026 20:33:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BCDCD1AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3074409EB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIBUTYvxJgEn for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 494B9409E4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eHBBJ2Rf
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 494B9409E4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gAIuUl3mzk4EiOubnRQz26vNXagbUlKxFHlUdsrkEo=;
 b=eHBBJ2RfrI+UeZZWflrqTebl8kQCj2nzPS1Iqma14Z1EPbJTkrBCGgE/K/9h6uFY7lvGqB
 9sCTLIAWLY5Ape390hSqIyKUls8RX/ULoHudB+J3RrJQ4GH9idlKk/2MMCwIYAJyL+PxJd
 sXuBNWrRf+oNH8Mo88/csbkmQ0BlLDk=
X-MC-Rep: binary re single
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-CpEl3rhTMASG_hzVFsxNEA-1; Thu,
 26 Nov 2026 20:33:11 +0000
X-MC-Unique: CpEl3rhTMASG_hzVFsxNEA-1
X-Mimecast-MFC-AGG-ID: CpEl3rhTMASG_hzVFsxNEA_1795725188
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E9F919560AB; Thu, 26 Nov 2026 20:33:08 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87637180197A; Thu, 26 Nov 2026 20:33:01 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Min Li <min.li@microchip.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
Subject: [PATCH RFC net-next 04/19] dpll: add KUnit tests for pin links
Date: Thu, 26 Nov 2026 21:32:16 +0100
Message-ID: <20261126203231.934632-5-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: WWetFQHtRRf3aloCCYIVGjVB8ROTqmm0fb3Qq7APLOU_1795725188
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a KUnit suite with a mock driver of two owners that differ in
clock_id: a pin of one owner with a firmware node and a pin of the other
owner with a link to it. The tests check that:

- the link is reported for both pins only while both are registered,
  whichever of them is registered first
- the pin at the other end gets a change notification whenever the link
  appears or disappears
- a pin keeps its link when it is unregistered and registered again
- for a pin registered with two DPLLs of its owner, only the first
  registration and the last unregistration change the link
- a pin with neither a link nor a firmware node is not linked or notified
- a duplicate link is rejected, also on a registered pin, and a new
  link cannot be added to a registered pin

The tests build the pin message with dpll_cmd_pin_get_one() under
dpll_lock, so both are exported for KUnit.

Run them with:

  tools/testing/kunit/kunit.py run --kunitconfig=drivers/dpll

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/.kunitconfig       |   5 +
 drivers/dpll/Kconfig            |  16 ++
 drivers/dpll/Makefile           |   2 +
 drivers/dpll/dpll_core.c        |   2 +
 drivers/dpll/dpll_netlink.c     |   4 +-
 drivers/dpll/dpll_netlink.h     |   6 +
 drivers/dpll/tests/dpll_kunit.c | 419 ++++++++++++++++++++++++++++++++
 7 files changed, 453 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dpll/.kunitconfig
 create mode 100644 drivers/dpll/tests/dpll_kunit.c

diff --git a/drivers/dpll/.kunitconfig b/drivers/dpll/.kunitconfig
new file mode 100644
index 00000000000000..017c9d5b593a4f
--- /dev/null
+++ b/drivers/dpll/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_NET=y
+CONFIG_DPLL_KUNIT_TEST=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_PROVE_LOCKING=y
diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
index be98969f040ab6..6f1ffc3a6e7717 100644
--- a/drivers/dpll/Kconfig
+++ b/drivers/dpll/Kconfig
@@ -23,6 +23,22 @@ config DPLL_REFCNT_TRACKER
 
 	  If unsure, say N.
 
+config DPLL_KUNIT_TEST
+	tristate "KUnit tests for DPLL core" if !KUNIT_ALL_TESTS
+	depends on KUNIT && NET
+	select DPLL
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for the DPLL core. They use a mock driver to check
+	  that links between pins of two devices are reported and notified
+	  while the pins at both ends are registered.
+
+	  The mock devices and pins are registered with the DPLL subsystem,
+	  so user space sees them and their notifications while the tests
+	  run.
+
+	  If unsure, say N.
+
 source "drivers/dpll/zl3073x/Kconfig"
 
 endmenu
diff --git a/drivers/dpll/Makefile b/drivers/dpll/Makefile
index 9e7a3a3e592e81..ef3081be2a113b 100644
--- a/drivers/dpll/Makefile
+++ b/drivers/dpll/Makefile
@@ -8,4 +8,6 @@ dpll-y                  += dpll_core.o
 dpll-y                  += dpll_netlink.o
 dpll-y                  += dpll_nl.o
 
+obj-$(CONFIG_DPLL_KUNIT_TEST)	+= tests/dpll_kunit.o
+
 obj-$(CONFIG_ZL3073X)	+= zl3073x/
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 58a5a4a41a0b72..7fd84b0e90e993 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/visibility.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/idr.h>
@@ -21,6 +22,7 @@
 
 /* Mutex lock to protect DPLL subsystem devices and pins */
 DEFINE_MUTEX(dpll_lock);
+EXPORT_SYMBOL_IF_KUNIT(dpll_lock);
 
 DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
 DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 016f3026d2f2e5..931ea2027cf68f 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -6,6 +6,7 @@
  *  Copyright (c) 2023 Intel and affiliates
  *
  */
+#include <kunit/visibility.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -735,7 +736,7 @@ static int dpll_msg_add_pin_links(struct sk_buff *msg, struct dpll_pin *pin)
 	return 0;
 }
 
-static int
+VISIBLE_IF_KUNIT int
 dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 		     struct netlink_ext_ack *extack)
 {
@@ -811,6 +812,7 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 
 	return dpll_msg_add_pin_links(msg, pin);
 }
+EXPORT_SYMBOL_IF_KUNIT(dpll_cmd_pin_get_one);
 
 static int
 dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
diff --git a/drivers/dpll/dpll_netlink.h b/drivers/dpll/dpll_netlink.h
index 4f63aa58789a17..bc20bcd248a512 100644
--- a/drivers/dpll/dpll_netlink.h
+++ b/drivers/dpll/dpll_netlink.h
@@ -11,3 +11,9 @@ int dpll_device_delete_ntf(struct dpll_device *dpll);
 int dpll_pin_create_ntf(struct dpll_pin *pin, u64 src_clock_id);
 
 int dpll_pin_delete_ntf(struct dpll_pin *pin, u64 src_clock_id);
+
+#if IS_ENABLED(CONFIG_KUNIT)
+/* For KUnit tests, call with dpll_lock held for a registered pin */
+int dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
+			 struct netlink_ext_ack *extack);
+#endif
diff --git a/drivers/dpll/tests/dpll_kunit.c b/drivers/dpll/tests/dpll_kunit.c
new file mode 100644
index 00000000000000..7fb50fe0eea9a5
--- /dev/null
+++ b/drivers/dpll/tests/dpll_kunit.c
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for links between DPLL pins.
+ *
+ * Each test starts with two owners that differ in clock_id:
+ *
+ * Owner A: devices A0 and A1, pin P with firmware node F, pin U with
+ *          neither a firmware node nor a link
+ * Owner B: device B0, pin C with a link to F
+ *
+ * The devices are registered, the pins are not.
+ */
+
+#include <kunit/fwnode.h>
+#include <kunit/test.h>
+#include <linux/dpll.h>
+#include <linux/notifier.h>
+#include <net/netlink.h>
+
+#include "../dpll_core.h"
+#include "../dpll_netlink.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+#define DT_CLOCK_ID_A		0xd011a
+#define DT_CLOCK_ID_B		0xd011b
+#define DT_MAX_LINKS		4
+
+struct dt_dev {
+	struct dpll_device *dpll;
+	dpll_tracker tracker;
+	bool registered;
+};
+
+struct dt_pin {
+	struct dpll_pin *pin;
+	dpll_tracker tracker;
+	int changes;		/* DPLL_PIN_CHANGED notifications */
+};
+
+struct dt_ctx {
+	struct dt_dev a0, a1, b0;
+	struct dt_pin p, u, c;
+	struct fwnode_handle *fwnode;
+	struct notifier_block nb;
+	bool nb_registered;
+	bool p_a0, p_a1, u_a0, c_b0;	/* registrations */
+};
+
+static int dt_mode_get(const struct dpll_device *dpll, void *dpll_priv,
+		       enum dpll_mode *mode, struct netlink_ext_ack *extack)
+{
+	*mode = DPLL_MODE_MANUAL;
+	return 0;
+}
+
+static int dt_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
+			      enum dpll_lock_status *status,
+			      enum dpll_lock_status_error *status_error,
+			      struct netlink_ext_ack *extack)
+{
+	*status = DPLL_LOCK_STATUS_UNLOCKED;
+	return 0;
+}
+
+static const struct dpll_device_ops dt_dev_ops = {
+	.mode_get = dt_mode_get,
+	.lock_status_get = dt_lock_status_get,
+};
+
+static int dt_state_get(const struct dpll_pin *pin, void *pin_priv,
+			const struct dpll_device *dpll, void *dpll_priv,
+			enum dpll_pin_state *state,
+			struct netlink_ext_ack *extack)
+{
+	*state = DPLL_PIN_STATE_CONNECTED;
+	return 0;
+}
+
+static int dt_direction_get(const struct dpll_pin *pin, void *pin_priv,
+			    const struct dpll_device *dpll, void *dpll_priv,
+			    enum dpll_pin_direction *direction,
+			    struct netlink_ext_ack *extack)
+{
+	*direction = DPLL_PIN_DIRECTION_INPUT;
+	return 0;
+}
+
+static const struct dpll_pin_ops dt_pin_ops = {
+	.state_on_dpll_get = dt_state_get,
+	.direction_get = dt_direction_get,
+};
+
+static const struct dpll_pin_properties dt_pin_prop = {
+	.type = DPLL_PIN_TYPE_EXT,
+};
+
+static int dt_notify(struct notifier_block *nb, unsigned long action,
+		     void *data)
+{
+	struct dt_ctx *ctx = container_of(nb, struct dt_ctx, nb);
+	struct dpll_pin_notifier_info *info = data;
+
+	if (action != DPLL_PIN_CHANGED)
+		return NOTIFY_DONE;
+	if (info->pin == ctx->p.pin)
+		ctx->p.changes++;
+	else if (info->pin == ctx->u.pin)
+		ctx->u.changes++;
+	else if (info->pin == ctx->c.pin)
+		ctx->c.changes++;
+
+	return NOTIFY_OK;
+}
+
+static void dt_dev_init(struct kunit *test, struct dt_dev *dev, u64 clock_id,
+			u32 idx)
+{
+	int ret;
+
+	dev->dpll = dpll_device_get(clock_id, idx, THIS_MODULE, &dev->tracker);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev->dpll);
+	ret = dpll_device_register(dev->dpll, DPLL_TYPE_EEC, &dt_dev_ops, dev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	dev->registered = true;
+}
+
+static void dt_dev_fini(struct dt_dev *dev)
+{
+	if (IS_ERR_OR_NULL(dev->dpll))
+		return;
+	if (dev->registered)
+		dpll_device_unregister(dev->dpll, &dt_dev_ops, dev);
+	dpll_device_put(dev->dpll, &dev->tracker);
+}
+
+static void dt_pin_get(struct kunit *test, struct dt_pin *pin, u64 clock_id,
+		       u32 idx)
+{
+	pin->pin = dpll_pin_get(clock_id, idx, THIS_MODULE, &dt_pin_prop,
+				&pin->tracker);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pin->pin);
+}
+
+static void dt_pin_put(struct dt_pin *pin)
+{
+	if (!IS_ERR_OR_NULL(pin->pin))
+		dpll_pin_put(pin->pin, &pin->tracker);
+}
+
+static void dt_reg(struct kunit *test, struct dt_dev *dev, struct dt_pin *pin,
+		   bool *registered)
+{
+	int ret;
+
+	ret = dpll_pin_register(dev->dpll, pin->pin, &dt_pin_ops, pin);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	*registered = true;
+}
+
+static void dt_unreg(struct dt_dev *dev, struct dt_pin *pin, bool *registered)
+{
+	if (!*registered)
+		return;
+	dpll_pin_unregister(dev->dpll, pin->pin, &dt_pin_ops, pin);
+	*registered = false;
+}
+
+/* Fill @ids with the pins reported as linked with @pin, return their count */
+static int dt_links(struct kunit *test, struct dt_pin *pin, u32 *ids)
+{
+	struct sk_buff *msg;
+	struct nlattr *attr;
+	int n = 0, rem, ret;
+
+	msg = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, msg);
+	mutex_lock(&dpll_lock);
+	ret = dpll_cmd_pin_get_one(msg, pin->pin, NULL);
+	mutex_unlock(&dpll_lock);
+	if (!ret)
+		nla_for_each_attr_type(attr, DPLL_A_PIN_LINK,
+				       (struct nlattr *)msg->data, msg->len,
+				       rem) {
+			struct nlattr *id = nla_find_nested(attr,
+							    DPLL_A_PIN_ID);
+
+			if (id && n < DT_MAX_LINKS)
+				ids[n] = nla_get_u32(id);
+			n++;
+		}
+	nlmsg_free(msg);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_LE(test, n, DT_MAX_LINKS);
+
+	return n;
+}
+
+/* Check that @pin is reported as linked with @peer only */
+static void dt_expect_link(struct kunit *test, struct dt_pin *pin,
+			   struct dt_pin *peer)
+{
+	u32 ids[DT_MAX_LINKS];
+
+	KUNIT_ASSERT_EQ(test, dt_links(test, pin, ids), 1);
+	KUNIT_EXPECT_EQ(test, ids[0], peer->pin->id);
+}
+
+static void dt_expect_no_link(struct kunit *test, struct dt_pin *pin)
+{
+	u32 ids[DT_MAX_LINKS];
+
+	KUNIT_EXPECT_EQ(test, dt_links(test, pin, ids), 0);
+}
+
+static int dt_init(struct kunit *test)
+{
+	struct dt_ctx *ctx;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	test->priv = ctx;
+
+	ctx->fwnode = kunit_fwnode_create_software_node(test, NULL, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->fwnode);
+
+	dt_dev_init(test, &ctx->a0, DT_CLOCK_ID_A, 0);
+	dt_dev_init(test, &ctx->a1, DT_CLOCK_ID_A, 1);
+	dt_dev_init(test, &ctx->b0, DT_CLOCK_ID_B, 0);
+	dt_pin_get(test, &ctx->p, DT_CLOCK_ID_A, 0);
+	dt_pin_get(test, &ctx->u, DT_CLOCK_ID_A, 1);
+	dt_pin_get(test, &ctx->c, DT_CLOCK_ID_B, 0);
+	dpll_pin_fwnode_set(ctx->p.pin, ctx->fwnode);
+	ret = dpll_pin_link_add(ctx->c.pin, ctx->fwnode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ctx->nb.notifier_call = dt_notify;
+	ret = register_dpll_notifier(&ctx->nb);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ctx->nb_registered = true;
+
+	return 0;
+}
+
+static void dt_exit(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+
+	if (!ctx)
+		return;
+	if (ctx->nb_registered)
+		unregister_dpll_notifier(&ctx->nb);
+	dt_unreg(&ctx->a0, &ctx->p, &ctx->p_a0);
+	dt_unreg(&ctx->a1, &ctx->p, &ctx->p_a1);
+	dt_unreg(&ctx->a0, &ctx->u, &ctx->u_a0);
+	dt_unreg(&ctx->b0, &ctx->c, &ctx->c_b0);
+	dt_pin_put(&ctx->c);
+	dt_pin_put(&ctx->u);
+	dt_pin_put(&ctx->p);
+	dt_dev_fini(&ctx->b0);
+	dt_dev_fini(&ctx->a1);
+	dt_dev_fini(&ctx->a0);
+}
+
+/* The pin with the link is registered before the pin it names */
+static void dt_test_link_first(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+
+	dt_reg(test, &ctx->b0, &ctx->c, &ctx->c_b0);
+	dt_expect_no_link(test, &ctx->c);
+
+	dt_reg(test, &ctx->a0, &ctx->p, &ctx->p_a0);
+	KUNIT_EXPECT_EQ(test, ctx->c.changes, 1);
+	dt_expect_link(test, &ctx->c, &ctx->p);
+	dt_expect_link(test, &ctx->p, &ctx->c);
+}
+
+/* The pin named by the link is registered first */
+static void dt_test_link_last(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+
+	dt_reg(test, &ctx->a0, &ctx->p, &ctx->p_a0);
+	dt_expect_no_link(test, &ctx->p);
+
+	dt_reg(test, &ctx->b0, &ctx->c, &ctx->c_b0);
+	KUNIT_EXPECT_EQ(test, ctx->p.changes, 1);
+	dt_expect_link(test, &ctx->p, &ctx->c);
+	dt_expect_link(test, &ctx->c, &ctx->p);
+}
+
+/* The pin named by the link goes away and comes back */
+static void dt_test_peer_reregister(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+
+	dt_reg(test, &ctx->b0, &ctx->c, &ctx->c_b0);
+	dt_reg(test, &ctx->a0, &ctx->p, &ctx->p_a0);
+	KUNIT_EXPECT_EQ(test, ctx->c.changes, 1);
+
+	dt_unreg(&ctx->a0, &ctx->p, &ctx->p_a0);
+	KUNIT_EXPECT_EQ(test, ctx->c.changes, 2);
+	dt_expect_no_link(test, &ctx->c);
+
+	dt_reg(test, &ctx->a0, &ctx->p, &ctx->p_a0);
+	KUNIT_EXPECT_EQ(test, ctx->c.changes, 3);
+	dt_expect_link(test, &ctx->c, &ctx->p);
+}
+
+/* The link stays with its pin when the pin is unregistered */
+static void dt_test_link_reregister(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+
+	dt_reg(test, &ctx->a0, &ctx->p, &ctx->p_a0);
+	dt_reg(test, &ctx->b0, &ctx->c, &ctx->c_b0);
+	KUNIT_EXPECT_EQ(test, ctx->p.changes, 1);
+
+	dt_unreg(&ctx->b0, &ctx->c, &ctx->c_b0);
+	KUNIT_EXPECT_EQ(test, ctx->p.changes, 2);
+	dt_expect_no_link(test, &ctx->p);
+
+	dt_reg(test, &ctx->b0, &ctx->c, &ctx->c_b0);
+	KUNIT_EXPECT_EQ(test, ctx->p.changes, 3);
+	dt_expect_link(test, &ctx->p, &ctx->c);
+}
+
+/* Only the first registration and the last unregistration change the link */
+static void dt_test_peer_two_dplls(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+
+	dt_reg(test, &ctx->b0, &ctx->c, &ctx->c_b0);
+	dt_reg(test, &ctx->a0, &ctx->p, &ctx->p_a0);
+	dt_reg(test, &ctx->a1, &ctx->p, &ctx->p_a1);
+	KUNIT_EXPECT_EQ(test, ctx->c.changes, 1);
+
+	dt_unreg(&ctx->a0, &ctx->p, &ctx->p_a0);
+	KUNIT_EXPECT_EQ(test, ctx->c.changes, 1);
+	dt_expect_link(test, &ctx->c, &ctx->p);
+
+	dt_unreg(&ctx->a1, &ctx->p, &ctx->p_a1);
+	KUNIT_EXPECT_EQ(test, ctx->c.changes, 2);
+	dt_expect_no_link(test, &ctx->c);
+}
+
+/* A pin without a link and a firmware node is not linked or notified */
+static void dt_test_unrelated(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+
+	dt_reg(test, &ctx->a0, &ctx->u, &ctx->u_a0);
+	dt_reg(test, &ctx->b0, &ctx->c, &ctx->c_b0);
+	dt_reg(test, &ctx->a0, &ctx->p, &ctx->p_a0);
+	dt_unreg(&ctx->a0, &ctx->p, &ctx->p_a0);
+
+	KUNIT_EXPECT_EQ(test, ctx->u.changes, 0);
+	dt_expect_no_link(test, &ctx->u);
+	dt_expect_no_link(test, &ctx->c);
+}
+
+/* A duplicate link is rejected, also on a registered pin */
+static void dt_test_add_duplicate(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+	int ret;
+
+	ret = dpll_pin_link_add(ctx->c.pin, ctx->fwnode);
+	KUNIT_EXPECT_EQ(test, ret, -EEXIST);
+	dt_reg(test, &ctx->b0, &ctx->c, &ctx->c_b0);
+
+	kunit_warning_suppress(test) {
+		ret = dpll_pin_link_add(ctx->c.pin, ctx->fwnode);
+		KUNIT_EXPECT_EQ(test, ret, -EEXIST);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 0);
+	}
+}
+
+static void dt_test_add_registered(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+	struct fwnode_handle *other;
+
+	other = kunit_fwnode_create_software_node(test, NULL, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, other);
+	dt_reg(test, &ctx->b0, &ctx->c, &ctx->c_b0);
+
+	kunit_warning_suppress(test) {
+		KUNIT_EXPECT_EQ(test, dpll_pin_link_add(ctx->c.pin, other),
+				-EBUSY);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+}
+
+static struct kunit_case dt_cases[] = {
+	KUNIT_CASE(dt_test_link_first),
+	KUNIT_CASE(dt_test_link_last),
+	KUNIT_CASE(dt_test_peer_reregister),
+	KUNIT_CASE(dt_test_link_reregister),
+	KUNIT_CASE(dt_test_peer_two_dplls),
+	KUNIT_CASE(dt_test_unrelated),
+	KUNIT_CASE(dt_test_add_duplicate),
+	KUNIT_CASE(dt_test_add_registered),
+	{}
+};
+
+static struct kunit_suite dt_suite = {
+	.name = "dpll_pin_link",
+	.init = dt_init,
+	.exit = dt_exit,
+	.test_cases = dt_cases,
+};
+
+kunit_test_suite(dt_suite);
+
+MODULE_DESCRIPTION("KUnit tests for links between DPLL pins");
+MODULE_LICENSE("GPL");
-- 
2.56.1

