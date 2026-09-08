Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B740C79FA0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 06:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD050404FF;
	Tue,  8 Sep 2026 06:19:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aYll_J-6Rk3h; Tue,  8 Sep 2026 06:19:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 44437404EB
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788848362;
	b=sDTANqvjwni3gBpUW7Oqe6sxkZCyzl5i2GSSXVRPceTlKPpxxEwN/T1VAJJqrfBvohLI
	 zckH4bJVZYXsXLJGWHwasw6LS5v6aKcUtZW+2qNzGicdha2JTTyij/AY2sVfB9rSyXljL
	 V745XjIe3tqgqK33vCgU61qOH7R7iXPjajOl7DG0f9f2aFcrCQnpZ+t4MQ6Ljja7KAQH0
	 baH6Ax+iPozEgbJYSxah23qiQ8yGZfIZf3j6PfykhEzaNp/vspYnr0hFobvDihsMkwxAv
	 lrQoHaPb+Be6DEqnoB3ESTfgmUT+6CTfYgcKeyFWHjtAkFOWg/irI2kHsyzow3uK/BQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788848362;
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
	bh=KMnMTScWD/6vECpME4syWzx9y2zG+X0T1b+GO6HodFE=;
	b=jLNCpuAZWItIovNAKtusEMF4RrpD8taFEVIyJkp0EjBBEOnMktRpE8J5KjJYMn7tYvXS
	 gqQl+BrceVvV/buwZACnJ/GuQo2nGoTCf2y5lhs8jOKzhvbXyoUREwKbQcxYlQM54ZVY8
	 Z69lNjATLURSvYRP6wm10cWnUwEbVIhPstFJvaU+00zfAtrcDzwt0ROg0hUT5pta0yGaG
	 5UTFgWe2NxVG4WWBIDONUuZeBSEv5pTDWI/54Qb37gQUsV/CSbHIL22fn5xtPNif6yKbC
	 RAhZCPB3nXW6ij7yzmDaJrmPjqfus+3OLC1pkr9PKQmDmdx+xCuanUEPFiUzc2a2fxw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OnB7AQ+U;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788848362;
	bh=KMnMTScWD/6vECpME4syWzx9y2zG+X0T1b+GO6HodFE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9Bo+AE0MJyNcmXzYHXJvxgBApkN+I0dSYyqPNdTt+XyYujetfWQazzqWijMihxwLm
	 ygNJrp4CCyNipLfL8UttGLVLRwdh4SxmvBmQBiT8eQJA8P6E57KZMhVhoGfgfmlPm7
	 RJ5B/Z+WgVk8xdRa3cjaHSEVpTLjGKvr0HQ9ZEeaBLGFVs91PDEAx+y4etYBvTjNbe
	 1NP4kTuq1BPlUc04wWrMsd7Ppe75urzp9otG/ZT7L70rMAVbv9VcnaSg4HZmQdtvjQ
	 oeTJL5B060w6Hb7dBt15sgu8HR/6J+3w2p2wjvY3NOB8YROudpadzaKHYkbkhMrRPe
	 Y1zdZBM7uX4XA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44437404EB;
	Tue,  8 Sep 2026 06:19:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AABA1AEB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CC5B404EB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZshDId7YaqQp for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 06:19:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3763B404C1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788848359;
 b=Z+vdIkracoBe6gPzl0JW4JrTSkAQL9knkRfRaVmghrgmyRDNVUdBUv1gebmBQoAXa5Oc
 IkpvCYSGfU/lF5ChsMYTfBZ862OZ/94UppM6JLPK7FUX19Tn+tkk2J7LfJA4kSs8GrGlq
 IFsX7G0VKHh4woLImkJ1/Kd1A2njODSlYUn1LE5dbRaTSIFGx6QttbPwrHhNAamnaEQSq
 H7zdyI/udlYeA0yicQMzSJzr0eTBIfnfWEOc+37CWTPTruLsrJKAbv3QaeyCUNW7WbHtb
 FKI5TzXAIgsw2KFl1fPlMj/o4FvH+Pdsd4NwstuK/7mNLtELuTXEb3mm+jnyczn6AyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788848359;
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
 bh=KMnMTScWD/6vECpME4syWzx9y2zG+X0T1b+GO6HodFE=;
 b=pPzFm8JIZWgfkQki2s/FYsbZn1a/j9DuyZHKyRku4qeBQZn2dIH3cQgjO7Pl6ow+VbDK
 VSqGI72J1iSDymqIu3alza/14cmVmsV3jhUQpueVcES5INl5NPcQ0GvApjT7puIjTgUtl
 59a829NCwrF3WGf++WJNHv7+YMoqrWMjfcUrjNxHy6CH2ClBufzz014XhuOjeiuXIyw++
 5TEKQWrIkLw2EkIfklzSe3gs3VZR42+96Hs1Rr3A5t19lqCJ53mn/q7i82rhzyUY9JFxp
 mghApDpl9sVK2P0igu6SkSpOYknnNhS0THVF0OR9GOYiD4sm5g8gbuYuRppF9xNiaOg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OnB7AQ+U; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=sunithax.d.mekala@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OnB7AQ+U
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3763B404C1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788848359; x=1820384359;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gKv22u3T8drb3Ctzts4yyswBjzObQYDmwJvzFSmSXI0=;
 b=OnB7AQ+UCKWwg+79dt9RDLlzXvlX4BDiFZ5Nlja0zS8hbOLpS/gE0LkN
 eVgJ7bxkE3boBm+2cuKiubI99Va9gg+CRKByruvRs2ttmt68OtrCa7Qke
 bnfefdOTXY8jXDfoIOw9DG5HfRYty7U9koDw6pBff5wiDOgBANLOmyB1i
 zOHK/CxQOCdaP1s8Kl0YoWNmjlmZViDglRqpoY7cWza4B/frkn2YsZ6fT
 v9GC21MO5W3A/7o01ec+x9lg0q9kXRfj9sgImGMzFbDYMkXgY53YBZWl0
 Ch17Ya2RCA7fHXxwcAX1Y1ZUmr4Z3dKkIyr2OWSr+p1oJRZVuzE0aHGs/ w==;
X-CSE-ConnectionGUID: gma7eBhTRbaKm5yfiGwMTg==
X-CSE-MsgGUID: XggoMfCnSpCstJwmRpqlPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100399469"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="100399469"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 23:19:18 -0700
X-CSE-ConnectionGUID: tmbb3y2uQ5SNWv0p7R3haw==
X-CSE-MsgGUID: 5qOdnzYkTwqbp8K+dXSgOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="269573672"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 23:19:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:19:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 23:19:18 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:19:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHXTOcSjzvnqvru8ifollvJkgxeHQ71KMDdiXj/A6Rj8fcT8Al8WG6/7OG0ZXWhwMfZiFs4zNbbnSRqFvbJsiqPxnVuPu0MyXaZBHzqkxQUY4WLPENkxqVveRfW//d4MWhA6y7vkG351Qgbi8hrdXlRuXKnTAjWqM7rQSs3TlU6LDenGk4WX2L6XG7jhx0qk77UD9VkYP4SPIeLDTZDr0Ns+wQjaq6a8C+GNtbSUCW2AnEuA5I7Juop7wcjnVsSary/0tPUyh9gCDCQS6GAc4+fyMiXqeL4ofoDev8Tsowm+1UqYUN8qMUD+CHxf5r2dmFq4BSdAI0zl9FkErDNaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMnMTScWD/6vECpME4syWzx9y2zG+X0T1b+GO6HodFE=;
 b=MqeFiB3OtCDXN0ulUAA6nbGf3WuM3L89gjRdDKEmnZtP7/c+fOqIVLfejFCaAcWxnGvw8rxSW4zU+C+e5djzQw7KlLK7t4ud/GaJ4P6UpnnnSXMdkIgN8fuVQStU9gHX0/EnAs2+CqY5WmMX/ZK5aalJ01F1f0X27ZhlGR3v2BK+wFhsBgFU9qSEMzIpeeQO4LRGjLQPbU90U9qCMEp6aXITEbDks5dBHcXmPAvetIn7In9Bzzy4bq5i6Amhj6dskT2SMHQuORKjyJoBOLSAOsgd2iOjCaQg3CQO2ppxJdBzGWYKtwzovh09oMG7+WB4pgtRTED9CFxrtw0g67kdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 06:19:14 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 06:19:13 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>, Sashiko AI Review <sashiko-bot@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v5 net 3/7] i40e: make ring pointers
 unreachable before freeing via rcu
Thread-Topic: [Intel-wired-lan] [PATCH v5 net 3/7] i40e: make ring pointers
 unreachable before freeing via rcu
Thread-Index: AQHdCVeVRWMJXwAujEOa1QqXFfckr7bEnFtw
Date: Tue, 8 Sep 2026 06:19:13 +0000
Message-ID: <PH0PR11MB752221875E37B71B2D933011A0B12@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
 <20260701124524.13644-4-maciej.fijalkowski@intel.com>
In-Reply-To: <20260701124524.13644-4-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|LV2PR11MB5999:EE_
x-ms-office365-filtering-correlation-id: e625031e-be87-474c-23ae-08df0d711a9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|38070700021|4143699003|5023799004|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: KsR4y2Gl3qU70h+hDL0Xc3ySFFVW0ttJQNowEB5cRBxxsEFi4so4nrbabi/Ljts2XTPzk95cvwWKkZXNY4EgMZZQseCBtgqr7KHnhAri4UWVjbxeiAmlYqzwAEFEBGuBJygmfk8EP9jF+7M/aHPNWu5Q9zvQtob6khRyAOXXcRm7GmLKu5BefYWU01zurse6Fwipb56OFhIUrfItyHuTTGOZfKheT/H8c5rL3vG+MJLFDo5aS3JtIiWqP/thtoY5xjtoKcsYLHtaEUp4yqpdiZJEG1eW37dMqYzaVFdRz9CFM0m/YJAYfL+lF+PX4phzqdpsljgUax24qvi0r9SGyFbgTW/CRQgvvg/h28xr/lz52gbDv81XQR/OJEtotUAotzQ4co1Kk7IOKXmNC3yHGLPNbQNHbsmY/ps0ojxKoRExIuOCdGwJ1ghCG7G1AMmfF39wnzh3tSNMXW/lha5NvL0iGXSaUwBkyhrbQKB96lVRtE6nr3Y5YInv+k347cpVMQp2JPb7XXOQDPiKne3MqNus34g1g7c2QgWUSBK0gBjCV5+2WtboIn2ltvFzvnQBCbxAtOqoMr7Rb3RMAJCMA60bj0eZg3Ws5/9NjAB4MvVJEUkTAU4c8+PS4G5+/9WuGNPP3biQlX6vh+R3n0iHjudbfZxo9YRs5ZMOzyD8wX9XHuWBRWNVuhE8XyJZ/Ndd0GtUJCHjACm/3EgvE2tvanGl6R6Z6qpTnmLjhIMN4rE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ASSQYLGfE0DGJSgrebloXKGhWbY0+0GCdQxnRfWCZ+w0DSKu1k6PtUtbQ9a+?=
 =?us-ascii?Q?XbYtbgra7rm20K2EdM3T7mJRjuGjqC2sdMYstfEPo/banvsAn9LOTFnR8oue?=
 =?us-ascii?Q?wbmENkrV0wAcwE7+9KF74uUwo2YJT/DrZby6kteq9WgOxNtr5jA4clLFjY/J?=
 =?us-ascii?Q?A4iAUuNd3iSewI22jhE7ljEo2HD6ygz7kULSpIRbE2NWb1RlBZDCQNHNBSC3?=
 =?us-ascii?Q?xrFqGG9ZGwtJzFc3C2RU8X3ROAwWguFXzE4yzxrUTjdIUu2ix/JbSQ97t20i?=
 =?us-ascii?Q?XMs9nUQ9wz1WQUusUGT6EyqOic+SMctux9Aod62WAkwubAFp6hd/kKytjHZw?=
 =?us-ascii?Q?XrPEOeeavNZtPac3zD/NIi9ElXv2ZjpFY3CbJpQFoON3I/uhPqs4et0SZhSB?=
 =?us-ascii?Q?+LC1Vkb8MAM+u8butwQM5oIaqjw4cWBLm/MuiYcFh/H7AK3a2xqbJ/J0/UWT?=
 =?us-ascii?Q?HxsEhKcxRmMHeq3klp/YqogdRYC+tQe72m/GQvBxO9fbMkFzqEuLGPSqjTK6?=
 =?us-ascii?Q?uU38oxXFfeEMqudmFRIUceXaOhut5Fx4gdH65QXNhi27mX6+LDwaWlJh5979?=
 =?us-ascii?Q?XIP45wdn1drYm2n3OybiTQXOHNXeh75r1LGE2wjYcK5I3N5K5JdOTR1edT//?=
 =?us-ascii?Q?aeWjzY+njpbLUPNjshEHVroJQPxlcRX712mFo0KOTaic++buLoInsY8rvthY?=
 =?us-ascii?Q?A8gwQWaxT5sVO/RK+DRQ9mJ7fJDfOmwf8RpAQMnHxjzH1RTreqMn67mY+RPD?=
 =?us-ascii?Q?A+kW60M+gn3HRgE9gicpL2EdPFCwxJplQ+m8ZqrihEqYpUYLcns7OQJmjIR1?=
 =?us-ascii?Q?nXcOvIcn2o3dC1eotnWj9Qb23oAem9F9hCDeDCVukLCSqgBASBTJxF1b75Sd?=
 =?us-ascii?Q?i+ETmZ2RNEUKNmwZQ6+w86D0y23YZubIbpLS3W71AUZ60j/Uuur4n7KQ26U7?=
 =?us-ascii?Q?lHgNlpq7wTwTveXY+C+L7XeJLj8Rrfwx4YFLetow+syHFsSO0x/Vhh0mw0DY?=
 =?us-ascii?Q?4QNOQjzbHEgxYmdI22NbOs6NjXjrpra8MiX3Mm4DFlQs/zNQAgN7r3//Ch+H?=
 =?us-ascii?Q?JYJCZ1vY0ol8T05yULiIOEQPGdj/Vk7rJkZjdXgOyJ0OV6uvvjdMR5q1QhTC?=
 =?us-ascii?Q?onE8w2JsBgtdoUV3Kd3nv0MHOgoG1nXkqF4N3bplLBs2425DebvMjPq77SUl?=
 =?us-ascii?Q?vayJLyNngYi64WG9mxcc2YrWpvIp9qtT3q4VpRza0E9oCISS8NSZz67j/w+s?=
 =?us-ascii?Q?U+DGX00lYI3c2qr+exvQ5glmcroAL6IJA8ejN0PprmBGc0WmmCETmTQd9qdY?=
 =?us-ascii?Q?L4fzvKhBf0ns0kEQH8ZPcFddWywGFtt9a2EK1Q6PofeRM/aqs/0BavNOsHhY?=
 =?us-ascii?Q?zbZgxA/c2Ook7AAqiX6YSeTILFfpxDykRU8XTRru85gM/bPsJ97kslm0cLX4?=
 =?us-ascii?Q?VUMB0tOULHlKlMkewnLR3XunDAH+7WN1zd+gbkxALunlrFtCtJTpKvl32Ge7?=
 =?us-ascii?Q?bwjtl6hoHIe/b87kYl8uMeXh3VnD18/MRxAPvwbCB1ObaPL4qL4d4tVzFXzQ?=
 =?us-ascii?Q?YeZ2SxVcat8v87O1/epiv4uVbap8iCp5JhFwS+96GEImDam5lKEl/DHQWW6g?=
 =?us-ascii?Q?QY2mMutJSl3jIwoNTJr62KjHXbUY2GMeWgtORD2ilWx9G8p+JsjurqTcYTEh?=
 =?us-ascii?Q?ap90OYolqkyKgpdy88ondaORmxjRV2LLFkl44Jts4MrlrEXxcOg2nnRj5A+D?=
 =?us-ascii?Q?DOi0K6EKFw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EtZSkagKn7Afzeo4Xy8qSt2bWfsRLto76bYoZDPxlM0SEiCDzpQ8MZv7gGe8oV253uCN1Cvzckcm2mvZbjIPYJ7LsO8dZsvnfKXnge8o3Z19raLAWvQfVCru1REEwKTv+XBJXEo2ePro8n7UWGTuOU9nvBnkSes2WTAdJRpK3e3q1XziZP4YQdIeA5reDiSX+AJQ4jNYOyUBC8XsEHaVJ5Xs3gHSIcuUcyvv4Ny6+2dNIbUWs/VVMyEUoqU0p6Xb6trMIdLDLAugIMZAGHxRjfoI54lA0eZhwsghXS3cEN29hg/Nt7ieXp5s/Bp7DYZxumQEs+d695RG53aDbHYoHw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e625031e-be87-474c-23ae-08df0d711a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 06:19:13.8359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rzQin6Z52taN+G6LSY2h36Sv3EI8IEcUkJ216VofjGOEfHiceRnr1fUTye8Rpmr6+N/owBduXWo+xIiDD4rPoanooYNvNSRsediiV655lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
aciej Fijalkowski
> Sent: Wednesday, July 1, 2026 5:45 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>;=
 kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; Kitszel, Przemyslaw =
<przemyslaw.kitszel@intel.com>; Keller, Jacob E > <jacob.e.keller@intel.com=
>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Sashiko AI Review <s=
ashiko-bot@kernel.org>
> Subject: [Intel-wired-lan] [PATCH v5 net 3/7] i40e: make ring pointers un=
reachable before freeing via rcu
>
> Sashiko reports:
> ***
> >  err_config:
> > +	i40e_vsi_free_q_vectors(vsi);
> > +err_qvec:
> >  	i40e_vsi_clear_rings(vsi);
> This is a pre-existing issue, but can the sequence in i40e_vsi_clear_ring=
s()
> lead to an RCU ordering violation?
> In i40e_vsi_clear_rings(), the rings are freed before the array pointers =
are
> nullified:
>	kfree_rcu(vsi->tx_rings[i], rcu);
>	WRITE_ONCE(vsi->tx_rings[i], NULL);
> Under RCU rules, a pointer must be made unreachable to new readers before=
 it
> is handed off to kfree_rcu(). Could a new RCU reader (like
> i40e_get_netdev_stats_struct_tx()) fetch the pointer after kfree_rcu() is
> invoked, and access freed memory if the grace period expires while the
> reader is still active?
> ***
>
> Save the Tx ring pointer before clearing the published ring array slots
> and pass the saved pointer to kfree_rcu(). This preserves the intended
> RCU ordering, where new readers can no longer discover the ring through
> vsi->tx_rings/rx_rings/xdp_rings before the object is queued for
> deferred freeing, while avoiding a NULL kfree_rcu() argument after the
> slot has already been cleared. Since the Tx pointer is the base of the
> per-queue-pair allocation block, re-reading vsi->tx_rings[i] after
> WRITE_ONCE(..., NULL) would otherwise turn the free into a no-op and
> leak the whole ring block.
>
> Fixes: 9f65e15b4f98 ("i40e: Move rings from pointer to array to array of =
pointers")
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
