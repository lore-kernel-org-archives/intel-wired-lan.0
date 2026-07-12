Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438A7C43458
	for <intel-wired-lan@archiver.kernel.org>; Sun, 12 Jul 2026 13:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0179340A96;
	Sun, 12 Jul 2026 13:22:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qxAQRfakwDoz; Sun, 12 Jul 2026 13:22:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEB6140A8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783862570;
	bh=f+YFzVviG3DzxMqpa6xeKwhT6SuFAN+/OdOMSnwiZgU=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PFij0y/JTGJzIMGiZL0T4eD8OHrylRJi4ln5/GMJCQuAmvDeKRg88na3HTtvgJC8l
	 +CqiCbe8vdYD1HtUeA7/ctx3K17S9wZM96VNgx0+fgBle4HYGP/zJIqjOMdyTKUdtx
	 +S8G1AU0cRqO1nbXqpIdOYR10n93at2Z/7B+qRpdUqTRdvQh5XzJSO5Wy+VZZ+LXdv
	 DdbZ0K8hCdkNPRdts5jQLss1+9QggXNmI//CIGB1/U6xXlSG217BIQgdyq7GvVlkP1
	 i7HWDtRCF6YCgu1CR4YzcdsJ6wiuckDvEdqS1Gw3Ndb2qfA5hywKZtZ/mYwUBiByUC
	 3u/ET0G+vySLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEB6140A8C;
	Sun, 12 Jul 2026 13:22:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEA962EE
 for <intel-wired-lan@lists.osuosl.org>; Sun, 12 Jul 2026 13:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B03B140A8C
 for <intel-wired-lan@lists.osuosl.org>; Sun, 12 Jul 2026 13:22:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YSTKCQzC4eFm for <intel-wired-lan@lists.osuosl.org>;
 Sun, 12 Jul 2026 13:22:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=devnexen@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BBE9240A8A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBE9240A8A
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBE9240A8A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 12 Jul 2026 13:22:48 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so16068005e9.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 12 Jul 2026 06:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783862566; x=1784467366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f+YFzVviG3DzxMqpa6xeKwhT6SuFAN+/OdOMSnwiZgU=;
 b=RsgM1oB9L1PVZGJSGIMXKwKBw5PYf11IK3hBB1ydnp3NlWQgsHDQ50Q45bOHZ6ZeOX
 GXjF3sEcBUPosyyGJ3hySQIxjC4ZBbTD4NTw5YVp0I2kRvHR0I1i2GeVZbDQvXF27VdD
 BSY++DfBU0hHgSM6As7V9m5xGLRQUbB0dL9PVtlmAYEVw9NdykXQ6va0CLmklzw3rfNp
 j0w9p6DJ3qE38kMrPvYVbYSCterk/OE1UA+Kxcq6UJ9GwfKal1RnZNFhHtr5mJ+qBBAg
 NAygXl5mFP8+ULfDfwedLds8PQgVP7nIr9TLxltuniVmze58Tov2GXVfwPryDot2gMhr
 1SyA==
X-Gm-Message-State: AOJu0Yy0kEgRpdWM53rx3YpAGHc3/BqhFU1W4QOFqsNluMQadIf2Nnao
 2uRKHbwcjgXVBbreeCzodxSPd3biSuAmOjb80liQub4LklT7jjZ8F9iydft/4Q==
X-Gm-Gg: AfdE7cnt44/BIAmSoF1y6DxzzlAMLUIk7RWzzW1tXDgVLXnk+aMs3Okvor+fkowIzRA
 fUuNuGDyF3qpHLWCiphK+3TWiKZJSB1w8b9vuf208/iL5BA4DgJ8j71Svlxh8bHYH4xl+TnTHBY
 nQAduMyiEqhwqA8xCgs/dTf4Uaoxkpmk84hwP7z35KcC0zOEMMuAZ0uJtbuo4NhfiDA6KOSAXqa
 E8x3oDnj3HZiUppEOpdcXsiXaTuTDfksL1vnCyhrdmruOQdXB/mdNa2qpNIpUQsg20Ya2HzRFtU
 UrUr0M4R1AUBhd2VrQSLwifF+ZTcNUV8EvyI17guLTI7rGS5+sc6pqlb5jAHKOAHU8+ZGKmUCq0
 KZgRFjtGIZgayEbELZ9Zr9gcDhxTTNj80AWiPnrouiYbZ2PAZ9Zz8EdGpzxi6xRkJNC6Y0QV3Jy
 fRAaMGCdf5UFHrFqKwdwFFcvZpfwgbI3scA8YO5R9MXhJZLjjes31n0VhgpEWBBPVlNvSMzwxh
X-Received: by 2002:a05:600c:8b52:b0:492:53e8:3bc1 with SMTP id
 5b1f17b1804b1-493f87f3cffmr58484955e9.17.1783862566268; 
 Sun, 12 Jul 2026 06:22:46 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f4cbc620sm180883955e9.13.2026.07.12.06.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 06:22:45 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 maciej.fijalkowski@intel.com, aleksandr.loktionov@intel.com,
 advoretsky@gmail.com, stable@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Date: Sun, 12 Jul 2026 14:22:42 +0100
Message-ID: <20260712132242.223254-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783862566; x=1784467366; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f+YFzVviG3DzxMqpa6xeKwhT6SuFAN+/OdOMSnwiZgU=;
 b=THm0R2LxCB0Wu0COy1yKXnMziZTQFJYrq8X54phV+6xxE6yyTP0YFkvaxT8rQA83jF
 rcBiAU2No/6C4JdEGGRH2tpM+9GBs044Ed/zbJx8caMM0UH7TydOwpSfsCEM9ZuCuXMH
 Vk8H9GN8MoLEm8GXjkHrCl6uvaPYMGH8Mwmplhuu7P326JJmr08Qxp/fyDSyokewD9w/
 YDimcNgrqtrliqLNzgQNDmRmTsxus/3zWjTSqpRMFcSvzYyaNKXAig7JHe4XIF2wNkgr
 d4D1wjLBBk16gCb43wGgPF+ywTKBjZDFsxyVDpHEpMclbxmvV13ijNgVZdE4gRoAsxZw
 3prQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=THm0R2Lx
Subject: [Intel-wired-lan] [PATCH net] igc: remove napi_synchronize() in
 igc_down()
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

When an AF_XDP zero-copy application is killed abruptly, the XSK pool is
torn down but NAPI keeps polling. igc_clean_rx_irq_zc() then returns the
full budget on every poll, so napi_complete_done() never clears
NAPI_STATE_SCHED.

igc_down() calls napi_synchronize() before napi_disable(), so it spins
forever waiting for that bit and the interface never goes down. Drop the
napi_synchronize() and let napi_disable() do the job -- it sets
NAPI_STATE_DISABLE, which forces the stuck poll to complete. Reorder it
ahead of igc_set_queue_napi() so the NAPI mapping is cleared only after
polling has stopped, matching the recent igb fix b1e067240379.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..b3883a5a7d7a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5352,9 +5352,8 @@ void igc_down(struct igc_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
-			igc_set_queue_napi(adapter, i, NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
+			igc_set_queue_napi(adapter, i, NULL);
 		}
 	}
 
-- 
2.53.0

