Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F1606A31B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MzgYEVzy;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Br4yYSNx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1CB98110F;
	Wed,  4 Nov 2026 18:31:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HTDrvYdq8ihC; Wed,  4 Nov 2026 18:31:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 338308113B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793817116;
	b=mPWQlk3Hrp3MZOxgigoklmC2vyHwG12m9fggAtOlt+kySJmz2jT/Ph99hXHmSQivs8/q
	 9ZjOE0YIIuO2XYkajDW6oc+sxyc5aikHP5Rx/RGFPot0Owy+5Ocgu2gSuSnikkH/695Yo
	 ywFtCJhvV7azEfVzH84Z7uxtJM1MDUMYN/GWVQ9q2y63tRaZbrnudr6zvuSWuaQR2KaCy
	 CaOdVaAECNx8ZUT5x1/gt0ThEAJB8ySfpb0HLyTFhkQgtEoJhOnTYTkcYvRPzRgyYXmgx
	 1jAiB6kWw++JDuXX/Ajrl97OF28DLatOfroM3NxbNCN2/worPwl3mn/3hZIHPIuGm6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793817116;
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
	bh=B63MW8DPUASrjWOlxVQs3+NydYfsSbj5Njg4D+s6n5E=;
	b=FsZRNQ5AL5mdTfqwnvXMSlhHpXQMu5/A6RBFRjZhaa8QSd0n+8hZOZvaqptgdgTLFH/W
	 5nfqYwQXDrX4OhdZkHg1h/RdMkGS9N14gGS9MCxsKeYBn4RpqDex/jnQzmvIQ8koe9amV
	 +s5IbqMc3uCS91bBCaiERGTKzhZ1TlVaHOm/eWgNXE3e1dQL7IfNGwxtZOPYgI+Ry76gE
	 /IP3jP7ne497qJUhmx8dfhubpPCGLKKpNhiYqS1MLQAvVAJBVPPwACQun0RGFnM/pRBRe
	 vhd5sKU+SkNYBc4Mf/EQwN8sOVZ5K+Eez+OS0TCNQ8CcMoMLTjcQ7nW8LGpbmUzVH3g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Br4yYSNx;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793817116;
	bh=B63MW8DPUASrjWOlxVQs3+NydYfsSbj5Njg4D+s6n5E=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MzgYEVzypW68IzohxT2EF2r9CqfVtweyXHVInKnRaXlsRFfB6ZiszpeJoXlYPjA9k
	 lgqs6UGnzqVJqwv+fgwDMm35XwTJZG4dKIGxFLfeiKzub4AQMekgu9+FvEd5hWiNVk
	 2ymIe1P839zm+iTKBnKhTD0S/YVfNBH/FR7BgyvYVgldRFCr130tIVQcdPht+rBXdp
	 SLU3z3a3yEQKsCYuEN2BxrdV6V+VuHyntsQNutWzlSQiFFeOB0MiSxIBoIGdyS2gNk
	 zrWK11zfUIHju6iNqztvO8RaoGJmaJOr4hZbZutD3rmAgHKGU++6Ph15kRinTAsRN5
	 GqTilAoFWqpRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 338308113B;
	Wed,  4 Nov 2026 18:31:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F14B61788
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 18:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D71678113B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 18:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tHEGR80PUHGm for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 18:31:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 155858110F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Br4yYSNx
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 155858110F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793817114; x=1825353114;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cu4RvyOfc1zamM0SnCMG29jn4kIQrdNKFZYYFHhBF4s=;
 b=Br4yYSNx0I4fBJTR5GjnTYDYHJ9yN30s0D/KarQ8ZKK7soPNZ+/wifEg
 rk1cyjcMbsGrDcci84iXQ9JR7Gp43HOM1qguwv/By1GICwtGu62FQENu6
 uG0b59MC2KFXYqGWDWZhLIgSMR213bPSAOMeEA9UJMIB58aelH+/i8M0K
 f9x8xohilmnc1+fRaM+JSHJKNivWbGnpSvFJypYd5hp/mLGh/RWFBn1yN
 83Zh+/Kqlg4HTSrWlonkDP96uaPUeHSpSLv5ya/7D6s4svySMpR4oFxBP
 YNgfJ+XX5p850XKtfe8UCxeuSf3qz3MOTt3yEZ9QyuHcZ2llSjzxJ97FW A==;
X-CSE-ConnectionGUID: PsDbfEuzTkGClDPPKu4LtA==
X-CSE-MsgGUID: C5V+5dB7TfW50NAODRzdEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2459757"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2459757"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:31:53 -0800
X-CSE-ConnectionGUID: 8nBhZ4L5RPiISaBXHaElRg==
X-CSE-MsgGUID: OasudVLhR7iz3J87cN0+qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6618143"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:31:53 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:31:52 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 10:31:52 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:31:50 -0800
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by DSVPR11MB9719.namprd11.prod.outlook.com
 (2603:10b6:8:352::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 18:31:44 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 18:31:44 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Burra, Phani R" <phani.r.burra@intel.com>, "Zaremba, Larysa"
 <larysa.zaremba@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
 "horms@kernel.org" <horms@kernel.org>, "brianvv@google.com"
 <brianvv@google.com>, "decot@google.com" <decot@google.com>
Subject: RE: [PATCH iwl-net v3 2/2] idpf: skip empty netdev slots when
 detaching for a reset
Thread-Topic: [PATCH iwl-net v3 2/2] idpf: skip empty netdev slots when
 detaching for a reset
Thread-Index: AQHda/E6cT4cYOxeo0WC+/srUAf/M7cePY1g
Date: Wed, 4 Nov 2026 18:31:44 +0000
Message-ID: <CH3PR11MB5668952D2735E1955BC05D0F68E5682@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261103235354.1063721-1-emil.s.tantilov@intel.com>
 <20261103235354.1063721-3-emil.s.tantilov@intel.com>
In-Reply-To: <20261103235354.1063721-3-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|DSVPR11MB9719:EE_
x-ms-office365-filtering-correlation-id: b2055380-ac71-42d0-3015-08df3aa1e0a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|6133799003|38070700021|261102123227099003|4143699003|56012099006|261009223027099003|11063799006|261022105027099003|261026140227099003|261022075727099003|261028144727099003|261021121427099003;
x-microsoft-antispam-message-info: uHl3nYpWSgZCuNxI72vJqYWdw35dUpKzyyx80y7ecEu/8s22ganEAuZPnpuMrxZm52B/61fmXTdeTL9TrJ2lcdehHOGH8b/JUQy4ZaZH9mKP5qbu+kxvMtkDZwge4vNQUgt1ZdOzXsbeJigD+u1qnLkVdcvuKaNaevM1ezcKgtu1KG9iwtrK+4pcjgCE3gpsVsv2kB7kdoAdPMSIzidPy+fQ/twc7+ozfJ9aLGlL6GPgQCwOwNLSQrKGPxwwIntcYvvv8cesEvZq6td40mmCLO0uA8ikY7V6KJQYJ5Ei13BiJDrkicU2IgxMSof/yjAQ0WEEM6gg8FD7jeVElMbiqu2mntzMG+qGszqiNXdM/EatysGO1TVqaO28nPmOs/MB92ioIvRbHM/LLMZklCi91P4MqSqKbb6/Wl3gPvTH2TwtJktQkofqtzwXOEXzoE3LXYdw16nT3M9vincdT4RndWRrQuLbkTwDj22AFOJ+jKi5SUhi5qWiYDZSuXYhClQM2g3c0c8iWdTLbBAU9pN0hxIiKC33yhgzDtlO0Q/goAFZry/WBVTsV0vOUxvwb/QLWF7PwUWiuwxTNeS9Z6d9GfOKy1O1WOa06utzTq8HiLHLX0VHuR5t3Jpa0+tK9D4uAGpr8bIIkuEBeJ9IhtOKeP2HZ31wmKNnyJPt1gPm/orfeKkP1KftEoFl3P7d9KxQuyCaVXnYuIwQ5tdzaDqEbxPLoIAP+xy8I59/IDiQbRM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(6133799003)(38070700021)(261102123227099003)(4143699003)(56012099006)(261009223027099003)(11063799006)(261022105027099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mKsIqMGEJZ/xSswHQsbaOsADdVqtFgVfgjkkse25odoBFMRUyA7TxP3/vxX2?=
 =?us-ascii?Q?OwN31LXAJUS6ZjnoMzr7DWOhbd+YG3k/Kdz1D06RNwQhoCJgjgXwGcxAelRo?=
 =?us-ascii?Q?LGWqfpQdU87380q3XZmxXiv0swMKN2NU3S07AKOxwWEwEM1mc8LV0D7Txh5q?=
 =?us-ascii?Q?RENSPjGYHH0FUdx/EBIwo8GWWchX/vjjkZlUPuFEsGurkRkkoX9mepZwXCnV?=
 =?us-ascii?Q?2BkXwyuH7NKkcbilMjl1hrtKdVAsz3sSdatomRZxWVnV4qan+z39/910K3qj?=
 =?us-ascii?Q?NPkqw9N6Udn1WoW7kQMZTr6zzA94gC5xt3lE8MTjJQ/HBLIONv98NtzVEKj2?=
 =?us-ascii?Q?WdTa3IIsxrQSlc8s+b2k7vcOgXumUcAueQsEytkvjwN+y+OF19VSMVpsxXm6?=
 =?us-ascii?Q?83Or1mwHW8Xdjp4q7PMS5VeNs9V/6L+O/uBBk9ireHqlDezarigy9BFoHzJm?=
 =?us-ascii?Q?M6nG+5sztBP1gtqYi8dBrpToQSmtXqZ1vq/ET75qE1mO7ujtcXz1XkMY9xwA?=
 =?us-ascii?Q?HYMytw81ON0qNK0KZsYhLTUUkZ12U+BXEGrYRU2n6Is+QesgVhwALjfVStD7?=
 =?us-ascii?Q?1itOjJR5RFKl7wqXTShHWeKCoLvZA85KzCyBPu51YH95v+PkIdbGknccYaHG?=
 =?us-ascii?Q?FJq45KS3XrAiUibOtRcj+YAn/ED2SR9EweT/IGvwAJoD674mcCkkvrStJ4rq?=
 =?us-ascii?Q?wLim4EOH/DYgnqGDIeawugRHmU0UvAhAds/H03NDLI37szIrfiidkqlVsrN8?=
 =?us-ascii?Q?scO09+U9HbupnNsP40XSnc6mtzd8GAMWyFHFt8vwVyhMjn/SQ+tC55zWB0mG?=
 =?us-ascii?Q?UwNeLVd3we7ad/zYLgvYtzasAh/a5dsniWwj53RmjypKinE7JjHqPNJ22VPe?=
 =?us-ascii?Q?01UIKbLdYGMCT9vdV8Qls4MLzlyK824Z+KOUSJxZegJaumO02SvHs9hxXIzj?=
 =?us-ascii?Q?g2+6TVcBH0J6WL8EnPYreyHWEU09/svOxYpOaggbjf1ElXEGclEKzvpqAMnX?=
 =?us-ascii?Q?DjLZXekifHBDv7vBrBGpm2iglwXOlhIW9PS0gRghpN0rBiWy6MWcXUMvLau0?=
 =?us-ascii?Q?1EQ6g28Z7SRR903YkEw4XVsvSXBJvxug4ih84oiMWrlbOjP0U+pfWoYkEU6m?=
 =?us-ascii?Q?s8cDVETaIuN48/IC7ZCKHsK/INArCgvCxiEtlLUSadOruq/LdWyi3KJrbr6S?=
 =?us-ascii?Q?TkgZewmc7QRvk4vaxwPl5kbjNd9v2/sGRu2Ns9IOowegq1MaTHY4Ei4mX7fR?=
 =?us-ascii?Q?+OW5oQiQt+i629Y4NzgenL+DQS/tTsBDVKgPy7r4UpE0ofwn3G2i2RfIs4sI?=
 =?us-ascii?Q?xF7ztP6dFP68XkhbsXtdUPd1MXpeqb6qwU20ATDaK1ZvMSkO+JzTyELkKWyW?=
 =?us-ascii?Q?PpvBL3UHu59bTJ7qGLsreJ+4MWz1zADS0GDWnzrJIW0RKNaLk+VnbKCmXg5R?=
 =?us-ascii?Q?CIK9PvLAVXPeZLhtyget5JGhygzI9x8dk6R+xt2g5vMjIfsYZDgnwpSMHvr5?=
 =?us-ascii?Q?+WxyB9fcSQAJahnBp+3IMe08eQgCVN3jA1aajDKY3eLuYjcCNOUpxkih+JH0?=
 =?us-ascii?Q?Zmr1gWjKVdnk+KXxej8GnzNQnqHITi9sVfC06lk2ekcCeTyVKk8rJgONY4Ux?=
 =?us-ascii?Q?b79E+riGy/xtFk33A2tgxAAf3HiRWAJBnoreTc/mV8hATw2YZKf8MQnLf6+M?=
 =?us-ascii?Q?QpGwj51ibY3Ih7dXVOu0O7Uf5I5wfCI/1o08qlFQpAElKwv0WlyuxDULmi5j?=
 =?us-ascii?Q?ON7bpOVXlkMLC2CXnwkR5njbYpidc/U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E2WRfcFcc4zcI6BbbEJt4USAOZ4GriyFzwOLlUB5YjFIC6FSBsCTwqlGuzWAGCHJYY3+d2dJCzEaDrAlQA8OFk7f9HqCv153FpETAO0uQiH40xJvIsHie3wX6TrAyXKdkiE3mQKC6aHb0Dkv82NfiTMOywukPmEiakRxsTm12yl57Vp6wir3glUKBX1KfUYkU93PPlzAmwSlAssvugkTmsnJGQZyy+AQq5ULosluQMM0OnHnHPQazy5t8JMXFY7VH1FXh8N3GIQ5tBmgvsIGjHw7T5bNbwXmidMJnKPnE7Zc8hXXEb2xpZUTe19KOD3L1CtBoHUHXDyUP6nvNBwVWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2055380-ac71-42d0-3015-08df3aa1e0a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 18:31:44.2211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/BuD9S/KEUddJVZMDQ/OQUmrcdcP7cze3AdDi9Yj3oSjx+umglSfS03dEBvnFxnXMIYwKe3lDFLh0Xhu43F90ezVYyf2KHSgUtz6sH9TrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9719
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Emil Tantilov <emil.s.tantilov@intel.com>
> Sent: Wednesday, November 4, 2026 12:54 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Burra, Phani R <phani.r.burra@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Hay, Joshua A <joshua.a.hay@intel.com>;
> horms@kernel.org; brianvv@google.com; decot@google.com
> Subject: [PATCH iwl-net v3 2/2] idpf: skip empty netdev slots when
> detaching for a reset
>=20
> adapter->netdevs is sized by caps.max_vports in idpf_vc_core_init(), but
> idpf_init_task() only creates netdevs for caps.default_num_vports. These
> are separate virtchnl2 fields, so on a device that reports max_vports
> larger than default_num_vports the tail of the array stays NULL, causing
> a crash on reset:
> echo 1 > /sys/class/net/<inf>/device/reset
>=20
>   BUG: KASAN: null-ptr-deref in idpf_vc_event_task+0x22a/0xa30 [idpf]
>   ...
>   Workqueue: idpf-0000:83:00.0-vc_event idpf_vc_event_task [idpf]
>   Call Trace:
>   dump_stack_lvl+0x77/0xb0
>   kasan_report+0xca/0x100
>   kasan_check_range+0x100/0x1b0
>   idpf_vc_event_task+0x22a/0xa30 [idpf]
>   process_one_work+0x917/0x1940
>   worker_thread+0x5a5/0xfe0
>=20
> Add netdev NULL pointer check for every vport in the loop, same as the
> max_vport loops in idpf_remove() and idpf_init_task().
>=20
> Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a
> reset")
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 791ebff98507..0cdbd81b1371 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -765,6 +765,9 @@ static void idpf_detach_and_close(struct
> idpf_adapter *adapter)
>  	for (int i =3D 0; i < max_vports; i++) {
>  		struct net_device *netdev =3D adapter->netdevs[i];
>=20
> +		if (!netdev)
> +			continue;
> +
>  		/* If the interface is in detached state, that means the
>  		 * previous reset was not handled successfully for this
>  		 * vport.
> --
> 2.37.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
