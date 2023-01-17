Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D7BC00A5A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Jan 2023 23:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C498481E15;
	Tue, 17 Jan 2023 23:45:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C498481E15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673999154;
	bh=V7jXWwKaqH7KIJiyCIAhagPMEAgiAyaMePBkJRNuAT8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=xUT3cZEpzrbmjhEy4/3Y7RO9759dFHtnbxoTs1HAtIS4SBBj6WuJKAdYDxfqim2jd
	 MxjvbscFpZOAx9G1n2a/mSaE1/FIjeD5BOpLfj9It2t8KMfBJf+Fo2HNNLCv27/jNw
	 CN1VZC+J8I+/WbE8yiTM7gXqwlDXhdldsWfd0K+SzEPSOzADO1XI1KD1zBFzVh28K2
	 AXfdcryfZm2pL4mNkd7z0qKvZM4T+8v3kohQHdxA/OOu0rk2ZSyU1DfE5u0sjeVQKQ
	 TbQ+4Yc9bTrQzVWPhsQkcOscv0sMq6UtIzsM+itSaCb7T8tqjgAef0iEe8waE80IR5
	 n4rRRh3kgtYHQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rIM-JJZ_CQo4; Tue, 17 Jan 2023 23:45:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id B276881E19;
	Tue, 17 Jan 2023 23:45:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B276881E19
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 86A991BF33F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Jan 2023 23:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 605AC60E29
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Jan 2023 23:45:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 605AC60E29
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zH7TD1JL2mev for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Jan 2023 23:45:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CA7060625
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CA7060625
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Jan 2023 23:45:51 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A0BA0B81912;
 Tue, 17 Jan 2023 23:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76AFC433D2;
 Tue, 17 Jan 2023 23:45:47 +0000 (UTC)
Date: Wed, 18 Jan 2023 00:45:44 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@corigine.com>
Message-ID: <Y8czKD8/yXywbl+f@lore-desk>
References: <cover.1673710866.git.lorenzo@kernel.org>
 <b606e729c9baf36a28be246bf0bfa4d21cc097fb.1673710867.git.lorenzo@kernel.org>
 <Y8cTKOmCBbMEZK8D@sleipner.dyn.berto.se>
MIME-Version: 1.0
In-Reply-To: <Y8cTKOmCBbMEZK8D@sleipner.dyn.berto.se>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1673999148;
 bh=/isgHAWViwVBgIFKVjs/C/z6ulRns3DI5YKLAnx/VSY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FFSVm6hnYS7+aXKcCJ7GhRG6Qhdb9j8tkzbANLp+ULvVBo1lhALCbmo4OvZInbzgE
 WYiZG5nJvE5hYq+XDBsVtMp6eeFRP8vCPHuzwKDfQ936nJZ76mtyR6+xDBu9f0lNie
 ETYoHpsBZeGfs2geHaVIJzK+qaw+FRbOPUsGO1z6Cfs4J2Gavn+FsWDhZOSgQEsOZ9
 3OV/peuB3w9qTraxwoKYUw/w82WjrR3oQ/KV/fYC9pY3MPYSNZnLb5tX+HDnIsquIi
 Bncax33JsTc/kRlrHiDTqdlqxuNb7wEfkmh1ZIShvENZKxiy/yAphEV715PlCgvSMS
 eQi7l9TTTkWvg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=FFSVm6hn
Subject: Re: [Intel-wired-lan] [RFC v2 bpf-next 2/7] drivers: net: turn on
 XDP features
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
Cc: mst@redhat.com, vladimir.oltean@nxp.com, ast@kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com, daniel@iogearbox.net,
 andrii@kernel.org, intel-wired-lan@lists.osuosl.org, simon.horman@corigine.com,
 kuba@kernel.org, pabeni@redhat.com, aelior@marvell.com, hawk@kernel.org,
 christophe.jaillet@wanadoo.fr, memxor@gmail.com, john@phrozen.org,
 bjorn@kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 leon@kernel.org, netdev@vger.kernel.org, toke@redhat.com,
 ecree.xilinx@gmail.com, alardam@gmail.com, gospo@broadcom.com,
 saeedm@nvidia.com, davem@davemloft.net, nbd@nbd.name
Content-Type: multipart/mixed; boundary="===============2737971668644312528=="
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


--===============2737971668644312528==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Uje9DHp9XZ6F6Ayi"
Content-Disposition: inline


--Uje9DHp9XZ6F6Ayi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo and Marek,
>=20
> Thanks for your work.
>=20
> On 2023-01-14 16:54:32 +0100, Lorenzo Bianconi wrote:
>=20
> [...]
>=20
> >=20
> > Turn 'hw-offload' feature flag on for:
> >  - netronome (nfp)
> >  - netdevsim.
>=20
> Is there a definition of the 'hw-offload' written down somewhere? From=20
> reading this series I take it is the ability to offload a BPF program? =
=20

correct

> It would also be interesting to read documentation for the other flags=20
> added in this series.

maybe we can add definitions in Documentation/netlink/specs/netdev.yaml?

>=20
> [...]
>=20
> > diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c=20
> > b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> > index 18fc9971f1c8..5a8ddeaff74d 100644
> > --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> > +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> > @@ -2529,10 +2529,14 @@ static void nfp_net_netdev_init(struct nfp_net =
*nn)
> >  	netdev->features &=3D ~NETIF_F_HW_VLAN_STAG_RX;
> >  	nn->dp.ctrl &=3D ~NFP_NET_CFG_CTRL_RXQINQ;
> > =20
> > +	nn->dp.netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> > +				      NETDEV_XDP_ACT_HW_OFFLOAD;
>=20
> If my assumption about the 'hw-offload' flag above is correct I think=20
> NETDEV_XDP_ACT_HW_OFFLOAD should be conditioned on that the BPF firmware=
=20
> flavor is in use.
>=20
>     nn->dp.netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC;
>=20
>     if (nn->app->type->id =3D=3D NFP_APP_BPF_NIC)
>         nn->dp.netdev->xdp_features |=3D NETDEV_XDP_ACT_HW_OFFLOAD;

ack, I will fix it.

>=20
> > +
> >  	/* Finalise the netdev setup */
> >  	switch (nn->dp.ops->version) {
> >  	case NFP_NFD_VER_NFD3:
> >  		netdev->netdev_ops =3D &nfp_nfd3_netdev_ops;
> > +		nn->dp.netdev->xdp_features |=3D NETDEV_XDP_ACT_XSK_ZEROCOPY;
> >  		break;
> >  	case NFP_NFD_VER_NFDK:
> >  		netdev->netdev_ops =3D &nfp_nfdk_netdev_ops;
>=20
> This is also a wrinkle I would like to understand. Currently NFP support=
=20
> zero-copy on NFD3, but not for offloaded BPF programs. But with the BPF=
=20
> firmware flavor running the device can still support zero-copy for=20
> non-offloaded programs.
>=20
> Is it a problem that the driver advertises support for both=20
> hardware-offload _and_ zero-copy at the same time, even if they can't be=
=20
> used together but separately?

xdp_features should export NIC supported features in the current
configuration and it is expected they can be used concurrently.

Regards,
Lorenzo

>=20
> --=20
> Kind Regards,
> Niklas S=F6derlund

--Uje9DHp9XZ6F6Ayi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY8czKAAKCRA6cBh0uS2t
rLC/AP4pKRhBqfnI57ccjG64UDZk7/3FQsd+XwPmAo4AmLieEgEAgi5h5wtcUwPr
+43wVYoWmaUlSUvAqHKqt3R3OBdYQwY=
=C3/L
-----END PGP SIGNATURE-----

--Uje9DHp9XZ6F6Ayi--

--===============2737971668644312528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

--===============2737971668644312528==--
