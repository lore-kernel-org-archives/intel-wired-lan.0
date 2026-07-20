Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBABC44515
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 22:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AD8360718;
	Mon, 20 Jul 2026 22:08:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qRdwtrE2lhB3; Mon, 20 Jul 2026 22:08:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35FDB60704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784585338;
	bh=z11ITbQvt4NP+i0GjTjmCBTKhf0Lxqrhu6WfRIGhnpQ=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fEHKu1XYGP5Zmq1z9XAY/TXKvhriohy5T9uQbBGRzJD0XL6i8IvXtthrcXJI6bZ3r
	 rZWJhAW8rOllg387Tq3p2FfZ2EMtqpZDpvyAKr/Fr4MKemlHwYfMBe/P3WPEzToje9
	 8yQODSGFOvxLZG0smHXd+WGsvPP/h3+TLxqEGd4SdIUU2kSmPzBA/IVsdIXoCgPhry
	 7o+XJPIGUxBF9e5Gl/f1XCPotQNZq5VD3uLNLjp5ZO7tEZooVWGOs6w3ejKvZW5i4K
	 v1s4GRdz79k5U8mSHs9Y2ueLe40fnwT6kUgtPjbtmyYDtbERfa0sUcpvDQgQ2LV9v1
	 BJZYAcOQUyd9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35FDB60704;
	Mon, 20 Jul 2026 22:08:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B1B6696C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 22:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9775440089
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 22:08:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LawowNJYJtqN for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 22:08:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=lorenzo@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A8EDA4009F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8EDA4009F
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8EDA4009F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 22:08:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 25CD060A7A;
 Mon, 20 Jul 2026 22:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2966B1F000E9;
 Mon, 20 Jul 2026 22:08:54 +0000 (UTC)
Date: Tue, 21 Jul 2026 00:08:52 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Vladimir Vdovin <deliran@verdict.gg>,
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Message-ID: <al6cdHMBpd1SqZyl@lore-desk>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
 <alkBnI3XcH0XGjEo@lore-desk>
 <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Poik8L3QQ7fei6lR"
Content-Disposition: inline
In-Reply-To: <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784585334;
 bh=z11ITbQvt4NP+i0GjTjmCBTKhf0Lxqrhu6WfRIGhnpQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mT6UbtmYOcXsiFK7elvuKwRHp7wkmlw03MJRL5gqKdAITLpvWFTnN92LZxOKLVAcj
 fXA1y3IrVJq/qALoBLutVthJWs6NmYVJ7RPOJ5wSk1RXGByldWP4//t2HWuNmCjQp2
 ciykP2LyK2iACclGNuy2mMgN6gNl/30oqyv1T0gJxiQsFY6T0XgT7hzt1y7vIUTWpR
 MBW156AzU1Ad82gIWGpqXDhgVPauUlTW0kFkWxhGT58S3tExitlwiz9EUbtRT6lsg4
 dsY+rQPSG72eOv4NPr7XthzSTlx8UwILF0pPjRcVGHOAcGXE+InVWtBRsAAx8sfR9b
 yFes13reBTApQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mT6UbtmY
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v5 8/8] selftests: net: add
 test for XDP_PASS skb checksum invalidation
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

--Poik8L3QQ7fei6lR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 07/16, Lorenzo Bianconi wrote:
> > On Jul 16, Stanislav Fomichev wrote:
> > > On 07/15, Lorenzo Bianconi wrote:
> > > > Add a test that verifies skb->ip_summed is set to CHECKSUM_NONE
> > > > when a device running in XDP mode creates an skb from a xdp_buff
> > > > if the attached ebpf program returns an XDP_PASS.
> > > > The test attaches an XDP program returning XDP_PASS, and a TC
> > > > ingress program that runs the bpf_skb_rx_checksum() kfunc to
> > > > inspect the resulting skb. After XDP_PASS the driver must invalidate
> > > > any previously computed hardware RX checksum since XDP may have
> > > > modified the packet data.
> > > > The BPF program counts packets per checksum type in a map, and the
> > > > test runner verifies that after sending traffic the CHECKSUM_NONE
> > > > counter is non-zero while CHECKSUM_UNNECESSARY and CHECKSUM_COMPLETE
> > > > counters are zero.
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  Documentation/networking/xdp-rx-metadata.rst       |  5 ++
> > > >  .../selftests/drivers/net/hw/xdp_metadata.py       | 55 ++++++++++=
+++++-
> > > >  .../selftests/net/lib/skb_metadata_csum.bpf.c      | 73 ++++++++++=
++++++++++++
> > > >  3 files changed, 132 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documen=
tation/networking/xdp-rx-metadata.rst
> > > > index 93918b3769a3..7434ac98242a 100644
> > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > @@ -90,6 +90,11 @@ conversion, and the XDP metadata is not used by =
the kernel when building
> > > >  ``skbs``. However, TC-BPF programs can access the XDP metadata are=
a using
> > > >  the ``data_meta`` pointer.
> > >=20
> > > [..]
> > >=20
> > > > +If a driver is running in XDP mode, any existing hardware RX check=
sum
> > > > +(``CHECKSUM_UNNECESSARY`` or ``CHECKSUM_COMPLETE``) must be invali=
dated
> > > > +by setting ``skb->ip_summed`` to ``CHECKSUM_NONE`` before passing =
the
> > > > +skb to the kernel, since XDP may have modified the packet data.
> > > > +
> > > >  In the future, we'd like to support a case where an XDP program
> > > >  can override some of the metadata used for building ``skbs``.
> > >=20
> > > Sorry for keeping nitpicking on this, but I'm still not convinced that
> > > it is what we currently do. From my previous reply:
> >=20
> > no worries :)
> > My current take-away from the previous discussion is we just need to do=
cument
> > what would be the driver expected behaviour adding a kselftest for it (=
without
> > modifying any driver).
> >=20
> > >=20
> > > > > Looking at a few drivers:
> > > > > - bnxt (bnxt_rx_pkt) does UNNECESSARY - ok
> > > > > - mlx5 (mlx5e_handle_csum) does UNNECESSARY and skips COMPLETE if=
 there is
> > > > >   bpf prog attached
> > > > > - fbnic (fbnic_rx_csum) - can do COMPLETE even with xdp attached?
> > > > > - gve (gve_rx) - can do COMPLETE even with xdp attached?
> > >=20
> > > (although for gve I might be wrong, there is also gve_rx_skb_csum tha=
t only
> > > does UNNECESSARY).
> > >=20
> > > I'd wait for Jakub to chime in, but it feels like we should just docu=
ment
> > > what we currently do as a recommended approach: for the drivers
> > > that support COMPLETE, do not report it when the bpf program is attac=
hed.
> > > Both NONE and UNNECESSARY are ok.
> >=20
> > I am not completely sure the UNNECESSARY case is different from the COM=
PLETE
> > one. What are we supposed to do if the driver reports UNNECESSARY and t=
he ebpf
> > program modifies some fields covered by the rx-checksum?
>=20
> For unnecessary, I think the safe expectation is that the bpf program
> will update the value of the checksum in the packet if it touches the dat=
a?

I do not have a strong opinion on it.
@Jakub: any input on it?

>=20
> > > Also, did you run this test on real HW? NIPA now has HW tests, maybe =
it
> > > makes sense to route this series via net-next to get the real coverag=
e?
> >=20
> > What about splitting this series and have two different series:
> > - bpf-next: add xdp rx kfunc and related selftest
> > - net-next: add kselftest for the driver expected behaviour.
> >=20
> > What do you think?
>=20
> I'd post everything to net-next to get the HW coverage. Once you get all
> the acks we can ask the maintainers' guidance.

ack, I am fine with that.

Regards,
Lorenzo

--Poik8L3QQ7fei6lR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCal6cdAAKCRA6cBh0uS2t
rBbAAQDuKu2WNBvm2CcO6No6R6S427G1mLi7hdfmjTMduKOLYwEA9/j6hFjjCn7s
9OGAW6D4Pk31PHVDpSIYW7xQEkUWTwU=
=j1RN
-----END PGP SIGNATURE-----

--Poik8L3QQ7fei6lR--
