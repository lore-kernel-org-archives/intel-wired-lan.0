Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3007606A31E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=IqBtymTD;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WMz8suVJ;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VbUJ2iZG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85FE1406D9;
	Tue, 24 Nov 2026 15:43:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rXR3ns4nPDqT; Tue, 24 Nov 2026 15:43:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E860C406AB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795535025;
	b=cFAT9miWdg9CtdWk0GL0Gl6JOhP/A4Sr+cbVLuV3sJKPJu7pztlYHqAWuwLdE2Qs75V9
	 HPFometWuplZB9g3Z0nMavqjfuIszZGFxcc11SGR0rZpaAqtyVYKyp4oOzXdU4LyXASak
	 AGl6IsHU8YIdinbvDxJDDk/xaHSJWV83Owz/hZMxEzUS5qPRrUF+G7l07H+Wq9McoGnuc
	 aleD63qoHICb0PUR0HYIUZTRhAvfWCYYrqNVwecW6KLtmj+V6YqwP39MJgYb19tCV5oU8
	 1+GedBPjRKD3rvHgouWAwy2SEW9lwlNsuF/ukC7WQaeJdp8i7DL1ZaEFVNtlm+qhxJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795535025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
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
	bh=AZGyck0qnLqE4iaONdcuHZVQ+bWUrFspyQ/6CLepCYw=;
	b=hdJjoKxdm8U9QrSAxl7kJhG8zcRu1iw4GtNgnJxpWvKE4m18NRIq2Ks8/zy5bgEuf4/K
	 gkLia1ZJR1V4Ta7UMd/pXaIzijzsxiPjSnO2MK9XETJ3vc51tAapna+UQq6fLfDcRc2f6
	 IGvPJpX60jJlxoirKAu4Q32tZHoq5GD2oQJ2B7iHYBL/tXzIJGg83cNLIQS45cBKtaKTB
	 XFnFWjeiLwyJnVbMY4kv9lxNlnUFb+9s2AYfKPNGkXQN0nQvGdFkX16TIm2/7VNkm0K0X
	 aPa4Yubifd2xBjqfw7zq1f1tMrMxsNzVCNElV8sit83DU/AUOkeRSzd5t2ecJ2odFBQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795535025;
	bh=AZGyck0qnLqE4iaONdcuHZVQ+bWUrFspyQ/6CLepCYw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IqBtymTD13l690Yr4DLiCFwL0KxnlWSTNld+UThLDlrFtx2fWPqCCLqrFlD1zI04U
	 a2of354k6Oig3B+1t4KBW1nLt48KKz0eFRTXdpg0mswZ4pihOl/hlUYIGkprabfFSk
	 MdJ4kb3J8iYkhZuRh4yRquGu2+RJjLmSY974brOHaW1SxcbTpFCkxZhEJinwJqTgDY
	 X2Ppx0V91DmvAd/yub/Mi8mH/4jj3wXgXu9gR1CnMJqKRSSA6mjrC2TV/YxVsnhKHN
	 DL/zHl3cAGoGVSjopxunpXIrjpn/o3FEWWFqLQFEfvhL0QaiB5bFp6t3aWBni2miFV
	 K4Z2dVr6NkKxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E860C406AB;
	Tue, 24 Nov 2026 15:43:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A350B499
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 15:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8958440282
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 15:43:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GFG_106NrvG8 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 15:43:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E8D80400AA
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WMz8suVJ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=VbUJ2iZG
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8D80400AA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795535022; x=1827071022;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AZGyck0qnLqE4iaONdcuHZVQ+bWUrFspyQ/6CLepCYw=;
 b=WMz8suVJze+lRkce51DolKCdyuk3PxQpzAjYFl/Cugdd3TdYB1yRUkYO
 O2EGOSIQeQJPqfDksPAN16LA41j7hKkue04fgqNSmkyzqmnwGOyRdxyEW
 vV12D6TQhoSUqBt/9N4A9rbVz4badD86o/tLYDJGm/WQMp2znm2kvI3xo
 hbQYop/Bd1t+4YjWGknlc53gniCWAe5Rq99veGW/r6mDJMgulSVkgUO2W
 cF3fyvH9PZYySzElajiYeXwNJmewhPjQ6B1qEleVNbTolM0dvNnNmt0wp
 92j5QAdDr66/rnv3XiP5LJ7PZtb432+1E9OZAOVjIOzMjCym3xi4wgr7G Q==;
X-CSE-ConnectionGUID: QFF0oonBQPqamf/5roNUFQ==
X-CSE-MsgGUID: qXW58BhoTKuH0kejD9oyUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4468354"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4468354"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 07:26:15 -0800
X-CSE-ConnectionGUID: eTEujUftSJi8NIbMUGuZvw==
X-CSE-MsgGUID: kByJcf0sSFCj3TgLhwVM+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11501221"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 07:25:54 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 07:25:54 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 07:25:54 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 07:25:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZGyck0qnLqE4iaONdcuHZVQ+bWUrFspyQ/6CLepCYw=;
 b=VbUJ2iZG2wYrMxKDPdlVqHk77/FPlBeVBPl8iiPy240ue+m2vR7hzoLLhAxkXBf13Jk6s8dCPje/HlkDaXtb8plGw6MGpuBOT54kv04f8M8atqYRUyAJwa4pVBDukEngd/olF0bgD9JxQHP3PrBEsuDm35zOaazziaRCf0ze3AU=
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by LV2PR11MB813179.namprd11.prod.outlook.com (2603:10b6:408:416::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 15:25:51 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 15:25:51 +0000
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Ilichev, Konstantin"
 <konstantin.ilichev@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-net] ice: fix stale cached PHC time after a time step
Thread-Topic: [PATCH iwl-net] ice: fix stale cached PHC time after a time step
Thread-Index: AQHdco+lsBYQjH3JDU+ELiKi9atT4bc3pnkAgAPd3nCAAJF9AIABVIXw
Date: Tue, 24 Nov 2026 15:25:51 +0000
Message-ID: <PH0PR11MB4904948106E5E7E11F79B44394442@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20261112102301.342584-2-przemyslaw.korba@intel.com>
 <6fa3928e-90f2-42d3-86c6-ddc5492b51ea@intel.com>
 <PH0PR11MB4904B8854B7457816C72D4A894452@PH0PR11MB4904.namprd11.prod.outlook.com>
 <7864ad35-402b-4ae8-b470-ac6e9a81ac8e@intel.com>
In-Reply-To: <7864ad35-402b-4ae8-b470-ac6e9a81ac8e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|LV2PR11MB813179:EE_
x-ms-office365-filtering-correlation-id: 34e3b900-cfbd-4ab3-1725-08df4a3f3939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261026140227099003|261102123227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|5023799004|11063799006|4143699003|56012099006|10067099003|38070700021|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 9l6mQprB8DKt/1O47X/rj/VKRxvPrn6TsOQK5HGLvPoWQmvE4dUT+3bRRccEuoJenIECQRrMZfepQpf1ReXMzcLEE7HdHymjnHRBjbmnjnvIPI2x6dP6Q4EwHBSR9m44WTbhlcEz/MDAhOuvjvDSxaq1e+EZzeqpSKqAFBYOzmEGwXUFXT/w6qlWMfMBFtnlX+2Ub/wYltyDhlyqaHGg2qGKfq6Ae+O5SarDmGIbpU2IeY7yGJAEos2TXw5fpKbQ2bi01gWDIaHzN5gWzUK2KWqQQ5Gj2IfR/TKs+54yHsk+51axIURpNTdMch9K92799cAugK9SgjsTpKoNGJ6hUwhQTYVkgZHPBZrnd5ghxW/6PgyzA3Q7NKCxjIiuSLR2DYH2oBP02TAez8bllOwrWhedbNqiXvkVwnXZFOfrg/RWTgTvimo4mwcduhH66UFmzPpzD4nQxBSpT9Vb5+6hAYwaXIe18lczRcxca73x5FnhRX7r08J1f2waRBKXhfQTJygENGUVxF/R8DIE1OLnblcsLDpyag1+7ZwnAHLr2GA+XW4Qx3sTWppQjxipGxxo7wRTvWfMCJFYqtycRolXBxAJLi3qtsMcRFed+bhD+KyIPSBe9ZA9IfLzvO4vpfeGKL34R5qtwboW0BvY/yyeWqHc8fjKsrc8zZ0mQoJZLoF+zDumt9PUajATgiHgyoln96aJlBx4YmI8NBJitn4zSIi+ldcYDTCPPvMtAfmHc6M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4904.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261026140227099003)(261102123227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(38070700021)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1RxZzFwMzJudi90WnR2aURBdVZ6MlBGR1dXK2orbk45MktldGk0TmtOdjFQ?=
 =?utf-8?B?blVTTFNkZ3g0cXlFRmZ2NVZ6NVpIdW5rNnF0TW1QQVBleExxT0F2VUZVM0dT?=
 =?utf-8?B?ejlyNkdIZ2VlYmNOM1U5YU1nMmcyUGh5WXM4N21jRlkzdHR0ZXU0OXpkSGI2?=
 =?utf-8?B?dW1sY0VHVGhOZ29xK2JNLytpaWdBdmIzeDhkTEhoRTh4WHllZkZQOFc4NTB3?=
 =?utf-8?B?VHNnZ25LaUdyeXZJNzNJemkwajNOdlFPdE85S0tDMjBrOUcrcXYwakZMU0w3?=
 =?utf-8?B?TExrcTUyWFVqTm1iaXJ4SFJUWG9NQmtqeE0xTERYWDhiMSs3bzQvY0ttUWg1?=
 =?utf-8?B?Q3BDdlpiMFliOEhJMXl6MnUyc3RUQzJ1M2V2M0plTW82UDF1TWRXc2lGZHZK?=
 =?utf-8?B?U2l3VkJPM2xKV2J3Z2FrKzBOdHhjN2s0MVJuV0I5clJjNGJ2cVVZdTF5NC9u?=
 =?utf-8?B?OUZlTWNTWkYzUS85OTVGUGE5RTRKazFuQS9taCtpMmZvQ2gyQlRZTHRINGRp?=
 =?utf-8?B?Y0hzR3Z3VzRyRnVjbityRSt3SjREM2JGSjZLRmpha2MwdmhOaGRvcSt0T1Rh?=
 =?utf-8?B?T3duWjlueHdkek1vRzBRaU1YVVBSb0dGMUhDcVBPcmYzVUpBaXJtbEZUdXpj?=
 =?utf-8?B?a295SWJIT3NSRitIZ2hzTllEQVpUajVYclZmamV2ZG5vd0hxSlp2MWVqNmw2?=
 =?utf-8?B?U0ZWakpiMksxS1lBeGE3bThLZHN1amsrOVppWG9SZER2cE9ZNnR6WFFTcGFz?=
 =?utf-8?B?c2hXY1E3cWpCbmExZ2I4WXpkZXJKY3pZOTArdEpYMjRHMzNYMzdaODB2TFFX?=
 =?utf-8?B?Uk81MC9QRG1VQTN2bklmYnZvZlBzQkdBdndkbGt1SG5MMkpGR2U0RHRpZkwv?=
 =?utf-8?B?MndicHVPV1hpYk0welNBVE5wOHF3WDZxSGNIdnVWNUZFYStQUUpBNmRtL3JU?=
 =?utf-8?B?bVU4RWx2bFlxZTJqZUVIcmlJYVFETzk4NzNVejJlZDF4R016QzRUWk42RERI?=
 =?utf-8?B?VXFXTXIxK1drWCtWazdIRnVUU2RKV2Z3aU56cTR0THo1M1hVQmQ3aEJqeUpl?=
 =?utf-8?B?dUI3SVlkUFhydlZUT0kvZzQ0SFRPOWhYUlNKUDBLU0ZIL1RxRUI5SVNaSnl2?=
 =?utf-8?B?eXJwbTVZYkhGYlF4TkxUS0xSSkxIVEhVRS9NdXRFVlhCcDlpb3FqeWNwTGU5?=
 =?utf-8?B?WDBRS1NUTE5KSVZLSHpvVHorTEt6TE9DRTMraCtEOEt4UzJPL29NNXRNUlho?=
 =?utf-8?B?SVN1THJQeWFlbk5mK0orbEV0NTUzRzFjYnIvcEhjWVZoT0J0bVVWcmdGaURs?=
 =?utf-8?B?ZFpSTWpQQlEzbEV5ODVkYWFJTjAvZVl4dzJ2YXhMajAzVFdFVklLdjlIZzdJ?=
 =?utf-8?B?V2o3OEM0dUpKNVg3Ti9vWG8wRGFnVERGR3JKVzZ0bkRCTFQvU0hlVGNtc3lt?=
 =?utf-8?B?Wi9selFrUWM3cDVKNUJHc01zMUtpUTdkeEd4VEJyQkx3ZEpYY1ZEVS9HK1Vm?=
 =?utf-8?B?NmFibG1xTm5WSkRWTU9vcmdBbnJuQWU1ZjY5WUZrUDAwRGlLVGRaQjRGellX?=
 =?utf-8?B?THN6TUZITEFWYWwrMEtBNHo0bzh6SEwwTlhWdnhCZTdWMk9RUHo0ZHV4OURI?=
 =?utf-8?B?TDVyQzdMUFJpZWxvVnR2b2lQZmxQeUNjNTZYa0Q2d3Z3WXZoUGhtOFoxWWx3?=
 =?utf-8?B?SUhwcm5BTnE5dW93M1NUcTgvOWx5a2QzMTlVdVdSbU5IMzZ0dGFHL2lyQUc3?=
 =?utf-8?B?aGIwTjRPMmltQmJpZmlVamQ3R2d4MGRYdjh2OHFEQmp3RFhoZmNnOGovOEtR?=
 =?utf-8?B?clAzMVpJOVRoYlNubTA2NXcrNUZjSVBPUmhGYXdLa25ialJWQ09YRGgxcmhU?=
 =?utf-8?B?MTNycUVLcVBCT2Evam5oTUhEVEs5aGtpWm5iTmZMOVpYUlNvd3NSdm15cGhV?=
 =?utf-8?B?WXE2TGg1MUpZdW8wbXBnRGQ0YTlGcWpVZmIwcnRQSlFzWnNzMmtZTkFkWUcw?=
 =?utf-8?B?eDJialRYbWQrWC9CU1hsZkFod3pSblROcU9lNyt6VEN2aUo3TVIwa0gyV2FZ?=
 =?utf-8?B?aFAyUDZEZFlBa0E0ZGF3d2ZkK283dFJVbHFTalpOcjhMUUV2Nm5UMTQ5bk9P?=
 =?utf-8?B?Tm9uRm9nTnlUV1ZVUysrOVM3T0tkWS80b0t0c2RmU09jRXl4SUw5VlFpWWRF?=
 =?utf-8?B?cnRjazdIYWlneGdqUHhZWjhwVVNjYmE5OUlER092M21ZNFhGaDZJZjRwcWwy?=
 =?utf-8?B?Q3Nla1owZGpNNTFLcFdIMlN5bG0yWnpFMHVQcWp6V1ByTzJLS20wYXovQ2Yx?=
 =?utf-8?B?MjhrUUJXQ1JLMDFhZ1FPMkg3bllXbHBFR2EwSmE0c2t2SDN2U0FBQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SjMEeGmzOws8E464izoMUWW77d2qJbGaDW2hynuL1Fxn0MSFzjAiYEmDKyAhh0rjKwjrbpmUM6hQ27C9koRCyeFUpEaeJk5XuDBLM2yAC+IUp7jYMoYaQF4/csJVci6xth+XFOk9mw+ceAPw+mJtKoliB1EKXDXTWed+872MqjdMIavZkmpZYzzyz+kC2VHyEnBzpSMAu7plMdm8eQtU1X9NNs9GHLGEKzMWcJ7Z7p3RFrQNKNNHf8F8LPgeTw0WsH8DlDlP9aE3spEqmf3tRBuguFUlOkGC8oyYP2by4XERQoBFVxMF2oDXg/Io5jjIp6kYnyP5F7eoH/M6vLg7kw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e3b900-cfbd-4ab3-1725-08df4a3f3939
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 15:25:51.3212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xt4YvaGj6xXELjuZZTJPIm6eX7BjhKKHixvzF/Jz8xycvA4H4GETzx3lQnCUEVOvw5ThB9Y53TKjDSKPdUbSevB99PUqevVGa5KMDQ0EfAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB813179
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

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWxsZXIsIEphY29i
IEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAy
MywgMjAyNiA4OjA1IFBNDQo+IFRvOiBLb3JiYSwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5rb3Ji
YUBpbnRlbC5jb20+DQo+IENjOiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRyLmxva3Rp
b25vdkBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRl
bC5jb20+OyBLdWJhbGV3c2tpLCBBcmthZGl1c3oNCj4gPGFya2FkaXVzei5rdWJhbGV3c2tpQGlu
dGVsLmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBJbGljaGV2LCBLb25z
dGFudGluIDxrb25zdGFudGluLmlsaWNoZXZAaW50ZWwuY29tPjsgT2xlY2gsIE1pbGVuYQ0KPiA8
bWlsZW5hLm9sZWNoQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVteXNsYXcu
a2l0c3plbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggaXdsLW5ldF0gaWNlOiBm
aXggc3RhbGUgY2FjaGVkIFBIQyB0aW1lIGFmdGVyIGEgdGltZSBzdGVwDQo+IA0KPiBPbiAxMS8y
My8yMDI2IDI6MjUgQU0sIEtvcmJhLCBQcnplbXlzbGF3IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBLZWxsZXIsIEphY29i
IEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gPj4gU2VudDogU2F0dXJkYXksIE5vdmVt
YmVyIDIxLCAyMDI2IDEyOjIxIEFNDQo+ID4+IFRvOiBLb3JiYSwgUHJ6ZW15c2xhdyA8cHJ6ZW15
c2xhdy5rb3JiYUBpbnRlbC5jb20+DQo+ID4+IENjOiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxl
a3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5s
Lm5ndXllbkBpbnRlbC5jb20+OyBLdWJhbGV3c2tpLCBBcmthZGl1c3oNCj4gPj4gPGFya2FkaXVz
ei5rdWJhbGV3c2tpQGludGVsLmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBJbGljaGV2LCBLb25zdGFudGluIDxrb25zdGFudGluLmlsaWNoZXZAaW50ZWwuY29tPjsgT2xl
Y2gsIE1pbGVuYQ0KPiA+PiA8bWlsZW5hLm9sZWNoQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVt
eXNsYXcgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggaXdsLW5ldF0gaWNlOiBmaXggc3RhbGUgY2FjaGVkIFBIQyB0aW1lIGFmdGVyIGEgdGlt
ZSBzdGVwDQo+ID4+DQo+ID4+IFByemVteXNsYXcgS29yYmEgc2FpZDo+IGljZV9wdHBfdXBkYXRl
X2NhY2hlZF9waGN0aW1lKCkgcmVhZHMgdGhlIFBIQw0KPiA+PiBhbmQgdGhlbiBzdG9yZXMgdGhl
IHZhbHVlDQo+ID4+PiBpbiB0aGUgY2FjaGVkIHRpbWUgdGhhdCBpcyB1c2VkIHRvIGV4dGVuZCBU
eCBhbmQgUnggdGltZXN0YW1wcy4gSXQgaXMNCj4gPj4+IGNhbGxlZCBib3RoIGZyb20gdGhlIHBl
cmlvZGljIHdvcmsgYW5kLCBhZnRlciB0aGUgUEhDIHRpbWUgaXMgY2hhbmdlZCwNCj4gPj4+IGZy
b20gdGhlIHNldHRpbWUvYWRqdGltZSBwYXRocy4NCj4gPj4+DQo+ID4+PiBOb3RoaW5nIG9yZGVy
cyB0aGVzZSByZWZyZXNoZXMuIFRoZSBwZXJpb2RpYyB3b3JrIGNhbiByZWFkIHRoZSBQSEMganVz
dA0KPiA+Pj4gYmVmb3JlIHNvZnR3YXJlIGNoYW5nZXMgaXRzIHRpbWUsIGJlIGRlbGF5ZWQsIGFu
ZCB0aGVuIHN0b3JlIGl0cyByZWFkaW5nDQo+ID4+PiBhZnRlciB0aGUgcmVmcmVzaCB0aGF0IGZv
bGxvd3MgdGhlIGNoYW5nZS4gVGhlIGNhY2hlIHRoZW4gaG9sZHMgdGhlIG9sZA0KPiA+Pj4gdGlt
ZSB1bnRpbCB0aGUgbmV4dCBwZXJpb2RpYyB1cGRhdGUsIHVwIHRvIDUwMCBtcyBsYXRlci4gVGlt
ZXN0YW1wcw0KPiA+Pj4gZXh0ZW5kZWQgaW4gdGhhdCB3aW5kb3cga2VlcCB0aGUgY29ycmVjdCBs
b3cgMzIgYml0cyBidXQgdGFrZSB0aGUgdXBwZXINCj4gPj4+IGJpdHMgZnJvbSB0aGUgb2xkIHRp
bWUsIHNvIHRoZXkgYXJlIG9mZiBieSBhIG11bHRpcGxlIG9mIDJeMzIgbnMuIFR3bw0KPiA+Pj4g
Y29uY3VycmVudCB0aW1lIGNoYW5nZXMgY2FuIHJhY2UgaW4gdGhlIHNhbWUgd2F5Lg0KPiA+Pj4N
Cj4gPj4+IEZvciBhIGZvbGxvd2VyIHRoYXQgc3RlcHMgYSBsYXJnZSBpbml0aWFsIG9mZnNldCB0
aGlzIG1ha2VzIHB0cDRsIHNlZQ0KPiA+Pj4gdGhlIG9mZnNldCByZW1haW4gdW5jaGFuZ2VkIGFm
dGVyIHRoZSBzdGVwLCBmb2xsb3dlZCBieSBhIGNsb2NrY2hlY2sNCj4gPj4+IGZhaWx1cmUgYW5k
IGEgc2Vjb25kIFVOQ0FMSUJSQVRFRCB0cmFuc2l0aW9uOg0KPiA+Pj4NCj4gPj4+ICAgcG9ydCAx
OiBVTkNBTElCUkFURUQgdG8gU0xBVkUgb24gTUFTVEVSX0NMT0NLX1NFTEVDVEVEDQo+ID4+PiAg
IGNsb2NrY2hlY2s6IGNsb2NrIGp1bXBlZCBmb3J3YXJkIG9yIHJ1bm5pbmcgZmFzdGVyIHRoYW4g
ZXhwZWN0ZWQhDQo+ID4+PiAgIHBvcnQgMTogU0xBVkUgdG8gVU5DQUxJQlJBVEVEIG9uIFNZTkNI
Uk9OSVpBVElPTl9GQVVMVA0KPiA+Pj4gICBwb3J0IDE6IFVOQ0FMSUJSQVRFRCB0byBTTEFWRSBv
biBNQVNURVJfQ0xPQ0tfU0VMRUNURUQNCj4gPj4+DQo+ID4+PiBJbiB0aGUgZmFpbGluZyBjYXNl
IHRoZSBvZmZzZXQgYWZ0ZXIgdGhlIHN0ZXAgd2FzIGV4YWN0bHkgNTg2NyAqIDJeMzIgbnMNCj4g
Pj4+IHBsdXMgbm9pc2UsIGkuZS4gb25seSB0aGUgbG93IDMyIGJpdHMgb2YgdGhlIHRpbWUgd2Vy
ZSByaWdodC4NCj4gPj4+DQo+ID4+PiBIb2xkIGEgc3BpbmxvY2sgYWNyb3NzIGJvdGggdGhlIFBI
QyByZWFkIGFuZCB0aGUgc3RvcmUgb2YgdGhlIGNhY2hlZA0KPiA+Pj4gdGltZS4gV2hpY2hldmVy
IHJlZnJlc2ggcmVhZHMgdGhlIFBIQyBsYXN0IHRoZW4gYWxzbyBzdG9yZXMgbGFzdCwgc28gYW4N
Cj4gPj4+IG9sZGVyIHJlYWRpbmcgY2FuIG5ldmVyIG92ZXJ3cml0ZSBhIG5ld2VyIG9uZS4gVGhl
IGxvY2sgaXMgb25seSBoZWxkIGZvcg0KPiA+Pj4gdGhlIHJlZ2lzdGVyIHJlYWQgYW5kIGlzIHRh
a2VuIGJlZm9yZSB0aGUgR0xUU1lOX1RJTUUgbG9jayB0aGF0DQo+ID4+PiBpY2VfcHRwX3JlYWRf
c3JjX2Nsa19yZWcoKSB0YWtlcywgd2hpY2ggaXMgbmV2ZXIgaGVsZCB3aGlsZSB0YWtpbmcgaXQu
DQo+ID4+Pg0KPiA+Pj4gU3RlcHMgdG8gcmVwcm9kdWNlOg0KPiA+Pj4gMS4gQ3JlYXRlIFFpblEg
KDgwMi4xYWQgb3V0ZXIsIDgwMi4xUSBpbm5lcikgVkxBTnMgb24gdHdvIGRpcmVjdGx5DQo+ID4+
PiAgICBjb25uZWN0ZWQgRTgxMCBwb3J0cy4NCj4gPj4+IDIuIFJ1biBhIFBUUCBsZWFkZXIgb24g
b25lIHNpZGUgYW5kIHB0cDRsIC1zIG9uIHRoZSBvdGhlciwgd2l0aCB0aGUNCj4gPj4+ICAgIGZv
bGxvd2VyIFBIQyBhYm91dCA3IGhvdXJzIGJlaGluZCB0aGUgbGVhZGVyLCBhbmQgcnVuIGlwZXJm
MyBvbiB0aGUNCj4gPj4+ICAgIFZMQU4uDQo+ID4+PiAzLiBSZXN0YXJ0IHRoZSBmb2xsb3dlciBy
ZXBlYXRlZGx5Lg0KPiA+Pj4NCj4gPj4+IFRoaXMgaXMgbm90IHJlbGlhYmx5IHJlcHJvZHVjaWJs
ZSwgYXMgaXQgZGVwZW5kcyBvbiB0aGUgcGVyaW9kaWMgd29yaw0KPiA+Pj4gb3ZlcmxhcHBpbmcg
dGhlIHN0ZXAuIFdpdGggYSAyMDAgbXMgZGVsYXkgYWRkZWQgYmV0d2VlbiB0aGUgUEhDIHJlYWQg
YW5kDQo+ID4+PiB0aGUgc3RvcmUsIDMgb2YgMjAgcnVucyBzaG93IHRoZSBzZWNvbmQgVU5DQUxJ
QlJBVEVEIHRyYW5zaXRpb24gYW5kDQo+ID4+PiBTWU5DSFJPTklaQVRJT05fRkFVTFQgd2l0aG91
dCB0aGlzIGNoYW5nZS4NCj4gPj4+DQo+ID4+PiBXaXRoIGEgcmFuZG9tIGRlbGF5IG9mIHVwIHRv
IDEwMCBtcyBhZGRlZCBhdCB0aGUgc2FtZSBwbGFjZSwgYW5kIDQNCj4gPj4+IHBhcmFsbGVsICJw
aGNfY3RsIGFkaiAxIiBsb29wcyBydW5uaW5nIGZvciAyMCBzZWNvbmRzLCB0aGUgc3RvcmVkIHZh
bHVlDQo+ID4+PiB3ZW50IGJhY2t3YXJkcyA1NzkgdGltZXMgaW4gMTUwOSBzdG9yZXMgd2l0aG91
dCB0aGlzIGNoYW5nZSwgYW5kIDANCj4gPj4+IHRpbWVzIGluIDM5OSBzdG9yZXMgd2l0aCBpdC4N
Cj4gPj4+DQo+ID4+PiBUZXN0ZWQgb24gRTgxMC1DLg0KPiA+Pj4NCj4gPj4+IEZpeGVzOiA3N2E3
ODExNTVhNjUgKCJpY2U6IGVuYWJsZSByZWNlaXZlIGhhcmR3YXJlIHRpbWVzdGFtcGluZyIpDQo+
ID4+PiBSZXZpZXdlZC1ieTogTWlsZW5hIE9sZWNoIDxtaWxlbmEub2xlY2hAaW50ZWwuY29tPg0K
PiA+Pj4gU2lnbmVkLW9mZi1ieTogUHJ6ZW15c2xhdyBLb3JiYSA8cHJ6ZW15c2xhdy5rb3JiYUBp
bnRlbC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX2FkYXB0ZXIuYyB8IDEgKw0KPiA+Pj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2ljZS9pY2VfYWRhcHRlci5oIHwgNCArKysrDQo+ID4+PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9wdHAuYyAgICAgfCA5ICsrKysrKysrKw0KPiA+Pj4gIDMgZmlsZXMgY2hh
bmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkYXB0ZXIuYyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2ljZS9pY2VfYWRhcHRlci5jDQo+ID4+PiBpbmRleCAyMDdlNGZlOTdiZTcuLjk4
NzQzODBiNjQyZCAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2ljZS9pY2VfYWRhcHRlci5jDQo+ID4+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pY2UvaWNlX2FkYXB0ZXIuYw0KPiA+Pj4gQEAgLTkxLDYgKzkxLDcgQEAgc3RhdGljIHN0cnVj
dCBpY2VfYWRhcHRlciAqaWNlX2FkYXB0ZXJfbmV3KHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiA+
Pj4gIAl0aW1lY291bnRlcl9pbml0KCZhZGFwdGVyLT5waGMudGMsICZhZGFwdGVyLT5waGMuY2Ms
IDApOw0KPiA+Pj4NCj4gPj4+ICAJc2VxbG9ja19pbml0KCZhZGFwdGVyLT5waGMudGNfbG9jayk7
DQo+ID4+PiArCXNwaW5fbG9ja19pbml0KCZhZGFwdGVyLT5waGMuY2FjaGVfbG9jayk7DQo+ID4+
Pg0KPiA+Pg0KPiA+PiBJIHRoaW5rIHY0IG9mIG15IHRpbWVjb3VudGVyIHNlcmllcyBmaXhlcyB0
aGlzIGJlY2F1c2UgZWFjaCB1cGRhdGUgaXMNCj4gPj4gcHJvdGVjdGVkIGJ5IHRoZSBwaGMtPmxv
Y2suDQo+ID4+DQo+ID4+IFRoZSBwZXJpb2RpYyB1cGRhdGUgdGFrZXMgdGhhdCBsb2NrIGluIGlj
ZV9wdHBfdXBkYXRlX2NhY2hlZF9waGN0aW1lLA0KPiA+PiBhbmQgcmVhZGVycyBnZXQgYSBjb25z
aXN0ZW50IHZpZXcgYmVjYXVzZSBvZiB0aGUgd3JpdGVfc2VxY291bnRfbGF0Y2guDQo+ID4+DQo+
ID4+IFRoZSB1cGRhdGVzIHRvIHRoZSBjYWNoZWQgdGltZSBvbmx5IGV2ZXIgaGFwcGVuIHVuZGVy
IHRoZSBwaGMtPmxvY2sNCj4gPj4gbXV0ZXggYW5kIHRoZSByZWFkIGZvciB0aGUgdGltZSB0byBz
YXZlIGFsc28gaGFwcGVucyB1bmRlciBsb2NrLiBUaHVzLCBJDQo+ID4+IHRoaW5rIHRoaXMgcGF0
Y2ggc2hvdWxkIG5vdCBiZSBuZWVkZWQgd2l0aCB0aGF0IHRpbWVjb3VudGVyIHNlcmllcy4NCj4g
Pj4NCj4gPj4gRG8geW91IGFncmVlPw0KPiA+Pg0KPiA+DQo+ID4gWWVhaCwgSSBhZ3JlZS4gb25l
IGNhdmVhdCB0aG91Z2ggLSB5b3VyIHNlcmllcyB0YXJnZXRzIGl3bC1uZXh0LCBJIHRoaW5rIHdl
J2QgbmVlZCB0aGlzDQo+ID4gc3RhbGUgY2FjaGVkIFBIQyB0aW1lIGZpeCBiYWNrcG9ydGVkLCBu
bz8NCj4gPg0KPiANCj4gRmFpci4gVGhlIHByb2JsZW0gaXMgdGhhdCBvdGhlciBmaXhlcyB3ZSBo
YXZlIGZvciBQVFAgbGFuZGVkIG9uIG5leHQgYXMNCj4gd2VsbCwgYW5kIHRoZSBtYWluIHRhcmdl
dCBjdXN0b21lciBJIGhhdmUgaXMgZ29pbmcgdG8gdGFrZSB0aGUgdHJlZSB0aGF0DQo+IGhhcyBh
bGwgdGhlIGZpeGVzLiBUaW1lY291bnRlciBpcyBhIGJpdCB0b28gYmlnIHRvIGJhY2twb3J0Lg0K
PiANCj4gSSdtIG9rIHdpdGggYmFja3BvcnRpbmcgdGhpcyBmaXgsIGJ1dCBpdCB3aWxsIHByb2Jh
Ymx5IGNhdXNlDQo+IGNvbXBsaWNhdGlvbiBvbiBtZXJnaW5nIGJlY2F1c2Ugd2UnbGwgd2FudCB0
byBkcm9wIHRoZSB1bm5lY2Vzc2FyeSBleHRyYQ0KPiBsb2NrIG9uY2Ugd2UgaGF2ZSB0aGUgdGlt
ZWNvdW50ZXIgZml4IDpcDQo+IA0KDQpZZWFoLCBJJ2Qgc3VnZ2VzdCBsZXQncyB3YWl0IGZvciB5
b3VyIHRpbWVjb3VudGVyIGFuZCBsb2NrIHNlcmllcyB0byBtZXJnZSBhbmQgbm90IHB1bGwgdGhp
cyBwYXRjaCBpbiANCmZvciBub3csIHRoZW4gd2UgY2FuIHRoaW5rIGFib3V0IGJhY2twb3J0LiBI
b3cgYWJvdXQgdGhhdD8NCg0KPiA+Pj4gIAlyZXR1cm4gYWRhcHRlcjsNCj4gPj4+ICB9DQo+ID4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9hZGFwdGVy
LmggYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkYXB0ZXIuaA0KPiA+Pj4g
aW5kZXggZDhkYTY4ZTczMTc3Li40NWM4MmY4ZDdmNDMgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkYXB0ZXIuaA0KPiA+Pj4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9hZGFwdGVyLmgNCj4gPj4+IEBAIC01MSw2
ICs1MSw4IEBAIHN0cnVjdCBpY2VfcG9ydF9saXN0IHsNCj4gPj4+ICAgKg0KPiA+Pj4gICAqIExl
Z2FjeSB0aW1lc3RhbXAgZXh0ZW5zaW9uIGZpZWxkczoNCj4gPj4+ICAgKiBAY2FjaGVkX3RpbWU6
IENhY2hlZCBjb3B5IG9mIHRoZSBQSEMgdGltZSBmb3IgdGltZXN0YW1wIGV4dGVuc2lvbg0KPiA+
Pj4gKyAqIEBjYWNoZV9sb2NrOiBTZXJpYWxpemVzIHJlYWRpbmcgdGhlIFBIQyBhbmQgdXBkYXRp
bmcgQGNhY2hlZF90aW1lLCBzbyB0aGF0DQo+ID4+PiArICogICAgICAgICAgICAgIGFuIG9sZGVy
IHJlYWRpbmcgY2FuIG5ldmVyIG92ZXJ3cml0ZSBhIG5ld2VyIG9uZQ0KPiA+Pj4gICAqDQo+ID4+
PiAgICogc3RydWN0IHRpbWVjb3VudGVyIGZpZWxkczoNCj4gPj4+ICAgKiBAdGM6IHRpbWVjb3Vu
dGVyIHJlcHJlc2VudGluZyB0aGUgY3VycmVudCB0aW1lDQo+ID4+PiBAQCAtNjQsNiArNjYsOCBA
QCBzdHJ1Y3QgaWNlX3BvcnRfbGlzdCB7DQo+ID4+PiAgc3RydWN0IGljZV9waGMgew0KPiA+Pj4g
IAkvKiBMZWdhY3kgdGltZXN0YW1wIGV4dGVuc2lvbiBmaWVsZHMgKi8NCj4gPj4+ICAJdTY0IGNh
Y2hlZF90aW1lOw0KPiA+Pj4gKwkvKiBQcm90ZWN0cyByZWFkaW5nIHRoZSBQSEMgZm9yLCBhbmQg
dXBkYXRpbmcsIGNhY2hlZF90aW1lICovDQo+ID4+PiArCXNwaW5sb2NrX3QgY2FjaGVfbG9jazsN
Cj4gPj4+DQo+ID4+PiAgCS8qIHN0cnVjdCB0aW1lY291bnRlciBmaWVsZHMgKi8NCj4gPj4+ICAJ
c3RydWN0IHRpbWVjb3VudGVyIHRjOw0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX3B0cC5jDQo+ID4+PiBpbmRleCA0ODhkYjgyOTgwNTkuLjE0ODZhNmZjMzVmNSAxMDA2
NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMN
Cj4gPj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4g
Pj4+IEBAIC0xMDc5LDYgKzEwNzksMTUgQEAgc3RhdGljIHZvaWQgaWNlX3B0cF91cGRhdGVfY2Fj
aGVkX3BoY3RpbWUoc3RydWN0IGljZV9wZiAqcGYpDQo+ID4+PiAgCQl1NjQgc3lzdGltZTsNCj4g
Pj4+ICAJCWludCBlcnI7DQo+ID4+Pg0KPiA+Pj4gKwkJLyogVGhlIHBlcmlvZGljIHdvcmsgYW5k
IHRoZSB0aW1lIHNldC9hZGp1c3QgcGF0aHMgYWxsIHJlZnJlc2gNCj4gPj4+ICsJCSAqIHRoZSBj
YWNoZS4gSG9sZCB0aGUgbG9jayBhY3Jvc3MgYm90aCB0aGUgUEhDIHJlYWQgYW5kIHRoZQ0KPiA+
Pj4gKwkJICogc3RvcmUsIHNvIHRoYXQgd2hpY2hldmVyIHJlZnJlc2ggcmVhZHMgdGhlIFBIQyBs
YXN0IGlzIGFsc28NCj4gPj4+ICsJCSAqIHRoZSBvbmUgdGhhdCBzdG9yZXMgbGFzdC4gT3RoZXJ3
aXNlLCBhIHJlYWRpbmcgdGFrZW4gYmVmb3JlDQo+ID4+PiArCQkgKiBhIHRpbWUgY2hhbmdlIGNh
biBvdmVyd3JpdGUgYSBuZXdlciBvbmUgYW5kIGxlYXZlIHRpbWVzdGFtcHMNCj4gPj4+ICsJCSAq
IGV4dGVuZGVkIGFnYWluc3QgdGhlIG9sZCB0aW1lIHVudGlsIHRoZSBuZXh0IHVwZGF0ZS4NCj4g
Pj4+ICsJCSAqLw0KPiA+Pj4gKwkJZ3VhcmQoc3BpbmxvY2spKCZwaGMtPmNhY2hlX2xvY2spOw0K
PiA+Pj4gKw0KPiA+Pj4gIAkJZXJyID0gaWNlX3B0cF9yZWFkX3NyY19jbGtfcmVnKHBmLCBOVUxM
LCAmc3lzdGltZSk7DQo+ID4+PiAgCQlpZiAoZXJyKSB7DQo+ID4+PiAgCQkJLyogVGhlIHNvdXJj
ZSBjbG9jayBpcyBnb25lLCBzbyB0aGUgY2FjaGUgY2FuIG5vDQo+ID4+Pg0KPiA+Pj4gYmFzZS1j
b21taXQ6IDM0YTcwYTQwYzk1NGZiODA0NGVjZDEyNDg0MGEyYzM4Y2QzYWE0Y2MNCj4gPj4+IC0t
DQo+ID4+PiAyLjQzLjANCj4gPj4+DQoNCg==
