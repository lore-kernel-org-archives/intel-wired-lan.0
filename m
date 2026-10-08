Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2EDCA600B
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 13:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BE9540ACE;
	Thu,  8 Oct 2026 13:19:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mayAq5Ld9gpL; Thu,  8 Oct 2026 13:19:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 496A640AB9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791465547;
	b=sgv4p5edaE5//+IzjoQnCKVqthyldNYylumuqFER0+XppMkoNGSJwwxxF1e3qgy7CCLb
	 uWWKq9oPckDXhzpva7DWdpkglszbHWJGfj3pGSa3PxEx2EA8ZJOXhZDh51pFIBSd2JXXE
	 qf+VUBv9fJ4pBc2RUAuUdHIJi+Rds3T8U+qlpdEE0sDgXCZHjgFglWrrwNB0g11w/+uHX
	 HJxZXtoxs4c5FF9RJWveUcxNTHtxXTSqdAwT9jcHK5GQhjLZPYOC8ktcN6ceJEspzkeiM
	 q4YY4AbfMSuZEKFTtVPYLoo75PZKRQ6R8vpZ54EYhTHuf/sZfX9QcL/2tsMJ7IZknpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791465547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
	b=Llzse+wiREnjQldIj3QYTe7xQ4MVVEEdemLCuE7H/v1rmSAJA5X4TBmHOSPH5Cyel5EF
	 vnegaoM1kFNjIfo15DeMYwBQ5mIb3YZeAHETzsAMFr45JuRrY0J+WRJTh42BlcWr1LU9T
	 6yqYNfm6Ro9CFJfoN3P5hw63tgkXUaNBUX27ztH3n2hcIz8zrR/WB/oQe37Q7SIkUukQX
	 8/1/4lNKvGAnCTmx9K2JnVKFqIqbqQFwJ/Xb8IPPu221CqF7iQVgVQaDcioVUsM4wgdwD
	 36meCQV5/y2esg8kXaYVgHfYiQM6eFrsGOASkNE8QSU9j7HdxQ2/d1guSjrtZCbfahw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791465547;
	bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UsGIm5A//LuXgINREXc5hQxHUFcnmueteEMDWB8W6qpeEENRfViuCEtR7r+sojfIL
	 H0q54qRnZmQs4pyQOf8s10H7Wy8Ls93b0morqffjFytHdqLi8VBAUG1rv0FtKcCeaJ
	 NDK5KgWwhcIwVPFYcP/uiiP/xCMc3X/C+m7nIxeIxMtqOgAfLeWtQB1iwBpw9ZtReQ
	 ekPeNqhkfK32lUKer3QhPlHxG/Hi6OMPQ6eASkbP7thyi32FYpv1r+puP/Vd6QyjRC
	 APRkXWpCtv7L3bUtFW/f++NR7bYziEBxiaJ1lQ8vK3sHoe1kkJMc4kPekF+QAVwJtc
	 sakFl86vt3iDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 496A640AB9;
	Thu,  8 Oct 2026 13:19:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DCA234E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 13:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 841DC4043C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 13:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oKau9eYRPJyY for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 13:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5E21740059
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791465544;
 b=JwGHGEkoEgY2Xst3Firw9PggFaF/wSG8lxoQIrzdlLQ+NL7vF74RubtptsjjhTC0kaLv
 QRtkdPtHP1YrmNPr/seQAeDizQ2ZHmcVwfo6WkcDV+PO7v4gULyEFl1uvVpy15GZV1cFG
 HWW4IBBBkTWr+EDzF6CPVU6ofms1ryT4DyI8F9367FPhTDAvT50KYgJbyD6xrwlxHHWhj
 wpahDhdWhJaQ+7FTxigwjyW/spqktM5H1kWlWHytZcwMWMhgK+xUVFjaFDZONaPlgxB0w
 stHmdZqza/E9xHnyRf3Fy7remw9RbGKM52LbWgeOcJ6h1qJIi6kwf2Zs9d2MleAZs0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791465544;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
 b=mh1hx/0Y9nGDL3HvGUisCjsRla1QcFkUpOG1yJNTxXSWlkKMViupAIW6vJUq6w+pV9OC
 FMrAMyNxJwh/iLOc4NoPBBp9erTDZTzsnQS5eT0XRjB3Q3Lej6W0gOEORWIYhY/1IgCRw
 McSIF1tlH/lasPrlrqfdDInmUBujgVtrACvyWQKpq6339gM61vprluoKpkXB5OXx7l/hK
 0dF4+JTofhSYR7UEQ7AJgJytRfYdfgouNsFtL9YJtSleDT09oMmdSa01TKxXrCDCX/ILV
 QqFnyCLhex6+RMbdoNz0huag/RpzEYU8Vm5ddtvKjv6FoBeWme2ZvqO8ndSfziPwwRQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="C81Y3E/p"; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=C81Y3E/p
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E21740059
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
 b=C81Y3E/pPxG49sPS6rIEZPCB18WaqfgE9zlH+i3SoFiNk39Do9/h5EK7Ozs4Z0XbEKWDPr
 A2fd/SmmcPSW6t7ORU2+Mn6fdLoyxtK1bJTmo5juGWMzpfhViDKqIbHK8cHpOQprH4990f
 5OZ7+O1B8YpD92Tw3qDdohfoHIt+Ppk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-_uKGO4pMPHiC237ANgM9qA-1; Thu, 08 Oct 2026 09:19:00 -0400
X-MC-Unique: _uKGO4pMPHiC237ANgM9qA-1
X-Mimecast-MFC-AGG-ID: _uKGO4pMPHiC237ANgM9qA_1791465539
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a17c024b89so25713805e9.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 06:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465539; x=1792070339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
 b=hjwj7Qt1BonJoP2HxNkL39Dso/bgfoB39go3SzM4pKKT5QFEOtad/3Hm3DINXWXMkx
 /+FGF2TtPnWs2GIwWVGUl8/VZY3jTRlM+zKWnP0Lpy5IPsx/gKX45COyJagLu92NEktd
 NMTcByk2jJvsEC9HCyn4w2Ik0noIzxGzB+0oEabItrmbLjnnL7wzshmUTfxMp6jmKgHb
 nLkEyXZG1jyvtkQ4omBR7e9BxUSDNhRjq6IMiniGKV+eTOVQKon5ZfZvAjr5iaUsnC6J
 Tx+RF7nDIJr7OZgR0Lob4vxnKdxiRynTEArtTfuAW0MnT8DfgxniGO1uuT56bb1zm8y6
 I4kw==
X-Gm-Message-State: AFuF++ntEgMpPM3KaxJFV0+xURRrFE+fS9yr5xVsycwL/uz7cuBErqS6
 Aie552a9i6e3xfwzHo2A8FyLHHF99F275zDcNw7QkC4c2b/D2EkS/07/11sv9qiTd8Hq9VmFZf1
 kU5G9qKh4LHhFGNnG5b9dins7ujN9FwymaCSiKSQ66kM9EZRJ9Bm8xRF7ap0Rwnafd5IqUOP7kj
 wy+2PYdEGUZTw901FT7rC3jK/6awhPU83axidOS0mD8w9oJ9Sl/PA07A==
X-Gm-Gg: AYBFou3MGaSbxqedplZU8HhcRPTINi7nBRnQqXDyfQPkzUSrM2zG4xoZ0Vfjpl/wkAF
 UOEHzYCPts0UVjfhMPkr3Vs5/JmwcxNOrSQBHaq0eB+gYn5cik5ilgZcflo3Aj/uggshkAfFAbQ
 ZUPqFa0J298hXtdhXz05wkSzYkUHDH2nDvAZC65JJVtVuA5ixgrbqc+sg6lEgCMJAQhP1ASuBIV
 vzhzSAsKxvLl3pIOqCmJ7+vh3SY0ijEaq8dT2+tNKBbuWahnfmAtd9E3mh0zu8TA1tmjz+SSiAw
 OwJezMF5yl6kl3QFJwg9KtEyB+IZtGscjkvTurdBgwItGS1G/xm5YiJeZ3A2nZ81HsXzzL0OV4B
 5ZyPUPW/Dp8U4lVj63fx8mjxRskRY9g1Y
X-Received: by 2002:a05:600c:3b9a:b0:4a0:1feb:de6a with SMTP id
 5b1f17b1804b1-4a18045a4ccmr129984825e9.30.1791465539037; 
 Thu, 08 Oct 2026 06:18:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3b9a:b0:4a0:1feb:de6a with SMTP id
 5b1f17b1804b1-4a18045a4ccmr129983965e9.30.1791465538539; 
 Thu, 08 Oct 2026 06:18:58 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843e3356sm62947465e9.14.2026.10.08.06.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:18:58 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v5 2/2] i40e: add devlink parameter for Flow Director
 ATR sample rate
Date: Thu,  8 Oct 2026 16:18:24 +0300
Message-ID: <20261008131824.248508-3-mheib@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008131824.248508-1-mheib@redhat.com>
References: <20261008131824.248508-1-mheib@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HWdQxeC8B-e6XZRkBvNhODLd14qnaiNv27y5tLzFg7Q_1791465539
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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
 Documentation/networking/devlink/i40e.rst     | 21 +++++++++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 46 +++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index 51c887f0dc83..d280c17fe987 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -40,6 +40,27 @@ Parameters
 
         The default value is ``0`` (internal calculation is used).
 
+.. list-table:: Driver specific parameters implemented
+    :widths: 5 5 90
+
+    * - Name
+      - Mode
+      - Notes
+    * - ``atr_sample_rate``
+      - runtime
+      - Controls how frequently Flow Director ATR updates flow steering
+        information for active TCP flows.
+
+        ATR programs Flow Director entries based on sampled TCP packets
+        per Tx queue. The sampling interval is the number of TCP packets
+        transmitted on each queue between ATR updates.
+
+        Lower values increase Flow Director programming activity, while
+        higher values reduce the update frequency.
+
+        Setting to ``0`` disables ATR sampling (no filters will be programmed).
+
+        The default value is ``20``.
 
 Info versions
 =============
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index 229179ccc131..8af2487776f2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -33,12 +33,58 @@ static int i40e_max_mac_per_vf_get(struct devlink *devlink,
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
+
+	/* Setting rate to 0 disables sampling but does not remove
+	 * existing ATR entries. Flush them so stale filters do not
+	 * persist on devices without HW ATR eviction.
+	 */
+	if (!sample_rate) {
+		set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
+		set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
+	}
+
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
2.56.0

