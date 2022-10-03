Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4F1C433F5
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Oct 2022 08:42:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9AE354010E;
	Mon,  3 Oct 2022 08:42:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9AE354010E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664786573;
	bh=f9fLAAAmwCLGuHuqp/Eh1CW85HMl6c8GA2pLvitLf9o=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vMXyPzpGlhUEkpiV2cAj1vEVMewkyd7V0dvutLaS7aFlFoDNpkudAgzsMFhfeSWSr
	 xVSwqdlrp71nMyDfTyOJ5tB4RbQER5W8pozEAOwvze79HOUSpL5OrQ6HjEthm2NP6B
	 ofL6BDBgmzZaX5N//0nEv7oYOgUk+Rqn3kjLW9DqAq5hDXEwaYczeoOMDgUnp2BF8q
	 AOi+TyvERX9GEcSUWQonn4IirwtKNksSV5/+CNDUcn8LsRwir8mM4YOhNtrlYbCB++
	 KKiM5jb19mzUzBWhnKf4ymyAg4NWZn/CJ1wLHcSDN3FCMMJNnvmcM9032q1tGA8xra
	 Va4StthbiOPUQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rc_h6TYbIhXg; Mon,  3 Oct 2022 08:42:52 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id A95AB403F8;
	Mon,  3 Oct 2022 08:42:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A95AB403F8
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 8E1141BF271
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Oct 2022 08:42:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7534F81423
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Oct 2022 08:42:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7534F81423
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IoR6P1Ag27tu for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Oct 2022 08:42:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D591A8140B
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D591A8140B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Oct 2022 08:42:49 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aeef9.dynamic.kabel-deutschland.de
 [95.90.238.249])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id ABA4761EA192A;
 Mon,  3 Oct 2022 10:42:46 +0200 (CEST)
Message-ID: <72f9b004-cd7f-69ce-6684-a2f3c2607ce5@molgen.mpg.de>
Date: Mon, 3 Oct 2022 10:42:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Jan Sokolowski <jan.sokolowski@intel.com>
References: <20221003082615.1870-1-jan.sokolowski@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20221003082615.1870-1-jan.sokolowski@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v1] ixgbevf: Add error
 messages on vlan error
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBKYW4sCgoKVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLiBUd28gbml0cy4KCkFtIDAzLjEw
LjIyIHVtIDEwOjI2IHNjaHJpZWIgSmFuIFNva29sb3dza2k6Cj4gRnJvbTogIlNva29sb3dza2ks
IEphbiIgPGphbi5zb2tvbG93c2tpQGludGVsLmNvbT4KClBsZWFzZSBhZGFwdCB5b3VyIGdpdCBj
b25maWd1cmF0aW9uIHRvIHVzZQoKICAgICBKYW4gU29rb2xvd3NraSA8amFuLnNva29sb3dza2lA
aW50ZWwuY29tPgoKPiBpeGdiZXZmIGRpZCBub3QgcHJvdmlkZSBhbiBlcnJvciBpbiBkbWVzZyBp
ZiBWTEFOCj4gYWRkaXRpb24gZmFpbGVkLgoKVGhpcyBmaXRzIGluIG9uZS4gbGluZS4KCj4gQWRk
IG1vcmUgZGVzY3JpcHRpdmUgZmFpbHVyZSBtZXNzYWdlcyBpbiB0aGUga2VybmVsIGxvZy4KCipt
b3JlIGRlc2NyaXB0aXZlKiBpcyBhbWJpZ3VvdXMsIG1heWJlIGp1c3Q6IEFkZCB0d28gZGVzY3Jp
cHRpdmUg4oCmPwoKW+KApl0KCgpLaW5kIHJlZ2FyZHMsCgpQYXVsCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxp
c3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21h
aWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
