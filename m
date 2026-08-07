Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A69C2A09B
	for <intel-wired-lan@archiver.kernel.org>; Fri,  7 Aug 2026 15:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BEF781331;
	Fri,  7 Aug 2026 15:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GI3PG2vlhHd6; Fri,  7 Aug 2026 15:27:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9551381338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786116453;
	bh=tkpFr6rG5lBoCbq0wNytvjoTRlryXvJyiJH9uY9WWYY=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6tTIiUsKxKVTcvT9GXT8dNgKAJPetraFLQRfc+bPITdHDwGRvfQWG30ptRHYoEmUq
	 cL0DDWEgSdlYJ08Xaqd2pa2SyKXVP4DBnKkOgrDPoLWRXyR9upWltPxb8/xX8VYNbp
	 hnDeru11uPqvcU5yQn70NhexC2y703+SzFys5DyolN3wAXL8f4aWt7fx+91OWwUt7/
	 Hgw+QPwVmXquzBTx5qMdBmG/rh2EruyjQLuRIy357/L7a57i0D1AbTaKdVpj54IYMh
	 SRARBCrK3EZLTUMilyOMaVmk0nhB+Y2Dg+KOlUeTtSTJqQmvd5IUt7D0vBpR+8A0OF
	 rdetNyo6CFuoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9551381338;
	Fri,  7 Aug 2026 15:27:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE2FD282
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 14:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3BEF40244
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 14:56:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OSJjDeW3FlEw for <intel-wired-lan@lists.osuosl.org>;
 Fri,  7 Aug 2026 14:56:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com;
 envelope-from=pavankumaryalagada@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E37A240074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E37A240074
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E37A240074
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 14:56:37 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c9e0b89e228so2071034a12.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 07 Aug 2026 07:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786114597; x=1786719397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tkpFr6rG5lBoCbq0wNytvjoTRlryXvJyiJH9uY9WWYY=;
 b=a8bi2gAuvhNUPkbkv9O+wVLNw2UZAE55OfKQPy4/ZpdABbDRWpxuM6ECpc43a2OQKA
 GbGZ2fI1naiFKmO7xN+bh0D0UlXxhVPyRPTeBNBIk6TCCc2Wlox+SF1hwJAqfaD3FzGe
 XgvmlEgFLikNTw6wFoPUCJDMN+4jMjrTtT2KatYsFQgD0oNHfaVn5U1msmRuIXTfwwyx
 dz3fQJ5RsKbqPE2A9m1cf64oMDMP2BSb5QQ7mG0Jib0GhBXQy4sGgbxobtV96LgUQECJ
 idPjnvUqV7zAb/XPvEMm2wMtfH6WPiW3moKqxRsgEahNT1fSJ9Szfkj1v/yf36y9+TIu
 rKiA==
X-Gm-Message-State: AOJu0YxZmutlIFPK0K0Cod1k+IGxVU8wnIJkE6RzufRo75QaHtK1oScw
 0Ot2oRvxifocs0Zm10d/TmZa0FCiYa+GbOkpugOwzLFd8T/GoWo+SCNa3Mt9BZsC
X-Gm-Gg: AR+sD10n/RqCgDgSkoRLJzFTKzQXO2Xajdk3nuJQWr7F+QSHek3hdJgEgr/Z9nILpdl
 WKh811OuXeJtk0L90arF9/Vy5essVT1HKsPYXLowWch7BM1k2Mtfnzdnq95ywYU1Rv2cy9ntguw
 ZpeUSMsVoW7ZX/2oHbO1YwVNc8OCmvjy98tXfnus7yuNIeP8ZUA+MVnNu3wnRheThzcxFuEnOFK
 llQwj8ZT+tyQKoFGRxVghONQQiuNPoQ8j60F+UKynX9XEMQ5YlBBbUQm6o0HfVxNAqZR/5q68pX
 vdG90DvkeAISkryP2xrkdt3fMMH2nkz18zSp3NSW/8lCeREAuIazka/capASQLhN1LnPhn4ce9S
 RhhQEjmfm+isgsFpeaDTBjFB2yJ3qDF4TEbfpXw46HuUuqnG4W+xwQu3xSdoxU/EBizjn85LL38
 EE1CKG8Fgw3a0qHqKas+jfIalWCL7Xw25sy7pbu62OZj6PNGc3vPv/ZfWpCPsTIcBSTtA=
X-Received: by 2002:a05:6a20:a11a:b0:3cb:8eb2:acbd with SMTP id
 adf61e73a8af0-3cbce9294abmr977283637.25.1786114596980; 
 Fri, 07 Aug 2026 07:56:36 -0700 (PDT)
Received: from user.. ([2405:201:c052:b00b:782d:6a3f:587:95d7])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141019c3912sm11957018c88.8.2026.08.07.07.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:56:36 -0700 (PDT)
From: pavankumaryalagada@gmail.com
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, pavankumaryalagada@gmail.com,
 syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Date: Fri,  7 Aug 2026 20:26:26 +0530
Message-ID: <20260807145626.52692-1-pavankumaryalagada@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 15:27:32 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786114597; x=1786719397; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tkpFr6rG5lBoCbq0wNytvjoTRlryXvJyiJH9uY9WWYY=;
 b=CmJxXNoDZpdUZEehoEuY5zolbWwHlYs2HbBdRMLMAOVxsNfwRWC9AZyyRqS8S6+SkW
 4oX6khW5Q3BTg9bR3DjAbMW/0JZ/9phQUCSX0TxBi5ZRgfDBdqBPI/MK4Eoaz7Ow2lVa
 0DiAd0Y2t8WJuXUidfm3rca7dvzjlaEI3J+zJhnHX8yaUPXMzyQucQDhkbmCoaTG4GYa
 JQGrLCF3N051lsaizmdLKHmC5nxX7ioFeXaM9s8do/aecuISQz7EgthNzMAaJ25o84p0
 k1HGN9SlTZUOpaoF5oyTUmNBSg9xEuqnjHa+UbWa/k+A8KmdRx5FoXmqFJlsKAACQhvi
 Y3eA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CmJxXNoD
Subject: [Intel-wired-lan] [PATCH] e100: prevent shift out-of-bounds in
 e100_eeprom_load
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

From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>

When reading the EEPROM address length, e100_eeprom_read() can return
an invalid length (0 or >= 16). Passing an invalid addr_len to bit-shift
operations causes a shift out-of-bounds, triggering a kernel panic or
UBSAN warning.

Validate addr_len after reading it from EEPROM and return -EINVAL if
the value is out of bounds. Additionally, use 1U to prevent
signed integer overflow when calculating eeprom_wc.

Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Tested-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
---
Tested using syzbot c reproducer.
---
 drivers/net/ethernet/intel/e100.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 29960762e64a..1de5cd41ea0c 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -744,7 +744,12 @@ static __le16 e100_eeprom_read(struct nic *nic, u16 *addr_len, u16 addr)
 		 * complete address.  Use this to adjust addr_len. */
 		ctrl = ioread8(&nic->csr->eeprom_ctrl_lo);
 		if (!(ctrl & eedo) && i > 16) {
-			*addr_len -= (i - 16);
+			u16 len = i - 16;
+
+			if (len > *addr_len)
+				*addr_len = 0;
+			else
+				*addr_len -= len;
 			i = 17;
 		}
 
@@ -765,7 +770,15 @@ static int e100_eeprom_load(struct nic *nic)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
-	nic->eeprom_wc = 1 << addr_len;
+
+	if (!addr_len || addr_len >= 16) {
+		netif_err(nic, probe, nic->netdev,
+			"Invalid EEPROM address length %u\n",
+			addr_len);
+		return -EINVAL;
+	}
+
+	nic->eeprom_wc = 1U << addr_len;
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
 		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len, addr);
-- 
2.43.0

