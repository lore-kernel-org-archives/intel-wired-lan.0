Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE7606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=cmj1qmFq;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UO9GiaLZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E828740648;
	Mon,  9 Nov 2026 11:00:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EqlH5xh0Z0zR; Mon,  9 Nov 2026 11:00:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AB5D4405F8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794222026;
	b=q2G3Zj52GQBiKB4QDwX9cspFVH3rtBN98RMyoKGoCRjDyo8q/aMtivXRmOpfHZbup0MC
	 EJo9LuSF3ahlXflAoHCO26v4zpSpW6cscf0RMctxb6f90tChtTLHL3uNS3sPYz/EGyFBL
	 sr0byS6ZZV90297x35QjYSJHnvbIiJRfS4VYYJslurHpKwHtNTpZlD/AOCxqacaCF/Y/V
	 hWD1KPi7a/nD1INs4U/hp2yO82Ix3C5KL8dNKFOpIWoycxOmGQTD6MuP4YZnx8WiccDjc
	 Qs+KtHxnpK9RnUwMrV3BBMHBYxx39AtVhTf5dllbKCQPm/grwfK7Jc2R9IksbQR2DBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794222026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=UVOKcJ0imV3BMzlBl8KviFRk6JNmSzRyuvXvmJ1bkVw=;
	b=hICfg2Xe2F1TgXSk6Nmr3EKJugtUwHpCm0gJh6q8XDOvL4V70++NAjdmfwaHvNxKX42F
	 sdzbLP/lCBQjVZC8BS1ZRWwsE8oqrXFhuaZLwCp17BiYNoxXhFHCRjXSP+JNehU0YSM+m
	 niYLLwSSS7LleG9eDTeZjQSR7+v/nfYgUJ1yUHWywVOzVIH0qvsmBfZF+RaAAd567P8Kv
	 v5hee8lBBnpAiKbRFq3UBe55QN9rHU9OpcqZRS2nbhIJBbGESG/cB01FIgPkSZSl7BDj+
	 CryMGOWqz6qyk8RPfdnpkk7pGt64mM6FMaTjpaUW5iXGk33vPizhObcIvTPDW8XLzDg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794222026;
	bh=UVOKcJ0imV3BMzlBl8KviFRk6JNmSzRyuvXvmJ1bkVw=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cmj1qmFq9Tn/ix1kn4Xu21HICFDzpXwNRC59Am1D17M6Go5FQJadAs0BFbwwC4iYz
	 C89U3iBGwXSnngz9tsvpwTRlPYYwNXBGqq++HW4yYZy5E5tBqphFSGrI4OWh6OtATq
	 FGQc7+GnzvAiB8DOXCGUwAL9n6fraUqgQU1pYz/YR16OU3C20pJD1TewrjlCSCwIHs
	 qiTai+a4h09T3f2v7tlBa2/HYJiO6gsSXLeXuY2z1i1RjhW1KMoz5MlIyAU8KAxT0O
	 +cVGqN3o4kKHwrYVZB0LvDlt+hpvHUVb4vdG7mR694FuYniZX5mrWy2A1KIgzs4Qof
	 Sm7iMcZ15hZZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB5D4405F8;
	Mon,  9 Nov 2026 11:00:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 644A4932
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 11:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55DA180E7D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 11:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FNGu4tH2a9_h for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 11:00:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E46A380E3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UO9GiaLZ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E46A380E3E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794222023; x=1825758023;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=UVOKcJ0imV3BMzlBl8KviFRk6JNmSzRyuvXvmJ1bkVw=;
 b=UO9GiaLZ9TC6xyMS6kvYwEO27X5t7t7kjS//Mx4IqIOH5+7oPZdHdogx
 sC1PKBchBxhdGhOx/rd+vdG/6EQDcM8rB9id5VW0TeEtnkremYou4O+ea
 5i/6jR6bIji3vv2NcnUeFUJDdXi+FNwzF4MRv76tbM4ZjGTJtlbrBjdv/
 1ezqx2R1dUQYliN0OZuyXR6T2riHxrGCmF5xv2sJW5DlOwNXjXD1Bf6qg
 b4OWaNAL2mNtfHz6JjdQ9axbmKvk0WuqqHgKUDUgUqPvdLEkH8SKx4vpv
 jQhHEb6+UP3D06gUkFIeDO+p96CLmlddCtlYiADCF4/t0+Pf5TTKRG5Pp Q==;
X-CSE-ConnectionGUID: q5rc8iOdS4yFU6/zeKXTAA==
X-CSE-MsgGUID: EOnE9FKPSZCEJAQEuMZHXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2935958"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2935958"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:00:21 -0800
X-CSE-ConnectionGUID: aguyGskLQCeWuHxcBakt/Q==
X-CSE-MsgGUID: nJzbM/8wQqulBKXxw497EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8173642"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:00:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:00:20 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 03:00:20 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:00:20 -0800
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by LV0PR11MB9839.namprd11.prod.outlook.com (2603:10b6:408:384::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:00:13 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:00:13 +0000
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH iwl-next 2/2] idpf: add direct Tx timestamp readout
Thread-Topic: [PATCH iwl-next 2/2] idpf: add direct Tx timestamp readout
Thread-Index: AQHdaru6R4lEWvVRXEuFhfLCgXQLYbcap94AgAr1izA=
Date: Mon, 9 Nov 2026 11:00:13 +0000
Message-ID: <PH0PR11MB490478EC6F96909284BEA1DB94732@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20261102110717.77800-1-przemyslaw.korba@intel.com>
 <20261102110717.77800-3-przemyslaw.korba@intel.com>
 <sashiko-outbox-193341@kernel.org>
In-Reply-To: <sashiko-outbox-193341@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|LV0PR11MB9839:EE_
x-ms-office365-filtering-correlation-id: ecf4fc6c-e2c1-4e02-94b9-08df3e50a176
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|6133799003|10067099003|38070700021|4143699003|5023799004|11063799006|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021135927099003|261021121427099003|56012099006|261026140227099003|261009223027099003;
x-microsoft-antispam-message-info: 2wZ4opLLKW4bvv0dXvAM25T08VgsdckjL08OaJE55brFINN4tlMxUmclsJLDbMME89r6OiFMPgl2I35F+x4F3sZVclApM2NUz+nuJWDKQTAhCcZjD1Z/qllOw4EbaU9MlRSGK4m3DIQz4qAxEAGvk+Hw0vXHaDVpVZQUdTBVHEmEUB7C/8rJK6xujaJMkcdp1foe3f9sSmCokT4weHqp3AyH301hyJrxcThjXDyg/mzlQYp7CHDWUsB7SMU02FP+XeEH6VOPCHxXTUzPNYm9KD1XiaaB0wVIGI6hsS4KntRdmo9LlGXGysmIaxLD+VVTA5Q3ce3zIRA6hrT2dXaVJ8zSIbpJHlonW7Ho4hw4Iw2BsJYTRTFF09lOM/SMOEBWbNXXE3ODdO5NdCmahr8BBtctKHLU3I7fM2JT5bsig1y2qNdG81uM1VQ3Q9XRQgumN61XUSefzGISlhWNLksBOgnMm07hmd0wCQ+qQszDtRwsqJ57bmSLlUmcm8egi3MPI1YoOcBOe0cP3pAOP1aYq8pfuoAZE5JrSvWSn4OsipiUqGhLf5+i7QmKg2pWBZoW9/8woW2XhGC+8CNoU/QCIj7uyHqs+kBiprRU/xfd7LCRi+F1hQuGKbJynXwdksLyAnIslyL9Xti9BZeBhwOcaUP1KEE4VdoGpglKF5Z7+LY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4904.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(38070700021)(4143699003)(5023799004)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021135927099003)(261021121427099003)(56012099006)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzZ1K295OUdDZEdOaUJLNmtFZWNINVRsSWJacjNOUVdLaXNXQXJRTStxQU1B?=
 =?utf-8?B?WmpLZ1AwdlVLR2ZLNE5KeUJCTysxTTFobHNwcGJOVysyUjdxamxZckJmR2th?=
 =?utf-8?B?US93aXBBcm9lRHZ6TUF5QlVwS05DQS9pejN6eWtRZ01UeEJDWVcyYTRTL3h3?=
 =?utf-8?B?ZjZGK2RaTDZ4RXE3cG1vSjJzR0tQYjVxS0xGNVVrNHh0YkxqVTFCWndGWmtv?=
 =?utf-8?B?b3p2WXdFMkxWUGFQVGVsWGwwaS9NSnlYUmhORC9UbW5iRUZHQ2sraFZ2WEZr?=
 =?utf-8?B?ZjhTcDUveTJWS3p6Z2k4R04xUUVtUURKRkxXOHk0aGFwWklCd2RSQjJlK21B?=
 =?utf-8?B?MFYzVno3NWx2RGtJamtreW5SRDBNMndVVXFxS09vUnN6czlKR3VyWjQwenFl?=
 =?utf-8?B?QnRZNkhDQkFxOUUrT3JVYTRJRWxvNmZScGZSeElDamdTMy9CbUU0dlZXVFpN?=
 =?utf-8?B?MUdBcWxDT1IrVXcvRTYvVzRudC9EcGtWRmcyZXZtcExzVnBXSTdXK1ZWRUtk?=
 =?utf-8?B?M0FrVzZnUE5sbXZTdXpvL0VCd1ZweHdWcmF1eXMvdUdWeFdLSVQyM1R0RW1t?=
 =?utf-8?B?azZ5SkVKeUlDSjVqUmNtd0d6RGx2Z3l5dHJwVDVndzhFdzhtWXYyVzhxYXBM?=
 =?utf-8?B?U1hWcExOamtHSVhLSjhtVm9zS3NDcmhhdlQ5a0tKd3dYa3NDeTBYSzFENXpO?=
 =?utf-8?B?R0NoNnJPRGo1Z3JEcEhGOWFKWUNUY1QzZWVCdDN1WnN5L2g3ak9NODhpNXMy?=
 =?utf-8?B?eFRqcUZRaThZYVhtdHMxbkFIYXhsTlhCaHRLSW9xWERUZkxLa0VGTG5oYmxS?=
 =?utf-8?B?V1J1bjdKTFpaalJVeEhOaVF3TEk3bXdtdXdOUk5rSlFFNlQzWStoeWZ1cWlU?=
 =?utf-8?B?QkpyMGxsWGVFd1VkRWJyZ1Q1Skg3T3VsenF5ZVhKK2s1WG5kL01MQnE2RU5j?=
 =?utf-8?B?UVRkWUt2cE5vT3FWa2x4RkdRcGFrV0lESE1UL0hsUVZkR2VkU2NKSFd3Wllq?=
 =?utf-8?B?QUNmalR4dzdhWGVJWXRGdkFQRC9LclRUS0xOWlNiOFRJcDhSbHg5R0RQbkxl?=
 =?utf-8?B?K1I0WEIzaVlLMUFPVjQ5b2VObS9yVURiemJhQnhvNTdmamdxekI4V2MvMG9J?=
 =?utf-8?B?MU53SG9waHAwd3dVbXJzQWtiOUpHcmJmSFJBV3RXSk9WQ0R4WXdsbGVwY2M4?=
 =?utf-8?B?c2p5aTgxMmxvQzVUcFBuQUR5VWZFQlF3WjZaVk5pdXUrbFV1Sm01VklRNUt6?=
 =?utf-8?B?bFBIcDhSL2ZuZzRqSElHTFJkSjMxamc1ZEdsdk44V2F5cWpkSnpXMnJhWDk2?=
 =?utf-8?B?N0xnWVVuQm1pcjNTRU9INkduZ1NzZXZ1U211bHM2UENtNmxHNThiN012cktm?=
 =?utf-8?B?Y1FtTmNEb2xnZ0d6WU1HU1RoNlNHaDdCZWh2MU9oZFdzUTJGQ252VG1hOEEr?=
 =?utf-8?B?bDk3MUM2UlNIMHJkQ2xNZTFUbGdyRWNmakc5ajlvR01FYllyUE1mZUxOSyt1?=
 =?utf-8?B?aWhycFhHY2VnWTNMUFI3OE90U3JzNUFGUjJ3ajdlNE05WmFET3VwQXluVTZW?=
 =?utf-8?B?d2VJSSt5N29PMHh5NG9SanplNWdPS052ZGJNYXFZMGRjL1hLMWwra08wTGdm?=
 =?utf-8?B?WGd1OUZ1QWpiUjNKU3lleWNzYUoyWE12NjNOWUNaVGlGeldFUGpVMFVrU3dy?=
 =?utf-8?B?MmZzWTUzcHZYeEI3K3FmK3FHNm5vMi9CeTQrUHhVc2xZbHRyS2hZRUhaTnZu?=
 =?utf-8?B?M2x0cm82YjlsK2orL0oyZXIzZk5PaWxUbksyV1FjZ0RRdUJITDZVWXYzQ3p1?=
 =?utf-8?B?NXkyVmEzOWpvc2xjRzJtVy9GMzZwRlAwTXRHdG9hQ3dickRaaTRGWjhGZ01C?=
 =?utf-8?B?N1gzRTBHbjRJcGNlSGtpZVlIQjgwVXp0dzc1Z2RoMVMveFNCMTdnN0MvVFVt?=
 =?utf-8?B?SWdPL3pYUDZRbUNiNEYzVHArUXlmczJUU3FnanQ4eUJ3VHhmR3VlTlVhU1Ji?=
 =?utf-8?B?MzhybkJOcmVGemNBbDNWN2VFc0x1eENtRExOV3ZFNTBTTGllTFhRUEtweFBy?=
 =?utf-8?B?MWZCYWFtYTVrbTlWSmxTWEU5QXNmdFRkeUZKbEI2YmhGTHRTam5VREY5Q2dB?=
 =?utf-8?B?N1NFV21Ja0QvNzh6enIrVEtsOUV4Nk5jU0RWSnBteWJnQjJzMzN5aHB6S3NO?=
 =?utf-8?B?b3REbHhFQnh5aVpIb0JtVHYvS09DOTNyWVdHL21FeTZTcnNvVUtQRWxEdDhT?=
 =?utf-8?B?UkZUNno5OFQvUGUxWWhKb2RKaVhUSzBNU3kvc1dsQ1pMd3VWSS9CdjlFanRI?=
 =?utf-8?B?WjBYSTRLMllqVExrankrQUJIMEs5SXl4OW5FKzBJMnBSU2dXWklOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: z294aQ8qVZmWkTy0MXn5wAu8PAuIt9lon2dxXutlpE2wi3f63S4L5IS/uSjkPh1iGnWXGoaxhZL7x0pd6oOoWyX/+8A0eQNB/p++pwU4MGt49bveuF7NcWdkfuC78EQIZbbPRS4JmAEd5xPat1Hmc3hwCHgVLo+kL8PubnaBzCS8L8HsaHkdvgkh/KzfyP5K8RJXPyrN7LpvWxh8rUsGGcs06dnOw1kLiij5f+i8UJfSbrlZMsAGg7xHkcfkJjz38sd2s6OsMvcNwJNgAwBCfzL+LAEfM9Js0l30T9Zqup1CEtyGDmjWZMEGiPIs8mwyWFvpyNuc40AVvW1uOjrYjw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf4fc6c-e2c1-4e02-94b9-08df3e50a176
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 11:00:13.7035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoK8i4WdvAU9WN5Im6xWASDIo1dILV5wDEomuyERmlweRq9E/oRqijih2UZ/N4U5LvHulFBZ2rNYjHssUCyd+o1McqJjpvqYLQza4/clWv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9839
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzYXNoaWtvLWJvdEBr
ZXJuZWwub3JnIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE5vdmVt
YmVyIDIsIDIwMjYgMTI6MzggUE0NCj4gVG86IEtvcmJhLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3
LmtvcmJhQGludGVsLmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggaXdsLW5leHQgMi8yXSBpZHBmOiBhZGQgZGlyZWN0IFR4IHRpbWVz
dGFtcCByZWFkb3V0DQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNo
aWtvIEFJIHJldmlldyBmb3VuZCAzIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4g
LSBbSGlnaF0gaWRwZjogbGVha2VkIGxhdGNoZXMgYW5kIHJhY2Ugb24gZGlzYWJsZSBpbiBpZHBm
X3B0cF9zZXRfdGltZXN0YW1wX21vZGUoKQ0KPiAtIFtIaWdoXSBpZHBmOiBOVUxMIGNtZF9zeW5j
IGRlcmVmZXJlbmNlIGFmdGVyIG92ZXJ3cml0ZSBpbiBpZHBmX3B0cF9nZXRfY2FwcygpDQo+IC0g
W01lZGl1bV0gaWRwZjogdHhfdHN0YW1wX3RpbWVyIG5vdCBzdG9wcGVkIHdoZW4gdnBvcnQgc3Rv
cHMgaW4gaWRwZl92cG9ydF9zdG9wKCkNCj4gLS0NCj4gDQo+IGNvbW1pdCBkYWI3NjY5MjFmOGVl
MzdiODIzMzlmYWE2M2ZkMWFmODBhMmY4MDdiDQo+IEF1dGhvcjogUHJ6ZW15c2xhdyBLb3JiYSA8
cHJ6ZW15c2xhdy5rb3JiYUBpbnRlbC5jb20+DQo+IA0KPiBpZHBmOiBhZGQgZGlyZWN0IFR4IHRp
bWVzdGFtcCByZWFkb3V0DQo+IA0KPiBUaGlzIGNvbW1pdCBhZGRzIGRpcmVjdCBCQVIgcmVnaXN0
ZXIgYWNjZXNzIHN1cHBvcnQgZm9yIHJlYWRpbmcgaGFyZHdhcmUgVHgNCj4gdGltZXN0YW1wcyBp
biB0aGUgaWRwZiBkcml2ZXIuIEluIGRpcmVjdCBtb2RlLCBhIHBlcmlvZGljIDEwMCB1cyBocnRp
bWVyDQo+IHBvbGxzIHRoZSByZWFkaW5lc3MgYml0bWFwIGFuZCBsYXRjaCByZWdpc3RlcnMsIHJl
cG9ydHMgY29tcGxldGVkIHRpbWVzdGFtcHMNCj4gdG8gdGhlIG5ldHdvcmsgc3RhY2ssIGFuZCBl
eHBpcmVzIHVubGF0Y2hlZCByZXF1ZXN0cyBhZnRlciA1MDAgbXMuDQo+IA0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfcHRwLmMgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfcHRwLmMNCj4gPiBpbmRleCBhNzgxYjNkYmUy
ZDYyLi5hZGIzZjMxZGFhNWQ5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lkcGYvaWRwZl9wdHAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2lkcGYvaWRwZl9wdHAuYw0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPiBAQCAtODI5LDM1ICs4
ODgsMjU4IEBAIHU2NCBpZHBmX3B0cF9leHRlbmRfdHMoc3RydWN0IGlkcGZfdnBvcnQgKnZwb3J0
LCB1NjQgaW5fdHN0YW1wKQ0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPiArc3RhdGljIGVudW0gaHJ0
aW1lcl9yZXN0YXJ0IGlkcGZfcHRwX3R4X3RzdGFtcF90aW1lcl9jYihzdHJ1Y3QgaHJ0aW1lciAq
dGltZXIpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBpZHBmX3Zwb3J0ICp2cG9ydDsNCj4gPiArDQo+
ID4gKwl2cG9ydCA9IGNvbnRhaW5lcl9vZih0aW1lciwgc3RydWN0IGlkcGZfdnBvcnQsIHR4X3Rz
dGFtcF90aW1lcik7DQo+ID4gKw0KPiA+ICsJaWRwZl9wdHBfZ2V0X3R4X3RzdGFtcF9kaXJlY3Qo
dnBvcnQpOw0KPiA+ICsJaHJ0aW1lcl9mb3J3YXJkX25vdyh0aW1lciwgSURQRl9QVFBfVFhfVFNU
QU1QX1BFUklPRF9OUyk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIEhSVElNRVJfUkVTVEFSVDsNCj4g
PiArfQ0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIGlkcGZfcHRwX3R4X3RzdGFtcF90aW1lcl9p
bml0IC0gU2V0IHVwIHRoZSBUeCB0aW1lc3RhbXAgY29sbGVjdGlvbiB0aW1lcg0KPiA+ICsgKiBA
dnBvcnQ6IFZpcnR1YWwgcG9ydCBzdHJ1Y3R1cmUNCj4gPiArICovDQo+ID4gK3ZvaWQgaWRwZl9w
dHBfdHhfdHN0YW1wX3RpbWVyX2luaXQoc3RydWN0IGlkcGZfdnBvcnQgKnZwb3J0KQ0KPiA+ICt7
DQo+ID4gKwlocnRpbWVyX3NldHVwKCZ2cG9ydC0+dHhfdHN0YW1wX3RpbWVyLCBpZHBmX3B0cF90
eF90c3RhbXBfdGltZXJfY2IsDQo+ID4gKwkJICAgICAgQ0xPQ0tfTU9OT1RPTklDLCBIUlRJTUVS
X01PREVfUkVMX1NPRlQpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogaWRwZl9w
dHBfdHhfdHN0YW1wX3RpbWVyX3NldCAtIEFybSBvciBkaXNhcm0gdGhlIFR4IHRpbWVzdGFtcCB0
aW1lcg0KPiA+ICsgKiBAdnBvcnQ6IFZpcnR1YWwgcG9ydCBzdHJ1Y3R1cmUNCj4gPiArICogQGVu
YWJsZTogd2hldGhlciB0aGUgVHggdGltZXN0YW1wcyBhcmUgdG8gYmUgY29sbGVjdGVkDQo+ID4g
KyAqDQo+ID4gKyAqIEluIHRoZSBkaXJlY3QgbW9kZSBub3RoaW5nIGluIHRoZSBUeCBwYXRoIHJl
YWRzIHRoZSBsYXRjaGVzLCBzbyB0aGUNCj4gPiArICogY29sbGVjdGlvbiBpcyBkcml2ZW4gYnkg
YSB0aW1lciB0aGF0IHJ1bnMgZm9yIGFzIGxvbmcgYXMgdGhlIFR4DQo+ID4gKyAqIHRpbWVzdGFt
cGluZyBpcyBlbmFibGVkLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIHZvaWQgaWRwZl9wdHBfdHhf
dHN0YW1wX3RpbWVyX3NldChzdHJ1Y3QgaWRwZl92cG9ydCAqdnBvcnQsIGJvb2wgZW5hYmxlKQ0K
PiA+ICt7DQo+ID4gKwlpZiAoIWlkcGZfcHRwX2lzX3Zwb3J0X3R4X3RzdGFtcF9lbmEodnBvcnQp
IHx8DQo+ID4gKwkgICAgdnBvcnQtPnR4X3RzdGFtcF9jYXBzLT5hY2Nlc3MgIT0gSURQRl9QVFBf
RElSRUNUKQ0KPiA+ICsJCXJldHVybjsNCj4gPiArDQo+ID4gKwlpZiAoZW5hYmxlKQ0KPiA+ICsJ
CWhydGltZXJfc3RhcnQoJnZwb3J0LT50eF90c3RhbXBfdGltZXIsDQo+ID4gKwkJCSAgICAgIElE
UEZfUFRQX1RYX1RTVEFNUF9QRVJJT0RfTlMsDQo+ID4gKwkJCSAgICAgIEhSVElNRVJfTU9ERV9S
RUxfU09GVCk7DQo+ID4gKwllbHNlDQo+ID4gKwkJaHJ0aW1lcl9jYW5jZWwoJnZwb3J0LT50eF90
c3RhbXBfdGltZXIpOw0KPiA+ICt9DQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gRG9lcyB2
cG9ydC0+dHhfdHN0YW1wX3RpbWVyIGtlZXAgcnVubmluZyBhdCAxMCBrSHogaWYgdGhlIGludGVy
ZmFjZSBpcyBicm91Z2h0DQo+IGRvd24gd2hpbGUgaGFyZHdhcmUgVHggdGltZXN0YW1waW5nIGlz
IGVuYWJsZWQ/DQo+IA0KPiBXaGVuIEhXVFNUQU1QX1RYX09OIGlzIGFjdGl2ZSBpbiBJRFBGX1BU
UF9ESVJFQ1QgbW9kZSBhbmQgdGhlIGludGVyZmFjZSBpcw0KPiBzdG9wcGVkIHZpYSBpZHBmX3N0
b3AoKSAtPiBpZHBmX3Zwb3J0X3N0b3AoKSwgdGhlIHF1ZXVlcyBhcmUgdG9ybiBkb3duIGFuZA0K
PiB2cG9ydC0+bGlua191cCBpcyBzZXQgdG8gZmFsc2U6DQo+IA0KPiBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pZHBmL2lkcGZfbGliLmM6aWRwZl92cG9ydF9zdG9wKCkgew0KPiAgICAgLi4u
DQo+IAl2cG9ydC0+bGlua191cCA9IGZhbHNlOw0KPiAJaWRwZl92cG9ydF9pbnRyX2RlaW5pdCh2
cG9ydCwgcnNyYyk7DQo+IAlpZHBmX3hkcF9yeHFfaW5mb19kZWluaXRfYWxsKHJzcmMpOw0KPiAJ
aWRwZl92cG9ydF9xdWV1ZXNfcmVsKHZwb3J0LCByc3JjKTsNCj4gCWlkcGZfdnBvcnRfaW50cl9y
ZWwocnNyYywgJmFkYXB0ZXItPmlycSk7DQo+IAljbGVhcl9iaXQoSURQRl9WUE9SVF9VUCwgbnAt
PnN0YXRlKTsNCj4gICAgIC4uLg0KPiB9DQo+IA0KPiBIb3dldmVyLCBpZHBmX3Zwb3J0X3N0b3Ao
KSBkb2VzIG5vdCBjYW5jZWwgdnBvcnQtPnR4X3RzdGFtcF90aW1lciBvciBmbHVzaA0KPiB2cG9y
dC0+dHhfdHN0YW1wX2NhcHMtPmxhdGNoZXNfaW5fdXNlLCBhbmQgaWRwZl9wdHBfdHhfdHN0YW1w
X3RpbWVyX2NiKCkNCj4gdW5jb25kaXRpb25hbGx5IHJlYXJtcyB0aGUgdGltZXIgd2l0aCBIUlRJ
TUVSX1JFU1RBUlQuIEJlY2F1c2UNCj4gaWRwZl9od3RzdGFtcF9zZXQoKSByZWplY3RzIGNoYW5n
ZXMgd2hlbiAhdnBvcnQtPmxpbmtfdXAgd2l0aCAtRVBFUk0sDQo+IHVzZXJzcGFjZSBjYW5ub3Qg
ZGlzYWJsZSBUeCB0aW1lc3RhbXBpbmcgd2hpbGUgdGhlIGludGVyZmFjZSBpcyBkb3duIGVpdGhl
ci4NCj4gDQo+IEluIGFkZGl0aW9uLCBhbnkgc2ticyB3aXRoIFNLQlRYX0lOX1BST0dSRVNTIHRo
YXQgd2VyZSBjbGVhbmVkIGZyb20gdGhlIFR4DQo+IHJpbmcgZHVyaW5nIGlkcGZfdnBvcnRfc3Rv
cCgpIHJlbWFpbiBvbiBsYXRjaGVzX2luX3VzZSBmb3IgNTAwIG1zIHVudGlsDQo+IGlkcGZfcHRw
X2dldF90eF90c3RhbXBfZGlyZWN0KCkgZXhwaXJlcyB0aGVtLCBsb2dnaW5nIGZhbHNlLXBvc2l0
aXZlIHdhcm5pbmdzDQo+IGFuZCBjb3VudGluZyB0aGVtIGFzIGV4cGlyZWQgcmF0aGVyIHRoYW4g
Zmx1c2hlZC4NCj4gDQo+IFNob3VsZCBpZHBmX3Zwb3J0X3N0b3AoKSBjYW5jZWwgdnBvcnQtPnR4
X3RzdGFtcF90aW1lciBhbmQgZmx1c2gNCj4gbGF0Y2hlc19pbl91c2UgKGFuZCBpZHBmX3Zwb3J0
X29wZW4oKSByZXN0YXJ0IHRoZSB0aW1lciBpZg0KPiB2cG9ydC0+dHN0YW1wX2NvbmZpZy50eF90
eXBlID09IEhXVFNUQU1QX1RYX09OKT8NCj4gDQo+ID4gQEAgLTkxNywxMiArMTE5OSwxOCBAQCBp
bnQgaWRwZl9wdHBfc2V0X3RpbWVzdGFtcF9tb2RlKHN0cnVjdCBpZHBmX3Zwb3J0ICp2cG9ydCwN
Cj4gPiAgCWNhc2UgSFdUU1RBTVBfVFhfT046DQo+ID4gIAkJaWYgKCFpZHBmX3B0cF9pc192cG9y
dF90eF90c3RhbXBfZW5hKHZwb3J0KSkNCj4gPiAgCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0K
PiA+ICAJCWJyZWFrOw0KPiA+ICAJZGVmYXVsdDoNCj4gPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4g
PiAgCX0NCj4gPg0KPiA+IC0JdnBvcnQtPnRzdGFtcF9jb25maWcudHhfdHlwZSA9IGNvbmZpZy0+
dHhfdHlwZTsNCj4gPiArCS8qIFB1Ymxpc2ggdGhlIG5ldyBtb2RlIGJlZm9yZSB0aGUgY29sbGVj
dGlvbiBpcyBkaXNhcm1lZCwgc28gdGhhdCB0aGUNCj4gPiArCSAqIFR4IHBhdGggc3RvcHMgaGFu
ZGluZyBvdXQgbGF0Y2hlcyB0aGF0IG5vdGhpbmcgd291bGQgY29sbGVjdC4NCj4gPiArCSAqLw0K
PiA+ICsJV1JJVEVfT05DRSh2cG9ydC0+dHN0YW1wX2NvbmZpZy50eF90eXBlLCBjb25maWctPnR4
X3R5cGUpOw0KPiA+ICsJaWRwZl9wdHBfdHhfdHN0YW1wX3RpbWVyX3NldCh2cG9ydCwgY29uZmln
LT50eF90eXBlID09IEhXVFNUQU1QX1RYX09OKTsNCj4gDQo+IFtTZXZlcml0eTogSGlnaF0NCj4g
Q2FuIGRpc2FibGluZyBUeCB0aW1lc3RhbXBpbmcgaW4gaWRwZl9wdHBfc2V0X3RpbWVzdGFtcF9t
b2RlKCkgc3RyYW5kIGluLXVzZQ0KPiBsYXRjaGVzIGFuZCBsZWFrIHRoZWlyIHNrYiByZWZlcmVu
Y2VzPw0KPiANCj4gSW4gSURQRl9QVFBfRElSRUNUIG1vZGUsIGlkcGZfdHhfcmVhZF90c3RhbXAo
KSBpcyBhIG5vLW9wLCBzbw0KPiB2cG9ydC0+dHhfdHN0YW1wX3RpbWVyIHJ1bm5pbmcgaWRwZl9w
dHBfZ2V0X3R4X3RzdGFtcF9kaXJlY3QoKSBpcyB0aGUgb25seQ0KPiBwbGFjZSB0aGF0IGNvbGxl
Y3RzIG9yIGV4cGlyZXMgZW50cmllcyBmcm9tIHRzdGFtcF9jYXBzLT5sYXRjaGVzX2luX3VzZS4N
Cj4gDQo+IFdoZW4gdXNlcnNwYWNlIHRyYW5zaXRpb25zIGNvbmZpZy0+dHhfdHlwZSB0byBIV1RT
VEFNUF9UWF9PRkYgdmlhDQo+IGlkcGZfaHd0c3RhbXBfc2V0KCkgLT4gaWRwZl9wdHBfc2V0X3Rp
bWVzdGFtcF9tb2RlKCksDQo+IGlkcGZfcHRwX3R4X3RzdGFtcF90aW1lcl9zZXQodnBvcnQsIGZh
bHNlKSBpbW1lZGlhdGVseSBjYW5jZWxzDQo+IHZwb3J0LT50eF90c3RhbXBfdGltZXIgd2l0aG91
dCBkcmFpbmluZyBvciBmbHVzaGluZyBlbnRyaWVzIGFscmVhZHkgcXVldWVkIG9uDQo+IHRzdGFt
cF9jYXBzLT5sYXRjaGVzX2luX3VzZS4NCj4gDQo+IEZ1cnRoZXJtb3JlLCB0aGUgVHggZGF0YXBh
dGggY2hlY2tzIHRzdGFtcF9jb25maWcudHhfdHlwZSBvdXRzaWRlIG9mDQo+IHRzdGFtcF9jYXBz
LT5sYXRjaGVzX2xvY2s6DQo+IA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lk
cGZfdHhyeC5jOmlkcGZfdHhfdHN0YW1wKCkgew0KPiAgICAgLi4uDQo+IAlpZiAoUkVBRF9PTkNF
KGlkcGZfbmV0ZGV2X3RvX3Zwb3J0KHR4X3EtPm5ldGRldiktPnRzdGFtcF9jb25maWcudHhfdHlw
ZSkgIT0NCj4gCSAgICBIV1RTVEFNUF9UWF9PTikNCj4gCQlyZXR1cm4gLTE7DQo+ICAgICAuLi4N
Cj4gCWVyciA9IGlkcGZfcHRwX3JlcXVlc3RfdHModHhfcSwgc2tiLCAmaWR4KTsNCj4gfQ0KPiAN
Cj4gQSBjb25jdXJyZW50IFR4IHRocmVhZCBjYW4gcGFzcyB0aGUgUkVBRF9PTkNFKCkgY2hlY2sg
aW4gaWRwZl90eF90c3RhbXAoKQ0KPiBqdXN0IGJlZm9yZSBXUklURV9PTkNFKCkgc2V0cyBIV1RT
VEFNUF9UWF9PRkYsIGFuZCB0aGVuIGNhbGwNCj4gaWRwZl9wdHBfcmVxdWVzdF90cygpIGFmdGVy
IGhydGltZXJfY2FuY2VsKCkgaGFzIGZpbmlzaGVkLCBtb3ZpbmcgYSBsYXRjaA0KPiBvbnRvIGxh
dGNoZXNfaW5fdXNlIGFuZCB0YWtpbmcgYW4gc2tiX2dldChza2IpIHJlZmVyZW5jZSBhZnRlciB0
aGUgdGltZXIgaXMNCj4gYWxyZWFkeSBzdG9wcGVkLg0KPiANCj4gVGhvc2Ugc3RyYW5kZWQgZW50
cmllcyBvbiBsYXRjaGVzX2luX3VzZSBob2xkIHRoZWlyIHNrYiByZWZlcmVuY2VzICh3aXRoDQo+
IFNLQlRYX0lOX1BST0dSRVNTIHNldCkgYW5kIGxhdGNoIGluZGV4ZXMgdW50aWwgdGVhcmRvd24g
b3IgdW50aWwNCj4gSFdUU1RBTVBfVFhfT04gaXMgcmUtZW5hYmxlZC4gSWYgSFdUU1RBTVBfVFhf
T04gaXMgbGF0ZXIgcmUtZW5hYmxlZCBhZnRlciB0aGUNCj4gMzItYml0IFBIQyBjb3VudGVyIHdy
YXBzLCBpZHBmX3B0cF9nZXRfdHhfdHN0YW1wX2RpcmVjdCgpIG9ubHkgY2hlY2tzDQo+IHB0cF90
eF90c3RhbXAtPmRlYWRsaW5lIHdoZW4gIXB0cF90eF90c3RhbXAtPnRzdGFtcCwgc28gYSBsYXRj
aCB3aG9zZQ0KPiByZWFkaW5lc3MgYW5kIHZhbGlkIGJpdHMgd2VyZSBzZXQgYmVmb3JlIHRoZSB0
aW1lciBzdG9wcGVkIHdpbGwgaGF2ZSBpdHMgb2xkDQo+IDMyLWJpdCB0aW1lc3RhbXAgZXh0ZW5k
ZWQgYWdhaW5zdCB0aGUgY3VycmVudCBQSEMgdGltZSBhbmQgcmVwb3J0ZWQgdmlhDQo+IHNrYl90
c3RhbXBfdHgoKS4NCj4gDQo+IFNob3VsZCBpZHBmX3B0cF9yZXF1ZXN0X3RzKCkgdmVyaWZ5IHR4
X3R5cGUgdW5kZXIgbGF0Y2hlc19sb2NrLCBhbmQgc2hvdWxkDQo+IGRpc2FibGluZyBUeCB0aW1l
c3RhbXBpbmcgZmx1c2ggbGF0Y2hlc19pbl91c2UgKG9yIGxldCB0aGUgdGltZXIgZHJhaW4NCj4g
cmVtYWluaW5nIGVudHJpZXMgYmVmb3JlIHN0b3BwaW5nKT8NCj4gDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hubF9wdHAuYyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hubF9wdHAuYw0KPiA+IGlu
ZGV4IDQyN2IxNTI4MWFkMGQuLjY0NDNjZTM0YTBkOTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3ZpcnRjaG5sX3B0cC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3ZpcnRjaG5sX3B0cC5jDQo+ID4g
QEAgLTQ4LDYgKzQ4LDcgQEAgaW50IGlkcGZfcHRwX2dldF9jYXBzKHN0cnVjdCBpZHBmX2FkYXB0
ZXIgKmFkYXB0ZXIpDQo+ID4gIAkJCQkgICAgVklSVENITkwyX0NBUF9QVFBfU0VUX0RFVklDRV9D
TEtfVElNRV9NQiB8DQo+ID4gIAkJCQkgICAgVklSVENITkwyX0NBUF9QVFBfQURKX0RFVklDRV9D
TEsgfA0KPiA+ICAJCQkJICAgIFZJUlRDSE5MMl9DQVBfUFRQX0FESl9ERVZJQ0VfQ0xLX01CIHwN
Cj4gPiArCQkJCSAgICBWSVJUQ0hOTDJfQ0FQX1BUUF9UWF9UU1RBTVBTIHwNCj4gPiAgCQkJCSAg
ICBWSVJUQ0hOTDJfQ0FQX1BUUF9UWF9UU1RBTVBTX01CKQ0KPiA+ICAJfTsNCj4gDQo+IFtTZXZl
cml0eTogSGlnaF0NCj4gSW4gaWRwZl9wdHBfZ2V0X2NhcHMoKSwgY2FuIHRoZSBjcm9zc190c3Rh
bXAgYmxvY2sgb3ZlcndyaXRlIGEgdmFsaWQNCj4gcHRwLT5kZXZfY2xrX3JlZ3MuY21kX3N5bmMg
cG9pbnRlciB3aXRoIE5VTEwgd2hpbGUgbGVhdmluZw0KPiBnZXRfZGV2X2Nsa190aW1lX2FjY2Vz
cyBhbmQgYWRqX2Rldl9jbGtfdGltZV9hY2Nlc3Mgc2V0IHRvIElEUEZfUFRQX0RJUkVDVD8NCj4g
DQo+IFdoZW4gcHRwLT5nZXRfZGV2X2Nsa190aW1lX2FjY2VzcyBpcyBJRFBGX1BUUF9ESVJFQ1Qs
IGlkcGZfcHRwX2dldF9jYXBzKCkNCj4gbWFwcyBjbG9ja19vZmZzZXRzLmNtZF9zeW5jX3RyaWdn
ZXIgaW50byBwdHAtPmRldl9jbGtfcmVncy5jbWRfc3luYyBhbmQNCj4gdmFsaWRhdGVzIGl0IGlu
IGNsa19yZWdzW106DQo+IA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZf
dmlydGNobmxfcHRwLmM6aWRwZl9wdHBfZ2V0X2NhcHMoKSB7DQo+ICAgICAuLi4NCj4gCXRlbXBf
b2Zmc2V0ID0gbGUzMl90b19jcHUoY2xvY2tfb2Zmc2V0cy5jbWRfc3luY190cmlnZ2VyKTsNCj4g
CXB0cC0+ZGV2X2Nsa19yZWdzLmNtZF9zeW5jID0NCj4gCQlsaWJpZV9wY2lfZ2V0X21taW9fYWRk
cihtbWlvLCB0ZW1wX29mZnNldCk7DQo+ICAgICAuLi4NCj4gCXB0cC0+Z2V0X2Rldl9jbGtfdGlt
ZV9hY2Nlc3MgPQ0KPiAJCWlkcGZfcHRwX3JlZ3NfYWNjZXNzKHB0cCwgY2xrX3JlZ3MsIEFSUkFZ
X1NJWkUoY2xrX3JlZ3MpLA0KPiAJCQkJICAgICBWSVJUQ0hOTDJfQ0FQX1BUUF9HRVRfREVWSUNF
X0NMS19USU1FX01CKTsNCj4gDQo+IGNyb3NzX3RzdGFtcDoNCj4gCWFjY2Vzc190eXBlID0gcHRw
LT5nZXRfY3Jvc3NfdHN0YW1wX2FjY2VzczsNCj4gCWlmIChhY2Nlc3NfdHlwZSAhPSBJRFBGX1BU
UF9ESVJFQ1QpDQo+IAkJZ290byBkaXNjaXBsaW5lX2Nsb2NrOw0KPiANCj4gCWNyb3NzX3RzdGFt
cF9vZmZzZXRzID0gcmVjdl9wdHBfY2Fwc19tc2ctPmNyb3NzX3RpbWVfb2Zmc2V0czsNCj4gICAg
IC4uLg0KPiAJdGVtcF9vZmZzZXQgPSBsZTMyX3RvX2NwdShjcm9zc190c3RhbXBfb2Zmc2V0cy5j
bWRfc3luY190cmlnZ2VyKTsNCj4gCXB0cC0+ZGV2X2Nsa19yZWdzLmNtZF9zeW5jID0NCj4gCQls
aWJpZV9wY2lfZ2V0X21taW9fYWRkcihtbWlvLCB0ZW1wX29mZnNldCk7DQo+IH0NCj4gDQo+IElm
IGNyb3NzX3RzdGFtcF9vZmZzZXRzLmNtZF9zeW5jX3RyaWdnZXIgY2Fubm90IGJlIG1hcHBlZCwN
Cj4gbGliaWVfcGNpX2dldF9tbWlvX2FkZHIoKSByZXR1cm5zIE5VTEwgYW5kIG92ZXJ3cml0ZXMN
Cj4gcHRwLT5kZXZfY2xrX3JlZ3MuY21kX3N5bmMuIENoZWNraW5nIGNyb3NzX3JlZ3NbXSB0aGVu
IGRvd25ncmFkZXMNCj4gcHRwLT5nZXRfY3Jvc3NfdHN0YW1wX2FjY2VzcywgYnV0IHB0cC0+Z2V0
X2Rldl9jbGtfdGltZV9hY2Nlc3MsDQo+IHB0cC0+YWRqX2Rldl9jbGtfdGltZV9hY2Nlc3MgKHdo
b3NlIGFkal9yZWdzW10gZG9lcyBub3QgaW5jbHVkZSBjbWRfc3luYyksDQo+IGFuZCBwdHAtPnNl
dF9kZXZfY2xrX3RpbWVfYWNjZXNzIHJlbWFpbiBJRFBGX1BUUF9ESVJFQ1QsIGNhdXNpbmcgc3Vi
c2VxdWVudA0KPiBjYWxscyB0byBpZHBmX3B0cF90bXJfY21kKCkgYW5kIGlkcGZfcHRwX2VuYWJs
ZV9zaHRpbWUoKSB0byBwYXNzIGEgTlVMTA0KPiBwdHAtPmRldl9jbGtfcmVncy5jbWRfc3luYyBw
b2ludGVyIHRvIHdyaXRlbCgpLg0KPiANCj4gLS0NCg0KQWxsIGNvbmNlcm5zIHZhbGlkLCB3aWxs
IHNlbmQgdjIgd2l0aCBmaXggc29vbg0KDQo+IFNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8v
c2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MTEwMjExMDcxNy43NzgwMC0xLXByemVteXNsYXcu
a29yYmFAaW50ZWwuY29tP3BhcnQ9Mg0K
