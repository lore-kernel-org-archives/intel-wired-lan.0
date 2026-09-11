Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA41C88E4D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 20:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EED0580E85;
	Fri, 11 Sep 2026 20:59:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DIi03ud1zh9q; Fri, 11 Sep 2026 20:59:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1245980E8D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789160396;
	b=IFJsKG74X49uWZLCCoZeDg1sNzDjrg/YbK8eXoHkdYIhUtA8BXUaKkzbCqKjlfzGuErn
	 SzIk0dWFyeRwmaH/5rzAmZBR0x4YQePiWjgjTF/UzmxpKdUaldiLu/gyBI8Ol5je+PZEI
	 qRFkjpWOapoezgN4ofwyPhhxhc+iiqWoxVcq/UJuai6chPFkma0fB/2sAKFcoN4K7+fys
	 KSw4vwGU5Rl8wRrimsDaJzisYvfqXcjZvhvc+XT1k/AY6ZsCnp6hmjocxq5dgHzUnEDgA
	 6SOh4jlz6or+6rNaRi72SMAdb4CFAzKLbfdSLkC6uDR6torTuCnRB8G+UIA58p/SqGg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789160396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
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
	bh=3JlIkIlpjrTN90R9Is6cubeB5JH50gTEsMoDrJBewAc=;
	b=caZCD9aoMs23nXZ8jOSjhHpraLKpOE96cJ2HBvzi/eVuV9BsKJ03DLfLeTkGBnS/f9kd
	 m8G3e5Lm1rAq/IrlZk3P380s8Q4jJkgcNyV1CruKCwApUN7u5kX6kY+8Whjj1KAhmsUqE
	 9eQ+fy9EvwP7aMpVUymbl9PGJ4G78RzDFExG4joZeUDJjK0QalqdYlYMWVmnQjBalNivS
	 KlAc4gOiI6WE0l2ZuINRC1tk9Tf3j0EyjqAjKv37h/V94YZrjEcPaFzvR+rftFNv9VQZK
	 O8zYyjb6xohcbA5ELZ1ZM4C9ESFlRndgCNCGb4D23Vif/7mxfKjGD4Mr67V3AXqfzpw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789160396;
	bh=3JlIkIlpjrTN90R9Is6cubeB5JH50gTEsMoDrJBewAc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UX0RmYLdcTmCpAAe78sxSp2Z1dNciPjdi3WrmtN42XPIW6hVLjAc4Lq7gvj3GX8Rv
	 kdNmFzDVs6eySiuru0kUGgzHnxbNh7kLC1M66+eKasDPMwDiLYJA178tMLn4aE02Wo
	 YzGORUlXXl21CkZTOj6bDb+DKorT46zxxIF92wXmjh7yLzrCf3mn1iFNu+EsHxueIY
	 eFfB+/GzBgkrpnj2OwGuqgreyN65g6MmVDxQkuZI2owps5m3OiicunqLucuqwOQfYm
	 rEgUctPvlaEso7Kimx2WjlCogkf5PWfjwdqlVYvnFBMnL+2Fu2J3yYtFZLrE+jUnqF
	 MzJ19fDeMN4sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1245980E8D;
	Fri, 11 Sep 2026 20:59:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7155432F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 20:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56EFD405BB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 20:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OxUfjr6EKMQ4 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 20:59:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6575240575
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.4
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789160393;
 b=WecHjnAhdbuM3QGNl0oQykNdNaLUwYoQPRJvi7UhNLHWAXWGgY/CdIx5AKqCTa49G89b
 lJ4I8gHhMJV704gk71N6aD7Gf6bgf4YcNo9XZHRA6A9XvvbCpQG4cyIomVop2oXTLh5jO
 84tKh7qvQ17tCCb3qzMUGLbUOAU/oJ9ilLawd9Y9gFE73SR5liJvV3PTMC1yH/zD0ZCTR
 nZBwKbjcXDzlbVGZLsNQC3v1qfosit7HgYXKXGEXeNYiLhSnVR2Uze8eL+FoBsVaYNYa5
 YHbo4wdVQw4lQVQmivTbXTOnSx61spm2Fd62XqW81SELQP21BL+n0h/Eqej9aWmUI7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789160393;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IronPort-AV:X-IronPort-AV:Received:
 X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:
 Received:Received:Received:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
 bh=3JlIkIlpjrTN90R9Is6cubeB5JH50gTEsMoDrJBewAc=;
 b=ssc38zVqEooudp+XgvUBlytGI0t2LZcOXotiEohwLuMy0vx4UwAVV2qf2oJWmsR29YzM
 tN1fPToERq0X4VxWDyWxmu4o3+9nPxB/i8XE0vWCUiDYrAN33+PR3igXFgxXe/mAnbJaS
 yOR5km8qNZtJlS2E0f0DgFta1hdpZ6TYapWjWWf8CBLYXOWGNu5vy4SYiipcBxi+tdCLD
 sLydR3CeF39zPRPgPX1JYQUn761nUuIOfozXWjz3v5GOe9n2ugLITZcw8+JuvEYVf01jG
 aKqUQ9WfydX/oH3MTw9BQ/3fos4mxUQE8d67qhR9flOPV4QmLWcRHhZ8nbmjyD/zdIg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Dx+yDO3v; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.4
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 11 Sep 2026 20:59:53 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Dx+yDO3v
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6575240575
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 20:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789160393; x=1820696393;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HkYAmBfTj16MreBfnQHHdXfXjk4mBKQAwGomuFZhQtI=;
 b=Dx+yDO3v+lfQ40ZaeJS7yPmSCYUCQ48MRlvZT6pNs8fYRqfyGbvjy6Hn
 Dd86WXa/drX4irvUTmTpwWMAxi2fNSkjWL8k1DvhjVoaHo5ykdCUPsGaV
 Q3960mOMTsd84ebGKXXp1KTUxaKXfVx2QG118e057nvEXNoo+Pcci9pNb
 zvX9YwHpcg7gBfEtWxTlQeLz4duxbyDbldeYYDgXutzQk9ovF7ahwRO4D
 0S/b7fcJQWBUHjhi+Ku8xw06qxk3Ky2YNM2RjHNaDUhaEpu3hDJC2V/Al
 Kw/f1eJDXh97gkdycjlcwaByLxaBKcBbUHccWdSc2MbV4G9rJTQ5C9zv5 A==;
X-CSE-ConnectionGUID: iNmHI0xWTYuqjgykakzAlA==
X-CSE-MsgGUID: 19rb1xT2ScKzhtvYbycjZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="139034"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="139034"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 13:58:49 -0700
X-CSE-ConnectionGUID: KhpI2OeTTNCuKQEFLaa1DA==
X-CSE-MsgGUID: SvqlxD8XQwuDK0OKQ1895w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="275776311"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 13:58:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 13:58:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 13:58:48 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 13:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuo47D13QRWWZMJsHNB7k3sRfZ+H6+n74VN/+kvKKNTrcZU63ZrxS4hb0+bERU0OM/dAmSDACwhVCdK15+5WUavVw73Cro16Q6826BW7nD/wtJMZObsYQlnTuhhBilTrbISmcvg/JyauVtIXBrQL6HW2ME5IV1cA0OT5+bMXXMw0wE8VRVf2hwdUadB8CyQ0TxNB6lAD8oU/+Qmr7+8SgOgRyA6Q3b5WeSSUZInGHITGkOWtg6YHe8iImtI4lGZUmgvHmN94fNawr9Bg7yxt7JTkBsZiqkMGyGx7fHlwIDNQlX0VtN+61lgtzVYIt9aAvqR0IfVIGgb7A1g7+5Kxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JlIkIlpjrTN90R9Is6cubeB5JH50gTEsMoDrJBewAc=;
 b=H4BL0Hb7D/fy5X32NWqlQR5otjRSAXSGe/ztQ/ppX6nQhH4lzuhoO0ZDbWyFf3ewYtNxVTuBS3NaOxq5rt6HKwKjwc6zORc20yY1O7kuFpBbX7uvqtF8SLqu4RoCXoPgCsWTite4oGUSmUiLQvaTzx/j5E/pn20DnI+DjmgS1GMkvjloM75Da6TZpEkRb5/pUANdYfuViwNzA6w2ygilW55ZKlQ9MqmXYy0AWMj1iUdN2OQWtIIfKTvCKYk6j7JcjJGor0ZygzAB+GxrzenyT1g+4lPRNmCrPDbDklHsp+8oa7GG7qKFYJOtYFGxA1y2TE1RA22vl54bDChHNxWvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 20:58:44 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 20:58:44 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kneuper, Paskal" <pkneuper@dspace.de>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "Baldin, Daniel" <dbaldin@dspace.de>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Kneuper, Paskal" <pkneuper@dspace.de>
Subject: RE: [PATCH net 1/2] igb: Preserve RXPBS.CFG_TS_EN in igb_setup_tx_mode
Thread-Topic: [PATCH net 1/2] igb: Preserve RXPBS.CFG_TS_EN in
 igb_setup_tx_mode
Thread-Index: AQHdQTwNXHtvnPkMFkqfOhhn7s17ybbJ3hrg
Date: Fri, 11 Sep 2026 20:58:44 +0000
Message-ID: <IA3PR11MB8986DA5A1264AE773B12F27FE5BE2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260910113854.13279-1-PKneuper@dspace.de>
 <20260910113854.13279-2-PKneuper@dspace.de>
In-Reply-To: <20260910113854.13279-2-PKneuper@dspace.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: 7944b616-a88e-4a62-5306-08df10477787
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|921020|38070700021|10067099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: WgwMUkZ6zG8pzCp6LWFnampoiLq8P7sbSNNNEm3CQa91PeKKglS9nKHyjWeOiCoM94aZtwU8KwFGVZx/HyLrN7ajSo0l6aFHz3rHCzQkariNaNzAYXt0xzoSiu1Jfrf4G6zx3SaNZguchCiVJ3/e559aINBBnXvWshjyA2pSKvL+zkdyUihJMuWAtmn2xBXlCZDozqLj95JwBK/JRVNVNZjOIUyd1os5C3Qzh5AKv/dLoSauwbYAQ0w9BzHLtM595IQ50MpDJN8UOEuglHqmTk6SW3serb+4PzhM+FNv9B0IXtbHaoYc6nxmPLcbYH/MKTQ8Xs+823TPuCaqNZPquglTE8qMIH/A0TFBXAP+FGQHIdGkhjrybxn/6nNjF+lf7TygoipuHxa0qKYatmrG+jj6Za38TpByOVxt0e9Sgb3nT28TFsLIsl3DRqmzrWQ6zuraGz5jji8pgnOqCkpGd10WkzBti0NdL3r5PUZNFzpXRD0xygPUB/oN0HFUpOdUfLdEOPOJd7MJP3daK3JXdCiI+tIkpigYCXdOnOE9BRmgWHkp9R0f4SDAcwbrK2LyPqrfr3s+TiHeZOM21600aCLBkaeqWtGGIBVuE/HmLSOMeG2t0EfAdLPTtaIzQLayOXmx4nuArrTxLyNKH/0Y5Q4+2OlzgKLSutBMve1NUf9mmRavKeNw77Y7PLERO18/HyOgrbanIfEWNFja80xvEKV0oSDqg/oJzefNacFcn0+UBGxZ0e39j2lC75Pu8/Dz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(921020)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oI+EvIPi5eTEtV6P2Q9OdAPmjVCtetsWB6nBhTNDwWT7rUCMU+MJbuCgR4EP?=
 =?us-ascii?Q?i8GnJ2lS6piiML6mopO1r40BY/1/CWFt8oLH6WHT9CrdI9Kyw4Nwp6o57ai9?=
 =?us-ascii?Q?0nMTq4rTi6WgjxpAddlGMvmsdGr8g2wWJfab5oT9Wh76nbgZ9xhiXv8DiPWo?=
 =?us-ascii?Q?4oCkza0m/iD+7VEx3pb5gKvwTxKEemOLYZjwP39REDKQGM+5aWZ7Vsz8uOyx?=
 =?us-ascii?Q?VhC5BGZUHdz6gtf3HUL22C+7DCtOl8IWhb6dTUMCGxuYw6b6NuWaSAJvMkrr?=
 =?us-ascii?Q?OVMx2PoPSYZhxqJSblZpqk4YVacDmXBkpnA2oXkD2Rvuf1kHLyD+ci1qkSnw?=
 =?us-ascii?Q?RlWCDuLEfoLhhbY/zpbN//K351sAX5ElUSRzDbPdXrlHznFeqWqTuesVyEyj?=
 =?us-ascii?Q?m0tXOrvBEMAp6Yv2lnfoM1wwKwABBqqdo3Xoqk+MjKzoXFUXTo75w+HQFKCB?=
 =?us-ascii?Q?H7/ELlHe/cBMj0aeeneQVY6VJQPAAY2R5MjC/7zKhOFtL2TpEycMeEoljKDE?=
 =?us-ascii?Q?YZfks0rQvEWUtgkrVmC9Bunt8v3DwS110hVxtmTYE3S0hSIv1hei0CpV+F52?=
 =?us-ascii?Q?79jXhzLo1U/yurTa/R4/cjxC9nRcYd96m6xMIIBm0BoqBnmwnRd4tZzYqSvo?=
 =?us-ascii?Q?rF+Z8/Wgsz07iVLtoQiDNsZC4QHqFzvjZhe7qwXFtF2n+s6fvytEIij/30Au?=
 =?us-ascii?Q?k6efXx2vcx63aV/NM5ZzswGmwsCyZDgatxG8bkYgEgdCbepk7U98WnlfYudl?=
 =?us-ascii?Q?9fihhGnPogChAaPbIMVvfXbJICtM0JuPg65EFAGcJFZDsDBuDgdN9nEYD/Ys?=
 =?us-ascii?Q?VUeVMtlFffllHEO5jiya3rqexB6ndfEYMZmYWJawhn6hSyjWKE3wxFnsi/ZJ?=
 =?us-ascii?Q?n0s9F1/yMw61KcTVaZR5fHywoiWQRsp8/MTPZU3i4RlRMiG2P7dVvaq8CQFU?=
 =?us-ascii?Q?yBnX9tWKIy5XNfkoGOe2A5YRHlW7pbx5ZtenLOlRftoH+MwpkblXdlNJe4fu?=
 =?us-ascii?Q?SQeEumeUuUN1lhlBknLj0nay/LBbl74Do3XN6RvGcltp7SffJyEIpdeGu1i+?=
 =?us-ascii?Q?1Y29VkDtULbMjZgBZFR7PsiIINVi3i4TrsMb2fGpIX1E9ko8q0MI7J77e3vm?=
 =?us-ascii?Q?UIdgWlNfXX8XNs1MyYNuzndXn2QnRZ9EeWT8R/6AIjZ8cCguqrjTNUcFQ76V?=
 =?us-ascii?Q?c7kDNLbA+ntWjmMzrudHeSUWbWvjOGKPUF0c8HO5f1pje2AAVMusT4s4m5hb?=
 =?us-ascii?Q?eFJbP8j/F/GKUicX/N2fQwqJhnfRunIDMLJbcDfD1XQ+rP9C1npEY5JK4UEp?=
 =?us-ascii?Q?t6oLqulhlkEQUDoooknoOjsGaRbJ7STQzpPH2x3aJTjiRfEvuu6MlcL4bUKn?=
 =?us-ascii?Q?0QiA1If/O/tmLLhft47biureEDWPQYBfjIrzJMXqOFLTk0BrGIuNI8x6BYJs?=
 =?us-ascii?Q?PqS9Y1rSUyIIetLpdIPVEeuUvsjB0x5CGvpjKJgRWsshwrbnPE14wq7uUx+u?=
 =?us-ascii?Q?ahdOqoXXUAT6bD7c8hL87wWMuWpr0/CiXA98lyPQIlPsAyNtMU6dxxSqRvm5?=
 =?us-ascii?Q?qHN5OsHmI3mbNtEIBxHJj7ZtHHsOuWGGEU0k2SRPBXNBUNjCV1NcWxPOnfAV?=
 =?us-ascii?Q?sX7d4q1PWUP4kxK85fe5qObrWSXSwDeykJGl6rNKffiSRsa1l6U/SsJm47Oq?=
 =?us-ascii?Q?zoDuAggfw9aqHHpApdvG7ycNqK5dYawJnAPwKjl34gfqxJvZZKjXzcNolVZs?=
 =?us-ascii?Q?495Vv3F6IZwSJC0GJGdg1ho0fnajZ54=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ICsEEaOmAlvK+TVMkU5legxSyQMH3XE4C3kisj2+oAMUEzormP4idzGLItTH6I5xD/A8aUETx8u/cwfzkmggH0Nfjj8yS0CxjMOgs7JfcoVfWm07RNuZJgovPb1mmlivMxrR/XWgDV5FoVOdtqxMJtlKoHwyiunn5AkPjMEtg5WpuonXF6oJggKJ9wRe+zOwKqBYIDt7l0QJuXbFrePEsSbAvauXkAtRWslsm3qPLOWiifqetLNr7ekpd01oTE5FnUTPR79FcOUKyRU4IYlXPI5DacJeOFZOZZXS71VT6IEqkrQ8SLIcUOfXvsi8AeKTBaAqXwJRgtJKj3x5PzoCwQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7944b616-a88e-4a62-5306-08df10477787
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 20:58:44.3407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyoowArJ/5N15Tf/mBAMe804d/WubSNYxqi0WGp1S0atOLCyzqbeWDkEa1DVHrQPh7qa6JGqzxBXQf9ZQ9O6DFwRWD/O0CN2F73TRdLJ7RA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
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
> From: Pascal Kneuper <PKneuper@dspace.de>
> Sent: Thursday, September 10, 2026 1:39 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Cc: Baldin, Daniel <dbaldin@dspace.de>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Kneuper, Paskal <pkneuper@dspace.de>
> Subject: [PATCH net 1/2] igb: Preserve RXPBS.CFG_TS_EN in
> igb_setup_tx_mode
>=20
> Commit 05f9d3e1ae6e ("igb: Add support for CBS offload") restores the
> i210 Rx packet buffer size with an unmasked write to RXPBS. Bit 31 of
> RXPBS is CFG_TS_EN, which enables per-packet Rx timestamping. Writing
> the register unconditionally clears this bit on every igb_up() (link
> down/up, MTU change, or driver reset).
>=20
> Like other drivers (igc, i40e, ice), igb intends timestamping settings
> to persist across link changes: igb_reset() calls igb_ptp_reset() to
> re-apply tstamp_config and set CFG_TS_EN with queues stopped. igb_up()
> then clears it immediately afterwards, undoing its own restore.
>=20
> igb_ptp_hwtstamp_get() returns cached settings and never reads the
> register, masking the fallback to software timestamps. On an i210, a
> link flap increases PTP path delay from <1us to tens of microseconds.
>=20
> Fix by masking the buffer size field, as the FQTSS branch already
> does.
>=20
> Fixes: 05f9d3e1ae6e ("igb: Add support for CBS offload")
> Signed-off-by: Pascal Kneuper <PKneuper@dspace.de>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index d4a897a8c82c6..0f3c728a07fb1 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -1947,7 +1947,12 @@ static void igb_setup_tx_mode(struct
> igb_adapter *adapter)
>  			igb_config_tx_modes(adapter, i);
>  		}
>  	} else {
> -		wr32(E1000_RXPBS, I210_RXPBSIZE_DEFAULT);
> +		/* Preserve RXPBS.CFG_TS_EN so Rx timestamping settings
> +		 * persist across link changes.
> +		 */
> +		val =3D rd32(E1000_RXPBS) & E1000_RXPBS_CFG_TS_EN;
> +		wr32(E1000_RXPBS, val | I210_RXPBSIZE_DEFAULT);
> +
>  		wr32(E1000_TXPBS, I210_TXPBSIZE_DEFAULT);
>  		wr32(E1000_I210_DTXMXPKTSZ, I210_DTXMXPKTSZ_DEFAULT);
>=20
> --
> 2.47.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
