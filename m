Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD03C5B56D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 15:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AC8E80E73;
	Mon, 10 Aug 2026 15:22:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d7gwsPOdaGqp; Mon, 10 Aug 2026 15:22:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2568180E8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786375329;
	bh=s87mpArnJrBaRlOD42LLOQjBJTZsxs2th2G+gHL+3Ak=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TAZ/aLeEuNpDJhlcYabgP9QlbaM58FW8n2ryBYBZ+lB7jFG5cepr0YxHbiKHufsse
	 VFthHnWmz4Fk4M76MJKlACx41XP71yfDRILza4hgAhVScYnW0f6YCmV5p871LVR4tE
	 UU2DjA0R2b4ZLpCjy7avQig33QQlyeZP91DGYij8LOcVcLtxx+d1eAL/mY6DPUQqmV
	 dZqUNPWzMhxQ5t+UHAJ05mGz/2mgdTe18ZEg++nOI8lh/5JJZRRz9utY7rrRddsnU/
	 8+e0mmq/5RSQ+apwPENOOFDRPebuUDH4P7u6sjKm+5uskXxtC5w1BYlv0o0x2Y4vq4
	 k/gdpMQ2F8tnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2568180E8A;
	Mon, 10 Aug 2026 15:22:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 00877198
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 09:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E664940569
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 09:08:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJOIVqH45wQ9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 09:08:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=malathi.a2000@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0CF3440462
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0CF3440462
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CF3440462
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 09:08:14 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so1195551a12.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 02:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786352894; x=1786957694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s87mpArnJrBaRlOD42LLOQjBJTZsxs2th2G+gHL+3Ak=;
 b=giwKrBLiYOxDFx49CcsnRwPHMh9fSk9LXDce2yF8p6kqlGvX3oGBoARusNkye5me8S
 XHE5Y/LprXQXctYjaBi/AKg2hUPiR/ejQXNNW5MylIRJ7PnQVeSMKPgkkSXBTaQFzZg+
 tAdRXUCO3Fj7GGzD8yHlx8P+ercrWK6Ub1Q/lKilNg0HwbYFztXjAfkPb4rmmfzd9Lg9
 iwDxvaaqkxba7ltLkujHlyNuF4f3QIxbrzTtKzztQF1BDr35mFTArDGcxpqDCv3D8i7z
 d4v95J76XcTkOyzhSSRWpKlB9bHo7RGQkZySRy3xdgDWr78pbG1SJPuCpC7O/YH5dDw7
 tt9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RopJXQFV82gAj4GIuFlIrjNgCJYTYf5OTNrwOuhPdOsEzAjKwa7AB5eOVy4upvlenc53292dAqp7S92vDuMZ48=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyxmnmYmhZSEebwJC1cdypNb49/O5r2c0urMOzsptnW9WzdPAES
 QeKLjkJhWa/SXaNrjoxwwi7rcIBKZKUXnjVN3lT15L35JZ6CVIvqLHIF
X-Gm-Gg: AR+sD10Da4cozn4f1Zu3xN3w6OfhGHk31wlga9oZma8SRb+eJ9xDmTdEBV0TImam8NN
 Dx+2UPidjk77MPqWp5fwt2ZtFD8aayPWVAFR3mxmU3iVJ9i5odxYRR3Q0BUsJVkFQfGqaBM9Pm2
 luMtE+iAqOTbUk6Ka8vk2i4tOSCHD6uy4X/WOFYW9w834Tc/XcM6N2HzvDp2ezG6nT3NRhreyvP
 1kbljaVUf2maX0U6Mcmt6EKBrsgoMW0TTX6k8BYSVWEpOdHQHzgGuU1ITsqw6Kb16qV05NLLmKJ
 HywRyc0h/34opS395OHpQgUMyIAzleSq/Mcmx5lpZg6QBIS/WZJR6bV1LweXuTE4uBFn3cNezZX
 1QdqMqso80jT3UFMzBcmf47bOnWBfFVOJjp47GmWCfLahudWcMf0uzkUkuQNU3xJBoLSO6LKYQF
 qCn0IZHtfT6U8AiLi5dEHx17137F18Wq8een/IEnJ0pFdhr9XMGdsaLut2WpKRyC+ghzKT+RHfH
 CWXPyqr6bKHO7QuSJDhOxSVFUw=
X-Received: by 2002:a05:6a20:1602:b0:3c3:a3f4:5485 with SMTP id
 adf61e73a8af0-3cbce6cb2dbmr21537263637.6.1786352893987; 
 Mon, 10 Aug 2026 02:08:13 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8d60f4sm41132755eec.13.2026.08.10.02.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 02:08:13 -0700 (PDT)
From: Malathi <malathi.a2000@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Malathi <malathi.a2000@gmail.com>,
 syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Date: Mon, 10 Aug 2026 09:07:46 +0000
Message-ID: <20260810090746.206290-1-malathi.a2000@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 15:22:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786352894; x=1786957694; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s87mpArnJrBaRlOD42LLOQjBJTZsxs2th2G+gHL+3Ak=;
 b=qkEmCpW7w2azp6Rpg12k5T56DoobpJqBS1jTpCa0/iMpzxc5/tMSPYh9upsR0S8VCO
 YxnxpicXd4ZRbrEONIl/wIuaIrjmRRH+k99z1KtSsp0dKYyUY2KSMOL4kxk4xzGZGDNN
 aOEq2WkMx5mUBUfmyq7sE+5oCi4VNizSotCaeO1gNzX5E8khE74JxJzxODmc4ue2e/zp
 j64VBLgYn//kPkFtceCOt5cEDJrjJxdbl8vsbXQW+2y7ShcFjj3h/QCDuz1KCjSilD1C
 YWHZAP6S+v8DzqDVZOmdXH+RLzqvd7k0afR5TAy74Q7lCfdNpCXXaDIQfm6RmuTHCxac
 J8aQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qkEmCpW7
Subject: [Intel-wired-lan] [PATCH] e100: fix shift-out-of-bounds in
 e100_eeprom_load()
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

e100_eeprom_load() and e100_eeprom_save() start with an address length
of 8 and call e100_eeprom_read() to auto-detect the real EEPROM address
length. e100_eeprom_read() adjusts the length with

	*addr_len -= (i - 16);

based on when the EEPROM drives a dummy zero onto EEDO. A malfunctioning
or emulated device that drives EEDO low too early makes (i - 16) exceed
the current length, underflowing the u16 addr_len to a large value such
as 65529.

That value is then used as a shift count:

	nic->eeprom_wc = 1 << addr_len;

which is undefined behaviour and additionally overflows the fixed-size
nic->eeprom[256] cache.

  UBSAN: shift-out-of-bounds in drivers/net/ethernet/intel/e100.c:768:21
  shift exponent 65529 is too large for 32-bit type 'int'

The same corrupted addr_len is also fed back into e100_eeprom_read() for
every subsequent word, where it is used as a shift count again:

	cmd_addr_data = ((op_read << *addr_len) | addr) << 16;

so validating the length only once at the caller is not enough.

Clamp the length in e100_eeprom_read() so the subtraction can never
underflow the u16, and reject a zero or out-of-range length in
e100_eeprom_load() and e100_eeprom_save() before using it. The EEPROM
cache holds at most 256 words, so a valid address length is in [1, 8].

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Malathi <malathi.a2000@gmail.com>

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 29960762e64a..26a7c0aaa6e2 100644
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
 
@@ -765,6 +770,11 @@ static int e100_eeprom_load(struct nic *nic)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
+	if (!addr_len || addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "invalid EEPROM address length %u\n", addr_len);
+		return -EINVAL;
+	}
 	nic->eeprom_wc = 1 << addr_len;
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
@@ -791,6 +801,11 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16 count)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
+	if (!addr_len || addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "invalid EEPROM address length %u\n", addr_len);
+		return -EINVAL;
+	}
 	nic->eeprom_wc = 1 << addr_len;
 
 	if (start + count >= nic->eeprom_wc)
-- 
2.43.0

