Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03402CA6018
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3810607B2;
	Thu,  8 Oct 2026 21:25:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E1td5rKauOGA; Thu,  8 Oct 2026 21:25:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2BCDD6082C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791494720;
	b=Gc6tQS4NT4aCGrRNXq4WKK1fNzXbiaoV4P0v95B2ixHSHrtJ2uCq+m0hKAo2tWhWOwaD
	 VV5+dRmBw2tSrFtz1zh4PX3JE72xV5KYMTOeNQNEnAD4PX0YhfEd4bGOmp2NjvwMfTX+l
	 hwGXPsjdn4BB6IK/DHvj5C1P1Yi/MOag63pBOd6bdbuuVNyj3Ocd1gsWa2cW6cgHFhSCx
	 A56Y6rMHIkIFxEBxcawdfgLXV+nHiN/CXAp9OKgg5NUxkVasLg+NQ4Q0ArRoBKOrDSUr4
	 7rvQ2fSfli+zqu5YNLPdpmDlYvbfMjTUAOLMthN/BI2uRBPxDWXrl5FSDFb9uSPky2g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791494720;
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
	bh=+WCZ81zOVxkxMxR08q4MPoIRNlVgRvALnkRCCDLdzGQ=;
	b=IRtKJlTiU2coVIB8+xsFK0b6rseHgilnwCT1m7LkcqHTCbRKpKFmoFBkQ4may+JppILH
	 5cDYi4J6eMjeeyNkvJ1njPE3KD5v3wDBacN2q3T3Hi5S/vYZmI8Dp6Z7EYIxDa9G6i2OA
	 foeE2Ev2lrdjhpr97PSTFcrDxNZ/ZULD+Exz+JbtT4hGVBltx/h72Alze1f7r3WZgo4Pl
	 mWPuTzmODy1Cnpg/8VbWlfFihSkljP60TgU+RkWI7wroZTStOIAarpqkMcOlN939l1afz
	 hcLiOALQ4Mij7v0kX8yEjE3kO2gTc5Pgc3voRFIw2JOkkFsTbv5J+ZWsIEYRMRcJz1g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791494720;
	bh=+WCZ81zOVxkxMxR08q4MPoIRNlVgRvALnkRCCDLdzGQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sbx3BIdPswzSviFyONGAhFtFiRug4LZL2aAzmbWDdAxW8KJSpLE/Jl2k2ME83zUfV
	 pTtFfFUcJ4fDtBOiXGZupsZh2xyPy2NOycrOuob42EI7ti7WMeSks7bbcRZ41RnSkc
	 P5yaY9jC8jPLWmVicHQhjk25vtnOHj/TS6xxNXc/9hX9KoUDa4d6zikWIqFhpdc91K
	 XyvqnzyQ0UcfHMG+tBF22jhJ6Fv6G/ZI/VEmpsn4LkQ4hEEQ48lmvfBDdUHYIuzfXt
	 31BYqWuVLADGRMUQ+JAne+jtcqiDA9yVazMtSLeev5rrB47gAWUDQsbgBScydLZOA9
	 l9YYROAMZF/7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BCDD6082C;
	Thu,  8 Oct 2026 21:25:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B58C2B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D0F14091B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:25:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tpf1KmDkv8Bm for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:25:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9B18B408F2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791494717;
 b=JEFvTp7u3B5Y4+lhroqjsulsXywLvyrcORIxnfL69jGw+Ppg7PBM8ym1DKDoUZw23HKA
 N3wm8UqiED+jYF0gExwwmtE0oFk6G3Qml7dvcHPyJpWVNE8rcIPwKochYIN2ifU9PJECO
 Sh1oEjvarOv9OrsQG6QbeEBlfWFNYHiAMrQjBcYHoN+kl7sY7sIvFVu+NOj3gbRD/hFMx
 GllC4+J3jROzK8iutoFAdyAqF72r092HOE/lWYE5wcLf6lIini1pOsBSt+uUnPz/qv9+t
 JDmktW0uAyshv/+ayQb+88B9kDyv5yhaQJvUI6lHfOphR7gIr9Jowtqy16U5DGsqMog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791494717;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=+WCZ81zOVxkxMxR08q4MPoIRNlVgRvALnkRCCDLdzGQ=;
 b=Rbsus13z34fWINN6d42K2jf02hATBDoZcsdb429JHeUWEgcfhnt938syop0Cet7y5IjR
 q2MQbpIMCfDjv+DyVTVGNeAkACwA6mFt4V8IqmbfK+uhq0bNT4XhibjwNhvCcGiVeAYix
 OZuur6rdGAclqXbwjSnBcR5yY8OaeWIu0bQRyDvS5e9LxIUhKcPbOXTP5ssCmryob9wy3
 AbeoUTt1nPjSiiymp4FkItxKIFFnZLS6lgSvpyvqelQYcr1zgE1rdczhShAKWQaL3P+vk
 xIy/P/3PTT1J2xu2EE/8EezYmSUoaE3C+xn+ZPnGPquUU4wq9UvOfwCXgLBCInZbkDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Rq6khHwd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Rq6khHwd
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B18B408F2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791494718; x=1823030718;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+WCZ81zOVxkxMxR08q4MPoIRNlVgRvALnkRCCDLdzGQ=;
 b=Rq6khHwdvcywQBaKbLwCY9bBNlzXyitW9KF/lvrNHwzzsVk3JJ79ptRo
 9xjybcwh3QQy/1VtQa7+JLh7AOwz89L1WCNncg+5pI3rSFaGYabqpljxE
 UM5kiY0qlpBHTnovI1smGCZsVQgCNth2LzlWibH0S9tXL3Uzu/sjw/b8T
 BQ7HZBFYNuWVXRqH3ozfeyFj3hBgegrH2XYvrKhwzAwLJ6o+OpqFrHNj1
 jjZ+2OaKPHrFOMRR6QIwKGs+u/rtIhAHkZBx9UK0UxJg6i7quMWH76ub6
 k/O1BEy2RCztB3Sr65r8GOXfOPeezlO1ufSQOEhgarbiTwJCZCDPkFj74 g==;
X-CSE-ConnectionGUID: Z4PApoZTTyGFefuVxzbg5g==
X-CSE-MsgGUID: nurRnewqQaSlG7jEohJsig==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="184969"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="184969"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:25:17 -0700
X-CSE-ConnectionGUID: ZZM2fqZrRNaFk+kbrzOzGg==
X-CSE-MsgGUID: /M9UtZ4ATTWQgz2SBqGb9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="145822"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:25:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:25:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 14:25:16 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:25:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dX2JzN4mDW7W8v05Sx9ZPtqNjKy1QIG+99FxiEQd8C28/QrSP7dpR3VlGHXPhYYbVYHRr8b2gh7vqyrxzQhsU3GGc21DZ4hMus/II+olbGhIoQqms+81zh59cjwm5f/wV+FZl1MgZrSAhJUFlzsf2rBRMS3NbPNYjac3g5exIgCqJk9RIsebX4vhxJCEysKXIiwh+0bYW9CbaDVkPwYHv1s3N6iILbmiKA4aJYCSf815RCoOW9UDpdghzWQHxoqOvrwriDhAetQ0qXwhDp8GCss+wHB6SQQ/BM2S5i9vgI9feL8j8ZTiHe26Z3XQYQqS8xwar8cnatX8D5mtzk76yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WCZ81zOVxkxMxR08q4MPoIRNlVgRvALnkRCCDLdzGQ=;
 b=HBAudT1zGXx7jzzzMQuj2Wcin6gweXEP/lJDqnH/L7GBUVYsKsSvqGHuCUSJrxK2vK9EmG13ExBIZH3irjpx5KB0EBZPSbFM+OP3cXAVyWf5MuKDFCeRC7zuydxdGaO9LSqNEfrB6k2zZDfn30151a2hl8Mlx5luslFC6L8KFzr5XAUhqIqg47E76uJDL03Jr/KwAulu6ZvKwtFgpFDZw+HJKZEvLwQ7YwQS0THUsZdeXyiTaDSJn1NAGNEs4YkVRK32M8tMAQGq8pbN6c2CfsR8hZ/zwb/JgQ5rKOV6hnj19vK+eJGVWy8HP19QdRbaodRbqz3f+EY9/J3LW3Z2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 DS4PPF8ECAFAD61.namprd11.prod.outlook.com (2603:10b6:f:fc02::3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:25:13 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 21:25:13 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Zaremba, Larysa"
 <larysa.zaremba@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>
Subject: RE: [PATCH iwl-next v2 03/10] idpf: get rid of msix_entries array
Thread-Topic: [PATCH iwl-next v2 03/10] idpf: get rid of msix_entries array
Thread-Index: AQHdQfHbWKurkn8Vd0uFwTtJaofVc7b0UwfA
Date: Thu, 8 Oct 2026 21:25:13 +0000
Message-ID: <DS0PR11MB6422498367C05D01E7AF80AC9B932@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-4-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-4-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|DS4PPF8ECAFAD61:EE_
x-ms-office365-filtering-correlation-id: f562c9f3-de4d-497f-03a8-08df2582a3dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: oPvM3cdmXleGFxiMrMpXLuQK0R54r/2q3V5HoBNXTrx2v0V8Z0OAhsrhzhszeaoUGce9eL0ec9W7/KcuD/818sIxCAtebkj9ScV1S8sThyoDtNPbslxQ+Dlf53UgrBY7doR0U14X00wHtVlk7gH2e+8Vuid/e4wDNfdbZL9bEmhL9LMo78OcoBpxKPY2l94B3s61CX8Gj//S94B2q0URZL2luxhpcC7zhlu4R0C6ehWsIPa7oU5GrsvV6UfMOvx8EM6vUj5BLCsxG+xi49Jeu8scxSlCivZRvhxE9ZvFDgzeawW0K6dVl08bqG9A/jZpJELpenGwVnX0gnfO31OxHF28djjjPJbKHzuPb3rQJBMZXV9dbF0S8Kd7W1HQo1jfwYa6Wf3f955B6a63B8VnSt+tt2NEpYKy9VBIIx+OsoLAnRPUWVLRNdXQpCMfz8+2dPnWBnoznXKy8tyVgNmZkLe/rBGE3U0mna/+qwX2Cj0iQZrcij7ZjjTMicDRmkcc4BnIOygFW0bJLktipwNnKk4B3aJGLcEVY78ME+PiEEfogA5ThjsIT3v/6ShxX9fQiZn4vGOnKELQPUwcpdqGAsGRSqMD9PQtyWvJxOmlirKr2NCywUfSsQQpBS3KaPwhtcADqA8hiy8ivrIcYN1zE0bzT3qs1d4Cd+S2ElWq/jf3qHtRdr0d1bv5f00/OPp/k8N1GvzjrjB80ROw4wvTyGh4SeC5DU7qydDibq/ig3s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6422.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lgusea5maAIOya4xb7z6m2DRBZnPt67sdXqjYKi3tl6ogBYJo1LDSzw/sSSc?=
 =?us-ascii?Q?YaF03GNKfBijecc5gRC8xc0NM+DoD4hVRN51a1vv2nstSXsWm3dYFuDrFeAR?=
 =?us-ascii?Q?SQw0k8WYTnwohxnLEbC7R3G+K+3d7aU2UpCwh9ZFHu4SyJps00eBvA7TMZol?=
 =?us-ascii?Q?uOTFc0vj9neNpgkGKTm+e9BC2PW+oxnqcmagBUThfb9FclZBQ9QslJ45aX/L?=
 =?us-ascii?Q?04EkpZudpPK/bmxj9r7Og4iSliEHcgUM/A3CbkiRYlFeJKRDl6YZtAlmKkrh?=
 =?us-ascii?Q?bZeZORBxUQoBKyeIhwwMF1mUsG8XGSYDqMPXpBiJzbbUh9IrpCLFb6JyLRSp?=
 =?us-ascii?Q?Oy+5JOwrwj/o+WAzkexFijkOI58E940gFRoP/weqTX9rQs/KFOHsca1JM4W6?=
 =?us-ascii?Q?SeanuyH3+tIyVt2+wDn7/d2ZJnFoGShHVXqRcHcIMYkHMaTuVhOdeIe+2Njz?=
 =?us-ascii?Q?Dji1vLJMuPoAmo7+UR6Cbg2TrqsG+/2AhOS3MuABC6NWUV8apch+WVjb2voA?=
 =?us-ascii?Q?dPcvGV1rpvmzv1qinMURN9V5Ge+5vqZ/KpfP6rM2ufxAV04ILEi3KHBXS/ev?=
 =?us-ascii?Q?Evy2AJ6Oy5h1BymGcNUvPF++9cZUd47ViWMYjJT7iJi2TB4wbquaBFNFWWBJ?=
 =?us-ascii?Q?zt3X6Rc6FHeyoCnc7KD4mLn8RSUKcmhjFYMgeFN1BXJfhqjnyHFfAKnv84Q9?=
 =?us-ascii?Q?BLUJBZ/MPEiOLnsov/bycdX79hwL/Dd9t9AKws3wbX50sCimODfq8fefDByE?=
 =?us-ascii?Q?hAhrPRc9iN2Or/GBMwF2RDjE5ey+LBl5Dst8T5Wtq1yKSWvlTjYwuAvapS2n?=
 =?us-ascii?Q?HK9NXGg+flp7zfyNTBW0OZX2q22rB0SBkpLJQeHL7swyXk78WDuZkVFR/K//?=
 =?us-ascii?Q?4NzBHvFO/Y0J7LoYbqixAE68qUR9VvsIlMDm1JxL4OLKIds7WBo6SybFUwPI?=
 =?us-ascii?Q?I+BPno+Xy1yHuexc5cPPBUl6TSWw998PcGUxBKRziK8eRFEt01HOKyEQhARC?=
 =?us-ascii?Q?Y/wvCNt76+mRjzchOd/3J+4fhkScBsyWg8ukFoZ1d8kuGCNlBGHrUIS9zecB?=
 =?us-ascii?Q?hcyMNp5dwnHBuL0iPHE20yrfzmZrhi5r2Sb7ZEzGmnkzrB+v2SC8zfiuiCt/?=
 =?us-ascii?Q?XlkRq7U88NzL5YEy/7Tr1jToY2XDAudzthIQHpfH3NFn8smmKDuPBiK5M+ME?=
 =?us-ascii?Q?ALlvltaUhpC6FK6t7jjoyzzrGcMngJ3L+iA+ec+wU2dCxpwc4hb94JtIV8Ia?=
 =?us-ascii?Q?gc/RdfVb7KseCu5QwMuUMDi/QPGkPqWlxVaXNQs9komfIleD5aJaaFZEzGqC?=
 =?us-ascii?Q?8a0RbjYJ+DAhuXUXBAONyOseprUycEKJdBtQCv2o3cS1wCl2zyd/oB59ulVH?=
 =?us-ascii?Q?eIoXA/xpTgImAcQ5a9RAHhvBx7Ahks70fQ9F7myNSBKG8MiqAH2B8/L55WFR?=
 =?us-ascii?Q?+Jhzp8G2K6Nrnps0AYeUv2PU1foo3Wg3mOG3X7pzMugn3uTFIC/ao1APWnem?=
 =?us-ascii?Q?HB14/dxlmdY0EnesY0Nm1A0b18y3RxIkxQiS8r8bozcSzKd5vmGbYB6mfT97?=
 =?us-ascii?Q?vc48dcQyNP2hG4iiPKDmAybv+S/kzEdndHmM0GNl8N72mJcjoHd71sntYbqG?=
 =?us-ascii?Q?O5jEuhgio5BYmoO3RIE6GY4GVmPVeY3mn7rXtqIoRK5711GuKsNI0KZSUb7S?=
 =?us-ascii?Q?DDw74dSEk+KaOh7tSAWsqg7cnnXq8VQRjEvCUdX92ZzPffC4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pnVHLxkZ2/Okh0ApNnyher43j6REvJ6USJ/HqfFY6A8exWWqVId3oYGjnRf48VpryMCFU9+9kfGadiOnGEQkiJb0EMKtMKC7+CiFlN0rsoeQbQwSlYZUoptVnqoEVIXARdjU80i4+8Mt58M55hbPKfp5dzOL7M/t5pG7ZjCHrTw5TV+E0PNRvsP0QWtJXKN3LKLNUL1OQj1zfd7faiQrrH+ZYqoRSh6tPjBEvE9XdA1PeK/UdbFTGtKnEZzKMRGKAPspU7v2N7CQP68ETa3sALGLi4vxPVDLp9jzBKuwztxhWnxXZEooCNPJvdpuPdWStiImAVLSuVyqK7RxZ3JJ2Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f562c9f3-de4d-497f-03a8-08df2582a3dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 21:25:13.4840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJN5xFH+Ez8MG2UBilN8EA+CXhS3yvyGvzxEd8hIStSJfr1/r2DmLeVPdRYoIIUBOTNP5Jml0Z3ohg3QpW8M2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF8ECAFAD61
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
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, September 11, 2026 5:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>
> Subject: [PATCH iwl-next v2 03/10] idpf: get rid of msix_entries array
>=20
> There is no special need for storing MSI-X info in one array. Instead mov=
e this
> data into q_vector where it is commonly used. With that one layer of acce=
ssing
> correct kernel irq line number can be dropped.
>=20
> Moving pci_irq_vector() after q_vectors creation will be useful when swit=
ching
> to dynamic irq allocation.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
Tested-by: Samuel Salin <Samuel.salin@intel.com>
