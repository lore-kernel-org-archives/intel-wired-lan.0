Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC15C00140
	for <intel-wired-lan@archiver.kernel.org>; Mon,  8 Aug 2022 10:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B819A40891;
	Mon,  8 Aug 2022 10:28:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B819A40891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659954490;
	bh=5ntPlT1PVVAhu5l9P5ARBnh9fiF68s+8a7bfVvJGqIw=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=HyCJmDkfINn/ldq0HQSwWDZXQHMiKfgiz+3g7YNXY1GyT+BwJNRQHqXNXMriBz3hs
	 yjSkp+MP/OvGlH+5p4b0RG/DJbAG2XW9tbimlXxgx6Ox2zvpxDjyneIwLvYT3+l91T
	 oNPxF6Kax//d5SVmQWsGyXnIcX9sYjCBjpKIuRGX4iDVHAob6IgObgKpfHblUJVKWY
	 RxpjN1f8cNa/m59v+WJGyYOqK8sLwdG2eZcs9WR2BhCh9nsP9RconxbgJIaEFGhX5g
	 R1BOkS50ih1tSZhQeIwCdtcqzoix0sJzikj9KI6BPWzOKBv+jzNW59Eu3MDLnsr+IF
	 5egdVGURYtzKw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1hnuqBFmNgwA; Mon,  8 Aug 2022 10:28:09 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 803DE4097F;
	Mon,  8 Aug 2022 10:28:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 803DE4097F
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 549CB1BF36D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Aug 2022 10:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 310B740347
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Aug 2022 10:28:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 310B740347
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QqRdMn7jZ7Na for <intel-wired-lan@lists.osuosl.org>;
 Mon,  8 Aug 2022 10:28:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8041F4007F
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8041F4007F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Aug 2022 10:28:05 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 39D6B61EA1928;
 Mon,  8 Aug 2022 12:28:02 +0200 (CEST)
Message-ID: <c9576243-0cb8-c268-2518-b68c01ca076c@molgen.mpg.de>
Date: Mon, 8 Aug 2022 12:28:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Content-Language: en-US
To: Sasha Neftin <sasha.neftin@intel.com>
References: <20220808102421.1651482-1-sasha.neftin@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220808102421.1651482-1-sasha.neftin@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove IGC_MDIC_INT_EN
 definition
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
Cc: intel-wired-lan@lists.osuosl.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Sasha,


Thank you for the patch. Why not make the summary:

> igc: Remove unused IGC_MDIC_INT_EN macro


Kind regards,

Paul
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
