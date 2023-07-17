Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E497EB64DC
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Jul 2023 09:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 309F4404AF;
	Mon, 17 Jul 2023 09:24:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 309F4404AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689585841;
	bh=AdtQCIOWBrXOlVfXXMNj2oCNCVQQsgrXaOzfEhou7Ss=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=hW1l/hl6upT23NjSSuRRp7B0kva7IwL9DYB3Nm+rssecbsv/+pYnK/MZae2qsIYD7
	 bq9Df7v0t5Gtixye8CdYEewr6x52xFpKnVXKCCfQ16czmI/gX/VWr3XvXEa6PK/XAK
	 cr5lWYhSJ0v4kRj57M0DBxO0GzV0OcE3PO/kS7Jdv2jQ4E2lnozvXvotalf6Mexm3f
	 QqHHF4b8ANxPCKBP1mEuv/dPiIjdt+kPWg1+y4EVEAxyAY2Df1LOwicqfYCxJ9Kasn
	 caaV8vIv1kXDpfhXbS5CKa1ZmYS4P3cTqgelo9P3/6q4z4IUdxKg10R71sRymnluLu
	 zvYuRmWeBdIlw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NzY-mlBnKwfv; Mon, 17 Jul 2023 09:24:00 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 52C90404D8;
	Mon, 17 Jul 2023 09:24:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 52C90404D8
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id C4ADA1BF363
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Jul 2023 09:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D12280C03
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Jul 2023 09:23:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D12280C03
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P809odWrHT1Y for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Jul 2023 09:23:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6DEF80C01
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6DEF80C01
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Jul 2023 09:23:56 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9F3E961E5FE01;
 Mon, 17 Jul 2023 11:23:32 +0200 (CEST)
Message-ID: <e5e7a277-9591-4154-15de-b78be569a498@molgen.mpg.de>
Date: Mon, 17 Jul 2023 11:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>
References: <20230717091843.108015-1-wojciech.drewek@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230717091843.108015-1-wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: Accept LAG netdevs
 in bridge offloads
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
Cc: jiri@resnulli.us, anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, simon.horman@corigine.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBXb2pjaWVjaCwKCgpUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guCgoKQW0gMTcuMDcuMjMg
dW0gMTE6MTggc2NocmllYiBXb2pjaWVjaCBEcmV3ZWs6Cj4gQWxsb3cgTEFHIGludGVyZmFjZXMg
dG8gYmUgdXNlZCBpbiBicmlkZ2Ugb2ZmbG9hZCB1c2luZwo+IG5ldGlmX2lzX2xhZ19tYXN0ZXIu
IEluIHRoaXMgY2FzZSwgc2VhcmNoIGZvciBpY2UgbmV0ZGV2IGluCj4gdGhlIGxpc3Qgb2YgTEFH
J3MgbG93ZXIgZGV2aWNlcy4KCldoeSB3ZXJlbuKAmXQgdGhlc2UgaW50ZXJmYWNlcyBhbGxvd2Vk
IHRvIGJlIHVzZWQgbGlrZSB0aGF0IGJlZm9yZT8gSXTigJlkIApiZSBncmVhdCBpZiB5b3UgYWRk
ZWQgdGhhdCBpbmZvcm1hdGlvbi4KCj4gUmV2aWV3ZWQtYnk6IEplZHJ6ZWogSmFnaWVsc2tpIDxq
ZWRyemVqLmphZ2llbHNraUBpbnRlbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogV29qY2llY2ggRHJl
d2VrIDx3b2pjaWVjaC5kcmV3ZWtAaW50ZWwuY29tPgoKW+KApl0KCgpLaW5kIG5yZWdhcmRzLAoK
UGF1bApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRl
bC13aXJlZC1sYW4gbWFpbGluZyBsaXN0CkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3JnCmh0dHBz
Oi8vbGlzdHMub3N1b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLXdpcmVkLWxhbgo=
