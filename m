Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013AFC4828F
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Feb 2024 20:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78AEC41612;
	Sun,  4 Feb 2024 20:09:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78AEC41612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707077350;
	bh=ouVZksEXK/xMPgXsQ/OT9ohmeeL5dL9MmZKGpPPQFb0=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=UU5bfpwmg1TegQMVm5THFL7T1iAKqPPGFSDgZ3+lDaW78iruJrsYgjfMjtG596ltB
	 vBr0HhxNXCmyUoWoWsSY6Pk+yBWnAUiVXQRZq9wmWzEmI9gIcuywrjupNzL5ZUUYIh
	 nFp5a4gWkP4OjQrvdVteOnKBI7/sYIWfWZ16gMA7zEJ5JurQCFwUK11TLTiYaxlAJS
	 0cFUYVHOZUVmpweH5HOK44MbBpRDIOnDigjjHSaoLoStwvI8fxCKc4arf33Drx+7NM
	 pGfFiLR9zyx7tHNbdDybp//7b4dstwAzrB0CQ00L+viR9xDMKrk2XgFxdqSLhJQ7YT
	 C4Xrk6+lePwaQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sCm89Gd8OPKj; Sun,  4 Feb 2024 20:09:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A072C416B7;
	Sun,  4 Feb 2024 20:09:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A072C416B7
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id ACFED1BF425
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Feb 2024 20:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 783B240974
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Feb 2024 20:09:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 783B240974
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Leoj-G_lMxWz for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Feb 2024 20:09:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3751F4022F
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Feb 2024 20:09:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3751F4022F
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="304425"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="304425"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2024 12:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5185667"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.124.132.248])
 ([10.124.132.248])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2024 12:08:59 -0800
Message-ID: <2b2029bd-083f-444f-ab55-ac63827a9f5e@linux.intel.com>
Date: Sun, 4 Feb 2024 22:08:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20240124085532.58841-1-kurt@linutronix.de>
 <20240124085532.58841-4-kurt@linutronix.de>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240124085532.58841-4-kurt@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707077345; x=1738613345;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=iAxMkmIBEx6JRTOgplejPllumoRaDR5CtoZ4eNtC3bc=;
 b=AsQ87Mi9pINtRQ2p3EX/rgtZMWdD55RirzmVNuIoSrjhCpeVcZ06Nnbw
 L+gYJ+uYJ86scNmJOFv57KkSFpwhi1zkNk3oa40SA9rzIeKaHfZ3rpdPt
 x58nQep87W7KTyEnVa3ywtXkDI7GR1+77Hri5hGUObe8mMYN+5Cx6J/wf
 GOJgNwZoA7sRk5PJY5trfyyqVU24OvnmlsTF0w/IDvQUYh8FqHdYC29/s
 Biw1roptblwnlGADZAUVOwmp0O3t0LaNbwjzEuDtC0vrQUQa4lpE1cagJ
 tr/O/0n6kR4dgt9n7Szq893bucqoJmCQrl5CMXUgtHcESecT8k6BE9mM/
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AsQ87Mi9
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 3/3] igc: Unify filtering
 rule fields
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
Cc: netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 1/24/2024 10:55, Kurt Kanzenbach wrote:
> All filtering parameters such as EtherType and VLAN TCI are stored in host
> byte order except for the VLAN EtherType. Unify it.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         |  2 +-
>   drivers/net/ethernet/intel/igc/igc_ethtool.c |  4 ++--
>   drivers/net/ethernet/intel/igc/igc_main.c    | 10 ++++++----
>   3 files changed, 9 insertions(+), 7 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
