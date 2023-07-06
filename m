Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48F6EB64DC
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Jul 2023 06:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AC2060F7F;
	Thu,  6 Jul 2023 06:44:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4AC2060F7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1688625848;
	bh=t0EOvzx2Fe7Y69PKS/EgvGq/oF30vFvVPUEEG+aDdzM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gNGr8vFxbADPgqkZ5Xaryu/oechZ1CA8KVf8zJ5sBzfk8tkej/Lw7e+i1jADilqAm
	 ANbgS/GgcQpAQYtdxzB54pRmTvTgfdYtI8DRTcYthz6bC+ClFyQYMIbqE0GyFt+sIm
	 LZQQOH7brFwlh48L1kXkmGdfk2R1IB6UthDp2OHNm1k57MaZp4nKP695JdNTfmafyI
	 bdxQnKqVLipEcx6FAvLefP6tveX+DlW2IohNkJyXpIzJKoQjjh96z5MIECNzehlNw9
	 HB+g3k84yEAoXQqW2eaadtMJJ8FUkXoERbJ4gDGdNEi7i6ImXuyk+Z5UDUqBU2Mthv
	 XB/PEOsRMRlEA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ltNvv9sKwGA3; Thu,  6 Jul 2023 06:44:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A4F660B13;
	Thu,  6 Jul 2023 06:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A4F660B13
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 98BE01BF3B9
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Jul 2023 06:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B72760B5C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Jul 2023 06:44:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B72760B5C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VVhs3o8SMRLr for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Jul 2023 06:44:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E400B60A7F
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E400B60A7F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Jul 2023 06:44:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="343851556"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="343851556"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2023 23:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863988311"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="863988311"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2023 23:44:01 -0700
Date: Thu, 6 Jul 2023 08:43:53 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <ZKZiqTzTvE4pATqg@localhost.localdomain>
References: <20230705040510.906029-1-michal.swiatkowski@linux.intel.com>
 <c3c7bd46-5fbb-b11c-2f6b-ab108d1ee1d0@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c3c7bd46-5fbb-b11c-2f6b-ab108d1ee1d0@molgen.mpg.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688625843; x=1720161843;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=odkPhiodI0sR5/e1NdXixWj2wCvO46ORM+eZOvGyN6A=;
 b=E83tsUm1CjNLaC9pXALlVJbUryiSdLeZ812VWxOK8Iax0Z4O7iwIITyc
 5VEQSKMT5Bap9BATWxoEeQhEw97POTuUurb7vf+V3LD8djxRUMToAHvPw
 UJhEkiuUuy7ESSO/FVB+hu+cF8TWoaqdfume89mqdCRnYQflluD4jBrTw
 Jql0YPd9cIDsjVvWaSWa95GEKnunCudj724N8OwrAS8j4cKgQ5S8RcrXP
 huhunxFHo+mDLi/tdNbApd61bZNfPEtGOC/VWO22QS4HxAqsTyxjxj4Ik
 MaOoanVhoR0cgJlddAENKxSPHyrmdV++TDs72w1/eBmAmGmmU2QNa7Jbq
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=E83tsUm1
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: prevent call trace
 during reload
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gV2VkLCBKdWwgMDUsIDIwMjMgYXQgMTE6MzM6NTVBTSArMDIwMCwgUGF1bCBNZW56ZWwgd3Jv
dGU6Cj4gRGVhciBNaWNoYWwsCj4gCj4gCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLgo+IAo+
IAo+IEFtIDA1LjA3LjIzIHVtIDA2OjA1IHNjaHJpZWIgTWljaGFsIFN3aWF0a293c2tpOgo+ID4g
Q2FsbGluZyBldGh0b29sIGR1cmluZyByZWxvYWQgY2FuIGxlYWQgdG8gY2FsbCB0cmFjZSwgYmVj
YXVzZSBWU0kgaXNuJ3QKPiA+IGNvbmZpZ3VyZWQgZm9yIHNvbWUgdGltZSwgYnV0IG5ldGRldiBp
cyBhbGl2ZS4KPiAKPiBb4oCmXQo+IAo+ID4gQ2FsbCB0cmFjZSBiZWZvcmUgZml4Ogo+ID4gWzY2
MzAzLjkyNjIwNV0gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNz
OiAwMDAwMDAwMDAwMDAwMDAwCj4gCj4gW+KApl0KPiAKPiBJ4oCZZCBiZSBtb3JlIHNwZWNpZmlj
IGluIHRoZSBjb21taXQgbWVzc2FnZSBzdW1tYXJ5L3RpdGxlOgo+IAo+IGljZTogcHJldmVudCBO
VUxMIHBvaW50ZXIgZGVyZWYgZHVyaW5nIHJlbG9hZAo+IAoKV2lsbCBjaGFuZ2UKClRoYW5rcywK
TWljaGFsCgo+IFvigKZdCj4gCj4gCj4gS2luZCByZWdhcmRzLAo+IAo+IFBhdWwKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtd2lyZWQtbGFuIG1h
aWxpbmcgbGlzdApJbnRlbC13aXJlZC1sYW5Ab3N1b3NsLm9yZwpodHRwczovL2xpc3RzLm9zdW9z
bC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC13aXJlZC1sYW4K
