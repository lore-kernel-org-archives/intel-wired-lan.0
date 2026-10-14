Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A0BCC6B1D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 10:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDB7B405A3;
	Wed, 14 Oct 2026 10:27:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IgYPZGNuiOXb; Wed, 14 Oct 2026 10:27:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E23B94056B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791973677;
	b=lV9V/ZSCHpHF8Wa8xS7zvEUHUvLb/Nn0aDyRWOvG5E+FM5m1Bji16isqnrXd+wHPIOHp
	 KuTXn8ZaNMAJuYyV4tQ0pTE6pjyZ3n5KuO6T5H1icJG03CqaZyc5bgfWgouLqWKB4FQn4
	 GFuEQZDY3/KtgXL7rQ3u9OBRhO6n40gAGFvCpwd5LnVs+vEa1fnTIbE5bGsjjOn1qT/MO
	 r10t4POS9RRvilBG6sJSpc2sqYeMLqbajVJJhQxPFQ9DfAZyOo4yyNLDPV2zFAGsl8cbf
	 UkhOUnTwRfFJGdPwVOqOu2e0AWT5TBuTqrGEaI0PMLJFQXoIfrp+SMgdc7KwZ4QKReQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791973677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=X0xAcWVe9Xi7Fh35e6Cak0UMDeNR4bJk3nMSAE0Cw5M=;
	b=L+gztiS20kmo9JArbUr7ftFME8S7Ov8PYlbFx49/hhY1DWCw9esHpJ10Tc/ScJYIw9jy
	 npJmJbwNnXqiEkfVvoMxxyno3+QPKfK10aZfk7GP14vNbrF/2Jf8r/JAVx1dP61VHHIeI
	 fMShnwaUSlkhIWPqLzLkCaOaXz79RYeKCAIVdG9BWCsNm2NWwD3vzsDuF75u6SOZzPZ7z
	 FrYtpa4CA1GttENYWARPoOZp3z6OTJ3an1qNN7xe7RBmpq9RVMEH80M2YldRLMnpkDAom
	 lQVJoYdmjDls6XG5HtYig5bC1AFLSytdpI7BjbKZRx3Ruf/py3kozYAv/NR5E0NkAGA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791973676;
	bh=X0xAcWVe9Xi7Fh35e6Cak0UMDeNR4bJk3nMSAE0Cw5M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5pTPfru/fb7B7m1HjJjA/utHe1NwVlxbGo6VLI0CxcPkNIyLAqyFAGo+5eELSgkYJ
	 zHlmOLWMH8NnMBmvW1C2z2fNkKBlOyYvG9Gcemk52o4+wm7w9JP8hJp+stAyVBzGi/
	 neMAZQSxUKIngtQrzLuKH6MkES10C9jpRu4UBITgnEJSq8OygV1UPXrqmaFQ/RABGk
	 gCOCxIrtAL+9MUt5CJRIRDRS0eW/jCGEwtoR7g3E0Hb56K53HrULuEjLkiv4lsR1nP
	 5oejH4lCwpRw+krQzkOXFl7IUA6jpy4eNSqvgDKr8U28Kn25LLEubL9YbZu2cqL9JI
	 OaEMmzgHAwSow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E23B94056B;
	Wed, 14 Oct 2026 10:27:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 799D8255
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F44F6076B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:27:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S2ZtQ2jYV2Lh for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 10:27:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59BF96072C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791973674;
 b=OZU8zUzo9v1s7XXEuGDfbOUtuczl7/EV5OdCZQoFz6d86mfKqdZ0RzN/6iCxO98Tsy5x
 qGHqL3ARbHrgkLiP+9m6uCj/wAiFLXsNJZZlyKBxi7xLRjaKWq7/rxFfY9ecqR2zxX4kZ
 6uVGSLjN3HSH3fo0QV1aTSROvHh95AEn+2OXQ5Hc3vO3H7f7333bETuwyWORUaztXLds2
 pxZmQ6OSSEswJV5rez8rHiBdaKU88c7Pxhg4B68nREBWFiToz8zoPRhETmATbxMdLSneW
 QaQYnooVD50scgKWfAp7IiF4oqUStoY0k1nUBYaTsy6h5aUciT+52UsjtNyQUa0nVKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791973674;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=X0xAcWVe9Xi7Fh35e6Cak0UMDeNR4bJk3nMSAE0Cw5M=;
 b=Hs6dCBDlbZyyo269LItGzYNlpVBntH7Dj6GQvoWHk91zDtwJxiwlWdNPntF+LHWer8sd
 LRfg080nw8ztB6e6JqPVZE3vlowI3oMYI7woqqqWm3hTWEB2LuKH5x0vgnVLwNGwNN+LL
 uXve9ieJjveEwIs9Kd9OutomzdUKdT8u29o6isv4ByasIEFVDq7C6TxCb5ReyPtmDBmCN
 UqDEtzEETubhw4Ac4AHfrUmGZoZhVeUjWEmejeU0V4B3wby0VbXxhbPCpjCnoSAoJCjB8
 rQEGrZd8WFwnEFOYBp07jqAqeiobrpDWiboa/9UlUbUo+n2zkZY7mep5jGMJwZp4NmQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R5ijFxBj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=ayush1x.singh@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R5ijFxBj
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59BF96072C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791973674; x=1823509674;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7JxD/dU7Pf7fD76Re/OpDCxfwMrX596JgKDNSGTwaEs=;
 b=R5ijFxBj8jPObYvHOHOQTgCbSFYt4bw+NhYlrWjX+SGtB+O/kvvfej6h
 6QTsJZWOBdDP0aGG7++LDiCWtmsf4HrrfrOsglMJrPUPfgVlKHD1B1Xfs
 VvaDp8uausmLgFbK86frIOrInlMfhZzlaklnrs6+NZ+Y5zEsMmvW8Oj5S
 zGBS7ciDx00DNUE4/YPgcV7ZRGeItCsSi5e3vm4DLl4Ox9h/gB7relHcC
 8a+97fRFGAczt0NqNiP1KzKiKVg8zDFYrM4KrXr0VLoJckdsoQGEyHnr1
 vD9GZtYs8oa1WfrU1Gx4oKD9IxghJ+I7H8P55+IyXf4Q97pwSJZb0L16W g==;
X-CSE-ConnectionGUID: aAC3rRmKTo+/CE4ltihHrQ==
X-CSE-MsgGUID: thIh4Ci1QiWGab32Hm39yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="707856"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="707856"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:27:53 -0700
X-CSE-ConnectionGUID: 9q+ZR/6wQXWvEgOZkm3ztg==
X-CSE-MsgGUID: APqclEyPSTW9r5QqNfbZVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="3151127"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:27:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:27:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 03:27:52 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:27:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWtu4ES76AtpkqO8jkT9a+kXNc5HkFVSpbAtFyngOYSc+dzsdvSbQ+9QFi3UWODFecopYCgKv7NDPMAiGCWiEry5lX+QVey1Zxwlqv4f19pZYgItlak6dbFtSQQm1O6q0dUqP2IC365edrfkqAdwqv1okP3j/9hI9c+OPadswegE0OxU5VYXHW/sN9TMz9YNcce+3Clv0eT6cbDTdTV5xFZiKNaeFh77ScEMpT2jlAkhLFUtfQHwVSXxhlBhF0hMrVzi0E9+Hv6CryBzmN3fDtBfzeX5DKqXjkOgxoCnhXCMQ7aqgoykqKrhSt2gzmLYFXrfJyCMNl+xuJl7fF0zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0xAcWVe9Xi7Fh35e6Cak0UMDeNR4bJk3nMSAE0Cw5M=;
 b=W18QAFrvVjKfGcHCheXPsWXDp/Xhj131HUMtsYmNZKieszsgzV7yXfeKphGVVR0Him1vwspfSriefqRteE5QadmWZWRxU4Ul/oiQe0zqUi57ELPrKpN8B3WVbh2jm2s+702pnLOvdEHL1+H9MwcXkdLJTivUYswKK5E3SG6qosbMIi0BxjHNJ+IxAI56FIFUK7Ti2I8maS2YVspc1I3dnlTkuG3+Sv9+q2XhUdeHV1vmJFXYVTR1LYapZblOIFUq2hy4KN3odyjBTV0VpQ4T8qDtQB8ERS7SDMH+gyXyOEWOf0uERzXi6Xurg69hPpP4IsdwMJCcpVAjE1MmP8EWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14)
 by DM3PPF17031675B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f09)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 10:27:49 +0000
Received: from BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4]) by BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 10:27:48 +0000
From: "Singh, Ayush1X" <ayush1x.singh@intel.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Henry Tieman <henry.w.tieman@intel.com>, "moderated list:INTEL ETHERNET
 DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH v2 2/2] ice: clear Flow Director entries before reset
 cleanup
Thread-Topic: [PATCH v2 2/2] ice: clear Flow Director entries before reset
 cleanup
Thread-Index: AQHdPr98uBGBLMl3vEStvD0C6k9imLb80LkA
Date: Wed, 14 Oct 2026 10:27:48 +0000
Message-ID: <BY5PR11MB39764768CBA4F6512AB6E11FA59D2@BY5PR11MB3976.namprd11.prod.outlook.com>
References: <20260907115221.926007-1-aaron.ma@canonical.com>
 <20260907115221.926007-2-aaron.ma@canonical.com>
In-Reply-To: <20260907115221.926007-2-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3976:EE_|DM3PPF17031675B:EE_
x-ms-office365-filtering-correlation-id: 0b5e8cfc-da7c-477b-b073-08df29ddcb63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|4143699003|38070700021|921020|56012099006|18002099003|22082099003|261009223027099003|10067099003;
x-microsoft-antispam-message-info: HJOXKbUFojYNpm2NNd2bUPJRGSfVe2JA/XD/AsMK3eBfVebMq5eEw8LU5NQ4/1NUt2f7cuW+Z5EuDwceOCq+cKvxIJqwj+JWPM1zcF7X49gfuZ1TVeepwcFhOFx+jnhjJ7TwHaf39Op3CMNw1bKiLpInKmiQTWzNq+jA8qKO8NCFeg5ni/862EjppYBWkWjqXvq9pmMIKOB4bfxNePmQrvyxdl0xYz2+CJqzH6vsuFghE8/wUv8objPPrTLnLFhY3EFqRStOs8YSFK1R+tghEWeypCC8ED1VizEfwRa2JscqkjbD3JjgjeG+xjBKwdETDUlrHUxA5bHG6uE31u1rrC7wkJ7BdOU3CZT28LPLDsd57+br5dtcgOQXjumeIld1VOugnQ8DizB9iqBIW6oTm1dWN+1H0rnOw7lxeTr8/HUHUQI1RgKcZa/Q0UY7zFjn026F49L9wHGzFF3GicWtopnyU8enNr98T0sbkJdrOmdACCjX1yRffsh1WwjbA/b7j48mlVyE6kmQ/MIaQ39m1nxJVoK6S03nHIWBD6CHQ+hUkxZiBxeSfLfXVGpkpi+a8Z5MbY1MSYLxWskcM+R++3eb1N+7JzSaZOwifSaRjA+xyFeW2n91rIaQXrXvx6XiW1BQTGzcqwx1QvJvdD/htseOXY41HtwUEOYXN2zbVKFtb8MVbnQSNdiJqRmFXL6V/KdNMhCEoIzBTDrRflvA//Q3fcCQGJtNx7hf4lyiiItBySiiDvg9+k6gzzOGadWq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3976.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(38070700021)(921020)(56012099006)(18002099003)(22082099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U2Jn4O8sREK2FTCvDA88sdOzDVilpQ4yN1X/sExH+wFFAAVwYtWfsUcMsqvD?=
 =?us-ascii?Q?998bOfF1xOWVKjUI0XzkF88+taLQe2EBISfZvSxk1rpkfo3LBxDrXNHnqmPo?=
 =?us-ascii?Q?1ycIEAsJXlJa4XGmcLHFnn9W+GMbwm2jdclUhupHIYMhesPTkERhjYW88ANZ?=
 =?us-ascii?Q?HlbA1HjKSqhL0Z2OaVqXrEPH8jZDw9+aFceQ88/AWVmJl41Jm/K5HgULPWKC?=
 =?us-ascii?Q?EJ2jSeC9HHbfPQnH29w74XajWLvskOiF4K+IobyyF9diIuHVQ9TD0tuAhbko?=
 =?us-ascii?Q?B5wag9CUc0A8/h5kSMNgNsxcsm8Zq5Riy74p28bBs1bE8ySCKzn+9pn1Z3gh?=
 =?us-ascii?Q?ar5m7hVmDd9yOKdoXTyRDZJZGoLe1GdoXKhe2xMd5JVvsoghAPi8JCGeJIE9?=
 =?us-ascii?Q?L9MwTK8JO2mlKuBJ+EkKK1a9F0AMe7Ec76UQxmmt+b9eT4zLOcTwikj6RM+c?=
 =?us-ascii?Q?TVV6itCX2zam8cQSmrwf+JoJo60eRPpA7Vh8JcmXUVBknDq/hVeqNbpZsCjp?=
 =?us-ascii?Q?ANjbh7l8UUup7wSATMoDWt/LJ18FV82Je3UUe8gOWzxdR400srnQ8k3gxigC?=
 =?us-ascii?Q?f4z5SlRahwfj16B8rAm1SbpFjR2Ij0znJNvJKnGM0hCihoo6zc11hejYew2T?=
 =?us-ascii?Q?JOqcGsbGM7Ktky86ouajD0CkcI1NmAA9vT2mscd4cMulBKSJMl7NKxOfkJbU?=
 =?us-ascii?Q?9NRpkIfn0VttLkaGKrAn/agJxkUDxIulmL/0PeH4M3j92iWN+PCts5mMqk75?=
 =?us-ascii?Q?t/ZVSL0yVMcMSACNEWx6kSchbwBT11AzWevVDUVbEQTvy8Mv3vmVG5E3BDQm?=
 =?us-ascii?Q?AIHqb7VfKo2BjfntNxqMexXUi2p9dFfzjUF8EDsnmOTm+EL89GAwKxyn45un?=
 =?us-ascii?Q?J4NcGFzq2wnie0wGQ7UMYCqaf9QWUMo4cuHzg3HfC0TK486QMl8EhftUAof3?=
 =?us-ascii?Q?+1ISql3CffHN2VMr9t/uT5x0vABUFher2mA2bySlvepB+XNsIaDff/3CIKtf?=
 =?us-ascii?Q?dkFhIPbZ/LWRv1eYsdlF9tGVBnZNjMjWRMeHR6UHVMP96g9VFyTCk5I1sZ5x?=
 =?us-ascii?Q?xH7QQI08oDwTZ38oochZyQM58zKLCB21As30nUd8WHZy23Y4hSX37m3syIjM?=
 =?us-ascii?Q?+xkqqmxr8vflYANjdiV6mwEWUwIu8+n+A6WVW1qjyAbPnQC8r9JcwYVdLZyQ?=
 =?us-ascii?Q?hq2IZjXcbhA60P0mVUoAQm6l+nv7p5oSsV4Rmd7NZsDvdnUvr0xE8SmWbID3?=
 =?us-ascii?Q?PG6+SzFJZJ6dft87ZGuyvY1cfJon+QJ0KMpatiFsz6bP24Xk/7NXtxjhVz4x?=
 =?us-ascii?Q?TO/rAo2/TLRgEgTqaWlC3FAbxNAKc+Pec32joKmiSmOKV+rJ56Mnk2cs9a3V?=
 =?us-ascii?Q?J3UmqYCmBk1pSfkYIMbL0yDatRjqXxPNwNJCenm2muzWa0fT3Nypw64AFDCn?=
 =?us-ascii?Q?L08L0PGRjyMBQPmvZtK1VDMwQuzieq7btEC3lUrO2+gkBA4f1zdYQwSA6yYP?=
 =?us-ascii?Q?DNX6qnKQmz1pBU+9lA67x8TEIVJkC1Be4SGjRdOkAb2K64BsrDruyc2EWc2E?=
 =?us-ascii?Q?tnl/kz+UVnK4l6rtmsBr5AqfUlENG7t/472mc3ILOpM3W7PhFm30NaHSBp1X?=
 =?us-ascii?Q?WsJGmMhfzIMuyLG/l78wYbLD659MmoSNPt8zIOj2zMe9HlWg/pLgJprHhvjg?=
 =?us-ascii?Q?MeyykJJ5CYfLEhl26UKooE9HvvX5ImPhFHhuj08LaJEXpTXVWhNqFWCGnVla?=
 =?us-ascii?Q?EACOhcL/Fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QHxb8OQleqMW0L1+2s4fNMFpScIY0hlRQu2p9V7m16gXtDpALJY3jb6fdK1ve2D2U7sUGPc0Ob6PVU9ifUTvfl8HUeBBSrG7LrU2R0LN59EmaHlHL2CFYtNvLONt2r5jGgCShzlrRAsJK8dSxpJn6d5hnrxPAkNFQQhQvFQNsIzVVwlO30cfT9dUKyQnd6GkPyderLYDL323hX/g5CLyu62lJct17CM/PJmSBUd1L9AjXoz5mYZyAcN1nU+XhLK0m576SIwnYWRr5viz+BWkMzV4bR4JfWPH9XU0M5uOULCXiIceKKDYmwuvpMaEJ49tDJKME7XnUXKuW5maGjwd8A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5e8cfc-da7c-477b-b073-08df29ddcb63
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 10:27:48.5954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aL1Eewbi1zusFlpd6yfXowiqz3yGqHdiTbljJqgEyy3QFv1n83Htnri3/d5aPsA8EhuRrr95qwm3S8VoKshlZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF17031675B
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org

> -----Original Message-----
> From: Aaron Ma <aaron.ma@canonical.com>=20
> Sent: 07 September 2026 17:22
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; netdev@vger.ker=
nel.org; linux-kernel@vger.kernel.org
> Cc: Henry Tieman <henry.w.tieman@intel.com>; moderated list:INTEL ETHERNE=
T DRIVERS <intel-wired-lan@lists.osuosl.org>
> Subject: [PATCH v2 2/2] ice: clear Flow Director entries before reset cle=
anup
>
> Flow Director profiles retain handles to generic flow entries. Reset call=
s
> ice_clear_hw_tbls() to free those entries, but leaves the Flow Director h=
andles unchanged until replay replaces them.
>
> If rebuild fails before replay completes, later driver removal follows a =
stale handle and dereferences a freed flow entry in ice_flow_rem_entry().
KASAN reports a wild access to list poison from ice_fdir_erase_flow_from_hw=
().
>
> The failure is reported as:
>
> KASAN: maybe wild-memory-access in range [0xdead000000000108-...]
> RIP: ice_flow_rem_entry+0xaf/0x170 [ice]
> ice_fdir_erase_flow_from_hw+0x1ee/0x420 [ice]
>
> Clear the Flow Director handles while holding hw->fdir_fltr_lock before t=
he hardware tables free their entries. A successful replay installs new han=
dles, while a failed rebuild leaves them invalid for later cleanup.
>
> Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> v1 -> v2:
> - Acquire hw->fdir_fltr_lock in ice_fdir_clear_flow_handles() to
> synchronize with concurrent ethtool filter add/del.
>
> drivers/net/ethernet/intel/ice/ice.h          |  1 +
> .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 26 +++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_main.c     |  2 ++
> 3 files changed, 29 insertions(+)
>

Tested-by: Ayush Singh < ayush1x.singh@intel.com > (A Contingent worker at =
Intel)
