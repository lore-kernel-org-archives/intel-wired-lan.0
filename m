Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A25C10F05
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 Dec 2023 13:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D19741EE4;
	Thu,  7 Dec 2023 13:00:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D19741EE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701954041;
	bh=qwjvUT2xMMya8EzPhly1GnDhDieCB3lOtJZqPU7s6d4=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Blm+B5wDDPbihSwgheWBMV0yKxtRgW/+WJWHe7eRo0QnUW/DG0drtGU67rKfcz5w0
	 GDCqKqKfjPszpdMGT6bXbRAEETwHu0QY0cCrZdDmBm6scf8rJ4eDdfK9jbzAwqZ8Ys
	 uf1l9uJNqgirUyP3WID10a15bUQea4HMQj5WLpjLaqSabpgiPghfXf0eJhqp2p9Rpj
	 XVnzA63tr5wLGPTddS3NC3MVpuNvCL+X3vDA12NE5Y9ytHtFe0i4V2JpAP2QdA70Si
	 ZnZ+XBm0c2IeYw08AKnVJpP2s+XpncynROu2FnPkysmfvKLevR50D0OKBWN5xsioK4
	 OgdPpJ+KMAS8Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nsYqkKIIOVeo; Thu,  7 Dec 2023 13:00:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93D7641F5A;
	Thu,  7 Dec 2023 13:00:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93D7641F5A
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 6ECFF1BF38D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Dec 2023 13:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 448594032A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Dec 2023 13:00:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 448594032A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FYJVzTQwUTfp for <intel-wired-lan@lists.osuosl.org>;
 Thu,  7 Dec 2023 13:00:37 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 07 Dec 2023 13:00:36 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D83EE40167
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D83EE40167
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Dec 2023 13:00:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1092306"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1092306"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2023 04:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="945022813"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; d="scan'208";a="945022813"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.214.195.94])
 ([10.214.195.94])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2023 04:53:26 -0800
Message-ID: <04cbd377-8b3f-4013-9d6b-71dbfd7adaef@linux.intel.com>
Date: Thu, 7 Dec 2023 14:53:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 linux-kernel@vger.kernel.org
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-4-ilpo.jarvinen@linux.intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20231121123428.20907-4-ilpo.jarvinen@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701954037; x=1733490037;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=ZiHl9FrPeon9v+0HakeSLaCOj/bdmgwLi2bMYXzJSUE=;
 b=bmhF0Pea+mbsaFgxWrUsvb+nEUdM6YMBO1Mro4XZDGu0NOzCwa4dNyEj
 TntAWanNxzowv6oSlAnA/80Ur0uFcdfdOiTOqCOquQAk5k+2CniOKDwYR
 sKHPnF1nFON8mkTWxE1nLaRxatt2RciYrXyh80yRBIK58DULFkskP0nwv
 xRj1WfdKQdgUX5IZqG/gAZJ/zYlvOJY0k6WlYBMGZy9SYHKcKbZJWNulL
 2v2b5Xl/9eYk60kTb6Bj3gKx0D0KbPFdvLv34ML4Ce9ZRWizv+tqV5fhJ
 UuWyPBLzjGvqJM96gLTEvwMpgQ9v7cCLD9oH421zgcjDXWJdg3CGKF7zS
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bmhF0Pea
Subject: Re: [Intel-wired-lan] [PATCH v4 3/3] e1000e: Use
 pcie_capability_read_word() for reading LNKSTA
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gMTEvMjEvMjAyMyAxNDozNCwgSWxwbyBKw6RydmluZW4gd3JvdGU6Cj4gVXNlIHBjaWVfY2Fw
YWJpbGl0eV9yZWFkX3dvcmQoKSBmb3IgcmVhZGluZyBMTktTVEEgYW5kIHJlbW92ZSB0aGUKPiBj
dXN0b20gZGVmaW5lIHRoYXQgbWF0Y2hlcyB0byBQQ0lfRVhQX0xOS1NUQS4KPiAKPiBBcyBvbmx5
IHNpbmdsZSB1c2VyIGZvciBjYXBfb2Zmc2V0IHJlbWFpbnMsIHJlcGxhY2UgaXQgd2l0aCBhIGNh
bGwgdG8KPiBwY2lfcGNpZV9jYXAoKS4gSW5zdGVhZCBvZiBlMTAwMF9hZGFwdGVyLCBtYWtlIGxv
Y2FsIHZhcmlhYmxlIG91dCBvZgo+IHBjaV9kZXYgYmVjYXVzZSBib3RoIHVzZXJzIGFyZSBpbnRl
cmVzdGVkIGluIGl0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IElscG8gSsOkcnZpbmVuIDxpbHBvLmph
cnZpbmVuQGxpbnV4LmludGVsLmNvbT4KPiBSZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8
Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvZTEwMDBlL2RlZmluZXMuaCB8ICAxIC0KPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2UxMDAwZS9tYWMuYyAgICAgfCAxMSArKysrLS0tLS0tLQo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpUZXN0ZWQtYnk6IE5hYW1hIE1l
aXIgPG5hYW1heC5tZWlyQGxpbnV4LmludGVsLmNvbT4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtd2lyZWQtbGFuIG1haWxpbmcgbGlzdApJbnRl
bC13aXJlZC1sYW5Ab3N1b3NsLm9yZwpodHRwczovL2xpc3RzLm9zdW9zbC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pbnRlbC13aXJlZC1sYW4K
