Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF80C5B572
	for <intel-wired-lan@archiver.kernel.org>; Sun, 16 Aug 2026 11:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72D23406BE;
	Sun, 16 Aug 2026 11:39:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MxeWx3djCdPY; Sun, 16 Aug 2026 11:39:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC092406EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786880368;
	bh=+2hN3pG7DWenkEBL8a2DnjfNcMqYXamdUeL+Aidbmqw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wRujnoh9itb7qoniGuZpevAmma3WN8vFaKh054WLgBRDavjjPec1FO7H0OtSTrADc
	 Koi+SBDs/k4IRtJCTPPfkkGWLHtCluqse0UaImgp11d5Ni4JpGUsl+ZPnyXgwZ00Y9
	 7ihNgstY8IIaSs7Xdzi7M0QGeS0zOuj4R0pdU9mtLeNQm2xwWlitx9ZKTLu1poa5i1
	 mhhSWn+Vl3pPUvn5D6lHnNMuVQFZr0MLVKtqGuc0LMVj19nKPMKYHkPfeac3Q8WFtd
	 om1+hd8PrXqMgzpdHq+xlGjYm9nkAXCwxdH0FCLtwLs/UrgkBGeSrbOdqraHdeX1wZ
	 m8/GWxo9gRoeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC092406EC;
	Sun, 16 Aug 2026 11:39:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 98F31337
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 11:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A660406EC
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 11:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2jWQAfX_cO4j for <intel-wired-lan@lists.osuosl.org>;
 Sun, 16 Aug 2026 11:39:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=pavankumaryalagada@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A2C24406BE
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2C24406BE
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HvDuFyG1
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2C24406BE
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 11:39:26 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso3406352a91.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786880366; x=1787485166; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+2hN3pG7DWenkEBL8a2DnjfNcMqYXamdUeL+Aidbmqw=;
 b=HvDuFyG1SljrJxvHKUiRE7Hg0lyEVr/JHHau4Xq/SOVAPeGYkJEAXrs7LL3qFYR5QZ
 oCNLRjpsznQcCWIvX35roF1EasqmPdo0E609amHm8wCUhmIcG+n9tjpq8uoNcyEDOeKm
 +5mKu9We3LsJo/M6ECA2BNYUBgrTEMF8uocsTyRAcx6tfdWlGaLm7OVyvEc7uhQsBUVz
 dx6ZWaap3bp3NLnQCNCU8LewPe0ZbMkHJCrHGssBsywP9wL79t7063wlebcdjEwWr3+x
 tssF3/o3eMaiPcZQWKPF/GV2esyIwRdd+4kp/3lMPwDtCZvGqw9PkWgIlUv6FyN70o+y
 lLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786880366; x=1787485166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+2hN3pG7DWenkEBL8a2DnjfNcMqYXamdUeL+Aidbmqw=;
 b=SKzbcUup8ktihlli5WWvOE/r/y6SiFDRBrUeajJfZqn8XWXShz6GMZ8Wc3JtxktqIu
 CrMHpsHlTu3uDlqXuodmmjLpNFmPaF/xs5matzS6CAjTQgfjiUh+/3Ei7uJsYoMMUUj7
 S/D3QaVjolhNYCjlsfSVEuh9AqQVZOYDfM8bza+dyekAa7RTeh71OxP4vVfjr6yavTP8
 QYV56mqqnQTvYTT1exgJIXwnl1Gk0dqv+4/R5qsTHQCNJkmsSOw8oBREaWMZ7a3osjG8
 tdSJTpF7yUdgOC52CoezXEl/js4KQDmJgfcBTUNcPzIf2F0aUcbYi92W6u+toAMBcTnf
 CaKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoO7COVbZt6uGz33D2+6HYoWI/mslp3oIzdBPkL6JmSOdgCub1tV6OSbfmfsPUzEB9OF158X3mhS2Em5qVqgE8=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yx//LgAXQY7py0u8SszOaChoieNowNDdRMeuhu6KGKjrpqj03hw
 2khCl/Eqkl96o4atrvP6z9Wkthdz2vuz9Soa1BqeTrl4vt3SpQ42a8W5
X-Gm-Gg: AR+sD11L/InjeRMo0jVEu+QsxPMPl/kXr1pbmFchaPRIUF1FUHNsbwojjgA51C1RaX/
 Ikls5LweOqF5oPdd0tHL2QaVPhoihMnl99Jqjm3m0pyitdnyRjSh6v/GILyCmPdRaAk+0edEjx5
 Q1ctxdDcklk2BwQB+oTI3Fb/sHGysMNicTzsWGJjvM14cNPruzJbVblK/F6BtoYw2F9/3W9+Q89
 yGmwKY6hPEYjU3XgNqKiB4DicAD7m4DXwuPMywQ284AbOzHLef0m0QK+HEyRoMB6oZaPHuobzvL
 i7BP0t00Wrw6PPdp0fnoQSBgPeiPEOiqhrHfH47McMax3jWyIjzUDmqI/1EG1BX3ABx4G8Osx7D
 a/IYPzrijKgblLlvnfkeT5/7SVdNGxjfIo4qryxLZg+IoWeMniNTO+fb61m9YxsVPx0FL0ZzuX+
 91MP8Gvax5Uay7T/GMTZTjgUper1wfOcOqte5gH8blS8b1GBR8wpyjgjgAZLfe2TIQPa03
X-Received: by 2002:a17:90b:1d02:b0:38e:64b0:8bce with SMTP id
 98e67ed59e1d1-3933ba86ab7mr21327188a91.20.1786880365757; 
 Sun, 16 Aug 2026 04:39:25 -0700 (PDT)
Received: from user.. ([2405:201:c052:b00b:c8db:7e2d:fa79:eaee])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320d61e1cccsm22520860eec.8.2026.08.16.04.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 04:39:25 -0700 (PDT)
From: pavankumaryalagada@gmail.com
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com, kohei@enjuk.jp,
 aleksandr.loktionov@intel.com,
 Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
Date: Sun, 16 Aug 2026 17:07:54 +0530
Message-ID: <20260816113754.22900-1-pavankumaryalagada@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Intel-wired-lan] [PATCH net v3] e100: prevent shift-out-of-bounds
 in EEPROM access
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
an invalid length. This value is then used as a shift count when
calculating eeprom_wc, resulting in a shift-out-of-bounds UBSAN warning.

Stop EEPROM address probing if the detected address length exceeds
the initial address length to prevent addr_len from underflowing.

Validate addr_len after reading it from the EEPROM in both
e100_eeprom_load() and e100_eeprom_save(), and return -EIO
if the value is zero or greater than 8.

Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
---
v3:
 - Prevent addr_len underflow during EEPROM probing.
 - Use BIT() and explicitly cast the result to u16 when assigning eeprom_wc.
 - Update the commit message and subject to reflect the scope of the fix.
 - verify the UBSAN failure with syzkaller reproducer before the fix
   and its absence after the fix.

v2: https://lore.kernel.org/all/20260810083355.21631-1-pavankumaryalagada@gmail.com/
 - Return -EIO instead of -EINVAL for an invalid EEPROM address length.
 - Validate addr_len in e100_eeprom_save() as well.
 - Drop the unnecessary 1U change in the shift.
 - Update the commit message.

v1: https://lore.kernel.org/all/20260807145626.52692-1-pavankumaryalagada@gmail.com/
---
 drivers/net/ethernet/intel/e100.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 464dc2d6cdb5..5165f1d3c98f 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -746,10 +746,12 @@ static __le16 e100_eeprom_read(struct nic *nic, u16 *addr_len, u16 addr)
 		if (!(ctrl & eedo) && i > 16) {
 			u16 len = i - 16;
 
-			if (len > *addr_len)
+			if (len > *addr_len) {
 				*addr_len = 0;
-			else
-				*addr_len -= len;
+				break;
+			}
+
+			*addr_len -= len;
 			i = 17;
 		}
 
@@ -771,14 +773,14 @@ static int e100_eeprom_load(struct nic *nic)
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
 
-	if (!addr_len || addr_len >= 16) {
+	if (!addr_len || addr_len > 8) {
 		netif_err(nic, probe, nic->netdev,
 			"Invalid EEPROM address length %u\n",
 			addr_len);
 		return -EIO;
 	}
 
-	nic->eeprom_wc = 1 << addr_len;
+	nic->eeprom_wc = (u16)BIT(addr_len);
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
 		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len, addr);
@@ -805,14 +807,14 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16 count)
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
 
-	if (!addr_len || addr_len >= 16) {
+	if (!addr_len || addr_len > 8) {
 		netif_err(nic, probe, nic->netdev,
 			"Invalid EEPROM address length %u\n",
 			addr_len);
 		return -EIO;
 	}
 
-	nic->eeprom_wc = 1 << addr_len;
+	nic->eeprom_wc = (u16)BIT(addr_len);
 
 	if (start + count >= nic->eeprom_wc)
 		return -EINVAL;
-- 
2.43.0

