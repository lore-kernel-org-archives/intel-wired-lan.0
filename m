Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782D8CA5FA5
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 01:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4203B607B6;
	Wed, 30 Sep 2026 01:18:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xsG1MKG1UD_s; Wed, 30 Sep 2026 01:18:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A568060830
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790731101;
	b=nyhMPxQefnAhWEj8g62bE3N0NqpS0mKjw7QFV4hGamUY1dpTJ6iLa4DJeSqCZqDjTncf
	 vg5uRP5o+cSrpbTLOuzvq+YbyAHzGeck2kNmuR2bNXJDYiGYxM0b0QZ0TtRxvjlCb1UhF
	 qLBHOsDGGVxUp2n01JkSR3E8K/zLzb2UYPlG4sMFmU4u56SBLSEq6d4IqCDGq8DwrX/Rj
	 yPp89RURREDCVufHA4YaL4qfHzq5fwoiUau2mv6SVG5D+fn/3B9fs3HrAypP7epE8YXDm
	 +yE612KV3J7zm4VYP/xvoKg9Sw13RkoqgG/mI1MWpuJ8C/xOZiFIumKmIELTq9aBbAA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790731101;
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
	bh=A/bNGfuKibBjpg0QF8GdwY0c5qWyMWCkxhHtOkOK6LA=;
	b=q4PrxNaJZke1F/qg9lTzSVx4ave8r0DXmliDXHgSzsa1dXmDhXhybm54y4yQkBfU8rZu
	 U4FmJFs2y1e6hrSDjdp74URVYeaAm+y7OhjvVGQYueH4kB+JlMN28zvy84WwccNmJlJGJ
	 umnCkqCTDZA2PMuw16tMZBKoyjiCHaoKjBni9DEVj+H2er+dMu2QfZkA1vvKOxAHKeGdP
	 15ZrkhdIqZioFiClTBVp++FXDuu1acAk6yDwOorIKrMWjvNsD0A9Kn3I9PKflad56Aepl
	 upZacA/O6c1R+6d6FJUz2Q02EoHO0QmOYIkANVo9KRjs3oNQDRa3E+2iXGK01M319Mg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=evgVFTLN;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790731101;
	bh=A/bNGfuKibBjpg0QF8GdwY0c5qWyMWCkxhHtOkOK6LA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S5SXTSJaH154Tbcc2Ka4s+EBBMLuyRN48w4VOuTM8cf+DByyf9bqZu5H8K9oXg77Y
	 xq7iNTqosLf7fMYXVTR8aL46SYwWTifvYFKLx1meuRrES8Q35khr/JIxcmuW1LUySi
	 GdZE+e6Nj5Nku/wYa4bvTPDqxeRoxsurSFBUduqMK+gBVQ+7tK0OYQ8QEOGrwNX7Ys
	 d3z+y2FvUHIX90hKR3Ty6mCwzW7pCScE0rjJwD36fwAub3DvTPaYEYMEbapGEZ4VJ+
	 ATVw1L2UM927QGq6Drv1EAXX0U+O4nJxGo9Gv3IzNPeoEG30fCNwB2D7EFqwrWWXDe
	 WeBSCV457VhiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A568060830;
	Wed, 30 Sep 2026 01:18:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 17210282
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08CA460830
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VB7aRBm-n0vP for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 01:18:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3592A607B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790731100;
 b=d+OirvwU66DA7AFsINhcxtjVHe8MHECs5NJr/mFQXSLMl486crgWRpnXTkPGBB0xKAyJ
 6prKJk9OgwBwnGZ90SZTwLm3M6ysReV4XMoeheuCAH6lnivhYfX1FNr88inr/alcao7Ot
 C4ezs6I1d6cKr+51XGY8OU02qgFz5PR7zu9RMEo63vLstRo9tKhKBbJdVgY11bqR089NJ
 gzKICn47KoToGpnsglBi/ljdwiX2ewedAof5YJfvXvkRn9yXJh8KgmdNl/e6kNcLLei9O
 qm1cgTs2c67/MfWL+pX+JCR8T3kZYcKPWijoDDE3isSeO6XQZ4+ILrPMZno2y61/jBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790731100;
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
 bh=A/bNGfuKibBjpg0QF8GdwY0c5qWyMWCkxhHtOkOK6LA=;
 b=LtQk8fvSuZtgxWeMMW7sY9GfZEpE+FgiAW4/LpgP30H+StNOMe2bgybhRyVAhXpG7Dds
 4/uMc1CLF5BG3h9+kqft0DXNM12viCSAQpoSkM5KwNAgpVsl1nWqNPtxpohQ9s6Oj099S
 ygiOZhz1l0sw06lQPNqrkr3Zoc0Q4XBXOwFM7958hISeoo14tMge7G2QqHBNiKx8dTnkU
 faFHKu7qSuV7cDjSc8L/ivoObZlNF1cc81EaHxpxowZRt+vYRKFZauM8IaRI+RGpgsm5V
 9B83eMopIOO/JrU54bZ9bypzTM+l42L7TmEMlX4UKRyDX0hWQgy6s9Mk37N7nft7WuQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=evgVFTLN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=evgVFTLN
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3592A607B6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790731100; x=1822267100;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZDESCISrFL8io4GyHUYrt4hvuasMQ0WJX4a/9UT3XGI=;
 b=evgVFTLNUOqc7jQ3o7xUr9fpwctiCPKnNWSiOqMWp/bopoUVwYD7ScgL
 O3iOqPdOhtNKUW0Z+VwIkbYWZy7ehGiuVk9xyVdkJNglvw06o1J4U0nsd
 S1PZ0ZizNbtehdowCOV4aLtvgB3/GeJ2XHCT1aNNWBpAWJDHdi95cofZe
 0K3lqeBSd0BH0UQIHGApnUgXblGepAVp6gdOXjO9Iz2x7d2bYAwiA5Ai7
 0shbaxGQV372fuRp+dob51nyDsRIaRxblsvw3RWfmLAIy2AQ2nYWDR2hc
 ZRtmXbiruO738cepiYlLdVCMwOjKCp5fLhYyniu8qnAvixAEi9oRiara6 w==;
X-CSE-ConnectionGUID: SFhxOvQ4T8aUjx52LZrPWA==
X-CSE-MsgGUID: P/dskehGSr2MFt8rmZ60/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="116990315"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="116990315"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:18:19 -0700
X-CSE-ConnectionGUID: PQSwiCsrTJO+XgeHxayDog==
X-CSE-MsgGUID: jIvT37unQmW56KETk+wKpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="275573111"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:18:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:18:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 18:18:18 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:18:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elIHNo7Ta2BkOd8FhVtQb4Lda6u+JU6yuhwurpleNuXA1BE77oMLNglA8tTCdBqBVRSoWFf9mLcc1rM78MiE7wSa0xpKkxP1bd93hDPIc9GFM21pe+fYEQNoE7J7fDYDx7YRSlDyctiMumqvO+Rv49WFRicnCrje0w3sZU3M0OCjafueqzXO7koORQLTn+D6IokJdyFNfxtoOIx5hP3aOOtf8lo1HHI4MgTBUcyi3rpE+19Fwnaj84z74416UQPB5bWf64GBeLA7d0RFUN4LJT6PKdJBSQERsgv/15Qfh1vg7q+tZetaFhrPvCpvzIHbytqroFzSyRRE3H68xS01sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/bNGfuKibBjpg0QF8GdwY0c5qWyMWCkxhHtOkOK6LA=;
 b=chk83l2LWKU/DQweRUVCQNhKNQn9mxPzVxBllIE8Gm0qOTvQJ1mgl/pmG70m9ogaCIzJgXb9p59IugVQJ9iP5Ks8ljmV7uc0s4Eht5zqc1zOAAcUg34XLZwLubr48iQ8xtbT2PfV8SxJrDLIgPo5FRn05nSEbX62kNwQOI/Uid+Vane3iIMHbmpT07l2kx8AjTgcdP6wYjJXQm958zb1sItyQK8EFrfAmMt73lYYGuzkJkIxpBBZhYXX29vzrtiT0ViATIixPCfaVpz3eRFs9uTovi10rJQp11S1M03twACXZc6pdRY1kLOeocLtGzjrEDSIOw7PFFT2Dp0WGweB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 01:18:09 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:18:09 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "horms@kernel.org" <horms@kernel.org>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>, "Kwapulinski, Piotr"
 <piotr.kwapulinski@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 5/5] i40e: fix races in PTP
 external timestamp work handling
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 5/5] i40e: fix races in PTP
 external timestamp work handling
Thread-Index: AQHdJKcgSXsqRXd78EG2Ykb99sHvVbbmqa5Q
Date: Wed, 30 Sep 2026 01:18:09 +0000
Message-ID: <LV1PR11MB8790E3EC557F549B60DB5474908B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
 <20260805065132.148625-6-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-6-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW4PR11MB8291:EE_
x-ms-office365-filtering-correlation-id: 0318f9fb-4812-4e9e-0db5-08df1e90b075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|4143699003|10067099003|260925021911599003|260925022911599003|260925021311599003|56012099006|11063799006|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: lU60kvxDyrRVtqSMzkWlx5MgCDzG/ZxcgSNMcTKfK8EZvaSkj/meQLTrkisnnDQjTwtEGug1xUCpKw/1zeAGmyCpYjzTt4LXXJo1R7gUoZ50tK27j6EDTn0VQEI5LobAkUANf92iuZDTpFsENzlVOr3I+1wdgaa119N1cU7Tuxc2OJe1N+VauHGW7YiH8x2NvbKeXNbSTs/3PkcJgB5hegl0A0HCMvcolMIWOJwk+AtEDYc9MgwrqgDEqXPYQcZ7+OfIw3qmkK0sF2kIyJh72ADU+f03Fr7vle7jcinkaoB+sutoNMN1r1KYbWC9UsPcENsVgNvasKBlLF3eV+f3XKxn+LdNwF4Cye+0DYqhApOEe0lGk+evNnWyLTVhXYtQ4NlBSNJeyzCj6b6Uxh2L4khwE8NxLmR0bjpCOF9jRZDWiarF5KvSxJ3d5iXTSQVcTI9B42yJ+Kshc+RAUx6T+MKbufeRHsDV2kEcGi/1yW2MlHLfCPHvz+EVoxC4t0EjStwTCXOhouRytFJjRLZsjW4m+V/kpLfOWi72/9Yb5FxhVVFuuPCpfJLry97NGFa+Z3y52j3PKX4cWE3xYswyWPiu/eggBtTucKQzUabz1v9k+5n0wFVylj7KXFdIPqKM/hU7lvxyZI9bU+RY3eNv30H8z68iRmSZQNKDSqBU6QhLIWttdmGvh9/qF9MQtnCKRlGV9UwVhIZ/K/GoUjIetQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(4143699003)(10067099003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W0xhuaTWMuGA/KI3jLhvXdtqt11AAWddNV1LyCEIlz4l3XZX0QMJdXigNQlE?=
 =?us-ascii?Q?2SG3mBt938AcC9A0qJVIsqKDA2V/NZigJDIQRTMwamTe4PwaM9/pie19VIAL?=
 =?us-ascii?Q?aqWsqvBVNnSqALRdloFp/mjin6/OXeE0gQBx2PrpUdbV5ERh+/FjSwbd2BF6?=
 =?us-ascii?Q?E+g7dqfQiDavcg9YVEgseH0FNfobHwjZZd1si8veLaUPdxTukUoqgDVEaBn8?=
 =?us-ascii?Q?mxbcVJqTVfDuskCleJI5RxwKKmwhMOnyyES1jh6ZZa4hBeMMOv21Afw0l4rx?=
 =?us-ascii?Q?THEOvr1RtEsxv+oHk4kepCXUbR3fnSJu20nBqaspFvmGhhBaU9fLCnloKFtH?=
 =?us-ascii?Q?JJjiyUtLZC8Urc1FrF+eW28NDEFanGirLM7J5XZX2e+XF3oCJ0QbHFanyWsC?=
 =?us-ascii?Q?sLGXuPaWuaXA0NNWjC8sv5dWvRpeqpfakYZileRKu+vvr6qX3gUU1eMKCOTe?=
 =?us-ascii?Q?oJGrdbBLhuinD9ISmCVooO2gw6mraDoehhrN+plg6c3jYsRqkNtLd4C0+FWs?=
 =?us-ascii?Q?HsPRXl9QbNy1Rsdvj3f8GTBRyMofMRquVX86FeNgd0OnpLcxLrbcwKSFvipK?=
 =?us-ascii?Q?6KMhFLmQV9It1ALHOQnaSguMj1iwhCqT1RqgTQ87uWmECIgk3MQNnLQe20Qo?=
 =?us-ascii?Q?1nQQ+hEknnGN/AX1YkM/mbEGt4b2Pd+5COfB5xLDZeUs6BkK/MYzTdnqTIFm?=
 =?us-ascii?Q?ISc3KqdfiKKfXiZCUX6tgJGNY/2WxBPManIYWdTmUQJ3wNRV4fL1U9zwHlsy?=
 =?us-ascii?Q?MoUUn14mDDmPEyRhtpD7abIJXm7YRdAcLHO1HyA6LzwdUmx9HeulL/c4efZG?=
 =?us-ascii?Q?pWXBqH+J/jIaVSXkRX/riYBRWNyNKCH/QD/hboCx4PQu4hbSH62XG6/VYiYW?=
 =?us-ascii?Q?vBWsoCiEvOuKLAZIUSvtTJYBTDsHaCqAw8N2jv1qi0CjJetnZVCPmTjSYMtV?=
 =?us-ascii?Q?XMhcdH8q8FW3AH4rExO/ooJAJ6+dZc4beIv3vxMmI+bcb1YYkK3joMcT3KoQ?=
 =?us-ascii?Q?zHW1Qc7LBz9XmYmvlMBMNrQJSqI2xREhJBh10Lw0fohTBLNBxXgWV5h9ktDA?=
 =?us-ascii?Q?BqrMUKYq+Smt3sSvH5ghQbleMpgQPF7sPd1+cWvO6MZgBf9pe4KdLiGlueXf?=
 =?us-ascii?Q?THxCezLDvsjknBhzrvu1F9dw9SZYiIckFIUNCEIJ/hi+bGosWRsyt7dKH9Rb?=
 =?us-ascii?Q?ub7O1Wv6XqyeqcbJNTLiT31K4I1I4aTbMVTnK0Z2kQZ6lCxq1ixrmGt7NHht?=
 =?us-ascii?Q?0/2r40t9H0p7jBVLh+4z92yoIZ6aqaz8ABobfHeprw1gT6MdOv+BJ/gdu0th?=
 =?us-ascii?Q?p2vsqBABlJ/PN042DfEaBTvQvhhor+X3NfobGTPKvnoq3e7x0xCTU8ZgI90m?=
 =?us-ascii?Q?RV/MwK/QmplcFfKIucSz8ANxFWabU3OAh+QgEt3QY1kakA+2KAOPcZoLBElk?=
 =?us-ascii?Q?v34U+T9i/p03wF+yUbMu/Ce8xp/HbU6oMwvyJzGljWugqpCi6x07mFsZ75pn?=
 =?us-ascii?Q?6ZZKDUKWG36A2EPcmp4gxzwmJjRN6xZXryKrtQlx9NfYpX3+VegOXW3gIwY1?=
 =?us-ascii?Q?U5NVdsvccyX+pO8dZNqF5ZBH8bc1Em7J3hERVLKTNTYzSHdraqPcTCekpZ/8?=
 =?us-ascii?Q?2Aqjb7Q41OX6S6qBPwJN41X76qgti9rOpNbbJ5jmAtTHlwUmpaRRsMhL2doh?=
 =?us-ascii?Q?p3OUwWwXDppcILNw5bOBwFJBND24J9xoSp5C0TPLzaD+WKwJYXej7xC2T+vo?=
 =?us-ascii?Q?dFuAJIVFpg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Uic8wdhSA34daxWsvl6RSaIqvwM6oDP5o/GdEtbNAIolsZUtM1du9X/RhcDaBM4lQHiRXRVJ7i3ZvOlNWRiP4Gf5cdDt1zLMAhY8d2dN3Lk2XdMILX5Y+ci1eEEw1ysc47GLM3T/FcCuqxBDkmLvSZ2woyY7LLMIRihjLlwN2aqNXKvor5k1lh4tFJRdhqjBPgvpyaNdkIseGb7RB8GcWuR09F0insplNQuRoPC8Vfs+NSM5liSZJXZlDr2QoMncnTh25sf9fKwirVbjEJWoUWyZoZ3Dcl6IJt1KMYpbIPqTKZROPANMh/mzCo07CrtsCYpvTYJvuvp+E6Z91qAQiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0318f9fb-4812-4e9e-0db5-08df1e90b075
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:18:09.3862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9OsNnD6D2bRoDoupIZ5JcFULxeDJzGTVqDeTs+AHZvIn3T2u5lYaF+0ze50g+543t6/SsG7gs00lQq+V143KZlFdkLb1YV0kdweHBHQJTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8291
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
> Sent: Tuesday, August 4, 2026 11:52 PM
> To: intel-wired-lan@lists.osuosl.org; horms@kernel.org
> Cc: vadim.fedorenko@linux.dev; Nguyen, Anthony L <anthony.l.nguyen@intel.=
com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lun=
n.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@red=
hat.com; richardcochran@gmail.com; Kwapulinski, Piotr <piotr.kwapulinski@in=
tel.com>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Loktionov=
, Aleksandr <aleksandr.loktionov@intel.com>; netdev@vger.kernel.org; Xuanqi=
ang Luo <luoxuanqiang@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 5/5] i40e: fix races in PTP =
external timestamp work handling
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> The time sync interrupt queues ptp_extts0_work, which reads device regist=
ers and reports events through pf->ptp_clock. i40e_ptp_stop() unregisters t=
he PHC before disabling the event source or draining the work. The worker c=
an therefore use the clock or PF after either has been freed.
>=20
> Move the event-source shutdown before PHC unregister. i40e_ptp_stop() fir=
st clears I40E_FLAG_PTP_ENA under ptp_config_lock, so timestamp configurati=
on cannot re-enable the source after the lock is released.
> Then call disable_work_sync() to reject later queue attempts and drain wo=
rk already pending or running.
>=20
> INIT_WORK() is currently called from i40e_ptp_set_timestamp_mode(), which=
 runs on reset and whenever timestamping is reconfigured. Reinitializing pe=
nding or running work can corrupt its workqueue state. > Initialize the wor=
k once from i40e_sw_init() instead.
>=20
> Fixes: 1050713026a0 ("i40e: add support for PTP external synchronization =
clock")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +  drivers/net/ethernet=
/intel/i40e/i40e_ptp.c  | 25 +++++++++++++++------
>  3 files changed, 20 insertions(+), 7 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
