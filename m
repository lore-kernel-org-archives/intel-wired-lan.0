Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1C5C7EE2F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Jun 2023 22:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EEC4C4053C;
	Mon, 12 Jun 2023 22:43:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EEC4C4053C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686609817;
	bh=Ffqr8iF/It5BSuzDZYO5gIx4MceTN1svI8TtXJad06I=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=g0g3akA+DDjgtwB1REI6n+U9Q6IqZW0t4XraCnZEzIMFPpH9jeZtMy84Rokqjuei8
	 oPf7p7zra0ZOev1jzzODgRlVXD4a94zNQw+2eN5jX1jIRjevXmJyXMxE1oDKDY9Y91
	 OzAo0Zp3hwX17w3xjoFGyToRgLEcxn1BXs/BW0ghoh1aRq/fx4vS56yGRLdBQ3ZRuf
	 Hojv6tH3rnRQuuhMZOXzHuAmxhXiap+oETG3FE5UaHTvVC1V4hkzAIyO6Ta8KQzao+
	 kfaUBV5gVrnKu7NC+zI8ZOP1oFugFA9YNZ/Y8t/RRO8kU/23u+cNwz1O7noAZs29mx
	 gKYieelYktGSA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id blrQErBRf7oc; Mon, 12 Jun 2023 22:43:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0CB5C405AB;
	Mon, 12 Jun 2023 22:43:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CB5C405AB
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 21B2F1BF3C8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jun 2023 22:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED907813C7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jun 2023 22:43:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED907813C7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Af92XS8cLp89 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Jun 2023 22:43:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3EE1C813A8
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EE1C813A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jun 2023 22:43:34 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 85E1961EA1;
 Mon, 12 Jun 2023 22:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8A3C433D2;
 Mon, 12 Jun 2023 22:43:30 +0000 (UTC)
Date: Mon, 12 Jun 2023 15:43:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Message-ID: <20230612154329.7bd2d52f@kernel.org>
In-Reply-To: <20230609121853.3607724-2-arkadiusz.kubalewski@intel.com>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-2-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1686609812;
 bh=JBnyaSL01ZIaD9BxSHKCygGU9ZOWddzqcQnjN+ViNR8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Y+dhwf2/ZroIxTkGwW0S2KpBpLyAmhnEDkWq8yrVJBaUmeNTM8chFq3gJGGAI9AJP
 hgMI//H1pDJ47odAmSs2mBJR2CpDMQqiviylWQF8wWxOJvSni8Y4Mbh8LAXR20OxcU
 6Xhm7nJrbOoj0l2hV0O/MUopYZQ1jj1VgkAFYT0F1CwVg2T3QOmJFlDXbUzMR92E5X
 HVXSZcqxVSq0xilwvIoplXESzJcetA9CXlCXMguI3cKCaAJndPxDEi39UqHgpoH0EV
 /yv/QVyVJVoJr2TdG4igeCfEZUJjvTah3/P2T8uGRxR2wSkfztSfGPM1HFOARQ6xzL
 L/1Gs8PyRFmiw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Y+dhwf2/
Subject: Re: [Intel-wired-lan] [RFC PATCH v8 01/10] dpll: documentation on
 DPLL subsystem interface
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
Cc: geert+renesas@glider.be, mst@redhat.com, razor@blackwall.org, phil@nwl.cc,
 javierm@redhat.com, edumazet@google.com, benjamin.tissoires@redhat.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 lucien.xin@gmail.com, leon@kernel.org, corbet@lwn.net,
 linux-rdma@vger.kernel.org, masahiroy@kernel.org, linux-doc@vger.kernel.org,
 jesse.brandeburg@intel.com, vadfed@meta.com, intel-wired-lan@lists.osuosl.org,
 airlied@redhat.com, vadfed@fb.com, pabeni@redhat.com,
 ricardo.canuelo@collabora.com, jiri@resnulli.us, arnd@arndb.de,
 idosch@nvidia.com, richardcochran@gmail.com, claudiajkang@gmail.com,
 kuniyu@amazon.com, jacek.lawrynowicz@linux.intel.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, linux-arm-kernel@lists.infradead.org,
 axboe@kernel.dk, sj@kernel.org, vadim.fedorenko@linux.dev, linux@zary.sk,
 gregkh@linuxfoundation.org, ogabbay@kernel.org, nipun.gupta@amd.com,
 linux-kernel@vger.kernel.org, andy.ren@getcruise.com, tzimmermann@suse.de,
 jonathan.lemon@gmail.com, saeedm@nvidia.com, davem@davemloft.net,
 milena.olech@intel.com, hkallweit1@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri,  9 Jun 2023 14:18:44 +0200 Arkadiusz Kubalewski wrote:
> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> Add documentation explaining common netlink interface to configure DPLL
> devices and monitoring events. Common way to implement DPLL device in
> a driver is also covered.

> +``'pin': [{
> + {'clock-id': 282574471561216,
> +  'module-name': 'ice',
> +  'pin-dpll-caps': 4,
> +  'pin-id': 13,
> +  'pin-parent': [{'pin-id': 2, 'pin-state': 'connected'},
> +                 {'pin-id': 3, 'pin-state': 'disconnected'},
> +                 {'id': 0, 'pin-direction': 'input'},
> +                 {'id': 1, 'pin-direction': 'input'}],
> +  'pin-type': 'synce-eth-port'}
> +}]``

It seems like pin-parent is overloaded, can we split it into two
different nests?

> +SET commands format
> +===================
> +
> +``DPLL_CMD_DEVICE_SET`` - to target a dpll device, the user provides
> +``DPLL_A_ID``, which is unique identifier of dpll device in the system,
> +as well as parameter being configured (``DPLL_A_MODE``).
> +
> +``DPLL_CMD_PIN_SET`` - to target a pin user has to provide a
> +``DPLL_A_PIN_ID``, which is unique identifier of a pin in the system.
> +Also configured pin parameters must be added.
> +If ``DPLL_A_PIN_DIRECTION`` or ``DPLL_A_PIN_FREQUENCY`` are configured,
> +this affects all the dpll device they are connected, that is why those
> +attributes shall not be enclosed in ``DPLL_A_PIN_PARENT``.
> +Other attributes:
> +``DPLL_A_PIN_PRIO`` or ``DPLL_A_PIN_STATE`` must be enclosed in
> +``DPLL_A_PIN_PARENT`` as their configuration relates to only one
> +parent dpll or parent pin.

Also sounds like setting pin attrs and pin-parent attrs should be
different commands.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
