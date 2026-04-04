Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A046E88D8B
	for <intel-wired-lan@archiver.kernel.org>; Sat,  4 Apr 2026 11:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAA2740A5D;
	Sat,  4 Apr 2026 11:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ct65OnxVt2K0; Sat,  4 Apr 2026 11:40:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9DEE40A3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775302840;
	bh=MPq1pUu+fEtcun1am5TUsNjkCUb+pzJqigWwnFIwT9k=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SMdEENUr0ossbBQ3ltLv3et6eUhmfA0v/4/QFROAtfBz7iBuiVYdV73JX3/Iv0aBU
	 JK/hXpflVu5ONK1KqkGK6cCHbl17XdpN5K4qf5gvWRzoPlmxZAdB/qF01Fqwt6yvOe
	 cSVNmuxyOr/OEoFxMaf01oa0IWlkrjfRvGir05pCtrhAVO93fSBayW5Nyb874Weh3S
	 BaR/XMNaTYadsJsxWqOzEV0Gp9OKDz8WkY58RP0FgB5DiL0Sn0bIIrnpMakT26iQDg
	 iOuq68XFYFToM17hnzTrSFaXc5aWs1reqOopQugYB4k06N81KkCjgMTsuS+43Fmp5F
	 H20WxtpWuq6uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9DEE40A3E;
	Sat,  4 Apr 2026 11:40:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C25CB75A
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Apr 2026 11:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4208810A0
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Apr 2026 11:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2KmBgL6nKi1Y for <intel-wired-lan@lists.osuosl.org>;
 Sat,  4 Apr 2026 11:40:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D3C6681099
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3C6681099
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D3C6681099
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Apr 2026 11:40:37 +0000 (UTC)
Received: from x1 (13.3.31.150.dy.iij4u.or.jp [150.31.3.13])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 634Be5DL006352
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 4 Apr 2026 20:40:07 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Sat, 4 Apr 2026 20:40:05 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Message-ID: <adD4AUcEWQ4lEh1g@x1>
References: <20260329145122.126040-1-kohei@enjuk.jp>
 <20260403140555.GH113102@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403140555.GH113102@horms.kernel.org>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=MPq1pUu+fEtcun1am5TUsNjkCUb+pzJqigWwnFIwT9k=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1775302807; v=1;
 b=wXtFIZZbgl4ot7WXuTlRU3TXuzrvI3TCoP1fqHCYSb9boNphY3YAKwyTHL0FCQfu
 rUuAOc1utxk3FEnoucXkJSXpB2HImHIQQ15ZX5v+e1GfGT1iZg2oQ5A3Dq/gJr/+
 R2LYHQ143M+G+gr6M/W7csN1uUCUu5/NeMYSFownviPJf5v2ZaH7TRCjiLjrAiN6
 /2w4gTk/NWCyLWG6QRe97RIXA5HtIz7uRkS/jX2f0ny+QZBLBmBaWfW7AuTrdicx
 aYR2emSgoZKdR/80vMn5haM2tlmk/xn2MZzvTVybpx+ljTc1mrOTBaIBSv9MhRZ+
 oixu0m9JlRv7EPJ4AM5RTg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=wXtFIZZb
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

On 04/03 15:05, Simon Horman wrote:
> On Sun, Mar 29, 2026 at 02:50:49PM +0000, Kohei Enju wrote:
> > When igc_fpe_init_tx_descriptor() fails, no one takes care of an
> > allocated skb, leaking it. [1]
> > 
> > Use dev_kfree_skb_any() on failure.
> > Also call igc_flush_tx_descriptors() only on success.
> > 
> > [1]
> > unreferenced object 0xffff88813aee1b40 (size 224):
> >   comm "softirq", pid 0, jiffies 4294709256
> > [...]
> >   backtrace (crc dee31384):
> >     kmem_cache_alloc_node_noprof+0x54f/0x640
> >     __alloc_skb+0xd9/0x5b0
> >     igc_fpe_xmit_smd_frame.isra.0+0xad/0x510
> >     igc_fpe_send_mpacket+0x32/0x80
> > [...]
> > 
> > Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> 
> I am wondering if we can achieve this while sticking to the idiom
> that the main thread of execution is for the non-error flow,
> while conditions handle errors.

Hi Simon-san, thank you for the suggestion.
I agree. It seems cleaner for me. I'll work on v2.

> Something like this (completely untested!):
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 8a110145bfee..02dd9f0290a3 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -109,10 +109,16 @@ static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter,
>  	__netif_tx_lock(nq, cpu);
>  
>  	err = igc_fpe_init_tx_descriptor(ring, skb, type);
> -	igc_flush_tx_descriptors(ring);
> +	if (err)
> +		goto err_free_skb_any;
>  
> +	igc_flush_tx_descriptors(ring);
>  	__netif_tx_unlock(nq);
> +	return 0;
>  
> +err_free_skb_any:
> +	__netif_tx_unlock(nq);
> +	dev_kfree_skb_any(skb);
>  	return err;
>  }
>  
