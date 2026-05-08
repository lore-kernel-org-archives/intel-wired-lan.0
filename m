Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB8DCD3445
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 15:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDF0C8443D;
	Fri,  8 May 2026 15:42:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q2GVH_99Eu7U; Fri,  8 May 2026 15:42:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A19C84437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778254947;
	bh=EAVUYgE7LocLLpiISnuzYat2WqQIK0QUTqYjNVqaTtc=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kC7Zi5oIOxmwf2D3ZVXCSt9Hecz+oYy/L4ExhHp+4RwPDi0dFjcEyJ30wvtHNOQLt
	 UX8By4jvBsjws24eMG1xm6NjNt3QHHfauunpvCYlRspYoOTNzrAP5aR7/YwT9n+aOi
	 4WkY34CQUBOIjwl4I0HLdm2ACK+X9UGgxo7qZya4hx3V66bej30th9KRp9rRMVksLa
	 iu1o1woXNN0BrkcwT1OYSru/metHoNG5saHh+MsEFV6z+t41yP4n0txAZ3XPi7/F+5
	 XTPjuO/usFVmZa8CmTNcgVoeXaqWNkxQ/5mQ393Noq4vW51Lm0fnzROwo+8tYGNLkc
	 +7ndvqtB5hSug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A19C84437;
	Fri,  8 May 2026 15:42:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 19D93358
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 15:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B17B84435
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 15:42:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jBVSxYk_qt0N for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 15:42:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1EDBB83F9A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1EDBB83F9A
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1EDBB83F9A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 15:42:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 145F3600AE;
 Fri,  8 May 2026 15:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D37C2BCC9;
 Fri,  8 May 2026 15:42:20 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: aleksander.lobakin@intel.com
Cc: 'Simon Horman' <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kohei@enjuk.jp,
 jacob.e.keller@intel.com, aleksandr.loktionov@intel.com,
 nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri,  8 May 2026 16:42:00 +0100
Message-ID: <20260508154159.1250696-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505152923.1040589-6-aleksander.lobakin@intel.com>
References: <20260505152923.1040589-6-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1778254943;
 bh=hpyMjuuhAA498YiMJD/7ERK/AlvHaCx8MmWRt7EyM+0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r3pbmeuPmFgZURnUdoN1bDWlA7HIgEWcv02J2eJLqk59Bm/CpTuOteR+/WLaQyYkZ
 17zYddFItB9pnhfy3LpCjzdgyYta+tHjzqTx1TyFYoWKuT7Ir83XJFQPbDlIv1t6oa
 2eQOMaQ6LoV/Ik8zcEv6cdOs+vUR42Kg07xoyB1lDG4PNTfndVJMoIf9nw5pUtWK/4
 XBzZFOB1b+ZxjAP2QVXRxPXPqrxPo2zYCjJ9BZZT4XI6UCWixIZBSDrv//YCB78eJK
 ZyCGQFP/ZSbQhFkFVUYQL02kYrpaHabc+xf3rNsCKutfqooxKuX8/KqAS6xrX4OB8C
 YcmVPpMaTP1ow==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=r3pbmeuP
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 5/5] ice: add support for
 transmitting unreadable frags
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

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: add support for transmitting unreadable frags

This commit advertises netmem Tx support in the ice driver. It modifies
the transmit path to conditionally set the buffer type to ICE_TX_BUF_FRAG
only when the fragment is not a net_iov, allowing the driver to skip DMA
unmapping operations for unreadable fragments.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index a88f9e3c00771..0e61b38e53a5e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3453,6 +3453,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
>  
>  	netdev->netdev_ops = &ice_netdev_ops;
>  	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
> +	netdev->netmem_tx = true;
>  	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;

By setting netmem_tx to true here, the driver accepts packets containing
net_iov fragments. If a net_iov packet exceeds ICE_MAX_BUF_TXD fragments, it
appears it will fall back to linearization in the transmit path.

Since __skb_linearize() uses CPU memory accessors that expect a valid struct
page, will this cause an invalid memory access when skb_frag_page() returns a
net_iov pointer?

Should the driver explicitly drop highly fragmented net_iov packets instead of
attempting to linearize them?

[ ... ]
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 43b4670760273..1d97e2cc2adee 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -113,11 +113,17 @@ ice_prgm_fdir_fltr(struct ice_vsi *vsi, struct ice_fltr_desc *fdir_desc,
>  static void
>  ice_unmap_and_free_tx_buf(struct ice_tx_ring *ring, struct ice_tx_buf *tx_buf)
>  {
> -	if (tx_buf->type != ICE_TX_BUF_XDP_TX && dma_unmap_len(tx_buf, len))
> +	switch (tx_buf->type) {
> +	case ICE_TX_BUF_DUMMY:
> +	case ICE_TX_BUF_FRAG:
> +	case ICE_TX_BUF_SKB:
> +	case ICE_TX_BUF_XDP_XMIT:
>  		dma_unmap_page(ring->dev,
>  			       dma_unmap_addr(tx_buf, dma),
>  			       dma_unmap_len(tx_buf, len),
>  			       DMA_TO_DEVICE);
> +		break;
> +	}

Does removing the dma_unmap_len() check alter the safety of the DMA error
recovery path?

If a mapping fails in ice_tx_map(), execution jumps to dma_error and calls
ice_unmap_and_free_tx_buf(). Since the failure happens before
dma_unmap_len_set() updates the descriptor, it seems this might unconditionally
unmap using stale descriptor state. 

Could this result in 0-length unmaps or erroneously unmapping persistent
net_iov memory?

[ ... ]
> @@ -338,12 +344,14 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
>  			}
>  
>  			/* unmap any remaining paged data */
> -			if (dma_unmap_len(tx_buf, len)) {
> +			if (tx_buf->type != ICE_TX_BUF_EMPTY) {
>  				dma_unmap_page(tx_ring->dev,
>  					       dma_unmap_addr(tx_buf, dma),
>  					       dma_unmap_len(tx_buf, len),
>  					       DMA_TO_DEVICE);
> +
>  				dma_unmap_len_set(tx_buf, len, 0);
> +				tx_buf->type = ICE_TX_BUF_EMPTY;
>  			}
>  		}

When mapping a net_iov fragment in ice_tx_map(), the descriptor is populated
with the length and DMA address, but tx_buf->type remains ICE_TX_BUF_EMPTY.

Because dma_unmap_len_set(tx_buf, len, 0) is now placed inside the
tx_buf->type != ICE_TX_BUF_EMPTY check, does this skip clearing the len and
dma fields for net_iov descriptors when they are returned to the free pool?

If these descriptor fields are leaked, could they be incorrectly unmapped later
if the descriptor is reused and a subsequent mapping fails?
