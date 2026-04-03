Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140FAE85367
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 14:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA9FC81B69;
	Fri,  3 Apr 2026 14:06:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L7PTPkHloER9; Fri,  3 Apr 2026 14:06:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E60B281A58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775225163;
	bh=+YyL/9bPtBuow7+iyQbmirEYnk9NwzhKUQx4v3NvZ5E=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xMmLDTz8Wm024Rrdu3s498Av3SJHcggpzXt1o8ewJsxD16nEc4OZghs6YsqF1bWf9
	 pstN+H8QyI9YeEPMaiu6lTmOGQCG+KtRhTcw10uu+XOaUlIhfC8GkTUihjWlJx8JFc
	 lT3KVPH0+xHqpjrOVyhUxo9KOjqnVfsglzAmIhzLPRIm+VsL2B+pwMCEAmxRGonCHo
	 bdexSesglSZPOuaC/Vq1WXAcBL+TBBJpTB9BAs/mGiT/jZKMTKzk834PFxfrEmfnn0
	 o0j8iEv3xMK1amypJLA2CotTZP6AYhC1kXYCVMKlN8YZ9wdUfKp2LCgD1Z5ou2JCk/
	 tLFLH7KMJZElw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E60B281A58;
	Fri,  3 Apr 2026 14:06:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C0051A9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 14:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5BBA440D51
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 14:06:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rrNpXRoGBUVh for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 14:06:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BC4BB40D0C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC4BB40D0C
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC4BB40D0C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 14:06:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 05E4560132;
 Fri,  3 Apr 2026 14:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A98C4CEF7;
 Fri,  3 Apr 2026 14:05:57 +0000 (UTC)
Date: Fri, 3 Apr 2026 15:05:55 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Message-ID: <20260403140555.GH113102@horms.kernel.org>
References: <20260329145122.126040-1-kohei@enjuk.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329145122.126040-1-kohei@enjuk.jp>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775225159;
 bh=dPL04DWhjNrJecRKU97SRfyIoJ78lkDa9XPzjHYqYBk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OKx4crZ+McLwDe6RNaSO6h8jbx+f+E+uWq8OvMuAcDJz0a0QmbNRdk4S0HvR8dVLW
 0Mzdgw3QT4mi6EG4Hy0MvupGZ+oyOgzxMSEmGT2lClWjF7pz+AEXlKsKy2nSKqZVgh
 HjEIG8MukR+FJ98FX1vN5uAy9hkjl2NxVwStEp2NYJlTlIDv/6CMrWfJxSpKdQ1jZi
 vbBrXhEGwZGKJpGM3RXM4AJREdhk0IJrc8t+novzWfwWC4PCY6mFN/lJTXAPbce/wK
 bl9PHoT57/dUotN8w3DPRWRWEQkuk7pvMtMFMp3GfkMGLZyRJu18b8LohbN7E7DeW2
 fnrdzA8/Rb9yw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=OKx4crZ+
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] igc: fix potential skb
 leak in igc_fpe_xmit_smd_frame()
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

On Sun, Mar 29, 2026 at 02:50:49PM +0000, Kohei Enju wrote:
> When igc_fpe_init_tx_descriptor() fails, no one takes care of an
> allocated skb, leaking it. [1]
> 
> Use dev_kfree_skb_any() on failure.
> Also call igc_flush_tx_descriptors() only on success.
> 
> [1]
> unreferenced object 0xffff88813aee1b40 (size 224):
>   comm "softirq", pid 0, jiffies 4294709256
> [...]
>   backtrace (crc dee31384):
>     kmem_cache_alloc_node_noprof+0x54f/0x640
>     __alloc_skb+0xd9/0x5b0
>     igc_fpe_xmit_smd_frame.isra.0+0xad/0x510
>     igc_fpe_send_mpacket+0x32/0x80
> [...]
> 
> Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

I am wondering if we can achieve this while sticking to the idiom
that the main thread of execution is for the non-error flow,
while conditions handle errors.

Something like this (completely untested!):

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 8a110145bfee..02dd9f0290a3 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -109,10 +109,16 @@ static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter,
 	__netif_tx_lock(nq, cpu);
 
 	err = igc_fpe_init_tx_descriptor(ring, skb, type);
-	igc_flush_tx_descriptors(ring);
+	if (err)
+		goto err_free_skb_any;
 
+	igc_flush_tx_descriptors(ring);
 	__netif_tx_unlock(nq);
+	return 0;
 
+err_free_skb_any:
+	__netif_tx_unlock(nq);
+	dev_kfree_skb_any(skb);
 	return err;
 }
 
