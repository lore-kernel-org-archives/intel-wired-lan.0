Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB8DCA9ED0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 23:15:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0830680BEA;
	Mon, 12 Oct 2026 23:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDugMjVNyNLK; Mon, 12 Oct 2026 23:15:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 639FB80BF4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791846958;
	b=Ez130mJGSbpX8n6/37zoP/sp1mmPIxxEHQBNWxgzEj/5oMySwhYHborfGv9R6nbklrQu
	 oOxS/XFEyoTaQypf6wVutGmWFEHls+VAGthugWKAe+W8iiS2oBPn9RSVCaXR8t197JUpq
	 a9aSHRM6ISD92Ud63TfJzxC3J7J4ePiw4k8JRZn8vQMrC8wt1nVQHOLhNSAZxqk7XDzwQ
	 /osP0M1jgwBKLfdGWiQ9JNr8qNg4DxuBa0GEUvQFXYYBIyCfCC7umM7PYCVBen2ur6qyH
	 Y9QuA+fnbdrbYIolCrGWI4e37OsBpvrXKBSgKM+cuKHUuQWpc/zK8W4qQ6rQOfl/8KA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791846958;
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
	bh=6gqjdIWvChMhpZJOHnGZcEG01trJhGGsSj5yNLa4mIs=;
	b=KJNvL8Bjpi1EQv506hhUz1FR9dGox0QcrRKcZACv0ohhlILSDUr/Z9oICPxvRZ+utj83
	 R7UiYaarXzAPrV/z2fO/Aeocf+ETlvdZ/18Cn+u7qadbcfeiZGWgYQSkvYz00bdmzV2eF
	 vsUd5un9K5d1++XRZgC69v5DHcKBVVdycmnc9HKapE+/vKK/52NMNxw4PCVBJfQousVWW
	 CVn4Y/OC1RiOGA/6MY2ce7b1biWpMebBgu1Bmy5eERGWGYY5Hb9l+ZJzBETk6wOrD3Yr7
	 1AjIAB3AwGMhm0QbJFwKvOjcvSbgPjjEjW6x9cUo9qcUgyoysBPSHEL4zE2wQIAyOpA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791846958;
	bh=6gqjdIWvChMhpZJOHnGZcEG01trJhGGsSj5yNLa4mIs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IOEqgccfHwEDPtmdNx0yb2ZPuwlmfedWZeSq16KGUaZpNpHviBaWtPercVPw5Qe6h
	 7/RyWPCgpjUEQZwMpahwcoRucM9ufFphbRaqsYL6lSKhB4nzbIcHju3+eH+6rMLRQM
	 erhGk/ZcjoJpWmRNTeGKM9sgSluDkdkPCFuWaZitL+7qDCO5laWU4jZTek5segXohX
	 ebOvvCugcM5wZfyEvnJH0OI9RhTP43n/JW0yfosiGUW9ulYTjZdY6pPhr6+WcYztx6
	 8yO+RW2rAkIuyPtOe5Wa516VFi+4qa06meNQqlIOY5Dz3f7+otqyTHUwWZtd+jkmwJ
	 hZgXaZibZBThA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 639FB80BF4;
	Mon, 12 Oct 2026 23:15:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FD71156
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 23:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D6964058A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 23:15:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id trqyvt_RuJY2 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 23:15:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 282B340556
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791846956;
 b=U8Ae4qFBfjeJG4ZwJip1ZV4B86L80y989smHPuOdFYbzVkTMDYLJvW9Gf8v4C2StBN0O
 RvzjoSCfn/ls7H2MW0Xiwb+QyOEb0OWRIv4FpTsEl2IP/QI0OWR/thly2scLVzOwn8I6h
 /Ey9czeL3vbgGGopJqDzHArRFYh5NtTtTFCwt17/YdGv5wo5Mc38B/Tuv+7X5oEHroRPe
 mWdSf80r21MrfdK2tc+xQ/zyWkLOpTvoLSqB1uZpvORgHPGnbVd2B9G/yRZb3Vpw0t7W2
 9Vq8CkY366WYFNb5pICinMV1futH6wiuxO9wo3qEY+GPYbYQEI8ZAxfTYWVy/wxKdpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791846956;
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
 bh=6gqjdIWvChMhpZJOHnGZcEG01trJhGGsSj5yNLa4mIs=;
 b=TtggwnL9i8VAeqIgZOq/892CYrvCpGDM5ZH5SRKOnxBc22ClAQTX0jiE00T39fUL1i7t
 FG6B+H6Oa12WjPpAv84xDzFcwhGUdN6PaYFKPhi+u9Z7WgIqOOMLqamk+eO9a0NNXaMyF
 ow97vD/JhyaqtdovUYE6/pn8+yKhihtBX6QOKqn5uNcFvpdNoYMssHie+x+0pr1Z3P+8H
 tWhSe5a6nx1yLICmgcwtTOxS8GiKLhyP1YVw4pCiXUkH4ECektJre8ZgPxJ0cJQYfYFgh
 KIoPppMqV2MyvzPVwFwlCw8XZhNb3yoBXcPcTe6ydka4QsBZFFXvSdLC/PNAIOLwhEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kcz0J6yt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kcz0J6yt
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 282B340556
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791846956; x=1823382956;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7m+Ym/vVFXFxrzzrqAGwNRGYV/9ELW+/9UGbMgGKwdw=;
 b=kcz0J6ytVaU67fzxrDmKudD9W07tJs3OXnYm0hcfXTDop0+pRVNcvQ+f
 le13mxjxrYnT1vIlfZaHdDIjaDndmQtFnzpMa10csD47YPj4Gs4TWh7Xm
 xJugsl//FDff5xEksj511QvJiecrwXE5ihZsYzuWLV+JgRdYThY4u77R5
 Y0NQDz1u1iJ4nigvPIiUHwMXeynDWDW+85mgVnW6XfLxPAqLSX5xM3L+v
 Tjkh5YjnL4cubYA8LOmwBEDEOUY6SxAZNMtv/iwi88zp7xJa1SoUtWH6p
 CPT6J1Z2+tJYw+B2VKYyIeOZWE9A51rbmkWO6suGLHAZeTZ+DzbS6e8Rs g==;
X-CSE-ConnectionGUID: gmNI05BARAe/kWfP2JHpbw==
X-CSE-MsgGUID: 8VJCQQGNTyydydz+dPRcfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="450047"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="450047"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 16:15:54 -0700
X-CSE-ConnectionGUID: LbOv3pTtSMico0lrKKobmA==
X-CSE-MsgGUID: WYZb5GpZTpqYT218169TGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="943210"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 16:15:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 16:15:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 16:15:53 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 16:15:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4UYTnElsKbQHXi6I7FgZrX5IVGW/Tn9unZACmEANA+DyUHCYxpscRli84Zb8ut798iYWUn1dQD23ZegzkZMubDEXIymDHyy2Q6+FSRPXMLoxKTU3AtdeY5UOu9EITC/P8MYNNj976HS3vXQUEAiFzu4+jc/YZTlpvfSgPPXS6skRWebXIW3bMxVUBTsBoGR1jGXd4BWDNSrNHMZ0Arrj3QWxrXm06yPPIbZt6EedNC3CQK35XhnG5x4A79PTiWuSunFQGba9W6mnuw6LUomg52eGtan7I3vAZvcZTRO2EXIbqQY5e1M9XWBEa8/v4Q6CVRskgkhq08WmrfIin8C6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gqjdIWvChMhpZJOHnGZcEG01trJhGGsSj5yNLa4mIs=;
 b=uAi368mG8Y0td82qMf9GW/9LG9GV+Gf7+pUp6vQ+5nbWe/5zGIpf+vhwBvJPHhsq+xrMtGQ40PRhTtfpQRMBXcVaQetM7rqv5bsajdz8EkcISWMMJaE17zjSlB5aXKRpctOjt786rcTaf5kf+RNNI1QHAxoxBCJC0lXi4XYcoBJJHEChvreydyJSlmFsRX4J0OKd5ivOR+bJYz4TAKfo7rGXz1A5vSCHsnLtM6h0wgC9nZGpyM7s9pk7xuEdOlsixIYBP73kf0PNkARrKyx1WORJ/4dEqoWjG41LSZ9iuDibtWNS/jlcejET7u0xGszUQ7MqHeyYMG6rfn0fsLrV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 23:15:51 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 23:15:50 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "sln@onemain.com"
 <sln@onemain.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] ixgbe: fix xfrm_state reference leak in ixgbe_ipsec_rx()
Thread-Topic: [PATCH] ixgbe: fix xfrm_state reference leak in ixgbe_ipsec_rx()
Thread-Index: AQHdRpWmphSp3qsJhUm1TU3el/MzWbb6sNrw
Date: Mon, 12 Oct 2026 23:15:50 +0000
Message-ID: <LV1PR11MB87907F8F98770A06457ED31D909F2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260917111317.2148568-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917111317.2148568-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH7PR11MB6771:EE_
x-ms-office365-filtering-correlation-id: 83a6da43-119e-4708-4c93-08df28b6c199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|23010399003|11063799006|38070700021|56012099006|18002099003|22082099003|261009223027099003|10067099003;
x-microsoft-antispam-message-info: MEcgky8/Fl2HBQ0lwrAFrKQb+BQziXlZSL1f/CxamJ5A1qKEzRvt7I3QNTakWdGvuVwIQKVUV5EdgrLa0tBNEHu5oSJRyEW8wcsMeBU/T+koHRpcBphI5uYT/f0+6xE+UOB14eXAM3YeeWgtl3UwekzYEDwlclBsfJ+b91cFgsJYeh4A4deyQfVj6o1Uu16i563TW8M0a+Z3l9l8GQ9eRA7BgfFI8QpPf1mjXCcsGEjEVU5pbrAMIwj6d8BmafpkPzdWWuwh18dJJCSJVIEVwiC7uaf58Eg4pPAKLrYSvqoehjLiF7cCu2spBz/L9DIe1y7naUBx2KxLc07WdNi/8KTnegcNOnmNA7IYpo/r8Zhs196c1GOjJkDWlpOGvmVKaPJ8TQeDj22FEiL4wo11JUnYwxv5D9F+jFnR2fbn8Pk67b/AlaEtbfDq3hJUCIZhR3E7LzmumOq9yvC1q64bM4sHcuUaOt7AMxrhxvh8zUNWuQZjPIkgOwGf5oe0UhaL9FLZ6EiuG5PTBUocAwr6JVNOVhg8hgsMwsPnlFDEbp0hGddsPpbRSQhCLKOJbGxWBqwj+1Tu1ga9i9SEP+9aauB5peSKGmWL5UMiBkQqx7r0SgxrRrjRqBgWKBddxBiic3d4Z2rb44iDJrEwDlJyEXZE7+USXecHJTyFMFCBEGiuN527YQ83PIeMz1v8CWMMwjHibKlUYi2KrSXZPe6J/pEK9/O+VEDGnQlyBGA22GM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(11063799006)(38070700021)(56012099006)(18002099003)(22082099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ACjwkVdiqRFqGe7IbYYbvtuem9u7EXkGwPlcq/B+PQGICqHTLNf+DdadUobG?=
 =?us-ascii?Q?E6vYGpmkcreni6xq8Km0RTc4kui7enR+trF0qAYcuPcHt66WOIu3HwXm2qKD?=
 =?us-ascii?Q?Jsd5ZQfcyBegUhIZQwdaEb4tb2pSw9PMkj0u3ZvMfy6ofq9lFi+z+kp+9Dra?=
 =?us-ascii?Q?wg1pqeq5g2S2M9wgqHPYJV5lPzlbtnCAKf2IYxstBKlDLmeTDXk8JHToc6tC?=
 =?us-ascii?Q?8wuDqPZ1YHgX+Uo5bV9JBvd3vo+HaTEzV0IdjY1frszGTdYY9D8rBEyHr1J0?=
 =?us-ascii?Q?/USQNI3ufqeDzoGEMYXi3ctkJt+5gvUJnOIlykB430dd2P0tu3y6CZBgBePh?=
 =?us-ascii?Q?pTApGmxgu23cU6DRkkxeEQYQ1NJhf6lX10zDdpmVhJLDQxdTuO0PxD1XbKSw?=
 =?us-ascii?Q?O3Nnx7VY8ATvosPzsu3xoYkw76NUHRlOmaNKjUmTLVWl+5tvim2kIku/y38c?=
 =?us-ascii?Q?9FPIq3eLISL0HD1FQRx7OABXPZJlPSa7Go2a2zarmP9yaEIoQ1JnHSXBodQN?=
 =?us-ascii?Q?8KaWPXNmGGIiuP9Hl1JKtDv/mGE62ugSH6uPmKFdBw/SuC9C+X8pAfT97b+L?=
 =?us-ascii?Q?t1UUoii9IFjVbm3jvvOOQweL82+hkGN6Mx0f3C4+zsInsQG7elprjZ8F3sC6?=
 =?us-ascii?Q?6uFC/iMxM3FBg/x/irgtIOZUU7wuX11AzHFAwSmh915xFSb8jXNRNj2DUlU7?=
 =?us-ascii?Q?jrRPbsCrIEMrdcMEEy/l81SnOPFMGahxs5a+QsfSn4fyNjeVfCrrQ03a5Iq7?=
 =?us-ascii?Q?NdUzzF5N5xhqnCxd/Z+Eq6OBbdspsb/TBmOYM8iG4SvslGqGjdaC8TLZR91C?=
 =?us-ascii?Q?lcFrs8mYMBmcrSViKepLOVv4Z29m1tOTVdUkM/h5Klaku4PSsh4Kz4XKgbpE?=
 =?us-ascii?Q?uhSot1FhTIdEQh5T1Ip6C23UQtgeU147I8ID6cr3jt0qFfFnGnXZ9OSlU9nq?=
 =?us-ascii?Q?0Tb7JwOkW5NcHjVF0aPQ4MDF22XY8TAUiNwhOH2+zFRHB8tgG5TQ63VUdt60?=
 =?us-ascii?Q?U4HZDI/zyP51YDkcTOkIwi385d/1WPh/H8EavCqGh9yHNdpd1hYaqL2kLw4P?=
 =?us-ascii?Q?SGlVAE1cZWzTDdWbKV2vfYej2BciuS98i4UmVb9ufSy//ldO/IJDOwp8/X4x?=
 =?us-ascii?Q?dxYSRACQcTVNDMErOlE0gTIX9uprHOmq+rkwESqy4o9ZqsIOiG4nqlCiCC2i?=
 =?us-ascii?Q?hC45J/6hesMXujSQmM9vubids2i/6OaChLQFVF4S7uml225/ThnMJPfjp3ty?=
 =?us-ascii?Q?3+2Gx2rsNWpPu9UgaBy3O09++daQRCx/POkZEgwgLF8rK8WcHtrcWu6YmPCb?=
 =?us-ascii?Q?dwyBmEh0PpRMEy1cC//mQRNok7y/YIq032Jv5XPqa21ggivk/FXi89VGYdEu?=
 =?us-ascii?Q?yZM419CF2KJJoiAu4UkJl2wnaWElp2E1EuFBDmmiZO3oN1kIyF30LI92gsvm?=
 =?us-ascii?Q?hVGEJOUOiJCnKdK5XvV/jxoWfGXbdj/rKl6KMC2LRtEHkPN6I03sgYD8u1M4?=
 =?us-ascii?Q?LTDUGGaJnjRLl6blsox8B2hv+X2gzSDYZYMy52lrm8PC/leIp4MLDPxg6wyw?=
 =?us-ascii?Q?ixsSkDRRNGS5+VcGAtsfiMjD51yRN/cr7acACdmHENNS/Hg3F7lC7pcRj7Qs?=
 =?us-ascii?Q?NtYUqf1lmlKrbXG97PoMQIv13mBR3SqTG1hN3f/mxWuxHC8kIr6u5O4Nsur/?=
 =?us-ascii?Q?Z2VIL28/8EdApVijgDIyQHdnYqK89D/jrQcArPxCCQUHkewu+2JBKFHd0s/a?=
 =?us-ascii?Q?kFf9d/wT9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uDRNgPsq979UGzaj9aCDd43FJYlsIJgSYb7djmi0TVOT5ANwDYyxa7rMbeQ+Fzui55KunhLjN4mg89Bn8z0mu/vyF5/izcE728fnuMVdzpWX4RlIlMEG+YYygwyCNXmPDIRy+H15VjdX02mVDnvwPN3iUm6BecIfbCXxZq7VCUXl8B7lMyYZLxbimUinZfrQrzVVMkGnwjgWnm0gPpqKEW+dVbpwjVmKWq4Zz0Olxxb1Sdk7DjeKNmpsPE+K9irNgaE1E+sCGpq8EKl0xU4/tRnKPQwjOiVpWsGGWg9nwq5zRn5ueSE6dEYL6BC4UXrF2XOE0riVLTgrt8i67wNGqg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a6da43-119e-4708-4c93-08df28b6c199
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 23:15:50.6881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nld+zSKqH7E2VfGGPmw5PZ3omItBTfPVOdBcaMnTm3xMMWeXgbnHKAoiutKnbesFLEbHR0kqAFl7seLhEPGwQrv/e62Vt5sCMr2R48H63qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6771
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
> From: Wentao Liang <vulab@iscas.ac.cn>=20
> Sent: Thursday, September 17, 2026 4:13 AM
> To: andrew+netdev@lunn.ch
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net; =
edumazet@google.com; intel-wired-lan@lists.osuosl.org; kuba@kernel.org; lin=
ux-kernel@vger.kernel.org; netdev@vger.kernel.org; pabeni@redhat.com; Kitsz=
el, Przemyslaw <przemyslaw.kitszel@intel.com>; sln@onemain.com; Wentao Lian=
g <vulab@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] ixgbe: fix xfrm_state reference leak in ixgbe_ipsec_rx()
>=20
> ixgbe_ipsec_find_rx_state() returns the state with an extra reference, wh=
ich is handed over to the secpath on the success path. When
> secpath_set() fails, the state has not been stored anywhere yet and the r=
eference is dropped on the floor.
>=20
> Release it before returning.
>=20
> Fixes: 92103199f10a3 ("ixgbe: process the Rx ipsec offload")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
