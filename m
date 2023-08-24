Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8C9C7EE2C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Aug 2023 15:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C8FC82893;
	Thu, 24 Aug 2023 15:20:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C8FC82893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692890446;
	bh=CQ2gsxNmAVGCThKebcNIgD/4AHsVTF3a+g5OwOe/jvg=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=J6PX1YFKxKLooMU+Q1w2pJDohsemYND/N4w1Zd0fayHIjIO6Q3zJt5yq0SEiiKB5v
	 a2Thn8JNlogUQW6C/PByQ/5K/k5t8BgGh/7fLoDQlBiKT/p3s8on6fHeUkbDWE1MRI
	 aQZDDO7hLTeKfyHXol/8nxwo9KUoi6bPhF2VR6nqOIekk9GG0Mmfg2LgIwuyWWHEsl
	 aDzO/QWMuoJdqGoYKWA3kf66eDV2ZUDik/hEqFbqm91+O/sOagE/IZwdlISaxOLNGq
	 8ooEMKRF+Gxs2zcF/QGI4LnftjdrZuwr26vY9UoX5cLgNG2wQcYr3VM6wLG9gq21Df
	 zYDuA/B1d2erw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6FMtuaMamw1n; Thu, 24 Aug 2023 15:20:45 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58BD982AF8;
	Thu, 24 Aug 2023 15:20:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58BD982AF8
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id ED74E1BF329
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 15:20:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3B1A82AF8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 15:20:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3B1A82AF8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IQ-opLBuxoJ1 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Aug 2023 15:20:41 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C12A882893
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 15:20:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C12A882893
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E351A61D29;
 Thu, 24 Aug 2023 15:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA89C433C8;
 Thu, 24 Aug 2023 15:20:39 +0000 (UTC)
Date: Thu, 24 Aug 2023 08:20:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Junfeng Guo <junfeng.guo@intel.com>, anthony.l.nguyen@intel.com,
 jesse.brandeburg@intel.com
Message-ID: <20230824082039.22901063@kernel.org>
In-Reply-To: <20230824075500.1735790-1-junfeng.guo@intel.com>
References: <20230823093158.782802-1-junfeng.guo@intel.com>
 <20230824075500.1735790-1-junfeng.guo@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692890440;
 bh=KN7cymyG/qwFVaSKXJdF2fwt9NoRwhRtC+EooIL1RaM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LcxQxcMMxhYcBZXrvmOVBb/kLifU0H6t4KXgAdXxa43pjsns5lBzc/cjsBSGrn4sT
 J1rTjc7UFZ+1IrIwMbc2DTq6wB74sCg6oJ9ULDDN6YQpxGCaLI+X7ooKpxwsp6YPuO
 zIToOrWRxaNrk8nCD5v02yPR/LOBIfgz9RkyXEAZj3MymCKghl05C896vGeKz+4cGt
 syMqZGzVwLsgEKu3S90Kipvy8AUK29iQJpfBq7GA96oIh9FVZYLqOXaZphROvBFgL/
 iVCelHScLWQpnYwb8zxhYWhGZy/nMUAi2V8kpW3evsV5XPyQ8L19KWcJisO2enw4tt
 W7GNoTAPPK/kg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=LcxQxcMM
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v8 00/15] Introduce the
 Parser Library
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
Cc: ivecera@redhat.com, netdev@vger.kernel.org, qi.z.zhang@intel.com,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 24 Aug 2023 15:54:45 +0800 Junfeng Guo wrote:
> Current software architecture for flow filtering offloading limited
> the capability of Intel Ethernet 800 Series Dynamic Device
> Personalization (DDP) Package. The flow filtering offloading in the
> driver is enabled based on the naming parsers, each flow pattern is
> represented by a protocol header stack. And there are multiple layers
> (e.g., virtchnl) to maintain their own enum/macro/structure
> to represent a protocol header (IP, TCP, UDP ...), thus the extra
> parsers to verify if a pattern is supported by hardware or not as
> well as the extra converters that to translate represents between
> different layers. Every time a new protocol/field is requested to be
> supported, the corresponding logic for the parsers and the converters
> needs to be modified accordingly. Thus, huge & redundant efforts are
> required to support the increasing flow filtering offloading features,
> especially for the tunnel types flow filtering.

You keep breaking the posting guidelines :(
I already complained to people at Intel about you.

The only way to push back that I can think of is to start handing out
posting suspensions for all @intel.com addresses on netdev. Please
don't make us stoop that low.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
