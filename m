Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40892606A321
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fkZW5fMt;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTRpjfSb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1447D40588;
	Tue, 24 Nov 2026 02:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n2ss2DcBEoCf; Tue, 24 Nov 2026 02:22:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 585B24068B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795486965;
	b=rxhiBEGb0FFeHPh3EKa4I7ha+N+BFsPo/O0XSMJdDljXe/Heo5a+msK4jx974w8C15Cg
	 DJ/9OFBXGgHSgOWpnyJ1QiO+ca6fyPK7jbEpEkLbOLNhGkfLQbKhjDy0dmnnDEAJlnMSY
	 ss+cVytm4kxqZN6Mq3LgBGrtCFdpnSEGoCwVmCBddclGdzip6mM/CK4BMPwPuBC5jdpOT
	 vfcR04mJes+go9XCQfC4H5PAzoW0qB5D7xQEuQYiZEUwWaYHZMgGDB8ILl05EaM6eGFCS
	 vG9oIP/P20hCQDwPEoZTvVEhQbNQocpo04j6jN1oc27Ip1B2cRSek0iLT7hRHu5tBPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795486965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rYPVDxBVvOltbNOoJmQqqACBIgbxppeZWxXwH8wg5Qs=;
	b=gWJ2wlEfVntuTR1wXZ+/Df23QWlE2dcyVwcVADIuJ3LX7607JU9z4hoVvM3pEKZqahHL
	 znSYTNF2iuK4dkr+gKyd7uL3sz249sfnIDc28tAYwVFSja6mAWh9v4CsPTOVPGXOsLJsd
	 u2WYaX3nChn4PHxRIB242x3zAXTMhN4N8EGWoAnsFjxNtYp8Js8WGWoLcYaJ/EDbMa+V0
	 dvplMr9sk1uyzIdPg+Lk4EpuuE5k2UJRgp4mJZaLU42H8C1gEvpsexyZBmy21NtnNNfLQ
	 pdHO2576b7D7M2HJTIl/F0ai7e8qMrayi79yXA9T+z8xhn/DJXYCdKRAXBaxkJiqEPA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=fail header.from=canonical.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTRpjfSb;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795486965;
	bh=rYPVDxBVvOltbNOoJmQqqACBIgbxppeZWxXwH8wg5Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fkZW5fMtzSeIphC6Md5VaJiS64DzqvnyKq0JeOdi6W1NU8xspZjwy/uUzLAd16MA3
	 eig9A6OhVygkC9VxRxbdwa2O/sK16aR4LHwxW4d2p5wN7fXSbYaZmIny5x1WcwNS4m
	 KJ0lUg5WmDfbrPXFzxJc3mu6SJuJwu+qLXyrZjXHd0qBNuOCiHPe/z0OD4rhG6nDGn
	 EnMu1oukj4eEgSomSt+tdiAvTILAambaqu0FohpKjfMiSpZfRw+daaglBcaFN8tHaA
	 Wy3mta5vH81dojnmSAuoatTvQVZ/RD/kNhpCv2113lGt5QfaoaYfuQBugTrTcTg4IS
	 paPFuTP5hBL8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 585B24068B;
	Tue, 24 Nov 2026 02:22:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0786AFBB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 02:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC9984068B;
 Tue, 24 Nov 2026 02:22:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id grKCQDUtNBKu; Tue, 24 Nov 2026 02:22:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BDC8B40588
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=acelan@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=fail (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=NTRpjfSb
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDC8B40588
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 02:22:42 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3b487f44ee0so1019090a91.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795486961; x=1796091761; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rYPVDxBVvOltbNOoJmQqqACBIgbxppeZWxXwH8wg5Qs=;
 b=NTRpjfSbeZAzjqDTJsGSC6mP3hCA93PXHW+4iKjc1K3kf4+iaaltHdwMnpXmBEvHJE
 CfQGbOkszq9BKMKDizuwNI2Bj72VDa95KE53YV0hscxl/n09ASJ8Mikn9OxCDjKnyIS8
 6UOkwl6AGRFcHrQarNrGFD35gytCMkFL06ho+VWHTgx8BJymeNrLDyJw5PUePX3Cmiuo
 Rm4H1njUAwQZV9vbBR9ZQMgVmFHE1LlOTpgP0Xe4Tyba66nJmc2xpHdGpRTI8dH4Ydkc
 +JA1zaOJtA+Rp+D0GTNHwaXiwlgcagWo7cNXOVyOKp3U82KVomX/tGvlXkHQJpg11XR+
 UrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795486961; x=1796091761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rYPVDxBVvOltbNOoJmQqqACBIgbxppeZWxXwH8wg5Qs=;
 b=WJ3azUFrDHTxz7PrkChOHtc9MuHwFRqcluxFz4owT/0L8JO8Bir/eXIgXxrrZxuEbQ
 v8kr6DK+qJgRMGdNzVz+SrJVh0bKPEV+pXZcxmXFSzs3OGMxlV+3DyKgTyullfvCv3j+
 8z+Ufv3927lCokmk0GIQGCFroe2w8rGxORiA35mpfUpnP1mrNj+SaSNYtH0hh5+VZ7PJ
 NTEvR6vJeBXFbHagwzIg7UeAonWgNL3EBkoQeK6QO9PwxLbFo9KTRrsKyS7+0Jz+03wP
 l+qVUIdOHRb5ddTxPyH8VHQYFw3BRQcUEDNsIqfXIEyofFuQW+Qh9Jf3ouv5cwCLykHL
 6JJg==
X-Gm-Message-State: APuU4Z9RNyyXaSN/h9Dd7rFRe5TKWnAbnjkPp9AS9eBqBqLM5P3PQbjY
 fwQPl3SKZ9fDjIjAHcrYe69KiluUQM1gcEvTkez8GQ9hfyJjtKIOILgJgRL28TQI
X-Gm-Gg: AZFdTZf6LjuyzQF1mlfDuaBlDKCUrgbgIGKisuqa/D+6JrH+b0MSffy75DRB3ZgmMaj
 JcPM1Vbc31sAQqn1Kwm9MXPBhF9aaT25d9L4PenMyS1+PeZHVjPNwFzIgl21vtJKhWrLv2kxQsw
 oOz3ZXlF9GDORNQ87UR79oEAtvIVMjhSvkjveWfFpej+xaTzexSRVU2scHi+Hr0FPc7QifAZFI1
 QKXY9lmJTF4TD+RCU92RpEfExZN90etRJrwRfu1ZRBofEYjq3KaxrbDFIgR5VUTFI2zzqapehgR
 LCFYz3yty6LVzciTs9lpSDGrOBjRw4lAEDVfXYdL0Y8zExmeRWQN6BIF/x9hI8F8mrbvhUHsBt5
 6I8snb91VoY7d5i21QF1DA4xPqD4YXPLMTn60tTzJsMVeJr4PnH/NXfQ2gFnHKW1wn/YllsGzqZ
 LjlTa45ZpNlAnBHD8d1IeeZ6cJSMhPshozG87DJWspViFbWd2wdPPUJR3kOzzvno0LFJ1UfxVAh
 NSDBFAu75WF1TQT06qb7opnJ4iFawb8rGK7mLJDWvvWbU+zTaYw2Ey/Z5qv6N6cWBpCWRuSs/Kn
 rbecoc5fnulDQFPj5OJyNdN+J2e3WU8UiCllUzWCiRwVhnusAqv4p+ADqncgsLonfDW09rGt/v/
 72WfX7lhF
X-Received: by 2002:a17:90b:2e8c:b0:3b3:b373:6a6a with SMTP id
 98e67ed59e1d1-3b41c9e45c3mr12662368a91.28.1795486961522; 
 Mon, 23 Nov 2026 18:22:41 -0800 (PST)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net.
 [211.75.139.220]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ecbd0bsm23559437a91.15.2026.11.23.18.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 18:22:40 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Ye Shu <hello@shuye.dev>, Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] e1000e: disable K1 by default on more MTL+ systems
Date: Tue, 24 Nov 2026 10:22:33 +0800
Message-ID: <20261124022233.1234651-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119001818.513503-1-acelan.kao@canonical.com>
References: <20261119001818.513503-1-acelan.kao@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Like the Dell Pro 5 Micro P5M1260 added by the previous patch, other
systems with an I219 on MTL or later no longer enter S0ix during
s2idle since commit 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake").
Every suspend ends with:

  intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!! (S0ix cnt=0)

Each unit ran 3 s2idle cycles on kernel 7.0 with the default K1
setting and, if all of them failed to reach SLP_S0, 3 more with
disable-k1 on. On the following systems the default cycles never
reached SLP_S0 and the disable-k1 cycles all did:

  Dell Pro 14 PC14250                       [8086:550a, 57a0]
  Dell Pro 3 14 P314260                     [8086:57b3]
  Dell Pro 3 16 P316260                     [8086:57b3]
  Dell Pro 5 14 P514260                     [8086:57b3]
  Dell Pro 5 16 P516260                     [8086:57b3]
  Dell Pro Max 14 MC14250                   [8086:57a0]
  Dell Pro Max 16 MC16250                   [8086:550a]
  Dell Pro Precision 5 14 PW514261          [8086:57b3]
  Dell Pro Precision 5 14S PW514260         [8086:57b3]
  Dell Pro Precision 5 16S PW516260         [8086:57b3]
  Dell Pro Rugged 10 Tablet RA00260         [8086:550e]
  HP ZBook 8 G1i (14/16 inch)               [8086:57a0, 57a1]
  HP EliteBook 6 G1i (13.3/14 inch)         [8086:57a0]
  HP EliteDesk 8 Mini G2i                   [8086:57b3]

Add these systems, matched by DMI vendor and product name, to
disable_k1_list so K1 is disabled by default. The HP entries match
the product family, which covers the screen size variants.

Cc: stable@vger.kernel.org
Fixes: 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake")
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index a8f0d3c0fd750..319c7a44f5a53 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -80,6 +80,104 @@ static const struct dmi_system_id disable_k1_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 5 Micro P5M1260"),
 		},
 	},
+	{
+		.ident = "Dell Pro 14 PC14250",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 14 PC14250"),
+		},
+	},
+	{
+		.ident = "Dell Pro 3 14 P314260",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 3 14 P314260"),
+		},
+	},
+	{
+		.ident = "Dell Pro 3 16 P316260",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 3 16 P316260"),
+		},
+	},
+	{
+		.ident = "Dell Pro 5 14 P514260",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 5 14 P514260"),
+		},
+	},
+	{
+		.ident = "Dell Pro 5 16 P516260",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 5 16 P516260"),
+		},
+	},
+	{
+		.ident = "Dell Pro Max 14 MC14250",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Max 14 MC14250"),
+		},
+	},
+	{
+		.ident = "Dell Pro Max 16 MC16250",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Max 16 MC16250"),
+		},
+	},
+	{
+		.ident = "Dell Pro Precision 5 14 PW514261",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Precision 5 14 PW514261"),
+		},
+	},
+	{
+		.ident = "Dell Pro Precision 5 14S PW514260",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Precision 5 14S PW514260"),
+		},
+	},
+	{
+		.ident = "Dell Pro Precision 5 16S PW516260",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Precision 5 16S PW516260"),
+		},
+	},
+	{
+		.ident = "Dell Pro Rugged 10 Tablet RA00260",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Rugged 10 Tablet RA00260"),
+		},
+	},
+	{
+		.ident = "HP ZBook 8 G1i",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ZBook 8 G1i"),
+		},
+	},
+	{
+		.ident = "HP EliteBook 6 G1i",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 6 G1i"),
+		},
+	},
+	{
+		.ident = "HP EliteDesk 8 Mini G2i",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteDesk 8 Mini G2i"),
+		},
+	},
 	{}
 };
 
-- 
2.53.0

