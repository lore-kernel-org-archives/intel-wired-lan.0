Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E115CCF2DA
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 08:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F21166069B;
	Mon, 19 Oct 2026 08:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Cg3uF6J17y0; Mon, 19 Oct 2026 08:39:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1B2B260722
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792399173;
	b=qOZic3P9i9/eOZam8+lhYIEBbOh4HyHFqBnOMGiRC22F4WBmqbw47hxXu4sp3CN1aA1X
	 BpK9cqZLvkTUP/sooZp2CpVgQcGRtE5HaA0R97/AF7rHpItV75JzkqtLxIRzY+lqtg+Zf
	 atGWZyT/xQbecKmzBKKCOTeHvO5KYRi1uAynzBPXFcFfv3aEdThoDeVyl1y0GchIBy1Cr
	 +nanlQyD8GGk2AZj9L+MlBf9+QdtBUDqag/64EfQBVBJB/Xeb5wg7qamDyz7Nwn4Fweuu
	 xJ6wplKFvNnL9M8uLTv1SgO5VwEUEy2ajlg1Huofd58qK+DUxhs2tAIGvpbIBnWCEOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792399173;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ARRolzGWF+9JkMPtETvDfAVJklJOhengJAuGm4xchBM=;
	b=S2oFPChRq343W/Ewv3juf5gRuyCP3aifJ0MZqp9SgEbTyJzF2kcdHab1Q1jMQh4Lap1V
	 Kc6Yq4OEgEhW+mXJ5cmW6odjXhh7hyQlZqKDdY7RxidpxeVF4/mkTABdHjK1OxCo9hav+
	 3cru3FPNIWto+0qkN5q6gft4nnYZ2i7i6LUKVkvLLKg3nIepnvpIXuOd1ikwLO0RoCqUk
	 bCOU0Rm5LoPUfrSplFRj3DTIoW21ofRhnE4mUfRZY8zhOby+KT8G14+WPnoNIz0LPSFDL
	 1vw+XFoJf1q0gIgFB+aKv3Y5YmWxd5vKu64XDYl02JJeaa5x7U9fVs1cpmffcsUFzsw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oi1Ld0op;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792399173;
	bh=ARRolzGWF+9JkMPtETvDfAVJklJOhengJAuGm4xchBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=qzbr5q0oIMOXNvejK0oAHm4yX19d2dRTucaMzfurJUOVERA6l9HCV4CTl2+mVauFH
	 veSm5N8KXa0wU9YEON6YeQvJ2RFAo3X7HslFgHYP8AcXCzUp/uumh+4CETqG25cvaQ
	 qp8V3Evpmt/gXJk3ylKp3fnTuzoEIWg6+xCR+TpV3UC8pHV/g8CkF0sDx9VsmHq9Rw
	 GDeOiAtSS4C+r68bhbCKpBlk7E3JQ0lEDvvZC8IX6cdFg24aW2YRYsgKu5IMduR7yk
	 Uk87nCYo/kkT1vR4AWSsxlfm65UMESxk97OfLBZYFonayM+auZoTXz1cfW6/lpQRJV
	 6tzVyB6j3eiNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B2B260722;
	Mon, 19 Oct 2026 08:39:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F40DD465
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 08:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5E1460722
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 08:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CmDS-vN3i4X5 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 08:39:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9FD6D6069B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792399171;
 b=e/e6AzRl7i93SerzpSmFGXBhW/02wK33EzEvOk8/xC2+8z2mZRvnl/JE2b0PvjJY0JIs
 yZqyEzfFH95HFus2dTLbzETJR68Nq8jAC4ZevAfsqofzvI1lX/FniN5/AK3AwFqvMzdY6
 cgfWJ82DzxVan+7HYM9dOUPH+goZnokD1Z0KgkiLqZSN/7rdNkwyL2x380FZE7FqZNnl6
 IfVL7V9wgGTgOPgPwqo73wMVEIHFAFIXfuDOLtnM5tGIREDXEYHoGotCeNrSCSr9nwdqQ
 vAo4v1xLD6UmpdQY5euE/1LhTGALI4lHV56UukNFNF8N2/tUdz1c8OjuXEcZ8x5IQQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792399171;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=ARRolzGWF+9JkMPtETvDfAVJklJOhengJAuGm4xchBM=;
 b=GkedMTsuSnBnvsQRI3zTJvsp21ecZDz2gCbeENKsfSqhH6cdOdB1t4XTqkuaNCWnXxSQ
 tWV+5vbURw84hDt09f7Nfviwt5pEQXi1pXudwg3je5WAcg2ZWn4ENtJXAz9vJrsLGEpQg
 BHbwwgk1uR+guT6HRKiy7o0vGe5ezJNx1EgzCrkttSpMHXspxgulGw/G6KzvwpTgFevsg
 7CHVyIaiyhBlC997iv10T8R7/yMfuwulm3yM46gpZF3EGmBITt1qu8QESRmj9xzR0O7vj
 Yq7+JtO8Sx5yRg6bvrJn9WvU8reRRsMUnUcmeXSIC+wgMzJTOXXWJn04ZWBzJXk5N5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oi1Ld0op; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oi1Ld0op
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9FD6D6069B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 08:39:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20236601FB;
 Mon, 19 Oct 2026 08:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DDD1F000C4;
 Mon, 19 Oct 2026 08:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792399168;
 bh=ARRolzGWF+9JkMPtETvDfAVJklJOhengJAuGm4xchBM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oi1Ld0opU0n8wBf4xCaVxyNqB2vAzs8eTL0P3ikc45I+SV3fNmq7QcFeHfhNp90z8
 g4qd82wQVjLP7TdP4s8IAsCv5FIh1k+kH34tVpwvmGXwelKzh6zU2Cj7sg44zMZz1S
 T0PKhDmqrRedhmrGOG8Vohk3lfrNE4rBO7NzVI0lADuOrVNc7JqBS8Et3fc2cuo6E7
 NArHymYMN5xq/SO2b3CRQEYNxJex2AB9I7tby41n7YhaonO2Wz6UhBJ1ZFIiuCFRDo
 ea3sDJaWPJleiDemGAcrSDW5pikYLYmWBOudWBsdjv/xY76CqQyUymHuJu2q2+KQPp
 gxrHqjyGyeG5g==
Message-ID: <sashiko-outbox-176817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is full
To: "Marcin Knap" <marcin.knap@vecima.com>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:39:28 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] xsk: missing xsk_buff_free() on redirect error in gve and octeontx2
--

commit 2859b3e778dcb29dabcd4c998977aac223d207b7
Author: Marcin Knap <marcin.knap@vecima.com>

xsk: Do not free ZC Rx buffer when the Rx ring is full

This commit stops xsk_rcv_zc() from calling xsk_buff_free() when the XSK Rx
ring is full (-ENOBUFS) so that callers of xdp_do_redirect() do not
double-free the zero-copy buffer. It also updates i40e and ice to free the
buffer on their XDP_EXIT paths.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6f..0edc160c660fd 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -224,21 +224,15 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct x=
dp_buff *xdp, u32 len)
>  	struct list_head *xskb_list;
>  	u32 contd =3D 0;
>  	u32 num_desc;
> -	int err;
> =20
> -	if (likely(!frags)) {
> -		err =3D __xsk_rcv_zc(xs, xskb, len, contd);
> -		if (err)
> -			goto err;
> -		return 0;
> -	}
> +	if (likely(!frags))
> +		return __xsk_rcv_zc(xs, xskb, len, contd);
> =20
>  	contd =3D XDP_PKT_CONTD;
>  	num_desc =3D xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
>  	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
>  		xs->rx_queue_full++;
> -		err =3D -ENOBUFS;
> -		goto err;
> +		return -ENOBUFS;
>  	}
> =20
>  	__xsk_rcv_zc_safe(xs, xskb, len, contd);
> @@ -252,9 +246,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp=
_buff *xdp, u32 len)
>  	}
> =20
>  	return 0;
> -err:
> -	xsk_buff_free(xdp);
> -	return err;
>  }

[Severity: High]
Does removing xsk_buff_free(xdp) here leak xdp_buffs in gve and octeontx2
when xdp_do_redirect() fails with -ENOBUFS?

In drivers/net/ethernet/google/gve/gve_rx_dqo.c, the call chain
gve_rx_poll_dqo() -> gve_rx_dqo() -> gve_rx_xsk_dqo() -> gve_xsk_done_dqo()
handles XDP_REDIRECT on zero-copy buffers without freeing xdp on error:

	case XDP_REDIRECT:
		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog)))
			goto err;
		break;
	}
	...
err:
	u64_stats_update_begin(&rx->statss);
	if (xdp_act =3D=3D XDP_TX)
		rx->xdp_tx_errors++;
	if (xdp_act =3D=3D XDP_REDIRECT)
		rx->xdp_redirect_errors++;
	u64_stats_update_end(&rx->statss);

Its caller gve_rx_xsk_dqo() then releases buf_state via
gve_free_buf_state(rx, buf_state) without freeing xdp, leaking it from
rx->xsk_pool.

Similarly, in drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c, the
call chain otx2_napi_handler() -> otx2_rx_napi_handler() ->
otx2_rcv_pkt_handler() -> otx2_xdp_rcv_pkt_handler() pops xsk_buff from
pool->xdp[--cq->rbpool->xdp_top] and does not free it if xdp_do_redirect()
fails:

	case XDP_REDIRECT:
		cq->pool_ptrs++;
		if (xsk_buff) {
			err =3D xdp_do_redirect(pfvf->netdev, xsk_buff, prog);
			if (!err) {
				*need_xdp_flush =3D true;
				return true;
			}
			return false;
		}

Should gve_xsk_done_dqo() and otx2_xdp_rcv_pkt_handler() also be updated
to free the zero-copy buffer when xdp_do_redirect() fails?

>  static void *xsk_copy_xdp_start(struct xdp_buff *from)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-xsk-zc-rx-=
double-free-v1-1-2aa19f6628fb@vecima.com?part=3D1
