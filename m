Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BA6ECAAD8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Sep 2022 12:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EB3541A60;
	Fri, 16 Sep 2022 12:54:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EB3541A60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1663332863;
	bh=uVBE1TJROjpdpu33YoW2Qd3NSTUzy91xCvdRIo73pVQ=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=i2k03SYKSes3XmN0kNecyQmjGylyy4Q6IVrQ9NiETCHJyE60ODP61JmbQmwQFwbRl
	 SGxVxVuubfqbNQsJtVGXG8J8MN963F8w+hONz89a1ILn1RMcz4Rw/smKuvkG8NIq3l
	 ELfz9ZgJySqWmUy67dIgXLkHLRRXegDL4bpTyLv/gHcBdnUVP/KHtRAN+LCqCl9FIb
	 HxDwr2k5549TjNP0hHjjsODyo4CkZT3U5uFi9U4SYpTop/yrOFOKEHh+/sEZaQDWv8
	 jJhNPbXM05iGEkW0I1j8Rn+CFHpu33XGVPy1V6ZhZUm9H9XSIgpEonmW8RWc/qXrVJ
	 rVyx7lhibW05g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y6q7fCqUmvv9; Fri, 16 Sep 2022 12:54:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FCAA41B9A;
	Fri, 16 Sep 2022 12:54:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FCAA41B9A
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id EC4C11BF2E5
 for <intel-wired-lan@osuosl.org>; Fri, 16 Sep 2022 12:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7184611D4
 for <intel-wired-lan@osuosl.org>; Fri, 16 Sep 2022 12:54:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7184611D4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tfl7Y1HyCkC0 for <intel-wired-lan@osuosl.org>;
 Fri, 16 Sep 2022 12:54:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 712C66106A
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 712C66106A
 for <intel-wired-lan@osuosl.org>; Fri, 16 Sep 2022 12:54:19 +0000 (UTC)
Received: from [172.30.1.130] (unknown [193.158.90.91])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id B3D2B61EA1929;
 Fri, 16 Sep 2022 14:54:15 +0200 (CEST)
Message-ID: <3d7c3fca-dbd4-4522-253f-5b48564b26ad@molgen.mpg.de>
Date: Fri, 16 Sep 2022 14:54:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
References: <20220914144942.22700-1-muhammad.husaini.zulkifli@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220914144942.22700-1-muhammad.husaini.zulkifli@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v1] igc: Fix kernel NULL pointer
 dereference
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
Cc: intel-wired-lan@osuosl.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBNdWhhbW1hZCwKCgpPbmUgbml0IGJlbG93LgoKQW0gMTQuMDkuMjIgdW0gMTY6NDkgc2No
cmllYiBNdWhhbW1hZCBIdXNhaW5pIFp1bGtpZmxpOgo+IFRoaXMgcGF0Y2ggZml4IHRoZSBudWxs
IHBvaW50ZXIgZGVyZWZlcmVuY2Ugd2hlbiBkZXJlZmVyZW5jZSB0aGUgcG9pbnRlcgo+IHRoYXQg
aXMgZXhwZWN0ZWQgdG8gYmUgdmFsaWQgYnV0IGlzIE5VTEwsIHR5cGljYWxseSB3aWxsIGNhdXNl
IGtlcm5lbAo+IGNyYXNoIGFzIGJlbG93Ogo+IAo+ICAgNDUuMzY5MjA2XSBCVUc6IGtlcm5lbCBO
VUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwMDQKCk1pc3Np
bmcgYFsgIGAgaW4gdGhlIGJlZ2lubmluZy4KClvigKZdCgoKS2luZCByZWdhcmRzLAoKUGF1bApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC13aXJl
ZC1sYW4gbWFpbGluZyBsaXN0CkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3JnCmh0dHBzOi8vbGlz
dHMub3N1b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLXdpcmVkLWxhbgo=
