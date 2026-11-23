Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BA606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=SZ8/TlFi;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rGS6m5//
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 008DE40478;
	Mon, 23 Nov 2026 18:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OzozCkEMo2DI; Mon, 23 Nov 2026 18:49:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE83040631
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795459764;
	b=ratFfMNe2Dk4xRDLOALdbrK7aaK9A8yOMmFL1sOYFW8vemUmO0KYlJKPUetdh1g+Epyk
	 pEvZBe+ZujFS5ucS2zVfq3743pLLNDWRgp/GNWiSxI8K+O3qfgJPY078sZE85IcZDMneB
	 0UbL5+hwHKGmB/1LznX1Gz1/Ikc/xTAdupVyz34QdXW4gGwpOA5M6EpKLFf6sz5uN5gsE
	 C8svxNq3KnSmI8nR6O+GwByKBkY+i1sxDEHVN4F7WF548zKUFKo3VKGOdXXBqtZpl9xul
	 pYGxTBspubSuNDUPwwBQpSez1Dg7ZG1dw7S2YXqJ7L+1g0RZ4cDUbrjVpzBs7NCAhFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yuo3RMT5uLMlvZjj6lcxSmCTKfmm/IW4Uhs7jIPyUXI=;
	b=FpoYL+DaVZ1IPukwkDySRy0Le3jR2+GIAi8ReHOTJVmHYl8nFnSnQ7eBH0wAMNoZZjSZ
	 a3gE3BMz8II4XFLFUJ97FWWesfNhTbsrE8eBXh/OB9BNYGrnNQoLarXQaP/PyrW6TZ2tw
	 nh0SRCpNSezX/+hFv7BDo25T9Csw2KDEx9kQTSkCqdPqkXS/Hb7U2/ZLv0yTo/zlIcRI0
	 fnEkSoCKMvJzB/YKVfadC3f3M2nmw32UUgr4o502L6blnmf/iibqdV/oALC+TR+6W0X54
	 yQxjoTbNLofFrDY15YUzPAPj+wamsWnKHyzW3X3v6uK5StiK16ilVTYBHP9wtVK158Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795459764;
	bh=yuo3RMT5uLMlvZjj6lcxSmCTKfmm/IW4Uhs7jIPyUXI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SZ8/TlFiyVxWhM98iXzSG2B1fEIGeuKuMIuzFdjs0TgrBMPHbypqNflDIiDSjahSz
	 DkohwNaQz1+IdaHhYXy0f/5/cAZQtjsAp+BRqm3ZkPBIRbO25r7mCphGLU5Kkdzncf
	 kHmeS/n9mclH3G1elvaRvgU/9RCZbPKzE1DHJwqn3fBEKieI+uAgMTGgwZIHkTsrdf
	 PdrqUAli0NwbzrMe840EWVfYP3jHyAdkAaqekdYdpLN+B5Wd/iMcKGq/n18ofWeoME
	 8DgHcoW/MDd461+fyvxQMaxmVVd9krtZ/NHsQKxtpc/VX6aswQ8Rzs5i8hbxTfwmqQ
	 obpG/S5xNh9Nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE83040631;
	Mon, 23 Nov 2026 18:49:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A3A722B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BAE3605B7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:49:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FDQ8ScMXwJAy for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 18:49:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D197605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com;
 envelope-from=alexander.duyck@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=rGS6m5//
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D197605F7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:49:19 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2f05b465cd1so16270095ad.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795459759; x=1796064559; darn=lists.osuosl.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yuo3RMT5uLMlvZjj6lcxSmCTKfmm/IW4Uhs7jIPyUXI=;
 b=rGS6m5//49e72Yw/d5tC888bPpswATgMNcRVMB+Fwnm2reCZ33VH9XkJQ2L07Utvrc
 +INOQcOR4m0yIP1jY1WWb+1gQ4dskdpQDzQhpGuuoxzrcm1gCpCCw6FxMQDcTJucGAgw
 +z1pAsr8eMl2Wrmu+XoQZ85OcXyJmFriPWECbz1CxcbRuQt+4r7ubWedYZjV/b5AZCOM
 MWhw+acWK876fbjHShK33tdh1M+WKlGgOhRvTvfK2Y694jJQLtDCwwwbE7SN5A9sXa3n
 CW505AKgBvhdzQkvax834Etw+yoIE9c7Ex5M/0zsirDDtnHK2NFix9dxne7f2t6QXf69
 LASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459759; x=1796064559;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yuo3RMT5uLMlvZjj6lcxSmCTKfmm/IW4Uhs7jIPyUXI=;
 b=sJGVP8FdWyeNJ7yJNrvCPSea9TRktsrxfB3ytKh7/giB8y7oxMNJQ3wQykSB1Z5g92
 C3bohoTN1A4UB62z6X4E3SyxOCpLkytYIETHbKc5a9n3czWXr8EN4lJlEtRDXphPBr3Z
 G7UfQVA1syWgWSsHV8nu1nfB7E+lqcaK9jRyXrVEQEhYVsg9o2XBEOeFp59QxH7r/IFY
 wFogffe6MqhtAf4+DfEi4GB8eblRnn3+zd+uHfl7XIiW/W+p6Anu88D4ejeR7ibeRAch
 s3Zo+05+DA/SX6JY4TFANtGSNB8Hzj8HvN+Xjc/p+pqFmBJZxDbp/dud6yJmnc8LW3Mv
 tipg==
X-Forwarded-Encrypted: i=1;
 AL+hErFTDgXzC6cUEWPuEmLe7eYQtjh76cgb/PUj1LgL3AOdFYh+giRF1cUjrlLGBYmKhMrAGP/qkfz4zN5hsJjB+zA=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/nXl2XEDr+sbISVeXgUXDXRqGxTk3PBSL4OQO2S4Ft3hMgC7pR
 WdQB+vOw/pitKkl0OfyREyHakql3X5BdenV80sVdkAadcFpd0hEhqouo
X-Gm-Gg: AZFdTZeYNCp7m45ymkl60eXXXlQBVPt8wOxQTKIQ4ZCc4H4OWzTO2/G1sGjGEagZQt1
 I9NnwejvuqrTupS6a1JGxZsx9cgiSHgjRdm/1XF0FicOHxrt+I67RW63gn/W7yFYwRG3sNBOdar
 FQZ7FXWmDDa73L7lSPk3jUHjpbgWbfqh/wAe4hrsNqADhQtSHR83CN/tm5koOhEylvBuOwNfxg9
 E+hw5nYMuYqnNiWsZFWjz8122yGseXtzm/i3gL3G8TQfSekALyih2SMKV4NhNutaquYjG4+Kaet
 FgdldR9fHzPdzsmiZ9VmhM/0Pgvc1EnKhMb8PCRlQAPDVkbK0stz6my9LDpa1zms1UpiiryA0pa
 RWO8oUNu+sc58UjYggKXLVyG98eSVB6fnD85Y0n9w6UAVkzC8n7pxxB3DWUFMrFu7bVHFsf7EfN
 4COHU+Hmu1BE/yhquplS1rxMISiQUskn8unP32C9XadhzA8ejGjMWI8rcwegEC04vx8EdWLpv4B
 6Wr/mtYIpp58OcCiS2DRVYZq7XzsI3j9ZIdcNz/alr4AlLwMzEoO4sapoDTwer+hs2ffpiAXG8H
 ZPEnBLlbh/bMWvbhVrR/aygl/gjQOE0EhpLXm9wtvEr80dmAOdA8YKXh4rSPQH5b9pf9qUqlnGY
 YA+zrdV0kaClJzXp5SsgaaBgUXDz37OkgXUmM/2WElOgW7rk8WPEiVCIX+2BUUJJ1W1U=
X-Received: by 2002:a17:902:e80b:b0:2e9:9a19:c43 with SMTP id
 d9443c01a7336-2f03f118277mr119957685ad.15.1795459759098; 
 Mon, 23 Nov 2026 10:49:19 -0800 (PST)
Received: from ?IPv6:2605:59c1:38c:400:82ee:73ff:fe41:9a02?
 ([2605:59c1:38c:400:82ee:73ff:fe41:9a02])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2f03f1207f1sm57374525ad.64.2026.11.23.10.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:49:18 -0800 (PST)
Message-ID: <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Tianyi Gao <tianyi@cloudflare.com>, netdev@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Jesper Dangaard Brouer	 <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paul Greenwalt <paul.greenwalt@intel.com>, Alice Michael	
 <alice.michael@intel.com>, Eric Joyner <eric.joyner@intel.com>, Jesse
 Brandeburg <jbrandeb@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 bpf@vger.kernel.org, 	kernel-team@cloudflare.com, tianyi.gao@linux.dev
Date: Mon, 23 Nov 2026 10:49:17 -0800
In-Reply-To: <20261121012402.84848-1-tianyi@cloudflare.com>
References: <20261121012402.84848-1-tianyi@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 2026-11-21 at 01:24 +0000, Tianyi Gao wrote:
> On E830, ice reports CHECKSUM_COMPLETE with the generic checksum (GCS)
> that the hardware computes over the received frame. If an XDP program
> changes the packet and returns XDP_PASS, that checksum no longer
> matches. The stack then checks the packet again in software and calls
> netdev_rx_csum_fault().
>=20
> On Cloudflare servers, an XDP load balancer removes the encapsulation
> of the packets that it accepts locally. Our production traffic hits
> netdev_rx_csum_fault() all the time.
>=20
> Do not use GCS when the ring has an XDP program, as mlx5 has done since
> commit 5d0bb3bac4b9 ("net/mlx5e: XDP, Avoid checksum complete when XDP
> prog is loaded").
>=20
> E830 also sets the L3L4P and checksum error bits, so the packet gets
> CHECKSUM_UNNECESSARY or CHECKSUM_NONE, as on E810. For example, a zero
> UDP checksum over IPv6 is marked as bad and gets CHECKSUM_NONE. A zero
> UDP checksum over IPv4 gets CHECKSUM_UNNECESSARY.
>=20
> Two pending series [1][2] give XDP access to the checksum status.
> Neither of them supports CHECKSUM_COMPLETE.
>=20
> ice_rx_csum() reads rx_ring->xdp_prog again after the poll loop ran XDP.
> While ICE_VSI_REBUILD_PENDING is set, ice_xdp_setup_prog() can replace
> the program without stopping NAPI, so the two reads can differ. At
> worst, a packet in that poll gets CHECKSUM_COMPLETE as before this
> patch. The pointer is only compared with NULL, so this cannot crash.
>=20
> Link: https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-0-623d=
5c0d0ab7@kernel.org/ [1]
> Link: https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.=
com/ [2]
> Fixes: 905d1a220e8d ("ice: Add E830 checksum offload support")
> Suggested-by: Jesse Brandeburg <jbrandeb@kernel.org>
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
> Tested on an E830 (8086:12d2, board N31483-007, fw.mgmt 7.9.5, DDP ICE
> COMMS 1.3.63.0) with an XDP program that removes a UDP encapsulation
> header with bpf_xdp_adjust_head() and returns XDP_PASS. The kernel was
> based on 6.18.64, where ice_rx_csum() is the same as in net:
>=20
> - Before: 63322069 netdev_rx_csum_fault() calls in 30 s.
> - After: 0.
> - Without an XDP program, the port still reports CHECKSUM_COMPLETE.
>=20
> On an E810, which has no GCS, drivers/net/xdp.py, ping.py and
> hw/csum.py give the same results with and without this patch.
>=20
> Request for comment: I also prepared a drv-net selftest for net-next.
> It removes 16 bytes from the UDP payload with bpf_xdp_adjust_head()
> and fails if the packet reaches the stack with CHECKSUM_COMPLETE. I am
> not sure we want to enforce this for all NICs, so asking here.
>=20
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/=
ethernet/intel/ice/ice_txrx_lib.c
> index e695a664e53d..ad22d855436e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -123,6 +123,7 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff =
*skb,
>  	rx_status1 =3D le16_to_cpu(rx_desc->wb.status_error1);
> =20
>  	if ((ring->flags & ICE_RX_FLAGS_RING_GCS) &&
> +	    !READ_ONCE(ring->xdp_prog) &&
>  	    rx_desc->wb.rxdid =3D=3D ICE_RXDID_FLEX_NIC &&
>  	    (decoded.inner_prot =3D=3D LIBETH_RX_PT_INNER_TCP ||
>  	     decoded.inner_prot =3D=3D LIBETH_RX_PT_INNER_UDP ||
>=20
> base-commit: 92e97d7cffc7ec6adfa4699203c18b1ab0c8b314

I'm not sure this is the best fix for this. If we are needing all NICs
that support CHECKSUM_COMPLETE *and* XDP to report CHECKSUM_NONE in the
event of a frame being modified by XDP it really feels like we should
probably look at moving this further up the stack.

Otherwise the proper fix for this is probably going to need to be
spread out to far more drivers as I suspect the intersection of the two
is likely not that uncommon.

Also even if we go the multiple driver fix route I wonder if we
shouldn't look at adding a new XDP return type to indicate that we are
passing a modified frame so that we don't have every XDP program out
there forcing NICs into a state where they have to start turning off
various offloads across the board when they don't need to.

What we are going to end up with this current path is one group of XDP
programs dragging down the performance of others since they will take
the penalty for the ones that are making the dirty modifications.
