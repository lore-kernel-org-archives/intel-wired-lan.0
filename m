Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC90C54F54
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Jul 2026 16:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 588EE8118B;
	Tue, 28 Jul 2026 16:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OYr1n1U-bb-o; Tue, 28 Jul 2026 16:56:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 501E78117E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785257773;
	bh=FiofRO31Fv+cJNFL7HdI0/BJPS3KBuOwZK46ZVcuj3g=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wzQjupOGg2T9fU/86RwkCGQRlITLmotAZMw1ejQCYwUG9uE+X2VhT+2CbswkxSBkN
	 fVD/NgeCVfvIrmwC/RNv6pzyWgL9z0YGfiCmBC55X6W6VsT5fHkd62Tm9ttUakAHvN
	 P5vvs+otb5pdOol3O7EvP4K5eOZdavl7JDwzVfT99zbm4JiORrGkNYrJYjbITqZl6y
	 N8zJFCDlaZuJUh5BtXYe6dy96h/kg1UIC6honA2iRb1QrEVVWt1Mn4sipacs6h/cNd
	 h2iM8rFtnuRHZJ08KrKl7p89v7zKhPTjeLjUdErKdxBebfwf/2Ekqy5oPE/NumdzJ5
	 1fRNwVfDAxH7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 501E78117E;
	Tue, 28 Jul 2026 16:56:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CF9D4BF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 16:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2CEB8117E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 16:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZNn7jSBskKWV for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Jul 2026 16:56:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 20BBB81176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20BBB81176
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20BBB81176
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 16:56:10 +0000 (UTC)
X-CSE-ConnectionGUID: J/k1wZs7QTmzytQHYXJotQ==
X-CSE-MsgGUID: xrGeVwMYTXC+BKFxV7l0CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85794707"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="85794707"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 09:56:10 -0700
X-CSE-ConnectionGUID: lgxgb+gTQzisV3o13gPKaA==
X-CSE-MsgGUID: bVtqVoDqQYyQ1mTCYtk2cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="261715418"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 09:56:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 09:56:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 09:56:09 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 09:56:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBNGS01Ip5ZCVpYE5Ca7qwvbxv0dR55HbSkPVkFiS6OS5m/5lYlSGw/XXZAARcySRP6az+NdtbZ57vwxKfL2xiF8PTW7OYP9DARNtkKxDLW0+KkBlwuvdMsvyPPOkx3ZP21rcPM7dGlF7aiwJHbZy7QDQQANX3pvQj72O7K3d2F3theoAjfAwk0nW0mnm5McSnQ3WX/nKsX+NzNY/hZOFwVnpltkFiDrqIWzE7opDNk/WJRcKDB2P/gF8BHj6JuArui3Ghp1ZSy5QNC+DaBf9G+u5DRZphFFbhsKUHnhsWM+3N4y3vSi0rkwn9zeHtYq8YVC/+EUXHzFyJyaxOEQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiofRO31Fv+cJNFL7HdI0/BJPS3KBuOwZK46ZVcuj3g=;
 b=yB7EIYFt/e5K6xst+khTL3T19zdPBKSj1TaTyTqVDLBMibdlBXqNIAXjAQGfdE+2jR2PXBH59dIWJgqKwOBIjH3oG0oL11VffWtaytstU9MEgBkCf0vQPYZwY4w1/Ce30cK0/N5XW6jutcT8/TdGnE9AmOLL2sYKw76erewxmfCr68fW8lUw7Txcbj77b/sKXxl9spgZK2ElbQn8Inhh3YuJ8Kr87dhs4S6/pWrfbH9qKNXNRkdM9KtyFyD8PusNSrGa5rGMYpA5swqK/Y4G2PgkKNSOE13YFe96tAcnq/tpI6TjvtEKx/+UQ8rW+iRnZQWNVG4ZdQtK0sTF5eQv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 16:56:06 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 16:56:06 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Yuho Choi
 <dbgh9129@gmail.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH net v2] idpf: Fix mailbox IRQ name leak
 on request failure
Thread-Index: AQHdDVt0DiKpzGg0JUCejXT1YOGAFbZiD0AAgCE559A=
Date: Tue, 28 Jul 2026 16:56:06 +0000
Message-ID: <SJ1PR11MB62975D4A27133CD1C002244D9BCB2@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260703050332.121551-1-dbgh9129@gmail.com>
 <IA3PR11MB89863719790B9C2A4AE48A34E5F02@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89863719790B9C2A4AE48A34E5F02@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SN7PR11MB6899:EE_
x-ms-office365-filtering-correlation-id: 3761166b-c729-49fe-077d-08deecc91da0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info: BYlNs+XW46i+/9MbLkaH9cxi2r5XUR0BbZk3WqaK0hS8pibt0K8LuEpMYoSq+ezUwA+k7c1m5vKiQo73FzyxMXLSQLlWabVwxm09PjWlO833BA91IkpJ3wHhl48oIkrx7Qo7KaHCnzrys938ELL9NXS4t20R1Z7fL25c4WVLhyYLDIWkx7vTltprwIYX4WfO32/x6WjycnKxlKJRUkzpkwxzjIhGl0ctbOk8e7UBryRXRNnzDyw2P260ooMa43oCGsemgqHaTeze04Xn09+3j6pjNC2FKVZ3rnQq7z8Kv8f/s0lmQziIbnN3+Z5Hq2m2FEQuqwpGsInsvxB0yuBBPPeCGzYAqd2hZ4r1nAbF7pD+vpWK1fz8EZ/WMpBA0uKHzV5kO2+u8INhzZmKsed2qrzqqF+rTU+BQGVXoZ4PE1D0Pzh6mOHiLNMLXa111QSR+qpxEI9dT/FDBFN7rPeIlxZaG03f7Js1lm+5e2aVm+VOmZh5tqImPc8Cfklok1A8mzNIh/p13Zhf1f3EHpi7P1MkNbz/snZZA/jgAt3gPZ6E5irSXcoO5ZW8IfMPKtv2fZSKu9HPk+HM+OleVgbQNNsXzXTUKrwVz06LVQMq1k6jpOXlkw2y7DD6aJANIpyx6RFtGjYiSvLMjq4l9PUSo5d8KKs5Vzj6xzVJlExjjnKZcCvHlKxR8OI7TKOjo693UaaKCvaWxhmwfkZamrAAdKVFR6d8eQj+91wOz4aAFWXD8Z+ZwEXtwauEiiAAzhGS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6297.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?njMdHFB2/hOaU1TPaZdxk3AYUfTFdj+WF4hhnQ7JhRsqtLejJJEXBncHga0F?=
 =?us-ascii?Q?NFAghaeuBFMv3vloz4Ef0UEa+NAwG7902h0RLQ4DS/xUABKdjXrD+qfN80gW?=
 =?us-ascii?Q?aSRX+QDxtsX1DNDvNE+uwEMTrNAFQUCJzGyKbU0+FeBLFUJKLDUSxUzDcpMz?=
 =?us-ascii?Q?5ARjezdn8qnq46r14YbO45pNGpx0zmX8a4t6y/j/dkVZFQXI9sT2L/E3SLdo?=
 =?us-ascii?Q?A7Xg2hHEejVR4XEoE655m8HDHQsyCt/m5urjwWCn7RsqQtkTWNWaRnULiFht?=
 =?us-ascii?Q?uYbvOBRKMEtgHPpZ4WsMiH5WowsQDXmchMhwg48ISdAmcEXl8qS3B+Sa3jlL?=
 =?us-ascii?Q?2VxmZRr+qbqneh9Jn/uWh8DjB5aBIDPMOh7/bw1XHFtr5rAC1jHpDpln+J+z?=
 =?us-ascii?Q?pzn9V2wSN/+nEU5UCBKp8j394UqH2knPLnJJZpUp4lODv0HVVd9OpCXYRGCl?=
 =?us-ascii?Q?Ep3tOwStpKWHilNV9gWIUgTdQQR7/qhzVVYKHmpPTY8aTvUnZ8gHuN41rFA8?=
 =?us-ascii?Q?6stX77Yq/d1qDc5UEANu2zLP934fSL0dqqqx2LFOf8HNl7kO3paL50UogA6j?=
 =?us-ascii?Q?j8gZYaB5rQ68QKPt4nbE1V0uhugpYCxmzFy5suv1Vna96DWFAf72QLZtOd7a?=
 =?us-ascii?Q?dJDf31MWYoVI9+qZJlBPDYAGJmIQSU5LFPtzMuH+yXstqMu28zGNUbXgpj3t?=
 =?us-ascii?Q?iFAxVDr5LbLvMUVPQk0gRH2auETLwfmX9tHa+J4DZyhdoBK3YRReEhKPhVRc?=
 =?us-ascii?Q?thjb1pGAXg2sDYJdKdqyy60iaByt2Pj4zcc4xnaficF6+l5A2o3xt/c5r6qY?=
 =?us-ascii?Q?CEAcIKTv1umWq4s2mz5vfpcdlvo46eV0uUCqePkKP9qFECe9MA5cq17WJWOs?=
 =?us-ascii?Q?FnYjoqJI7VK2q2xciU1XhgIkZhRtTsqfatL+3DaEUK1OEdVA+iECvq/hkC1C?=
 =?us-ascii?Q?7Iy0ymQzExbKfGca5rqD4d0rdzJAX6FvBUN9X4XYVRmVJTYWnGJBhtT9mysG?=
 =?us-ascii?Q?gURllnj4qXAt3TqvgAHWj3/iAsyOMh0v9rvnH/uFzoC7+o3765JQ4JwCWTPp?=
 =?us-ascii?Q?71Ri6WJgU8FAIUcDyHEA8rMzmcYmcws54dDgSnLFeMnkO5PViRj7ulMooFW7?=
 =?us-ascii?Q?hwHiymlADdqd3h6zIm+wTBvf6yDZ1FB/STG60lQmKiwVtArB9ZXD8vlufV/G?=
 =?us-ascii?Q?p9Of2d1L8kplUaBJxUxDTULmHlSq0oWRWLyC+UrTXkDDCupdewDKlgnR7YkQ?=
 =?us-ascii?Q?AGtAeJ/IC4T7jw6LqGWkVz/Iu+9nJTfOBUylmXoUTiUfzxO56eUwV9xFT8ZI?=
 =?us-ascii?Q?BDK1nW56rzVjUC+focbYuyfosXdnd/6RPJLxcDzsJvrkzkx2Do6xGQ8hEv97?=
 =?us-ascii?Q?Y4trp0hzxu/OT8n0anxONytNDN6F0bDAoefzTI3G2LAm0n25SOLmYvvnJMBK?=
 =?us-ascii?Q?xshZVHp5sE79fEUAVwhp5pPw+hsTiPuvD+8wNcgi/L2U7mNq5XN4kJ8EmoBd?=
 =?us-ascii?Q?vtsSXvXcUXmvLZXnwW3o4rG/I4cXuazudxvPf+XA7IoPh/46kJNPnPNSiPk3?=
 =?us-ascii?Q?LFLtrLBz6N/kW59bnumnggAhZXNZxeVDcp3N6kByqlrqSeRax/iyhUwG9NCO?=
 =?us-ascii?Q?Xo058qxKjmBdnkNtHaiWP5lJonGC9ni2+Qx68waH+Eyw/H43t8oFDvh0pnFx?=
 =?us-ascii?Q?ZbxL2BWQKMlOOwhJZbuLIuS7z5nKfmtpwR+Wh57TnuKTuHgK84otpbNQFoc4?=
 =?us-ascii?Q?RRmimtraGw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aT1Q7bHInvkNY22/xk8qO0fyAkpi9wq7stmYFaipj1QAX50ZNQFlcaWrQpgkZjkwuAKwG0wv3IIl4yENFGdlvX7UE0l2xf2tStZgkxso09YVXMD6SLSs1KwM/Uw4pUAuYieF5xJk0xKPWgIsCkjfq2QMWitgtE71PglUr6/PAf881VaBeAdr1TANnEEkUMZDeO9JQ7YcJIh1BsHSMLWqvEAUlmStbCKebOPte6pSQ4aQllUegjc5kzpPWucTHVHU2CR/Zhhbw9VZYgyCaU83S3ttWapXCTMt6+EI+ZI4mnxQK4I7Tr5QO1Ju5MMIS9DieX9A86vjzE4dwmD0rOcyMQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3761166b-c729-49fe-077d-08deecc91da0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 16:56:06.2263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuGqARik8H4jRSDxpAUYPRBfPzvWe2jxBOZb/mz0AuJvaV2fu55Kvh8VstQADy3/ijQK03neLGDGs+9mVlyJpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785257771; x=1816793771;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8FavA/q4iOclHgK3ZElhKmklIOrPBibFycJQ/6EfBmo=;
 b=ftNfoZrV+8LqxcEoar2w4PI6W09etXuNBluS1RFaDTOcs0oLpSo1k7st
 /ExJWUEXap59dDKkV+RahCTCdst/fPMbgbjiVKNWjdiQf08uuwQxNfCeU
 S6TWbVuCKtSXg+iL8P6ikp1OpQRgDlfrFZ423akj3SOmBsMS1RFPWX3Ik
 i8E3D96kUfxRBrOvkidbXwYmI38QQCHGqGzvwFJwhUeaGXR5wh+sq0wkJ
 rmitjm1Fe+jZa8hetJbArjmlXoVs/UiF8qOnhrZUmABkqR5L7n8uUSHLG
 VE8aFzjF49AuFpBFcZapyBpI4x3DxNl2bVCGLVaZamR8sTQS6DIjHq0s6
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ftNfoZrV
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net v2] idpf: Fix mailbox IRQ name
 leak on request failure
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Tuesday, July 7, 2026 6:32 AM
> To: Yuho Choi <dbgh9129@gmail.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH net v2] idpf: Fix mailbox IRQ name =
leak
> on request failure
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Yuho Choi
> > Sent: Friday, July 3, 2026 7:04 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo
> > Abeni <pabeni@redhat.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Yuho Choi <dbgh9129@gmail.com>
> > Subject: [Intel-wired-lan] [PATCH net v2] idpf: Fix mailbox IRQ name
> > leak on request failure
> >
> > idpf_mb_intr_req_irq() allocates the mailbox IRQ name before calling
> > request_irq(). On success, the name is released later through
> > kfree(free_irq()), but request_irq() failure returns without freeing
> > it.
> >
> > Free the allocated name on the request_irq() failure path.
> >
> > Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> > ---
> > Changes in v2:
> > - Add net tag for the patch subject line.
> >  drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > index cf966fe6c759..bb81e620c5c8 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > @@ -139,7 +139,7 @@ static int idpf_mb_intr_req_irq(struct
> > idpf_adapter *adapter)
> >  	if (err) {
> >  		dev_err(&adapter->pdev->dev,
> >  			"IRQ request for mailbox failed, error: %d\n", err);
> > -
> > +		kfree(name);
> >  		return err;
> >  	}
> >
> > --
> > 2.43.0
>=20
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Tested-by: Samuel Salin <Samuel.salin@intel.com>
