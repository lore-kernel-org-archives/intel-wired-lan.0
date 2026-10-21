Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA1606A31D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=n1d6+lHk;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZoIsrKF4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FE2C81086;
	Wed, 21 Oct 2026 11:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iyL5dsUzO_FV; Wed, 21 Oct 2026 11:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F7118102A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792581160;
	b=AtW1hM96nRkUSqhvgNd4mq5N2yKh5kalX6hEnjZagfKI8H5jDESw96Qv80dW29A2g6Sy
	 zcrU27l74SJMQXNHfFmbCv/4AwCoQ7q2MAiTZnfEDriJNg+cALAtgjoUs15ahKi16EW0C
	 5sIPBnWP1d/y/z3UQzX5MolutRWGFpweCrY9X8hUADx3fxrAkHpFt2e071bxRmC9jGDCD
	 dkKAETxfQktbug0ZFvYtadSePhRy0IiwEVBpzKODDX/neIUmSZsSHPE8SPPF0XYgVaVyO
	 5/6uMsX0MwslcN11CQ7CF7O/l/+yJ97B6/TESyZJ2Dp064q/C5eDu1FxaFzeDbmJceQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792581160;
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
	bh=GzOwwO6Vb4ZMEqRl5LojXX2sOV974LGw65Vis0Yhr2s=;
	b=EOBQpkEfjSN+WjYslv9AV/I5XRHOIIzFoRC70rYduWCHVGla9oe29IEnaP1zHLpW6MVl
	 ndXlCxVSDa2k1n2EUApISFkFISDCBZf1Wp6No5HAZQzlrd/yLptRReBa8XwNGIcOYSQLv
	 S2UYe6WUSe+fzR11hUhrTRinjCrMABXrG5QDmMs9fabkd6BXtNlYRVY17H3vZbRgIlFQ+
	 MZbVSFf1dwKjp3bkRL5s/HW+L+Rf3G0fhduLVtTuTzCuMv2K4QvCeJ+bqd/ZmFyY+dLid
	 gNPULFTHmqYDOLdI0qRCi5fDthRDRdnqBMTSN1UU3H2auGINtW6b+YPHARIFvkoXA8Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792581160;
	bh=GzOwwO6Vb4ZMEqRl5LojXX2sOV974LGw65Vis0Yhr2s=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n1d6+lHkPsNeDw40VjV98fnvuK385Gpl3/78fRo20hQT7qtHntPN7HU4K1/5vJCan
	 yTayjM3v9KXApw0pYXDaPmq3PilbjBQg+GZq8ZF0nw8GSfg8963vb4DfkejKofrLjG
	 e8jD+0jUFUeV3dlZcfQgLs5XHqSZC3mDTGmoehme1TeE3yT3Rj/fDjIgk9sZ5YSZKp
	 XtsCUI7u571liHJtakIGXu9VyArOI/vMBDouLuCA2OeurivdoMpz1XvHlqGW37WgsF
	 wMto2rr7R9hYePZRuW30pSaoNWlxQC5gQ0U9lYlw8RSUUBWStR4i0SmybIuVmS+yFl
	 Unv3S49+Cgxmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F7118102A;
	Wed, 21 Oct 2026 11:12:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 29F7B3A4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 11:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B67B40380
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 11:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q31qOPPIRCOR for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 11:12:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7BD7A40060
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792581157;
 b=KhCiuUQX73ffuwUxijqT/hB1Y2idGMDTHgYCgs1FC1V7iVttvGcJTSxX+MDmhnzx+oZR
 +MJJT0WlTUg2Eq8gDbWejiZ0QbB2G+zim/r72cqBBwqC1ojJWSCyVtCZ15ob4n0LJPBlt
 4wOXiKBlhLaFamUPl767ChD6tt5bj4qhlpCSLqTFSDPKGP61kms9r4k3+uMvRsJT9cwk+
 IWFCq2Mh4gCraOPfAQM2KEHNllhWBSRyWd8wx1k0hONb/iRG6gLpV5DHoEtNbA2jBnTPJ
 VYqUNSsZetHPUYopGvFVKE/KpNtM4Yd1wK3WcyolP4zDnyv7fjYOmhma5iGd2lpQ0Eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792581157;
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
 bh=GzOwwO6Vb4ZMEqRl5LojXX2sOV974LGw65Vis0Yhr2s=;
 b=R3Velw3kxS5BkuA+f8xdkMF4OqO8Gp5Slrw16+LDpaemKNtkZE4o48I2biUtyXkKZWPo
 aaUsZs+a1PXySv15SkkC2V+Pcc0obX3JhlkB3EmnUAqV/pCmQvcRXavmInPXLvkyRw3WT
 4l+idkYG8Hq4IzXVrR39OxzU1JM8vyHT7X11CkuhaDT7i/r530t+jJYdsVWs7nL9bPKTU
 Zk0PZx0gZiYYhwjWBzN/ko4twto9mWMS3+laleG+kHIMaclXNGidEgYAJbd1kfsVYfAve
 9QCVP5J8fMJpqtpMPgOFfviFsVfK2tjllxRLnZ6SHXouIdHznQcL4uAFsMzrxD4++aw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZoIsrKF4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZoIsrKF4
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BD7A40060
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 11:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792581157; x=1824117157;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uEO4AgZQftIUIlWb+cC3CNRaJOiWA2YUbcx654+zjaw=;
 b=ZoIsrKF4WxrkLbR+B233fmH8RvsnWYIx2fwHfrZ2fHwreHSisd1lX4as
 CcftVdswZVG05zZB9lUyfnVJjAa5pFYfaf5wrco0F/S/Z+RrcY2Jn3f7S
 wO0weIxUSfNcqcHFJsbimkoaEScgdpoIjjV68k5zdxPQJhxBo2xFjCOSL
 b7uZt6vo4+TwrQZHXmOSGnk61lL3J2SgLBekIAK5f/S58+4xY8xtwB4IN
 j2/Nuk9hVByeIqwI11TMsoqSoD9nzh4GO01Lj0ROd4ZwgDrIgRCGkRcgE
 N+NbtzS5Jbp6zdQdqItoEyWYobROXgxh22KEo6VEo1GO5/pzIMz11uacn g==;
X-CSE-ConnectionGUID: fS75pXJJRmeeeFWtyenyAQ==
X-CSE-MsgGUID: Q0btABqEQZq1wOYSL5nhbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1338839"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1338839"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 04:12:36 -0700
X-CSE-ConnectionGUID: SIQ8f+CXQfChiUM7YzMDKg==
X-CSE-MsgGUID: ulFQj5niRQmgyxX/9ALOzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3528356"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 04:12:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:12:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 04:12:34 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHWSUBOOhWxoToyvj7DLfDQru9pGVG61C7KwJ/We66Kn2DvJ27pSXj7xnYVzR825NWr9UTXPXeFLMXFCHn2WA9C63Da9rXLKbLU86nlqRPBe4rt6VT288Dv7AEUZbjyNIsM5vGYVRGwu5e+yXHOEZOHOqsCazPctZZqzS25OhqMh/ebDL9n7y8Y+rbQPZdIUE6zRbw4uQAb0aMT3OEG2nZgalNh3CpaNrQU9JR7YVhBmlh4r9wy2oVQp22LtzBmTnGy30Y0qs3U+xV/5vT9FVfZAlk2lRzOmv4/lVmKHIvq2pMuFwuZx4s7OHt0IN1FNNyD5OfREexosuX0+1NKWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzOwwO6Vb4ZMEqRl5LojXX2sOV974LGw65Vis0Yhr2s=;
 b=xf6M7Cvv/3EryA8tqpa2i6KdkYYwV5JOp6+XcpUE5RVycAA2lRMWwlvNHbrs1RR1V+E5sV28gREIPCMsksEwH/T1KYYyhV7TjsCCIWHd07msvC/kOUfLr5JGH//oQIxRYkrKrR8B8nvfpswYv5rsxh1iCZmLFnti3oGbp8DYlELXBcPOsVahYTR8VzpKJ6KaljRiAnBuiTxWwVisuuTf8cOsRXEj9rMcIktl03HCzgG0Hizkz9los1pOHLOBIlBQZ1NoI4VpS3xRAaNsafyxIeG1d0pmfaAzhUlqfohjEYbxp3FVlc7IfyQSLeALdBiRxWwJ5DX1dr7919aMrRF4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by DS0PR11MB8737.namprd11.prod.outlook.com
 (2603:10b6:8:1a1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 11:12:31 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 11:12:31 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Richard Cochran
 <richardcochran@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
 <brett.creeley@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH 3/5] ice: scope global configuration lock to the adapter
Thread-Topic: [PATCH 3/5] ice: scope global configuration lock to the adapter
Thread-Index: AQHdX7gXv61ZbOtoHUWGG6e/kGp9u7cH2kEA
Date: Wed, 21 Oct 2026 11:12:31 +0000
Message-ID: <CH3PR11MB56689592183937149141CA5D6DE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-4-aaron.ma@canonical.com>
In-Reply-To: <20261019105155.3793063-4-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|DS0PR11MB8737:EE_
x-ms-office365-filtering-correlation-id: b6f304c8-d4b4-4d22-43c9-08df2f643382
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|38070700021|56012099006|921020|4143699003|11063799006|261009223027099003|10067099003|18002099003|18092099006|21046099003|6133799003|3023799007|22082099003;
x-microsoft-antispam-message-info: b3/D1hKAn9x40G5eQ432C3Ld35s0WNCXhiPU+r1e114VFhbGwIHPV2dolgReLlEMotvRuYjT9gkyJs6KSezvwRclm4o1BFYNnifRmTOSJQPVvSIIWPtmJtj3O3TZqIURtPTYpFRSl9Oeh/cvahqmfboQgPbaLFpn0SInVhNnhlYd+IraGMy6K7S93FMj6gsIT0h9HkSSGlVJtEN36XdaTuIclHhcgWEMFjeKJJlZExOerRZSox7jASeubOkgXXYRjAoPqZplOfZ0NSvOYnHmkEnYd6QPMHvHV/P0it1mYCKua0pVpsO2oBx95KIgID+svzmKIBHmrV+GoiO0mYzhuFNYxf7grM8zXm/8oL4YIWy3r2Jviubl3etc836IUTLTj7RICmtxXNqwRDu+frSRh8HCVv5OdOFMNA7gBGCGYlfdVF7LvD7UtVw4CWRZ34DiUYyyG51Jdps6dbXUugQeVJEnyC4GSmMxUGH/eQdcHcCWAvmwvgjwzJ7vnzoJZ7jKbD5TIktXZpHybkTd3s8HBYnpi8DS4qd5fygdVgBTD8ZF48o3D6MbBvpm1gpm07PJGKFM5ez6fPi6ZoFx1F6bGZMtqpLbaP2+nr0stD4zIkylsr1pnAMuLTYa26lND5PGR5EC53YID598FDoILA9t0N648dv1CC1XBpWj3fktcJ5JcJop5mxR7JPxumb2bBSkSQOQh4LVLEpKUFaDBWnbL/LSZnHm3mjs8jMmmQJtK/5C2zAIsyEFscIZBRBPxcch
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(38070700021)(56012099006)(921020)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(18092099006)(21046099003)(6133799003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BAXSL6ownZSWy9TjxnWD5+zfb1HOBsWVDlTfdEbVqZhz+jKd4xPu3nFNoODW?=
 =?us-ascii?Q?T2ZDKLNiV7ZwKNnX7cwAKi5D8gitbLBTKHKEBIys0qjoAotJqQF3XpUaSqom?=
 =?us-ascii?Q?tUnKIgf1NQU22dTQaXhjfQhaib2WW5NsKm2UPP0FhUzlaxBWlgzlFfq5SjPX?=
 =?us-ascii?Q?rVdoc9ayY3o01o1tiJSE6twhg9xR2MWvLNHMf0BbUWWODPuwQVcty5nKZLrh?=
 =?us-ascii?Q?rXpQXwrygQKVltIqJY1GqjD0+hA1IAJIxJhNRVKxZdxXBfDzr4XPZEvSZEpz?=
 =?us-ascii?Q?CCuMgtS27kgcGRMe/X/7mDpy78oAR7uL3KTEG39YGu5tLUio8mHPuHAlDuH/?=
 =?us-ascii?Q?dY5G7gzc1+/QYfhrEvyGH9DlpbUztNRWdbZOP52uIDZLX/K9CrzU9lfsopw2?=
 =?us-ascii?Q?G+r/OTTLWdlD1hZRrg8uL++tcY9k6in0+D+Chs1WUspJFynl9OF+40S0FlWY?=
 =?us-ascii?Q?FsVvrZeOHesEEZVTUMjvYJH/u7101Jw+VLB7AX8Q15h2MHJqE8ccADq8HjKK?=
 =?us-ascii?Q?h1un4e/nZia/YfTFhh1XBlwA3s3Rsc6d9ty9OJG2sya8RzbYd7FIC77Qx6Ml?=
 =?us-ascii?Q?LoqXDtgCxmCKWBtp3jvy2FUQAYA/18yHyRK/aC9SEPBHCNQDr+DwnLMzbT20?=
 =?us-ascii?Q?l8PoFWbn9zmdSH6kN2jJwO5f0IOLr9QIds/sITP2nCbXR94MUWNL5uvlnl0X?=
 =?us-ascii?Q?SEBJyhzDveSXgofr6Tv6RGxrsvPJMHZ6mbFKS4VUG+th3Q/xAacXWL0K+FPH?=
 =?us-ascii?Q?nH6O8iba5M1DStBYnRiWlCsFElIIA3W/J0Qoj0p9JdmU4I0tEHJbdUkh7oue?=
 =?us-ascii?Q?om0NUn7ImVfCTp/H13x+/UGthL/P9+qMInYn3wFjts9AmIzSd/04m2wqelmo?=
 =?us-ascii?Q?39j0By5sGpEtfMWSjVK7ycnbtATzxF3LwiqBy8bwGlHV6TYASpCYn4jga1vL?=
 =?us-ascii?Q?038zuRqzUbtcnW8SnWpWbZZ24x1nH54LCiDq/k/LV2UI52Uah6gZKzSePC4G?=
 =?us-ascii?Q?qFiKSOkjyYUZOY8mPUhT63cwZIW0sDbu4s1p80/+20hu8dyRBm1WTW9c9rkV?=
 =?us-ascii?Q?VSz8NL2rL7PXCkzYPpEy/BKwCxTrS+xpqRDc7KxXY3xdvgF8VFXMJ6zFAuYY?=
 =?us-ascii?Q?mArK/DzDpZUdd1mnDwjUpPBw8tkVc7QvTiZ6dCTHL8KDyPPdExsocaafd/Bf?=
 =?us-ascii?Q?zz9yj1Fc65S6ksHSPd9FAdr+4Th1qzCr0e3Ne1S5ePsG6sArQajS5LRP91JB?=
 =?us-ascii?Q?SaTE8DeFCXkwJCNFhJbPYyo4MGnA9Hhw0ns2ghIC/ujJ7uNA3/R1Y2ILy5iD?=
 =?us-ascii?Q?YeSUHttZlvT1O/lHseTwl1RhWMjc2oFTTVN26srm2Wlg/31NsQtebf8env1o?=
 =?us-ascii?Q?TNQbH5hcG2OS2F1sI1vTeKVP6nWrJUIzRDOhrgS/9DaH8zZkpbXQepX+V6E4?=
 =?us-ascii?Q?dDp4v80bH2Ww3Li4n3HZaQYiNFcx8HF7AvUxpJeOtDSFd0T7ssa0lP4+RUVS?=
 =?us-ascii?Q?z/tho70zbtWw6VS8kxB8F0NfuYpL/LclVzKMfkO+Sg3KscN/ApjSW0yqHBpT?=
 =?us-ascii?Q?c4Varp+92iuenx/gdSvWg7dz1DdiMgt5/USCQCa4s54mfh/MkdWPbRFZEWGD?=
 =?us-ascii?Q?UrZScd+az6nokIfL//mFq82RH3FUTmp+Y8Zalb74C06KxuDy/pnQuG8B5EsF?=
 =?us-ascii?Q?sFqarabeGIMF+KfXJe58CjmnA3vTnEPhFY1zTsNIhij64vsmcuMSSMvUePcy?=
 =?us-ascii?Q?MRpB8MZ536bslCMmBtRsnR4+RzHvwJw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4QUlfqWOGcw9fMGM++nvKcCHgZRcMnZkG2LibQd8SN0MPlHQYa0J7lnrfueVBohd1ZU98V4BQLSTjw7BHnrJX2n9SMrgs6VN8NioxWeAUkoofMnozbJAe15fOYEir6epsnScHIl5Nw4GDUkSGs6MYl1m0wprQ8+hWKTKZ7t1E7x8sB1HDPmLIkcu+9SR/EBpnFNaEjdT1q1Olt3bYyhCqs/cgShXYs51OQXP0fUSvN8+VrNycFZf4scQGWLuTIaViFEEs4N9YEzuXnG4skEF4DDpGAq61myfu3VFSoXgiKX8mJyqQNWGdFRKKKPgBvHmNzRK78dXlsaMHzP4QB4PnQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f304c8-d4b4-4d22-43c9-08df2f643382
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 11:12:31.6740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tICzGZRJ/BHeOCVKExy60MAMXs2mOUevvnY0iNc7I7XovYanX1at2Rxic0DM9TCeWLvbpO/j/zM0Rdh26Rgynq8iERyRjQPvAzqIaXdw2Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8737
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Aaron Ma <aaron.ma@canonical.com>
> Sent: Monday, October 19, 2026 12:52 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>;
> Richard Cochran <richardcochran@gmail.com>; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Dan Nowlin <dan.nowlin@intel.com>; Brett Creeley
> <brett.creeley@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>
> Subject: [PATCH 3/5] ice: scope global configuration lock to the adapter
>=20
> ice_global_cfg_lock_sw is a module-global mutex, so a package download
> on one E810 adapter blocks Admin Queue commands on unrelated adapters in
> the same system. In addition, the mutex is acquired only after firmware
> grants the Global Configuration Lock and dropped before firmware
> releases it, while the opcode exemption list in ice_aq_send_cmd() does
> not check whether the caller is the lock owner. Non-owning PFs on the
> same adapter can therefore submit exempted Admin Queue commands or
> sideband requests while another PF holds firmware ownership.
>=20
> Move the software mutex to struct ice_adapter and record the owning task
> across the entire Global Configuration Lock acquisition and release
> sequence, including the core reset path in ice_cfg_tx_topo(). In
> ice_aq_send_cmd(), require non-owning tasks to wait on the adapter mutex
> while allowing the owning task to issue the permitted configuration
> commands. Route the Admin Queue fallback in ice_sbq_send_cmd() through
> ice_aq_send_cmd() as well.
>=20
> This patch depends on the previous patch in this series.
>=20
> Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization
> (DDP) download")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adapter.c |  2 +
> drivers/net/ethernet/intel/ice/ice_adapter.h |  6 ++
> drivers/net/ethernet/intel/ice/ice_common.c  | 63 +++++++++++++-------
> drivers/net/ethernet/intel/ice/ice_common.h  |  3 +-
>  drivers/net/ethernet/intel/ice/ice_ddp.c     |  7 +--
>  5 files changed, 55 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c
> b/drivers/net/ethernet/intel/ice/ice_adapter.c
> index 7de9223e971a7..17819c3a172fa 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> @@ -65,6 +65,7 @@ static struct ice_adapter *ice_adapter_new(struct
> pci_dev *pdev)
>  	for (int i =3D 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
>  		mutex_init(&adapter->cpi_phy_lock[i]);
>  	mutex_init(&adapter->rebuild_lock);

...

>  /**
>   * ice_should_retry_sq_send_cmd
>   * @opcode: AQ opcode
> @@ -1895,17 +1894,24 @@ ice_aq_send_cmd(struct ice_hw *hw, struct
> libie_aq_desc *desc, void *buf,
>  		u16 buf_size, struct ice_sq_cd *cd)
>  {
>  	struct libie_aqc_req_res *cmd =3D libie_aq_raw(desc);
> -	bool lock_acquired =3D false;
> -	int status;
> +	struct ice_pf *pf =3D hw->back;
> +	struct ice_adapter *adapter =3D pf->adapter;


pf->adapter can be NULL during ice_init_hw(), is it ok?

> +
> +	if (READ_ONCE(adapter->global_cfg_owner) !=3D current) {
> +		guard(mutex)(&adapter->global_cfg_lock);
> +		return ice_sq_send_cmd_retry(hw, &hw->adminq, desc, buf,
> +					     buf_size, cd);
> +	}
>=20
>  	/* When a package download is in process (i.e. when the
> firmware's
>  	 * Global Configuration Lock resource is held), only the Download
>  	 * Package, Get Version, Get Package Info List, Upload Section,
>  	 * Update Package, Set Port Parameters, Get/Set VLAN Mode
> Parameters,

...

>  	/* Since we triggered a CORER, re-initialize hardware */
>  	ice_deinit_hw(hw);
>  	if (ice_init_hw(hw)) {
> --
> 2.53.0

