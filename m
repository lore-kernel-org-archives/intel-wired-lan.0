Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F99FC7EE2E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 17 May 2023 13:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1B98C4029F;
	Wed, 17 May 2023 13:33:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B98C4029F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684330431;
	bh=7a0AJaeH+Nxn7T6pd8CSjOtlaoZYtz7+akg3Ce83I0w=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=YRnMLdZNgCFj9sxldi2zI/C59E4nJCE517kUTM9yYdBuNKX+KsUD7x53eedlP8Qdz
	 uvdU5QosAw/DlRq0LLW/lUIf1G5md4lx+1X0AUj2ees07mOB/TYJm7ZtOL6JIjMhLh
	 wEngi0Fp0IkwcI4+ygOwYcKN0E/iVs1eqkngs2rlus0z0jqzNzh7s1vMBk6ZXOHnHD
	 PWiVlCBbegRjqTrONRG57bZWvjaghA7J7Xu/ZMsUPkXuLRedgjCYlvB4IxtLb4k3ul
	 nckz6r4lIcErOzhW4nHXiDq8AOEPGsr2HGKUvoRcZEeEsO0Uv8QKs28rYjfTVXTAni
	 JYQbDWgd/O6Sw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a2Fe46vb0BCL; Wed, 17 May 2023 13:33:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3B9A840438;
	Wed, 17 May 2023 13:33:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B9A840438
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 64FC91BF487
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 May 2023 13:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41D6F81B25
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 May 2023 13:33:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 41D6F81B25
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FQ6cmGCwUy8Q for <intel-wired-lan@lists.osuosl.org>;
 Wed, 17 May 2023 13:33:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CBCF81A6A
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CBCF81A6A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 May 2023 13:33:46 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id E993C61EA1BFF;
 Wed, 17 May 2023 15:33:21 +0200 (CEST)
Message-ID: <52dbbc99-85a8-12a3-6c27-99c08a7e7ca1@molgen.mpg.de>
Date: Wed, 17 May 2023 15:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Piotr Gardocki <piotrx.gardocki@intel.com>
References: <20230517125247.331227-1-piotrx.gardocki@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230517125247.331227-1-piotrx.gardocki@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 0/2] iavf: cleanup
 procedure for changing interface's MAC address
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBQaW90ciwKCgpUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2hlcy4KCkFtIDE3LjA1LjIzIHVt
IDE0OjUyIHNjaHJpZWIgUGlvdHIgR2FyZG9ja2k6Cj4gVGhpcyBwYXRjaHNldCBjbGVhbnVwcyAu
bmRvX3NldF9tYWNfYWRkcmVzcyBjYWxsYmFjayBpbiBpYXZmLgoKSnVzdCBhIHNtYWxsIHR5cG8g
bm90ZSwgdGhhdCB0aGUgdmVyYiAqY2xlYW4gdXAqIGlzIHNwZWxsZWQgd2l0aCBhIHNwYWNlOgoK
PiBDbGVhbiB1cCBwcm9jZWR1cmUgZm9yIGNoYW5nZSBpbnRlcmZhY2XigJlzIE1BQyBhZGRyZXNz
Cgoob3IgQ2xlYW4gcHJvY2VkdXJlIOKApiB1cCkKClNhbWUgZm9yIHRoZSBmaXJzdCBsaW5lOgoK
PiBUaGlzIHBhdGNoc2V0IGNsZWFucyAubmRvX3NldF9tYWNfYWRkcmVzcyBjYWxsYmFjayB1cCBp
biBpYXZmLgoKCktpbmQgcmVnYXJkcywKClBhdWwKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KSW50ZWwtd2lyZWQtbGFuIG1haWxpbmcgbGlzdApJbnRlbC13
aXJlZC1sYW5Ab3N1b3NsLm9yZwpodHRwczovL2xpc3RzLm9zdW9zbC5vcmcvbWFpbG1hbi9saXN0
aW5mby9pbnRlbC13aXJlZC1sYW4K
