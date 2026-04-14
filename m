Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13DCED7B8D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Apr 2026 08:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9301161CD9;
	Tue, 14 Apr 2026 08:55:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y04yLUP4xfe6; Tue, 14 Apr 2026 08:55:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4167608C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776156942;
	bh=rzFrTzoq0HnCZHcVlEeNBgHotPSPhdkKZmBWoRPrbOg=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eJMJYacP4ByzmhjB6CcML5F2+m+iUCjf9yNJnAUsLcKpakVY1510DPUp2cf36sxB2
	 Rqpg0rRU98/ZY90GoSc8fCLO/enYt+cnNn+wy8+RbJAAAy8IcG7eRoP9TvEze4shEt
	 N2OUwDooCuK979DyXMGIW/sfLKvLfqb18OPSuOef+A+zBERl+D8VjiZC3wpCUa7ONG
	 n2Yy3M5H7hrh+xd5fj5cEIBF1mxtQ8TjUcgnJrlKE9ej6nZD55fgb+zitxQ1QjAyom
	 2tgC93tlUDcpfoP5ylAPmTB79HFGiyCbaW4XRS0Muo/3WLeaiJcbcBKlmf+AWrOJqC
	 mkb3J+75S63yQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4167608C7;
	Tue, 14 Apr 2026 08:55:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7063E283
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 08:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6149A403B9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 08:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ew8xyKjSTj3a for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Apr 2026 08:55:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=dawid.osuchowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 66F9240191
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 66F9240191
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66F9240191
 for <intel-wired-lan@osuosl.org>; Tue, 14 Apr 2026 08:55:39 +0000 (UTC)
X-CSE-ConnectionGUID: d+9770hPRLuuXx7to+YLZw==
X-CSE-MsgGUID: PZ+rTnQJTFO2NzzXwVA5AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="88186418"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="88186418"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 01:55:40 -0700
X-CSE-ConnectionGUID: rfAdmeYfT7OQFopcDKEkiA==
X-CSE-MsgGUID: Aoc23v+fREy3t9eodGYHEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="223535662"
Received: from avbakuno-mobl.ccr.corp.intel.com (HELO [10.246.16.61])
 ([10.246.16.61])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 01:55:37 -0700
Message-ID: <01cee873-23d7-43f5-96eb-29826d1c157c@linux.intel.com>
Date: Tue, 14 Apr 2026 10:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Vollrath <tactii@gmail.com>, intel-wired-lan@osuosl.org
Cc: stable@vger.kernel.org, Avigail Dahan <avigailx.dahan@intel.com>
References: <20260413000325.33379-1-tactii@gmail.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260413000325.33379-1-tactii@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776156941; x=1807692941;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=kudLCTIITmlAZjTqgthhq39P8xFZprhHZarcmmvo6PU=;
 b=cWkG0Mt7cdFFEvQcCH004TenPRNAgqdAm3aPHelXIa6YTlN0O7cXaH8p
 +e9eeuIybEhuIkekaXSfKrJuDWe3iND6MAyA5ueTHLjo2XLI6trwe2XRh
 6QWaFQLFM3hOBDOdKsWWHzwZeE0KZcZtMmlS68aDPOtSu8181EiETRbt3
 bcG7TPsc0MpgBKd4zKi2M6FrtCZ6nBoL3n32wJENYYV0fsaPE5KuWfBlC
 QtmV5JubuHJqA0xrKZPT3t5McgCKbMJKDGhs4V/DpsyaXYMJNCgI+K/Ll
 u1gFQu08ikVXpmhY7ewdTkFRWcLqmX78+uGwmpBDQt6x0GjEYrHbZlRI0
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cWkG0Mt7
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] e1000e: Unroll PTP in
 probe error handling
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

On 2026-04-13 2:03 AM, Matt Vollrath wrote:

Hey Matt,

Thanks for the patch!

Apologies but it seems I didn't explain fully where the changelog should 
go, same goes for the Cc: stable as it should be inserted into the 
commit msg as a tag, see example below.

> If probe fails after registering the PTP clock and its delayed work,
> these resources must be released.
> 
> This was not an issue until a 2016 fix moved the e1000e_ptp_init() call
> before the jump to err_register.
> 
> Fixes: aa524b66c5ef ("e1000e: don't modify SYSTIM registers during SIOCSHWTSTAMP ioctl")
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
> ---

Changelog should go _here_, not below the:

-- 
2.43.0

and should also have the --- afterwards. So using this patch submission 
as an example your commit msg + changelog should look like the following:

If probe fails after registering the PTP clock and its delayed work,
these resources must be released.

This was not an issue until a 2016 fix moved the e1000e_ptp_init() call
before the jump to err_register.

Fixes: aa524b66c5ef ("e1000e: don't modify SYSTIM registers during 
SIOCSHWTSTAMP ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
---
Changes:
v2:
* Apply the correct Fixes tag
* Target iwl-net
* Cc stable
---

  drivers/net/ethernet/intel/e1000e/netdev.c | 1 +
  1 file changed, 1 insertion(+)

<snip of the rest of the diff/>

Once again sorry for not saying it more clearly before.

Best regards
~Dawid
