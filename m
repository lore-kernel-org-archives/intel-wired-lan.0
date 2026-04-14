Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05706F9D0FB
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Apr 2026 21:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8AE984E44;
	Tue, 14 Apr 2026 21:58:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3jpTdF7M5t-y; Tue, 14 Apr 2026 21:58:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6F3A84E43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776203920;
	bh=dngKVKr5z8OMkRIwgGh7J+tTe0Ax9ttXjhYDEVNvC2Q=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=JVGOavcafovSgno/b/JQLfqI+BKKAs/A6OM0CiIdNxKQGeIyPMwldeuMLLWL2wOst
	 9fmqQvD0Y0bTvryzSKJYiXV/ZId+0NhNGdUjgzr9DTfy0mRXKGbOFSHrYmiWvJ/LGo
	 5tHymjk+UOwqYKU30W9Ob/1cDoSSVp+p7IliN7m32PTzmpE6hQOCZDJMjlzE7VyhQm
	 ZcAlJohxLFxosqDahvSwz107QCWxi9UzoqsNJ7Hj/7r0VyVVdySLsgCiiRKgEaLsh4
	 qRXCpZt2QY4lTqeVSuAbHl1d+Ga8YtYG1Vfv8hSo2FbkK3LPIN0LhoJ80Eot2eixFM
	 K9a4kCw6LCaQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6F3A84E43;
	Tue, 14 Apr 2026 21:58:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE17C375
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 21:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D00D3404D9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 21:58:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QTterdwwYRxq for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Apr 2026 21:58:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 19C3B404BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19C3B404BC
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19C3B404BC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 21:58:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5266F60018;
 Tue, 14 Apr 2026 21:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5FAC19425;
 Tue, 14 Apr 2026 21:58:36 +0000 (UTC)
Date: Tue, 14 Apr 2026 14:58:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Message-ID: <20260414145835.07fbe355@kernel.org>
In-Reply-To: <IA0PR11MB737882B384AE7279EBCD05C79B242@IA0PR11MB7378.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
 <20260406192312.0f7a2760@kernel.org>
 <IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260409181041.395a0c37@kernel.org>
 <IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260410133812.4cf9b090@kernel.org>
 <IA0PR11MB737882B384AE7279EBCD05C79B242@IA0PR11MB7378.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776203917;
 bh=eE/A1HY1Is/66jFX3FEuLDx0jM8WPULiynZwxPFdYuw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AaGycWMqF2itECQyxqYFjUFW3dHR6GRwAx0BBqkWWwCe02RFgFaBe1KclsQWMKa6y
 22FZim7vYwpx8mtvgYbtKC02RUcVaV7DdLzB/h6PDUFa+9SuZoiudP/1INUeO4AhNP
 XxUDuQI0hdpglQy+RgfZc+BuL+d04pLkwwo6BY38yNdN18r3Di2qAQQAqFZAh6dbpH
 iMDXLzQdVo0hERNhykRSphEZmx0p7gAo5a3A4iKFyydOnpTxTEEhMrRjmHDYhjQWmu
 fYrGupJZMCUlUmIT/ai6S4x4IlylDTGaXJNEdRoZ8JfCvqcOSXmG9FkX03uY+3yIYF
 moV/T4obwB7Mg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=AaGycWMq
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
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "horms@kernel.org" <horms@kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "jiri@resnulli.us" <jiri@resnulli.us>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 13 Apr 2026 08:19:30 +0000 Kubalewski, Arkadiusz wrote:
>> My concern is that I think this is a pretty run of the mill SyncE
>> design. If we need to pretend we have two DPLLs here if we really
>> only have one and a mux - then our APIs are mis-designed :(  
> 
> Well, the true is that we did not anticipated per-port control of the
> TX clock source, as a single DPLL device could drive multiple of such.
> 
> This is not true, that we pretend there is a second PLL - there is a
> PLL on each TX clock, maybe not a full DPLL, but still the loop with
> a control over it's sources is there and it has the same 2 external
> sources + default XO.

Don't we put that MAC PLL into bypass mode if we feed a clock from
the EEC DPLL?

> A mentioned try of adding per port MUX-type pin, just to give some control
> to the user, is where we wanted to simplify things, but in the end the API
> would have to be modified in significant way, various paths related to pin
> registration and keeping correct references, just to make working case
> for the pin_on_pin_register and it's internals. We decided that the burden
> and impact for existing design was to high.
> 
> And that is why the TXC approach emerged, the change of DPLL is minimal,
> The model is still correct from user perspective, SyncE SW controller shall
> anticipate possibility that per-port TXC dpll is there 

We are starting to push into what was previously the domain of
drivers/clk, tho. IIUC the "ASIC PLL"s are usually integrated with
clock dividers. And cannot be "configured" after chip init / async
reset (which is why I presume you whack a reset in patch 7?).

> This particular device and driver doesn't implement any EEC-type DPLL
> device, the one could think that we can just change the type here and use
> EEC type instead of new one TXC - since we share pins from external dpll
> driver, which is EEC type, and our DPLL device would have different clock_id
> and module. But, further designs, where a single NIC is having control over
> both a EEC DPLL and ability to control each source per-port this would be
> problematic. At least one NIC Port driver would have to have 2 EEC-type DPLLs
> leaving user with extra confusion.

The distinction between TXC and EEC dpll is confusing. 
I thought EEC one _was_supposed_to_ drive the Tx clock?
What PPS means is obvious, what EEC means if not driving Tx clock is
unclear to me..

Let me summarize my concerns - we need to navigate the split between
drivers/clk and dpll. We need a distinction on what goes where, because
every ASIC has a bunch of PLLs which until now have been controlled by
device tree (if at all). If the main question we want to answer is
"which clock ref is used to drive internal clock" all we need is a MUX.
If we want to make dpll cover also ASIC PLLs for platforms without
device tree we need a more generic name than TXC, IMHO.
