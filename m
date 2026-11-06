Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62C606A339
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=RjfmdgbS;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4oAZvCq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFA3F606A5;
	Fri,  6 Nov 2026 11:11:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8EBtR2YClEUY; Fri,  6 Nov 2026 11:11:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F306607CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793963490;
	b=M9JvXMuJuCDKx+tip3ETyRco9Ayf66bfuzW0E4BHC36caaDua+1g3W7wCPpwAA3gbM+h
	 kIF+wDIU8ApDWA5wJ0Fx1LYV1jRA5pMZuJNrFPt0rUFC4nmgI52oA+y0rylr0seGThZEC
	 8+lGPUh9AtOCKY36rwJIgGe9zmP5GlKSRaaFM7/ZOHGoLRNM0aU0/EFfl1aq0f34IBLnI
	 pKVGm/xVd7TWqqKSk0U5HYm/25bPSviSGdlsyjOTzHMFhuB2rnMlN8Ey5vuG/nN5GTvHm
	 TiHHZbWdMa83dAQg60NYsSEU1b2rEhAhIF8eXOE4q8HAJRqZnp5+aRIupGO1EBdvc4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793963490;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2TCSFRqB1VT/51qxAzdDDlKE5fIfeOnrCaZNdRqchMA=;
	b=cPX6qRF25WChIyQzuLcuxslIeU2n7qTtsLFVFU7ED8gNMmsz40p1KrqyETLvV+20V+C/
	 3iGhTPkeQkOYZHgnbOIzy5D/IUXmOwyv5HR1tPPetwio4Kb1/tmATvAXwHeHPUzbnNKf4
	 eYznoppO8gmtPrf4Z4/uv3opP52Qk38HTRUYX0ryXhkV6cw60CD+uo3tKjv6H500HmVCS
	 eDFd0GWXjo144Fp1A6gNeBRpaNUGf/fukMXryq5FugcLBuF+vPgMKBPRu6jRJYBhB8cMV
	 amo+LlHqb25hiemtiB+Ywy4DG0WGyCbKgb4glErRhjqWl1lLp7wRlHyIKZgLHl8291w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793963490;
	bh=2TCSFRqB1VT/51qxAzdDDlKE5fIfeOnrCaZNdRqchMA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RjfmdgbS5iNaa0I4SDtYBeaFAl51CQWuPvQSLWA9SSjmfIWmfgnpOVEFHMCzIOu8a
	 hxJIwxOwlnpYab7vSeRscPB+VJA60dMMY7R4fLmt9d+fkZVnxVxDpaRCwdTJTF5PZO
	 GI2IRClekA/hpUZI8U9QYJXbsbWEZ3uuNP9S+KNPxfBx2TMTtnBXPBIwqmgAA1fwGJ
	 WzFI+2N8drwihtcAvWzCNI9X4Sm55PfHu80IkPZxHwb3fbbRRt6vCi0PiDzYRo75wo
	 jkVt3Flj/Byy+ZriuDIcNK4me9Hxwpe4AuDJoGlTZTOvUBBA8nDWBdPl4tTKgBmds5
	 mM9qdrZaLD+kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F306607CF;
	Fri,  6 Nov 2026 11:11:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD4D62AC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 11:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEECF40554
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 11:11:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MWb7_TiqyYVf for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 11:11:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 884DA405E9
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=n4oAZvCq
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 884DA405E9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 11:11:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6452F4396F;
 Fri,  6 Nov 2026 11:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D281F0089F;
 Fri,  6 Nov 2026 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793963487;
 bh=2TCSFRqB1VT/51qxAzdDDlKE5fIfeOnrCaZNdRqchMA=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=n4oAZvCq2992sUstzwpmoVVBPrV4cYtzfOyX/xKu5+VfHf51y+tGNNBfOdLfQZJJe
 WEaklyz8/R3DScWiyEHAAyezFfRsv6Z3IJbo0XyS3Ilo/xiheT7euupzYXTJ26kNnu
 ipAj6s3l8cAGNQ6XmE/jAQRBcGaaxP4wPFjpZo5ng/ELq3U/+xnowT5cqMe7ujrQHq
 yXeQOYpbMjrGh54lKPOQRkhisE4oV8jFB+uLld7y9y1OBG3YjVaYhRXuJPWtLp58/s
 SFxsSm6n7gEryS9MZUp7+ZB3w1RQTcGOIkHe8nrTQsoDigtMOQ3uWbsPpf4oFRtAtr
 lSF+NAfsGAhAw==
Subject: Re: [PATCH net v3] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
From: netdev-bot+sashiko@kernel.org
To: marcin.knap@vecima.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jtollet@cisco.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 bjorn@kernel.org, kerneljasonxing@gmail.com, nshettyj@marvell.com,
 joshwash@google.com, hramamurthy@google.com, sgoutham@marvell.com,
 gakula@marvell.com, rkannoth@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com
Date: Fri, 06 Nov 2026 11:11:25 +0000
Message-ID: <179396348511.994134.3480253108877320302@kernel.org>
In-Reply-To: <20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973@vecima.com>
References: <20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973@vecima.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (3) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, ixgbe's need_wakeup -ENOBUFS path keeps a
  live buffer and runs XDP on it again, but with stale data pointers.

Pre-existing issues:
- [High] The rule that the caller owns the buffer when redirect fails
  still breaks when a zero-copy buffer is redirected to anything other…
- [High] In otx2_xdp_rcv_pkt_handler()
  (drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c), the two…
- [High] In otx2_xdp_rcv_pkt_handler()
  (drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c), the AF_XDP…

--

xsk: Do not free ZC Rx buffer when the Rx ring is full

This commit stops xsk_rcv_zc() from freeing the zero-copy buffer when the
XSK Rx ring is full. A failed xdp_do_redirect() now leaves the buffer with
the caller. The drivers that relied on the core freeing it (i40e, ice, gve
DQO, octeontx2) now call xsk_buff_free() themselves on that path.

> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index 82ed5e48b00ab..cc544420df112 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -686,8 +686,10 @@ static void gve_xsk_done_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
>  			goto err;
>  		break;
>  	case XDP_REDIRECT:
> -		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog)))
> +		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog))) {
> +			xsk_buff_free(xdp);
>  			goto err;
> +		}
>  		break;
>  	}
>  

[Severity: High]
This is a pre-existing issue, but does the rule in the commit message, "A
failed xdp_do_redirect() leaves the buffer owned by the caller", hold
when a zero-copy buffer is redirected to something other than an XSKMAP?

For non-XSKMAP targets, xdp_do_redirect() calls
xdp_convert_buff_to_frame(). For MEM_TYPE_XSK_BUFF_POOL that ends up in
xdp_convert_zc_to_xdp_frame(), which copies the packet into a new page
and always frees the ZC buffer:

net/core/xdp.c:xdp_convert_zc_to_xdp_frame() {
    ...
	page = dev_alloc_page();
    ...
	memcpy(addr, data_to_copy, totsize);
    ...
	xsk_buff_free(xdp);
	return xdpf;
}

__xdp_do_redirect_frame() can still fail after that. Examples:

  -EBADRQC for a bare XDP_REDIRECT
  -EINVAL for a missing ifindex
  -ENOENT during broadcast map teardown
  -EOPNOTSUPP, -ENETDOWN or -EMSGSIZE from __xdp_enqueue()

The err: label only traces and returns:

err:
	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, map_type, map_id, ri->tgt_index, err);
	return err;

On this error, mlx5e_xdp_handle() counts a drop and does not set
MLX5E_RQ_FLAG_XDP_XMIT. The XSK Rx paths in mlx5e then skip setting
MLX5E_WQE_FRAG_SKIP_RELEASE, so the buffer is released again at WQE
refill.

Wouldn't that produce the same duplicate UMEM frame, and the same
possible NULL dereference in mlx5e_post_rx_wqes(), that the commit message
describes?

dpaa2_xsk_run_xdp() has the same problem: on a redirect error it calls
dpaa2_eth_recycle_buf() on a buffer that is already on the xsk free list.

The copied xdp_frame page also seems to leak on every such failure.
Neither __xdp_do_redirect_frame() nor __xdp_enqueue() frees xdpf on error.

For gve DQO and octeontx2, the new xsk_buff_free() is a second free on
this path. It is harmless because xp_free() returns early for a buffer
already on the free list, but the page leak remains.

Neither the commit message nor the changelog mentions this path. Could
they say that the mlx5e duplicate frame problem is only fixed for XSKMAP
redirects?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 90af9b9044aa0..6d10c132f61cb 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -1555,7 +1555,8 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  				*need_xdp_flush = true;
>  				return true;
>  			}
> -			return false;
> +			xsk_buff_free(xsk_buff);
> +			return true;
>  		}
>  
>  		err = xdp_do_redirect(pfvf->netdev, &xdp, prog);

[Severity: High]
This isn't a bug introduced by this patch, but the non-ZC branch just
below has the same problem the commit message describes for the ZC
branch. On redirect failure it does:

		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
				    DMA_FROM_DEVICE);
		xdpf = xdp_convert_buff_to_frame(&xdp);
		xdp_return_frame(xdpf);
		break;

It then falls out of the switch to return false.

otx2_rcv_pkt_handler() treats false as "not consumed" and continues with:

  napi_get_frags()
  otx2_skb_add_frag() for each cqe->sg segment, with a second
    cq->pool_ptrs++
  skb_mark_for_recycle()
  napi_gro_frags()

xdp_return_frame() has already given the page back to the page pool. Is
the skb then built on a page the pool can refill to hardware? And is that
page returned to the pool a second time when the skb is freed?

Should this branch also return true after freeing, as the XDP_DROP case
does?

[Severity: High]
This is a pre-existing issue, but on the zero-copy path the on-stack
xdp_buff in otx2_xdp_rcv_pkt_handler() is never initialized:

	struct xdp_buff xdp, *xsk_buff = NULL;
	...
	if (pool->xsk_pool) {
		xsk_buff = pool->xdp[--cq->rbpool->xdp_top];
		...
		act = bpf_prog_run_xdp(prog, xsk_buff);
		goto handle_xdp_verdict;
	}

This jumps past xdp_init_buff() and xdp_prepare_buff(). Only the
XDP_REDIRECT and drop cases check xsk_buff, so in ZC mode these cases run
on the uninitialized struct:

	case XDP_PASS:
		*metasize = xdp.data - xdp.data_meta;
		break;
	case XDP_TX:
		...
		xdpf = xdp_convert_buff_to_frame(&xdp);

Does XDP_TX here dereference an uninitialized xdp.rxq inside
xdp_convert_buff_to_frame()? With CONFIG_INIT_STACK_ALL_ZERO that is a
NULL dereference in NAPI context; without it, it is a wild pointer.

XDP_PASS also seems to compute metasize from uninitialized fields, and the
caller then passes that value to skb_metadata_set().

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 781ba46eb1525..89bac2feeff26 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -224,21 +224,15 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	struct list_head *xskb_list;
>  	u32 contd = 0;
>  	u32 num_desc;
> -	int err;
>  
> -	if (likely(!frags)) {
> -		err = __xsk_rcv_zc(xs, xskb, len, contd);
> -		if (err)
> -			goto err;
> -		return 0;
> -	}
> +	if (likely(!frags))
> +		return __xsk_rcv_zc(xs, xskb, len, contd);

[Severity: Medium]
Now that the buffer is no longer freed on -ENOBUFS, ixgbe's need_wakeup
retry runs XDP again on a live buffer. Is the buffer state still correct
for that rerun?

When need_wakeup is enabled, ixgbe_run_xdp_zc() returns IXGBE_XDP_EXIT on
-ENOBUFS. ixgbe_clean_rx_irq_zc() then breaks out without clearing
bi->xdp or advancing next_to_clean:

		} else if (xdp_res == IXGBE_XDP_EXIT) {
			failure = true;
			break;

On the next poll the same buffer is processed again with:

		bi->xdp->data_end = bi->xdp->data + size;
		xsk_buff_dma_sync_for_cpu(bi->xdp);
		xdp_res = ixgbe_run_xdp_zc(adapter, rx_ring, bi->xdp);

xdp->data and xdp->data_meta are not reset first; igb uses
xsk_buff_set_size() for this. Any bpf_xdp_adjust_head(),
bpf_xdp_adjust_meta() or header rewrite from the first run therefore
carries over.

After adjust_head(+N), wouldn't the rerun window extend N bytes past the
received frame, possibly past the end of the UMEM chunk? If the second
redirect succeeds, user space could get a shifted, truncated or over-long
descriptor.

In this patch, i40e and ice free and consume the descriptor on EXIT
instead. The v2 notes leave that change for ixgbe and igb to a follow-up.
Should ixgbe drop and consume the descriptor here as well, or reset the
buffer before the rerun?

On igb, the commit message says:

  - ixgbe and igb keep the buffer in the ring on their need_wakeup
    -ENOBUFS (XDP_EXIT) path and run XDP on it again on the next poll.

In igb_run_xdp_zc(), out_failure falls through to XDP_DROP, which
overwrites IGB_XDP_EXIT with IGB_XDP_CONSUMED. Does igb actually ever take
an EXIT path? If not, the igb part of this description looks inaccurate.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973%40vecima.com
