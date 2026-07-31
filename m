Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4976FC55167
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 09:13:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A6D660825;
	Fri, 31 Jul 2026 09:13:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBxEJYRmkIlk; Fri, 31 Jul 2026 09:13:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F4AF60811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785489230;
	bh=8WrJ4QDOx7yAhfwsyhcOio5sAPpFezqN3DwW+56xWLE=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3KVs9kKEHz6XV2gKcVBrBVngx/nf7aWk2eB9HsanjwQbQUD2uplwTMgh/P9qaFB2g
	 ZmIJOSK+OxCSNWT/QqixBRT48lPd/zhAvgM7fhUF+dhZqPaIu8CKIgV0SjUUN/L6B9
	 ogAhoeasA7/U/koE+cvc288eAUUpXd5jLNIZqEzXlJ3/rCJnBr035+Q8Q7/Leqg4aB
	 Qs+wgu8/3JTWKiyeD6OxoTof8lqMuEtcujJkDEcbNaFpgJBlMOIALeeqElTI7hNGmH
	 omeH2gseiPRPR2U2Nhu2qg+Tjar+xmjjCsuf6a2TmqLbeoL5MnaBS18vqK6aeOwE+U
	 uBH60FRZTiwdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F4AF60811;
	Fri, 31 Jul 2026 09:13:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D8C1126E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 09:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEDBF60811
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 09:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PqBc8MU7o4_Q for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 09:13:48 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5F89B607C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F89B607C0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F89B607C0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 09:13:46 +0000 (UTC)
X-CSE-ConnectionGUID: Wj4hWOdkTwmsOQm41TRrnQ==
X-CSE-MsgGUID: KDfJaFVFSjGTKx15XsXFOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="103523816"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="103523816"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 02:13:45 -0700
X-CSE-ConnectionGUID: Ix06IZ5CSt6KOeH6kUvsag==
X-CSE-MsgGUID: Y8Wv+ug5Qwq497zOffJX8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="283860142"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 02:13:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 02:13:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 02:13:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 02:13:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzYw7MzFQBH2CChVfcSPAThgL74E7h8GG6uUnQXtYt2vSmABjEm/u0oUMCIE1hWGIYaURCs9/oO/7oqYpsUU4neEgF6dNzZ3en0dq22Y33aBis5jg1wvDF1LmzDIhVov03Ca83GcuJkXIqHlFFFAH7NUMOCiKmvHK6ZlDcqQN2cMPd3X5ETirLOxA8bvdQoVZ2srvdipq+jVPsHFQhdYUd0mh6DDURZyf9XIPpXw4bbcHBBheQePF0Uj/sa96XSEJ9GRjK2sEhCSQlCGNrCSVu6eD68ITCgpzUDCn4L7jg4GSsY3K5PAHm4UiXqaIgt6xNtr14ObZ0PrkrGTyiDZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WrJ4QDOx7yAhfwsyhcOio5sAPpFezqN3DwW+56xWLE=;
 b=N9GGVJxDYv8dYr2YZY1DCBRQKPbYuRdWilMvFsNpKlMdiEs0JvEHZxb1B9zMuxUG2RH/kiKcvoPekAZZ/n94Wd8hOon1XS7i+pRIDIopW4AUq5QfOzErCrOsvSjCPU03nmkgmhS60+A7RHEwCKqnvsvPR8ooSAqUnREud99Wg0MbuOBWnOy8eVKFSbHgtbWVfIj4o1QGbZSH2gZPwtZe6rbjKpFoLpbIUzsUMk8DY4hQkADQwf5s+dQfpVp92t0m+XPDBfWZVk8MuU4CN5mgUsppwlQ+oy4ZE0SVVkiCrKo5A1EkNY++SjsTnaMCAP6uGvuV751S3zavnjtwE2OqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 09:13:42 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0270.009; Fri, 31 Jul 2026
 09:13:42 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>, Paolo Abeni
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, Marcin Szycik
 <marcin.szycik@linux.intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "David
 S. Miller" <davem@davemloft.net>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 1/2] ice: move
 ice_vsi_realloc_stat_arrays() up
Thread-Index: AQHdDZulIcaBkdc9/EmC+T2zBzBZe7ZrhXAAgBv5CkA=
Date: Fri, 31 Jul 2026 09:13:41 +0000
Message-ID: <IA3PR11MB898566C971428C74D2CD2FB68FC82@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260706224346.22546-1-przemyslaw.kitszel@intel.com>
 <20260713140306.GF1364329@horms.kernel.org>
In-Reply-To: <20260713140306.GF1364329@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DS7PR11MB6064:EE_
x-ms-office365-filtering-correlation-id: 921fb3c9-c44a-4258-c03c-08deeee403fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: qZ7G2lt4KZWdqJfhiCTExYHGTXPRxJgjcSGC1+lb2+9MyiaoTgkgJc8cADDcyNCAFxSg+trOUbR6puuhOtrl53/IjjhlzCipYUUV7nf5wbObIn2K901SHVptcgFE4GMMyPrsvp+uBHXF91WMuynv0tamOivQoMvU33fxUE1tmJCCBKmydsMhh8xOAHQ42Zrp8NrowkPhx8DTIYhNWxprDlBOzmGZ31C3B45z5xNq77ke9UdJktV04C1a2rBDANbwhwxu0NkrfL598ljMMxz9IL+O9u8idmvphveSE0/wAnVWErki5IzyP0uNsb/x38MIStU71+DzkNbS2uTTY+b3AM1rlZr+QhkiRGDhLekge6VFXgz6hOTCZTYe/oGeV6/oUCx+srdJrXMBq58gjScsLiDsTKht1RbfSK2p87UbU41Yw/O+hM8RZzXfR922Wd+zFX75ocKf0KF0xzkMVK6mm4maeCO5L/yJHZOC8C+iNKO27PfBbyNTLgId2knpJ8eRzuHXCSfCayI3R2fLWoaik6BRUPBKeMxWgNmybQWqo3rZlZVDEuKABe7ksZ+zCH4gHiphOU2f11WWL2wEESJ72dvkUdaTdf5wfWlAjSLgnH12kfz3GWxLnuNKfVQh6oK1k4PZOBKtstmA831BCO5avX/v7hGJt9L1GrhR6VUn3yC2y9wDvNYT0fJ2jmZTJz7CuMHTsQzCG/XRNUkgjDFWmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jtErA3nuI1YFMKy2XcdqbhTxy2FhfKizLt+r6y+chxb1ilpJkJ4uNvUKO8eB?=
 =?us-ascii?Q?VxqEyySkVrwlfhRwvvqc1py8rVV6FiaemMLbSxrEb4RLF+2B05YDBfBgah4z?=
 =?us-ascii?Q?7kfp31i6Ce/eRYs2D/C5xusPO31LF2ToOrnCxHOUKX2oXMYsRcVwzDAPADha?=
 =?us-ascii?Q?Nk3emqPa/uqeC6IgJen1AMZEJ8h03eP/5WrPH9kn+7ajT/rHvcZAeCot+G4y?=
 =?us-ascii?Q?9BQfdrMirLLy0qGRg75rvYswb09xsSzzfJR7eYga9svnuUuO5VRqzrMZdD9q?=
 =?us-ascii?Q?ojl6B/0eZpmJtTVbpXQO8WrT54jfui40O9mI4QMAKToSXni7JpYW1XnJ4A9V?=
 =?us-ascii?Q?JJHSgRU14u9rzCdDDrlYETozX7CWE4Y15MmZo+rBr5Goe9sU74LpjaV1j8Ts?=
 =?us-ascii?Q?42ma6C5/w9xGFtMXGMRnWt/t6oCVqGaZ4TeyjyIsYuMRdC/4thJ6gdBp1sK4?=
 =?us-ascii?Q?QG3TAQ0gmSo0b5T/4VxFqgx5SuMk+aU5mBQqF31vs7rmxwKDpS52W6fimRe9?=
 =?us-ascii?Q?ik+qhkY32T+tVyCR6/hzCvJdoXGG2icPEC/hMml1LfOokXh082ELFyup8zqZ?=
 =?us-ascii?Q?/Shg9nYQn4OF6CbcZvbRcmvqiZdeYhQA3goK5Vi8m2LeSresgyaeqaqRSTk6?=
 =?us-ascii?Q?VULydKhwe27lZJDIX1UNPCk/Wj1yuUMs1bLpLnoJyxSkg83vdYYtvO1WIq1+?=
 =?us-ascii?Q?iaBrn7R086/qOVVPZwAqHTzMBLg8AzVVF4TviJoIyn/AeJ3XvB61CD1aL+58?=
 =?us-ascii?Q?Rh828a5qE1Df900X7sZkzayamKaVokRbKnOt/DddoUmH8xg+DVTSFNe75DgZ?=
 =?us-ascii?Q?ovKD8tJfwxkr/uLTTpZ/wgL7eQEn2PAUtGiQrYYKTktWGcM3gLn5n8eG/6D3?=
 =?us-ascii?Q?kc1WVi53tDRFs59W11yrGtT9vasB+Ym8dBXavoGJXnAwcyxKity1gXHHZUko?=
 =?us-ascii?Q?yfm9cOvK7NNFQqeO041n3NKSPM89revEbaei90nrpXJ4URLun0jYBNO4VMDY?=
 =?us-ascii?Q?oSMijZC5BbZj8CwQMmtzWTtr3sKxfmLoipjxXRSt3RRV/DlO7gJyKYH3JQ9g?=
 =?us-ascii?Q?5+pOoBqRT2iYHku8kX5xiRK+8oZHSmpQHJ/1lCuEhHA2dvbJ2sQXTZmTGB1U?=
 =?us-ascii?Q?mfefKaL9njq/2norF2Jjsw2ZgexCIf5F5iQa3oVogDgDfBiWMV/ObHg6b+Zw?=
 =?us-ascii?Q?LzEW3fi4XSaLp9u9keq+xEVb8deKiHnR5gsnfuXyTOmUHBu61oMJXNgddNMr?=
 =?us-ascii?Q?h+28/DJhjeMitEyaL7JwkvZq8W/mwJfPrUMne0NqC1aaWrHLut+jzsrJVPA2?=
 =?us-ascii?Q?YXNjHjOWMSNfcTBE6p4ZYPSWTh4Enjtm+mEsMny1wsQszSz7x1wLS6MzoXXN?=
 =?us-ascii?Q?OWoWCMikWgfb6gSMSYmJg2OcmNTTpN7jXWBmJJg1F4FvOrgG26xahh5Fxc/k?=
 =?us-ascii?Q?7ris8Ui0DJ88xEHgEoJ0cGucrJ9QEJHSLvfKee2kUhTfhQuXBQ/XmpJJ1Szp?=
 =?us-ascii?Q?zGJb26i3Nsi3ZgEv5KhQfJHE54W/vEnaJSMoFCXoi3IN/EhbcHMr3eT3mq/a?=
 =?us-ascii?Q?IAAOwpFjliQFlm7/GTMQI6VdWvLPBhTXkUHrE0D+GmC6bEKJcDKfFXEu82h5?=
 =?us-ascii?Q?uiOC4j/tTL5kBESVc/Tv3PDUlDB99WzD63yWU7tY7IBmxnns1oBuJOqP/lY7?=
 =?us-ascii?Q?FyFU0cH31UFCAE9Tw1gCeyy9hK08WZeGb4kdLLnen3TepXjBd9VHbkwxI7sA?=
 =?us-ascii?Q?oAMeraAWhQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MKdLDsuS3hW9JD90MU6ThGoEDIZsLY3e5diRSathonqlH0PM/fiktth2w/u5yA8MvVHZ0KqPbh0q5dSKm6pGlEpVGgWsHhNgiyLYDkXBpeAgfETLcX5JhL78lqM+zkTk8ju54skHK2caZVCRKjz6RAovvmgQltRPgfos0diMLDO+hWkryLCzrha+EG8Gx1sU6nJQBnYW4PjjBWJ9OrnvDY7j7MwzIE5dU+B637cP9HEPF0aPpYkq5Cv5hevgHF7h9vunHhIpSw4hknHf8X1AIzmVountRYDF4QEUmD0wemsBA2jqj/n1OH1Xld6kGf23s4gkqZxs5wf9lZ93hF6D4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921fb3c9-c44a-4258-c03c-08deeee403fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 09:13:41.9369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygHD09qWjpY5W9tmbW3+tvFELMgCDxcJQdY2jTEPHuoRXn+fDOOGaxPeHAOAa4HmJqpxVtXYCBlZE6zj99OXLuTWGC60kCG1FEboPGBltwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6064
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785489228; x=1817025228;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8WrJ4QDOx7yAhfwsyhcOio5sAPpFezqN3DwW+56xWLE=;
 b=hTTTI6Se2VJcafou5fZB1oMtfz10wPxoxp+tVG2JNc6PJ/qduEQOyaof
 LJYH2LI2sizakYu5XWWdHwUjLsfWryYexlYZokU2QbsrbFaJpkX0MaaK9
 jyddomfjn+wrjVMseufTqUI9EOsMrl+tJasCSxHZXDaL/bvdVrW3ZLRIb
 5Y+kgcxXge1OD8jRSCfPaxQMU0drKeax549xt9KzPo0T+2wINkGM7/iZ2
 P86NrbYLHmFuZe0xLKj9zbLiBFRChX6DPVbOQncKdQBlXWWtOC09iWObg
 4jb50U0CBxa3tuzdpzzoN09IazWVYvKw8XeUZX9VlCFlW5OnFwyyWDfLv
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hTTTI6Se
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/2] ice: move
 ice_vsi_realloc_stat_arrays() up
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Monday, July 13, 2026 4:03 PM
> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>; Paolo Abeni
> <pabeni@redhat.com>; netdev@vger.kernel.org; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Eri=
c
> Dumazet <edumazet@google.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Jakub Kicinski <kuba@kernel.org>; intel-wir=
ed-
> lan@lists.osuosl.org; David S. Miller <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/2] ice: move
> ice_vsi_realloc_stat_arrays() up
>=20
> On Tue, Jul 07, 2026 at 12:43:30AM +0200, Przemek Kitszel wrote:
> > Move ice_vsi_realloc_stat_arrays() up, to allow calling it from
> > ice_vsi_cfg_def() by the next commit.
> >
> > Fix kdoc for touched code. One line break removed, "int i" scope
> > minimized to the loop, no changes otherwise.
> >
> > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > ---
> > v2: no changes
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

