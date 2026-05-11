Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C82CD37B5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 May 2026 09:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63DAA810A5;
	Mon, 11 May 2026 09:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ykp6xm4skWR; Mon, 11 May 2026 09:21:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F36028233F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778491306;
	bh=yTA3EfMFNqWtw4mwbSh1QoSBedE1rcjpYMGPIfcrLnU=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=y78sfYfCbcqHNNesvEW4x8WACHHg07btQIkgsQCm9nX7vOOMaAf1Y0yJGFU9b2lOk
	 zG2MgBTLBUHKRAaWvkcu5ghwuLR7ZrxJQVGbCMsYbf/v7J8WNW+lD44RVzZOqhIfGl
	 jI6ds8BpJgk1Lp0qjAYhsjqft5JUqqxgU19d4I2W4lSeJjpaC1VaMXRwXh6awb8Tr3
	 91BQHX4wL/f2u+jt0+1iJBTWEd+SprOumVL9Es+NOQMlyuTBdaawZcGXYvUmnP5uFu
	 LFcb+csib2dpPVZj2SyAqZI/idPBCZB0xFR9dS+ymgDDUNX2Ch3HBGw+Gd6e7n0YAO
	 9tnzajCH/PYnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F36028233F;
	Mon, 11 May 2026 09:21:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 79B77223
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 09:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B1A940328
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 09:21:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vw4VTmt-YVCE for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 May 2026 09:21:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ukleinek@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A5C034021E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5C034021E
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5C034021E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 09:21:43 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso35138295e9.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 02:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778491301; x=1779096101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTA3EfMFNqWtw4mwbSh1QoSBedE1rcjpYMGPIfcrLnU=;
 b=oCuuHGTS/Pat7OYjZ2ZvCE0OcLictSgr1v+/cvunGOvMOz6TCUwwYT05vMqWoPOQY3
 90nTzsBluCfSqYivCn+wB9WRKW/HZk7wGjIBywfRqWV0QwHMDQbo011YpRc8rPy7ohUZ
 XuS2M0Sm9QEMgyzgMRrPJaAzal4p/lQsKg3xMqEACEGw1s7RPBvU7UzO/3biL1CG30Ol
 vlMZ1SU5qdNO+JZhKQ2LikaTrusAVt/M99C2R63X4pqigf0uXIoFucx4qFZWJLzWaWmG
 fYfuXTiQu1vF44TDUEUMj5Z1t5QyR/N+I8j73IhMN0mgMUbgoTMzFAJfHnW8hf5IWsZy
 /g+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jKvRKnElvA87CJCCSuGmahes9Czy/O+58NLUJfINWbwZTr4cO7s/poyI+/BwgLL4/nu1D5FXnOQcndu2XhkQ=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzkaLsKwBGoTff4a0ApOxXBLbNawdY4DcsHJjb0Loo8j8O8F7CH
 LzJmEoLLdIwwo89YM2UZ8jpbg+oENzPIJCDrfGCelBpQdVCCCys7tfB3jYWCEYpVbhk=
X-Gm-Gg: Acq92OH01apFLLNvBeCF6YlMLZbneUmXaOT9rbD6LFCWZ9FS8kDYuo6DFlGp1KhFFdd
 zzkX46Oh4aPkAztyd0OF6Y38VgKai5yn3XrUw/7uE45Bq15c/3DVIOVe/RvtFmnziLfuy+vzq6i
 ysNam5Gcz33mEJhlOLSas2H1X/ZOMqr6Bx2Y9wzv2MILaupoRLwUmg810F/uiN40louD/WPta6Z
 WrXiw/C2OPzoC1VN686Sjl/6u/+jLHm9GfdRJELQ8z1A9wbbsCgVwaVrfFpxxjvldoows81mKMf
 f4stc/Or8H9ompDfzoJnQ+ggIRKQ9IQCJDCr4RzeQyAR1doCgnwaJ3eH/mc8tzONlYVO1COVz6M
 bUHNIJtBgsPimcCjaOABCyfHLBFoDcRdLtzYp3VJ6Kcfa63/0KalA8nBcxJwGwVGBzs1aNt8Hg7
 lPCk0y7M4v9wg+hJarxPXgLwyK/XniblA1cL+8nBcuzVjQE4V+IdG5GEbcmosCiJ+ePyHx4lbV7
 /9FOBWkwaYk9w0=
X-Received: by 2002:a05:600c:b8d:b0:489:1fa5:997f with SMTP id
 5b1f17b1804b1-48e70691673mr134646165e9.9.1778491301044; 
 Mon, 11 May 2026 02:21:41 -0700 (PDT)
Received: from localhost
 (p200300f65f114e0841c796eda31a14b3.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:41c7:96ed:a31a:14b3])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48e7041c4e8sm167443115e9.14.2026.05.11.02.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 02:21:40 -0700 (PDT)
Date: Mon, 11 May 2026 11:21:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Michael Grzeschik <mgr@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Message-ID: <agGfbyxlKC8WcEdm@monoceros>
References: <20260511090023.1634387-4-u.kleine-koenig@baylibre.com>
 <20260511090023.1634387-6-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="26wz6vcj2wzkdd5i"
Content-Disposition: inline
In-Reply-To: <20260511090023.1634387-6-u.kleine-koenig@baylibre.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778491301; x=1779096101;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yTA3EfMFNqWtw4mwbSh1QoSBedE1rcjpYMGPIfcrLnU=;
 b=mlHCRfrE79Z4QtBG4i89UI3tSPFJPBIohxQ7K9oMLX2iyBV8sS5gFPEhDEnpdFtpSk
 g23BasfOggQ2tPkDOmjESZ+5CtR9FAkwCjn3bHfQSZv4gAdqWkwCDftFeZu02nae6eL7
 hF07P+fAMRARIlhrw+HgOjQURPzBlRBSduRR035HJXTuNtRMJ0rqK9S6mUE76zLcxAfG
 LUb5gM46hjoCx21jytae+UAXcvH0VLerSMJ8zfGey/BSC6SNvjNpeORIEtMTx/Cce+E4
 g+c0jIqTHkIKsQB78t6k6AbSOV+C25zCRGz9UJu/l6bfyLEJRPAG+yJsnUrccM47TXwa
 HBog==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com
 header.i=@baylibre-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=mlHCRfrE
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 2/2] net: Consistently
 define pci_device_ids using named initializers
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
 Yonglong Liu <liuyonglong@huawei.com>, Kees Cook <kees@kernel.org>,
 linux-wireless@vger.kernel.org, Ian Lin <ian.lin@infineon.com>,
 brcm80211@lists.linux.dev, Daniele Venzano <venza@brownhat.org>,
 oss-drivers@corigine.com, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, MD Danish Anwar <danishanwar@ti.com>,
 Samuel Chessman <chessman@tux.org>, Fan Gong <gongfan1@huawei.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Kevin Curtis <kevin.curtis@farsite.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Ion Badulescu <ionut@badula.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Colin Ian King <colin.i.king@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Denis Kirjanov <kirjanov@gmail.com>, intel-wired-lan@lists.osuosl.org,
 linux-parisc@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>,
 Steffen Klassert <klassert@kernel.org>,
 Stanislav Yakovlev <stas.yakovlev@gmail.com>, linux-rdma@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>, nic_swsd@realtek.com,
 Jiri Pirko <jiri@resnulli.us>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Ido Schimmel <idosch@nvidia.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Double Lo <double.lo@cypress.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Nathan Chancellor <nathan@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, Bjorn Helgaas <bhelgaas@google.com>,
 Zilin Guan <zilin@seu.edu.cn>, linux-can@vger.kernel.org,
 Yibo Dong <dong100@mucse.com>, Petr Machata <petrm@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>, brcm80211-dev-list.pdl@broadcom.com,
 GR-Linux-NIC-Dev@marvell.com, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Manish Chopra <manishc@marvell.com>, Denis Benato <benato.denis96@gmail.com>,
 Rasesh Mody <rmody@marvell.com>, David Arinzon <darinzon@amazon.com>,
 Randy Dunlap <rdunlap@infradead.org>, Mark Bloch <mbloch@nvidia.com>,
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 Yeounsu Moon <yyyynoom@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 Simon Horman <horms@kernel.org>, Yicong Hui <yiconghui@gmail.com>,
 Mark Einon <mark.einon@gmail.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Thomas Fourier <fourier.thomas@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


--26wz6vcj2wzkdd5i
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v3 2/2] net: Consistently define pci_device_ids
 using named initializers
MIME-Version: 1.0

On Mon, May 11, 2026 at 11:00:24AM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> Forwarded: id:76da4f44d48bdde84580963862bf9616bee5c9e9.1778149923.git.u.k=
leine-koenig@baylibre.com (v2)

This is my internal marker for tracking mainline submissions. If someone
applies this revision please drop this line.

Best regards
Uwe

--26wz6vcj2wzkdd5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoBn6EACgkQj4D7WH0S
/k4q9wgAnNsetoJQuSPdcsRqTfhJ3nvDxBsfxvsce6Raf4aiAs6sa5jJlBrTa5h3
nEaIsI15hqOx2W/FeLUG3/e0pnGua3DO4qsTmtY+G74jweYDfLDdXlEHlt9zNS6x
lDrxCXGPT97KmN2CifwJILefl8Lv7jTwROdpFGiVt85DXbiZtFIL/frdeU6leU+1
FdE6JY7j/Qx1jjdXNf0bWzAYX8PJ8ocHv+b0BcV8ctfX7hsV/vxsLmUU0goDLYiO
u683/fMBDCwmEtoIHKOODM7mPIJAndSocuWgR2Fn2xqlVyooDPuS9d0p0wTjl2qT
eA7SLNWIZbT2fhIZM4FV8lAwHsMj+w==
=qcwQ
-----END PGP SIGNATURE-----

--26wz6vcj2wzkdd5i--
