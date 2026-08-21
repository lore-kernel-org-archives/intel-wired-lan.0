Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BCFC5DF7D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 11:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96BFD4092B;
	Fri, 21 Aug 2026 11:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KcRPTqlYNBh3; Fri, 21 Aug 2026 11:11:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787310719;
	bh=M8wFe1BOI8xU7NO1AFinkJmhR3cWhtCAED+Zn56H3m4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZOjnL74D7pDKHTTQeosY6GUr5FZhb/B3dtx9mMYOC5QtFr2F0VPMrSnvRULdXjsge
	 ug5YXm7KzBYbKHGm+s26l02Qlh5EomFl7vWvx2pGNlg9x0nJ1L9WBeio+BGxYgbw0O
	 /mrXkD2aDFy/teLnuxgVmisiXXd56QNBl8sjre9YWw97yzpbzklpP3Ke99wuQ1zEfl
	 ueffFeSSr2GEDhqEFpu84HbZu/KeW/SQ79LfxV6u5x8XEsRkCP1VhnnvLOVX5c0YV0
	 zaeHU0MVxNIVIPbX6HzLqB/Q+CIrMAZlJ2h0CcqPlVHxVe1hJqH2Qnc4D0f+cmlR4Y
	 Z2f9ay9pk05ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8A9E40911;
	Fri, 21 Aug 2026 11:11:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F0474B8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 11:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6482D6068A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 11:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q815NBtzkCJd for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 11:11:57 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hN6l3LwG
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1966360649
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 11:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787310717; x=1818846717;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3mqOkLFXM7E7LXfZOiQ9C2REmBNZp46NSOZP5bgVSeg=;
 b=hN6l3LwGzEHK84lC3NzUfIkAY91SX23zK5m+zoaJPofu+4gZFhllNAH2
 gC1KWuFws5QXO+RopchxigXEAW3ZiB51Rj/EFDdI4rr7mo3M0PMoVJc8K
 f3yhVxzmdB/6tYVGyqaQDN0+5Jdgh8a0Xe73VZ6EEEzlG/k/bXNKQiewq
 Xv+LQGR6pbvw+FqXjK5u/sCwS1DByU7pJ2uwePZSE32F2PL6K0T8OP4Y/
 BS7sqh5cWMbkDcsq0dGsapMFKFAh+HyWlW70WHB+XFcKQIr83BmzqGRkx
 NgN2+jtU3uZQHOG7azPfbMoBK2YXzzemAQ28rhDtHsKTpkZTIyZ6B55Sq g==;
X-CSE-ConnectionGUID: fvunzc73RgyyIlfivd39rA==
X-CSE-MsgGUID: 5dlJzdUGRkelexDyzFm6Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87627298"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="87627298"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 04:11:55 -0700
X-CSE-ConnectionGUID: BjiZimvySPedfLEyHWrADw==
X-CSE-MsgGUID: G/zvEP14Rbq+TRauIxz2Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="262603696"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 04:10:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 04:10:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 04:10:48 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 04:10:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfEXS0SYbKYTf2P7AXVueUgxx/CeSpaFYUmXhjHHXdOib0fv966/4tv8u9rnU0EqsHUvo2yEU5vJdhBBtVzphHFKgsv8RMUJ7qR4kKTVMv93yA5Ks4Ml2Sn0BXFuK+oZMyQBeA+7wg3KkaPPPLIR8dZgEAcAWXfOpxAiFmKBOa1c2BOcb8JjG9E5lRmer6UAydRzdiCaYlc0T4raxrlZE+o+/tiWWgWJj/vF8gJrBtHusyAjnQHc0RHjLBWLlUa4RX39LDZRjRIutI7dLx+5KzFPNCwTc7GTs98wUIyLgPU/ftPBizId/+0CcFsohnpr9YP07cnQaIvH15RnyO5RYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8wFe1BOI8xU7NO1AFinkJmhR3cWhtCAED+Zn56H3m4=;
 b=GaEZ0+4ISVlbKsfl/Hje5LzKS+0i715p5RSRzUWYhORK+ZC5wBxrfdE8Nyk2gZ474K/hzFaxIuePY65m/2t4RIZ1RVbwwbpICBlibDp636p3ICNqCNSVCtbz89+QW5g+d3HpoixGyOzRoBMRUHxU0+zsq9dvMjjYNj8GOWRwAtKFhLG8Qc6pcWN6kNGBU/IBDDouawElULOvk+02fqq1NFnipxW1OeZybgGp3dRAZxyaMq3Xhj2iNsiQnOpTKzZIzC9SjaMeDOv2tXVMvCFSbWi+oQ1HepWS25bLXxH1I+wtbDWDvdGsQ2EwmnDm+uQRuSd0s5aCxJgg6UcLp5fG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL3PR11MB6457.namprd11.prod.outlook.com (2603:10b6:208:3bc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:10:44 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 11:10:44 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-net v1] i40e: fix set_ringparam error path freeing
 live Tx rings
Thread-Topic: [PATCH iwl-net v1] i40e: fix set_ringparam error path freeing
 live Tx rings
Thread-Index: AQHdEDkjxHhTWICfq029YQNAK4bGX7Zv/xiAgDibsRA=
Date: Fri, 21 Aug 2026 11:10:43 +0000
Message-ID: <IA3PR11MB898627357B69696EFD995B7DE5A32@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260710065530.4138116-1-aleksandr.loktionov@intel.com>
 <20260716104217.268158-1-horms@kernel.org>
In-Reply-To: <20260716104217.268158-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL3PR11MB6457:EE_
x-ms-office365-filtering-correlation-id: 5bab1208-de64-4e87-9a84-08deff74d81f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|3023799007|6133799003|10067099003|56012099006|4143699003|5023799004|11063799006|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: fWoJwpIXSMhKF1n2zfLWAliPDV3KqSK9TgrIUhLSm3xdFfCgZpoSyXMAh7lOMZhvQuzC8JiXGv+NE4dRpyLAirlVCwG+FyLbn/yolL+dcUj0q5Qmo99W7nusrcbqSimN+m9EYt8zdRBDqKfTS639kbJ91mRqKOZ3g6J+0oTxLJ2GWNE0uERlRrUszJhb5IcbAOoH2ZHdCxW2libc2QiyN/1L2xtIDu9VH0jP9SyVyHpnMxccciMDCi1mEfnqL4BF38WhcpV2WBq6Ol0HSY56keJDROJLF8ZoARLu5B6UPi6ts2qdqPkUgeucBTCbLhYJvm8zPQwgTaecdUVElRe9MzpIv51MomCLDwko6AGGVFoB+84nL6IdD2ahrnYni1necTVEMLagfQ0fXY0hboOvYakrWXmrdDNVl/Zg1KaoD9eLlx7SBoiTbZvxS6kf1nk69XkNEWew5AqgEtc+WrLr3OSvE0IfUu6dKDO01H8hl9PbDEiJnIdfDFYCnkHJfM6EA7aE4we3GKSSU/ykT7f25nhUotm4PslYcwtu/U9jGnuYLRcs62snjI64DJK6/gkV9lNM4+46+vgRP8RAFiVDSIV14rug5OHPseymX8rWt3g5Qxgg01SoilpwBHc1Yrv6recumuxhrVFRqxzQUS3Y/sb+qKSZ9pgcBetyk710K0M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(3023799007)(6133799003)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Un+h3DSbOLt/Fs/bG8mdujw9OVs+8gqZBx7herCbL8vAWTuK/6MN3slLBIMp?=
 =?us-ascii?Q?XoKPlr8TRPF3VOWIE1ML9pZGGGzxmXXiOAt0D6x8JVFk4Ck2R93mMqv/QbzM?=
 =?us-ascii?Q?aCmGfezbyGFQgikR6Yjqmr5NdfxyOL/81XaYVEjA563AlDwsZWrC5u3GuoKS?=
 =?us-ascii?Q?z39nN5b62ezsnzucdvcFekkNddhmyb6052l8Yyj3rzlHKbJBQwnB4KGN5E47?=
 =?us-ascii?Q?znDAxlfj25f1hrBgb7g71hj5a80g5A+rh/fNinVCWRkjAJLb4yJmPYATD7+j?=
 =?us-ascii?Q?pNiIoDFbiybnU6Ofeat26pmrwGPL+mkAL+S37fE8ShDn9KQQfLIfpfBi29kf?=
 =?us-ascii?Q?kdUPT/vB3cSmsTavHn9xRL/H02GmlVSTEtXizAt8QP6WOjxe9vJgi2CQeajc?=
 =?us-ascii?Q?t0mKirmf/WBW+xvT2n6CeaB+yeBZk2eErktrxebp+PhQvkL+Ayn0IKyZgwOB?=
 =?us-ascii?Q?dOGydsR0yVB3M0m+lBiLroUDLna9QgWQjCPD4L3xgm5hr9zn7jr7mdd8Y/t2?=
 =?us-ascii?Q?OmqGRVfz+UsM25UWaI7ywFRi6cO/mUIqRa8s3w9/Jzf01I692Zf0TYb+FADL?=
 =?us-ascii?Q?Xn5oFD0Vt7DWqxsrndS4UhUqF7TIAY7GSphsmTOO4ec3VNG0+3LopsFsZTYZ?=
 =?us-ascii?Q?tDwgMWZrnisu3oR8EyABjWTgFSFmmVQVxlPdu448KFKsGOBew2JWxBLdOOz4?=
 =?us-ascii?Q?154+RGJgU9X2hZZeTyJnQbLpQB+znLJ3c9EXw6HuhJMIAnu6uiKhf4ky7J9w?=
 =?us-ascii?Q?ecdf8X0pzHzm5tVTtaa6nl7cKy3PIOU1Bte7JzqYZ+hwKrVeV3/FLshqJouV?=
 =?us-ascii?Q?QCkKSdiEZkfQpYj1OeGdRsxLNr/PD2xTgcIIiuikE6UDL/ezS/wP8kDUoXjt?=
 =?us-ascii?Q?7p13QtGRpGbf2xO6eOzPYaTZRZdd+Xw1le5361i2y3m92ddirjj3E3KAaf3K?=
 =?us-ascii?Q?QRX7sDMui8jhHFgTzZ2fqm+iD9xuB/xrL46V/FAjR3F4YXuEb6i2GvlyBh9/?=
 =?us-ascii?Q?p9nXc8FCowukhPYvF+MvSJZBzx0LMfoin49+lpsIy7cW9znmljvvdSZdHehr?=
 =?us-ascii?Q?Ps6KWQctscvINRU8yDCWU+nDn2HyXsUA2jlKXSRZUy+RzGM7rAvq20bOf99+?=
 =?us-ascii?Q?PDmqVStw6lGCsIFTTrpfQYK16ykahKQMt/J4hMAoU1HtjI6Ris09Rw2UM/XY?=
 =?us-ascii?Q?BtjJx+8oPRNuDJ9ww+a+Oabx4GvGItPKm5d7gomWyFLHZJYtZVKRHN5lKeLZ?=
 =?us-ascii?Q?GJkyYbcQ02a6Ddc2ZoeB2J3oUJohZEi6NE0r4nI81j6o6J8cTcEKmleNbA+5?=
 =?us-ascii?Q?xxR7ok6wK4lDx4SeshAj+4lv3BufPoAToZuHi3JfVuXVHTfxwRpoJ/COt9y0?=
 =?us-ascii?Q?+MCEXBbumTIBuW174bEIZXXDOa4H8DF5cbJnLmJTo7zqtJEHJ0+gyR5jlqf2?=
 =?us-ascii?Q?7WokL0fm7PMloiNTBQSB+llK+v5bCNalo3RC+IW7vQ2VQHQ5yXewrIbR6NVC?=
 =?us-ascii?Q?pgezeGfVqtIst2BmanGL0P6T1RNzRVrHMtn7gsNCWJDvxlrrYYzmyGQ0iFCt?=
 =?us-ascii?Q?B29YsXq2n6AgG2YvylEatVNQO9BUZUxX8W8M0A/mt2pvSjtrbhhKuVZvm2sf?=
 =?us-ascii?Q?MuRMigYmuyv774NwFqjDg0sapuISv0iCPV1eKsPmIPAnYNbCjVMNw/Teg91q?=
 =?us-ascii?Q?OSYx8psJbJq2x8guOF9H9POShUpTeBwCUsZ59l2PtgUqlt808hjf5nhd6GJO?=
 =?us-ascii?Q?+CRb3Agj6TCI6SRmldpCB0dDP9KVt0Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SDHC4fdOVOtb92WEDNTyHuk988XB3zhCRQuu4AyBCa7/HVKzSkZu171x4dJFnDf+HAQ5OYR6WNDytb5ydx75tECnQs165jd2Fkc8rdq11rwOQBUMCfC88kbNBrnfoDiqs6wCHzRw6yd/EmnpdSJpNNKNGoGDxRxbJcJKZ4Ri46kY4kPJrPzWk4gQGjuEDRUqFJFiRBUvL3T9DBciIUxw3OZREtOdnHmxbr2xVUak8D7x2rdsZKOJn0SimDzYjHcWx3cOuMJ+MJ2nfdW/9J787jKIIGkQ+e+aRDGl5AF3i5G28A7uVxNIqz1G7nVj/LNO+5rVrIN3QMpL5uZ94Tt77w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bab1208-de64-4e87-9a84-08deff74d81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 11:10:44.0378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2YBmLPZOu6E+DuqqRRmUub7oeDLuKDc+oftxRSD8Ii4TBeBL8gNGtEyIY600UPs5HjwYz4RmC19QkvWdZ59MVMLRD50QpiCJ+LfeK7Lkro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6457
X-OriginatorOrg: intel.com
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



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Thursday, July 16, 2026 12:42 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: Simon Horman <horms@kernel.org>; intel-wired-lan@lists.osuosl.org;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org
> Subject: Re: [PATCH iwl-net v1] i40e: fix set_ringparam error path
> freeing live Tx rings
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> --- Patch [1]: [PATCH iwl-net v1] i40e: fix set_ringparam error path
> freeing live Tx rings --- commit
> 7042e7b9f58a75bdb26437aed842a7b6780df035
> Author: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> i40e: fix set_ringparam error path freeing live Tx rings
>=20
> This commit fixes an issue in the i40e_set_ringparam() error path
> where it mistakenly frees live, NAPI-active TX rings instead of the
> temporary rings allocated for a configuration change. It does this by
> passing the address of the temporary rings instead of the live ring
> pointer.
>=20
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > index 3da9ec49cc745..6d2b076049f7e 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > @@ -2249,7 +2249,7 @@ static int i40e_set_ringparam(struct
> net_device *netdev,
> >  	if (tx_rings) {
> >  		for (i =3D 0; i < tx_alloc_queue_pairs; i++) {
> >  			if (i40e_active_tx_ring_index(vsi, i))
> > -				i40e_free_tx_resources(vsi->tx_rings[i]);
> > +				i40e_free_tx_resources(&tx_rings[i]);
>=20
> [Severity: High]
> This is a pre-existing issue, but does calling
> i40e_free_tx_resources() on the cloned &tx_rings[i] inadvertently
> reset the Byte Queue Limits (BQL) state on the live TX queues?
>=20
> Because the temporary rings are shallow copies of the live rings, they
> inherit the netdev and queue_index fields. When
> i40e_free_tx_resources() cleans up the temporary rings, it calls
> i40e_clean_tx_ring():
>=20
> drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_clean_tx_ring() {
>     ...
>     netdev_tx_reset_queue(txring_txq(tx_ring));
>     ...
> }
>=20
> Since i40e_down() has not yet been called on this error path, the live
> queue is still actively transmitting. Locklessly resetting BQL here
> zeroes num_queued. When the hardware subsequently completes the
> already-queued packets, won't dql_completed() underflow and trigger a
> BUG_ON()?
>=20
> The same issue also seems to be present in the earlier error path if
> i40e_setup_tx_descriptors() fails.
>=20
> >  		}
> >  		kfree(tx_rings);
> >  		tx_rings =3D NULL;

Thank you for your review.
I'll re-spin v2 asap

Alex
