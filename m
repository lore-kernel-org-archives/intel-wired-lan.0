Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE70C4167B
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Dec 2023 11:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA16141A1B;
	Tue,  5 Dec 2023 11:17:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA16141A1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701775030;
	bh=RkVsKWPQU37QkX3wxDijA2i7VbYRPVvsYP1O4PJia8o=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8U5+2fb2MbuQoqqMxV3/CGzHD4/3ojTkpe9JnvmjBCXgoCljj9j4dnBjoFx07aI60
	 TAjdcDZe7SAT5br0rFrlTC22nxH5itbmeCS5pB9yaxcfi6RtZjeSvc8XnQQOF+NEGU
	 6hKLLFZ+zEUvtEiGC9AGHoDq4XHQqXN8GPx2hPC1iJv/A5bbt/MTLvJ7bzXBmKO0lV
	 gTc1xgHvda5kYZmNoK3KQU6Obz/uohSNujosnc/QzsFC46pf3TqulHtDYuiZ4LoA/R
	 HUTq5NcZDPjVTcy8z6jURcacT6rKay9ka6JSwwXd9O3/KHajvio0N97y9gZwCm00IT
	 2lCMqyqCMSJeg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A2ZirD1b5wpF; Tue,  5 Dec 2023 11:17:09 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id A16EC41A34;
	Tue,  5 Dec 2023 11:17:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A16EC41A34
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 918881BF2B0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 11:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D3D241A1B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 11:17:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D3D241A1B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2vWLhjFEbgo6 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Dec 2023 11:17:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BE1F41A1C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 11:17:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BE1F41A1C
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="397775472"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; d="scan'208";a="397775472"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2023 03:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="841421178"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; d="scan'208";a="841421178"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.214.215.245])
 ([10.214.215.245])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2023 03:17:02 -0800
Message-ID: <c55d299b-ff6b-4da6-bc9f-931d7cd5b2f8@linux.intel.com>
Date: Tue, 5 Dec 2023 13:16:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
 <20231121211921.19834-9-jesse.brandeburg@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20231121211921.19834-9-jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701775026; x=1733311026;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=H271sEIBAGP5MA7yccwYLYdOp2ywSPd2T2VYfsYelW8=;
 b=WVU53oZYk3yfTs4+CJloP+K79XLqnWkr6fmI3rj0PZ0FfV1eBvQvx/uV
 iB7xW4wPXIvLd1SWIs3C7FekuOUw+r3MfI8UxAfOzjXJ6VHeoDdsrSEwL
 nqV67mtWGDi1gx1IDrUh/msYh0/ghO5TeHscG0uEAqserEIKIujpfl75r
 nfx0DdI4wSlkQkELJz1HNtnS6p8dkut9s17+YXevklCViwepfPay0T7Ex
 U8gsAGyFaB34F4FY8/W3UWFnDDDKl+NFJ/s7ysCUUuoCi1V5Xr5HjL8Jb
 /TIPpWBhXZUDTnBO/e8afm48G4cFnY7OAHMBXpdzYe0cuIoMbzC3HhOWg
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WVU53oZY
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 08/13] igc: field prep
 conversion
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
Cc: Julia Lawall <Julia.Lawall@inria.fr>, netdev@vger.kernel.org,
 Sasha Neftin <sasha.neftin@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 11/21/2023 23:19, Jesse Brandeburg wrote:
> Refactor igc driver to use FIELD_PREP(), which reduces lines of code
> and adds clarity of intent.
> 
> This code was generated by the following coccinelle/spatch script and
> then manually repaired in a later patch.
> 
> @prep@
> constant shift,mask;
> expression a;
> @@
> -((a << shift) & mask)
> +FIELD_PREP(mask, a)
> 
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Cc: Sasha Neftin <sasha.neftin@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
