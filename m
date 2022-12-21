Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D9AC4332F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Dec 2022 10:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EEFB8400F6;
	Wed, 21 Dec 2022 10:47:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EEFB8400F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671619646;
	bh=w0KhHbmVg0QIUN5FhyCFuajeE2ITfogZIJmI8OMaCKw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=m0cCNvYJIdzt46+VcabSYcXPhs1FpHL92AwKDjPflXG4YeLeqkDenVHTVthHyhTyQ
	 UDdbJMCJqXeLCqoLoUk9njjdaQHbMvQDPEQzdcsvR/FedssivGXFO70d7FtgAtcaz8
	 ILQvPTiOVRt9fOK/aCE70tkdfvBfX0cxb54liOd2+bugn9rC01sUn9pylPAquq1Aon
	 s01CmZ0Oi05l15Ryt3K8L/Wgv+a6xemdsHkgSEE/LLejPpCUGst5D5crAU/acUrJcu
	 YrFLZLdvAcMJW5NpwAtTuQj6rVDtwQZ/R9cgogOu76T8+g96+w50t+qu6SR3p3PmkO
	 6wCBpfxN/rzHw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L6p9pXoki7sP; Wed, 21 Dec 2022 10:47:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1513240B53;
	Wed, 21 Dec 2022 10:47:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1513240B53
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 6C7BA1BF5E0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Dec 2022 10:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5261940B53
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Dec 2022 10:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5261940B53
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4iYeO14Vdj8j for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Dec 2022 10:47:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57BAF400F6
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57BAF400F6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Dec 2022 10:47:23 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id DDD2ECE17C8;
 Wed, 21 Dec 2022 10:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A87C433EF;
 Wed, 21 Dec 2022 10:47:17 +0000 (UTC)
Date: Wed, 21 Dec 2022 11:47:14 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Message-ID: <Y6LkMtURZEjfVWVv@lore-desk>
References: <cover.1671462950.git.lorenzo@kernel.org>
 <43c340d440d8a87396198b301c5ffbf5ab56f304.1671462950.git.lorenzo@kernel.org>
 <20221219171321.7a67002b@kernel.org> <Y6F+YJSkI19m/kMv@lore-desk>
 <CAAOQfrF963NoMhQUTdGXyzLMdAjHfUmvzvxpOL0A1Cv4NhY97w@mail.gmail.com>
 <20221220153903.3fb7a54b@kernel.org>
 <20221220204102.5e516196@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20221220204102.5e516196@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1671619638;
 bh=aVDDiFOJK4tI1KD4ouwvUzCRM24HCXz/rMHIn+pJYrE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BsWtqG42vKr4ZSW4MqJiGO60bXWpHqLTGur2mwIPQNOZIKVyNM94y+cJFVSMhgtzH
 vHb99vGAuKzJ/Kd4gzeBaOf8B5R0at23nab4n/jZvlxW9KMRA1U3FGK4RcBqFZ3gVj
 6YeR7SzFwy7a9GL3i271y1pKRPVasqALKhW4Hzddfc2agMMgj2hRHjvL0Gb1jLhFex
 FQZbger9/Dojk/+PlXp2eW2UbWPJ6XdAOBrHHMQckyvvwRjgFavN0hGxz9IY5Vh0yV
 MeHMymapK01kCl3XTmUuUrKinju6+ynUStIbQE2YhUsYF8/NZhnDIsNrauz5B+mA4f
 7XqXM+q6pudjw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=BsWtqG42
Subject: Re: [Intel-wired-lan] [RFC bpf-next 2/8] net: introduce XDP
 features flag
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
Cc: mst@redhat.com, simon.horman@corigine.com, ast@kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com, daniel@iogearbox.net,
 andrii@kernel.org, intel-wired-lan@lists.osuosl.org, vladimir.oltean@nxp.com,
 pabeni@redhat.com, grygorii.strashko@ti.com, aelior@marvell.com,
 hawk@kernel.org, christophe.jaillet@wanadoo.fr, memxor@gmail.com,
 john@phrozen.org, bjorn@kernel.org, bpf@vger.kernel.org,
 magnus.karlsson@intel.com, leon@kernel.org, netdev@vger.kernel.org,
 toke@redhat.com, ecree.xilinx@gmail.com, Marek Majtyka <alardam@gmail.com>,
 gospo@broadcom.com, saeedm@nvidia.com, davem@davemloft.net, nbd@nbd.name
Content-Type: multipart/mixed; boundary="===============2399413934364582943=="
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


--===============2399413934364582943==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+eCb0XDvva+nTJ1R"
Content-Disposition: inline


--+eCb0XDvva+nTJ1R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 20 Dec 2022 15:39:03 -0800 Jakub Kicinski wrote:
> > On Tue, 20 Dec 2022 23:51:31 +0100 Marek Majtyka wrote:
> > > Everybody is allowed to make a good use of it. Every improvement is
> > > highly appreciated. Thanks Lorenzo for taking this over. =20
> >=20
> > IIUC this comment refers to the rtnl -> genl/yaml conversion.
> > In which case, unless someone objects, I'll take a stab at it=20
> > in an hour or two and push the result out my kernel.org tree ...
>=20
> I pushed something here:
>=20
> https://github.com/kuba-moo/ynl/commits/xdp-features
>=20
> without replacing all you have. But it should give enough of an idea=20
> to comment on.

ack, thx. I will look into it.

Regards,
Lorenzo

--+eCb0XDvva+nTJ1R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY6LkMgAKCRA6cBh0uS2t
rOyiAQD5NVL/9N4NHfxoSJKlDMMG7ppq80Eax6fJ/Klm4n2WrAD9EA8vAIZ4TItH
WtCvhtFiz0xWJmKiDgKq9r6AMiTB5gs=
=nnX9
-----END PGP SIGNATURE-----

--+eCb0XDvva+nTJ1R--

--===============2399413934364582943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

--===============2399413934364582943==--
