Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE88C433FE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Oct 2022 05:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 519BA605BA;
	Tue, 18 Oct 2022 05:58:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 519BA605BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1666072684;
	bh=WWPhO+0/Z21dd7t2ykPu5gDrJin1YU02X4BEmmcd3rI=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nQSN+8G1B1lqigc96PSSzGvgMXzqLs5aQQbDZndYXexlHXD6dPVH718OC+ImCkONQ
	 sUqPKQVUqKNaT280bmpKklv4d6Gpx8xfI6GB2lYnLt+rnlu5Gb6jsulOrx4KeQti7Y
	 OmlgXM5I4lhau9v6GdpgPuP7rKLsnTZVO51PKJnvKCO3usoqIeKCzzwrfstLlbV1MW
	 2bLVQQzyDKUMnq4GfAKW/oIT8BC6WWZCFS48yr+ezI+6kVLEr8UcrTofOPumhWGw6F
	 rWEZyigki2bNrOHXneFbUT0bpuJs7hWug6rzx5Fjl52g1f7qVyu8Q6jXa5egCvBpa7
	 TEZFcTRl1SUKQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hU5Hv9o8EGGO; Tue, 18 Oct 2022 05:58:03 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E11160FCD;
	Tue, 18 Oct 2022 05:58:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E11160FCD
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 22FEF1BF396
 for <intel-wired-lan@osuosl.org>; Tue, 18 Oct 2022 05:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F11C382EA4
 for <intel-wired-lan@osuosl.org>; Tue, 18 Oct 2022 05:57:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F11C382EA4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wW_Z0XoNmtYK for <intel-wired-lan@osuosl.org>;
 Tue, 18 Oct 2022 05:57:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7ACF813D7
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7ACF813D7
 for <intel-wired-lan@osuosl.org>; Tue, 18 Oct 2022 05:57:58 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae87c.dynamic.kabel-deutschland.de
 [95.90.232.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 212C461EA192A;
 Tue, 18 Oct 2022 07:57:55 +0200 (CEST)
Message-ID: <2d522491-e4f1-9e4a-c713-4adc4990f04f@molgen.mpg.de>
Date: Tue, 18 Oct 2022 07:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
References: <20221018010733.4765-1-muhammad.husaini.zulkifli@intel.com>
 <20221018010733.4765-3-muhammad.husaini.zulkifli@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20221018010733.4765-3-muhammad.husaini.zulkifli@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 2/5] net-timestamp: Increase the
 size of tsflags
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
Cc: leon@kernel.org, netdev@vger.kernel.org, richardcochran@gmail.com,
 davem@davemloft.net, saeed@kernel.org, edumazet@google.com,
 intel-wired-lan@osuosl.org, kuba@kernel.org, michael.chan@broadcom.com,
 gal@nvidia.com, andy@greyhouse.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Muhammad,


Thank you for the patch. For the summary/title you could be more 
specific with

 > net-timestamp: Double tsflags size to 32-bit for more flags


Kind regards,

Paul
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
