Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3803AFEFB4D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Feb 2026 13:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E61E860A75;
	Fri, 27 Feb 2026 13:21:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DyDi1U14Z2C3; Fri, 27 Feb 2026 13:21:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1241D608F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772198510;
	bh=rDOiGm4nC2OBxZNU52qZsExo+zd4jUpc82/EVs95tKk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=67alfcg6P8MnPEeVTvRLCZss+sbDkq7HZF+MmTCZTit0l/iXlQStEFG7Oz388bIu4
	 OBQvhx1IQrpJ4xzXV+7WTQfoDfn08eJ1B+hvHp9IvVKj359RwCy1XmI7ieVmm+5Xw3
	 1q3pG4nm3cYO1C//gWn7VBmzZzB8SYlNGq669kRG9NMZKUdYPpPgWDex3wi0Jrab7d
	 7XX2IjJhr76F0Ywi3tiNq9jgOA0b8GWdgmcQ55tqNf3P1ZF6s1M+xHJycUmwYG3IFV
	 EV4xfr8U6zDuY4IBewAsxAFTfRCsOcR5ICctIMLOMkDFWGIPIBCEVgTXudwANkFKaA
	 Wi5AE+DqbxbXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1241D608F4;
	Fri, 27 Feb 2026 13:21:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 835A2131
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 13:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80AA7405B5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 13:21:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C_f5LeAH1IdW for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Feb 2026 13:21:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=lorenzo@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B2163405B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2163405B0
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2163405B0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 13:21:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E36FA442F8;
 Fri, 27 Feb 2026 13:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4354BC116C6;
 Fri, 27 Feb 2026 13:21:46 +0000 (UTC)
Date: Fri, 27 Feb 2026 14:21:44 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org
Message-ID: <aaGaaExy63bGa7Or@lore-desk>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
 <20260218174742.62a4074f@kernel.org> <aZbuWBnmh_SQJyVf@lore-desk>
 <20260219091344.1d8517f3@kernel.org> <aZyKWoxnywXKWth9@lore-desk>
 <20260223151845.06db43b0@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X5UIePTG9Ua3mURR"
Content-Disposition: inline
In-Reply-To: <20260223151845.06db43b0@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772198506;
 bh=RxKqxEY0Xu8EuSp7+bKFB2HeqvW76FbZw8P16BHa8oU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eA4Idsw1g4sl/MtQ/mfXzuFUUwt6ojhVGvS8BJ7642ce6l4mCGyqq7peIYz210mjA
 JGBIqKUalyg4EgBes27actsgQoPNUhFCqA5qXEJBt+0+saaNaB0gEaxIQoPIfuTAtd
 8EYZPxVB8QctXCRh+pukcmgcI5ykwBdqTjSlcgvLNW/kh0o7i/1AYo3Ux2aAzLjEqo
 wp9qhfx3uvEgvuKtsIM1Ke8TGFtxrQqcN0eVbneaon0BD+zyrdfwy7Y7t500W23oo0
 QJvfKIhB0EdYrtIzQf7Bz6Tl9mYswQ0vMYYDbNrG2vYO/MOcucodVFjLYyBPVvjKD5
 LCpNRGUNFDb8g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=eA4Idsw1
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v3 1/5] netlink: specs: Add
 XDP RX checksum capability to XDP metadata specs
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


--X5UIePTG9Ua3mURR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 23 Feb 2026 18:11:54 +0100 Lorenzo Bianconi wrote:
> > > Off the top of my head drivers prefer reporting UNNECESSARY when they
> > > have both, and reserve COMPLETE for cases where L4 could not be found
> > > or is incorrect. Why don't we report both? We're using 3 args, we sti=
ll
> > > have 3 to go. We could turn ip_summed into a bitmap and have explicit
> > > output args for both level and csum complete value? =20
> >=20
> > Ack, thx for the explanation. Just for sake of understanding, is there
> > any NIC capable of reporting both csum_value and csum for the same pack=
et
> > in the DMA descriptor? Or is this change needed to be future-proof?
>=20
> Both nfp and fbnic definitely can. Off the top of my head - mlx5 also
> can, but I haven't double checked.

ack, thx for pointing this out, I was not aware of it. I will modify the AP=
Is
in order to add the capability to report both cksum and csum_level for a gi=
ven
packet.

>=20
> > > One more thing I'd like us to at least have a plan for at this stage
> > > is how to deal with COMPLETE + modified packet + XDP_PASS.
> > > Right now some drivers discard COMPLETE when XDP is attached since
> > > they can't be sure if XDP modifies the packet. Other drivers don't
> > > and we end up with bad csum splat. Do we have a recommendation on
> > > the correct behavior? If not - should we have a kfunc to adjust /
> > > discard csum complete explicitly? =20
> >=20
> > At the moment there is no way to store the csum value we got running
> > bpf_xdp_metadata_rx_checksum() in order to be consumed during
> > xdp_buff/xdp_frame to skb conversion (this info can just be consumed in=
 the
> > ebpf program bound to the NIC) but
>=20
> I think the scope here is much narrower than the xdp_buf to xdp_frame
> to skb conversion. We are just pass information between the program and
> driver which owns xdp_buff. Very similar to your new xmo.
>=20
> We could either tell the driver to discard the csum complete or even
> add a helper to "adjust" the the csum value. Similar to the helper
> we have to adjust the csum in TC / skb context.

IIUC, for the CSUM_COMPLETE case, we want to add a kfunc used to update (or
invalidate) the checksum value (if the packet has been modified by the eBPF
program bounded to the NIC) and report the updated checksum to the driver if
the XDP verdict is XDP_PASS. Correct?

I guess we could have two approaches here:
- Write the new checksum value into the xdp_metadata area (if available)
  where the driver can load it and update the checksum value before
  allocating the skb.
  The main downside of this approach is we need modify each driver.
- Add a new xmo callback used to set the checksum value and report it
  from the eBPF program into a specific memory area provided by the driver
  (e.g. DMA descriptor) that is used to build the skb.
=20
What do you think?

Moreover, since we already have this issue upstream, do you think this new =
feature must
be part this series or can we do it with a follow-up patch/series?

Regards,
Lorenzo

>=20
> > I guess the issue you pointed out can be solved in the verifier
> > during program load time. What do you think?
>=20
> It could, but at the verifier level we'd probably have to be fairly
> coarse-grained. Any write to the packet data would mean csum complete
> cannot be trusted, that's not too hard. But also any tail call / fentry?
> I'm not really up to date on the latest in program chaining in BPF but
> I think a lot of real-life deployments would use either chaining or
> fentry. So in practice it may be a lot of complexity for having csum
> complete always disabled w/ XDP, in practice.
>=20
> Up to you. I'm totally okay to just say** that drivers should never
> report csum complete with XDP (until appropriate API is built).
> Perhaps this will force those who care about XDP+csum_complete to
> tell us what their requirements are?
>=20
> [**] "just say" =3D=3D document and add driver kselftest that validates it

--X5UIePTG9Ua3mURR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaaGaaAAKCRA6cBh0uS2t
rKZWAQCkjxOiPEXrSTZT3qkJeVaUw7n0juwuC4GXrIPIsv9pgwD/QH7+ttDrkbKB
iSiyRZHPZpFfG0J6K+i2c23A6SEVsws=
=6+Zv
-----END PGP SIGNATURE-----

--X5UIePTG9Ua3mURR--
