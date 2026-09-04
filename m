Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EA8C61DD6
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D454E40B20;
	Fri,  4 Sep 2026 13:50:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cpOwMrDVmuBh; Fri,  4 Sep 2026 13:49:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AA75F40B38
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788529799;
	b=UejSn6T6P3WwWT3gub5QW61hgGUG6twj614BDr+slAFay66W+pQPs1Z44+f1McZaFiXH
	 ByOwZDPH4etBPVss2UK4sZemnUcmmJn6kkPIw0oxqLZR6voEYXw0aMjaGpKlY6+LfPcHz
	 9d8Mt9GkLp/pli4MMG2IehBBve4nFEcnYoSHI6Ug2Gk2Cn0yZXTxbMZ3Y5R+O4+AiRl/N
	 CaQ+01GQ2fnELZVjeytYV0G8Jq8ZAuZxILCq3CTGvPPaHysPRWE0WQ2O6hM8kHRXSUwQI
	 tjuoyZrk1vgXp7HPtMwZ2GQ6r0mH8xKmyntbSAimIvpwtdpcWubtu7M4g6GfrEFRZZg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788529799;
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
	bh=y+jBpI32HCBBzXEaDgz+3U1FDDkQbk9K72g1y8JJce8=;
	b=BPF5bid/mRiuQYDY26VhsO59YvugYOzGYKMWmT+iJINVuE/IfR1lo5AkrKKkXpw883yO
	 CwvKr2UVkFCK7LFGCNXQZ0oKJKVl4eKezvXQzAkrOhv5W5fbqNRP0aEu42zCGms4YIxhk
	 MuxEQLmop41zMha53jYgzeD5UhjwHX2XcjLuPvPfzqUzGqtIO7NkMCxhhwKvsyArelp62
	 yAblia53ikX8DhDRpkhUp9hrRKWHwpBIYPalPVqimYs0Z2fQk+mWTr50NRhIZYelfXoVT
	 qWZhQ8U+2pGtjm3XRNCXW0xM05tBxAyVcf9a8fQVTngzSISBQyUiHBpxgc55++ZQR3Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mpjsAFI6;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788529799;
	bh=y+jBpI32HCBBzXEaDgz+3U1FDDkQbk9K72g1y8JJce8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c16Z1PwqV8dfiUVqmmpZQPBnhNHK7QI9SwfWDoahCUYnE4B4ckowDTL6K3LMuBfUm
	 Yn9dhhW/JW+3AesTHb5WG/ZmFdJjoELv7kKV4U3zDsCvymVc9416T1LBPKZaymePdC
	 xUajPGMRfzXuG/5B5pWHbIiUBBQ0QxNbofrAwoCxBbkVoOhMDPIj+10vbfANIDoVEJ
	 EMzDo4rfAfOgkMcqCeYf6prgOBHa8YL/bFM27Xl4F/xdVAkTgFZ0YzNuzxDdyeorSJ
	 u4CXLidjob0sFPMAuCgeFW4V1sgpDBXMNC7yYkZnrIRFVMfj+3YIdbFFYCNBpU45O4
	 4vvL0DAAvUkWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA75F40B38;
	Fri,  4 Sep 2026 13:49:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F16BC77F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 13:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2B3F40B38
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 13:49:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PFxSet7v5oS6 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 13:49:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A007A40B20
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788529797;
 b=m2fP9nLv0jbvLQcmZSeTrT6CfL8d5XXC7LKTSKu9ciQkf+MPIKG40EilqmKL5e9pSYTd
 vBsRPp65EK6wKJpM+fez6F7gMWJTBmCzB9cIcCBAHH2fy7yQkK8m0yC0+7DMutAujLCn2
 /IDQzfulijKWYJfocFgpz7U67/hHyGOOjeEiCf2vlHGvkYDkNdwxBJBtKONklLSAKOpn5
 gJQjqysPYKBTlAQhfb6tTy1Grs2gjMeTKAycRNjTfLHg3swy4gZYpuOCxBGoLL4aqLzqF
 LpUMPERLPrsY3zsbcAXgc10BS+MZm/1OfpicH5MNlwhRX0/rMb7sc2PojztS5nk38uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788529797;
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
 bh=y+jBpI32HCBBzXEaDgz+3U1FDDkQbk9K72g1y8JJce8=;
 b=hTNkOsXTAq0s5+O1BnKybCmX91BFQdfcGwyaqr7G2vkaAmiZHQrVCpPpJEWe/HCkcQV5
 Ch6zFAYgAe9XrZ32rv0dibyRqCYGHvDkpFQg7y6QGgO4qu+NYHtoo92fDHDoN6M1OIHMN
 bz4Sml6arT4MNnbyAF+AIBMm84Lsi7n9z1p7zqZCSZHxEnSydXHvH03idB/swIRPROKMb
 WvvJZ2da5j+7aJhdyqQ+d0xqV/8HBHPx9V5E4gIVINodfNvNxB3EvuNW7OhgchNbweIUJ
 ckA5YpQwA2hE5LpLkej/k9mY2wHWk9ZipXGODojJ1Zmz15d2Xt0Cx/Vi7lv+IiNQbZA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mpjsAFI6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=patryk.holda@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mpjsAFI6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A007A40B20
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788529798; x=1820065798;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=y+jBpI32HCBBzXEaDgz+3U1FDDkQbk9K72g1y8JJce8=;
 b=mpjsAFI6Ja1gDAWLal4fKGXpzcHAIp5LVrPNYw5nGvq5F29F8pz9ycy5
 R6DH5hQsHt87zkeircEzxdPD7qpnx+zfpxv2ApHYYjllevumt/jDabtYe
 UIF/y60i2ehR7kezZUJwny5jU6JjeRH6EE3vQLU9C/qPVBsJd3nlCOBiJ
 gcF8pnE2lRCGePnXV8UqtMAY6qwOL0uRKtfv5in5ug0R/ushTJcIy1tm4
 ZaJ1gwMHmvS3uIwyKXsAgkGx55AXa5x+m9kEIky1l/tvps7MBaFa4q+A0
 0nwn73TwjJdKgEKUPNgMAjpyC1bVh93bKw4tE1uwaCa9TKdB0h8DD9pFs w==;
X-CSE-ConnectionGUID: /UspibEYQoGVGhaVnjGDfQ==
X-CSE-MsgGUID: bHihnfjhRfacWgNu0cG9OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="99362145"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="99362145"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 06:49:56 -0700
X-CSE-ConnectionGUID: Ah1yE3RSQUCQUlYwORTsGw==
X-CSE-MsgGUID: MVeXD55uSNO4Duk+7NfWMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="265698628"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 06:49:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 06:49:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 06:49:51 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 06:49:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nj7a1CSy0SMfZD2bZXeXALEGDj9vwZ7SK4LhCTjOznBse8OWdti9RFoEBUPc/B5H5Ob6mHtI9J7QSIbYYlL7MFcFVkMkEagVSsawVO/kZU2hs9kZxZLifQZKVQ0ihyGelRmASYJFcgI/eh0rMPJ9bH2WnTs4dc45HG22zjMPaNaQPku9M+0ueSRWiEK+D3tT214h97onZMxu4vrsnhHqCrNf5tYKVNRqVwMbAmM5bdQNFp+W7ObrpCO0EAJt4NTQbuXJgbXLr6e9Crb80KRyEufJia7Boz+K4hlfA09BOQ465CtjzL9x8Fq0elsbhaoI/YmVA81Z8UMaMlNvdfe2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+jBpI32HCBBzXEaDgz+3U1FDDkQbk9K72g1y8JJce8=;
 b=v1ci4nuHyMuMIy8BGd4Kt41iYTzJ/mlJ+6x0N6AEsNnSlqLfdccdNLmp2lNbRYwPgq47c2fzBco6zapxop2koo46/kQmAmizyAnDxx7DSLhvr86P64gVHJCUHP8HPS3VUs2KzmwRCUoWdzEKpIVMFPE+eCvh424K2AAyNXUmWmDcDonMwZiLcXXB3Okm5z1L/uZfagMDdWMY6T87Da/nDNF1PmySAqJWcPdaYiVqLhXqX+O7mdLZrM612eXT7sKX1iZJr4USxYxGGf0WohYMGk+4yRuEkqof08NpwpVZzg68HYYLLv9i+zUvH/MR8Eh6SU0RTL3ESgloeyE69vvJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH1PPF79470873B.namprd11.prod.outlook.com
 (2603:10b6:61f:fc00::547) by SJ5PPFD56E32CC2.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::859) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 13:49:49 +0000
Received: from CH1PPF79470873B.namprd11.prod.outlook.com
 ([fe80::b284:e3f8:7534:c6bd]) by CH1PPF79470873B.namprd11.prod.outlook.com
 ([fe80::b284:e3f8:7534:c6bd%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 13:49:48 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 YiFei Zhu <zhuyifei@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2] idpf: add flow-based XDP fallback for FWs
 without Tx FIFO support
Thread-Topic: [PATCH iwl-next v2] idpf: add flow-based XDP fallback for FWs
 without Tx FIFO support
Thread-Index: AQHdNJBdhl8QtXYeXUuOQpN3NAxibba+f03w
Date: Fri, 4 Sep 2026 13:49:48 +0000
Message-ID: <CH1PPF79470873B5A7A4CB1532104A56E718AB52@CH1PPF79470873B.namprd11.prod.outlook.com>
References: <20260818155101.2416665-1-aleksander.lobakin@intel.com>
 <ea7bd312-a9b7-402c-bded-42a34b63b167@intel.com>
In-Reply-To: <ea7bd312-a9b7-402c-bded-42a34b63b167@intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH1PPF79470873B:EE_|SJ5PPFD56E32CC2:EE_
x-ms-office365-filtering-correlation-id: cf15b16f-035e-464f-dc7b-08df0a8b6316
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|38070700021|6133799003|5023799004|10067099003|22082099003|4143699003|11063799006|56012099006|18002099003;
x-microsoft-antispam-message-info: i95NZCIBtM1+ZxNmrmyc6cb83cU5Y5TriHYrNrMbLKgcb7IBk0wVY1z4NoRazNTDJrs7OCfUmugSZvQjq+e1mm0wQYLYAKSydTmSMMzB1XRoDIDMrCt2NNbb6vOki4gUAMGbJWpuD6kDwO8miyR2UfuMU8qW6wyYy2Pau8pV17EMikytIVsQ+F/OpCpyfnYLTHxpbCw9cRFfS463yiJx/d1fFyhslHg9SOZ9KvcAXacnDia67GAYJQTPgZEclb/94Ja0saAZYw2cqzyGkgqxNBD/mfRdJDmrm0Hoct+bqKtdYSw5HxpZKHVK1KgGFLOLzOt1NsdNVtFOyOY7cIpE7LS0xCvQEzg3w7pCai3AV0Akce3g0SrW4N/oi0/ki+kWivVlPRz+cb7OP48OX8/azpO4DMnDrA9sGJKEaKzcnehydUf82zvPkMgp0Lzhz/Zh7BXxo6PL5yvIQ7SSnmsIlKt8d190eQb/gHbnyBduyS4jYfoQFBlS+J3tvV7a6mEeJcPdo0W/75EtDnn2PsV5s8b/BC0n7FRHwrE9woPE+4TXp4TCKYtiwq95D6Q+UiB9KXEyU/SgVo1bC5FVKzIYQ9XYvj4SEamUb7E/RR1EfXFRARLDbegh1ll02+O0K3NAN6wjWnis9B7eUQtzdWEauuyvqsGC3VxQnafailNduG1RQ3GensU5A40/LzU1BKXaUCqZqnR8zFJ8c48T9szzh0OtwOrl9dCNoldmY7DboKo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH1PPF79470873B.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(38070700021)(6133799003)(5023799004)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M29udWJmb3dhdHk1S2l1Y2lZVjZnNXY3M0taNm1KNk9qQ0dNUWNDcmV4MWVM?=
 =?utf-8?B?bkZ3WkZxY0hjakc1amFZaE9RNzVHNytmM0Y0OExxUEYrMSswdTcxMmRNaGF0?=
 =?utf-8?B?cW1ySXNCQU9iSFpiU1RnOXBaQTlFV3FCR1lTTTJPR3U0N1I0ZWludjU2cU9Z?=
 =?utf-8?B?c0VXY1dCSVNET2N4TkZSMVYwM2NWSmw1dHdNZXRmYnpJd3dSdFFqTVhuVTB3?=
 =?utf-8?B?NDB1WVdPU0xWWkVKVUczcExVR2xabDQzZjF1TWVydUxzWjNydkdqOWoxNFRu?=
 =?utf-8?B?WUorczE1Z0s4S1RJK0ZpWGpJQ1BmKzF0NzhiWFA5VlZTd05aN01YNmhkVFVl?=
 =?utf-8?B?MGc1L3lreEtIT2FCcU9PVlJXUEkySkhUWXZBRHZxaXpJQVRQN0dsYkVTMjJ1?=
 =?utf-8?B?RVFSUlpvRHU1LzhYQ1dqaTlOL2xhTmhhcTkvZytLTnFkV3BYRHVIKzkxb3l5?=
 =?utf-8?B?SndscURaT2JidVlEeml1MU5JQmlyZENxcWVWMVYxbmJLUmlnMDREOFAwTWRV?=
 =?utf-8?B?YUpuTG81Z1ZFNlV5N1pCNElwVlJMMTcwYzl3b1AxeDFxencxZzBwUVZDWWZo?=
 =?utf-8?B?TVFSR1ZBaEFiUHNzQmJVV1JiL0Q4b2JiQlk5aVdZd0ZMUyt0TjgrMEFPdUhC?=
 =?utf-8?B?U1hQTGtZVlVrY2x4ZG1BdXBVSGg3RDRXQ1FobXhYbDl4R29yRnl6Zk1JUlVB?=
 =?utf-8?B?SjAvRXRHUktEVURXQzZNSEl0eVlKbzFjWHJWbkNTb3RjR2lveXZCSGhlZWp5?=
 =?utf-8?B?UlcxUEViUGdudTUvRGFVV0ZnTktuRE9pWVFZeHZoemgxYmtiKzRUSWU0Qnli?=
 =?utf-8?B?MkdOQ3FqaEZsZXhESW9iemhZTjQ2cFBQb2R0SFVQcjZNQVUyelJZZ0RyN3dP?=
 =?utf-8?B?eWZySjRvRXN2WG1INEJrZm1ndzQ3UzQxemtONldKdEZxTzlCOXJnM1c3bG43?=
 =?utf-8?B?eWszL3FPVnRYZnpOYmx5MmdNcnRKNDVBcWtuZ21JNit2SEs3UUtGa0hzN1Nq?=
 =?utf-8?B?V2dKYStjZWZaMUR6a20yb0ZHRmJ3Mm9odlVqUGhZQTRXTTNBcm1GVW04THlZ?=
 =?utf-8?B?REgyOFFYZi9mQnFaVi9aWld3bkdzQlZpSksvWkdSbjlnRkkrZ0FNTnhBaTB2?=
 =?utf-8?B?cnd6TUZVM0ppSDNCbGhTWXgzTTlJdnZVTFA3NlRVTERQaGE3RCtmYnBZdXVu?=
 =?utf-8?B?Y1ArZnNPOVpaMCtTNE5qTEE2RGhKNDRlTDdDMWphNWRIQW5sMkZmdmhXTFlG?=
 =?utf-8?B?QVNqNlpkN293U1gwaGhNaWI3Wk1ONm5sMnZDZnZNMlhYWUN6NExOZ01rK2FH?=
 =?utf-8?B?LzlaTnZocmlnbklUVkRYQzNBQVJNYVRycHdOeExTa3V1bkFjN0gxVmpIZUZW?=
 =?utf-8?B?dXBmLzZtNnZZcmY3bENpL3lWOXZXMkpDU2xmcHI5Q3VId2cvanI0YXdLdlVt?=
 =?utf-8?B?bFNjOEdOVWkvak5PYWJ5VUZEb0JOYk9aQmorRkNyVmRUQkZDcVA2S0FZenhR?=
 =?utf-8?B?YzcxRFVLNVVtWmsvUE1UY3JFaVB2bUMxOHoweVNRM2VNSWs3amY3WlJXVFR3?=
 =?utf-8?B?eHMzQUVtVlYreGk2UDVieHVUMXBWZ2xWMEhHV2Jmcysza3ppM3hDd1UwOGpN?=
 =?utf-8?B?d1l4MWE1Y1NsM2NKSkwvUE01Z3FSdE5CbDQxcVQ0Sytwak9ZdlgrbkVIR0FR?=
 =?utf-8?B?alMvZjZ3bjRaOWxDY1pVTkplWStrL0xHK2FHM1Nhc2I3Y2d6RDJJZXJiZWpF?=
 =?utf-8?B?NHlQNyt6OFdpNmlDYURtRTB2bFMzcE9sVDI1VVZaajlzc0pYbmlpQmNFMXlv?=
 =?utf-8?B?SDJ3Mk81QUpSaHQrUEVOMWtzL3l3M29QWXE5b1I2czNZbG9Bc1RNc1pSTlhv?=
 =?utf-8?B?bXRMY2hZQU9Ra1hVdTJ5NzZaTjBheUg2TXEyZ0UyenNsNEc5eDBNa1ZZT001?=
 =?utf-8?B?aXZxelo0MDhKanB1MTJwNlZkeVlRN3d6Z0dPNFdOVzVFTXA5aHhpOXdpYzZS?=
 =?utf-8?B?bDZZWnpXVmtZUVdGZW1uckt0SFFtM09BSlo4OTBxRnd1c2JQckMrQWw0WWVw?=
 =?utf-8?B?UFdhL1o4UnV0aDVJWGhkY3Z4elZUNUQ2azJueDExNklJR3h0L25hZnZaVDlF?=
 =?utf-8?B?OHcweEkvRHV1dStSaHhkL0xwN2dlTmZxQVFQMjRUYXNVNU5mM2gyWjVYK3dV?=
 =?utf-8?B?TVFkOGhKUko1ZlQwMDRERG5BNkgyOTVmUEZkMnMwOGVDaitlaEpQL0xTL0Iw?=
 =?utf-8?B?UFRCNldhMGFYbTEzR1c4bDc2MVRvNk9DQmVJcG41c1g4SWk0MitLWVNtNVBQ?=
 =?utf-8?B?ZDNnTjVGMTZLOUYyRDE1M2VuazR2TTJRSGFKcUVqVERYa1VQVEFsZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dBd0HnuqKoYxXzYld1Jm8OS/o9THix/HguoIDd35vbGLpZNvt2o1FbWxn2E+chMImNSehhWmz+4g643vr+MVUxvBh+hJ3wxyIPRNj/1XkA6xXD2srH9WlO4yu1YuFwMXt7Hw5ArKfR54H0ubT82wn7C0CDqf0W7hI5aG5Bb87PvjnqAFQmOdPrBfDUZg64pJaqH5Icr56eUq2TOKuzSaeUBMOt9fLCzexuTabT2T9HiMGUhF48d1uFomXbzgZiiSyAgipYUFkVuA1G3KhK5vJv8PCKJJSR+QElEMFUh5ny1OoeopmxOGsT4oxgBuIYCXl5Jhifpflvnpcv6o8zk9+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH1PPF79470873B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf15b16f-035e-464f-dc7b-08df0a8b6316
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 13:49:48.8840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8m1hdGOXj44bdzx9lpxFnPdPkoVDYpzRCTaqXgdumvq+J7lPKJy/t5IdP/QgLlcxfOd5Fp22KXPiT/lOlH2YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD56E32CC2
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgTG9iYWtpbiA8
YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDI1
LCAyMDI2IDI6NDUgUE0NCj4gVG86IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+
IENjOiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRz
emVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgQW5kcmV3
IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47DQo+IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEph
a3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJl
ZGhhdC5jb20+OyBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+OyBMb2t0aW9ub3YsDQo+
IEFsZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+OyBZaUZlaSBaaHUNCj4g
PHpodXlpZmVpQGdvb2dsZS5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGl3bC1uZXh0IHYy
XSBpZHBmOiBhZGQgZmxvdy1iYXNlZCBYRFAgZmFsbGJhY2sgZm9yIEZXcw0KPiB3aXRob3V0IFR4
IEZJRk8gc3VwcG9ydA0KPiANCj4gRnJvbTogQWxleGFuZGVyIExvYmFraW4gPGFsZWtzYW5kZXIu
bG9iYWtpbkBpbnRlbC5jb20+DQo+IERhdGU6IFR1ZSwgMTggQXVnIDIwMjYgMTc6NTE6MDEgKzAy
MDANCj4gDQo+ID4gRnJvbSB0aGUgZmlyc3QgZGF5cyBvZiBYRFAgaW1wbGVtZW50YXRpb24gaW4g
aWRwZiwgaXQgcmVsaWVkIGFuZA0KPiA+IHdvcmtlZCBzb2xlbHkgb24gdG9wIG9mIHRoZSBxdWV1
ZS1iYXNlZCBzY2hlZHVsaW5nIFR4IG1vZGUsIHdoaWNoDQo+ID4gYmFzaWNhbGx5IG1lYW5zIHNp
bXBsZSBGSUZPLiBIb3dldmVyLCB0dXJuZWQgb3V0IG5vdCBldmVyeSBmaXJtd2FyZQ0KPiA+IHN1
cHBvcnRzIHRoaXMgbW9kZSBhbmQgWERQIGRvZXNuJ3Qgd29yayB0aGVyZSBhdCBhbGwuDQo+ID4N
Cj4gPiBTaW5jZSB0aGUgZmxvdy1iYXNlZCBzY2hlZHVsaW5nIFR4IG1vZGUgaXMgbWFuZGF0b3J5
IGFuZCBzdXBwb3J0ZWQgYnkNCj4gPiBldmVyeSBGVywgaW50cm9kdWNlIGEgc2ltcGxlIGZhbGxi
YWNrIGd1YXJkZWQgYnkgYSBzdGF0aWMga2V5IHRvIG5vdA0KPiA+IGh1cnQgdGhlIG1vcmUgcGVy
Zm9ybWFudCBtb2RlLiBUaGUgRkIgbW9kZSBnZW5lcmF0ZXMgYSBjb21wbGV0aW9uIGZvcg0KPiA+
IGVhY2ggVHggZGVzY3JpcHRvciBhbmQgbmV2ZXIgZ3VhcmFudGVlcyB0aGF0IHRoZXJlIHdvbid0
IGJlIGFueQ0KPiA+IG91dC1vZi1vcmRlciBjb21wbGV0aW9ucy4gU2VyaWFsaXplIHRoYXQgdXNp
bmcgYSBiaXRtYXAgb2YgY29tcGxldGVkDQo+ID4gZGVzY3JpcHRvcnMgYW5kIHJlcG9ydCBjb250
aWd1b3VzIGJsb2NrcyBvZiBmcmVlIGJpdHMgdG8gbWF0Y2ggWERQIGFuZA0KPiA+IFhTayBleHBl
Y3RhdGlvbnMgYW5kIGF2b2lkIGZ1cnRoZXIgY29kZSBjb21wbGljYXRpb24uDQo+ID4NCj4gPiBU
aGUgdXNhZ2Ugb2YgYSBiaXRtYXAgb24gaG90cGF0aCBtaWdodCBzb3VuZCBzY2FyeSwgYnV0IHRo
aXMgZmFsbGJhY2sNCj4gPiBpcyBhYmxlIHRvIHJlYWNoIGFyb3VuZCA3MCUgb2YgdGhlIFFCIG1v
ZGUncyBwZXJmb3JtYW5jZSwgd2hpY2ggaXMNCj4gPiBjb21wYXJhYmxlIHRvIHdoYXQgaWNlIGdp
dmVzIHVzLiBUaGUgbWFpbiBib3R0bGVuZWNrcyBhcmUgdW5saWtlbHkoKXMNCj4gPiBhbmQgb25l
IGNvbXBsZXRpb24gcGVyIGVhY2ggZGVzY3JpcHRvciwgd2hpbGUgaW4gdGhlIFFCIG1vZGUgd2Ug
aGF2ZQ0KPiA+IG9uZSBjb21wbGV0aW9uIHBlciBiYXRjaCAod2hpY2ggbWlnaHQgY29udGFpbiA2
NCBvciBldmVuIDEyOCBmcmFtZXMpLA0KPiA+IHBsdXMgdGhlIHNpemUgb2YgdGhlIGNvbXBsZXRp
b24gZGVzY3JpcHRvciBpcw0KPiA+IDggYnl0ZXMgaW4gdGhpcyBtb2RlICg0IGJ5dGVzIGluIHRo
ZSBRQiBtb2RlKSwgd2hpY2ggbWVhbnMgYSBsb3Qgb2YNCj4gPiBhZGRpdGlvbmFsIFBDSSB0cmFm
ZmljLg0KPiA+DQo+ID4gYmxvYXQtby1tZXRlciBzaG93cyAudGV4dCBpbmNyZWFzZSBpbiBhYm91
dCAyIEtiIHdpdGhvdXQgYWRkaW5nIG5ldw0KPiA+IGZ1bmN0aW9ucyBvciB1bmlubGluaW5nIGFu
eSBvZiB0aGUgZXhpc3Rpbmcgb25lcy4gSSBwbGF5ZWQgYSBidW5jaA0KPiA+IHdpdGggaW5saW5p
bmcgYW5kIHVuaW5saW5pbmcgY2VydGFpbiBwaWVjZXMgb3IgdGhlIHdob2xlIGZhbGxiYWNrLCBi
dXQNCj4gPiB0aGUgY29tcGlsZXIgY29sbGFwc2VzIGFuZCBvcHRpbWl6ZXMgbGliZXRoIHRlbXBs
YXRlcyBzbyBoYXJkbHkgc28NCj4gPiB0aGF0IGVhY2ggYWRkaXRpb25hbCBleHRlcm5hbCBjYWxs
IG9ubHkgbWFrZXMgdGhpbmdzIHdvcnNlLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEFsZWtzYW5k
ciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiA+IFRlc3RlZC1i
eTogWWlGZWkgWmh1IDx6aHV5aWZlaUBnb29nbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRlciBMb2Jha2luIDxhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tPg0KPiANCj4gQ29t
bWVudHMgZnJvbSBTYXNoaWtvOg0KPiANCj4gPiAtLS0NCj4gPiBJIGtub3cgdGhlIHdpbmRvdyBp
cyBjbG9zZWQsIHRoaXMgaXMgdG8gdHJpZ2dlciB0aGUgdmFsaWRhdGlvbiBhbmQgZm9yDQo+ID4g
ZXZlbnR1YWwgcmV2aWV3cy4NCj4gPg0KPiA+IEZyb20gdjFbMF06DQo+ID4gKiByZXdvcmsgc3Rh
dGljIGtleSBtYW5hZ2VtZW50OiBtb3ZlIHRvIGlkcGZfeGRwc3FzX3tnZXQscHV0fSgpIHRvDQo+
ID4gICBhdm9pZCByZWZjb3VudCBpbWJhbGFuY2UgaXNzdWVzIGFzIC5uZG9fYnBmKCkgaXMgbm90
IGFsd2F5cyBjYWxsZWQNCj4gPiAgIGluIHBhaXJzIChoYXJkd2FyZSByZXNldCBldGMuKSAoU2Fz
aGlrbywgaW50ZXJuYWwgU2FzaGlrbyk7DQo+ID4gKiBkb24ndCB6ZXJvIHRoZSB3aG9sZSBwZW5k
aW5nIHdpbmRvdyBidXQgb25seSB0aGUgZnJhbWVzIHNlbnQgc2luY2UNCj4gPiAgIHRoZSBsYXN0
IGJhdGNoIHRvIGF2b2lkIG1pc3NlZCBPT08gY29tcGxldGlvbnMgKGludGVybmFsIFNhc2hpa28p
Ow0KPiA+ICogbWljcm8tb3B0aW1pemUgaWRwZl94ZHBzcV9zZXRfcnN7LF9mYn0oKS4NCj4gPg0K
PiA+IFJlZ2FyZGluZyB0aGUgcmVzdCBvZiBjb21tZW50czoNCj4gPg0KPiA+PiBDb3VsZCB0aGlz
IHNlbnRpbmVsIGJpdCBjYXVzZSBhIGRlYWRsb2NrIGlmIHRoZSBxdWV1ZSBpcyBjb21wbGV0ZWx5
IGZ1bGw/DQo+ID4+IFdoZW4gZnVsbCwgbmV4dF90b191c2UgZXF1YWxzIG5leHRfdG9fY2xlYW4u
IElmIHRoZSBoYXJkd2FyZSBqdXN0DQo+ID4+IGNvbXBsZXRlZCB0aGUgb2xkZXN0IGRlc2NyaXB0
b3IsIGl0cyBiaXQgd291bGQgYmUgY2xlYXJlZCwgYnV0IHRoaXMNCj4gPj4gX19zZXRfYml0IHdv
dWxkIGJsaW5kbHkgb3ZlcndyaXRlIGl0IGJhY2sgdG8gMS4gVGhlIGNvbXBsZXRpb24gd291bGQN
Cj4gPj4gYmUgaWdub3JlZCBhbmQgdGhlIHF1ZXVlIG1pZ2h0IHBlcm1hbmVudGx5IHN0YWxsLg0K
PiA+DQo+ID4gSW50ZWwgSFcgd29ya3MgdGhhdCB3YXkgdGhhdCB3ZSBjYW4ndCBmaWxsIHRoZSBy
aW5nIGNvbXBsZXRlbHkuIFdlDQo+ID4gbmVlZCB0byBhbHdheXMgbGVhdmUgYXQgbGVhc3Qgb25l
IGRlc2NyaXB0b3IgZnJlZSwgb3RoZXJ3aXNlIG50YyB3aWxsDQo+ID4gZXF1YWwgbnR1IGluIHRo
ZSBIVyBhbmQgdGhlIHF1ZXVlIHdpbGwgc3RhbGwuIFNvIGluIGFsbCBzZW5kaW5nDQo+ID4gcm91
dGluZXMsIG91ciBidWRnZXQgaXMgbGltaXRlZCB0byBgZnJlZSAtIDFgLCBtZWFuaW5nIHRoZSBz
aXR1YXRpb24NCj4gPiBkZXNjcmliZWQgYWJvdmUgY2FuJ3QgaGFwcGVuIChuZXh0X3RvX3VzZSBu
ZXZlciBoYXMgaXRzIGJpdCBzZXQgdG8gMSwNCj4gPiBzbyBpdCdzIHNhZmUgdG8gdXNlIHRoaXMg
Yml0IGFzIGEgZ3VhcmQgYW5kIHJlc2V0IGl0IGFmdGVyIHRoZSBiaXRtYXAgc2VhcmNoIGlzDQo+
IGNvbXBsZXRlKS4NCj4gPg0KPiA+PiBJcyByZXQgYm91bmRlZCBiZWZvcmUgaXQgaXMgdXNlZCBh
cyBhIGJpdG1hcCBpbmRleCBoZXJlPw0KPiA+PiBpZHBmX3hkcF9wYXJzZV9jcWUoKSByZXR1cm5z
IHVwcGVyXzE2X2JpdHModmFsKSBzdHJhaWdodCBmcm9tIHRoZQ0KPiA+PiBkZXZpY2UgY29tcGxl
dGlvbiBkZXNjcmlwdG9yLCBzbyByZXQgY2FuIGJlIGFueXdoZXJlIGluIFswLCA2NTUzNV0uDQo+
ID4+IHBlbmRpbmdfbWFzayBpcyBhbGxvY2F0ZWQgd2l0aCBiaXRtYXBfemFsbG9jX25vZGUoZGVz
Y19jb3VudCksIHdoZXJlDQo+ID4+IGRlc2NfY291bnQgaXMgYXQgbW9zdCBJRFBGX01BWF9ERVND
Uy4NCj4gPg0KPiA+IE5vIGNhcmRzIHVuZGVyIHRoaXMgZHJpdmVyIGhhdmUgZXZlciBiZWVuIHNl
ZW4gd3JpdGluZyBnYXJiYWdlIGluc3RlYWQNCj4gPiBvZiB0aGUgY29tcGxldGlvbiB0YWcuDQo+
ID4NCj4gPiBbMF0NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9pbnRlbC13aXJlZC1sYW4v
MjAyNjA3MDgxNTEzMjcuMTA5MTU3MC0xLWFsZWtzDQo+ID4gYW5kZXIubG9iYWtpbkBpbnRlbC5j
b20NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmLmgg
ICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl90
eHJ4LmggfCAgMTggKy0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYveGRw
LmggICAgICAgfCAgNzMgKysrKysrKysrKy0NCj4gPiAgaW5jbHVkZS9uZXQvbGliZXRoL3hkcC5o
ICAgICAgICAgICAgICAgICAgICB8ICAxMyArKw0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pZHBmL2lkcGZfdHhyeC5jIHwgIDEyICstDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lkcGYveGRwLmMgICAgICAgfCAxMzEgKysrKysrKysrKysrKysrKysrKy0NCj4gPiAg
NiBmaWxlcyBjaGFuZ2VkLCAyMjkgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+IA0K
PiBbLi4uXQ0KPiANCj4gPiBAQCAtMTk3LDEyICsyMjksMjUgQEAgaW50IGlkcGZfeGRwc3FzX2dl
dChjb25zdCBzdHJ1Y3QgaWRwZl92cG9ydA0KPiAqdnBvcnQpDQo+ID4gIAkJeGRwc3EtPnBlbmRp
bmcgPSAwOw0KPiA+ICAJCXhkcHNxLT54ZHBfdHggPSAwOw0KPiA+ICAJCXhkcHNxLT50aHJlc2gg
PSBsaWJldGhfeGRwX3F1ZXVlX3RocmVzaG9sZCh4ZHBzcS0NCj4gPmRlc2NfY291bnQpOw0KPiA+
ICsNCj4gPiArCQlpZiAoc3RhdGljX2JyYW5jaF91bmxpa2VseSgmaWRwZl94ZHBfZmIpICYmIHZw
b3J0LT54ZHBzcV9mYikNCj4gew0KPiA+ICsJCQl4ZHBzcS0+cGVuZGluZ19tYXNrID0gbWFza3Nb
aSAtIHNxc107DQo+ID4gKwkJCXhkcHNxLT5sYXN0X250dSA9IDA7DQo+ID4gKwkJfQ0KPiA+ICAJ
fQ0KPiA+DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiArDQo+ID4gK2Vycl9tYXNrczoNCj4gPiArCXZw
b3J0LT54ZHBzcV9mYiA9IGZhbHNlOw0KPiA+ICsNCj4gPiArCWZvciAodTMyIGkgPSAwOyBpIDwg
dnBvcnQtPm51bV94ZHBfdHhxOyBpKyspDQo+ID4gKwkJa2ZyZWUodGltZXJzW2ldKTsNCj4gPiAr
DQo+ID4gKwlyZXR1cm4gLUVOT01FTTsNCj4gDQo+ID4gRG9lcyB0aGlzIG1peCBnb3RvLWJhc2Vk
IGNsZWFudXAgd2l0aCBfX2ZyZWUoKSBkZWNsYXJhdGlvbnM/DQo+ID4gVGhlIGtlcm5lbCBjbGVh
bnVwIGd1aWRlbGluZXMgbWVudGlvbiB0aGF0IHRoZSBleHBlY3RhdGlvbiBpcyB0aGF0DQo+ID4g
dXNhZ2Ugb2YgZ290byBhbmQgY2xlYW51cCBoZWxwZXJzIGlzIG5ldmVyIG1peGVkIGluIHRoZSBz
YW1lIGZ1bmN0aW9uLg0KPiA+IENvdWxkIHRoaXMgYmUgY29udmVydGVkIGVudGlyZWx5IHRvIHNj
b3BlLWJhc2VkIGNsZWFudXAgdG8gYXZvaWQNCj4gPiB2aW9sYXRpbmcgdGhlIGNsZWFudXAgc3Vi
c3lzdGVtIHJ1bGVzPw0KPiANCj4gWWVzIGl0IGRvZXMsIEJVVC4gV2hpbGUgeW91IGNhbiB5b3Ug
X19mcmVlKCkgZm9yIHBvaW50ZXJzIG9uIHRoZSBzdGFjaywgeW91DQo+IGNhbid0IHVzZSBpdCBm
b3IgcG9pbnRlcnMgaW4gdGhlIGR5bmFtaWNhbGx5IGFsbG9jYXRlZCBhcnJheS4NCj4gU28gdGhl
IGFycmF5cyB0aGVtc2VsdmVzIGFyZSBjbGVhbmVkIHVwIGF1dG9tYXRpY2FsbHksIHdoaWxlIHRo
ZSBwb2ludGVycw0KPiBpbnNpZGUgdGhlbSBhcmUgZnJlZWQgbWFudWFsbHkuDQo+IA0KPiBUaGUg
c29sZSBhbHRlcm5hdGl2ZSBzb2x1dGlvbiB3b3VsZCBiZSB0byBmcmVlIGV2ZXJ5dGhpbmcgbWFu
dWFsbHksIGJ1dCB0aGlzDQo+IHdvdWxkIGNvbXBsaWNhdGUgYWxyZWFkeSBxdWl0ZSBzbG9wcHkg
Y29kZSBldmVuIG1vcmUuDQo+IA0KPiA+ICB9DQo+ID4NCj4gPiAtdm9pZCBpZHBmX3hkcHNxc19w
dXQoY29uc3Qgc3RydWN0IGlkcGZfdnBvcnQgKnZwb3J0KQ0KPiA+ICt2b2lkIGlkcGZfeGRwc3Fz
X3B1dChzdHJ1Y3QgaWRwZl92cG9ydCAqdnBvcnQpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBuZXRf
ZGV2aWNlICpkZXY7DQo+ID4gIAl1MzIgc3FzOw0KPiANCj4gWy4uLl0NCj4gDQo+ID4gQEAgLTI1
MCw2ICszMDgsNjUgQEAgc3RhdGljIGludCBpZHBmX3hkcF9wYXJzZV9jcWUoY29uc3Qgc3RydWN0
DQo+IGlkcGZfc3BsaXRxXzRiX3R4X2NvbXBsX2Rlc2MgKmRlc2MsDQo+ID4gIAlyZXR1cm4gdXBw
ZXJfMTZfYml0cyh2YWwpOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHUzMiBpZHBmX3hkcHNx
X3BvbGxfZmIoc3RydWN0IGlkcGZfdHhfcXVldWUgKnhkcHNxLCB1MzINCj4gPiArYnVkZ2V0KSB7
DQo+ID4gKwlzdHJ1Y3QgaWRwZl9jb21wbF9xdWV1ZSAqY3EgPSB4ZHBzcS0+Y29tcGxxOw0KPiA+
ICsJdW5zaWduZWQgbG9uZyAqbWFzayA9IHhkcHNxLT5wZW5kaW5nX21hc2s7DQo+ID4gKwl1MzIg
ZG9uZV9mcmFtZXMsIHR4X2NudCwgbmV3X250YzsNCj4gPiArCXUzMiBudGMgPSBjcS0+bmV4dF90
b19jbGVhbjsNCj4gPiArCXUzMiBjbnQgPSBjcS0+ZGVzY19jb3VudDsNCj4gPiArCWJvb2wgZ2Vu
Ow0KPiA+ICsNCj4gPiArCWdlbiA9IGlkcGZfcXVldWVfaGFzKEdFTl9DSEssIGNxKTsNCj4gPiAr
DQo+ID4gKwlmb3IgKGRvbmVfZnJhbWVzID0gMDsgZG9uZV9mcmFtZXMgPCBidWRnZXQ7ICkgew0K
PiA+ICsJCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJCXJldCA9IGlkcGZfeGRwX3BhcnNlX2NxZSgm
Y3EtPmNvbXBbbnRjXS5jb21tb24sIGdlbik7DQo+ID4gKwkJaWYgKHJldCA+PSAwKSB7DQo+ID4g
KwkJCV9fY2xlYXJfYml0KHJldCwgbWFzayk7DQo+IA0KPiA+IElzIGl0IHBvc3NpYmxlIGZvciBh
IGJ1Z2d5IG9yIG1hbGljaW91cyBmaXJtd2FyZSB0byByZXR1cm4gYW4gb3V0LW9mDQo+ID4gYm91
bmRzIGNvbXBsZXRpb24gdGFnIGhlcmU/DQo+ID4gV2hpbGUgaXQgd2FzIG5vdGVkIGluIHRoZSBj
b21taXQgbWVzc2FnZSB0aGF0IGNhcmRzIGhhdmUgbm90IGJlZW4gc2Vlbg0KPiA+IHdyaXRpbmcg
Z2FyYmFnZSwgZmlybXdhcmUgaXMgY29uc2lkZXJlZCBhbiB1bnRydXN0ZWQgc291cmNlIGJ5IGtl
cm5lbA0KPiA+IHNlY3VyaXR5IHN0YW5kYXJkcy4gQ291bGQgYSBsYXJnZSB2YWx1ZSBpbiByZXQg
YnlwYXNzIHRoZSBzaXplIG9mDQo+ID4gcGVuZGluZ19tYXNrIGFuZCBjYXVzZSBhbiBvdXQtb2Yt
Ym91bmRzIHdyaXRlPw0KPiANCj4gVGFncyBhcmUgd3JpdHRlbiBieSBIVywgbm90IEZXLiBJZiB3
ZSBuZWVkZWQgdG8gdmVyaWZ5IGV2ZXJ5dGhpbmcgdGhhdCBIVw0KPiB3cml0ZXMsIG91ciBiZXN0
IHdvdWxkIGJlIDIwIE1wcHMgaW5zdGVhZCBvZiBhbG1vc3QgMTAwIDpwDQo+IA0KPiA+ICsJCQlk
b25lX2ZyYW1lcysrOw0KPiA+ICsNCj4gPiArCQkJZ290byBuZXh0Ow0KPiA+ICsJCX0NCj4gPiAr
DQo+ID4gKwkJc3dpdGNoIChyZXQpIHsNCj4gPiArCQljYXNlIC1FTk9EQVRBOg0KPiA+ICsJCQln
b3RvIG91dDsNCj4gPiArCQljYXNlIC1FSU5WQUw6DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCX0N
Cj4gPiArDQo+ID4gK25leHQ6DQo+ID4gKwkJaWYgKHVubGlrZWx5KCsrbnRjID09IGNudCkpIHsN
Cj4gPiArCQkJbnRjID0gMDsNCj4gPiArCQkJZ2VuID0gIWdlbjsNCj4gPiArCQkJaWRwZl9xdWV1
ZV9jaGFuZ2UoR0VOX0NISywgY3EpOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+ID4gK291
dDoNCj4gPiArCWNxLT5uZXh0X3RvX2NsZWFuID0gbnRjOw0KPiA+ICsNCj4gPiArCWlmICh1bmxp
a2VseSghZG9uZV9mcmFtZXMpKQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCXR4X2Nu
dCA9IHhkcHNxLT5kZXNjX2NvdW50Ow0KPiA+ICsNCj4gPiArCS8qIERvbid0IGdvIHBhc3QgbmV4
dF90b191c2UgKi8NCj4gPiArCV9fc2V0X2JpdCh4ZHBzcS0+bmV4dF90b191c2UsIG1hc2spOw0K
PiA+ICsNCj4gPiArCW5ld19udGMgPSBmaW5kX25leHRfYml0KG1hc2ssIHR4X2NudCwgeGRwc3Et
Pm5leHRfdG9fY2xlYW4pOw0KPiA+ICsJZG9uZV9mcmFtZXMgPSBuZXdfbnRjIC0geGRwc3EtPm5l
eHRfdG9fY2xlYW47DQo+ID4gKw0KPiA+ICsJaWYgKG5ld19udGMgPT0gdHhfY250KQ0KPiA+ICsJ
CWRvbmVfZnJhbWVzICs9IGZpbmRfZmlyc3RfYml0KG1hc2ssIHR4X2NudCk7DQo+ID4gKw0KPiA+
ICsJX19jbGVhcl9iaXQoeGRwc3EtPm5leHRfdG9fdXNlLCBtYXNrKTsNCj4gPiArDQo+ID4gKwly
ZXR1cm4gZG9uZV9mcmFtZXM7DQo+IA0KPiA+IElmIG91dC1vZi1vcmRlciBjb21wbGV0aW9ucyBh
cmUgcHJvY2Vzc2VkLCBjb3VsZCB0aGlzIGNhdXNlIHRoZSBYRFAgVHgNCj4gPiBjbGVhbnVwIHRp
bWVyIHRvIHBlcm1hbmVudGx5IHN0YWxsPw0KPiA+IElmIGNvbXBsZXRpb25zIGFyZSBwcm9jZXNz
ZWQgaW4gdGhlIGxvb3AgYWJvdmUgKHNvIGRvbmVfZnJhbWVzID4gMCkNCj4gPiBidXQgdGhlIGRl
c2NyaXB0b3IgZXhhY3RseSBhdCBuZXh0X3RvX2NsZWFuIGlzIHN0aWxsIHBlbmRpbmcsIHRoZSBu
ZXcNCj4gPiBkb25lX2ZyYW1lcyBjYWxjdWxhdGVkIGhlcmUgd2lsbCBiZSAwLiBSZXR1cm5pbmcg
MCBiYWNrIHVwIHRoZSBjYWxsDQo+ID4gY2hhaW4gd2lsbCByZWFjaCBsaWJldGhfeGRwc3FfcnVu
X3RpbWVyKCkgaW4gaW5jbHVkZS9uZXQvbGliZXRoL3hkcC5oOg0KPiANCj4gVGhlIHRpbWVyIGlz
IGNvbGQgcGF0aCBmb3IgY2xlYW51cCBvbmx5IChhcyBob3RwYXRoIG9ubHkgY2xlYW5zIDEvNCBv
ZiB0aGUgcmluZw0KPiBhdCBtb3N0KSBhbmQgaXMgcnVuIGluIDEgc2Vjb25kIGFmdGVyIHRoZSBs
YXN0IGNvbXBsZXRpb24gcG9sbGluZywgbWVhbmluZyBubw0KPiB0cmFmZmljIGF0IGFsbC4gSG90
cGF0aCB3aWxsIHN0aWxsIHRyeSB0byBjb21wbGV0ZSBkZXNjcmlwdG9ycyBlYWNoIHRpbWUgYSBu
ZXcNCj4gYmF0Y2ggaXMgdG8gYmUgc2VudC4NCj4gDQo+ID4gK30NCj4gPiArDQo+ID4gIHUzMiBp
ZHBmX3hkcHNxX3BvbGwoc3RydWN0IGlkcGZfdHhfcXVldWUgKnhkcHNxLCB1MzIgYnVkZ2V0KSAg
ew0KPiA+ICAJc3RydWN0IGlkcGZfY29tcGxfcXVldWUgKmNxID0geGRwc3EtPmNvbXBscTsNCj4g
DQo+IEkgaG9wZSB0aGF0IGV4cGxhbmF0aW9uIGlzIGVub3VnaC4NCj4gDQo+IFRoYW5rcywNCj4g
T2xlaw0KDQpUZXN0ZWQtYnk6IFBhdHJ5ayBIb2xkYSA8cGF0cnlrLmhvbGRhQGludGVsLmNvbT7C
oA0KDQoNCg==
