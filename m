Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1FFEDF170
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Feb 2026 15:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5343844AB;
	Fri, 13 Feb 2026 15:22:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NFd3RNIpHO4N; Fri, 13 Feb 2026 15:22:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00B66844A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770996129;
	bh=HqldCT71mbDoDmaJksXXeb0a2vmhAF/mGBEjDq1VJ/k=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3VA9R/aJM2ubChUk2fr/OFRg+9kaL2+bof8M2BGNU1NuemmVVXeU8npkeYvwS99DN
	 BjBCRkhr5dg4Irh2JDvQrYwvvfUi6JY9FDHli8zCWFxnKcYtkxJhCxObBru6YGQegk
	 wmbxJecaxsYcLzGMOOxenQSUlIxdqXoO9O/SsTZm82F5h8c+rkCaJ60ULzwIGv2yJF
	 MK7r+aQHOqQTw9e+0bIpRCWPwOs2Eut3c78HgSP4KzhNzwwMVoIMhxljWj1XQz9FBy
	 bM6Ivhpgse/o4op7fJxiYg7RqQaHa2Lovbwz8q8asv62QkmPIcSxMfBmSLkyAAK28k
	 qWthhn+fiTX9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00B66844A6;
	Fri, 13 Feb 2026 15:22:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48F70255
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 15:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A7E740248
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 15:22:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P-6cqDMNRyf4 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Feb 2026 15:22:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=lorenzo@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 765E3400A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 765E3400A0
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 765E3400A0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 15:22:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 181BC44050;
 Fri, 13 Feb 2026 15:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D33C2BC86;
 Fri, 13 Feb 2026 15:22:05 +0000 (UTC)
Date: Fri, 13 Feb 2026 16:22:03 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Message-ID: <aY9Bm0ewK6lLWpqe@lore-desk>
References: <20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org>
 <20260210-bpf-xdp-meta-rxcksum-v1-2-e5d55caa0541@kernel.org>
 <IA3PR11MB8986DFE4F3C0D804F50B0A56E563A@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HFmkBUtLTk0X/kCd"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986DFE4F3C0D804F50B0A56E563A@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770996126;
 bh=uiXKGrta5YSlOI9oj98H0JbtZs40BXq+md8wHRRZ+YA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mGw9ILGuBrof3W4ID1AXaRcRnWS+kvUe3FQSoaOotADVb3P1+lkFpDJx7SZ/rsNLP
 lbQwMFYHr2exFPdbAgOzH5VWP0xmXnQzWKbVS+WVH9riUpsC2RnaK4VyhlWYiHeJRE
 XeD7rthBaCh+xiTm1VJ6cGvPMlcnwWKjwkwUsnXUmf0gazK3hOApJrYbEkDJyzcNqX
 5gUxrcwaI0X9ilHL6V/SODI9T/awsKhEh2niVe4F3mCPpT50kuesxEol/Z5Ck0wf5x
 a+kNvDip0saLJHQFWVlr/jY81zF6sc2vP+ZW1+052sC008Vyyf1H8FqdiRmfI4UbIP
 ZnZWYmY77zCvQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mGw9ILGu
Subject: Re: [Intel-wired-lan] [PATCH bpf-next 2/5] net: veth: Add
 xmo_rx_checksum callback to veth driver
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


--HFmkBUtLTk0X/kCd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Lorenzo Bianconi
> > Sent: Tuesday, February 10, 2026 6:22 PM
> > To: Donald Hunter <donald.hunter@gmail.com>; Jakub Kicinski
> > <kuba@kernel.org>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Simon Horman
> > <horms@kernel.org>; Alexei Starovoitov <ast@kernel.org>; Daniel
> > Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> > <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>;
> > Stanislav Fomichev <sdf@fomichev.me>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Lobakin, Aleksander
> > <aleksander.lobakin@intel.com>; Andrii Nakryiko <andrii@kernel.org>;
> > Martin KaFai Lau <martin.lau@linux.dev>; Eduard Zingerman
> > <eddyz87@gmail.com>; Song Liu <song@kernel.org>; Yonghong Song
> > <yonghong.song@linux.dev>; KP Singh <kpsingh@kernel.org>; Hao Luo
> > <haoluo@google.com>; Jiri Olsa <jolsa@kernel.org>; Shuah Khan
> > <shuah@kernel.org>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> > Cc: Jakub Sitnicki <jakub@cloudflare.com>; netdev@vger.kernel.org;
> > bpf@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> > kselftest@vger.kernel.org; Lorenzo Bianconi <lorenzo@kernel.org>
> > Subject: [Intel-wired-lan] [PATCH bpf-next 2/5] net: veth: Add
> > xmo_rx_checksum callback to veth driver
> >=20
> > Implement xmo_rx_checksum callback in veth driver to report RX
> > checksum result to the eBPF program bounded to the veth device.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/veth.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c index
> > 14e6f2a2fb7783334d8f6afd54e658cf9a0e6f3d..38b70ad62db7e92cccc6c6c9ed1f
> > 5573d8baf48b 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -1693,6 +1693,25 @@ static int veth_xdp_rx_vlan_tag(const struct
> > xdp_md *ctx, __be16 *vlan_proto,
> >  	return err;
> >  }
> >=20
> > +static int veth_xdp_rx_checksum(const struct xdp_md *ctx,
> > +				enum xdp_checksum *ip_summed,
> > +				u32 *cksum_meta)
> > +{
> > +	const struct veth_xdp_buff *_ctx =3D (void *)ctx;
> > +	const struct sk_buff *skb =3D _ctx->skb;
> > +
> > +	if (!skb)
> > +		return -ENODATA;
> > +
> > +	/* For locally generated packets ip_summed is set to
> > +	 * CHECKSUM_PARTIAL.
> > +	 */
> > +	*ip_summed =3D skb->ip_summed;
> > +	*cksum_meta =3D 0;
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct net_device_ops veth_netdev_ops =3D {
> >  	.ndo_init            =3D veth_dev_init,
> >  	.ndo_open            =3D veth_open,
> > @@ -1718,6 +1737,7 @@ static const struct xdp_metadata_ops
> > veth_xdp_metadata_ops =3D {
> >  	.xmo_rx_timestamp		=3D veth_xdp_rx_timestamp,
> >  	.xmo_rx_hash			=3D veth_xdp_rx_hash,
> >  	.xmo_rx_vlan_tag		=3D veth_xdp_rx_vlan_tag,
> > +	.xmo_rx_checksum		=3D veth_xdp_rx_checksum,
> >  };
> >=20
> >  #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST |
> > NETIF_F_HW_CSUM | \
> >=20
> > --
> > 2.53.0
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

@Aleksandr: veth implementation is quite different in v2 so I will
remove your Reviewed-by tag.
Can you please take a look to the new version when you have some free cycle=
s?
Thanks in advance.

Regards,
Lorenzo

--HFmkBUtLTk0X/kCd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaY9BmwAKCRA6cBh0uS2t
rM9GAP9pqasZqU5mkbE9HeZKaEA/3fmJnoxbUinX2RuFECIihQD+MfrvsdLGCvNi
SmxAUR2eFsKybJxZcgoL96b8QXXhzgQ=
=09aw
-----END PGP SIGNATURE-----

--HFmkBUtLTk0X/kCd--
