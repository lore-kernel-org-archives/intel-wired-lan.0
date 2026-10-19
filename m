Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5D606A31C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Wi7V2E+O;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkdYFlrV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A723C4054B;
	Mon, 19 Oct 2026 23:08:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N3Q8IOtT66F0; Mon, 19 Oct 2026 23:08:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E0EFC4054D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792451337;
	b=rRCK0PT/s1x1r2QJliIWs94hNVfLNDceTUdUmdBiKeVuZx8eBpH9kQylT756hrWL78un
	 jx8qKoqWMLKk+WYuUXvlhQQkr9NAjjqhupsBgdU4bHizgm/QENj2p4Z+eyji6WD3LEsA5
	 LSyJqEbgtbiWmd9GUYNIU//TeBgpGdgyzDyvMLrQn5mV1nMQJ9MoQsl+a92pxMBWb7weL
	 A/KmgwH9dpqRrPUXfCfrVh/Ee8BngMyKtzmUiYcciGG61RYqhbLRix/kRPgYdF/MDfRVI
	 MQWFX+EhM1wo8ECtjir8pxh7EE3UezXKZfOtaWAGgkhqw4ppO4kgxw7E/4nacXS3u5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792451337;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eLKM7MMeaqzoIZ75AVxnOBs7+cOS67Dja9Pr1r6VNKY=;
	b=fgTSnh7Qm4kTVxKmYO50BEiDRi3XAi5iGL13qbFziz09o0k4FpwcMZdYr0uQ1/3yshJA
	 I8pBSEXxk0gxbPmbPWsvJ6n+XomW6lNpe2sVgjf4FDe8Xj4ZJn7AVOPA3cXzl05RFTaaa
	 MTXj/zl/RZGrWMpxq3o8S7KslcduhuB0hDvX/wEcBG/YrPHTgHU8w9i0DvufgDyXRxUq1
	 9mEm++/Rb8PTkdp/+xJg+dEozMJaFvANOcUZxAcGuMGNZu8r240WlwrOanYg9VqkdT/NY
	 0VSKs3oY5mIknggBRKju3wrcFM8VUe0jzKfcwuL0FPMVDS1Vrr0QpPinC8usSkcfeIg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792451336;
	bh=eLKM7MMeaqzoIZ75AVxnOBs7+cOS67Dja9Pr1r6VNKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wi7V2E+OIw0ZiXWkvlnpzrH13qE1p2g5wqR2hX24HB1f26/07LhukklzsJCSHoBO+
	 /eUBUHU14OUG2VyMIdPOmpZamKwANxKLevReABA/mohnLkaFAKAlR5Vfls0CD20yNt
	 2JEeYEEJKo/uAEQAOb/FvHGk9KzUEkckuoSaV/n02oGXxJ3Va+3uOh2CfusyB6+xrU
	 OF3zdYzPJq0SmZuRWPxgQVWqvP+wDGH938EzJiwkWx4jwuePUq2j/IkjbfJykGioC5
	 ImGn9SrG1cBG6eT3+imaSGFPZtRzc5X1c7jC2DyY1kf6wTZIxvWrkclXrkr03sg06U
	 53dK2iSYrQofw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0EFC4054D;
	Mon, 19 Oct 2026 23:08:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 359492E0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 23:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 27805402C8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 23:08:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u8eT5hl8tXny for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 23:08:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 75103402B7
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792451334;
 b=aom6Mg4vMlwYdwX2O2Km2PwDepu1E65Es7eZB4ESuJLzv1KFvg8mop7QEMcaZBW9C7a/
 uy8rDGRGvvCf46Gi7c6a2344YRtxJOJOrnbuMwz0uFJ5NPRG6dojEIXRiR+IqvLmpaBQd
 TMZ41r+rs7n5XdibmdRSTTqxW6EJdqebPLU4dt+AV2FlLaUn3jsuUR8MwuhL8LcrMU+gh
 G7bV19f2VWUeWppwTgCzHOnBJbNqdWercVVNx6sPTykbSX9nmhvM3fGxGG5NQQtFhm5Wa
 EGugzJrFoVVleZouNZN26IHu5BwHTn/Q6SUeNxsoWZ5hGc2RU+eRCutialpKFoC8bNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792451334;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=eLKM7MMeaqzoIZ75AVxnOBs7+cOS67Dja9Pr1r6VNKY=;
 b=EfUT2A1jUudqfARYehamFkfuz2RZLL6glaXwo8diKTpGZqYzIkPOV4XvocHCmmc9FfQM
 MkRm6W1hndO4KfzVOHrrPbwkE3xmFBYDKVMKZwUkQRbRbkkbX08wWgwBWT9Qmi4exzDda
 tJOtmJHf49M3UTgbeeJhIT1VtIwzAykdLCU2Dmq4E5DwuoZXte7MXZ8zfr2Ml51D+U84B
 6mLdM++AO3HbXahx2nxwnwe+xuUHgwXN8sRDL9h8dNuHZT34f3PcAxTdXJQ8XrjTFNQ8e
 5pRswPsSPfVQ8E5Rp9z9LDD+MwTqFkmGtyLyH68+j2L5Hr6JbDECWeTm3DsueDO3LCw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NkdYFlrV; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NkdYFlrV
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75103402B7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 23:08:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54D1043E10;
 Mon, 19 Oct 2026 23:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0251F000C4;
 Mon, 19 Oct 2026 23:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792451333;
 bh=eLKM7MMeaqzoIZ75AVxnOBs7+cOS67Dja9Pr1r6VNKY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=NkdYFlrVNZLObvTMqbesr14pbD3trgw5L2H4TNqYNolXpHBvm0VC1bK38omiDO3Fa
 fbASWjUz4Y+mxBOv7Oe/+5lfZy6Tv9f0jeU/7lUFPuSCc/5zBgIO4IHYm7aHHO0AlE
 EKk51z1IAOvHRCTyFS/ZKGBLG1uwo/XKGAfG7H2cWCn1l1TYWMcfIRVB5uyohEbjHy
 XKNzoa4NveXR4CfL86ig0/VYGiJo4QZ5oAdy5NICa9gP2biM7Tkl7+62MOXScL2R0C
 JuLj10XXX4Z9gJ0TIeOQoZJJ+UonvzJlctKIAe3C2/mR8tnBXQowrGbiE+Q6lS9W6+
 kaHvsfl0o+lqg==
Date: Mon, 19 Oct 2026 16:08:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Manish Chopra
 <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v2 00/10] net: stop calling __pskb_pull_tail()
 from drivers
Message-ID: <20261019160851.7eb2a889@kernel.org>
In-Reply-To: <CAEzrpqfgBrvwy0Q_AX8X1s3ogq3g1U=JmpqHAM8QUmMHAqWPsw@mail.gmail.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008141131.0ac356dd@kernel.org>
 <CAEzrpqfgBrvwy0Q_AX8X1s3ogq3g1U=JmpqHAM8QUmMHAqWPsw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 9 Oct 2026 09:43:31 -0400 Josef Bacik wrote:
> On Thu, Oct 8, 2026 at 5:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Thu, 08 Oct 2026 21:02:47 +0000 Josef Bacik wrote: =20
> > > v1->v2:
> > > - New 1/10: skb_drop_empty_frags(). xen-netfront, netxen and qlcnic
> > >   relied on __pskb_pull_tail() releasing zero-length frags even when
> > >   there's nothing to pull, which pskb_may_pull() doesn't do (Sashiko).
> > > - xen-netfront, netxen, qlcnic: call skb_drop_empty_frags() after
> > >   pskb_may_pull().
> > > - skb_drop_empty_frags() checked with a boot-time test under KASAN and
> > >   kmemleak, on cloned and uncloned skbs. =20
> >
> > Please keep in mind that we ask people to limit themselves to 15
> > outstanding patches per tree. You have 18 right now.
> > (200 active netdev contributors + an LLM) x 20 patches =3D=3D insanity =
:/ =20
>=20
> Eesh sorry Jakub, the skbuff BUG_ON() removal series is the more
> important one, this series is the followup so I can finish that work.
> By outstanding do you mean per-merge window or once I get
> notifications for things being merged I'm good to send the next batch?

Sorry for the silence, I've been mostly offline past week and a half :S
