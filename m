Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABB5606A330
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ogpApasQ;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F4Q4CL7A;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=RaZuPA4c
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8CA240AC0;
	Thu, 19 Nov 2026 12:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WOLIkUxISzdS; Thu, 19 Nov 2026 12:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CEAD1405F9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795090229;
	b=avZfMlPP731SHCxAxq/oh2ZQKEmL7LAUYyKLO3/zrRSgrUrNSzEbYeXDnmm1+pM+WytP
	 FKJke8kzAp8BVva1SEVjbYeAKOVXr0vvv4mFXi0aZ+C5eGdPV824dJNOlBDPq+yi4krtb
	 UmUJ+RoBg0V+0QXHefj/jIJ9EZh3IxlLMH2RvnKScGGHwDlMdAbsMqlxwjmM1gq5ciCBh
	 rhIY9veBGIwBev6xMoxRTX3oq2+TC+aybkyhc0bglkrkoeDI9ViBrd3Dkk83AzFY5+425
	 lXPo/zoEWYy1nej5VPZBDg+8CazFTcBhuhwTCuH+E9YxCcBbKXSXS8zDGSI8Jgn+h9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795090229;
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
	bh=aTY9iG6jy4SwUWPkXfbQDEDEI0SrCYAqIxrYV9X+/2Q=;
	b=ppKi05ogNqqFXHWb3Ba9nhjm/MmFU277EXgWNBOtvcYlVTMWvsojxkGkehAWbvqpO4Uf
	 E4ypdvUkTt/lyaEbcWGugbEtOwDnnhCEAWIceRwWnuL+l1ZntDZgftU3pUlPJKxk3CkWh
	 ZVEsSLH4GAKfz+yWK8kp+QWiBYIqplhVxCwYiM89V4iskqQ/89TCCtYSe8YgBQExsvxq0
	 U2XY3IaeW+tF4brEB5SyOrHdo0nwRimR2HC60ZrcN1tRC/ckcrpMnBNoDXTJLtA3k5DxS
	 puijqzCuSSC/6uOomin/ALbQTBjB+qfM2kS8h1vWsDYLWy/mD52BoAf/bdpGhkF/9nA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795090229;
	bh=aTY9iG6jy4SwUWPkXfbQDEDEI0SrCYAqIxrYV9X+/2Q=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ogpApasQ4uCbzybvqkbYLfrKldJSXzU5tVjSmnb06rkwcjtt1EANUKemfwdYvlYJ5
	 n+4wsWPvepYLgIB1mqK7eVj9jXgNcZhD3k2dw/W0hZpYrbqzbXH/WDMpxuoNbqKa0U
	 ldda2a9ve9k+/2brnCP1X4lAP85qeeaIuWyiZMdnvKvwoTTwngs9U4ktYUdMAYI0ON
	 Kyq1ydaEJbtxWKksdh7N56UeCCdZYcymkEclTvKIIgBK7kkNE8jP40xWpP/HMX/zaN
	 GswP2pGS2gTiA5ZqsPC3TPk1u0PY8Sy6K2gKgjW5JAnLYs5bD4XZF4r6q0Y3PCWtyu
	 LVoGb+HSxL82g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEAD1405F9;
	Thu, 19 Nov 2026 12:10:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DBDE2FB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 12:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 048E24052F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 12:10:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c975Nq6cFywo for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 12:10:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DC4AF40526
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=F4Q4CL7A; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=RaZuPA4c
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC4AF40526
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795090227; x=1826626227;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=aTY9iG6jy4SwUWPkXfbQDEDEI0SrCYAqIxrYV9X+/2Q=;
 b=F4Q4CL7AminS0JnQT3CC0SrucVB7E7D2teTRQEYqdKpOvmvteDFXVSs5
 kQgI9nMEchP9sMaeraGAUEDtFOiN3L1Ja4kOSnAWoEQK5qo7BDAWTsNmM
 mk0F560lGbJu2eg9XKpzmFbYUNOSL7kjet1sHw8/7kZMWqTJSz7Wsmggl
 aZ2jVQ+Oz9PkRvZS20W+1HgahH+7aN+motPCZTTUOE0j5LuD65l5HTpu7
 4P2L5mFSAGy+lWuogHnzsklBu8j/umJbaQ45Ons7J1OStqVBnT62y2VBv
 7F92LpeYYHqOWSIvuTp8HTolAlMxypkDw28YuM2zZt55CWSCWqCTjQ5bh Q==;
X-CSE-ConnectionGUID: IHbrcfqRQ7WmSMPWWYsygg==
X-CSE-MsgGUID: Kperdqf8RfWbM98P+5Ucfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3781298"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3781298"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 04:10:25 -0800
X-CSE-ConnectionGUID: P80GMhsjTzm8DoGoQDWFsQ==
X-CSE-MsgGUID: XKE62QdgTZO1a6rMRiFcVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="12158340"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 04:10:24 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 04:10:24 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 04:10:24 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 04:10:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTY9iG6jy4SwUWPkXfbQDEDEI0SrCYAqIxrYV9X+/2Q=;
 b=RaZuPA4cLafUSI+6tGzJEWWLByRTj3McVEijGOAKuYSJ+m74dLZT5vzL1OctGN71Jb+NA/49kU6R7weyAFJBWsdNRJnZrY/gu7r3lFPvaHmyZ1veJq+FAPFCNV8Y0IXtcoVK18QdyX048W3Lsti15+oN3pQtcdjkK06ECCroP54=
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by PH8PR11MB8260.namprd11.prod.outlook.com
 (2603:10b6:510:1c3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 12:10:21 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 12:10:21 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>
Subject: RE: [PATCH iwl-next v4 2/4] ice: exit PTP callbacks early if not
 ICE_PTP_READY
Thread-Topic: [PATCH iwl-next v4 2/4] ice: exit PTP callbacks early if not
 ICE_PTP_READY
Thread-Index: AQHdd71jkd9cAteTy0ux9h2RYhv677c1Tlwg
Date: Thu, 19 Nov 2026 12:10:21 +0000
Message-ID: <CH3PR11MB566895477244CBAED1E26C681CE5792@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261118-jk-e825-e830-timecounter-v4-0-0acd194b7357@intel.com>
 <20261118-jk-e825-e830-timecounter-v4-2-0acd194b7357@intel.com>
In-Reply-To: <20261118-jk-e825-e830-timecounter-v4-2-0acd194b7357@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|PH8PR11MB8260:EE_
x-ms-office365-filtering-correlation-id: 36b0abc5-be1f-4e07-77ea-08df4636156c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|921020|38070700021|56012099006|261026140227099003|4143699003|11063799006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|261009223027099003;
x-microsoft-antispam-message-info: +CNO7BJwWvHCVcBiinEqdS9uwywsc7kgg9IEkQgJVj5c63xhhUP4oKjDG48ZlEy8LL7d7yHbDidufIjupLDd7yBaw+b/Q+GLGVMSPZ+AyugziA2kKIr71IMdszVQH0/neycgNtgMiZ/MoSZCF2MBm0riRo+DO/nBGvnhSy8wbJMS6MOn+HAU3kaBnOcsgBuKCdig4rx8hhc779VQOsrwvh+inhb018Lp+SQKRar+6mhqj5ra9LOK4ZJ0Z2XV2HSwBUcjFQ5OKolXlRmNc/1vCnEIzJ/ncaL02qzKNBy+G3BuRBOwHXfYAsM/POQpyYcDdSCz27bkLdQJQvHyvZ8yn1dkFlLnpclLT9xm8ojWl7Ixt3IIRjs7dnzEwkjc6H5WazPmPaxOP/NPB+oETwEFjCRn47KF8kL+UIIHsRC5TlA8E6i48fDDmipRN5H4lat6ZKpY4mwClp15VQ7ufqbFzs/mcXiL2Zzbzh+mNcjGYzLvaF++/p9V6m3E8zwf6VIqXu3NLuN/CVTeNWg53HHSA1qdNoV1hlfOgXALkD/ewegKnsEZ5lx/qXE1rLaV2hzz+jX4NVUavJnXyLYxiiY4yp4q06DjaD4JzQPa2eCIv9Hb6WG4meNWpSMXken5l8xEmwduBa5CMAlT47gxunskDZYk/YWybc4tRuO0lrqRhVJhluLAOOMAX7E0UOcBoJmV//IwRpHWyEZ8kvUUbRY/R0L0q3cJOhHve/j8eqfqiH+BLyqaYAvhZT3mo6DF39D7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(921020)(38070700021)(56012099006)(261026140227099003)(4143699003)(11063799006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFZITjNoUTlUTWFjY3Zxc0I5aWszUHJRNWYxS0c5VWJDQlhXZjIvU0MzUGlV?=
 =?utf-8?B?UXlwWThLWjgzWUlQZTdPV2VQQVRDamVpT2QxT2VrV3ZYbnhDUlFDV0ZmU2lM?=
 =?utf-8?B?VndsNDhPQVZkSE9vaHlxd1c2TzRBWlhnc0tVYnVlUVFDaGZCWnI1RFV4djlz?=
 =?utf-8?B?UThoOE5NWXVFaTJDcE9yblVtS0NFOGNsd1ZCaG5JWHpVNWkvb3ZHZHZ3N3gr?=
 =?utf-8?B?a2FKTHFIM2hsc3ZNc2VwM2tZMFRkMUJ1Zk01VDY0OVRBUGFIU014SnZ4VXhF?=
 =?utf-8?B?S1ZmL2ZJTXM1Z0RUemR2cjJaSlhYQ1FLaHA0aXBZTHExa2U1T3BmVWc4eS9o?=
 =?utf-8?B?YktmeGMvNy83MjJEbHVlR2xJbXJ0MzkxbTNsZkhmbDhFOEwzay9qcVdrTFZt?=
 =?utf-8?B?SDJSY1NXVE51SzF0UXpQRml6eFNQZE1kSGRnelRrNHBlZllQeDNmRmdCKzZZ?=
 =?utf-8?B?NlMwVld4R3hZVEE1aUc5U0xqSzVvZjRZbUp3Z1d6ak80bTFSeWdjcC83UlNs?=
 =?utf-8?B?OHBFUUM3eU5qMXNhUXRxTVdhSEhHd1RLYWNINWl5VFl3cVNmZTVuZVo5dDgr?=
 =?utf-8?B?aFhTeHpzVFh0NDh1amlMMWpGSTlwbDBYM1JLN3lSRXpGbkptRXVFVUYvK3Jw?=
 =?utf-8?B?YThZSWJIWHZwQjQ3ay9zbkM1bDRubXNIeHpLN2c3V3BiTnpNQjN0TTNpQTlC?=
 =?utf-8?B?aXg5aXZna3BRbm50b0xadUhDWkFaWnZ3ZzJSejVJUTVrRVlyWE1jMW1wM3VD?=
 =?utf-8?B?L0dZVDlsQW4xSS9zaUFZSnA4RVNTcjRhYnY4TjJpZzcyZ3RZZ24xRUw4M3Iw?=
 =?utf-8?B?K2tseG5sdEI1S0tvaEpxWGJIM3dGcklhWmFQWlY4VFBFNVV5L21tK3QzcUFl?=
 =?utf-8?B?MklJWmZvbFJPWnBhYkk2a0piQlhHLzYvTXN4U3RkRkgzVnFNcE9NdWVtYjJw?=
 =?utf-8?B?QXZiODBkSFFlSlRSUGFwcjFZQUFkRCt0SG5VUFJLZ2xObmozcjdHUHdPNFNl?=
 =?utf-8?B?Q1AyNFpvbitHS1pxbFdSejJVQjhPK2Q2TGFlOU9EZUx6cDAveVBYZS9VOGtX?=
 =?utf-8?B?L3YwNXBlNWpKY3gxalJ4QlZVbUYvVGJJYk1KTkVsbld6L1c4dkRUUTFmNmpi?=
 =?utf-8?B?aWV4OG1YZUVrSmZYZzR4YzY1YVJlZFBLb1BjZE1Nbnd4enB0aU0xV1lJT0Yr?=
 =?utf-8?B?dExHZzZVK2RVSXU5WXNVRDFjbTltanptK295UTAwdW1ON2Z5ZWxoRjZhZWo0?=
 =?utf-8?B?dFhzQUZCQmh5UDU4Zjk4MVdqZ05IU0t3UkJWN2U0VHZBcWRVSmgyczFhT2ky?=
 =?utf-8?B?K0hxZGlRRUxnTFUrQ24xd0YzNjU3MWxLKzNFWXF6eVg1WVBpSXZYeG5RNHg0?=
 =?utf-8?B?TVhCRloyeHFRUHQ1dmszMkI0QTdSei9YSkhlU0R3RlkwbDhhTUFVbGlhejVV?=
 =?utf-8?B?WWVkTTloZWVtQVZjMXR5QmEwUGxObnVBWGRVcFErakxGRjNqTlhQVjF6UUFo?=
 =?utf-8?B?Rmw5TzB3T0txVjkzQVdFNW5sOEFwK3ZCZ3g5cm1mTnRaT3M4R0cvbElRUTF2?=
 =?utf-8?B?cC9Pd2JaSldLOFNpY0pic3F1bHYvSTZzRlJJQXh6WTlSWUh1YUhGMUo2WG9a?=
 =?utf-8?B?MzlOYmVhOU5mSnJCbHROQTJ0Vlg0OFhKSU5NWlk2Zm9SRHhJbUlaWVlLWVNp?=
 =?utf-8?B?ZUo5TUNnQUZyMEJZOXkwaXBXZ3BBVmNYUzFqMmU3VkFzT1RFSEpDVHQ3cisr?=
 =?utf-8?B?VUYyUEJyakR2UWs0MHJZYzhwemo1cUdUZ2phZ2VLTmxPTHVrd0pRL2I5Vk9j?=
 =?utf-8?B?aURuNU9paWFrdUxJSU9JclFFQWk3NkF1bFY4Vld0K2NsMlNjM2pMWlRMVmo2?=
 =?utf-8?B?b2dqbHRPbEgxdWRydmlld0U0dnpxanBRalZzN3pSN1M1QnhJd0R3b09qbFhq?=
 =?utf-8?B?a1lqckNOQkhnd3JKeVA2UE9iejkyRUVzajdqY0ZuYStESzlCbUxrS0FDb2JN?=
 =?utf-8?B?a2JCTmZqZU1PV2FEenUrV1RGbEpMZCs1STBZaStUdXpFaW9abjl1N3E5K1NI?=
 =?utf-8?B?S2hMMGxEUHB4VmEyV1BpOUl0V2xCWEM0bDl2cm5OWGxuSHdOOG5aaEUvVjVt?=
 =?utf-8?B?RWUwRktTT1NzR29FRDdhdENWNWdGQTBpekR1REt5ODFOQVJITE9TTzFDZGdn?=
 =?utf-8?B?TENhU09iSmJlWU91NjhxdGVSY2FBYTdPQUNnVDBJTzRwbEFHRnpDZ0hqMEJz?=
 =?utf-8?B?bWsrZWhmcUVpU21DQ2NseXc4RUU0ZU4rK3ZTdW0vb29LeXhYVGE2RmtNekRP?=
 =?utf-8?B?QWZmRXhtL08vdGxQTy9JcVExSlIvdExMRHFFNTRXb1JiZ0NJS1pZaHNMM1pr?=
 =?utf-8?Q?PHs5BIVMBN7VF+2I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oxZ8BFyygpsDXG6WAcbiXvJEWvJUD4SOpgbOtG3/drzmQW+M8Cl4wc+UjfgnchuE5p0fz27ZMmGDAJNeS37/coAJ51m/d1eAd6SuxcGLguxLoDIcCBjnixC4yMblkviZmsSs6Q2KSc0Qd78gPXcdEsSNczWDdlAP0/wl53C4xju6AZdaX+dV90FSsrZQmEGdxJq7qWZONZhHaIY97gbKotKMHcRZAjMepahFSGjsoqcN9/sV0uK5LOMm0SK2P34ZqqM67LbMsm8g9PlI5IXQXfJXN/tKcFQ08+J/cp0EBEMWA1PzY26wp5Lrlgz2WCP0QlIdE3hxG4tj8UFuMM79nA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b0abc5-be1f-4e07-77ea-08df4636156c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 12:10:21.1013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WgrE+DrABOtLdz47SpZCgCEaBCgMxg2nxR3xdBGxtLeJnj/gcJOR3tA7/xq5wGyvNMlShbl6nFl6TSgUL1yCmnEH/ys7pUB6Y3+c/8UUlSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8260
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgS2VsbGVyIDxq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxOSwg
MjAyNiAxOjMxIEFNDQo+IFRvOiBJbnRlbCBXaXJlZCBMQU4gPGludGVsLXdpcmVkLWxhbkBsaXN0
cy5vc3Vvc2wub3JnPjsgTmd1eWVuLCBBbnRob255DQo+IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50
ZWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVs
LmNvbT47IEtvcmJhLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtvcmJhQGludGVsLmNvbT47
IE5pdGthLCBHcnplZ29yeg0KPiA8Z3J6ZWdvcnoubml0a2FAaW50ZWwuY29tPjsgVGVtZXJraGFu
b3YsIFNlcmdleQ0KPiA8c2VyZ2V5LnRlbWVya2hhbm92QGludGVsLmNvbT47IE1hY2huaWtvd3Nr
aSwgTWFjaWVqDQo+IDxtYWNpZWoubWFjaG5pa293c2tpQGludGVsLmNvbT47IEt1YmFsZXdza2ks
IEFya2FkaXVzeg0KPiA8YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPjsgS2VsbGVyLCBK
YWNvYiBFDQo+IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBp
d2wtbmV4dCB2NCAyLzRdIGljZTogZXhpdCBQVFAgY2FsbGJhY2tzIGVhcmx5IGlmIG5vdA0KPiBJ
Q0VfUFRQX1JFQURZDQo+IA0KPiBBZGQgYSBjaGVjayBmb3IgdGhlIFBUUCBzdGF0ZSBhdCB0aGUg
c3RhcnQgb2YgaWNlX3B0cF9zZXR0aW1lNjQoKSwNCj4gaWNlX3B0cF9hZGp0aW1lKCksIGljZV9w
dHBfYWRqZmluZSgpLCBhbmQgaWNlX3B0cF9ncGlvX2VuYWJsZSgpLiBJZiB0aGUNCj4gZHJpdmVy
IFBUUCBzdGF0ZSBpcyBub3QgSUNFX1BUUF9SRUFEWSwgZXhpdCB3aXRoIC1FSU8gaW5zdGVhZCBv
Zg0KPiBjb250aW51aW5nIHRvIHRyeSB0byBtb2RpZnkgdGhlIGNsb2NrIHdoaWxlIHRoZSBkcml2
ZXIgbWF5IHN0aWxsIGJlDQo+IGxvYWRpbmcsIHJlc2V0dGluZywgdW5sb2FkaW5nLCBvciBhZnRl
ciBhIGZhaWxlZCByZWJ1aWxkLg0KPiANCj4gVGhlIGNoZWNrIGlzIGN1cnJlbnRseSBiZXN0IGVm
Zm9ydCBhbmQgZG9lc24ndCBndWFyYW50ZWUgdG8gcHJldmVudCBhDQo+IHJhY2UgYmV0d2VlbiB0
aGUgc3RhcnQgb2YgYSBuZXcgY29tbWFuZCBhbmQgYSByZXNldC4gRm9yIHRoYXQsIHdlIHdpbGwN
Cj4gbmVlZCBtb3JlIHRpbWUgdG8gaW52ZXN0aWdhdGUgYW5kIGRldmVsb3AgYSBwcm9wZXIgc3lu
Y2hyb25pemF0aW9uDQo+IG1lY2hhbmlzbS4NCj4gDQo+IFRoZSBpY2VfcHRwX2dwaW9fZW5hYmxl
KCkgc3RpbGwgYWxsb3dzIHJlcXVlc3RzIHRvIGRpc2FibGUgdGhlIHBpbnMuDQo+IFRoaXMgaXMg
aW50ZW50aW9uYWwgYXMgaXQgd2lsbCBiZSBjYWxsZWQgYnkgcHRwX2Nsb2NrX3VucmVnaXN0ZXIo
KSB3aGVuDQo+IHRlYXJpbmcgZG93bi4gQWRkaXRpb25hbGx5LCB0aGUgY29yZSBQVFAgY29kZSBv
ZnRlbiBpZ25vcmVzIHRoZSByZXR1cm4NCj4gdmFsdWUgb2YNCj4gcHRwX2Rpc2FibGVfcGluZnVu
YygpIGFueXdheXMuIEFsbG93aW5nIGRpc2FibGVzIHRocm91Z2ggZW5zdXJlcyB0aGUNCj4gaW50
ZXJuYWwgZHJpdmVyIHN0YXRlIG1hdGNoZXMsIHdoaWxlIG5ldyBlbmFibGUgcmVxdWVzdHMgYXJl
IGJsb2NrZWQNCj4gdW50aWwgdGhlIGRyaXZlciBpcyByZWFkeS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMgfCAxNSArKysrKysrKysrKysr
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYw0KPiBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gaW5kZXggMmI4YjZmMmE3ZWY4Li43
NzdkYjIyYTdjMjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lj
ZS9pY2VfcHRwLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9w
dHAuYw0KPiBAQCAtMTYxMiw2ICsxNjEyLDkgQEAgc3RhdGljIGludCBpY2VfcHRwX2FkamZpbmUo
c3RydWN0IHB0cF9jbG9ja19pbmZvDQo+ICppbmZvLCBsb25nIHNjYWxlZF9wcG0pDQo+ICAJdTY0
IGluY3ZhbDsNCj4gIAlpbnQgZXJyOw0KPiANCj4gKwlpZiAocGYtPnB0cC5zdGF0ZSAhPSBJQ0Vf
UFRQX1JFQURZKQ0KPiArCQlyZXR1cm4gLUVJTzsNCj4gKw0KPiAgCWluY3ZhbCA9IGFkanVzdF9i
eV9zY2FsZWRfcHBtKGljZV9iYXNlX2luY3ZhbChwZiksIHNjYWxlZF9wcG0pOw0KPiAgCWVyciA9
IGljZV9wdHBfd3JpdGVfaW5jdmFsX2xvY2tlZChodywgaW5jdmFsKTsNCj4gIAlpZiAoZXJyKSB7
DQo+IEBAIC0yMDAyLDYgKzIwMDUsOSBAQCBzdGF0aWMgaW50IGljZV9wdHBfZ3Bpb19lbmFibGUo
c3RydWN0DQo+IHB0cF9jbG9ja19pbmZvICppbmZvLA0KPiAgCQlzdHJ1Y3QgcHRwX3Blcm91dF9y
ZXF1ZXN0ICpjYWNoZWQgPQ0KPiAgCQkJJnBmLT5wdHAucGVyb3V0X3Jxc1tycS0+cGVyb3V0Lmlu
ZGV4XTsNCj4gDQo+ICsJCWlmIChvbiAmJiBwZi0+cHRwLnN0YXRlICE9IElDRV9QVFBfUkVBRFkp
DQo+ICsJCQlyZXR1cm4gLUVJTzsNCj4gKw0KPiAgCQllcnIgPSBpY2VfcHRwX2NmZ19wZXJvdXQo
cGYsICZycS0+cGVyb3V0LCBvbik7DQo+ICAJCWlmICghZXJyKSB7DQo+ICAJCQkqY2FjaGVkID0g
cnEtPnBlcm91dDsNCj4gQEAgLTIwMTYsNiArMjAyMiw5IEBAIHN0YXRpYyBpbnQgaWNlX3B0cF9n
cGlvX2VuYWJsZShzdHJ1Y3QNCj4gcHRwX2Nsb2NrX2luZm8gKmluZm8sDQo+ICAJCXN0cnVjdCBw
dHBfZXh0dHNfcmVxdWVzdCAqY2FjaGVkID0NCj4gIAkJCSZwZi0+cHRwLmV4dHRzX3Jxc1tycS0+
ZXh0dHMuaW5kZXhdOw0KPiANCj4gKwkJaWYgKG9uICYmIHBmLT5wdHAuc3RhdGUgIT0gSUNFX1BU
UF9SRUFEWSkNCj4gKwkJCXJldHVybiAtRUlPOw0KPiArDQo+ICAJCWVyciA9IGljZV9wdHBfY2Zn
X2V4dHRzKHBmLCAmcnEtPmV4dHRzLCBvbik7DQo+ICAJCWlmICghZXJyKQ0KPiAgCQkJKmNhY2hl
ZCA9IHJxLT5leHR0czsNCj4gQEAgLTIwNzAsNiArMjA3OSw5IEBAIGljZV9wdHBfc2V0dGltZTY0
KHN0cnVjdCBwdHBfY2xvY2tfaW5mbyAqaW5mbywNCj4gY29uc3Qgc3RydWN0IHRpbWVzcGVjNjQg
KnRzKQ0KPiAgCXN0cnVjdCBpY2VfaHcgKmh3ID0gJnBmLT5odzsNCj4gIAlpbnQgZXJyOw0KPiAN
Cj4gKwlpZiAocGYtPnB0cC5zdGF0ZSAhPSBJQ0VfUFRQX1JFQURZKQ0KPiArCQlyZXR1cm4gLUVJ
TzsNCj4gKw0KPiAgCS8qIEZvciBWZXJuaWVyIG1vZGUgb24gRTgyWCwgd2UgbmVlZCB0byByZWNh
bGlicmF0ZSBhZnRlciBuZXcNCj4gc2V0dGltZS4NCj4gIAkgKiBTdGFydCB3aXRoIG1hcmtpbmcg
dGltZXN0YW1wcyBhcyBpbnZhbGlkLg0KPiAgCSAqLw0KPiBAQCAtMjEzOSw2ICsyMTUxLDkgQEAg
c3RhdGljIGludCBpY2VfcHRwX2FkanRpbWUoc3RydWN0IHB0cF9jbG9ja19pbmZvDQo+ICppbmZv
LCBzNjQgZGVsdGEpDQo+ICAJc3RydWN0IGRldmljZSAqZGV2Ow0KPiAgCWludCBlcnI7DQo+IA0K
PiArCWlmIChwZi0+cHRwLnN0YXRlICE9IElDRV9QVFBfUkVBRFkpDQo+ICsJCXJldHVybiAtRUlP
Ow0KPiArDQo+ICAJZGV2ID0gaWNlX3BmX3RvX2RldihwZik7DQo+IA0KPiAgCS8qIEhhcmR3YXJl
IG9ubHkgc3VwcG9ydHMgYXRvbWljIGFkanVzdG1lbnRzIHVzaW5nIHNpZ25lZCAzMi1iaXQNCj4g
DQo+IC0tDQo+IDIuNTYuMC4yMTUuZzQ3ZmRmMjIwOGM1Yg0KDQpSZXZpZXdlZC1ieTogQWxla3Nh
bmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQoNCg==
