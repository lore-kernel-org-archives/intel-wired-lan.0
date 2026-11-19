Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7ED606A325
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dQ/wrAtW;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=beUE9yNK;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=JJ9EA+PC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0F7740A20;
	Thu, 19 Nov 2026 10:30:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKf__eTr9Q38; Thu, 19 Nov 2026 10:30:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1E83240A11
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795084232;
	b=QSXhMvOaMFMw/PZ32Isk2Aq4gHVfv1XfG/7FCjF3NPQ+daFPtoUt+d6ZF1BvJmwGi/tI
	 CvusQ0wptdrSIWNLaOdInyUXdOVuv5kybt05I7wvpHVxXy1GHmGFlh/Whf4GG6chgHNZT
	 OF44OtjIyk9P+TDWn/wb1v0UUKb1IY0YZVjj9PdoqMcSj1mZzXLzhVWZncmZ2401VVMKw
	 cBIr14BBZ7/HQupsYioPLrs8KGclErdQ6qcjbCdn4Z+na/oX6ZxgkopWLHFlJKWgjJoGB
	 JUeORyrVova7GWjoJ0jSXbs0TdYZcLt6a5UE0K7jIecZ2OPChzYZStc9glJ6QdaROcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795084232;
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
	bh=SHqTY/UFiZcSmNnRc3J/Jrkk44Suxb48Mecx9Pj7ziA=;
	b=Yyx6mdNKNIff5PULim/3QqONZ/qi9+VKSyZ8y4xAWcSuS3QQzxqlS4EwBVVq7K968YPg
	 YiNjKlygMI/hynxEMRurdRYBOtwxQBehBAWodfo1hd9aST7pmk4ClmyeMo/7jswC03e3M
	 ldMSneay6XYPvJ38GYCeUDcyCbIx/t7pI4CxyEAC+rVRs7Nsi1r1Uv0aXCsRpLJrmuRXJ
	 J1uefMAdzxkh6+2P1ms7bYgJmJFxtoAWGbtqN9yuikzvyeh+7fQyEyCrNogdq3rQzQE20
	 mGkZSmL7691eSe+VpbSn6LNxZOZz5ZMu4ZbWORcbbIyi4Rgom30Vs5wnV9/Y14g4G/Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795084232;
	bh=SHqTY/UFiZcSmNnRc3J/Jrkk44Suxb48Mecx9Pj7ziA=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dQ/wrAtWFtAO8kT/9nOOciRkkmxHHzynyFOAyNEe8cffWLzXDwqu5yenc2R9qRem9
	 U4TGN+t85lEFNTU+CbIGbU378U+coqc4kbinD9NuAPWi9dAXToKgj6C7AEgSiS6Lik
	 kQpivQGZXAFsPDSiolGt+LE+BKAreZ7rXW6NrqDDBlPSpoojgr++qr4xqD7l847hZK
	 QV9mXV+NaxvEoNXyKmBJTbJdkBdpjKDW73KaBV6Y7TbqWFlX9PggA6ZMaU0H3PWX+b
	 zhyFvwEYjSJ+PnbskCRX9rsn+J0zUkU0afHZZ2WxrPTtCGRRr+OxPoZBwziWH3I94y
	 cTrzkjSwzahEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E83240A11;
	Thu, 19 Nov 2026 10:30:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F5972F1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 10:30:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8554C80E69
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 10:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6-eLauBGsJWr for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 10:30:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7665981240
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=beUE9yNK; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=JJ9EA+PC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7665981240
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795084229; x=1826620229;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=SHqTY/UFiZcSmNnRc3J/Jrkk44Suxb48Mecx9Pj7ziA=;
 b=beUE9yNKUebFvD9vm8D2dHPt4O8IpgVrjChW/7stZAtiOf49sRK3FeKp
 usm8jzgL3+R70k498Fl5Ujyyq/R4tAG31rhiWB92XHUXbywnLjX6t24St
 msLJBlpiK11K/C47UdbZOFoXkVwdR9ovmrT1LOtz+md+H5OTxyJdZVC0S
 l0LjZSuakUM0HCdUyZnmnja1rgrGXBEWpM7C9NEwSIlN5fWm3AkGsKj6b
 d6wb/oQU89+p5cZGPryHiD/jL8d0DF93+CMSa7/z7I/NDcfoxOveDmsiu
 6ROyQjZzZVou2Ylx+c5S8rgGh3/BlqpsJgvEc7HdrJkIE1SoeNPnB9SCY g==;
X-CSE-ConnectionGUID: xTHBYe8xR/q73mN52QD8iA==
X-CSE-MsgGUID: VEkukLfYQfqyIeBk3C9mLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3816922"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3816922"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 02:30:26 -0800
X-CSE-ConnectionGUID: 5wxFHBCjS0SPn6aivobecg==
X-CSE-MsgGUID: iqb34G6mTk6Th0a05uUAYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10667709"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 02:30:26 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 02:30:25 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 02:30:25 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 02:30:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHqTY/UFiZcSmNnRc3J/Jrkk44Suxb48Mecx9Pj7ziA=;
 b=JJ9EA+PCZ5gS3W1xTCJ62ta76luUBw333Obl66v00FoV25i9lymrNhfijVIzq8SAsRrQst8ZI+OKSl418cxinFjPZxplK4LIoAChz3kN/CPokY0r0HOp5tLxCxNltOOBU4RGl37tUju7n1deSvjphx7WMIDSMZByT0a4ihY++TU=
Received: from CH3PR11MB810902.namprd11.prod.outlook.com
 (2603:10b6:610:34a::20) by SA1PR11MB6784.namprd11.prod.outlook.com
 (2603:10b6:806:24c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 10:30:21 +0000
Received: from CH3PR11MB810902.namprd11.prod.outlook.com
 ([fe80::1ec1:24a8:f6d1:552c]) by CH3PR11MB810902.namprd11.prod.outlook.com
 ([fe80::1ec1:24a8:f6d1:552c%5]) with mapi id 15.21.0615.016; Thu, 19 Nov 2026
 10:30:21 +0000
From: "Karlsson, Magnus" <magnus.karlsson@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH iwl-net] ice: use the queue pair's XDP ring in
 ice_qp_{dis, ena}()
Thread-Topic: [PATCH iwl-net] ice: use the queue pair's XDP ring in
 ice_qp_{dis, ena}()
Thread-Index: AQHdd2oYSJe3P3EETUiDGvslZNgdT7c1MsJQ
Date: Thu, 19 Nov 2026 10:30:21 +0000
Message-ID: <CH3PR11MB810902A5D3E10666990633EBD8F7792@CH3PR11MB810902.namprd11.prod.outlook.com>
References: <20261118135952.1063685-1-magnus.karlsson@intel.com>
 <sashiko-outbox-221222@kernel.org>
In-Reply-To: <sashiko-outbox-221222@kernel.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB810902:EE_|SA1PR11MB6784:EE_
x-ms-office365-filtering-correlation-id: e9a8ab8f-1c95-41c9-ae66-08df46281d3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|260925022911599003|11063799006|4143699003|260925021311599003|261009223027099003|56012099006|261022105027099003|261022075727099003|261022115727099003|261026140227099003|261026121527099003|261028144727099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Er5fD/3LaVg1Q247Xc55W7pNl1WWXdg4G/v33p39BTM6jBOHTLmGWCwYH+QYCsbhTvB5Xa6oO5Z/28E/9g30hFDQe38ScYQZ74IsVeWl0W10bXNeMk3EgrKPYySU4zFECdJEJrp3c6ZsSHMLUeB7obNNhbYjOvmFDAsO4CxOLEQ652G4GXNstCRTXshWzMXhi8iBC0o7LOyYZL5kBhPEp7lH1c5Uw2MPaJERzDMQdlttI8sfTBUlgZY5prQlwol84OYOz7AfTPJUcylFF0WZPXdRyYhVkYm+4z4j/OvF/sLfwVNYSPKHtH7fi9Lzxa42lui+E3XE4pQrXtCCSCZvX/XTB3YeRITYlY+eJJ34QdIvOdHR6tV+UopaWQuYQO3FKPyltNZL737hAH5a7W3ZJWcjWqhGKFH0BAfDFio1NSYRMQ/O8I6d/tSym+M5t0P1/FLd7Sta7pqsSaL4N9rBjGnJZhDqvbiF8VrqxplP3P/P9JDBeXAYi7/EkR5B/cR48jAlDscwq1N3gPQqwc6cOVgogvizNHktaItuZ9xJnRdi9+FRsr4F+spHm+tfjzdgzR4UKqOXRQnu6aPHRMPApeLGlgh56zdIwuyXBpE87LR70DuNaCFRVogqNmt7nBOrMGklrWc8bMXDqrcQLxmeqCrOp02z2oiKXoODsIo/3sc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB810902.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(260925022911599003)(11063799006)(4143699003)(260925021311599003)(261009223027099003)(56012099006)(261022105027099003)(261022075727099003)(261022115727099003)(261026140227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXVuQytDN1hqd1k0WURIY0w0cUREODJxMFVHQ1hNbXgySG93N1p4emZXVi9a?=
 =?utf-8?B?WnJ5WVdiaGVwcU9ub05CdEZIMXkrMHVSZ2tHMTZqRkhib25iN2dwM2FDSnJn?=
 =?utf-8?B?Q2FhZlMyNDBmVGJ2WmU4empQNmhJcUdSVnZvOGdrNURJS1BsTCtZczFrQ1Vm?=
 =?utf-8?B?QStEUjJRbkg1ZzlEanFZUEwrTzRHbmhSMndvK3M2bFBQQU5HWEYwVjFsSjd2?=
 =?utf-8?B?dGxZRmhSM25iZVlaSVA0VEd5ZHRMZmg5WXZmTHZoZkQyVHpPMnF3VjMyckdR?=
 =?utf-8?B?a2JLWEEwdGhGWERGb2lmVWRhVjhsZHoybDFFSFBNb2x3R2JqejVHOGk4Y3Vl?=
 =?utf-8?B?WEF3U1RvNlNIUG9yT3kwUWtOT2xTR2ZUR0sxbWpUV1YxRU9VTjNrbTVNVmJx?=
 =?utf-8?B?VmRJdEI1QXRzTTRYaTh2TGtBMlpKOEliYXdQYUwxZk1HTzZRMzAwVmhaMnlR?=
 =?utf-8?B?VWJVNXg3ampnMkk3Vi9lSktzQkxvQzRrQlk0alVYM2ViRWJycXhvOVJYNmds?=
 =?utf-8?B?V1laZzlKNW8zODdXWDd2czNpaHVHQTlrRUVSUWlTRHQ3aGV5UE9XVVZUVHdK?=
 =?utf-8?B?d2JIVEtJNUFjYXlnMk1MeGtxM3ZyMEpNUEZPTm1tODNLdzl4aS9mSE9OTTVX?=
 =?utf-8?B?MEhwVllkSm9SSGdnbTMvREFTWiswSGVTMmVnN3k4L3djbmR0bWMxOFB0R0JK?=
 =?utf-8?B?VG4vZFlsUjE5VEFZcS9hWDlkU21qemZhQjNldlB5N0xvRWovWW85V0ZTMU1s?=
 =?utf-8?B?blRxcmhTdUVYVFJTdS9wZFhxZjRGeEhBMFQ3bFcvdHFYMktDTUpNZGhDaE1i?=
 =?utf-8?B?RTVBb2hJczMzOEcrcVFWcUQ2QUxoVFJSUDNmZG1WQ210UGpPdEdkamJCbGlM?=
 =?utf-8?B?Ny9XbGFFSXRmd0NIQU9NK2NmWGxJMWtaNVNNL0VwRFZKSTVSc0hEVWlqcEdi?=
 =?utf-8?B?NS9maEVNcklXVkt4RUpUR3QwenFjenVralMwc2Y1cUErc2hNdmFDZmdDRDhW?=
 =?utf-8?B?dlJRS2hjNnBjc2tFcVNzQXEzL3cvZzhheGpyMnVrNGVaVTE2QkdXQUJTejI4?=
 =?utf-8?B?OHNwTzQybFZ3c29QR1lNenhWTVNVL0ZRQm9Lc2psSXV1RUsxNEJDQTFDUTAy?=
 =?utf-8?B?M29id3FRWE1BMmFaUjBGSFNQNFV1bGhoNGVvUnpodVQyMGtCcjl4cVZaZ0xY?=
 =?utf-8?B?ckhvYVgzZFhjYnpvT01Hc3NKaW1NWWRFa0VqSU8ybkJSRnQ4b2w0SlNGZzBp?=
 =?utf-8?B?dWt0cHd4T1Yvd2M3OWZ0Ny92S2JvVW9tK1B3L3RTN2lPalQyWTNqeDlCVjRi?=
 =?utf-8?B?N3VGVDV4UFZFZkdKR0FNTnZPTHpkNWJGVDBLa3BPL3ZBMnRDaXNTRENmdXRT?=
 =?utf-8?B?aXdFSC91dHJBV0N4L2dCa1p6OFEvY0pGR0pXVHd0T3NCU254dkRaZ29PZHly?=
 =?utf-8?B?UVlyalJLZG1RT2l2a0xlUlQwNXZyRmFCbXV2ZUhFVFAxWnh0eUZhN1pIcC8z?=
 =?utf-8?B?S3pXWkFLZXIyaDhBY2FZMlg4aDJvbElxdlVLMG4wbWRUZll4YTZkKzRBeEZN?=
 =?utf-8?B?dThqaEdVN0ViR2V6ZHljeGpxaFl0aGdybVgwS2wzZldILzRyRGdFUDhDU2Zn?=
 =?utf-8?B?UExXOFhYWjNMcHduKytIelRsQXdyOW02V21XLzQwMjVpZHFnenhndmV0UmI1?=
 =?utf-8?B?NTRiLzdIdjkrdHM2ck0zT3ptbXN2Y0lFZ3g4aHMreEVEN2hpNEZhcW5tNnF6?=
 =?utf-8?B?ODV6bkFYMTNrY1o3RGZIMjQ2MXE4T0JXWXViQXBSaUN6Umt3R25UeWpQbVpz?=
 =?utf-8?B?YVNBdklCN2RaNTJkaytvcGphaVRpOWo4N1l2VmNsVnVsOVhxZzExeitMRWJ4?=
 =?utf-8?B?RUFtVmdxTUJ2a2tEN3RvTWVGRWtCMkpKL1hnc1NzYWlDUDJjY2grNHlkV2or?=
 =?utf-8?B?cHdrV3g0L056VXFaQTAzcEhPU25zWE9yTXZlUC9YMnBxNkU0bDNUeWNuak4z?=
 =?utf-8?B?a2pkNGtIbzhxc3haaGVlUGRBWExjNk1CanhsemNOSXdYZ1l2LyszYTBNUnRm?=
 =?utf-8?B?YUtQaXl6OTJQak1CclV4YURGSnI2aldOWWpEcnFKU21sWW5CcDRPYlQwdno2?=
 =?utf-8?B?d2lHSlRDeVNNNU1YYmY1YTVxWEt3U0xTVDF6ZEZ6N21HaG55ZW5jcjRQVFV1?=
 =?utf-8?B?YTFBV2tLVDdLZmNjQVl2TXVXbVdJWU84WnlZRzVrOUREUHZuRDR2aXBXUkx1?=
 =?utf-8?B?RVJZRzZQT3FsdVJ2RGw4anZqWEpJdDR6OW1nV0JXTG5ZbHNoWld1eFRCZXFs?=
 =?utf-8?B?Y2JLNHoxWmxSVENiWXh0SzNEck53STJmMGtkM1ppd2pRSVZNa1FhUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qlTnmZaDX+LoUH+I4ihACup2hIrI4QtTZK5wQbViQFJ56x9MhAMyvRFMXyHxin36Jd18PE2E6Uf8zxjz2F4dCQ4fTBnvVL/nBbMoTv+xgeETYWBNm0l8z+vIPuf6dCjqPdUd+O+WKBQxcdj/EREmbEZ4gHmNgHCFOWB+omDzd1r3QdKVrwlYOCb59yDzLTtGkieDKcFbR/LbCItqoMOLgmbTX4s+B/tVc2KyAlXPTi6FVhSw7lKNM/RS4LJqPMfl5L60OsmeMsrlOYQZK5U7SVpbOxg8ylARTJTL2KZGOi3wQ9dns3mC+k5JReiCRlq2vc+NpUBQ+xHBN47AqCIQ1A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB810902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a8ab8f-1c95-41c9-ae66-08df46281d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 10:30:21.2755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xr6uGBy8hp/sc5P8rETlO6jWXy5vp2XCYvg98KTTUJOb2tYOXa3n+1877JdXs2C+of1ld/viuCCDb99Uv9prmz05pPZG9HVF28BEO4vSNo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6784
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc2FzaGlrby1ib3RAa2Vy
bmVsLm9yZyA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3Zl
bWJlciAxOCwgMjAyNiAzOjM1IFBNDQo+IFRvOiBLYXJsc3NvbiwgTWFnbnVzIDxtYWdudXMua2Fy
bHNzb25AaW50ZWwuY29tPjsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBpd2wtbmV0XSBpY2U6IHVzZSB0aGUgcXVldWUgcGFpcidzIFhEUCBy
aW5nIGluIGljZV9xcF97ZGlzLCBlbmF9KCkNCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250
cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDEgcG90ZW50aWFsDQo+IGlzc3VlIHRv
IGNvbnNpZGVyOg0KPiAtIFtIaWdoXSBpY2U6IFhEUCByaW5nIFFJTlRfVFFDVEwgaW50ZXJydXB0
IG1pc21hdGNoIGluIGljZV9xcF9kaXMoKSBhbmQNCj4gICBpY2VfcXBfZW5hKCkNCj4gSXQgYWxz
byBub3RpY2VkIDEgcmVsYXRlZCBwcmUtZXhpc3RpbmcgaXNzdWUgdGhpcyBwYXRjaCBkb2VzIG5v
dA0KPiBpbnRyb2R1Y2U6DQo+IC0gW0NyaXRpY2FsXSBpY2U6IGluY29ycmVjdCBYRFAgcXVldWUg
aW5kZXhpbmcgaW4NCj4gICBpY2VfY2ZnX3R4cV9pbnRlcnJ1cHQoKSBbMV0NCj4gLS0NCj4gDQo+
IGNvbW1pdCAxNjE5NmE3YzQ3Zjc0YTgzMmZjOTFmODYyZjc1ZTAxOWJlMmY2NDE4DQo+IEF1dGhv
cjogTWFnbnVzIEthcmxzc29uIDxtYWdudXMua2FybHNzb25AaW50ZWwuY29tPg0KPiANCj4gaWNl
OiB1c2UgdGhlIHF1ZXVlIHBhaXIncyBYRFAgcmluZyBpbiBpY2VfcXBfe2RpcywgZW5hfSgpDQo+
IA0KPiBUaGlzIGNvbW1pdCB1cGRhdGVzIGljZV9xcF9kaXMoKSwgaWNlX3FwX2VuYSgpLCBpY2Vf
cXBfY2xlYW5fcmluZ3MoKSwgYW5kDQo+IGljZV9xcF9yZXNldF9zdGF0cygpIHRvIG9wZXJhdGUg
b24gdnNpLT5yeF9yaW5nc1txX2lkeF0tPnhkcF9yaW5nIGluc3RlYWQNCj4gb2YgdnNpLT54ZHBf
cmluZ3NbcV9pZHhdLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9iYXNlLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNl
X2Jhc2UuYw0KPiA+IGluZGV4IDE2NjdmNjg2ZmY3NTEuLmFhMGFkMzEzYTk3Y2QgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9iYXNlLmMNCj4gPiAr
KysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2Jhc2UuYw0KPiBbIC4uLiBd
DQo+ID4gQEAgLTE0NjAsOSArMTQ4MCw3IEBAIGludCBpY2VfcXBfZGlzKHN0cnVjdCBpY2VfdnNp
ICp2c2ksIHUxNiBxX2lkeCkNCj4gPiAgCWVyciA9IGljZV92c2lfc3RvcF90eF9yaW5nKHZzaSwg
SUNFX05PX1JFU0VULCAwLCB0eF9yaW5nLCAmdHhxX21ldGEpOw0KPiA+ICAJaWYgKCFmYWlsKQ0K
PiA+ICAJCWZhaWwgPSBlcnI7DQo+ID4gLQlpZiAodnNpLT54ZHBfcmluZ3MpIHsNCj4gPiAtCQlz
dHJ1Y3QgaWNlX3R4X3JpbmcgKnhkcF9yaW5nID0gdnNpLT54ZHBfcmluZ3NbcV9pZHhdOw0KPiA+
IC0NCj4gPiArCWlmICh4ZHBfcmluZykgew0KPiA+ICAJCW1lbXNldCgmdHhxX21ldGEsIDAsIHNp
emVvZih0eHFfbWV0YSkpOw0KPiA+ICAJCWljZV9maWxsX3R4cV9tZXRhKHZzaSwgeGRwX3Jpbmcs
ICZ0eHFfbWV0YSk7DQo+ID4gIAkJZXJyID0gaWNlX3ZzaV9zdG9wX3R4X3JpbmcodnNpLCBJQ0Vf
Tk9fUkVTRVQsIDAsIHhkcF9yaW5nLA0KPiA+IEBAIC0xNDk3LDkgKzE1MTUsMTEgQEAgaW50IGlj
ZV9xcF9lbmEoc3RydWN0IGljZV92c2kgKnZzaSwgdTE2IHFfaWR4KQ0KPiA+ICAJCWZhaWwgPSBl
cnI7DQo+ID4NCj4gPiAgCWlmIChpY2VfaXNfeGRwX2VuYV92c2kodnNpKSkgew0KPiA+IC0JCXN0
cnVjdCBpY2VfdHhfcmluZyAqeGRwX3JpbmcgPSB2c2ktPnhkcF9yaW5nc1txX2lkeF07DQo+ID4g
KwkJREVGSU5FX1JBV19GTEVYKHN0cnVjdCBpY2VfYXFjX2FkZF90eF9xZ3JwLCBxZ19idWYsIHR4
cXMsIDEpOw0KPiA+ICsJCXN0cnVjdCBpY2VfdHhfcmluZyAqeGRwX3JpbmcgPSBpY2VfcXBfeGRw
X3JpbmcodnNpLCBxX2lkeCk7DQo+ID4NCj4gPiAtCQllcnIgPSBpY2VfdnNpX2NmZ19zaW5nbGVf
dHhxKHZzaSwgdnNpLT54ZHBfcmluZ3MsIHFfaWR4KTsNCj4gPiArCQlxZ19idWYtPm51bV90eHFz
ID0gMTsNCj4gPiArCQllcnIgPSBpY2VfdnNpX2NmZ190eHEodnNpLCB4ZHBfcmluZywgcWdfYnVm
KTsNCj4gPiAgCQlpZiAoIWZhaWwpDQo+ID4gIAkJCWZhaWwgPSBlcnI7DQo+ID4gIAkJaWNlX3Nl
dF9yaW5nX3hkcCh4ZHBfcmluZyk7DQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IERvZXMgaWNl
X3FwX2VuYSgpIGxlYXZlIFFJTlRfVFFDVExfQ0FVU0VfRU5BX00gY2xlYXJlZCBvbiB4ZHBfcmlu
ZyBhZnRlcg0KPiBpY2VfcXBfZGlzKCkgc3RvcHMgaXQ/DQo+IA0KPiBJbiBpY2VfcXBfZGlzKCks
IGljZV92c2lfc3RvcF90eF9yaW5nKCkgY2xlYXJzIFFJTlRfVFFDVExfQ0FVU0VfRU5BX00gaW4N
Cj4gUUlOVF9UUUNUTCh4ZHBfcmluZy0+cmVnX2lkeCkuICBXaGVuIGljZV9xcF9lbmEoKSByZS1l
bmFibGVzIHRoZSBxdWV1ZQ0KPiBwYWlyLCBpdCBjb25maWd1cmVzIE1TSS1YIHZpYSBpY2VfcXZl
Y19jZmdfbXNpeCgpIC0+DQo+IGljZV9jZmdfdHhxX2ludGVycnVwdCgpLCB3aGljaCBzdGlsbCB3
cml0ZXMgdG8gYSBkaWZmZXJlbnQgcXVldWUgaW5kZXg6DQo+IA0KPiBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX2Jhc2UuYzppY2VfY2ZnX3R4cV9pbnRlcnJ1cHQoKSB7DQo+ICAg
ICAuLi4NCj4gCXdyMzIoaHcsIFFJTlRfVFFDVEwodnNpLT50eHFfbWFwW3R4cV0pLCB2YWwpOw0K
PiAJaWYgKGljZV9pc194ZHBfZW5hX3ZzaSh2c2kpKSB7DQo+IAkJdTMyIHhkcF90eHEgPSB0eHEg
KyB2c2ktPm51bV94ZHBfdHhxOw0KPiANCj4gCQl3cjMyKGh3LCBRSU5UX1RRQ1RMKHZzaS0+dHhx
X21hcFt4ZHBfdHhxXSksDQo+IAkJICAgICB2YWwpOw0KPiAJfQ0KPiAgICAgLi4uDQo+IH0NCj4g
DQo+IFdoZW4gdGhlcmUgYXJlIGZld2VyIHF1ZXVlIHZlY3RvcnMgdGhhbiBDUFVzLCB2c2ktPnR4
cV9tYXBbcV9pZHggKw0KPiB2c2ktPm51bV94ZHBfdHhxXSBpcyBub3QgeGRwX3JpbmctPnJlZ19p
ZHguICBBcyBhIHJlc3VsdCwgeGRwX3JpbmcncyBUeA0KPiBpbnRlcnJ1cHQgcmVtYWlucyBkaXNh
YmxlZCAoYnJlYWtpbmcgQUZfWERQIHplcm8tY29weSBUeCBjb21wbGV0aW9ucyksIGFuZA0KPiBh
bm90aGVyIHJpbmcncyBRSU5UX1RRQ1RMIGlzIG92ZXJ3cml0dGVuIHdpdGggdGhpcyBxdWV1ZSB2
ZWN0b3IncyBNU0ktWA0KPiBpbmRleC4NCg0KVGhpcyBpcyBhbiBleGlzdGluZyBidWcuIFR4IGlu
dGVycnVwdHMgY2FuIGJlIGxvc3QuDQoNCj4gW1NldmVyaXR5OiBDcml0aWNhbF0NCj4gVGhpcyBw
cm9ibGVtIHdhc24ndCBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dCBpY2VfY2ZnX3R4cV9p
bnRlcnJ1cHQoKQ0KPiBhbmQgaWNlX3ZzaV9yZWxlYXNlX21zaXgoKSBhbHNvIGNvbXB1dGUgdGhl
IFhEUCBxdWV1ZSBvZmZzZXQgaW4NCj4gdnNpLT50eHFfbWFwIGFzIHR4cSArIHZzaS0+bnVtX3hk
cF90eHEgWzFdLCB3aGVyZWFzDQo+IGljZV9wcmVwYXJlX3hkcF9yaW5ncygpIHBsYWNlcyBYRFAg
cmluZ3MgaW4gdnNpLT50eHFfbWFwIHN0YXJ0aW5nIGF0DQo+IHZzaS0+YWxsb2NfdHhxLg0KPiAN
Cj4gV2hlbiB0aGUgYWxsb2NhdGVkIExBTiBUeCBxdWV1ZSBjb3VudCBkaWZmZXJzIGZyb20gdnNp
LT5udW1feGRwX3R4cSAoZm9yDQo+IGV4YW1wbGUsIGFmdGVyIGNoYW5naW5nIHRoZSBjaGFubmVs
IGNvdW50IHdpdGggZXRodG9vbCksIGluZGV4aW5nDQo+IHZzaS0+dHhxX21hcFt0eHEgKyB2c2kt
Pm51bV94ZHBfdHhxXSBjYW4gYWNjZXNzIHBhc3QgdGhlIGVuZCBvZg0KPiB2c2ktPnR4cV9tYXAg
b3IgY29ycnVwdCBRSU5UX1RRQ1RMIGZvciB0aGUgd3JvbmcgaGFyZHdhcmUgcXVldWVzLiAgSW4N
Cj4gYWRkaXRpb24sIGljZV92c2lfcmVsZWFzZV9tc2l4KCkgb25seSBpdGVyYXRlcyB1cCB0byBx
X3ZlY3Rvci0+bnVtX3JpbmdfdHgsDQo+IHdoaWNoIGxlYXZlcyB0aGUgcmVtYWluaW5nIFhEUCBy
aW5ncycgUUlOVF9UUUNUTCBpbnRlcnJ1cHQgbWFwcGluZ3MgYWN0aXZlDQo+IHdoZW4gdGhlcmUg
YXJlIGZld2VyIExBTiBUeCBxdWV1ZXMgdGhhbiBYRFAgcXVldWVzLg0KPiANCj4gWzFdIGh0dHBz
Oi8vc2FzaGlrby5kZXYvIy9idWcvbGludXgtMGIzMDgyMjQtNzEwNy00ZDIzLTliYmMtOWFlNWM4
MGIzNjJiDQo+IA0KPiAtLQ0KPiBTYXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3Nhc2hpa28u
ZGV2LyMvcGF0Y2hzZXQvMjAyNjExMTgxMzU5NTIuMTA2MzY4NS0xLW1hZ251cy5rYXJsc3NvbkBp
bnRlbC5jb20/cGFydD0xDQo=
