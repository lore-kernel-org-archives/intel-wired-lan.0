Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB76C5CFEE
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 09:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6903540862;
	Wed, 12 Aug 2026 09:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ts-nAe6NWY2; Wed, 12 Aug 2026 09:43:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90B8C40859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786527823;
	bh=3NTS4J/hFzoctaOhsUCqQZjjE2HdX+QBxtRu8mIGrW0=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jfd1K0VAq/kjIalTEGI77SJBWfm76/0gp4dNI2h8Zl+aJqyOohocfRlJvh/qeoY0Y
	 r+k3ZtzVOx1qDituC4GwUNMXmMABY2AeApn1nJHQ4olnJHVu5543EMBm6eM3BDpnmw
	 nipFWhfT+OMa98/YXVBROkSPbYx0Wu2exZ22pQgiVPCGKYtRngeYMvi+SvBjGAVKum
	 acH2457jaDyUDvVM1pC2w73WamDhzTx92CkG+aidaHkBB7aUv1ulVZ7A1SagS7rV6C
	 q929WGPmxrN3zmWJ4DN7kmzfsdmeqWdBqOhVMlbPLrkKuGW5SG74V/vgwLAA8tCiyi
	 HGEEU1fx7pf6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90B8C40859;
	Wed, 12 Aug 2026 09:43:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 573E31F41
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 09:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D8AE608AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 09:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id egrh8H1UXINy for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 09:43:41 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8261F608A7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8261F608A7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8261F608A7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 09:43:41 +0000 (UTC)
X-CSE-ConnectionGUID: HvLr3lB+SDygcl5QVK7AYA==
X-CSE-MsgGUID: mY+dIigmRrKXnMuifWupyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="89600919"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="89600919"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 02:43:41 -0700
X-CSE-ConnectionGUID: CRS+C4gRTMy6BoQwFi/cjw==
X-CSE-MsgGUID: 0q9IQIztRn2MXR3WBsqjOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="257397030"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 02:43:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 02:43:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 02:43:40 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 02:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wv86gCzoXA/Ld2GqG27YzERT0f++sZzUEyuefILFSpynci54AMBPv8gnQK+4VOXOxp+Mr+a/qvJTEQQ9qby0jDnM4lTxAoo/R51wuYjUlRFRzvLVmG5N3Eab5bWcm/1BgEsp1J3/h6UzMoMQi8+38TmAsvF9SyoYQKAH5dkZziAmaF8mIU587xJlmz1nq45LJxv4CyWbPLTdVsRxpZYP23SlwtC/+sBYaqL7cJmHFZWWjGenNIzk0OM+NpW1U4C5BL12wAjFpWSAGaLIokBWGGJsfSy1k42t6wELKQMUpD1YqMQ0xHUCcoQYUAQRZYN9+sLxfJEfmeelKyqz2APMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NTS4J/hFzoctaOhsUCqQZjjE2HdX+QBxtRu8mIGrW0=;
 b=Ws9GJGW8OkMsOd6W29yAEiUeHjh9qs14aNFDrLZLeM2RSBqZ8ZaVNtD9R0yUbEHRX9VkmcjEyh5a6mXRY9HkusLfSAweon/PxbPpavH+Q36VsIfb2kOBk1/ua9rlciLM+g0IAr2dwQ3MA2nLAF5gOL/0hufrkYMrqh/svq52LayzHcrH684TBRlRBjLwjg2Cyf1cbGW+rZo2M5xqJCcB3295YqU0dSv20g8pB5ZmFVRLoiJFOBo4eD2p4MTUZpDUHG1Vea7Jm9EHD9vnckH+3eZMYFQBZGe+qZhVIAkOWPKBjnCAI0MyzFb373DdSC5WaMIZMSn1p6kkAjGaKUsxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by SA1PR11MB8596.namprd11.prod.outlook.com
 (2603:10b6:806:3b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 09:43:29 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 09:43:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Ertman, David M" <david.m.ertman@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix incorrect LLDP
 filter assumptions
Thread-Index: AQHdKdW3s25Ql/VIx0+0hmVMUHgh1baaKlNg
Date: Wed, 12 Aug 2026 09:43:27 +0000
Message-ID: <DS4PPF7551E6552D93A383AE955F62439C9E5DC2@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20260811181127.1142095-1-david.m.ertman@intel.com>
In-Reply-To: <20260811181127.1142095-1-david.m.ertman@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|SA1PR11MB8596:EE_
x-ms-office365-filtering-correlation-id: 542be70d-d9bf-4f64-0f89-08def85629b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|7136999003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 3spvPGx1nFUw3c5diBS8V15hvVixzEl5tA8UmDvm3ftV5lf992kqgrIL0c3vodMPnFfJJoVxBxpxpTNGmtxd/Sxmv5Bz8TnChb6jPIEkIwI+WL7OBj+NmbVhqL5d8HPNTajCcRevTskc5RCGASTvJjGISHM8MImkaoSqgbvdp4HWzeemNZd5g7fdWHWUx3alEIvVSV/bm6KjgCixy7BKitw/WnFHBZCgIFixZ6YaL5dMmLC5mAToxxLGLVjBR1srii8KKOk2gXWrOObidJBwAzAV530VEbt07U82YmQv7SAsHj64/rCiiBDQQw3egjm6Yuuao45WAsRPfrYW4KYboobINe9Lpm1Cl1ZzgWp5UT/erUkjesIhr3orus/PHfmtQTRcY4FLFKZvIWIYrdmvpKdEZG89bBEqkiNcYBRp+ZlZEkeYbdFGj0G4WqMw/cqupi/kqeE/jwJpzcNxXCYZk9MOOvm96POMQVemxYzE5xaKfvjQO6fyZ5OKBOvWZAXBIYp8NWwaW42Wdip+1GQzt7EPmC7TLYPXryV/RQalMXV0u0Hy0rUlGOhRAWbPgvBxGMN4os1JHzuAZJzcLdxsg1kO+KsF2BuNnnpyd2QbNnql/erqke8/HZ6kaTfD1Tr7wOv8vTJ/fX5Ox9tjL4grh31GLneVxMYYpjz9wb9xDzDcZCCdlGD4IiewEQisBQoxCwIAJYtGdxBqsQYkvnDvUXYhbQs+H7/5or7+QaCkRBc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF7551E6552.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(7136999003)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/nLV7iy13cMz4spQ1y52S6+qkkEFfgrPu5NUObL6v7UUWUMXQWqKYCAKjg6p?=
 =?us-ascii?Q?TDA2YvoFbm76JEClpClhE9m+NQ3E1WTavm89QpFg5/6vQG03P/05RvC6iz9D?=
 =?us-ascii?Q?cr7ndhu1cc3mV0JeCKbUfzt5jk1d/WxPYCgSNQq3StAd7JWEvBLTrLdusnRv?=
 =?us-ascii?Q?pASUUL4I31CdOwM2h0z3jRh69/c3L/3SkFmvMFpS+5WSefLsbAx357q3scc+?=
 =?us-ascii?Q?UftO7Icx+ovG0kCz9Qz/d7oTrjmxsPEDs3lwbhaw6QA1lP1AxxiW563noQXT?=
 =?us-ascii?Q?EpQjofJ3C1IV54SSdYKdLMGF58SuSgtxjUYkUXALF6iEJwuezA3cRSOhYPv5?=
 =?us-ascii?Q?auEcH1V+c5IudHpAbdrG9iOzy0iKP6C3B/uGeXI/K1aHF5C0QcyaRwYmX8Uo?=
 =?us-ascii?Q?F+CuOrvlNnRNl+uXErT2wrj25mLclFVbO5wA9HluK7IUHW1DF9rt3SO5aGBc?=
 =?us-ascii?Q?ofJa/L4UiziLhq3SpYcOsZStpvv8l3BfwFqlj5N2EDaT/al3uhH6nf29BbUh?=
 =?us-ascii?Q?ave9Xb1iNnfo55EuckF/ASJkiYpUmHoKlNUnNdgzh62Lmq7WgZ3W8cCq+1/w?=
 =?us-ascii?Q?+nSLNgn4wkuHnj0ORzviFp+lezhut6DW10tgC/wdUsaZsTGmRsdqfmPp9jIo?=
 =?us-ascii?Q?j5sKJ6262k6snAwOLNCv/YtU/KIBtZ2eZXvuGlYYl4eBZ2aq6jGStJAgSLIz?=
 =?us-ascii?Q?LoN81VELepYkxfpXOeW5y3Lqh9wmRiDWENfBWAnMIn/cYDXSUBiZ/fp8q8LH?=
 =?us-ascii?Q?pTENhRtIjZqFdxufEkPol1AD/J5mx4PmaBwzRPmEyboaQ5KyBl08jJZOxzU5?=
 =?us-ascii?Q?1jBwHfbtgO0LqlaaN+DMi/EG0Hs0X3Ba74Bzf38YDFTmIROMGIOBSZ1Et9Bf?=
 =?us-ascii?Q?edhDITvaeakNwLmiO9nGO0rIchfVGOz842SQsqeucmsbNQuUMZAIwFiD9irg?=
 =?us-ascii?Q?PetMV3wgO5ryPNWhK4dyF7i6a7YRRJL1zr5RtaZFvHCNVLIMiBWzOykavsTx?=
 =?us-ascii?Q?x38wnMa3ghbuXXgYeH66P+gzdJ2Z3MXFx+jYzcOe/VEH4etRve93BqqXjbsM?=
 =?us-ascii?Q?BuaNCl6K2vD6CQGj+o/J5Ca/fKLKFEDYT8XYEQ5vrY36Ls/CHMJjNKfOFl7X?=
 =?us-ascii?Q?tfBKgoEKeLWVGJh1IcvoYnTMoCmNAEXQiV9dko4/A+Ycs4dV/HWVdPg+Zdnq?=
 =?us-ascii?Q?MKOEqqXcMliEjFMOPjgG/c3PrX5FtQ3b7pw+zTWLXkpykfFVHDgpdAzwL/ul?=
 =?us-ascii?Q?dx2UbhgTATChbb2gvuglx/QfZ1a5yrleGl/ZzqBpJYC5947zXQZ5GMOX25Pw?=
 =?us-ascii?Q?uApYHe+3EFqyBQeBRWFhmV+rgVhXNHL52VN4BNx0snAEiA0pEMdjALEOxvej?=
 =?us-ascii?Q?6I5xslO9zwlf4duZTIp8S0hGGXEVBctQP7nTWMACaAfoA1yVqbOA2pWCZPGt?=
 =?us-ascii?Q?95SKiCHOcmgx7vtrqZwJWfL82wW67mLMzn0Yx6mSQkq9BYuVqgqdotFABEgX?=
 =?us-ascii?Q?8C1sp172DWbY8LotRRFrY85GGGjGXQTgfrC0taDiTTyKd9S2uwagMVnXJZo1?=
 =?us-ascii?Q?bFgTLHCEIM8qbaHrhsKqho4GqhBaRtB103vDBtm3RS48m0BrnJa4HOzr4Gnv?=
 =?us-ascii?Q?d6nveWhswLBgGv7GL/HXWUAjkOMJiTskckGivh7zIqEqe1Y55RwY3bSAiN+e?=
 =?us-ascii?Q?jNb4lWVW1ne9ll69nIqvNYFhUY05QPEVPf85Nal/ICyY4gPM0lzKw7YgUIdz?=
 =?us-ascii?Q?a681Jvu6zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XeS3c18UHGvX+kZZXPSsqt/jUNTbxfwbz5wCz+JTj6DQumhsh066joe53Rv2DL3Ah6v+TuqTOuxxj9nyMRzF4EJEnOAoq1T6IW3t09A953RzEqr/hvD5a9ksz/+E0/a+hRlPdUE4IPYTnwNZ61xppcxR5PkkzRRxfc+TEFYkbXdkW6vC4HD2a1+b8e5NUFq1qpH9ManbczxWKHbfUeYA2g52ckJFJwonMl4zzxDVMAD4/AFnvsIYs9FbTDeVlHFoaP0ubX69mFd+WJKij5CDkmkRLJ/36eE09T3zYNp6MAzB4vzUWOkGWu1rz7cE4jwTM0BR8vnJCGL4AaWwFbc5+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542be70d-d9bf-4f64-0f89-08def85629b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 09:43:27.8257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4UBXhoD/KJ5DZWWnzDlCpobT+60BLZ+pBpqc0bl2PP2KZIOXJO+t1xVTqU35J4rD0r3sqH8sjESXzg4CllY+nGtSmZd7U6wrg4plN1ABykM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8596
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786527821; x=1818063821;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4xATDZDV9Uc8KARJfy3Tt20MvkfC69DO7BeWenpx1IU=;
 b=nRVNxuD0Z/OIn4feBAFg/aHSXHkaisSQenDW1kempNHpcL7/9T2xT6ZU
 8UH0h6tvFi1kWzFZRSXa3MPSrQWM9rKnJbyoWKTM6hRtZZICk/Lg6iqUO
 xNZbU3HDRAplt8tc0VpOJWfujDFHtIjiHE8N9ZiLkX6Jq31wOF6ENFJJB
 yjJIHclzKcjVUYuGwUUp9bG6X0mPWVjbOesyuekSjiIIs9tI6QdNjlKcN
 MjanXEjgfudctw8t7LObDNPnKHNet2F7C8VwjhIAMFlze7J3Wl4kAChko
 1mvw5foYgoKeOOWkOtO1jXFZ0mbHiJv3PmiYGUX7tX5Li+Vp3mbmFpoVK
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nRVNxuD0
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix incorrect LLDP
 filter assumptions
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Dave Ertman
> Sent: Tuesday, August 11, 2026 8:11 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix incorrect LLDP
> filter assumptions
>=20
> In commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
> necessary"), it was assumed that llpd_fltr_ctrl was a unique
> application of a filter instance and the other command in the flow was
> generic.
> This is an incorrect assumption, they are both meant to add a filter
> to handle LLDP packets and only varied in the actual AQ call made.
> The newer AQ call was created to handle a special case in some NVM
> images where a LLDP filter was already existent and the old AQ command
> would generate an error if a new filter was attempted to be added. The
> newer AQ command would detect this case and instead would add the
> current target to the existing filter rule.
>=20
> Fix the flow so that the newer command is always used if available and
> only fall back to the older command when that is the only solution.
>=20
> Also remove the obsolete state flag from the PF struct.
>=20
> Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
> necessary")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h     |  1 -
>  drivers/net/ethernet/intel/ice/ice_lib.c | 18 +++++-------------
>  2 files changed, 5 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index fc91b6665f90..7eaa3d1e78a5 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -522,7 +522,6 @@ enum ice_pf_flags {
>  	ICE_FLAG_MTU_CHANGED,
>  	ICE_FLAG_GNSS,			/* GNSS successfully
> initialized */
>  	ICE_FLAG_DPLL,			/* SyncE/PTP dplls
> initialized */
> -	ICE_FLAG_LLDP_AQ_FLTR,
>  	ICE_PF_FLAGS_NBITS		/* must be last */
>  };
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 8cdc4fda89e9..2fe91ff8119f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2090,24 +2090,16 @@ void ice_vsi_cfg_sw_lldp(struct ice_vsi *vsi,
> bool tx, bool create)
>  		status =3D eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_TX,
>  				  ICE_DROP_PACKET);
>  	} else {
> -		if (!test_bit(ICE_FLAG_LLDP_AQ_FLTR, pf->flags)) {
> +		status =3D ice_lldp_fltr_add_remove(&pf->hw, vsi, create);
> +		if (status =3D=3D -EOPNOTSUPP) {
> +			/* If fltr_ctrl not supported, use legacy
> +			 * add/remove command
> +			 */
>  			status =3D eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_RX,
>  					  ICE_FWD_TO_VSI);
> -			if (!status || !create)
> -				goto report;
> -
> -			dev_info(dev,
> -				 "Failed to add generic LLDP Rx filter on
> VSI %i error: %d, falling back to specialized AQ control\n",
> -				 vsi->vsi_num, status);
>  		}
> -
> -		status =3D ice_lldp_fltr_add_remove(&pf->hw, vsi, create);
> -		if (!status)
> -			set_bit(ICE_FLAG_LLDP_AQ_FLTR, pf->flags);
> -
>  	}
>=20
> -report:
>  	if (status)
>  		dev_warn(dev, "Failed to %s %s LLDP rule on VSI %i
> error: %d\n",
>  			 create ? "add" : "remove", tx ? "Tx" : "Rx",
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
