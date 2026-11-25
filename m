Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6910606BF44
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=DsIuMIoB;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U8L9kAIu;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BTBhmrgA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B140060687;
	Wed, 25 Nov 2026 15:42:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vb74bP6LfMB0; Wed, 25 Nov 2026 15:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C573A60725
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795621362;
	b=RUCHrsCd32phLpF4xILDbuOE348LMv/LY9+IypU88pkM2YMorVOkZY7J8ryDRSvxOo42
	 42pxuCagzJ/+IMyABPjPbVxdVqPYfw/aU+CjfUDGBzJCWsi0eNj8aZEADOznBq23y3oW/
	 FjoFWa9WA7izJVqWK/O8QXp+Uwkw+Z1Egmoj9mmW3DaAstNhhwWRYlB2EkkmHb3dvKtux
	 +jlJeuYDntI2d/BKHGyixDQZATx2dW5foAqH8S6Hp8eXiywAUR6GwtY14ZCy+S/+OYHb5
	 1cHzNbnQuHEP9bVq5HDnrq4d/xtw0yYZoqgQqHCh9m08IBIiY7Rvd1K3U/T4jYDNqNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795621362;
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
	bh=sn3kcJh4xq8WLRXwgAefnSZyzIR9CxOdqzLQPXcIKC4=;
	b=bYs1d4QLDoe9iG4BtJlkzKgnhmMqGh2JoqGLJ3Y7NfkBoMWvqnzODGiLYFaZhCtwpKYr
	 u/PF2Y5mcT1C0aj4gDnZ9csCUCwiyRJiXJtt7ThLkTWJ3VTazrpDrYjX9vrRRkwLnmfrS
	 nQ1uDAPXp0xIVDMgV90ppKGFHorYK0oEuRj2WxpJ8lM3WoKRaLA7aSZWwvoX3d4UEmSaa
	 bfUToU6dNaUTAFemGx2WOxQNfGvysDv6gUPivi48hYl6ZpnSLmcc0YuVs3R5C9JKzJBko
	 J1HFhL2K+wrBl7X779ma7OYvppmChS8zL55dVqNNaHxYFLauEoefq/ohhzE3tSoGl6g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795621362;
	bh=sn3kcJh4xq8WLRXwgAefnSZyzIR9CxOdqzLQPXcIKC4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DsIuMIoBfcqtSqjPXutT+EKX2aUg65uZ0+/FCYR7eChljA8CLs9i8yI73aUXuLuJN
	 PFUNO+ypKKw/hMrnYo48QfQNrx2QeHqp1ZNlE5VmcjR2vqHEvN9qO721m1jsFQ+BIz
	 DRiMUK1mGxN12mQ0D8+5rLlCS50Wd8vYhbm2P770+PBQRjZuXEHlqBIiIp4UqtOw0u
	 lXW7wQXMgWu7IxKS4yaw/5mceZ4K/QL8NAaFqExtnSw2Rs1RidAfKXwuA/dkcaJi4d
	 /Ch9t7c4SV8RhbPlNUCSXmyFnxh/ELXqlt/dMC4gUXeqvbPV/+jagnGntiwHDeFX3Z
	 CweZWnUP2i7jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C573A60725;
	Wed, 25 Nov 2026 15:42:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 411A643
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 15:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F52840588
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 15:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uxb0nldYLqkA for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 15:42:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D88234055A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=arkadiusz.kubalewski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=U8L9kAIu; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=BTBhmrgA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D88234055A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795621360; x=1827157360;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sn3kcJh4xq8WLRXwgAefnSZyzIR9CxOdqzLQPXcIKC4=;
 b=U8L9kAIuTN7yc41l/3urjib/KdLHb2bpktXRbgC+CumOGsRO+oLW6sJ1
 UEP1RRLSVZWmpszqVNw646Wi0j9WsZERmKZIJOF/vRkc7H+844L4QJP02
 qqNFwod2dIf5qDPKKtxcBvOAsRfMaCWphkOFyQhhggQghkwHnhqrbHcqm
 k0NxLqAGx8R4rpyb6GPuwGgjkM6ZZkrsSlJXf620nIsOblnxGRBBL7QJK
 m5EwgaJGIbCGlaLYBq9DWNVurliyYi9mNIo/aoXRaJpRfz+q59BD7GBn3
 bLYGCZwnQEJyWf+txdCpJhNfrcn2EpfP7gLAYSO5425CkuFITvunlnobm Q==;
X-CSE-ConnectionGUID: LYGUITwOQpCyDuKEcGFRbA==
X-CSE-MsgGUID: wLAuj95aT6qqw7h7pLWD7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4419877"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4419877"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 07:36:43 -0800
X-CSE-ConnectionGUID: KiZO4WwWQJOkVTWG57HUig==
X-CSE-MsgGUID: +FQoeS1yTK+Lj0j0twVEGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="11705780"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 07:36:42 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 07:36:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 07:36:41 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 07:36:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn3kcJh4xq8WLRXwgAefnSZyzIR9CxOdqzLQPXcIKC4=;
 b=BTBhmrgACxYp/JVeU9BvMutZbHN7VeTuLv263bFtSr+DyaJb7qLWMn5E6bwqYIQW8OOYXojdrfzwr5fNzrUVv6F6hWH28WZBlhOpBkwqiEVnRZRhOwmyjIhQ0RtJRPOdwTKeI9U5ogkvrhnIA2DgzsIb292+bpmkfsS4Ibz9gmA=
Received: from MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22)
 by SA9PR11MB772229.namprd11.prod.outlook.com (2603:10b6:806:a6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 15:36:37 +0000
Received: from MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::924e:9c6d:73ec:27f2]) by MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::924e:9c6d:73ec:27f2%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 15:36:37 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, Karol Kolacinski
 <karol.kolacinski@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, "Oros, Petr" <poros@redhat.com>
Subject: RE: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
Thread-Topic: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
Thread-Index: AQHdcftsjeqnHCNYXUaGas67mVSOY7cxj0QAgAJv8oCAAKvVAIAAtCaAgAmgHCA=
Date: Wed, 25 Nov 2026 15:36:37 +0000
Message-ID: <MW4PR11MB6984FD51283AEF4F2B8E27E39B432@MW4PR11MB6984.namprd11.prod.outlook.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
 <20261116181612.107a4b57@kernel.org>
 <fe1dcdd5-ef75-4231-bf9f-03bf8536c2aa@redhat.com>
 <20261118174424.32e9f130@kernel.org>
 <dd1d61d7-7bef-4a02-8518-e17d2f50369f@redhat.com>
In-Reply-To: <dd1d61d7-7bef-4a02-8518-e17d2f50369f@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6984:EE_|SA9PR11MB772229:EE_
x-ms-office365-filtering-correlation-id: 99114aeb-9b21-4afa-b707-08df4b09e4b1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|18002099003|22082099003|3023799007|5023799004|4143699003|11063799006|56012099006|10067099003|261102123227099003|261026140227099003|261028144727099003|261021135927099003|261022075727099003|261022105027099003|261026121527099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: kixq7Ozx3PoHo9HShTG+dqve/zfttrAj9b3/4LfF+pGaOIpa5wtQEDAuTo3ZspdcPWMwmITnQg/7F0IPmHWKHdgShtoHsXxuqdNeXe2JQ8ssHnz1b6XPtlXGP+tV9f6bxuwezS74choqPHCbfga2V3T7fzZrnY4uVVB23rWcZUBXJehCGrxiDtBBdqqQ09Ez24mrGYJz6HWziMbJbcANHvmURV4a1U4HsYU2daXlLWbyAjUgkUZRCqj5HucOekujyBHZURhUvlinUaLw3I8h+5kdhpxRNS5ros+29Qc8KewML9IPdj0iATBV1pDpjeicoxCULEm8xl4uJZDgook4FdpduiFYgNB5pXbZsO0kEbc1fcnVXHlAM9jb1BzLLBgSKISZ3k/bUcPaZS4BSryENz42xr9dzdGmIE2rSFfhXjswomS0Hpa9IKFJyRqM28wOEvNpt94ls2DI6AidPfpdrNUmLSveLFPDHYzMa1H3pqJBhBvuGgYWilaWtrHiB+wTTKJv2gaMZx7pk7nhuM0Ip9RjCcz/aJ1kmPFAjNfLFGkJ2QljU/o6YUH8nWOm+iUbP30xfmHAzTCOvfcfn2QN/FBA71fkWA7yZiX5pyimEob2zZyL45o302yD8+HlrwUn31YW88Mmzc1m/08h+VkG5GISmz4KIGPZ0IPkQKjPPoN9oh5deTAUTFRbu+K7suQl9CidD7a0vITMVO2ggE5MyLXwv1LHBNC9HkB7d5JItus=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6984.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(5023799004)(4143699003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261026140227099003)(261028144727099003)(261021135927099003)(261022075727099003)(261022105027099003)(261026121527099003)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2I4N0d1VGJQUTl0dnlXUWQ0QjAxL2NjaUV2MzZLTXQ3bko5REx1Z1FSbzNm?=
 =?utf-8?B?akFuNXhDVHVwcStCdzhJNUFmbHgva3A2dnRKaVRLNm9QRjFsUWRqZEhTRDk0?=
 =?utf-8?B?MnkyaEJoMWxVV0dpTDFuMlc5b2NHTkdEeXlTdmxlZW9NZmpJZUxlbUdXeisr?=
 =?utf-8?B?azFqQXhqWUNncEFiZ0dnZStVNnovR05KUVkxVDdBK085dUhaZC9lZ09acXFI?=
 =?utf-8?B?cHFYTDU0VWtmQnRQSFk1S3lZSW9DSTlONm1rRkNPR2VmUjNPOUVCM0U2YlZh?=
 =?utf-8?B?a3VDWFo4YU1hcEJ0WmhQczU4SHI4dTZVWlNYYUhWSFRzQzZ6QncwMy9COWo5?=
 =?utf-8?B?dGxpN0V3YTJxWDA2Tnd3TWltNW9IMFJqRGJMR0tWbUh6TGVxdnJta0RHMzNa?=
 =?utf-8?B?RHZwTHQzUjBGNjRiSWUwNmVWbEo1VFpXY05ZOUxLVDR5YnN6VWk1Y3JCVWI1?=
 =?utf-8?B?SlUzKy83RkI4aG5HTGNLUE8xSWJ0SEpoY3F0VVFRbytPTEIveXFFdWhnd2dQ?=
 =?utf-8?B?ZDhPSVBseEM5N2NsbWx2Zjh6c1hMeHo1eFYveVBhSTdmOGdLR2cyVlJFbzRk?=
 =?utf-8?B?YnRoay9UTDBTem14a0k2MmZIVmViRnREVzVXVEt6VERuWTFqaldGWE9hRFc2?=
 =?utf-8?B?Y0NjL2tncy8wR1Fmc20waVhBQnhxdTd3a0ZsaXdsNjZEc2ptTzdzbTV3bnAv?=
 =?utf-8?B?Z3F5Q0wxaXJDSG5mMGMyMXVIMy94TnhCYzlpTGpuYkNpcm5TcFBDK1BZdi8x?=
 =?utf-8?B?b1BxaGJCSTFzYnFta2Z4RkdxMzUwa0pBYUFCQzFLeDVtcWx5TFpSRlI5bm45?=
 =?utf-8?B?RFdrQ1AycVN0SENteWJZSlVCTjE5aGtLQ3hrNzhEbG53UmQ3KzA5YVdjYzZp?=
 =?utf-8?B?L0xkSlhCQW0vWnJTUjBpekVtazFZaGYyRUdmcko4bW9MSWhlcWtUTEhWZ1Vl?=
 =?utf-8?B?aGhqOVZYSldzRlZ2YTA0Rm5TNTd3bEtzRW5CNTA0aW0vUFZXYm5WYnQ0MW85?=
 =?utf-8?B?U0R6ZXZpNGUvbUdKMjVsNHEvTFNHSnRMK1IrVEJraEVhYW9xbTlnMnZqY0tM?=
 =?utf-8?B?M1ErL0d2T0ZPbHVaSnR5dnVTYUFLa2ZobDN4ZUhWckZqa09pdW1tWHorYlVF?=
 =?utf-8?B?VW45dWU1YkpsVG1CaGpwK2FFSy9mdVczKzY2THN5c1Jta0EzNkN5ZFgxaHMw?=
 =?utf-8?B?cEpTSHltZUtuYkVCQkJMV1NBTHFJbVlTdU1GN01PYkZGblE5Nld0UlNXQU5W?=
 =?utf-8?B?OTI5dVkxK1JScUt1Smt1NGZTT3FFRjZJUkcrVEc1MFlDUkVnbEpjQ2hEc2Ix?=
 =?utf-8?B?VnQwdDQzUlM4SkoyK1o4UWlUUjJBblFLZGRSalJxNXNUMUEyc0IwSCtKbHFM?=
 =?utf-8?B?WWVFYXFVeVdIeHNNK09sTXlYZytNZkZSN1RLaE9kNUtqODloSWhScEI2M3hl?=
 =?utf-8?B?dW9hMHVxRmsrWmZUSjVhTDVtSkF3Q08zbXJBN1ErVVc4UUlnWkpRaGNpT05n?=
 =?utf-8?B?YW5kL29xN2pzazAyNENNR2VGaDV3TVFTNmlQempUaTJuZlFMZzdSZ1dzNDlM?=
 =?utf-8?B?ME52S1FHWGRTRmVQVS9aL01FNnlzdGZrbFhpdUlHMnhKajMyVGNhYlBPVEJn?=
 =?utf-8?B?ckEwWElqZVBsck1HL01oRUFiS1lFb1F1amhFZGxPbnJvOXBudk1RKzIxN21D?=
 =?utf-8?B?b2NWY0R3THhleWEyUzNmdlFRSHVKYVFXejI0cHBycGRCaEk2Z25xTlpWYlQz?=
 =?utf-8?B?WTdzUDdyQ2xUeUlCaUNibjdNUzQrRGc0VitMdmNIVmVQRU90S0w2Z05XbWhT?=
 =?utf-8?B?RkR1TTY1bStUUTlSMEJRa3ZGWkh5L0xMc05IblVNTnlRQkVXL3JVTkJxVnlB?=
 =?utf-8?B?YitJWWdpWXExWjUzaVhkaHFxRDlXdmpmcnQwREhRRDJ4eVZaQ2R0WE84ZkxP?=
 =?utf-8?B?L1RPM1FLT2FjM0x1RU5WS25OUHJkZTBrZ3FYbTQ3dzJyT1NuOWdNazdRQnJT?=
 =?utf-8?B?Mk80bFFUbFVuUFJYaUN4YldaRGdwUkxLcTRWTGY5YURWQXpVY0owYWRjdWFH?=
 =?utf-8?B?cVQxdHFlVmgvZWkwcUlCYTFBUitraFEwRm9qc3lJQjhQWllMaVV4STBIOGM5?=
 =?utf-8?B?V0ZXM082bWNSRE0raGkvUFM4TW9PR3JleVZhT1JpbG9HU1dGb3dIYzRxMkJD?=
 =?utf-8?B?VVBoWFB3R2xBcHBrZlY3UW1QeEYxR3Y1czRza2ovMkw3VHZmcTNOdXBCaVVL?=
 =?utf-8?B?QzNkN0ZzSENJa1ZwQmp2d1ZTdVl5Z1M3UFMyN2Z0Q0Nud2owQ1V1eTFHMDh4?=
 =?utf-8?B?YmtTUzNmOEJiRDlVVHl6YlVCV3NnaGFTZkpHRUttTVVXM3hyMUlqaUlYV0Rk?=
 =?utf-8?Q?SH9db1+mF3AU32JI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CorhBixFzpouHZtWuWEBGdvj9/KtSc5WXwFAFOVtnAg5nQsEjfLAM+JynrvxnuAn854/V3tzpsBlnX3/jg6dVNU8MjWjIQ2ry7FDUp93g4+/bV/SB/K5AumFsPxq7JBP3V0b+kmizMhg5fS8idIpomioepzTNMvPT9PLHbdtwvSW9n2z5EQcJ5e5BYljwSmmd6HDNSnLNf5imNIrYXOTjG3/rxnAnTezTS922z80/BS0BOsk1O5aN/Au1kiQsx5tzNNDl025PNCehyv8ZbmCmOvc1y+ilCOnC37mqJecuLM5hCHMzJY6qa5HnbBtIx436Wv+ykSFrL0suFKlUzG0TQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99114aeb-9b21-4afa-b707-08df4b09e4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 15:36:37.3029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61VYgD5Sn4JEvAZw4p3p/lZQYiRyzG9ADKvLnjYPlnuU8CAUbhv21B4TTw9sBFLW09OfppL6rODF2wE6vD9VkwSxDqETy4i8+lEQsEDFIIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR11MB772229
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PkZyb206IEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5jb20+DQo+U2VudDogVGh1cnNkYXks
IE5vdmVtYmVyIDE5LCAyMDI2IDE6MjkgUE0NCj4NCj5PbiAxMS8xOS8yNiAwMjo0NCwgSmFrdWIg
S2ljaW5za2kgd3JvdGU6DQo+PiBPbiBXZWQsIDE4IE5vdiAyMDI2IDE2OjI5OjIzICswMTAwIEl2
YW4gVmVjZXJhIHdyb3RlOg0KPj4+IEEgc3RlcCBvZiB0aGUgemwzMDczeCBQSEMsIHdoaWNoIHB0
cDRsIGFuZCB0czJwaGMgZG8gYXQgc3RhcnQgYW5kDQo+Pj4gYWZ0ZXIgYSBsYXJnZSBvZmZzZXQs
IHdhaXRzIGZvciB0aGUgbmV4dCAxIFBQUyBlZGdlLCB1cCB0byAxIHMsIHdpdGgNCj4+PiB0aGUg
Y2hhbm5lbCBsb2NrIGhlbGQuIEEgcGhhc2Ugc3RlcCBjYW4gaG9sZCBpdCBmb3IgdXAgdG8gMyBz
IHdoaWxlDQo+Pj4gaXQgd2FpdHMgZm9yIHRoZSBwcmV2aW91cyBvbmUuIEEgZHBsbCBjYWxsYmFj
ayBvZiB0aGF0IGNoYW5uZWwgd2FpdHMNCj4+PiBmb3IgdGhlIGxvY2sgdW5kZXIgZHBsbF9sb2Nr
LCBhbmQgZXZlcnkgb3RoZXIgRFBMTCByZXF1ZXN0IGFuZA0KPj4+IG5vdGlmaWNhdGlvbiBpbiB0
aGUgc3lzdGVtIHdhaXRzIGJlaGluZCBpdC4gV2l0aCBUb0Qgd3JpdGVzIHJ1bm5pbmcsDQo+Pj4g
cmVxdWVzdHMgdG8gYW4gaWNlIERQTEwgdG9vayAxNDQ4IG1zIGluIG1lZGlhbiBhbmQgMy45IHMg
YXQgbW9zdC4NCj4+PiBXaXRoIHRoZSBzZXJpZXMgdGhleSB0b29rIDAuMiBtcyBhbmQgMC4zIG1z
LCB0aGUgc2FtZSBhcyBpZGxlLg0KPj4+DQo+Pj4gVGhlIGJpZ2dlciByZWFzb24gYXJlIHpsMzA3
M3ggY2FsbGJhY2tzIHdlIGFyZSB3b3JraW5nIG9uLCB3aGljaCBoYXZlDQo+Pj4gdG8gd2FpdCBm
b3IgdGhlIGhhcmR3YXJlIHRoZW1zZWx2ZXM6DQo+Pj4NCj4+PiAtIGEgZGV2aWNlIHJlc2V0IHdp
dGggcmVzeW5jIHdhaXRzIGZvciB0aGUgZmFzdCBsb2NrLCB1cCB0byAxIHMgd2l0aCBhDQo+Pj4g
ICAgIDEgUFBTIGlucHV0DQo+Pj4gLSBhIGdsaXRjaGxlc3Mgc3RvcCBvciBzdGFydCBvZiBhbiBv
dXRwdXQgY29tcGxldGVzIG9uIGFuIG91dHB1dCBlZGdlLA0KPj4+ICAgICBzbyBpdCB0YWtlcyB1
cCB0byBvbmUgcGVyaW9kLCAxIHMgZm9yIGEgMSBQUFMgb3V0cHV0DQo+Pj4NCj4+PiBIb2xkaW5n
IHRoZSBnbG9iYWwgZHBsbF9sb2NrIGZvciB0aGF0IGxvbmcgd291bGQgc3RhbGwgZXZlcnkgRFBM
TA0KPj4+IGRldmljZSBpbiB0aGUgc3lzdGVtLiBGb3IgdGhlIG91dHB1dCBzdGF0ZSB3ZSB0cmll
ZCBhbiBhc3luY2hyb25vdXMNCj4+PiBpbXBsZW1lbnRhdGlvbiwgYnV0IHRoZW4gdGhlIGNhbGxi
YWNrIHJldHVybnMgc3VjY2VzcyBiZWZvcmUgaXQga25vd3MNCj4+PiB0aGUgcmVzdWx0Lg0KPj4N
Cj4+IFJpZ2h0LCBmb3IgdGhlc2UgbGV2ZWwgb2Ygd2FpdGluZyBhc3luYyBzZWVtcyBsaWtlIHRo
ZSByaWdodA0KPj4gZGlyZWN0aW9uLCBhdCBsZWFzdCBuYWl2ZWx5L3dpdGhvdXQga25vd2luZyB0
aGUgSFcuICBXaHkgZG9lcyB0aGUNCj4+IGRldmljZSB3YWl0IHVudGlsIFBQUyB0byBhcHBseSB0
aGUgc3RlcCBjaGFuZ2U/IElzIHRoZSBwcm9ncmFtbWVkIHRpbWUNCj4+IHN1cHBvc2VkIHRvIGNv
cnJlc3BvbmQgdG8gdGhlIHB1bHNlPw0KPg0KPlllcy4gVGhlIGRldmljZSBoYXMgbm8gaW1tZWRp
YXRlIFRvRCB3cml0ZSwgaXQgY2FuIG9ubHkgd3JpdGUgdGhlIFRvRCBvbg0KPnRoZSBuZXh0IGlu
dGVybmFsIDEgSHogZWRnZSwgdGhlIG5leHQgaW5wdXQgc3luYyBlZGdlIG9yIHRoZSBuZXh0IGlu
dGVybmFsDQo+MC41IEh6IGVkZ2UuIFRoZSB3cml0dGVuIHZhbHVlIGlzIHRoZSB0aW1lIGF0IHRo
YXQgZWRnZSwgc28gdGhlIHNlY29uZHMNCj5zdGF5IGFsaWduZWQgd2l0aCB0aGUgMSBQUFMgb3V0
cHV0cy4NCj4NCj5Mb29raW5nIGF0IGl0IGFnYWluLCB0aGUgemwzMDczeCBob2xkcyB0aGUgY2hh
bm5lbCBsb2NrIHdoaWxlIGl0IHdhaXRzIGZvcg0KPnRoZSBlZGdlLCBhbHRob3VnaCB0aGUgZHBs
bCBjYWxsYmFja3MgZG8gbm90IHRvdWNoIHRoZSBUb0QsIFRJRSBvciBwaGFzZQ0KPnN0ZXAgcmVn
aXN0ZXJzLCBhbmQgdGhleSBhbHJlYWR5IHJ1biB3aGlsZSB0aGUgZGV2aWNlIGFwcGxpZXMgc3Vj
aCBhbg0KPm9wZXJhdGlvbiwgYmVjYXVzZSB0aGUgUFRQIG9wcyByZXR1cm4gcmlnaHQgYWZ0ZXIg
aXNzdWluZyBpdC4NCj5JIHdpbGwgbG9vayBhdCBuYXJyb3dpbmcgdGhlIGxvY2sgaW4gdGhlIGRy
aXZlci4NCj4NCj5Gb3IgdGhlIHJlc3luYywgYXN5bmMgaXMgbm90IG9ubHkgYWJvdXQgcmVwb3J0
aW5nIHRoZSByZXN1bHQuIEZhc3QgbG9jayBpcw0KPmEgc2V0dGluZyBvZiB0aGUgRFBMTCwgbm90
IG9mIGEgcmVmZXJlbmNlLCBhbmQgZm9yY2luZyBpdCBtYWtlcyB0aGUgRFBMTA0KPmlnbm9yZSBp
dHMgZnJlcXVlbmN5IGFuZCBwaGFzZSBlcnJvciBtb25pdG9ycy4gV2hpbGUgYW4gYXN5bmNocm9u
b3VzDQo+cmVzeW5jIGlzIHBlbmRpbmcsIGV2ZXJ5dGhpbmcgZWxzZSBkb25lIHRvIHRoZSBEUExM
IHJ1bnMgaW4gZm9yY2VkIGZhc3QNCj5sb2NrLiBBIHJlZmVyZW5jZSBzd2l0Y2gsIHdoZXRoZXIg
ZnJvbSBhIHByaW9yaXR5IG9yIHN0YXRlIGNoYW5nZSwgYQ0KPm1hbnVhbCByZWZlcmVuY2Ugb3Ig
dGhlIGRldmljZSBpdHNlbGYgaW4gYXV0b21hdGljIG1vZGUsIHdvdWxkIGZvbGxvdyB0aGUNCj5m
YXN0IGxvY2sgcGhhc2UgcmF0ZSBpbnN0ZWFkIG9mIHRoZSBjb25maWd1cmVkIHBoYXNlIHNsb3Bl
IGxpbWl0LCBhbmQgdGhlDQo+cmVzeW5jIHdvdWxkIHRoZW4gcmVwb3J0IHN1Y2Nlc3Mgb24gYW5v
dGhlciByZWZlcmVuY2UuIEEgc3dpdGNoIHRvIE5DTw0KPndvdWxkIGtlZXAgdGhlIGZvcmNlIGJp
dCBzZXQgdW50aWwgdGhlIHdvcmsgY2xlYXJzIGl0LiBTbyBldmVyeSByZXF1ZXN0DQo+Y2hhbmdp
bmcgdGhlIERQTEwgY29uZmlndXJhdGlvbiB3b3VsZCBoYXZlIHRvIGZhaWwgd2l0aCAtRUJVU1ks
IGNhbmNlbCB0aGUNCj5yZXN5bmMsIG9yIHdhaXQgZm9yIGl0LiBXaXRoIGEgbG9jayBwZXIgY2hp
cCB0aGV5IHNpbXBseSB3YWl0LCBmb3IgYXQgbW9zdA0KPjEgcy4NCj4NCj4+PiBBIGZhaWx1cmUg
Y2FuIG9ubHkgYmUgcmVwb3J0ZWQgYnkgYSBsYXRlciBub3RpZmljYXRpb24sIGFuZCB0aGUgbmV4
dA0KPj4+IHJlcXVlc3QgZ2V0cyAtRUJVU1kgdW50aWwgdGhlIGNoYW5nZSBjb21wbGV0ZXMuIFdp
dGggYSBsb2NrIHBlciBjaGlwDQo+Pj4gdGhlIGNhbGxiYWNrIGNhbiBzaW1wbHkgd2FpdCwgYW5k
IG9uZSBjaGlwIGNhbm5vdCBkbyB0aGVzZSBvcGVyYXRpb25zDQo+Pj4gaW4gcGFyYWxsZWwgYW55
d2F5Lg0KPj4NCj4+IERvIHRoZSBmYWlsdXJlcyBvbmx5IGhhcHBlbiBiZWNhdXNlIG9mICJ1bmZv
cmVzZWVuIGNpcmN1bXN0YW5jZXMiIC8NCj4+IEVJTywgb3IgdGhlcmUgbWF5IGJlIG1vcmUgY29t
bW9uIGVycm9ycyByZXBvcnRlZD8gSWYgaXQncyBqdXN0IHRoZQ0KPj4gZm9ybWVyIGEgZGV2bGlu
ayBoZWFsdGggcmVwb3J0ZXIgY291bGQgYmUgYW4gb3B0aW9uLg0KPg0KPkZvciB0aGUgb3V0cHV0
IHN0YXJ0IGFuZCBzdG9wLCBvbmx5IEVJTy4gVGhlIGRldmljZSBkb2VzIG5vdCByZXBvcnQgYQ0K
PnN0b3BwZWQgb3V0cHV0IGFuZCB0aGUgZHJpdmVyIGNhbiBvbmx5IHdhaXQgZm9yIG9uZSBwZXJp
b2QsIHNvIGEgaGVhbHRoDQo+cmVwb3J0ZXIgd291bGQgd29yayB0aGVyZS4NCj4NCj4NCj5Gb3Ig
dGhlIHJlc3luYywgbm8uIFRoZSB3YWl0IGVuZHMgd2l0aCAtRVRJTUVET1VUIHdoZW4gdGhlIERQ
TEwgZG9lcyBub3QNCj5lbnRlciBmYXN0IGxvY2ssIGZvciBleGFtcGxlIGJlY2F1c2UgdGhlIHNl
bGVjdGVkIHJlZmVyZW5jZSBsb3N0IGl0cw0KPnF1YWxpZmljYXRpb24gaW4gdGhlIG1lYW50aW1l
LiBUaGF0IGlzIGEgcmVzdWx0IG9mIHRoZSBpbnB1dCBzaWduYWwgdGhlDQo+dXNlciBuZWVkcyBp
biB0aGUgcmVwbHksIG5vdCBhIGRldmljZSBmYXVsdC4NCg0KTmV2ZXJ0aGVsZXNzIHdlIG5lZWQg
bWVjaGFuaWMgdG8gZG8gaXQgYXN5bmM/IE9yIGFkZCBhIHRpbWVvdXQgZm9yIGNhbGxiYWNrDQpv
biBkcGxsIHNpZGU/IFRoaXMgZ2xvYmFsIGxvY2sgd2FzIG5ldmVyIGludGVuZGVkIHRvIHdhaXQg
YSBzZWNvbmQgKG9yIGJlbG93DQpwb2ludGVkIDYwIHNlY29uZHMpIGZvciB0aGUgSFcgdG8gcmVz
cG9uZC4NCg0KVGhhbmtzLA0KQXJrYWRpdXN6DQogDQo+DQo+QmV5b25kIHRoZSB6bDMwNzN4LCB3
aXRoIHRoZSBnbG9iYWwgbG9jayBhbnkgY2FsbGJhY2sgdGhhdCB3YWl0cyBmb3IgaXRzDQo+ZGV2
aWNlLCBmb3IgZXhhbXBsZSBhbiBtbHg1IGZpcm13YXJlIGNvbW1hbmQgd2l0aCBpdHMgNjAgcyB0
aW1lb3V0LCBzdGFsbHMNCj50aGUgRFBMTCBkZXZpY2VzIG9mIGV2ZXJ5IG90aGVyIGRyaXZlciBp
biB0aGUgc3lzdGVtLg0KPg0KPlRoYW5rcywNCj5JdmFuDQo=
