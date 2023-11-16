Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8ABBC197A0
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Nov 2023 15:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D995402F3;
	Thu, 16 Nov 2023 15:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D995402F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700146932;
	bh=ru1gH93rQ8jbog7ZXWxxrEM1qTTB/aMPyCjs5jCJOkA=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=bVOVSXdrulcPohpaPFknpthZIum6SXV4iXeriXO7GnCjTdNDJ4+4ryt68jzXCaIOA
	 zMavUw0w93IPl9c4TlrrwkFn8w5hT3Z+4Zogi+ke/Vh/MXZKXVPRJLxf/B8Pfb8UOA
	 SFFkAzQOsu0Ed/H38BEw7aWe+fWfSQEiLZ9oJGqdd66fAarvL4d1la3mMSXtT/TNM2
	 s/2p3y1LI0CkrxoEyxJtnKesWQ0GF6IBgmm/csb/z6gBEBq1ePjw0gDaPfpcPQT5Px
	 zLsLKzrMTg2m5C7bsnIc3kMpFcEp9P8itKFLREOjfQ3OUQpIQcfmw7Sk3spEbu5EKC
	 rHFVdHC11J2JQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b263TPz7ymMD; Thu, 16 Nov 2023 15:02:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3FC9E41A38;
	Thu, 16 Nov 2023 15:02:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FC9E41A38
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 6B02C1BF363
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Nov 2023 15:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4203D81EAB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Nov 2023 15:02:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4203D81EAB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oirfHDDpEKAg for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Nov 2023 15:02:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 702F581EA4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Nov 2023 15:02:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 702F581EA4
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-3hkXgPN0PXqpqicqpF-54g-1; Thu,
 16 Nov 2023 10:02:01 -0500
X-MC-Unique: 3hkXgPN0PXqpqicqpF-54g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 737161C0651B;
 Thu, 16 Nov 2023 15:01:56 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C14265028;
 Thu, 16 Nov 2023 15:01:54 +0000 (UTC)
Message-ID: <c14fc17e-95a7-47be-86c5-e1c889ea627e@redhat.com>
Date: Thu, 16 Nov 2023 16:01:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
References: <20231116144119.78769-1-ivecera@redhat.com>
In-Reply-To: <20231116144119.78769-1-ivecera@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1700146927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6L7tI+K8yZDrsftYj6Ia4FnBkfs6t8tIYhpG29gA3U=;
 b=cGTx3eyIPvh9Ze8zxRW+NlcKuVbRYBhOBMMZhXA/ksI2Nx4ZOq2ebAnAbH06UVfnqpxPCU
 Fphfe7fp0RgCr8+D+D4KtSsC28Nx8HmsXf6W5szR8ZSJ95/FLA/EOAGFrBniAekpAGFVCU
 M+TnQOiviSgqAEgSChKjDRR/kjwSEZo=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cGTx3eyI
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 0/5] i40e: Simplify VSI
 and VEB handling
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
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 16. 11. 23 15:41, Ivan Vecera wrote:
> The series simplifies handling of VSIs and VEBs by introducing for-each
> iterating macros, 'find' helper functions. Also removes the VEB
> recursion because the VEBs cannot have sub-VEBs according datasheet and
> fixes the support for floating VEBs.
> 
> The series content:
> Patch 1 - Uses existing helper function for find FDIR VSI instead of loop
> Patch 2 - Adds and uses macros to iterate VSI and VEB arrays
> Patch 3 - Adds 2 helper functions to find VSIs and VEBs by their SEID
> Patch 4 - Fixes broken support for floating VEBs
> Patch 5 - Removes VEB recursion and simplifies VEB handling
> 
> Changelog:
> v1->v2 - small correction in patch 4 description
>         - changed helper names in patch 3
> 
> Ivan Vecera (5):
>    i40e: Use existing helper to find flow director VSI
>    i40e: Introduce and use macros for iterating VSIs and VEBs
>    i40e: Add helpers to find VSI and VEB by SEID and use them
>    i40e: Fix broken support for floating VEBs
>    i40e: Remove VEB recursion
> 
>   drivers/net/ethernet/intel/i40e/i40e.h        |  91 ++-
>   drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  10 +-
>   .../net/ethernet/intel/i40e/i40e_debugfs.c    |  97 ++-
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 563 ++++++++----------
>   4 files changed, 371 insertions(+), 390 deletions(-)
> 

Oops, wrong files submitted... Apologies, please forget about this (v2) 
series.

Ivan

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
