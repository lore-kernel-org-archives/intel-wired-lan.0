Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98557CA5FAD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 01:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F0F781129;
	Wed, 30 Sep 2026 01:17:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5F9OLdoRPUEC; Wed, 30 Sep 2026 01:17:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AB02E8112D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790731024;
	b=PIZEABAKU3AkQ18mL1jr4bhjPgX52fTL20y5aJyXbKq7xjpOolQd7uwOsyEw6+MR7jgU
	 n3Xz2tRkRu4tWAEpsUfpIByRjcN2W+junQyV5SOJLG3J6xmZCTUxB/75gmrlnUQuxAOvn
	 vYxBENpaWXrSGRwOWH6gbjSZu8jeTQAM8HYpMIcp3xYbjFZIwGucsG2z0Z+NwHjQTjO8Z
	 oOoprijdc3BThWOSouPC4hhhuUMt1v/XrHaksIzYJ/HWLIvlnZsOjvVO6ny3XeoXPDgLr
	 SRgH9MY4W9Qi2FdULKXCRT7LpmQTjyNEmRcmNpW93dk4tyLi3ld7co2H4Eo0UbXj+IQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790731024;
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
	bh=bmV/LbzoM0gnt4WG48Eah1umOh69tSNcYndfnCBQKcY=;
	b=bqtFIFFko8wwudA8JgnH4IccEIS2PydQpSyIKQ2LZ9xhOel3hpqrtYP2X+bWJpacs9wH
	 cM8dRRSNwLIQFOGp5ud+to/7HjdfkiphllMkuSgbT7MC6KnXGmgNWo4oyTF+6g5MJA1e5
	 Ih1VMbzeNKY0iW/HtsVT/tx3WGA/yhHu4R4ZX0HbuR6nUuS8KKiEVd8ryOAUQ2N1573Wt
	 r62P9LxX/H34dWp0zYCDLoQDtuDQNBOawnk5KbhheqtTkpEnigXz+DnitStRO8o7g0mgO
	 G1azUsrK6Vx23AnvsLDRIKVJIR/VyxlwnTlaqGgDM730D22V4LfqzHZKtbBBYJwUrxw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="JY0DTk/Y";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790731024;
	bh=bmV/LbzoM0gnt4WG48Eah1umOh69tSNcYndfnCBQKcY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O4vgr56+Y/9CFZxdjaiwhep0JU5d8D8ulkSJFtquCq42ALhAJbk0ZVgjYC2iQ3/6K
	 4LGEs4Bz3f9BteR9lRGz9oeB+/jdwWFVsX2hHupeLjfHqqtsTZQMl8clzZs5V9wITF
	 NgFtmOpkouTgNrSNtwgovA9+qIzxJn9V7R4gVwgnf0lv0SLXPgkWrbLPy9me0isKE/
	 H9C7CP//cQ1WUOD2/2qmNlgDjSeelzh5c4OOaAy/KmbmluI3jJEdAwbBTQHhJ9rBRu
	 2e8bMLpCj6PG/6plUjRwd0er6x8+a6166/z8s+jMmppL54Buffd3hgqNhcF+JmPMaS
	 XHRLwCxzd/u4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB02E8112D;
	Wed, 30 Sep 2026 01:17:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CE2624E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E35E8112D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZQQB8DBZ3QQg for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 01:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A378D81129
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790731022;
 b=GCuxSDCReoSQPPjXRxO+ZRdAIBDzlcpMdI19O6JlJcyOIGP8ce6Fg/fVV+WGbBe9js2R
 9U/Sd4lhJWxtK87olO/GeOpWmwBDHsmv7R7GqadayAXUEJUJPxm/MSN+ukZ8ePdEyP1lP
 4bsPDBJKcVZP1c+MoLoMGEFjtSJSjMCKxISoCVlaBsKYbcJpYBcuV5eiNyBjCKmxWHxwz
 aT8XIlhBALa80Blr5BdQH4+K1Lm08oSEoplpFPlmes3QLQvQLrCmgy7c5cAyIQFAV8VoD
 mqqlGFADOzwu3yiD2eka5sqzVKKWnz36+dOS7woxWJUYMX+B+/gZ6p1+tCAUVr3iq9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790731022;
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
 bh=bmV/LbzoM0gnt4WG48Eah1umOh69tSNcYndfnCBQKcY=;
 b=C9Ok+zCZay/Zx05iz90BW/KVLHuJvFtvrI67akVaxA6sGxABB1ltCNQbuOIl7GyHB/1X
 JxJWEGv83Or9GUBHYBFaIDs7MUQ3pz7ZE5Uzh8Nv4RtIlbBTvIbTYc/fiktHgcDQ3tVvs
 uHvB66gcHZIlmaoY63BJpQz49y9egIYogChJTdRjdigVx/VAGsFm+Gj7a3I1Y8kkImzAG
 rOzDh8w9vVMEJCKt5Cf1eq2mUXm3UPzPvxNFbYCdG1+nBNHXBtVnakE3991zoFakIM35D
 UCxT5HRVv3w1T3bLMBBrDt/kVAM7A8JzZs4rTOQoYLCAD4+d1KQnMfngKgCFH45VCxA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="JY0DTk/Y"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JY0DTk/Y
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A378D81129
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790731023; x=1822267023;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=v9mHqfTSSrVzQEfdKAxgG8bDn/v7AtAt/BTXT/U6h9Q=;
 b=JY0DTk/YXRGJxLlfRG4Zd3G2Xbj9VbJmwVgqPm7OZgMcx9YIYUQfEIM0
 z20+OReAB2MKr/2cbmfq3mJw4gODnicdkRPMLsoB4Z8leZzVhhpZDYqjn
 12QFTp6DUPczxChySdzt8528jmJJf3uQSSv9BDJfxuPISQl6iFrvTzymT
 m/k9tRZjZdlB8rUY+xq4y9S0s3rnhjR5WwBrYhYw1YBA8vzUjlScCRwI/
 LaB4bPZ0bNLVvT/1TPOgpt+LcJRoZJtxer+/uSFucfVKqgoXp5grPXKq+
 QgoCnX+GJ+x8dZutPbF+OsOLZhZ4f0TkNmVHXB3HjLllHft6AfO2rDAET g==;
X-CSE-ConnectionGUID: 5MabAwcuQ0+jXmlVWojiNw==
X-CSE-MsgGUID: QPsmgSvNQb24u4sNNBDHzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="116990214"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="116990214"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:17:01 -0700
X-CSE-ConnectionGUID: CWY/tthSSoalVKGfELLKHw==
X-CSE-MsgGUID: gf8qXmNDQHiyOkD5bHpr+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="313485548"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:17:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:17:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 18:17:00 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:16:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSrpBToiAJ14bka4X/hW+3QR/MJbOqkACYkgXrPNkGw7+UXeT/CxxuJ+71ZMeuy1Kcno9Eysghen4MjMXO9MMePynPDwxVdrQgaGx7GbpHKGEqPyxAzRHacmay2RpVi7T/zdWBsmMQRPlL/p58TYaqBFkKXMOOtB27MKyqjlBoWoSjIbu/D/1/UU0i3RpLo3+sH3lFjvYQZSJ1egu2/CKO61gU9l+NKQLQSkVfEn8rfx62/Yqnyphbvfs2jkTQU0d9gC+UwYO7FzV3QiTJWZbcYpuRhCJnZZAvv21dvltc9M1QxdfC25qeYxxhfrn/9pa2nSmwqDBQEg4RVHHGcxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmV/LbzoM0gnt4WG48Eah1umOh69tSNcYndfnCBQKcY=;
 b=TPnUmcmqK4BJBzeZ+E7lTvpHgEc5bIxA9j+pf6i7dnAurY3CGImTUMk6s85j2cMVpn1idofmQvmLMSNjpR5z/7srYAzsqgdaMpihb8XK2vZr6+6anjCF1R3mKuFplNgxcumuezZTIfWwdS97ijyYqqU2VHATkOXYkItS1kN4i9w758VutOuv+BzvfU+EYoWSXZIhaPd3+EuIidDjwpYjKTRNmZLl6LjI0zilyPpOrOFsRPSX4dwHZZns+KzLbfCgkSSjjEchRxxPrkJSlmOpCVyyg8fv/hGFTySXbyXHY6LyMBfd0LhyojlCU0J5gW49jPjUxEd1YbFjJyKn8nLKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 01:16:56 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:16:56 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "horms@kernel.org" <horms@kernel.org>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>, "Kwapulinski, Piotr"
 <piotr.kwapulinski@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 3/5] i40e: synchronize reset
 recovery with device removal
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 3/5] i40e: synchronize reset
 recovery with device removal
Thread-Index: AQHdJKcSNcymdUMav0eD5pCAGeHSIrbmqV7g
Date: Wed, 30 Sep 2026 01:16:55 +0000
Message-ID: <LV1PR11MB8790B06A61F0E6ED4F59A9E1908B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
 <20260805065132.148625-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-4-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW4PR11MB8291:EE_
x-ms-office365-filtering-correlation-id: 2d337d9d-09e5-4771-9829-08df1e9084a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: YT41KaUdapFuikSa0Qu/zB9M4/VrRNaIibqJdm5s+Zn8BGgb3OWrmzogVJq17YfBpwNi9LJut216pM/KcWSNtdyvaoLIroVJegI5mc3HPNapmkGzHJuJGGmfc01U8VoXtanly30pDoMt+xr8bU4+syW5aMyTeNfd+tlEQx9xHUwIchU7pF0MfqDCZytP+8kZH9CVKnmlkR2dMrPfPSj1WeueGW+0c2Cp3DJe17g28y/yUZRObtz1yJfjKpSHJ8Wum+hPWRiqfGD+sSLB9V48urLuDG3cAkjY5V2z0bbHV7KZZZoJ5b+hqQvLAREs8MWzpvI9krhGgge7l60QjrjfPX24fPX0mgqRyJqedq51q7bJkbXJ1Y0iJ4S+UnopF/6Lo+s1blypO+MF60xDzyu0zCv0ZjxVrPHbmLPw1efEhXQbEVqPNz8GE0IbEHeELmyfyuG0TKChpknw5LL55NXJk5y3T+0U4h+39rz5ACX8Lmhc4cSdFQ7dT0WSrPNaC7Qqs4FaNoFLr3foemwZRMfPKbuo8lOHLxSzBbidsKOqdNru87Oauoj3bliNmFBPXCqn2hLVApQgs+vF506HttU+EZZiG1+Fx29knPasMwQotslBUh3TLNcEKoXV81Ue1vD+SF8TUY+n5hHF56xRKdNrzxP33B5/Ym7yxsAYVUXTTLotRm+eo8I7zGoymwkrT0caOFPvhq/6rtwrTmmLPydKDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NuW7ZHhpyqCZ0Af0Z1h6nK+41HDT5J7oxxrJO4wr1SQ5Z8IOh0qHos+EA58w?=
 =?us-ascii?Q?sRYqlWBDTE5xBGZDpnrd5lCp6PwpJmDK2Z8H+KdVsHwtaC9NG/i4f1vPcZCB?=
 =?us-ascii?Q?vXgPu2Afw1xnJt7YTls+8x/ryc7WVhEUHzbfUPHSyrYiSTotOjXOSJqWt9lf?=
 =?us-ascii?Q?lNzNdRuSrOsz8z9a7G0XVx4QchJJxXxnmfWvQl7hM3rQeyRqDtDopwi0uMRc?=
 =?us-ascii?Q?0hSkfsFDbBsfPh3TlKbgVVc32D6fI4DU9QZUZbgpMZOYsTb6Qt3EV+FWwTtM?=
 =?us-ascii?Q?AMTTmEC2fuXQ7vOBz2olduwB6jCUQL4tB1vk4mZA7S7s/nggIIazRIJnTwj4?=
 =?us-ascii?Q?KhT9KkJKzFxVGCKvdgCpnf/YeP45V+1zBI7EsXvNZsFe3uDw8nHQGhPduPMW?=
 =?us-ascii?Q?rszaR1JEVnmvxedz9Sl7/9gJ1DVe7Mf+P4bWuwD0rU0vh7j9zihcvDM+d97T?=
 =?us-ascii?Q?VX7ZvCECS0R406dJFja6ZWBpaGD4waI7u4XYOUEZQwqMw3RrwAB/9JUS3GpZ?=
 =?us-ascii?Q?1DMzVh65Wn5VAa55EYWFjNVxpC7m1ek8PmLLxtR7X0EWjzR0VCbLpEh+4/mV?=
 =?us-ascii?Q?lXM3y4XgvmRcuUGP6+4IiTMf/fvYUjn2+Pp5ltluwC/NJS4nsrJLnhGqu/AL?=
 =?us-ascii?Q?zyZsw3UkZXyUu4YzpGx7fZ7sl4zo9uY1cBAb+uLgCsb3miwYpOmK8vcQ99Im?=
 =?us-ascii?Q?c21wKjWEy+r1vfczdh6DCZHOR1sZSZj9LWXLRUaETyXPPAqm83b4n0P476xz?=
 =?us-ascii?Q?x6u7ddWwmV8GexTMcH5Gtl5gallN04By1g0V0hAklC3cwmo1clFhc5L1GQZA?=
 =?us-ascii?Q?zfpBKygHOcV7nJDQe9O46nSivDfxP6S0S9f8wAWrtdbm0BGptd2kXQ+zhDr+?=
 =?us-ascii?Q?yZJp0oFDUsVpAT8WSaYPPSwwY0sAgNmYG8IZ37Lr0itsYJx/vM/6O3wRnVw+?=
 =?us-ascii?Q?qEMdCNQKqXsY+K52VLC5LjzmvRa2rev6lCcYo5lHmEFGJUTve7oCh4rPukig?=
 =?us-ascii?Q?hU6DYD4WUfUOC5j+xb+toFhXvt7V/rYTm2hZNe/Ts0yfL45RYtMQrMa8cpLK?=
 =?us-ascii?Q?APgYcRIuq6cvDw1dMbvZHzLmaUvn4XHcQowmVDOigB3s16sXvmVo92BtS7cl?=
 =?us-ascii?Q?tkE8kr95kBlxMoe2AeJJXXUrlKJe66GudzJAfc6B+YGSslf3GhXH2F8TyqHz?=
 =?us-ascii?Q?NIB4D3cDhy201zCFPK34pLdiszp1ndmZ7MP8ZLgiQ1CGDbge2EySg9shLDXU?=
 =?us-ascii?Q?86VajDGCJKKJLx6Q4V4xRYJIJv2MQyiOFX+pQxvHV9LPLZQxgK9GigDhlH0R?=
 =?us-ascii?Q?90xYscHSQ5t44HKtEWTMtnpmjl1jebb1tCTpPHwgER70s6EUrDpxisPga/At?=
 =?us-ascii?Q?xjS47+is45E9RuqvVaaX16qeIihlzETDrkGYiwi7B/io5ynlwiKsfDcM9nMh?=
 =?us-ascii?Q?Mk50GyYFDiHkqYxnrjPOW08tjNjjlGtZxYtXk7YOZq9I/9PME0b28v6KkW0L?=
 =?us-ascii?Q?q/ENXWm16yimHB5TORySDQfyVnOOU+55jnW/r/Kd7SLVSvm4/QCvauly3F/N?=
 =?us-ascii?Q?fUGnw9PHEmObLA9kb61RiTGwuA5Gq+DcS/e2Clp72nuHpMYKbiSXWp8kY8Oj?=
 =?us-ascii?Q?J8nKm7epj/61bid9cZYXehDa26F+DpGAf+wu+gu8FStHj4penJgZ1shyZod/?=
 =?us-ascii?Q?zqzfT9LtYSFwyFe8Iv3erkuSkvVu5cDri6Rtvve/j3Er4zwyGxcRL9FBnC9Q?=
 =?us-ascii?Q?4n11RCzZkQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 08NsQKQccCpspOvyU8TNHq86bLRydXsnTnxR1nx87Ck7NH2EnljUcsF1/lVtMLH70wCvFMJWeSc9NKdfu7pe3DMnInmXrpn4UT9VxS8WfJ7Ib81IMdFl17Iqd0kkHbp+AUNHm4buP75QqOGCXkRnJ0RJrl0OZ1zqQ4oNzxb7Dw2GIVnxLISG/qNooXistdYwscqsBGldP2hypM/MAgK8zSuZzwNNor4uGRGPzckb29ssw3bdo9OpbNpEHGA++6qL9ATxfkAfkufzCkM3otFHYZCH3jyrChGILPgXSLyMxYwZhp5axqw5mTqveRyM5kuD3O125iH/se5wI6kYYwHzfg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d337d9d-09e5-4771-9829-08df1e9084a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:16:55.8641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxHom/XHdJM7Cz04fKR2xyLuUmqgoz3b46hlm7s1RxETCz2hW47nv9G/DVSgCIETk1rEKkjtCH1jn7A4z6cGF0KMqUHgU5P84PaBW1Io/Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8291
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of x=
uanqiang.luo@linux.dev
> Sent: Tuesday, August 4, 2026 11:52 PM
> To: intel-wired-lan@lists.osuosl.org; horms@kernel.org
> Cc: vadim.fedorenko@linux.dev; Nguyen, Anthony L <anthony.l.nguyen@intel.=
com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lun=
n.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@red=
hat.com; richardcochran@gmail.com; Kwapulinski, Piotr <piotr.kwapulinski@in=
tel.com>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Loktionov=
, Aleksandr <aleksandr.loktionov@intel.com>; netdev@vger.kernel.org; Xuanqi=
ang Luo <luoxuanqiang@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 3/5] i40e: synchronize reset=
 recovery with device removal
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> i40e_remove() currently tears down PTP and device resources before claimi=
ng RESET_RECOVERY_PENDING. A service task can pass its initial state check =
before removal starts and continue into reset recovery after the remove pat=
h has begun teardown. This can make i40e_reset_and_rebuild() access or recr=
eate resources that are being released.
>=20
> Stop the service timer and disable the service work before claiming reset=
 ownership. disable_work_sync() drains the current service task and rejects=
 later queue_work() attempts, including those from interrupts. Claim the re=
set bit before starting teardown so an existing reset owner completes first=
.
>=20
> Fixes: 6533e558c650 ("i40e: Fix reset path while removing the driver")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 28 ++++++++++-----------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
