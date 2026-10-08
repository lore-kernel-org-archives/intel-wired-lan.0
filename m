Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44F2CA600C
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 11:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77FD781232;
	Thu,  8 Oct 2026 11:40:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TwEVlIMDvrv6; Thu,  8 Oct 2026 11:40:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8211B811D4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791459657;
	b=k1l5i+R9qblML9Jkv1L6Ko+pk18SjWXpGCYWRcjbt+WBraWTzXIY9L/esjkFNxUJGUka
	 lnI2w8dxIOBkaaBs9Z9JGyoXPSgprfwPoX4b1oMVN1/pVOhrd1HoetsuMbsvZaiKom1ur
	 IoNVf/FhhVfJrtUlWA0cvvODN58SajHy6k8aAbPsFRaAT8YnjQnNQ+q31fNCK0gwQkLPv
	 6reejAStX+Gk9hjgnCw82XL8ZlQ/e7HRVnIcX4oJrfks90vNSPDksLGGKpEz2CeSTCjCW
	 N1N62vWy7ExC4lElYaRxJOWsBFOzig6wtHTY0ceeKH0e8fI542BR9JtG7/JFBXvj0Tg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791459657;
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
	bh=eomsP7sNOzgpfSb/Bf2MqBqaKaBANho+gTtC1jl7dcA=;
	b=sE7BSLXA2/n12uEg7awrVZIbTKD2nIYKMCOR65tabwBFlRMz2opLDlop7HuclcpRurF2
	 u56QotiOvXPhnTHkK7TuSE+B+pj7FoQqgZrJ2GUFSSQp79xaBOsm+i+ovdTsDYa3Ot3DE
	 I2zJ0XKesfLM/mi41xtQ2bwPVjxe9lJ+T/TcuZU15KMEFl6c/n7nBEYm64+cn9QCw1PKi
	 u012SfJ+BGEoShegJDzHlyAcX2HtMhSoy0as3W33a2vMJuEoC3KqagTtHJgN9Sb3dNh/r
	 LdptkAex0mLpHqheOzPmBurlWKSyrK9BnRomiN0Krgy7xmq+8VdVmdTromGHEJsR3+g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791459657;
	bh=eomsP7sNOzgpfSb/Bf2MqBqaKaBANho+gTtC1jl7dcA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W9LDh3YL/hquWA0BkCnik5JSUbV79I6VCKFYUONLvftYXoGFBX7SRRxWvzb4yLziM
	 j7U0MS3O5QAIvkIHyn98EyHCLsYjxnMaRiPbVym/aRU/zjwMMmgG2kCoqi62FOVqzn
	 kmZ4S/H7rvQQWsPop645k+JqZDEdnaWphS69V7G8NMculMUr1xMfN6QrGXfCOHNH32
	 kGZ3SsYIxDsl4nhngb8vruSdpomywcHVyFzAclkXjc/HeB25/7BeJ3IqII+kNA3KiA
	 BU5pfHYUEUYA0QAVg6xzsB4npXApGSS+8YWRmZxs9ZcZpiTIhPJ3WwsLJZBcb8Bxro
	 3Za2FRdZlwlXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8211B811D4;
	Thu,  8 Oct 2026 11:40:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7023F338
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 11:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5364340456
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 11:40:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SPu5nKFFftxN for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 11:40:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C220340427
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791459655;
 b=qeP3JTJ5I57x1+DdmzzonvsahZx2aDNEB2gkXiFXBHQwv2z0L7+AjvFkgjFZEcD8OKo5
 /VB1en3SgByo4QaAa9JKDnEf1Wxd59MLyomtQ6iN2tnNO3dIJUr5WycVa3CMccfC7oC1d
 jn8ajwf4RBA5ZRcqbhiyQc8OYVSIlcWIcnQan5MKjL6qqXbPRGgPy9f+zovw6YV9Is/kf
 OGyNqD0IcNXJYFbxXcUt8Ny1vrWum0P76Hzufcw/occ/dKGNaEPpKy6FRrFjMUKTuyfqc
 dNHkRJQjiVL3DJjzIcZTK1DIxjyxn1fWyoBgLG8Ze1ImXtHM6Ti+b8riNhziQ/EVbAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791459655;
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
 bh=eomsP7sNOzgpfSb/Bf2MqBqaKaBANho+gTtC1jl7dcA=;
 b=KEHWezoj1WFoUJbVzhE73UgZWdN2tOoEDdENOSLXwp0amMqGR4yx1i4bpnsMDFaok9Fr
 owo73xipA/cqo4QQ/gRjE56181QlFoI37Qzp8GnggvqRvIe0N76cnzdSGf/u+59oyswZg
 H4dfBHfmlxDrJL8JNAD/gjxy6siL+1Fe9184WF2TPgOzuOI+N45W4U8aW2ebcCvxHC9I/
 xWPZ1qFYHei0zszsQu2hMwUNpK/xAv1gRf/TcYmyjNfuFghDLDVC0tViQswIq86xHcv8h
 Oi0ZXr1fWP9qmtitKTEXON/3QCKHAHA2HtGFqTGBvNxduTehJb6e19U13bIfgIUGGcA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=G5Q1aviv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=piotr.kwapulinski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=G5Q1aviv
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C220340427
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791459655; x=1822995655;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yi+bahb5cvkVhjFhBcrU0NN47xz+lJjEJBA6ngUI3VI=;
 b=G5Q1avivoe6pM/pNX5sxgQ2mmxfjvk2iRMw+tgk9z2KrzqHGM0Ljl2oF
 +5hnJoMzA3Yvi+u2xepzcXJswGD6Bs76F6iYxvTRiym5mY6f1jdpNmufj
 R2TNVCKJmmcKr2XD+SvSxFObFgoA2B+osOtpNvaDE1Oo9b3phQ3gyfxHW
 yT2FGBpfmgRXQJiTuM4M6q+yWBis946EsFyaWl1iI92DAxbc4BI0XHUVx
 QCDb3X59kLE6u02NnPfbFynYh/ZRT5U6tr3vNVZq58LU44JkXniklJ4ih
 se9hEX2aOSHkj3bmJCStLpi8CqUg2LzMiHYGwZKFpSXZEJMkdXCXFoisx A==;
X-CSE-ConnectionGUID: X1NW7boxSI+X7EfOaGurgg==
X-CSE-MsgGUID: VUixcWpwSjixdZJDCfcf+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="237687"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="237687"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 04:40:53 -0700
X-CSE-ConnectionGUID: RBCF1PuLS6idJWY7V49slw==
X-CSE-MsgGUID: RCzDnYFqS6eBiVLBmcsY2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="136088"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 04:40:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 04:40:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 04:40:52 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 04:40:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxwlpfSqJr/V3WgIFTFf57ViMk4NaXUos7Is0Sa1L7CI4ZkeRqjGubwaBTWCuOV1GAA3fp8JOmQV4moqlqmQ6rTFSMnhl++nStj6axXUfLYpuCzFR6+8Zmu62lDggsYzN8LwYGzk0IqBJFIlBitj6k+rAKyAFPDMiao19i2YG+gsnOoH8k6V0wHx21Yi504mgqJzHIDRXiZXFq8h721LW3OGr8M5+aDAVYMakXgbtvgKZ0SXcUy2M03jD3nSspXWyNUUh46iqWI5WKGOMgrQSvTC8H12e3UnPZQPtQ1aWVeonSQYAEmgRkw0IF58IjEDijNUrQ9qKPpbTitisKI6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eomsP7sNOzgpfSb/Bf2MqBqaKaBANho+gTtC1jl7dcA=;
 b=tWR4tSrlKL7ohsM/VuYd3UNfHgv/VqIN737SGVtIcaiExoRp+sSHcg+iLvRr7SH4cu3Cd1OfM5Rw9C3UZkDyFQO0ZXu7NRZkcBoly/H38wMjxN0pUxqzSiVGgC6rUB+TJ+UtkENIIlIo6hVU607yEew1H7+jCmIUE+KYiiIy/0aJ6vbQDgcaKk6oI5wEQQLz8Dmw6DvYtsohMFOYuiLPwlOKy6NoJum5pfFb5AtGnc2FF3XEqhpfrylGz4FBmZyeV1MGMbqlQltHkkzgLAY8I7WUx5/OV3AQF3ARqnyVykwAtNlAH58k7FNEpvyf/SYCXtXHDp811oeZAVUUPkIFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFA424F92C2.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::41) by MW4PR11MB5909.namprd11.prod.outlook.com
 (2603:10b6:303:168::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 11:40:23 +0000
Received: from DS4PPFA424F92C2.namprd11.prod.outlook.com
 ([fe80::760a:25b:30eb:6d7c]) by DS4PPFA424F92C2.namprd11.prod.outlook.com
 ([fe80::760a:25b:30eb:6d7c%8]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 11:40:23 +0000
From: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>
Subject: RE: [Intel-wired-lan] [PATCH 2/2 net-next, v2] i40e: add devlink
 parameter for Flow Director ATR sample rate
Thread-Topic: [Intel-wired-lan] [PATCH 2/2 net-next, v2] i40e: add devlink
 parameter for Flow Director ATR sample rate
Thread-Index: AQHdAX2CY1rk5SbAWEqbDrU6DiSbI7b0MA5g
Date: Thu, 8 Oct 2026 11:40:22 +0000
Message-ID: <DS4PPFA424F92C2A514E86DEFCC7C5A5BFDF3932@DS4PPFA424F92C2.namprd11.prod.outlook.com>
References: <20260621125644.253844-1-mheib@redhat.com>
 <20260621125644.253844-2-mheib@redhat.com>
In-Reply-To: <20260621125644.253844-2-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFA424F92C2:EE_|MW4PR11MB5909:EE_
x-ms-office365-filtering-correlation-id: da9517f5-35ab-4683-352b-08df2530f03c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|38070700021|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: A1w0CmKs3H1LlUhl6lDvhXV22D/sOXJGOqsAfsg9VQkz2PLz618oE2i9aHEswJ/iET0nFvCXQdV+CqHpDrwyYIfXuXXPBYULGdufGYqwMqXKiB3rSFvCcIOhUuUTGzScFZtZAhJ5pArwBHZ6UB212vmJh5KXHlaTnfD00feA3pcWjBED+qAPXtDGPpOIOfuvGflKJhnnRBc2h/4TQzxIp35cjIX5cYCHonz4pN7tzTfkVDBNlHPIBMum6bhCupXQCGfmAGWiPCf4iZBh0U84NfPblWwQU6OzBUXS/Qdhd1kbmpxfZ6Va5/V8FoeGNmKZxF/xKDXs7pIpNse0CTHBsqRFyIdXM/FrIHosZ84bPvybCQq7jOfPCF/clF0OITxp7daCqW2HoXD6X3swBlKmJKH97LSuc8doipyBR8ocd/NH9dTYuph8O9R/CQZrDuvEhMsiEx7clitm5HHWBxpsAAO09BQICQbzwIYYnSWoCgU3LclYLtSbsRLOgnH/drSOL8Q2M4Kefa1vJpS+0Bx7wr2EQKB4lShtuuOsKcX9wEx5XWEEbYia0JcCpo5Iol1EaAhjoS2CajYyvq5O7gIX1FCAHt1MdrxaIQ9kO3XzzifvaUyBPDEbmdqkOap+06lYg55+kCdHPyFL/zjAa06PWqUQkVhBB2PJ5f6A1gyC3gmOxy8DKTl4jsls8K/V9a5GzPQXZlu7lJ+EMaqPdNZXJYL3rR/xTa43uWN1lhmmrJk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFA424F92C2.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GoGa8wCJUkmb2xaRTD3A0sNRGpejdJS5xGy4j6+z0dMxyLmHpo6uzIRV+/rE?=
 =?us-ascii?Q?K9w5xw7uLRQ9xn+VPnrMkEOy7VOKTpZMehFbXbnDeUtG0R2VOwcjF/g7QA6l?=
 =?us-ascii?Q?H5ljKvbnNEUJg19UsB2EVn+JcOClst3CLDrGUKx1OQERtTOY1bjadOM5uR//?=
 =?us-ascii?Q?nCEC7YBwmdmeFDx9RFdjEifvCGmMbQCU1faG/B8Lugy0rr9LWUmx7Vqklt1N?=
 =?us-ascii?Q?HFzVbQIG2MQ83td511trb3nuYHWlMyqVX/TLUvEzC/rm+zML0SR105sf7nW6?=
 =?us-ascii?Q?lrCcO9HBHps76pijCBSYnPu0aYCVourXKg0+BsSNVnmvB57CECFfAlEtZOyS?=
 =?us-ascii?Q?S+2UiLxOZGZjhv8FboytbbHWmarp+fBq4MC2jqx7QeDVDhjfaxURzTz1+onL?=
 =?us-ascii?Q?UE4TueHsEE9OIbgGdTg92E/SD0jR6WgYcqVMeIZsLuolmfsg18sRpPpP2Vq8?=
 =?us-ascii?Q?cIZuahrIYOv4TGL9QYu+fqdU6JkPnWeVpQRrjbAGp0JFcsegH5G+4tFKmqAY?=
 =?us-ascii?Q?Sz8x+Z5G2V2iA2PABCFiZk0CDxKSenzchDZv/Fjtme0GXMwKkvPj/I5w3jvY?=
 =?us-ascii?Q?FRvpyotbRMv+9iwYam6VgG/RAqmIKuGFDaXVxq1slNTNdRvQ8qgaAWeRJlkh?=
 =?us-ascii?Q?w64tNa2ps72z0tOVPqzXmuU70JdDhkbqstbakanTcTLoK0BLE6Q+C9mLeDMr?=
 =?us-ascii?Q?Hs4YaoCnQ/cAT4ahH6DyFLdTAb5ooW3sIvc7Z/K8zuQOxRAvdWeT4+4/fNCo?=
 =?us-ascii?Q?pxPjHFXnC/ObfMKFN7Wqgjs9RrEiuTWufNr1a2hlA9cL4vE0cntCLfBCsZHg?=
 =?us-ascii?Q?lynLBVzaa3PI1bb7RpRulvJ9Wjff5F1SNgb203FhdomV2utqQVW7bfgXRpxt?=
 =?us-ascii?Q?EKWyAUITmGFcj3Qyx/oJWqGApBZVTjFiTn7AS8LGLBHZkM0x5DGKAuDqDn1r?=
 =?us-ascii?Q?QvCFEn+ghMUyXmo5Z1T+FWBKgHOde1jiOInR6xV1mfOEjTgzZoVG6so8UWcr?=
 =?us-ascii?Q?5WaD5Jzc5Ydl5AVS1Xjdxy/6yRDKNIMViv5MP9Z4QfwI4yTWxwL/YWFk2yLp?=
 =?us-ascii?Q?anMB14YiUTRO0X7Yaitlu7OXWDJTqq0lhN23TutxeEJz29mKnpGz03PwwOOH?=
 =?us-ascii?Q?4cTWkso5kYHiiHnYJp99qs1gb5bNy4qnXR0bGmWstCfKJINDLxOmBFme1h92?=
 =?us-ascii?Q?hKnMTTguSNsbpxzgNQzyLZnOXPlCy2ZCCrcU0cQ5Asy8DBfnNxgKWhT41f9a?=
 =?us-ascii?Q?GxT/P1Jo58psle8YKYBMMXxif/DC1P97xazSfm7gIFxdN/STcvhsMQ+/cFnY?=
 =?us-ascii?Q?E8Mq7Yjonp1dV22crEmmvShoZU5/6Oz1HECsdwI4cDvDYk9CYd1K3JAv6ZRx?=
 =?us-ascii?Q?+dD6uLsQsmE8J0xqwOwFGuZhu1oG3qdoXLi/raPddZk3bbYL4J3doezCEVao?=
 =?us-ascii?Q?6Re2247Xutv6S+dydEGC7cwo3KK06Mox4QcF4OBbgfNa7goGH2FSm3abZQbC?=
 =?us-ascii?Q?+EuQLus8qU3F5VM62QrMlV5conhOcYA6SZja59TyiyEd/QbMhymGaPRFWuuk?=
 =?us-ascii?Q?eGB4YPyWAz8kYjD05fhLr+EpJyJtTpBEYdf/8A+g7IkJyHjwxCEN0TzVyUpb?=
 =?us-ascii?Q?ewjk7g9Cah/48ZTtyXKdBhlvisMIr2t8kEPBT/lz7evUG/yJdEK3cYiQAcXi?=
 =?us-ascii?Q?dmakmlBU5w5ODjI0kuPxI2xmuC6uqkbdkhU1faDvBy3gWuWWjaG9MY5NRB2/?=
 =?us-ascii?Q?xjD0Og52NA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nqHgJoTi6g/RnRgFtOR/KxSRtHaXUKXKnMHLc6IHkmiHgWFJy7flKYEEhAY2/WLKF17PWKTXn8bftDsTLxN2iljqMNiumPZ5yxzkLbPlWUgtbCOLgFVieNjSiXk/54Lr60tvwb8yqRIQ++zL20Z6W2YFuE4Gby938WilGhJEQtNHS7b84i9JnQSMKFVgZ2QZr0HUJAywbuC0QAw1F6eoVryYUOg80zagcb3SGmgT7TIZhI/VObMs9oV0f1aWKUem0bbZKneNL0VUfaorZ0iCnIzTRweV2yrks/t+iyk+A6LohlHe4xM8/ruDOmwpfy9tXlxYTMSDeC74eWNTzO2s/A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFA424F92C2.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9517f5-35ab-4683-352b-08df2530f03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 11:40:22.8912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /l6J6On0CTt3xWh+e9tbJ/X8ktpXSEm5Bpy9clKpNduXSjtXfesESPhvdKhVfJKCSvOb7wu3fcGNqIm1Jisw+y8b0HBTLiZ6yD974FfLjjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5909
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

>>-----Original Message-----
>>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
iayuan Chen
>>Sent: Friday, June 26, 2026 10:39 AM
>>To: netdev@vger.kernel.org
>>Cc: Jiayuan Chen <jiayuan.chen@linux.dev>; Nguyen, Anthony L <anthony.l.n=
guyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andre=
w Lunn <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric=
 Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abe=
ni <pabeni@redhat.com>; Jeff Garzik <jgarzik@redhat.com>; Bruce Allan <bruc=
e.w.allan@intel.com>; intel-wired-lan@lists.osuosl.org; linux-kernel@vger.k=
ernel.org
>>Subject: [Intel-wired-lan] [PATCH net] e1000e: fix IRQ leak when request_=
irq() fails in e1000_request_msix()
>>
>>An internal syzbot instance reported the warning below.
>>
>>comedi (comedi_parport) lets userspace request_irq() an arbitrary IRQ num=
ber and can thus grab one of e1000e's MSI-X vectors. When
>>e1000_request_msix() then fails partway through, it returned without free=
ing the vectors it had already requested; pci_disable_msix() later tears th=
ose descriptors down while their irqaction is still attached, leaking the /=
proc/irq entry.
>>
>>Free the already requested IRQs on the error path.
>>
>>genirq: Flags mismatch irq 28. 00200000 (eth1-tx-0) vs. 00200000 (comedi_=
parport)
>>
>>remove_proc_entry: removing non-empty directory 'irq/27', leaking at leas=
t 'eth1-rx-0'
>>WARNING: fs/proc/generic.c:742 at remove_proc_entry+0x436/0x560, CPU#3: i=
p/445 Modules linked in:
>>CPU: 3 UID: 0 PID: 445 Comm: ip Not tainted 7.1.0+ #284 PREEMPT
>>RIP: 0010:remove_proc_entry (fs/proc/generic.c:742 (discriminator 4))
>>PKRU: 55555554
>>Call Trace:
>><TASK>
>>unregister_irq_proc (kernel/irq/proc.c:406) free_desc (kernel/irq/irqdesc=
.c:482) irq_free_descs (kernel/irq/irqdesc.c:874 kernel/irq/irqdesc.c:865) =
irq_domain_free_irqs (kernel/irq/irqdomain.c:1917)
>>msi_domain_free_locked.part.0 (kernel/irq/msi.c:1619 kernel/irq/msi.c:164=
5) msi_domain_free_irqs_all_locked (kernel/irq/msi.c:1632) pci_msi_teardown=
_msi_irqs (drivers/pci/msi/irqdomain.c:28) pci_free_msi_irqs (drivers/pci/m=
si/msi.c:925) pci_disable_msix (drivers/pci/msi/api.c:200 drivers/pci/msi/a=
pi.c:193) e1000_request_irq (drivers/net/ethernet/intel/e1000e/netdev.c:202=
8)
>>e1000e_open (drivers/net/ethernet/intel/e1000e/netdev.c:4681)
>>__dev_open (net/core/dev.c:1702)
>>netif_change_flags (net/core/dev.c:9806)
>>do_setlink.isra.0 (net/core/rtnetlink.c:3207 (discriminator 1)) rtnetlink=
_rcv_msg (net/core/rtnetlink.c:7068) netlink_rcv_skb (net/netlink/af_netlin=
k.c:2556)
>>
>>Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
>>Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>Assisted-by: Claude:claude-opus-4-8
>>---
>> drivers/net/ethernet/intel/e1000e/netdev.c | 13 +++++++++----
>> 1 file changed, 9 insertions(+), 4 deletions(-)
>>
>>diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/eth=
ernet/intel/e1000e/netdev.c
>>index 808e5cddd6a9..19b9823c5679 100644
>>--- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>@@ -2099,7 +2099,7 @@ void e1000e_set_interrupt_capability(struct e1000_a=
dapter *adapter)  static int e1000_request_msix(struct e1000_adapter *adapt=
er)  {
>> 	struct net_device *netdev =3D adapter->netdev;
>>-	int err =3D 0, vector =3D 0;
>>+	int err =3D 0, vector =3D 0, i;
>Thank you for the patch.
>I'd suggest to declare 'i' right in the loop, besides:
>Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
>
>>=20
>> 	if (strlen(netdev->name) < (IFNAMSIZ - 5))
>> 		snprintf(adapter->rx_ring->name,
>>@@ -2111,7 +2111,7 @@ static int e1000_request_msix(struct e1000_adapter =
*adapter)
>> 			  e1000_intr_msix_rx, 0, adapter->rx_ring->name,
>> 			  netdev);
>> 	if (err)
>>-		return err;
>>+		goto err_free;
>> 	adapter->rx_ring->itr_register =3D adapter->hw.hw_addr +
>> 	    E1000_EITR_82574(vector);
>> 	adapter->rx_ring->itr_val =3D adapter->itr; @@ -2127,7 +2127,7 @@ stati=
c int e1000_request_msix(struct e1000_adapter *adapter)
>> 			  e1000_intr_msix_tx, 0, adapter->tx_ring->name,
>> 			  netdev);
>> 	if (err)
>>-		return err;
>>+		goto err_free;
>> 	adapter->tx_ring->itr_register =3D adapter->hw.hw_addr +
>> 	    E1000_EITR_82574(vector);
>> 	adapter->tx_ring->itr_val =3D adapter->itr; @@ -2136,11 +2136,16 @@ sta=
tic int e1000_request_msix(struct e1000_adapter *adapter)
>> 	err =3D request_irq(adapter->msix_entries[vector].vector,
>> 			  e1000_msix_other, 0, netdev->name, netdev);
>> 	if (err)
>>-		return err;
>>+		goto err_free;
>>=20
>> 	e1000_configure_msix(adapter);
>>=20
>> 	return 0;
>>+
>>+err_free:
>>+	for (i =3D vector - 1; i >=3D 0; i--)
>>+		free_irq(adapter->msix_entries[i].vector, netdev);
>>+	return err;
>> }
>>=20
>> /**
>>--
>>2.43.0

Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
