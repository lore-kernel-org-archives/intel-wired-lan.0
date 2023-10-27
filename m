Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16C4C27C47
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Oct 2023 23:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CE7860648;
	Fri, 27 Oct 2023 23:44:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9CE7860648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1698450242;
	bh=knWOvpvyq0xPIyx99dXbxw8vuEnkjY/e8g61mNB85gc=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AnONYB2mYIcURjsTC/hOtjebTEnInxOMTVSAtZyzx4JE97DTikuxrCM9sB7xDE+fS
	 v25X/1MkFe0nQr8LQGfKgvOofk8QM8vWa2rV++beqiTSzpH9gpctK/lZJ8eVxxLnMz
	 +6t1EkPDf4rJZwZ+rV1icO3CgVifufdL0rNP0LTRETzlJKc0VneBVijN/pP3RZbZh0
	 dipYw4uBmyEpQCpZmjbaRZVmxaLXRJpbvfPXhTaW9sStHL+kNpnAIhhrETxDk+fO33
	 UkqGKjnwt3wCSuMhvoBes7OCrVyyuajwhBYDD06RNGDuAmheC31BmH2cnEyo/dRvVZ
	 GGXyKsK+l2UnA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eM_ZeWY9PpNQ; Fri, 27 Oct 2023 23:44:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8BF760655;
	Fri, 27 Oct 2023 23:44:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8BF760655
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 3095E1BF4E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Oct 2023 23:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 068BD400EC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Oct 2023 23:44:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 068BD400EC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EmsDzm4eFR_Q for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Oct 2023 23:43:59 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD323400EA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Oct 2023 23:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD323400EA
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qwWTx-000NpJ-BL; Sat, 28 Oct 2023 01:43:13 +0200
Date: Sat, 28 Oct 2023 01:43:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Stitt <justinstitt@google.com>
Message-ID: <8ca4ba13-1bcf-4c7b-91b6-8c77fbe55b30@lunn.ch>
References: <20231027-ethtool_puts_impl-v3-0-3466ac679304@google.com>
 <20231027-ethtool_puts_impl-v3-1-3466ac679304@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231027-ethtool_puts_impl-v3-1-3466ac679304@google.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=nON0cFSztiE7XcY8cFP+C7pm31K+bA5yGWUP5QJ9lns=; b=r3RDh8iDMr/m9xE7BTG70h/G40
 /0aDL9NP5016KyWfQbW3QCU45vcREym2fT3cY9k9P+t2ZoutQYyqPvPiWlKZSWoKLFvRL+dJrH27X
 nGxyvU9tY146Xp5aUDuzQVvN+Eeo2IZuvxWZ681zhAkGOwBUZCtXSaUlL381DnomFDiA=;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=r3RDh8iD
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/3] ethtool: Implement
 ethtool_puts()
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
Cc: linux-hyperv@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Ronak Doshi <doshir@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Alexei Starovoitov <ast@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Vladimir Oltean <olteanv@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
 Arthur Kiyanovski <akiyano@amazon.com>, linux-kernel@vger.kernel.org,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Louis Peens <louis.peens@corigine.com>, Wei Liu <wei.liu@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Dexuan Cui <decui@microsoft.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Noam Dagan <ndagan@amazon.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Landen Chao <Landen.Chao@mediatek.com>,
 Shay Agroskin <shayagr@amazon.com>,
 Daniel Machon <daniel.machon@microchip.com>,
 Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Hauke Mehrtens <hauke@hauke-m.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 Sean Wang <sean.wang@mediatek.com>, Nathan Chancellor <nathan@kernel.org>,
 Joe Perches <joe@perches.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Wei Fang <wei.fang@nxp.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Andy Whitcroft <apw@canonical.com>, drivers@pensando.io,
 intel-wired-lan@lists.osuosl.org, Lars Povlsen <lars.povlsen@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, Salil Mehta <salil.mehta@huawei.com>,
 GR-Linux-NIC-Dev@marvell.com, DENG Qingfang <dqfext@gmail.com>,
 Kees Cook <keescook@chromium.org>,
 =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Rasesh Mody <rmody@marvell.com>, David Arinzon <darinzon@amazon.com>,
 oss-drivers@corigine.com, Nick Desaulniers <ndesaulniers@google.com>,
 Daniel Golle <daniel@makrotopia.org>, "David S. Miller" <davem@davemloft.net>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>, Saeed Bishara <saeedb@amazon.com>,
 linux-mediatek@lists.infradead.org, bpf@vger.kernel.org,
 Dimitris Michailidis <dmichail@fungible.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, UNGLinuxDriver@microchip.com,
 Shannon Nelson <shannon.nelson@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> +/**
> + * ethtool_puts - Write string to ethtool string data
> + * @data: Pointer to start of string to update

Isn't it actually a pointer to a pointer to the start of string to
update?

> +extern void ethtool_puts(u8 **data, const char *str);

	Andrew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
