Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAEBC61DB9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 28 Aug 2026 06:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DE3D40475;
	Fri, 28 Aug 2026 06:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j27Z7oY3NW9f; Fri, 28 Aug 2026 06:57:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787900260;
	bh=OKmExH/1vWizgJD6te4ffAszCA/TJfWZ+U/NPcU/cwM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OCr2V98wrG7nGwNT4jz7AQX+EMHl+uO+QcHjhDGSh9kebydXd2zG+lf8F0SkmZKuh
	 L2QqzGnuNJmfvpJQlTn2unVMA4uJjyWukHjGtKMnZsbmRupOImhnAjkmunOFL03pxv
	 6dsJpwrUHLxvzRVrqwRjrgOEKLU8Yc/1DHLBkNPt7Z06Ibbgc0VUZ+pUD38sRfQ1NV
	 unS8+SZ0P/ZHfbryyreYEOP0VQs+6wXJ23Y3520Wk9woYzVC9L0MPx6YLvDuVPhRAp
	 WnPPyrOiM3Nl3Tc2NwYZU7sA3WLyF/rrcY/06p/znH/nMDCBRMdApqZnSAvLaCi9dr
	 DkF40pYbHym0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8E87403E3;
	Fri, 28 Aug 2026 06:57:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A87E978B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 06:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8ECA0403E3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 06:57:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6FUccUpjC2J for <intel-wired-lan@lists.osuosl.org>;
 Fri, 28 Aug 2026 06:57:39 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZkYkih+z
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B72A40386
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 06:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787900259; x=1819436259;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sfu2ZgXkf5C8iipDZOen9NR5JXDCv+xnh5zXTi6jyj0=;
 b=ZkYkih+zVesKYY0I4/cxiI9MXSrUsPEgEVy1px+AtjILA7Wwk0iOOhnx
 22+eLEcn026ZetRby6ZyINkzqFWp6/dMLQXUUpFHynurna8qEyJUq7LOf
 B7HZ4Zo9xzAJFQ/9dRHc8MceOVwnwnjUD3iY/JyGDTuR8gSsEDSQGU8El
 wc3PGNYyJa4PkczKanmle2bZ52MI8L8SN0/CcuWcHp+Y1yw3UzlC8TzxH
 fLXNX7ulkBFovyw4rt4KmtnmuIMuS0bUIl4b9ZfKGrmwGUy7L4zl4bhW8
 5edjWswVSaANdpQ3fov414n1QeNp644mE5BSVpEOSa1SCPG3dJgdSgauq Q==;
X-CSE-ConnectionGUID: aHH/amf+TGy5fhO/xGnknQ==
X-CSE-MsgGUID: 7sxFwGJwQu+mCNFHHA1kCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92219491"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="92219491"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 23:57:37 -0700
X-CSE-ConnectionGUID: VT1hGQxuRpiQNxFlbjkDPg==
X-CSE-MsgGUID: pTUm68ybRrKXtaGLthHyGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271602201"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 23:57:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 23:57:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 23:57:36 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 23:57:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQTPl5vQs/220Y+t9Ihem/PX/VPq3hBERlFHXFSQ5qrE2rTzAnZqFSUgEI9cdWct7+f4TgTWuC/FxyVpKCvQsjqy1XwaQolilF4qiA66UcrJ87wIjscWCk0q6QtxbZGI90viKNBCVZnaX4Nc3JfKs0rY2Vmdp74FqHW+cUOv7+oJHlUXbxhfcWd4fY/iuGZs1/R48NESs7fuqc4DknZ4A5GC+H5Q+N0VZY2Qm4C/v63MOR0Mr9Phz8opJL3nqpP3emuhchZmWjlaxkyzWdULZ6a9tEcc1Z2bo6NzdiqGjl3ZceTFeISGi8874yRHWqusXzMhVqYcFKPP3NaR/t/1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKmExH/1vWizgJD6te4ffAszCA/TJfWZ+U/NPcU/cwM=;
 b=hVakWxsWVTi2rOYGv/FEzgRFgbUJbs7G2afahmI+8jv+stj1hmrvXJMItV1qhci98pL2BrPOyoijlRrl5/Sh9HouA2EqA77Ztc5RFRP4UK9S9kmZBNftZeBaecSZQqKWBnuXUInROY1H00CbCuefLMgs7ZBUDIKATZ60mMkieSohbqhSNVWeg2+3icPFe8mkYJ14MG2vmK8rAYG287TUIhnfidYtzUBMTiDo/to72iB9Z3Ft5BXzOO2x00d/buTAOvnYK/PHu6giScC4fYZCvDXyEpnNvxqPU0im07/m6GQdpw4HC9MfxFK/wOoXO4pq3GIB7NhHxHc9VRh1I/i4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 06:57:27 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 06:57:27 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Pawel Dembicki <paweldembicki@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next 1/2] igb: detect M88E1112
 100BASE-FX SGMII mode
Thread-Topic: [Intel-wired-lan] [PATCH net-next 1/2] igb: detect M88E1112
 100BASE-FX SGMII mode
Thread-Index: AQHdGFuLcH/Op4za+k+yi0QHZKnTubazMz/Q
Date: Fri, 28 Aug 2026 06:57:27 +0000
Message-ID: <IA1PR11MB62414ADBEA79DD610FFF8DDC8BAC2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260718165213.3620511-2-paweldembicki@gmail.com>
In-Reply-To: <20260718165213.3620511-2-paweldembicki@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA1PR11MB7725:EE_
x-ms-office365-filtering-correlation-id: 6de192d8-9e16-4f18-1b03-08df04d19f26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|56012099006|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: CTvcT7eDurh+OvKJ88Dg9lpoI8YyKUMcIVGkYyxXV7h5cVNbxYR3jBHzNF6gc58aL+aCS/oU2OJLpS1DvGt66esHmz+y8ZIYWKVAY3C4+KggiemI43JeQce5XvKqnQ3KgosOfRW/hakqio1gkeJd1Nb+jwCypnLWB27BVuTxp5RIcQ+vDms7nOUPS3zEZkeXM0AwD7X7py7PazYf53JA7yCBsFHKFpruqWiyShU3I6Bp7wTw0IdvmOOneLRre+th5F6pgn8dnBB48NpE6w+zPm5jxmr2VFRAK26nBUlabm8UsB6+Ew0Trc529oUWX8ttOtV6OAfdyJRMVfb/l0bRFZAl82pDNMf+xtH4LkMsNUIFqTdczau68euZ3jFCH1ZFUuGGDy0JbBMd2mNBvSzY5zasi7quy3gZLVuLjywTur8tXxNy38GAgRsN+uCeAO5WXPs/nRFN9kmwJshauRBEbvEu5kfMk1Xh1duSMEzEU4RtLX8Ju5eqz2O+ckHhf9Gq5eyI6i8pbOjWQ44/Uyx0SWWzSjvwryCUJidKrkFEP9hUqDqkqH1K2KAf1uqNw6uhdmOG2NQ5FgXe48XPACVAjkeW3hovJoknkI2hi9+qnGOY7eeXuqtva/o/e4oXQmn+MBkg6kA/9hSvpWjvFBc+r3nt5M2x1JEmgswMY3+HXfa6Ie50B1y3FYD5mNgR8PYOr0V1biX8TrObzEgp35p549DzsCnnLZ1u6QUFZU0BzFM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oUXNEpY3SUHXCGaVOhsPbDf30W5qVpZazZBA0nu/MW5Wdix7uxs8N52K//0F?=
 =?us-ascii?Q?X41v9OTBEvhRmrZ3agvqTtjBTM7EgORcY9rLh2znF86F13B4IEvPNPV7XSn6?=
 =?us-ascii?Q?yznThxs3567SaW6lEJlpfyYBDjFtU5gAZ0BADp3jbJwg3eYW7zsg0XbzjZVn?=
 =?us-ascii?Q?k8rc90TLMOQKe0cengqLqJS+/ry55dFn3ihO9ZMW6ugO5IR6ALJjxGVGihuR?=
 =?us-ascii?Q?rRwZKaFwprX5NrB6Gl6xHko9FCUwrfpjQK45kI/VyIwqhbTnYvZJEFZtbveC?=
 =?us-ascii?Q?nOWsiJ1G2euPVypz0aty/6qM3FQV0T9KMj1PKRD2dmFjHUwZfgrl5YuDUPaw?=
 =?us-ascii?Q?9X17CphmI88Y6LSR2w5l98YPW6Zr+B8fDjFMK6B0RgsiBwcKVoSPtDTWI+uG?=
 =?us-ascii?Q?pVUnC9lxXp8m+1DVLRbdW0u+iOZZzOSrBVlTDuXDE0HK2gIiYYtqVkSdEPV2?=
 =?us-ascii?Q?wN/Inl4HioqJrvLe+7sTMHq2Zuv8gh7M6Ul7tOULl8ZNWQQazRc8iiuQ4F/2?=
 =?us-ascii?Q?voyMH3GZ6fxNDuYzsO2CgiL5r1bzG7RWwiw/3SmeYtT4wnqTEX07Q4f9n7Bq?=
 =?us-ascii?Q?UPY9t7ZUqayP0TGT/Lped9vgQJuyAUcObpxam+GIaPaIUWkvj63lkmHb3dpS?=
 =?us-ascii?Q?f4eGFIsR7bBrOB0eCy+3JeeV1CXO3sNIhfLIVAEwSsjfLMh89pL2wbKMRG+V?=
 =?us-ascii?Q?mAHR6fAvioutAG0MJNAlnWwoykiu6625a3YWm6hewv/uzLI6yw3wWy4B5gjg?=
 =?us-ascii?Q?OgyVPCKRETybabvbcZLOgd31S0CD/+aIjVw9Or+G90LFhf0wVceiYOAYyizP?=
 =?us-ascii?Q?bgFD2B6yiOM9hUOrVYKzeoQLaSyZ2BFkdZXq2DiCrjK5zt0AaojLMGD1cVYJ?=
 =?us-ascii?Q?oB7KkCBAwIgkKrAd9JyuPG4V6nFl0ahwiYq33SL3r2dCz1CJUoYIxSGaNdn6?=
 =?us-ascii?Q?5R6+wS6v7ynJT9Uf1XKPCxkLyc89VcTfcvxdPC7wzX7upiZAKgTRsufX5y3s?=
 =?us-ascii?Q?j3h38iQynnrarKoGJMTCSJW4veXcmouLkWVcMHQhJ4h86+1VwMKScjfpqUrs?=
 =?us-ascii?Q?KQAvPXKK8fp1p8x7Wi6BTYrqHxFJEHXikOJIRXFGwTyZTPd6Y5nqB4azIBUt?=
 =?us-ascii?Q?bitQ9dCLoEB1f8PfulkWqKN+a8hdmM8lbIjL6HAZgAe0AnjT8Y1Bw+S8kcom?=
 =?us-ascii?Q?7WACLDpJdIeMR7hKw5uBqwlP3YArAQov9ZFzc7zarksitNBZptf/P0Myxm/0?=
 =?us-ascii?Q?ohKNt8agW4Z4G1Q6b+IltutQGtGzdLizBYUgSU+ERBmw6nXsZDdn2rNsBTx8?=
 =?us-ascii?Q?k1nxdx5BZ2Icu57+HqBHnljgxC+KA+ZZCS2uPuCN2Weq29OkvOmFt2OsJofX?=
 =?us-ascii?Q?G+sitIHOOIj79tTqbx6NuZsI9JaYfVqSt+Rpc9JYGvQ/k0HjNeqPIiV8q6Xz?=
 =?us-ascii?Q?Lgrwn9pcZkx0E0FvG0CFZFyiyAutKv5BRaSEQGaKnJHYnpRmfSFkoYRT/8b5?=
 =?us-ascii?Q?IwXMn52nfCENNq/H4eYgmAzWs1Mc0tOWuomDHOoChhexxX/KOHer3v1ZjDmy?=
 =?us-ascii?Q?ZkwKKKwevey21vC19vY4C/5//6lJ2zoL4wZeT2JrJljq20n5OZ/looqbioZU?=
 =?us-ascii?Q?7B/uGbIAsDoiraAlpCN47dXWS6U/Z60zuIxbJ58Ykqm71J+euxFQKAvQ23e7?=
 =?us-ascii?Q?LYZh8fT01d6ls++4AOAD+UqhdBOLood4T2t5nHB7kX3qCZIL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XXVkhYPZ3EOHUsZsd8LPynFTIVyIlLPnQiaeE1lcANfq/OfM5asdR9XKgVQGBbNa+T2VVsTfMeQ38hU66un8MJcpo8+U4CSiRFLagn/z1S0Hg6aRmYFchJAAi6XrPnitm6+B/jUWv9aYlZ8Try0nFm8nkQyRcwlYEhAgIv68aZHSFsqU3g4wi2E+Nr+NUYWqctUz3Rux/jHt+tumpgogEo4wFGGFEoq0YoO0ywjsK6KKAI2TiQL4fWHS+G/tCilUYQ6KxBgyGlePKuSVgoucoxNW2Z7pHuBqFmiFcouBY3G4NCegl7xlAmpu4eSDNzYEspYW0MndyhIbjXE3PahuAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de192d8-9e16-4f18-1b03-08df04d19f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 06:57:27.4440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckrd5Zx45r9hF6KPijr7S1q4pdG+t26vIpYYIuwoAcP9Cfl0FvJ5QGoJ0ImsOa8gYUD+ZRiWvZaFxzT90hgs0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
awel Dembicki
> Sent: 18 July 2026 22:22
> To: netdev@vger.kernel.org
> Cc: Pawel Dembicki <paweldembicki@gmail.com>; Nguyen, Anthony L <anthony.=
l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; An=
drew Lunn <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; E=
ric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo =
Abeni <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org; linux-kernel@v=
ger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next 1/2] igb: detect M88E1112 100B=
ASE-FX SGMII mode
>
> The M88E1112 can be strapped or EEPROM-configured to bridge SGMII to 100B=
ASE-FX. In this mode the driver still needs the SGMII PHY register access p=
ath to identify the external PHY, but the MAC link setup must follow the SE=
RDES media path rather than copper setup.
>
> Decode the M88E1112 MAC Control 1 mode field and switch the I210 media ty=
pe and physical interface setup callback when the PHY reports 100BASE-FX mo=
de.
>
> The driver only observes the Marvell mode. It does not program the
> 88E1112 registers or its EEPROM. The board must configure it through firm=
ware or straps before probe.
>
> Assisted-by: Codex:GPT-5
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> drivers/net/ethernet/intel/igb/e1000_82575.c   | 12 +++++++++++-
> drivers/net/ethernet/intel/igb/e1000_defines.h |  1 +
> 2 files changed, 12 insertions(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
