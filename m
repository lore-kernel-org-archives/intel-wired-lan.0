Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E8BC001DB
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Jun 2023 15:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5247840200;
	Fri, 23 Jun 2023 15:53:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5247840200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1687535624;
	bh=r8mcfRH25KNJy3vnka7UG/khdpST+AEJ7opdPZrcGHs=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=MWukjdyZZIzCPFiWSwbRYiOdfqOxLlYSK3M54/dDvub9Nd7G3NIVKan5yqIxjLcFi
	 wJnH1PRxAgHEBj0p3cpcECglSOb7pxEBv6nBvsPxsAixRsdDF7qG7Uuj4b8fu0zG5u
	 9hBw0InXJzUtNektoyi74rmFCpL0wg2LjUP98sQ/6qoguLAKOftJCMF+QD8gCFXtZy
	 7YbrXOnS885tj9WNCO79Pgr4Lv7+D7aRDJ9NdUI0nA7wCELjyWmL5vZLA5KT+MOo/E
	 x6ZPOumn/nE09z5Vgu51xMCHm6uPlN4YX77Ny2WRYBl5UxJWwV+Tsgh9fvWopYZ7qw
	 qajNkX/FzB5rA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JlAEr3UjxlOS; Fri, 23 Jun 2023 15:53:43 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F13A40308;
	Fri, 23 Jun 2023 15:53:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F13A40308
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 486EC1BF33B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jun 2023 15:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C8D740308
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jun 2023 15:53:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C8D740308
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9XrWjaQ9LGoU for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Jun 2023 15:53:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 54BC440200
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54BC440200
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jun 2023 15:53:41 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D5D2A61A71;
 Fri, 23 Jun 2023 15:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94577C433C0;
 Fri, 23 Jun 2023 15:53:37 +0000 (UTC)
Date: Fri, 23 Jun 2023 08:53:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20230623085336.1a486ca3@kernel.org>
In-Reply-To: <ZJW37ynDxJCwHscN@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <ZJW37ynDxJCwHscN@nanopsycho>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1687535619;
 bh=LO2ZlO08aZVmvLBPdoTl7wZfWJdem3/WH71EoJNOLT0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CPKlUylbJIXpldlDEdYgOUqmxx+MdfOUA5CfZ2018ys73LdvAryMsIz4OpewSRK+j
 KG6x2V+HTnkocCO6RQNv9ixN23S/NmN/svxHFvj1I3/j7UopQ3vi3wc5Cqi8B/B2hR
 ObZimg/ux3CsntQYi3GGU0SDlBoDe50mv8YSg6fPceWtPa6kRRmhX8Z3X4yM0JvS9K
 5mS/WanIjcqtwGkXdYptKmALsi0gecaYLsgsEXLqPYgTtBxDMbtnzk+rlKZU0/wTCc
 mXGVmsGOz9ev8DLJ+6aU2b4cAXYX5rQM4eSGBnBgyGSfiRp3guqTrK21XRAYfJZQfe
 AFXvVmRRbtJuQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=CPKlUylb
Subject: Re: [Intel-wired-lan] [RFC PATCH v9 00/10] Create common DPLL
 configuration API
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
 ricardo.canuelo@collabora.com, arnd@arndb.de, idosch@nvidia.com,
 richardcochran@gmail.com, claudiajkang@gmail.com, kuniyu@amazon.com,
 jacek.lawrynowicz@linux.intel.com, liuhangbin@gmail.com,
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

On Fri, 23 Jun 2023 17:19:11 +0200 Jiri Pirko wrote:
> I don't understand. The discussion in the RFCv8 thread is still going
> on. The things I mentioned there are ignored. Like for example:
> 1) mode_set op removal
> 2) odd ice dpll locking scheme (either fix or describe why it is ok -
> 				that's the unfinished discussion)
> 3) header file bits squash I suggested. Vadim wrote that it sounds
>    reasonable, yet nothing changed
> 
> I thought we are past this. Why I have to point the same issues over and
> over?

FWIW I'm lost in the previous thread, so for me there's value in
refreshing the series.

But you're right, at the very least there should be a summary of
outstanding issues / open items / ongoing discussions in the cover
letter.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
