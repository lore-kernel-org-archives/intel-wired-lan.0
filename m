Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246FDCD6E61
	for <intel-wired-lan@archiver.kernel.org>; Tue,  2 Jun 2026 06:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C861840E65;
	Tue,  2 Jun 2026 06:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kZMOERYIH81j; Tue,  2 Jun 2026 06:52:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9794040E6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780383142;
	bh=ZDSxYnMPY0itqsVM4sIvyNaZq4A9tfxgOPqtLTGH890=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s2+UGzWqlf2w8xEIPGpxVJwHJHk6qnHxDawj88MgCFy1K1pNjKRZGZDBy/bIHcxca
	 M9bcYlKSuFuT06Fa+xkvgpOfRyN518y7+sR2VKsnmXj7sJj5Q05VE3qMhhtwixhlAb
	 xokxN+YE0YNHdeY/dqR5xiqqL2ayWPfnyBwXXVM8BkdXPHj4afijzWiV1NbYCsIlah
	 I6kAQCrAia6+FYRA9Uoc5HYn5SLs7X8eQu3yQb93gQKfLnzBaFPP8ab5NU+7AgaHr4
	 cj1pdc1+F1Pdw1HCzY741ZrFcxwGDQ9jZi9J6kQfru9wneWcIpocvSGlwD03WVH1Uz
	 7Ie0GhTgmsNoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9794040E6D;
	Tue,  2 Jun 2026 06:52:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FC75223
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Jun 2026 06:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21C9A60B88
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Jun 2026 06:52:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bfVEu0tqdw6p for <intel-wired-lan@lists.osuosl.org>;
 Tue,  2 Jun 2026 06:52:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=lorenzo@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 466BA60B83
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 466BA60B83
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 466BA60B83
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Jun 2026 06:52:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A83CD43C45;
 Tue,  2 Jun 2026 06:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F199B1F00898;
 Tue,  2 Jun 2026 06:52:18 +0000 (UTC)
Date: Tue, 2 Jun 2026 08:52:15 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Felix Fietkau <nbd@nbd.name>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org, intel-wired-lan@lists.osuosl.org
Message-ID: <ah59n47KKkhZmt0o@lore-rh-laptop>
References: <ah1NJMrJ5rEkQlJG@strlen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="576asHiwzTTmFSL0"
Content-Disposition: inline
In-Reply-To: <ah1NJMrJ5rEkQlJG@strlen.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1780383139;
 bh=ZDSxYnMPY0itqsVM4sIvyNaZq4A9tfxgOPqtLTGH890=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K8IElk/hVgq6/2y9P/OGKrMAyBQ/0zQwylWD9vpg4553zitHz8Ps5Fv8mD9wzSvpS
 xuTYJ6vQ1ZtD6Yn/RAOp3cFFnclPPFkZ0g412Q01VwUB9+YakZFBJTSV1XT6gsxMQd
 0HmxjvIEvWavEt29wPCTHDtXddp8TmPSXIKcScI3h+JFDhq/Vl+6Kj2sRiYdfqXlv+
 scMjuOgCQtsx0Op4M0BL8hrwFzeQDGcjmsYrto8fvuUaFTxxktpBsiN1MCvRTaIbtr
 EAYNFzlxx+wOmYX+fjDfXlxVoAGs2yZ8TBlb8UD5sS5fft+kZQsKXW1xdaURtRdK/w
 LmtjxWZABNmEw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=K8IElk/h
Subject: Re: [Intel-wired-lan] Possible UaF bug in netdevice teardown path
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


--576asHiwzTTmFSL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 01, Florian Westphal wrote:
> Another sashiko drive-by report. TL;DR, do you need to apply this
> pattern in your driver?
>=20
> -       metadata_dst_free(priv->md);
> +       dst_release(&priv->md->dst);
>=20
> Affects:
> drivers/net/ethernet/airoha/airoha_eth.c
> drivers/net/ethernet/intel/ice/ice_eswitch.c
> drivers/net/ethernet/mediatek/mtk_eth_soc.c
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
>=20
> Long version:
> https://sashiko.dev/#/patchset/20260527135751.1031891-1-tristmd%40gmail.c=
om
>=20
> This isn't a bug introduced by this patch, but looking at this fix, do
> other callers of metadata_dst_free() suffer from the same use-after-free
> vulnerability?
> In drivers like ice_eswitch and mlx5 MACsec, a metadata_dst is allocated
> and references are taken on it via dst_hold() when packets are processed
> (for example, via skb_dst_set()).
> However, on their teardown paths, these drivers call metadata_dst_free(),
> which unconditionally frees the memory without checking the reference cou=
nt.
> If packets holding these references are queued (like in a netem qdisc)
> during teardown, does the memory get freed prematurely, causing a
> use-after-free when the networking stack eventually calls dst_release()
> on the dequeued packets?

Hi Florian,

For airoha_eth and mtk_eth_soc I think the issue is less severe since we
destroy the metadata after running unregister_netdev() (that executes
synchronize_net()), but I guess it is better to fix the problem. I will pos=
t a
fix for them.

Regards,
Lorenzo

--576asHiwzTTmFSL0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCah59nAAKCRA6cBh0uS2t
rBbkAP9n6TqudmP6+W+Gls0RKmbOrps5XTC2yBfclupisGuNKgEAzCrWI8aTjg0X
PL+C1WcMnx5qmRT8MuqbePPE7PitIQs=
=sBwZ
-----END PGP SIGNATURE-----

--576asHiwzTTmFSL0--
