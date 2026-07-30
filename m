Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B7CC54FD2
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 08:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDA2580C41;
	Thu, 30 Jul 2026 08:42:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qd8rjN0uuBtI; Thu, 30 Jul 2026 08:42:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A430180D06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785400935;
	bh=tcwoBe4dkOQkbQKeiUkRGmATcOqYUpFQcgqsQWiuwnw=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4l8FXWnCAZ3Rj9IUMUVc+xtPJM3l810VJu1fd+HpoCFq/U/2bGl94R342F9OcdV8O
	 JM64N73TXAwSnEHriVygDdC29yvhVC4XFmKh0u+gV2pQr6phxlmGaeuwPqwWV+XuuS
	 pRSVoW18P0CZ5vuWPtmI2IdM2piVaAA8krwskeiQU1t4qOG3f4a85laMo9aXVhG/tZ
	 HFcchZ359tpbKDX4OXD8v3bB9zOR+P7yM4+17zsHYHxcr+AN40p0Ad7vhyLpLeBsGY
	 coJxZ0uFShkzaMl70elKZhAWYFZoSDqvZSAuM/pzzGQTpl0ACoIUdr8gY8Fytte8HX
	 D1LqO3aP4eFtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A430180D06;
	Thu, 30 Jul 2026 08:42:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 20CEF352
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 08:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0690A607B2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 08:42:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pk_e80qdLff0 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 08:42:12 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C5E7C607AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5E7C607AE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5E7C607AE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 08:42:12 +0000 (UTC)
X-CSE-ConnectionGUID: GJcYnRhgRE+8qEPa6DZayw==
X-CSE-MsgGUID: dShAev7rT7Wpe51oEykN/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="111561606"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="111561606"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 01:42:11 -0700
X-CSE-ConnectionGUID: yIvWMJnmSpWnyYt16iCyhg==
X-CSE-MsgGUID: OwkONxLRQsCg3CKaePFWkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="298454020"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 01:42:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 01:42:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 01:42:11 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 01:42:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbBatq7YFXNhca4EyYZXKPSpSGW1D329CcLLo0FTJLZrUTmKN1e32IEQ+4Iz8VtvqRUos7WlWX0F4xRCe9E0atFfGMoQ5a2gPrz6pziMczv5KrJsQ9YJ+I9G2150H7PLoQ2FXzpxLeYCkI66L35YguZd2g7SL0NNu9XKp9BWOLrZy9oSATN+sAFhh9HqQqSgWLqca+1Rn00HG2h3HG31L2q/kp6hiSW7V0P0b3Z6hVIUYtnhO16SVii1nQVIPxS2H6VlJiGzdBPTm3RZYexEO8qp4RXtZ7RahTDlf3WQn74vsmlrjWflnJbnJDh6SHhs//weRmgjU4YKrb8aSVyC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcwoBe4dkOQkbQKeiUkRGmATcOqYUpFQcgqsQWiuwnw=;
 b=ZJrMVmMPL3VcDVsT+jKPESjfbPdtCaEMW8jvoAWQptwZaJkdZR6BlaV3T2TDPKEtjkmEGQhsezxwiEBJycXr1sd86m0TjwSW45cxpcs4WLhVKIPHqwVryStPelim6uQ7rA4gYQv5MKoMSdMSYvCpAu/k+qKEZ0LuqUc2y7mwgzqKpCQPzHo57Y2pCZMKbWYj1a0MX/JqcfrLhTblNP+FIJU/HsDSNjAZKZhQfpOf4frRBOWFw2saAoGbQCsYciihChf4TuwatmJLz6566jRANogbpsiua1TwgxfXujK5TBlW9TN3Smt7OLpf/peh6OL7UVSRx45Q7nWBPmhwACjA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 08:42:03 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%4]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 08:42:02 +0000
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
Thread-Topic: [PATCH iwl-next 2/3] ice: add TSPLL DPLL device and TIME_REF pin
 for E825
Thread-Index: AQHdHnIajsbP1EXs9UyMAE0zX2MXUbaFv9Cg
Date: Thu, 30 Jul 2026 08:42:02 +0000
Message-ID: <IA1PR11MB6219EBB889AA9876B20BC6B892C92@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260728091314.1420656-1-grzegorz.nitka@intel.com>
 <20260728091314.1420656-3-grzegorz.nitka@intel.com>
In-Reply-To: <20260728091314.1420656-3-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|CY8PR11MB7686:EE_
x-ms-office365-filtering-correlation-id: ffaa2297-6db0-4996-6abc-08deee166d4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: XpGWs0OUSlAt7yw/y4mZvDaJ0cpB3ajHkoo3sYbwOpXW98rQ4Ccith1glGT+yIcXe/AmOBoPzTqPnPNgMfiIukjPwmv3oknCzQIKzBXNC8oPH9a0Ou1vGC0bj3jHrE1U8ba7s3w/So6Vl+S0OATqHe7nSRAjcIz4J97deOdZwFl3LvF3mdBbgTvjiP2yt5aN11rDAU3yZ0o52hAZdbQ1nZXUkL8yXEKcuVjH/MhSLZFNUHCZNXAi/6Ajxp2SyywUv7Ucb8eoNlBhXaPCw+b3bqNFiixT+i+wvjIW7tzfsRDisIJXpB5iPhFU9uT9go6CNOp2eEAuZzYiecRxNnIfAtqaAhFjGVKZ0zqx8VosSg9e0AOCpIacnxL5Thcymkbts5nXmWV6OQpb5ShD4UiFNix9CdCuOIvhAVeN+UwX1Hhh3zwgvYcbJU6jypgeimYiaGh+snlW/ysam8GC4jjQGqbOragXbXFTmOFnVQ5AX1/FNrBPikVqUujsK64tC8qXgg6DTGP2USneMyM7v/CVSRR8iqcDnecb6gy5QayRF/SYXPusOdOmthi1C8ojKGRQxxpLnr5hXF2o/4A21mWL+ND12WdrmfKEImP6ASwjTGDAPe9qry0WODwVKwe0E7Mmyq67Bg/Phk/qqBLrysU2xt0GVGtHy7RwZmBydEHY400=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6219.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Wy+qg7u9AbcP/hF6+E3oDjUIbhNCC353cKWMwXQhzxD0nhSXV5XJhODPXqo?=
 =?us-ascii?Q?jbFoFNkZKcNjRj4fLMX3hKMJ7WSL29gvBl5lWBBFMk5S1Mfnw914zK1o4h5e?=
 =?us-ascii?Q?CxCMVFxk2XhPm9QWBBxdW3Q/bSYL6U6zYqXn+I7QEnZYAVcZYlKu0UlQKclo?=
 =?us-ascii?Q?mbDj++oHr62/2KQ1tin7PCI8TPrWqHjEODG9jqoaJHekDgZ7gCSRe3n825vX?=
 =?us-ascii?Q?EwklvirtfCjaoODnP+ajLRx5NxuH/kiCmX8GNoFCBkPyKF5kkl7S8Bg3JqS0?=
 =?us-ascii?Q?6lYuYPrf5Ra59fY7sip2ER2wZ/lZtBgmHxV+uLdQ3HQA/KH2bwYn6SSsLwFj?=
 =?us-ascii?Q?wUc7mqn1y+GMHr/zyqnH0WEpUpnMDNl/0ByE9tGEm4DXQAXgqOVqSMVO5emE?=
 =?us-ascii?Q?YzfKV/5JGlbKYRN+mXKXKoBVHxt2C7oWoZ8cuMOXY6ZSBkFfA23dz6RSK/XG?=
 =?us-ascii?Q?Bcm4VZ35rD0p4ovqoOi006ZxLPMGigrBej5j0dLan83GmHzFt95uQ5PnfnWB?=
 =?us-ascii?Q?Se2H0BrNJKniSC0CaT7Y+gtG+jYsRxVIpGs4uPbvGqXiy4yZ9OR1LMPgfpnn?=
 =?us-ascii?Q?DVMPZ8H4gTSlk0quvbaSYJoSDcl1lRqFzkPZX2gZdtxTO8l2H+wy8E/YzEn+?=
 =?us-ascii?Q?D8dW0sdF6/EKM1qEctVkmuy3dJ43Cx640q964eRRE8FiwMf98Dlc0Uw5oRCy?=
 =?us-ascii?Q?b4H6sKa0gxuVY9HBDfhvjgC1JsdOFHT7tbvzen5NSZLkl6lZpWgBeO1rwxSA?=
 =?us-ascii?Q?BQO54EK/PtoL72WuVJKcbblXAxBzJHn5CLgpzbkCCkKcmEryzO1/9AHJwqu+?=
 =?us-ascii?Q?YQcVLn4nvdJq/kJb+GVMfoUpjYPlk2xcCEfPxpXUyt1a9zN9DX2WIXHmpKjR?=
 =?us-ascii?Q?XY1wKkeIcvHNwW0AsPw9vdYBGe8uRwWa/ChBX6UNXYwMBRx5slv/yuw72CyJ?=
 =?us-ascii?Q?y2oDooinydlZ9HLVaJGfAP/FiSWISHHWXTF5SCB/E1DsDGKnFq3c2CctYLBY?=
 =?us-ascii?Q?l17FhrhO8emdlOb6SutxBJzMJKYi4q2EfwZkWf0YJcNytk/iEK9wQxnvmle6?=
 =?us-ascii?Q?vXewZHf5KSSFzBeC74wDd6XEi6CGxMjCelFcjDeeAP17UfeP+q3GOcNLAVYu?=
 =?us-ascii?Q?hlZnIyzs61b4+XVFLSL8mKIiWwsoAwr4G22TotqgW5Dnwom3ORIPr7qTrZ+n?=
 =?us-ascii?Q?3KfhmGUgY4pIPKataFPlaVkwCbUQPPTTlK7Rypk1sv8MMz/I8khJSSQcdao8?=
 =?us-ascii?Q?c58MnnseRm6cITjnHfT7rLAW9SZPxpoYPZ56u3PGRB/0meklM0C2nkGUY7Bo?=
 =?us-ascii?Q?o1HIawJlb8pCVC1yGZ3YFDuzrkNVidok+vvvmmk9VJ+RKZc+/PxupoNlSO3d?=
 =?us-ascii?Q?ftMS7ArxXrJ5Rk0eCiqh9aRmtLsj8R1EKaNvfugNWcoEym3nkqasF3yfxQoz?=
 =?us-ascii?Q?6x+uhCnVWmay0DeHnNUIZQRXwatDUSRJWXVRiVttRIiWXIuB52O1RP8cjLVa?=
 =?us-ascii?Q?/+IQN5eK7ognq3rUcaB/2gJQ+RQ2rQ836xdfthjTPALEx3Woj0Ncco/dE4PH?=
 =?us-ascii?Q?qN4dxq7lbzkikywBsFy9VrQrmmDH07WMT2SV8e3TJ11eZuJuEv2mOuY2AJNH?=
 =?us-ascii?Q?hKK4gaJ6MA6dvUgrKQNxCkYvRDSKN+nmq9CwllY54ps2wSMSyA8uIP7fi13e?=
 =?us-ascii?Q?iGDVD03MldcL5RkV6DzDg6tNFrSpjHjS9jvPbO2G0Cpib4BNufUE50z6etYs?=
 =?us-ascii?Q?wO2GfEiXSA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gj8Ru3yOoYEtHRYZ/daEoRTOy2ALOYy8kg8/ElSvTVNQrUC98mZkiD9fZEMxEjHlA4kEJyvCkaEa54hy6ehU6HNCahZa98WpebgfLPQBenq45GSPNAJ/UzgzvIAjdzos96jzyUqJxpSWLFKyoeV4JonJjD6r7V0YFDDLNad4JmmrvB+Oi3T5D6qmM1qnJ0gLah+AsEZj8ge9/dkPZW5524Le1FtxbseIKXYdgGTpLISpsCfByhLhpLbnlDXoHqagztHyUw0+7iF9ugJSCZp9s/bKT+yXrJF9wFpd0Zd1r/BIMHOiQk2q++ajfQgo0Y6m26TGp0LuMPxBnssBZq+pVQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaa2297-6db0-4996-6abc-08deee166d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 08:42:02.2976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDXco7tCpq1lxoQ4vjAllvobzSStXYt7fwFJxk572Orby9w+ml7SQKOY6T4qfDJ1agFv/Vnt3e56hZlF73xFkSxu7xlba6Ia4gil+IgsLpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785400933; x=1816936933;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OuoKkn+BRqRrKn82qoc2x75tOtYi3bcCqXYh+0zS9iA=;
 b=ZWYWzl0Vz8RNYap/PrfQpfnQwBPS1OrWG/nhCymsiih4LD3t9TEMmyty
 0fRO1WYl7fyD5N1qHymBnpKzG24nJ1GwVe7+Rvqf22lIvdp/7JAFU3iiN
 7c6AZVKbRplGqz1JxkHR3uT6N/fRp0RIIYpk8EsTdlTxjsjfKRRLNRjDi
 vCT3EPW/eaaRZzxtva7uuR8/bC8x2H3EqNFxpgHJgpxX15xr24U4w9BUv
 q6fF/XOeBKQr9T+2ynixc/bRxm0MeUyVlwidQm/vB+soR2J8/cER06pLK
 kECDnStJjmjsRAHD+jaZeNN4jVLSLFYjo2WciANo5HuAdcYTcNHsVbnn/
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZWYWzl0V
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/3] ice: add TSPLL DPLL
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
> Sent: Tuesday, July 28, 2026 11:13 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> richardcochran@gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; pabeni@redhat.com; kuba@kernel.org;
> davem@davemloft.net; edumazet@google.com; Nitka, Grzegorz
> <grzegorz.nitka@intel.com>; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>
> Subject: [PATCH iwl-next 2/3] ice: add TSPLL DPLL device and TIME_REF pin
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
>  drivers/net/ethernet/intel/ice/ice_dpll.c  | 398 +++++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_dpll.h  |   4 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c   |  10 +
>  drivers/net/ethernet/intel/ice/ice_tspll.c |  34 +-
>  drivers/net/ethernet/intel/ice/ice_tspll.h |   2 +
>  5 files changed, 409 insertions(+), 39 deletions(-)
>=20

[...]
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index a997be5f7d8f..cbd9f6455c05 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2898,6 +2898,7 @@ static void
> ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>  static void ice_ptp_tspll_monitor(struct ice_pf *pf)
>  {
>  	bool lock_lost;
> +	bool dpll_ready;
>  	int err;
>=20
>  	if (pf->hw.mac_type !=3D ICE_MAC_GENERIC_3K_E825 ||
> @@ -2917,7 +2918,16 @@ static void ice_ptp_tspll_monitor(struct ice_pf
> *pf)
>  		if (!(pf->ptp.tspll_lock_retries % ICE_TSPLL_LOG_INTERVAL))
>  			dev_warn(ice_pf_to_dev(pf),
>  				 "TimeSync PLL lock lost. Retrying to acquire
> lock.\n");
> +		/* Serialize R23 restart against TSPLL userspace reconfig.
> +		 * Guard with ICE_FLAG_DPLL because init failure may
> already
> +		 * have destroyed pf->dplls.lock on the error path.
> +		 */
> +		dpll_ready =3D test_bit(ICE_FLAG_DPLL, pf->flags);
> +		if (dpll_ready)
> +			mutex_lock(&pf->dplls.lock);
>  		err =3D ice_tspll_restart_e825c(&pf->hw);
> +		if (dpll_ready)
> +			mutex_unlock(&pf->dplls.lock);
>  		if (err)
>  			dev_err_ratelimited(ice_pf_to_dev(pf),
>  					    "Failed to restart TimeSync PLL (err:
> %d).\n",
About Sashiko comment from:
https://sashiko.dev/#/patchset/20260728091314.1420656-1-grzegorz.nitka%40in=
tel.com
"Does this code introduce a TOCTOU race leading to hardware state corruptio=
n?
During initialization in ice_dpll_init_e825(), there is a window where the
TSPLL DPLL device and pins are fully registered and exposed to userspace
before ICE_FLAG_DPLL is set.
If userspace reconfigures the TSPLL during this window,
ice_dpll_tspll_state_on_dpll_set() (in drivers/net/ethernet/intel/ice/ice_d=
pll.c)
will acquire pf->dplls.lock and modify the hardware."

In general, this concern is valid however limited only to very narrow windo=
w at
the driver initialization. I think the best way to fix it is to move dpll.l=
ock
init/destroy outside of dpll_init/deinit procedures and handle it in the dr=
iver
probe/remove routines.  This way, the flag guard is eliminated, so the moni=
tor
code becomes straightforward: "take the mutex, restart the PLL, drop the mu=
tex."
[...]
> --
> 2.39.3

