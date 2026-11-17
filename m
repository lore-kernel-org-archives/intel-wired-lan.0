Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3ED606A32C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0dTANJUk;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YkWr0a+e
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02F1B605EF;
	Tue, 17 Nov 2026 22:15:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87_qmBFyzqKT; Tue, 17 Nov 2026 22:15:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E05E6069A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794953713;
	b=pW24xpTRxAfnwDloS+BP/Th6P6qt2TbFnhZdFtTkC/1Daa3PWYM5jjEIp0RJRc/Ipf/F
	 Vg0KXRLCA8Tb4Q4f+YnTwCMopbonLPzwhRLLY2x//LDVD3+FfCBPOfV3TB51gBEX+VHHM
	 BtixrGYd7VKSUWdaZBDmYr4Kapiq9AExv323zLDyV9Ltdb6Aq+4wstFlFGQp74Zhx5JYf
	 tb6vbk/JWFnU3kENbuiN9jGOtM5PJaYzzJgW4KhDLYZD+t8huyT8shb5xn+7pNDecHxZM
	 gU2X1mnF8yWn/tyQvBl3W9Rd50N7hFp072QVeB+isAm4inPiwBxtWiGGCSk6n6y5L3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794953713;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8igbL3DrmgjB8f+3uFsYWHUjBeZpK0nAdLK0B3NxyZE=;
	b=lgEjHAG79P2uWy1AwP304VBq0ylVKBKPbqJWGYCdgLHuU/3e0GhhBNIP8vAiug0h8omE
	 zZVBVIHb8c4XkbHclc33kLhVr4470TlWBqOqxGMFoDYTxhgB9Y1k/rYIhNxyEziPJpvfU
	 zFopxG+lx+WcaepLbRSQNspwSS1n3p+heve6qpfyNpspALkU3yXRdiihrerYJRvXmEL9d
	 7ikecf1u+shy6N71wcGEmd5Y8gx7WofZp69QmZk0UzsrAXsIQySjPllnNVeHBCexRkXA6
	 JYkdSi+gdzgXCy5xxlZC3nBxSSQdlcj6thfagr3feFz/JKMvl3O/e2dQ2UXn87bxTNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794953713;
	bh=8igbL3DrmgjB8f+3uFsYWHUjBeZpK0nAdLK0B3NxyZE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0dTANJUkh21KcWdWfGvz0ofd8s/ZwX7UXM5YK53tvSKw9zNwnviFBVNY3sjZZMflU
	 A+LOYns5ep+nat0maWVWMTdyIw8Utt5k2F6EF/5xkO7eJ/irHlCQrrtQ+0wQC/75sE
	 dVQ/2fflMuyMZi8jW/lQDPFRKpOBt+X4FHRd5ECvhwJJDc8ugUXXioUtsSZTVr1hNm
	 HGGr2fTTgrWFszc0COPd2L2DIa2Z5Ac7q84vA9HM/6QaIpufjX5gud8c8UtLe+r2zW
	 s150iirzzo9PDw355gKcPeoJyXFobY/aia4D2zdWySsBVBMxjGqicbkoFr2PT0wQQd
	 soc4VVfuMNjFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E05E6069A;
	Tue, 17 Nov 2026 22:15:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 068A3A0E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 22:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E08584035D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 22:15:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JyJfam_YI2SB for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 22:15:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 00E354005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com;
 envelope-from=daniel.zahka@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=YkWr0a+e
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00E354005D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 22:15:10 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-91eb449364cso2008716d6.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794953709; x=1795558509; darn=lists.osuosl.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8igbL3DrmgjB8f+3uFsYWHUjBeZpK0nAdLK0B3NxyZE=;
 b=YkWr0a+e2K2k38EwQMQemtyT8QLclHbiuGDKTA0XBwuNkfvxW5lbU5dn7/8WQMbwb/
 ZCBCNzTxPvzTW41UAijtDzO+mcfvvz67F5HRruzxeFPpP0KQiPTVOu1mPJ0rb4d9NXe6
 cJCpk4dP/p2YAcv5tM1FOIz/eK8SrlKhpFSz5iuhz0TgOghhgzjfst7N10o7BP2vjNSQ
 5OpsAML2EBS1i4XZzL0pmn1ofA2tXt5Y8Sovr/JVD5c3FDdzN7Ugx1lAQXglAKfAEzf4
 g4nSx8dmge6HPXmjRb4Zwr5ZfkbqtRNyaSVPMmwGENu4HbETQoULUTAz9PiHejypEdxQ
 alKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794953709; x=1795558509;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8igbL3DrmgjB8f+3uFsYWHUjBeZpK0nAdLK0B3NxyZE=;
 b=Dj/3ISwXf/foVZ1PS0ESFsxDnfUpb0g4clbttvX2Iz/g6Kxs7EkWHSPAEzHhK7Plf3
 0754/4EmPrxsyXR7NebcWg0A32tsHrpmeLLohvITL12POVlupYfGuCsCKPtFOOZ8E8K3
 HUIi2kEnIHRGlQSUdjbcVjRP3GxsuZg7+1Y3tcALDchLtcu22QDOc3kQ2Gs+255IdcDq
 pJZj3JjWQyB7l8Ovrr4zxlxCqKBMbbePjStrRcqQzwxSr4j09hciV3FJpc8mUcpe3TFx
 N1gL55fH9Wq+zlmMe83gzq612BHcj7TvRTYr4He8M9jKY8soVmcvwYGGIJ3hSLUnSa6o
 uWKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHLRX59zFLQtthazD6zENYztaqiuOiAL8lpLuRnYwnQdBqNxR924rPNWbyuoFYa3cGGlnzdxL7EmLI3KgxYd90=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9B00n2HhNiTKPBwCalAc+7vHu5nLoE7UGPuWrtqa/NaEtGK20r
 atcwbfadrsxC6sNA/RWCAt25GkEJgLBUvrU/BQ33ktzT1z7sOgE4IZNY
X-Gm-Gg: AYBFou1bWcVJnYl/8zu3Oz9Gwxy/PrAQ/9n9eT4Y+Xfxuv3FEH9nUT/+dFNuYg3KslV
 SEwNRyICSwOcRQTsmcEovLLc6PCSgTBc3m0BuVRQCV95Dske2d5XHvU3Ra0bFUZfZoxS7mQOsfq
 8NzBh+9v+41F6cxTW8zBgj0fNOU5Qom84MsUj3lymDpLW8wgqTv4bQshxefbN6iEm+t/5uZ1KVZ
 fR6FRgkj8DLWw7VonP7IOvN0je2qi/9ABQ/sDguZKMx4KPZJVM/xdO+0pVB8/rQH52b2iXtyJdi
 X60OHfD0QZXkzuKJO7AOqrlo96kTe4d2giXvc9oNv71dT3n7eNqIVrPG5cT0IjmR+ZGOCbSiSC1
 fER+YUwEzxj2n/VqWHPPH05DvJ0/o7iGkh9IN2pUIyG6IbAwZfSW3iAuncIv/yPK/cQ72EmcanZ
 zo9Qd3dV9k10TZE+VDxWmeLAtZ3ZniZsL+/oKBgxQIyzCSfkt5vbMsXYSobBWlf5S2ErWIa4/ED
 LPRvP1srUWUhzJuSCyewC5Z+yfJJ7mICPHnphkB0m1X9vrV5CCFL8RnvjeOOP+9XTHhYjftqmQ0
 ndUJhL2igmaEHKw7niUqXPeWXewIycJWoQ==
X-Received: by 2002:a05:622a:307:b0:55d:1db7:3ef4 with SMTP id
 d75a77b69052e-55d5a5b77b2mr12272421cf.41.1794953708820; 
 Tue, 17 Nov 2026 14:15:08 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92114d53b7fsm4789176d6.26.2026.11.17.14.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 14:15:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 17:15:07 -0500
Message-Id: <DMXTZHJA6OGI.3RFGSK5SE9RUF@gmail.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Decotigny" <decot@google.com>, "Madhu Chittim" <madhu.chittim@intel.com>,
 "Emil Tantilov" <emil.s.tantilov@intel.com>, "Sridhar Samudrala"
 <sridhar.samudrala@intel.com>, "Brian Vazquez" <brianvv@google.com>, "Li
 Li" <boolli@google.com>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Daniel Zahka" <daniel.zahka@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH iwl-next 09/15] idpf: psp: add support for psp key rotation
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Stan Iliev" <stani@google.com>, "Tony Nguyen"
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 <intel-wired-lan@lists.osuosl.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261117145522.1910636-1-stani@google.com>
 <20261117145522.1910636-10-stani@google.com>
In-Reply-To: <20261117145522.1910636-10-stani@google.com>
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
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 17, 2026 at 9:55 AM EST, Stan Iliev wrote:
> Add support for PSP master key rotation:
> - Introduce VIRTCHNL2_OP_PSP_ROTATE_KEYGEN_REQUEST (563),
>   struct virtchnl2_psp_rotate_keygen_request/_response,
>   VIRTCHNL2_EVENT_PSP_ROTATE_KEY (4) and
>   struct virtchnl2_psp_rotation_event/_data.
> - Implement the key_rotate PSP device op with
>   idpf_psp_rotation_request(), which fails with -EOPNOTSUPP if
>   VIRTCHNL2_CAP_PSP_REQUEST_ROTATION was not granted. The PSP core
>   increments the PSP device generation before calling the op and
>   doesn't restore it if the op fails: the op restores it then.
> - Track the master key of the allocated RX SPIs, to report their
>   generation on receive in a later patch: bit 31 of an SPI selects one
>   of the two master keys of the CP, and the CP master key generation
>   of the allocation tells when a master key was replaced. The packets
>   of a master key get the PSP device generation that was current when
>   its first SPI was allocated, which is the generation of the
>   associations using it. Associations then survive one rotation, as the
>   PSP core expects.
> - Handle VIRTCHNL2_EVENT_PSP_ROTATE_KEY in idpf_recv_event_msg() with
>   idpf_psp_rotation_event(), which logs the new master key generation.
>   The PSP core can't be told about rotations it didn't request, like
>   in mlx5: document the limitation and a possible solution.
>
> Signed-off-by: Stan Iliev <stani@google.com>
> ---

[...]

> +/**
> + * idpf_psp_rx_gen_update - Track the master key of an allocated SPI
> + * @adapter: private data struct
> + * @psd: PSP device, locked
> + * @spi: SPI allocated by the CP
> + * @cp_gen: CP master key generation of @spi
> + *
> + * Bit 31 of an SPI selects one of the two master keys of the CP, a rota=
tion
> + * replaces the older one. The HW doesn't tell which master key decrypte=
d a
> + * packet: report the PSP device generation that was current when the fi=
rst
> + * SPI of the master key was allocated, which is the generation of the
> + * associations using it, see idpf_psp_rx_process_skb(). The CP master k=
ey
> + * generation tells when a master key was replaced, including by a rotat=
ion
> + * the PSP core didn't request, see idpf_psp_rotation_event().
> + */
> +static void idpf_psp_rx_gen_update(struct idpf_adapter *adapter,
> +				   struct psp_dev *psd, __be32 spi, u32 cp_gen)
> +{
> +	struct idpf_psp_rx_gen *rx_gen;
> +
> +	lockdep_assert_held(&psd->lock);
> +
> +	rx_gen =3D &adapter->psp.rx_gen[be32_to_cpu(spi) >> 31];
> +	if (rx_gen->gen !=3D IDPF_PSP_GEN_UNKNOWN && rx_gen->cp_gen =3D=3D cp_g=
en)
> +		return;
> +
> +	rx_gen->cp_gen =3D cp_gen;
> +	WRITE_ONCE(rx_gen->gen, psd->generation);

WRITE_ONCE isn't paired here. I'm guessing the Rx code in series 2 will
copy rx_gen->gen into the psp skb extension, but that would likely not
be correct. The generation field in the extension should be copied from
Rx completion metadata. If such a descriptor field doesn't exist, then
the key_rotate() implementation might as well pin psd->generation =3D 0
like mlx5 does.

> +}
> +
