Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE4EC25B78
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 May 2024 19:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A32534174C;
	Tue, 28 May 2024 19:17:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wy1BRTSW4kpj; Tue, 28 May 2024 19:17:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08C7A406C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1716923823;
	bh=OiENsZrqJp7uTYeGdgimFwU+53g0aINVe9qMZ+35Ahs=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=5l6ezLCbHKqjUtqYRg6z3Pu9pHkRJoUKziPh1rTaWx085ZLW08GRO1hkF6AYXbCPj
	 1kO9ZT6YFuPPCjzr5gs6r4xev7lbvQjDq//v1Ixu/T3RQM4M75NJ4ZBxdy1FUL47J0
	 An9j/l2RAXm1/sIL0urMrGQRBSTupyDJepGf7wYvcvy38G90FtFIYykZ35uzG+oPsu
	 iCiTNPQF9TIW0wJuyMp5hE6XpgI5MtDmwv3FytHoPiD4H/wSDI0GvuKTeeluD+wwJF
	 /XmDxPJtqKorW7KGGiFo3EE/Ax7RMkuu6k7WfN92RFGowbP7EyLXtHfja3hrrV/xGs
	 5xBjyqF4cwROg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08C7A406C3;
	Tue, 28 May 2024 19:17:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 9323C1D2C09
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 May 2024 19:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E4FE4020B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 May 2024 19:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cbjAujYvd60g for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 May 2024 19:17:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E2298400D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2298400D0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2298400D0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 May 2024 19:17:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1BFAF623B2;
 Tue, 28 May 2024 19:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4270C3277B;
 Tue, 28 May 2024 19:16:59 +0000 (UTC)
Date: Tue, 28 May 2024 12:16:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Message-ID: <20240528121658.0bb99e8e@kernel.org>
In-Reply-To: <20240528110132.483447-1-wojciech.drewek@intel.com>
References: <20240528110132.483447-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1716923819;
 bh=U7QuO3zXX7GbfWwbA7Ahakee4jNDpsIstX+7UK/Da7M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KjwWoGpLIo/ICcdluPu+5DcAOcibQhD/yoitlw+jzalqrj2UXB97ej7EwjSJ0q9Zw
 4k/anXZ++f+By6tOpN0IXzuxwywpXPOTqzihSecsfRMqCqNvz6Och1ts3UdHH/1lCr
 p3EPfWIFRet0j1ry3iqmqotOn/dd780Rvh+6npxle+kh+Ey5Iha3Dq0/oAeoxQFvlF
 pcC3lWpJ4q+yzXMpjHTmgINCzGoGWPTz8vFYH3zss65Gznyq4KeJ0jT59YUM6rAlez
 qwQxR/YLrPx5CrXsK+AdpHr1fZOMyezWJjEvjoZyJpm+mgu7WS9lu5s0r/vko683FD
 6otUFWQmd+Q0g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=KjwWoGpL
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: Add support for
 devlink loopback param.
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
Cc: jiri@resnulli.us, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 28 May 2024 13:01:32 +0200 Wojciech Drewek wrote:
> Subject: [PATCH iwl-net v2] ice: Add support for devlink loopback param.

iwl-next, presumably

Param makes sense, although the name keeps giving me pause.
I expect "loopback" will control either port loopback or something 
like hairpin. Would "local-forwarding" not be a better name?
Not a big deal, I guess.

> +        ``enabled`` - loopback traffic is not allowed on port
> +
> +        ``disabled`` - loopback traffic is allowed on this port

The meaning seems inverted?
