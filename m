Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B080CA5FA5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5803B80F8C;
	Mon, 28 Sep 2026 15:22:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a1l_ugI3kEDq; Mon, 28 Sep 2026 15:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B554580ED5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790608921;
	b=LUOlkjNXSFlQDD4sznsqpGcitHXdFeobehBOC4DCKpDnu/ps8tOW0uXXDYmBBCHYBEmX
	 TrBoFOVQVlecxY8XgBCe1s0vVyyI3sWYWZL5MJjOl0RGx4lSqkBxkDdOXMATTyY/LHi8G
	 IG4iU10wy3aHC0wFheR4VW/beBBUuDcNr7xV9SuA8zZeQonvxoIptrZ0pUYSuRC4R7AIH
	 aknxjXJD4R+kwVk+3xBum0SY2J9EikQRTyZ9Qksh3MB0AFWWH96RI8s2sc/Im/P19KysC
	 ws2j2Z87N+M1d61zbO+KVRmrnA6vtoI1wIowgF6AbHLtWDsdnCMMmkvxGqPtcN47zMg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608921;
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
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Bxijq9Bb6//2fm3rnc9N0kIVAraOcWhs9FJdfOx9hbk=;
	b=I53nkmisJ12Itbrp7U7aOB4zflweVZPvlRbcn1D9pG3f24IqIpjiaK3DZmsH4kcN9xkx
	 RhPV6Kp+pGOsHh4YXRTgzXXa/cGiHzbrGPzFbLYvOtcU+4f+1zqn5LynGFfK7Qev8S9Fd
	 mci06i9jFiEqgAiHf8plCuzlHnbQRzkkUKK7bJpKAWLloMBiOOpKUwzeMf+c/dxvyyWMX
	 VIfc/sMY628pgmQv6bczWOPo9D1QmguLaZqst7BJnlqlIbDYtm7fMvXF+6eUwfocjiBfj
	 j0f9svVsGdKdWnrAE7cQ4nF/dz7HYvujY3d1/p21NVMRGZSrK72o2Hsu4UGYKfFiywg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BrIxcNbF;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608921;
	bh=Bxijq9Bb6//2fm3rnc9N0kIVAraOcWhs9FJdfOx9hbk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vt0M24ntCr50qyHzy2FdXQk/+vXIDHPPwLYXJRFeOUJupoYn0+RNOoyTZQlkKoAUo
	 h2Lo96jXQRdp/GXR6zQETwMUtOqnpM2cJEMHF4uwboYVVT+tnEsP2gZmV7+wd0BVll
	 U3zztmaGP41kjxHuUeVIk6o6IxdYa4dpL2yGdtcyAFmR7bSBbZR+I5ox44jAfU8T+7
	 QdxoGDDMaU2A0t0ktjsOVB0JXohz2Vx1zwUWA/TMTpDDfoti4kGwjwCGRh2GJCaaf9
	 mrdXzvoqG8bMo3qD9xWSBgWMVTjJb9wlhATHSxwoznNZGh7iqNPzq4f2Ao2tdO32s+
	 BepzyJy2TW+8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B554580ED5;
	Mon, 28 Sep 2026 15:22:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA5482B6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 15:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C08D880ED5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 15:21:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NS9XTcbxD-bT for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 15:21:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DBA5880ED0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608919;
 b=qkwkyXz+1Hx3Uegvhu8cnLOPIMWKYNXRNLrKERmN8nLKl6gKVqsmP66qg0yosNvLsxOX
 AaxFabGJzKFG4On1ZHEyMpPpswc8O1HuSX5EyVUMwwPKa//im7yuY0iOAyYqR4K9VgomQ
 jG4TYqR3N1zQPtOjbKG4uNkvn1XhAT2xIzSItzgLMxMqM5Hca6sjVBOhrgP0rTgvXM/x6
 VvCs5WtWMMbRLkE4unlSO0tndWDg9LdgO67WQLuKPQSy+bV8mO6Gh8GR6iwCvX7cq6VNP
 3IxT8mdg/wfFDOoaJwP9LLjq5OMThpV8nMJtLWMRRD+wWk+vCp4oQlHKrLRPCaWVuxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608919;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=Bxijq9Bb6//2fm3rnc9N0kIVAraOcWhs9FJdfOx9hbk=;
 b=tbjJ8rryuiFE/++sJAYyGH5Bqp1FsMkSdPvaKE0HSV0fH/9igoj8WNGMBDDSmxtHK4Ds
 a1TtgdDar9/4R59aqQ4Fj/JV2lTS3z0c/nfSHVC+xX4lcNX7kWvyuOCWHW+AH/RKbVXVs
 4bmeb21aKaRhR6ijv8gfoyUTg/QKavsgpG0ZeaIeQzp4DgPb7EgqXZ5XUe0WQtvTFUQr8
 ML0haA9ursjRZCQjH88XVZVEaowqX//0FoIT0E6R21xqkDisRGKWPJO8rswriArg1cWmQ
 crVz+B9K1ioFlrp6ccHhW7YHOQG4n6q2INHzVelgy0WZMwYIS67YuT8BoALXIDSFDnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BrIxcNbF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BrIxcNbF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBA5880ED0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790608919; x=1822144919;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SVELm0I+DzoHgWaDG+5TXqF5Xr8aDYIIAqcLJSukQGs=;
 b=BrIxcNbF9JX2eFgtyn1zfGoP9FJztUUt6xJJimCkOYJGtOGpC1+fX6v7
 2fQ+9zEEtIwbynVwSsmhobTN55bFdyL2S2fT4eSp6XwClPKeOKlVJNYmO
 MM91vhvjoQRH7fTLATrNWFSj6um7JGzkSo0mbFzyjl4dFMYDMh++94qTM
 kwE/2SeB2az04uyL4vhw4Kc1d4XUl3TNTrxpeQOWDifg60hOT/8Ok2UMb
 kJIsT5H3xXPm/Y3V5GjVTXMp7stv6VZ7LovWYWFoq7LW1uwA8BQWUpUKg
 sIS1/mFckl055B475RkleX8mLMqnMuyStNNsn11KOGPQcwIqPBRleTXVO w==;
X-CSE-ConnectionGUID: o7o0v7F+RES0uLMjIaf5UQ==
X-CSE-MsgGUID: yNIb0kBER8qJ37dFl7PjrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="116837640"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="116837640"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 08:21:57 -0700
X-CSE-ConnectionGUID: 9Habw8uzTXai0YibMMCVEQ==
X-CSE-MsgGUID: 7fROJ5GVRYiDz+/S+XQJHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="304588720"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 08:21:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:21:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 08:21:53 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:21:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYrz9P0gdxNryvRWjEHM2jic2nFzdgJg3GfuFjqJmum8GnntFMx/mn6/Xiuv9ZDzHuMqaFBISVYeiJY3J/okJfC8GhZavXiNhYsvbhcOpGtMzj8APyF+59zCgt8eJpUk2VPL/Usw6JNuJF3xnlT+msu1cztFvjZKlXkecUe15yfIm+oBMff0Z05dECq2uUeM3aoNLcgzZzbRa88qfMLsk6Uv1Bxf+tAuc17upt9jSzXSEDsNWeisH6kvmNDxJxeh8yd18BBcbgz4C4f08PiMLefAPlmLWMxba6XaTG8Z9LNgUs+4UIVxK0eKzMujYnwNIfx29nk0AWFAAr0qGMgFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bxijq9Bb6//2fm3rnc9N0kIVAraOcWhs9FJdfOx9hbk=;
 b=gQeNnECrjdTTT9nQhfMcjvqXx+k1rC6oTal6UnKQ9qckbCO961jrzJP0MP8UTGhGPvLunsZBpNgIxchEGr8UpjyZfX9xpxmvTK/P2SrL+YAY6tlcEGCBwLUqlRms9UQWN7CLIC8IR4NWQTmyY2S6QSSMHZ61rLzUo86u6l4+K4s77XHzXDos+B3Dav2iE45udbXX+Z41kMi7hhqef99Ij2a/LuF1gokFJu4IlTKWh/eOBDdE9VYTu41p6agiUpZzzAr/GAUe7W+utUC2tUqY00rI82dpHfr46HYdjt3GDk6WdaNt/fMGLJBdsRPa7BQzo/NcmQGUnHWFXJgsDWH82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB7656.namprd11.prod.outlook.com (2603:10b6:806:320::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:21:49 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:21:49 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Brun, Lorenz" <lorenz@monogon.tech>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ice: fix pktgen crash in eswitch mode
Thread-Topic: [PATCH] ice: fix pktgen crash in eswitch mode
Thread-Index: AQHdTT0DccHCALKZtE+mRU2oqa/MLLbkHy0g
Date: Mon, 28 Sep 2026 15:21:48 +0000
Message-ID: <IA3PR11MB8986F2F11D6594337EBB871AE58D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925222645.354053-1-lorenz@monogon.tech>
In-Reply-To: <20260925222645.354053-1-lorenz@monogon.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB7656:EE_
x-ms-office365-filtering-correlation-id: 9c18e26d-f38a-4408-4431-08df1d743740
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: ggXxTsse4us6IaccYgWTo3KrsWLAeu6NWIjrkv0pqeJ7TDUhq09ylp+3HE0k0z/hrwOHJ35Tk9jp3z9HhBGiN7HD68y/lhgFg6YksYhADTcKV+LBW+bHcac/xYma9OESIFOGTBpsyKU8/+KCrnkVtse9LumQPmodn6UR1zUvmsEtlQW5zfJLR4fRBwMXAm7D7NiZP0+CWChWFWnF858Z43daTMKMEWr4WtVFlcZdXtWOB3g4IfnSjzL2xHs2Jy6yltAKDxYX+WjSrOnpnB9A8mWlpOOnPwBnYQg6zG0baQdktqgJE+EFGm9D3iKy/Y+OAtVtFEaUuONuzUDiY0Qr7kADyudz3VcB86ermf2cWXU2sqL07L56p5V32i1qXtuI2uu+o+PuYmYFPueFSC5Fyo2Rh9QJbtyZbLuW6HLE4Kg9fHi0SMXkkc1MOnD/o5qiNKU8Xe05Srdc/l/IBD7UW8MLLlCDTm3gTQ50vXsFml2i78NGgNWqtbLyG7Dc5wO6/YKmpt0JdRInXR/RsxJu2OrhF9WJIncAqcxh1Wb4u4GIJqn99u4VFBw0JzxXBxWl+jY17WKEgn2szZJdiliLRzk5kq1vBOwlAg6G3HnIqjTRkvrj5Qf0EQdCFCn6mX5lbQfWxcjxmHDCt0GgED62IaxojoGUHV9tMQQQViM8tHYD61NAo7cz0yAE1oQ3wCdMTJlV07BK2V+LcliHCFH76cMO1s9hSgYTDtPoyzKyJdty+SEVaQ/Xs9En9Cw4PsNS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DPvFfbLpwfdtQ3A8ueBPi++5HO3Qkb1+umR7yiEzUNpjaeeHjfvD9Fr4Emrr?=
 =?us-ascii?Q?EeAQv2IivC5lqnGe2DsGbHjTti49ekDbUxtNAQ9SDgbYdcWafnZb6LbbYGme?=
 =?us-ascii?Q?SI3bIMXWDTJmBkJlmpBp/9VLPHbZ74XGJ6JI/mMO7B+D9vFVR3p2QUCjngQf?=
 =?us-ascii?Q?r/Ryxcf8IZ8nTNrc2Xen/tdnhrSqNGrFZjV3IG+J9sBcQPJISyrlqmZsRMQO?=
 =?us-ascii?Q?gJhYF+k1JdpSouPVIKwZEWbanKa5HJw4/A/D9TVIj53mzhs6g5XucSX0JqbL?=
 =?us-ascii?Q?uavSS12X9GDRk5C4IgA7NqKpsZY9vnsPrgDka9g4GNYTUiR1IJ+n8qH4JAHb?=
 =?us-ascii?Q?vyDQRPIWZgBSX7DqAjJClgkiNV0Ml1h/jbKFb8RinqSId8Dx6QJhWEyxpCyO?=
 =?us-ascii?Q?9HsnjNNUecoLA9l0xEnxXsGCtKLY8PCDKm/Aq5QqEBSANWIpRr7ujtam5Vd2?=
 =?us-ascii?Q?9QX/a+c0PJ50rBhSCKnbrkvxWiJCu23cwBEuP4oQxlvEzMbectoOVCkby159?=
 =?us-ascii?Q?JehYtCuQuLrRvUBNyyEtie2j0CXIMVrovtlMpfFmYuurVVQKo5mGasqi7ImW?=
 =?us-ascii?Q?CNrcf0YwtDs04pDukvz8CP+ou/WNkfwSs47LFW1DNGTBYnxim3iilRMsDx92?=
 =?us-ascii?Q?35LWtJ0rQqu60LcM8Ldu1aKH5JiK4mi/u02gOhbcgkLExOIbNR6073n++Fvy?=
 =?us-ascii?Q?wF7fR3yDuGT9TXnXJWAd2bUVmXuV8F9kVVABaurEuXGpsxXSJTyWlW0BFXq4?=
 =?us-ascii?Q?czN6QF86f9EmuSkHVl9eduGsDq/mki+SOaENxkNrMPnsl4W4W6MkaIWhqUGt?=
 =?us-ascii?Q?lAoOO6SFh8Q2CkDjh3vYlV6HWF/qFw9I5EObNO9n6DIdM1Rugj2+ZHu5ZC3y?=
 =?us-ascii?Q?2lq0tLOysnHf1bl3LsO/FnGqW39wuDGIdqU2VXrifN05pshEhYzcVqsOQREP?=
 =?us-ascii?Q?yEuYN6JakgGKTEVn8Mhz81/927nEJxSDTRrC5NgBm41qi1fq8uYJx12CJPYK?=
 =?us-ascii?Q?+ujnQv0iEole5SvR7Mn69hr8TDKFGuA8PcDH+5vz3fgOHq+JM1GmbpLXfIQ5?=
 =?us-ascii?Q?6+0BXirhK86eNaLlsCvWRz/ntW8zecNRP+P3Jbeu96UBinBiNCOr+xer7QQt?=
 =?us-ascii?Q?mpMn3/fWkO1hFp8Ghw4fK5RvNayKDKmFhrUL1vn7EYA8pkHpLErzRnYbex1P?=
 =?us-ascii?Q?50tYzP3MT2FVCe3p+SVhBZOY5OVhPFcedPXyQaUpV7I7JjfvFm8GlS7RZx93?=
 =?us-ascii?Q?zGcPtusQ2Ag/2t3zFmb7BeMnJd/o95KLbLlFXMtu2iUcj++o70C9AHsO5yoG?=
 =?us-ascii?Q?wtJYMkeCH+pY+mqLEFLZ0k6Ry1fm9vZIlXWEy1I119aLQ8go6N37S6VV+hYS?=
 =?us-ascii?Q?lgIgBtw2LksoUX8KCj9SspXV0c/jM6jsckkJFt5FmP/ZDRpkbihc3wXAyUTh?=
 =?us-ascii?Q?wVatDkH5NKNRoAJcray4vuVgnY7s0TVlEzbF6yQyaHyERrn5nwenQGdp+4CT?=
 =?us-ascii?Q?wCAd80XlbWZ6OgjBR1sjzHrNvkOZ36IgHzhpNSyrdk8TrtTzQHztg2eKDtIx?=
 =?us-ascii?Q?dhz4swgxI9a/2zntMB3xWbBEeB4SX63xODS7A5w4km85XDpOEudaeBXBfex3?=
 =?us-ascii?Q?0KJmK6O/UH4uKlxy+hEk8ApX6LmqEKMwhmhcxyVmMjbxRjg2ejclS11CqHo2?=
 =?us-ascii?Q?XLcc0pk21T4hWBYNhxFX2HQCHq4lQRYRiQ7BCSec7S7E8hw67eAqoLdqD0vb?=
 =?us-ascii?Q?AnDP5CgGxErNprYB0aDYhqUX0odOP0g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P29h15E0ng6YJCoyBkVUu0HOhKUt5haKc+eR9bzST+nf7pH7Nd4rvf1ysG+i7ptPZC9LiENMlMgLFLB1QvCrpBpsRi176ZADQMiWfHabTQVmwpigFhptgfzFM6c1m1swLxwL1b4mYZi5wSbtH39D+jY+I99IP+9xPoFtgOUm0qBKtYG1+haFgJy6ITbc0ScMyD/4dNf3HxGnIV3gee/ntbG1uLEikb0Ja6StE78ivNT+7b40vc0+BcslacMIYhyBPu6wwDpYozJbBXeZurWtjnT2q6Qtjq4du+uxLmQQWFXU47ejeVusmj4Yem9dpoaP7OPV8XJ0FbG4BFlU4al07A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c18e26d-f38a-4408-4431-08df1d743740
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:21:49.0102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4X/UAA2RE6h0TiJmPOxcbw+fxAg6K2QO9yH63YX/6PYQZXoGyoGd3YyrzdY5qo/jGzIBIFZ+Jt3uoJDJkXpBRdb8yG+/v/ffTSRwIaZ/14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7656
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
> From: Lorenz Brun <lorenz@monogon.tech>
> Sent: Saturday, September 26, 2026 12:27 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] ice: fix pktgen crash in eswitch mode
>=20
> When pktgen reuses an skb on an ICE port representor, the representor
> forwards it to the uplink through dev_queue_xmit(). If the lower qdisc
> retains the skb, a subsequent transmission of the same skb overwrites
> its list pointers. Dequeuing it from qdisc->gso_skb then dereferences
> a NULL skb->next in __skb_unlink().
>=20
> Disable SKB reuse for this ice path to prevent this.
>=20
> Crash signature:
>    __dev_queue_xmit+0x5c9/0xf20
>    ice_eswitch_port_start_xmit+0x83/0xd0 [ice]
>    pktgen_thread_worker+0x82f/0x1c10 [pktgen]
>=20
I think this patch required fixes tag.
And if it's serios bugfix it needs to go [PATCH net]

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


> Signed-off-by: Lorenz Brun <lorenz@monogon.tech>
> ---
>  drivers/net/ethernet/intel/ice/ice_repr.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c
> b/drivers/net/ethernet/intel/ice/ice_repr.c
> index 096566c697f4..2603cb0f6a54 100644
> --- a/drivers/net/ethernet/intel/ice/ice_repr.c
> +++ b/drivers/net/ethernet/intel/ice/ice_repr.c
> @@ -305,6 +305,7 @@ ice_repr_reg_netdev(struct net_device *netdev,
> const struct net_device_ops *ops)
>  	eth_hw_addr_random(netdev);
>  	netdev->netdev_ops =3D ops;
>  	ice_set_ethtool_repr_ops(netdev);
> +	netdev->priv_flags &=3D ~IFF_TX_SKB_SHARING;
>=20
>  	netdev->hw_features |=3D NETIF_F_HW_TC;
>=20
> --
> 2.54.0

