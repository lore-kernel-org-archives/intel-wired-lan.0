Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80827C433FE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Nov 2022 14:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1172440475;
	Tue, 22 Nov 2022 14:17:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1172440475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1669126647;
	bh=Vpz6MmgOg4VCt7bVE3TQGCVjtemGeC/9DN0Y5OURFVE=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=F7iUmzwknlpio36leYi4DVNQX4+pF82/6otUoFkjgHRw+gyBtUmTXEAZvLnWZYHfn
	 +ON5SGlQOfdbkd1hbSjgaJ9asGsOOV46eo/5ZL7MZqu4/Ye3HCk8RMD2fBJCOTmdOs
	 yKz258hrB57/8KPmJCvruns4ugiVgowm7z3riZ53I4eSMtr9YTwL5uhLoLvNqlLDDN
	 zL0O4coYmoRWjtRdZ3gaAV5wgB02brj6kR7GNBKJlSUB4DYjnnva357Lb472thINJ2
	 INQBboHuJtJAcqc1KzG0kJCgccwO3Jmd8Wyv49q46DhxSpj0T4xN2VhjEOF/nIXRRH
	 4KNxgWl7pLOZw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h2enwzzsntlV; Tue, 22 Nov 2022 14:17:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2C37540981;
	Tue, 22 Nov 2022 14:17:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C37540981
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id C8E7C1BF475
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Nov 2022 14:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B13B68206F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Nov 2022 14:17:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B13B68206F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KE29l3iU1S6C for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Nov 2022 14:17:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E392C8211F
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E392C8211F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Nov 2022 14:17:22 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id BFF7B61CCD898;
 Tue, 22 Nov 2022 15:17:19 +0100 (CET)
Message-ID: <24fd3d18-0c09-8235-c88d-d7e151110ebe@molgen.mpg.de>
Date: Tue, 22 Nov 2022 15:17:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20221122092707.30981-1-akihiko.odaki@daynix.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20221122092707.30981-1-akihiko.odaki@daynix.com>
Subject: Re: [Intel-wired-lan] [PATCH] igbvf: Regard vf reset nack as success
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBBa2loaWtvLAoKClRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4KCgpBbSAyMi4xMS4yMiB1
bSAxMDoyNyBzY2hyaWViIEFraWhpa28gT2Rha2k6Cj4gdmYgcmVzZXQgbmFjayBhY3R1YWxseSBy
ZXByZXNlbnRzIHRoZSByZXNldCBvcGVyYXRpb24gaXRzZWxmIGlzCj4gcGVyZm9ybWVkIGJ1dCBu
byBhZGRyZXNzIGlzIG5vdCBhc3NpZ25lZC4gVGhlcmVmb3JlLCBlMTAwMF9yZXNldF9od192ZgoK
SXMg4oCmIG5vIOKApiBub3QgYXNzaWduZWQg4oCmIGludGVudGlvbmFsPwoKPiBzaG91bGQgZmls
bCB0aGUgInBlcm1fYWRkciIgd2l0aCB0aGUgemVybyBhZGRyZXNzIGFuZCByZXR1cm4gc3VjY2Vz
cyBvbgo+IHN1Y2ggYW4gb2NjYXNzaW9uLiBUaGlzIHByZXZlbnRzIGl0cyBjYWxsZXJzIGluIG5l
dGRldi5jIGZyb20gc2F5aW5nIFBGCgpvY2Nhc2lvbgoKPiBzdGlsbCByZXNldHRpbmcsIGFuZCBp
bnN0ZWFkIGFsbG93cyB0aGVtIHRvIGNvcnJlY3RseSByZXBvcnQgdGhhdCBubwo+IGFkZHJlc3Mg
aXMgYXNzaWduZWQuCgpJbiB3aGF0IGVudmlyb25tZW50IGRvIHlvdSBoaXQgdGhlIHByb2JsZW0/
Cgpb4oCmXQoKCktpbmQgcmVnYXJkcywKClBhdWwKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KSW50ZWwtd2lyZWQtbGFuIG1haWxpbmcgbGlzdApJbnRlbC13
aXJlZC1sYW5Ab3N1b3NsLm9yZwpodHRwczovL2xpc3RzLm9zdW9zbC5vcmcvbWFpbG1hbi9saXN0
aW5mby9pbnRlbC13aXJlZC1sYW4K
