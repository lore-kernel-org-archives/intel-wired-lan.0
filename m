Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C83DC001DE
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Aug 2023 07:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEE9380DC3;
	Wed,  2 Aug 2023 07:30:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEE9380DC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690961427;
	bh=GyvndtofQaBLwxdnnzVKq2iegL67IdWGVVU+/SILvkw=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=myb4FRqZc8as+Uo2URSxGTfsV8jxaioH8dAR0sded72ugh2iPTFTaWEdyx6VdbFGG
	 6Vik1Q+evzKcfzqM9i53bN7Itf6ns6ch7Xw2LSMK0sBZft6OXdIY5DclNXMF8xBRXG
	 11TyUIn6KPMr142M+guuW3zlAipCuv9nMkKohSyMX91wtcR/RN4EdqfsK2smC2AjjS
	 M6vQGZqNBloXQcY5w/Su5NG1U837o6ljHoI0MpdaiNZJdnF0i+V7T1x4VKBmM3uE/M
	 0plN0mjYG6StGxArhZbL0/fTiSGYmi6O5wCbMnGN+5k8KIMLq0b+itGj8Q4Ruy+CoQ
	 06dN2R5usOYTA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kwNJLty5eGFU; Wed,  2 Aug 2023 07:30:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C823C81432;
	Wed,  2 Aug 2023 07:30:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C823C81432
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 33C921BF360
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Aug 2023 07:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6A3E80DC3
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Aug 2023 07:30:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6A3E80DC3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PvbGY8fyx3Kq for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Aug 2023 07:30:05 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3382C80CE6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Aug 2023 07:30:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3382C80CE6
Received: from [192.168.0.2] (ip5f5ae98d.dynamic.kabel-deutschland.de
 [95.90.233.141])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3099F61E5FE01;
 Wed,  2 Aug 2023 09:29:43 +0200 (CEST)
Message-ID: <d492b7a6-75a4-2300-2eae-b9f73be59461@molgen.mpg.de>
Date: Wed, 2 Aug 2023 09:29:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-US
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20230802065341.3545102-1-aleksandr.loktionov@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230802065341.3545102-1-aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] i40e: add tracepoints for
 nvmupdate troubleshooting
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
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBBbGVrc2FuZHIsCgoKVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLgoKQW0gMDIuMDguMjMg
dW0gMDg6NTMgc2NocmllYiBBbGVrc2FuZHIgTG9rdGlvbm92Ogo+IEltcHJvdmUgbnZtdXBkYXRl
IHRyb3VibGVzaG9vdGluZyB3aXRoIGJwZnRyYWNlIHV0aWxpdHkuCj4gQWRkICdzdGFibGUnIHN0
YXRpYyB0cmFjZXBvaW50cyB0byBkZWNvZGUgbnZtdXBkYXRlIGNvbW1hbmRzIGNvbXBhdGlibGUK
PiBldmVuIGZvciBmdXR1cmUgZHJpdmVyIHZlcnNpb25zLgo+IFJlbW92ZSAnc3RhdGljJyBmcm9t
IGVlcHJvbSBmdW5jdGlvbnMgZGVjbGFyYXRpb25zLCBtYWtlIHRoZW0gcHVibGljCj4gdG8gZW5h
YmxlIGR5bmFtaWMga2VybmVsIHRyYWNpbmcgYW5kIHByb2ZpbGluZy4KClNvbWUgcGVyc29uYWwg
cHJlZmVyZW5jZSwgSeKAmWQgYWRkIGEgYmxhbmsgbGluZSBiZXR3ZWVuIHBhcmFncmFwaHMgb3Ig
CmF2b2lkIHRoZSBsaW5lIGJyZWFrIGp1c3QgYmVjYXVzZSBhIHNlbnRlbmNlIGVuZHMuCgpBbHNv
LCBpdOKAmWQgYmUgZ3JlYXQsIGlmIHlvdSBhZGRlZCB0aGUgY29tbWFuZCBob3cgdG8gbGlzdCB0
aGUgbmV3IAp0cmFjZXBvaW50cyBhbmQgb25lIGV4YW1wbGUgZm9yIHRyYWNpbmcgb25lIG9mIHRo
ZSBuZXcgdHJhY2Vwb2ludHMuCgo+IFNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3Yg
PGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaTQwZS9pNDBlLmggICAgICAgIHwgICA1ICsKPiAgIC4uLi9uZXQvZXRoZXJu
ZXQvaW50ZWwvaTQwZS9pNDBlX2V0aHRvb2wuYyAgICB8ICAzMCArKy0KPiAgIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMgICB8ICAyMCArLQo+ICAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3RyYWNlLmggIHwgMjEyICsrKysrKysrKysrKysr
KysrKwo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyNTYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25z
KC0pCgpb4oCmXQoKCktpbmQgcmVnYXJkcywKClBhdWwKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtd2lyZWQtbGFuIG1haWxpbmcgbGlzdApJbnRl
bC13aXJlZC1sYW5Ab3N1b3NsLm9yZwpodHRwczovL2xpc3RzLm9zdW9zbC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pbnRlbC13aXJlZC1sYW4K
