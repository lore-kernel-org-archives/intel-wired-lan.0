Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C85C4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Oct 2022 15:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11D8D60AE6;
	Thu, 20 Oct 2022 15:08:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11D8D60AE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1666278500;
	bh=oyoLVR0TnUQx1zrfuo9ytuiID41C3NEzCKFIbM8cv0I=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Dd7MvvpyfPw8crxf5sm8hzDWX59Lt2Y5kwS9V4YzkNXljj6rhKYNmsHNfW/gIv6RB
	 z3N17wmZ3ranl0QIa3NG6t84DAV0rEDxJaFjaD1HZ2hs9HcRv9db+jXs2Zw7URoZVP
	 UH76lOYkP7YXrg0vx5yEGztqg5n44dfBMzkC1FEtH5y7Dl2OGKiSJNYbmIqiveea6+
	 +A88vzsfUyZAW4q1oo9pJQ4REFGlBijfxxbYm47eXm0ZlmhSXg2MF/azBVD4Lcg7IT
	 YSLoYLIeShtf3wGD3Hic4+bJkPx72RYqLvLLhL6duzsRumfkHf8Jw7lJmYdMPEjs4i
	 RmrBrPXXPuCng==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tnud4qiRep0S; Thu, 20 Oct 2022 15:08:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 136E46FAC0;
	Thu, 20 Oct 2022 15:08:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 136E46FAC0
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id C759D1BF275
 for <intel-wired-lan@osuosl.org>; Thu, 20 Oct 2022 15:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AEC966FAC0
 for <intel-wired-lan@osuosl.org>; Thu, 20 Oct 2022 15:08:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEC966FAC0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rG-VDmqsTCC8 for <intel-wired-lan@osuosl.org>;
 Thu, 20 Oct 2022 15:08:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D8E160AE6
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D8E160AE6
 for <intel-wired-lan@osuosl.org>; Thu, 20 Oct 2022 15:08:15 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 635F661EA192A;
 Thu, 20 Oct 2022 17:08:12 +0200 (CEST)
Message-ID: <53da60fb-3741-2869-b97e-65da9a8aac67@molgen.mpg.de>
Date: Thu, 20 Oct 2022 17:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
References: <20221020145316.1543-1-muhammad.husaini.zulkifli@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20221020145316.1543-1-muhammad.husaini.zulkifli@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v1] igc: Qbv scheduling enchancement
 using frst flag bit
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
Cc: intel-wired-lan@osuosl.org, mallikarjuna.chilakala@intel.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBNdWhhbW1hZCwKCgpUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4KClRoZXJlIGlzIGEgc21h
bGwgdHlwbyBpbiB0aGUgc3VtbWFyeS90aXRsZTogZippKnJzdC4gQWxzbyBpdOKAmWQgYmUgbmlj
ZSAKaWYgeW91IG1hZGUgaXQgYSBzdGF0ZW1lbnQuIE1heWJlOgoKPiBpZ2M6IEVuaGFuY2UgUWJ2
IHNjaGVkdWxpbmcgYnkgdXNpbmcgZmlyc3QgZmxhZyBiaXQKCgpLaW5kIHJlZ2FyZHMsCgpQYXVs
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLXdp
cmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0cHM6Ly9s
aXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
