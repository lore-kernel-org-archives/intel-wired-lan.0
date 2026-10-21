Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28D606A322
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=V+mc7hMW;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VoX4DmBU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1AB26078A;
	Wed, 21 Oct 2026 10:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a3wWZSr1cwn9; Wed, 21 Oct 2026 10:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C0FF16079A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792579401;
	b=X5U5mCSJ8tySI47zx7cIyIk/RIy3SzcE57vH1g1V9mrWmMo5lmYjXWFVKnYWpRTsRvkJ
	 lBVm3qTpxDo3mGQlleV/gyZeNeWMdOi9JrPx7Ok3YGQkVFBYcKMesGsLGG151dVskEIsH
	 aSOfDv/SkqLw9JPENZ77nIlCvlvG4o84bkIejURdfH0EaZlGPzMHv3uE+NVLE8bM38AvT
	 YR4LYhDOiIGbSBgYfsGa7kM8ivBK6+r2e77pUkUUMHC0yZBD1kh+rrjp1RpzQDMnUY4Px
	 JpQzN3q0PDzpcAZOeDSvDcq2vpwMzGAkn8lefYWhgHsHu5RP3F6EWr79gh8f1ZfGySQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792579401;
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
	bh=uQjMNitUSTjJTfNh9YIODEm3PUn4YHteP4XTHLL7jWE=;
	b=QUUUMvH7dDlkzsSf/GzBeZyRASVOOdZImml2pNUJz2CYkenrRM5gZomczxY8X3MCCIjT
	 ul5Fgi+8IU7EO2OJHzEaiBCackMVW05hExhAaOurYK/bhihY2LYdaGfDnFsoMXAbTQZLd
	 3QeqQgzIg/YZtDt85wVRnm5YLvxwz6tBwAM4T4k82I5jrdljhGURcr8VF8UOJMOLUjH/E
	 j/Cjl6yc3H+uCn00KskxBL0q2ElWx7vyKOJ7XIe7jHR7/wWRhxf40+S+fz4X/TFzkBjnw
	 3dJRW9Gjyn4hPjUdMPvotzhYqBwycXpM7g5CJPzf6O5Un9yvda408+ZZvDgSKXTFiNg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792579401;
	bh=uQjMNitUSTjJTfNh9YIODEm3PUn4YHteP4XTHLL7jWE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V+mc7hMWZtKCF9i5vK+43chsGwjPcEf3Xfo1yVh9PCn6ZZBSeWH+Hwm7Nz9aFPyXn
	 A+Pu/rkVfZ1GlBqOre+Jr3snxFSQPXTgsNByvWmpurEj8Z3Wqjx3w7ohAlttrewtkx
	 sjKHlSRUFkozPZisA/E7QeJwMdJJL4tE5YxXeIDQH6VFpRKeWXWNPD/CbkQIXHnbAF
	 cW8fdDlQWpHGWpvUpg99FEMPNAU1bb3sVSTSenEKJe0uDpRz6I3Ad5NMCFdA3JnGJy
	 LeERCbAfz2Lm36WXBsKMVr3Ux4tC/xmEFUBeQ+FLOfg7KpeJ54/yaEh0W9fh9T1i3D
	 nRcT6qeTlcmMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0FF16079A;
	Wed, 21 Oct 2026 10:43:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D0F71E9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 10:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82D2980F35
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 10:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3DTE0eQ_xmtW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 10:43:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 47CB280F31
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792579399;
 b=GHYM/P6OGa+au6lHoQQNLeHlI/NDHWqlzqy0zIy1AGuk8ZfIeyXzdVqg3F+ILBMtsjsm
 EUxhnhjrOM8xiDPYsynfX1wSq6lqG+llqKxPxvRzXXu4v44ueyb8QCrS0BvGpu3ACWywj
 Q8egt8BwQHPgiZ4JTJW34PdeFjHLVex0PKYrT0A9l2hrdn3aSG0JwIaqz87HLCmZ7jFTp
 vWVZdZxslCB3/lch3GeIAMqBKeiYz+H5wAXathQxYeZwe4N6yZsRQddhkEySul7ZOp4Bh
 VslDTSouVHuZbcJ+n2j3aEdd4Jp7jWyq0aSGE9R344ZtH104ytd4K8+ueo0FiUbKO+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792579399;
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
 bh=uQjMNitUSTjJTfNh9YIODEm3PUn4YHteP4XTHLL7jWE=;
 b=DnUyH7GsaYOfYatE5CYIfnwnF+mE8ickMO3VT4+TwfHeK01jMynHc9l+kMK3ZZt+0hUx
 jWd4g2+ZOpCZJ6F6XQMdlL3oBdKbMMXY1aFCnLmMOr3a6BDbIOHkiU4nYM2YuEhMAv1fx
 xzRKiS2ytdPL0hkT/jfj7mLKWPmSbxhHx8tFRMM3AAu1nv78xsjQUn/LF5/oynwlOJLfg
 NJNYodR/nCFbOYfahrWe/x0+dyACAvLdAv3Mt0LNFrKBJDHdza8Tw3+xtDFYNZ+VsBuXt
 dZLkP3WkepB7m8noNhjilpoJAV+rXL7lp7j1tTIAzHfpSkoN9WLCI4wIf9UDkpHAOlw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VoX4DmBU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VoX4DmBU
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47CB280F31
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 10:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792579399; x=1824115399;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uQjMNitUSTjJTfNh9YIODEm3PUn4YHteP4XTHLL7jWE=;
 b=VoX4DmBUvC4+79CaMkU2IoIzSJ/Oy7zlr2nY5hy/8cUf7Ui5zZxbmxF6
 07uScv2wW6Uy5WXudo4gKzYtcyvRIWcmsmnf+qL1HBPHpge6l4HAXI2Ps
 6LOagnG01EVhXLb7tHbwmBbUwsae4rI4VPFgtB9MBgrqXFsOI9znuHlr2
 +d42OZmtfUp8CpXuVhAPgGkahe+apDEj1AVvXqGpVmcF8QZqYBD93ShFd
 CyldL2hC0vHplcgzOJOdAEjfMaSwnAzK0oYesQu3g6qXzzyd30irDryfm
 +wg/KHxT+KDJBt/jE2Z2MEjtAKZ0xeuYCKIWsYn1zjzqGt98UE4rxbYRi A==;
X-CSE-ConnectionGUID: 0mkDtGBPQiWrfvK3B3FwtQ==
X-CSE-MsgGUID: eyhxBtv/Qw6z1egPLLHBlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1203138"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1203138"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:43:18 -0700
X-CSE-ConnectionGUID: ZJ6/F1x3SE+LxN4WJ2dvfA==
X-CSE-MsgGUID: 3Ia5DJqJTQmaQ8BBqZ1X2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="2977863"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:43:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:43:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 03:43:17 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:43:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgIQhjeeVMEsxi86QWs09LrhQu1CbVkfIxrslpWwSXBxDtUFUrLyil6Gin/YEUSqHRpBNX7rz8aWTxx7TmgrJHwdvsE8LuAn2gfDbX6miRRDY5HnrA9Clqc1lX8yjsZUI5mVUxHuRzocOGol0CPK9ps66z1IZfRnY2uSbLvxKKFC7VHCQGfm+3Jx9i2miEZdD5xRdd1f0OGm71ICtrhEPZ7DQ7CLzZHAqcU2oMD2cfhubw7zpccWJ20M4DaLmjKD3ud1vmeI1IBctHXOenMEsSGx8aRUttVM3Di0xe399ftFfYD7Czl7Gjz1DAMPI03OJsbGa6W97KWuhe0AzesNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQjMNitUSTjJTfNh9YIODEm3PUn4YHteP4XTHLL7jWE=;
 b=NUPdENQsBVChC+bJZvtN5niazJyYc6g+x3rycc0hhEPXvItXvpnx7pZzIUEfB961vZDuzpzxekczMr/VV6UeuLvdkJJDirLLGzVg9akWzGd2UQcuSBPjmGGWjbUVpFSRmEJcxmrPsI3tHqqBdsVfriLIlOTXKoisTH+pFCVCYYEkOi1+fEVRpLyO9b1QPPH+fjnxx0tVVv7UwiTkN+NM0yRj9zf62MyuMuq/TO+wuPkU9cBMp1XSOieD8Cdi1u8u7nRndoCtuAZDxvqsUGOY4pn0nIvpAxbX4GrDm7297xxKCSsNDcE5Q1kIOAOfUMnksR2AvWwlCnwYKyO6wXQHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SA0PR11MB4702.namprd11.prod.outlook.com
 (2603:10b6:806:92::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 10:43:15 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 10:43:15 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Luigi Rizzo <lrizzo@google.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Luigi
 Rizzo" <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, "Hay,
 Joshua A" <joshua.a.hay@intel.com>, "Zaremba, Larysa"
 <larysa.zaremba@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 2/2] idpf: use GFP_KERNEL for the initial Rx
 ring fill
Thread-Topic: [PATCH iwl-next v2 2/2] idpf: use GFP_KERNEL for the initial Rx
 ring fill
Thread-Index: AQHdYA3Bl7CJeKf0uUCUq832E2yB07cH0ceA
Date: Wed, 21 Oct 2026 10:43:15 +0000
Message-ID: <CH3PR11MB56689549671463FE24213BF9E3E5662@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261019210604.2433620-1-lrizzo@google.com>
 <20261019210604.2433620-3-lrizzo@google.com>
In-Reply-To: <20261019210604.2433620-3-lrizzo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SA0PR11MB4702:EE_
x-ms-office365-filtering-correlation-id: ca27200a-c8f0-4c62-ab10-08df2f601ca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|6133799003|18002099003|10067099003|22082099003|56012099006|4143699003|261009223027099003|11063799006|38070700021;
x-microsoft-antispam-message-info: iGC/1lO06il9d3RT6eOjH/WMvPDQLHXGPPcadxW0Agg878tUJN87YD4ufjfBX//UQG2EIs3L+Kn24lxOBebCnJUBy4JlWzhfXkiZ4gFQINU3vUXA0nw4rRQc00a/7CRJlbc+YyxJQLqbM6J8SkzDDuX1c6EFeYklITa92KZQVCRQbIiXmYZ39MBQRfM3k+o/Vp08Di3haQIhhz7IH8TqrD/ozQDFAZLvj8z2Owcz49oCagUxCvv06OokFYxMgMJIHuJbYeLGhAi/UXisDPXH/35O5qj1CRp9XSsriMPJz52rIg0tcDWNivTcN0Q6TFXWEVpYvgSyXWgjrJPesf+1ayxc+vRqewiHWD2/cSdOle3q+9y9jbP6GQ8pqf93ZdWFD5NkTslvjgXMlHs0Ot222Mf72zX/JOoRAndMG/ed0XIbQvUF0nVS22ErxC9snRBBKUYlnG6fIc1q4GmHAWhhb9CUlzlPfhxvwfUPYJiftG6j8aAcmZHjKg2d3Wi71WhXHKY5fUiLVitOMnqpRgyJALFmFLmQ9tEawpVa0xEDjsOBWN7o+ULnuPvfjTMO+Yz9G4huSIEyNrljtJWptaKkt9y1fEGwQFniEWIQyhulmhd+S3E6XrdPOsF7fz5sy2tplDfpmfUA4p0qQmrwkbHqzXA16r3qPWl7SUTzOihaJZhwLglDwmzu4Z4Lsxy7v5p1jbyDJvziIUNHkTx3ZVKTb7Jhu2MBuCqE8kqE7ET4FDs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(56012099006)(4143699003)(261009223027099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTVJelh1Qmx1TVQxV2wxZVVNcnk2VndJVDU0VzZ5bXIxR1Z3TUR6MGNBSzVI?=
 =?utf-8?B?SnYvSUFjUUJsaHpWN1NUK0Vhd0JKc3QzSkxvVVo2WDZLN3lJdGtXWnBnZGRE?=
 =?utf-8?B?WW9UMGp3SWdUNk1SRGJETW1scktLNXBlMURRT09wbzEwYWJVZHFFRk9yakJM?=
 =?utf-8?B?dW5pWkxaZUFETTdmRTF6WEgrZ2lrOHF4cUZYaU8rellhRUhJeGFuQVY5M083?=
 =?utf-8?B?YkNnd2xoTktpc2I1RFFkUUl5NU8ra2haMDZQbHJnaTB2dlVlSDZsaWVGajk5?=
 =?utf-8?B?MjlrZ2s4R3BtNjEvTDVPZFlkTFZkbDFsOUFVSFU0Zmt1cU84Q0srK3ZNdE5N?=
 =?utf-8?B?aU5aemI3TFZZSGFWM2xFQitmMzFNV2N3OVQwZ05VZllQYUtoRUtKK0ZjbWVx?=
 =?utf-8?B?WS9NdWNwMmxDYytvaHg1NTRFbmN4cFFiWEwvOFFxWVY1YlNxM2E3QkVHaDdm?=
 =?utf-8?B?bXpNN2kwTVRyM200Ymp3QUNqUFB5cHVEc2lIMENpTEFNN2VadXRTaEhOZlF3?=
 =?utf-8?B?Z3k4NUtpWjJyK1BaaWVCSWJ5WExmWEFRd0owY0I1RVRsNit1c29Da0oxVi9N?=
 =?utf-8?B?VUlheXBGSFNlS1YxYU5vSlltVDU4RjV6OGdaYURvZzA1Znl4ZTVML0xTck1L?=
 =?utf-8?B?OUlHUHJrM1piMjJ0alpJaHRwSS80V3lsN3JmYzlZZ1FWNDRlSFkydXpHTUtJ?=
 =?utf-8?B?NkNhNG12ejQ5SW4vckV4b0F3NFZZZEZJTW5kOVFpN09pL1ErVEd5QUQvQitR?=
 =?utf-8?B?bkFCVUljYnUyL0pEVlBVb3dDZWpKeUFaeFJRZStPVnRvLytnWE0reU1kL3Ax?=
 =?utf-8?B?L0RhSVU1K2dpb1M1ZUtYTVc1K3NkVUJkRCtsNjhwMmRrQ2p4N2w4cHRVTmpW?=
 =?utf-8?B?NGlKWVkyQTNKRnBGbFQ4RWpCcUFtMEFsem1rS2NmeTJzamFOT2wyVXVYUk54?=
 =?utf-8?B?SVBKTUJpVGZXTWRWMEQvTDc3L2MrdXNLcTJZazJ0b05NQnlkWWlVQ0xhNGs3?=
 =?utf-8?B?UFkxYnBOblo2dnRDSHVGdS9kUW9GNGRySUdsUWY5QnpadmY3Qm9aTVpjVjZN?=
 =?utf-8?B?UWJyS0pMQkdPZ3NoaVdTVU5FZ0NUMktXMnZKUkp4aTBPRjJRNW1zc0EzNFRx?=
 =?utf-8?B?VmE4ek9GMnFGUXZrNlc4OHRkTTZsSktsRkY3ck5tTDJQaWlvZUNEa1Y4ekZU?=
 =?utf-8?B?cVNxa2ZYOTBYZENYeEpIT2lKMnkwdURQMXZES3F5K3dZWkhZRDlOWUlvOVFq?=
 =?utf-8?B?ZFovaWhCY2FrNmRha0FJRUU3TGRKTnl1RUxqTThGM09zMkZ4QUhndFl6UlBm?=
 =?utf-8?B?blZPeVNxOUdlam4zTUZDYXQ4Rkk4dFN1eTdOTnZVdWJaL0ttcGNtcTlrRUVT?=
 =?utf-8?B?QllQVmdaL29VY0pIMURqUHVXNldhbElWQVAwVCtWNkwyTmZBRzRRanRWdE8x?=
 =?utf-8?B?MC9QeVptK3Nqc1lIN3FYclQzYjFmSXNkSGp3c0J6c0xOSHN0Ym5NeHU3Sldp?=
 =?utf-8?B?ZDF6alJFOXo1UzR0aHNVN0xhaDBYSWQrTHVBZ0prRi9rWkJldlExQVZDZVJT?=
 =?utf-8?B?RWdzbzB5ZGZoc2tuRmFNM0syOVNxRjBxeWk2QW9yL0VZaGpJNlNTYUV4YVZI?=
 =?utf-8?B?MCtBdndJUlJGOE1EVWZEUU96bDJlQ1VhdkUxSVZSdFJsNXBvYnVxZkNRYklG?=
 =?utf-8?B?TGkwQ1pUWnpnaHE2OENRQ2ZzVEZOT05wLzRkZHRWSG41OUh6ZUhUYXJnV1Yr?=
 =?utf-8?B?SkVYTTlGSDdWM0lSQUgraG9Xb3YvaTdGSHM0Zlpla0Z4bnhyMGlmQ3lHaDRz?=
 =?utf-8?B?anMvZTVRckdUc2g3ckM3YTBFd1dUQVR1R29jWUdUVk1BWmlxY1hKdnYxRWQv?=
 =?utf-8?B?OURDUGlOWmlvL2pGVTVXSjY3ZmU1dWVkKy9DbDMxWmZxdjd0MTZxOXFxVlNI?=
 =?utf-8?B?akE3dk1GQTM2VndITXpLSHFBcU1CUnI1MkhOL24wUlRRekFkUlE4dytmQytJ?=
 =?utf-8?B?TzNNOTBCY0RiV1hBQmo0ZHdqUlBpRFdnVDVCSnJQRWovYTM3NW5PQy9UUVNP?=
 =?utf-8?B?dldiT3IzNEVvbXZGSmJ4aTVOZFJJR3pHWnNjM29qUUFiYmJQaTlRZXg4cEFk?=
 =?utf-8?B?SlFBa2xWdHlFb2FrZEZxZkgxL1paVkpRZ1Z1cTRsTzAzemtwZ1FRMUZDY0kx?=
 =?utf-8?B?RUxxcUtBS1FDMjdEd0FST2t0czJKb3JOYmNYeGJsM0lCdllIbHlCUWRVdXpZ?=
 =?utf-8?B?ZGw0TCs1Zk1PKzhJdndnZFZYTEZpQzdKd0xBd2NCMmFpZWpXYjJqT1BYeW0v?=
 =?utf-8?B?WXV6SUFDYmdSeE43RHpjazcvN3FjVW5TOENZS2Z5YW8wOXRxdGRZaVltSWpv?=
 =?utf-8?Q?PLVSRo2ZgobHFLRA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: e4sl7nmYKsPM1X4Ay+F5DKKaRMPgn224qQ9BJTe4nJamQzOjPRIFgZRL8aVZvDfVthtcUP3VllzOsZ9T5iBnB1UQEI9TAr4lB7OsuY5iuzkktk2TzVSxgHkD+OC5dhk0FYCGtaSUNCT3iDR1W8beXpKuc/h5HsDgeRKEC23wrE+x23mxtBzMkFzEjA8bjmAQDIUyKMSeH7ePSfk6sbQZ+rhGTJ5CRb6OV0fAAG8DHdflCZVPSWzmspWRvbQjXGzgIM77lJ5StJESplvd2XA2zFeuxhqwPw2LvAnPb+VUm0eHUArvt+JvuXFSImcrfbT7QPz7FSKu6NCsI+x+J+RI/Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca27200a-c8f0-4c62-ab10-08df2f601ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 10:43:15.2963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UUs6AAvqWpO96Ggu0zHKeA0ZyCe5Ko/IklXBazVTCsTZsUCye0AzuiJOHsQSJeZuuuOL+GAFouhA9d6NSmxvnr3QIH3Trji0FSpB8t09gRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4702
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVpZ2kgUml6em8gPGxy
aXp6b0Bnb29nbGUuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMTksIDIwMjYgMTE6MDYg
UE0NCj4gVG86IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5ndXllbkBp
bnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50
ZWwuY29tPjsgTG9iYWtpbiwgQWxla3NhbmRlcg0KPiA8YWxla3NhbmRlci5sb2Jha2luQGludGVs
LmNvbT47IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+Ow0KPiBEYXZpZCBTIC4g
TWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBr
ZXJuZWwub3JnPjsgTHVpZ2kgUml6em8gPHJpenpvLnVuaXBpQGdtYWlsLmNvbT47IEJyaWFuDQo+
IFZhenF1ZXogPGJyaWFudnZAZ29vZ2xlLmNvbT47IEhheSwgSm9zaHVhIEEgPGpvc2h1YS5hLmhh
eUBpbnRlbC5jb20+Ow0KPiBaYXJlbWJhLCBMYXJ5c2EgPGxhcnlzYS56YXJlbWJhQGludGVsLmNv
bT47IEpha3ViIEtpY2luc2tpDQo+IDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFi
ZW5pQHJlZGhhdC5jb20+OyBTaW1vbiBIb3JtYW4NCj4gPGhvcm1zQGtlcm5lbC5vcmc+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMdWlnaSBSaXp6bw0KPiA8bHJpenpvQGdvb2dsZS5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSCBpd2wtbmV4dCB2MiAyLzJdIGlkcGY6IHVzZSBHRlBfS0VS
TkVMIGZvciB0aGUgaW5pdGlhbCBSeA0KPiByaW5nIGZpbGwNCj4gDQo+IFdoZW4gaWRwZiBmaWxs
cyBpdHMgUnggcmluZ3MgYXQgb3BlbiBvciBvbiBxdWV1ZSByZWNvbmZpZ3VyYXRpb24sIHRoZQ0K
PiBhbGxvY2F0aW9uIHJ1bnMgaW4gcHJvY2VzcyBjb250ZXh0LCByaWdodCBhZnRlciBwYWdlX3Bv
b2xfY3JlYXRlKCkgYW5kDQo+IGJlZm9yZSB0aGUgcXVldWVzJyBOQVBJIGlzIGVuYWJsZWQuIEFs
bG9jYXRpbmcgdGVucyBvZiB0aG91c2FuZHMgb2YNCj4gYnVmZmVycyBhY3Jvc3MgYWxsIHF1ZXVl
cyB3aXRoIEdGUF9BVE9NSUMgaXMgbmVlZGxlc3NseSByZXN0cmljdGl2ZSB3aGVuDQo+IHRoZSBj
YWxsZXIgbWF5IHNsZWVwLg0KPiANCj4gSW4gc3BsaXRxIG1vZGUsIGlkcGZfcnhfcG9zdF9idWZf
ZGVzYygpIGlzIG9ubHkgdXNlZCBmb3IgdGhpcyBpbml0aWFsDQo+IGZpbGwsIHNvIHN3aXRjaCBp
dHMgaGVhZGVyIGFuZCBwYXlsb2FkIGFsbG9jYXRpb25zIHRvDQo+IGxpYmV0aF9yeF9hbGxvY19n
ZnAoLi4uLCBHRlBfS0VSTkVMKS4NCj4gDQo+IEluIHNpbmdsZXEgbW9kZSwgYWRkIGEgZ2ZwX3Qg
cGFyYW1ldGVyIHRvDQo+IGlkcGZfcnhfc2luZ2xlcV9idWZfaHdfYWxsb2NfYWxsKCkgYW5kIHBh
c3MgR0ZQX0tFUk5FTCBmcm9tDQo+IGlkcGZfcnhfYnVmX2FsbG9jX3NpbmdsZXEoKSBhbmQgR0ZQ
X0FUT01JQyBmcm9tIGlkcGZfcnhfc2luZ2xlcV9jbGVhbigpLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTHVpZ2kgUml6em8gPGxyaXp6b0Bnb29nbGUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl9zaW5nbGVxX3R4cnguYyB8IDcgKysrKy0tLQ0KPiAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3R4cnguYyAgICAgICAgIHwgOSAr
KysrKystLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl90eHJ4Lmgg
ICAgICAgICB8IDIgKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pZHBmL2lkcGZfc2luZ2xlcV90eHJ4LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pZHBmL2lkcGZfc2luZ2xlcV90eHJ4LmMNCj4gaW5kZXggZTNkZGYxOGRjYmY1MS4uZDYyM2U0
YWI4NTExZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9p
ZHBmX3NpbmdsZXFfdHhyeC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lk
cGYvaWRwZl9zaW5nbGVxX3R4cnguYw0KPiBAQCAtODg1LDExICs4ODUsMTIgQEAgc3RhdGljIHZv
aWQgaWRwZl9yeF9idWZfaHdfdXBkYXRlKHN0cnVjdA0KPiBpZHBmX3J4X3F1ZXVlICpyeHEsIHUz
MiB2YWwpDQo+ICAgKiBpZHBmX3J4X3NpbmdsZXFfYnVmX2h3X2FsbG9jX2FsbCAtIFJlcGxhY2Ug
dXNlZCByZWNlaXZlIGJ1ZmZlcnMNCj4gICAqIEByeF9xOiBxdWV1ZSBmb3Igd2hpY2ggdGhlIGh3
IGJ1ZmZlcnMgYXJlIGFsbG9jYXRlZA0KPiAgICogQGNsZWFuZWRfY291bnQ6IG51bWJlciBvZiBi
dWZmZXJzIHRvIHJlcGxhY2UNCj4gKyAqIEBnZnA6IEdGUF9LRVJORUwgZm9yIHRoZSBpbml0aWFs
IGZpbGwsIEdGUF9BVE9NSUMgZnJvbSBOQVBJDQo+ICAgKg0KPiAgICogUmV0dXJucyBmYWxzZSBp
ZiBhbGwgYWxsb2NhdGlvbnMgd2VyZSBzdWNjZXNzZnVsLCB0cnVlIGlmIGFueSBmYWlsDQo+ICAg
Ki8NCj4gIGJvb2wgaWRwZl9yeF9zaW5nbGVxX2J1Zl9od19hbGxvY19hbGwoc3RydWN0IGlkcGZf
cnhfcXVldWUgKnJ4X3EsDQo+IC0JCQkJICAgICAgdTE2IGNsZWFuZWRfY291bnQpDQo+ICsJCQkJ
ICAgICAgdTE2IGNsZWFuZWRfY291bnQsIGdmcF90IGdmcCkNCj4gIHsNCj4gIAlzdHJ1Y3Qgdmly
dGNobmwyX3NpbmdsZXFfcnhfYnVmX2Rlc2MgKmRlc2M7DQo+ICAJY29uc3Qgc3RydWN0IGxpYmV0
aF9mcV9mcCBmcSA9IHsNCj4gQEAgLTkwOCw3ICs5MDksNyBAQCBib29sIGlkcGZfcnhfc2luZ2xl
cV9idWZfaHdfYWxsb2NfYWxsKHN0cnVjdA0KPiBpZHBmX3J4X3F1ZXVlICpyeF9xLA0KPiAgCWRv
IHsNCj4gIAkJZG1hX2FkZHJfdCBhZGRyOw0KPiANCj4gLQkJYWRkciA9IGxpYmV0aF9yeF9hbGxv
YygmZnEsIG50YSk7DQo+ICsJCWFkZHIgPSBsaWJldGhfcnhfYWxsb2NfZ2ZwKCZmcSwgbnRhLCBn
ZnApOw0KPiAgCQlpZiAoYWRkciA9PSBETUFfTUFQUElOR19FUlJPUikNCj4gIAkJCWJyZWFrOw0K
PiANCj4gQEAgLTEwOTUsNyArMTA5Niw3IEBAIHN0YXRpYyBpbnQgaWRwZl9yeF9zaW5nbGVxX2Ns
ZWFuKHN0cnVjdA0KPiBpZHBmX3J4X3F1ZXVlICpyeF9xLCBpbnQgYnVkZ2V0KQ0KPiANCj4gIAlw
YWdlX3Bvb2xfbmlkX2NoYW5nZWQocnhfcS0+cHAsIG51bWFfbWVtX2lkKCkpOw0KPiAgCWlmIChj
bGVhbmVkX2NvdW50KQ0KPiAtCQlpZHBmX3J4X3NpbmdsZXFfYnVmX2h3X2FsbG9jX2FsbChyeF9x
LCBjbGVhbmVkX2NvdW50KTsNCj4gKwkJaWRwZl9yeF9zaW5nbGVxX2J1Zl9od19hbGxvY19hbGwo
cnhfcSwgY2xlYW5lZF9jb3VudCwNCj4gR0ZQX0FUT01JQyk7DQo+IA0KPiAgCXU2NF9zdGF0c191
cGRhdGVfYmVnaW4oJnJ4X3EtPnN0YXRzX3N5bmMpOw0KPiAgCXU2NF9zdGF0c19hZGQoJnJ4X3Et
PnFfc3RhdHMucGFja2V0cywgcnMucGFja2V0cyk7IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdHhyeC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWRwZi9pZHBmX3R4cnguYw0KPiBpbmRleCA0MzExZmZhMzBiYjE4Li5iMTEyN2Fi
NDhlZjNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lk
cGZfdHhyeC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl90
eHJ4LmMNCj4gQEAgLTYwMCw2ICs2MDAsOSBAQCBzdGF0aWMgdm9pZCBpZHBmX3Bvc3RfYnVmX3Jl
ZmlsbChzdHJ1Y3QNCj4gaWRwZl9zd19xdWV1ZSAqcmVmaWxscSwgdTE2IGJ1Zl9pZCkNCj4gICAq
IEBidWZxOiBidWZmZXIgcXVldWUgdG8gcG9zdCB0bw0KPiAgICogQGJ1Zl9pZDogYnVmZmVyIGlk
IHRvIHBvc3QNCj4gICAqDQo+ICsgKiBPbmx5IHVzZWQgZm9yIHRoZSBpbml0aWFsIGZpbGwsIGZy
b20gcHJvY2VzcyBjb250ZXh0LCBzbyBpdA0KPiArIGFsbG9jYXRlcw0KPiArICogd2l0aCBHRlBf
S0VSTkVMLg0KPiArICoNCj4gICAqIFJldHVybjogJWZhbHNlIGlmIGJ1ZmZlciBjb3VsZCBub3Qg
YmUgYWxsb2NhdGVkLCAldHJ1ZSBvdGhlcndpc2UuDQo+ICAgKi8NCj4gIHN0YXRpYyBib29sIGlk
cGZfcnhfcG9zdF9idWZfZGVzYyhzdHJ1Y3QgaWRwZl9idWZfcXVldWUgKmJ1ZnEsIHUxNg0KPiBi
dWZfaWQpIEBAIC02MTgsNyArNjIxLDcgQEAgc3RhdGljIGJvb2wgaWRwZl9yeF9wb3N0X2J1Zl9k
ZXNjKHN0cnVjdA0KPiBpZHBmX2J1Zl9xdWV1ZSAqYnVmcSwgdTE2IGJ1Zl9pZCkNCj4gIAkJZnEu
ZnFlcyA9IGJ1ZnEtPmhkcl9idWY7DQo+ICAJCWZxLnRydWVzaXplID0gYnVmcS0+aGRyX3RydWVz
aXplOw0KPiANCj4gLQkJYWRkciA9IGxpYmV0aF9yeF9hbGxvYygmZnEsIGJ1Zl9pZCk7DQo+ICsJ
CWFkZHIgPSBsaWJldGhfcnhfYWxsb2NfZ2ZwKCZmcSwgYnVmX2lkLCBHRlBfS0VSTkVMKTsNCj4g
IAkJaWYgKGFkZHIgPT0gRE1BX01BUFBJTkdfRVJST1IpDQo+ICAJCQlyZXR1cm4gZmFsc2U7DQo+
IA0KPiBAQCAtNjI5LDcgKzYzMiw3IEBAIHN0YXRpYyBib29sIGlkcGZfcnhfcG9zdF9idWZfZGVz
YyhzdHJ1Y3QNCj4gaWRwZl9idWZfcXVldWUgKmJ1ZnEsIHUxNiBidWZfaWQpDQo+ICAJZnEuZnFl
cyA9IGJ1ZnEtPmJ1ZjsNCj4gIAlmcS50cnVlc2l6ZSA9IGJ1ZnEtPnRydWVzaXplOw0KPiANCj4g
LQlhZGRyID0gbGliZXRoX3J4X2FsbG9jKCZmcSwgYnVmX2lkKTsNCj4gKwlhZGRyID0gbGliZXRo
X3J4X2FsbG9jX2dmcCgmZnEsIGJ1Zl9pZCwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKGFkZHIgPT0g
RE1BX01BUFBJTkdfRVJST1IpDQo+ICAJCXJldHVybiBmYWxzZTsNCj4gDQo+IEBAIC02NzUsNyAr
Njc4LDcgQEAgc3RhdGljIGJvb2wgaWRwZl9yeF9wb3N0X2luaXRfYnVmcyhzdHJ1Y3QNCj4gaWRw
Zl9idWZfcXVldWUgKmJ1ZnEsDQo+ICAgKi8NCj4gIHN0YXRpYyBpbnQgaWRwZl9yeF9idWZfYWxs
b2Nfc2luZ2xlcShzdHJ1Y3QgaWRwZl9yeF9xdWV1ZSAqcnhxKSAgew0KPiAtCWlmIChpZHBmX3J4
X3NpbmdsZXFfYnVmX2h3X2FsbG9jX2FsbChyeHEsIHJ4cS0+ZGVzY19jb3VudCAtIDEpKQ0KPiAr
CWlmIChpZHBmX3J4X3NpbmdsZXFfYnVmX2h3X2FsbG9jX2FsbChyeHEsIHJ4cS0+ZGVzY19jb3Vu
dCAtIDEsDQo+ICtHRlBfS0VSTkVMKSkNCj4gIAkJZ290byBlcnI7DQo+IA0KPiAgCXJldHVybiAw
Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3R4
cnguaA0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl90eHJ4LmgNCj4g
aW5kZXggOTM1NDc1OTdlZmQyYS4uZTI3NDM4Yzc4ZWM3OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3R4cnguaA0KPiArKysgYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdHhyeC5oDQo+IEBAIC0xMTIzLDcgKzExMjMsNyBA
QCBuZXRkZXZfdHhfdCBpZHBmX3R4X3NpbmdsZXFfZnJhbWUoc3RydWN0IHNrX2J1ZmYNCj4gKnNr
YiwNCj4gIAkJCQkgIHN0cnVjdCBpZHBmX3R4X3F1ZXVlICp0eF9xKTsNCj4gIG5ldGRldl90eF90
IGlkcGZfdHhfc3RhcnQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UNCj4g
Km5ldGRldik7ICBib29sIGlkcGZfcnhfc2luZ2xlcV9idWZfaHdfYWxsb2NfYWxsKHN0cnVjdCBp
ZHBmX3J4X3F1ZXVlDQo+ICpyeHEsDQo+IC0JCQkJICAgICAgdTE2IGNsZWFuZWRfY291bnQpOw0K
PiArCQkJCSAgICAgIHUxNiBjbGVhbmVkX2NvdW50LCBnZnBfdCBnZnApOw0KPiAgYm9vbCBpZHBm
X3J4X3Byb2Nlc3Nfc2tiX2ZpZWxkcyhzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiAgCQkJCWNvbnN0
IHN0cnVjdCBsaWJldGhfeGRwX2J1ZmYgKnhkcCwNCj4gIAkJCQlzdHJ1Y3QgbGliZXRoX3JxX25h
cGlfc3RhdHMgKnJzKTsNCj4gLS0NCj4gMi41Ni4wLjIxMi5nMTI5ZWRlMjBkOS1nb29nDQoNClJl
dmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVs
LmNvbT4NCg==
