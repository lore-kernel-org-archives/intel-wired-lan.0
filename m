Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED4ECD343F
	for <intel-wired-lan@archiver.kernel.org>; Sat,  9 May 2026 06:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E20F83D18;
	Sat,  9 May 2026 06:42:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9UdWoDLdntEE; Sat,  9 May 2026 06:42:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B512083CD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778308966;
	bh=4fgHjlyy8GzHWAXn0Fq+FtEi3bvrm+LBlHiRLm/LF+E=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=3BVj4EiswRd1rpZEO2Z3Q0GhSDIzSBbBEY+KZUwyzACU859IWR/F8KYlFfQ1l6t8J
	 rM8F0pOTUrfQ+BlB9OJ4RedpK2m/I7r4hGnraybE6fRbCvLf7P53d1Ae9JEKuULA7z
	 d/IbO+/tkS4BggSMe2yg5GV/ddmafAJd+wNM2Ei9Y+LD70m0x9aZ4EdVBv+BK/zk7T
	 6eoYgfzlSxSxIyskDnW7dbnnzOCi90JxFTRbiW/OdNiyPubJnxgRf78O8OvUZIm7yW
	 u8oqDEiUjAubvdxWJ0W/Og03U5TMRGRdeZJTlQrHXN9CRIKNvMkdguGdOgfi+nOBJt
	 Rie7qHXSG+7Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B512083CD1;
	Sat,  9 May 2026 06:42:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22EA925B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 May 2026 06:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08995423CF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 May 2026 06:42:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QwQTaIK4I12g for <intel-wired-lan@lists.osuosl.org>;
 Sat,  9 May 2026 06:42:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ukleinek@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C5759423CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5759423CB
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5759423CB
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 May 2026 06:42:43 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso29025705e9.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 08 May 2026 23:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778308961; x=1778913761;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4fgHjlyy8GzHWAXn0Fq+FtEi3bvrm+LBlHiRLm/LF+E=;
 b=Zqy30ZLyipqHR2o52CbWHhxFc1is8lRJsSq5LowD/3HBHO/+GJE0cs88+CuGhcT6Dg
 Nc4OWyOmVC9bt1orQaXd6NjDKlRK/5IsQwuV8dS/ZHD3kvUEsQvo4b+ZA/ZJittZo10T
 QHyVJwA6dhV6i9JDD9/ctuhzVnxW4IJEMSRZOCEddAihgPOlCaA0XNF9pU4gfkcFqkgV
 2tuA5DzhG73tnhq5YdUZLOwRHhP6qyWseFMI8Ogq9ZAt9WGxD35zuEhuqfVp5gN5Vh2I
 T4A9fkqo288+j3pX+u5REXQBMnMR4F0KKMMX0uu8L+1hdG4Qb9xCJZJsDaBRhD8dZ0Vl
 obfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TIt3aY9OMT3MSoR6qNIPGjSNJJ4yd3XhAel2WB2oO8nTTc3k3o5ykXHZ+HPGWkZgs4bk/H3OjUCWJDTGJSow=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzusTFwQTOTiviegkO7jvkgCaTKH//9xKZZ4OHC/6tN0+k9rYz3
 D9fpjmKt8JQ3Oj1OIrH+6/QJPvuXMtBZgfNlWgGw7H85SbX3flUwSLobWG+EEL0BkWI=
X-Gm-Gg: Acq92OE8QqOsG0J4OW5FQJduDDn+NumSVEXrSqerwtCRBnIlnlMdjqzsKv/ctm4uvj6
 YQ9KEBCLiCGvdyJVRE4DS6KL5fly1zPtAId4q4tY4tyYg0037Rgwx4e8WPSBShKokgP+1D7nY7j
 zySgdyHAN2I0Jo7VTER3zOovSnepZ9XXPj+QTA9cubZW0Wt9cOYxFeaynE9KgpjYI+LpK4q1rkD
 ZkRgF5XbOiJ91EzZt8y74be7JdKmR46pcRhhkkGRlKPzFYUnaDFm/cDSHx6RJGBCIkLoPVq9dfv
 t0b+2ustR1H95xAId+sqaPIRNPQfCFLvUS9jsHsQ14V7xRy9LhEtAqedxZjitf+x05ek/+BXw2z
 AuNm51FRONDvN6CJjXL/pOsYgkhxZeknOM6YGE8aADVG5chUmdAGWJZHKhPpMaKm1e4UBXnfZ1w
 jVYy2CPd9FXoK4n9FY+gTIlxKvoC/n361m4QYVBnM=
X-Received: by 2002:a05:600c:4f51:b0:48d:1a94:56c with SMTP id
 5b1f17b1804b1-48e51f3054cmr269055545e9.18.1778308960358; 
 Fri, 08 May 2026 23:42:40 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48e6db1e1a1sm15355095e9.34.2026.05.08.23.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 23:42:38 -0700 (PDT)
Date: Sat, 9 May 2026 08:42:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Jakub Kicinski <kuba@kernel.org>
Message-ID: <af7WyUi8jEzInj5z@monoceros>
References: <cover.1778149923.git.u.kleine-koenig@baylibre.com>
 <20260508153452.6a1a9044@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pa3si5htqwvg7uxg"
Content-Disposition: inline
In-Reply-To: <20260508153452.6a1a9044@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778308961; x=1778913761;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4fgHjlyy8GzHWAXn0Fq+FtEi3bvrm+LBlHiRLm/LF+E=;
 b=WmvPIK9RciQfzyUHKOVrRjydHTXJ3TYVSloB5pfyDvqL6prKISntk0WcHhadIbLrKX
 KdyfxQ8fjFJFwnh+zFKCeuSXkqp8deN09LQi8tPm9IuULPVVsQI46gK8zTCALOl4FhlU
 egJC7FE928N+38n+wM/iPGvrOU8xC7o+9dU9fJ1X5OCKBkn01OH3jGLXK7QmJ8aMnN9R
 H0xu45Py+veMGhf3WgoAQRdnqF3Pr7+OYVlsorR8+8C/6vN/WuZYI/scS9WQDqvbtSYv
 QoyCci6cYmmsvplFVH3YIkpHfO3u4kYe9s6K26uhjdARo0PSDu3l7ln8u7ktihDINOdP
 wgxg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre-com.20251104.gappssmtp.com
 header.i=@baylibre-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=WmvPIK9R
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 0/2] Rework pci_device_id
 initialisation
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
 Ian Lin <ian.lin@infineon.com>, brcm80211@lists.linux.dev,
 Daniele Venzano <venza@brownhat.org>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 MD Danish Anwar <danishanwar@ti.com>, Samuel Chessman <chessman@tux.org>,
 Fan Gong <gongfan1@huawei.com>, Mengyuan Lou <mengyuanlou@net-swift.com>,
 Kevin Curtis <kevin.curtis@farsite.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Michael Grzeschik <mgr@kernel.org>, Ion Badulescu <ionut@badula.org>,
 Yeounsu Moon <yyyynoom@gmail.com>, Manish Chopra <manishc@marvell.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Thomas Fourier <fourier.thomas@gmail.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Denis Kirjanov <kirjanov@gmail.com>, intel-wired-lan@lists.osuosl.org,
 linux-parisc@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Steffen Klassert <klassert@kernel.org>,
 Stanislav Yakovlev <stas.yakovlev@gmail.com>, linux-rdma@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>, nic_swsd@realtek.com,
 Jiri Pirko <jiri@resnulli.us>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Ido Schimmel <idosch@nvidia.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>, Double Lo <double.lo@cypress.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Nathan Chancellor <nathan@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, Mark Einon <mark.einon@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Zilin Guan <zilin@seu.edu.cn>,
 linux-can@vger.kernel.org, Yibo Dong <dong100@mucse.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Petr Machata <petrm@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>, brcm80211-dev-list.pdl@broadcom.com,
 GR-Linux-NIC-Dev@marvell.com, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Leon Romanovsky <leon@kernel.org>, Denis Benato <benato.denis96@gmail.com>,
 Rasesh Mody <rmody@marvell.com>, David Arinzon <darinzon@amazon.com>,
 oss-drivers@corigine.com, Vincent Mailhol <mailhol@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Jian Shen <shenjian15@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Thomas Gleixner <tglx@kernel.org>, Simon Horman <horms@kernel.org>,
 Yicong Hui <yiconghui@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Johannes Berg <johannes@sipsolutions.net>,
 Heiner Kallweit <hkallweit1@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


--pa3si5htqwvg7uxg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v2 0/2] Rework pci_device_id initialisation
MIME-Version: 1.0

On Fri, May 08, 2026 at 03:34:52PM -0700, Jakub Kicinski wrote:
> On Thu,  7 May 2026 12:50:18 +0200 Uwe Kleine-K=F6nig (The Capable Hub)
> wrote:
> >   net: Consistently define pci_device_ids using named initializers
> >   net: nfp: Drop PCI class entries with .class_mask =3D 0
>=20
> There's a transient build failure between these two patches,
> you should probably reorder them?

I did build test with the first patch only, using gcc on x86 and arm64.
I guess this is about the ambiguity I mentioned in the cover letter and
maybe using clang? I'll try to reproduce and fix.

Best regards
Uwe

--pa3si5htqwvg7uxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmn+11kACgkQj4D7WH0S
/k623gf/Q5yF7db6dzmHCyOj113/GHbgzci3Yxu4CEcdvsPNimdU2fG1YgBtP6nM
r1i/YnPw6mQRQh4Qq7870HLsc/WC4sNLH9xZ3NjusUle3e5XMEkpB3mxW2hH/UzB
b0H3xhJvSgiMvib07RqvaVi8kUtsRwkCSR/2zVeSQ2EsMZxwRzV2P09lA/wTiPhB
Hxl7XbIAvVTsDMnnDW4UcyR/xqwsoEjLpTqPSymYwgE9A7kCU1/JD8EO+CNKisYk
AXjQUXekCwI/z5gR4lWMD0xqU7WtNMVfI48Bi7t3gVYPaJTnyY/z0PJuUfKvA8BP
Ar9LmlMuhzaJTsnOdLsr4fzHOJuHdg==
=2L5C
-----END PGP SIGNATURE-----

--pa3si5htqwvg7uxg--
