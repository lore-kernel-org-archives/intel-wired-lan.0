Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B23606A31C
	for <intel-wired-lan@archiver.kernel.org>; Sun,  8 Nov 2026 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gHSo6n4v;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I6Pbp4HJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 895BF80D5A;
	Sun,  8 Nov 2026 14:45:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zGeAWBmksktu; Sun,  8 Nov 2026 14:45:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E623E80E15
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794149111;
	b=MNNygw5U/OyBUOxLj7e3gsH5VQ4NB90MtqyH2bq5cN8rSwzx6XwbJEhwHhNfLiH3URp+
	 CdrbLL/JvxqOlyeXAKbFAPhcXR9fRyNRlG4qrAzAuDb2B0fR9/H5PTkZNWHIofQTvZ9dK
	 CcGB/Ne3X1Eg/mHso9A5N1kTytCke7yuAx1DM+d8GhzFqmIacVAsxajdOnOn9ze01WUPs
	 TDO2GIypF57KKe56mWXO+lsW0hPhccFPmC9RKNtcAREBs+Hz8xz/0s0L2nb+Dc1K65Wpr
	 AhfF5ycGxevp5LwZgSyHMIzxBf16Y4C4h3v/YcJTwKcwgPOvEJUi5/gyBj0PwFb7Wfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794149111;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=P1OZhaVn4kdyUyav66dtw9HlE137AkiLOR3WFCa58MA=;
	b=E5QuLCwQOhgyHFtDI5QbNQtdRTKxQf/FEIXMm/G1uqJpyBe3dzoOuWQKvWSS+Fh391mj
	 6NV56T4uFdt8A4RUB1K6aaeZz6R9c+PSm2wn4OUvxCygTAjNi2JKC30damBgYoAcNybgN
	 qYgSQmnDZ32Z8PCFHDnvBat0LWbhsbGrD5ogOkiHVyaVhaljohhGv4lfRMlhXe6QDIjLe
	 mf9vFmc1bMheHvikvbx7rYgwHZEHZQARBXX5c/fIPvG43Zgr/yJNnSp7iOYNzJVKaa+4m
	 QW5WaK9ayTM1AWNYYbBc2dV/pe5NM8zx4YLSoXB3PpBVZPzI9phLM5EuYpll9FkVWjA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I6Pbp4HJ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794149111;
	bh=P1OZhaVn4kdyUyav66dtw9HlE137AkiLOR3WFCa58MA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gHSo6n4v6cwtDx2yllAy1kEIrUoX+zv3GwwSFS5vQkkEtDkOr7NXihKLwNGMGaAQu
	 Ea1z+hPcS7kFVf/JW2INX6IogjxyOFkLExrMI5nGHUWZyOcjq3Af0tohJIDZJSiVym
	 lIn+X9RbwhQUTAzH8/7d+CL+3dPvXeyQvKqk0/bKJfBb3SxhFOxbOwdQfyj7/mnYjz
	 EukV31xYOTasjo7j/1rp3bOJiq8sUod8VtrA0E4TKg7kuINfX3FCQpiEQ4++xQ8oxQ
	 JqTcxQkkDTt/skKewxJG3MC9YJfAOMwHkVsBCMDZ7scmaO58l+0F7IQagLBSBe4pQk
	 4jYwg/BTbVC3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E623E80E15;
	Sun,  8 Nov 2026 14:45:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B3079D1
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 14:45:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFFFA80E11
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 14:45:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tuNkf_a3OOGQ for <intel-wired-lan@lists.osuosl.org>;
 Sun,  8 Nov 2026 14:45:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0B3F380D5A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=I6Pbp4HJ
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B3F380D5A
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 14:45:08 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so82850f8f.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 08 Nov 2026 06:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794149107; x=1794753907; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P1OZhaVn4kdyUyav66dtw9HlE137AkiLOR3WFCa58MA=;
 b=I6Pbp4HJcQCOBUn9XAvoL0SHKd32oJNJKPARzidptX8Fv7LvoDC+teZiBW7T+mXWZp
 bl0kr10MGv01ugQAirxl3ZXDq5ntvQ4ZsLAJTxcjAFZfWZ6kRhPWW5tyIYLoyfgOrrTB
 QeF8Lwz10tMimUEjBPtrbM+nTT1cTMiUGCx/3pKFDQ0AdlQ6DMnjbbHtHD11zVxwnH2B
 vKb9L7gNrmlSApSz7CXBbN7EYn1qPbz+5B7N3DfnpVGyKrK47jPjt3Q6eydYD4bOBbCd
 JGb6bEF0m10PYUEbzgX8prk1lVDBxy+UyXzI0l0VUJFw8CcAXlytLoXUhdNI3OGfKOrT
 gl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794149107; x=1794753907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P1OZhaVn4kdyUyav66dtw9HlE137AkiLOR3WFCa58MA=;
 b=ILFyzQzmDTVK+/wiQCkE2vEMFiwOoEIpd9/yKIIb85Yw2FpOFcpPU6FPHWTHX13Tcl
 AyZiZd3mjc8mK02UN/7sLtSPs8vUYbz09N1X8yeG/LIJJJmm/UHPTQ4V2JDY4CPfdvwP
 yEqtrQUklHqCxlLzc5SxSF2BBpUkJWXhZdmepBKrdjG2Df85dMBSKLSy5TBGvtRtvW26
 vXnZCqZdkzW436paQTuFAq3gFQE6aF58j7XORiAwcR4yy2I/TmOp6Htw0TAANuvbJkNP
 h23HCplv4A6wselmzaoi/zpEVND7d1/osS5URhZoKF1mKln7VLyHkay94fhKF/JxW07E
 Onxg==
X-Gm-Message-State: APuU4Z+Pp5FqgvY+GxRxYkWCG9nojTq1psLOZ61sr+A78a9Yf+Q+GITe
 YUumL2Rz6mtdceaD6kpwXxzRSVT8xOBcq4+Y6la5PGEf8/X9XVex2HaCc/QDpXnz
X-Gm-Gg: AYBFou2hhfCLys6kIhsYZbVfcX8X+X3Wave2ARwxI128Jjp+ZvnQWAq9id2T6vDj/++
 mbzzyy5rDNkroLCSSsOq0F9dCPyOO0ZNObhSO2G2C0rpCPTIFFq3D/qA4lUKzpX5+5Zr2WBKzgc
 +LvWbeyxXH5BW6F1VO0cSxxaNjgNL/0yNNLnuhaFt6XgvxzSGE/uZHWjEtv6YTOmNSo66YX04bP
 aIq0ln9UBQjuWdiVdTjKNHC3HTSpj5Fbe1MWC5zg/8xGjZjM9rWt8pAKaW3nqCS/PJ3zP6gz30E
 YPXnfp97uMC8bS6dNgP3KlKQ0/Zx0akk91ofZRX35WXGw9FVU9Av+SXTaWc9fshkN43S1fWrBNZ
 dW8Pk/GaNMqSVezg4dAym9Ncw1CzTJOHruWs/6AychZU1SHlHCVu6hITv/Q3+pDXwGzbR8GbFjQ
 n5bUxssPEyc//pVrh6Jwitgba/XQJRTenuG6/BnqV2Uqpeu1/09u41YYmP2lyyDYtcOHNWkvPT/
 HPpERFRKxANs7nWNLtTZSn29tGw/Q4kt38ub9htzTemJgRmEtvYsoNn3UxjiktL9pA9Nq7NRubl
 qOA6PuPY9HffPbtC4Og5QyvgNxDebg2Hp7DKZlY2xQ60+YHkgaQHrn28QVx92hCHKN7kjIu6v5a
 wiA==
X-Received: by 2002:a05:6000:26ce:b0:48a:f404:695e with SMTP id
 ffacd0b85a97d-4958468f01cmr3735173f8f.50.1794149106284; 
 Sun, 08 Nov 2026 06:45:06 -0800 (PST)
Received: from raspi5eynotyarden3.home ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-495bf0772c1sm3074754f8f.18.2026.11.08.06.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 06:45:05 -0800 (PST)
From: Sasha Neftin <sashaneftin@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Sasha Neftin <sashaneftin@gmail.com>
Subject: [PATCH iwl-next v1 1/2] igc: remove unused extended wakeup filter
 definitions
Date: Sun,  8 Nov 2026 16:45:02 +0200
Message-ID: <20261108144503.97783-1-sashaneftin@gmail.com>
X-Mailer: git-send-email 2.47.3
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove unused IGC_WUFC_EXT_FLX9 through IGC_WUFC_EXT_FLX31 bitmask
definitions from igc_defines.h. These extended flexible wakeup filter bits
are not utilized by the driver.

Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 30 --------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index ab55b88d4d96..369aaccbd24e 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -26,13 +26,6 @@
 #define IGC_WUFC_BC		0x00000010 /* Broadcast Wakeup Enable */
 #define IGC_WUFC_FLEX_HQ	BIT(14)	   /* Flex Filters Host Queuing */
 #define IGC_WUFC_FLX0		BIT(16)	   /* Flexible Filter 0 Enable */
-#define IGC_WUFC_FLX1		BIT(17)	   /* Flexible Filter 1 Enable */
-#define IGC_WUFC_FLX2		BIT(18)	   /* Flexible Filter 2 Enable */
-#define IGC_WUFC_FLX3		BIT(19)	   /* Flexible Filter 3 Enable */
-#define IGC_WUFC_FLX4		BIT(20)	   /* Flexible Filter 4 Enable */
-#define IGC_WUFC_FLX5		BIT(21)	   /* Flexible Filter 5 Enable */
-#define IGC_WUFC_FLX6		BIT(22)	   /* Flexible Filter 6 Enable */
-#define IGC_WUFC_FLX7		BIT(23)	   /* Flexible Filter 7 Enable */
 
 #define IGC_WUFC_FILTER_MASK GENMASK(23, 14)
 
@@ -61,29 +54,6 @@
 
 /* Wakeup Filter Control Extended */
 #define IGC_WUFC_EXT_FLX8	BIT(8)	/* Flexible Filter 8 Enable */
-#define IGC_WUFC_EXT_FLX9	BIT(9)	/* Flexible Filter 9 Enable */
-#define IGC_WUFC_EXT_FLX10	BIT(10)	/* Flexible Filter 10 Enable */
-#define IGC_WUFC_EXT_FLX11	BIT(11)	/* Flexible Filter 11 Enable */
-#define IGC_WUFC_EXT_FLX12	BIT(12)	/* Flexible Filter 12 Enable */
-#define IGC_WUFC_EXT_FLX13	BIT(13)	/* Flexible Filter 13 Enable */
-#define IGC_WUFC_EXT_FLX14	BIT(14)	/* Flexible Filter 14 Enable */
-#define IGC_WUFC_EXT_FLX15	BIT(15)	/* Flexible Filter 15 Enable */
-#define IGC_WUFC_EXT_FLX16	BIT(16)	/* Flexible Filter 16 Enable */
-#define IGC_WUFC_EXT_FLX17	BIT(17)	/* Flexible Filter 17 Enable */
-#define IGC_WUFC_EXT_FLX18	BIT(18)	/* Flexible Filter 18 Enable */
-#define IGC_WUFC_EXT_FLX19	BIT(19)	/* Flexible Filter 19 Enable */
-#define IGC_WUFC_EXT_FLX20	BIT(20)	/* Flexible Filter 20 Enable */
-#define IGC_WUFC_EXT_FLX21	BIT(21)	/* Flexible Filter 21 Enable */
-#define IGC_WUFC_EXT_FLX22	BIT(22)	/* Flexible Filter 22 Enable */
-#define IGC_WUFC_EXT_FLX23	BIT(23)	/* Flexible Filter 23 Enable */
-#define IGC_WUFC_EXT_FLX24	BIT(24)	/* Flexible Filter 24 Enable */
-#define IGC_WUFC_EXT_FLX25	BIT(25)	/* Flexible Filter 25 Enable */
-#define IGC_WUFC_EXT_FLX26	BIT(26)	/* Flexible Filter 26 Enable */
-#define IGC_WUFC_EXT_FLX27	BIT(27)	/* Flexible Filter 27 Enable */
-#define IGC_WUFC_EXT_FLX28	BIT(28)	/* Flexible Filter 28 Enable */
-#define IGC_WUFC_EXT_FLX29	BIT(29)	/* Flexible Filter 29 Enable */
-#define IGC_WUFC_EXT_FLX30	BIT(30)	/* Flexible Filter 30 Enable */
-#define IGC_WUFC_EXT_FLX31	BIT(31)	/* Flexible Filter 31 Enable */
 
 #define IGC_WUFC_EXT_FILTER_MASK GENMASK(31, 8)
 
-- 
2.47.3

