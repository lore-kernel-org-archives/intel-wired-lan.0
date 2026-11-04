Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5B4606A329
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=g1BX+Wu5;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SWmeJxgF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F00640535;
	Wed,  4 Nov 2026 18:34:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VS4fl_E1yj_W; Wed,  4 Nov 2026 18:34:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D8F640555
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793817240;
	b=sltIcEgRT4GlTo5SfeQA4Esl8omjJxDHJ9YIK+4prjEqXH3AydnaUl+7JDcLWSHM5vcH
	 CiFoLF1rYxJWnVSiOEt1hjtKyyh2h0KfnWHzmSdxa6VcAusFwTDeLNqV+f2OT8HAhiANf
	 5DoXYZMzE7P70B6x3T85pSSi606kM6C/oIlk/O8h7K43afRwoK0xZPUX5atNwDpXEJcNK
	 hZvR75b1byHxQox3q96ruM0QBTx4GTaDj3X53uv195p6Rojp1jw2+cxFtkjTRd/BKG8vp
	 yU7qUcFk1pfwB3pTVofgIF4drBsHVAFPTaVBD0/odMqLcoUP7IvdvkTL6vchbDPwtCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793817240;
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
	bh=mwbGUjDQ/SQwLG2Jkfg6o9j7gYIaIO2dQ9DWqoqPauQ=;
	b=WM0VkM8YfFqe+XGG6eEDYtPF8vdRSsdMfo0gJxO95kMDnBHVCqgn8AqndgR1MU+bX/uN
	 vuNsB9Zoe5kuXRBe7kdHfMU7kzvsMaJUzyUgWxPMvXjcmWz0HoZ0qazQkwNR6Ltki/D3p
	 v+R1SQlQ3J6KS3A8fcXYc1LvAQF03346jy12Ow6VQ/8PPeS59asa6krRoiwpydXX08Pvi
	 gOG5pJOGpVi0EEWcANTorXG2HikcpXJih72SNgavTAUV+Ld/9xOvXGSc2F19gUILc4IfS
	 2PrxPjxGTzyQ0Z2zuFnlPAjQWpX3q7jvlL7J3fWedwbXDvXIPcGJK01YdGm+yK1tnAw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SWmeJxgF;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793817240;
	bh=mwbGUjDQ/SQwLG2Jkfg6o9j7gYIaIO2dQ9DWqoqPauQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g1BX+Wu5nlWMDPh6HYgBt0RKPR55+0tUaSydoveMtIiPVorraL73l47IEDdAmRIiG
	 evy6z+MB4OHbBcR+xqvQ4+7mPBjtF6RTu5Pncqgur5iKEePX1xgsXw8F7HowwpQjIO
	 7lSXMKJ9TDEcinVgcDYpoCkur9gA1mNhUsamhLByUo7BMe8rcug1yVnWtEYjwewT8n
	 BBXcJ9hJ6yLK1ETAs3TNEw9uxQqoVFgFnSmuiQUOhXomxuPpUsXOBAvuSDbhzMfth7
	 IPRqCOre1zsbr5dPO1a++XlY+5V1sBFwlzjV1JULWqtCNiGbPyKqEPcDTG8B4GYxg6
	 8gOzPHKOkfXfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D8F640555;
	Wed,  4 Nov 2026 18:34:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F12851788
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 18:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2542409B9
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 18:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kJzk03NbEfuZ for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 18:33:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E51F64088D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SWmeJxgF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E51F64088D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793817238; x=1825353238;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=32vyRA+XBKkBVlTsoKSXD4LfAZxt4LSRAmtNtKI+dnQ=;
 b=SWmeJxgFI0tfWjA07toW7wcfMxtCcoR7pW8BZBMOaSvz6tpEShr8mBTW
 8HXkBVt9co0lzKoEnolyrXz67c2YZ6Ug8H6g8MvBv90XLyaJIcJFQChg3
 3YUbyKpo2nJrYpMqNnT+QhnVfMvXqu2NTvYMcnewYgivxvVdMJajTyJ9n
 gZ3QE2HVTcaVfC/DaM9CVovzPfwk7h0fcNviZhpych7dywmqryXvteQsW
 uvjqbm2TYmS3qVnXOTLGfiLHwF8DncTFO2p52oxFd8MXA36RDDxoAppzG
 L7mN4i7fcWah9uiQtFMJI4VuZg90hUmzI/VmrL3PmeL2Axjgujb6M2GWd A==;
X-CSE-ConnectionGUID: Ejg8JMrXQEyFao2T8uEFeg==
X-CSE-MsgGUID: tPIKuRBWSVSKDc/eoZdbvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2601288"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2601288"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:33:57 -0800
X-CSE-ConnectionGUID: ulJgxBazR0y/p8/c2vTHaQ==
X-CSE-MsgGUID: avOXnT4DSUqtRaw/4HnWDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6938955"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:33:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:33:56 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 10:33:56 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:33:55 -0800
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by CH3PR11MB8705.namprd11.prod.outlook.com
 (2603:10b6:610:1cc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 18:33:51 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 18:33:51 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Burra, Phani R" <phani.r.burra@intel.com>, "Zaremba, Larysa"
 <larysa.zaremba@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
 "horms@kernel.org" <horms@kernel.org>, "brianvv@google.com"
 <brianvv@google.com>, "decot@google.com" <decot@google.com>
Subject: RE: [PATCH iwl-net v3 0/2] idpf: fix teardown races around reset and
 remove
Thread-Topic: [PATCH iwl-net v3 0/2] idpf: fix teardown races around reset and
 remove
Thread-Index: AQHda/E8Ny5ZoNjrN0Ks2waG9hHJgrcePgZA
Date: Wed, 4 Nov 2026 18:33:51 +0000
Message-ID: <CH3PR11MB5668955CB654A99C93A394895FE5682@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261103235354.1063721-1-emil.s.tantilov@intel.com>
In-Reply-To: <20261103235354.1063721-1-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|CH3PR11MB8705:EE_
x-ms-office365-filtering-correlation-id: 877ff977-6f8d-4f24-20b1-08df3aa22c65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|11063799006|56012099006|261021121427099003|261009223027099003|261021123027099003|261026140227099003|261022075727099003|261022105027099003|261026121527099003|261102123227099003|261028144727099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 8qUgcUxJ1VGrDIAsl94eUhEwj8e5srCvZrFfgEUJzgxM0AiwQBYR9qVk8AgTCDAefwC/sGyx6K0gYZCpFPReIf/cQom08NC5UZCY+J16mSQKzmLtQ9lBWHG2Ihsy8G/v4j4MecWlmClppNvRLZJ7NTi5X0bt96OY3IqcsA28Ao2vSILuJv8V3je+9ANSV5lDH9E5Cm7TEYTcQNetaZHsDAugsTTmJKCQygwTRzneid8aJhprisSoYQHrzsPLrXpqbtBDFiP0YbJJQJe8kb438b0tsypFoyHdP//hI8nOBxS01cOL7+2C/SI3icpRwrVXtwL1A6Y2o6bniAgXq0sx1czCdlC5xkjvkrWPFHW/TRw3Wdg5aP5LREOZYVwH6XvqcqIJ8u6MKeDoIQtYqee8cBOTPSkhEaDm6f0Pu3uvaLBnhtUTNKTPHT5Dy/Fc/y2j/0EEoVs8w/I515buFIx8AZDua/ZcVh3A+CPmzH7JllbbkLdxoBHbAA2uL91SxI0KoUIi3nUCHAaLcN5NgC1IRAaZH78mwgxjALMakFlGuGak000mVNBaGNC2aJfVzjEfzRrW5Zd909gZPoEgaJXyWJER/f8OjDfRdV+36daPcomCXs2a42GHcTdjtktB9PejIdowehmkxmrhPVW7FqS+27IJhcyHefQ+YBAdu7Km+M4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(261026140227099003)(261022075727099003)(261022105027099003)(261026121527099003)(261102123227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/7c5StmxVj7hrR2Hrt3r7BDA/BdWgemCozwnOZt6un25U4IA7MYxy7Cp8wKo?=
 =?us-ascii?Q?/5baX1hXKGvl8hHH/b+Eya5d1TPuffgp/TpNTXxRVntrSUbaDi2boCzvO4RU?=
 =?us-ascii?Q?G880DTWNSibCjmJKvL7hSnszgC+mifPOZTGBDeRUpCNEhz9NkO6bCrxB6LIU?=
 =?us-ascii?Q?KIlpHmpj7PDEwCL7STVwMTuMnXB08ulzGJXaTeRJLpeijT6HGhnQWGdfpGFP?=
 =?us-ascii?Q?8EhMd5pJBFG1TD9CN7vgAA8ogv3Vznz8lvtrFbQ37DgZqviedess8JLSJlbp?=
 =?us-ascii?Q?o6tRjZq9ZFE6PVelttUQboCw+Xrd7feEn0zjHxup/608wW+1AdeGT6gT5Nqb?=
 =?us-ascii?Q?B7TAolRmf5MUjy5L+0vqykrX7tvg0DuZpcoTHsJFja2giGh11EUxUP2G7PWQ?=
 =?us-ascii?Q?z4Xx7o+yWwtX67SbCvHFKJVH4R7zBny+XC2vZCb6AMcGEKYbVcgiTkm+Ix1m?=
 =?us-ascii?Q?K6K7vqpVeiCiav0Y3NV21PbnmtyVChGPw/muHpE6abx55qt4UzRhpM0mYvz5?=
 =?us-ascii?Q?Y84kPLY/0DvUYccTNir07Nz8MBrgSuZj+Mt5FDlJXWQo/I637Rg8vMD8z8kd?=
 =?us-ascii?Q?qCo+7kdP4WlgAHFMBbJ7XLFlvA/NNWrba+S99+mxKIbEJa+2DIVzSFnA8/oR?=
 =?us-ascii?Q?1Yxwvhl99StC/tsPNc40rLsQh97TTl2PoduIaXdWtTJS79tkd3nS79utY4iS?=
 =?us-ascii?Q?awKz8IEjSg8oUJbKKZcbvrAihMSzJWeXUOYS7ab4Ewfx2PfUaQ3eRVcy2rPV?=
 =?us-ascii?Q?IqG8cLfsxAhP2CjYrOdPogSk3fAcv1qjMlLpXYMLcjHnYelu9Qg3ZReoeOgN?=
 =?us-ascii?Q?lCi7a6SfYYrYgCyoowwpLW8vEQ2E0ClzvXg1hFjHv83TQHzhS4zm2bEE6seL?=
 =?us-ascii?Q?M/ohpFMivKN8oljaE9DVfknReObPFPZ3txvOSqE/L3qWQQ8V+bxDjq7mgxqh?=
 =?us-ascii?Q?fD4DMLzL/9+fauRkIBqN8r12Xzon5EBe+ohj9qRozA0nT/23QRdG37o5n+bf?=
 =?us-ascii?Q?TkH4DFwGrbaNYCKbGbdkIn4Gudk8SD7R2tIAzpImAyGcOJKGSBQu2gy6Htr4?=
 =?us-ascii?Q?uVnHwVKVOG3bzISWNXLtPiYpHVdzSj3vj5DBhBDnAYkv0UsNWhDcm1iOrdVa?=
 =?us-ascii?Q?54nYKRzgwXAIGcxGscZ/4RRoEFqOPb1JcxgkpPy8ywCKrT6fbyuHg74gSxgG?=
 =?us-ascii?Q?A01bUC26Xwzfx4N4TnK8WdfutY9SAMdV3gZHb7dYOiloS3DtRhV9z3zBLvZc?=
 =?us-ascii?Q?vvEkWlZI6CfyuRLdN6DCmo2PbmPGBWkqlSwk8+Vd1yacL1svANzdo5Ws9tXC?=
 =?us-ascii?Q?IEuv6+hPJn4BoK31Bkdi6azfaBAd7d/u959mGBfVGOm2DEDUIrNRuk3L8xjF?=
 =?us-ascii?Q?5q6L3K0gxwK6Bw0B/DPnJFi+AU+0/y7GL6Aia8ZhH94XDaxAJBGa7EJYnmTm?=
 =?us-ascii?Q?YAZHLkv84tBF77GW5K9eDErE0KSa1lh3ol8hpCZqmCq5JcytckYWVSEowDEo?=
 =?us-ascii?Q?GKu1yocGAba/FUvs5Uj4KKFmM/C4niJxTzmwZLrblN8lx2H/c7/r8BQLlzdj?=
 =?us-ascii?Q?suqSGToNUj7NA3mTcWHZkqTKjI4HxFpYz/Ni5+pk2yfxpe535T+Vhk8bYYdX?=
 =?us-ascii?Q?8/pVo0hQ+8++dpTye4sqNipJlgIcovmrkpE51Z+G8TmkF2ZVmOKPNSq0k7sb?=
 =?us-ascii?Q?LKrJLxekp3tWbQ9PZSKdXpZOvVb5BXIIIISeidRHoVzE4Djdhsqjt5wm60Ja?=
 =?us-ascii?Q?7w1sJ9C4+UtPbsIEJe9dnir2BM4LlBY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ur2qkNs3KyPzPQ6nP1NLgu2Lv725M/HuowtatXMub3ch/i2xyBALxvfJ/cVfbHN1EBPlllZDQFF0AyhBCqrtH6Cr5P31wBohYqpbZC/kzic2CYY522nznc0Ljn3mNpvkeGXlsZbMF2viPia1Et3sOVlT1UtEuPQkM7dYKcz9WXikNn5e3v0KY2LDVQrnPIYhmLHQPpbLFunwee8FswruhzMoLnj+iO4nOEip8FpjBuUqqAJdWUZ0+/S/M/MiCKnmBmv4Hee9eMX8zCdw4A2zyCNPDcg74MJ80tQpbpsx/IzpUVwqC8ie8v0WPuRLXp+pv4rcpQlV2uS9oDy8Dy9dwg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877ff977-6f8d-4f24-20b1-08df3aa22c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 18:33:51.2667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d82wSwrcCaGYNXr0WFmssTqe/yhNGfh2qttEF7DNb2wtgOi+fGwNhY/se8gw7eosiu2nGeGPagwKWbLfReux5bKmheWPDwF7nRScX+FfFZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8705
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Emil Tantilov <emil.s.tantilov@intel.com>
> Sent: Wednesday, November 4, 2026 12:54 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Burra, Phani R <phani.r.burra@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Hay, Joshua A <joshua.a.hay@intel.com>;
> horms@kernel.org; brianvv@google.com; decot@google.com
> Subject: [PATCH iwl-net v3 0/2] idpf: fix teardown races around reset
> and remove
>=20
> Fixes for races between reset, remove and close in idpf.
>=20
> Patch 1 lets a reset racing with remove tear NAPI down in
> idpf_detach_and_close() by dropping the IDPF_REMOVE_IN_PROG early return
> from idpf_stop(), and tests IDPF_VPORT_UP under RTNL. Seen in testing,
> trace in the commit message.
>=20
> Patch 2 skips empty netdev slots in idpf_detach_and_close(). Reproduced
> on a reset with FW reporting more max vports than default vports.
>=20
> Testing: Patches 1 and 2 reproduced as described. Both are not HW
> specific.
>=20
> Changes in v3:
> - Removed patches 3 an 4 from the previous series as there were some
Typo: 3 an 4 -> 3 and 4

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


>   issues discovered in testing and review that will require more work,
>   and a likely a refactor more suitable for -next.
>=20
> v2: https://lore.kernel.org/intel-wired-lan/20261026221908.24690-1-
> emil.s.tantilov@intel.com/
>=20
> v1: https://lore.kernel.org/all/20260811171751.22165-1-
> emil.s.tantilov@intel.com/
>=20
> Emil Tantilov (2):
>   idpf: fix possible race on remove during a reset
>   idpf: skip empty netdev slots when detaching for a reset
>=20
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> --
> 2.37.3

