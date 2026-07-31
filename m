Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38620C54F54
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 13:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F052E81316;
	Fri, 31 Jul 2026 13:38:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LTpWLZH0Xu2k; Fri, 31 Jul 2026 13:38:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 390D2812F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785505114;
	bh=/gs+31pn6Ir+fL56XGFAGyP7E/zqbxcw6HLxRAtenpk=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7U6Z6MJJDKnQjYbLotPL4yA+cEd3VUYaMxVzpDbxbK6TlAvdQoazH+wIj/GBTF/Th
	 ZBv1MRzOQe/9p5Jl9sszoISNJM4XsNToYZHAIq54rt8xiV/rXtNUBXeeOBHQRA1T9X
	 TAfniz7vA5ThM2+79oWbVG+KHDyHGhj0wqU6nmEyc7baFbzcsWuCLtuX4mJfyCXoha
	 LSPtxyyJIQWLc/6yTwdFFE+fyLNev82TEe3Pz80q0WdzjILjvLrUGyVnATWJ/XG7XI
	 hLRIsHZFRLCNBon/7e+3nj79aIO6mCWiiFig/sUVmokPPeEHVl3/n96+8MP1E21dqx
	 NXKXHlh+pk4CA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 390D2812F4;
	Fri, 31 Jul 2026 13:38:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F6182E9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 13:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 356B1812F4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 13:38:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W1bYulvrv76g for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 13:38:32 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0CDC18127A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CDC18127A
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0CDC18127A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 13:38:31 +0000 (UTC)
X-CSE-ConnectionGUID: mNFizKz+QPmzZZdm/dC29A==
X-CSE-MsgGUID: FyBY0rXGSFyVRX3ooY7jbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="86248285"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="86248285"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 06:38:24 -0700
X-CSE-ConnectionGUID: Ir/OO6j4SYqK0fcbbc3NsQ==
X-CSE-MsgGUID: A5HD/h5vSzS721qKOhe0CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="258795135"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 06:38:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 06:38:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 06:38:23 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 06:38:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7hkLLZZVTmBWfZl88e7oJyf6nNqPKI0KksXFhD3K8BCTW399+vtyW18eVCeHL3J8LriEXbLwD1+H9sw4a3CC3dXnAv4fBPQPX+No8N9tn4aEK7XyfDYkuwofmhgqyi/clYUbtW3jAanGk7vyImXee2kzdVCaFLtvfUZLqv5UYyi/GW86Hhxk584xx6ykjXsTmk2Bi7gNriguaWs0uFHWGzkwjqgvLikyY2QVrt8iRWfznNCCZsWPwbvIhJJj/SszuHUWAnKvoM/x2eS/OkbaB/D3UZJBvxTIvRgIL/HaPRDgXSqvMcYUN5DNdlnf1iipmELIM67d4BEJo8y7X2yYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gs+31pn6Ir+fL56XGFAGyP7E/zqbxcw6HLxRAtenpk=;
 b=lD9NWuNVel5pGPFnW7ofVzdyj6qijOgUdoIa/jFeB18SrYO4U3dvlY41gRRJYiV1wWLFK9hzfHnJUwOHUJ2yD/WoKwMj6n+8nm7mRnL8xExVyNY3TYZdDitzVCuCtrGESc9APgYc6pOmBNo2Bb0ZgJF46O2yLEx4uN49QgLeuTnuyaC0Gi4lwRUQQ3eH66qbAcTM3wJDc65+4VpNUhQkIGppALEXiMByV1cFFFji8k0g1q/F2oW7rQ3VrTUcrH1MF0IfaWnHHVszDBzdJG6ky982xvkcKwC8EZ7w3XkR3Tchjdu7bp5x34rT2GTxDOAgB8u3pL4MdW+LeMph8Ix/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LVUPR11MB9859.namprd11.prod.outlook.com (2603:10b6:408:38b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 13:38:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 13:38:21 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Matt Vollrath <tactii@gmail.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 2/3] iavf: use
 __libeth_rx_sync_for_cpu
Thread-Index: AQHdIOsbXzxZDOnXWkW11ts33JMGdraHocsQ
Date: Fri, 31 Jul 2026 13:38:21 +0000
Message-ID: <IA3PR11MB89869FEBF6A5207E65199B47E5C82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260731124109.99065-1-tactii@gmail.com>
 <20260731124109.99065-3-tactii@gmail.com>
In-Reply-To: <20260731124109.99065-3-tactii@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LVUPR11MB9859:EE_
x-ms-office365-filtering-correlation-id: 137720d7-feea-48f2-5745-08deef08fca9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: G5rvq+dmluK+lc28789M3cOLLELNRMXGNN53Nbsgh4bZP9cATCbfdQ6rz4MST24tCBouRt/Kr2rtz76w39VWK/5hmY+FBITuD4SuQoxCJbMksQFCr47XBRje4I3soGszrfGpW/LK2ebGvnyiLXBZSZP3VzID6B+rbNZrFjzaSuSp+RPWc9hCILYQNArt4/+4RilY99KrGjiM8UbMvR0khe5N51htSTmLFWodunzFSKD6r4ZUgEZGrO0tvW17OUnVwYrx1sieDmkAKmz9Xy0dP/PnOxqivzqHJlDmTgDLQb5jnXwXjRhoPVIqXP2BX61PTdJISf5Gz0BIZUS7xTXRcVrJWyRHnbs4LOvCEMJwYdFKuk7rUzHBoixD9SSc8OdpNmn3npHaWrFP0z7Mm2Kkos+yObjr9SOJ+4qHtfTgsi2zAl68xFvdoZEuaAvRr7H/Vq2dWVhqO1agvLOsq9Xo7KIL6nML3Gpp347iX1pxr34/+wN1ipVvys4KBRotQyXn5HAU/Q26Bmo3Km+UO7CvJy2T2byvkmm9GXtxlF7Yqdb3aF3CWsdZQ0YFRvDYvJj1oS/9uIwFH3rEyvzgRlVLg3A0wQc7k3h9JsgqCzTbG657w09BTzH98noxrQ2TUhoIVQytD9hdDVDQ2BgXlfECGDwcf94wjN2kJkWFtUceaM8fEtwckX4hVdGmF0WlSxXe3Ooa9XuQ7sGrRH8f85EJxLj0Pv7MOhl0OoFCjJUiVdI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G5Rd3EYEybD3JZ5mtLFfNWFgG2rexBPALBK7PmUXixgfZ3mSIbC7VF/PP1z7?=
 =?us-ascii?Q?aRfDuXZbPDO2J2gIJ+oHEV6A9Yh/3xpq8Hao5ULWRk3kNG12fNOBnjnklCko?=
 =?us-ascii?Q?ZJY4OuIRQTsNlu+QXDKoBbs9zXj7LemDkXN0su9QZj0sMJ/6EV44rwUke1Uu?=
 =?us-ascii?Q?IGo+H1e/S9gksUg9Is+6LQDQWrHWnv+exKuYXPAHRcMF01cdRsdPK85WgfnB?=
 =?us-ascii?Q?xroh8QR08+T63OycREdVswKmSWUktIvhRNGNkTg9MU1kRtp6U73NLkVpEWyS?=
 =?us-ascii?Q?K8BFKltjNK09kigRLC/amM5kNGho/38hOIyT6iUoY1IacgYEJdEQe5XTwmyp?=
 =?us-ascii?Q?9WZy8Uf+ECWsAYL7ZWKQDLgWUGH8rWQdpKmCw8FbjEEREglIRpl+xCV1++Fo?=
 =?us-ascii?Q?Y+jZrKC1zwcBOhU3GRDOreij27oYnlAFhWx701y6HyFOnbybhrMge4kmx4dA?=
 =?us-ascii?Q?/Nwz5KNBf07WJoZHWSp/gCeOOEPnvKJd1QAHlJ0QdfvvaH6t0x9OpEmmTuf0?=
 =?us-ascii?Q?5AWvirVOOPO5Btd839YNKhNzLVsfAr60ZwbxOMCXZ789Dz+JOUZyEjhqmYaY?=
 =?us-ascii?Q?y3ZbY6Ggtpi05JB48Lb0DANkWiflJNQA9CLQm35OX0qwBTiLWF3Zxu+6obTU?=
 =?us-ascii?Q?21OP2kA3OlzZNG69NdVGu3fIAXSXgLiViLLg/vo4pCcryb+Q3+i3Cc8DNFSG?=
 =?us-ascii?Q?4A0NBSpgJuTdbCNI1On76LS4LqllqpfAz9ZGvSPV9+9qL/NE/IlDEyYct6uH?=
 =?us-ascii?Q?yJbGWetNGdewk1oCD7KPTBMREXjrhVjLmKkxE7XYFZKu1ycWbEcqjpi5SZwY?=
 =?us-ascii?Q?duxgQCWEV/gmrxWc3nxV9rqymGSP1yEFPkLGuFmIMUQq9oDDSdpmBd37b7OL?=
 =?us-ascii?Q?KQh7XcvgE2l87641Eyw3Yt1cwTbT/5PNJ363OUDbQEtkFaTjyrKg0NHi+BZc?=
 =?us-ascii?Q?1EoTdkZK5Kz0D+CbD2bYcAvyko9NmacZE/YRvI1V/ObG6ueY/YxeyCmRid0Q?=
 =?us-ascii?Q?bWc+MK0saWGsLqqqeG+wh2hC+iLudgZfJcPTlPx5AneAn09cNR8F0pGZIL2e?=
 =?us-ascii?Q?9H99TVuLFetl2EsMWWe5QCK5eRsGvcv4NA7vAoR1OJ6mpJp9U7zD5da4EPZx?=
 =?us-ascii?Q?OOO0wzmL9Dl6UPD7nk60vp8e8KXIxw5Pu+jiwrdKKCqPM7DRMC4GftwhfNS0?=
 =?us-ascii?Q?4A3kN9Pr7KTqs0xrmu39b6PNSgFXSbIeDpBWFRRLZc9zWqDeoMsBV9lEXCxK?=
 =?us-ascii?Q?inlEnOYuZWBLmbTCLu9bt5R2aZKuDJBEgswLdV9AOoMF+3HK06ibzTeZvQ7e?=
 =?us-ascii?Q?ShOm2lSRBouu8jZJR9hOhq/vOs3PW3EDnctguE/+oAWdHSaatmR8jyxs1Ku9?=
 =?us-ascii?Q?xh6gEOywMn9pBfAXcnUF/LbevvbxRLn67m5IO4d6GTS7O5rP/t9rxnnPofuG?=
 =?us-ascii?Q?cS9l9PP/3lrGwg6cEulfjRv873v6I6f1vLI0ie2PB6ZvcKgowmVghy1J1xBa?=
 =?us-ascii?Q?0GXIHYNFCjMPtw0q6UUi5VUaGmcq+epnYQ4UuOvk66zvCj2PoUpGmMrKlEkp?=
 =?us-ascii?Q?xSdn1oJMV06veiYgg2FXxLyukBYrx2TCxvm5iSWTgYXCjJTXGTdskGb8vhHw?=
 =?us-ascii?Q?36tAevDtMtz9taJVEgljoX72KC2kjteNCEBYDGwt61icOUf+MCDT/mfHSOqG?=
 =?us-ascii?Q?Pl6iy0gL8aF/ytXjJzCbOtDc4+bjhtaJMAwBJVJSURrhg50wyzvOuLc4isXS?=
 =?us-ascii?Q?7d82dUHpkg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Di0TUoOMrpvtBurntxckfOVkxe9pihrOoMFC2v/7Fm8uZZ/KxUFnal32XQ80qm19qO5FxYdIvCHfnOlbFDy/hGk407Rhbfsol5WiuzsI07FujhkegKoD8aeJpDZ0bNZQw76wZO2JfRs1PzPLAghnds1vdSXQwx2wDDOXL2QzJ3yD8vvQvxTxH+xS0EG++MokanfguntXEuaYCx4EDvHRgvomlogwMmPKWfQJjsGpeE7xFTnW03mcDjqkEXdui8ZDxfRGbwuzQiPWoOix0iLKK1JqDw6i0uwietJsxkvNEW5wT3FvtvjjM1OT6b80mWDFWV5tu9Mwei5LC45i5MY8Ig==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137720d7-feea-48f2-5745-08deef08fca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 13:38:21.0607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AhP6Cwjm4f1NOJpWyIJyOGJot9vSD9RhIeLl6mtCqp9kLUMisTCCFiR/1/gtkMk5csbgcRylNc3uZPcD2VqfZSPGcMXSyE83yScUE71p8AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9859
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785505112; x=1817041112;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UI53F0AMVIpuUwZgNiL21lms2hNxeWY7c4r+PzG+fpI=;
 b=NM7dljlxGs+0lYmuTcpnPDuzR73XOO59Tom8TLWtUP2Ff/Mcqm4FsOF6
 aqFy2+j1Jw3ZnEZlt+mfgxuVMasm2yx0PM6x0s0levawi1/hG9vkdXuC1
 dvdTvPOhN/dCXlF4DrMX0QQFEXgWPrp860pePYuAjg26Z/Qmvs4GMVh7q
 nXaw2EvC/s0A64ZB1ocx6T+qzABYBF4S7krKCo7TBdcSg1qxDx8rtkLja
 vEFyER1f5Hg2/H9LY4Yi2I//XyOQ0Uwqe57pJ5jhpCanaBhLu21pZ4k3U
 CG7K+jwOAy12u8ohgqlzMt9HxTPMJhtMoDScMpjZQJ0qdFL6+AqRUMXyc
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NM7dljlx
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/3] iavf: use
 __libeth_rx_sync_for_cpu
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Matt Vollrath
> Sent: Friday, July 31, 2026 2:41 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Matt Vollrath
> <tactii@gmail.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 2/3] iavf: use
> __libeth_rx_sync_for_cpu
>=20
> The Rx ring already has a reference to its page pool adjacent to
> fields touched every iteration. Avoid loading the netmem_desc for sync
> by taking the shortcut.
>=20
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Assisted-by: Claude:claude-5-fable
> ---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> index c30abf17cf5d..3ae2f0a0ee4d 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> @@ -1387,6 +1387,7 @@ static int iavf_clean_rx_irq(struct iavf_ring
> *rx_ring, int budget)  {
>  	bool flex =3D rx_ring->rxdid =3D=3D VIRTCHNL_RXDID_2_FLEX_SQ_NIC;
>  	unsigned int total_rx_bytes =3D 0, total_rx_packets =3D 0;
> +	const struct page_pool *pp =3D rx_ring->pp;
>  	struct sk_buff *skb =3D rx_ring->skb;
>  	u16 cleaned_count =3D IAVF_DESC_UNUSED(rx_ring);
>  	bool failure =3D false;
> @@ -1424,7 +1425,7 @@ static int iavf_clean_rx_irq(struct iavf_ring
> *rx_ring, int budget)
>  		iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
>=20
>  		rx_buffer =3D &rx_ring->rx_fqes[rx_ring->next_to_clean];
> -		if (!libeth_rx_sync_for_cpu(rx_buffer, fields.len))
> +		if (!__libeth_rx_sync_for_cpu(pp, rx_buffer,
> fields.len))
>  			goto skip_data;
>=20
>  		/* retrieve a buffer from the ring */
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


