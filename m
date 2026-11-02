Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D1606A324
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=wa15xrvF;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kU1x5z7J
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B026380D00;
	Mon,  2 Nov 2026 10:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQDjBwyIukT4; Mon,  2 Nov 2026 10:53:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BF5CB80F58
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793616810;
	b=MVQ1qi9MfdilAriVqRpWBV23QhsKNbyLbPizWdYH8L1VwOqlSLZ3FkM+1S9+2Bf0NepA
	 YJ1vnTyh2GsOuLKJ43VaibdCf/1A56fAnLskIyhdQM8zizgW4ATJ+FFiA6qS9nz7cwJKb
	 EWx/WZ7lbIS+GKQCl07LlMqbnZpEwvNVZhXwYz5xmMfKhamG+VBV8oKILppT3fNw1Yj72
	 LAUEoHC3iEu9x9c4D0XPkPKdkp0hR+I77OswC5z+GfRX7BSp6IdpfJ9OYAtBgSXYhIcvc
	 aLvrErnwqMOjfynZT7ljHCcWmNTl1EI5sAp0D1v2eUT2OqjVLFuSyqlFPw8WSDxPIqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616810;
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
	bh=jWRS0pJco3dFANtqA22jpOgt0dfPHAY8Ic9SmXFZa+A=;
	b=RlrzbcFTa7sSPqhZXND4fhDToV5pFom4HtqobDg4B9vbkaIqJEfuqRXIkFFCC6TVTTEM
	 Q/bYDnJpiiPyFWl5QWYTgvm9qdGo91NbFyO2U+mzhUvYzVlmRP6j7QyurH45s0F03/PrF
	 9ga82QHfL7EQIatXGVz09cBNsZTSniVqfBXOYS0qrem/ZQ7eRB+GkXu49UDV0aPdCGe2O
	 IsuotawzWtoIhGJ/Xp7O9vtGGPT2Jv2kbzUjAFYdwoP9nXTtX2x2qH/6R/fqFtdj9qv3a
	 AdRTE8VOGsJnrvIc61ZeBEj+BRypjkoH280mypYdFU1yOS6SdgEof6BRLInpCkbuAVg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793616810;
	bh=jWRS0pJco3dFANtqA22jpOgt0dfPHAY8Ic9SmXFZa+A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wa15xrvFTjUMUAqK0PAra+M4DlJdxZ/80jH5YLofqjdYlmmdG6ToHwXztnq7sSzAq
	 4f28HDcKvVIbNi/zanwYD2/jKYRW+5DBYN50W4zdMvgTFU6FIV2x2gWYOo26yKxqVc
	 GlgFZRM9SflGqQ2KliIEbJg3bWsdQClfdTMnoXMTWdFx6diJSoZbC7sdtsm4WEfHZe
	 gqMkztdbNpEpydIJgYGPrYZ+k+3LtYY285bxrWqecIzg6vSm9yvLDbBuB3si7ry0a9
	 ez+xkqwn/d78WLo7zIbw4lBZnBNEZfhGq+zA8BLz4I58YhDneSDKiReOoL6GOtgs18
	 xVrv2CBhMT00g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF5CB80F58;
	Mon,  2 Nov 2026 10:53:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B64AD362
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C62E40730
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:53:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YqCwzY1j_fUw for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:53:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C7EE40719
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616807;
 b=N3ti3dHETuYdx+QJQNQql9x8F8B+jPWGkxSt5RGhIQ6dIDRHTWp9Ks0Zkc79oXxpEy+/
 oLOsKxVaGnoSLaqZ/4/k3B6RZGFCwTbP75AsL0wlifYbniw9ixbKRbMmo+s97o2Ckm52/
 nM2BsQKSYZsjJ8kteWhWm0ooz9fLwDqowVIPoUC+r1sxPYl9vO+P7FK1QWhvbsxS8Cz6V
 xf4sG2YTrorH0TS+yFmYUu5UKJ3iSC/Te0am7OsX4uThWry7vz4AoGE7iSKshCbphEJ6o
 CV4DDkAKJDU/VX+7V/L2vUrTrD70fK3QOjtZ1KXqP8ZdNJpmMEWjYZjplsyKCUCUrtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616807;
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
 bh=jWRS0pJco3dFANtqA22jpOgt0dfPHAY8Ic9SmXFZa+A=;
 b=PR4QVpLDOGR3TkK4gX/W3Dc6IB8FDHzD6P5CCc76eglIw45dtgN4uU6daWI8vhc16GYk
 oIxak9SUw1EICPw1TAAwkpJVyPbEcGoJ8ohmUMD8F4QkR405aFjYQZPQV3N4opERgUaNS
 Qyd0NBLdBwZCJVjuzols4Mjr5OHA23Z/ApwaLVkH6EVOrvVkjcDWr+RdX7OBf4ZTVzY81
 eszwVkpmm4DPdsuaNV/83t8czemu2slIpGgb4BjI8Kvk9Z2xlEOAtV3Npjt5i9T0c5o2e
 n7sV/GL0vFbfeh5Vav+LfDyWMjq3P1i3KMWkoQSQqcgbkZinL4YlOGhpRip6r5cdcqw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kU1x5z7J; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kU1x5z7J
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C7EE40719
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793616808; x=1825152808;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RdCIRaXnIRp3yYnEKzx5uw6xVZRutiwYtR9yIj7cx6k=;
 b=kU1x5z7JodtTM1spN3z69oAX0rj+lIiqu3Uy/1M/QaksYpV2oLrtbJng
 xoEbsHWIbfngjSfUny6kichlAL9/jupFL9wydgx1zL03l2N5NEqoxVOqK
 g86k8tL55bdyhWdUy4SHnBJklz2wgsaM9axA1WaTus8v4AAxcMzJXVwAU
 OZxJ7l7Yo3uzZQtZsqHIXx+ROUEtxh6F/xtbt01H9CmFZjLCzKe+qf6LS
 hxMJQsJEP3HrPbUqPAXnunit40z7ubqC/GExpobdf4eQEKLvKKKhTGMkS
 CmJGHuIcfGVaaD2F8TGwRR4doJiSn2eKstdGNhe55vONNeXhZ/OPnakcm A==;
X-CSE-ConnectionGUID: i5zSBALKSH+2U9FGPx1U/A==
X-CSE-MsgGUID: aeF+oN7xTiqqlG/lvyFO9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2336389"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2336389"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:53:26 -0800
X-CSE-ConnectionGUID: BeN5v/z3Sn+k4hC8DyslUQ==
X-CSE-MsgGUID: +9W1vOgFR8O4bO0VN8t8Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7864298"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:53:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:53:25 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:53:25 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:53:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWbuF5TciNSaKhJCwY9exvN/H5IZaBvs0TrkYtMswD0k8MBWgeRtAe23dmcvzWKccAc7UgQ+RA3m6hApNy2pWBMbVBOp7KNJL1uZo9P+vi9CggukZRFH8Y2xrWX3+6gfTKHit0tNnjXl3mq4HzI25DXVE1viFT1Uam60nHDKasXySqD4XVJBwR8p9pbAkOdD95ng9DDmGaBEQ5HPJ3qGXf/e0MfAQT1v/WTZnA8rkmTbHYEj5+XlO6NRbkuP+qbZqSv7dbA30tMRkiwsKyFwZ3crpR5ur7aDfj4F4knjqrWzSJSuvr1rRv4gzti3hWw1Jee0QSeGyi2qWh1KTv+UrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWRS0pJco3dFANtqA22jpOgt0dfPHAY8Ic9SmXFZa+A=;
 b=Y4hF6Y+QKDSxD0nW4LeApcMLXo/chfw03qivNGDbBo6A72RulXftuJpdIxwyRrqStgRwJXuSF1X4BbzAczDJymQFx7Jp4UXmzTPaPHm2QWVo1Nz4X/FXPThwgS9RET8gP+XY+J7kRXlHuT3qrcSwNwzYibZeLL++60R7zZgQ5k11JNxQJHvhdp48ZlQzohA03J9xqbBa9F8mZLUO0L5jJyfnEGirK1JAwmGuuzdURhbysHDZTgl7f4+HSvP5I7zg8+zdP8Qlc3fcUWlmujXtFFpLlxvrp0GRGfCKFUnLwN8FFtm3QnzZxSHRyaOwBK2AeZPIHOJxHEJQvoAxOTaITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CY5PR11MB6416.namprd11.prod.outlook.com (2603:10b6:930:34::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:53:23 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:53:23 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Yuho Choi
 <oss.patchbox@gmail.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: Simon Horman <horms@kernel.org>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
 Alan Brady <alan.brady@intel.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>, "Burra, Phani R" <phani.r.burra@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2] idpf: Fix vport IRQ name leak on request failure
Thread-Topic: [PATCH net v2] idpf: Fix vport IRQ name leak on request failure
Thread-Index: AQHdVCuj1tNwRkH5u02F+ksIQdR5qbbuvmEAgCwJ9iA=
Date: Mon, 2 Nov 2026 10:53:22 +0000
Message-ID: <IA3PR11MB8985D32D84B8D01631E7BCE58F6A2@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20261004180954.163789-1-oss.patchbox@gmail.com>
 <IA3PR11MB89862E926E53936B2C669FCDE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89862E926E53936B2C669FCDE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CY5PR11MB6416:EE_
x-ms-office365-filtering-correlation-id: 8b9cc9d1-1291-4dbd-b3cb-08df38cf83c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|261021121427099003|261022105027099003|261022075727099003|261009223027099003|38070700021|261026140227099003|261026121527099003|261028144727099003|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: i51NAo6Ngq/g2IWQQ7Axelg1GElvA6O93b6WKgsa2WL7aDQmOuh9UyLzdT2/096gkF5/v3Cn5ersxv1Gv4y9iacUxvA3mnRoKJQpxflSVi0wXobTVU1yxUXRr83AxXAL3rP9TPL2bVomb3VE7gGN/1XizezFv7jLvV+YmsKeSrCJpLo45nhZv5QyYvaR2ouHn3xC9xYzHWXLfBQlpw40q9GUSPKj+5mws8vjSYUywnQvWt9MQdfaIxoaMRMQTHleebRIZCq6vSrbaZcxOy+xyLw4BwYY+0daxb4oeU6OXBt83nFHcMj+uJkvGmmb9Zoz1jSnHucVNYJFUyHpMBAA4jB+vcK7Xjh5hZMN3EN8sjFBfa5oCX+uWxouz90RcpNO97vb8yYuAf0/WR+PEWXg32mjmWtjZZ+GDFDkBOkKxS6avEe2RM8YG25vi8w9OpNTQQaYIZXs6RO5cPccHb9ZJ74QgRkuoaeEQZ2hnGcmEo6pTalTB+CkW/P/d41vH1pzJuHOlhnEgFjqAmIssa9X8jUDapXMssyfR+FBzQ1pXJbwr3yIzzdZIpzd4bwIGv+0TcZ/TA4xhX64NQRO5gvUqKbM6GlYLJQlNrOWGCPhBQa7/TU+1OlKIT/mHhP/DAKs34m3dJHbxjGUO+jjq7axqiALaAf8o3ncNzhSi9WmYQUCZqQUjmuuFy5eWX4lKWvT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(38070700021)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bnVan2nYAfMBYtrvq7AFufrikIKaMiTSPmCUva6Arxjiu6ZotI9u1/79PRFp?=
 =?us-ascii?Q?nfor2NH7QLC3apPuxOzWtAPDWilJSdk1mQIZUTUA1NOC/nHM5jMjh9mnGPPY?=
 =?us-ascii?Q?ZdHbeEce9tYt1ZKm0QClOJ0Tc/5vHPH6KPmZSpAF4GqruZLgwwrHu4oi1FyL?=
 =?us-ascii?Q?c2dnf1k820H0RLwiEgufCTqvD98+aOIE+JF5zIO5gt5R4nL8ZeSHURux7pkf?=
 =?us-ascii?Q?bHBU21qIDXb5AQox+xfX5RZPvRcglBj2XNATzor7xzYd+53BrZd7IKjIcUld?=
 =?us-ascii?Q?riRJZP0nU6ch3qX5Ll4ute8RWATL1GFgg5RRrmyrOYZACB7xANVHp4H85exh?=
 =?us-ascii?Q?cwY73DemHSRd6X2LrTyRHGMKwKmMCo0hzzNO5P0LxKFVw6Ufl9PWdrQoaOBe?=
 =?us-ascii?Q?j3MpDZGIcG4lZjmMJliEDSnsk6GK98L0OCJ6cSNFyvyl76WYvNl1Yk8W27yh?=
 =?us-ascii?Q?DvKTpAJodUQH123y8nRQ0jHfMYFasWXqA7WwbCNuh96bWVTPmjmI+1YJ5o3t?=
 =?us-ascii?Q?nuVj/0YOIlSPhuQ2Ui+cD2sBLW/lyLbDmxK+qIjElhdOxTyEfujIrY/24fPU?=
 =?us-ascii?Q?SY5xqz6THP8i4FbRoR8OGQ0VIUC4w5idMHHuPFmw+rb+IllRLD/JDK0h7qtD?=
 =?us-ascii?Q?AS5sb6FJ7rrsmG4gHyqNVmp7FWoF98MMajJkfglxIxxipB3bUDR/9IseXjFM?=
 =?us-ascii?Q?txnEdlXMoS0J2KbbokO6cFa5TRyUiv+DvXrV+AJCpmg1y3ayYZEj+7denh24?=
 =?us-ascii?Q?GBRF1HDu9A7iw4sYs2DehcC+xqtXtSEKlz1FfDmcQHfVM8MKt0Bzny1e5jTL?=
 =?us-ascii?Q?1CqHopJyZhaPcAHkFnjfZx2qvaReJSKoXD7I3Y/R+2y/6A99hoZu9rH/AgWd?=
 =?us-ascii?Q?NZBYLxIj/NBRTQY+GFhw0J0Lcjt5U9QqGLRVayo7e2yVXpkY8ifH0s98l0+E?=
 =?us-ascii?Q?XZYcn7g7Oyu+IdGIR49fy0Dpa25RkCFsEYn3r+jKFSQaJdzCzdShrE7lZDVQ?=
 =?us-ascii?Q?fQE3rBRR7KcOAH2KAhNgWZHFyvyKTLFlnBDYjSB19mXI1dYCVFaE2Y7ZsRf9?=
 =?us-ascii?Q?m5nKLaTjunbo37aUXViNSbr3SxLz411TNoRleQyxut9Ko47mrD1friEowPAJ?=
 =?us-ascii?Q?4gp2pjlT0ykwB/8pO84DmiNkznb8h6Q8bSV8jSJMj6B5CA6PSbBHjgjAbA82?=
 =?us-ascii?Q?LX9j67IkmO4UWMpizkBWmJFkVLSkaewbtbDr/VcPSYyLe83uOEMWvkj39Y90?=
 =?us-ascii?Q?335HJ47QvYwTRDEB1D44KI6FP5kgNK0bzSxWVv8EHBkLN/nCzksGf1f3UO0J?=
 =?us-ascii?Q?W8wITKhSCPHuslPvqD/y9NPoJHcm4MK4UF/ZIQyHdv5VQlmx54RGderwLdoV?=
 =?us-ascii?Q?mRpCwJXsaDj69GDHSnjb4h3WxbigiFnRws2lpKnJqEkfdTNgtFmxHWP/jRKr?=
 =?us-ascii?Q?O+muRVlQx5TjRIXF1i1XQvhutE+OtsNn5MBKV2NbXMJcP6gWXRyJzYJpF2Tf?=
 =?us-ascii?Q?kt7oMs+2QXWW+dovK0aRRDtMCT6CYdF4GT2xvUkA0/eNNJ1lYS7ArhPPJSr3?=
 =?us-ascii?Q?JECECJG9nNQBkips+C+iZW2r+yT4q/fPBjaaR2BNfvlVp7XP9HR6LWdGZRE2?=
 =?us-ascii?Q?nBeE2Jbs3PCR7lit8g2lHTAXhkK+DSROg8kTpFcl8Lt1uDLfwafNISy8pR5K?=
 =?us-ascii?Q?5uSTiqk3Hh23CvKNcGoPJEmTcfUAbtqI/xrSF+g8CkZURfpPMZElpmN7DGnT?=
 =?us-ascii?Q?ulzAjQOODQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: x3MEMELbj7Mb7DEFKfKwvz2RLrobf3Z4cZZEP00ctDzuHoCGhAxRPWEV+dqPO51rpkL4lEQw9t08LIbRts5ojb4rgktxfO4Jv0cYE6P+Ec5eKrrYbRpa6A8+49hRxQ61Y3LSKWr9BqM1V9SBZXfVrrJInFHvByfxLkSwDwTSq5vXubiO9a6cvuYbWUOm27tUnR3DwP9vXMVdn2o4L0blLY0TVMHSxg/ke73jUxfeBeQiEnbNGfW7yItnsmSu4z2YUd5Eap6x991KpsjUbkIclr5rx4VjgS8N3qvj23hFPwzdck3JP7Ef3PI43Cm2GiWzihBSv+H5kCQdtLMlLBIG6g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9cc9d1-1291-4dbd-b3cb-08df38cf83c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:53:22.9153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoemvAfwODSCMmbFmhRbPsmOPcaLwjUo78VZZW+P2byrVuM0xty3B14U2PG9xRJhk71flrLX/BCBlgZ+qdxTwBgQpJgWUpqcXg4FW5mpv+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6416
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Monday, October 5, 2026 12:22 PM
> To: Yuho Choi <oss.patchbox@gmail.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Cc: Simon Horman <horms@kernel.org>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Hay, Joshua A <joshua.a.hay@intel.com>; A=
lan
> Brady <alan.brady@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>; Burra, Phani R <phani.r.burra@intel.com>;
> Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.or=
g
> Subject: RE: [PATCH net v2] idpf: Fix vport IRQ name leak on request fail=
ure
>=20
>=20
>=20
> > -----Original Message-----
> > From: Yuho Choi <oss.patchbox@gmail.com>
> > Sent: Sunday, October 4, 2026 8:09 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>
> > Cc: Simon Horman <horms@kernel.org>; Lobakin, Aleksander
> > <aleksander.lobakin@intel.com>; Hay, Joshua A
> > <joshua.a.hay@intel.com>; Alan Brady <alan.brady@intel.com>;
> > Samudrala, Sridhar <sridhar.samudrala@intel.com>; Burra, Phani R
> > <phani.r.burra@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David
> > S . Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> > Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Yuho Choi <oss.patchbox@gmail.com>
> > Subject: [PATCH net v2] idpf: Fix vport IRQ name leak on request
> > failure
> >
> > idpf_vport_intr_req_irq() allocates a name for each vector IRQ before
> > calling request_irq(). On success, the name is released later through
> > kfree(free_irq()), but when request_irq() fails, the error path only
> > unwinds the previous vectors and the name for the failed one is
> > leaked.
> >
> > Free the allocated name on the request_irq() failure path, as done for
> > the mailbox IRQ in commit 9bff30482c10 ("idpf: Fix mailbox IRQ name
> > leak on request failure"). While at it, fail with -ENOMEM when the
> > name cannot be allocated instead of requesting the IRQ without a name.
> >
> > Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> > Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> > ---
> > Changes in v2:
> > - Correct the Fixes: tag (Simon Horman)
> > - Handle kasprintf() failure (Simon Horman)
> >
> > v1: https://lore.kernel.org/all/20260923234819.702327-1-
> > oss.patchbox@gmail.com/
> >
> > Compile-tested only (x86_64 defconfig + CONFIG_IDPF=3Dm, W=3D1).
> >
> >  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > index 4311ffa30bb1..af3213eae393 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -4067,12 +4067,17 @@ static int idpf_vport_intr_req_irq(struct
> > idpf_vport *vport,
> >
> >  		name =3D kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name,
> if_name,
> >  				 vec_name, vector);
> > +		if (!name) {
> > +			err =3D -ENOMEM;
> > +			goto free_q_irqs;
> > +		}
> >
> >  		err =3D request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
> >  				  name, q_vector);
> >  		if (err) {
> >  			netdev_err(vport->netdev,
> >  				   "Request_irq failed, error: %d\n", err);
> > +			kfree(name);
> >  			goto free_q_irqs;
> >  		}
> >
> >
> > base-commit: 551c722f40809618230001baccf219193e22fc5a
> > --
> > 2.43.0
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

