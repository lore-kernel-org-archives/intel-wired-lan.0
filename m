Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563A606A68E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YFsoH95j;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o24u8jBG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B381980F4E;
	Tue, 24 Nov 2026 07:07:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YaRFC-b3HiBM; Tue, 24 Nov 2026 07:07:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2D00380E5F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795504041;
	b=kMHxJKKcCmwBSWqzZD3/2DjXK9kIKIo5Y65MgTQt9V7RALSFKptB+81FTGg/Haa73DEL
	 vQe3nWUgmCVga5M9dOua3Nokx2f43zYFuMp+VkjHTKYvUB86cFwHTUlD9XRNAbqxjx1AH
	 Kxa7vTBnQ6TGPJWXdVmsMHPGYfYsaa2U8MFJ2d5EXjJKFuHPtM8ZRLm8ithmebZ403NOA
	 qHiT1xzeiyzrqrl5Ie8UCNl3EmpGxHYB6HPzugN1iVmZ6Ta/N7nv4wyhHBz1Vi+vG/4EV
	 HGRLZsUnZfSiHwx6AABiyPzbUpG0BkRYFrt8qplTS3vQf3zzlfoFCOH6qeLyfUZlbzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795504041;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1a1sEC0opA8FK+P5aTL8hTESPayturbzP3CdUYVKH/Q=;
	b=BD/m4nEDlbB5GgZfXEgT6DPsCY+a5jh1J8lUeZQ1fM7NwwBed/5OhngLmR562jLHOthv
	 /FoApKwwCdUD61x868KQO0UVyv+n9M9cbd4nu6qUKqLxFMI6kowhJ8OFSJZw1vbwUAfDw
	 aF9ak7cAK/oyt4dTyfFrdn6LetH6dj8HEG5yD9d6N2mwwiklw+P4vmg+7InK8Xc/8qc0+
	 Ds8O94y86X9MAKceNTK+xz68o9QoCEKVAvTBSPahfR3TrMAk9gXgI7qoaJS1E/dWnNUXc
	 04p9xpKuRRIQu0YLI0xZrpZArEerAgXHGV0abCWujacVeoc0sqtYIijmkYlCOIYNxcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o24u8jBG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795504041;
	bh=1a1sEC0opA8FK+P5aTL8hTESPayturbzP3CdUYVKH/Q=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YFsoH95jTruMNOxM00rGPmbU4WIcQ683IuPrUwNYX9qfPRfSfEPg+SJrZYhkXEqDv
	 S6x33v/LzX8EAHjGzqgIofE7Rqm62EJt9mOIFLANVUpD4ABlaMcC2hbVkXeVgaLS8h
	 vDczyXs0cQVGPjHdZSWD4VpqGSC4AyFzGAWAiLwULt7b3iIwRv4Hfhnfks3/KLYzmv
	 EIYOrRbYRee+v8KsRDkkrR4tCb9v55OJ2g1pHLD0439Y2IKLcvyXT9i5BpI5j2225l
	 3F0OJDRctm5k9B/EN2qgV7/1sTUji2lz9it5HsMZr5l05WL3wl9DpWIS8HlSOhfBZg
	 YIfLyGbLUkAUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D00380E5F;
	Tue, 24 Nov 2026 07:07:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 94ABE260
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 07:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82ABA80F4D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 07:07:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kD6Zi0Of-X3a for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 07:07:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9311F80BE6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=o24u8jBG
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9311F80BE6
 for <intel-wired-lan@osuosl.org>; Tue, 24 Nov 2026 07:07:18 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so2873835f8f.0
 for <intel-wired-lan@osuosl.org>; Mon, 23 Nov 2026 23:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795504036; x=1796108836; darn=osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1a1sEC0opA8FK+P5aTL8hTESPayturbzP3CdUYVKH/Q=;
 b=o24u8jBGKznalCR6Y0N9p+tBXyvRIkVFdDLyrrka0K1n6FsgXoGjoIGHweJQHxH9Yw
 L01sWDZh4E39M2mzW3nyIS+6bEnCQcX2zk3lYbUXoWwGPVhmW3Qo/nVzjIgl3ypxkMEB
 h6JQjuuEevPrwbI85kkOrTSiKZyNfEj9oXrM5ZFBloD3R/tu3E4+wegwEA4kqsdnsZAj
 ZhFgm0lWIB2tI5agqVmausvu8eoBIjstq3eKTM7XgmoLh6xpqKcY8Wb7619nww1XyfLh
 2oA3QOtY7zU+5uW8e6nVhSkYPyIvKxxbelLnzbQm0pVszuFdxfkvPqi27plaBFzKjKuV
 VN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795504036; x=1796108836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1a1sEC0opA8FK+P5aTL8hTESPayturbzP3CdUYVKH/Q=;
 b=S5Hrmu8tLTpqsmLR4XbOihbjZguru0HoCJfUTtKPq0IIU9QFORJmtjurDYhh9EBtgS
 PPTbXlxEZdFnPNPaOT+z5E6sHRjlnlwxdqfqNEqVZ6i7q6tARL+wvO6T+MO6WgnKy32/
 CZhCu17cIkox1Boze6HAG5WdZbMjCZVxL43qRwcmJ2A6Oo69I22cHdIhNGF/DnD7PiYg
 TE6DC1mmKZi0e+ds+7rJDsvP2ONnCYHGAyAoVwYVa/BB6QYOPsdLyFzozqOoYxKfzNvl
 YOwZV9za5pobOldJvTn4APNhCsiUIaFtZ8j/c+gNmonksJAZbrOwUxb78lwjCfvxpXzd
 SB1Q==
X-Gm-Message-State: APuU4Z/EEjOsX8L8fU3KY/WxQDBLrAMKFL9neXPzI4aDB57eUxRUL+9q
 B51m6pxsZzU2W1PEP6Sjo1gYZCAtBxXMp3FV69B1UWSiK8nK86+XPKK9pQF4KX1O
X-Gm-Gg: AZFdTZdkwM6Wjjezmah7YSpCet8MRPAiuDvMIkHX6sFM5AATuNKNVB7oNyR8N/iBDuG
 1uhfLJkk3c3+9tdH0dgOpFVuzwjewLpDiUUvm7pKRWm8xEyIG8DwLdduZ/VtoV1nxYYSz2rB+LQ
 xmVSVIRLjZ78lLg4h592mzkStBnfUbCPGW02coJ7VOlRI14dvm42yxj6b+fLWWng3zIzjud/kTw
 2gB1yd0EFA+ycKvaK/Z1UoyQqYBYX1+XLPymp4ByKnoNgs97BRDbgGyjn9OwIpRIa8jQ+P6579K
 u4LnyeYdZg2zc7zy6F3Hmac6kk5Ro8H1Mi17faBFV3q0daBlRy+6ABX6M3iLJZuuWK6OA8YRl1O
 IatykMtjTPd11SM/kEb+oiVsh0nvzaWXE6msicnPiGG5yYNf/C0iVjX6S19ohN//BZ69SrQR9wY
 WJIiH1XAPRxlYIg8AuYKoPdwkY/SXzs6bamm3AaRrLqy8OjM95YdNkXtciyMcaPAhheQoddkuvd
 ZrAddCNR1B3CiHWa8I+pgXMOnkZF30wkNDrUz+G0cHcgibfoH1IKeyS2S0xBd2sfLnXuYzOl2mq
 yJqrk6cZ3TV2uCayog+gQIjGUu7Xo4FMbNp2ikU14KrIMQrOB3nNIIRkQdptDCCfvS4SqwIlLAc
 L068k8CcHXVVlFa6UMrM=
X-Received: by 2002:a05:6000:27c9:10b0:4a9:9a59:c7a6 with SMTP id
 ffacd0b85a97d-4abb2ece9d6mr19702446f8f.16.1795504036122; 
 Mon, 23 Nov 2026 23:07:16 -0800 (PST)
Received: from sashaneftin-pc-GB-BSi5-1135G7.home ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c3csm25700607f8f.36.2026.11.23.23.07.13
 for <intel-wired-lan@osuosl.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 23:07:14 -0800 (PST)
From: Sasha Neftin <sashaneftin@gmail.com>
To: intel-wired-lan@osuosl.org
Subject: [PATCH iwl-next v1 2/2] e1000e: add support for rx_sym_errors
 statistic
Date: Tue, 24 Nov 2026 09:07:10 +0200
Message-ID: <20261124070710.9728-2-sashaneftin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124070710.9728-1-sashaneftin@gmail.com>
References: <20261124070710.9728-1-sashaneftin@gmail.com>
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

Expose the Symbol Error Count (SYMERRS) register to ethtool statistics.

The SYMERRS register tracks physical layer symbol errors. Update the
adapter stats by reading SYMERRS in e1000e_update_stats and export
"rx_sym_errors" in e1000_gstrings_stats so it can be retrieved via
`ethtool --statistics`.

Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 1 +
 drivers/net/ethernet/intel/e1000e/netdev.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 6f45a37b17d4..49f4d93759c4 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -60,6 +60,7 @@ static const struct e1000_stats e1000_gstrings_stats[] = {
 	E1000_NETDEV_STAT("rx_length_errors", rx_length_errors),
 	E1000_NETDEV_STAT("rx_over_errors", rx_over_errors),
 	E1000_STAT("rx_crc_errors", stats.crcerrs),
+	E1000_STAT("rx_symbol_errors", stats.symerrs),
 	E1000_NETDEV_STAT("rx_frame_errors", rx_frame_errors),
 	E1000_STAT("rx_no_buffer_count", stats.rnbc),
 	E1000_STAT("rx_missed_errors", stats.mpc),
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 3213f6dc123d..8a9fa8412224 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5036,6 +5036,7 @@ static void e1000e_update_stats(struct e1000_adapter *adapter)
 		return;
 
 	adapter->stats.crcerrs += er32(CRCERRS);
+	adapter->stats.symerrs += er32(SYMERRS);
 	adapter->stats.gprc += er32(GPRC);
 	adapter->stats.gorc += er32(GORCL);
 	er32(GORCH);		/* Clear gorc */
-- 
2.53.0

