Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F18C79F82
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 18:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DEED80A84;
	Tue,  8 Sep 2026 18:01:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UKAN4lQYgndU; Tue,  8 Sep 2026 18:01:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 71ADD80C88
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788890516;
	b=F6HI7Xy726FOZKwBvPpG3Wt/7R93MzDJovZzxZAi1WVKFQTZrJhQA3bBGCVwabdC7CdM
	 egBNZj/rK5/O/LSX1bj6ROzOBRSCssezv183aGGI5C0fbjKQcIXZjLlIlRl1fUEc/HJs1
	 DJ+g8kts7+zTX2P0F7pMECCoUbN1KevIfnWqjgEcRC+NoaqL0Z4hCnGncn+FA1W/VApax
	 08JWi126EbwqVvUjJYsdddzroojNZv1HszzC8jOFSXTb/NzBFcK9ciW8NEZvHlnwDE60n
	 1uKoenV20CFhGXUalxU6aoAPp4llgXxiUSqCNv2VnWk8+QKRQB6dQWAPR7M5qZQ7cJg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788890516;
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
	bh=5WYIr2IFYpt913WYsvpU1Tqk9UVkDebfCtGDeIIq8kg=;
	b=Y99mJF/OAVSag+62T3k/a9oKEtlu7zWwRgXTxaiFZk4dn9P0LavOweJr+LqILnIIeE8q
	 3MYap9QWCJjICh1WY7JOmS6UdrKYUjQ9ks2y3P34GYJhn6CUS8cuQDcoblvxTOrz93cbV
	 StZo+moX1Gxb9bV+cQXMaTfMKry6DBRgA5T7YTBrAuyA8OmxGWGMYJuRsMCBsuBfJZr4h
	 2Vw6sKSCkAH7gG+y+o55/DfZCHJvM2Q8ddM8/9mfpO6LxktWVjTxESfgNLGihHAaE4Hnt
	 ZYiLieysJ3KBJ3fvnkPq4t9ig6zkJFmR2QOpdvY18o9AuZHfhzWJfI/BjOVk6lYsgGw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788890516;
	bh=5WYIr2IFYpt913WYsvpU1Tqk9UVkDebfCtGDeIIq8kg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MvPN9/hp2q+BjqW7rS6XDTTbq5ETnlKfOP+VhRaGhbcwVmZAx5iR57AmNRn9lAc4N
	 41csECtQrMMwAT7LPC7x1HncvQRb9Vi/dQ617D6Y2xZgWthw4HpER62GOFE9cXifbK
	 XTNbAXk/mQYnTojWIuw50TRvWaPIe/TdNRepo1lidiFpFiZ8r62reV831IoRHWVJC0
	 s9zXPB97f6Q8Rk+6jHEUmvaQpyN2Uhp6xQ1/tC/dirxCjJEBWZZJ5WMY3byBWtYsMg
	 TkD55dz/qC0uP+QDJmvAX3NPxG0TCG0XM6vzZmjswFRHyRcincGPKx7OWk7uDqxq9Y
	 XhC4v6l0J37/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71ADD80C88;
	Tue,  8 Sep 2026 18:01:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EACD2D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C84F40670
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:01:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5UzuHQYJZD9y for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 18:01:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 82C9840642
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788890513;
 b=O/8mwRlqkLELrePYZXm8wlmWezXHfjN7g6ls2/NOfeR2TnodT6xIx1GgMC+3lYjVi2hI
 yhUgnKd3j8Suq/+IkUssgLd9XQZiIuyXcEG2SHFjIJZNy85uavBhZXMLtVSK+jPdYtYkF
 ol0cQ9q6QVj4wZsCmTN+Y7tCTdLpYFpijBCRdVboxo/X3k8GLyOlsdLPH48Gtpk96tlp5
 aAuWseImHdnnUa5WJJntl1wKOJpCrTW1MuMvSXyx6mUI9PyjJ09m28T4Ixa3jngeDsia4
 RTXNl4bpFn1y1W+K5OTLCtCTQmyjcKNffH7/vkXJi9GKPcaSy925Ci4fzbCfl32EX8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788890513;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
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
 bh=5WYIr2IFYpt913WYsvpU1Tqk9UVkDebfCtGDeIIq8kg=;
 b=Le+I2z95ZX45FlExFbCL2GQ1KbmCOJEdhNF0+En/5YLTm8VdsAFdwhlva1nKScvCeoNZ
 fTff/KLUgRwiFngXSSet793jjn+nFZvx9FodmYWvZJU3D6WSxIk3QJ9e7kqgNJpsM6cE3
 GxMrRWF/8dWnzFg5hjQbNwZtQf6R5cSJs9mHVR6ipDMqMdcGuCNiTs7FnEyPBl99U+IK3
 UeJMHW7zhjZkiBYuz25S3jze4nJzsD/hQm8zKrKeuub+Jp4ifVnaSJsdVrF2pU5iB+A+5
 HAzLXzxUjowNIhmzNch+/z+7mOFH/UozoLpe9uW5IEt7fmoSF902u1bJ1xiGVJx86yw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CCZme2bY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CCZme2bY
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82C9840642
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788890514; x=1820426514;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5WYIr2IFYpt913WYsvpU1Tqk9UVkDebfCtGDeIIq8kg=;
 b=CCZme2bYVyuNS909kT+GBfUI5u3bdFlOqxvqrYbdGH++Sxpq+tkpgQq4
 6ydrM8HdB6WmtGFKeiAZTHxh8HYxNG9rPpyj0+a6/eCSqUNut4N2ydgmA
 rSuGeNCqKS88LD3e5MYMf+FmoSFS9w+DpxqwXSWLcsB5LR0+AntHS6AD/
 5RfIpAXGwOzdCUgTMVfAeRy6qrzGg8VLo1GUwUOfwRowLyvnweTmZaJUM
 WzoZ32NBdjXwdUnJIk6CxVCbYSsozhXcYAhWTl8Yhcz5JvcOGILDr6y1A
 rjX1PRLSwlE+SMGKEATfJxylK/z6LKd1xw42ZAJB+XlCslZ3x4+ePV0Vx Q==;
X-CSE-ConnectionGUID: QkpfmL/LSM+zsEkxwOuqMQ==
X-CSE-MsgGUID: mnm5UhOzSdyQ7wG3CBvIbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106819338"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="106819338"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 11:01:28 -0700
X-CSE-ConnectionGUID: 7Uv8ZhxnTTmHD39+YlPGcw==
X-CSE-MsgGUID: DezLraJEQSeqQA8cWCiiYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="271052047"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 11:01:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:01:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 11:01:27 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:01:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrLu94S34WQAOcDfpsT+UAeCXCQX5yaPbSJKdeg0IxytfykX+T2VDa86xBr0WSOTQGbGROExaF7JicwAIJjNUJpOY3PlCspz5ElP1MykU82YH8806KhhgBzepeqhXspcVAdOoAkjnM9kke5NqvpfESFgrB3hiCc+kBQ4OKho4zihK02fh7YSiZhtgZpg1WRvejQj6KU0WnmGN/tIeTrsDIbyTVJs2OBkWys6uhk4VzOjzEp2fjbBU49glFOPgp8UzveM/y6lN4ry5d1RROwbbUrzJZwhklS68U6vsJoZw0WTCw44EEpkfSTqXLrjNz3anUDs5cc6XXP9MJEXBdJCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WYIr2IFYpt913WYsvpU1Tqk9UVkDebfCtGDeIIq8kg=;
 b=nRP4ZZAs3bPzjfwY/2Kt7UrNCFaQUGPzuSrE/TRRNzFGwZOsWCOcNBHz7FxkCOidoSaqjPxj8G6q8lp7TtO8KS0UOvPChMwUdUAHcZvgemBGR35PwJDLbiPmc3s0NIScEbWA/6B+VZIfCftqwr7caUXipboM3iKUfTcgGjjGgFHOZdWWcdM5Zs25NFFR/dYxRO78XPc6A1AciZSXGLBhCI0pPJtONuHX9sPfc2JvZUXGBGnYJMA4D76a5I5jyhda2iQOtvLbapj1HWca/GaUXMh3U3Fv8VREDOAfdyS3EsGQq1ZZURXJAdZtdWpX6ohx2TMVvnTlE13/hJ191OKN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 18:01:22 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 18:01:22 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
 "Cavatur, Ranjit" <ranjit.cavatur@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v2 01/14] ice: use reference counting and RCU for
 PTP port access
Thread-Topic: [PATCH iwl-net v2 01/14] ice: use reference counting and RCU for
 PTP port access
Thread-Index: AQHdNOTMLpJd5ne50UeEokqF4faXFbbE/Pmg
Date: Tue, 8 Sep 2026 18:01:22 +0000
Message-ID: <LV1PR11MB8790D9B801AC95DA6E81401590B12@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
 <20260825-jk-e825c-minimized-fixes-v2-1-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-1-8223f95d26e3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|BL1PR11MB5255:EE_
x-ms-office365-filtering-correlation-id: 9b4bd416-ce28-4bef-3402-08df0dd33149
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|6133799003|10067099003|22082099003|5023799004|11063799006|4143699003|56012099006|18002099003;
x-microsoft-antispam-message-info: fKBs0LFGrTxUox/wvYUKIcA4LjT5VTEjXsthh0X9uAiNfloRWT8nAZWYczy5zCbWGwVpbF6aNeMXLmm0Mz5u6FUtScT3XQAzFOn0kfhSGJtF6cVRgfAout3NPmDKOc5/98K4peP2KoewzwmO/CAJAcC3cE0wg0uQb2IxQ6glU86sE8lWeR4Osbjbq22mObW695Fk/CRKPeWGrGwREksc+GwFuR57NcRcus9S+T+3HevkjfeJsaSk9wgt2+wSrRzFkIdguTJemYOwUUilWqPeYHGkNj3WOiMEUTwsgAiz8ldZs2E+ymQXr0t+z3EgOn/6PgTCwoxVm7jn1tJ+WByOwa9tHcoftuNpA1Aj72RvvU3aJvOJbySpE8R8LHqSxzqINcLvJd71/V7Arefc2WyXueZgPsXW+e+LLnhX+jD8SGLdL0z2Y8qkrrLpds/b0hOfeuoPbCG6sUZxM7bhEqeOVOYmwWR75DtkIpdb+78Zdv2Dxm8N+JtadZQto8jbUxXk/UOsrM3sGUYvNHYZOXYi5/4/Mum+uPkV3bPSL+DbdCAJ4Q/XEm7w3JE+W6gjC1OJwf4fsgCApp3ZhlxAYi7Zfb3b7f1+XztQoNx41jbfdAhFhg3O3t5LOpkCd7KqKgmbdUaVuhUfAuy/nytQ25lhU4ZzvCpZOVhfbrkarp2zAI29w4qPkS1oyq//3m7g/dD7uojQ0pV1Fi39CKYvfIngsGl/2YAT4bONVV+XrV7sPt8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(10067099003)(22082099003)(5023799004)(11063799006)(4143699003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnNCd2IxRGROQUUxQWdjOUFVK0VKWmp6U0Faa3E5bSs5UFpzYXltM2doeCtz?=
 =?utf-8?B?ODBseEltdk5Sb0NRakQvU1VyZHVCeGxDV1Y5VktROXpDck5Da21ZS1BjSVZC?=
 =?utf-8?B?QU5ySHUrNTZnK1Y4QjcxNlZ3TmxFV3NLVVZCL0swSWNqczRxVlVhbldQdFY1?=
 =?utf-8?B?Y21ZR3BESFkxNFBFTXlQSk16NUEzZUN0Nm5FTXBkaldubHlCVHpFR3RyMnUy?=
 =?utf-8?B?RTFYczdTc2sxM0lPcnhxeVpGaHJvU3lBUlJuc1dyT0RlcjlYTU53eUVPWE5z?=
 =?utf-8?B?TGhXVlhxWkhXaW8wL1k5WDRCei94dGcyWndJUVo3cmpoV3AxRmpTaFg4bFhV?=
 =?utf-8?B?bHNKZVJOenJmazVWYTdtbjExcjArTGhRNDVGQkZvK0x0NlFLaG5KWTIvU1Fx?=
 =?utf-8?B?QlgxUzFWazlyV0pYN2x6VjJxQ1JheG4ySXV3NTZYTGI5QkpEVGEvQURTUFAw?=
 =?utf-8?B?SmJRVFIrTDNFaDZBdUxwbWFmem5IWXBST3BjUzYzdWdIM2dQRWpMMjJLcU13?=
 =?utf-8?B?WGpZcDhCbHBIc2U0OVJVc0JUTDMxU1N0dkhtWFVnSzBXTXhUTDZsb29sWnBY?=
 =?utf-8?B?ZVhrVDBmQmFwMllkRldRWk1zMnZjTHlXanJTL2dXWFNYSFFlZkQySHlEUE5P?=
 =?utf-8?B?cUdQUzhKRG93Q21EMEd6dkRXUGk3WmZwbGUxR0Z0NXg2S3cyV3N0S09CNkpR?=
 =?utf-8?B?UDAvK1dMb2NMcnBtK0QreFhVUW96eXdTOG1LYXpwTFBweVl6ZmZ3V2FhVWtz?=
 =?utf-8?B?V1d3UHJzZVQrT09IR1VLQ1YwRmdTL0tJWGdDRVgwZ1RpNWxpbDFDc3FUenB4?=
 =?utf-8?B?eG1CNFpGQkpWWlJWVDdZV3pMU2xKTGVWY1VYVWRhM0pEMHVVaUtZWFVRaDRI?=
 =?utf-8?B?dGRNWjM3WGxzQTlJZm1YVW9SNVhySzJHNDR5VkpWd1pJSFpWMGl4K0NydXcr?=
 =?utf-8?B?dUFjek11cmZURlRJbFRuTEdlVEI3T2NjNElKODFnbHgwMEV4RWZNam5QUkZB?=
 =?utf-8?B?Q0RyQThYbmRyOU9Uczg3K0ZOY3R1ZkRrT012VGpnNmhjeE8yZ2EwQmF1S2Ft?=
 =?utf-8?B?TUR4LzJJSUhHdHpUTlZyQnNsaUxxOVM0Q0NiVXluaEpNYTR5R2tyY2kxc05T?=
 =?utf-8?B?SUNOdzRRcGZOczB0T2lmK1pnMVlMa2grTEpXOHpZQkM1MTA1MjArTVVqTGQ1?=
 =?utf-8?B?b0czVWdZWm1yVDJtcmxoSElJWk9adjFpbEZEdm93bFRESDd4a0pTSzJPYnNW?=
 =?utf-8?B?QWhuaTk3ZmcrTlVrM0h3VUlZV2F5dEttdzhFZktZczg4YXdTQi9hVkpFUndK?=
 =?utf-8?B?SVRHUVZXN21IMzk4U01jNnhpNXJ0RHZOWTNtWG9mcWlaaTNOSzNYL3V0VlBa?=
 =?utf-8?B?REFhNTNsMEVqZDZLNm5LbHJhS1plNDJCY2xaNFhOckowdXpuTDZWL2JLNVNG?=
 =?utf-8?B?UVl3eEY3dE5pbDA4YTVYVUtpY2dGZjI2MDNMSzg3bVpiNnVCWTdlZ05OUzZ4?=
 =?utf-8?B?SkxOb011VnZENC9lRm9nT0M2R0ZaTlJPV2tZRFQycHp5S2tZZ2htNWR2eEZv?=
 =?utf-8?B?dGNtNVNvZjhZUk5KdTdoMlBKdVdueDJ5UnpVWVpjVStITmRYOFczOURxNkli?=
 =?utf-8?B?MGdjcUtKaEY3WlUrM2Nzc0laMnU5cVlTenNOaXZjSXJJZk5TY3RBbUpMVE1l?=
 =?utf-8?B?YlhXVWNWR000WnhSK3I5aXhmVnZ6Z1lEUEdlUmJKNWkxYk5sTUV4LzhDUHdx?=
 =?utf-8?B?aWNJUk9sYjl2bmJpZnp3UWl2eEVuUkx0TDVncjNtdjBQczBCQTRJSXdTaHc3?=
 =?utf-8?B?SUNwNzlTWXFXZTlBY3oyVDUxZmlyb0luekJoaGtteVpGWGVocE01K0x2WHJL?=
 =?utf-8?B?K1VwMm5GQVBFcnVjR2M5QzdJRlEvQk5hL295TFQ4OElCdHlpQlpuempWT2NC?=
 =?utf-8?B?bUhYOXd6WlZmUGJyKzg3R3hxZXp0c0xPZUhCc2tobHFNYkQ1cGVEVTBSOVVt?=
 =?utf-8?B?S2lxOGhFRWk0MFIxYzA1ajVuWlJNYjArcUlsRVFZOEN0VWJaWjMySGhObjRG?=
 =?utf-8?B?RkxqZk5UZ0lsbE1YMlVkeEFRSUJQbzBoUU9CeVB0RWQzT2EvYTZvdi9wd2JU?=
 =?utf-8?B?UXdyOEpEdjdOeHZmRFkwMWZDTGZld3BjUUtmUFNOMlI1dVVwVTFDbkV4alFK?=
 =?utf-8?B?MkYyQzl1WVlpTnU5S2N5UEt0RlhPSmJBcTU0UmVabHJiSFkyVXliNEYrR2hs?=
 =?utf-8?B?MU1UVFgrWUU5UjloL2o0dUE1QVhndzVscndHUDBidlZ2R2dadnUzVmM4WVhF?=
 =?utf-8?B?R2FWR3EyaEFvenF2KzZ6NVNScGFpMlcrT0xkbkdzbGJwR0RWRVRLUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZAcdc0hjzCje2uBdqgbCmXrONJwKboOP7qqmjDUcj9RLGwModblXOzmiSFKlfM5paBHX3+jVGYVEaTy7DKilHcExmyX/kH6PeSNsCH0vOmbgBD9jk5HnNi1l9qS2bzzTACXY+GEVcLeQhOh51P83OsVw/EEAUG+uiza/3jBiRMfAe7RUIy8xfdzF7RBbpxnOzrG88Ejf4Hdf72OR3YMR1650ph8ijSS0v5MipvIsbWYtDd5zhVoWL2JArs7NJ1q7iRHNAxR3I+O/JZTRGCIxLOgwqxiPb1lOL4BmAadMLqDOzqMLyUpr1i7jRxCATDIDjRstTyog7l0A1UgFtYCYmA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4bd416-ce28-4bef-3402-08df0dd33149
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 18:01:22.5491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8K9eVLOmVM82OTTFOSzPKSIRZ3wemO0bBG/xXjYrOldR5etVSbpvX7dLWsMLBjpW9vOKhsNPPu6YF4dEfBjzRNtOOlMpAywdNIsk+AejmKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWxsZXIsIEphY29iIEUgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNSwgMjAy
NiAzOjUzIFBNDQo+IFRvOiBJbnRlbCBXaXJlZCBMQU4gPGludGVsLXdpcmVkLWxhbkBsaXN0cy5v
c3Vvc2wub3JnPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTWFjaG5pa293c2tpLCBN
YWNpZWogPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPjsgTmd1eWVuLCBBbnRob255IEwg
PGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS29yYmEsIFByemVteXNsYXcgPHByemVteXNs
YXcua29yYmFAaW50ZWwuY29tPjsgTml0a2EsIEdyemVnb3J6IDxncnplZ29yei5uaXRrYUBpbnRl
bC5jb20+OyBPcm9zLCBQZXRyIDxwb3Jvc0ByZWRoYXQuY29tPjsgTm93bGluLCBBbGV4YW5kZXIg
PGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPjsgQnJvc3MsIEtldmluIDxrZXZpbi5icm9zc0Bp
bnRlbC5jb20+OyBDYXZhdHVyLCBSYW5qaXQgPHJhbmppdC5jYXZhdHVyQGludGVsLmNvbT47IEtl
bGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgTWFjaG5pa293c2tpLCBN
YWNpZWogPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
aXdsLW5ldCB2MiAwMS8xNF0gaWNlOiB1c2UgcmVmZXJlbmNlIGNvdW50aW5nIGFuZCBSQ1UgZm9y
IFBUUCBwb3J0IGFjY2Vzcw0KPiANCj4gVGhlIGljZSBhZGFwdGVyIHN0cnVjdHVyZSBtYWludGFp
bnMgYSBsaXN0IG9mIHBvcnRzIGFzc29jaWF0ZWQgd2l0aCB0aGUgYWRhcHRlci4gVGhpcyBpcyB1
c2VkIGZvciBzdXBwb3J0aW5nIFBUUCwgd2hlcmUgdGhlIGNsb2NrIG93bmVyIG11c3QgaGFuZGxl
IG1hbnkgb3BlcmF0aW9ucyB0aGF0IHJlcXVpcmUgYWNjZXNzIHRvIHRoZSBQVFAgcG9ydCBzdHJ1
Y3R1cmVzID4gb2YgdGhlIGFzc29jaWF0ZWQgUEZzLg0KPiANCj4gVGhpcyBpcyBpbXBsZW1lbnRl
ZCB1c2luZyBhIGxpbmtlZCBsaXN0IGFuZCBhIG11dGV4LiBUaGlzIHNvcnQgb2Ygd29ya3MsIGJ1
dCBhIGZldyBwbGFjZXMgd2l0aGluIHRoZSBjb2RlIGRvIG5vdCBhY3F1aXJlIHRoZSBtdXRleCB3
aGVuIGl0ZXJhdGluZyB0aGUgbGlzdC4gVGhpcyBpbmNsdWRlcyBpY2VfcHRwX2ZsdXNoX2FsbF90
eF90cmFja2VyKCksIGljZV9wdHBfcmVzdGFydF9hbGxfcGh5KCksIGFuZCBpY2VfcHRwX3ByZXBh
cmVfcmVidWlsZF9zZWMoKS4NCj4gDQo+IEZpeGluZyB0aGlzIGlzIHRyaWNreSwgZXNwZWNpYWxs
eSBzaW5jZSBpdCBpcyBub3QgY2xlYXIgaWYgd2UgY2FuIHNpbXBseSBhY3F1aXJlIHRoZSBsb2Nr
IGFyb3VuZCB0aGUgY29tcGxldGUgaXRlcmF0aW9ucy4NCg0KPiBUaGUgcGF0dGVybiBvZiB1c2Ug
Zm9yIHRoZSBwb3J0IGxpc3QgaXMgcmVhZC1tb3N0bHkgd2l0aCBtb2RpZmljYXRpb25zIG9ubHkg
aGFwcGVuaW5nIGR1cmluZyBQRiBpbml0aWFsaXphdGlvbiB3aGVuIGVsZW1lbnRzIGFyZSBpbnNl
cnRlZC4gVGhpcyB0eXBpY2FsbHkgb25seSBoYXBwZW5zIGR1cmluZyBlYXJseSBib290LCB0aG91
Z2ggYSBQRiBjb3VsZCBpbiBwcmluY2lwbGUgYmUgcmVtb3ZlZCBvciBsb2FkZWQgYXQgYXJiaXRy
YXJ5IHRpbWVzIHZpYSBiaW5kIGFuZCB1bmJpbmQgb3BlcmF0aW9ucy4NCj4gDQo+IFRoZSB1c2Ug
b2YgYSBtdXRleCBkb2VzIG1lYW4gdGhlIGRyaXZlciBjYW4gc2xlZXAgd2hpbGUgaG9sZGluZyBp
dCwgYnV0IGl0IHN0aWxsIGNyZWF0ZXMgY29tcGxpY2F0ZXMgd2l0aCBsb2NrIG9yZGVyaW5nIGFu
ZCBwcmV2ZW50cyBpdGVyYXRpbmcgdGhlIGxpc3QgaW4gYW55IGNvZGUgcGF0aCB0aGF0ICpjYW4n
dCogc2xlZXAuDQo+IA0KPiBJbnN0ZWFkLCB1c2UgdGhlIFJDVSBwcmltaXRpdmVzIGZvciB0aGUg
cG9ydCBsaW5rZWQgbGlzdCwgYWxvbmcgd2l0aCBhIHJlZmVyZW5jZSBjb3VudCBvbiB0aGUgcG9y
dC4gVGhlIGtyZWYgcmVmZXJlbmNlIGNvdW50ZXIgZW5zdXJlcyB0aGF0IHdlIGNhbiBzYWZlbHkg
YWNxdWlyZSBwb2ludGVycyB3aXRoIGEgZ3VhcmFudGVlIG9mIHRoZWlyIGxpZmV0aW1lLCBlbnN1
cmluZyB0aGUgYXNzb2NpYXRlZCBQRiB3aWxsIG5vdCBiZSByZW1vdmVkIHVudGlsIHRoZSByZWZl
cmVuY2UgaXMgcmVsZWFzZWQuDQo+IA0KPiBGb3IgcG9ydCBpdGVyYXRpb25zIHdoaWNoIGFyZSBz
aG9ydCBhbmQgZGVmaW5pdGVseSBjYW4ndCBzbGVlcCwgd3JhcCB0aGUgZW50aXJlIGxvb3Agd2l0
aCByY3VfcmVhZF9sb2NrKCkgPiBhbmQgcmN1X3JlYWRfdW5sb2NrKCkuDQoNCj4gRm9yIGxvbmdl
ciBvcGVyYXRpb25zLCBvciB0aG9zZSB3aGljaCBtaWdodCBzbGVlcCwgd2UgbmVlZCB0byBjbG9z
ZSB0aGUgY3JpdGljYWwgc2VjdGlvbiBiZXR3ZWVuIGVhY2ggbG9vcCBpdGVyYXRpb24uIFRvIG1h
a2UgdGhpcyBzYWZlLCBzdGFydCB0aGUgbG9vcCBpdGVyYXRpb24gd2l0aCByY3VfcmVhZF9sb2Nr
KCksIHRoZW4gYWNxdWlyZSBhIHJlZmVyZW5jZSBmb3IgPiB0aGUgcG9ydCB3aXRoIGtyZWZfZ2V0
X3VubGVzc196ZXJvLiBJZiB0aGlzIHJldHVybnMgMCwgdGhlIHBvcnQgaXMgYWxyZWFkeSBpbiB0
aGUgcHJvY2VzcyBvZiBiZWluZyByZW1vdmVkLCBzbyB0aGF0IHBvcnQgc2hvdWxkIGJlIHNraXBw
ZWQgd2hlbiBpdGVyYXRpbmcuIE9uY2UgYSByZWZlcmVuY2UgdG8gdGhlIHBvcnQgaXMgYWNxdWly
ZWQsIGV4aXQgdGhlIFJDVSBjcml0aWNhbCBzZWN0aW9uLiBUaGVuLCBwZXJmb3JtIHRoZSBkZXNp
cmVkIG9wZXJhdGlvbnMgb24gdGhlIHBvcnQsIGZvbGxvd2VkIGJ5IHJlLWVudGVyaW5nIHRoZSBS
Q1UgY3JpdGljYWwgc2VjdGlvbiBhbmQgcmVsZWFzaW5nIHRoZSByZWZlcmVuY2Ugd2l0aCBrcmVm
X3B1dC4NCj4gDQo+IFRoZSBpY2VfcHRwX3JlbGVhc2VfcG9ydF9yY3UoKSBmdW5jdGlvbiBpcyB1
c2VkIGFzIHRoZSByZWxlYXNlIGZ1bmN0aW9uIGZvciB0aGUga3JlZl9wdXQoKSBjYWxsLiBUbyBh
dm9pZCBhIHBvdGVudGlhbCBpbmZpbml0ZSBsb29wIG9mIG5ldyByZWZlcmVuY2VzLCB0aGUgcmVs
ZWFzZSBmdW5jdGlvbiBzaW1wbHkgdXNlcyBhIHdha2VfdXBfdmFyKCkgY2FsbCB0byB3YWtlIHRo
ZSBjbG9zaW5nIHRocmVhZC4gVGhlIGljZV9wdHBfY2xlYW51cF9wZigpIGZ1bmN0aW9uIHdpbGwg
cmVtb3ZlIHRoZSBwb3J0IGZyb20gdGhlIGxpbmtlZCBsaXN0IHVzaW5nIGxpc3RfZGVsX3JjdSwg
dGhlbiByZWxlYXNlIGl0cyBwcmltYXJ5IHJlZmVyZW5jZSwgdGhlbiB3YWl0IGZvciBhbGwgcmVm
ZXJlbmNlcyB0byBkcm9wIHZpYSB3YWl0IHF1ZXVlLiBGaW5hbGx5IHN5bmNocm9uaXplX3JjdSgp
IGlzIGNhbGxlZCB0byBndWFyYW50ZWUgdGhlIHBvcnQgcmVtYWlucyB2YWxpZCBmb3IgYXQgbGVh
c3Qgb25lIFJDVSBncmFjZSBwZXJpb2QuIFRoZW4gUEYgcmVtb3ZhbCB3aWxsIGNvbnRpbnVlLg0K
PiANCj4gVGhpcyBmbG93IGVuc3VyZXMgdGhhdCBhbGwgYWNjZXNzZXMgdG8gcG9ydHMgdmlhIHRo
ZSBwb3J0IGxpc3Qgd2lsbCByZW1haW4gdmFsaWQgdW50aWwgZWl0aGVyIHRoZSBSQ1UgY3JpdGlj
YWwgc2VjdGlvbnMgZW5kLCBvciB0aGUgcmVmZXJlbmNlcyBoYXZlIGJlZW4gZHJvcHBlZC4NCj4g
DQo+IE9uZSBtYWpvciBjb21wbGljYXRpb24gb2YgdGhpcyByZWZlcmVuY2UgY291bnQgaXMgdGhh
dCBpY2VfcHRwX3BvcnQgaXMgZW1iZWRkZWQgaW5zaWRlIG9mIG90aGVyIHN0cnVjdHVyZXMgYW5k
IG5vdCBtZXJlbHkgYWxsb2NhdGVkLiBBcyBhIHJlc3VsdCwgd2UgY2FuJ3QgdXNlIHRoZSBzdGFu
ZGFyZCBwYXR0ZXJuIG9mIGtmcmVlX3JjdSgpIHRvIGp1c3QgZGVsYXkgZnJlZWluZyB1bnRpbCBy
ZWZlcmVuY2VzIGFyZSBkcm9wcGVkLCBhbmQgaW5zdGVhZCBhcmUgZGVsYXlpbmcgUEYgcG9ydCB0
ZWFyZG93bi4gSWYgYW55IGNvZGUgcGF0aCBsZWFrcyB0aGUgcmVmZXJlbmNlLCB0aGUgZHJpdmVy
IHdpbGwgYmUgdW5hYmxlIHRvIHRlYXJkb3duLg0KPiBJbnN0ZWFkLCBhIDE1IHNlY29uZCB0aW1l
b3V0IHdpdGggYSBXQVJOKCkgaXMgdXNlZCB3aGVuIHdhaXRpbmcgdG8gZmluYWxseSBhbGxvdyBQ
RiB0ZWFyZG93biB0byBjb250aW51ZS4gVGhpcyBoYXMgdGhlIHJpc2sgb2YgcG90ZW50aWFsbHkg
YWxsb3dpbmcgdXNlLWFmdGVyLWZyZWUsIGFzc3VtaW5nIHNvbWUgcGF0aCByZWFsbHkgaXMgc3R1
Y2sgZm9yIDE1IHNlY29uZHMuIEhvd2V2ZXIsIHRoaXMgYm90aCBsZXNzIGxpa2VseSBhbmQgYSBs
ZXNzIGJhZCBvdXRjb21lIGNvbXBhcmVkIHRvIGJsb2NraW5nIGluZGVmaW5pdGVseSBvbiBhIHJl
ZmVyZW5jZSBsZWFrLg0KPiANCj4gRml4ZXM6IGU4MDA2NTRlODViNSAoImljZTogVXNlIGljZV9h
ZGFwdGVyIGZvciBQVFAgc2hhcmVkIGRhdGEgaW5zdGVhZCBvZiBhdXhkZXYiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IE1hY2llayBNYWNobmlrb3dza2kgPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYWRhcHRlci5o
IHwgICA2ICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5oICAg
ICB8ICAgNCArDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkYXB0ZXIu
YyB8ICAgNyArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyAg
ICAgfCAxMzIgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICA0IGZpbGVzIGNoYW5nZWQs
IDEwNiBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlvbnMoLSkNCg0KVGVzdGVkLWJ5OiBBbGV4YW5k
ZXIgTm93bGluIDxhbGV4YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
