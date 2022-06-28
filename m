Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF5BC433EF
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Jun 2022 10:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A468540598;
	Tue, 28 Jun 2022 10:49:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A468540598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656413387;
	bh=xLwoTdZRqysSZTHeHxPxjpOuqY8TbiuPiWCivngBUpI=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=UV2F2YH5qKOqKmo6ZD2IfGDRYgHukp/OzZ6r9+jg/ih3VWiEcTQlR99eVd355on/U
	 6BS70S3XAf+SbP7Wu9twsaaeX8StQKYATQmXnQ74lfKRiNG7UOgJgN153p9AgXYLY2
	 xxvwoLcZT89BVubrrD/K2ckcpvdEej+6j/vfVz/h1dcksKJ5Ow2TXw4r06LIuHDDrD
	 CsNuRlvb53W7KCwZy03kb75l3IV0dSQC8poKLy8sPLNjULX0d7uui3yjV0GKWk0tNE
	 IsleXpbRVVeOj2Gtyv+gW0Wr08AbtfBiOQCZkJSpTmGsMnIn5fZRxa0hV0GLPahCx3
	 oZCS9+0hUWJdQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xIIH91ZQq5HA; Tue, 28 Jun 2022 10:49:46 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDD1A405AE;
	Tue, 28 Jun 2022 10:49:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDD1A405AE
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id AE80D1BF599
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jun 2022 10:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87BEC400BF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jun 2022 10:49:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87BEC400BF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CKp-GYqsRLhN for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Jun 2022 10:49:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80F0140598
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80F0140598
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jun 2022 10:49:41 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 46B0661EA1929;
 Tue, 28 Jun 2022 12:49:38 +0200 (CEST)
Message-ID: <f1bc6014-1743-ec50-a719-639890ed6649@molgen.mpg.de>
Date: Tue, 28 Jun 2022 12:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: Anatolii Gerasymenko <anatolii.gerasymenko@intel.com>
References: <20220628104354.4195-1-anatolii.gerasymenko@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220628104354.4195-1-anatolii.gerasymenko@intel.com>
Subject: [Intel-wired-lan] Patches not threaded below the cover letter (was:
 [PATCH net-next 0/2] ice: FCS/CRC stripping control)
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
Cc: intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBBbmF0b2xpaSwKCgpUaGFuayB5b3UgZm9yIHRoZSBwYXRjaGVzLgoKQW0gMjguMDYuMjIg
dW0gMTI6NDMgc2NocmllYiBBbmF0b2xpaSBHZXJhc3ltZW5rbzoKPiBJbXBsZW1lbnQgcG9zc2li
aWxpdHkgdG8gY2hhbmdlIEZDUy9DUkMgc3RyaXBwaW5nIGZlYXR1cmUgdXNpbmcKPiBldGh0b29s
IGNvbW1hbmQuCj4gCj4gSGF2aW5nIEZDUy9DUkMgY291bGQgYmUgdXNlZnVsIGZvcjoKPiAtIG5l
dHdvcmsgc25pZmZlcnMgdG8gaW5zcGVjdCBGQ1MvQ1JDIGNvcnJlY3RuZXNzCj4gLSBmb3IgYmVu
Y2htYXJraW5nIHVzZSBjYXNlcwo+IC0gWERQIHByb2dyYW1zCj4gCj4gQW5hdG9saWkgR2VyYXN5
bWVua28gKDEpOgo+ICAgIGljZTogSW1wbGVtZW50IEZDUy9DUkMgYW5kIFZMQU4gc3RyaXBwaW5n
IGNvLWV4aXN0ZW5jZSBwb2xpY3kKPiAKPiBKZXNzZSBCcmFuZGVidXJnICgxKToKPiAgICBpY2U6
IEltcGxlbWVudCBjb250cm9sIG9mIEZDUy9DUkMgc3RyaXBwaW5nCgpb4oCmXQoKRm9yIHNvbWUg
cmVhc29uIHRoZSB0d28gcGF0Y2hlcyBhcmUgbm90IHRocmVhZGVkIGJlbG93IHRoZSBjb3ZlciBs
ZXR0ZXIgCmFsdGhvdWdoIHlvdSB1c2UgZ2l0LXNlbmQtZW1haWw6CgogICAgIFgtTWFpbGVyOiBn
aXQtc2VuZC1lbWFpbCAyLjI1LjEKCkNhbiB5b3UgcGxlYXNlIGNoZWNrIHlvdSBzZXR1cD8KCgpL
aW5kIHJlZ2FyZHMsCgpQYXVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkludGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9z
dW9zbC5vcmcKaHR0cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwt
d2lyZWQtbGFuCg==
