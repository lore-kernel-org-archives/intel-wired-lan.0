Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB6606A68B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 07:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=uYeJ43pm;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RIwUIx1J
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7C9780BB2;
	Tue, 24 Nov 2026 07:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fHOHVjgPJbIo; Tue, 24 Nov 2026 07:07:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1533F80C1A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795504038;
	b=lc9YavB7G6Q/2bWozqAbViEm5C9zT8+X7q8KqyouWoSj0Av/KKu2CNko7hoKVsg2MjZj
	 VVLiwn6xCrTYncZlv1u590PK2X5vvO/TnBoTo64Mypx8pk3p9NeUw+2PJygI1AsWnZaIN
	 u+36Bosai/oVF4/4YM2MkS5nIf785ZEM7f7cDp62Ts6XuEA/9Aqc8njjuiu6HrsxFUrq3
	 E0/ODvcDEc7iFvgj/5fgdqUVdwbNa7PfAbX45URT51jNFsk0KGPcNXnTFXYc8r5Qqwuzh
	 2LdR/NHV517FFYPJ7Tj++h4OB3FmC5yYc88MiF2b23U99loQm0nkWh6g0W2aH3EC0mQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795504038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IC3LVVpCgx2FAz4Ler6p5Ik5jT3gP8rGy4Uyn5vHrIU=;
	b=es5UcRHKdsBIjnau3BlHpdP8IfOlTEzblIPWbZADyaZ2443wJ8uQazc7pEPlk5tHfmp9
	 VE1MVHFOLDzX9O5qt96j+TX7Bx/a6e19lq9CpkezyFvRqJGSl4cKr3LE1NjVrLy9uJAKR
	 MtRVQPOfAlaMtfHnDIgMYOIIN7XJhzTqBmuJG29sUBSNlDwQXl8ugv00NxtYYTSzZe3WR
	 U7McCI23oXIz+1hC53sGz4YhktlA7eqw50RRP+MliWi596O3H6I150aTFaUmhY5coCp2K
	 zaZpYPRIKSIsfAP1doRnJ7yutuJVcQonKkhFvlJbJqZypv9Ft89elONAwPfyAEtT5/g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795504038;
	bh=IC3LVVpCgx2FAz4Ler6p5Ik5jT3gP8rGy4Uyn5vHrIU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uYeJ43pmH49Yfsecna1OX9e4ANrnw9Iy91MgqrcVdLprTbq3kINdjgBfvdkmKoAIG
	 JrpIPvhGCwu8mg9cn9nL2jPlDBkAFXxQdcJh74DzCIoNVb3Q15huXPBxkwdFOR3X/F
	 bndVnKPD7n39EI7mKZN6S4gC0Q1oWCz5DkoUJSxFCghneoXrLrKoklp9OMWXuMHPvi
	 UxK7L+4XIhQA2Pk9NYgD+9MLAICb7Bws7GS5NINI52eCbBuZ4Ef0kFiwMhyyacXH/k
	 GuHDdoknWOoqefOIcL9uRs9OklcYwwubvLEPiCjBV24pOFWDWcEQwI+SHZKvbBpxlF
	 ODSNI+cGh503w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1533F80C1A;
	Tue, 24 Nov 2026 07:07:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 265E71AB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 07:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17FE260789
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 07:07:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xgtT0yuSEhrB for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 07:07:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 09689605EE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RIwUIx1J
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09689605EE
 for <intel-wired-lan@osuosl.org>; Tue, 24 Nov 2026 07:07:15 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4a34ffd3e39so2213672f8f.0
 for <intel-wired-lan@osuosl.org>; Mon, 23 Nov 2026 23:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795504034; x=1796108834; darn=osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IC3LVVpCgx2FAz4Ler6p5Ik5jT3gP8rGy4Uyn5vHrIU=;
 b=RIwUIx1JzuX3GvZo/+8wU8B+jkH3H/4U3lfLtxgq6KF6GXC2KQ7EbKDVmpaweUUQqv
 vnzm+o8x1rSN1klCjc0c0+5178733pEBFE9moBueKq30kkfFynzhvPN+UTmUVML3ZIQB
 03QBWnf8tA4W+Aa25wsRwZTnhiZH5x/JkyI55tkrXWxWhn1Vw3fhv/zcxw2IFq5zkpo+
 WnDxPlV20LJuedBKB2E9K4nxJ9nPMm4bTPhHSR/CLPM1zO3+A2WIjrCWSRadarI80z+s
 CypMc7N8qMhgB5YGtW2lup3O5eKs9LDTTJdweX+uUNmcTv0z+niG0dEhkFTNQhRgkn+s
 EHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795504034; x=1796108834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IC3LVVpCgx2FAz4Ler6p5Ik5jT3gP8rGy4Uyn5vHrIU=;
 b=xXB9pY/VU7Oe/lTwbxyKXL3t35jI30ZmPN4lF6cfLPE+fQ2lqqke7lB8EFAGxvCs3/
 ZEqsFKDYB8xEt3/ZVPQwLVKWqVq3rfVkjT3OOy86T7w9GAJOEeWSELAmmcl5CqsCL3E/
 MAM3dvuiEkyNO6i/xBd3iulD9Rb7+fV0M4IyR3mcxxO6kWR3y7Y/lzJ+xByxiVEfChzh
 o07ugif3lwBOkifCaZbkTWS8quAdspQh7GFLqDv6LRDxki63Kx1Vt4ZP37qn5iChKRGB
 49QkrtHHX0Dejn2X4q7qXZ2YDTNzJ1WD1FUZkZqQSGMU5HMgR9tgcVgcLevu2zNkIua9
 xIdg==
X-Gm-Message-State: APuU4Z+PMtNM85w1lw6wtirMDYjBSa94Jr76xh3fgRSEKtS32YKm5/J+
 58AVLwVlF3z0brhdGgQEc/1Ss3uN3URXhM0WbrVhUtMuyvzTwPxNfUIvtZWLZMak
X-Gm-Gg: AZFdTZctS1Jo0UBlZoGnbD5X9jEyG+wESEp3/BL9J4g7wPksPF/mcBHCIvsegritH3L
 EX0BBXabtk072wrD8OSAPmtBmr5X8g7Lox2EsNPeldYeVqgc3E1HwPAbA0Rl2h98i0m/VXp0S5Q
 BiN+FX77TVQOKIJKRWXSEs4/FaIYv1jVNVk69y5nfvQz2UBl43nM/JI1X5n/4D4owPL2e7a359v
 3TE8ypcRBQDGJM/70MkwR0m5S4GAiZ/raf6R8jcokcF92tPn6VGus168A3F4TVGvfdGbYTbZzyi
 rFYBvJXZo4RvTxmM7NmO/7qxE5M8kJtYSO+Y9N3Z1l81fbWxHa3ETOlIPT4BI2xEdUELMaGIeeB
 LU0KnldrLRtpdYpu0dnlUML0Rnx784/S7egI2pZ0xE7uhaOYilYwUI8TVAibl5Q/gNVXtTPTDiU
 TIrEH3DlqAZ+xVIS+VqdOL2lhXseE+g9Jx+dyIxd1mHAmt2P7rM+k3B1cbt5grRDezJFRXgEKn8
 s2x+cG74+SFAEPmoVMl4NTjwXtDrQDamHeepRDGMypkwdIXvgLlZil0K4OOU2AD5p5Uw45dFk21
 e8omNpa4CA+TgnU6EgG7X5reyqZTMlOPsL5S2wr5BDMMTTcMdLQL+TFVF1LLMFEMHuogstlOHPw
 w8AXzHwRP/uirL7dZdAw=
X-Received: by 2002:adf:e197:0:b0:492:b5d9:feb9 with SMTP id
 ffacd0b85a97d-4abb3a4d8f7mr23998529f8f.30.1795504033666; 
 Mon, 23 Nov 2026 23:07:13 -0800 (PST)
Received: from sashaneftin-pc-GB-BSi5-1135G7.home ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c3csm25700607f8f.36.2026.11.23.23.07.12
 for <intel-wired-lan@osuosl.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 23:07:12 -0800 (PST)
From: Sasha Neftin <sashaneftin@gmail.com>
To: intel-wired-lan@osuosl.org
Subject: [PATCH iwl-next v1 1/2] igc: add support for rx_symbol_errors
 statistic
Date: Tue, 24 Nov 2026 09:07:09 +0200
Message-ID: <20261124070710.9728-1-sashaneftin@gmail.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose the Symbol Error Count (SYMERRS) register to ethtool statistics.

The SYMERRS register (0x04008) tracks physical layer symbol errors. Define
the register, clear it during hardware counters reset, update it in adapter
stats, and export "rx_symbol_errors" in igc_gstrings_stats so it can be
retrieved via `ethtool --statistics`.

Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 1 +
 drivers/net/ethernet/intel/igc/igc_mac.c     | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c    | 1 +
 drivers/net/ethernet/intel/igc/igc_regs.h    | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 4ebc0c7f5fc4..dead327baa17 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -35,6 +35,7 @@ static const struct igc_stats igc_gstrings_stats[] = {
 	IGC_STAT("multicast", stats.mprc),
 	IGC_STAT("collisions", stats.colc),
 	IGC_STAT("rx_crc_errors", stats.crcerrs),
+	IGC_STAT("rx_symbol_errors", stats.symerrs),
 	IGC_STAT("rx_no_buffer_count", stats.rnbc),
 	IGC_STAT("rx_missed_errors", stats.mpc),
 	IGC_STAT("tx_aborted_errors", stats.ecol),
diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index d6f3f6618469..db28f1c2f24a 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -235,6 +235,7 @@ s32 igc_force_mac_fc(struct igc_hw *hw)
 void igc_clear_hw_cntrs_base(struct igc_hw *hw)
 {
 	rd32(IGC_CRCERRS);
+	rd32(IGC_SYMERRS);
 	rd32(IGC_MPC);
 	rd32(IGC_SCC);
 	rd32(IGC_ECOL);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e36d6761a0be..dbebdb0d15b8 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5237,6 +5237,7 @@ void igc_update_stats(struct igc_adapter *adapter)
 
 	/* read stats registers */
 	adapter->stats.crcerrs += rd32(IGC_CRCERRS);
+	adapter->stats.symerrs += rd32(IGC_SYMERRS);
 	adapter->stats.gprc += rd32(IGC_GPRC);
 	adapter->stats.gorc += rd32(IGC_GORCL);
 	rd32(IGC_GORCH); /* clear GORCL */
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index f343c6bfc6be..89f146d88d04 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -132,6 +132,7 @@
 /* Statistics Register Descriptions */
 #define IGC_CRCERRS	0x04000  /* CRC Error Count - R/clr */
 #define IGC_ALGNERRC	0x04004  /* Alignment Error Count - R/clr */
+#define IGC_SYMERRS	0x04008  /* Symbol Error Count - R/clr */
 #define IGC_RXERRC	0x0400C  /* Receive Error Count - R/clr */
 #define IGC_MPC		0x04010  /* Missed Packet Count - R/clr */
 #define IGC_SCC		0x04014  /* Single Collision Count - R/clr */
-- 
2.53.0

