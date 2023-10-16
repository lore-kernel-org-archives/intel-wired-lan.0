Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DFCCDB482
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Oct 2023 11:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07AFD41BC1;
	Mon, 16 Oct 2023 11:13:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07AFD41BC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697454791;
	bh=hDSoguWAx97GCoEliMnuAUTjPNMR2TqKAvoSeb7BItA=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kcboCqgMcDZXpQBo9L+PbI6JYsw3pPMYcfwnCJcAnDA/pwguOs5LoHCQVKJuzpFMU
	 H283QpPOM0vmv6tN+E5pdFvPAdwz1CXMmd/DQ5auaXE94FcbL1LSnZSwAfyCdGqinN
	 VrF30++OJ+7yrPqkAR6SUNO5tmnXNidrJTS8kziQXC5ud88XDU9GF/CKZ6uUboVIhL
	 CeyYrj8gb6i9TbWp5Y1fpGLg1ws1rUUMG3DjMQBqh2An4n9rakGeQTPwXZ/Q4r5c2/
	 +fGUrGjJZKU0AhIOZJ0ss/hxuVr5tYMxSPEJDATMiPzWS/rGZZt4WwOnGxiLf7nEWH
	 o3st/ZQAFAYig==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PY1hAKFvNSNx; Mon, 16 Oct 2023 11:13:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3198141BD8;
	Mon, 16 Oct 2023 11:13:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3198141BD8
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 5B2101BF3A9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Oct 2023 11:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 329F481F9C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Oct 2023 11:13:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 329F481F9C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HsRDIvdK6s60 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Oct 2023 11:13:06 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1331D81F93
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Oct 2023 11:13:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1331D81F93
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7D7B660ED4;
 Mon, 16 Oct 2023 11:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BDEC433C8;
 Mon, 16 Oct 2023 11:13:02 +0000 (UTC)
Date: Mon, 16 Oct 2023 13:13:00 +0200
From: Simon Horman <horms@kernel.org>
To: Aniruddha Paul <aniruddha.paul@intel.com>
Message-ID: <20231016111300.GK1501712@kernel.org>
References: <20231013134342.2466512-1-aniruddha.paul@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231013134342.2466512-1-aniruddha.paul@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1697454784;
 bh=LIAd5eIB7WxazbMRVYdEI0ou++tgLkv4FU4blqvs1Mc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K7kXO24MJR3Abl4R5dtCPiwxWpfmLZhFN5moKBSrzWQYaI96BMBxjpoP5EaeT/f9D
 V1JjfmVl8BHSy/bgcZs2lAg/aBIzl5d4VFM6708PMLWsQ88Hu4WbqnySrmrPEsZU7A
 qpe1pSUSPz1G9zUFs0iwDNHIvG9s4e9hklUcqYL7P2Ck2RbVp9HDZMXi+B25wmzJux
 IDklju0MfxQsI5ShXFU7hxwqCicPH27eE1GxqvsipUujX4c9Kp3U2NDh864M9U9wV7
 ZhRXOZAqyklV53kZnufABTDsqdXhfoK9D0/J42I1AC+2iT3xnXjZ9grlQgMvnQ2NiG
 1OdPFeqXfwDLg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=K7kXO24M
Subject: Re: [Intel-wired-lan] [PATCH iwl-net,
 v3] ice: Fix VF-VF filter rules in switchdev mode
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
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, marcin.szycik@intel.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Oct 13, 2023 at 07:13:42PM +0530, Aniruddha Paul wrote:
> Any packet leaving VSI i.e VF's VSI is considered as
> egress traffic by HW, thus failing to match the added
> rule.
> 
> Mark the direction for redirect rules as below:
> 1. VF-VF - Egress
> 2. Uplink-VF - Ingress
> 3. VF-Uplink - Egress
> 4. Link_Partner-Uplink - Ingress
> 5. Link_Partner-VF - Ingress
> 
> Fixes: 0960a27bd479 ("ice: Add direction metadata")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Aniruddha Paul <aniruddha.paul@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
