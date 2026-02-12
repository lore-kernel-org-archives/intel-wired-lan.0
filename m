Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4798EE36A9
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Feb 2026 16:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E9B2842B7;
	Thu, 12 Feb 2026 16:51:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SY4ys4DhhRBd; Thu, 12 Feb 2026 16:51:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7490842B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770915092;
	bh=mz3faHTRLCenuin280CUhN2KcEIoRxLUGJtQBDYings=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gApwuv2Bq2kcijS3O68Gt7l6Si0UBPWi0dhDS1Gyxy9y9FwbEUkAmOae3u3NprJeq
	 23nvfy79wrq5oJm1RJDn3GP6Wcczhc9tUFYcF9mpFIoNDv+4FiS6a/INczQ1hvNHMB
	 t3vhoGbI5mQX7YFsoi3+O9n5d7rvj/PTUuXYYGD2PwEUYg1RugxAoL7cVPFjV55zbM
	 nX6clY7RnV3lWaYqzWj1hK+xMGVhhdQWIuWDv2NmvXvGKI5zO/Ok6z6lmgHEA4oLV6
	 PvpXunhRFIeRO5S7UNw2Skav2YFV/iJjUVj6TQylhGWE9p91dX/AKUi4OlHVgKigjZ
	 +zewFVKgfU1GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7490842B8;
	Thu, 12 Feb 2026 16:51:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D166EC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 16:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A1A0842B8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 16:51:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 33aFB8QOtyFY for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Feb 2026 16:51:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=lorenzo@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 22A12842B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22A12842B7
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22A12842B7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 16:51:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A2E543C3F;
 Thu, 12 Feb 2026 16:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE26C4CEF7;
 Thu, 12 Feb 2026 16:51:21 +0000 (UTC)
Date: Thu, 12 Feb 2026 17:51:19 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Message-ID: <aY4FB_Gf31V-VYiF@lore-desk>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
 <aNYUqdaIJV1cvFCb@mini-arch>
 <e03d6d69-73ea-46dc-b632-149ef5831f85@kernel.org>
 <aNcZdfCivLR2slFw@mini-arch> <aYtqKfv0F0l2-hgy@lore-desk>
 <aY0zd4Esewxa-8hw@mini-arch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8qT/NFgXfwBYc55E"
Content-Disposition: inline
In-Reply-To: <aY0zd4Esewxa-8hw@mini-arch>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770915082;
 bh=XdxVG+YXGaMS3AWMGOWVYDuXvjuKlsGk0gHHkVYXoBE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g301/aHxOBg/tZoPaoIo39YQf6X3yf/bDbcpa60KjMq6uJblkjbFxXdfsoMG8aTBn
 nlwV7lbuECo+Mv9r5Kk484RzEJleTWEL0UWNOeOomzwDmP1ZcORj3OW2batpf6uiFA
 FMhVTI5BQs4yfi6qfcJmiINE42oRNQfLcZBxaFclppUqy/bQn1aafFpob6bcLbBzEr
 ZkZHWziHAccDsvfcp7A85qp34HZJxItkFXVKl9KzYf2sQ4dXSG2DjYkn6XNd3V6Jsj
 5SgHidUP7eTxjL/wKPAV7aos/RXsrc8CJ9uYaP2Tpp/uVBzWPv7Um3Yf7zIgfR1INM
 0w2O4FVC4LexA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=g301/aHx
Subject: Re: [Intel-wired-lan] [PATCH RFC bpf-next v2 1/5] netlink: specs:
 Add XDP RX checksum capability to XDP metadata specs
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
Cc: linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Song Liu <song@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Yonghong Song <yonghong.song@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, netdev@vger.kernel.org,
 Eduard Zingerman <eddyz87@gmail.com>, Simon Horman <horms@kernel.org>,
 bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


--8qT/NFgXfwBYc55E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 02/10, Lorenzo Bianconi wrote:
> > > On 09/26, Jesper Dangaard Brouer wrote:
> > > >=20
> > > >=20
> > > > On 26/09/2025 06.20, Stanislav Fomichev wrote:
> > > > > On 09/25, Lorenzo Bianconi wrote:
> > > > > > Introduce XDP RX checksum capability to XDP metadata specs. XDP=
 RX
> > > > > > checksum will be use by devices capable of exposing receive che=
cksum
> > > > > > result via bpf_xdp_metadata_rx_checksum().
> > > > > > Moreover, introduce xmo_rx_checksum netdev callback in order al=
low the
> > > > > > eBPF program bounded to the device to retrieve the RX checksum =
result
> > > > > > computed by the hw NIC.
> > > > > >=20
> > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > ---
> > > > > >   Documentation/netlink/specs/netdev.yaml |  5 +++++
> > > > > >   include/net/xdp.h                       | 14 ++++++++++++++
> > > > > >   net/core/xdp.c                          | 29 ++++++++++++++++=
+++++++++++++
> > > > > >   3 files changed, 48 insertions(+)
> > > > > >=20
> > > > > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Document=
ation/netlink/specs/netdev.yaml
> > > > > > index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67=
c6b9ee3548098b0c933fd39a4 100644
> > > > > > --- a/Documentation/netlink/specs/netdev.yaml
> > > > > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > > > > @@ -61,6 +61,11 @@ definitions:
> > > > > >           doc: |
> > > > > >             Device is capable of exposing receive packet VLAN t=
ag via
> > > > > >             bpf_xdp_metadata_rx_vlan_tag().
> > > > > > +      -
> > > > > > +        name: checksum
> > > > > > +        doc: |
> > > > > > +          Device is capable of exposing receive checksum resul=
t via
> > > > > > +          bpf_xdp_metadata_rx_checksum().
> > > > > >     -
> > > > > >       type: flags
> > > > > >       name: xsk-flags
> > > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > > index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b=
70618a9d4f32544d8b9a30b63 100644
> > > > > > --- a/include/net/xdp.h
> > > > > > +++ b/include/net/xdp.h
> > > > > > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attac=
hment_info *info,
> > > > > >   			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> > > > > >   			   bpf_xdp_metadata_rx_vlan_tag, \
> > > > > >   			   xmo_rx_vlan_tag) \
> > > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > > > > > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > > > > > +			   bpf_xdp_metadata_rx_checksum, \
> > > > > > +			   xmo_rx_checksum)
> > > > > >   enum xdp_rx_metadata {
> > > > > >   #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > > > > > @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
> > > > > >   	XDP_RSS_TYPE_L4_IPV6_SCTP_EX =3D XDP_RSS_TYPE_L4_IPV6_SCTP |=
 XDP_RSS_L3_DYNHDR,
> > > > > >   };
> > > > > > +enum xdp_checksum {
> > > > > > +	XDP_CHECKSUM_NONE		=3D CHECKSUM_NONE,
> > > > > > +	XDP_CHECKSUM_UNNECESSARY	=3D CHECKSUM_UNNECESSARY,
> > > > > > +	XDP_CHECKSUM_COMPLETE		=3D CHECKSUM_COMPLETE,
> > > > > > +	XDP_CHECKSUM_PARTIAL		=3D CHECKSUM_PARTIAL,
> > > > > > +};
> > > > >=20
> > > > > Btw, might be worth mentioning, awhile ago we had settled on a sm=
aller set of
> > > > > exposed types:
> > > > >=20
> > > > > https://lore.kernel.org/netdev/20230811161509.19722-13-larysa.zar=
emba@intel.com/
> > > > >=20
> > > > > Maybe go through the previous postings and check if the arguments=
 are
> > > > > still relevant? (or explain why we want more checksum now)
> > > >=20
> > > > IHMO the linked proposal reduced the types too much.
> > >=20
> > > IIRC, PARTIAL was removed because it's mostly (or only) a TX feature?
> > > So no real need to expose it as an rx hint. And I think empty xdp_csu=
m_status
> > > in that proposal might have indicated NONE?
> >=20
> > Sorry for the (very) late reply. According to [0] CHECKSUM_PARTIAL can =
be used
> > even on Rx side, right?
>=20
> So is this for virtio (which I don't think you need)? Or something else?

I forgot to mention before CHECKSUM_PARTIAL is used for the veth use-case
when the packet is coming from the networking stack.

> Can we start with the "easy" cases of UNNECESSARY/COMPLETE/NONE? I'm not =
even
> sure we need to expose the csum_level (start with level=3D0 and handle
> encap if/when there is a real usecase). With kfuncs we should be able to
> change/extend the API when needed.

ack, I am fine to drop csum_level for the moment but I am not sure if it ca=
n be
useful for the use-case described by Jesper.
@Jesper: any input on it?

Regards,
Lorenzo

>=20
> (for PARTIAL, not even sure what the BPF prog is supposed to do with it)

--8qT/NFgXfwBYc55E
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaY4FBwAKCRA6cBh0uS2t
rLgyAQDNKqpoeLWazkdUXhQHQ1Jjc9nNvo0J0et1ZcPKGvP2RgD/aGy9hpI/I7tJ
HHNGMx9dyMNBjMP6TKwbgmwxuYvj9As=
=RLM+
-----END PGP SIGNATURE-----

--8qT/NFgXfwBYc55E--
