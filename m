Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48942CA9EC7
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Oct 2026 13:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D60640600;
	Sun, 11 Oct 2026 13:50:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rYkPpDFPgN4l; Sun, 11 Oct 2026 13:50:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 53A8440698
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791726626;
	b=Q/JQvAeKKROrJ2bvneoJiOq7I7qjgB6aUI8OJqZKZsWP0OcXqL1FeHuXNY5/JfTn56se
	 SkmUvc+3M6A7WqwOtzF6BdS68s2W0J1a1u2in9KyMFC7vC/lJw0N26VHClZaaB2ptNYJd
	 vdnebqIqkC8tbYYCLKAVPhLce+Xhw9OVcwYyisTcnwWLzGX0cnU+6/kniqhQxxDaMOp4+
	 vH15VbjHCqAfbWL2nuGQEr3q3z4Z48vm+frC8lTmdjL2BmFm7BDLJN/KElVmXFw+RoxDt
	 tr5g83vSX2pEZ/Q84+a7tOKVsglTPHly0qctIWtxt3abxycSRK2dgeeGKJU9+sibuTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791726626;
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
	b=kTDJeTQKkpQZYyw82yTQUGveGYvr7vsitAOFF6ogue/v99BBgt8DxffadzE/zL/VFCbd
	 Cj8P5HndHKYVXpHeu4DMVCyxLSJA8Z0LVPO5I33YtIP1Y4Jm/Le/8GT5aW2KgWpHMryDm
	 TnvgwLrvog6EKKU3+1NMNU3xjLZgUPlTGa5yoitJRJce2xZNshiXlXGoesky4Z+ax8i55
	 SCeln9eA2/m7T8/9PClEsjW2Gt8ig5BeGSkLPi/KA8ISRc0P+BmzD27PySx0dWpdgvEt4
	 3T/I8yFFOHD7emnajaeIxui0adxsStofcHMW0G/r8z+VX8dG0rBV7E5p5lDzDLrNvfg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791726626;
	bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oW7TpCLir1omS1TpuI/gVU+P8v8P73H89wmaxnb+G/C2Rcxi8TEqoGSKQvUefJvCb
	 jfq+47gWa8I6p8TuHr/Q2PRzvvzRNdMqvfJm5J2/nDayz8gDh1VDDtSvEpHOcx1Dhu
	 mqwK7kKv7YJkBIwCdmbtrBBDvSS+vyFgJFZfiLTSlVr8wXTn4CKNQkpepQt0m6MVA3
	 EgNgfl3CMO/A3fkbiK0rVgxq+yvCGvoAx0oPuWHULoVxnP4F4WS1BT1Pjn8KHiZ7gv
	 3L6PuNxBrKZaLhIX8wHm7YQlYfeExhWOc+y4ILIPinFMttqdPsA25Wu1dNocWlElcS
	 S5AJNUINyDZpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53A8440698;
	Sun, 11 Oct 2026 13:50:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E7771A6
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 13:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2045540071
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 13:50:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wj2Xl1hrb9kC for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Oct 2026 13:50:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0DEA24002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791726624;
 b=iRwOjP8u5CNUbf6pDfY6gA6xdkKX+GAWDcKHzTBEHNeHP/QGqsFpVVULIcWwrqaFHV6e
 INoSFIrCe5Yi5QlXTQEzSDhM9ijHgppmZGBTI2FFgwUR0+W/FOzaftSQeDk2jMMgQvowA
 yWmjelhj87VPt7IOJa3zlZkyKZhnyBqEEA+srU1rAds+V3GkWablddvDOSdTap8ZczYLD
 CxJh1d7hax549RtaGnw14jIG6XbUey/eQ39BgSnOxgG779ozf+EXpYbKDn/kFn/MCeMFw
 B/wA6fajZ3YTVKB/tx8crRtk6aSXDrEiLbXUWfsuIDYEXpF4wZ15GfCJkAvBOMw1j4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791726624;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
 b=Z1EyDkUhfLQRumV3YS5aelTt64KQTVoSywAezak4NC6MCaF8NXVKZlYPXEj/8jN3iybQ
 rblvwJEyyb0Jj1Xi3nBn55WwOmflp6OtTV1qDqOpCVfo07VN1O8VtCBqwewdgA2YfxJ+5
 2BwLFc5+ZqKOgn6puv1wWPBS5iEJyKweKOJbQDhyjnL5GAxxurh9TwgrZ21Uz8KwCkSzy
 mZrWuOF0E7K2o0bElLY/0QYQupAHfTqVmsOFQAFwuAfyQgWehQyrilfvmDaEsvvio/uE/
 2t8s2VALYN6WM5hHYvLzozMPdpCFL+aFIDlZU6ABGouIOwVzoiwmIdCboP27swpxTeg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="eyMk2x/v"; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=eyMk2x/v
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0DEA24002B
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791726622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
 b=eyMk2x/vS21n4aRQEaGS2qxd7sRSyvQUVOnWof8lMiHw2yNsgmZzexNm2tiKWE3OLwG29f
 k7IWOHJRPj50RP6ouhqM2I28n5xH4iUSJBmiduYv1YHMQIRFrzzqcuHKO2QtXZpmN2kldl
 fFR1Dr0bRcApDFUzFkgOdkj5DT7mqn0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-rK3GYrNLOy6nlMgOzVHkEg-1; Sun, 11 Oct 2026 13:50:20 +0000
X-MC-Unique: rK3GYrNLOy6nlMgOzVHkEg-1
X-Mimecast-MFC-AGG-ID: rK3GYrNLOy6nlMgOzVHkEg_1791726619
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e6b5c5f44so19467625e9.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 06:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791726619; x=1792331419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
 b=Y0yghmVjGShk85BrECffpMXzeJyP/PhmgyCXjsmGd8M7Kw9Zg4YJNsc6wRO4v8o+11
 OhBbwnkz6WuNukv0ALf81UBabg1hm8TRGZE3/luIgRZJ7iuKkP7zq6q1wZmYys1y9JY7
 TaiX1XmjJjT/0Ky5UU229LZI85vhiO/u8FB98l9F0qF6UlUR093CctXklMVoOwkeRY7b
 vgLdvesG4dntUJhai1SYn1I55/TY5JE9Y/nqMYGODuhb+Co0XF72nVBxuecqms5jKE+F
 Lqo3LU6hgmN1Fgo/fApDloZzswytsQVZKm+rqw2nd4mOdtHGLltGQ7pOLbvbDx4XdbH2
 C2bg==
X-Gm-Message-State: AFq9FYJm4hTNJtbk/JK2xuISPNbKB0+yVDTUBWR2be2nAFQ+w85Yzukr
 0WLfpX10ZvQHcGxCEhuR2XcM/WyHZCrscDsDEqHUQUzAeVonDPOx1aQR+vjD2M3Iju/NeCOOaYT
 GYjk+ZYsuWKI6NB2OJ2akvE6c9bQVUz43FKM9CW+VsOFBRiOARKobUOk8F5LYU5UwVDrQU0qTMl
 4/czvVhUpICQTqHp6PxFNH6stOPkFcIvXNqU5SV0hwgCnUfCx3dl/3BQ==
X-Gm-Gg: AYBFou0kEcY0YKsPbfkkrkYMb0MAol/BJQ1vfTEl9VdEgfmtW0qFx3HcRK7zB74Grgf
 iTwUmXjBfCre21Vs+bBKKSy1/nm0WryF+jrkZmPJYmucZ0kD9ZVdX2reZDedh5PFZrreOPSQWWX
 5y12bOKHX4WCQunFjnPhAiGET+a+zUsiLIpPDRl9LkxrRV4uOdABEGiGVfbQ/ScnJXFU3fEV1NQ
 kbNcLX1SJ9XB9mYlf2Od0VssnV70SFxn2SXdnHMUQVHewTRYchMascHxCgKrMLJMVgJT8+CCCTk
 V9VYlc4qQcuVw2ups2W2RcNxZoBRqEawqbXVvyUfMWRy6Oo07Yt6H6YbqPAsCBuS6CJcMlR3ibK
 eWJtc2AxXsc+IYfEuY44yqC0bJjVQN47/
X-Received: by 2002:a05:600c:c16f:b0:49f:ed8c:6cad with SMTP id
 5b1f17b1804b1-4a18e4ca869mr117267845e9.19.1791726619266; 
 Sun, 11 Oct 2026 06:50:19 -0700 (PDT)
X-Received: by 2002:a05:600c:c16f:b0:49f:ed8c:6cad with SMTP id
 5b1f17b1804b1-4a18e4ca869mr117267405e9.19.1791726618767; 
 Sun, 11 Oct 2026 06:50:18 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19f249692sm13334125e9.3.2026.10.11.06.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 06:50:18 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v6 2/2] i40e: add devlink parameter for Flow Director
 ATR sample rate
Date: Sun, 11 Oct 2026 16:49:52 +0300
Message-ID: <20261011134952.54887-3-mheib@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011134952.54887-1-mheib@redhat.com>
References: <20261011134952.54887-1-mheib@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lmngWOgiSoa7R1uufvbIu2871m2BgH_HK6U82rfZvTc_1791726619
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

