Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A58CA5FA5
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 01:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB304810D0;
	Wed, 30 Sep 2026 01:15:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D_BVmASkkS30; Wed, 30 Sep 2026 01:15:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2596981118
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790730951;
	b=ogXpv/b39hvwgX2SRguD/CPojr7l1mrOgkr/r+XQYP4nOkFdOqnDIc4CfhC4bXwfsFWF
	 24RcfMcvChAcq7bIdkjow6HRbxkFjpWCzTYNXRC3pASlfwgzq+7fE1aU8cGKa2Unz8n3h
	 IE2BN7Dk8SajZVVVAE/7VnM//QsZDk1M4h15VjTbC/Rx8hDuhO6DJb+6wxi56+SsdQyDZ
	 Sb6vP/uTRRXJbrd7djYMCywlDmqi7M3REGzDeew7l7+6IdQQOUCea6m9vnfJnyCteaB9+
	 bZsTUg06kTlKfy8nP3oDHtyqh6fapjLcqTuluciCbptHEhuDPRAbhEJc1LFuIht2ZYw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790730951;
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
	bh=OKz+ZAV9B7zxN0Dj6SPNymeJsNOQ9nkfSf+9Rj5fTws=;
	b=WkzeAETmWTIECtCGIzPt+HjMl/X6d5neusMgrneb/MqnqvBsohtlSoGx8ZiKEmMW+1jt
	 PtrQGVrifm2oxeGwuIbMjfSawgllQnnNIhE7PO3zVtEYAppackZa4HHnmFaUd7K36W+K7
	 lUFuxfq7jhIk7SYS3/uq1gKXzkh7jBsKoKQ6o2b+2noGMMiLpMBAvvWYbxEjHAz/iykIh
	 0CEp16qDD0cJw0x2JiC/XXlT3hoVtLbCXaH8wIgv5GH1V8tksvabE5gp50F9RHqUcOlkF
	 BFRmhhnnbr47aeP0ct1bpI37SYU/wsk1Z+5XlqYyMsBJzKYMcBLC6aqh6XvogJVA2yg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790730951;
	bh=OKz+ZAV9B7zxN0Dj6SPNymeJsNOQ9nkfSf+9Rj5fTws=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GJa2Kdl/dr2KTYC1r3JfwFOkpmMhFXhOac/uDGokGt6b/YxRGBqIofvIUmsVoDkcn
	 AMq6MjdF8PRBNfVUNpQfYsqpZR1CyMHIhiwpCdPr58z5z7MBdDUyaTwnqHRj/3BfRB
	 l+xvRvxN6JGKY9FtUaCnvskwMITHvLCnsb0wWXGrUbYlth3CJ88coENphzL/Ay/CV1
	 F+QRGJvdcl4lVzKImtFFRtX/7I6x3UCbW0eai7cqxZB5HeY7B1irA2FJ1CBSGkAzqW
	 KwPdl5srsBwd4srKsXj+jROQ9sHym67Nw+axQqmOCXANOgU9taMH1BSDL6rtPwCPlC
	 PMGKkrPgBU4rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2596981118;
	Wed, 30 Sep 2026 01:15:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C251282
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E65054080A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:15:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gEzNmoSHvfaB for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 01:15:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DA15C40400
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790730949;
 b=Z6F578XpzP5MZL8Zs1tNNCTP0LE46iLwHuV9Ae6vzOXptPjCu1/pZCEWyqXJwEUkhfnH
 rQdzDwrec3x7nSAjT1h4DXO0cm2MV2NBXEA+ZUHuBY4iN62zRaiQdw4gQkdRVplyozpyc
 o7yWz3vbuNXKHhyPNCRi5oPoaSH4taH/E5DH7jEjDTAGWok0tjVhRgVdd+pzYpKbcDGhw
 jVNtFfscuwkU5cZE3UkfN0jzu+YbR5n3PijCd0hTwNaYOAzO7ORK5/h+/fGp31zUizZ8Q
 AJOh3HI6dyeR+i9GQqwXWWRR69zgj1wifZRXNt57lCnRteP5FVwFlMpuAz/ILGK8mrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790730949;
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
 bh=OKz+ZAV9B7zxN0Dj6SPNymeJsNOQ9nkfSf+9Rj5fTws=;
 b=IVUbsgoVoIOrOXDAoMICCGS54DsE1HPoCYU7xd/YIf7ZJdDpzrN7ZdSEwVLM8tjc+qIt
 ooyCNY7H9SPGnoE6eK/E1Nh1b4PbD1uoEBIGLT1JiLXbRXKd+3uxJM5gFCOqUrIDtIZVV
 HZGqcd9TYRIseiP8F3Gd4osDYzO7WBgoolVU817c8xxaAFH6rSBJR6Ryg1m/wNM4uU3bS
 V4KsrjusMu2KzZeG9fdEdMzzDLHisFPMgVOmaqxGnhAsPE6pZfpKthY0LXQdRR2k6WN3J
 /SFGBwH4FgFeSY44ibNcBrHl9eRxl4wPCFjjWy23LdN9lKP0QbFFlcQENExK/Hz3dqg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=O5vTatkr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=O5vTatkr
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA15C40400
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790730949; x=1822266949;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ogQhOERwY6g6QJ6BYihdhpo8ZJYGSgsESxxvxp7zPFE=;
 b=O5vTatkrqXo0SepewMr0yWWRhYztYZQ1uYbkTj9D82M7w36/K7jBL0Wx
 cwl7J1P8hE/yucXMsFcUPP5Wv8o/sTttMuzVQVlNPIFW+xn4ovG9vWyKc
 c3ol3ymfRMo659Bnpp+5MJUzMnw/dPs8lrzY0Gay/xMXOD15tQFcvFIVy
 R1+t5yn08ZHGi4DyEjkca4YdgY4OjDicUOw95Avgkd0gM4W1XjGH+hz/f
 wu/jb5Gka3P9HS88ysYkUjq2JFwDXgudvhT6oibirljsgMo9QNu5i5/Yp
 AozPPBBlvJY6t3rgewm9tE3mFo9yRGCKPdV4UqTJ8HWLpgc8Tfqn5y27z A==;
X-CSE-ConnectionGUID: 0O9S1kdOSU2fAO+bEiE3MA==
X-CSE-MsgGUID: 3R04zpmWTbqSlWJ/qJLe2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="94175706"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="94175706"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:15:47 -0700
X-CSE-ConnectionGUID: dM3QBKqhS9Kdey4xEWxjDw==
X-CSE-MsgGUID: AaKl7TD7SE+HnUVZS2yqWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="274733071"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:15:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:15:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 18:15:46 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:15:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr4VsHaQY0ao5zmbkDBA1p2uQXcVWpUPB6vt3kaeftI9QYw47ytSON/BBSatnsI2qEsXYRPdbqbjnu7NZYfSxequl9f98ALBRnotxj3nnEu/eAK0sOZysAhbhxHoE1b5ISSlYGakYwr+tWYmE2qNldDvurZ6bB78C4CxxlUK7Dwl2rrKQKyoSwj45Cv4umnBjVf1A7VnPe7g7xKEN2hnjZE9+wtCt1qdxmfW0Acr0ZaqB4gwUS2r8zgLZKUKKWs4nuPmtn+oHwz7lDN+S3adUy4eIA+QiuQ7EJbd0CJRRQOWdC7Kasm5TnHXcBy5t/UJ/kZpIgT1IYN4TkzTFHCJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKz+ZAV9B7zxN0Dj6SPNymeJsNOQ9nkfSf+9Rj5fTws=;
 b=GdhftTX17OBoczHC8HArQXYjvLn6fZpqVguw7hMl5A0EkC4VyGD9RNBtpvLTCR4Q18yrD8kau5m0sEqRQaluTATHy5h8KMXVuTnPhUyFtw3NgG2mPZY+vIJH2tOUISL4hD6iKOicX16iXjVm2sJSChYUa0IztbjnJXSqVpOygnk+0boj44RUNgbFI6tSpgEJ65FHGZ7s6BNpUUOXvNgIq7FM/OCF3pnxQgXpdxwYwM5c3QIj+Qp+2OCAYANw//lLGu7YeMPQMMKCIIbMnue0D4PwwFtEjvsqRaect5OlerB/obiBUb3IbZd2IM/c5iTOiu6ggOttcyNEEa689VtPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DM4PR11MB5232.namprd11.prod.outlook.com (2603:10b6:5:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 01:15:43 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:15:43 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 1/5] i40e: serialize Tx
 timestamp skb ownership
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 1/5] i40e: serialize Tx
 timestamp skb ownership
Thread-Index: AQHdJKcQdKGogJj6ckOjvfdiuLTKR7bmqPmA
Date: Wed, 30 Sep 2026 01:15:43 +0000
Message-ID: <LV1PR11MB879021687CA187003D1B9A44908B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
 <20260805065132.148625-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-2-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DM4PR11MB5232:EE_
x-ms-office365-filtering-correlation-id: 2e5958b3-8232-46dd-d2a2-08df1e905950
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: nNsenA8n0m1Zd2JgqJuZxHPJ0ddAnu5LxosqZewv9oAJ0n7yXgJ0fu/2Uy2l5KH+qfd22tkgq4iE5LDTN7+xfqMU4I5QaIRFRagKVndOuoWrwsuFL0dWNpEzpLOyp3dpao0QPa0oMMawyV5W4lgaSekQRnqdp79P5Y00xXQo5bzu7/Rv1Mj75dB/YUhBa68eURCmuEanjTm3nHYAB3HOO4vz+JmB/OGBZaSmUs97Aqyk2LC4aIfC1A+SuD0iKovu2wHIFcetk+9eWkywzwCS1NqBQpNNQz75WiYIEYHAFdxm+dONVb9jj4EplQUGReNBJQxtIi6jDPJT2lkP72eT38JwU6LDTruUYQjYF+en78Vb35XXR3wwnvMRpOwRBf3cNt1G1VCrlqtIuAnSV18ZQDPITXJ8h2H+BF5TrKiVA0O56888JSr7GpJ9AmBoz5leaiztpRoHE7/m1Id8f02CHsCuiOowqyFwM9w1VImWUWKyoYWxMgyIGcvBqUaSi3awUwYCEOFYYAXDjduduMOp4LSmKcjCGgZk7Kt1cN3uH7midCE10WvEqwWd83NP400ltYKIq5OLHaWG5YdOQdruUrd7+LgSEJQvDj/mOf0IgeQjb8800sMW3gWFzBYyqAmr/oCyvvagpEAFrEmMDVdcSYI3FP86iNgsKza+tPsm9BvVe7WLX3zceu9DoahGVRHW7WqqKmCWukIAliOtnk6CzIWgEIGJr9ZkxEC9x2JDoNY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5YJxo3jl511oaWgwG4oM3CWqvD3SQQON3SHeY6OUsDYKmp2PWo8OoHb4B4DU?=
 =?us-ascii?Q?XXAsS0INTw1Ht5P0DUC1vOQR0ADFkrw+Q8dW/cm1y1Tyk3015fJyH0lB0912?=
 =?us-ascii?Q?GbPanYo+Asf8mhAjAtFPr/AsiPuO1uMAGTHfpKMbPxa5tGt4h1YSyYUh+R2s?=
 =?us-ascii?Q?pggF0MN1OMwDetU3xD0x/1oNNj5kUuDRKG+1HeUSGGmmPRRp88hJkDgEf4o/?=
 =?us-ascii?Q?0Q4ckd+GFMkIejNMnUI4y3KyLH9Yfw3S0ofL2INVjhrRglNQkbCgz2KEVnCT?=
 =?us-ascii?Q?9r840JKNd0Wcon+oZqxa/QIiyYv/qD02GRjcKrSpZpChp1Zz/OC6cRVhNReh?=
 =?us-ascii?Q?BzDTj73R2VX4cIBTKZ/CFzEaXuW3GUizfxYazpNIbNuqET4iloPl/C9F+mmm?=
 =?us-ascii?Q?WZlW1JYNBv2qCuIC36CHRxTmU2vqkxmfdz0grNqHGcMKBnTFnyRS97Ej968J?=
 =?us-ascii?Q?kDaXTHICAjShFyFc67hdbi64cia/oS+jmwqT6YsRQFqa698/LRU9fUqiku3C?=
 =?us-ascii?Q?xz/t/lfBISlnIRdnvsfjBN+jBK5egR38SvEZxurHifDynThPLApGg7QNMxHM?=
 =?us-ascii?Q?B7DKomMMvIv8sT+Thg+cphxnc9kpQamtVp37B5XB6TzhGuJs3iJgfCQq44xR?=
 =?us-ascii?Q?PyFNLHrsqYn9G3EYa07jfYVYR5xftiWvTEh2bN3f8ZfJFKTu5FuyUHKG6H40?=
 =?us-ascii?Q?BvE+ZIqr3zVJMeDmXUI2PtLRBq6oS3xhzVxFP0wCnFOeBFk1WLo2PD9IoBkV?=
 =?us-ascii?Q?P7SbEDqxjM9bT+AuHYg5rByVJDqQypqooLxRR2GjAZGjvNg8Vd2TDJa2ERQB?=
 =?us-ascii?Q?DeUfV71Ry0eiu8tMbCPfZxmJMsQa3ryhHXraj+CgwqGCAVY87ZRH/CrzrDe0?=
 =?us-ascii?Q?dc0ZCs6Y+krAnddd1Krik6UliY00tY3Oj8+BTYCNuvOMJlBpqRxwG+5XWwdE?=
 =?us-ascii?Q?22RPJRYl/aT+ymTsjW7DTBrxjNV6TVNljgmIET44TY3/4xNb5nwZFdh5MWtQ?=
 =?us-ascii?Q?1Pgd89P5iQnIigpIFndy+XZNhnyi6+MgGgqzQACFFSyeyJ+IXgm5OCVzK1DF?=
 =?us-ascii?Q?sBbpqqM6kG5TTuZSTpqMwawvMzo7hyf7hg6gI56VeDQLmAcnp9CDlERxX14n?=
 =?us-ascii?Q?TwAS4bumEpyg5Jlr7scawXt8OUdYZ3rlneKjYFBDf/fwzKZA+p8bqci4cTlT?=
 =?us-ascii?Q?4N7jJzlBO68RA0rZbt5yOwJcnzbp1jhTqnathDNF6am4cBYSiV49GtB4lWXb?=
 =?us-ascii?Q?nPVIGDeCJZKb6esKwFzlObnfOfzXloe8r9yeQCK261dG3NzHyx5O241YluZn?=
 =?us-ascii?Q?4+n6uBvDmTivH/VvfotH20q0sl+6K4Z8FFne/dALZpVPmwHkuHpnsvezDfip?=
 =?us-ascii?Q?IYBS97/ogdFUayRqnHzHcbE8baSOYb03whFZs2iVpPyfb7JMg6FKD6TLdTFq?=
 =?us-ascii?Q?ezTnpATRGvSDnmdAkC5j3B6viyF23L6uxQoDeAhE4YFc88+laCL1WvTsvbGo?=
 =?us-ascii?Q?KNhJXsW4TNrpllgz9dcAmFj+r9oy4e3Pvo+gLPBkDomu207ZYXhV6HUc+32d?=
 =?us-ascii?Q?LJF13uCh+Uvosr5l1EezV1zjgOKwxYakjFr8V/fmixgglYWErDgcSxmG6sHH?=
 =?us-ascii?Q?yYp8PcvH0CQBzoMEl/7Hxv7URpxX+4KF+t1SYCr7AqPRpHIUP3rp3vpOJ8Do?=
 =?us-ascii?Q?y8/JNbNwSqM/UcMnVX7QSyDeH/vOBBB//mv4JF7VTrdYXY3SEXLgaYoIb00k?=
 =?us-ascii?Q?+MYYowcrDA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KnINbpQ14g9YhsXy3jQT7F0QasDuOAN9IGK2k5FMHhnZ8Y3wIqbtfacT/TSV0X6Lqz0Suk2+InJeBwX7XuupC+aSUDRu+QCrVNBmi9WKqJarZaKygvTTDuxEPXegP4+tfRka6cAiywTN7SVzAzLiCArfiXthkP176NBRiMPzN8AK4z4PW5naeHJpTDV5RITBSwjt/yaErdBW53SXLzhLdksFhf17MTN/54C5QGI0Nw1XfJNz4uFBzRjvHMdbv/Xkpv8rHr82g1VgyIgNMdAy7RN6TYKwc4kz0mP5vHnkCRvhCJwjaIZChOEXMMGhV1k8gHvqargn8nS8NwI+Ug3h/w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5958b3-8232-46dd-d2a2-08df1e905950
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:15:43.1718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qvlpA+MuKadw2qClKPf0plxqUDvj+3UOdoZgDT5EDKl5R+C2vlxqOknsbcShqVUbI4pxTLQhazdFoFiVMadjYt+C2+3dntUnseHNWX6mQBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5232
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
> Sent: Tuesday, August 4, 2026 11:51 PM
> To: intel-wired-lan@lists.osuosl.org; horms@kernel.org
> Cc: vadim.fedorenko@linux.dev; Nguyen, Anthony L <anthony.l.nguyen@intel.=
com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lun=
n.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@red=
hat.com; richardcochran@gmail.com; Kwapulinski, Piotr <piotr.kwapulinski@in=
tel.com>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Loktionov=
, Aleksandr <aleksandr.loktionov@intel.com>; netdev@vger.kernel.org; Xuanqi=
ang Luo <luoxuanqiang@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 1/5] i40e: serialize Tx time=
stamp skb ownership
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> The Tx timestamp interrupt, watchdog, transmit error path, and PTP stop p=
ath can all release ptp_tx_skb. The existing in-progress bit serializes slo=
t reservation, but does not protect the skb pointer. One path can therefore=
 free the skb while another is still using it, causing a use-after-free or =
double free.
>=20
> Add ptp_tx_lock to protect the timestamp slot. With all accesses serializ=
ed, use a non-NULL ptp_tx_skb as the single indication that the slot is occ=
upied and remove the redundant in-progress bit. Publish and claim the skb u=
nder the lock, then complete or free it after unlocking.
>=20
> Make the transmit error path claim the slot only when it still points to =
the skb whose transmission failed. This prevents delayed error cleanup from=
 releasing a newer timestamp request after another path recycled the slot.
>=20
> Fixes: 0bc0706b46cd ("i40e: check for Tx timestamp timeouts during watchd=
og")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +  drivers/net/ethernet=
/intel/i40e/i40e_ptp.c  | 55 ++++++++++++++-------  drivers/net/ethernet/in=
tel/i40e/i40e_txrx.c | 38 ++++++++++----
>  4 files changed, 67 insertions(+), 30 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
