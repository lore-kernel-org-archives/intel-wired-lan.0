Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD8606A32C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0Q5zHp1s;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YqaBnHzh;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=YT/7egi0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CDB840340;
	Wed, 18 Nov 2026 18:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QIDzOnmz6HcP; Wed, 18 Nov 2026 18:58:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 098A3407C5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795028284;
	b=bBHPK7RkhNz63TihF8s7jr5xmLfqEUf9nt9ZR8giE4C0a0w4v/fw59wkgIj1K2NcpH7u
	 hJP9GrjjbXPb5wddJ35oHuAMePQcJRU4jc6R5Imt2KYkQEhUEv3SZEKma13+exaon+3l+
	 l5AdwxgmzADSXS6UanNgX0AdJFVqtJkCTBF0EzWDwSYIgP150uZw2HQzJD5dXVYY59yGv
	 KUZb8pUpt0NxlddKTzvSVyCI3XKu/JfqfJz+CXLmxq7PiCbKT2ae3FT/X54N4xf6TH7fC
	 jLM8zkV3lFH1MDJGPWgi5hetuVK9M3Bpzvke0nbuL4vqa09EzUY4eJOyf5fnj5GFmUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795028284;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:From:To:Subject:Thread-Topic:Thread-Index:Date:
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
	bh=QfjPPp6gRrP1ymQlkuE6r+ASN49PJiK0UN0NTex1B9s=;
	b=GysAEkMyLPuD/P2aTx80g05oLqeCYxcRK2yKqABm2v7RlkNkvSeapGv2yCcdLkB+8cLO
	 Nz8WgFdkf9Gai1yA39Q0ThDdqs+CwTKtCoDer5brO4HOb/U7WYB1Kix7a0k8ecbLhTQ8g
	 apPInSeN34RBobEFnLl5sODhg1uu3KmtPwymf+Z3DA8y/ZP7yZiwIXrxjA60T8j3ZlYtC
	 v0eWXb5Y6QNMGJBXWnry7GJnJi/mEgxAFld2yqzSd/8INzWXhPuQi6A9pS/QpC8Wxz3iZ
	 b87XSG91DyG3PaiBIdBAv09EsdkQfAgClJrFh0iKJDCn2Ro2tB/NCR03ioicWP95khA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YqaBnHzh;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="YT/7egi0";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795028284;
	bh=QfjPPp6gRrP1ymQlkuE6r+ASN49PJiK0UN0NTex1B9s=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Q5zHp1spGjOFwwnawDBB5yIGdS7jioiaG7N6PTz7TqHs/avNIR2B8OMb9g1BJKr7
	 Zx2/3iNQJqoUIhUGfOuTalnlWCCQzpu/rwFpKIevFZGwQWl0uJfkBMNItpYDomY1Qm
	 gf6A6Lgld6zNVR/qoXG75C4HN6djUS6STD41slDlHdi35GzMw0GQ/BWdeSsEOKhJPJ
	 2IKYhBsQdduRWCdm2Lf3+s0zrvVWWEg0tjYqH9gRuq3jSJ6F+mkpGpeOqjAeiF2Od1
	 jOmaKZKb/h5k00evLo3S9KbNzU/CnJg67go8wVuSP5VqS8MDOVYo3o/z6VEGBhR3pw
	 VZhgvoK0IOA2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 098A3407C5;
	Wed, 18 Nov 2026 18:58:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8289413C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 18:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 676CE407C5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 18:58:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aymYXsqcyGOl for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 18:58:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 884CF40340
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YqaBnHzh; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=YT/7egi0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 884CF40340
 for <intel-wired-lan@osuosl.org>; Wed, 18 Nov 2026 18:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795028281; x=1826564281;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=jC4yxv54ZsNEqm6PcU10Dubq/m3sfFxIx/t4hSFHYZs=;
 b=YqaBnHzhXiKwalhtSBbm4xtfjcnCJgaFxptV/1rSufEVZuf6jD8ruiX+
 Y8/l7HMSYAiQoQt/yQhAWq/ExOao/CJFwSPFt0kPrWiBr9PTup34DWQ4Y
 FonxK78fkusiLFcN+uy4rajgcx6ABQ/Ut8QQvn1267cPxeje72qzXd9sM
 S8zR/WJW/JjBQ+3h0GhLlNTcMmckGRu01X6u5hkMIRTopi/ItClRDurRD
 DpjUNqCSN2PxYxrv5t9zYT84mma7seXLfnnfJqiyEI9DQm+UQ8kUWVZCJ
 ZbHYV4w9gfCGSjpRgYyUjs/PlN5kV1t9zdvPo+GgbrOP/tMSQeBMy6SWZ g==;
X-CSE-ConnectionGUID: RiN4wkUYSra7UTgk1z1d6A==
X-CSE-MsgGUID: PFyP3RI6Q4644QdoPelz2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3748737"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3748737"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 10:57:53 -0800
X-CSE-ConnectionGUID: +msBVkIwTTCzOK5Ah0mjzw==
X-CSE-MsgGUID: dmwyPAc0Sjm64MPWw2KHXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10491860"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 10:57:53 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:57:52 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 10:57:52 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:57:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfjPPp6gRrP1ymQlkuE6r+ASN49PJiK0UN0NTex1B9s=;
 b=YT/7egi0I+EUO8/356Jgb7figlrfpXat5FQQSiyrWjbY9KAnmS5+V7N6s9wvowzZVYreOmXJCHHFpmn1/QeCTtLaZF0DwMKdb+tUGGBgB1OaENatUjzzdXa84eqX94/Tfgl5bWfyEatLwui6PgB0p9cEdqz20JmeXiI0LqbMP40=
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by CH3PR11MB015790.namprd11.prod.outlook.com (2603:10b6:610:349::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:57:50 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:57:49 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
 "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>
Subject: RE: [PATCH RESEND iwl-net v6 6/7] ice: Annotate PTP control PF lock
 handoff
Thread-Topic: [PATCH RESEND iwl-net v6 6/7] ice: Annotate PTP control PF lock
 handoff
Thread-Index: AQHdWvMdRtUgWS/tDUu7HxpeRLnu4Lc0Z0VQ
Date: Wed, 18 Nov 2026 18:57:49 +0000
Message-ID: <LV1PR11MB8790D0F97CA24E172C42AE5B907A2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
 <20261013091235.1423979-7-sergey.temerkhanov@intel.com>
In-Reply-To: <20261013091235.1423979-7-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|CH3PR11MB015790:EE_
x-ms-office365-filtering-correlation-id: 5c85a7cf-021b-4261-33d3-08df45a5d761
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|10067099003;
x-microsoft-antispam-message-info: oE7qDNzswBkS7p+sfa/ygwsJ0orT9Gl3tHhYLCyYxVYC2xB6zAzmJgVL1RDz8IpM9lbtPq+ZgknTM/4Ca9o/g6ayWu+uQtqdbiD7NCyM/4YYya4HC1UzUnlA2/0Pn3ZnA14MiYBVq7mt6TaCcktOkxcpE5D75J7zvNP9u4nafGcUNDJUwjCYAcWWHu87fUDDrbXdB2Jgh/+JCClIH45hVyNpF+S8NGz2ZftYikMBpo7U4VGUc0GlgxOYSUpkoSdx1vfKQpdU+wv1gvPfTWD859A6fiJvh5PpHvXAw+St2spNL0xsIMahv9rVEDtxz2o92rEuWBS0iBb3IrQ1yuQDDNeK51vU0yOUZYxgUetDmSWMNclYeCu8SLTuP+a2ol6xyl6agBDE6uShnkbLoj2R01tShni7GQg+V73SCr7vsZ0uYOTlXpNprMw9/U41wB5N15mgr7l6UyYPmRR8QtADq81pIY+wgrbalZBUDfVcnMxqFTxZWtqX5sqPclGR3+90aPP0QN+DfZflQKOfyoSyDU1L7rrkpOJFvRUA5vICk59z2AVE5dBtrUQaJi2xrm9nT+MjdNgHCC+7GtMR2HjEHGZ6yAss+1nXBbUxoC69gvRnEbtX44Bo6rcA/PqqU5PFZyGW7tklfLRNxGh2SQH2/2IfysBEIlIuNHN2oKyzSmdFEkNdcnZhugEBF7tbG/jrsQ9BaYlsFvnTf5R9vrqmyVI/6bE6NKDwnLhOUfZPy+o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dlQr+6e+9Vii0oAMz8FXOD1llL2zq9W6QCnt1/A2Uik3Xir7cvG+a8IbinmP?=
 =?us-ascii?Q?Fu5wAaB/UYZoLbVlqf2fLRCprqhvvUgMyqnGqX/1TGJniDnI3/BNTjrC51kV?=
 =?us-ascii?Q?U3rREp83BF1zKQUfIFSopfrL49Mynzo3e+bGWe5kL+76wOrYySN3uhfydtlb?=
 =?us-ascii?Q?kRglGLoTtP+ZAAlBfscN1i3XtlB+nOkARXcxDUoYk7mYdzy4J3OdXphN0z5s?=
 =?us-ascii?Q?Xl921lQJi6u45FJk+wZnO1VfeK6uD25QLmTaGduR71JW07O2GVtVjhpdBgXp?=
 =?us-ascii?Q?B5Nzlyno46+eFx2iObwo5J7SUA7g+Rq4QZwEQvFLM5KWCDQ5eYwEqV3CLeb8?=
 =?us-ascii?Q?UUhLJ1Vj+BitHFzlaMgVkbM4RUkUU6JGkpYr5Yqw45ANHv5RBLGmx6TLEPjG?=
 =?us-ascii?Q?eOFY15FjkswAPRVtiQcCKy1v/nyVGJlpT1I5QvXuqC66OMGTeCBCjJsnTMRA?=
 =?us-ascii?Q?rdy/L6WC3HRJuRYQO8oSxJKUjdkd1g1Z/GzRRi8/DqliQFyo5UBBKbCTd42u?=
 =?us-ascii?Q?QtyOdLGBoYaN8I6LZKRnKDzDYPvVyjQo3LVY8npcz31nTONXAlh0AqnkCxNL?=
 =?us-ascii?Q?xSU/8emoOK/TEBPeNooj3mDebnrUr4XRA6nnbgoGDRN714FWhzB1nu54CUwJ?=
 =?us-ascii?Q?lAT6kzRl7iJI9bBcdUyjIrCxzfT/R9qXPjYk5B5RQnNv/aPawt/3aHojc8Tp?=
 =?us-ascii?Q?KvFexSiDNkmY+Uh1ab2RwosdjdchZzMMLJzNt7ZfIsgre67b9AlAGefHZfH4?=
 =?us-ascii?Q?nIBYKXS3Wx93tdTXn52k59/ILrtxMsw2MBg6YhuWdixanB+Mv2JwyJNsUMK9?=
 =?us-ascii?Q?G2BHAmy8EucwgxYfhvZwZBz2vObIk4YCStCmNMG8fBVFKNtyWM0qE1FLnDEg?=
 =?us-ascii?Q?6RcvEcYhF4Bn9rlzMeogwRkcMGfK8E5JgftgBnJvupBxRhVW+kAA/zafgqmc?=
 =?us-ascii?Q?WhqYkt/7/v0BkHg6yciha2ij+f7dLZ3rJiiqEFcgsl/XqR0dKcJpnuVt7Klu?=
 =?us-ascii?Q?VPG9i/fgJFUPza5D+wUF++iZb41AMTwcUp7r58LI9B7PVm9LPywuk8m9GtVY?=
 =?us-ascii?Q?HZaDdlagcbE/G+bjd10utgzh9S5TY++ntJjnSW771CoXiidoZQC+3GlNKKpz?=
 =?us-ascii?Q?Yfq5acVgW9PHszFJK06Y4BOcyWZLDxMzcwVfySxfC+ovuOX21fP//Lbtr+sp?=
 =?us-ascii?Q?NlOKOrMgy+h9IYC/FzqqUMBf7IUsRsyOEBCWzGnofNY3bNy7enPI8M0y8bks?=
 =?us-ascii?Q?Yoc+YVTSX9MsNl533vbeO93CTa/Z8Dq8pVrrH7y41Pi+X5VyziplnY51+wfk?=
 =?us-ascii?Q?aYd8eqw+aAz1Vsamgn9y6RS4hzdnn9LOB3X6UAGl/ss/CF+Ca6i0mv4HY6ij?=
 =?us-ascii?Q?JGVOPLUMopvSiEYanIOq+MaGFJOEu+VlDm6YYyfo5UZzJ7rTBvN/4Y0FysbX?=
 =?us-ascii?Q?DaLtzqKSxbB3uy2lOC7qOxYPmw32Bm0Xd9vzvBIqNDYoNl/CAyNw6SdtZvuR?=
 =?us-ascii?Q?P/W9eHc7gatT4zIWFoR0ecbWR1byKgikOD0LiJ8GtULKM/wccwqphl2Oqe1B?=
 =?us-ascii?Q?5KJHEbTZDtEDw0+JnXORexKjKyunhcqUP/wmnUiVqcg5J0Ufkg3fEyf+xK/c?=
 =?us-ascii?Q?WeqePmAsCjzTzaz1dIUu9PKdoTh9C4ViCc6Olly6StKuDD7o7EqvK9jWr5Am?=
 =?us-ascii?Q?gV4xA9VME34nFdCJfLFM8nDHIrjf84+EktnHIL297oC5mI3ZmyBLE7AThLRU?=
 =?us-ascii?Q?35bhuqx2pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rYExFNy6K2w545rmaWVcRsxZgIawIvFmiBH01CRQnAqFeIzK8ggQ/dG55Gw+tHfBIJR5+7jw+rwyPBc1CmvocKCEeuUSufc90dAc2WVYCh/CKk7+dYAUyAvvuzxlFYt33oSi4FP1wqPctWvc/QT+45VNMeo/Zwv91ibOE1QioF6Yaq3Dt6KNxi7xnl2f8KV6bQvCPXq6dYuGHrZS2p17dfBFj6p/MIFSIP9FlOARNfTfvc1hiVUfI9JMP7Qljg1Umb1I8HNR8Q1wIW8wPJByFi66sqsR3j8Foi0S/DvqRHI+ic0x+ihrK1gDY4d8o8MonhzHmL07wEgTHiOQ3iPS9A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c85a7cf-021b-4261-33d3-08df45a5d761
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 18:57:49.4873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZmoIgoQmi571cbh0a+1IOgOitKdcMc7qzaAeBs2fPF06s3rVQtcKLVNSR/gZIcZkDb1L803s1i79Ka2mswgLohcIqtx0WAZZ5a42Q9+4h/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB015790
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Tuesday, October 13, 2026 2:13 AM
> To: intel-wired-lan@osuosl.org
> Subject: [PATCH RESEND iwl-net v6 6/7] ice: Annotate PTP control PF lock =
handoff
>=20
> ice_ptp_lock() conditionally retains ctrl_pf_lock for read when it succes=
sfully acquires the hardware semaphore. The matching unlock occurs in ice_p=
tp_unlock(). Describe this cross-function handoff with context analysis ann=
otations so static analysis can verify callers.
>=20
> The annotations are inert for now: drivers/net/ethernet/intel/ice/ does n=
ot set CONTEXT_ANALYSIS :=3D y, > so CONFIG_WARN_CONTEXT_ANALYSIS does not =
cover these files. Opting the directory in requires annotating the rest of =
the ice locking first and is left for a follow-up.
>=20
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h        | 12 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 26 +++++++++++++-------- =
=20
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  6 +++--
>  3 files changed, 32 insertions(+), 12 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
