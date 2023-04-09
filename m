Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9F1C77B61
	for <intel-wired-lan@archiver.kernel.org>; Sun,  9 Apr 2023 10:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7BFCC401AD;
	Sun,  9 Apr 2023 10:33:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BFCC401AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681036429;
	bh=tb/K44JDk5x1MUFKBbV/j/k4osVRUPlb/7JuqlJmbGg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=QPzSw8d3Y0773P0oM8XkjaEYKmW654w+T8KNxys1B9GkJ1wWfxugMh3oTZeY+28gg
	 NzMfhm81AxJPGrNu0Mht811uUP7o+Uvu55TJJ9zNMn2UKcSqKPuPuXwbttjTkpap7Q
	 T4z9cZTiCNBHdwVEjw07ibOvgvXqIibcHywl6CytDAhwtpswMIhOlqq6qHbuJbXSTF
	 IimTsvBiquk6mfxtRPQEYQSCbwRx9QWVJjx1/kD3P0Tk7zUe+XZms0PAiNnyOIp2qh
	 DxR+b974tBG70fjL7LlfIHRsSbZqpRjgwb0xiHo9BxFJQN764QBkvIj5/eveQtD/hW
	 zfUxu8EdTkfbg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CoS0-OHo6bGR; Sun,  9 Apr 2023 10:33:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 99186401C2;
	Sun,  9 Apr 2023 10:33:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 99186401C2
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 327E31BF30D
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Apr 2023 10:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 092DD4031C
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Apr 2023 10:33:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 092DD4031C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZRtMJNuV3vvR for <intel-wired-lan@lists.osuosl.org>;
 Sun,  9 Apr 2023 10:33:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 306C7401F6
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 306C7401F6
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Apr 2023 10:33:46 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7149660BBD;
 Sun,  9 Apr 2023 10:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C39C433D2;
 Sun,  9 Apr 2023 10:33:44 +0000 (UTC)
Date: Sun, 9 Apr 2023 13:33:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20230409103340.GJ14869@unreal>
References: <20230407165219.2737504-1-michal.swiatkowski@linux.intel.com>
 <20230407165219.2737504-2-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230407165219.2737504-2-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1681036424;
 bh=xm+3DjVWD9JGNIP9xZXESfsK9loFeRstBnM8TUlsOEY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nrlPwHRqf1DTXQSlwxJWJM+v0gQ78850OXM8kHfm7aA8e+7Wc2SCWa9PyJfs8dANc
 fljDuFRxDA9X1kVbTjkBxQs9c26Fc0tCux88p4Wv8CbWOgJvVPxOAun/8VoFuBEs76
 TpP/iHO91p1Dq20wV7/uJgI6ElS/mpup28dcXQM0xZ5j4fF+J6BkpnmT7yrQ2mDoet
 C8WOAWBKJTrPeHBE49qeUA6YI4t57RWk7i08ICTv/ZUg9m9g9WHdrYBFklWVLqob0z
 T05PgzyJVHYRR4prgS2ptBSkXs5YYxMx3v9Ic9xq4SP99UknAF9UvubcGf/a784Olz
 wrmp6WS6B9LAg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=nrlPwHRq
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/5] ice: define meta data
 to match in switch
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
Cc: pmenzel@molgen.mpg.de, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Apr 07, 2023 at 06:52:15PM +0200, Michal Swiatkowski wrote:
> Add description for each meta data. Redefine tunnel mask to match only
> tunneled MAC and tunneled VLAN. It shouldn't try to match other flags
> (previously it was 0xff, it is redundant).
> 
> VLAN mask was 0xd000, change it to 0xf000. 4 last bits are flags
> depending on the same field in packets (VLAN tag). Because of that,
> It isn't harmful to match also on ITAG.
> 
> Group all MDID and MDID offsets into enums to keep things organized.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> ---
>  .../ethernet/intel/ice/ice_protocol_type.h    | 186 +++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  11 +-
>  .../net/ethernet/intel/ice/ice_vlan_mode.c    |   2 +-
>  3 files changed, 183 insertions(+), 16 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
