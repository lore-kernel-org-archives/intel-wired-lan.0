Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA15CC38142
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Jan 2023 11:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CE1A416EB;
	Mon, 23 Jan 2023 11:15:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4CE1A416EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674472552;
	bh=TciMvscwivctZrxLWwYImFokybAcfRPT/tgowXYLpTM=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=0qWYFWsV6C5gmNflt1lXwvt1NH/JlS3vVx9TDOqZeyo/KjRNz6kArGttsOpRhN992
	 S3OFe0scknURb9rLdtfw7kn2KqOV0tO50KUXcz9hygXvp5SgvQpEGzolYJiX2y44w9
	 oBga2GgTrv7zyzSfslfIkQ066kReLQ6ujAOTBlNrjchjnjCMrrnvU54oPhkvmt9Nb2
	 6xDKL91kWS6Co7XIeSvygps7lgg4Io9QvcPkduhXANJcBZw4/r3ZJIWRqANcl2kp2K
	 Ht3N9aYoEncIh31zz56HFSeGI7PVvzaqRsHIi4o3zPuf9mB4UbPe4HU5Pjf1+PlI5U
	 6VQ5zUGJFKeAA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h7fJ8JPPHq9g; Mon, 23 Jan 2023 11:15:49 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34060416CE;
	Mon, 23 Jan 2023 11:15:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34060416CE
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 94A411BF319
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 11:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6ED2F416CE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 11:15:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6ED2F416CE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JcCPqaUElQBG for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Jan 2023 11:15:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B0DB41697
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B0DB41697
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 11:15:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="309595487"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; d="scan'208";a="309595487"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2023 03:15:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="804055292"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; d="scan'208";a="804055292"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.3])
 ([10.13.12.3])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2023 03:15:41 -0800
Message-ID: <59a81c79-7770-7673-5ebd-d79c44824554@linux.intel.com>
Date: Mon, 23 Jan 2023 13:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Tom Rix <trix@redhat.com>, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 nathan@kernel.org, ndesaulniers@google.com, vinicius.gomes@intel.com,
 jeffrey.t.kirsher@intel.com
References: <20230114140412.3975245-1-trix@redhat.com>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230114140412.3975245-1-trix@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674472546; x=1706008546;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xCgElu63hiEX8PZSg1x7apvUzWPg+SYGm2cwSlK2h8o=;
 b=iw2QEe3VrIqP7X6fvROkckAuub3H46LU7oYLNLaZC0rFcLgytLGSM1SU
 oT8i2+l4DYPqb8mu6el5cfpUDML6TaOb8p1gnqkmyKRJXzzzX3iP0MgIB
 FWdKD/krSxTHY1fycqGa0JLDzpzlcvApMN9gad2GdkNDEhZZAVrAqv6fr
 7nXd7EBLBA0woQ7GEwq2j5K2vW5rrL75ypHIWJURQbhQoxGYwDfKH/PJU
 F82lpPrftMI7Qfv9KPs7+6Xlelf0tRvOz97Czd3xisMwm0C/I7erR78Kw
 bg0tm0pF3adxJQhGQtsWnYUTp64Q/D+/LOWGiJqboW/jtPHTCfR7qfAx3
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=iw2QEe3V
Subject: Re: [Intel-wired-lan] [PATCH] igc: return an error if the mac type
 is unknown in igc_ptp_systim_to_hwtstamp()
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
Cc: netdev@vger.kernel.org, llvm@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 1/14/2023 16:04, Tom Rix wrote:
> clang static analysis reports
> drivers/net/ethernet/intel/igc/igc_ptp.c:673:3: warning: The left operand of
>    '+' is a garbage value [core.UndefinedBinaryOperatorResult]
>     ktime_add_ns(shhwtstamps.hwtstamp, adjust);
>     ^            ~~~~~~~~~~~~~~~~~~~~
> 
> igc_ptp_systim_to_hwtstamp() silently returns without setting the hwtstamp
> if the mac type is unknown.  This should be treated as an error.
> 
> Fixes: 81b055205e8b ("igc: Add support for RX timestamping")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ptp.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
