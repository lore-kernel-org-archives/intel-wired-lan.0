Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D3606A32D
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 04:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=E59gj+86;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mRcxtRIn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4B6A8135F;
	Sat,  7 Nov 2026 04:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DTu8nGXyE0yF; Sat,  7 Nov 2026 04:53:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3651581360
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794027233;
	b=pgCKtDTQFFPSbZ6qo5cc/ZyZnLc6CgLpVV2xAHccZKEfPUZtWeUOObL6SXG6ADFsXyVO
	 Qi2NXquPbyVcrvbq5OMh+O7+bcKX++T4yuKl40ggfRAP3if2MJEJV2sIGck79CEyFdB+3
	 V0aESakI8tZJpyDc4miUHsvjJ/DyooUsfNRRzz3eBU/eNhg2wuprJWtq5llN5PtPAdMQP
	 ofgJbsOsV6DdKwsHOeURkTV1jCNHaVTSRYGCvuxcDocniSwEiLE7Z6Yd/T0LSjJ8JOhRu
	 apV32PBZBrcEvxjo0dsNk19a/s+WQuqxlFBl/0l79hnzG/ZDFG8ynQNWxqhVFtpVcuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794027233;
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
	bh=A+cbNZ30+3A/Gbsl2HKyT6P39ueit/SNGYE2LlSDNsA=;
	b=qEKFDVklplOuJ8/l/Vah7kqLVZtFLX+gfAaK9LQPuwRT802Y+QlUPyozsGxdSu9rz4+B
	 cyDCmOnj1DDKbGef2qc0csPU/if7bc9O4BLNSUYcQV/9usbXKqc0TSHQzPQDwq6mr3D/e
	 QdP2HhcBX6A2BsQZJvpyaTcpif3Zda0X4EojaeFX4PzkaiTxMdBKHfcGBFWWiCiDZqbye
	 +vVnZJmqPrQJgHjuhsq1JECb+JEfMV/zmn3JkHHIO3qHoAj4JaBHAk7CnB8DFq9K0kTl9
	 SODsehi3J1bIV+MLdh+FcxD3pLbAU5E2RyH9beAS6tFxk2rY+KX2APWl/PpLcq1Th3w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794027233;
	bh=A+cbNZ30+3A/Gbsl2HKyT6P39ueit/SNGYE2LlSDNsA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E59gj+86hWIAOah1cCTLh192m+CxYABETqDApmbFbmdmfrVPsVNAFGAZjYuD1ymc+
	 1pqqEYy3Q6+CpK2EZyeCQmGilgZ7donr7joRJG95egEpK0KTu/wUo4Wk4Mv9cZTW4y
	 l+yX44Ju1Ms4yrm0Ryil+RIkUCALMu9E8pW7HdN/KS6RWFp4pTEU9UMiwOK7iK4Quw
	 Clw1cISwAmi5cRtS9YcFTL4eT8uy9z3g5HXAY7F17qW4ReZoJxA69sgAGSjQaxtqbS
	 8a268F+L1dRIpbGRFG++LN3zDIA2aDRT5Nn4CLPXkevuQPA0pompaIUOWddqOHEZWC
	 RJW1Ch1Sa5YOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3651581360;
	Sat,  7 Nov 2026 04:53:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E229B32A
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7FEC403A9
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u4us2cwY_bGs for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 04:53:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E896940086
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mRcxtRIn
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E896940086
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 04:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794027231; x=1825563231;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nJvvvIWF2ekRyLigpQBCBh2jDu6bSntgzscKmWTMRgo=;
 b=mRcxtRInAgq9/iPXdN1Bhbbr1n7Wpsyo5qs+bQ9AK3hkynO+3F2R1hYA
 1Dn0+MIgUcjoJBlrJlMl9EpPPxV0XdOFCHBaWxO1SpS36VrCgjk2VQ6V7
 RXqJaP6l43CRlVwIP4IgsiolfaqeVW/sxsFAS/34jzVZ3Uw0bHyuqvRL+
 nnUSqOYP35OqXWpuPtqEX0hIrJIDTc1Qqh/XhhxCAlDPUp/W0K1qhwO5f
 vicErNUyUqxbq8igEMc8fpP0d6ZbKuC6nTQV96WGVTjN2rc0sBLmKzaHx
 NchDBy3HNurIko6NmYPsv3PT2lELDx4nmAhaDjd3zbT+ku94DbbG5/Fpr g==;
X-CSE-ConnectionGUID: EGEXvjzfQTeeJmO9Yyz/VQ==
X-CSE-MsgGUID: AKbwXgWPRLC4PogZWInQAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2741044"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2741044"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 20:53:50 -0800
X-CSE-ConnectionGUID: eq7Vofd6T0CMdUgLCZxe9Q==
X-CSE-MsgGUID: RDqjrVg+RQKTx3aBYMLm8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7761443"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 20:53:49 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:53:49 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:53:49 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.15)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:53:49 -0800
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 04:53:46 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 04:53:45 +0000
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
Subject: RE: [PATCH iwl-net 06/10] ice: keep adding MAC filters after one that
 already exists
Thread-Topic: [PATCH iwl-net 06/10] ice: keep adding MAC filters after one
 that already exists
Thread-Index: AQHdUm837jfy9ezxEU6d6cSnmHgRlLciQvLw
Date: Sat, 7 Nov 2026 04:53:45 +0000
Message-ID: <LV1PR11MB87903346C6B1C86EB3345A7D90752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-7-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-7-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA0PR11MB7840:EE_
x-ms-office365-filtering-correlation-id: b09209c4-1d9d-4052-e185-08df3c8b1ad9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|21046099003|10067099003|38070700021|56012099006|4143699003|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003;
x-microsoft-antispam-message-info: xd6SHvwYPybPCla/efS7T2hg1mtPlimqiEgXZPoZmoEvTO7MM/tUl3hc7h+5xHglf1so0m0WVeNeWDzwbaaXOapjY4cPZUEm+UR/S8TqXTDyb4OIJRn8+Y8pOlXZ7NdDiCZTX86jAx+v8K3vZbFWIuNvSTZAMo5tw70HIZJ753pO7pHxSrf8g3Prp/NS1CNdNu/L9y1tGf+U3a6Zmmq1qSCcZ8Xffk+B3o3A73PVlL5Hs+J+uIZ0OdxaM82poha2OzcoajEdICqeS4GAbkYx59+xpoTDmp3293G1FC71zvzxWuVQVzlUDN36XnpzWrT0YUZPWKwp0Zwd8kc/6by+tZRJxM8H1p/esoFAVU7bPMzY4caI6ZS55kVIblZht2r5mY5DUGh3hGTQOC9G6cKODZgSY23YkE2zCVTGVlfaBgYFjWmgo0gloe0neq9kk8Up848n004BG2jc5HYfUc9ePjGZYssqhUo4Cl+e+QYcXGLDVEQhvkDQWjf4zqQuFw+XPjeu2Xy0N0XGM+zmNbSnsVs6jmwcjRlh5wRLX8mMdrMfIz+LEbSFYpAWL1HBEO3Cajkkapy61/PuEfuB2OCjm6Wg3OOAtRKwkvmNSsV2DCtbN3htad3O+pTFbL7oxNqQwmg6bxb3Ew8lTYJEigZ2NLTL95YJhE4i6lio040AT1Pm5614Suu7m5FwpdXKYRZ2sAwcJzl1mtQtOutBXDj8shaBxQUl5gQQDb0j/K9rBXo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(21046099003)(10067099003)(38070700021)(56012099006)(4143699003)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?660eFt5BAmYt83nLrWTwgDgm+V6ziWuKhuELoSmivI0uNguyOlOnrmPWrLzU?=
 =?us-ascii?Q?MtSsq3N1SUJKf/GGqiZocpDeWvINNDbGgpif0xidAbSzq2gskVV2c1mZg5ya?=
 =?us-ascii?Q?sOqm+T79KsWrcetVfnyv6DV3m4FVoBoXis1fNvGNCpXchEtq5BjlyomCXKjc?=
 =?us-ascii?Q?BgQNVMTA5IfkqcHCqOyq/mS07OUYr7Gj8dtrefQMtLUOEtnW2QwRI+JOevnr?=
 =?us-ascii?Q?irGBMfLuSpMTyscIPStXF+irE20Ri4vGuwbLvntdG0hnZE+RjLG044bV04j/?=
 =?us-ascii?Q?GYpIuXOmU+GZDmFXA9vpcRenjea1l22V8WgsegVC65tFhhloxj6ldstoEnuo?=
 =?us-ascii?Q?Vcqykjl/ROoPdz5aJnUN9A5vTposDGVxOuU426zZ48jHSequ2O9Cn0jXpc80?=
 =?us-ascii?Q?PbLCiZSgWpKs6SBAvwGzQVQvCF+hjEBR2LswxSw6I1IifC0OJjCVu1X3Z9EL?=
 =?us-ascii?Q?r++fU5PIemm7LpTcn+yiaMCWddYtcZICwJaHHUpq13u/DjOu9Q5UDRZOUwpB?=
 =?us-ascii?Q?9WvBE1dHOWjx5vx6LzJ6cTPv9fqH4aXW8EWKwg1BpToTDke+uwOyov/aVwK1?=
 =?us-ascii?Q?1gX5hs2BOjPBm7ZAlUc1d7Ee7BakowZoQK59cVxXpSSsSjbTbSy6Rosze5iM?=
 =?us-ascii?Q?+h4lrkHQSdphYOkh75ivMLLIK7R29OXMJqNDRZ/+2PZlQDh5xSpdD5wkid25?=
 =?us-ascii?Q?m6xvuxotYRwy6sROBGNJUQC1wuPamd/12nr7zQv7DjZPa6/umqaqyVjKXPa7?=
 =?us-ascii?Q?4x2v+s0BDBsBA4kitZrJAFcYFVjUdMPRSYo2f0fk00xrN7L9ILf5MAusHtVy?=
 =?us-ascii?Q?ypHFwYZQI3Jr2ltNCfHRnDUpRa003mzm+biToZgUFadC8pBd5M7QlNze9xOz?=
 =?us-ascii?Q?8Pake/N4gF2EQ85BhhFW0XUAwbST2NPbOE8EJc+eD2DKyFzyhdNAh8jH6AUo?=
 =?us-ascii?Q?I/PPacutmQi0GTpKMjYTrg8FNaBrTTND6TLLp/Ccps0ApjRzT7RBB1uauP1W?=
 =?us-ascii?Q?UgXbDuMeQZq8Uh7FlsyrT+nUI8Dbxoa07l6iJ/7ByvI8QyYW3bmEWgSez3xo?=
 =?us-ascii?Q?yXPx8WtFoC9IsA31onXZgvRYNHgNnIo6iOUWttxRq8rz/FX9rJBW+ZsL9Xna?=
 =?us-ascii?Q?LgWz9Djk5ZDWdpCKItikDkkx7bxmdqZtitq0+VfGcTfQbX5go/99ow5u+Z7i?=
 =?us-ascii?Q?wHzCyBR4G49WCWCjEGMuSKCsEZfs7o3fad2aKy1y54EXSIn1TG/Ah1ftTV7E?=
 =?us-ascii?Q?TSN8WC/L6stLnkvl/ZFa+PdIr4xbIdg7zPW5pa8ajdHlI7l4KeG/fhEA/GMW?=
 =?us-ascii?Q?zIKPEnbNuyg4Zlahw5R2QX/bh96eaVwk0rmeUHf6IQXIhWSwteoaPvmgdUQT?=
 =?us-ascii?Q?ys/4N1drbt0vVlK1ZpWYYfFFpH+ad07ncx2pAQCJ+u/89lV9O2I3dghYqdxm?=
 =?us-ascii?Q?wNq/xbv2z5QbJUIBoxnU77u19xpxC7wQoDfT0cLortJlMgDTx0zETiWaGGJw?=
 =?us-ascii?Q?5BNVWi2I/YFZT3Y3YNMWDsnqKf9F95lcyIJuRgTDHt977cBXew/+bKgv5UuZ?=
 =?us-ascii?Q?ZJalhx0WRq7pryCx1sOfZr6+jxirIj209r7Mp00Ryv9gHHXImPXw29HKAutJ?=
 =?us-ascii?Q?FD2CzIJTSBQXxGUYb7NavOoQdHdLRZgac+r7HA6pP/9d6R7V7ZMbKGAyD8He?=
 =?us-ascii?Q?3XBdgMO9SkHmHeK/ap5NA7raQi9Ps5R22rZf9lJnCUg1nysd/Ct1V0CQEU8g?=
 =?us-ascii?Q?+/FNiEgf5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H079O6HinVdtJE/HF81VcquoOqdpDP+pDhhOJvJ6pdjP5hSsnb6oX1180Q0hqaAhko/Y8odPGSI3z36FsGGKyiBwxgyZl/ey2W8xuUVends+0lxzaZMKsn4FIylmS7S8kCr/dHVtSx9W4qvJJgdxa6fpyflifzS2v8JVYUMHctv6lPAF0RvVExVmGTU9LSwSWlMk75uL6lt5DixDcV0JJSb/FZ3GYWxdEX62+bb3XAdg0o8PtsLQln1Czo7e//30JVs6EOo5yxBav9RKz9jOVHQ5g9iSI0vDLLjEIQ/udZJWLVg/Y1VoDl7CsUNp0Iv9uWbEm/QufTQM07XYCL5vVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09209c4-1d9d-4052-e185-08df3c8b1ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:53:45.7925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKC/iHswyZ9aoPrqAzPMQKqweXyouGyf8VvEE97A/ioGpUZ8jSf+QiLcGo7It6nB+g6cTdkHp4iOk90m0DkNdAHLlE+4q+eKRpoedOFJOkY=
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
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
> Subject: [PATCH iwl-net 06/10] ice: keep adding MAC filters after one tha=
t already exists
>=20
> ice_add_mac() returns as soon as one entry of the list fails, including -=
EEXIST for a filter that is already programmed for the VSI. The rest of the=
 list is never added. ice_vsi_sync_fltr() treats -EEXIST as success, so the=
 skipped addresses are considered synced and their traffic is dropped until=
 they are removed and added again.
>=20
> In a test that adds 50 multicast addresses to a port in a burst with the =
port MAC address in the middle of it, 19 of them were left without a filter=
.
>=20
> Continue with the next entry on -EEXIST and report it once the whole list=
 has been processed. Other errors still stop the loop.
>=20
> There is no i40e counterpart of this fix, i40e keeps its MAC filters in a=
 hash with a state per filter and syncs them differently. It was found whil=
e building a reproducer for the MAC filter overflow handling that i40e > fi=
xed in commit e58872398684 ("i40e: fix disabling overflow promiscuous mode"=
) and commit 7363115efb04 ("i40e: do not force filter failure in overflow p=
romiscuous").
>=20
> Commit bbb968e8b34c ("ice: Fix issues updating VSI MAC filters") dealt wi=
th the same problem for the VF MAC filter requests, which are now added one=
 by one with -EEXIST tolerated, but left ice_add_mac() and the PF filter sy=
nc as they were.
>=20
> Fixes: 89f3e4a5b762 ("ice: Do not bail out when filter already exists")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
