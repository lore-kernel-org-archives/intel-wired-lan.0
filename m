Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B504606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mqU8PefZ;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XvnKs0OW;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=OKL80odG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 663F780D9D;
	Mon, 23 Nov 2026 07:12:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZzMM7XyeRuyD; Mon, 23 Nov 2026 07:12:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A70B480D9F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795417929;
	b=B7mlPT5gSVQLkkUPsdd+ZeBxk3nESbwaZno6jmaKCWWZmE7eZFgl74QtAEwu3IGJpWWC
	 mZvdXdrbPbBquuFQlybNfGpMV+oxHXtSpAnE670I/5HPw0trT9x5ZVtLy5H0obyMLZGtS
	 IyZt8ID6WcvX081U9x6tN2DSxWW2W4cqVD0vwubft/nMLsy718VQxvCnMwgqT5xd8fZUR
	 k9ak0mSvFYaCwYazh5IijESwqbmzlMf/4gNW4yTxt+QLdMupzyqaOrE0+MpAPxDDY1udL
	 /dVcs3m3tNdYKfMmBmds1/41moeCkpCgpJSkjuaUWu7cN4v1Ka6SfKYUGiToOvcxONQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795417929;
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
	bh=OT1Ik+ZD/j2MCEZSb/TvREm92uIi9TcB86ipXhIHjkE=;
	b=XidGCRPgdQhWhJGYLCE84toPTa4Pn19IblBu91wHQtlUEB5Fm4mdrbBm2LTsPqmUVeUC
	 s2+IMuQG8xJfjzPNW7thKSiqLOi+zjuNX+6lHLVlXo6oEME+bEBpNNO22vUYVWE663U32
	 dA8UkKZgqV5X+/sFhep6RlH2L1TMqn+jxJBMsVuq7OrJSQBICjJIlnApFfVDFmaJHAVy2
	 6PHn+puts7RVjeXObe+aLkrz6AH3ym+QHtcW0IUJ+B5R2Ve4WCE3owweSmeWtc6oPLD89
	 hR+2w9fjZrGJNata3vhnS8SRcoZHIanAALzASDWw73osW3Nhy2VXo1pyjflst5l1MKw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795417929;
	bh=OT1Ik+ZD/j2MCEZSb/TvREm92uIi9TcB86ipXhIHjkE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mqU8PefZZ7jNelsJeAO/SSsEFcxkgczSRl7r8KDXGuz8sVY/6PxFhWuUXQdZ8c/c1
	 3E7oS4gntywS9fkzdjZMqkV51Jy1r5UTQOS3pHkBvBAB4gPHmG7yVG9neMkX2eIUos
	 h7ox3xTKbpmM098f3uCn6h48/n5+Vx+lMrSvBx/lfRmTNCdyxY7CxIJ35Q3gJ8Vg5I
	 mipIDKUQ11Fpe8VlnpL1+yF4QmluRQXGH8MS3hQu5Xw22nBGbwisu9HBxKuvlswd0e
	 TgqOJLolUt+AGbw23AspKxLLFJGdHRabsUsLEy0d1oyv6yaedAhSo9ufLqeZ848YwI
	 76NVCW91osPvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A70B480D9F;
	Mon, 23 Nov 2026 07:12:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E568C310
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 07:12:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6EBF40081
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 07:12:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hFRpoGkCu0X0 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 07:12:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6E54840063
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=ayush1x.singh@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XvnKs0OW; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=OKL80odG
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E54840063
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795417923; x=1826953923;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OT1Ik+ZD/j2MCEZSb/TvREm92uIi9TcB86ipXhIHjkE=;
 b=XvnKs0OWuUbTdMRan3C0eVQsopQZ6ZXSlTy5weFN8LEwxXaHV37v0899
 hayNotO3ge/reXealf8EucwyJOMnQqgD9ZYLTYdSAR8b8Gp/0ZG+Rvwv4
 7SpnnB7SJ+PkV9A1Ba5BGV/Xeqn8sa/xV3FR9crM15dTHlVoP5w4KVIEn
 yLHWRxHCU5MT/y757SvAQslfZQUAaMSEGP/AqaZ6LwuNWYVVGouU1XIRu
 1kWtKR9eWNt5XJB77QhWf3B8qjd7rpXTn/zwoyKlezxZl8ilYL///z27W
 c7/M4N1WtCS60PTVoIzOFDSaMlJwm56BTkbJkDP6YPOHtvEF+DG+QrIRW A==;
X-CSE-ConnectionGUID: bCpLylr1TOyOMj/Am3mRBQ==
X-CSE-MsgGUID: Ek0OJuTTTFeQo0Sai2mxLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4112678"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4112678"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:12:01 -0800
X-CSE-ConnectionGUID: 98hImrhmROSCgZK+FPxxSg==
X-CSE-MsgGUID: Mt7cs7hbTUC4+f4xfwTPKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11209666"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:12:01 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Sun, 22 Nov 2026 23:12:00 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Sun, 22 Nov 2026 23:12:00 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 23:12:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT1Ik+ZD/j2MCEZSb/TvREm92uIi9TcB86ipXhIHjkE=;
 b=OKL80odGV5vgMNjOZE+Bdnu7gRo45jOAHabVaQnO4reirKjZZ2hcSsfx09vtciNHJJJExJR9bDt/7Rd3WgpM4FXF1N/7tEmX/34nFkF5FuESQXp9cFGuDIPaHLxMSrYwYRsusr/E+LVAzwnNao0q4JJJ2Ws6kWfXonzOL69wGPE=
Received: from BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14)
 by PH8PR11MB6975.namprd11.prod.outlook.com (2603:10b6:510:224::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 07:11:52 +0000
Received: from BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4]) by BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 07:11:52 +0000
From: "Singh, Ayush1X" <ayush1x.singh@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "Machnikowski, Maciej" <maciej.machnikowski@intel.com>, "Neustadter, Marc"
 <marc.neustadter@intel.com>, "Temerkhanov, Sergey"
 <sergey.temerkhanov@intel.com>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start with
 PTP lock and incval
Thread-Topic: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start
 with PTP lock and incval
Thread-Index: AQHdTT4EYxYJVO3Bn0mqNTv532uANbc7mVTQ
Date: Mon, 23 Nov 2026 07:11:51 +0000
Message-ID: <BY5PR11MB3976A5840078F09C4E8CD038A5452@BY5PR11MB3976.namprd11.prod.outlook.com>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
 <20260925222824.270640-2-grzegorz.nitka@intel.com>
In-Reply-To: <20260925222824.270640-2-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3976:EE_|PH8PR11MB6975:EE_
x-ms-office365-filtering-correlation-id: 20065f51-8953-42bf-748b-08df49310c60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|261009223027099003|56012099006|11063799006|261022105027099003|10067099003|4143699003|261021123027099003|261102123227099003|261022075727099003|261026140227099003|261028144727099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: U6hXZRkSX2JHXtx5MO9bcqGGDvZPEkJfpyp5aF9UvPUaGtSPZ0+WUIIpX5mURkPitkqMVv25rkuI0rLt7jUsAXXYo0XlzRNtim6Eb+1f7u3YKDF+Uw3mmsufpnjm1584vS6JVdqo9VZaqI2Xouue0CFah1c5QmVQC8MWeAO1k0SkdeBCDtr57YrDI9OlFoNWUj0tJZHGdgvpnmiVwYJIRFsTi1HvVDI6Co5YmEWRCyz6mXWbbpjp1m/jGapGxHsh+q6SZm6xyxIK+CUI6a+G+WPCf6ga+tDQRE75VW8mI8deTVoQPsLZUwJ29QfQqBW0b3zrrECFrpe4Be03E8mdTPg6r6i9Nd951o1HqoN18mG8QbQzRgo8rq58wngYlioMvm1yEc6kVOSNo7BGaRUDFYXckEoaibrzLfdpRvsO2GKWhbHJ3JllkgGqsZW4BAR+lfSPaZsbCEeRiCLDg91wC6oTAT3EP8kSGOGnMSVENf0rzaboGOzI27qJYibiqyZSwzWVXofyPxCJFnHYlnKljVXR03Mb4KzKR4kM+upO+EKQeXACtJTl84gpemZZl5BIew9MZm7FJG6d33B7iAF43M2zOfZR3PRjmhKDQhTFEaC5zq02iXWfDLYrE98GfuGR2lixrUPxPbKQ45aRe+1NGURGN3EISssEyutHl+Sliwl94mPvC258BZzClzl7+3vU17oPEo/GDRNe7227SZXOIa+gdHF35XpCR62JanqfXTg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3976.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(56012099006)(11063799006)(261022105027099003)(10067099003)(4143699003)(261021123027099003)(261102123227099003)(261022075727099003)(261026140227099003)(261028144727099003)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zFUGcPdh/v+ZhrinaIbiGTsygimdc552iJMNK/B5QCd3dQUPWNmy4XJIkDd+?=
 =?us-ascii?Q?rshmoQ8ULXvvqSxO5fSLrTdWrXM8iQmvE/08Zpx2W5Gspexx3ZdjEg01lCDv?=
 =?us-ascii?Q?712MTpA8B7nWCNVikgPCMm8VDnc+snvEIIhHwYnNLvKo98OTEqgbeZuLTI1F?=
 =?us-ascii?Q?L9Yk5n+DI6/broSV2vDGFKeGzBqAJgawgRIC79ta41o+bTuMDCpq19Oppw2h?=
 =?us-ascii?Q?b57wDgPCaDGQophUN17vrirxcUNI5FOt6SIuHtoO2CFLZQoMKWlP3dN94prB?=
 =?us-ascii?Q?K4I+c3scupjK6hu+/+y8jDyECz6dpTQT5eglVuuxboYmnTbpeNV8NktKgN9K?=
 =?us-ascii?Q?blpp8qXCIkWFncqmEVgbtx/CG9XsLK4JF2jc3iaW4QsMuR2HyMkKdy1gwG6p?=
 =?us-ascii?Q?leqA6Lx4FIclilKVb6mcqB/OpsVIUz9vdiW35aKECjyfLhpnmufVNV6+AFWu?=
 =?us-ascii?Q?zLe8h5bfZBPAMgDAjF1iBvfm7isRJXbPf5txlPCQPDy1WruHrgpzNvMVhLN2?=
 =?us-ascii?Q?07jqRjgy2DL3Q4G4LVuLbg/UM47bjUhjKDllGuB2Lg/ig9GSinIHtslS75YL?=
 =?us-ascii?Q?RMUWUZcdAJQKm/NRVlcFQjQcGL2lDbuLIpcoe7um11pO7yVxog6Y94xn1ngY?=
 =?us-ascii?Q?hdfJ4tj8/T3vH+sdj5z3JEGAtUE2wHHm/kuLqpB8imNMeFE4pBXwZMCr4q9H?=
 =?us-ascii?Q?Q8p69eVOdzy5cP33GJeiQU5KMsmHrOCrzJGiVofX1d/Fl6ds+UBZqlHxm3SD?=
 =?us-ascii?Q?oyR2USqCs6qWkaHvWbGhwvAmHFjUXgA9XyaNfJBDHfAf/rUrgOSa9i8uT+mH?=
 =?us-ascii?Q?dQaDQF8x2/dlHH5eFSeUcQ2oloNbKHBKLBD99RGSKekJFIhOWMzyMcmm0u/p?=
 =?us-ascii?Q?hG2uQtaainPiRPZKPYuGu/NcnbTPJYpi51Um57+6dN/pLuLJiQJC5NWvp0hx?=
 =?us-ascii?Q?y/bScGtMvarRijneUBZ7pxBqFGxvCk7AVaCxqA6l+I6dYEv3Pr/gPb18YVhE?=
 =?us-ascii?Q?rRxH/io8ILOg5TWnzovZTDzndr2Nc48S1wp8eM+K6mBXVql6jBJ/HajPa9ZB?=
 =?us-ascii?Q?RAMaJ/rAlsyLs/p9OVpBR5RZN/lrUR1x0IVwWSNOZvHE5bnBlpPrIEUXX/B9?=
 =?us-ascii?Q?RhtIbQi7bgGnHH6GvYHmUsvX4ioiBp7GgkA440Z9/p6V6rfVBdFbZbPaYK5o?=
 =?us-ascii?Q?+B4u4lNNEF7HegfzUqp4Tqx5OEz4pjgr6Q/x3KMtS4krMOpEkNz+Sr+wof+d?=
 =?us-ascii?Q?8OQkTxYyJKn9yjwzBxqbuTO2yXoqigM2tLY0pAiSmEQtnMaMhu1bd1NDeUMq?=
 =?us-ascii?Q?7r02f3AoNj2BLPzkENmP39wyVrcP7/o6c7F8uBL6KwBeHthtbP7EkNYN6AlO?=
 =?us-ascii?Q?y0DET0B8LNKVNRJCv4AnyPnkD+HTHcXTq3DeZIiff4O+g0OPKxiXGbX+M2VT?=
 =?us-ascii?Q?eDl4gAIwVPg4Odk0eiz+fuyVf/nLKIB2uN2JDloaKbl8NhaOfaZI/yILTtUL?=
 =?us-ascii?Q?N7ImrPdRVX1Ag8tPo3+dWfx6twfbaAY8X6BD3nH3/ZUMtZF+YSMKBg+kbGJ1?=
 =?us-ascii?Q?kv5AckF7EJi9R0+l4vuhlfTyQtpOMZS4QZl8SUb/VcaYGLXFne0sQhDDX47i?=
 =?us-ascii?Q?/QiTr1RMYsBicWf8G8XiWfnVLD+Zf+TMwz7VsZd2OlePtsdlNJ03ntjvAMOY?=
 =?us-ascii?Q?r1hPZQkdRUdGeRdD7iP6p1S3Vd2DySOxkHJqGzEuqMicQwBH9wacw9h3gAgD?=
 =?us-ascii?Q?oRDC61dDoA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WL1oI1wAd1Slpp4gk/58/Oq0HajgR9/n7w5qeae13mYMUDOFh2ZhYMlEDFifrh72jDSHdBaLMN9T5VoTfIGYlnGzIRaWWtfHEY/PHWa8dY6sVmOUmPsrsA2Zt5fW9kPhpIi4wTPXpE3S/kYZ34b7rMzVhJs/FGtkHgAGNzsJvmhQHSmjiNDGWV6UHr95zfv0Gmx1pVSKr1bYKFATNOq0bGQQGusFA9QKVFfyUcGSrDvUIA9t1frUYPzpW3DvYGwMtWG9C4XSbRKECxDl/JZ78kwgvLx6qnpHhw5a1WhM3Bs76vuxHKBivDXQgPXUH1Cqypr0fm09Ixj/DruVZ0jFKg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20065f51-8953-42bf-748b-08df49310c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 07:11:51.9148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fK8G8dx8jqujICciXhl0F1EzS2Zx/sQdgd8D6e6hrhVpu6pBKQPNMmXVB4p4OdsIh36JDEOFiX/uKAxMqUiKxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6975
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Nitka, Grzegorz <grzegorz.nitka@intel.com>=20
> Sent: 26 September 2026 03:58
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; richardcochran@=
gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw <przemyslaw.kitszel@i=
ntel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kubalewski, Arka=
diusz <arkadiusz.kubalewski@intel.com>; davem@davemloft.net; edumazet@googl=
e.com; Machnikowski, Maciej <maciej.machnikowski@intel.com>; Nitka, Grzegor=
z <grzegorz.nitka@intel.com>; Neustadter, Marc <marc.neustadter@intel.com>;=
 Temerkhanov, Sergey <sergey.temerkhanov@intel.com>; Olech, Milena <milena.=
olech@intel.com>
> Subject: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start wit=
h PTP lock and incval
>
> From: Maciek Machnikowski <maciej.machnikowski@intel.com>
>
> ice_start_phy_timer_eth56g() programmed the PHY increment value and perfo=
rmed the PHY-to-PHC phase synchronization in two separate PTP semaphore cri=
tical sections, and touched the shared source command register (GLTSYN_CMD =
via ice_ptp_src_cmd()) and read the source incval before acquiring the sema=
phore at all.
>
> Because GLTSYN_CMD is a single global register latched for the source tim=
er and all PHY ports by GLTSYN_CMD_SYNC, a concurrent adjtime (small offset=
, <=3D S32_MAX) or adjfine could clobber the source command between the inc=
val-init and the phase-sync steps. In the worst case the source timer comma=
nd written by ice_ptp_adj_clock() (ICE_PTP_ADJ_TIME) was overwritten by the=
 unlocked ICE_PTP_NOP from ice_start_phy_timer_eth56g(), so the adjustment =
was applied to the PHY ports but not to the PHC. This left the E825 PHY clo=
ck permanently offset from the PHC, showing up as an intermittent clock dri=
ft.
>
> Hold the PTP semaphore across the entire start sequence: acquire it befor=
e the first shared-register access (ice_ptp_src_cmd()), keep it held throug=
h the incval read, PHY incval init, and the phase synchronization, then rel=
ease it once. Since the hardware semaphore is not recursive, split the phas=
e-sync helper into ice_sync_phy_timer_eth56g_unlocked(), which assumes the =
caller already holds the lock, and call it directly from ice_start_phy_time=
r_eth56g(). The locking wrapper is removed as it no longer has any callers.
>
> Fixes: 781ff8f2d575 ("ice: ptp: serialize E825 PHY timer start with PTP l=
ock")
> Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Suggested-by: Marc Neustadter <marc.neustadter@intel.com>
> Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 48 +++++++++------------
> 1 file changed, 21 insertions(+), 27 deletions(-)

Tested-by: Singh, Ayush1X < ayush1x.singh@intel.com > (A Contingent worker =
at Intel)
