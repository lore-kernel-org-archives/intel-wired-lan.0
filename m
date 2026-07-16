Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB64EC4450A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 10:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86E47407A9;
	Thu, 16 Jul 2026 10:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SYs7YCFxjstw; Thu, 16 Jul 2026 10:42:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4BEB40692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784198559;
	bh=BLp9vfm76Yd/0vFs3+TtMxXwa8V/xVY/MTryj+uNLVw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QFw9gKoBdHi1A+7zN1IMiQi/Ec8NeAiwwhVTBRlZb3ZdK/8NP52pHhvbgAaLLJUkM
	 rNasQfUtU2IVxg+Gus5yNfF/pzdEmS/tssglW4l86zKiJ2P1rfSY4YA3z1oDGgYwPT
	 Yeal+x0g2+kyO3TX+3LRK88BaAStWJE/7Co5kNtSX6lUcZye7xQh3VSOWaXSLZ4KAZ
	 PzA7CGg+iw0XRGH9hHs7pQaaNhU9cclIzZOsXa9oTgtKwTuH0WNi8tG7ED3AV/oaJy
	 1MjazGJvP8WEayso0HrBSYEbni+V2NGY7ydkesg28i0JY939KHSqFx8iNCdTAWluSh
	 pwF2o8NMRJ3sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4BEB40692;
	Thu, 16 Jul 2026 10:42:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B46E2426
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 10:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CFEC4025A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 10:42:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQ3z7QGgkCMx for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 10:42:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C64C440084
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C64C440084
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C64C440084
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 10:42:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 381EB600B0;
 Thu, 16 Jul 2026 10:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30771F000E9;
 Thu, 16 Jul 2026 10:42:33 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org
Date: Thu, 16 Jul 2026 11:42:17 +0100
Message-ID: <20260716104217.268158-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710065530.4138116-1-aleksandr.loktionov@intel.com>
References: <20260710065530.4138116-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784198554;
 bh=BLp9vfm76Yd/0vFs3+TtMxXwa8V/xVY/MTryj+uNLVw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=obGFhfJ9oWEVKxGxNts3U7Gft+Tp1IFs+rEf07M7CXM2C9S96HHPGe7AnZHX0UDpP
 dA6oFNUyRM990GhyePFibuRnjAifAtBHEAWpk/Vyy6itr87p45w8MSasYRaKAoBQ0m
 +cajaUqQcexF47r7BZkUlmPah466HiXHyZoacsuhXdnXjAHKCcpdTwsA63C9BFUcNZ
 T9GJAGiq7eADOWv0xFqoMoeM/p+YffERastf0h2AACwSHmimjoWWVbJ8DxDMljcMSc
 wOalf0WpQdumBVHXIPZk/FY0NSnbWKRrB36Dj1T8m17/wty0gXbCOySGqqKqvw29f7
 0MKnOwRUbwC5A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=obGFhfJ9
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] i40e: fix set_ringparam
 error path freeing live Tx rings
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [1]: [PATCH iwl-net v1] i40e: fix set_ringparam error path freeing live Tx rings ---
commit 7042e7b9f58a75bdb26437aed842a7b6780df035
Author: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

i40e: fix set_ringparam error path freeing live Tx rings

This commit fixes an issue in the i40e_set_ringparam() error path where it
mistakenly frees live, NAPI-active TX rings instead of the temporary rings
allocated for a configuration change. It does this by passing the address of
the temporary rings instead of the live ring pointer.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 3da9ec49cc745..6d2b076049f7e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2249,7 +2249,7 @@ static int i40e_set_ringparam(struct net_device *netdev,
>  	if (tx_rings) {
>  		for (i = 0; i < tx_alloc_queue_pairs; i++) {
>  			if (i40e_active_tx_ring_index(vsi, i))
> -				i40e_free_tx_resources(vsi->tx_rings[i]);
> +				i40e_free_tx_resources(&tx_rings[i]);

[Severity: High]
This is a pre-existing issue, but does calling i40e_free_tx_resources() on
the cloned &tx_rings[i] inadvertently reset the Byte Queue Limits (BQL)
state on the live TX queues?

Because the temporary rings are shallow copies of the live rings, they
inherit the netdev and queue_index fields. When i40e_free_tx_resources()
cleans up the temporary rings, it calls i40e_clean_tx_ring():

drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_clean_tx_ring() {
    ...
    netdev_tx_reset_queue(txring_txq(tx_ring));
    ...
}

Since i40e_down() has not yet been called on this error path, the live
queue is still actively transmitting. Locklessly resetting BQL here
zeroes num_queued. When the hardware subsequently completes the
already-queued packets, won't dql_completed() underflow and trigger
a BUG_ON()?

The same issue also seems to be present in the earlier error path if
i40e_setup_tx_descriptors() fails.

>  		}
>  		kfree(tx_rings);
>  		tx_rings = NULL;
