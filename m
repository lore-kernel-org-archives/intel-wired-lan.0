Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A64C79F82
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 13:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C5E440555;
	Tue,  8 Sep 2026 13:06:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CGPQvoC0hYHl; Tue,  8 Sep 2026 13:06:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AC7A140562
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788872776;
	b=qgSCCW+7vCg5yIRopd7dSOUxzTNwVxumPrFpqQD5OS7mUZMZqrHlyUu43V4xtkqPv314
	 r8qj5r1URzH3wxX/sfMbKvdUm8Sx7IJDSy3hQp2B/Z5jZN2++xKIJ64v8i7EIsXfsnR2I
	 txlSJJMn6dM1ppV94aHcERP931Bl7Ao6AoSW+8oGjyyvDzAvGpPpg+lH7C2YznOWGB72a
	 fRQEvFSDNh4EtNOK+v+74LRsYWRi0+yViEego6yzEN2rIsD04fEWWnV7dSG1zHbF/nPDl
	 8uKc+jOxvY31o2yU8e3Bn8167TMig8fwBAFCQS5pYF6y4fIZlDdvSm6hfCXVn1hbRUw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788872776;
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
	bh=uBkVddoDNZqw2KaK27e7IpKuEq+TMra7zecxUsQprSg=;
	b=f7De+J54+BTdr5TfejTE/at+NPCtfALtMQ+lICMFDrHAYRCixK6w9M8TGe/2WnpXU5UP
	 w0lMXZnmJvWdtSbmQ4E9GfS/587fLE9leffwirak/c2YDQJjqWjp85beYwlbz7Q04bF2f
	 c2VnPLqVc+JcsBMHQTDXNOESTcIacINGixjqRTrAQYyi7U44K4nfiyrCArbDISuXjshaT
	 SSFnPxkG/tvPDgr5K6hlQroGonujr2KZYEGJznv5K3op8R7JjL2Jz1RerasoF7C6wHkaI
	 5cWFtcruylZgtK9fsIya15J9CVVfv6Vf2pn48xDMdj7ca/F3fydIC2wY+Kqy1i9ebIQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788872776;
	bh=uBkVddoDNZqw2KaK27e7IpKuEq+TMra7zecxUsQprSg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RCxxNrp8Lm71SGgdynrEd6gNgyiymcB1KYuLT7M/YN1XrImdHJ8gBjamMsFzU64qk
	 6kQWBttJQhtS8bqCiUEcgsJKQ4KAXClZHveMmOs76QX2m+iN4oz+IRdKuV7gyS4YCd
	 Jzx7mlIMvz6n0GJEFoZTPW1B5W5vz2gLD36pZ0fj8aIESP6XM1en4d8m8e2CQH3Qtp
	 Swo7Jmh/IkOLiDAZ4KKvNEI9DtgC0AaFYIs8XKv/3RvG/15S+/xWcb9yEEoZgsMYku
	 8k5UHT1gDi1iV+LLla7lvXXU1gRba66ITyscwmzlBcmvlgbMnvhIlQEcQJ+MQFeAIe
	 z5EtG6ElnLjOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC7A140562;
	Tue,  8 Sep 2026 13:06:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76B02990
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58D5F606F5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1pfiVF_6th4D for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 13:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8C824606DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788872773;
 b=UaKLFX3V4Bfg7qLN1+SpH8XXhsfvqTne8F9XV8gAA5XPx4FRppwTuSR5Iu5zxY4tO9Ky
 io5DiFJ/cUjlu9VUucnfzSXrt2cAsuoZ2Oo7uzDZdvmuKnE3093NKCbVO/V8MmXm5/J/i
 oImSrtIABjHtsf+5hlev1dTgIqX/6ID4TlfmimGZBuYAm3dyUwu9BA4vxsaxVOSq2bujP
 OqbLmWz7h8BBa3uV+QMOb+3JcLtZkYvMLsaX6s4Lmmpj+addTjk+MJlSn6bkovvA3qCdV
 G2bz4y4GN7QfCKVWeVXbhbW2b8rxZgrUSUuMfNJS1AFZhSmB/Nj38t8MeK9dzk/5byg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788872773;
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
 bh=uBkVddoDNZqw2KaK27e7IpKuEq+TMra7zecxUsQprSg=;
 b=hjOun/d7Iu4QXhJizLcMbSAxhEk4XwGqrRvohRGBfjsmJ2t+upuxmZqs5PxmF4BzlPU5
 fhzj1YnFbqa2PjmB6W5HGXBq1PhPaHmgTyvKOj4QXNyl5UI7SdrYe6CDZVXUab6vHqy9Q
 cP+00xWijjthT7/8vtsJEcRy01UNavEGrhzszAaOYZ6zp2xElbDWZ8gx2BMvkov+iYegq
 7HABA5U66XkePdX9fg+Zq0PvvnodgIeEZ8/ocGsTw62Xx+T8rqeFclFqBLnj6EtnQ4EV5
 NmpOwpAa+aBCPv4ogFn6sLew3XqdviYKHpGQD9E095xfM168n2liJ3PFVI0v87iVjmw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VTN0l7mh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VTN0l7mh
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C824606DF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788872774; x=1820408774;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NUAGtKaRn0v19Pk09B+UjXV+XQnqxItqEV4JezBG98U=;
 b=VTN0l7mhxjlQxKcWE+GN0jXqL6veZYMCBjIJsxp9c4FB9rYCQ/nWklH1
 ysV9udPjpH24wT8W92hzKS8QtpFsViiRmcXydNuLz0TrYDtutup+g8q9U
 Fz4Rg2oNkc3Reu1Ci8lvQ784QQkC89RwoVbb20FS86Ab5U3OE0lIb70DX
 7KMbjTUpHkXKOuP0tquAs5+bH0sgnegU+2NZT3VCZPVRJbiIuO1yJvdZB
 tar4pWQOgtpbjFWZxtJGx+3TZYGDrruDgkH+SnMgiclxgPrqiifTRrG+m
 4K0+MjPQQoDkJ0GKpp/DnpfJmb0hPt9DH0NNnhiOgtJ7CnAeIxhEE4L78 g==;
X-CSE-ConnectionGUID: ZD3ps/zmQui6+GuplAXLuQ==
X-CSE-MsgGUID: 1157XgxBRpCL9KTf/3Q5CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="93093464"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="93093464"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:06:12 -0700
X-CSE-ConnectionGUID: o1LnUZlaTjSXo0JT64faeg==
X-CSE-MsgGUID: T96YrsBdSdmnDvDZkLSIcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="269662533"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:06:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:06:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:06:11 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:06:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWeoa2vPeQsi4XvMFvZjVXexZkGZUxQXobZDpsnsKPzZH4ry1ke9wDSXqIoMvQBK8eLmTzCH/PgSsocQ+MP9LHKfLaGvPJdCMjVydLXYYsX9R7a3up52d2FOMrywpHGTYrIhaYR49QJwVqFo3P/SmUHPLoXWkCDo2dAS04p4ymW0uKQO4l3XpwNZAKNUmUaXJQ+5AS7blRQFSmv6dc/s+3O6GyOa1t2OS1PwhzWO8rF6zOCejS54i77vEQugTEaNnwMT7rGS3ttNhmLkrd0UuAq8ya/4JrbmBua6EpyOuh1hFR6BiY85uEkX0uikQSvzsCv3/ACctONhwJdSDd6bLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBkVddoDNZqw2KaK27e7IpKuEq+TMra7zecxUsQprSg=;
 b=pXrErv+5UVIk9gS1WZj1PpqRAK/6RFpFz9V223R/ec4Sn58uqkRjruYSFtZV4v59nefvUWAafSavUtVDqW/WLJxvcQL5liKXw1m8NjIvFJCIcLPJUC2JKeuPsEwz3IUwkayKnRozhYA1DbxOMd3BzzGAIjHAnDjznJcPaIEynIHCjl6FtNzEn4I4zaOfAqHEsvtYQnMbxgaCEHfO5jU61AOstCsaf8CzDBVauINI/9XIWYrghMeDOtoY+xI9BP2AEfov9zsL4Y+YdoEkWpU+391DTkQ7l7OXhDA+7sjLe5N8LIzCeJAJ2ZGp+1t9imm1fu0jjcyz7NxPRTMn+vfbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:06:07 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:06:07 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Yury Norov <yury.norov@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>, Prashanth Kumar K R
 <PrashanthKumar.K.R@amd.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Jian Shen <shenjian15@huawei.com>, Jijie Shao
 <shaojijie@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>
CC: Yury Norov <ynorov@nvidia.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 4/9] ixgbe: use linkmode_and() return value in
 ixgbe_get_eee_fw()
Thread-Topic: [PATCH 4/9] ixgbe: use linkmode_and() return value in
 ixgbe_get_eee_fw()
Thread-Index: AQHdPxOJ11atrM5yuke8h9sLXPYCKLbEpzrA
Date: Tue, 8 Sep 2026 13:06:07 +0000
Message-ID: <IA3PR11MB898697C70D1BE2234F11DC5EE5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-5-ynorov@nvidia.com>
In-Reply-To: <20260907215439.409858-5-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB7658:EE_
x-ms-office365-filtering-correlation-id: 4ff0c15e-e494-4dd7-f0e3-08df0da9f22e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: cx1mqbwWXasLpyiZCMpPEa3HdXdyWDKnTpmL08hmcWbxidccdhXFETRsCg3ns9ap4lxNbXGu45YknBUCdRbRClOapxSAQpXz2lMMf8vD8j70oP1KiOaKNuCYsxlFqF5GsKZJC0iBaf7Dkilr9wwTfiTW6LBfkfRQpSJR8XiM3cotitbNPuv42nNR5qSXOjFOfVbFK2YQ7l5LIEzyiuWwJjMeyfn8mWugIHtSjBiNHY71cmZe0dhBjF+v+f57vFiGP77mNmYIxRBiNLLfUVhZZ2DozK13maPQfpLVZ3GaaWksuf+V1td9dVOWCIf3Ee7+OxCTxXvcFDLZkkHiuXaBCkjWyGu56mf6BrSFOrQ/THCAd80Ii3DkRfH4epWCCf4AAyKHP+XgbMhxY9BnFIQ3Pd25vN/5scd3/IcC/rMawZ5Pz+i8jBFPGuBJDPcZZdEq0o1uaa9n8UL5MCUrtRiaPykFdkdM0YoRkAgMt6b7SxKXdcOI7pJDNS4rwOJxOzoMKsEG5iZq7nuC42DMz+Bn7qbCrf5Zb7lVs9PhitNjl02KDsrHWWJFTjkAJ2tjXgMvXJT0WHVhxjF9ZEgqyz3wkoh77vvBJhx6VsPf8oCBMNyGA8FfsLLHgqfEPckplWv8bTM1/ZcUAwMmY6ToQXkdMPzdvEySV2WEJnPKm/MxhOH/HcACvSBjW8fMDnC0anVi/sr23Q0gQW0gkWF4VFLHRZb3j3hsTLP3n0aJTkM34hw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ex9zYdF1DJX0TjImbrPH6luVdQj0kRkKBivi/CTYsggq7i3wxgngdjFsFFGC?=
 =?us-ascii?Q?zBDiaGt6FeICTklFV1F/gOjRdDDdmwgTe/Svg4ObNndYzCAfIJJv/4SepVzS?=
 =?us-ascii?Q?pyffdloTLxpDfIAv3ojkLAhTo73di0eMvB3hQW+sE2v/a1CLtaTF1Qj6XxlC?=
 =?us-ascii?Q?uoNRd/QkpXgF/g7p6tuBej7wrxZuBitKDwZJZtrwGVn2+zMA8mc3pZahdAjJ?=
 =?us-ascii?Q?Y1pGCoEwUQJzun5jxZbHDaI01Tz+axx7BHopqRondhckaSSuh7/FTAUd2Ul8?=
 =?us-ascii?Q?NY6YaG/oXwtQxo9OCJuL7Dvf8sBZQjMGI6SX2Lh6vMVkWktYC23IXtGfT5eH?=
 =?us-ascii?Q?b0/IhI6oyTwHm9BsQPaCxs93yn/x94IlVfL8+Ih0njoqYwLmV49GaxxbriiW?=
 =?us-ascii?Q?pdTB4UL3Q6jFvAyr8XQfr6L61C6sUqdn4wUnbV2cueTA1uS3Dstzfuywwg8q?=
 =?us-ascii?Q?QjM8xMcdcbJgm0yF4GH5lQJhDUhgZjHZ9eKc6NuSK14duOBfi4ZAQivRAdEe?=
 =?us-ascii?Q?fshObNYHUnbUXeU3zFHJ2sbcPTWmqitepN8TxXV0/xkc8g0LblXagzl9+d2a?=
 =?us-ascii?Q?f37weY2rRcgDUXxRBBH34fhE36+YJfWCsXK2GYKu5mEFaDn2jADWz2waCQoz?=
 =?us-ascii?Q?QvU+H25SctGcUPjHKwbA9nO0LM/k4koEmICd9HNS7la8vENdZaCFx3ckq4Gj?=
 =?us-ascii?Q?+FVANyDJOILjuPK5L1Pf2/aWWfs51ps3T6zxrZ1eLyraP7DOgcIVy2ad3CpY?=
 =?us-ascii?Q?UCLhTnCcHGafVtjr/hqbntEuFt7eitzl0qecYeK4mSE4xF090R2TrcD3jrW5?=
 =?us-ascii?Q?65WhqeSf6oIc5qP3m94vBDWqcSHVXZinLwWwSGwno4yO1GHYbMxVcv1xxtvl?=
 =?us-ascii?Q?8l4A63NKDpErg2tSeth9wjZPSr/N94Wu5QdrqqYQ7gC1aHKWxRENwKhKcf8/?=
 =?us-ascii?Q?TwMtVZwlHhnK6RjjxVFmgbAVKKmJCiPrX+7bhW2aWUSzE1q9uM0unewf5zc3?=
 =?us-ascii?Q?dek/kN9mcCx5i7TipsZcUBNC258PafkMmXZ9Dpu9Zuab2jQ+pJNs420py+pS?=
 =?us-ascii?Q?phGScnWRtYtcRXcRVMJrlRZCs0ROqNpK4xhmHtawoFJvbDr00B9hI4cGFXiT?=
 =?us-ascii?Q?hd13NNq1lIzHlkkM41/zD7Dg81hdWOPgx0S+E8FA1nb3Q3daH7swl5HotaBg?=
 =?us-ascii?Q?OO/2MszqcEh8/VpVzKEXED/Jx3aYrJ/Dm05OmUt8JuH7S03f4ujfZ7zqRjdJ?=
 =?us-ascii?Q?ixYb2DfF09KrS3Fi+Upsr7uOs0vdOk4UcXdLjlbFLFz8N9NbwAqBpbR0FNum?=
 =?us-ascii?Q?Lv+HzkGK+WFobM9OPORTzwh64ipeNt57uicc374io/DFyOnDSLRdTVy3qgmd?=
 =?us-ascii?Q?jCv/kTgWNOLt62Rm45g+o68LvB8ktcoBP9JzGf7Ui3QtniQ7x3GLsNE4D4D9?=
 =?us-ascii?Q?tEd3w4uE1A++pH6I0z4JEs4Kpt/5KQKxMZATW7sSeb+TE7y6Oxuv+G39eamd?=
 =?us-ascii?Q?q0e74UO3tCywv0EPgDib5wADHAOudm599FlmYJ3lWGuziL83N7Q1tq4h9OXZ?=
 =?us-ascii?Q?3stYjDEmdx8M5cnaJ29EhCUJIHA31pH1qjz3hijyw4hCuLeGRg0zS9L6AdI6?=
 =?us-ascii?Q?x/S2/uQKC7vGgCnkcbRy1LpD9796TKbN99/Es1KTpi7R78p4wu7wP2jO/frC?=
 =?us-ascii?Q?6zC35fKeMa4kylCSfsPZ0cfe9mnmBBtXBd2EF3Y/39K7IL8R/s54F/prn2bU?=
 =?us-ascii?Q?aRn07eaqqzkBq74nbhMOII2+X1ldl7Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EP7Bda8c5az6MjlIciJK/O/obhPUC7TkRCGUDWwnStFcSK2H8yZJpm6j6151bgseev5K5A3xjnnB1PFVwZ21CeOZRuBcsuff4/qPgooGpNQw3wNgCQ9la//X0AlUhcRKZShJh+W9IRbgjQwZWHUmmcH5LN9nb/5FiO2QBNlQQ2nFdiP7APFHA4LZz3k/NTPf4KOev4WIEkG5wqRfQTrcGSXXWMz6ktUcoaW2W4jglIyeJaeUI6hoFvXRzA7kqX74mS0PP/VPrSvGYfKCDIxypaxLGVHUNBwYK7M/JTbxdgLOGlFh/0cfqT7X4gfOnwqkDCtN+Mup8ny187AlPfo8EA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff0c15e-e494-4dd7-f0e3-08df0da9f22e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:06:07.3256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+ihZonlnP6z1DKhjkysaeThdKDkhBl+96HdcVXvXOmX/bf8YUNJtVZFqGuAH8GWxMk/TG83Is4Qqazs9JSDyj7ZZdPsEh2f/d5SkSxk88k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7658
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
> From: Yury Norov <yury.norov@gmail.com>
> Sent: Monday, September 7, 2026 11:55 PM
> To: Andrew Lunn <andrew@lunn.ch>; Heiner Kallweit
> <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; Raju
> Rangoju <Raju.Rangoju@amd.com>; Prashanth Kumar K R
> <PrashanthKumar.K.R@amd.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Jian Shen <shenjian15@huawei.com>;
> Jijie Shao <shaojijie@huawei.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-usb@vger.kernel.org
> Cc: Yury Norov <ynorov@nvidia.com>; Yury Norov <yury.norov@gmail.com>;
> Rasmus Villemoes <linux@rasmusvillemoes.dk>; Andrew Morton
> <akpm@linux-foundation.org>
> Subject: [PATCH 4/9] ixgbe: use linkmode_and() return value in
> ixgbe_get_eee_fw()
>=20
> Use the return value of linkmode_and() to determine whether EEE is
> active instead of scanning the common link mode bitmap separately.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 36e43b5e88d1..a7b7f89f29e4 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -3751,8 +3751,7 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter,
> struct ethtool_keee *edata)
>  	edata->eee_enabled =3D !linkmode_empty(edata->advertised);
>  	edata->tx_lpi_enabled =3D edata->eee_enabled;
>=20
> -	linkmode_and(common, edata->advertised, edata->lp_advertised);
> -	edata->eee_active =3D !linkmode_empty(common);
> +	edata->eee_active =3D linkmode_and(common, edata->advertised,
> +edata->lp_advertised);
>=20
>  	return 0;
>  }
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
