Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09519C982D0
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 03:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B05F560BBD;
	Fri, 18 Sep 2026 03:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kZAGyQdWdAap; Fri, 18 Sep 2026 03:05:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F219260BAB
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789700710;
	b=p+d7XrOkmJHAN8VeqgM+xo9Lo8yhNgW/dP9019ifTg+4HhKsj+pHMTjhkZFNuafSG6cU
	 V6J5t0+nmf+xw8LNlYYU6E0D7bTHf2YdsacRLJZAt3Sf8Yir74LRQHyoTJA9GjoYOttAc
	 xt656TkEfoSntFbIOi+LlR8ly/u88pQzCt8ivvTZplamX+9btRuhBzGreMuESnaFWeOIX
	 guqV78vzBwkZo8iiAJj0fqS2mVk3HpaSfwPKhaqjWpYlFsHiZSSicutWrd6SV8jmg4qXH
	 JYVbYnqqDXz3EFZ1yHdDEA7cuBE3nec1LDc8XR2A3cJ2F5/bYOeeTb26rxo3hugat0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789700710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
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
	bh=9REasuyhDKytht7Nd1dzQaBBPP48rWWOL3GUkCcS7gE=;
	b=eJeWn0oL0XiUDiC686QrzldfusOLiI8KKGL79zBNv8EhKX9u6O5KLrTCeFov6pyESOmC
	 KKRAQQqNgup5x8a1saIOvXbB7mmQjtyEsJ0sS4n5XTfJ+Pjkn6WSgK9YnEl74Xad9Li0h
	 4Y6DfAV+9AGEusqJ7XCg6IuSqmxzkAyk67EJLDlgnYIAO70jpyVnyH8a8sl4KCm6pJkCV
	 6Xh+eMEytfj9WbFJXKoV0r9TvrQR5j2HDewlBoygz1w0ZoS7Zwpa4kyPHsfb+5RTgo0Tw
	 7/ynk9/EjLc0AcJhZX4XjdRnK2S4KPXdO1WXuXW0V0/8KugWrkiV0hmvhXvsaHrc7kA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789700710;
	bh=9REasuyhDKytht7Nd1dzQaBBPP48rWWOL3GUkCcS7gE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+W92FX/EeflF36Ns8iPWuegML71Rl6TIbMONfTPCJ9/FO9jhsm5Pwt9GpBYB4ATV
	 Qa0TxG+AzlJs+9L0uSrBa1f0b0yW/cDT3GhNXS27JE/Po3C1XTPzx0hlqk+yeVOjUI
	 37lr8+oadE8Oe9KLW77sbF13PqG8iOSkuyy+6micwI49C3/TlAbLaAkLhcjJtn47FU
	 SRgONeTyZ+MuYIqU4T6dWI1pxolmNQm0fcidh0n94E1BxfxJyt6e2VRBKDkS/IMsKu
	 vr4j6MMscD1uwkVhFT4X7AF4Tko57YTkgT6Y3u1AvqVL8UNpZg3JjYB3ZVJA26R9Oi
	 aRF6iQuUxhV2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F219260BAB;
	Fri, 18 Sep 2026 03:05:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80065362
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 03:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71FE240AE6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 03:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WHTAn3UytIQm for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 03:05:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1F07040AE0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789700707;
 b=gILPOo9lZXHwSRVeKriXvUFioYtvWpQsYaLW+7WisWN9Ua3WEF62ng33pySZRXy27TE+
 DJjw2Lu7X4+C1lnXevLAH4YuAIfUtnShv7UO3fZsZGYjUo9QdSb5InIbPeaIuYdGeaTKB
 B9POr4QSRohAG6n81UvnOpe8RPddH1PXcIgzHoJlgHFESlzYRYRhV5BLv50ZOZSXJRYe6
 pf3jg3dV1jU+4P182hpalAY0jQASUEGniqQhULPMbnIe0GUvnMBo/+Sicf2EnYDxqw1ee
 wulYe3/FQSBANRN2fMrg3E6vpbY585TIC4hYCqwbiJWnJ+WNAembVubQ67hylYkH20g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789700707;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=9REasuyhDKytht7Nd1dzQaBBPP48rWWOL3GUkCcS7gE=;
 b=BQhDrMsmyk0EYWp87UgK4WeWvJ8mhAE2uSexWDKELfOSw8uHAA2sOSS110B0MTN+DBbo
 e0ri6Gl3cj39R52EUrP8QYS5utWxB+Kx6bqZEaG1ScfQ1ozKQLtujmTVp87oV/dsQak9y
 L1kTDbHbeqpJHr8C05vwWoHUlTquzt1cHkEuTTBAURQVA1i+coAj4zxHf3mwRVyhDip7L
 qcz8SfR9Z9Mcrwmllhi5y4SxjYWN711oWp/5AyhFWvI1dbmNHOdJSzChZVXYLSPDe+M3k
 U+D1kREVmy+TWBng8uzCpnaM5Oit343RKZwmrJnQktfLqn47H2Z6Z2HtHE7S0OZJXbA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QiNXvOs4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QiNXvOs4
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F07040AE0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 03:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789700707; x=1821236707;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XjTrBnjt3sD5UrtEpK290AK7g6wxVUWUyTqYFtmkFvw=;
 b=QiNXvOs4LO0+secisftP6tYoisnBWKYFm8gEaAZLKCfvi+ps/iBTRO+4
 x19CcpEIeNotupIGMx3obwb7gKRc9Dd6IO7nbldj7BeKeS1io2zJR1U6Q
 FWlyhiR9jpj+m78sChjmD7SNeXjS0rYmcGIDiDhx7XVk0Sqa6YaVAZxpG
 4RsOtZmyT03dDbgZuW6q5NbP7v1+CMO88u0Q3DQWlEC4w4T+wMZS3dNii
 OZef+VblfLYAm5LmFCcP8XIkWgQW4V+Pl/arkxmE/QYl8PmGS70b/FrqZ
 keu0/qAskZBrSfci3O7sQskris43fAI2kbGp3sBCY2O3KFhSzNnoW/kVP g==;
X-CSE-ConnectionGUID: axWxUZS7Squp4xuAdmVD0A==
X-CSE-MsgGUID: ccrtvvbiRgCm5o6PnxDmWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92690807"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92690807"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 20:05:03 -0700
X-CSE-ConnectionGUID: Ty/qRSqDRYuNInAqwpMaMQ==
X-CSE-MsgGUID: 0xGqf155SoCxJOItfik4FA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 20:05:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:05:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 20:05:02 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/SuxOidYqKpDWu2jrwVmGMS3j3YaM9Ffg8IN9oHmawhTRX9SQcOwengyZqiWgsN/EAW2k0++4tlQv4djyoW+hmA82h40NmbbqKrYrIktFgZ9Mxe29p7x6Rpog35o+qqMpWyDhi4or+GxBdUcMgx8SK6PCJV+ZPEZwYhNPBQCA/tT4BA591c1DzkwIBxo2AJa0xxlYhb0qyXpPkM4bMPG8j7yy1gU3TClc4Hqyw9Bjb+yDIbVGVjuTMx8JFc19kB4QuelQIsWfDAwQDU9FVYcF809DQ/MB4uIocjT5c9Jkt7B5RAhRvgrIuPusGfBIryqueRs0ikuVrIXCaLjFaTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9REasuyhDKytht7Nd1dzQaBBPP48rWWOL3GUkCcS7gE=;
 b=P3DrcWa5iHWUUZhd96E75xMjnwXVIvPpQQvNt/MVRaQj9cHhAe8OcKbfsjz8SHlvTOMwJhF+uBBI/MBkjBr2MJ8IOMzqhrs6O/8sf2WH/nebndhBuTSru8/M24MT58GflL3egGc7UZi+q0eIyx59+V8uTfqbJF3sEDYQhL18e8ENSh5jG9+BbfPzXSskkBpbjjG2qVCR1z3Fu8PAC1na4jZPaOWaSXAMlVN/Xi1l6wCYHisyC4N/LY5N/eb3qQA2itvwIrJgK9NqSTzy2T66iLkxJl50jfBJPzZZaUuaA7wR3MoD9+DxI3ZBy47iSdLseIxhv6G3EWLXaiBwn5puGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SJ5PPF20F246184.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::819) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Fri, 18 Sep
 2026 03:04:57 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:04:54 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "tj@kernel.org"
 <tj@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Xuanqiang
 Luo <luoxuanqiang@kylinos.cn>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] igb/igbvf: disable work
 items before device removal
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] igb/igbvf: disable work
 items before device removal
Thread-Index: AQHdGPzjJZCT8cec6EKBKYEDbf2cBrbUArEA
Date: Fri, 18 Sep 2026 03:04:54 +0000
Message-ID: <LV1PR11MB879069BE4FE975BEE23CF3E290872@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260721103539.57990-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260721103539.57990-1-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SJ5PPF20F246184:EE_
x-ms-office365-filtering-correlation-id: 0bd5b1e5-3530-49fd-4c8a-08df15319d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|18002099003|10067099003|56012099006|11063799006|22082099003;
x-microsoft-antispam-message-info: f7oQIfAwKb6ueVnuxI7nUBHoK9rlXF7bhmd3YQXj4EnNrNNl/scgb/RAsb1sl00xKodGs5BYojMYIUEhblD0mQUyeE5AqCxgGXiLW9pYhGDkARVyWurqcYpzKftjw7o8oI5DipZxMe9P8yFrZtr4U3MscN9GumeW4FTVD+LRiQkRXK34UpAloXMrzSzXsTfQ+Rl43GIHnHfoOMEeGgLYIyE0pMcOePc5vvOIi5+eUpOd0C9AwYvy44qPCxVvxeyOuMKlNjP8UZCHaJS9KXqyTo+GsEBArSHqTdOb4Ae8+y8FytKW4y9SChjlY6jcHvF7MgAVQb1Tp2Me9hDAMgYg/B2/kTgNYrfSfj0gKb5SgBO5cWnCkaESJq5xTJWAk7XsH9JAawKtWOzVcTrUwb5xJlbGT6zu+GyvHNncYRmGCAKqJZq0vfP83GO9hQsal++tUT57gl8+stqwuvPY62/n+VYL5gFnfnMH/2CwNGfEDqooZEu9nJGKdo4IXdALHY0+KT9BFD3C1hUn3GLuYkbnw+OKMy0j0nP1Me+89C0+7RU9F/jgn7oaiOpdLovSQ+Y3tWawvMYgHCCgn49juZRTPcFCE99dyYGNcq+aZfDqhPWdXsgUsmKUZFnbEV4tsmhz9MGoL+HxoAfZHLM6wMMYHSjAKxKjRSZm7xu65yyJ65YBNNQN+IJ7/gRDOJpKYgu6frptXekfbauNEDxfU9uDF3ydS7RrHZy9lRNHL+IjdnM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(18002099003)(10067099003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0d2MpXShE5LYbeoaGcKUjcIwnicqbsP9wbvbm9S8H8InNoN6kHlWee8d8gdZ?=
 =?us-ascii?Q?bk7vm98yt7PGvvycTvInYPLVd+e5QZGLwEaZhd+DuJitrH4Zrz8HdZ+1wGhw?=
 =?us-ascii?Q?ssPKBw3VNyEhSZYa99M/0stcoHEnkDHuvrN1DPAR3s6m240ibflcvLmQ2Udw?=
 =?us-ascii?Q?0UAJJuoSkeIa+cQe98mSj3CwmwEICHD3doKQq6Tb1GjOtwceRtedt4uENWYN?=
 =?us-ascii?Q?ARMr3/8HNz+rropc19xdT/pMyK8gZvjuCWNlhW7fwSSORGE5Ct/wJV5IQZmy?=
 =?us-ascii?Q?xMtLQR/Z8NUhHQW7QNyMKR41ijpTJ3qFoHxPV8VIhZ466VTb5WsTJcIPFQSJ?=
 =?us-ascii?Q?S/SmGp4cWKjUMwIVkk6/BvI+SYoH44dsmCLZcukAQZYtDSPGZ4nX5AnTceNS?=
 =?us-ascii?Q?0QDmMaCzj++iyD/oKWnHi6wmus4GUEX3CpKSz0b0pScBrAkb3+3Q5QW3cF3P?=
 =?us-ascii?Q?MNFw5yHf/+vUpxwwRD86PEzDUAOfj0o8u0UqojUyLvk8wglSb0b444Lp13Qm?=
 =?us-ascii?Q?RT9/2CdH9b8hMf3OSY0xiM/oaM94FeBbSdCXzCR2epUKfMhVHGNnIOjGO7Hl?=
 =?us-ascii?Q?goSr0ub9owg0xCga/tnxhv98X62jnmeWtFacpQ7W/o6gVILpDQKUT8P3uxV8?=
 =?us-ascii?Q?COHQhRHi7W9Nr+euriSNDba+Vb328e4+RMLz2CdHcYZ/MnubBdPA6WWv9CbQ?=
 =?us-ascii?Q?OS9QMi7ccSsWNu4W7ZideSanWs+m+hGKK5j/ZsUEbBBwXGoBDEhgVh8c1gzQ?=
 =?us-ascii?Q?Ea+Sl5dgATKCZG5QIyNtzF0PU88wOx1AsWJ36J7KOgKTgVasMipkYOeEo7xA?=
 =?us-ascii?Q?+1i0+Tb/2TlblUDoYOpkPj+kl17Vk+g4s5v/qFUoUX7muxeR2BppTHwAQr1b?=
 =?us-ascii?Q?utlnfroYEnLU1CSeW4bccaLARRvRRKAF1Th64D2pmQ/6w0c5Ao4cafRzIKFW?=
 =?us-ascii?Q?y2GeRDeBdjWV2CMkHokmsPDfMSz5g4e8VFLh4yfMdKYmIhzll8m2Qla1xW3j?=
 =?us-ascii?Q?N8/ya+sZEKXl2jQPFvJq+TTLLAb1BO6O93Ujtsfupaa+oC6adfumu5w3Tjjh?=
 =?us-ascii?Q?oYSbwaYRMsb0dB7gNi/2zNAwQ/4b9RcT/U/ljpyMQfknomfQgn0KPh9bj9HE?=
 =?us-ascii?Q?9BBJTWFuFJTTBSxrjmpv9Q+x6Y9o36DTxSNJgeQTWymhdCke3ofVaVPZVuXN?=
 =?us-ascii?Q?OhoMbXZOdb7YkpmIemaOGcnJxPtkJTmVGXWcnQzDvIhi5pzByKo6vN5qiwFp?=
 =?us-ascii?Q?2eGKQXEr+eFFpmqJagD5NAjbydN543uXJQI7LF8xXGi/mSi99oGl9NDnv7A1?=
 =?us-ascii?Q?HLVT0JK2HjeBGP3gw6P/31Ra2nSNEekebd7I9pU5aOtAYTKkLRMC92iz0V8p?=
 =?us-ascii?Q?mSdIHBcVBqn9ot5BVLKqIGYtPMokBUoiX9Eo0nYHj1Svq4p1FVHefBAK43/8?=
 =?us-ascii?Q?+fRETZ6Xuo7Zhi8KkZ/y8eORiASm8lNHYeGGJWABsyIJ4ES1df1dxEXJthT/?=
 =?us-ascii?Q?AlOs+2Qnww+CHWi/Q4e556RdG8EY1T2CWCuWc5R0whHj5tjfFEei4YLVb4Mr?=
 =?us-ascii?Q?srEr+HWjvwgH3mRHpoZURXlCEc+v6aBEGbWCjR6W0TNElqI0nKajx9J3yP/b?=
 =?us-ascii?Q?V+ziUUTn3JYEtpMcqD4O4N7DkDm3VlEAnQRvARfu0HoENaNbMrC1SNVbte+w?=
 =?us-ascii?Q?2IqD532Z5n9dmxlm2mKafkECqYftvflPvtyyQQeW0HsacowGaaMMSokJ9zQv?=
 =?us-ascii?Q?MEX3eL1Qhg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gVjNvlnfJVQA/l8tFmSBlKvnNaF79oglY5LpN58VJlZb6/YqVYSEWVRFwIWu5ijVQK7EC8BUmBMyR5i7qW85rlcg6eNGwBJgMLg7xUILGQnPChHFv+0nWgS9HOpvgRPfQE2KeFRjgFK3EDYuRtccWurUIcYwE7f4ArbbajVwgnOuQccv3qQoM85a3O0dyTM2hyXQTpPzRAvjhq1KYo7+hyA5+hWDBvmksS9rYah6pjW8B76kOjQfqWXRSfKf3pVD2+fFmfPK/9HIhXlPD4UqaTwtRlfs3wxkQ/8AC/aBN8gu6zV9h7XoAxjN23pK8N0p4+F+SAztSiiDkII/DTL+sA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd5b1e5-3530-49fd-4c8a-08df15319d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 03:04:54.6788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2casMfDdxM5L7316jOxU/6bxWG/hyOu4cdA0ckPAokCdZGqA/lMhUeRf9qGuCY2suQ2650mtFGh5CUPtMyC2F3qh6CMCL6hr99Cw6j0wINo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF20F246184
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of x=
uanqiang.luo@linux.dev
> Sent: Tuesday, July 21, 2026 3:36 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; davem@davemloft.net; =
edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; tj@kernel.org; net=
dev@vger.kernel.org; Xuanqiang Luo <luoxuanqiang@kylinos.cn>; stable@vger.k=
ernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] igb/igbvf: disable work ite=
ms before device removal
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> A watchdog work item that is already running can queue the reset work aft=
er the remove path has canceled it. The netdev Tx timeout handler can also =
queue the reset work until unregister_netdev() shuts the interface down.
> In igb, device reset interrupts provide another enqueue path. The reset w=
ork may then run after free_netdev(), resulting in access to the freed adap=
ter memory.
>=20
> Although igb_reset_task() checks __IGB_DOWN, checking the bit already der=
eferences the adapter and therefore cannot protect its lifetime.
>=20
> Disable the watchdog work first and the reset work second in both drivers=
.
> Disabling the work items also prevents racing attempts to queue them duri=
ng device removal.
>=20
> Fixes: 760141a53e5d ("igb[v],ixgbe: don't use flush_scheduled_work()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--  drivers/net/ethernet=
/intel/igbvf/netdev.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
