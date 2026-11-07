Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF72606A32C
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 04:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=jZkDluvs;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cz+FPUmz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F323181421;
	Sat,  7 Nov 2026 04:56:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ie74okTTKT0; Sat,  7 Nov 2026 04:56:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C84181423
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794027368;
	b=h103lMSS67eBM8tXkIQ1gXdVv+tfQEY/Z7DnCsV9nojEkJg2QwbJGlyfPJ+SXmlceSMI
	 PiUv6DfJndIeq1MkwFErACu9bURzoNYahuNBmIkhbdWMr5GFCbKWeutNSrXYGgpdq2gd+
	 Grzm0+62bU33bGcoZ9OPQkuv9fq2+ZQmR2jRlXGZ4LdUz2oY2aO6oDA6++7sWEU6hYnAY
	 WrQE4is4kmvVARysczXYado9gzyTpQprnFp22a4O+odQzGGEUMtwiQPnbWAzzrUIAY8ns
	 qxJTqTpqlaHvPIX0vZn2CHgZY9/h/gqY7DwsLyD0eHC0yS1a3qRsc4JGnfc9i68C4nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794027368;
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
	bh=/8y3rcvkc+yr86Wnyo/1fKVeDs0VIENm5B6T/VCqli4=;
	b=NMroeE7TOeP+bryejunZMZ0A8b6p2bFdZgx/BBPdO4LucL0/LiGNHt8BrBMi7stH9bXC
	 lMAKeg6MzZdIYFY/F0p/h5sUlnA37fTblpxKQVZ3lyRWIRpP9+AY5bnAYHwHLYnxDZUjB
	 ks4Hd736GNHjQ4PSGy7xgZhY6I4iLQHc0Xqwz+bL/nbzn97RvRPkNY/PKOzo69gpUuFm2
	 O+duLncbUMLsZ0mKn6OjhvrKcT2aj6t/dt3Cdfstg3yZREgFqaQu1bRr32bbHM6ZfVj58
	 MKD14LhKjdirsfV2zLf9qzQbmQnPAratOGryXwqcCispgJIia4fduNrwTJLENYle2dw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794027368;
	bh=/8y3rcvkc+yr86Wnyo/1fKVeDs0VIENm5B6T/VCqli4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jZkDluvs4ga49k6wp4rqmIKnW2caDCRfuXmGlRZ/iwxbmC/Jyicf2wJfsxWJ3OBQ4
	 pxV3p3uRdHvpeVysykw+nLxFGAQ+a4GGkNMs04Tm/7vEY/Icbootm0BXPvJxaJWOod
	 Ie7gVR6GEap28EnKjn+kBTMZr91HbEle10qGqgK0BXdiOccjU5SxRsIoT1+Hn6W8NJ
	 jdKfmFGsZlgV6dHWQ30D/9e0Z0voTAphCRCy9BhGVbclBT5VaqNjRdLGznJ+S6KEnM
	 owJG1Iup60FyMm5xhoFsQpFC56E84tgvgnmePRG7jKdYvlyUnALhxV8CsaCyE0dJey
	 wio04HEpSzE0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C84181423;
	Sat,  7 Nov 2026 04:56:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 15E47362
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 025A7404F5
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j83JurgIM5My for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 04:56:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 276C7403C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cz+FPUmz
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 276C7403C5
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794027366; x=1825563366;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7pE252+Z85HfkY3LQ1Eiqp+tzLYAaPQQ36QPAXyQi5I=;
 b=cz+FPUmzoz6T6APn6h0Io+SUUeX9UDcGJYQUc2nz1F3x3hMqiVRapoaZ
 xrFHxw8VMERmc0wXxN4YxBhgS+Cp56wnW9ABLOQDNZphwMnUA2Iekqg4k
 vg1+aCij4Hiyn0uKw3ZdcpTuvBsuALWHvumiRdW2h3ZyAV06tjFH2dKR8
 o+mKg2QFbvLO1W4FrL8aaUIk6QO2g8F4lNzMtgZNSha4YmwXwq8QIJjfV
 pCDnyXYKKUAKua5UIuEfQ/d/rujzsvB0JeT3WHe19/gQaeRjDm2orXfYh
 elzFPNj1320DfME4TMUC4Zj4OpiwR2SGrIInjXI9EHLj94gTi4TltC6O5 w==;
X-CSE-ConnectionGUID: pi1IkEtGSgicykuFS7UT3A==
X-CSE-MsgGUID: RMhLN0cbTtKgMa8vtx3bkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2869208"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2869208"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 20:56:05 -0800
X-CSE-ConnectionGUID: yZGtXldJRKKo4TexMpOxUA==
X-CSE-MsgGUID: oMWSIUgNRni8nJOctc40Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7460012"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 20:56:05 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:56:04 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:56:04 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:56:04 -0800
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 04:56:01 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 04:56:01 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Henry Tieman
 <henry.w.tieman@intel.com>, Anirudh Venkataramanan
 <anirudh.venkataramanan@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
 Preethi Banala <preethi.banala@intel.com>, Kiran Patil
 <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH iwl-net 10/10] ice: fix unsigned stat widths
Thread-Topic: [PATCH iwl-net 10/10] ice: fix unsigned stat widths
Thread-Index: AQHdUm9XHx3EaOfZfU+xoDvqx7cPO7ciQ5ow
Date: Sat, 7 Nov 2026 04:56:01 +0000
Message-ID: <LV1PR11MB87903A1F5FE239CEDCED2CF490752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-11-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-11-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA0PR11MB7840:EE_
x-ms-office365-filtering-correlation-id: 8bda3555-e813-4f4a-1a50-08df3c8b6b9c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|21046099003|10067099003|38070700021|56012099006|4143699003|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261102130727099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261009221227099003;
x-microsoft-antispam-message-info: T1Lr5Cl1WsKCtNQxYcDvQwMekRMvG5blerP7B7j7Yclma/F8V7jIUxhwR5FOC7bzPzclN5GYSl8kY0/AQmoXeSM/i/QcqvE+DgaaleOXWO/caK6tOwWeJzbyudpy3POZo4pdv7/oFBX7j3h/47ISHHhWVBXoNlWVEEpkyCVXGG2IrH62ByONdXk1aZ2sKUb6G0Tb2am4aFo+RCaBNn0L6qI8DrGdcawMfCP3Lf1DlH4bIgkBah8sHWprSaGBcxBz3PIwEo1Vk9zcwd4hLejEVJn093q6I/eC+2MAnFwFoHVH+hkylt3ye+0k4SjBOzG6FRFCUuUuo5NppG3dw4F7mDUyb6r4xwflrc60HwWQ8vjHhyptpbdJIxiQxnlOG1qbFv38SFcPnKDkuzSZO/4BwtSGQEMP2ykHJ0W++VB8x+Eh9lBA1/xTa2wSySEcUyRJFQs4OIsbVRCVirs9wNdInzXTm9cyTwrCWa0NRRmJD/pdclage0LMFBi3BlDqqRuOjewkExfLT2UqUrpdZrussoQf2e3njmrMiCr7+EKuC50hdLv0Kgm5XptpxB+e33JrXIaoKPC33E4stbNmF/vUmtxfgTTTdTR2NIXPxor1FO9eD9twJ+oZVwkOZhUgBJINXeNV47J32YdAwUdWs5FwKGrzUK6ccM8CpTsS3Fak6JQRLhEMVE6ywZHu8E4ky9cSS9amEu9BbppmIzr6mXOC5337h605BlMNb3rQPaotS0k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(21046099003)(10067099003)(38070700021)(56012099006)(4143699003)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261102130727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BC6+vJu3c6Iu7ENDsW/4uA0OBGpPoRoKv7zYNw/KjW2AHG2R72Qq2XwJhUff?=
 =?us-ascii?Q?cHynf0mX47vQMummsKk24SgsqL02GPb689hGvbW0LBImPPsqYka8oqCGAF8O?=
 =?us-ascii?Q?OcNG/3idpBTjpGivHeqtDGYlTjCWyLW8Isjc1J/+Kbsd8NXdxVgQHJVEeGqU?=
 =?us-ascii?Q?fV20Xi0qZLB6irdapu5BSBbToU1t3rFjl7fd5e40hjUfGmER4HNKJ/r6mGrC?=
 =?us-ascii?Q?qzOswgRpn1uu0Rr410PrSofiq0KSXm68+VBIVUbepNe21mz/qhIGlWimgouE?=
 =?us-ascii?Q?T+JxgMFn/P5FlSRz+0xTe5+fMckwkYul4xAMOD1LIlj0KbPLiO3nHte3dk1p?=
 =?us-ascii?Q?CE0KKj7BWuNrHuvdJMS6UMbcJjDMq7Zk7xvhA+PBf8WMYC6BdCFhYQS4k+Gl?=
 =?us-ascii?Q?dpSNv0dzKAdmqMyH2SpMZOBuXQ0MmzfyLpbPuM+wBwAknGyGW3wulV5DZrKg?=
 =?us-ascii?Q?HkGQWJPUyD91IxBxKv29GylOx+yAdie5uVgjYezfFVkjr4kUFXHFotpS1xkI?=
 =?us-ascii?Q?s1wV+z8+5GotF+1Er6a+qbsotOC8K7OErRBnaGBd8fF83WbSzovPoFcq5VCF?=
 =?us-ascii?Q?fgZhYWEhZ2R+mQ+QgBJAPER9muhoBItly88LJx0qY7u79Lr0gzjTADG4TDg7?=
 =?us-ascii?Q?zZ07BMhZ1X5Z/eFKVYJBtxTIANs+or8TNcu6hxC1iRgnKz29WFqaR5K0pKQE?=
 =?us-ascii?Q?uXRWHgEUjsyoAf+FXvTwdv7n9DrxiVmeXS46PKrkjVydznNRdQ2DsX5TXy1S?=
 =?us-ascii?Q?GbEmrve0zYoiZZYixsi/gAEEIMMvfHLsYxJ+hTJYmWisPSQlJT6OPY9Dl9b7?=
 =?us-ascii?Q?PEOaIkpgJwXHEOkfSY89Ii26U9lLyUVodnSA8iC8oQCMQIjt4OQarB5NWm2C?=
 =?us-ascii?Q?ZpnOQwJubgE80EME8TVu/GA6CL7UHjNF29nH6Hj6pLkOXLMA1n5s3nACo4wg?=
 =?us-ascii?Q?Ot02xyS4oGOTMR7lqhloQaJWfq5z/Hzf91XIpkOqSI+pUS7xEdaTwkNGfqaC?=
 =?us-ascii?Q?cDeVz/iX6K1MpHW6nEgWSygkxay7/uNUSqHZQ2DWgFGgoQBfbyVs4o8lB4xg?=
 =?us-ascii?Q?uV8KCaHs9HEp8zD4oUmADU9Bm7asPi2egMgF4+gI+3aTfDhSwoDnKXsaqJ5U?=
 =?us-ascii?Q?eXNyV9V5JUCBsJ5+DSdG8bJpLqimQEsGtaxJftWb4F3tebm70BsEJi0T0Sxu?=
 =?us-ascii?Q?hIK7LVqVz1nDvTC0a++BeCQ3Ukp3jIQNQgAx/0+x7r5vLDOGFVL2LYra6zuu?=
 =?us-ascii?Q?Z9LQQbIrUDwASGQm4lM3zEMwUBDkkDp0hC292Lnl5q03zU35Q0hnqY9IwgJJ?=
 =?us-ascii?Q?Vi5JThWyyUDqEinP8665sdD3CU9cAxTGNSwumEubctn9XjJCTOpjv1Nz0efm?=
 =?us-ascii?Q?Yc1ielX7f09/lLZ18+uM08DSPgtaiwUiq3EMWj9OI11ySZE4W0Fy8t5RTiKX?=
 =?us-ascii?Q?07ePT5stfFwtkGzFpDKLXX7zLSmCpaV/1DBEQpmVQFP9WKRg7Mw/cPhlbtYj?=
 =?us-ascii?Q?D4SGeViTrz0Wr+xy10QbA1BVctoRYL+cPUPjkWPoiRxDZh36X1+IA5oMfPbE?=
 =?us-ascii?Q?kTaCpneQbpqPCwNLY+ajjWHTIcT6mIHPzZ+p0AYlYn3HXbNdWub9fUnj58Hp?=
 =?us-ascii?Q?LNz0qINHisAZD/66URT0dJzvGMb0L3w2WwC9kkyka3amIN2zKOG8RgfhwsvL?=
 =?us-ascii?Q?geHQJxU0KrVVuOdV8803ss2hmGH+tETEhcs+DI4HHtUhQp+diEZ5o2aoidsO?=
 =?us-ascii?Q?52G4FuzexA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dVvt7e2Bv5gI8bymmI+IebCk2eaBi2w+xfraBEdctLPvTNPc1y/MjaMYQgBeLDL8+L0i2zK9BGGd+YfXTviavgV0PRLUP635tIxHP2GiYMhYQl1tCRaqk50Csf3uEjTaKNB6e5G0VUyB3jJVNrWL0lmIWgENeNcJsacP2ONVIkyw0ZE/SYdCvvxehOxF5Rheh3P8+rZfxKfumuqS7X/mI13leSr8zNrxrJ/itJ8+gYff53kAnEo6PS8Do15Bi/f2M9cFZw9WcZw9t1A29hG1aW9DlUpWTwNURDhXC/Azh+J9q/+Mns9RFAXk22wzib+kkFW2NHd6WKBm1Lt8ql7LKg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bda3555-e813-4f4a-1a50-08df3c8b6b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:56:01.3031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cb9v1kYoU+fs2ZIJRSPJrcTFaDgHf1PnDMDGITVC7gGPGIZym5z6GsBvc5fBaz4pHyXPsNOx8OppaOcSNAkiC45xs4meZ9Hy6148ypc33m4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7840
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Petr Oros <poros@redhat.com>=20
> Sent: Friday, October 2, 2026 6:08 AM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L <anthony.l.nguyen@in=
tel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn <=
andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet=
 <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabe=
ni@redhat.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>; Alexei =
Starovoitov <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Jespe=
r Dangaard Brouer <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.c=
om>; Stanislav Fomichev <sdf@fomichev.me>; Henry Tieman > <henry.w.tieman@i=
ntel.com>; Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>; Micha=
l Swiatkowski <michal.swiatkowski@linux.intel.com>; Jesse Brandeburg <jbran=
deb@kernel.org>; Preethi Banala <preethi.banala@intel.com>; Kiran Patil <ki=
ran.patil@intel.com>; Dan Nowlin <dan.nowlin@intel.com>; Stephen Hemminger =
<stephen@networkplumber.org>; intel-wired-lan@lists.osuosl.org; linux-kerne=
l@vger.kernel.org; bpf@vger.kernel.org
> Subject: [PATCH iwl-net 10/10] ice: fix unsigned stat widths
>=20
> tx_restart, tx_busy, rx_buf_failed and rx_page_failed in struct ice_vsi a=
re u32, but ice_update_vsi_ring_stats() fills them with sums of the 64-bit =
per ring counters. The values are truncated and the ethtool statistics expo=
rted from them wrap at 2^32 while the ring counters keep counting.
>=20
> Make them u64 like tx_linearize next to them.
>=20
> i40e fixed the same truncation in commit 3b8428b84539 ("i40e: fix unsigne=
d stat widths").
>=20
> Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
