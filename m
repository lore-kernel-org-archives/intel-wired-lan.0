Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0F60A3821
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 11:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00FA880ABB;
	Tue, 27 Oct 2026 11:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jzFDoCaaHeQS; Tue, 27 Oct 2026 11:39:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5561D80AC8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793101199;
	b=PaLlXbAMoOXm6wbHuAqHPXLQYnz8AvmV/mnBNWna5tJ1bM3+fLkhMSMGd4twoDgECxXN
	 XjNadglkEW9pBHrzQb8hZMxcqR9vi1EIXJFzVC9VL6BZnnGD5Vc9no3EkODvhZlhcAWs0
	 IB1DdadlZBhGe3ex4z4s4/GB6rhvmM+sXjd7vB4sdukdf+JH1Vm0r7gtUwrgiAMd28C2q
	 2teLYgyRa0sc137gOrCpcnd4sTMzh1NsaiM72RvinSGPEH4MzY8henMWbpRlVTF2FAYHu
	 jDjctgMXagf11uwws1S+92g+3sjdaBW6QqWaKs3LT6Opu3hDDaQpgbWiPdoWemwOajA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793101199;
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
	bh=7BRqziuHrj6U+k5siVvQBLXkWKqBkmRTJ4qhLAfgzAE=;
	b=HNiaNq3C3qM4/YqFrFWuiiEvdg6+ApwbEc8kNxtHI25yekEYrpeK+odCTha/D6ZrX+4A
	 Allb7MBnQR6j+W/A6iG3CMZenE/XXPPtBdPwOz7ZdZoBHDW/u0toFI0+RbkX2bUlxp1I9
	 7R98S001yLvx1SDykwhDRLe0IYtL7Ip4GeUNPNm0zKSmE7VdXMMBGeFS/t9VDOm/uzpUD
	 X8IjlbUBPdAI+bLT/MBmqWCdb1KOPxD5G3E+8rtCZqtNVt9eIwGvJQpTlBuJMnbB4EAYb
	 4VMlCpeWEibeniNP/Thp8zeIvuzhMX1L0uGLJ0mJYKXv8TA4TvtLsRE+pOxD9tf4dvQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mq4ZSEsB;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793101199;
	bh=7BRqziuHrj6U+k5siVvQBLXkWKqBkmRTJ4qhLAfgzAE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b//noYdY/uPgoPMmnyijpBTM9VgbTgGLB/+OXkaanadVFpmSU308l0g+OGPl6bq6W
	 b1WImc957MLqxhpR+2w1bKQx5ue6VPaRqtquxeY1UBvJ+j31ZainC9t9mS0LNso4Ga
	 YP5qIPHI0bDem8PIACvwcWbYWPx4z7TzXYK5U0pyKAYLLQv9nQUDLaEnFMDS+xo6+j
	 mtzEMzV1GP1ijX8ivhQvGk5OklZZLYrTsUp6vUQlmgps9hvIl4f/jFTHF2Tac1MurT
	 NecVib4nyJZc5ZXbIiA24wDH9hxskzhyKZhvdiTLvMaPBpnLmh4Wka3ABHf2hPxgEs
	 S4wox/vWIUXFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5561D80AC8;
	Tue, 27 Oct 2026 11:39:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 21937120
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 11:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13C3580AC8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 11:39:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B1oNI_Fgb5Ai for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 11:39:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1868880ABB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793101197;
 b=D1cPSBroBK6MiLTMPthcl5Sz/7EvDBP5XV7wxh08sFnZgHcfmVgEslJhBwalB13iBsog
 cZviCVXmrF7ItwO6uE4y9Ev/2+0J7vFiaYzyjZsTWClDc/qNG1Jlwx2HGMrGXgnhSz3Tq
 WGzCx2vtm17vMp/CdSUO3QHd6/zvuE42OPKVOfRTWi3Rz9pwnBBYSi2laB0HAZrZCHkPC
 dz69UycQpA7YvCFLsxG18GeQn9U446RObMKIBpFgsf7z8dCBMegVBYgHBQO1WkGuj+PWX
 YCIWlQc/P7dMF2WiW8toqOZydNm9Q4Vatq2PORmrir5L5KtNqKmls8F0rnoeuSt3ylw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793101197;
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
 bh=7BRqziuHrj6U+k5siVvQBLXkWKqBkmRTJ4qhLAfgzAE=;
 b=sqBu8yiRyTEtRUgXj0JsNg/KZ7ImQreD9UOSE6pkuT91TUvEoneHt38efx6G+YmOZADN
 Z/z305rmp8uPQd7NN4tWWkz+i2JCA/2uBiYBLOZs0m4FEEt5uPD2xeOcohZf5abpHDHsu
 KVDSqH0cTz/acT8fYeV7b+P5lrCAJlfY6asBEltbRyLwZzUdaN+QZE5eNeqg3KOQ1Gzpa
 t8gj3tmbvsM3ipM5tjXNUVEycfLlfaH4RdnnJhq2KXDbDcP5zkJB/enloe5UnhP8j+8V0
 zsNrWQli4oTqynAEuDipYjVVW2MKuKnR9WrqSCCIxod9G4ILR02grHItIj2j5NHfJjA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Mq4ZSEsB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Mq4ZSEsB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1868880ABB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 11:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793101197; x=1824637197;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uDfztM7O6YjNTZfhFfNM/Dtmeob56jo3h+wl2JCM9c8=;
 b=Mq4ZSEsB8EI1Owvn4gVE0lfQL+5tBzp9f4I1h17Br+Ekwh+NAFOb+g0n
 ZW2G5tdGWV7HlmRM1pjmDITnXJf1rwfXZyzDuYWRNFm2X+jBQo+FXkKWR
 YmMG346nOaSnHlTOURIwdp27rHvVX6xwrS1GljCITyUXybURMNput2rqE
 OXUJXQHGuOMhVj1li63AmmW+WyqH1ivYYLuPgqrNS/+jhLNU2VguoBakR
 DnW+Y+AsTUL9fLFpMK/8CZPrLP+EnQHafGrFniK2Df5YjJWmFeswFq3X1
 poUxn7xG/76KkVRYUApbvK5x/YVzP7oynxQLaXemZRhHx9JH/v3h3ytlc A==;
X-CSE-ConnectionGUID: EtcKNtTMRwiO1o39dJBpBw==
X-CSE-MsgGUID: Nx7FyhijSuCTJCMlmk1UkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1811348"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1811348"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 04:39:55 -0700
X-CSE-ConnectionGUID: XxyZkARLTSuRLQfZRsXCig==
X-CSE-MsgGUID: lfyig0F+QKaQtReux63Rvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4861546"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 04:39:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 04:39:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 04:39:54 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 04:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmZPtiWmOGLshaUQxeXPbgQIToB3m3NoH1EzRC8Dje7ntc+GI/B/roI8Sa+R2J6LtzRYmZ4uvxeiAu78vp0ofzoK5ad0sGo59t8B9GOd9Jz0A7WYwUyds4lip/+N9GABuGa0hgXdNwCjFvlxUr1/esi32hFNSZysJtDAfCLvdLjhXWa0xM1ApRAM3MbgKzPKq03zLEKQ0VNxY8J236FxcGy4bPnUxldBT6AtBiBVlzUxWlDQEexEJ/dnpJQ573JenGWnnaH0hoP1F/YC70AEuzt9elRb9Mr1zj41n8zZmV+rD/5GKaPzbRrccZN3hXQX0CO4AMnM0uZElhO5QVOiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BRqziuHrj6U+k5siVvQBLXkWKqBkmRTJ4qhLAfgzAE=;
 b=lVARaCQLFzA5AOaCorCNDuFeja70j2w89grYo9UZlEm5Xe398vgOoN2ZFUPhpeD89spi3inWXAXUjP6o8wvwINfXe1k9WTqt3s/s3Yy/3E+4NHoWnBK1O7G4x4deL5+C5e/k3Sdc0i+eEzz23Rcc8Qd7rvHwWyNfxsfXGam2TZN2FCFUVdilHbAOVRJeiI2SHp+/8A2f3gSLvyAFp8UjuA+kUPlUvQQsfNDJxj+3znEq2brtxQTc4DtMxPpLzv7nUKm+M8p+aEtqLl9Zo6XnMOZ4Qoe3m+VjsWH7mcG/DRwf7abspH1D9U+3x1Xn4T55P/j1rinPdD6c0Cz9PfHwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by PH7PR11MB6556.namprd11.prod.outlook.com (2603:10b6:510:1aa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:39:47 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 11:39:47 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next] ixgbevf: Warn when mailbox API negotiation fails
Thread-Topic: [PATCH net-next] ixgbevf: Warn when mailbox API negotiation fails
Thread-Index: AQHdWC8vlj/d819HwU64n5zpejvKtrcRX06w
Date: Tue, 27 Oct 2026 11:39:46 +0000
Message-ID: <IA3PR11MB8985A30AC65373E1C39BC7278F602@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20261009204346.11223-1-adiyenga@cisco.com>
In-Reply-To: <20261009204346.11223-1-adiyenga@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|PH7PR11MB6556:EE_
x-ms-office365-filtering-correlation-id: 506ba26a-ca6d-4086-b1e9-08df341f00ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261009223027099003|261021121427099003|261022075727099003|261022105027099003|261021135927099003|10067099003|56012099006|261026140227099003|18002099003|22082099003|261026121527099003|11063799006|38070700021;
x-microsoft-antispam-message-info: 2wdtVtx01UA9Yk4rKyKhCOGZTxXFkyTCqSlbv37Xep2Z6WVgtff76wusLyIa44vgJ/bIaXCnwtjfRmgHbrtvWu7xxVf/yu40XzFqowBJUutfHndVfGNNxHFQ0/qUwzi2tpnOnXN92PQJ8IwKAOCJblKivNx7b8feqPzEPtvz7Ok3ZdgeX7z7uL8lrJqOcZ6aFkeAvz+D2IYcjMlyAzPDn9vvVlkUYmdbN8/0xZNSsbkm4o3vqOpxOcp/85q2kErWVJfrdzzwEZkS3c3EfZ6CfrJFWELPTuJWMpjGHEPjze+bAaRS08LQ4h/wF/FD3oSLfO3webavggBOBwW1OYI9jNajcmlR3TRRXkg+wcfzrOr0BI5eF2Rdb2GUmCNoC3vXJIiL/aOfzuYO6mvSWKq9X2iX+phbNuWJqUrrM4GTz0sQg5zsTpK1Hvl+fkmwoGqDjQCpOwXNawBwT1DQGtk1wX5W/H/vQEE2qKHNHun6Dces8ru1N6sunp/+BKgj6FF7gaEaIn1Cs2hcuV3QxstMH7lgoroJzXw0Y75FO365JUK5XAlHpz9uE/enuo8hb0UHePrflnG/Q/gU+n4OYOLYDNDZI+hfahlPVE15ABjgBty9r0LTvluNhyKRiwv0D4t8h973OV7x5m2HLMenzepbUhjybYkPmbfFduy5t4rMrId8PXmKhyN9KFoPsXVYfIxX2ni2U7QmIjzaseTTl1pNWHHb5wFKZOu6sJBwwIkWZPY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261009223027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021135927099003)(10067099003)(56012099006)(261026140227099003)(18002099003)(22082099003)(261026121527099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7XRB/Rtl6XdKuW86MtgVCv4rhNgRyY+eAMNDU6oYfEyRNhVDxE4/auB8hs+k?=
 =?us-ascii?Q?67VvVWexfDfgRkNl1wnUs2qMtCwx3sRbEFzbIRgvnmRwOAAzmIaYY9PX2ZLZ?=
 =?us-ascii?Q?VL5i6Yqg3ROfxPp2OTX+wf/qfFKEh03/F5nZLsdwJx3gjI4QZeNCqRkylHwo?=
 =?us-ascii?Q?HAARpjRwNmkONBBdCAHCn0On9tjf7im8F0TfRxXz3v/Dez/aKdpHQo5sPQBX?=
 =?us-ascii?Q?UpjzDm2fNtuYteVAiI6+Sw1fljYhjOv2G54ZyI/XJlqk3qtAxzNE43ukXLc1?=
 =?us-ascii?Q?7+juyPWwl22JCn5305oBx+fV0swGZK1YEp4qadqPEAkzvaGx1tDZASq5z/uY?=
 =?us-ascii?Q?qnJjtf2KmJ+uuH18otrBUG+kfQhg0qvjoriVHOCbWv+Un8R0AcpPK+K6lt6P?=
 =?us-ascii?Q?YqbEsY4UEzi83r1fK8fhqZEWLxVmw08z21LILx5hVFwTLA1frK+kAnYlQDOv?=
 =?us-ascii?Q?5SJGfi++dBLMbIvd4yRSIgKTTgtSh9tzdNPpXcCSNaPqhZdu9RH9XstBCsr2?=
 =?us-ascii?Q?1jw74Gg7hhHC7k8gIUXbwhyLtCQmlTz74Uh6JYaUPLlEz5cexVanPDx5gv52?=
 =?us-ascii?Q?ISTuAVViqlWmA4oIRQV037OtSplY3Yag1SAW7zI+RsfonK7h9+f+ytYuxOwH?=
 =?us-ascii?Q?0SZRIS5NqWulHf2rc/rfC5OzElZWcUF9Z+W49O9EYiPrOQfbK3+yP0jd5FuH?=
 =?us-ascii?Q?KAAbTKWUo/j2ycOX/vsZqlGfArYiVHOIIsZfv/zVrp+agrf4RHYaHttfjWdr?=
 =?us-ascii?Q?qq5bGYP9nkjhn4lv5aFk5CBGt4PMrMprGoq2hv9TOD8wCm8GcXEQAvlMCaa4?=
 =?us-ascii?Q?UbGu5fOZSoyZ1GRNKRthNcoOyOzRb0Y/bYTO0kDNd9lInIZenEEH8Bdvdxrc?=
 =?us-ascii?Q?dODPSvJNAHTLQV2gK9O1ut8Nx+a/rgWASsKot7Kk5IYWD1pYRzX0JvLTrdrB?=
 =?us-ascii?Q?MJj/ZhGlIdv5SnZteOi0y4E44oqvdB0vLkl3XFN2ypCA6+uncC1T8NKiYzrM?=
 =?us-ascii?Q?t1kQDIMq8g8gEiffiHvuBzwjugLz72Wt+E+TLILfFJXktEFp+qi840syVWWn?=
 =?us-ascii?Q?1TkKFsLhT0AiZkcDOBT3QJM7PZDmtBMiQ/txEVLzWES2zIwf1minLC7oLvU8?=
 =?us-ascii?Q?BpjdDF9HQGLOfQcVfHwjjGmRkJ5SGtvzQoAfBWCe0aE6hHcR6Dc9CzmEWeY+?=
 =?us-ascii?Q?4S01eXm6xFlSfKQFWk7XkDW/cw056s+W8CKRa8jSEt2Eh7tM1aEd36dmL/4H?=
 =?us-ascii?Q?PBQBab4LCpE+SURqoV0WOcuo45uTMgYWeFiVbxj31T+RPnXRE9ZmauiYWzWb?=
 =?us-ascii?Q?Y0C16zXt7nr4Zw37X/UnIH7EoRa6T5CvKrYGTwrh7+eLyl9NlBiqbHImgkZi?=
 =?us-ascii?Q?0LNhQH5bqtsakO7Iv4OIOM4TmsOO+Z6rXBreMgEZirRG7Xeau86YWfkKCSJm?=
 =?us-ascii?Q?gsbOv4tlhzQDWjkZgR79FSkh2GMDjuO8wu+kSMSkijFpvGjuezC+wEkcgTsE?=
 =?us-ascii?Q?boqHnes0UxYRY9yxVi0CFQ2K8bzSKUXuUk1iP5RDgOZIaqQ4/0/Wna032alO?=
 =?us-ascii?Q?PT46SxglG70rFzORWMNP3zr/7T8T4i6dYTGk1b6gpKbKobtsN58PlcwPTl/M?=
 =?us-ascii?Q?W+vFuB309h4qMYlpjMCzZ+fbFCLY513/e1K7dyigQ/HbAbY17Qm2KTGqoz2M?=
 =?us-ascii?Q?GGMQTJb0z4VtG11pCqJqQwKwaU9u0GYmVj1uT2pXjzO6JLPqVfC0rCx4z2Hw?=
 =?us-ascii?Q?QSLtLaB3oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZmcAZ3u+yVNNJb/BjhONM6zm67fY/Zgl7UNtP2ODJ+IOFzn04vrtEZs6DPk58wI0Gp4mCXmLXyX7y7MxoMk4xIDSTzPuZ1E7msyfJg8vXzxhd0ziW7gwZ2BlHxvh6V4lQEVr2QSkdy26frQt/8mLY/YAMqJrxKdTCZrFZxmrQKpNkF1+4Bz+0mxFc5GQswykO6vB4gHDTqtSSVSgwGGEAnVP7EczhPfEWPVc/oZRaZ/ptnEmwFPUZv5kCvOGGHEABBcSCh5G+lOWax7xTLF1MZGP5eLuaY1XJisczUke/VwYX7i6TKvMeaCV34GqyXNz7+KrK2Z2mA+GVG85dZ2MAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506ba26a-ca6d-4086-b1e9-08df341f00ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 11:39:46.9565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JllLuyHmSzzi5xGvj5VPlmQDbIgkLylCRYS4H+9qUk2NrfOIOEv8sJsNqrHCFgr1Y9OyUf28uje5SWNh2MhIBZufSvle94KtYL46B4EPad4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6556
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
> Sent: Friday, October 9, 2026 10:44 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; netdev@vger.kernel.org; adiyenga@cisco.co=
m
> Subject: [PATCH net-next] ixgbevf: Warn when mailbox API negotiation fail=
s
>=20
> ixgbevf_negotiate_api() tries supported mailbox API versions from newest =
to
> oldest. If all attempts fail, it continues without reporting the failure,=
 leaving the
> API version at its reset default. This makes mailbox communication failur=
es
> difficult to diagnose.
>=20
> Warn when the version list is exhausted and include the error from the fi=
nal
> attempt. Do not warn about individual failed attempts, since a PF rejecti=
ng a
> newer version before accepting an older one is expected.
>=20
> This is a diagnostic improvement only; negotiation, fallback and recovery=
 behavior
> remain unchanged.
>=20
> This is a diagnostic improvement only.
>=20
> Signed-off-by: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 7ce46b4b4821..76c9ac3ac69a 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -2344,6 +2344,10 @@ static void ixgbevf_negotiate_api(struct
> ixgbevf_adapter *adapter)
>  		idx++;
>  	}
>=20
> +	if (api[idx] =3D=3D ixgbe_mbox_api_unknown)
> +		netdev_warn(adapter->netdev,
> +			    "Mailbox API negotiation with PF failed: %d\n", err);
> +
>  	ixgbevf_set_features(adapter);
>=20
>  	if (adapter->pf_features & IXGBEVF_PF_SUP_ESX_MBX) {
> --
> 2.35.6

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

