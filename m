Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D55C19F2D
	for <intel-wired-lan@archiver.kernel.org>; Tue,  9 Aug 2022 11:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEBF181911;
	Tue,  9 Aug 2022 11:12:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEBF181911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660043536;
	bh=QQCz29ROKLCtsVrXnFuKMcv0yiMYQhcyuAhFionG1Zs=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=oq8qnJpyUQTedX5n8B1jfNprqgwOO4X96NlfoY0i4Jv7qPKqIfY71DEfE2ZhSHR2b
	 Rn+YyLaba+9YCOF3Rf3IWdbo5vt9Fa4FJ+pH/agrFxVBl62qQBcJlGpgS9H72XMhqQ
	 mmrHU3wYYisEyhySLkJDdlw/n149uq3tOnvtj7Q9uJ6jTJMsJEDY4A/Zj3/Ix/QQez
	 Ynp/hG5owRVFVEy4QosXVRp/ZHOuI0HCOE19+5MwQ4mQ5AYh7hzAoo63CD0v6k7DDd
	 NwH76Sz4gBBXWXhRVgMlpzg+sy2eTYvIul6IYICkd61DLo5wL1OlgiXFuuhEOIvZoL
	 eeogQslCLp72Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m9eLzT9A_3pt; Tue,  9 Aug 2022 11:12:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0031D81916;
	Tue,  9 Aug 2022 11:12:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0031D81916
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id E034A1BF2C7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Aug 2022 11:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5BF7409DD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Aug 2022 11:12:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5BF7409DD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nWUQQAEE5udD for <intel-wired-lan@lists.osuosl.org>;
 Tue,  9 Aug 2022 11:12:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D02CF409B1
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D02CF409B1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Aug 2022 11:12:11 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aecbd.dynamic.kabel-deutschland.de
 [95.90.236.189])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id AE44A61EA192A;
 Tue,  9 Aug 2022 13:12:08 +0200 (CEST)
Message-ID: <4692e3bf-d877-46ef-8d96-be3836539766@molgen.mpg.de>
Date: Tue, 9 Aug 2022 13:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Content-Language: en-US
To: Kamil Maziarz <kamil.maziarz@intel.com>
References: <20220809130508.281453-1-kamil.maziarz@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220809130508.281453-1-kamil.maziarz@intel.com>
Subject: [Intel-wired-lan] Time problems at Intel offices (was: [PATCH net
 v3] i40e: Disallow ip4 and ip6 l4_4_bytes)
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
Cc: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
 intel-wired-lan@lists.osuosl.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBLYW1pbCwKCgpBbSAwOS4wOC4yMiB1bSAxNTowNSBzY2hyaWViIEthbWlsIE1hemlhcno6
Cgpb4oCmXQoKVW5mb3J0dW5hdGVseSwgdGhlIHRpbWUgb2YgdGhlIG1lc3NhZ2UgaXMgZnJvbSB0
aGUgZnV0dXJlLCBhcyBoYXBwZW5lZCAKb2Z0ZW4gd2l0aCBtZXNzYWdlcyBmcm9tIHRoZSBQb2xp
c2ggSW50ZWwgb2ZmaWNlcy4gSSB3YXMgdG9sZCwgdGhlIE5UUCAKcG9ydCBpcyBibG9ja2VkIGJ5
IHRoZSBmaXJld2FsbCwgYnV0IGl04oCZZCBiZSBncmVhdCBpZiB0aGUgcHJvYmxlbSDigJMgCmV4
aXN0aW5nIGZvciBvdmVyIHR3byB5ZWFycyDigJMgY291bGQgYmUgZml4ZWQuCgoKS2luZCByZWdh
cmRzLAoKUGF1bApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpJbnRlbC13aXJlZC1sYW4gbWFpbGluZyBsaXN0CkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3Jn
Cmh0dHBzOi8vbGlzdHMub3N1b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLXdpcmVkLWxh
bgo=
