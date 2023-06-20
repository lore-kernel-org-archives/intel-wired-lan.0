Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25748EB64D7
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Jun 2023 11:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9216640611;
	Tue, 20 Jun 2023 11:09:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9216640611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1687259346;
	bh=V80frO90xNtPrVAshsQJJci2SqsxSBYNLgRYY9yOhLE=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GBXDhL+qKuIlqSeXQlj2w2oqRCSMAgLtuaQeroLzQm/EP45XLObyZpurHtsA76oB1
	 uTXW1AGVqlS2SkYKcUPtgkfwlwg1UdO2OlDWwE1bM1evpXPWRiMVBS7juW6VLaI4iB
	 ejEYtwmuNvgKJKYUGPBMX3zxttRgFtTzIViyVbYNQLZHmrdTHVJJNOlBrzqGYEH4eN
	 lz39t8PIIuD1GgneArZFWd2FHfq4wrSvhVxTTogRpaif19BWyBehchs30R+c6Xr99W
	 aYFO2ggIzbreIHJeMc2uI07ZrrBADFTQQs8fhDpCYaV/hbxB+ZCS2xAY9oyN/ld4JG
	 8lwWlugKll26A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3KUdT_iDZUqQ; Tue, 20 Jun 2023 11:09:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F92A40863;
	Tue, 20 Jun 2023 11:09:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F92A40863
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 766671BF417
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jun 2023 11:09:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 491B960BB9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jun 2023 11:09:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 491B960BB9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ITSueT1KiA6V for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Jun 2023 11:09:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8546C60BB6
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8546C60BB6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jun 2023 11:09:01 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D351B61E5FE03;
 Tue, 20 Jun 2023 13:08:18 +0200 (CEST)
Message-ID: <6faec056-c703-90f8-6ec7-ba587fad853a@molgen.mpg.de>
Date: Tue, 20 Jun 2023 13:08:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Lingyu Liu <lingyu.liu@intel.com>
References: <20230620100001.5331-1-lingyu.liu@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230620100001.5331-1-lingyu.liu@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next V1 00/15] Add E800 live
 migration driver
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, intel-wired-lan@lists.osuosl.org,
 phani.r.burra@intel.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBMaW5neXUsCgoKVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoZXMuCgpBbSAyMC4wNi4yMyB1
bSAxMTo1OSBzY2hyaWViIExpbmd5dSBMaXU6Cj4gVGhpcyBzZXJpZXMgYWRkcyB2ZmlvIGxpdmUg
bWlncmF0aW9uIHN1cHBvcnQgZm9yIEludGVsIEU4MTAgVkYKPiBkZXZpY2VzIGJhc2VkIG9uIHRo
ZSB2MiBtaWdyYXRpb24gcHJvdG9jb2wuCgpb4oCmXQoKSeKAmWQgYmUgZ3JlYXQsIGlmIHlvdSBk
b2N1bWVudGVkIGhvdyB0byB0ZXN0IHRoZSBuZXcgZHJpdmVyLgoKCktpbmQgcmVnYXJkcywKClBh
dWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwt
d2lyZWQtbGFuIG1haWxpbmcgbGlzdApJbnRlbC13aXJlZC1sYW5Ab3N1b3NsLm9yZwpodHRwczov
L2xpc3RzLm9zdW9zbC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC13aXJlZC1sYW4K
