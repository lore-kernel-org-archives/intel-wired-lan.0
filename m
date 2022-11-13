Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AFBC4332F
	for <intel-wired-lan@archiver.kernel.org>; Sun, 13 Nov 2022 07:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D11AE81991;
	Sun, 13 Nov 2022 07:32:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D11AE81991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668324746;
	bh=uuoH9xfL272lkPF6TloHFr279DaZYz9UaeHS+t/8Ccw=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=FKv7Z1qjMMxAfmkSfMRdZja4JXsecWLZKpYvp2J7S2a5jfyMKIlO+OfLbTE412XwO
	 8F1vToMxw5MOP2bKzhEgvC9UNYiME9jhXQ/blKxHQGgRG3fOVZ//VbZ7suuSyIe0GC
	 UcDvxaii8A7y+1ik6vMMu560YCKfvsE/RGqatPt6kNkSHDNnDMDiqJ46+fRN1GAQCL
	 7E0l8/ZOn22DnXoBythx1wBaK+BkhcdCEl2G+DtEEE7vXrqW9uug383dF13kKQt+H7
	 iaaBhN2PRTwA3x2pFyJKVXVqNtbFNkSpQZehzmozY1Gz10qDVN8or3YOm6akO+jJ9X
	 snbvqIQovX1Eg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id apEEpyUUT-bS; Sun, 13 Nov 2022 07:32:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7BBA819BC;
	Sun, 13 Nov 2022 07:32:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7BBA819BC
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 13CF31BF4E5
 for <intel-wired-lan@osuosl.org>; Sun, 13 Nov 2022 07:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E23CA819BC
 for <intel-wired-lan@osuosl.org>; Sun, 13 Nov 2022 07:32:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E23CA819BC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LIcAPBazUbnY for <intel-wired-lan@osuosl.org>;
 Sun, 13 Nov 2022 07:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50E7E81991
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 50E7E81991
 for <intel-wired-lan@osuosl.org>; Sun, 13 Nov 2022 07:32:24 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="310500046"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; d="scan'208";a="310500046"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2022 23:32:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="706944251"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; d="scan'208";a="706944251"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.13])
 ([10.13.12.13])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2022 23:32:22 -0800
Message-ID: <91e11dbd-5852-c363-5f2e-3567c825e0a1@linux.intel.com>
Date: Sun, 13 Nov 2022 09:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 intel-wired-lan@osuosl.org
References: <20221030045324.25207-1-muhammad.husaini.zulkifli@intel.com>
 <20221030045324.25207-5-muhammad.husaini.zulkifli@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20221030045324.25207-5-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668324744; x=1699860744;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=GxC0mygZaECFqdyqWtZStSW+tpQvbGopsspNS3IJgUE=;
 b=NRjRZbVVloSpgp8j6NiSno7M/7epOTEkKimBEbRUKlBv+yCt5jslmQDA
 JG0msXwJZOYJtQ0UPER0HtP5VkcYIpNLYoHmtKSl0J/qcQgqHX5eSOQuh
 yB5zU1P/PM+rj9Ozh/QBjrk578PeS7YPoaFpD65YJovEeXqvakSXomqAw
 7qEOxiYcwDqoHEMNeT+kLvO5xDxzAalOyeVQ2AvMzIPtYxgI0Fux7/bez
 B1CKKWqW+azGjQo6PWVf614i7vl/RzZSTGzabwh4leCIz561Um8Tmuc38
 Su5wy+kGzpBTZlumMP4YUmLgXTLAUFhXwwsiROz8cYqVH/211Su6Qdxgj
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NRjRZbVV
Subject: Re: [Intel-wired-lan] [PATCH 4/5] igc: enable Qbv configuration for
 2nd GCL
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
Cc: tee.min.tan@linux.intel.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 10/30/2022 06:53, Muhammad Husaini Zulkifli wrote:
> From: Tan Tee Min <tee.min.tan@linux.intel.com>
> 
> Make reset task only executes for i225 and Qbv disabling to allow
> i226 configure for 2nd GCL without resetting the adapter.
> 
> In i226, Tx won't hang if there is a GCL is already running, so in
> this case we don't need to set FutScdDis bit.
> 
> Signed-off-by: Tan Tee Min <tee.min.tan@linux.intel.com>
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c |  9 +++++----
>   drivers/net/ethernet/intel/igc/igc_tsn.c  | 13 +++++++++----
>   drivers/net/ethernet/intel/igc/igc_tsn.h  |  2 +-
>   3 files changed, 15 insertions(+), 9 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
