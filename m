Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88106F43854
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Apr 2026 16:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39E2180CA8;
	Wed, 15 Apr 2026 16:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WEPRAxckTaT3; Wed, 15 Apr 2026 16:30:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B561780C93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776270613;
	bh=G1fnCBFOTz/a0YjDGgfv3ZYvqKBOgOLHiSmFptchnCA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=81i5YBX6+M6wKkj1w/V6QylHKclMX+8ewYttgCNaURQ+mOc2o987UMZrv26PpngCy
	 eHMGtcFO5w4hj6JOGUywejwE5wpcHweIx7s01tEnNvLQ0sjyVMnJnIOGcjBRJaaC1c
	 ovjAeBhc315/t3h0mM4H8gq2N0su9EI6//hPHlPNDDN5j3vslAKxNb9FfhHOqIngmJ
	 Z0JarwtAgpnaKDfkUI4zbSsD/B6PR8IurZUyGRMNUMaXSGHhBsjWq561jvXyrUL8UT
	 md2NH6StRfRKHWFJDuz0k5JAfW0Xy2cm2NtzNuulQ4ZFOqJbeuUTRJQ8ZhmUJ4UbAZ
	 NGEzbjFNzujSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B561780C93;
	Wed, 15 Apr 2026 16:30:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D455375
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 16:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 638EF402BB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 16:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B5uvkGytOAu8 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Apr 2026 16:30:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 86E3E402AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86E3E402AE
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86E3E402AE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 16:30:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B5328600AE;
 Wed, 15 Apr 2026 16:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17446C19424;
 Wed, 15 Apr 2026 16:30:05 +0000 (UTC)
Date: Wed, 15 Apr 2026 17:30:03 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Dave Ertman <david.m.ertman@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 jacob.e.keller@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Message-ID: <20260415163003.GP772670@horms.kernel.org>
References: <20260413191420.3524013-1-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413191420.3524013-1-poros@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776270609;
 bh=fniF0iwOu4pkgMWiGbwhBeBWmR/o5IjyUb8gyW4Vgwk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g9PWKMrZi+xJ6h43sHHkddcGBm1Iy9E5DBTRIBFEGOR+WHCVpS5B5vj0RrJIdg3iv
 qzyWhNuvYFH0oCv3WGTyA1gYhd8ZBjKxNf4ieil6zB1s9DH0XxAIjVvIxoei9XZKOo
 olShtrjMVb29k+8BNnhLP5xlxFl4MNJxF05gG2tlffmF0ezLeZpBsZX3wU4m+pZ4Bi
 tKMvN5KAbT/apig496Wy0mrM70R14brxktFLHqryduHmfLl81zvPgmv1tPoOTs6EYi
 F2II7AuwqcrlPtGW4KYV85yLrhE6WbtBLljgzOCJdkou4RuSv8GdOoRib5x4ke5cfa
 goyP4i4nZ46YQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=g9PWKMrZ
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix infinite recursion
 in ice_cfg_tx_topo via ice_init_dev_hw
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Apr 13, 2026 at 09:14:20PM +0200, Petr Oros wrote:
> On certain E810 configurations where firmware supports Tx scheduler
> topology switching (tx_sched_topo_comp_mode_en), ice_cfg_tx_topo()
> may need to apply a new 5-layer or 9-layer topology from the DDP
> package. If the AQ command to set the topology fails (e.g. due to
> invalid DDP data or firmware limitations), the global configuration
> lock must still be cleared via a CORER reset.
> 
> Commit 86aae43f21cf ("ice: don't leave device non-functional if Tx
> scheduler config fails") correctly fixed this by refactoring
> ice_cfg_tx_topo() to always trigger CORER after acquiring the global
> lock and re-initialize hardware via ice_init_hw() afterwards.
> 
> However, commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end
> of deinit paths") later moved ice_init_dev_hw() into ice_init_hw(),
> breaking the reinit path introduced by 86aae43f21cf. This creates an
> infinite recursive call chain:
> 
>   ice_init_hw()
>     ice_init_dev_hw()
>       ice_cfg_tx_topo()         # topology change needed
>         ice_deinit_hw()
>         ice_init_hw()           # reinit after CORER
>           ice_init_dev_hw()     # recurse
>             ice_cfg_tx_topo()
>               ...               # stack overflow
> 
> Fix by moving ice_init_dev_hw() back out of ice_init_hw() and calling
> it explicitly from ice_probe() and ice_devlink_reinit_up(). The third
> caller, ice_cfg_tx_topo(), intentionally does not need ice_init_dev_hw()
> during its reinit, it only needs the core HW reinitialization. This
> breaks the recursion cleanly without adding flags or guards.
> 
> The deinit ordering changes from commit 8a37f9e2ff40 ("ice: move
> ice_deinit_dev() to the end of deinit paths") which fixed slow rmmod
> are preserved, only the init-side placement of ice_init_dev_hw() is
> reverted.
> 
> Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
> Signed-off-by: Petr Oros <poros@redhat.com>

Hi Petr,

I don't intended to delay this patch.
But could you follow-up by looking over the AI generated
review of this patch on sashiko.dev?

Thanks!
