Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E21FEE4C9
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Feb 2026 11:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAA4C418C6;
	Sat, 28 Feb 2026 11:59:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X3cDpCgproON; Sat, 28 Feb 2026 11:58:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5E6C418B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772279939;
	bh=/PtUfVrsqDoReT1Tcw6qktujo46XwI7/Ej7DUD04/2o=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GQSiYgcR0DFzMx+O9Pn9JeF7ZMBGI3t2gFsmlCVAga2NN434Dk75DYRhKYnDL4zNx
	 gT8vOH2fRewCUP1DDG3yJLgrs7fce0rfkcitvjXGIuo2uo/We/MYTEDaIED/SARK36
	 bW2mfI0rdYh3iiDiiUUi7dRZ6qqj+nYLIMaRJNabcug14XJ+DpBe9JGoQe5eKZw1f0
	 WX6I0cPrKy19+HrGGDYZX4KmX+gOiC90FzfTcG4wAzFmh+shSgw1GiMRgPj02zff+1
	 2M3wyckHqiZG5cM1qbQxsUCZpqzlD9pK1GvSymO7MIXYHnmgsc+q1dMw/wr87JBib5
	 c1wpGZOd+JF0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5E6C418B2;
	Sat, 28 Feb 2026 11:58:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5386018D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Feb 2026 11:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 391A3418B2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Feb 2026 11:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1RjShhVoASGF for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Feb 2026 11:58:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=lorenzo@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8434D418A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8434D418A9
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8434D418A9
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Feb 2026 11:58:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 57A34401AA;
 Sat, 28 Feb 2026 11:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19DAC116D0;
 Sat, 28 Feb 2026 11:58:55 +0000 (UTC)
Date: Sat, 28 Feb 2026 12:58:53 +0100
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
Message-ID: <aaLYfWnuuf_ne72u@lore-desk>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
 <20260218174742.62a4074f@kernel.org> <aZbuWBnmh_SQJyVf@lore-desk>
 <20260219091344.1d8517f3@kernel.org> <aZyKWoxnywXKWth9@lore-desk>
 <20260223151845.06db43b0@kernel.org> <aaGaaExy63bGa7Or@lore-desk>
 <20260227153231.78d16b69@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zJe+viDHT4x8TgXE"
Content-Disposition: inline
In-Reply-To: <20260227153231.78d16b69@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772279936;
 bh=SA4eviJ/yZpyCZ7RPvowxWRJiO91Y0GTqAPs96rzHJg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fz3ojnSEYFMcEgZJjq4mQUrWrDU3Tq7qRuMBtK0kB6Rt/zxOJel2Gu9YaosO6Ug6F
 8C8YvGmh+ZSlAKQb2mILbGWXAUW4ufmFh+fOsdtbbo5yStug7IZ6K3Yb1EKcPEYmEw
 FNFeGHA0YghHdjL48ZxJ7A8rk9Wk471f7TxTMEsiS7IwtvHtDN95LVNIpc5sx7258p
 5CD8U8wHZK+CFn7wViJEB/MA7QvNxhfBAdhA4cp1zY3rl4LY5mYmOXgOHnj0V8ZxoB
 CQ7Qkh3Lmfw81RRL6gVP4oSHtB2WR33hCgei/6GU08EPMPY9PFkvpyLNLGC1O3BAYe
 A2r8i7UILNcxw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fz3ojnSE
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


--zJe+viDHT4x8TgXE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 27 Feb 2026 14:21:44 +0100 Lorenzo Bianconi wrote:
> > > > At the moment there is no way to store the csum value we got running
> > > > bpf_xdp_metadata_rx_checksum() in order to be consumed during
> > > > xdp_buff/xdp_frame to skb conversion (this info can just be consume=
d in the
> > > > ebpf program bound to the NIC) but =20
> > >=20
> > > I think the scope here is much narrower than the xdp_buf to xdp_frame
> > > to skb conversion. We are just pass information between the program a=
nd
> > > driver which owns xdp_buff. Very similar to your new xmo.
> > >=20
> > > We could either tell the driver to discard the csum complete or even
> > > add a helper to "adjust" the the csum value. Similar to the helper
> > > we have to adjust the csum in TC / skb context. =20
> >=20
> > IIUC, for the CSUM_COMPLETE case, we want to add a kfunc used to update=
 (or
> > invalidate) the checksum value (if the packet has been modified by the =
eBPF
> > program bounded to the NIC) and report the updated checksum to the driv=
er if
> > the XDP verdict is XDP_PASS. Correct?
> >=20
> > I guess we could have two approaches here:
> > - Write the new checksum value into the xdp_metadata area (if available)
> >   where the driver can load it and update the checksum value before
> >   allocating the skb.
> >   The main downside of this approach is we need modify each driver.
> > - Add a new xmo callback used to set the checksum value and report it
> >   from the eBPF program into a specific memory area provided by the dri=
ver
> >   (e.g. DMA descriptor) that is used to build the skb.
> > =20
> > What do you think?
>=20
> Exactly. The invalidation is easier 'cause using a single bit in the
> flags should be uncontroversial. If we want to be able to repair /
> provide the csum complete then we have to pick one of the two options
> you outlined. As you may suspect from previous discussions I favor=20
> the latter. But we'd probably have to have a PoC with either one and
> see where the consensus falls.

ack, I will work on a PoC.

>=20
> Actually, thinking about it more, I guess this is not just a
> CSUM_COMPLETE issue. XDP_PASS will also risk reporting invalid
> UNNECESSARY to the stack (e.g. when XDP stripped a UDP tunnel
> which which the NIC compute the UNNECESSARY but the packet inside
> the tunnel has an invalid csum).
>=20
> > Moreover, since we already have this issue upstream, do you think
> > this new feature must be part this series or can we do it with a
> > follow-up patch/series?
>=20
> We don't have to add the kfunc to adjust / invalidate the csum.
> But we should document how the drivers are expected to behave until
> such kfunc exists and we should add a selftest that checks the
> documented expectation.

I will add the required documentation and kselftest in the next iteration.

Regards,
Lorenzo


--zJe+viDHT4x8TgXE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaaLYfQAKCRA6cBh0uS2t
rK8NAQCa3BtPt0r6O4Rd1WSKMud4jYbuc+yFGRH5iD2pYIy4DQEAjp1slS4Z4kQg
Efic0WsT4AYh9Xf0lUF6VupLvRIrWAE=
=4fhS
-----END PGP SIGNATURE-----

--zJe+viDHT4x8TgXE--
