Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A5D606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 05:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=KvkZC7PM;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P+FRj5eF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A5176085F;
	Thu, 12 Nov 2026 05:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QxUzvLN2Ge8m; Thu, 12 Nov 2026 05:48:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6F76F60887
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794462500;
	b=K88BzEOdFKop7/bRt17XwhrSJ7yEMtZjsgI2XboCdQGY6GNg171D8Ea6/RJOi1lBP/ee
	 wnHwk0IGvkK0H3IIKvezxNZth7H70KS38XkU9PuYlA8t4HoEOk0Dcqyzeyh6yPKYe/2QX
	 q0Ivsxb52xlJz9x5ouaULYwUUvPop2R6bUw3+X8VY6bv7sCrNwEuveLswdo7UQMRPChzc
	 MLXwZBCfP8ZdpXtCUK9qJo9XWwEy4KqURwxI5GdxT76CIlArAGUIZcVCRqgIDqjbnxlpi
	 vssxyFyKouzT9r8CIfLl+6Ncy+TR1oo2FcBoemISOlBdHi0uaqCtzzLsFkZIHfKUoNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794462500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zpXkDnTS9bjtuid6N4ct4Azf72DO2P0s7WOZbFo6yg4=;
	b=j+sMgYXcoNsajWqBz+9D6yywMySgiyr+8Ggyce6aLMEAvugiFFnqgj2XnvQb2vpmnOE+
	 PAvX+MVy5MX5dulb9UBUUTRZtrXEidDFYlufVlArdPxOmhBaOqfEjTqiVDiQl8xyL84c2
	 sTkW6kxB9vqp8yVhb50Dr7DLKCMpqpj9ItUaP9hmObBjE4WMLdPZ1ALeDb2bX4Cf+aj0/
	 EYIV2qZhACwuDW1MoVq6sM7kGkuIjzASL7SOtWKFZ46V70bb0sGjlfv0dq280W+jvZ50l
	 yM6TGBtg+69KW7QkDWnXuShxShoPRROREo4FL/ZTrTd8bJEvKMq1esAEx7OO0PrEsAA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794462500;
	bh=zpXkDnTS9bjtuid6N4ct4Azf72DO2P0s7WOZbFo6yg4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KvkZC7PME+hvaMwWJWLDJ3XE+8pjpMj+GJTCctBOcspgHnB3cjHS4kf2VDioI8RcA
	 dDyW2jNHcwa1tDwFJQ0ZA9W3tjmTAlJ9/uaN92SNhNT/Lg5zS0oKF3+Lav4Td0D6TE
	 q5VdkOfy0Zk6lopPd78297AF7PdKEcCPDK8+ondycYdq8FZvdGwZYXPdlQTnL93lJM
	 cqKEmSHh8vEd0dIutaVLePQ/7xhh0zKMYe9myX/7l72W8wYfOrYSFby7iryk1POPwo
	 B29Py4eu63+GCHj227GBKI3QEzKff+xMifwENxLNoJyN33DhRj1ruFkmXqJ7y/mRFn
	 hncUYq/yu7rPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F76F60887;
	Thu, 12 Nov 2026 05:48:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 65F6E2FE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 05:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 576B081189
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 05:48:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cJWXk8ioeaK0 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 05:48:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C8F1810D1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=P+FRj5eF
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C8F1810D1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 05:48:16 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so2323987f8f.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 21:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794462495; x=1795067295; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zpXkDnTS9bjtuid6N4ct4Azf72DO2P0s7WOZbFo6yg4=;
 b=P+FRj5eFjYqoJ7sI0M4xEbIY4Kua4RiQUI7iFep67TfalVjlIBU7nutxniCGHLOENa
 1w9orBRyX33QnrHiiMhyV9gottgBHLYxR3NbyPk90AMS/PXCveWkMm2Bjl13myg9K9Yu
 F3/jgmo+kxu/FMORNr9hXQ1b2GCSJKf8cQP6mjyNkVdu40cEQiAaMGgkDf8UxSaH6a3N
 I5GU8G7rD8QE7yX5DzHVHwa6wkFwMmU7OjPU7QxMVY+Pehny33v9wyh/CLTkCTWPBq7z
 T2cOuBLD7v3KR6mSSZLJJZJQMAxEVced1D16pr9LbXkAnJTqKQo9RhGK371+PZJjWm0X
 fl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794462495; x=1795067295;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zpXkDnTS9bjtuid6N4ct4Azf72DO2P0s7WOZbFo6yg4=;
 b=dAGmmlZ6HczzQ+4tyofc7QRYkNFj4qRqC5EQJnCOiolscOsOead3Q4YOs/dIUjZBzR
 yReHAaSVaGG+zfblq4sgXnFE5BPoHElDQdsbzB64PX3GdUNyCcG/zZER09UqkQ7c/t8m
 bBngDaKpsNbgvWZA9NCXIm2yncLUq0Es6RuqbhNCze3FfXddHLWEXHfKNbGQ5tTDtq8S
 caWgai45+K3w1ph4ASIexSf9NNH5UJpwkvKq/m/byRoVxKq07hzyAoyNZjtMX07sW6jz
 zyR9KYY8ZhwYUzaToOsKmPbZLJUZ+ayKsYI0zS2u7v+qtFalhExTUbH6bNcuvxZKg5fU
 HhPA==
X-Gm-Message-State: APuU4Z8HswF6UFw65y2bMpYQAojwymllFvgFY8TrQAbdfNCDN0D4ew+4
 8KP2YwhGY0mwrnu7AgxMqMcTJLcCEuWKdSw/GztJ03CFexe+mRs3EdlJEyjjFjhn
X-Gm-Gg: AYBFou2i2J6+NCd8aYT95nco/Vd1twZDPSa8vEkmbrkif5Z7/aZDfZ0qDjdzyLrhxhp
 tM94m8ChigGTuKYKAGGSr9ms+dvlg3APr9rf+sp0EzWCBGaKm73BfFo9bHaCuKFtE19x8tK3wTI
 qV/4EC/NgYec4p5Ys8DJr3pCb6JQdNIE3WwQlHvFBCC1Kd9aKN9zhDhXegJwrqpIJX/vXitJdOH
 To4GaO2Bhf38yWUpUb/wqgcdUmwcK1tD0hQ3J/1f5G3e7dQszhaR5IKzEEpNzEUg1YTC7hYyeDR
 X1w7UPv1uGixR3KG6JKXZHpfbkeUY9QqCrQhBYcsIVls3IyBQcmXvtWZu2TfS+FEXSjS0QBgiRy
 0MoFoe/t//Lm5S0JQ9WbgK6hbHLH772VpjJ4sgZY2qwYg6Y+aXeWb11yf89Z67hh6b91ViPzuId
 S1uOTULt520NDwmAwh5HgcAmsiLsgXA4BXKXgUTxifXq/cX/L04GdEOPhEJ3YkQiGIBJ/FzziJI
 Q75JwUTH5ajMrAxIHyvHHmPHxAJT32DRCPBIUGfySBhi70bA95xyVONkFVuyvDpYylqhUrVfyVZ
 y+VU/kZ+0uMFVnDEDrTzGz7j6G+Z78cOrtby6hRazxSNuUmxc/At4CHz0f1OG3WbuqyNkHxBBNV
 K/g==
X-Received: by 2002:a05:6000:2213:b0:491:36b3:23d with SMTP id
 ffacd0b85a97d-499c5f31044mr7371620f8f.13.1794462494523; 
 Wed, 11 Nov 2026 21:48:14 -0800 (PST)
Received: from raspi5eynotyarden3.home ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c43f4sm17210875f8f.47.2026.11.11.21.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 21:48:13 -0800 (PST)
From: Sasha Neftin <sashaneftin@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Sasha Neftin <sashaneftin@gmail.com>
Subject: [PATCH iwl-next v2 1/2] igc: remove unused extended wakeup filter
 definitions
Date: Thu, 12 Nov 2026 07:46:55 +0200
Message-ID: <20261112054810.277427-1-sashaneftin@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove unused IGC_WUFC_EXT_FLX1 through IGC_WUFC_EXT_FLX31 bitmask
definitions from igc_defines.h. These extended flexible wakeup filter bits
are not utilized by the driver.

Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
---
Changes in v2:
Fixed a minor typo in IGC_WUFC_FLX*—started numbering at 1 instead of 9.
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

