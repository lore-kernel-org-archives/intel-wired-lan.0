Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25274606A337
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=oDfl6Jlz;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nHUZS20r;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=cp2kH/rI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 070C2810B9;
	Thu, 12 Nov 2026 14:32:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HE9XbgDiRXVa; Thu, 12 Nov 2026 14:32:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E4663810DD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794493950;
	b=jmRC5MHTGeR+TDMs9C2PhM3CwXeytPKbJ6P1ZmZUgcC1X6psM4SLDttXNjGD4SeGDaqN
	 yHCs19IvMGHcTWtJF5bRhXgI+IvP8goeUbQmD6a356zdpyiC6h6SWjikZxgGqJeW1YczU
	 U5mV3cuRCM4/CfXsnmfLJRGjSLdZMo1UgMOTm/m4bO0UZdiubJV/FMJbtVKNqPl3YMF6F
	 Zc/wxr1Ws9JFZxQyuIpg8+j3/u35c6dLN+oQ0ShpuVKEjx2hoBZmG4n2Loe/YZ3uvIOJ/
	 Hc7eUOleE1dEHfNDshG50ojUDLKYaVRkckQLngcbU84SC7zvdQVrMRBibINO+0cTpXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794493950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:From:To:Subject:Thread-Topic:Thread-Index:Date:
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
	bh=EJqiUxdeKRvVT4gcgU/oIS/3H8UyQ59s5xZ5rUnqz9Q=;
	b=JXdzrZ1XF+d7ZRSHf+s/MfYuwEy8StSwlj9iVayIrFD3yeh8+rDw7eYftgzA5N4H4jwV
	 iyGmcdqNgJMbD2AEIQjJGRjf4D5jkQywXYMnki3QzHSSnvhOMWbQoYZVDKRPIEXG24yFt
	 qn80Quu8MhJd/qQymy8ZdmwB0CcaRoqfSvf8CUuxspuCoi3ufDapuOxs+wdNHbarXbf9q
	 Y+gSmgbzgs6sUVbgbJtj1DlPocJcAmg/s5CEPujOGtxsJMQmuCXMSzahv8od+xqq25X6U
	 pTL0pPCGKPg4ImTnBTUSCrBBGmH6uKpTSK+oe4rB02EUSExQsuml04IDxP15D5XHs+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794493949;
	bh=EJqiUxdeKRvVT4gcgU/oIS/3H8UyQ59s5xZ5rUnqz9Q=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oDfl6JlzEjC+Lvx4JBTjkNvHIUbofCczIvgXXKs1w5FEqxTl7xYmi0BUsEakF8/XA
	 AquTUvWW/7270hWhj/NRMH1rWEFlwHS3adA/cYvz1nbbq41o0SBzshtuwQlmiogH++
	 ZrFmLQ5wxnNJVfyNLlhphA2j17sXMXt1lo8/4njcZypQrOeLoMpxLPsOJcKdKVlC9E
	 K1xQEIpOuQ4OAsa3xtX02ZFZOC9NSglGhHMpUbImCNroVznm1l7E73S0p0jvVY64oO
	 T6WVKq5RolT8LfUKi+YM13TjJdHebqOVFvNOkzLQV9+nsdX1k6s7hr+aQWY2kWy55w
	 VDW77AIjKTnJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4663810DD;
	Thu, 12 Nov 2026 14:32:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BCFC8235
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 14:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE95C6076A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 14:32:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SN-dGj8TV93G for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 14:32:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E8AF607A2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nHUZS20r; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=cp2kH/rI
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E8AF607A2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794493946; x=1826029946;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=EJqiUxdeKRvVT4gcgU/oIS/3H8UyQ59s5xZ5rUnqz9Q=;
 b=nHUZS20rBOIbmCVSW/hhqkFVgoY4Oh9ImyhDRlVKvXKSWEq4MEPDqS1V
 KAFWUwj2oIB+nhts7NWPrv6EAm6ijHjkO53juBfL4WAzUeBWFFLUk1mzb
 p9x0hsxD/PnXN55K94Z2VTWRMs/X7MtWsEbkGbFG8205+PI8borxqGpto
 Y2Qf+oXO7e1PcWS73091UHLUnixJkPJxzEJy0brdNrvJdPGmf/fI1Jk0O
 H0JIpBCr+G+SIR5Vh7aHny0Tf4g5ccBmiF7xzJJ4sfIjTy/VaSHR3r1Xx
 pthMcvJYwP91/LPXxZoT+FwrE1g8IfWuC1P1e76BluYPN/0GGPEiua2qN w==;
X-CSE-ConnectionGUID: 5+uVoBSXQFGwrf0u1dO3vQ==
X-CSE-MsgGUID: D2B6kRaeT+a1fnbK1Vrh2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3379309"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3379309"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 06:32:24 -0800
X-CSE-ConnectionGUID: 0kcF/JSoTa2Cex/mZqKXPA==
X-CSE-MsgGUID: xqdJR5H2SO+aJ2fNNi0vVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8673503"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 06:31:59 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 06:31:59 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 06:31:59 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 06:31:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJqiUxdeKRvVT4gcgU/oIS/3H8UyQ59s5xZ5rUnqz9Q=;
 b=cp2kH/rIoFHrVV5a6r4vE0A2xcfwfopF/Z1Wig5/G2+2XO09rvPgnIRS6zg+oZjWCbI5fzE8xuub9d6oOE/8X4uqdvmXPpHZbpy/5wl/3+bR5qibHKn4HgfgnyLvFUyID1xD4GB27E886ZrI5i/k9ep8NSOmkFrLNezKU+eJlwk=
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by DS4PR11MB9604.namprd11.prod.outlook.com (2603:10b6:8:34a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 14:31:57 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 14:31:57 +0000
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH iwl-next v3 2/2] idpf: add direct Tx timestamp readout
Thread-Topic: [PATCH iwl-next v3 2/2] idpf: add direct Tx timestamp readout
Thread-Index: AQHdcqPf2RscbdzCKEmHbcWKXc4H37cqbJgAgAARJ7A=
Date: Thu, 12 Nov 2026 14:31:56 +0000
Message-ID: <PH0PR11MB490458594EC62674CF057D4594702@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20261112123503.234508-1-przemyslaw.korba@intel.com>
 <20261112123503.234508-5-przemyslaw.korba@intel.com>
 <sashiko-outbox-211168@kernel.org>
In-Reply-To: <sashiko-outbox-211168@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|DS4PR11MB9604:EE_
x-ms-office365-filtering-correlation-id: 2abbb574-2753-4eb6-ae3d-08df40c9b47c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|261026121527099003|4143699003|261022105027099003|11063799006|261028144727099003|56012099006|261009223027099003|261026140227099003|261022075727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: Hyynru3utno3wluFAV0+thoaewikOardxDn5+pe5j+zleysdHDrl6iyv4GcB1+R92ifyS/XI1bhtdZcNOcb0ijVjiR7koqRPSSTPL2nDfyXMYRQVtbNHJCsh7Xlr/oTt1dHftmjOEcu9Tmt4fkUQ8qCY0noic99UFrQCbsBOipFDkMXQUoRTfN3uX/U+6Vw4TPAkx87J6bIbpe4NcexZhW6oVdjfka69vFAlKSnrOs+pT5pRcgA1KVErjG3baQqNcilkUzQjKCOE/x787JpJu8JStzUGkBwupv4GorD5WD4hQF97qQiwc0W3hsqx7rHALqQHsJ0tl0twSCl7nvS7DCJXOYRHdyQFWvdKugaeLUtquPW+J48/sSruAL6D3a7x2Z9jvRFOgMu3Vv1XSzVUewAHtXgpYDYcScTLSEBd1H7nALaZ5E3bXg59RzPzTsIouKljCKYT8+0BoKvU/MisCDSEWdLaao7qB1BCOnsd3wKhCGFrxsqoCRFT0js/o9ek5Y4JUQngLwi/cUTlFA20bM8L/ekviGO2M1MRePYFvozTis8FoGWvImZbZNh/2xuCLC9pfvRwZNl+gltTVj0TKBoG5tiO1K9a+rTXUzEIWvZnpz8HiyzpJDQDw1n82RzOp5a0NAzIUjGatXaxvnfc5ZWmoYavKnpYyTiZ9Zhe/w4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4904.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(261026121527099003)(4143699003)(261022105027099003)(11063799006)(261028144727099003)(56012099006)(261009223027099003)(261026140227099003)(261022075727099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2c5WktxNFdDdDdQdnYrS2xnWGdWL0s3MnJQRHlwbnhOZXNlNERydW1KODB0?=
 =?utf-8?B?WDlZOHRSOW11R3dHajVPU0t2RmdzUG81NmVPRHZXRUZvSmZCYUhOMHdBc0lW?=
 =?utf-8?B?djNLYnFKNnB4YUJJdk1IUW9tZ0xUNUdwU3Q3NmR1bDRVVUdkV3RZeGZrWURZ?=
 =?utf-8?B?ejRiMXlzOVYyVVNKeml0bThoTWFpRit1eGlTclZaUi9CeUhnK0xaM3gxR3Jy?=
 =?utf-8?B?bUZwYSs2YkM5TVJ6UFBXenFhbnZJeTV6aXl5a0hXSEs5RnlHc0o1Rm0vLzRD?=
 =?utf-8?B?dU9SSVExb2N5T29iejFFRHlKdmpYV3ZZSURSdnJIaGVRT3BkZUZDWnJKeXdS?=
 =?utf-8?B?by9jU1ZHak4vVnZkODZRa0xBT0cySWlYWlFoSjdvaHR1SVBGcUZoYjlvRE4x?=
 =?utf-8?B?dGNlY21UdEpaVFIzZUJwWnUzSmFyc1lYUFNVR1ljVUJKOEp1a29JRU8rMHov?=
 =?utf-8?B?WmFoRUhvZkIvMEhHRUNoWm9wTEFkWTVyMDZVM1pxN3NLRFA0L0pxL1BOWGZz?=
 =?utf-8?B?N04wTHpPRE9sTmNmSXdsUThmUE5nZTB1QXJlMnYzQmtJYUR5NWFNOTNNUTJD?=
 =?utf-8?B?d1huVENPNHdBWW9aMWhaaWF4YndHN0FHNDQ0NDJpbnBONjhaL2IzVnRhbXNv?=
 =?utf-8?B?aUFENGx2OW9GUm1hTXhkUkdZNS9qQytCbE90NjRhR3pOZ0RtelZDQlF1QU1h?=
 =?utf-8?B?bTAwS2pXQzRGaDNIZ2FXalBmVnlsajZRVUI0NXlMZEpNUHEycTlFUUJQZktU?=
 =?utf-8?B?dVluQmZFU3V1T28vbmlGWnE2S0YzYUlmUTQ0cjQyeXdVbUdNajV6dzZ0TVFv?=
 =?utf-8?B?K3ZTVTJUUXlFR2ROUHlmRmZnbkszWHVJZTVIdWo1SXJMN2I3MklXcnRaejBz?=
 =?utf-8?B?eTNmd0N0cTQ4Tm9Rdm5XMU9JVWFiVUxoaWRKS0Zzbmx0ZCtpL0xTTEVKbU9u?=
 =?utf-8?B?MzcyRmxEVHR4T1JVaXFyOTl2cVRXQis3UFdMSElwU3RWM1BDeVVHWEYrWkpO?=
 =?utf-8?B?eEZCV09HWURMTzNFT1d3ZVRKTU40YlY4TE1TQU0wSDdDNnRPSERERzAzK1c0?=
 =?utf-8?B?SWYyZ2RvL044di81UEdYREg0ZE1ETi93MzVrbXhQZnRsSHNsNmNVRGhzeHB1?=
 =?utf-8?B?N25XcUMyR3NCMmVRTlNIcGFpQ0lwa2liWVgxT2dzN2FMam5IeFdjUXhHUXBC?=
 =?utf-8?B?cHJLbHNtdG5HaVpGcENwbjc5NDZtbUV2Q09uY3NidWNBcU9PRjVLNlZndm1m?=
 =?utf-8?B?MlF6UEJvYTliOHM4eC9wT3Y1YVd1ZXk0OHE0OVlCM09yZG0wL0lMRnlBL011?=
 =?utf-8?B?TjhTTFkzOUhDL3hKY1daVlR2d29RZW1Ka3ZLU3BpbnBBR2JKRmNvWHl2VTNY?=
 =?utf-8?B?WDFCWjY3ZHl6U3ZNVlVzb0F6UnVuQmRCT2ZiMmkwWllKbTEyL1hKZktIcWhF?=
 =?utf-8?B?dkw5L1hlZEowY3dmYUh0UDg0UmtUUWttZDFYZklTZGc5Rmp3OFRtSW9NRXlo?=
 =?utf-8?B?Qi85RjlDSDY4R0pwQUhBNXJ6T2VzNDNTUjdsYjhvZEl0NXhCaldjU1YzSFN2?=
 =?utf-8?B?REV6MkVOM2hWYzlKV09CRTZxc1podFlTMkJWTWNJRlpVUVhWbG9UNzUzWVM5?=
 =?utf-8?B?T1R2Q2czR2ppQndNUFVkckxWK1Vrb2hoNUxseTRWdXdaWnBiOGJCdjR0YmYy?=
 =?utf-8?B?clZ1bUw2amY4T2haVUxTK0RKNEozS3ZxMEpDMTBzWlhUOUptcVRxZEI2cU92?=
 =?utf-8?B?K1VIWEtnV2FmOTFRcHQ1Z3FiaFNVdHBLUjMzNmNzZ3lRNlNjVzhUMk9Vd1BW?=
 =?utf-8?B?dW00eWZHNDZHQ2R5UWpzR3UwVXhIV0lTeFJOMlpoSFhBUm5jVjM5OTBMLzZN?=
 =?utf-8?B?UTkwbUVuN2J6S25CQlp2QnVRWGhxWmVFZERlNUx4amsvdzQwWkZKdUdxcVVL?=
 =?utf-8?B?UExJVmpSS0JBNnMwZDhlMThSNCttb2ZVMTh6NGJ4b3lvOStLVjd3bEllekJ2?=
 =?utf-8?B?ZUVTd1NIbWRGa1RvZWIvNjlCd05VVjB5YVRzVG42aEhNZWIyend1YytTMjdU?=
 =?utf-8?B?SzFkLzh6blFZR08yempjY29MK041Vk5rSnNyZnRmSnkrRTZ6NHUvOFF5TFlF?=
 =?utf-8?B?eUN4SEJHN3hxQnl0Qkk0ZDlVaWtqMkJjQytZZytKK3lraTNVeGQveXVFNjA3?=
 =?utf-8?B?WlpjVTlFalYrWkVWU011dVFyczJnVEE5RmlaL3lzRVhsb3RPUG41T2IydkNs?=
 =?utf-8?B?UTJVKzhPb2luQVRUeGRadjh2OFp6MU8zTndKRGNKdGo4cnBGRTB0TS9qUE9Z?=
 =?utf-8?B?dEd6TEtzV0RLYldFeHZtN2lYazVhaDhKdUtOZTF5dWR4QURsU0FDZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s0Gk/MbRpC63snXNQMb3pfrj8DR7jMOaWW6D/wpto2JwIDccemnCGmCEWdsLWUqCL+0MSk++RkX379WCaOD9cYVCg3XBDoeg92J9GkE3r7BK4kL8dXN41hHy4FBnRVKX1WdbTyrFYwmnymeq1XjvUJdA21czrXj3J8qnUaQyV66/uWoIthIOm5kz45xawpiYKx9W/YMbmGpup5ZMhi2fC1VxhHGLDXYiIVtKXAgQ799BF5m7Gu9QsuW18iN4aFIXDd6BvPFbRBcqTZqt+Ne6bP1eFK7pYwy5Sjqw1BRaEjMSbCNN/aeJOqK8Xq+igA2l1sCXm6atqAO9lIk+r9RrQA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abbb574-2753-4eb6-ae3d-08df40c9b47c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 14:31:57.0147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /p+t/tNMa86rUayL+WaWgHGdMyZ0Ul5GBj579PZ146DTJnyl6VpUEGCCDF51FP1Dq8WjKGtWMefTONnMnVJOulSr9NDK/zSEwMCiU57DCgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB9604
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzYXNoaWtvLWJvdEBr
ZXJuZWwub3JnIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTm92
ZW1iZXIgMTIsIDIwMjYgMjoyMyBQTQ0KPiBUbzogS29yYmEsIFByemVteXNsYXcgPHByemVteXNs
YXcua29yYmFAaW50ZWwuY29tPjsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCBpd2wtbmV4dCB2MyAyLzJdIGlkcGY6IGFkZCBkaXJlY3QgVHgg
dGltZXN0YW1wIHJlYWRvdXQNCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24h
IFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDMgcG90ZW50aWFsDQo+IGlzc3VlcyB0byBjb25zaWRl
cjoNCj4gLSBbSGlnaF0gaWRwZjogcHJlbWF0dXJlIGlkcGZfcHRwX3JlbGVhc2UoKSBiZWZvcmUg
dnBvcnQgc3RvcCBpbg0KPiAgIGlkcGZfdmNfY29yZV9kZWluaXQoKQ0KPiAtIFtNZWRpdW1dIGlk
cGY6IHN0YWxlIFcxQyByZWFkaW5lc3MgYml0cyBsZWZ0IHNldCBhZnRlciBsYXRjaCB0aW1lb3V0
DQo+ICAgb3IgZmx1c2gNCj4gLSBbTWVkaXVtXSBpZHBmOiBtaXNzaW5nIElEUEZfVlBPUlRfVVAg
Y2hlY2sgaW4NCj4gICBpZHBmX3B0cF90eF90c3RhbXBfc3RhcnQoKSBhbmQgbW9kZSBzZXQNCj4g
LS0NCj4gDQo+IGNvbW1pdCA0MTAzZTY3NzExNjk0ZTcyZDhlMjgyOGQ5OTUxNGNjZjUxY2QyZjA3
DQo+IEF1dGhvcjogUHJ6ZW15c2xhdyBLb3JiYSA8cHJ6ZW15c2xhdy5rb3JiYUBpbnRlbC5jb20+
DQo+IA0KPiBpZHBmOiBhZGQgZGlyZWN0IFR4IHRpbWVzdGFtcCByZWFkb3V0DQo+IA0KPiBUaGlz
IGNvbW1pdCBhZGRzIGRpcmVjdCBCQVIgcmVnaXN0ZXIgYWNjZXNzIGZvciByZWFkaW5nIFR4IHRp
bWVzdGFtcHMgdmlhIGENCj4gcGVyaW9kaWMgMTAwIHVzIGhydGltZXIsIGFsb25nIHdpdGggd3Jp
dGUtMS10by1jbGVhciByZWFkaW5lc3MgYml0bWFwDQo+IGhhbmRsaW5nIGFuZCBhIDUwMCBtcyBl
eHBpcmF0aW9uIHRpbWVvdXQgZm9yIHVubGF0Y2hlZCByZXF1ZXN0cy4NCj4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl9wdHAuYyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl9wdHAuYw0KPiA+IGluZGV4IGRmMmRhNDMw
ZmYyOGYuLjVkNzQ1YTUzZDY4NjUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWRwZi9pZHBmX3B0cC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWRwZi9pZHBmX3B0cC5jDQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+IEBAIC04NTEsMTkg
KzkyNSwyOTYgQEAgaW50IGlkcGZfcHRwX3JlcXVlc3RfdHMoc3RydWN0IGlkcGZfdHhfcXVldWUg
KnR4X3EsIHN0cnVjdCBza19idWZmICpza2IsDQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+ICsJCS8q
IEEgbGF0Y2ggd2l0aCBubyB0aW1lc3RhbXAgaXMga2VwdCBpbiB1c2UgdW50aWwgaXRzIGRlYWRs
aW5lDQo+ID4gKwkJICogcGFzc2VzLCBhcyB0aGUgaGFyZHdhcmUgbWF5IHN0aWxsIGJlIGFib3V0
IHRvIHJlcG9ydCBpdC4NCj4gPiArCQkgKiBPbmNlIGl0IGRvZXMsIGRyb3AgaXRzIHJlYWRpbmVz
cyBiaXQgYXMgd2VsbCwgc28gdGhhdCB0aGUNCj4gPiArCQkgKiBuZXh0IHVzZXIgb2YgdGhlIGlu
ZGV4IGlzIG5vdCBnaXZlbiBhIHN0YWxlIHRpbWVzdGFtcCBpZg0KPiA+ICsJCSAqIHRoZSBoYXJk
d2FyZSByZXBvcnRzIG9uZSBhZnRlciB0aGUgbGF0Y2ggaGFzIGJlZW4gcmVjbGFpbWVkLg0KPiA+
ICsJCSAqLw0KPiA+ICsJCWlmICghcHRwX3R4X3RzdGFtcC0+dHN0YW1wKSB7DQo+ID4gKwkJCWlm
ICh0aW1lX2lzX2FmdGVyX2ppZmZpZXMocHRwX3R4X3RzdGFtcC0+ZGVhZGxpbmUpKQ0KPiA+ICsJ
CQkJY29udGludWU7DQo+ID4gKw0KPiA+ICsJCQljbGVhcl9tYXAgfD0gQklUX1VMTChpZHgpOw0K
PiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJbGlzdF9tb3ZlKCZwdHBfdHhfdHN0YW1wLT5saXN0X21l
bWJlciwgJmRvbmUpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCS8qIFRoZSBpbmRleGVzIGFyZSBu
b3QgcmVjeWNsZWQgYmVmb3JlIHRoZSBzcGxpY2UgYmVsb3csIHNvIHRoZSBiaXRzDQo+ID4gKwkg
KiBvZiBldmVyeSBsYXRjaCByZWFkIGFib3ZlIGNhbiBiZSBkcm9wcGVkIGluIGEgc2luZ2xlIHdy
aXRlLg0KPiA+ICsJICovDQo+ID4gKwlpZHBmX3B0cF9jbGVhcl90eF90c3RhbXBfcmVhZHkodHN0
YW1wX2NhcHMsIGNsZWFyX21hcCk7DQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gQ2FuIGEg
cGFja2V0IHRoYXQgbGF0Y2hlcyBpbiBoYXJkd2FyZSBhZnRlciBpdHMgZGVhZGxpbmUgZXhwaXJl
cyAob3IgYWZ0ZXINCj4gaWRwZl9wdHBfdHhfdHN0YW1wX3N0b3AoKSBmbHVzaGVzIGxhdGNoZXNf
aW5fdXNlKSBsZWF2ZSBpdHMgd3JpdGUtMS10by1jbGVhcg0KPiByZWFkaW5lc3MgYml0IHNldCB3
aGlsZSB0aGUgbGF0Y2ggc2l0cyBvbiBsYXRjaGVzX2ZyZWU/DQo+IA0KPiBCZWNhdXNlIHJlYWRp
bmVzc19hZGRyX2wgYW5kIHJlYWRpbmVzc19hZGRyX2ggYXJlIHdyaXRlLTEtdG8tY2xlYXIsIGNh
bGxpbmcNCj4gaWRwZl9wdHBfY2xlYXJfdHhfdHN0YW1wX3JlYWR5KCkgd2hlbiB0aGUgZGVhZGxp
bmUgZXhwaXJlcyAob3Igd2hlbg0KPiBIV1RTVEFNUF9UWF9PRkYgZmx1c2hlcyBsYXRjaGVzX2lu
X3VzZSBvbiBhIGxpdmUgdnBvcnQpIGlzIGEgbm8tb3AgZm9yIGFueQ0KPiBpbi1mbGlnaHQgcGFj
a2V0IHdob3NlIHJlYWRpbmVzcyBiaXQgaXMgc3RpbGwgMCBpbiBoYXJkd2FyZS4gIElmIHRoYXQg
cXVldWVkDQo+IHBhY2tldCBmaW5pc2hlcyB0cmFuc21pc3Npb24gYWZ0ZXJ3YXJkcyAoZm9yIGV4
YW1wbGUsIGFmdGVyIFNPX1RYVElNRSBwYWNpbmcNCj4gb3IgZmxvdyBjb250cm9sKSwgdGhlIGhh
cmR3YXJlIHNldHMgYm90aCB0aGUgcmVhZGluZXNzIGJpdCBhbmQNCj4gSURQRl9QVFBfVFhfVFNU
QU1QX0xfVkFMSURfTSB3aGlsZSB0aGUgbGF0Y2ggaXMgb24gbGF0Y2hlc19mcmVlLCBzbyB0aGUg
bmV4dA0KPiBwYWNrZXQgYWxsb2NhdGVkIHRoYXQgaW5kZXggd2lsbCByZXBvcnQgdGhlIHByZXZp
b3VzIHBhY2tldCdzIHN0YWxlDQo+IHRpbWVzdGFtcC4NCj4gDQo+IENsZWFyaW5nIHN0YWxlIHJl
YWRpbmVzcyBiaXRzIGluIGlkcGZfcHRwX2dldF90eF90c3RhbXBfZGlyZWN0KCkgZm9yIGJpdHMN
Cj4gbm90IGN1cnJlbnRseSBpbiBsYXRjaGVzX2luX3VzZSAoYW5kIGluIGlkcGZfcHRwX3R4X3Rz
dGFtcF9zdGFydCgpKSB3b3VsZA0KPiBhdm9pZCBoYW5kaW5nIG91dCBhIGxhdGNoIHdpdGggYSBw
ZW5kaW5nIGhhcmR3YXJlIHRpbWVzdGFtcC4NCj4gDQoNCldlIGFscmVhZHkgY2xlYXIgdGhlIGJp
dCBvbiBib3RoIHBhdGhzLCB0aGUgdGltZW91dCBwYXRoIGlzIGZvciBwYWNrZXRzIGRyb3BwZWQg
aW4gdGhlIGRldmljZSwgYW5kIHRoZSBmbHVzaCByYWNlIGlzIGEgbWljcm9zZWNvbmQtc2NhbGUg
d2luZG93IHRoZSBoYXJkd2FyZSBnaXZlcyB1cyBubyB3YXkgdG8gY2xvc2UuDQpXb24ndCBmaXgg
aW4gdGhpcyBzZXJpZXMNCg0KPiBbIC4uLiBdDQo+IA0KPiA+ICt2b2lkIGlkcGZfcHRwX3R4X3Rz
dGFtcF9zdGFydChzdHJ1Y3QgaWRwZl92cG9ydCAqdnBvcnQpDQo+ID4gK3sNCj4gPiArCWlmICgh
aWRwZl9wdHBfaXNfdnBvcnRfdHhfdHN0YW1wX2VuYSh2cG9ydCkgfHwNCj4gPiArCSAgICB2cG9y
dC0+dHhfdHN0YW1wX2NhcHMtPmFjY2VzcyAhPSBJRFBGX1BUUF9ESVJFQ1QpDQo+ID4gKwkJcmV0
dXJuOw0KPiA+ICsNCj4gPiArCS8qIFRoZSBjYWxsYmFjayByZS1hcm1zIGl0c2VsZiwgc28gaXQg
bXVzdCBiZSBmaW5pc2hlZCBiZWZvcmUgdGhlIHRpbWVyDQo+ID4gKwkgKiBpcyBzdGFydGVkIGFn
YWluLCBlLmcuIHdoZW4gb25seSB0aGUgUnggZmlsdGVyIGlzIGJlaW5nIGNoYW5nZWQuDQo+ID4g
KwkgKi8NCj4gPiArCWlmIChSRUFEX09OQ0UodnBvcnQtPnRzdGFtcF9jb25maWcudHhfdHlwZSkg
PT0gSFdUU1RBTVBfVFhfT04pIHsNCj4gPiArCQlocnRpbWVyX2NhbmNlbCgmdnBvcnQtPnR4X3Rz
dGFtcF90aW1lcik7DQo+ID4gKwkJaHJ0aW1lcl9zdGFydCgmdnBvcnQtPnR4X3RzdGFtcF90aW1l
ciwNCj4gPiArCQkJICAgICAgSURQRl9QVFBfVFhfVFNUQU1QX1BFUklPRF9OUywNCj4gPiArCQkJ
ICAgICAgSFJUSU1FUl9NT0RFX1JFTF9TT0ZUKTsNCj4gPiArCX0NCj4gPiArfQ0KPiANCj4gWyAu
Li4gXQ0KPiANCj4gPiBAQCAtOTIzLDEyICsxMjc0LDIxIEBAIGludCBpZHBmX3B0cF9zZXRfdGlt
ZXN0YW1wX21vZGUoc3RydWN0IGlkcGZfdnBvcnQgKnZwb3J0LA0KPiA+ICAJY2FzZSBIV1RTVEFN
UF9UWF9PTjoNCj4gPiAgCQlpZiAoIWlkcGZfcHRwX2lzX3Zwb3J0X3R4X3RzdGFtcF9lbmEodnBv
cnQpKQ0KPiA+ICAJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gIAkJYnJlYWs7DQo+ID4g
IAlkZWZhdWx0Og0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQl2
cG9ydC0+dHN0YW1wX2NvbmZpZy50eF90eXBlID0gY29uZmlnLT50eF90eXBlOw0KPiA+ICsJLyog
UHVibGlzaCB0aGUgbmV3IG1vZGUgZmlyc3QsIHNvIHRoYXQgdGhlIFR4IHBhdGggc3RvcHMgaGFu
ZGluZyBvdXQNCj4gPiArCSAqIGxhdGNoZXMsIHRoZW4gZmx1c2ggdGhlIG9uZXMgdGhhdCBhcmUg
c3RpbGwgd2FpdGluZy4NCj4gPiArCSAqLw0KPiA+ICsJV1JJVEVfT05DRSh2cG9ydC0+dHN0YW1w
X2NvbmZpZy50eF90eXBlLCBjb25maWctPnR4X3R5cGUpOw0KPiA+ICsJaWYgKGNvbmZpZy0+dHhf
dHlwZSA9PSBIV1RTVEFNUF9UWF9PTikNCj4gPiArCQlpZHBmX3B0cF90eF90c3RhbXBfc3RhcnQo
dnBvcnQpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCWlkcGZfcHRwX3R4X3RzdGFtcF9zdG9wKHZwb3J0
KTsNCj4gPiArDQo+ID4gIAlpZHBmX3B0cF9zZXRfcnhfdHN0YW1wKHZwb3J0LCBjb25maWctPnJ4
X2ZpbHRlcik7DQo+ID4gIAkqY29uZmlnID0gdnBvcnQtPnRzdGFtcF9jb25maWc7DQo+IA0KPiBb
U2V2ZXJpdHk6IE1lZGl1bV0NCj4gQ2FuIGlkcGZfaHd0c3RhbXBfc2V0KCkgLT4gaWRwZl9wdHBf
c2V0X3RpbWVzdGFtcF9tb2RlKCkgc3RhcnQNCj4gdnBvcnQtPnR4X3RzdGFtcF90aW1lciBhbmQg
ZGVyZWZlcmVuY2UgYSBOVUxMIHJzcmMtPnJ4cV9ncnBzIHdoZW4gdGhlIHZwb3J0DQo+IGlzIGRv
d24/DQo+IA0KPiBpZHBmX2h3dHN0YW1wX3NldCgpIG9ubHkgY2hlY2tzIHZwb3J0LT5saW5rX3Vw
LCB3aGljaA0KPiBpZHBmX2hhbmRsZV9ldmVudF9saW5rKCkgc2V0cyBldmVuIHdoaWxlIElEUEZf
VlBPUlRfVVAgaXMgY2xlYXIgYW5kIHF1ZXVlcw0KPiBhcmUgbm90IGFsbG9jYXRlZC4gIENhbGxp
bmcgaWRwZl9wdHBfc2V0X3RpbWVzdGFtcF9tb2RlKCkgaW4gdGhhdCBzdGF0ZSBhcm1zDQo+IHR4
X3RzdGFtcF90aW1lciBvbiBhIHN0b3BwZWQgdnBvcnQgYW5kIHRoZW4gY3Jhc2hlcyBpbg0KPiBp
ZHBmX3B0cF9zZXRfcnhfdHN0YW1wKCkgd2hlbiBpbmRleGluZyByc3JjLT5yeHFfZ3Jwcy4NCj4g
DQo+IEFsc28sIHdoZW4gYSB2cG9ydCBpcyByZW9wZW5lZCwgaWRwZl92cG9ydF9vcGVuKCkgY2Fs
bHMNCj4gaWRwZl9wdHBfdHhfdHN0YW1wX3N0YXJ0KHZwb3J0KSBiZWZvcmUgaWRwZl91cF9jb21w
bGV0ZSgpIHNldHMgSURQRl9WUE9SVF9VUCwNCj4gYW5kIG5ldmVyIGNhbGxzIGlkcGZfcHRwX3Nl
dF9yeF90c3RhbXAoKSB0byByZXN0b3JlIHRoZSBQVFAgZmxhZyBvbiB0aGUNCj4gbmV3bHkgYWxs
b2NhdGVkIFJ4IHF1ZXVlcy4NCg0KVGhlIHJ4cV9ncnBzIGRlcmVmZXJlbmNlIGFuZCB0aGUgUngg
UFRQIGZsYWcgbm90IGJlaW5nIHJlc3RvcmVkIG9uIHJlb3BlbiBhcmUgYm90aCBpbiB0aGUgDQpl
eGlzdGluZyBSeCB0aW1lc3RhbXAgY29kZSwgbm90IGluIHRoaXMgcGF0Y2gsIHNvIHRoZXkgZml0
IGJldHRlciBhcyBhIHNlcGFyYXRlIGZpeC4NCldvbid0IGZpeCBpbiB0aGlzIHNlcmllcw0KPiAN
Cj4gPiBAQCAtMTAzNSw4ICsxMzk1LDE5IEBAIHN0YXRpYyB2b2lkIGlkcGZfcHRwX3JlbGVhc2Vf
dnBvcnRfdHN0YW1wKHN0cnVjdCBpZHBmX3Zwb3J0ICp2cG9ydCkNCj4gPiAgew0KPiA+ICAJc3Ry
dWN0IGlkcGZfcHRwX3R4X3RzdGFtcCAqcHRwX3R4X3RzdGFtcCwgKnRtcDsNCj4gPiAgCXN0cnVj
dCBsaXN0X2hlYWQgKmhlYWQ7DQo+ID4gKwl1NjQgY2xlYXJfbWFwID0gMDsNCj4gPg0KPiA+IC0J
Y2FuY2VsX3dvcmtfc3luYygmdnBvcnQtPnRzdGFtcF90YXNrKTsNCj4gPiArCXN3aXRjaCAodnBv
cnQtPnR4X3RzdGFtcF9jYXBzLT5hY2Nlc3MpIHsNCj4gPiArCWNhc2UgSURQRl9QVFBfTUFJTEJP
WDoNCj4gPiArCQljYW5jZWxfd29ya19zeW5jKCZ2cG9ydC0+dHN0YW1wX3Rhc2spOw0KPiA+ICsJ
CWJyZWFrOw0KPiA+ICsJY2FzZSBJRFBGX1BUUF9ESVJFQ1Q6DQo+ID4gKwkJaHJ0aW1lcl9jYW5j
ZWwoJnZwb3J0LT50eF90c3RhbXBfdGltZXIpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSBJ
RFBGX1BUUF9OT05FOg0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlicmVhazsNCj4gPiArCX0NCj4g
Pg0KPiA+ICAJLyogUmVtb3ZlIGxpc3Qgd2l0aCBmcmVlIGxhdGNoZXMgKi8NCj4gPiAgCXNwaW5f
bG9ja19iaCgmdnBvcnQtPnR4X3RzdGFtcF9jYXBzLT5sYXRjaGVzX2xvY2spOw0KPiANCj4gWyAu
Li4gXQ0KPiANCj4gPiBAQCAtMTA2MSw2ICsxNDM2LDEwIEBAIHN0YXRpYyB2b2lkIGlkcGZfcHRw
X3JlbGVhc2VfdnBvcnRfdHN0YW1wKHN0cnVjdCBpZHBmX3Zwb3J0ICp2cG9ydCkNCj4gPiAgCX0N
Cj4gPiAgCXU2NF9zdGF0c191cGRhdGVfZW5kKCZ2cG9ydC0+dHN0YW1wX3N0YXRzLnN0YXRzX3N5
bmMpOw0KPiA+DQo+ID4gKwlpZiAodnBvcnQtPnR4X3RzdGFtcF9jYXBzLT5hY2Nlc3MgPT0gSURQ
Rl9QVFBfRElSRUNUKQ0KPiA+ICsJCWlkcGZfcHRwX2NsZWFyX3R4X3RzdGFtcF9yZWFkeSh2cG9y
dC0+dHhfdHN0YW1wX2NhcHMsDQo+ID4gKwkJCQkJICAgICAgIGNsZWFyX21hcCk7DQo+ID4gKw0K
PiA+ICAJc3Bpbl91bmxvY2tfYmgoJnZwb3J0LT50eF90c3RhbXBfY2Fwcy0+bGF0Y2hlc19sb2Nr
KTsNCj4gPg0KPiA+ICAJa2ZyZWUodnBvcnQtPnR4X3RzdGFtcF9jYXBzKTsNCj4gDQo+IFtTZXZl
cml0eTogSGlnaF0NCj4gQ2FuIGlkcGZfdmNfY29yZV9kZWluaXQoKSBmcmVlIHZwb3J0LT50eF90
c3RhbXBfY2FwcyB3aGlsZSBUeCBxdWV1ZXMgYW5kDQo+IG5kb19od3RzdGFtcF9zZXQgYXJlIHN0
aWxsIGFjdGl2ZT8NCj4gDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl92
aXJ0Y2hubC5jOmlkcGZfdmNfY29yZV9kZWluaXQoKSB7DQo+ICAgICAuLi4NCj4gCWlkcGZfcHRw
X3JlbGVhc2UoYWRhcHRlcik7DQo+IAlpZHBmX2RlaW5pdF90YXNrKGFkYXB0ZXIpOw0KPiAgICAg
Li4uDQo+IH0NCj4gDQo+IER1cmluZyBpZHBmX3JlbW92ZSgpIGFuZCBpZHBmX3NodXRkb3duKCks
IGlkcGZfcHRwX3JlbGVhc2UoKSBydW5zIGJlZm9yZQ0KPiBpZHBmX2RlaW5pdF90YXNrKCkgc3Rv
cHMgdGhlIHZwb3J0cyBhbmQgdW5yZWdpc3RlcnMgdGhlIG5ldGRldnMsIGFuZCB3aXRob3V0DQo+
IGhvbGRpbmcgdnBvcnRfY3RybF9sb2NrOg0KPiANCj4gQ1BVMCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBDUFUxDQo+IGlkcGZfdmNfY29yZV9kZWluaXQoKQ0KPiAgIGlkcGZfcHRw
X3JlbGVhc2UoKQ0KPiAgICAgaWRwZl9wdHBfcmVsZWFzZV92cG9ydF90c3RhbXAoKQ0KPiAgICAg
ICBocnRpbWVyX2NhbmNlbCgmdHhfdHN0YW1wX3RpbWVyKQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGlkcGZfaHd0c3RhbXBfc2V0KCkNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC4uLg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpZHBmX3B0cF90eF90c3RhbXBfc3RhcnQoKQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhydGltZXJfc3RhcnQoJnR4X3RzdGFt
cF90aW1lcikNCj4gICAgICAga2ZyZWUodnBvcnQtPnR4X3RzdGFtcF9jYXBzKQ0KPiAgICAgICB2
cG9ydC0+dHhfdHN0YW1wX2NhcHMgPSBOVUxMDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPHNvZnRpcnE+DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpZHBmX3B0cF90eF90c3RhbXBfdGltZXJfY2IoKQ0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpZHBmX3B0cF9nZXRfdHhfdHN0YW1wX2RpcmVjdCgp
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl9sb2Nr
KCZ0c3RhbXBfY2Fwcy0+Li4uKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDwtLSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UNCj4gDQo+IEluIGFkZGl0aW9u
LCBiZWNhdXNlIHZwb3J0LT50c3RhbXBfY29uZmlnLnR4X3R5cGUgcmVtYWlucyBIV1RTVEFNUF9U
WF9PTiBhbmQNCj4gZWFjaCBxdWV1ZSdzIHR4X3EtPmNhY2hlZF90c3RhbXBfY2FwcyBzdGlsbCBw
b2ludHMgdG8gdGhlIGZyZWVkIHN0cnVjdHVyZQ0KPiB1bnRpbCBpZHBmX2RlaW5pdF90YXNrKCkg
LT4gaWRwZl92cG9ydF9zdG9wKCkgZGlzYWJsZXMgVHgsIGFueSBwYWNrZXQNCj4gdHJhbnNtaXR0
ZWQgb3IgY29tcGxldGVkIGluIHRoZSBtZWFudGltZSBkZXJlZmVyZW5jZXMgZnJlZWQNCj4gdHhf
cS0+Y2FjaGVkX3RzdGFtcF9jYXBzIGluIGlkcGZfcHRwX3JlcXVlc3RfdHMoKSBvciBpZHBmX3R4
X3JlYWRfdHN0YW1wKCkuDQo+IA0KDQpUaGUgb3JkZXJpbmcgZXhpc3RzLCBidXQgaXQgaXNuJ3Qg
aW50cm9kdWNlZCBieSB0aGlzIHNlcmllcy4gaWRwZl9wdHBfcmVsZWFzZSgpIGZvbGxvd2VkIGJ5
IGlkcGZfZGVpbml0X3Rhc2soKSBoYXMgYmVlbiBpbiBpZHBmX3ZjX2NvcmVfZGVpbml0KCkgZm9y
IGEgbG9uZyB0aW1lLg0KV29uJ3QgZml4IGluIHRoaXMgc2VyaWVzDQoNCj4gLS0NCj4gU2FzaGlr
byBBSSByZXZpZXcgwrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYxMTEyMTIz
NTAzLjIzNDUwOC0xLXByemVteXNsYXcua29yYmFAaW50ZWwuY29tP3BhcnQ9Mg0K
