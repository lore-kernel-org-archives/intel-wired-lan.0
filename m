Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE0EC53219
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 12:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43AF280DF7;
	Mon, 27 Jul 2026 12:12:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pyFycZLSudr3; Mon, 27 Jul 2026 12:12:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8292D80DC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785154378;
	bh=NuMpyXi203gMNqb11rcfOKZmtmuJN0EPDdTrfGAbmqA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jDiLFf6qhFY2Iti+FxBMvlRDrh4yIyDLnNL/lOLvnr3P38MImaJ8P423RpmqGm0GL
	 gbOTU2Kg1U9ngloE96FJ8q9XI9xKFSynFpKAwPEuylNcYMKRs4nSUrkizoz7h6zTeM
	 CSoibLzoJhd52Zg1AR2D8L0iX4HUC1mD7nnYp9WVqwQyvXGaVnYn2zMWML6zTZfujw
	 Ki2Aqt+azZxPk47a7JeW4yCdsKGR+7VvAQ/EUkX4y4vEEZD9i3QbWBsHJVqzO1ez5L
	 encF0QfPD1HQ/r5Z7K1BIJ96P0i61ux1hdcQrzhxyDDp4X3qdxM6EJELQyw3aAvi+N
	 BhSRmjm4+SnsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8292D80DC4;
	Mon, 27 Jul 2026 12:12:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1D73357
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 12:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7CD880DE3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 12:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vEm6jH2t0VkV for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 12:12:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=broonie@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 019B480DC4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 019B480DC4
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 019B480DC4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 12:12:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DAC743950;
 Mon, 27 Jul 2026 12:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0753E1F000E9;
 Mon, 27 Jul 2026 12:12:39 +0000 (UTC)
Date: Mon, 27 Jul 2026 13:12:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Alex Deucher <alexander.deucher@amd.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Borislav Petkov <bp@alien8.de>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 David Airlie <airlied@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jiri Pirko <jiri@resnulli.us>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matthew Sakai <msakai@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Mike Rapoport <rppt@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Paolo Abeni <pabeni@redhat.com>, Ping-Ke Shih <pkshih@realtek.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@verge.net.au>,
 Stephen Boyd <sboyd@kernel.org>, Steve French <sfrench@samba.org>,
 Takashi Iwai <tiwai@suse.com>, Thomas Renninger <trenn@suse.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Tony Luck <tony.luck@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
 Yazen Ghannam <Yazen.Ghannam@amd.com>, cocci@inria.fr,
 amd-gfx@lists.freedesktop.org, dmaengine@vger.kernel.org,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
 iommu@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, lvs-devel@vger.kernel.org,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 nouveau@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
Message-ID: <adcfc6f2-3309-4496-8331-1ae31e85d363@sirena.org.uk>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2ViMWcNJN7tv3iXJ"
Content-Disposition: inline
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
X-Cookie: It's OKAY -- I'm an INTELLECTUAL, too.
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785154376;
 bh=NuMpyXi203gMNqb11rcfOKZmtmuJN0EPDdTrfGAbmqA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cJUiNzz1prDmu0GWRwCZ182TsRp83BQvTp0/rURfnkMQzP20L6fG8sazv0cYKgUtW
 pg9MCuVlTFHqe3x/O6EVkylNOZs7wcPPsZhmCr3XEWEcOo26weH2DM61fSqQ+OmbrP
 tvyWB2eboDXUxX9deZuSx028Hbg9foCFt8d+5Bw+IlFteVi3skzllTVeGL1XafPYbe
 08wppeqNa8S6eH5zJPQgihAdalyGQJliwPyAS5P+AP5v8yaQxZyfcN5KNznMD5HYbU
 HA3HDDWzzh9ixbV9ramHSWGxONVFCvMxk3yVAI+jirrpd4gfEm0DA5Mx/fNCvUjATc
 xHtThaOzcAK8w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cJUiNzz1
Subject: Re: [Intel-wired-lan] [PATCH 00/36] treewide: remove conditional
 returns with no effect
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


--2ViMWcNJN7tv3iXJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2026 at 03:45:02AM +0900, Sang-Heon Jeon wrote:

> All patches are independent and can be applied separately, but for
> everyone's convenience, it would be nice if they were merged through
> a single tree.

Please don't do this, it does not make anything more convenient - it
results in huge CC lists and makes it more difficult to work out who
will actually apply things.  If there's no dependencies just send to
each subsystem independently.

--2ViMWcNJN7tv3iXJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpnSzQACgkQJNaLcl1U
h9DhKwf/RoCnDee69F9hZ06/HOdC8gDpovt8IjWRgC8X3EQmHZkTxcKWoky17APD
5D8K2eKoz+FEDKrtFChR3EfGX0AhpmXhKtwaUanH/Qm+clf4ZjOTiguGtDpB4EVm
bTQ0cWSCcNpHm4yfpRk8XJVw/leZO0YIsDDi9rHzgeKJVY5zWBXi6azVk3svE2Ut
E9u3jmn1vStzN8uV36mRJ2+hgzFQOVilP6XSNNxMrdu6GJXHk/T6ZUlANNAxGcbL
/fZLJuq1gzwgfEJevdiqJ+O9U3OQl0DV9ZELQBaghYKq6Lv3nMs3PFSromeerfgv
GqK0jSpzheWN4gsenCQKqgt3POQM+g==
=WTGT
-----END PGP SIGNATURE-----

--2ViMWcNJN7tv3iXJ--
