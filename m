Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253CFC61D97
	for <intel-wired-lan@archiver.kernel.org>; Sun, 29 Jan 2023 18:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83DE04157D;
	Sun, 29 Jan 2023 18:48:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83DE04157D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675018090;
	bh=5WCAv/Z0UHXnqR2FreFjRX/5nqkJsCGSYozaIqL/U+c=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9WLCZyRyfQC2sERAxKSVNTBYM/2x+xZNugLC0j78qa6JgwT0Bfuh1yh9HpYmGWHaG
	 rEdjXQfPYBLgo7ZQZzg/6oEJDmuo/WofMPYnIIv1gsENhyEnpVyAjeqzufcq5x/J8K
	 qjFAY7OQRHeKKqtr+tDipRBodJtJgDgbuXUd8+nsmAoqD4aPebJLjo9Cnd0U7WeNrX
	 u9+RmHfJy49kpqXwagwisLubFMyZ/cGb7kEuI0CurqxHia3qFyoJB1QE85Jh1JSSWk
	 IOYurhb1jMHcs7ARElxcS9vNF6ChlSzPNhREO94zHizpX5Qn7XMVstaIbUAISyTZJC
	 Pg7kmqLgdXxAA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rMukXugMss78; Sun, 29 Jan 2023 18:48:09 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F9064159D;
	Sun, 29 Jan 2023 18:48:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F9064159D
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 081561BF385
 for <intel-wired-lan@lists.osuosl.org>; Sun, 29 Jan 2023 18:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D30768174A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 29 Jan 2023 18:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D30768174A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4eeJIA2zOMa8 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 29 Jan 2023 18:48:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13D4A81583
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 13D4A81583
 for <intel-wired-lan@lists.osuosl.org>; Sun, 29 Jan 2023 18:48:06 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E93E560DF4;
 Sun, 29 Jan 2023 18:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA412C433D2;
 Sun, 29 Jan 2023 18:48:04 +0000 (UTC)
Date: Sun, 29 Jan 2023 19:48:01 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Message-ID: <Y9a/YWBBU/cjofIr@lore-desk>
References: <cover.1674913191.git.lorenzo@kernel.org>
 <a7eaa7e3e4c0a7e70f68c32314a7f75c9bba4465.1674913191.git.lorenzo@kernel.org>
 <CAADnVQJhdxM6eqvxRZ7JjxEc+fDG5CwnV_FAGs+H+djNye0e=w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJhdxM6eqvxRZ7JjxEc+fDG5CwnV_FAGs+H+djNye0e=w@mail.gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1675018085;
 bh=wqWSHpwy3MUpVmsntNqQHtsxLsPh+QcU+TX0EB5Z+4c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Nz1tZKtoo2WWyX7mMEDJ0juSHAcoJaOdpTBcbcWkG+P8/FhbZM+UEhpuuleS+FLUd
 4OzJ1t+ZdgzDeJ+nJ4yDp/amMYIlrdWBGOEzygjP42g2g245qB9D3YSX7Pbdh7NvOW
 5G4KuVbsuWWQ0KnKKM0iPK/t2i+ekATc7EwjAmIiuv6cHg1mOiOx/9Ws+QUbW+Wz9U
 iOyZMdtrQfBGEEPLquar3kg/yHDyqjMVltQbV/uB/96KSSE2RytjjXyE4kAIQ1je0/
 KSX1gPVLOhpWEHgNY+q/tEpVTXmBZVKNPWb4FJ1+jipdegmwISU77c+1qKZg14IB+2
 gkfbLrJHYVGKg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Nz1tZKto
Subject: Re: [Intel-wired-lan] [PATCH v4 bpf-next 8/8] selftests/bpf:
 introduce XDP compliance test tool
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, vladimir.oltean@nxp.com,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 anthony.l.nguyen@intel.com, Stanislav Fomichev <sdf@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
 Simon Horman <simon.horman@corigine.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, christophe.jaillet@wanadoo.fr,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, john@phrozen.org,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, bpf <bpf@vger.kernel.org>,
 "Karlsson, Magnus" <magnus.karlsson@intel.com>,
 Leon Romanovsky <leon@kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, ecree.xilinx@gmail.com,
 Marek Majtyka <alardam@gmail.com>, Andy Gospodarek <gospo@broadcom.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Felix Fietkau <nbd@nbd.name>
Content-Type: multipart/mixed; boundary="===============7549691132228080455=="
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


--===============7549691132228080455==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nx0wHPKtgW7QyJuF"
Content-Disposition: inline


--Nx0wHPKtgW7QyJuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 28, Alexei Starovoitov wrote:
> On Sat, Jan 28, 2023 at 6:07 AM Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
> > diff --git a/tools/testing/selftests/bpf/xdp_features.h b/tools/testing=
/selftests/bpf/xdp_features.h
> > new file mode 100644
> > index 000000000000..28d7614c4f02
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/xdp_features.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/* test commands */
> > +enum test_commands {
> > +       CMD_STOP,               /* CMD */
> > +       CMD_START,              /* CMD + xdp feature */
> > +       CMD_ECHO,               /* CMD */
> > +       CMD_ACK,                /* CMD + data */
> > +       CMD_GET_XDP_CAP,        /* CMD */
> > +       CMD_GET_STATS,          /* CMD */
> > +};
> > +
> > +#define DUT_CTRL_PORT  12345
> > +#define DUT_ECHO_PORT  12346
> > +
> > +struct tlv_hdr {
> > +       __be16 type;
> > +       __be16 len;
> > +       __be32 data[];
> > +};
> > +
> > +enum {
> > +       XDP_FEATURE_ABORTED,
> > +       XDP_FEATURE_DROP,
> > +       XDP_FEATURE_PASS,
> > +       XDP_FEATURE_TX,
> > +       XDP_FEATURE_REDIRECT,
> > +       XDP_FEATURE_NDO_XMIT,
> > +       XDP_FEATURE_XSK_ZEROCOPY,
> > +       XDP_FEATURE_HW_OFFLOAD,
> > +       XDP_FEATURE_RX_SG,
> > +       XDP_FEATURE_NDO_XMIT_SG,
> > +};
>=20
> This doesn't match the kernel.
> How did you test this?
> What should be the way to prevent such mistakes in the future?

Hi Alexei,

I added the XDP_FEATURE_* enum above since the XDP compliance test tool nee=
ds
to differentiate between actions in NETDEV_XDP_ACT_BASIC (e.g XDP_TX and
XDP_PASS or XDP_REDIRECT are handled differently in the ebpf programs insta=
lled
on the tester and DUT devices). However, combining netdev_xdp_act and xdp_a=
ction
enum definitions, I think we can keep this logic in xdp_feature userspace p=
art
and we can get rid of the XDP_FEATURE_* enum above.
I will fix it in v5.

Regards,
Lorenzo

--Nx0wHPKtgW7QyJuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY9a/YQAKCRA6cBh0uS2t
rA0MAQD14qKZyBuuTUx+gcvcXc9dncuAjpGH/LEYEmvcdZpjPgD/evMoa3V8P0ut
zGEhB25aPtnf/qiDteYI2cvq8czggAw=
=A3gE
-----END PGP SIGNATURE-----

--Nx0wHPKtgW7QyJuF--

--===============7549691132228080455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

--===============7549691132228080455==--
