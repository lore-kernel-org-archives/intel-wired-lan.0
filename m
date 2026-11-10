Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F2606CF15
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=UurC9sDU;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIDb4p9A
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38650407DA;
	Tue, 10 Nov 2026 04:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZH3etH2A6w6F; Tue, 10 Nov 2026 04:10:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6374A407C7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794283825;
	b=UQwJikU78FW8git53JzhHKcb3QzdVZ8VvlvGynQBNAgMEEWwWHypQ8M5dGXHreyQGoTY
	 zyBksI61+m3yUwaQMoTbNgoSN2YRFSpdjGMCyPyDVoiXjG1o06CB4zR9WE4M1y948ZK8U
	 uv5TTfz4r8fO3Cy5BMQhLEgGVJBZUqDDy5G0g4C3XyQGrp15kkeH2rWq9ccKfkjNMN77A
	 rGSQ5kucowx0GiZM6gtuxaxH2We7x9B6SiKnBkrt11/krT55g1XWQTP8kDpJ6VnQzZ8gO
	 rg2rDd3jiaSRAuldHAe4BxZUx3BZPF1JoPy+aWDkzS69gqP8BQwGhqKPWZ6ct73vM9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794283825;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=miTH91FU73AzmU2Fuek8eqWk6PC6BVPMe1SNLQf3Dv0=;
	b=RmKBjMbZnHL0BfXoRg6UAOQp1J1Rfp6+JpOB/LTdmM3P5tqG+5TIRfXybnizvHID1WYU
	 UhjoUKrY7rldqvLT/gheAA/Hn9ltex15Yu1OVZAxr0XFDYUWfsS5RX9pV2Oo6R5qUdNVW
	 6yAvRP8n6Yqk7LPfszCMJ+33uvKaG7axtnblNNOH39sH2LkIatW7NT9ZYP3BysfS8QT5n
	 6g9Pi5sHSRlBv+hjmSkI1t1hjpk34edabhN60KKA6hzTONw5SK14Z8Gy1bwdDhkc8HB/O
	 wihelQt2SBtkh3BWNPDFoOaemcp6ZrCwnj3scVERDaVfq32vV/WsXk3Pvx7aa5y26kA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794283825;
	bh=miTH91FU73AzmU2Fuek8eqWk6PC6BVPMe1SNLQf3Dv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=UurC9sDUDp43CCutcfKj/KcEw1KqSEy2owK4STNMR/EvULuq4aefulmeSpvzW8Ghj
	 fhpIv19+N9esETznYLZXMKvmkhixt4wGFlO9yGrTka1upu0daG+eye6okVFTGh7pCy
	 r7QTCe88hhBiu7ttRcm65I5WCML0g6d9UbeV3YJ/5R/SlBKhyzO7pJYE4mO1KbYkhr
	 vPc4uxBWJBC24mkUvmj9AYuaoqJbPkK1369z+xXm5v2cFk08j5j8xlCW3GTLQvybif
	 SKwx9tJ9jDnSy3MhibkP9DMcQdxYzpRVgNMZQCCs2ipZ6TFopN0xPQmvsYsZre/YJd
	 D1mFfN7qJHs4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6374A407C7;
	Tue, 10 Nov 2026 04:10:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F32E1FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74978607FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:10:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ST8xcy544lCc for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 04:10:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7CF7C607C2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IIDb4p9A
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CF7C607C2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:10:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DFB2B634E9;
 Tue, 10 Nov 2026 04:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AC81F00921;
 Tue, 10 Nov 2026 04:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794283820;
 bh=miTH91FU73AzmU2Fuek8eqWk6PC6BVPMe1SNLQf3Dv0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IIDb4p9ABoTBZlbesk2GEWzOSmQ4ZaquEP1t1jtKRawps/67ga0LA0aVwBlgpQfY1
 UwjCGKK0cXP4A8OcLzOkjttq+sOS9r2rG1ovZCdVl5SkpWv99hZJUwRtNfqqwKEiIL
 BxoOse/Sfc43T0E9Xa++2FbQ39TbxPgaamM6Rk8iA4hxlqtn2wy4h30BYourN0zkUc
 5n49vUSBbKhdML3ZPXhSaVGSTMMI4LYsTaNcigDrCdM5KSm1a1jrDE6wZ3vbB7O6yX
 m8Bb2eKcH3ViaCQL5DV9jury7RLI5kyIvOzPuPbQk4um4ehwDkJVRJZRdB8PeyfgTc
 w9tEr1PEBp1LA==
Message-ID: <sashiko-outbox-206173@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 10/15] xdp: warn on XDP_PASS with stored values
 when XDP runs on an skb
To: "Tianyi Gao" <tianyi@cloudflare.com>, bpf@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <15f830924c4d06d3d8c7e41fb8a9f8c29b63d9a7.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <15f830924c4d06d3d8c7e41fb8a9f8c29b63d9a7.1794281983.git.tianyi@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:10:19 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] veth: race on rq->xdp_rxq in veth_disable_xdp() [1]
--

commit 7b602275436247ecf1d76650c01ef17cdab5904b
Author: Tianyi Gao <tianyi@cloudflare.com>

xdp: warn on XDP_PASS with stored values when XDP runs on an skb

This commit adds xdp_skb_ext_warn_skb() to warn when an XDP program running
on an existing skb returns XDP_PASS after storing skb extension metadata,
and skips generic XDP in xdp_skb_ext_warn_pass() to avoid warning twice.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index b402f8ed50966..f0d279e2da6a4 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -826,6 +826,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_r=
q *rq,
> =20
>  	switch (act) {
>  	case XDP_PASS:
> +		if (unlikely(xdp_buff_has_skb_ext(xdp)))
> +			xdp_skb_ext_warn_skb(xdp_prog, xdp);
>  		break;
>  	case XDP_TX:
>  		veth_xdp_get(xdp);

[Severity: Critical]
This problem wasn't introduced by this patch, but can veth_disable_xdp()
unregister rq->xdp_rxq [1] while veth_xdp_rcv_skb() or
veth_xdp_rcv_one() is still using it?

drivers/net/veth.c:veth_disable_xdp() {
	for (i =3D 0; i < dev->real_num_rx_queues; i++)
		rcu_assign_pointer(priv->rq[i].xdp_prog, NULL);

	if (!netif_running(dev) || !veth_gro_requested(dev))
		veth_napi_del(dev);

	veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues, false);
}

When detaching an XDP program on a running veth device with GRO enabled,
veth_disable_xdp() skips veth_napi_del(), so neither napi_disable() nor
synchronize_net() runs after clearing rq->xdp_prog:

CPU0                                CPU1 (NAPI)
veth_disable_xdp()                  veth_xdp_rcv_skb()
                                      rcu_read_lock()
                                      xdp_prog =3D rcu_dereference(rq->xdp_=
prog)
  rcu_assign_pointer(rq->xdp_prog, NULL)
  veth_disable_xdp_range()
    rq->xdp_rxq.mem =3D rq->xdp_mem
    xdp_rxq_info_unreg(&rq->xdp_rxq)
                                      bpf_prog_run_xdp(xdp_prog, xdp)
                                      xdp_skb_ext_warn_skb(xdp_prog, xdp)
                                        xdp->rxq->dev->name <-- NULL deref

xdp_rxq_info_unreg() clears rq->xdp_rxq.dev to NULL and resets
rq->xdp_rxq.mem.type while the NAPI poll is still running with xdp->rxq
pointing to rq->xdp_rxq.  Beyond the NULL pointer dereference on
xdp->rxq->dev (here or when the BPF program reads ingress_ifindex), this
also causes page_pool leaks or use-after-free when frames are redirected,
transmitted, or freed.

[1] https://sashiko.dev/#/bug/linux-717ec225-ebb9-408c-a2e0-a2698846ef4a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794281983.gi=
t.tianyi@cloudflare.com?part=3D10
