Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AE0C00140
	for <intel-wired-lan@archiver.kernel.org>; Sun, 31 Jul 2022 05:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E363582BA7;
	Sun, 31 Jul 2022 05:34:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E363582BA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659245645;
	bh=G321hccGhTQCAIcF7iQhE9IJzpIxk3qpYhWFzhTQxWE=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VCwwg0gnohqrmmiw+QF9TBfsUDGSi8ti5ybXk0+D6jqxUWbHoZWTbHW1HAmEv3s/n
	 OmPCXZ6jEqz4oru4l31cL4chppYJQJcEOhQ2CxsozyKu5jRcU8Zv3RDn/mqXyZndta
	 QTivNud7lfrkLrFk7iGlrXGsfEcvjTJ48C/BJaNV1vH8n6dQVL5bTZL1Q4ssl8nTn5
	 qf6PF5+OLJZbQkltQQRli8k6T3LLr79CJLTk/OcWNCMfK6pJi7PP/bRrZdh4mxquYB
	 8lh8VrXVAblCFVR54dc352SlzoP8ruCv1EFiFdC7vlQ0+yXGstKn+E4cX0TP+kXI0t
	 IZ4D2bdV5beyg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03wa0m-8sCak; Sun, 31 Jul 2022 05:34:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8C0982E14;
	Sun, 31 Jul 2022 05:34:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8C0982E14
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 3653F1BF377
 for <intel-wired-lan@lists.osuosl.org>; Sun, 31 Jul 2022 05:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 100A360BBE
 for <intel-wired-lan@lists.osuosl.org>; Sun, 31 Jul 2022 05:34:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 100A360BBE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cAasJfbNg571 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 31 Jul 2022 05:34:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9208360B43
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9208360B43
 for <intel-wired-lan@lists.osuosl.org>; Sun, 31 Jul 2022 05:34:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="287726191"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; d="scan'208";a="287726191"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2022 22:34:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; d="scan'208";a="660746522"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.74])
 ([10.13.12.74])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2022 22:33:59 -0700
Message-ID: <ad6e8731-a6af-71f5-c7ea-fedf6d815fe2@linux.intel.com>
Date: Sun, 31 Jul 2022 08:33:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Sasha Neftin <sasha.neftin@intel.com>, intel-wired-lan@lists.osuosl.org
References: <20220726143625.2691487-1-sasha.neftin@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20220726143625.2691487-1-sasha.neftin@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1659245642; x=1690781642;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=STbPjh+Zk/NI5acJnUD+W1cMHzYjU9GiwIzm0QVbtHs=;
 b=P9sYMH7ndKBmtaHNVECF/5qisnBSujxi/qr84cu9g0+5GwaMGhQ10w3m
 hlVt/Wi8+wD0k1igQpljLUUMGeMbg9OUETQJ3GEg1P+uC20CLTC2gFZMy
 7VNEoJclCZ0zomc+DGHlNk7wi+jvpe01PUUIro7IuahrBBQluenANE549
 ckFiqdJuE4qSiwt2vvnlFSHLtvF+5AJWtdzy68fTyzhMnoH/I4OkWa0Z3
 2QlwU8i9BxXLlFgxA6KQI6ahGLjrzVnh+//XtyKtYtenljgEAl8buQao/
 gYCXx5Ri8V54O8uX0rsC/hMBUyHrAdZfNBSfBuL7d9PatrBbOQck1Jv/v
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=P9sYMH7n
Subject: Re: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Separate MTP board
 type from ADP
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 7/26/2022 17:36, Sasha Neftin wrote:
> We have the same LAN controller on different PCH's. Separate MTP board
> type from an ADP which will allow for specific fixes to be applied for MTP
> platforms.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/e1000.h   |  4 +++-
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 20 ++++++++++++++++++++
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 17 +++++++++--------
>   3 files changed, 32 insertions(+), 9 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
