Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC23C61DE2
	for <intel-wired-lan@archiver.kernel.org>; Sun, 30 Aug 2026 23:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 931594058B;
	Sun, 30 Aug 2026 23:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FS5r8zTgKn-c; Sun, 30 Aug 2026 23:22:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788132165;
	bh=EiW+JJ76BaAeq9W86nvcOxiyWOdlbAiuuIswuaS2d+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CrfwZkpv0b1TeT5RGBy5dCcU/DC9s/rAdhiLaR1619BMVZMdSN2pOBL3KfK2WsaUz
	 b8RD5aTbBEJtM0e7KLXdaBvus/gZMknl78iPvvQuSdYfOLgDqX2EX08KbRx0Eo8kOW
	 K13MhntjvtogrnVGiPNbRmDSXIXLZLrdeVrerO3yK7bldqwQJI+Pxmwan2r1WUiluJ
	 vZEuxt+Fban3jMvZNIMWEHQLlEEpGopZGrO3j7xDFLOfKzTcfPdj6oqx1rym0Cajqc
	 6g8ZcjzUSu/WovAgbTDu6FCvixSHE2dTAodZrWZ/v7LlNTSs2GCXxBUkU7OmKvd7Rj
	 24QuZJmksoBIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 084D64046C;
	Sun, 30 Aug 2026 23:22:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 038442AA
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDAE6605D9
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id STcwNdJ70_iT for <intel-wired-lan@lists.osuosl.org>;
 Sun, 30 Aug 2026 23:22:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=K6BBa2Tl
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8073605D3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:42 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8200b55dc47so24347947b3.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788132161; x=1788736961; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EiW+JJ76BaAeq9W86nvcOxiyWOdlbAiuuIswuaS2d+Q=;
 b=K6BBa2TlaNepZ5J89Mjd5Ni05IM90/g5DwKOGlrGWz8WXZl/JuO8fGnC5nTUxaXKnT
 U4SUiTVClpQELWtsLfb5r1ubxDxLaTvFtT23AVuvPACky6NZYnH5wHg44ItUwyDft6nI
 2mmWuwPRH+rxxWir58ZfS2iaSnxVjDC3wsTnDlcgNZLGvtH+vapWK6Y/zYbYaDPoqA74
 egg4oPD2CnAiAB9qmVXNwl3gxtRLObVVy/P3GaM9eJ7xXVkL5Kd6lmoaNxYHeRw1JRdw
 GiX8FhDF7agoX0ko78V/Q2I19Lek36j3vkkbK01i7iDmI8rA0cl7lkjKthAbfy6DQbqp
 pQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788132161; x=1788736961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EiW+JJ76BaAeq9W86nvcOxiyWOdlbAiuuIswuaS2d+Q=;
 b=Ix6qMd4HnAmy+S1sUHcL7dmH5Atn0mtpOPd8zDJje7XwaP14ucV7a82sitFVZsvCSt
 MAQ5VO6AYaCmlfy31iDWHWTCT9/qP+LYRLM+ZN38fO6PVfdMhDbn6K6soVX0fCjH6/rU
 zE03qwIaYADJs2Y8gW0KeUnbm0sVAED32GxGktZXIOo8FdsZ8zSq27MCGECmns/nmuPI
 us+ExbT6dp/+oasCJKbAhkJ1w2z9VCZy9VY362daBuhHekcy14eV7wZdJtQAPoHyg55+
 lJGfhj0wPyrjxE0t8M0MtpQOf0Y41e4kj+wSbl1EQ8KclTH4UHmiAVgGec/1CHa01WZT
 nwmQ==
X-Gm-Message-State: AFuF++mLygWjIS8MVOxjov/D9hPBQeLKErJFftdduPzqrBai0MNBssNb
 r0u6JTDlxQpRvq11QpGWW2xGQk15kBWKlFbDeOBvLIlbOsutyGJKol0jn8VnMFYmGok=
X-Gm-Gg: AYBFou2jTziU6fbTvUgSiFeCSk87MCmR5pm0MC4i074WhFY5RxyyrCovMw8ukWGpuAj
 u/vUzoXR1vG7yicoYlKtimp6Am70yp/9t6ES1MoXRRWhXrR9CufSFr38S2b1j5h8y30kbcqRIt0
 WsRxQPwy+KVcnDcgOb6FXeiIad+yAOcGRf7yQo6b0AN9Q60oTQOxZnKHc7L4j1f7oy9f6T6Jti9
 kjfL4Zboi0RmyMfeF5q2iTCgO3lYHotLW7QAoHAbXFOsz63BOJjSj6CHPDmfxyvLDJf3qZxI3OC
 tj8eqxdeUprfnfuvCxFihk5S8XzLY2+g41oTArf6eumJCq2ymFIo5Tv6lneOpL0qXVkAK3bwZ7v
 RdxMqhxmu5Ll0cjcEuKrFBQ1hyrzUlVVH/o32N7QjHlGU/HjsubYkLpzjHZgnlKkoO3MEurpSUO
 4PPwr9tmgqcFSkqj+InbuBXN2Gaf1uJhKNUDnPgBPRE1LFgE/J4Jw=
X-Received: by 2002:a05:690c:30a:b0:80f:9998:e614 with SMTP id
 00721157ae682-85d6eff6efamr86639137b3.28.1788132161448; 
 Sun, 30 Aug 2026 16:22:41 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e677606aesm39025937b3.45.2026.08.30.16.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 16:22:41 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-next 6/8] e1000e: disable NAPI while interface is down
Date: Sun, 30 Aug 2026 19:21:44 -0400
Message-ID: <20260830232146.36948-7-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830232146.36948-1-tactii@gmail.com>
References: <20260830232146.36948-1-tactii@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The upcoming page pool conversion requires that NAPI is disabled during
reconfiguration windows. Otherwise pool destruction would fail the
assertion that NAPI will not race, causing a benign but loud warning.

Move napi_disable into e1000e_down and add a napi_enable to e1000e_up.
This follows convention of all other Intel drivers.

Because napi_disable would hang if called twice, all callers of
e1000e_down must now be serialized. As of this patch, I'm convinced this
is true.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 194166531bc8..6d846cacb026 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3527,6 +3527,8 @@ void e1000e_up(struct e1000_adapter *adapter)
 	/* hardware has been reset, we need to reload some things */
 	e1000_configure(adapter);
 
+	napi_enable(&adapter->napi);
+
 	clear_bit(__E1000_DOWN, &adapter->state);
 
 	if (adapter->msix_entries)
@@ -3601,7 +3603,7 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
 
 	e1000_irq_disable(adapter);
 
-	napi_synchronize(&adapter->napi);
+	napi_disable(&adapter->napi);
 
 	timer_delete_sync(&adapter->watchdog_timer);
 	timer_delete_sync(&adapter->phy_info_timer);
@@ -4055,7 +4057,6 @@ int e1000e_close(struct net_device *netdev)
 
 	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
 	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
-	napi_disable(&adapter->napi);
 
 	e1000e_free_tx_resources(adapter->tx_ring);
 	e1000e_free_rx_resources(adapter->rx_ring);
-- 
2.43.0

