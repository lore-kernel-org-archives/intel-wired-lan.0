Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0949C55ABA
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 11:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5188B40722;
	Wed,  5 Aug 2026 11:55:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5bDZW0XepYI; Wed,  5 Aug 2026 11:55:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27845406EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785930918;
	bh=8m/OfZdr6yVYWqiU+XH5UjeTisPAom66N+fmTuETQyk=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9uoo8OEjeLGb3d3C6/V6fuaPVxujBtEz1C6vlhdNH6SV3SemK1gsBra60qA09OVuy
	 YW3/PnKgY44uLihbRSQJgs4SfCSheZsS8+tKNwkmg5upxPYUfLse4I+zFaiXprwyR1
	 hG/JrgwXdc+qx08A2/99bJ4zmxzPrEJYiV88NpeQgYQfnjp2jK+MwW0y4GLhoY/AeX
	 UkJM+xhdyQWNZ4vEJ6npoLfSUofk1VtWYSvD/ACoCKluciL8Hq3CN0kgo/PRUIMou1
	 Xnk2Mr7bnQ12fy0oZLmL28LyH2HZqKUbqq1iKohMDciszvwTq8JxOGgh2wll/QRTPP
	 qJBDqVInl/+Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27845406EE;
	Wed,  5 Aug 2026 11:55:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 77FCF28C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 11:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 699D74004D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 11:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tKL0oiKB9gl6 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 11:55:16 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 01B1940061
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01B1940061
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01B1940061
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 11:55:15 +0000 (UTC)
X-CSE-ConnectionGUID: M4mLLbMVTUKhA3OPX1UcPg==
X-CSE-MsgGUID: eTdUKRH4QqGyqNZ/upaFOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85627523"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="85627523"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 04:55:15 -0700
X-CSE-ConnectionGUID: VWsnSlx9T5O8H6uAwnJ4sg==
X-CSE-MsgGUID: XwjmrlewQ3Ktv91c+z+H1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="263781738"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 04:55:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 04:55:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 04:55:14 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 04:55:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtiORI/Da7Bu8WibCTr1NMn9gVeB4HwQ+0yImNwnbfBZStsTV2WIoSs26U4kCnp8C6vbjL+Hzq0l5qh07fgJA7IADhsdOm9HsNtbz+D/vixQZkTWBo3dO7hYTezm1mYHmsY6xfPOxUtSzAReqEdppUQhzNBlLKMfjIqIyLZkUu1/NkGKH/4S/nvAJnl9a5lEUXcZ1MHhymhkB4WbBVL6uibTau3tG6ZBTX49mMoMFgspMKm/dFWr1gt990b+PZGhAaR7D8x1k+bv1JeXWsnSWh2u0KO64Jz+CtN3qs/Aj5f3xBHivLIlNUsput/oczaGw5WMQ1rfRGLrie6qTYV+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m/OfZdr6yVYWqiU+XH5UjeTisPAom66N+fmTuETQyk=;
 b=J01B8lkKZ0hAszqh/hn1o5ZKS5TOPAKyUW7yl/AEYpnCkFqZ571O0VQeXaB3cUrk6xR3LLZdBDLhN81GbT+CbiCzSoRvYcmizzEI3YrRieUn8FwGB/9Xn/fzBF8Qq9A0SQsTbzc2kk4o4jqI7MW+tIs0+85OXyIdMn+6uSqPNVC2f2p/SW788hs9rrtqMzDZrjShDdyKnq+Vz7/A6lXRpGjW2llABQ/Zph65UBLUFT4A29RAsytgarln09e02CnnSgROFwxwV7LnNGzKRoKFdrCY4WKRpnusO7nB/TU15Z1WLikk/6sCxDphLaPkEvlSEoBeGom7JU2XARmOqrdO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by SJ2PR11MB7576.namprd11.prod.outlook.com (2603:10b6:a03:4c9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 11:55:10 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 11:55:10 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, "Korba,
 Przemyslaw" <przemyslaw.korba@intel.com>
Thread-Topic: [PATCH v3 iwl-next 2/3] ice: add TSPLL DPLL device and TIME_REF
 pin for E825
Thread-Index: AQHdIz0NXFJHPAaGjEyGyE4DH47+2raPWvqA
Date: Wed, 5 Aug 2026 11:55:09 +0000
Message-ID: <IA1PR11MB62194C4A39D665CF462AAFD992D32@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260803113507.1858083-1-grzegorz.nitka@intel.com>
 <20260803113507.1858083-3-grzegorz.nitka@intel.com>
In-Reply-To: <20260803113507.1858083-3-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|SJ2PR11MB7576:EE_
x-ms-office365-filtering-correlation-id: 5f4e5bfd-028b-49a4-5e1c-08def2e86681
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|10067099003|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: fbPty1GNRyrUWORGn+kRoFxxU4hvlPZcvy9vdiTT3BTdMZgoAmR7/gcYQut6Y7wUfDEd+jvAd0pboFTBS/lFdw8enfxFNEDxA0A5xLcQIiWzFYk7VFriPNuc+/GVRANSDBqwW9asRmNSvPyyUS+cqixkZmQWG0BQEfmd+vosCMbhw5aq3TPzTjCk08tEbg3evdpy1vHVenIrHAB1jk3gAurtrOzDSRnGlJshIoXeXtZ9Xb5LTH+fWtwbE7XsEpL1D6qhG+ecv5ECrwsg2msHsCXaZxPIjBR3bPBH+ndP9WFaIoWfCcah37T9q+kJD1u2smBF3JkaRkFaDOudUSe/5Q3prxS7nnB0M+pr2BBpQFSafdB5YBBBBu1dleLFWxc7wFn2y24VfWO9HddqbQBHHkQ+ziAQ/4m330ihDzMgP21DPK+Xhfjj2bg3MXxW3NWaE4stVLA0lm0EBlE5hhpf4k/Hn0CpYFviRmomYeugvcmMAvlmUQiNLE88lqmvbZnhv3NeFQX1e6dAg2+ID8i2Ki9/zrhR1Q2fYMEuU8HAadPiQ5b9EKy7K9mFJwFxxd89CNgHzIHvpMk536EMp/zQ+xrO27uTiihAgcYwYVnWn8zmLxHZ2XEIOmEFJCNYHKvhGjwz8YarRywHnwep6UM5QqomZG6Z2kXW4UkU9m3S05Ezv1ZRdm4yPJ+j8yMdQHGRDM/u3AAALL9eINvshlRaJvJmM94lUnz6USxtbOnWnPs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6219.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+iYvEDGiq7rO67CxfUCYvMIp72uqu8y5N47g7Xdy56e/lAMI4u/pKwtoQ4M6?=
 =?us-ascii?Q?n5Ior3eTDZAvBZ1hP50QYi4ScNSNZGoZHLFh0VwAiAGSCP+vrQ30Q74W75ek?=
 =?us-ascii?Q?0ZanjVxiE7Qdd/snvzytfYSmQ/0pug7k85Tft+lL+IP9zdU/W1PULPbvEyoo?=
 =?us-ascii?Q?YDyYutPmmXwdiF8PGhDjzemTFpZYGMfb1tnlGoY3PZUIdnn3yBXHUvo5+KJ+?=
 =?us-ascii?Q?xsK/nTcKEAxM5YtsAbD+EEUXLHKk7tFJlX1JhdEk9fi4QyVpQCShcbnr82ox?=
 =?us-ascii?Q?KJTqFQJ3JXO1BqaRQL4ksLddVOg26ddWeXEEgd6kfrnCiMJEQeSWPSNuCrgO?=
 =?us-ascii?Q?DU5k2cMvCZ4wQJRBCTpIdrg5WnBWR5AInKOrOI3BFLwpcgl/DwoQ0G6OD+Jd?=
 =?us-ascii?Q?CJFNUsm/SXs+0pdhpl083p0aefm+3+FpJNLnnBHXyaasktq3yRqcl6xYcHrG?=
 =?us-ascii?Q?3A9B3pLwt+bA2DwiLsHUt2jmo5wpecqtwrERsjMPBO6iajBHKOPa+F/qmusQ?=
 =?us-ascii?Q?d4jd7SVhZciguIGVk+J4/HpQA5weRAM654jhxrjSdOod3w5tDUhGR+a3kLuY?=
 =?us-ascii?Q?Og2LoL411DaB/gJOtlOSGCiTfHpEvQ9hcd36klSSaZRPJ2+ginb34ssTcBED?=
 =?us-ascii?Q?nJ4qzX9L7d70ST/D6zTb391vepc0Ai0rnym/xO04ybvUPhWOmcolq/vXroOj?=
 =?us-ascii?Q?3qmOdQrFriXKFB3pgVPBm7g1u9iSIuKjUz6/tlZ21lezQTaDNj/gnVIkGgks?=
 =?us-ascii?Q?awyNQdya3dFi2pzEECmvZSu/Oxt5SFeKeXAqMjPBixTI/0/ZjOl7vfPFU5ai?=
 =?us-ascii?Q?ugAC26kG4KhHwyi8/Xo/kAVvqkGT9sLtlMpUiYyfcIddD2dndE8ORbeUFqGq?=
 =?us-ascii?Q?Ddpp2rRGoMDYDWQOSrPtler3pt7bSv/LuwIE4gtcZNOfGWRMnJ+OGDc7xMHj?=
 =?us-ascii?Q?LUnxcx2JhDNKzgn5gi/wt3Mg8xwZRt4Qs1bqEzi+0oaKbuJjCcCrJRklBfQ/?=
 =?us-ascii?Q?jPtWb4cGkELpnn9VhF0K65NCrjtOcew+fUdd6GAuMuhbhbi32cBB0TwszYF6?=
 =?us-ascii?Q?GWKfdR/iVyi0ZLEV0un3A85qoik54nevWMhxSlMl5bEHyb6pyJyJ4aWD3pTg?=
 =?us-ascii?Q?MWV4Aib4QZmXVqryS7LzJjYrcICHkFCt7geS7I/Dy7DxvWveNDFg/ppnrixB?=
 =?us-ascii?Q?LQgQ78jHrPKP40E5jOEdxZmX2l6ZXWs8qLFDlVDLgBK7bH2I0skVoZ98ykex?=
 =?us-ascii?Q?NrK654z5erzF+hcQRiNsRdg3fHWliyHUzlSPLn8i7UmuaoiFZ7W2eD+Bf+xI?=
 =?us-ascii?Q?Mnldy9i+JybsOTEh5mwTN24Lf/MXzrgletxvm5jA7ovd5pptqkVSOa22QHyP?=
 =?us-ascii?Q?eSG/1xNRgT+59SCOkGzAanZA99WUxLUbyBZFm4yFM3r5UAyzyhz0kRGKNBBC?=
 =?us-ascii?Q?VkLDT2cHKxlVAW4RjrawC2wipbNYFV3HfjDZW8k4sa0dLkc/6ucn4V2P037t?=
 =?us-ascii?Q?s7+Z7FmgYEY2BUu14c0lqaS9GjOsYhh1/zFzVHke/IUcw9eqCwyqm5THRnMo?=
 =?us-ascii?Q?1cVgt6ZwhxE7HuqtQQLU+AWTHqU8ycQaQrXwpPDxIhwQQ04rGKK0LwiLTAGd?=
 =?us-ascii?Q?GzKaj3Zz2wJurg/FJxnp/U/j74PdXIswRPsZA+SorniBoUSo0lLSjtQYNm4e?=
 =?us-ascii?Q?8Qqwk2RRomadGy860F0UlGWm5tr00M9ZJ3hgYS6tK1ALe8SbVChPBOHiGS4J?=
 =?us-ascii?Q?vaSCHEU6zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cOJ7tULy6q1CPNQlJ3/u6XH64bwQO5k92nGT8KWDlAQtLuWwLc/INNLtAuCeNa2FkGS+Vnild+xVyr0wCvNBEksy2wmgvHsdwhtgk0clsLVAQVJYNoW3u9Wd6YdXuEP1ngX1eiA7B8kryI4jwJni8m50+A5VsDef2dN3jBY8D4LK2Hx6b14cpuGXviE7mRUn7lGlP7DqD4NtOXGOKFkGZ38mEUkcn46r4+CZjgv4YWvIaE0I0S4TxfrXwmqkETlAMvuVVoLe4gLWT+jstdY2qUcqo65DZS1uK1/h8kc6kkcXEJOVIHHmiuB/rjfk6hEtInT2YEUoDAjLZuTlr/DluA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4e5bfd-028b-49a4-5e1c-08def2e86681
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 11:55:09.8633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPRVKX7NBaAYskVZjRYmkBdyiKHoFP4fp5yOJg8Dn1ssbjT33ejogautO+QjfvQHu8J0T7fFLMA2kqabvh2u5r8YfueJA1Ggm++2X9M33ZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7576
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785930916; x=1817466916;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ESgpslzwgBk58+U57N3usI6cuLFuYQtNiuFSzJzLNkg=;
 b=B75NqAWOG4ai3cQcpSTE2I0ovs2eOof1Lah1aC7lcB6lBg5ChMaYfxAv
 paMtvHtCW3Tp5MJCDEhkdCZGX/GGc1OkJ1V2FjDKXfctpp4BLrouYhUwi
 17lT5CIfiQG8biVqM/h9eZY6ghywclO2qmuqdLB28M0GaH91G3jv6cgUZ
 Bb/UXki9VbyRtpWa0LP9RIvZUdP1UBFRwjuNzzc1lBYHINvu1qhmOXjws
 wOH2JxJOsAb+ah8K70+ln5yeOfVYFRDZE0EBcnRIPT9GGWC5qmo5zdKpg
 IqMdReSVCMFootSbgp4U0PTbWXix2bHEjkPTwNcFgv33Zm8VtILSDInwD
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=B75NqAWO
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH v3 iwl-next 2/3] ice: add TSPLL DPLL
 device and TIME_REF pin for E825
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
> From: Nitka, Grzegorz <grzegorz.nitka@intel.com>
> Sent: Monday, August 3, 2026 1:35 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> richardcochran@gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; pabeni@redhat.com; kuba@kernel.org;
> davem@davemloft.net; edumazet@google.com; Nitka, Grzegorz
> <grzegorz.nitka@intel.com>; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>
> Subject: [PATCH v3 iwl-next 2/3] ice: add TSPLL DPLL device and TIME_REF =
pin
> for E825
>=20
> This extends the E825 advanced sync-timing support introduced by the
> tx-clk series, which added the TXC DPLL device for TX reference clock
> control. The TSPLL, the source timer PLL, is now also exposed through
> the dpll subsystem so that its lock status and clock source selection
> are visible and controllable from userspace.
>=20
> On E825 devices the TSPLL is the source timer PLL, distinct from the
> EEC and PPS DPLLs used on E810. Register it as a DPLL_TYPE_GENERIC
> device for owner PFs.
>=20
> Add struct ice_dplls::tspll_in, a fwnode-backed input pin named
> "time_ref". The state_on_dpll_get callback queries ICE_CGU_R23 via
> ice_tspll_get_clk_src() and returns CONNECTED when TIME_REF is
> selected as clock source, DISCONNECTED otherwise. The state_on_dpll_set
> callback switches the source between TIME_REF and TCXO via the new
> ice_tspll_set_cfg() helper. Registration is deferred via the dpll
> notifier path if the pin is not yet visible in the subsystem at probe
> time.
>=20
> Initialize TSPLL DPLL state from direct clock-source/lock reads so the
> first published state reflects hardware and prev_dpll_state matches.
> During periodic polling, the DPLL worker consumes
> READ_ONCE(pf->ptp.tspll_locked), maintained and recovered by the PTP
> periodic worker. When the TSPLL clock source is TCXO (TIME_REF pin not
> selected), UNLOCKED is reported unconditionally to reflect the
> free-running state of the oscillator regardless of the raw lock bit.
> To avoid stale lock-status reads after synchronous source changes, the
> set callback now refreshes tspll.dpll_state immediately and emits a DPLL
> change notification when the cached state changed.
>=20
> If a TSPLL reconfiguration is applied but the PLL has not yet
> re-acquired lock, treat the internal -EAGAIN result as success so the
> PTP periodic worker can complete recovery, while real -EBUSY failures
> from reset/SBQ paths still propagate to userspace.
>=20
> The TSPLL userspace reconfiguration path (state_on_dpll_set) and the
> PTP periodic worker (ice_ptp_tspll_monitor) both read TSPLL HW state
> and write the pf->ptp.tspll_locked cache consumed by the DPLL worker.
> Serialize both with pf->dplls.lock across their HW-read -> cache-write
> sequence; otherwise a preempted monitor could overwrite an accurate
> cache update from the DPLL callback with stale HW state. The mutex
> lifetime is lifted to PF-features scope (initialized in
> ice_init_features() before ice_ptp_init(), destroyed in
> ice_deinit_features() after ice_ptp_release()) so the PTP monitor
> can take it unconditionally regardless of DPLL init state.
>=20
> Extend ice_dpll_deinit_txclk_pins() with a "flush" parameter so the
> E825 init error path for the TSPLL fwnode pin can tear down TXCLK
> pins without flushing pf->dplls.wq. If the flush ran here, notifier
> work items queued during earlier init steps would be blocked on
> pf->dplls.dpll_init, which is only completed at the unregister_pins
> label reached after this teardown. destroy_workqueue() at that label
> drains the queued items safely. Existing full-teardown callers pass
> flush=3Dtrue and keep current behavior.
>=20
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c  | 420 ++++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_dpll.h  |   4 +
>  drivers/net/ethernet/intel/ice/ice_main.c  |   9 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c   |  12 +
>  drivers/net/ethernet/intel/ice/ice_tspll.c |  34 +-
>  drivers/net/ethernet/intel/ice/ice_tspll.h |   2 +
>  6 files changed, 426 insertions(+), 55 deletions(-)
>

[...]

> @@ -4093,8 +4371,25 @@ static int ice_dpll_init_pins_e825(struct ice_pf
> *pf)
>  		goto unregister_pins;
>=20
>  	ret =3D ice_dpll_init_txclk_pins(pf, 0);
> -	if (ret)
> +	if (ret) {
>  		ice_dpll_deinit_rclk_pin(pf);
> +		goto unregister_pins;
> +	}
> +
> +	if (ice_pf_src_tmr_owned(pf) &&
> +	    test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags)) {
> +		ret =3D ice_dpll_init_tspll_pins(pf);
> +		if (ret) {
> +			/*
> +			 * Avoid flushing pf->dplls.wq here: notifier work
> +			 * items block on pf->dplls.dpll_init which is
> +			 * completed by the unregister_pins path below.
> +			 * destroy_workqueue() there drains queued items.
> +			 */
> +			ice_dpll_deinit_txclk_pins(pf, false);
> +			ice_dpll_deinit_rclk_pin(pf);
> +		}
> +	}
>=20
>  unregister_pins:
>  	if (ret) {
> @@ -4288,6 +4583,7 @@ static void ice_dpll_deinit_worker(struct ice_pf *p=
f)
>=20
>  	kthread_cancel_delayed_work_sync(&d->work);
>  	kthread_destroy_worker(d->kworker);
> +	d->kworker =3D NULL;
>  }
>=20
Sashiko says:
>  	ret =3D ice_dpll_init_txclk_pins(pf, 0);
> -	if (ret)
> +	if (ret) {
>  		ice_dpll_deinit_rclk_pin(pf);
> +		goto unregister_pins;
> +	}
> +
> +	if (ice_pf_src_tmr_owned(pf) &&
> +	    test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags)) {
> +		ret =3D ice_dpll_init_tspll_pins(pf);
> +		if (ret) {
> +			/*
> +			 * Avoid flushing pf->dplls.wq here: notifier work
> +			 * items block on pf->dplls.dpll_init which is
> +			 * completed by the unregister_pins path below.
> +			 * destroy_workqueue() there drains queued items.
> +			 */
> +			ice_dpll_deinit_txclk_pins(pf, false);
> +			ice_dpll_deinit_rclk_pin(pf);
> +		}
> +	}
> =20
>  unregister_pins:
>  	if (ret) {
This isn't a bug introduced by this patch, but there is a pre-existing
issue in the error handling path of ice_dpll_init_pins_e825() that can lead
to a double-free, use-after-free, and NULL pointer dereference.
If ice_dpll_init_fwnode_pins() fails during pin initialization, it destroys
the workqueue and returns an error without clearing the pointer:
ice_dpll_init_fwnode_pins() {
    ...
    destroy_workqueue(pf->dplls.wq);
    return ret;
}
The caller ice_dpll_init_pins_e825() catches this error and unconditionally
executes its unregister_pins teardown block:
ice_dpll_init_pins_e825() {
    ...
unregister_pins:
    if (ret) {
        for (int i =3D 0; i < pf->dplls.rclk.num_parents; i++)
            ice_dpll_deinit_fwnode_pin(&pf->dplls.inputs[i]);
        destroy_workqueue(pf->dplls.wq);
    }
    ...
}
This block iterates over all pins calling ice_dpll_deinit_fwnode_pin(),
which in turn calls flush_workqueue() with the pin structure:
ice_dpll_stop_fwnode_pin_activity() {
    ...
    if (flush)
        flush_workqueue(pin->pf->dplls.wq);
}
For pins that were never initialized, pin->pf is NULL, which causes a
NULL pointer dereference. Even if pin->pf is valid, it flushes an
already-destroyed workqueue causing a use-after-free. Finally,
destroy_workqueue() is called a second time on the same pointer.
Could the workqueue pointer be safely set to NULL after it is initially
destroyed, and checked before flushing or destroying it again in this
error path?

I believe his is a repeated concern from the previous iteration. It was mar=
ked as
false-positive from my side then.
I don't think this path is reachable. ice_dpll_init_pins_e825() starts
with:

    ret =3D ice_dpll_init_fwnode_pins(pf, pf->dplls.inputs, 0);
    if (ret)
        return ret;

That is a plain return, not a "goto unregister_pins". The label is only
reached from the three later failures (rclk, txclk, tspll), and all of
them imply ice_dpll_init_fwnode_pins() already returned 0 - so the
workqueue is alive and every pin in [0, rclk.num_parents) has ->pf set
and its notifier registered. So there is no second destroy_workqueue()
and no flush of a destroyed workqueue.

The internal error path of ice_dpll_init_fwnode_pins() is also
self-contained:

    for (i =3D 0; i < pf->dplls.rclk.num_parents; i++) {
        pins[start_idx + i].pf =3D pf;
        ...
        ret =3D ice_dpll_init_fwnode_pin(&pins[start_idx + i], pin_name);
        if (ret)
            goto error;
    }
    return 0;
error:
    complete_all(&pf->dplls.dpll_init);
    while (i--)
        ice_dpll_deinit_fwnode_pin(&pins[start_idx + i]);
    destroy_workqueue(pf->dplls.wq);

"while (i--)" only walks the pins that were successfully initialised,
and ->pf is assigned before each init attempt, so pin->pf is never NULL
in the flush. All flush_workqueue() calls happen before
destroy_workqueue().

Happy to NULL pf->dplls.wq after destroy as hardening if you'd prefer
it, but it isn't needed for correctness here and this patch doesn't
change that path.

[...]
> --
> 2.39.3

