Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3D3CCF2D6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 08:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2717880EA4;
	Mon, 19 Oct 2026 08:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Oj0RtWRk__B; Mon, 19 Oct 2026 08:59:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4F93E80ED9
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792400393;
	b=hNf+HpFXhXoGFTjyJTRsyLz2s23mw/ICbQ+k8pGR2kLuzGdFyTLQTLzm1fdK+d/jOWNq
	 ztmj4ay3w5faeWt8kLiQ/War2ADH5QzHhwoeo2t7dUpkz0p0n4QBux6QCJHEFSf6hrsrQ
	 Gm3U23xs8OyKw4AAD7qJ9sKS9Vsd+coTSGNe7YCVUnPJD7tICQmu55skfnsnFJm2muAkj
	 /dGR+Zdmt1xe0i1xPRjR9wWkFKHWLNQl3eXnwfdramWSl1CopG4hoOmzraxRv5nOoG2YT
	 +3UCLalFdkoHmlBrba0eIFoWeNK/JbV3uMWchZq5fP8a/OlaCQ9n+rWDjgXCNih28og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792400393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sCVL4RVHLYpuCYuxj//ChNXUdT91AceghX66I3VsNi0=;
	b=bBoJu13yjM/iC1coF+gDWvYIVqEQ5UDQ4d2tTX9uO7bE/LbUg0O4tE9GmC7OE9uVrhD2
	 hmqDgPZ5WXO1QJvV1eyYkUWUtyoUW0tN8LkZjoReRzVYZWZa2Z5Y3LhPEyUn8m0jn/3/O
	 OqIKQQ6q2JX8tKXMIlYz6q6XlWp6v7NQ8mQIvRTLKkIkFypCIjvOz+HXS2nR3evrYWF0S
	 xQOm0EDlzwPoKWe3ouxOI1R3Cl+NT0PgJ8LW1RRnWPfWHEQjM4XhBrEjXtNJu/hhM+MWr
	 IbhGung3z11ofCshluhMGdSZPaR6r9BQk8WQip3ULXqVIlgJYAgygeeILjJ7e1zciUg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792400393;
	bh=sCVL4RVHLYpuCYuxj//ChNXUdT91AceghX66I3VsNi0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oGQqIHN7xBXg2O1WDnpkFW1x6u5jD86qxUJoEQsddMt108HTfHeNH7WToeJ269sDp
	 Nz27ga9Oo0TFkq2izO14KW4CdWTrEo3GEQyO2gNE/WyiymzEi1hDF+51awh9qbgPwf
	 OPPPUmgv5EyRQQRxUpKCXLaqwUxC4GFpW147RFtJMbtc0Qkr5nJMhvu3KEY8zlWYg9
	 sVLSvXIeHgAdcqVOAdX9Oc+S9GzqCXks+t7FAdf8DChUHtO5sTkvsAnXfI0lu1kKaD
	 fAmLMhgarK/Cp+xMFf2CGVYf3A0mye/qO6zj71XVYGQm4GaT2Kyq8YjKy1OPjDoHMr
	 7xDseAOn+WUnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F93E80ED9;
	Mon, 19 Oct 2026 08:59:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B1B4A1DE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 08:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A321640680
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 08:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pn5HB_jfuiGn for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 08:59:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD01A4067C
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792400390;
 b=ggu25gn7OiLUl/4JpDd5bqV+CaE8L/R4TKyUhDbbv2UfodU2DKnt01Yrpaqt6LZmdZqC
 Sp5T0udvI7eJ42jPiltS7FgFOyfaaoQGy2rvcD17RX8ezueB7E2nwLBpZhJy4nPoaOWm3
 JxHA+agsKqfmG9t94+mrTyzVgJTktYe5GlSQuOtD+dmqoq0OaOm9qALpSrxkhNX9uuB2f
 qOht2GYJNdQh1BCwTbDkdyBRAt4YUzx2xgumHd9fhiyAHxAlAAe9hvbK5teWeoyUTQzoc
 B/IWeCHUlg1OfsDImOowRW8ZBHJx2ikm0lxPe2omJtQYZioQDKRp48O8teoUcDWLKaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792400390;
 h=Received-SPF:Received:Received:DKIM-Signature:Content-Type:
 MIME-Version:Message-Id:In-Reply-To:References:Subject:From:To:Cc:
 Date; bh=sCVL4RVHLYpuCYuxj//ChNXUdT91AceghX66I3VsNi0=;
 b=WkMBkSmTjxuvEBzOaJSWrGoJ0htE+2voJ+e/PNCTwcEcJbjop6DhKRscpyx7bZxIgSud
 3E0gv4L50qFTYBmVbjFA4cOX+Qltyk0otzi5iaW6o6y7CiKZuBklZmBNJRZiYL3991qBE
 yGBkO2lgC9jrYUCMFMEOaQBAR8a65njy+wRvZK8gJD3BhOUX3ApopJRIPUI3Ps9qiaSbK
 v/DLHjRBvQJnPCrZks0hvLC61RBKcmJm9/wi+GdPVjUpVfJIN8dz6BWZX3QINAzcSlgUL
 Qwji+QLBKAq6loRQCIBUNFWsAOB4PU7UDMeLLlXpjifwLaiSIYimzqySpOGNaOZdkgQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EeQu4m7M; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=bot+bpf-ci@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EeQu4m7M
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD01A4067C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 08:59:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A254E401D4;
 Mon, 19 Oct 2026 08:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D54B1F000C4;
 Mon, 19 Oct 2026 08:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792400389;
 bh=sCVL4RVHLYpuCYuxj//ChNXUdT91AceghX66I3VsNi0=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date;
 b=EeQu4m7M+rJLArRDfjnc0TYAbstjwDqvpihjZ7BzpYQL2mj5qSY+WyoCtI3hwd1TF
 LZjv9bPsfKrPnypcZPmZ40aEwV+wJUBzlqraa8bBS5oJNr1scba76D46Mj+m70FAgV
 N6FGWuTHOZt3DVdFIg07G4gRZXXTEgy89DiMWPVLX5in8KCWesbjg3/QZud518uSvD
 Flmq5a7v+rMGURY3Bq2vq5ALlr5RmqCbPxavQwxeIrRmZxsDjDM90HQLljtamqJdQT
 aVIFFP7qHDkYDk9JrkwwbSG9KMHDbDhCW2dbvi81I8vj0mNZQLyKUuha7eaUEVgdkP
 t0u4EyM1UIlFQ==
Content-Type: multipart/mixed; boundary="===============6491243909759321778=="
MIME-Version: 1.0
Message-Id: <222cfd632a97f75821b9f4671671253934825dfe1f1abee532816b26a0b47f33@mail.kernel.org>
In-Reply-To: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is full
From: bot+bpf-ci@kernel.org
To: marcin.knap@vecima.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jtollet@cisco.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, marcin.knap@vecima.com,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
Date: Mon, 19 Oct 2026 08:59:49 +0000 (UTC)
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

--===============6491243909759321778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> xsk: Do not free ZC Rx buffer when the Rx ring is full

TL;DR: Since xsk_rcv_zc() no longer frees the buffer on a full Rx ring, gve
DQO zero-copy Rx may leak one UMEM frame per dropped packet and eventually
stall AF_XDP Rx; it likely needs xsk_buff_free().

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..0edc160c660f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -252,9 +246,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	}
>
>  	return 0;
> -err:
> -	xsk_buff_free(xdp);
> -	return err;
>  }
>
>  static void *xsk_copy_xdp_start(struct xdp_buff *from)

Can this leak the UMEM frame in the gve DQO zero-copy Rx path?

With this change xsk_rcv_zc() no longer frees the buffer when the Rx ring
is full and it returns -ENOBUFS, so every zero-copy driver has to free or
keep the buffer itself when xdp_do_redirect() fails.  i40e and ice are
updated here, but gve DQO also relied on the core free:

drivers/net/ethernet/google/gve/gve_rx_dqo.c:gve_xsk_done_dqo() {
    ...
	case XDP_REDIRECT:
		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog)))
			goto err;
		break;
    ...
err:
	u64_stats_update_begin(&rx->statss);
	...
	if (xdp_act == XDP_REDIRECT)
		rx->xdp_redirect_errors++;
	u64_stats_update_end(&rx->statss);
}

The err: path only updates stats and never calls xsk_buff_free(xdp).

The caller, gve_rx_xsk_dqo(), then calls gve_free_buf_state(rx, buf_state),
which puts the buf_state back on the free list.  gve_alloc_buf_state() later
sets buf_state->xsk_buff = NULL without freeing it, and the ring-stop cleanup
only frees xsk buffers attached to allocated buf_states, so nothing calls
xp_free() on this buffer.

The path that gets there is:

gve_rx_dqo()
  gve_rx_xsk_dqo()
    gve_xsk_done_dqo()
      xdp_do_redirect()
        __xdp_do_redirect_xsk()
          __xsk_map_redirect()
            xsk_rcv()
              xsk_rcv_zc()
                __xsk_rcv_zc()
                  xskq_prod_reserve_desc() returns -ENOBUFS

Before this patch the err: label in xsk_rcv_zc() freed the buffer in exactly
this case, which is the scenario the commit targets (user space not keeping
up with the Rx ring).  After this patch gve DQO leaks one UMEM frame for
each packet dropped because the ring is full.  The frame never returns to
the pool free list or to user space, so under sustained overload
xsk_buff_alloc() starts failing in gve_alloc_buffer() and AF_XDP Rx on that
queue stalls until the socket is torn down.

The commit message says "A failed xdp_do_redirect() leaves the buffer owned
by the caller, and drivers rely on that" and names only i40e and ice as
relying on the core free.  Does gve_xsk_done_dqo() need an xsk_buff_free(xdp)
on the XDP_REDIRECT failure path as part of this change?

The other zero-copy drivers that were checked (ixgbe, igb, igc, libeth/idpf,
gve GQI, mlx5, tsnep, fec, dpaa2, nfp, stmmac, icssg and virtio_net) already
free, recycle or keep the buffer on redirect failure.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39223384647
--===============6491243909759321778==--
