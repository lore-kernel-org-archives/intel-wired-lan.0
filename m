Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89E3C87FCC
	for <intel-wired-lan@archiver.kernel.org>; Thu, 31 Jul 2025 13:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E13A8440A;
	Thu, 31 Jul 2025 13:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5b-8qChb2b9; Thu, 31 Jul 2025 13:36:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8B9F8439C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1753968966;
	bh=eIpeLj5KHve04WGn4PRtt593jBSgVzXjJNsFV3Jkkes=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lU/+6eL00IHCAr2Qq7zhrXn6ztT5u2v5WAJEr+MFONSEAjV496o8Grq+eJbZbuKdp
	 WqaSuUEHsDjyLfzG3Fbp3Li9/pkVGbHB0AZrc2GAEY2i4vbX2tMwbDCckyECnelIOh
	 aU7vv1eYJZM7hXIBhH9BUJ/H4UTrur/RsRb4ENqCsClDanP/COdgOGMH47baMOqcra
	 PTPxmDr6vvRJJ+v7w518RiXGOLp//4lQEMriSwISXoqmS9BHdJ5uG0yKDHReueatek
	 fr0B4y2e/mUJjbVx0rf9vBvOLz7H2xbCRe7NpX5rBtOHZr8yT4AVJ2OZOmBFMCPDsu
	 rNxJIxeoxRKog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8B9F8439C;
	Thu, 31 Jul 2025 13:36:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C30E9160
 for <intel-wired-lan@lists.osuosl.org>; Thu, 31 Jul 2025 13:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACFA661AEC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 31 Jul 2025 13:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VULS7b2xAagQ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 31 Jul 2025 13:36:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F3D0861B31
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3D0861B31
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3D0861B31
 for <intel-wired-lan@lists.osuosl.org>; Thu, 31 Jul 2025 13:36:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 11FD0A55336;
 Thu, 31 Jul 2025 13:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8990CC4CEF7;
 Thu, 31 Jul 2025 13:35:59 +0000 (UTC)
Date: Thu, 31 Jul 2025 14:35:57 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Michal Kubiak <michal.kubiak@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 nxne.cnse.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20250731133557.GB8494@horms.kernel.org>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
 <20250730160717.28976-17-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730160717.28976-17-aleksander.lobakin@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1753968962;
 bh=KyS0YK7eZU4aWlqqSlmnifoI1DVY+qASIuVMpm0Wk8M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j9cu3POghgzQfUtBUIplaBzrzNwhGOc6oVLq0yV0K73DS8+xpLh1WGipIheNSEisW
 gtaZXhKmUx1YU/UAxlykG793eGPQ6+biMr8w3ElbP2um4WUO7y6muSOoXlPRcn8wfb
 PI7fVO5IDluDRqPdQ/jlzm1w3KfxU3j9hn3VMJKjT0es0CxNOfPWUv+oVss251A/f7
 vTbIuWvqZ0HtEX2T1K6KURzm9/r8ZG+Vj+4oU5X+92zc3DMJVV1sKsX7drkww4jNZP
 /aVpVdG1J0jG9ETgKRb07YclTpS6VYcnBBD+Tl/UVaE8rmnLF3SkZ7INeLcmoJoz38
 IbQmg5FEdwA8g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=j9cu3POg
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 16/18] idpf: add support
 for XDP on Rx
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

On Wed, Jul 30, 2025 at 06:07:15PM +0200, Alexander Lobakin wrote:
> Use libeth XDP infra to support running XDP program on Rx polling.
> This includes all of the possible verdicts/actions.
> XDP Tx queues are cleaned only in "lazy" mode when there are less than
> 1/4 free descriptors left on the ring. libeth helper macros to define
> driver-specific XDP functions make sure the compiler could uninline
> them when needed.
> Use __LIBETH_WORD_ACCESS to parse descriptors more efficiently when
> applicable. It really gives some good boosts and code size reduction
> on x86_64.
> 
> Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c

...

> @@ -3127,14 +3125,12 @@ static bool idpf_rx_process_skb_fields(struct sk_buff *skb,
>  	return !__idpf_rx_process_skb_fields(rxq, skb, xdp->desc);
>  }
>  
> -static void
> -idpf_xdp_run_pass(struct libeth_xdp_buff *xdp, struct napi_struct *napi,
> -		  struct libeth_rq_napi_stats *ss,
> -		  const struct virtchnl2_rx_flex_desc_adv_nic_3 *desc)
> -{
> -	libeth_xdp_run_pass(xdp, NULL, napi, ss, desc, NULL,
> -			    idpf_rx_process_skb_fields);
> -}
> +LIBETH_XDP_DEFINE_START();
> +LIBETH_XDP_DEFINE_RUN(static idpf_xdp_run_pass, idpf_xdp_run_prog,
> +		      idpf_xdp_tx_flush_bulk, idpf_rx_process_skb_fields);
> +LIBETH_XDP_DEFINE_FINALIZE(static idpf_xdp_finalize_rx, idpf_xdp_tx_flush_bulk,
> +			   idpf_xdp_tx_finalize);
> +LIBETH_XDP_DEFINE_END();
>  
>  /**
>   * idpf_rx_hsplit_wa - handle header buffer overflows and split errors
> @@ -3222,7 +3218,10 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
>  	struct libeth_rq_napi_stats rs = { };
>  	u16 ntc = rxq->next_to_clean;
>  	LIBETH_XDP_ONSTACK_BUFF(xdp);
> +	LIBETH_XDP_ONSTACK_BULK(bq);
>  
> +	libeth_xdp_tx_init_bulk(&bq, rxq->xdp_prog, rxq->xdp_rxq.dev,
> +				rxq->xdpsqs, rxq->num_xdp_txq);
>  	libeth_xdp_init_buff(xdp, &rxq->xdp, &rxq->xdp_rxq);
>  
>  	/* Process Rx packets bounded by budget */
> @@ -3318,11 +3317,13 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
>  		if (!idpf_rx_splitq_is_eop(rx_desc) || unlikely(!xdp->data))
>  			continue;
>  
> -		idpf_xdp_run_pass(xdp, rxq->napi, &rs, rx_desc);
> +		idpf_xdp_run_pass(xdp, &bq, rxq->napi, &rs, rx_desc);
>  	}
>  
>  	rxq->next_to_clean = ntc;
> +
>  	libeth_xdp_save_buff(&rxq->xdp, xdp);
> +	idpf_xdp_finalize_rx(&bq);

This will call __libeth_xdp_finalize_rx(), which calls rcu_read_unlock().
But there doesn't seem to be a corresponding call to rcu_read_lock()

Flagged by Sparse.

>  
>  	u64_stats_update_begin(&rxq->stats_sync);
>  	u64_stats_add(&rxq->q_stats.packets, rs.packets);

...
