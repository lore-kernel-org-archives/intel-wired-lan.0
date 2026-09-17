Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841B0C982CF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 11:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48EA780F2B;
	Thu, 17 Sep 2026 11:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UrE14Q1Fe_GM; Thu, 17 Sep 2026 11:29:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AD18A80F34
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789644543;
	b=Gb1ZoSOMQTv0mCL7l4LiR6nWBh+qM/MnmRkNs4B3DKUZ7SaaBeFOHDtTSbbvOwYvYBNX
	 GTxIWPQ1mN67MG+kvurUoFOuS/Nsqtx7kWE+hqejJD96RXVUIwwjJw7HADIse2KJNHLPC
	 WNcqlmnrDDGP5q25zAdoUQBQ26KaiYY/AOgPDVDBAFSXpn0v5kyCmKvAYbSdrSVjKBrJO
	 VK54ozRY5m1NVWzFcTr92aDgmnjci+GS8amcpAnN38f3Zcxzn1PtQnM/KUxf0b1dGlj68
	 acpYyCo8m1Gg7nx0PyACmF/ceD0sE7hBBADJsBCgsmrX2xGUKpeBz0PvojpcOwbfRig==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789644543;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=6orhvdTQBZFdYhmjlFwSMZHxwlGrrvxY/OXgkxzLiIY=;
	b=jBqA4PpFJsFQ6TGwBPjiHPpcbSPBlRXA3VwJjzcjVCIM4Y1FrWDbztEkc8QOorD+ZKZk
	 M8BryZTm4XwUwCm9oFynj/qfzCLk10h85oHf5IBlbIAUe73YmZrKDWnWTBH6yHvBFNcMr
	 YXlPwn17LfHUd4J/U4GO/S4hwAwLiwzNw/Gor3STpXXZAhpVO7Wo4LQmhjwATcyaCPVjl
	 H1K4X5XlYURzZxIFnMosM4khhFx888oi90x3KOZP40DiL66hiuCKA2xmPtTGsjSS0XF7p
	 tAnhfh0libwgW5OJ5Fj1sdHXB9Yua6aDc8Pp7QeIIVS/WwV0R4cN8LuPVfzEcyhKG6g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="mUjyl/yM";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789644543;
	bh=6orhvdTQBZFdYhmjlFwSMZHxwlGrrvxY/OXgkxzLiIY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6yF0e4iwnACI8GGxC4u7y39Mp5NpIwX8wqWFEkaoAFEWrihWU6SMtm6khhOQjJCKj
	 mPllSO6tHQA1dhAY9p3jxIgyRmaaRb9SGQPKpnteLPLKh0LL77CEH+QoEe72FTW5Yb
	 kejW6fGQ5S73KDsutVwL9qiKhIrVI0xauturlvLnWpWYsnJyD/gd9ll7NPvtcO1soc
	 AoYg3DSxTq0bO64GCYGCYY/zExrHjZtIcfAdkLcwk5JYWPvWrK42RqCU3mRVhAX5ho
	 df8ky4cRmTV5LuPXMZf+auVRxa9PN7Hpal5xusYyPhQpNzobnBbOazEZxFeL73oII1
	 Y4k3JEbP0fuow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD18A80F34;
	Thu, 17 Sep 2026 11:29:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 92D2829B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C9BC80F34
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PJmPzTGgqRGG for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 11:28:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C1B0180F2B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789644539;
 b=gmTvU0A95B2wmCslvtEAeOQE+Q8xxqT3prxIHVqKR5WwEl+jQpGXbvZIbHzOg1guyvXi
 jsaJEYIM1z213dB5ZDpgAufbyMDpTUj0NxljWkBxRRSqxpgdP0JwL3T4exeEcQ8nle+qk
 OERGDQ/lJMIx/QrELW1Ty1Q4oe98uM5MW0fo2h4jBPEIy8gSRnerBHQ39s0L55rcImNLK
 onH5wYDpUq+vd8G6yGfETwo/CXMSCxHx5bwDZcpMvkV2UnLU7hJ5BnzqYLmEom+qVtpSA
 vkeUs6z07y5O0CxfQBZjt4RoOCofqjmg5VsrZ2Y0BpiXMBOycrYGduhEB2Xv+Qcb5/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789644539;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=6orhvdTQBZFdYhmjlFwSMZHxwlGrrvxY/OXgkxzLiIY=;
 b=o/O56YDKFkpTcksk6sqzjfrOjtk/+gBK+xa4P12aBmnnqX2pJMywX+p6q6RTMVTd/qAn
 Gs5p5MsoadUNzewdkX5fKHQ4IppRICWEf5n52hYrA6k/JhoeTopkeA2IkdgonbiYc8Tw/
 S2eTfQTZTZs6tqDFynegjgjtvyxYOJnUoTo7Zd3P+qhKF7DT0DcqT3L0Ugy6lfcswwdNJ
 DW80cXSum0Kug9zUrcabnO2/3Y/rCmLZnQiWtvnVX/Xm+VljsjGMoJg7C9zHyfG5JS6mA
 h09RDoAP8bixLaKcPLWlUT21y3bElgTkBoEzB1OLshghaIJ8hQgZS46kzopUAfqyeEg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="mUjyl/yM"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mUjyl/yM
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C1B0180F2B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789644539; x=1821180539;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3mGw6ORD/m5v9Fl5nCquq9EF2V7Wd4apmFwBxkqVy4g=;
 b=mUjyl/yMVNpGW/GJtAQjQcNXxRQkIphRp72HY1ikWGtGA0/xBZKaMBmB
 18carQfRjBDaCGNmNhx8u0o97GIf4uJAA3WFczrC2ZKleaWfgpW5kEwQJ
 LbI5Ud0R55Qz6a9koWe/TR/UABCPcmDctiL5KWCpyCqNlffNW6avNQ+Z3
 uVp6gr3b06wG4q57+JXBkovy4gOO5te+1Wk+oNU9Lbfo6rJ3E6GZN0Jor
 TlWJ81OdBidiCSJL4fhTlWpLDVv/qSSAoFojOsmfp8spKm8mb/b2p3FzK
 OkMK9ALBLBcuGZS7rl+EqEgsZqXIqoZ0m6quoKkx6toyDmKQ2zP6ZKBzN g==;
X-CSE-ConnectionGUID: U6yQMmeoSauXFeIxr9ouyA==
X-CSE-MsgGUID: KCHFtkiRR/yHcO58PBHxZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100720999"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100720999"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 04:28:56 -0700
X-CSE-ConnectionGUID: RqUIFNHMQ52Tx8NRQ8iZIg==
X-CSE-MsgGUID: GTYNGV1PTzq5oo4iQbs7bQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 04:28:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 04:28:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 04:28:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 04:28:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itkXBsi6ORnRJRXxga6yVZT957xJjMpcigwjSEOxPF3txrcoHEzhW8xPwaEbnmKmi+cDyem6RiVMETzoMCXw6YyvbTdmZUYcYEkY6t1K0Nj43H39E3znri1gZYQtUS/b2bGjdDyZbPiDfBxLRKYolRadKUF+4O6dYIW7/A3FhrImV3V7y3kopXHAmh35j+GkBYdRiyeMgC4dgpOKAdB2fwhdbo0XuFfm6iVsHtKDjZG1MekBMEFcMn/iCa3TZT/LinO8Qq0rw6dU2oiO69LOn0A2zd2XW86mWA13Y7ecNFW8iXdaSQNvvSLymLtyICBrX3PcaOiICKXzOJHkG/83qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6orhvdTQBZFdYhmjlFwSMZHxwlGrrvxY/OXgkxzLiIY=;
 b=XOSSc2GzDmbXN87D6hVa7PjaPz/Q1n1qX7LWm7PoR2oy9YN4dyx8eyH8WgJQ9q3uZ3fkBTEISVFs9j3Hgf7tdEDPauesjo0pfGfdEQ89z5Uz3yZtU4QCyA/JFN93upuBRmMLe71dkbIOH3zoIG3TeoGOLhpAY2ALsCFVj1/Gve2YAwMeD6f5xhjWnHerTMLEja1UPrutys4aSVOl3a4PxovN0cgoZ7Xk1q3FZhqNiqq0WYyxkxBsqKrDsTs95jA48SLxTDuHoGJ5eNAuI2NYu5v2+ynHAsOclJ6/pzdy/dHA56IWKgBHr+pfkxB+i98sMJcZhkX2hBBunV6Dr3fMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB7654.namprd11.prod.outlook.com (2603:10b6:806:305::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 11:28:51 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 11:28:50 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "kalyan.kodamagula@intel.com" <kalyan.kodamagula@intel.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Swiatkowski, Michal"
 <michal.swiatkowski@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: RE: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
Thread-Topic: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
Thread-Index: AQHdRpZw9C9AJgvGek6CTp3KJZif47bSoiUA
Date: Thu, 17 Sep 2026 11:28:50 +0000
Message-ID: <IA3PR11MB898619C38AC2792034B229C8E5B82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917111114.2148482-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917111114.2148482-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB7654:EE_
x-ms-office365-filtering-correlation-id: a9e70967-5bdf-479d-1d27-08df14aed919
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: 0F+qrKvDtP4AGoPGCDX0PswDtOKYtFA+qhAgfY4CUyOW+hwCse3KtUV3A/HeMCm4ko9DDLmex9jQlVYEGPMMyuxbD1rpZ40HagZI6q90vjIGg+oDJs2k5TriEpIdC8xUXrJ9Z2M0quMaBbuoEjDOiW5VF2U0HZiDck5GRbIfUhIDnLW64GuZmK10rn+jl94KMozkA3hA34W+Rx/OUtkpJAYrvUclStEkIUFS+43jA4XVfMpS00UCvvVqTfGyGvPMr3pS2FBQ9Z9EqPugkaCDK2dKeQq9ddgfj3SMu5d276XcjY71Nl5VoivrzBsCyoWwLUeqInt95rcr4Bz5OZb3F2y/1Ua3EeiR8Rn3l7UObxVh5i3jq8icSFtd9agMQciNB6swXxiOHklcggpafGG7uEsOEoldWZdSaLCuYSW9VrGep+JBdsODi3dCIfLVEnXoR+qbcXfln9rQZ1LhJKQt0UCCdBFEfnJW5VX1rm4zYuReb2ZJnywDukI2SVPihn61Ddgopchxaq+GQvWktnmCDf87ESFPMD8nwfYzDX8KTKItkMvpV5J7ClypQ0FBHyyVwvqQ8QlOc9jJvNZXnbv/mt5WgRKsqtN5+HGf82AQ51Miacrz4zTi/r5mZ2CxwZe1ph8kJoUyWiGLqiRWcCkagSTWSLtVXg5R2inQYdZ0LzGrp4cv1g4TVexnafae87an7b5yxWsZpK0XdQICCQYVnbxGzldzj4Qyn5zaUTa0Wg0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tMgeHSim6eLTdJKxUmv1ZtFpkHKCDqTvQ8KK710EEI6eTe1W9quAI+gDOcRg?=
 =?us-ascii?Q?/+e57/Ql234bIMsQ6IuNVsk6oF+G9yn1xnaLsrD0jcsUbQdpasYoArULNLFv?=
 =?us-ascii?Q?vK4FmwL11sHx/e+jQFTk8dexRo06WOoQg0QjBzcNid8blAOssquRKKcgrboh?=
 =?us-ascii?Q?7cE6FIQp0IfswZifFgGv0W6aHN367uu0m/dJjLA9pOBFGHYqsCQyyHeGLld/?=
 =?us-ascii?Q?fWa4y3nS9RpaYU++wj6G290nDBH+r8igRks5EfjM0qnJVKYV3DEsWHInZ5sM?=
 =?us-ascii?Q?GiZ6KkVUN+JHMtNcEV36wuWJ2OFQsdmw5ZtvAMHJ7SXkxgnTc+h7EYRkY7j7?=
 =?us-ascii?Q?IQI6q/TKM1qp3ZO1roiuojMFS1fjHzpSij2YE7DUkyUOeppiZJfqys07fdy+?=
 =?us-ascii?Q?DQks1vNJiOJQUisVTQtf7YGh0rVvxODPOrtGYovp6Ucj2ZSXQuRkpfKdW63j?=
 =?us-ascii?Q?ftZEMJZ1lrdpnW/UuQ/qbIKvBUbBKUzMvcEBxzLcahOFNuA7fIwJYpwOpQiT?=
 =?us-ascii?Q?PWKXZ+x2VIbh+Z6ovZ0PBgHwSdeLEVzYrUzSMhi+waYOyjtJifT0tqjaLT2e?=
 =?us-ascii?Q?qEagyXEcv+srzJWXgx38yDe/iQmMThmchQKD6HjBpmYOhMCUPsJWf4qMHc1m?=
 =?us-ascii?Q?nePg42fGYBqo2e53eChNep6rRX6uTJQ+Zs/TwU0pEfOayyVEybOqIq4AxrUL?=
 =?us-ascii?Q?oLljsoTtVlMfyWQ0wBT32GC4QSqXS2JA/UuE+3eHoUP9v0dEnyRzLZKQdaXR?=
 =?us-ascii?Q?oBvgdyLkCkw4prQrcPh5c9I0bPkcoouVNbUEhAxQBpRmafzA+e/1hkvNk6hi?=
 =?us-ascii?Q?U5YTaA0nbZjGUGfKPaSu6nkHWShV9Kkv2/JwyNLiB53aZ+K6XSF7G4CJ5v8V?=
 =?us-ascii?Q?1Z9tFM74kU33XvoSrH5a/Eq5LmjPF3jCl+sPE27FqnPcNCKSFE52Lcm9/shL?=
 =?us-ascii?Q?BZn0CAHJB0u2PmbwvKKjazHCRvaYkz9t1OMvKQjAmncbXg8jBwqBLyuktPeW?=
 =?us-ascii?Q?q1dht5QkW9Qgul+uevxqeEmqanDhzKvOLiYsLdl/bhr66XJYfF8zbxgEJDKW?=
 =?us-ascii?Q?UW7XsKnv5XZs9gFA5jdcbzMW3WIJtDipVxd/BsIkMkVgdDr4weOiOIaS1d8V?=
 =?us-ascii?Q?Gb4HwTL0M6/awWwg8XHR4McgrliGg52jINYgKZEWJidb52X09MbRcb8AXIes?=
 =?us-ascii?Q?w1iCy4f2vv1W3v9g7M7+u4QRnO34jgvjvCQkL6cuKHyUZVynHQbAhee5JU24?=
 =?us-ascii?Q?f+oPdpCWBrlwO1qXmwNdtUgyTHhOznNDF/17HysXKiNeLvCtFdhjk5jH77bK?=
 =?us-ascii?Q?xulCGsE/+M6n63yuIuq3rCWqNN88Gu1Uvs3oFgJdP+xcMsspipghZqHyEayb?=
 =?us-ascii?Q?BjArBWDUoXkZlbecSQiv97mNARiFUw4mgSa7B0MjOtgKhpUON6pReZlojfrj?=
 =?us-ascii?Q?BiM7FM3IiuJV3yi/7WKt0O9H1Iv/t/ADzsTEziYb9IyxDB4PH7/Zo8pb9bZF?=
 =?us-ascii?Q?lz2aD5osZGa62OOhQzruiy1OhyyLEEVnH7IHrVJMb+PL4ZCyDYw1q0gOmnne?=
 =?us-ascii?Q?JVtsKcLhS+1eSqnZhJTbP1Y7t5IWkLh4P7TE5RoZNykqypo/M7IXa2lfLykV?=
 =?us-ascii?Q?Nbnl2Dm5Vj34QUUxuwiPQzh3Ji/bHW2pDgLJGcaGP2dbfN5abkO3h+cn2fbW?=
 =?us-ascii?Q?1DURijb4T1+OQrdVzg90rC2KUAeN4aoJbeFXLXOt99hCdyGlf9yQzhUx9tag?=
 =?us-ascii?Q?VeHZILwkwY8CrhgZzzgi2WBlIo4iP8M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3nU27Q2KXplEgx9eAoBTC7m8sxU0b4ln4bMv8oKMTnq3wvFGwSQc6p9dx2s/AafgUi3wzBmagUtmwT9pQj0kQmhHuCF7XCz8I9o2G+loOrdbvglutRBe/BLaYfLcVoZsX0vHJ0vZHrEZKU0wHTbX44wtubg3aYFH48W1C8t+VEZULy4HmzeOhgjFIC0ae2vRkELYJ2EQa1/E8O/g2a6tI2vkyyBZsb4JYQfnN2/18AvgYIhDYYIYSpVmKJTokLh4yu/KdkbeYSkk85B4rsvv0cE+KqDGs0cta0LKKy22De8sneQcq20Sw8Ta0cZi1YGrmDfhiZ7400nG83qBTdYWYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e70967-5bdf-479d-1d27-08df14aed919
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 11:28:50.8326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ROvj0xD0JmFWH7Ohvg2dvYKGB52K7NYrwwjJW0Zqen5RrinXeo92KGZwJlUS1EV32TIIzhnOi9k4zYHVYHBBYGpx3jqoNvW7u2dIY9unUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7654
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
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Thursday, September 17, 2026 1:11 PM
> To: andrew+netdev@lunn.ch
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> davem@davemloft.net; edumazet@google.com; intel-wired-
> lan@lists.osuosl.org; kalyan.kodamagula@intel.com; kuba@kernel.org;
> linux-kernel@vger.kernel.org; Swiatkowski, Michal
> <michal.swiatkowski@intel.com>; netdev@vger.kernel.org;
> pabeni@redhat.com; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> Wentao Liang <vulab@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
>=20
> ice_get_vf_by_id() takes a reference on the VF, which the caller has
> to release with ice_put_vf(). The switchdev mode check now happens
> after the VF is looked up and returns -EOPNOTSUPP without dropping
> that reference, leaking it.
>=20
> Use the existing out_put_vf label instead.
>=20
> Fixes: 83b49e7f63da ("ice: check if VF exists before mode check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 7e00e091756d..202224dba1a3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1384,7 +1384,8 @@ int ice_set_vf_trust(struct net_device *netdev,
> int vf_id, bool trusted)
>=20
>  	if (ice_is_eswitch_mode_switchdev(pf)) {
>  		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in
> switchdev mode\n");
> -		return -EOPNOTSUPP;
> +		ret =3D -EOPNOTSUPP;
> +		goto out_put_vf;
>  	}
>=20
>  	ret =3D ice_check_vf_ready_for_cfg(vf);
> --
> 2.34.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
