Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E64606A690
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=He/GK1wn;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=efY/j6KU;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=NRC121UU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CBFB406C5;
	Mon, 23 Nov 2026 18:32:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OA4k4nJlY_ow; Mon, 23 Nov 2026 18:32:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78E15406E2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795458763;
	b=JTJ4F6sBaq8XaNWDftEkoC3KfdK7Jcdaa4y+JAM9uKr26TW2hjvlPq0zPHIdRnIaHPnL
	 1T0d7CQwi0jt6fCgTPmaOhR5vGqhN+FVOFRk6UcWmGiOGuRbpwgVUuwfCrxzQocpmD+vU
	 yA6kTNCB0J/jO///24rsHtBdXgCfvaj51gub7rnp3RHAl9gnzG0fWW2ijHCQp/bui2SBB
	 N67CESY0ccd4Qr76tG4LPy+aWyNkrnaMycyKT5yL5pdny6mPuZNhukLB7GHJq6LM/8srL
	 DFw4cJFvJ5X/PIWga8uCtdSO+IPbtbZCQtk4D85KaKI2HOSjV+JWICV7KrRwKpfUtOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795458763;
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
	bh=G36NFjJsENXzAIA5Ylv5sFPM6qfK3c9kH91DwZhL//Y=;
	b=rLfFq7o/cF1nZMtwcitAlfEY9cwxgYU3X37nR65YB9t177wsgoACCpmh4kgRciv7wYA7
	 DRFzU0V9QOvhPylipWjZAjamlO6AFKG2mL1EzrCd5POhgYqMdg+nu/W3j15nrPokf0DsK
	 p2AGH4uQiqGnS9L+vyp+l5CDVhDl4Qsi1wBCdEdTP6Bm1Y97/GktRy5vp0GViJUNxltLg
	 /2UMEg+ocpZyzyItAqfjvXe7+M4RwvP/7KYKbNaf+8r1yC8ndWW0Rz1IXxPiLv47FvPmf
	 Yuy2jpiPKCGz5+5dshO1RbntQpzEJgOeYEY797HHRx+1+cgbYlPqFSZnsGJV+BL4LCw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795458763;
	bh=G36NFjJsENXzAIA5Ylv5sFPM6qfK3c9kH91DwZhL//Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=He/GK1wn6jUXMUQiN+6LopO4RjMZbHLKQkK7pFSPAodOKP1vEqtZb853x8ph2+b+2
	 Ht7+z6H58tZXoRo//uUOV+/ioYbFLtBnGi14kAescPmvOr7kV+yHgmxvdDZZ2TYrzB
	 xlVCabHludLeDquThXU11LJWhIwjCD79xQhbpA08Nb5zvGLsdIUMiE/LsEqYhygsFT
	 1Vn5NG3usoif0Xeyvdc2yQ/mM7YCdYQHhflDyQFfW8320TqMqA3i0VV/H4GKHjrl4I
	 8sD3TN1kGTgBgLJO5TrJGXF0yY8fTdzAdR/zxHXSaYLOmFbwxNTwyd/FVNCMz2Irwy
	 Dvdg03cBL2Wcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78E15406E2;
	Mon, 23 Nov 2026 18:32:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EE714371
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D434660640
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:32:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6RQuDisRDau for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 18:32:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B263460608
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=efY/j6KU; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=NRC121UU
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B263460608
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795458761; x=1826994761;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=G36NFjJsENXzAIA5Ylv5sFPM6qfK3c9kH91DwZhL//Y=;
 b=efY/j6KU9p1q0t324GB6QDpshrozIHQtuRaQKo+zVfqjBj+egidt4x7h
 bKEsM5ZVFlKP92vITx4oN2XAkkpcUmrblPzhLwmVP+1MTVXx1AhVPnnql
 ZiKTA/zcTbdOcnyn8UDdT5442bfPQir1LiLwP4K967DflFME+dnEnDjP2
 BlTTrcM0fXa5QfGhA/JP5K0V/3N9VlrcCXUvsBcE1I2kk3MsFTWJA6n9m
 HS5b4xxKtk6E8v+PcbbfCB297yOi0YSpEQ8H8VQLXZWA18+jVKpRFuKSN
 N8TztCTzdZAxdMZzIIiT2FgGhVHkBwBdsPkERHvss0RWyKosbdT47erdd Q==;
X-CSE-ConnectionGUID: rEOQlCvFSPumTngH+IFVwg==
X-CSE-MsgGUID: RSaHivSgRVGQNX3qTYkfbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4294579"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4294579"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:32:40 -0800
X-CSE-ConnectionGUID: jte+bKWyRfGN36DZvKfPhw==
X-CSE-MsgGUID: SiWaIEfRQrGoRAkhsguqSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11529775"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:32:38 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:32:38 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 10:32:38 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 10:32:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G36NFjJsENXzAIA5Ylv5sFPM6qfK3c9kH91DwZhL//Y=;
 b=NRC121UU9EK6LykcTN4Gmny5qxlweLQ+YnXFP77gATJs7Bo0x0BNE1Qt9oblrN3eth8Slu1aLwT65//iOhCxLFu4feenE7JeqWNtFNhcJe+HO6mwP1AcbR2vVKxADa+ZoH4KUfONEebVvoNFH5uI/UYvsNxfdGyL1OOQwnNHOps=
Received: from IA3PR11MB824491.namprd11.prod.outlook.com
 (2603:10b6:208:626::16) by PH3PPF6E8D29981.namprd11.prod.outlook.com
 (2603:10b6:518:1::d2d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:32:35 +0000
Received: from IA3PR11MB824491.namprd11.prod.outlook.com
 ([fe80::c2b7:5964:96e1:8ffd]) by IA3PR11MB824491.namprd11.prod.outlook.com
 ([fe80::c2b7:5964:96e1:8ffd%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 18:32:34 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Tian Xun Ng <luckilystar08@gmail.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Tantilov, Emil S"
 <emil.s.tantilov@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "decot@google.com" <decot@google.com>,
 "Olech, Milena" <milena.olech@intel.com>, "Hay, Joshua A"
 <joshua.a.hay@intel.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Tian Xun Ng
 <tianxun.ng@bytedance.com>
Subject: RE: [PATCH iwl-net v5 3/3] idpf: keep the mailbox up while tearing
 down vports on shutdown
Thread-Topic: [PATCH iwl-net v5 3/3] idpf: keep the mailbox up while tearing
 down vports on shutdown
Thread-Index: AQHdWwxDtYeA7gf+1UyLjXTx75cw+rb89KQAgAAVfgCAPzG1gA==
Date: Mon, 23 Nov 2026 18:32:34 +0000
Message-ID: <IA3PR11MB824491E7FA4697CFB74C5566B69B452@IA3PR11MB824491.namprd11.prod.outlook.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
 <20261013121224.84482-4-luckilystar08@gmail.com>
 <sashiko-outbox-171247@kernel.org>
 <20261014133002.99917-1-luckilystar08@gmail.com>
In-Reply-To: <20261014133002.99917-1-luckilystar08@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB824491:EE_|PH3PPF6E8D29981:EE_
x-ms-office365-filtering-correlation-id: cd53f59e-6d00-467f-ea7e-08df499024a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|22082099003|18002099003|261009223027099003|56012099006|4143699003|11063799006|261028144727099003|261102123227099003|261021123027099003|261026121527099003|261022075727099003|261021121427099003|261022105027099003|261026140227099003|38070700021|10067099003;
x-microsoft-antispam-message-info: v2fuJH0IFFyiI/dTXZIIgkgurW1Lw1i/BNj8RAZf1Up22/7xoYVf6AwgvAsVky2hCoq/T8EEIX3lVNRcb63USWaIf/8vBx3M5UqZ3puQczGoAQhSgx6hgUsk25I7kHaxG+tV8LxQ/paHfUGvrsYH4v5FVMXGIUkkiQLDNvaoRx7wWsG3Pq6TrWObsWN6K+N20u7/L5qrD1x8sLxVevl1vAKmbuav851ZuBqJyXpmZlnW9wfT2ryn9jyiygSZhSAvJr8QuP8/SzuamU3xoz2yh/r/Cvm9aE1/wlWmw9Ue5N4GHWUHoexj+D6dEVcz4m+I2IVk7lP6xp/7RzRWTXyvxUlH4sElB/HZ0q2z5TlYeJEjgFELsB6eGJ0WXVkMT36qZ3XGNCSqYZfzgfpI2iyBvsNcBrBuP+QJ8TmuWsCHeUOunJVLvkoQoJM7F1vDnuucLGAb5ksExducfTdXnAi/yIPsc6381M59ibo7/ixD9xYyfUoNgwt0Q62F48LkyIip55SMJRyoCx+hfGQA3Gx3fwVvJ3fJLNlZ34rPjTivykwYxsCGVCV81rsrMvYrQnXEHylAlUdKjVeJB89obP3Cav0jXxQEK5QUGwdvxD7ISwqgtftQlnloy7Q5dIJF7K3nvSsmA4ONpidkSmOck1FSV9fUaXfSdfQeAiliySHwvPoJt55hKkdf9YbbL8SKe5A7IRjvbjRzqqC9FNzxYX8daIgbrxmEYChwSGHr6Sz3PYo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB824491.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(261009223027099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261021123027099003)(261026121527099003)(261022075727099003)(261021121427099003)(261022105027099003)(261026140227099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lgA4SpPg5exNMXZKPhRX3lWUD7K+r0nNUMfkoK3fNBJjllWNNJNXPtBhQr+e?=
 =?us-ascii?Q?czJk2I2PI2HjC09X7yO0puzeEVz9/aZbd1zrsUlG4oF77dEtXF/elAfAzg5Z?=
 =?us-ascii?Q?9uWBsBV/+6Zq5p9YE6jRRmG0Fs4sNBAA3dIr4n7Jo0Yw9DxhR3Xe2pBNFS7b?=
 =?us-ascii?Q?BmqiiRMgGi2NEnczqP1dv50gvHbvUfDQDs4Q+ZiJz26h9fCrKRgofjEinNB9?=
 =?us-ascii?Q?t7riyyqJZtsrxCRtn75Jx9ZMKk0MbcNV4p4dSX/NDEYF2RKZm0SUWiBqbR3I?=
 =?us-ascii?Q?viw/Ej/9yASsI2ZqgUFazx1lcMBanaC61tfX0aTbrAtzJHByUap4K7xnvhfC?=
 =?us-ascii?Q?yHvHBGDM4/tOa3rNsFNqlA/DFA8aJjoSvx4ledPLvtX9b8spfnxZVEU4SRWM?=
 =?us-ascii?Q?/j1RHA9qHf5bgIB376MF5Jl8mZT89CUeEezbclXuXXtfJXy/XFpnJseEBQqa?=
 =?us-ascii?Q?vxWRsXjZ3SPQKldAOQqxz9PnITwovLDp3jBxI+cpc9WESGXGXJ4zC52mqv4w?=
 =?us-ascii?Q?LtLNi7mteGiz36mXeEB9h05rEaAY32Y44K6E7HA13bYGdzzwkKn96VRQ6lYG?=
 =?us-ascii?Q?kv8B5bJyMBRIGKFU0yzIsBjnX0a8p/1iTCmiVSa9A7r0q9lwJiQauUABXU/g?=
 =?us-ascii?Q?UoAjWUOuImhw+mWO/9rFli3O/WCoSwcI7GfGBtS0GkUJ0m4VdMV3K+dSIi5g?=
 =?us-ascii?Q?5DnW6qfMHIR3pdqfyF60aLbjFmC5StIz68DT48bymV2EZ/abxNvTUloOLHdV?=
 =?us-ascii?Q?kwsjgaNSqzkCX2a+3aZ1z5KOSuIxau9W19iIPUR+YKlBFj5w83oBUhywqNRI?=
 =?us-ascii?Q?C6XQRTUoxC96sDqEMRhN93Bp2GPLUaYD3N00XQEz+5ixttpty0kKyK3/PRuw?=
 =?us-ascii?Q?onUVvK5Dw7dsAnUGB/XK8pmZ1cvbH7Jr/FbIU+KiRRuGl60nmIRnCd9irnBe?=
 =?us-ascii?Q?6+GospLg4c0HibHVd050no5BD5/lVYXsfMgvzsjur9y6wOhRNw9YgbXZWvoi?=
 =?us-ascii?Q?9EYmFbESTOnOUVbHKBtxgXcbsgZTmCc4r4C/ho/IlEAQ96Yc7f7v0wyXNu0V?=
 =?us-ascii?Q?kewVCFuvdUGqxmncqipRBcwmUuivXM3n5ZdWO5zh5YcKVJc8PRBJwVOqASgy?=
 =?us-ascii?Q?wl0bqDY27xkx3SspU8PwHUVWOxfLZTJoZhuZ6CRNWc24ALU9hHxEXMtY/wc3?=
 =?us-ascii?Q?0EuGVGhxvrB5LvHt5+qfk6P/TxR64OjQ5PAixSFpNX85EQMHcvcwntx4zWQT?=
 =?us-ascii?Q?CPBxkYHqS5FYd3wKWw6HlYMghSMH1S1IGLdv/8lFp69pTYUghNvZClXmogXu?=
 =?us-ascii?Q?UAy8uZ3/esWxtZqyunGJLSbAQhuUBv49SK1tuhnnsZOC1NJbnslukq8FmOJd?=
 =?us-ascii?Q?HsWex2y1fQ3KKjzS6A51vIhVyxWoMrEiqafTDfD7M11Wx104g/rHGo5Zt6qu?=
 =?us-ascii?Q?h3a+qC7p4yn7p/JttI1nHB/abCrk/dth/QyccvnGiKzczQ5eJ+GKMWfAciwi?=
 =?us-ascii?Q?Kq+zK60j2bzKGieh+GbQAHKA+hRPzKtY0Qy2BQQ2yF9BR7kNvpS+IOitehll?=
 =?us-ascii?Q?+SvYe6p9z5qrK268npTUbnmDeLc/ppUVpDr+40k0xa0rBy+0YTNbZOiAZxdh?=
 =?us-ascii?Q?LebI00FUV1bJtyMsJtLoLPDa2C9ufdptcC45IlTfBFWHvI0OTElR/DAhU2Fg?=
 =?us-ascii?Q?EtGpY/ptD9nWAV5PhLHzmo2FjO+Imb2NdRhXlZZ0ANFCyCVu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TEnZwotbYUTxiJqmJNMIm4bz/iTtxWNgBeFo4Fup0dcVLjOaaeunCcwCwW5h4ovePQ0O3GtetD5ZkraPuDcg+06KjtQnByDed0y5qC2JWyZY5BdLTIQ1LyVQJGJTnH+ScLJysL17qTzbqhKAuuuDh4WPGxsd3EUC8zLqzoOD3eNLhStH/gvoblgiQrHRyvoZPjJchYBvzbBn9iUvwPnZmqTo17kvU1piYMoO3R6L9Cm9ql33Ka0wK1O59sSfCb/4F/8rhmYt/ng37Mnpshh+/QUtxzfpNqMJQPKkLeT5Odvsv4DQcJsKXUSI8jzQeLfP+mDVgsyrhL9S3Ds+Aj7xyw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB824491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd53f59e-6d00-467f-ea7e-08df499024a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 18:32:34.8594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFxlRyBVi16PJKpfExMejqrIoDIhmSA2VxZRmS0rE6Y1IhR5xWjdJ8/RFJLo6Z6vTgWTSHft2itUg/oS6zm3cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6E8D29981
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Tian Xun Ng <luckilystar08@gmail.com>
> Sent: Wednesday, October 14, 2026 6:30 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: sashiko-reviews@lists.linux.dev; netdev@vger.kernel.org; Tantilov, Em=
il S
> <emil.s.tantilov@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; decot@google.com; Olech, Milena
> <milena.olech@intel.com>; Hay, Joshua A <joshua.a.hay@intel.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Tian Xun Ng
> <tianxun.ng@bytedance.com>
> Subject: Re: [PATCH iwl-net v5 3/3] idpf: keep the mailbox up while teari=
ng
> down vports on shutdown
>=20
> On Wed, Oct 14, 2026 at 12:13 UTC, sashiko-bot@kernel.org wrote:
> > - [High] idpf: NULL pointer dereference in idpf_tx_start during
> > shutdown
>=20
> This path is not changed by the patch. idpf_vport_dealloc() skips
> idpf_vport_stop() and idpf_decfg_netdev() while IDPF_HR_RESET_IN_PROG is
> set with or without it, and idpf_shutdown() has lacked the stale netdev
> cleanup that idpf_remove() does since 4c9106f4906a. It is a separate issu=
e; I
> can look at it in a follow-up.
>=20
> > - [High] idpf: SW marker consumption race causes cascading timeouts
>=20
> The set-then-wait order per Tx queue is the same as in the current code. =
With
> the default split queue model each Tx queue has its own completion queue
> (IDPF_DFLT_SPLITQ_TXQ_PER_GROUP is 1), so markers are not shared. Where
> they are, this patch limits the effect on shutdown to one 500 ms wait per
> queue set. Setting SW_MARKER on all queues before waiting looks like a
> reasonable cleanup on its own.
>=20
> > - [High] idpf: DMA memory corruption on slow CP during shutdown
>=20
> This is the trade-off discussed on v3 and v4. Without the patch, shutdown
> sends none of the teardown messages, so a control plane slower than 500 m=
s
> is no worse off than today, and a responsive one gets the full teardown. =
On
> the tested devices the queue-related messages took at most 240 ms.
>=20
> Thanks,
> Tian Xun

Tested-by: Samuel Salin <Samuel.salin@intel.com>
