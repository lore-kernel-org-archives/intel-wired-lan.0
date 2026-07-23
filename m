Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8E8C531D4
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 14:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09DC4608F7;
	Thu, 23 Jul 2026 14:05:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a0MSZKFlom8n; Thu, 23 Jul 2026 14:05:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6998608FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784815554;
	bh=EJSVbQzeC6WNvyzEAD2OPMeMq8tHisEcWft/tom9rFc=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7K1np3VjT4PHVRZA7T4PBbAQN1XR1HiIkEfME6kzqhwpEMtTyu9N0W7z7Ux5tzJU4
	 M2Z7P8oJJMe4TCSfldx6IwTAUiK5gEB3oDtpcbyEg6HcEEfFYjWKq0GTxSVKLAlEV5
	 21fZnqa8YVhlyuk93WOUBlW9V5i8U92lbtwFyQbAlgLCUjma1qwRgSDe+VIRLX1EPA
	 ne6KreFJUdFb6s/bgDbaShd72rPrbBq+YCvX8j2s1uHKf9PRFuO9UF6vRKdWsjsLuw
	 VM8RF4aIxgY00UZa9uwiyWn9/mSuNftDFcZa9eCAGqPCx2Wz1R/xydaWi7gajg3dg8
	 eusjyi+S+mnvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6998608FC;
	Thu, 23 Jul 2026 14:05:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83F122E5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AD84407D2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N3JQgh-6M6_W for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 14:05:52 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1F43640956
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F43640956
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F43640956
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:05:51 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-gf3NFeieORePgQa1-vIdhw-1; Thu, 23 Jul 2026 10:05:49 -0400
X-MC-Unique: gf3NFeieORePgQa1-vIdhw-1
X-Mimecast-MFC-AGG-ID: gf3NFeieORePgQa1-vIdhw_1784815548
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-492488f8583so7217005e9.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 07:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784815548; x=1785420348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EJSVbQzeC6WNvyzEAD2OPMeMq8tHisEcWft/tom9rFc=;
 b=EHyHr98TSFe3UJoRZqQiVqR8b5YfGJhBAS6B3hma4bslqhFXTgmuRV5Oe3rdo1Oedk
 BDegf0Z0/+eizkVqlt/gg9aA5+pIfeuhP1gHihops+XiIyljGM0D59rnBt5s57fJRY41
 LNrbr24VAfE0YFth+QGiQaURS31Xvx/BkUSQiOz3wsx+B6JLgXoBCLjfxb4Jl+LYZ/uv
 oygXOgwk6yjh1fBfDlfI+9vENbHSt9inlvtBNbihkIUkRyPjSyV3Eml5PqF4vvs2woK9
 UNVImwvm+ZnOC3cALgxuJtGs4X0H2mUbp3DxUN8CswENA5G+oK1BTGvkn0iOvyazLI9E
 FXDg==
X-Gm-Message-State: AOJu0YzQHaJZWRIZQezoj8YBIZ4sLurn5NmNxRiLqT/mkBW7BJMSP0HD
 png1l+Z01pHFFtELZNtCjLiezLyG/QYy7G9IT6zp7YgPXEiADnR5RbgpwxLFPGByf8ZeLPi8Rmv
 OO91wm3BWomau/WBANJOW0OvtFJnCY//Fq8HLpHMzmDn2GZhB6j/jGNvmE4J5cGskFeAKVxvavj
 qWkx3Hp9ui/VSwlgr2HCoG80QlWWOfXJ46lc9UTFReJJcccmCGSYUerw==
X-Gm-Gg: AR+sD129PJX5cGicOCFv8GDnRX59q5+14+2F13r4GcrlO3WpZtpEruumaoPFXHIeb6O
 paClYVOJBnQdqWQhi8VEPvyCZJ1O5D2KEDzaj1RB16M3vL37P0eFxpKh+YavDVGZ6RIKbDo3vvT
 xg5JLS1K0PmmdxKBZDlOeawhBgu3A5hhjpJS0JrwhZeOtaB1qVMrGzIo2uOONyDHFojGodUtNVF
 hpiO00ElJ0ab1OCnZwH7GTaFpbsjo+QTc6WpLF2qYNZ5TCiv7OxJGt+LkUx3vmyjMVXqrutNvZD
 S8tNSQSCdPZo+icW9DkqRV6XSIrhI+uA8CWzdZP1bdSjGR9ZqmBUAiX8YHBLxzT9PmISbtxpSMJ
 6fp6HIDzoj3bRKQ==
X-Received: by 2002:a05:600c:8b41:b0:490:b8c0:d470 with SMTP id
 5b1f17b1804b1-49573cfc9ffmr45277075e9.19.1784815548034; 
 Thu, 23 Jul 2026 07:05:48 -0700 (PDT)
X-Received: by 2002:a05:600c:8b41:b0:490:b8c0:d470 with SMTP id
 5b1f17b1804b1-49573cfc9ffmr45276385e9.19.1784815547537; 
 Thu, 23 Jul 2026 07:05:47 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4aae16sm154261685e9.0.2026.07.23.07.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:05:46 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Mohammad Heib <mheib@redhat.com>
Date: Thu, 23 Jul 2026 17:04:16 +0300
Message-ID: <20260723140510.184819-3-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723140510.184819-1-mheib@redhat.com>
References: <20260723140510.184819-1-mheib@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gA8P0-cpL0nFWip1QY1iaxxrmmVQBdfJ8HO1Iv9xAP0_1784815548
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1784815551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJSVbQzeC6WNvyzEAD2OPMeMq8tHisEcWft/tom9rFc=;
 b=KOd4e93TJi4rz2s4VGzt+d10V1mhhPZQ72rctIWZ5KTSHnQYgdOgIhm9TKasZHfcMHk6eO
 BbYGmkTRVlsQUaeoIm1+kWuXJg4LIpjTIfJ45JQCUNb7yO2/EPsEqc7nD5tF5ykUFtCmuf
 HpUX695VLd5eRsxTPCgGbe5Ts/tOsxA=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KOd4e93T
Subject: [Intel-wired-lan] [PATCH iwl-next v4 2/3] i40e: add devlink
 parameter for Flow Director ATR sample rate
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

From: Mohammad Heib <mheib@redhat.com>

The i40e driver uses Flow Director ATR to periodically update flow
steering information for active TCP flows. The update frequency is
currently controlled by I40E_DEFAULT_ATR_SAMPLE_RATE and is fixed at
driver build time.

On systems with a large number of queues and high-rate TCP workloads,
the default sampling interval can result in frequent Flow Director
reprogramming for long-lived flows.

The amount of TCP packet reordering observed on some systems is
sensitive to the ATR sampling interval. Increasing the interval reduces
Flow Director programming activity and can significantly reduce the
associated reordering.

Since the optimal sampling interval depends on the workload and system
configuration, a single fixed value is not suitable for all deployments.

Add a devlink parameter to allow administrators to tune the ATR sample
rate at runtime without rebuilding the driver or disabling ATR
functionality entirely.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 Documentation/networking/devlink/i40e.rst     | 20 +++++++++++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 36 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index 51c887f0dc83..2cea98b631ba 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -40,6 +40,26 @@ Parameters
 
         The default value is ``0`` (internal calculation is used).
 
+.. list-table:: Driver specific parameters implemented
+    :widths: 5 5 90
+
+    * - Name
+      - Mode
+      - Description
+    * - ``atr_sample_rate``
+      - runtime
+      - Controls how frequently Flow Director ATR updates flow steering
+        information for active TCP flows.
+
+        ATR programs Flow Director entries based on sampled transmitted
+        packets. The sampling interval is specified as the number of
+        transmitted packets between ATR updates.
+
+        Lower values increase Flow Director programming activity, while
+        higher values reduce the update frequency.
+
+        Setting to ``0`` disables ATR sampling (no filters will be programmed)
+        The default value is ``20``.
 
 Info versions
 =============
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index 229179ccc131..6df7eb217073 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -33,12 +33,48 @@ static int i40e_max_mac_per_vf_get(struct devlink *devlink,
 	return 0;
 }
 
+static int i40e_atr_sample_rate_set(struct devlink *devlink,
+				    u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+	u32 sample_rate = ctx->val.vu32;
+
+	WRITE_ONCE(pf->atr_sample_rate, sample_rate);
+	return 0;
+}
+
+static int i40e_atr_sample_rate_get(struct devlink *devlink,
+				    u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+
+	ctx->val.vu32 = READ_ONCE(pf->atr_sample_rate);
+
+	return 0;
+}
+
+enum i40e_dl_param_id {
+	I40E_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
+};
+
 static const struct devlink_param i40e_dl_params[] = {
 	DEVLINK_PARAM_GENERIC(MAX_MAC_PER_VF,
 			      BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			      i40e_max_mac_per_vf_get,
 			      i40e_max_mac_per_vf_set,
 			      NULL),
+	DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
+			     "atr_sample_rate",
+			     DEVLINK_PARAM_TYPE_U32,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     i40e_atr_sample_rate_get,
+			     i40e_atr_sample_rate_set,
+			     NULL),
 };
 
 static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
-- 
2.53.0

