Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A00EE49A4
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Aug 2023 16:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89D6A40BE0;
	Tue, 22 Aug 2023 16:53:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89D6A40BE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692723190;
	bh=3vBqZENhv56PE/xsyGjtZXrgwFcn4r+mRIfFUWhzLss=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=pJkG32lu7rUGydlZmqHYygE+G1cuIfnsKvMZHw/zlKgMiSF+Osq958XA4ShqYngZv
	 FIVXsei5Obi32ZTAPVDrfzHDXmhZ/hkZLe8ol0KFF05pPelysiE2SAVBE01L5c5uhw
	 E/MErmFPjP4/7sS5BWq8MZFniC0ms6Wf6JepOEWZBGJlqAfNysWEASrkO5b5WZNIui
	 K5RTMCjgeGWUBoYiN2mwBZItp/L5kyeJatLx/2xO2AV0eTYXJ2SJ7SDrXOjJl+wkGD
	 GZfTPVI8KQePwJwE26z2PMSm3PxEvzKgTutgLphITcSJo7SAvmc8CdzNn2a5AL7oMy
	 NmmokDOaxAhHA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1fEKhb7uHllH; Tue, 22 Aug 2023 16:53:09 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B000740BE6;
	Tue, 22 Aug 2023 16:53:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B000740BE6
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id E12071BF39D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Aug 2023 16:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B38B240BE6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Aug 2023 16:53:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B38B240BE6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SAOE-koDZ2BD for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Aug 2023 16:53:04 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4780B40BE0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Aug 2023 16:53:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4780B40BE0
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1C33461DAE;
 Tue, 22 Aug 2023 16:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E80C433C7;
 Tue, 22 Aug 2023 16:53:02 +0000 (UTC)
Date: Tue, 22 Aug 2023 09:53:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Message-ID: <20230822095301.31aeeaf2@kernel.org>
In-Reply-To: <20230822160651.GN6029@unreal>
References: <20230817141746.18726-1-karol.kolacinski@intel.com>
 <20230817141746.18726-2-karol.kolacinski@intel.com>
 <20230819115249.GP22185@unreal>
 <20230822070211.GH2711035@kernel.org>
 <20230822141348.GH6029@unreal>
 <f497dc97-76bb-7526-7d19-d6886a3f3a65@intel.com>
 <20230822154810.GM6029@unreal>
 <8a0e05ed-ae10-ba2f-5859-003cd02fba9c@intel.com>
 <20230822160651.GN6029@unreal>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692723182;
 bh=1PCdFDvVtS6q1aCDOFe7QTda6W7MpcZ2xfJ2LZ9QIbY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VfIluj/XOmj1Vo69xYyBpbO8ovsot7Y2I00bnwHpW22TsutWjNv0r750auv12htnQ
 TmZjDj9nY9UWNXqy91kp07O+qeYDKnWuH/GkIJN8+Dd63fiqFi2ohgtkl209VuZfuJ
 H6HNnU3iBfJ1o4PIzwEWnmtLhO9dCTWYWJ3eVBTCLuH8ozT7UrtKkwvrWNVbq0efr/
 +zOAQjYgQI+COo0N65Rnm4jbkr6wKIiC3SSEzdlEDd+OG4WviFNsXMCgeSPoCNmSxo
 ZJKkzxbjpdstG1nj+ABUAmJbFMpGlbE1KxKqXT1CNt4uOEtcFdCAbXj19VoRYus6Mx
 C4ex4mBwja0sA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=VfIluj/X
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 1/9] ice: use
 ice_pf_src_tmr_owned where available
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jiri Pirko <jiri@nvidia.com>, jesse.brandeburg@intel.com,
 Karol Kolacinski <karol.kolacinski@intel.com>, anthony.l.nguyen@intel.com,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Saeed Mahameed <saeedm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 22 Aug 2023 19:06:51 +0300 Leon Romanovsky wrote:
> Can I suggest change in the process?
> 1. Perform validation before posting
> 2. Intel will post their patches to the netdev@ ML.
> 3. Tony will collect reviewed patches from netdev@
> 4. Tony will send clean PRs (without patches) from time to time to
> netdev maintainers for acceptance.
> 
> It will allow to all of us (Intel, Nvidia e.t.c) to have same submission
> flow without sacrificing open netdev@ review which will be done only once.
> 
> Jakub/Dave, is it possible?

That sounds worse than what they are doing today. And I can't help
but think that you're targeting them because I asked you to stop posting
directly for net-next. Vendetta is not a good guide for process changes.

Let's see what the 6.6 development stats look like. Then we'll have
a discussion about what we can improve.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
