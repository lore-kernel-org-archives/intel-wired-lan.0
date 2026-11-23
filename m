Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EFA606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=syq0fKA6;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P6ft9Oy2;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Pc7Bv3UY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8876560721;
	Mon, 23 Nov 2026 10:25:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1sP6IGrPNNy5; Mon, 23 Nov 2026 10:25:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 816566071C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795429533;
	b=BHzPHZ66jMRRcwpLKxdCK/r9ddYnEN8J2DR8F3QCVlKzKFFSdZxzrjB2x+FNx3jVDLak
	 tocOmmqruBckZEfzf2G3eH2rt2nNSHOLEnG9v8l7Lpa7IMrJ79NJ9LHcsIbkUBoe27Bu8
	 4bGSMCV5lC6Y2BSy89VFNZ3pJ5cicj8iO1RacUbW3aih8xLQN4ZLh55yR3j39KSqIk827
	 jVo0dbXZCehttBua2LNklXS49R3DIFlZCLk2wDc2N4EXg8Hi38iEXFwzkvRlEaSl6wj/m
	 RxhdVX1gsmgNwhGf1gZOVfLGB3IO84oNLlZyVaq9CXjlEwVa2Ak0tWzzbpsSqloDazQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795429533;
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
	bh=Tgg8DQGjG7QMZXia5qKn89logfTpGlkLXAf9uPAqQHE=;
	b=if1eO3Kd3hOx29SwVzcDLzxx7szopGrqeZ9TOA4KQp2j3JeLniqjeW2zyxzLbyNciHS8
	 Ve0LAM95aamjmy3TzTxwQWSfhztxNDpkTuGlHT/Ob9j9zIewjrSSrSuFwwyrp1RycQM1h
	 jcDMCm+YmYyuPTbbXqJf33T+vASuQsioLu4Cd7JXV/9hQBgN6IeEiC4qT+49UOxbHAFUa
	 MGm0SmGXYxppHUgGTM3BuG0HKaGmCItCOXyvA88pOl+Ern1cwQnUBaEHUD5R7HPx7a06Y
	 X7IQoAK0K1nKt6twFGTZxdk9qV/HOb3f5FCRT/sCjQoIBzEDFgei5vlgINyAUvEIF0g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795429533;
	bh=Tgg8DQGjG7QMZXia5qKn89logfTpGlkLXAf9uPAqQHE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=syq0fKA6432jogTOptN7q0zRgV7j0jaf0GGR26b/hzCzh7GwqXrXnxndnlyvol0Fk
	 rMN1cVck8qB1SUnVMeXRAob2dKXXi07XkLOe/W/MF1gBHNWheyX7pceXiZ/5ydAH+G
	 2psowO9jziPGke0677aEpc3dLNw+55LX7ya+/aQ+yMGl+rVafKSb9SJJdzMJw9MOeG
	 hrtTq1jJuZ8s4WV9q23qJT1f8e7Zz1SMJ75lu2EssbLEjYgjlJ0lZKbFTeogcKwFRs
	 DEg2ZnuFqKffkkuo5iH+8yGYrRhdBBIi8FOoNzPL01gxY+XOJ6gzIs1qobQepmXhb4
	 UvUC8f87NcWEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 816566071C;
	Mon, 23 Nov 2026 10:25:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8492022B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A4334066C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:25:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJ4KCKXuCW8n for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 10:25:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 89F71405B8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=P6ft9Oy2; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=Pc7Bv3UY
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89F71405B8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795429530; x=1826965530;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Tgg8DQGjG7QMZXia5qKn89logfTpGlkLXAf9uPAqQHE=;
 b=P6ft9Oy2l21Qlfxab+qKcLzCc08Fik/7mrm1tpHO67IYyO5nSYbUeZyl
 6ZteqQilruLZJuD3CldBsfqcA54sF6Sd1duzWLGd7V5ubDGdcY90ZAc4Z
 RWDMCbGTXtbJvcqQw9hrsd79rHJXqjoQ6ORmJlQKRwX6xkXIX5EpDojZA
 5jZhcdwbz/GxP74qUAcGmYW3dC2Qu72XTYNq38VyhiKiM0pIMcQOkg3Dm
 nX0zTciemELxAErF5EN/uuvrDCwUCtsJirvCe1Dhi6yedpagvjozH6FML
 y+hfWIfyQtEm0NbUMq293c4+yqttJv/tNdioRzOCxqM5w12kZL9FfFaqM Q==;
X-CSE-ConnectionGUID: 9/TNvy8gTla4X4jGqfWCfQ==
X-CSE-MsgGUID: TZyQLPcNSxWokXHI546shA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4219274"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4219274"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 02:25:29 -0800
X-CSE-ConnectionGUID: agtSDb7HRw6NwS2dIaGWmg==
X-CSE-MsgGUID: 6UgzDJoFTOm9IQfss8iCqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="12971825"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 02:25:29 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 02:25:28 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 02:25:28 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 02:25:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgg8DQGjG7QMZXia5qKn89logfTpGlkLXAf9uPAqQHE=;
 b=Pc7Bv3UYlpsXANwVYxVqCjRwVOvT+b7lY4JkZdhyaZwHKMMTi3eNeGiL/HhBo93Ig8cRXDw/UCNp1hZ2BiHdynAvG7Ph4V2UQWIQxRo9W4RB9HeRpTQSg11qAuMEFomDsIIVgBAcQ5g5XYhSV9x5FtwCjZqu2KNB/CXA0vAq7zg=
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by PH0PR11MB9751.namprd11.prod.outlook.com (2603:10b6:510:397::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 10:25:26 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 10:25:26 +0000
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
Thread-Index: AQHdco+lsBYQjH3JDU+ELiKi9atT4bc3pnkAgAPd3nA=
Date: Mon, 23 Nov 2026 10:25:26 +0000
Message-ID: <PH0PR11MB4904B8854B7457816C72D4A894452@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20261112102301.342584-2-przemyslaw.korba@intel.com>
 <6fa3928e-90f2-42d3-86c6-ddc5492b51ea@intel.com>
In-Reply-To: <6fa3928e-90f2-42d3-86c6-ddc5492b51ea@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|PH0PR11MB9751:EE_
x-ms-office365-filtering-correlation-id: fbb5190d-17ba-4894-495d-08df494c1706
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|38070700021|11063799006|5023799004|4143699003|56012099006|10067099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: pAID/i+wq3yIYIG00oC+RMC1QcodzpPCe7XLrDZQOZW4FARvK7gxv6UjpAa+yyEbyT/N8FchAFKpC/HuiylDZhvbdKaDAZ/vTnfdrZW+ThVnvVB4hxOul9IoHbBsMLUYUQQ6EwlBksxyAUwZTkZlh+TRpuGJ6LWKsllTOMDTkfsnThJiKHcxHgdmnpbpDhBFlOIc+Tfl4qIKghqEFAT9tUHZT2mMrsCHnoCOo3wIRbPtE8Uy660BQmcX4QhfJxYiQH4yC5KiNrtAby7+4LV79i954bQtGw9YwJcR+xm5ry2ZGOnU61XXQKbqLcCEX+DqwH5YrlWlF71n7/t/ExkX+1jQl2m4ppHXKTVn6Y0IiyR4mHbhnmned4d3PMamuQY4Ej310cA1qB+4JUvjQRdXIHSZkoj9f4WFl5xeYwe4wGfAcUi1c9+lunwCNQ6iAMXEqtnRzWRZneenYWi5r2vHC6gIvuuQfdAldLOj7SLTMGPvNzk+W1ErjAp0/HVdUbytha/wdEqfSAaUWtQBGEvJpYgpnqFNj7RsfttChqCBAnF2RZF9baijfkxs4f+cTA7n/h5Bf1VQSNaJ8x/G7KtI0d4OKRAAoG2NuUmF6SIVKN9HtafTJS9M5zvQqTLAa1t9j7mYb+NwX+gLDkCpnWXpWZag4E1W8CjSEd7J3bSzwUW6aK6ZxYum9xqwIZDVSG3V1p6KrjWbfg2Wlw9zCucC9XXanceGstXT2pQOczD5v0E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4904.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(38070700021)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEFsbVRXMWo0ZURyUUluY2tiWlFWWFo5bHFJOUtWWkpNODI2cUliTDRpb3hJ?=
 =?utf-8?B?MG1BUlBDalR1M0RiN0lKR2pEdmlJZklFZUlPNEtVL0lYT0VPaFdSaXlmL1Fm?=
 =?utf-8?B?UkIvcWxDT0NENlZlN2cxelRjS1hQekx0Q1k0ckJlc0owNEVhekY3YUlFZjZ0?=
 =?utf-8?B?NFBoQWVTY2kwTXFPK1ZITUF0Mk40L3huSjlKQkd4cTBKNHZpOTM3Vk1CVEcw?=
 =?utf-8?B?UFJDUldoQW03REMwSFZVMlJrQjB2em8vZk5ET0xuN2Fwdkp5SGRpZ1FSYkRq?=
 =?utf-8?B?YXZUYitIZEdxODNLNUw2a092UmJYWVZJQUErQlhOMklCWDladnk2T2xsOEMx?=
 =?utf-8?B?WXI5SUlsdEpadnhGRVZrQk9lcmIwY1ZHeFB5ZURiVXdzQ2wzandTTDJ6Tkd5?=
 =?utf-8?B?a01YV0dqMVY2TytUblYzZ1JJYW84bE9NWTlFMlhIZGg1TndQWTE5YzZCWmRX?=
 =?utf-8?B?RXowZ21ySDNTVlRrcXdTRElBNkMxV3dFTUNLeGZFMjR2U0pSV0NUSXVSb3Bu?=
 =?utf-8?B?NSt0OUJTdTR2V09KYk9ORG5XZjJJelVNZkt3UGRjRU5VZlVZK3FxS2t3YmVx?=
 =?utf-8?B?cnJWVWZvUU45NzgvcjliOUpzRUtQRXhkV1RKK3NTVFFTZ2ZxemRBQjkzRll0?=
 =?utf-8?B?VGdubHU0bFQwdk9pRDRjVzNzNnBGUklTdVhOSGF4a1Z3WEd4cEJCNlVNMTdJ?=
 =?utf-8?B?UCtjcFRXbkRNWnhna1E5SUwzM1pyMnZrV25DUmpzZE5lNFB1ckRKNjZwUEEx?=
 =?utf-8?B?V24yaDgraUZsV1JIZHNISHFNTU1XaFNPVVFTTmU5Ry9UTGdkVzRKd2cvTVRL?=
 =?utf-8?B?MUlySG11aXhFNWM1Sm1ETXdqdEF2b0VDbTBKUXAvSkRCQWZlNVAwU1Nwd0o2?=
 =?utf-8?B?TzVSOGVUT2V6RnZ1MmxQU0tVaDhsVlFxOThYL2lVNTdzcDdPOWkzeWdic1ZB?=
 =?utf-8?B?KzBPSlpxNWk4aXA0RnRPR0dwSDZTazV3ZlZQMHQ4TU5pc056OXQ5bTUyZUdW?=
 =?utf-8?B?L2pJZkhTMGxhdE1jNGl5UWFzbUZYMldEL0M3TGp6SG16bUU1ZkFQanpabVZW?=
 =?utf-8?B?cU1zYVZtRnZiZTc0VGd1VHNBZ0kyWEtCSm00UzdKLzVrL1ErU2p4Y3RxYjFy?=
 =?utf-8?B?Qm9KOUNnVEV0YU0vV3RSaGJNejhaWEVFOFM1ME9LNEhpeW1hb0czSVBZZVZj?=
 =?utf-8?B?Zk5pSFV2Ti82alUwNUJLdTVsSkZ3Y0hXMWJlMEhVbWFGV2tJWFpUNW91cHNv?=
 =?utf-8?B?dWF0K2I2YXNtRC8xcDZQbURkV0tLNy85SDVUaE9lTTFkajJWVUI3WFR3ZmNh?=
 =?utf-8?B?d0JaVUpyY1l3a29UKzFLeFVlemlvbEFZVEh6aUlPRzhkNDdFQkNwbEpOTWFh?=
 =?utf-8?B?UlhFdTA0bXQ3RU5IV2ZVeEQ0RWFnRTRjREs3c3VyNEU3d3diTzl0dDVJYVlJ?=
 =?utf-8?B?RzYxUUVJVVF6Z2o3Lzd0MFU4T3BWQnhmbE1ZKzdNVmRhd3lVOWZmOTB6eWtp?=
 =?utf-8?B?bEtVZ05LUjU4d0VzVG5nU3VnZFhxaHZjQ01CWTRGdDhvQTFKRnIvMnNpUC9Q?=
 =?utf-8?B?K0hLVG9VY1FvQXU3LzhMcklxaEtCV2tSSGM5T0EvVnpkRXpLaHpuSWJrVjg5?=
 =?utf-8?B?STl3YTVvQ0RzMlJKVnRlclg0TndIakZqeXlxOUVZYlM2cDRUUjc1VnkvVTV1?=
 =?utf-8?B?YjllTjFiWnA5WlhpRnFaamFrdXhQM1JWd1RsRXFRYStyeUhYZXo4cmh5a05i?=
 =?utf-8?B?Mk9aQzdSTVg4WWg3UkhDZ0hoNUFVSHZlT3JuVnZ1SkZVS1V5cjR6cTF4L05p?=
 =?utf-8?B?b1llSEdPVVdtMVVsbDZIYy9NSmFXVXpSd3pwYmV1dHlZS2pKVUI3c3RpbCtj?=
 =?utf-8?B?bStTOHFMMEl0YVBqa015ZG9TYWlEV3pFbThVT1dUVVNVRy81NXlCZnFRTlhr?=
 =?utf-8?B?WG11Q2ZsejVuSGRBbTdHWWtOUEZmTHpmdWNScU1sR1NoZHBCSXlmUDVvbGgy?=
 =?utf-8?B?dWpvWUFMbFNWamhPa2g4U3JqbG44SHNMTFN5RWE1VVIraUQrTEpSRnhBankv?=
 =?utf-8?B?SVV6QkphTHdUR1c4V25tb1c0WVo2ODhqMkxObTJiRTlia1lTNzhtV3FhSk9t?=
 =?utf-8?B?MUFNVFZnTUhrYmZURVhxZmtCQ3lucEZoV1JYcnhwblhQbUlEdmZNOXp4YitH?=
 =?utf-8?B?Zzg2S0tFbHBRV0FaVjEvVUZhMFZiT1VCS3hhNUJFcVI0WTlKc1p1NUxoWXVq?=
 =?utf-8?B?ZjhEMTB3U1VRb0pwTnovUnYvYVZiOTAxUEZ5ajVoR2kzM1NTOWN0TzN4WVV3?=
 =?utf-8?B?TnY3ZlZadVczWmNyZm9xWFZzTGp4NzcvSUlDbE5TRU4vQVBCeHBDdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EJUjuJVgdsQybPOhfD5EBT943d7GdCUlvodQEd2QPIEA9ZKy6v3JNLoNHNKmr/yNQqaaOX2udEKqf/BqcvfT8o+hKNMip1jamAM3YwFaiJpWzQNhzwfH2GUGHz7jLBVjqPq9lwQheezGnrI4/dSBdxorjthVh41Q+/zVdbtEqf62/k42XIcVtlsaHwciUSJvyuqBUPe5utdZNeguvs0ndRCIVno9A47iXQuGslO5uFox8BjDG+DDXPG1Y5Di/BoGzx34Dw5wgDKNF4LcGIyzQtll7y3fOAD9fE5HlYndvFN286XBEmcsGkB+xbT1ufsvAIalbPMJ3ktHqZp9Ih4pvg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb5190d-17ba-4894-495d-08df494c1706
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 10:25:26.1885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmHTteYCZ9k3WREeGpu09gazJYtagaX/mG19e3a7qzz6kv2P5uIdnsPs96Tqt2CislF1kqQxqB3TOG+MwbFBnJEEfOHwfEeuoFEN49QYQAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9751
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
IEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIE5vdmVtYmVy
IDIxLCAyMDI2IDEyOjIxIEFNDQo+IFRvOiBLb3JiYSwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5r
b3JiYUBpbnRlbC5jb20+DQo+IENjOiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRyLmxv
a3Rpb25vdkBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBp
bnRlbC5jb20+OyBLdWJhbGV3c2tpLCBBcmthZGl1c3oNCj4gPGFya2FkaXVzei5rdWJhbGV3c2tp
QGludGVsLmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBJbGljaGV2LCBL
b25zdGFudGluIDxrb25zdGFudGluLmlsaWNoZXZAaW50ZWwuY29tPjsgT2xlY2gsIE1pbGVuYQ0K
PiA8bWlsZW5hLm9sZWNoQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVteXNs
YXcua2l0c3plbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggaXdsLW5ldF0gaWNl
OiBmaXggc3RhbGUgY2FjaGVkIFBIQyB0aW1lIGFmdGVyIGEgdGltZSBzdGVwDQo+IA0KPiBQcnpl
bXlzbGF3IEtvcmJhIHNhaWQ6PiBpY2VfcHRwX3VwZGF0ZV9jYWNoZWRfcGhjdGltZSgpIHJlYWRz
IHRoZSBQSEMNCj4gYW5kIHRoZW4gc3RvcmVzIHRoZSB2YWx1ZQ0KPiA+IGluIHRoZSBjYWNoZWQg
dGltZSB0aGF0IGlzIHVzZWQgdG8gZXh0ZW5kIFR4IGFuZCBSeCB0aW1lc3RhbXBzLiBJdCBpcw0K
PiA+IGNhbGxlZCBib3RoIGZyb20gdGhlIHBlcmlvZGljIHdvcmsgYW5kLCBhZnRlciB0aGUgUEhD
IHRpbWUgaXMgY2hhbmdlZCwNCj4gPiBmcm9tIHRoZSBzZXR0aW1lL2FkanRpbWUgcGF0aHMuDQo+
ID4NCj4gPiBOb3RoaW5nIG9yZGVycyB0aGVzZSByZWZyZXNoZXMuIFRoZSBwZXJpb2RpYyB3b3Jr
IGNhbiByZWFkIHRoZSBQSEMganVzdA0KPiA+IGJlZm9yZSBzb2Z0d2FyZSBjaGFuZ2VzIGl0cyB0
aW1lLCBiZSBkZWxheWVkLCBhbmQgdGhlbiBzdG9yZSBpdHMgcmVhZGluZw0KPiA+IGFmdGVyIHRo
ZSByZWZyZXNoIHRoYXQgZm9sbG93cyB0aGUgY2hhbmdlLiBUaGUgY2FjaGUgdGhlbiBob2xkcyB0
aGUgb2xkDQo+ID4gdGltZSB1bnRpbCB0aGUgbmV4dCBwZXJpb2RpYyB1cGRhdGUsIHVwIHRvIDUw
MCBtcyBsYXRlci4gVGltZXN0YW1wcw0KPiA+IGV4dGVuZGVkIGluIHRoYXQgd2luZG93IGtlZXAg
dGhlIGNvcnJlY3QgbG93IDMyIGJpdHMgYnV0IHRha2UgdGhlIHVwcGVyDQo+ID4gYml0cyBmcm9t
IHRoZSBvbGQgdGltZSwgc28gdGhleSBhcmUgb2ZmIGJ5IGEgbXVsdGlwbGUgb2YgMl4zMiBucy4g
VHdvDQo+ID4gY29uY3VycmVudCB0aW1lIGNoYW5nZXMgY2FuIHJhY2UgaW4gdGhlIHNhbWUgd2F5
Lg0KPiA+DQo+ID4gRm9yIGEgZm9sbG93ZXIgdGhhdCBzdGVwcyBhIGxhcmdlIGluaXRpYWwgb2Zm
c2V0IHRoaXMgbWFrZXMgcHRwNGwgc2VlDQo+ID4gdGhlIG9mZnNldCByZW1haW4gdW5jaGFuZ2Vk
IGFmdGVyIHRoZSBzdGVwLCBmb2xsb3dlZCBieSBhIGNsb2NrY2hlY2sNCj4gPiBmYWlsdXJlIGFu
ZCBhIHNlY29uZCBVTkNBTElCUkFURUQgdHJhbnNpdGlvbjoNCj4gPg0KPiA+ICAgcG9ydCAxOiBV
TkNBTElCUkFURUQgdG8gU0xBVkUgb24gTUFTVEVSX0NMT0NLX1NFTEVDVEVEDQo+ID4gICBjbG9j
a2NoZWNrOiBjbG9jayBqdW1wZWQgZm9yd2FyZCBvciBydW5uaW5nIGZhc3RlciB0aGFuIGV4cGVj
dGVkIQ0KPiA+ICAgcG9ydCAxOiBTTEFWRSB0byBVTkNBTElCUkFURUQgb24gU1lOQ0hST05JWkFU
SU9OX0ZBVUxUDQo+ID4gICBwb3J0IDE6IFVOQ0FMSUJSQVRFRCB0byBTTEFWRSBvbiBNQVNURVJf
Q0xPQ0tfU0VMRUNURUQNCj4gPg0KPiA+IEluIHRoZSBmYWlsaW5nIGNhc2UgdGhlIG9mZnNldCBh
ZnRlciB0aGUgc3RlcCB3YXMgZXhhY3RseSA1ODY3ICogMl4zMiBucw0KPiA+IHBsdXMgbm9pc2Us
IGkuZS4gb25seSB0aGUgbG93IDMyIGJpdHMgb2YgdGhlIHRpbWUgd2VyZSByaWdodC4NCj4gPg0K
PiA+IEhvbGQgYSBzcGlubG9jayBhY3Jvc3MgYm90aCB0aGUgUEhDIHJlYWQgYW5kIHRoZSBzdG9y
ZSBvZiB0aGUgY2FjaGVkDQo+ID4gdGltZS4gV2hpY2hldmVyIHJlZnJlc2ggcmVhZHMgdGhlIFBI
QyBsYXN0IHRoZW4gYWxzbyBzdG9yZXMgbGFzdCwgc28gYW4NCj4gPiBvbGRlciByZWFkaW5nIGNh
biBuZXZlciBvdmVyd3JpdGUgYSBuZXdlciBvbmUuIFRoZSBsb2NrIGlzIG9ubHkgaGVsZCBmb3IN
Cj4gPiB0aGUgcmVnaXN0ZXIgcmVhZCBhbmQgaXMgdGFrZW4gYmVmb3JlIHRoZSBHTFRTWU5fVElN
RSBsb2NrIHRoYXQNCj4gPiBpY2VfcHRwX3JlYWRfc3JjX2Nsa19yZWcoKSB0YWtlcywgd2hpY2gg
aXMgbmV2ZXIgaGVsZCB3aGlsZSB0YWtpbmcgaXQuDQo+ID4NCj4gPiBTdGVwcyB0byByZXByb2R1
Y2U6DQo+ID4gMS4gQ3JlYXRlIFFpblEgKDgwMi4xYWQgb3V0ZXIsIDgwMi4xUSBpbm5lcikgVkxB
TnMgb24gdHdvIGRpcmVjdGx5DQo+ID4gICAgY29ubmVjdGVkIEU4MTAgcG9ydHMuDQo+ID4gMi4g
UnVuIGEgUFRQIGxlYWRlciBvbiBvbmUgc2lkZSBhbmQgcHRwNGwgLXMgb24gdGhlIG90aGVyLCB3
aXRoIHRoZQ0KPiA+ICAgIGZvbGxvd2VyIFBIQyBhYm91dCA3IGhvdXJzIGJlaGluZCB0aGUgbGVh
ZGVyLCBhbmQgcnVuIGlwZXJmMyBvbiB0aGUNCj4gPiAgICBWTEFOLg0KPiA+IDMuIFJlc3RhcnQg
dGhlIGZvbGxvd2VyIHJlcGVhdGVkbHkuDQo+ID4NCj4gPiBUaGlzIGlzIG5vdCByZWxpYWJseSBy
ZXByb2R1Y2libGUsIGFzIGl0IGRlcGVuZHMgb24gdGhlIHBlcmlvZGljIHdvcmsNCj4gPiBvdmVy
bGFwcGluZyB0aGUgc3RlcC4gV2l0aCBhIDIwMCBtcyBkZWxheSBhZGRlZCBiZXR3ZWVuIHRoZSBQ
SEMgcmVhZCBhbmQNCj4gPiB0aGUgc3RvcmUsIDMgb2YgMjAgcnVucyBzaG93IHRoZSBzZWNvbmQg
VU5DQUxJQlJBVEVEIHRyYW5zaXRpb24gYW5kDQo+ID4gU1lOQ0hST05JWkFUSU9OX0ZBVUxUIHdp
dGhvdXQgdGhpcyBjaGFuZ2UuDQo+ID4NCj4gPiBXaXRoIGEgcmFuZG9tIGRlbGF5IG9mIHVwIHRv
IDEwMCBtcyBhZGRlZCBhdCB0aGUgc2FtZSBwbGFjZSwgYW5kIDQNCj4gPiBwYXJhbGxlbCAicGhj
X2N0bCBhZGogMSIgbG9vcHMgcnVubmluZyBmb3IgMjAgc2Vjb25kcywgdGhlIHN0b3JlZCB2YWx1
ZQ0KPiA+IHdlbnQgYmFja3dhcmRzIDU3OSB0aW1lcyBpbiAxNTA5IHN0b3JlcyB3aXRob3V0IHRo
aXMgY2hhbmdlLCBhbmQgMA0KPiA+IHRpbWVzIGluIDM5OSBzdG9yZXMgd2l0aCBpdC4NCj4gPg0K
PiA+IFRlc3RlZCBvbiBFODEwLUMuDQo+ID4NCj4gPiBGaXhlczogNzdhNzgxMTU1YTY1ICgiaWNl
OiBlbmFibGUgcmVjZWl2ZSBoYXJkd2FyZSB0aW1lc3RhbXBpbmciKQ0KPiA+IFJldmlld2VkLWJ5
OiBNaWxlbmEgT2xlY2ggPG1pbGVuYS5vbGVjaEBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUHJ6ZW15c2xhdyBLb3JiYSA8cHJ6ZW15c2xhdy5rb3JiYUBpbnRlbC5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYWRhcHRlci5jIHwgMSAr
DQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYWRhcHRlci5oIHwgNCAr
KysrDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMgICAgIHwg
OSArKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9hZGFw
dGVyLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkYXB0ZXIuYw0KPiA+
IGluZGV4IDIwN2U0ZmU5N2JlNy4uOTg3NDM4MGI2NDJkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYWRhcHRlci5jDQo+ID4gKysrIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9hZGFwdGVyLmMNCj4gPiBAQCAtOTEsNiArOTEs
NyBAQCBzdGF0aWMgc3RydWN0IGljZV9hZGFwdGVyICppY2VfYWRhcHRlcl9uZXcoc3RydWN0IHBj
aV9kZXYgKnBkZXYpDQo+ID4gIAl0aW1lY291bnRlcl9pbml0KCZhZGFwdGVyLT5waGMudGMsICZh
ZGFwdGVyLT5waGMuY2MsIDApOw0KPiA+DQo+ID4gIAlzZXFsb2NrX2luaXQoJmFkYXB0ZXItPnBo
Yy50Y19sb2NrKTsNCj4gPiArCXNwaW5fbG9ja19pbml0KCZhZGFwdGVyLT5waGMuY2FjaGVfbG9j
ayk7DQo+ID4NCj4gDQo+IEkgdGhpbmsgdjQgb2YgbXkgdGltZWNvdW50ZXIgc2VyaWVzIGZpeGVz
IHRoaXMgYmVjYXVzZSBlYWNoIHVwZGF0ZSBpcw0KPiBwcm90ZWN0ZWQgYnkgdGhlIHBoYy0+bG9j
ay4NCj4gDQo+IFRoZSBwZXJpb2RpYyB1cGRhdGUgdGFrZXMgdGhhdCBsb2NrIGluIGljZV9wdHBf
dXBkYXRlX2NhY2hlZF9waGN0aW1lLA0KPiBhbmQgcmVhZGVycyBnZXQgYSBjb25zaXN0ZW50IHZp
ZXcgYmVjYXVzZSBvZiB0aGUgd3JpdGVfc2VxY291bnRfbGF0Y2guDQo+IA0KPiBUaGUgdXBkYXRl
cyB0byB0aGUgY2FjaGVkIHRpbWUgb25seSBldmVyIGhhcHBlbiB1bmRlciB0aGUgcGhjLT5sb2Nr
DQo+IG11dGV4IGFuZCB0aGUgcmVhZCBmb3IgdGhlIHRpbWUgdG8gc2F2ZSBhbHNvIGhhcHBlbnMg
dW5kZXIgbG9jay4gVGh1cywgSQ0KPiB0aGluayB0aGlzIHBhdGNoIHNob3VsZCBub3QgYmUgbmVl
ZGVkIHdpdGggdGhhdCB0aW1lY291bnRlciBzZXJpZXMuDQo+IA0KPiBEbyB5b3UgYWdyZWU/DQo+
IA0KDQpZZWFoLCBJIGFncmVlLiBvbmUgY2F2ZWF0IHRob3VnaCAtIHlvdXIgc2VyaWVzIHRhcmdl
dHMgaXdsLW5leHQsIEkgdGhpbmsgd2UnZCBuZWVkIHRoaXMNCnN0YWxlIGNhY2hlZCBQSEMgdGlt
ZSBmaXggYmFja3BvcnRlZCwgbm8/DQoNCj4gPiAgCXJldHVybiBhZGFwdGVyOw0KPiA+ICB9DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYWRhcHRl
ci5oIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9hZGFwdGVyLmgNCj4gPiBp
bmRleCBkOGRhNjhlNzMxNzcuLjQ1YzgyZjhkN2Y0MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkYXB0ZXIuaA0KPiA+ICsrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYWRhcHRlci5oDQo+ID4gQEAgLTUxLDYgKzUxLDgg
QEAgc3RydWN0IGljZV9wb3J0X2xpc3Qgew0KPiA+ICAgKg0KPiA+ICAgKiBMZWdhY3kgdGltZXN0
YW1wIGV4dGVuc2lvbiBmaWVsZHM6DQo+ID4gICAqIEBjYWNoZWRfdGltZTogQ2FjaGVkIGNvcHkg
b2YgdGhlIFBIQyB0aW1lIGZvciB0aW1lc3RhbXAgZXh0ZW5zaW9uDQo+ID4gKyAqIEBjYWNoZV9s
b2NrOiBTZXJpYWxpemVzIHJlYWRpbmcgdGhlIFBIQyBhbmQgdXBkYXRpbmcgQGNhY2hlZF90aW1l
LCBzbyB0aGF0DQo+ID4gKyAqICAgICAgICAgICAgICBhbiBvbGRlciByZWFkaW5nIGNhbiBuZXZl
ciBvdmVyd3JpdGUgYSBuZXdlciBvbmUNCj4gPiAgICoNCj4gPiAgICogc3RydWN0IHRpbWVjb3Vu
dGVyIGZpZWxkczoNCj4gPiAgICogQHRjOiB0aW1lY291bnRlciByZXByZXNlbnRpbmcgdGhlIGN1
cnJlbnQgdGltZQ0KPiA+IEBAIC02NCw2ICs2Niw4IEBAIHN0cnVjdCBpY2VfcG9ydF9saXN0IHsN
Cj4gPiAgc3RydWN0IGljZV9waGMgew0KPiA+ICAJLyogTGVnYWN5IHRpbWVzdGFtcCBleHRlbnNp
b24gZmllbGRzICovDQo+ID4gIAl1NjQgY2FjaGVkX3RpbWU7DQo+ID4gKwkvKiBQcm90ZWN0cyBy
ZWFkaW5nIHRoZSBQSEMgZm9yLCBhbmQgdXBkYXRpbmcsIGNhY2hlZF90aW1lICovDQo+ID4gKwlz
cGlubG9ja190IGNhY2hlX2xvY2s7DQo+ID4NCj4gPiAgCS8qIHN0cnVjdCB0aW1lY291bnRlciBm
aWVsZHMgKi8NCj4gPiAgCXN0cnVjdCB0aW1lY291bnRlciB0YzsNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gPiBpbmRleCA0ODhkYjgyOTgwNTkuLjE0ODZh
NmZjMzVmNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2Uv
aWNlX3B0cC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9w
dHAuYw0KPiA+IEBAIC0xMDc5LDYgKzEwNzksMTUgQEAgc3RhdGljIHZvaWQgaWNlX3B0cF91cGRh
dGVfY2FjaGVkX3BoY3RpbWUoc3RydWN0IGljZV9wZiAqcGYpDQo+ID4gIAkJdTY0IHN5c3RpbWU7
DQo+ID4gIAkJaW50IGVycjsNCj4gPg0KPiA+ICsJCS8qIFRoZSBwZXJpb2RpYyB3b3JrIGFuZCB0
aGUgdGltZSBzZXQvYWRqdXN0IHBhdGhzIGFsbCByZWZyZXNoDQo+ID4gKwkJICogdGhlIGNhY2hl
LiBIb2xkIHRoZSBsb2NrIGFjcm9zcyBib3RoIHRoZSBQSEMgcmVhZCBhbmQgdGhlDQo+ID4gKwkJ
ICogc3RvcmUsIHNvIHRoYXQgd2hpY2hldmVyIHJlZnJlc2ggcmVhZHMgdGhlIFBIQyBsYXN0IGlz
IGFsc28NCj4gPiArCQkgKiB0aGUgb25lIHRoYXQgc3RvcmVzIGxhc3QuIE90aGVyd2lzZSwgYSBy
ZWFkaW5nIHRha2VuIGJlZm9yZQ0KPiA+ICsJCSAqIGEgdGltZSBjaGFuZ2UgY2FuIG92ZXJ3cml0
ZSBhIG5ld2VyIG9uZSBhbmQgbGVhdmUgdGltZXN0YW1wcw0KPiA+ICsJCSAqIGV4dGVuZGVkIGFn
YWluc3QgdGhlIG9sZCB0aW1lIHVudGlsIHRoZSBuZXh0IHVwZGF0ZS4NCj4gPiArCQkgKi8NCj4g
PiArCQlndWFyZChzcGlubG9jaykoJnBoYy0+Y2FjaGVfbG9jayk7DQo+ID4gKw0KPiA+ICAJCWVy
ciA9IGljZV9wdHBfcmVhZF9zcmNfY2xrX3JlZyhwZiwgTlVMTCwgJnN5c3RpbWUpOw0KPiA+ICAJ
CWlmIChlcnIpIHsNCj4gPiAgCQkJLyogVGhlIHNvdXJjZSBjbG9jayBpcyBnb25lLCBzbyB0aGUg
Y2FjaGUgY2FuIG5vDQo+ID4NCj4gPiBiYXNlLWNvbW1pdDogMzRhNzBhNDBjOTU0ZmI4MDQ0ZWNk
MTI0ODQwYTJjMzhjZDNhYTRjYw0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4NCg==
