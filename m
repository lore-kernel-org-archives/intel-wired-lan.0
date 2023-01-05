Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F5CC3DA7A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Jan 2023 13:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD9C4607F9;
	Thu,  5 Jan 2023 13:19:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD9C4607F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1672924747;
	bh=s1J4qSU52YeAuKCVtT/6NEmX8BDx4LHUs1OQUoNLwao=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=qV8b42iFGfG1TsPIcB9g3TJ4qcMKEUYZkHHOR5HnhMJj6V0KD1ITk82pQJZKpjiqZ
	 m9SFHPYyIXvBBQ/SNq/QUUBTKF8HMCmvZvj2RuHLN/+ClWJXfuS0aHF6BbEAmUgGF0
	 FvKN1ofFBEA1kd06Ziuue5SXiyeolmYCTXQiF5Z401SzBw46io8thHDigelRG7Yr+b
	 y9aEg6UvWtV7avrUj5G3RWwI0dVfROjSzMp6cSAsYS7AW/XhISTAYdcx/xR7DFIlXC
	 sRPjTT4b6CbMRo/WAIw87yiu6BCIKPV+KtPWu1v+rKgM+Oic3oL2rrZE4BJDqc2p3g
	 ih6eaVKbRG4LQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQvWp_ZzmbTU; Thu,  5 Jan 2023 13:19:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA69760804;
	Thu,  5 Jan 2023 13:19:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA69760804
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 06D9B1BF409
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Jan 2023 13:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D530340C2F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Jan 2023 13:19:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D530340C2F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id knjaB9Rejlbw for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Jan 2023 13:19:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E8CC40125
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E8CC40125
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Jan 2023 13:19:04 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9D9E561A01;
 Thu,  5 Jan 2023 13:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFB7C433EF;
 Thu,  5 Jan 2023 13:19:02 +0000 (UTC)
Date: Thu, 5 Jan 2023 15:18:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Mateusz Palczewski <mateusz.palczewski@intel.com>
Message-ID: <Y7bOQoFJQUhsB1kC@unreal>
References: <20230105120518.29776-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230105120518.29776-1-mateusz.palczewski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1672924743;
 bh=oeiqTX+YktoVuCEksUYADqphwlZpszjcAzOZO0MUgZU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a6mlhy57XL4NNdsfanSq8y9rXhWOQTlnSPehyeCmIZ+/cmcDmQliInZEyi2t7syr1
 qan+Kt132Hwei+/NPSla1LoVHJSAEWi9zXfQd+x9KLqrwC4Pip+0XBStSdgu3/VdAJ
 kBElWcf4WFdaISl8v6Xo3FxS/OCwTAHIAJ9xSQ1jB43hB6mEvNdVH7yflG108qTyxG
 C7jLnzNJyn0dNZ3pY9ZaUdcwkIIPabzzE1U7+HMid1pkMRO5plNpTJrXmrHvPKHuzf
 WlSAv1qIgwZlJl+S1RZPSd497E0hmODfbijcjD0/LiYWiXoljpbhr5LTPPsVggeTIn
 r3A96+7j7V+6Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=a6mlhy57
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: Fix deadlock on the
 rtnl_mutex
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jan 05, 2023 at 07:05:18AM -0500, Mateusz Palczewski wrote:
> There is a deadlock on rtnl_mutex when attempting to take the lock
> in unregister_netdev() after it has already been taken by
> ethnl_set_channels(). This happened when unregister_netdev() was
> called inside of ice_vsi_rebuild().
> Fix that by removing the unregister_netdev() usage and replace it with
> ice_vsi_clear_rings() that deallocates the tx and rx rings for the VSI.
> 
> Fixes: df0f847915b4 ("ice: Move common functions out of ice_main.c part 6/7")
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v2: Fixed goto unwind to remove code redundancy
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 35 ++++++++++++------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 

I think that it will be beneficial to have lockdep trace in commit message too.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
