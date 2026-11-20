Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D6606A330
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ZeodgV0y;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YrCQWT5f
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B087960E95;
	Fri, 20 Nov 2026 16:33:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k_oExxg9yO4b; Fri, 20 Nov 2026 16:33:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 224B860E90
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795192390;
	b=csT6VWEyklh9JT53o23k58NZ8ivcy4BB85C3nx/XPV8TtrWsRmIAcxHdd67VEsvu1Ym9
	 FO9mugmx28IINa9SphnEaiLwYMxGj5iarCFIzUFpVzAP2Y/9wxA4QUJJecX8A92CzuOos
	 rrjrcRSLEAq6X2FMkI7wlD1FUQoKfRH0hWDvp923Z7y2LvCKjpEEk6l/p6J3/u2YHvIJF
	 dQoXw0sVuh8XpESKqsKNlFWmthHO/bOdsXVI8dAShMvEjfN76KR1WbvZiyQMExvDxs3tK
	 7HGHufUtDSRt3Bkg9N/4vTcpms3YpNnolIe4/RlNEREoz/sUz1F4f9/zrRkgTGDiAcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795192390;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zX8OGEfLFGtorWxYFS4Yag3CUaXahlHcZyg8u0XBH7A=;
	b=X0mzU5H8qh2NSicvDOdt9EC152JJZZOE52VO7eqQRunT9VYYgXmC6GiKkDRt1A7e5F5L
	 p4nGtfAxCLRG8zYxlDReKUNHK/LdyLPTtbyOefcj2H4vv6N+vUIYQg+USzbP6FUWpCGEd
	 Xhrksgd3b748hdDQv2JXd3qO1ytpFciklCvCuCp5E/qIhRDoKKTdqicC7hAYO6vICQE0U
	 k7709cDrgwUjEGIyeW7SKilBIELa6gm6yMSwnVhvHFN20SyaFr0/yFXFM/EkviQ86lCQ7
	 hrtcHqkjX4YmFihFTMTmd/S+e9Yf8EuQAX+bEcZ18K0FUDWJLQABqhYL+nO7pIKYqcw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795192390;
	bh=zX8OGEfLFGtorWxYFS4Yag3CUaXahlHcZyg8u0XBH7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZeodgV0yNOl/g1evwoSSizyi4vuaBamanKyd8YwnnV/w/hShPCinDacmhcLNhcX6J
	 NNqDZG+z6/kVGnm3nVs9msc4FpTcxYvR/edQz4w0r6+qR11JiAKmYHupUfqhoTjTrM
	 8SIyA7JH1DzieXeRN+AdN/hdV3yB49M450LrrDj0gdc5vEnHGW/uY9AbcqpOgOf2a9
	 jSfOtjAoY0NLuEiBy3nVR3f7dWiIog6JVz0QdTqEaPJ4ZEgUrMndtozHmwBlVrnjMp
	 ON0u7oDU7z6AiVy+ElhYxfNPC19riVM+nY0LjqAO/eIy0UvhBMijV7taZyxPqfHKNe
	 1B5WlnqZfJFdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 224B860E90;
	Fri, 20 Nov 2026 16:33:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 55C58E52
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3BE518167D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:06:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ibqgFSOqWNq5 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 15:06:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 724428167B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com;
 envelope-from=shital.gandhi45@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=YrCQWT5f
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 724428167B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:06:51 +0000 (UTC)
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1b3b4944a0eso859154c88.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 07:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795187210; x=1795792010; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zX8OGEfLFGtorWxYFS4Yag3CUaXahlHcZyg8u0XBH7A=;
 b=YrCQWT5fXVn9fA1yuJx46mpHkf3PMSEmUiyjLtozGCzIBoiMVFVkOH6xuYIKO7mang
 WLt1DXL8hMR+A6qTgZlbklGHA5s09UsiqM5vXKH22EmkdnIL5IP6ox+aZ8kAKCLEXy0p
 zdc0TzmW7SSeZfIBTwwJqeRMAd77q/nxG4Y/l6XVUM9qSxEz0k8eQLzoeVyMzpW6Bj/V
 zNPTCZaMvv0SEpaJiEAaqYZhUmkk8c0giRQZUEKOtahU5g5Hea41Ij+CiCEY5xhLjAOw
 5+vJklyQTspvZfODf/Cve920TUK5QxQLgrXohQcaNJZRIzuEQrnvLupVyQKRu6kNQ+dY
 +U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795187210; x=1795792010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zX8OGEfLFGtorWxYFS4Yag3CUaXahlHcZyg8u0XBH7A=;
 b=bDgYm7syM+I3ka1L73mUw9SRAMWfC1mZByPEAeoBQsHI5CqiNaYwNUupY81deWJbWS
 Vup1JodEchAprBK2L9iHfnuh4qxdBh9wgFTkxw4qtDUgAhmf6guxJ6btEBuszvE2/E6I
 9KhPA/DZM+rVwQj5OF1sPMhzexNBKOEO5D+rvYSlE0cJr02BBLCDf+y4hm1P2+StD1P9
 mI8VF3cGvOyHlrjkfgFbY6TVAbLZ+LKgA7u9fL5EL9NiEcroQpxLLJuPC7gpFH5B8DDU
 J6jrVUufN3u/Hr/F3N8anJy90IjEwkplnvPQiX1lUZjZVt9L7gIp7j0zr06gOPvCMFOv
 /PRA==
X-Forwarded-Encrypted: i=1;
 AL+hErGm936E/MtydDEtahcNGSv5nf/O3AURGyL5ianUxf1w/3kmYI203KCgrE8XRqYiUYaSHFCWv3wQSGKM/IQJA9E=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/Grlbmya2tZev3ae20OIiEWF51lAlkIwHSbogh0miheSqOnTJj
 3JwAug3ravKUWwsi9L4kTMHrCyhmdyKz+WUgDEPu4W4LM5NYTK3z0sqO
X-Gm-Gg: AYBFou0BQi6S7GszP2JmUKsNWYzhiKLVwzZarnUM2dh9cBXGAmwIXr38+QiT37Tgnvt
 d2yydrF2BuiIiCQuVHsmRpqpKKSNJ+8f7Gtq90KMyN74B3OaPFWWpFe6DQ6ytdHXZwj++NUC2Ws
 xwk8SHvZEuzVriDyK1qDqaAsIxSrrA1Ov220ZvOJ+O+n/JWSjsYEhkD6AYKj7fYgsSu6Ohf3p9N
 d+WbLs9V2k2SVYhpvAH7ojDdfw2BSwIs9eILMc5Sdm9CsJpeHh69+obgzhZf4xCA3F1VYN1TOEw
 Xd4XkI/+SYQY3/4nCSec7EhkyRieDQQuZ+LfJgovFjFGR+8dRModDItwOh2ks6C0zjpt+i8TPQ7
 Vy13oZ51cE5cNvVHkAejLhvFTURYPf6kRkP4y9lLXjB4Fzsyn71zOluuYXtynV2IE5lFIWJ27Ce
 XiwrNgIhdAFtJLrk5MMCTWQCjeRVscksV6J5c4ebdUKVca3PJOnOlHy6Fx6yvL8aCkJ8a/qXWBq
 ElCsxDNHSqSzefXBFKblzbSkGPymHnPcACzq6yAlFnlxrW4AIYgQNS7lm933r21jGqYID075nYy
 rM5F4qyNxMIHvZrbHFP+7hQjZbtvin/UYfnVTpLEnLMNXmdkIW7WLj1V48CizGg=
X-Received: by 2002:a05:7022:3a83:b0:1b0:20:6444 with SMTP id
 a92af1059eb24-1b55690779bmr3017028c88.39.1795187210255; 
 Fri, 20 Nov 2026 07:06:50 -0800 (PST)
Received: from IN01-9QQVVV3.CAMNWK.COM ([171.76.82.79])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556840494sm7844902c88.12.2026.11.20.07.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:06:49 -0800 (PST)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Subject: [PATCH iwl-next 1/2] i40e: wait for one RCU grace period in
 i40e_down(), not one per queue
Date: Fri, 20 Nov 2026 15:05:26 +0000
Message-ID: <20261120150527.14649-2-shital.gandhi45@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120150527.14649-1-shital.gandhi45@gmail.com>
References: <20261120150527.14649-1-shital.gandhi45@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:33:05 +0000
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

i40e_down() calls synchronize_rcu() inside the per-queue loop whenever
XDP is enabled, so bringing a VSI down waits for num_queue_pairs
back-to-back grace periods. This is paid on every ifdown, reset, MTU
change and XDP attach/detach.

The wait is there so that in-progress ndo_xdp_xmit and ndo_xsk_wakeup
calls have finished before the XDP rings are cleaned. Both bail out
when __I40E_VSI_DOWN is set. When the caller has set it, as
i40e_vsi_close() and the reset path do, a single grace period after
that covers every ring. Callers that do not set it,
i40e_vsi_reinit_locked() and i40e_set_ringparam(), are not protected
against new calls by the per-queue wait either: a call can start right
after any of those grace periods.

Wait once, before the loop. While at it, use synchronize_net(), which
takes the expedited path when rtnl is held, as commit 405d9999aa0b
("ice: replace synchronize_rcu with synchronize_net") did for the same
pattern in ice.

Signed-off-by: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index abbc71e81..99f59079d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7611,15 +7611,18 @@ void i40e_down(struct i40e_vsi *vsi)
 		i40e_force_link_state(vsi->back, false);
 	i40e_napi_disable_all(vsi);
 
+	/* Make sure that in-progress ndo_xdp_xmit and ndo_xsk_wakeup calls
+	 * are completed before the XDP rings are cleaned. They bail out on
+	 * __I40E_VSI_DOWN, which the caller has set, so a single grace
+	 * period covers all rings.
+	 */
+	if (i40e_enabled_xdp_vsi(vsi))
+		synchronize_net();
+
 	for (i = 0; i < vsi->num_queue_pairs; i++) {
 		i40e_clean_tx_ring(vsi->tx_rings[i]);
-		if (i40e_enabled_xdp_vsi(vsi)) {
-			/* Make sure that in-progress ndo_xdp_xmit and
-			 * ndo_xsk_wakeup calls are completed.
-			 */
-			synchronize_rcu();
+		if (i40e_enabled_xdp_vsi(vsi))
 			i40e_clean_tx_ring(vsi->xdp_rings[i]);
-		}
 		i40e_clean_rx_ring(vsi->rx_rings[i]);
 	}
 
-- 
2.53.0

