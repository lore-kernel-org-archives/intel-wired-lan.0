Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEAFCD3423
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Apr 2026 16:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96BB66E2A9;
	Thu, 30 Apr 2026 16:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tezuERLYgVA0; Thu, 30 Apr 2026 16:53:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A7216E3BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777568008;
	bh=4K3CX6fQVp3G5LFrOMSsx2n8N4FljSdUREsN/3Z40rY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=LlFRBbc4LKIANaWoQiQHAzp3qYQUwQpv/q09bctAEe+LA8Dg14+E/Wa00jYXi5NW3
	 X9PyasV+zs2OtX++7GtvE6VWIVCenASRoqDEivaWUlNjbmz1hlGuXSl7hGW+2WT6iM
	 25hmoI/fP6k6LOe062NAcvam41tZmTvCQ9SDLEAVf28atv3COI0G7+5TK+8ZrHeUAt
	 LLxQFgsfdfY3qZY8b0M8y5N/koj4BaSTeK4RUbctiRlqEGd6eKsfdRk3HH0ycblskp
	 dasbqPpgchTtruvrALg8MnGYNdJ/X97tAK7TZvdor7kDQ2KtRnOAOyiTtMKfbc3iYc
	 Cr/qBDpxjFH6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A7216E3BE;
	Thu, 30 Apr 2026 16:53:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BACA273
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 10:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1F5B84014
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 10:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VcuL7D_7fYpP for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Apr 2026 10:30:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=ukleinek@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 76F6983EB0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76F6983EB0
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76F6983EB0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 10:30:24 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso138708395e9.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 03:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777458622; x=1778063422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4K3CX6fQVp3G5LFrOMSsx2n8N4FljSdUREsN/3Z40rY=;
 b=cDVTejLNatwsRAqTJIgIBpO2qHbSL8+K9kqaF2Xyc6Wm5WtYBMCQ4ta/pUPxjr0+6K
 u/MeE5uZdKhppewjems12+lSqFWEAOvwE2w0DXc2JM6lYqjikE+UBr/RP/GewfrY1DQ+
 8E5FGITSIHX3S2ybPcR9iadIU3To6LL/Jg4cUwJ4SFZ3nhK/LZ2HYL+oy98J+1opwUkE
 Nf8Lt7nLzBfJCG2IrWnpD9B7W4oKSf+Ox0R7jZ2S1vnhLBCklz0vvYMi782N7Ag/t9+R
 NrVHIdwgBp3GTlqeCNWmXwFhEx0NhzJVQASLslKuSl86/vtXM1d78oUlFyWArAhkdRlc
 RH4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8n5iGHwVenIEDvBCUE1vn1eN6U4izVnpfZKXEXpbclpzlA0W7CDw2gp1j35mAmXC1iuwFmPd73+yF4hsjsmao=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwPbdSbHS0pLsLgEgR9InsbjbzblGV2DKhJU3HNcHtbUvItMP8T
 WTGF9ZfffJWtSdfJyrpOKap3rxA2HIdWP+AeNI+BU7PqHueEESCyQ2nqNHUmc4PBiWI=
X-Gm-Gg: AeBDieu3jT3GuSq2JBAWl7XCOs76o78ATOo0MNe6Qrscbb169iDzRjYQv7wGmQuIbk2
 +dljNHXuYBpAp8c+cclhBRKoalxN/55fZ7B1b5o2ghF2D7zIP4XDwH3nigHzkXHWCimZTJELnwP
 1/VC5oN6wIoKdvHS08tjc0vdrrGVONF1ItXpKdWZrRGc0JtiuCu6ozzg0zzkSazATbEGg7qoJrh
 Yg0MjfyEjbDWaxJ/7t73jz1hX+zX00OAwuk5xEd2FUY++A4oPdWxC84jFXZryofxqcMNfLZZ5AW
 gVH/6iLynAsWZdVvMF8VbOoL6rQr21BenBwf6HgDxB/gEQlN2HqDNq1JUV5dnigsD3vNI6hVHCk
 uiLRKs1HfXGpTJm4bb9/klbtLc7fur1UH5nk/uFokeJ8IFevcVK0oGdw7X1E3g0/eyoG/y+VP2S
 MkJb7Wfa88ad2ho5AKmbFdPcKGqM8S/RbqCKhKdUFFdAAyeMin+RM1YfqG7HVCi8aqhgCRzN0VN
 9Lq2oXmSoFT1HAKlWJXt7LYUQ==
X-Received: by 2002:a05:600c:a4f:b0:485:3a03:ceca with SMTP id
 5b1f17b1804b1-48a7b543796mr66187605e9.23.1777458621928; 
 Wed, 29 Apr 2026 03:30:21 -0700 (PDT)
Received: from localhost
 (p200300f65f114e08936c55da887fa426.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:936c:55da:887f:a426])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48a7c57b641sm47160965e9.6.2026.04.29.03.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 03:30:21 -0700 (PDT)
Date: Wed, 29 Apr 2026 12:30:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <afHdAUpvfYa7A3AE@monoceros>
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
 <20260429-responsible-clever-coyote-6b79f1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3grpbpcumi4i3vj3"
Content-Disposition: inline
In-Reply-To: <20260429-responsible-clever-coyote-6b79f1-mkl@pengutronix.de>
X-Mailman-Approved-At: Thu, 30 Apr 2026 16:53:24 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777458622; x=1778063422;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4K3CX6fQVp3G5LFrOMSsx2n8N4FljSdUREsN/3Z40rY=;
 b=Ug291Yr5EZ7EtpgDC1DnHAnZ7Hz9h2UOPBpjUopedAM3EjZxbQLRa6CdOCYrTg1WrH
 JjCLL8brOxXDGnRH4AnTJ/BH6J/ogRjI3Lsh7MU1Op3NGy+hU+r3qTTFjZ8NEacXYzmM
 FcEXFLVr2GX7eq67Q8yhOvriTHjdmnAsqMF7uRrBGlqEhY4FZ14+gHra4eL/AvMCnOGx
 o+y590sEUD3cigqPJDNMnfNCWYGdWZV2izu/07baQD0qHZ4S8Lzx1erHbesDQEA+TW0R
 nN+LscuHPh9yibJX7+Mptwm8BHlzXICu5coYf8oGXIzsZTkrdYhsEtdLzrELd1s+JJTW
 QdZA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre-com.20251104.gappssmtp.com
 header.i=@baylibre-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Ug291Yr5
Subject: Re: [Intel-wired-lan] [PATCH net-next] net: Consistently define
 pci_device_ids using named initializers
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
Cc: Richard Cochran <richardcochran@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Randy Dunlap <rdunlap@infradead.org>, Yonglong Liu <liuyonglong@huawei.com>,
 Kees Cook <kees@kernel.org>, linux-wireless@vger.kernel.org,
 Larysa Zaremba <larysa.zaremba@intel.com>, Joe Damato <joe@dama.to>,
 brcm80211@lists.linux.dev, Daniele Venzano <venza@brownhat.org>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 MD Danish Anwar <danishanwar@ti.com>, Samuel Chessman <chessman@tux.org>,
 Fan Gong <gongfan1@huawei.com>, Mengyuan Lou <mengyuanlou@net-swift.com>,
 Kevin Curtis <kevin.curtis@farsite.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Ion Badulescu <ionut@badula.org>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Yeounsu Moon <yyyynoom@gmail.com>, Manish Chopra <manishc@marvell.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Thomas Fourier <fourier.thomas@gmail.com>,
 Sai Krishna <saikrishnag@marvell.com>, Denis Kirjanov <kirjanov@gmail.com>,
 intel-wired-lan@lists.osuosl.org, linux-parisc@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Steffen Klassert <klassert@kernel.org>,
 Stanislav Yakovlev <stas.yakovlev@gmail.com>, linux-rdma@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>, nic_swsd@realtek.com,
 Jiri Pirko <jiri@resnulli.us>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Philipp Stanner <phasta@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>, Double Lo <double.lo@cypress.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Nathan Chancellor <nathan@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, Bjorn Helgaas <bhelgaas@google.com>,
 Zilin Guan <zilin@seu.edu.cn>, linux-can@vger.kernel.org,
 Yibo Dong <dong100@mucse.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Petr Machata <petrm@nvidia.com>, Kory Maincent <kory.maincent@bootlin.com>,
 brcm80211-dev-list.pdl@broadcom.com, GR-Linux-NIC-Dev@marvell.com,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Denis Benato <benato.denis96@gmail.com>, Rasesh Mody <rmody@marvell.com>,
 netdev@vger.kernel.org, oss-drivers@corigine.com,
 Vincent Mailhol <mailhol@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Thomas Gleixner <tglx@kernel.org>,
 Simon Horman <horms@kernel.org>, Yicong Hui <yiconghui@gmail.com>,
 Mark Einon <mark.einon@gmail.com>, Johannes Berg <johannes@sipsolutions.net>,
 Heiner Kallweit <hkallweit1@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


--3grpbpcumi4i3vj3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

Hello Marc,

On Wed, Apr 29, 2026 at 11:10:21AM +0200, Marc Kleine-Budde wrote:
> On 28.04.2026 19:18:44, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
> >  	},
> > -	{ 0,}
> > +	{ }
>=20
> Nitpick: can you convert the terminating entry to follow the same style
> as the rest of the driver:
>=20
> diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/=
plx_pci.c
> index a03553b80a5d..d69ff0ccfd94 100644
> --- a/drivers/net/can/sja1000/plx_pci.c
> +++ b/drivers/net/can/sja1000/plx_pci.c
> @@ -353,8 +353,8 @@ static const struct pci_device_id plx_pci_tbl[] =3D {
>                  PCI_DEVICE_SUB(ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVI=
CE_ID,
>                                 ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_=
SUB_DEVICE_ID_BIS),
>                  .driver_data =3D (kernel_ulong_t)&plx_pci_card_info_asem=
_dual_can,
> -        },
> -        { }
> +        }, {
> +        }
>  };
>  MODULE_DEVICE_TABLE(pci, plx_pci_tbl);

That might be subjective. I also see some value to have the terminating
entry stand out a bit in the formatting and so I usually kept the entry
as it was.

If you prefer I can rework the can drivers at least to match your taste.

As you didn't object to have the can drivers converted as part of the
drivers/net patch, I assume that part is OK for you?!

Best regards
Uwe

--3grpbpcumi4i3vj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnx3bkACgkQj4D7WH0S
/k6JpggAqaPu+dVWg39EGo869zm4GExkyk9Cfi0y4X05WE8coeYG2q3U4oD1x05e
mbEJVHdpAHnBcB/vafRjFDSueFN1LbdYKyqmCOoSEVZm6FUryg3uez5LBTQ1H2M+
HSSsw95R2MJqtNxxGphk2Cr4lR3yVrG+oJpIot8CPMMed7xddK4yn7AdrudrcYAv
fhOuS+7KEB4g6yajDT95eF2Jj+hN7rzcU0+g6TBO5Gd3GnLwIhG6FG4iZnwnaU8Z
FqH+sC+KN85L/JYWezdPXgx5DnHkrmX1530hPFowO9u5SBLf6zBmbuKUgF8CdU4H
gSp6StxoogXj+z4H3WJRpNSbxjHwNQ==
=BqTG
-----END PGP SIGNATURE-----

--3grpbpcumi4i3vj3--
