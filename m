Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7180C5AD55
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 15:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52F264028C;
	Mon, 10 Aug 2026 15:22:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DXcZwM-pb8K2; Mon, 10 Aug 2026 15:22:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9453140462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786375328;
	bh=cQPgo7/ImwAyna2sJScM9HYP43JmyinkJZImCKBlm+8=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6MyD4LPtElklv2byvHsgvVePdv0f+oe/50vaBLGDMqbr4HseOCHZIm8pJB/jp1dFs
	 hnOLSDRh6XdTe9O+bpk58SpO631B6cvzXvtI6LhGZvDwIn7SHV+UHEBwevxVMUzYeX
	 y6hx8vF10s0Raz7/rdQeJ3UEfwjp7skK23hht9GEV3ARmdHp+Z0BflUoLAg8/r+XGP
	 4BxxyRd3f1FNUk7BhFOUgoWvLDQEZLKI8T3nD3qRog0zH40M76FfOYp7vC0YvZky49
	 PTeBI9sw28I//JY0QE27BaBp5Bh8ZC+siwbe5yamW6SjibfH8RRlK13YheMySmFaAZ
	 5/QUjtMQGyFMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9453140462;
	Mon, 10 Aug 2026 15:22:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D942423F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 06:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB02B40097
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 06:38:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ICt5A7e5HyB for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 06:38:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com;
 envelope-from=malathi.a2000@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1889240071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1889240071
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1889240071
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 06:38:55 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cbb662575d3so696536a12.0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 09 Aug 2026 23:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786343935; x=1786948735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cQPgo7/ImwAyna2sJScM9HYP43JmyinkJZImCKBlm+8=;
 b=blifLQbcWqDaDd4PF56UOE2VC84jeM+yOPtWGbe9jTOZxcf9/OvYqsglCyUy52u41W
 ovcc4/GV0RyptWyXgFpK5LgYwJoUy5r1WJq6hhx6jjY4TRF++trJAoKbkPuiIGthVaXN
 g+l28TcY4etlB4nVgJ5iyiC1dSDw8nr/z91oHDkIJcYulFwzNCcurht8CxyORQOUTR+x
 y/RglQlzptm370nKIF9Jp1SyhFO03vjOGc82TQXT6jcyntRuQmN7hD+qOpEvah4vIgWe
 Ni683ki3z31g9AvLZpYP1277Ky7Tg1AR96huuvDj96q/oZcgL5VQX/3q45jn9VI7eKIq
 NWVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYwabYONUYp80PCeHTwi1/LUWLSb7Vvi2L4CpAT2vBciP5og1fXKsHiIiCzkJM61g507q9OVQopUGX6NegOHE=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzKpNANMNU6ukLBrD9NVOpiXS0VAFfV0mHpdYGOMdJ2QwegAcr9
 TKu9VTJWPZ7wmZ8Gq1KeDkxL+hIgO0fYgIDaKc1IEa5hg6ES7ma6bSSe
X-Gm-Gg: AR+sD11P/Mv84sX34eZPd3cMglyh4cvWX+zvesYZCdCqKpjOfcEiz1TVEuN4f5MZeWq
 cIbSiiYxhnXr+aQD8crI9kwb56NzyKkbFWboncRIhqexwKEf93ylImsV8mMcEtq7K4acWsbo868
 OzqL+TZ2w04bwCmTQeiiMyhACBsAhsdT0ouikfUXPUYlyncxUBQizgwUitBuckVNintQYTmKMTE
 Vv7PaDCUELklXcsgUPB0LwWsRA0USmI0JwSLaenRdTlvz4IpgjARD6xL0umFE6/ETVrM5bMXnFJ
 oJ6Z6EdAnzHkpKpOxg3b+D6lqh3DzlUJ2RNYCBhMRYR6IZ7zNBf2q87EU5ChSDoPUmYh6/h0+XI
 GtpQ8I4k+uxtpcc/K9reRxqOdumVmK/Qrc1EaGeHnX/pFnxZcRPx/+0i5x9i6n9QQ2+ixHrP0rz
 rQp0sA/ATxcZhP6fxo3mh3CK4m7gA9VA04xSFjGyuh3aEKcFf2HDa5Ep7+1MlJsO0lcqMnIOyCL
 7XyISc/2vmIil4Vg7ghLiNmCxw=
X-Received: by 2002:a05:6a20:9c94:b0:3c3:91f5:82c2 with SMTP id
 adf61e73a8af0-3cbadb861admr30450624637.16.1786343935121; 
 Sun, 09 Aug 2026 23:38:55 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bebde308sm39626282eec.20.2026.08.09.23.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 23:38:54 -0700 (PDT)
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
Date: Mon, 10 Aug 2026 06:38:15 +0000
Message-ID: <20260810063815.151326-1-malathi.a2000@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 15:22:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786343935; x=1786948735; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cQPgo7/ImwAyna2sJScM9HYP43JmyinkJZImCKBlm+8=;
 b=UqUAp6w1v4YKtOytkDBbPDi7rEGpz70V+qp7PALHFHUDJ5IRFskyF10V6UeOWKaADd
 JmDcS5lGgYQmvQFSsiaRyGAfVkYGtWsPs/BSzPplKglVwkkOLSvugDqW3VZUZOfm0BAU
 BCGlVZvdDRvKt4lHd3ecmFtGn969R6Sq36CD0BdWZfXngoRfYN7mdZHgz6H7y0lbKDDY
 qBv51NVCNrQsjjuLpPvtZ66aoj+Aaxv0afAbdUTXB0A8NrdwhBXflfGQO95g26R3DAAm
 dcaWbc5gB6SkaxU3dHwuWiQ2/NPtHSi/qUuPgbpv5361Df+Pxq/foBjMbI94Jmur7l2/
 6ulQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=UqUAp6w1
Subject: [Intel-wired-lan] [PATCH net] e100: fix shift-out-of-bounds in
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

The EEPROM cache holds at most 256 words, so a valid address length is
never larger than 8. Reject larger values before using addr_len.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Malathi <malathi.a2000@gmail.com>
---
 drivers/net/ethernet/intel/e100.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 29960762e64a..a236273f5e65 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -765,6 +765,11 @@ static int e100_eeprom_load(struct nic *nic)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
+	if (addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "invalid EEPROM address length %u\n", addr_len);
+		return -EINVAL;
+	}
 	nic->eeprom_wc = 1 << addr_len;
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
@@ -791,6 +796,11 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16 count)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
+	if (addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "invalid EEPROM address length %u\n", addr_len);
+		return -EINVAL;
+	}
 	nic->eeprom_wc = 1 << addr_len;
 
 	if (start + count >= nic->eeprom_wc)
-- 
2.43.0

