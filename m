Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1664C606A32E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dDFVrEGL;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UUlWqf7A
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC4C660AC8;
	Thu, 26 Nov 2026 20:34:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gqb1e2cZ8oPc; Thu, 26 Nov 2026 20:34:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A7E360AE4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725297;
	b=FnfHP0VzYpjyhlgDmj253nx/wuGfBzgxqMDMfsbY+NTEuzuV4dXsakuktskCwkTDR2QA
	 wY8qT0hCAPVusiDX6ePUgtXpD9Sa19pTBju2h6WlEYOW/00AUHzuJ9+TtJh2WrsJ0BLL4
	 jNfh8dqj3nEsqLjZ8cH/zyMy7O+GB1+QdlSHpqyv5kwYDrHsvI9NlG+EGXsWYsm2uQmeC
	 DycXqN5PYjoFzh1dMDXAyFFMRHi4Eu2Nhub6xLPcGvZdctKmoi4VqkHzgUZnnUOOF6z5M
	 7ptgTm/aiqmSNpF7lJK0q96TrynIqsYjGrPJKDoI6RZZaXCPUMERW9xz2TA9waGDzxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725297;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZtIwCT3a4vXS9rYCNglRnCkULrvjfiTPxFncfyBIpu8=;
	b=MbIeYTP4cSxdXZ++MgCvHfUbiFgIhHrDRdMwbHpzntqma1z7WG00c/oYdQA3EMeqyf2X
	 3q9f6UsIbVnSU6iXrgCgvnoJUT/201BQFCE+zIX4uaQ0dv0E+UtzeEIJrU59JbdwTVR/s
	 jkeV+Zr1rKP08hUE+uYlkrHVDWSqvLq4melTv/LdJ8tyux2M4c0x/wz5xw5bSjL9RlCLg
	 vsrPQys4/ZlYeViU5GjghwQPbu+yJJ13JoIt3HTPC5Xqtef9fzqzCadyZGYn2dVo5SF6v
	 9ZWyzftfkOBX7l+zmRB+RFu73XyU448qPKvs40O2Fr4hVzbKV4EzabOMalk2Z1N+DuQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725297;
	bh=ZtIwCT3a4vXS9rYCNglRnCkULrvjfiTPxFncfyBIpu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dDFVrEGLi9ocBKiy54rvZ6DV4bTcHYws7iXpLUXxUjumWdMPvYrQdTeMz8xYrugax
	 83x61UINJHMOI9H7CH8BRZsm0m9z9IEOIno25qilmg3Es8bmRbat3SdKHINbj+9svI
	 HirL99DJqmjjt6botaF1WNdq3nAEvJoHHBS2jb3pDjsKkDYnx/RB8E+LeZmCtVhw8O
	 RUBfJIiRj5xG5Xb65YEzcJJsWb3KVKldxbphgwpcwhsCHxQ4/osiZ5HQCKVOs1SdTp
	 p2VpkPiV+6nVQtDnrr9mVqi+NzJumGEIxiJyU7ctGSlJDEcnY5i381h7DEmwB5n8tW
	 HcPNBLKwl4Kzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A7E360AE4;
	Thu, 26 Nov 2026 20:34:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01155311
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E713C4054A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ofcUqTn2Ma8I for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:34:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 00422400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UUlWqf7A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00422400CB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtIwCT3a4vXS9rYCNglRnCkULrvjfiTPxFncfyBIpu8=;
 b=UUlWqf7AEEQFIWEnYJR+YBZ4pwqXISZy+rntajpKBv93SbhrqGRMtDpUMPnJghhhbZ8RvU
 ENb85Z1qE6hn3A5sb5V6AzP8wLWZV9RXcZH22G7QmXrofSANQo+v8FO2DtkmpWYhDLVo4I
 yg0yhKjI3+lV7arrs+fbfOavlAW3JMk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-FnEJEt8UPi6lUpDlNIUToA-1; Thu,
 26 Nov 2026 20:34:51 +0000
X-MC-Unique: FnEJEt8UPi6lUpDlNIUToA-1
X-Mimecast-MFC-AGG-ID: FnEJEt8UPi6lUpDlNIUToA_1795725289
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB34D19560B2; Thu, 26 Nov 2026 20:34:48 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95BFD1801977; Thu, 26 Nov 2026 20:34:42 +0000 (UTC)
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
Subject: [PATCH RFC net-next 19/19] dpll: add KUnit tests for the pin owner
 checks
Date: Thu, 26 Nov 2026 21:32:31 +0100
Message-ID: <20261126203231.934632-20-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: _Npzq00p-gs-ulBtxVCzl2cOVjHZZu88D3G4tXMjpj4_1795725289
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check that dpll_pin_register() rejects a DPLL of another owner and a
DPLL that is not registered, that dpll_pin_on_pin_register() rejects a
parent pin of another owner and a parent pin registered with a DPLL
that is not registered any more, and that a pin of the owner is still
shared by its DPLLs and registered under its parent pin.

The checks are WARN_ON_ONCE(), so the tests suppress the warning without
counting it. A registration that is not rejected is undone, so the next
case does not get the registered pin and the failure stays in its case.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/Kconfig            |   4 +-
 drivers/dpll/tests/dpll_kunit.c | 150 +++++++++++++++++++++++++++++---
 2 files changed, 142 insertions(+), 12 deletions(-)

diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
index d57696652d450a..9be76330a1d1de 100644
--- a/drivers/dpll/Kconfig
+++ b/drivers/dpll/Kconfig
@@ -31,7 +31,9 @@ config DPLL_KUNIT_TEST
 	help
 	  KUnit tests for the DPLL core. They use a mock driver to check
 	  that links between pins of two devices are reported and notified
-	  while the pins at both ends are registered.
+	  while the pins at both ends are registered, and that a pin is
+	  registered only with the registered devices and the parent pins
+	  of its owner.
 
 	  The mock devices and pins are registered with the DPLL subsystem,
 	  so user space sees them and their create and delete notifications
diff --git a/drivers/dpll/tests/dpll_kunit.c b/drivers/dpll/tests/dpll_kunit.c
index 1804e5836f7db2..20bda0934acb1d 100644
--- a/drivers/dpll/tests/dpll_kunit.c
+++ b/drivers/dpll/tests/dpll_kunit.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * KUnit tests for links between DPLL pins.
+ * KUnit tests for links between DPLL pins and for the owner checks of pin
+ * registrations.
  *
  * Each test starts with two owners that differ in clock_id:
  *
  * Owner A: devices A0 and A1, pin P with firmware node F, pin U with
- *          neither a firmware node nor a link
+ *          neither a firmware node nor a link, MUX pin M
  * Owner B: device B0, pin C with a link to F
  *
  * The devices are registered, the pins are not.
@@ -40,9 +41,9 @@ struct dt_pin {
 
 struct dt_ctx {
 	struct dt_dev a0, a1, b0;
-	struct dt_pin p, u, c;
+	struct dt_pin p, u, c, m;
 	struct fwnode_handle *fwnode;
-	bool p_a0, p_a1, u_a0, c_b0;	/* registrations */
+	bool p_a0, p_a1, u_a0, c_b0, m_a0, u_m;	/* registrations */
 };
 
 static int dt_mode_get(const struct dpll_device *dpll, void *dpll_priv,
@@ -89,10 +90,29 @@ static const struct dpll_pin_ops dt_pin_ops = {
 	.direction_get = dt_direction_get,
 };
 
+static int dt_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
+			       const struct dpll_pin *parent_pin,
+			       void *parent_pin_priv,
+			       enum dpll_pin_state *state,
+			       struct netlink_ext_ack *extack)
+{
+	*state = DPLL_PIN_STATE_CONNECTED;
+	return 0;
+}
+
+static const struct dpll_pin_ops dt_child_ops = {
+	.state_on_pin_get = dt_state_on_pin_get,
+	.direction_get = dt_direction_get,
+};
+
 static const struct dpll_pin_properties dt_pin_prop = {
 	.type = DPLL_PIN_TYPE_EXT,
 };
 
+static const struct dpll_pin_properties dt_mux_prop = {
+	.type = DPLL_PIN_TYPE_MUX,
+};
+
 /* Stub of __dpll_pin_change_ntf() that counts the notifications */
 static int dt_pin_change_ntf(struct dpll_pin *pin)
 {
@@ -130,9 +150,9 @@ static void dt_dev_fini(struct dt_dev *dev)
 }
 
 static void dt_pin_get(struct kunit *test, struct dt_pin *pin, u64 clock_id,
-		       u32 idx)
+		       u32 idx, const struct dpll_pin_properties *prop)
 {
-	pin->pin = dpll_pin_get(clock_id, idx, THIS_MODULE, &dt_pin_prop,
+	pin->pin = dpll_pin_get(clock_id, idx, THIS_MODULE, prop,
 				&pin->tracker);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pin->pin);
 }
@@ -223,9 +243,10 @@ static int dt_init(struct kunit *test)
 	dt_dev_init(test, &ctx->a0, DT_CLOCK_ID_A, 0);
 	dt_dev_init(test, &ctx->a1, DT_CLOCK_ID_A, 1);
 	dt_dev_init(test, &ctx->b0, DT_CLOCK_ID_B, 0);
-	dt_pin_get(test, &ctx->p, DT_CLOCK_ID_A, 0);
-	dt_pin_get(test, &ctx->u, DT_CLOCK_ID_A, 1);
-	dt_pin_get(test, &ctx->c, DT_CLOCK_ID_B, 0);
+	dt_pin_get(test, &ctx->p, DT_CLOCK_ID_A, 0, &dt_pin_prop);
+	dt_pin_get(test, &ctx->u, DT_CLOCK_ID_A, 1, &dt_pin_prop);
+	dt_pin_get(test, &ctx->m, DT_CLOCK_ID_A, 2, &dt_mux_prop);
+	dt_pin_get(test, &ctx->c, DT_CLOCK_ID_B, 0, &dt_pin_prop);
 	dpll_pin_fwnode_set(ctx->p.pin, ctx->fwnode);
 	ret = dpll_pin_link_add(ctx->c.pin, ctx->fwnode);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -242,11 +263,16 @@ static void dt_exit(struct kunit *test)
 
 	if (!ctx)
 		return;
+	if (ctx->u_m)
+		dpll_pin_on_pin_unregister(ctx->m.pin, ctx->u.pin,
+					   &dt_child_ops, &ctx->u);
+	dt_unreg(&ctx->a0, &ctx->m, &ctx->m_a0);
 	dt_unreg(&ctx->a0, &ctx->p, &ctx->p_a0);
 	dt_unreg(&ctx->a1, &ctx->p, &ctx->p_a1);
 	dt_unreg(&ctx->a0, &ctx->u, &ctx->u_a0);
 	dt_unreg(&ctx->b0, &ctx->c, &ctx->c_b0);
 	dt_pin_put(&ctx->c);
+	dt_pin_put(&ctx->m);
 	dt_pin_put(&ctx->u);
 	dt_pin_put(&ctx->p);
 	dt_dev_fini(&ctx->b0);
@@ -404,7 +430,109 @@ static struct kunit_suite dt_suite = {
 	.test_cases = dt_cases,
 };
 
-kunit_test_suite(dt_suite);
+/*
+ * The checks are WARN_ON_ONCE(), so the tests suppress the warning without
+ * counting it. A registration that is not rejected is undone, otherwise the
+ * next case would get the registered pin from dpll_pin_get() and fail too.
+ */
+
+/* Expect the registration of @pin with @dev to be rejected */
+static void dt_expect_reg_rejected(struct kunit *test, struct dt_dev *dev,
+				   struct dt_pin *pin)
+{
+	int ret;
+
+	kunit_warning_suppress(test) {
+		ret = dpll_pin_register(dev->dpll, pin->pin, &dt_pin_ops, pin);
+		KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+		if (!ret)
+			dpll_pin_unregister(dev->dpll, pin->pin, &dt_pin_ops,
+					    pin);
+	}
+}
+
+/* Expect the registration of @pin under @parent to be rejected */
+static void dt_expect_on_pin_rejected(struct kunit *test,
+				      struct dt_pin *parent,
+				      struct dt_pin *pin)
+{
+	int ret;
+
+	kunit_warning_suppress(test) {
+		ret = dpll_pin_on_pin_register(parent->pin, pin->pin,
+					       &dt_child_ops, pin);
+		KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+		if (!ret)
+			dpll_pin_on_pin_unregister(parent->pin, pin->pin,
+						   &dt_child_ops, pin);
+	}
+}
+
+/* A pin is registered with the DPLLs of its owner only */
+static void dt_test_owner_register(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+
+	dt_expect_reg_rejected(test, &ctx->b0, &ctx->p);
+	dt_reg(test, &ctx->a0, &ctx->p, &ctx->p_a0);
+	dt_reg(test, &ctx->a1, &ctx->p, &ctx->p_a1);
+}
+
+/* A pin is registered under the parent pins of its owner only */
+static void dt_test_owner_on_pin(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+	int ret;
+
+	dt_reg(test, &ctx->a0, &ctx->m, &ctx->m_a0);
+	dt_expect_on_pin_rejected(test, &ctx->m, &ctx->c);
+
+	ret = dpll_pin_on_pin_register(ctx->m.pin, ctx->u.pin, &dt_child_ops,
+				       &ctx->u);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ctx->u_m = true;
+}
+
+/* A pin is registered with a registered DPLL only */
+static void dt_test_unregistered_dpll(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+	struct dt_dev a2 = {};
+
+	a2.dpll = dpll_device_get(DT_CLOCK_ID_A, 2, THIS_MODULE, &a2.tracker);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a2.dpll);
+	dt_expect_reg_rejected(test, &a2, &ctx->p);
+	dt_dev_fini(&a2);
+}
+
+/* A pin is registered under a parent pin with registered DPLLs only */
+static void dt_test_unregistered_parent_dpll(struct kunit *test)
+{
+	struct dt_ctx *ctx = test->priv;
+
+	/* The parent pin stays registered with a0 after a0 goes, as on E810 */
+	dt_reg(test, &ctx->a0, &ctx->m, &ctx->m_a0);
+	dpll_device_unregister(ctx->a0.dpll, &dt_dev_ops, &ctx->a0);
+	ctx->a0.registered = false;
+	dt_expect_on_pin_rejected(test, &ctx->m, &ctx->u);
+}
+
+static struct kunit_case dt_owner_cases[] = {
+	KUNIT_CASE(dt_test_owner_register),
+	KUNIT_CASE(dt_test_owner_on_pin),
+	KUNIT_CASE(dt_test_unregistered_dpll),
+	KUNIT_CASE(dt_test_unregistered_parent_dpll),
+	{}
+};
+
+static struct kunit_suite dt_owner_suite = {
+	.name = "dpll_pin_owner",
+	.init = dt_init,
+	.exit = dt_exit,
+	.test_cases = dt_owner_cases,
+};
+
+kunit_test_suites(&dt_suite, &dt_owner_suite);
 
-MODULE_DESCRIPTION("KUnit tests for links between DPLL pins");
+MODULE_DESCRIPTION("KUnit tests for links and owners of DPLL pins");
 MODULE_LICENSE("GPL");
-- 
2.56.1

