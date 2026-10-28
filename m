Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B1606A31A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6B7CfISV;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=pDof7GBD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D37E780C88;
	Wed, 28 Oct 2026 09:05:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c7RlIh7Fr5LZ; Wed, 28 Oct 2026 09:05:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 074B380C1E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793178341;
	b=TjhI7DvXqoU7VtNuLmVtYDNVx92f43cjtscJhARZpLsfsX8z5ox3o8Toiw3FpmSooM/m
	 3VKKWQTI9vBlSBVRR7axSHiVa621NFIwKp5B8hEYJ5ciGg+5rns1MO5Y1r6IsisvKvIUD
	 OsIWIvX4d3re7QDx26It3hwFqH6STlE51JSQK6wHcjhE4wUe+XsbWoJA5darmjk8XwTMw
	 p6lR5hq5BbY7e4al2Um1eoJbL1NWDGv+Zic2yUwii98Ixaj4aqbzEpvNQVxsxBbrYmnTm
	 2Si6WYXEwGN/uNNojnbjv3vFkohJdSfgijK+tdP7Xrjd6Zul+LtI4UhlcJ+ZrCjSoNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793178341;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GP87V0isCS9npBsUJzfzavKuNiOHWjoeDoQLqqwgJds=;
	b=dlVNgT8D640xzc3h9qOkU0KtUAzUjwVn4sOg6yJX+IOTTaF9ygcQ7vv+LYYdlUNx7FZr
	 Eg8F3uclkSgBXKj1K5H4gnhDy+636CKcNBrmJ0UszUZCQ+9ND6kZEE7vdBGo+MIg5YD8W
	 XUfstP3dRqztX4Of4fNWi0C/Sj471AefMoS2QA6UZpegc59Rbcf3/bP49XHoyjVUTbnSA
	 WpsePPyY+suPdFILuSDy3ue5Qa7kpRvq71m/kuGkgv/WPVAF/z+tswT4cqkXMbTtOsOpB
	 iP9uBACofaeMe5ar3Z+RdNNHZqX+3fBcf4+Bt8cit2UvozRXdGsCLs2vOO0hvVF4HRw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793178341;
	bh=GP87V0isCS9npBsUJzfzavKuNiOHWjoeDoQLqqwgJds=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6B7CfISVQv1KraVssm6mZKTdEs5v7rACjtVZAyznDqlw5xKFNHttJwiIfcAgc38LX
	 msoQqm4uWqt9FBNsihBdq4HLSagJb/b79JjNuQ/gv71qMhGUiLBULS7IFfHGMm9uH0
	 LZuYjfCtk8JXeQlveU3a3M+ejDm1DYh0TV6UcRuSaS7+/aGRIUR+K6Xt7VJyPlOxKw
	 aPtttOC3SusJw3nGVb4ZMXxO9NizafO/8PJnZzY0CjLTvLYltRylcKv+XC9Zjr9jug
	 U6u//sgDfzqTAMnCBQJLgRaQASR6NLt/mH286VqQxft335lKsDxh7/x8TSTfSidQ/N
	 TJ5CpJD3zSGnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 074B380C1E;
	Wed, 28 Oct 2026 09:05:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 75F33529
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 09:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C3544006F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 09:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DoiO2taWN8a5 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 09:05:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 655AA4004A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=220.197.31.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793178338;
 b=paFKsHMLMVrinQz57NKJJNdcBhNuzf1cpz8NYtGOV4G1njcEYjmSpjuOviV81PKSX6ab
 s6eWJ8rRbTiq8j8iTxT8+2oAfQn5KlFARZnKmlUT/3P5QFGRNFVFFQ6Ydn5HlLvts9lDQ
 F2mwzR95UrfWxG7rQ7d5WrdYXAno+HhV6hDdNEJn0ZXtHzr2FUgsg7ucfWwhmZoZz4jZi
 85LxBQmwGEiZYUAJkjZPg/TVeoj1FMKOPZPoHtTflGhogHAEvH6Eza5oqUWix9LY6MI7o
 BB4nrxNRKCHWto+6/hbNT5+o70y6NrkS/ljCqXadoq0xEW+yJKK1OdQNP9zrQVuTXhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793178338;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=GP87V0isCS9npBsUJzfzavKuNiOHWjoeDoQLqqwgJds=;
 b=hNYXlDBE0WY1MpqTLfbZJTmC356mHLkzAHqmmJGx929w7CuCBnVWP4iP99SPkB+23wxH
 dIVRscAB8RBI1FK2L53B1dfWBqcSrqU/xNIIRG7yrDzQpjYuaDbl8Y6EnH1y6f9EYR6Bp
 XzBsZVwDxX+wOd3j5amajTYusNzJC+yjk3pDKPbKa4DCB84MTwBrEMzrHckk3gIlgMNDJ
 6lP1AOhkckAH6b0xa5dByV/yghtAhbjh5RUdvV4xMkb96T6ZNZ7pUUZLL1MniGvEiNp59
 70DIxoC3YkSkv3cwtjfzEaXBDdlVMOuXYK1oPbrmfEWZF+JeI6WeLnjfqYRRRiGKCRQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=126.com;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=pDof7GBD; 
 arc=none smtp.remote-ip=220.197.31.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.6;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=pDof7GBD
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 655AA4004A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GP
 87V0isCS9npBsUJzfzavKuNiOHWjoeDoQLqqwgJds=; b=pDof7GBDaWXL3uDptu
 p7woJJuDQ930CWjRgR0+CEeJFipKk43uTZkpglPzlkjsoIyoYpCi26fCgrq4jhg2
 BXRnZBEi8+rhl924WKU5xUz+PVN3j63IAll1b7TDIj7wRVfbvhBfEzpXEGFy8wPd
 fk1R6gcgqbm8v6jDX9uylDEIM=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wD3ZyS4uuFqDbDtCA--.6527S2; 
 Wed, 28 Oct 2026 17:04:58 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
Subject: [PATCH net 2/5] e1000e: do not cache the hwtstamp config before it is
 applied
Date: Wed, 28 Oct 2026 17:04:55 +0800
Message-Id: <20261028090455.2291659-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3ZyS4uuFqDbDtCA--.6527S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF17Cr47CrW8WF4rKFW8Xrb_yoW8try7pa
 17CF90krn8tF1aga97JFy8Cr98Wan7tayY9Fyayw1Y93s8Cry8Cry8KFWUurWjyrWkJ34q
 qrn5Zw12grs8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlhFsUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRrvxmrhurr6ZQAA3O
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Linkui Xiao <xiaolinkui@kylinos.cn>

e1000e_config_hwtstamp() stores the requested configuration in
adapter->hwtstamp_config right after the rx filter has been
translated, but the two register writes that follow are verified by
reading the registers back and each of them can fail with -EAGAIN.

When one of them does, the driver is left holding a configuration the
hardware never accepted:

 - e1000e_hwtstamp_get() hands it back to user space, so an
   application that reads the configuration back is told that
   hardware time stamping is in effect while it is not;

 - e1000e_systim_reset() re-applies it after every reset, including
   the ones the watchdog triggers, and keeps failing;

 - e1000_watchdog() starts polling TSYNCRXCTL_VALID for the cached rx
   filter, and e1000_xmit_frame() still parks skbs that ask for a Tx
   time stamp because it only looks at FLAG_HAS_HW_TIMESTAMP, so they
   are eventually dropped by e1000e_tx_hwtstamp_work() with a
   "clearing Tx timestamp hang" warning.

Cache the configuration only once both registers have been verified,
so that adapter->hwtstamp_config always describes what the hardware
is programmed with.

Fixes: 62d7e3a2d006 ("e1000e: Validate hwtstamp_config completely before applying it")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 35f5590228eb..7ae33273734f 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3715,8 +3715,6 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 		return -ERANGE;
 	}
 
-	adapter->hwtstamp_config = *config;
-
 	/* enable/disable Tx h/w time stamping */
 	regval = er32(TSYNCTXCTL);
 	regval &= ~E1000_TSYNCTXCTL_ENABLED;
@@ -3763,6 +3761,8 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 	er32(RXSTMPH);
 	er32(TXSTMPH);
 
+	adapter->hwtstamp_config = *config;
+
 	return 0;
 }
 
-- 
2.25.1

