Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E932F36B9B
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Apr 2026 01:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 389B682CAC;
	Fri, 10 Apr 2026 01:10:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYrkPEMQsptw; Fri, 10 Apr 2026 01:10:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B082882C84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775783447;
	bh=t247P7Tq3knyRcMQORony+MEBdGwlOjbdD1yvSDAaPM=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=RjcpeUrLaERwqWWvSMGi1F9/8JKBNU/JhdfYCV/8eL2iTKNkZZyk108UWZUhzmsov
	 Eq/xR6OJM203N8ZOsHBEnw4/w5ezvcqoyzbPGTKFzNQVNpIbvMutikkjh0iAhEt9q1
	 LwBJkXCWpV5uh2VthdKDWyAffHTZlxdtBF8Rjz3qI+ax6EPl0CJTG1oma+ilJKPEIQ
	 eM2OjNqZx+I04au7BVc56vH559JZ0D1U+WBfA32kLODD8uIfK13Y+N9oBOGhW+9fnd
	 HbUq7geLMeFKm0o5AetcmCQHVuKD31De67cDn58bl0EHODMYR4fIB4c0xw+2RZp7Mp
	 YZiIMLhhOzdPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B082882C84;
	Fri, 10 Apr 2026 01:10:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3617C194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 01:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1374F8227B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 01:10:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VS-VvNFQKwLS for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Apr 2026 01:10:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3D724821F9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D724821F9
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D724821F9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 01:10:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D33160103;
 Fri, 10 Apr 2026 01:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55413C4CEF7;
 Fri, 10 Apr 2026 01:10:42 +0000 (UTC)
Date: Thu, 9 Apr 2026 18:10:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
Message-ID: <20260409181041.395a0c37@kernel.org>
In-Reply-To: <IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
 <20260406192312.0f7a2760@kernel.org>
 <IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775783443;
 bh=bOsL/5Ai9nkE51jkRZmv54YIfdu2zvaWVlpTurET71Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=eqlNT4PPbX5lYdH6cHK1Sb/ADvhscQaQLrSaA4bf1TWnsvM1Ms0SDiNYXziLykA4Y
 YiOvTOJ1CZBsmI34XvT2jH24hf7sfroANf9GVOkSizLCn9rp4ke6E3blQKliphchlF
 j81dQzdXslxdBuAi1wY3hJsXy94yApGjSVjaZ6sxwgJYAmNJl9c4TRbJAF78vDsiSR
 giueZKc2SKTmeJf4BQ8NI63DE0NvHHfackHzGwwjUcAfvSOaVaYuVrdejxeqy7dtIQ
 T3eJdfK6qrv0Nm4MuZwGGsJ6guP6xaSzE1l0uGU+OivfzAdfGW2G8K4ApSBZhAVF8M
 V4soj1S/G6aHg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=eqlNT4PP
Subject: Re: [Intel-wired-lan] [PATCH v5 net-next 0/8] dpll/ice: Add TXC
 DPLL type and full TX reference clock control for E825
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
Cc: "Vecera, Ivan" <ivecera@redhat.com>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 "Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "horms@kernel.org" <horms@kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 9 Apr 2026 11:21:35 +0000 Nitka, Grzegorz wrote:
> > On Fri,  3 Apr 2026 01:06:18 +0200 Grzegorz Nitka wrote: =20
> > > This series adds TX reference clock support for E825 devices and expo=
ses
> > > TX clock selection and synchronization status via the Linux DPLL
> > > subsystem.
> > > E825 hardware contains a dedicated Tx clock (TXC) domain that is
> > > distinct
> > > from PPS and EEC. TX reference clock selection is device=E2=80=91wide=
, shared
> > > across ports, and mediated by firmware as part of the link bring=E2=
=80=91up
> > > process. As a result, TX clock selection intent may differ from the
> > > effective hardware configuration, and software must verify the outcome
> > > after link=E2=80=91up.
> > > To support this, the series introduces TXC support incrementally acro=
ss
> > > the DPLL core and the ice driver:
> > >
> > > - add a new DPLL type (TXC) to represent transmit clock generators; =
=20
> >=20
> > I'm not grasping why this is needed, isn't it part of any EEC system
> > that the DPLL can drive the TXC? Is your system going to expose multiple
> > DPLLs now for one NIC?
>=20
> Hello Jakub,
> For E825 device, the short answer is yes. We have platform EEC now and
> we want to add:
> - TXC DPLLs per port, and
> - PPS DPLL for TSPLL config purposes (in the near future)
>=20
> EEC (Ethernet Equipment Clock) type DPLL is designed to control multiple
> source signals (internal-NIC or external), where one drives the dpll devi=
ce,
> where multiple outputs are possible, each could drive various components
> as well as propagate signal to external devices.
> TXC is specific dpll device that associated with single ETH port to contr=
ol it's source,
> there is no need to declare any outputs as the single output is already d=
etermined.
> Basically, having TXC DPLL indicates per port control over SyncE (or some=
 external)
> clock source.=C2=A0

Could you share a diagram of how things are wired up?
DPLL can have multiple outputs and multiple inputs. I'm not getting why
a single device would have to have multiple actual DPLLs (which makes
me worried this is just some "convenient use of the uAPI")
