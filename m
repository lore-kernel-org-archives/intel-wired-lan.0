Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447A5FF886D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Apr 2026 20:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2A9441EAB;
	Tue, 28 Apr 2026 20:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cp7_mg09oik9; Tue, 28 Apr 2026 20:08:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AFDE64101C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777406900;
	bh=iRxzu9RmmpZ7pX5zdGly9rKj0q1oCfBMxB/0kO0YbvI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dBBiZ98aM4BAA5t8M1uKvEMvDzr92E/aX0v9XxyHnqL0AGeakBCsUwFnIb7OnjfO+
	 92ZnZ5uo4bvh7hwIuaDDXWnlFvn9HxalIXbT6aOS2QxsRZB4TzkilD/RwrK6tt5kx/
	 UsvHycz/5VKqZd17Vq48M7VxMBMtBi0tzOUjZj6Ui84Z+/qzBc/WQ0KtygRLBKCMBh
	 hGmHb/MHytDvgXCFRDMmUgORv+NVPwppQoiy99eR8WHfxe6OX9x2TL1hjdzvQr4Dta
	 CTD3SHcmx0lf9UTayQ4lgoqmquBMDep9vQbu6cc7AEPrCAlrFMpwiVahXOwliEBbbP
	 Q90Q0z69AOWYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFDE64101C;
	Tue, 28 Apr 2026 20:08:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CEC041B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 20:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4E914101C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 20:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BmpgJfctN4MN for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Apr 2026 20:08:18 +0000 (UTC)
X-Greylist: delayed 1923 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 28 Apr 2026 20:08:16 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03FAA4057B
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a01:4f8:242:246e::2;
 helo=sipsolutions.net; envelope-from=johannes@sipsolutions.net;
 receiver=<UNKNOWN> 
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:242:246e::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03FAA4057B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 20:08:16 +0000 (UTC)
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.2) (envelope-from <johannes@sipsolutions.net>)
 id 1wHoD6-0000000154Q-0Yr2; Tue, 28 Apr 2026 21:35:08 +0200
Message-ID: <54d6fd70b123bf7c158e8e97817b0b3a033205b2.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= "(The Capable Hub)"	
 <u.kleine-koenig@baylibre.com>, Michael Grzeschik
 <m.grzeschik@pengutronix.de>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol	 <mailhol@kernel.org>,
 Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 28 Apr 2026 21:35:05 +0200
In-Reply-To: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
 (sfid-20260428_191919_544927_6ED8AE93)
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
 (sfid-20260428_191919_544927_6ED8AE93)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=iRxzu9RmmpZ7pX5zdGly9rKj0q1oCfBMxB/0kO0YbvI=; 
 t=1777406897; x=1778616497; b=fXCN/KlqDK+4nfH2/Er/fy/x09nHwgh7TpwZoWq5NCph7Of
 pI1XEJ3ddAZzeZ+lwIO9GueJwVbx5xuoFO1CkSJYCztF7NVs9l+2fO/8byvWPVEDOyRUL60/MOVBf
 Suhzz1BZOLMMrZJQnwP7kOs2hh9RcnayB1f84TR1VSm27yOa8MynqvSpupcmQa9vBU1ySPAbSWEbq
 3lkGtrcJdAQqKZjicxG2fvHYPlV6DcYsfgxVLDBC53c4HDLZi++3TGtq4TOV3y96rqRkXqENjt43y
 WwWdDDafwKwonBHu3boIB63GQNyP6D8OnD7ow3IXn8JTE1wKfQnD6lPN/SsMUWYA==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; dmarc=permerror
 header.from=sipsolutions.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net
 header.a=rsa-sha256 header.s=mail header.b=fXCN/Klq
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
 Yonglong Liu <liuyonglong@huawei.com>, Kees Cook <kees@kernel.org>,
 linux-wireless@vger.kernel.org, Larysa Zaremba <larysa.zaremba@intel.com>,
 brcm80211@lists.linux.dev, Daniele Venzano <venza@brownhat.org>,
 oss-drivers@corigine.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
 MD Danish Anwar <danishanwar@ti.com>, Samuel Chessman <chessman@tux.org>,
 Fan Gong <gongfan1@huawei.com>, Marco Crivellari <marco.crivellari@suse.com>,
 Kevin Curtis <kevin.curtis@farsite.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Ion Badulescu <ionut@badula.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Colin Ian King <colin.i.king@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Peiyang Wang <wangpeiyang1@huawei.com>,
 Thomas Fourier <fourier.thomas@gmail.com>,
 Sai Krishna <saikrishnag@marvell.com>, Denis Kirjanov <kirjanov@gmail.com>,
 intel-wired-lan@lists.osuosl.org, linux-parisc@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>,
 Steffen Klassert <klassert@kernel.org>,
 Stanislav Yakovlev <stas.yakovlev@gmail.com>, linux-rdma@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>, nic_swsd@realtek.com,
 Jiri Pirko <jiri@resnulli.us>, Philipp Stanner <phasta@kernel.org>,
 Chi-hsien Lin <chi-hsien.lin@cypress.com>, Ido Schimmel <idosch@nvidia.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>, Double Lo <double.lo@cypress.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Nathan Chancellor <nathan@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, Bjorn Helgaas <bhelgaas@google.com>,
 Zilin Guan <zilin@seu.edu.cn>, linux-can@vger.kernel.org,
 Yibo Dong <dong100@mucse.com>, Joe Damato <joe@dama.to>,
 Petr Machata <petrm@nvidia.com>, Kory Maincent <kory.maincent@bootlin.com>,
 brcm80211-dev-list.pdl@broadcom.com, GR-Linux-NIC-Dev@marvell.com,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Manish Chopra <manishc@marvell.com>, Denis Benato <benato.denis96@gmail.com>,
 Rasesh Mody <rmody@marvell.com>, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Mark Bloch <mbloch@nvidia.com>,
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 Yeounsu Moon <yyyynoom@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 Simon Horman <horms@kernel.org>, Yicong Hui <yiconghui@gmail.com>,
 Mark Einon <mark.einon@gmail.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 2026-04-28 at 19:18 +0200, Uwe Kleine-K=C3=B6nig (The Capable Hub)
wrote:
>=20
> I handled all of drivers/net/ in a single patch, please tell me if I
> should split by subsystem.

I guess wireless would be the one not in net-next initially normally,
but

>  .../broadcom/brcm80211/brcmfmac/pcie.c        |  17 +-
>  drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  52 +-

Nobody has been touching *that* code, so from my perspective this is
fine.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes
