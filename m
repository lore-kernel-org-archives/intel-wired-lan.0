Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875FEC79FA0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 06:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BACA60609;
	Tue,  8 Sep 2026 06:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mJby_3xyVyj6; Tue,  8 Sep 2026 06:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A9BD760641
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788848343;
	b=S8XDUbjRytGtXuO8UI9mmCQwtOKHobgi7P3pR17tRHo7NXQ+E5AVRF7hoTmdx2xfjCO0
	 IY0/YsUhinAPtqoSdA9Uuzd3Q2M72xReQjAeloW+BTjF+H8VcWIGPiTtWULdaAZrlHyP0
	 YjhqMYaLurVv74Mmjyda7r1OzHYa/TVYN0yCPE2/KouDo4FtKiXFHWj5McCctRdUAF/Ie
	 RaYZaqm3mwk0dAznERH+iS65e2ovV0HeuC+AzazlkPm8UYCLHiIfXyOmP6DYhsNlfG+OB
	 5N89L0B9E8hQjrmENDs0rYxKX926sf7w4QvnC/dDIRx+p2D7f9ZrzJlUUhczhx/PSjw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788848343;
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
	bh=syk6PjXWt2MiSL1RO9RpDH7yla287xA5uQSmgAB9hMY=;
	b=JpOCI6MKuCC9mUZ666r4echCramXXmBzaSY3ZlRGt8PkHtxrqq/5YuqsHtLSCEWNtdT7
	 Ceu+tfsvk4Bt4gBQiYUwlpGHjj6PkXn5Ysodj+FlqhD01qQf0JqDAoSoeHvIxq3WGwOOA
	 qmtcYN5SUD9AhY/aLRHmUVo2ErTazuNOLmC8BzGcEHNwfQhEfU2MRBhEMtRJdBVvI95uQ
	 7zm677bTvUJKLG2eBooq5mFGSKAbnMThP7Zcfxt9fCNFfW03kvDnblZZGx4Lgp5IITNEK
	 Cmoo+rumrQkyFTEciOKvfBx1bPCVilfmcTc1GuHqtO2uVUzx7Qx7fQFdocH/5vr5W6Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788848343;
	bh=syk6PjXWt2MiSL1RO9RpDH7yla287xA5uQSmgAB9hMY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nh4sODyb9KxvEc0DZKTcoCHHQpQ0VDflGdPmlToKTpjhd6vAr+4zdqo7bgCtiTdn3
	 2PLyZYfRtJmSZ1XsOYpbaqgETuEWGGo8GzeN9jmbDSUjUt16oHXTKxTzNYiei4h3xp
	 M+zdvkPTQM4mWXntMBwpDgRt+ym9jj9ju7rI5nioSbjzThPa0Ed+XxLDT/lq2VkVVE
	 SI15fImu6jg4hw7enexh1zXlAGBbjahprmmM9bQ8v6oHzCNyBJlp1Tvftsk/vAaFFV
	 LaHuoJWzo3ZZIbMQS78QQ42khaAc/PUjU2AGTOtyBcivwrxyOcvwWXPdOKsjDfm0YN
	 q+5cxp/V08viQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9BD760641;
	Tue,  8 Sep 2026 06:19:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BBE0DA48
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99FC680898
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DjZh-A56OIgT for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 06:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 438338088A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788848340;
 b=KymBaPx1TK+ClSXZDNtDSvKt7XyWfmkHJM6X9WJtVborhmK0x6H+TCc0Vl/94Q0MDEy0
 yIkQn3qH8Za0e25iszsEl8GwsyV2WJMMXw5XJNATg9CgPtDW1fnYyfP7qsw8pHWNjlkK7
 DnIdIHGHGmtNwVKJ326SlmpO9OKEReHtRwvAhzZfEBkA1Xlc0JkRS9zHDu/hcTYJkApRf
 cgVs0vqqWm62veMANBYKrgUkZtylGoIgEXEccqUUwyxPHAs53w71eoemCVGHNRgGWWyPO
 3boEkNDquJ/A63uczooNLDTDQLcFtQZQwe2oTjy/p3ui3oqESM3oCcM3rCXXMHCX0+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788848340;
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
 bh=syk6PjXWt2MiSL1RO9RpDH7yla287xA5uQSmgAB9hMY=;
 b=rGPuijovwjP0KjhOxpdQT3TeRTjpR1BpkkIyCUo/B1B52QHt0jG2tKiwZmV/WGEUr7b2
 crSADLuXqBB9djXwbBeYpunhNe/x0RFpV1oKZyvzN328+QYHDCtjZXTXo6Jd0xn0D13lQ
 8uyaPI9/yVLyw0QAoom7GyUgzvHt3cjfuN8rhdLRXnUWcgczI8RF64eIfVfklvAJ567a3
 hkCF/STyyOP3WoImUA1/8xJ6weLd5ubgPfg42QJTwSnyBux7Vp8LivFsWuIX+AiEbIikE
 6kULaHZbBPcRflsDB2buqGpBNfrZZBOfbylJ05hRk5MhazaGXRk/WYLAfHq6N8zV1sQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=f5GfXkDO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=sunithax.d.mekala@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=f5GfXkDO
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 438338088A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788848341; x=1820384341;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=W28VQ86wTpkeLd9WNkU1WXBdw6PkD3Ez4kWXJy7p5BA=;
 b=f5GfXkDOyHEA4tOfHsqQWwSlTplLhFCdaRz4ia1ZVOl0lt39ICJ3E/Zm
 QEMufpHeCgPrSFAqIn7EvHVV3HXO2JJ2dUkgl3mCUPK3tG2l/Z/SVMWZ2
 7j4RMYRmpQ4lx3xQbjy5dOqc63J6h21HBOW8sWa27EI4+uESgFi1DuOWS
 REMNhy8Q34x7lOGM1ee+7bhtrGylRSvnllWP0Ap3oR1bsfXquYhtRtoig
 a4ZU6/Kwd83amdsI1UVYNqWUKzHEe+Vfs4Y9fTe0QJ6Apq8AXaiSAEkgY
 Tv6HTCJ7hg1DwR78kQniOslYQ83xyZ45jVLEyrKHuqowihUyuJ8tPtcBJ Q==;
X-CSE-ConnectionGUID: +MCUI7e/S3e+anbaSsHptA==
X-CSE-MsgGUID: 4fRt+Z8AQbCRUdRWrnrv5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89284722"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89284722"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 23:18:59 -0700
X-CSE-ConnectionGUID: vAhEoCl9Q2KW3GdvN4vM5g==
X-CSE-MsgGUID: WBDvlTYERtmgVrwy1WFdzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="274413417"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 23:18:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:18:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 23:18:58 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:18:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzib7Dq4QfijBZKqM56HbMAaQiQKpwwpDDFNfl/V4350Q0PuCZuAubhtr9cfgT/CCwbxC7NKr6zjycJxeaxAwizPVW0KjH1/xgsBLqVrvmA3HbicN0i8QXs2UghL00TaUCLb6Kuf+LDPUlIZAcfD5eFPa5txFyQSmrMPC4nueY7IazbqKSJc//B/TiZ70AMRTFFnBpIniCvu5G+JGzCXMvGBnHZ4aRYK1B8OVeGtF9exJxOEF94qaqFtlXJ16OP8qP2VqzYJcUIAxiKhlzIQyIr8ltPgUodUDu1k+RMkKWCDBClO9VS39YSjKN9zz5igVFKDAUgO70cSMGziB148cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syk6PjXWt2MiSL1RO9RpDH7yla287xA5uQSmgAB9hMY=;
 b=G6OGVF+BbQnvIk2vY6Avvzpp+cI4+Z4o1CcRcxQgAKu9dnf57z6hO51MM4KSeTnTDOBhxTm7YP7PsaqWopdh/wE1eyVp9A/eYy7wFTWvIujQ3Ly4unalPZm7GO0bSVuyUQWXs11QXg5cf6lor70mXXWevkNPLkXq6RIyUBb/oo218unVGssP+4TbBw4f4tmEowkur0bOYiPA6TrDUZiwsPSKoSoFmxNNPREoKJh04GuPM0v7mmIiCgkhS1wQirYGL7st5Ym6SU6Sx87SvKyI/gVGNdfmH4mX49ErgbxCiMkSw8UqY2juWQIOl/vIqq+7kMhldl+fZxnU14Ng1D3uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 06:18:51 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 06:18:51 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v5 net 1/7] i40e: unregister netdev
 before clearing VSI on reinit failure
Thread-Topic: [Intel-wired-lan] [PATCH v5 net 1/7] i40e: unregister netdev
 before clearing VSI on reinit failure
Thread-Index: AQHdCVeWdfVMVwltNESqSuY7s2WwzLbEnH5w
Date: Tue, 8 Sep 2026 06:18:51 +0000
Message-ID: <PH0PR11MB752226FC021B80C7FF12A345A0B12@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
 <20260701124524.13644-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20260701124524.13644-2-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|LV2PR11MB5999:EE_
x-ms-office365-filtering-correlation-id: c9e1834c-a965-4495-758f-08df0d710d22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: eI1faCd6rIBmEm7mfn6P1HzBVs6Pb/mRT3gM4MwFlYJmVXsTSJL0gZcBZ+qwvaXsX3LNokZA1K4DVd4B8ZV4BeZE4LyonRLybgNpZWN2lLKw/iphi/uqjppCOgjjH2diCjU4FdefGIP1nGGYHu7tsgw7mj8KffiR+moHpYvJD7pyaHPqFWutwuKGTLGq2U0rj51l3Ft9w5IxqmKr1ZJlzGkSAdb22rvr4Yul2FDLOBu2kBz/LQStwkPoq5WJiXeM9S2k44qBpAsRkNUfpL1QIBcIXCPDpRWsyqxXeH1bn3dF6SMzN4LK2cfVh8HRm/0kHx0RKd3oEd2nooOneWhU78NwAqvtemIfvUJTnu71cI5ZqJjpmvVz317AlE2RkeUpyjYo+lrNQtInl0L18O8tPOZysmOv8OhH2aWNhOPeuXi7zOzJqy2nc9/8uFvB3bO/sjcFkH7AP+BvdTX5kvnXLbk7NakJ9Dc54erUtpDdF8c9OAgPP3mBce3VWdC1IEtkI1oB9Rv6IgkGy5G77+zgcBxAneOZnBtIN0wLiOrIRt/tUg2lYOhxNnUcCFlKCZceiIH5snHJChqroGUaEiDy95MEvZ7dlSE/DaAjTDfmNHQ+ha3Rhl2seHmUhe8WWM1GDTFvspk6IpH/dEKVHQTFKPQq8iMdcgNngSfZ1PBwyHr2Ae7E+cNDj5NRleiPiJqcOjEkgXA6HTNUTjybRYsByni8JxkYQcZgrfWTBkEeRFs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VPrWCxpEF+dfFUmiygTjPT2WN/sBUamDDd1DGck/jyiqWKJ4tcxSU0Rz+Jux?=
 =?us-ascii?Q?2Tjf1Lu/jPIY3kZldd3kAwzawKfKlFjCm3hD44EddhoVdEzOZHijAw8UBVZ3?=
 =?us-ascii?Q?Ta2p6mj0I/gHYyna5TA1jfkxGAl0gFXvkqTxhc/TMincsSu1O04SlPjqV6ai?=
 =?us-ascii?Q?6lpPcdW4MopxiTmFJWM9OLvbL7riaGrOo9Vokf3/kTQT14FRTbEzYLcv0wus?=
 =?us-ascii?Q?rMNKZcDg7oxBk0rvZS/2L3SHRTsYI6MJjq7RlshH4oXcDnr8Xoe+EMYoFGaR?=
 =?us-ascii?Q?L/6T6n+bH/WBNYLa8P+YnAqXVayP5pb5GKP1nHl5K3JLBlc1RPp1YiriDulx?=
 =?us-ascii?Q?S2cDQ5829phalQ4ykTDDEWFIlfHzqm0XRIeefq9Z3hPJvsnWaZGY4RX6jaqj?=
 =?us-ascii?Q?R4IU/8fOx9Hb9/WeFmacFZ6bNMkE+pfRuGE+6mJZ9Lc4xYkG4tO1+mL2ViO2?=
 =?us-ascii?Q?UusA1AxnFmLvEazxyPSnRZ/3eYP0GbaPaiUt871nyfXMEO3KQFNHZZadrJC9?=
 =?us-ascii?Q?R/17hDQ16In8iuHQD55fJEIP6hikONuRG0SsfGhhTcQpfl3PyF6sivw4ydsf?=
 =?us-ascii?Q?8wai9jVaDBwb2rdmbGmlViBi44CNLkD5PRkFGjM5Q1xUZD3/tckpOj6WZ5fl?=
 =?us-ascii?Q?vz15aVnefnFfe7Hka7/MIfVNlaPwMcMWWsQJVFwMoavKaHR1Xu5si+XFe97U?=
 =?us-ascii?Q?0uNbqvByIx6JdVrqXySXVRI3Xo4tkaBmrfQRtqQGownhNZIy2lXtAv540Ge9?=
 =?us-ascii?Q?BCPEM/+rt/oQL9HzVFks4VTxnzWSvlisb7umlnMNqobqfD2sKUMBEh4ML4Vc?=
 =?us-ascii?Q?9zuuIupUfeksUDDjxsn38AaSXgE949FfukyJg8lghHKnjLnRKnsAMLbe7ioF?=
 =?us-ascii?Q?S+Y3hY3MUXJAUk1zczDNoe3OnQiU1xJ0EThBYSwOI5yv2Ts6Gu+JCU/wrl7P?=
 =?us-ascii?Q?nxgGpmATzGQfqzDq3O9vpet2z5KRECECLfYWnZ4emwmJiMyBAgPipDurhE7K?=
 =?us-ascii?Q?aciU1oJIUl7FE2WlQeDRe5PQ7bDsJDlhoRkjAlW9PBJ9EOJeC5qIM8zEC0Vt?=
 =?us-ascii?Q?QTjnJW4Ib2/ZxFOG6HTtMOsZC8QlCC2RLHUsjnidf1dgCca2IH+0ctytrVJZ?=
 =?us-ascii?Q?up3aVVFlv0VNb9umEaM8oeokWE2mTcNPm+UJkhjmo1ALRXDmQhZOsKk/nbjS?=
 =?us-ascii?Q?PBRIGnAjWqeSl8LO/XUp1VVf92J1apT521psBgD7duBZ8CTB27f2zBnzmrVS?=
 =?us-ascii?Q?f7pIBeh2eq98/+T3iq1PngzJfzA4uRsdWEP7080+iCPqZO+A/LF7mE37S76o?=
 =?us-ascii?Q?LV9FufU8PpM8U+FKvwJPzAMbu6ysF4eJfb2zkUo3b6h23A1MjyTOBwfrkp2U?=
 =?us-ascii?Q?o7iGHE0/gRs3BbUSYELT+nP6U3/ZWReXP3H+1BNrSWMV9/bxrSFcy1sNsilb?=
 =?us-ascii?Q?9f33pxZ2rKuThK+Tm/Rl5y6m4ZeKm80kwUDYGJBIVK4lZzsKWWdFw6cWiUA9?=
 =?us-ascii?Q?WFLZ6BGwJXZxbSh7IPqjkbrC3p4lrwnNp4jgdrTAgmFsYqA+wIoRAsGrg/7P?=
 =?us-ascii?Q?dcF0sLCxDIxj1w/brBpPKBHDlPsCNtkwQ8HjijcofjeIM5Jp5Dcp/IHIr1fQ?=
 =?us-ascii?Q?isuSjqNC0XWVzYjxUYuZVzsjWCI+rBDCUtecTn1Fqplr/dkeASZXzQX59wUj?=
 =?us-ascii?Q?wdoxaq6drSnxeO/LNugX/bJFKLb+wBuYKpXDN7UtKH4PRw39/xrsCS9ggIpl?=
 =?us-ascii?Q?+NmnVsCqaQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l/hwnXy68XiGZJ3W10lsVQkwpqYhCHgxQVepiA6nzn8SgjySgjGRn3x3quA0QvEgucA/zkFt21EuPXzRsKyuD6/yj/ijeo3DedBSllD0nX4uFzTnpPqejAWBPyPz3e//uEH19RQEOO3rYTzkN0GsA510AVL3va0lEY7umKXBdu+AwMvGEqPka3NGqPTCwGpZ34ZqghSW9wct0N5gTTS/2FUOdjY3i9Q9MsoXLnhy7Zrt+n3MWW9HVh36TOCMl7Fy/u5ZRKax8w72Aq1Kz2ZNL3u9M46gRQBwsfIS4E/ByrGenNmUYJYSBb/DsyepCYu+mm72q/57lnZHaLnlqoDC6Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e1834c-a965-4495-758f-08df0d710d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 06:18:51.2086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tBVoidlb6Spc96QR/YOscilW1xQLRyX/P6MiUg+f5ToptrvwaTbBcjy6nU8eO6QlFADoEDzlUZEKoLW5eZ6CHxgQ0thIAcsJy4zA4sG1Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
aciej Fijalkowski
> Sent: Wednesday, July 1, 2026 5:45 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>;=
 kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; Kitszel, Przemyslaw =
<przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;=
 Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v5 net 1/7] i40e: unregister netdev bef=
ore clearing VSI on reinit failure
>
> i40e_vsi_reinit_setup() tears down the existing VSI queue/ring backing
> state before allocating replacement arrays and queue tracking. If one of
> these early allocations fails, the function jumps directly to err_vsi
> and calls i40e_vsi_clear().
>
> For a registered netdev, this frees the VSI while
> netdev_priv(netdev)->vsi can still point at it, leaving the registered
> netdev with dangling private driver state.
>
> Split the error path so failures after destructive reinit teardown first
> unregister and free the netdev before clearing the VSI.
>
> Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs f=
or PFs")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
