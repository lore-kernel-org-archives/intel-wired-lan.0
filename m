Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F258C88E4D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 21:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C83680AAD;
	Fri, 11 Sep 2026 21:02:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HM9Sljl7lJI3; Fri, 11 Sep 2026 21:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 625EF80AEF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789160571;
	b=hVah5rAoJWLzr63NRy7svcv8HgCORc59rAOIzW6NBzAbYk8PhRwI5WaMjAIy7me8XNhZ
	 xvsBeL3RRrIg6exgnJj2ouKmm0vBjpvTYynlcX1f9L6zf234DyeplwRg6Glnzmj4j6tbH
	 uWinfNqIdZ6zQI87KDI6B3aKFEaIzWXvSUft4IPgYFW8NHsu3rGNFAn5tzn9lf5tgP+3A
	 LWjMbnLFLpf3yD3zq1uoKxdUnQmaD6PYd0kB06Ci3Tmi1Ygi0cH+WqqE8kUhtzlC9KET8
	 nngLD4gHtuIy5iURKZH5aRqtFNNxdgq/lDuDybrhFowf7rgcW6Ksta4musi+Kvt5PAg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789160571;
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
	bh=wy81qti5XQ6yTEtPW76WdWZnt+E+eE/kNfYoU6NEvyI=;
	b=AsSpNwYGeDCzv3savf2XAIx8JgE1/561Jd9dvxkE7IdJfqBYaO+j72tHIPNGEVLeHNny
	 K2+/PaniYmFHHqq33g1980OYfMR2URq9i3L9qOU6FoxhuVOUWTEyMBSaR72ggksnAEUg/
	 5XW45l1nLf2CUmGY5jYjChGgD1wRPOPud01Uocj1Dp6UKTanODkUtnlI3OEzRxFCKhWKi
	 +crP9q2sJ/8OjsH7cGewTv7MqQ6JewPg9ChmqhxmrCC63VYQZ5aSTf9ARzBe3tANdYAdP
	 Zyujig9lkES+bIx2r22CJA4VcjszdeDKMyUlwCMRD3KhvMNh8Srtjc0KUQI1Igazb8A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789160571;
	bh=wy81qti5XQ6yTEtPW76WdWZnt+E+eE/kNfYoU6NEvyI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EjZLOglwvaMFo2/0xPwdVSIDGKLdN9FH7QLekn2dZ6azD2gRoy4z+aXq5omD/nUqr
	 z0PlIColgHM/WE/aJHLGmwJIglQIQiLNiOuIdTgfvf4scriWuQ0aCb9BW5Izm2GW2g
	 l8ID9AIUpfwJfEGfmuxpQf1qC2BJTMDX/07bojebDjuCkyFoHyt68dZz8PERFMiVeq
	 d+C27t8WNbcqpTmdNhXxJNXZdXYEWifvQ/fr9rMu4iNfph0sVT5jqrSjH++hB3sDL1
	 hwLypY9EPxfWD+rewGr96QCOYShB3Kr2iYLW0MJj27NOP9f6FhXuuOF4uADihZkpGE
	 og9nkBvp9eoQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 625EF80AEF;
	Fri, 11 Sep 2026 21:02:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 845EE32F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A3E3407CF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:02:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7XnkJuwh3TDl for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 21:02:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3EAF2407CD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789160568;
 b=GyLESp88GsTz7ekaKlFa800kPe2h7X9Md0yqvymC0ZNQRM1gAq6JEbLEZqjPJIUVJn7S
 xoExBhnQcvAijHDCdKJtbD2p4JttxWYDJOtm0K7slmOoQ3hnqX76iLGIRYmR595OAIzrF
 qA8/jpKH1QZskpwQ/SPLOSloghrECq0EwUXv6h03Mg9P9IsJMtkT1NqUCjwcl6y2zzXJS
 WZkZAkfLVbmHEZKyicL8oXfUVP2mXyR7JJP3TFNyNeH3eYvuLaFfyM7/l7dyUfFZzXajZ
 J+SgddUmrXRzrEaodz/JCU1f1tI6ORFoL8LenfULWKWGvfTxCxdRVtCbYbxWyhico7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789160568;
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
 bh=wy81qti5XQ6yTEtPW76WdWZnt+E+eE/kNfYoU6NEvyI=;
 b=efB2ZzSx0niOJwK3sz9BK7svqzygCi48YewQQ4XUJd8NiWKWsSam8zeDOkHDXhNyKZaX
 nuRRpc8GPvrCU7vAN0282DsRSvFPp2sKviKMZNw52fJqX18s+8gJoYFM06Xe1YYXaVXrO
 S6uGJkfaWsJEuYPLGkfCXRgwsRDpcN5EWKFhZ7qoMUJGg2jZV6hYCDoGL09E2v4+gNypD
 BXCXk0A5axbe5ER4P9nYNd96XTrPCmM0uYLVCHl5lQOwG5qly32c6YUkpebCVrxz9joCJ
 dxQUqPYpyEj8Og27woLzJ1lHeEr2HOSa70Rlc/IiJUTSvxhhqMggnYzr7/qorFJPtbQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UKlErTfU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UKlErTfU
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EAF2407CD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789160568; x=1820696568;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wy81qti5XQ6yTEtPW76WdWZnt+E+eE/kNfYoU6NEvyI=;
 b=UKlErTfUgdsFos4yW6cH5NloEVLyWFk2mEvBZaSyEULipCn11y9eKpON
 dnbzSJmommQRdUwCPVs4tZsnGSGTOXCBH/FOFIUcuEGa2YqTF8cI36TZ3
 SRTK7nBUoaeDhKyhy18ZzKGadpE7acSbxLKJDL0dBR+vHB3aFZwZiXoWH
 NXovoKZxAw3gFXwM+At9s1iwrQCveM1uWGWYTHMYddNRhqeGGD+6YnVCf
 kTCmrKAQhTVmJG0wx/hO10h015M8bMuk2GB2eQIWBSYZxqpGO1cOWlx31
 SPfzgLm3iEsPGEq9xLxL1B2PyQDumUdrdfa9YVT1Ri+Pk5N02LE5n79rv Q==;
X-CSE-ConnectionGUID: m37Tdu8pTHuwAaB4ofKKbA==
X-CSE-MsgGUID: ysXjm8pJQgiORONZDl8gLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="100224155"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="100224155"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 14:02:47 -0700
X-CSE-ConnectionGUID: Xgs1/aOGT2G/BGMx1g8lEA==
X-CSE-MsgGUID: 22hXtuJ3So2n38JuI2Ka0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="265828554"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 14:02:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:02:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 14:02:46 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:02:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJRNpvA7zwTlPZiaLp95w0X6YOsCvCm4Vf5cvDKyHf5il3Px9IkYkk2b4466WcvAfqVqAvWqgVZjtSlzyeb1891WHpaIVbQN4yGoISYNU1yfpuI7cskoiKne/WsaH/fmYgeAPqZXZMfFF0Gsm/8tXXcmWSXl7IcInuK6KMrAO/p2zXqxNJQzX+qUEISqpJn7bHAbL4+I11nEnDdgapp0dfv4AitliZcxo5SK96+RevC670lmXmeeTWnSKKcM8+G/qi+h2H3a9TjFK/grOSa57jnx7tqpLUkKu/LyQZl+R3h/b0IyGUYv1wS0mnZ2uhvVwwiSmn/PukMzdBoe5n8VsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy81qti5XQ6yTEtPW76WdWZnt+E+eE/kNfYoU6NEvyI=;
 b=BlVveiel0u+zq6DRR3wLbXSGO4XQXVECcL+xzipb48Vzlcy6nLGwmPS6PDesy5PC4hXFWYOyBbO6QXpnF6E5/2NZbPIExmq3+6h/VgzMPtpA4JEc5sQ3vSs7ubDf7ajNXqEurzj+kO0bn4PIrfwOi5VWKUbbVU4Oq9ZKzdic06Ts8E/Uqm/j0hnBUZeH3uabTOS08OGa/JHhSZ4BRuilRbtsNCO/uVuMUlfT0/9HZncS/8veqSrB5U1ZdiegQzB09hJ9gi1l+RlZpA2EiAFgTBrll7md1HtPAjQ9h6dSmfOI5q9H7uwJz9UE7QaW3OqTkpHj1QCxsLHj+3BusEPlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 21:02:36 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 21:02:36 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Hemanth Selam <hemanth.selam@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 4/4] Documentation/eth/intel: fix repeated
 words in comments
Thread-Topic: [PATCH iwl-next v2 4/4] Documentation/eth/intel: fix repeated
 words in comments
Thread-Index: AQHdP6TFwVPdzIj/BEaWgQd5972abbbJ4mhw
Date: Fri, 11 Sep 2026 21:02:36 +0000
Message-ID: <IA3PR11MB8986845ADB6B6F2AFF0ADB68E5BE2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
 <20260907095446.27290-5-hemanth.selam@gmail.com>
In-Reply-To: <20260907095446.27290-5-hemanth.selam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: 6bd1cc53-91ee-49e3-f55d-08df104801dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|921020|38070700021|3023799007|10067099003|11063799006|4143699003|56012099006|6133799003;
x-microsoft-antispam-message-info: C3piK8G5frq1B2/aAYTsZCh1nEiu7Bzmb4/zhpV3hNHEd56wXJBCCq2hkkYN5M6XTgN5KhqO4I7oxIDNWbcnaAB4gXnVzBUY/KhhUWlTTQYvouTChLrmJuxMCc6fsFSRzgmKnb5dVvaWIHGtbu9bnUwRO3yyJApxnhBNVBE1QQTGl1F+qO4FJIXJVIO9Igbhlg8a1WyPAY/xn100FQuHyeS3N8dFcAAtJ1hyzNRJXBkg0/WNE+9SvrKAej1ff5u/L/3HmnR/HWXqI8Jw0EMX8105dY4Ak30hw6w8JLIi6uZmrxKmK7N68c82Xk2d5ELEnbmTu0I7Y685VvJNy3q883C1wJAZpGPuovXbyRihEtTgY6eEkVLwhcZzRb3tRwbYiRPH0VkVhPpmCEhE7X0BajQnSZgn9/8RSCga/ra3qbZVaHMGAKiTGV96T8iBEoqlUGl+M98utNNHxGAT6fhoYwScLni5FBnZDw4sZtSsIcLA1v6c0HAP4+2uwImzuIItY44CnSOOq87lSeoNL32IixyTyjJPG0DIupoXv5GuZFBp5GOgXt6vmbS077acuL9pLREdoyK/pL7129l632KrQOLMlgbURm/VU6pxvpDlnDupDrJMFREjSvzFu5PwCdmQjmyXpmtaTcoKvzmg1r4YMnnDKQQGguXcatyjGJE0+eSsTUPEsP3L8F+B6umpknrTwlYLrFhZX/mOysFoDH01Y3YGEaaTnyw2IFiMY65glD5cwNT9qtjHEkVYKd/XBITg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(921020)(38070700021)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djB0RTMxVEY5akNySXpLVXVCTDZsK3RYUG1Ia25EY1QrOTNKMWVkaEk2NnQz?=
 =?utf-8?B?eFk3ZlhUdURNRFkwRFZpa1V0eVhGUmczRnpkM3NESWFwL1NvM2tpMHpEZ1lw?=
 =?utf-8?B?V1F2UVRRRkNEY3J6aWFIemk3WmtJQ1ZCNXJ2YTh0T2dqNXhlVTBsQXlwYnRj?=
 =?utf-8?B?Zm1HMlJTK1d5U21sM0txcWUvU2gxU0I1WkpyYVhVcHg3dGlydXhZVUhLTTlF?=
 =?utf-8?B?c1RaYXcyTzR1Z25DUWlWZjRFV3plTWFCalpRbkJ6YWg2cEovbis4NHhFa1Vi?=
 =?utf-8?B?d2kzcjVVSW9FTEFQTkI5c3FjczRFYzhYZG5rbHpPRUdGTWlGek1FYVNib2Q5?=
 =?utf-8?B?dDkwMGFnT0NHL0lsdnB6bXRqQ1V3OU5vWk9iK2cxdGdIZ1hkUko4V212WnN5?=
 =?utf-8?B?MVdNcUtNbjB6SU4rU1IycU1aaE5uTHA3U0RFSWFIbTVKK2RYZ2FxbUJ3UmZU?=
 =?utf-8?B?YjVqclJvZlg2RUJHSU16NG5OZHptTUdaMlRyVHFqMjYxSGZyQWp4bEcyTXds?=
 =?utf-8?B?TDIrYjNFV0kxQ09qRGF5S2czRDU1bHJuWkVocFVTeEloNUUxQmF5SXpxUnA5?=
 =?utf-8?B?bERXNGJHV0Q0TGZIMExDeTNCaTl2TGxjS3hIRkkzZmZMMW9UQm9EN1QrQ2U2?=
 =?utf-8?B?R2JhNzdVUVR0MEEzM1FsS0drSzI1Y1lXTDI2S0FpM2JlQ2llMmhnR2hTN1Bj?=
 =?utf-8?B?UmZ3REtOTFBtc3B1VVRUeUlQU2FhTXRCM1M2c3RFNjlrUkc0NU1zbU1EQUdS?=
 =?utf-8?B?ajcxSlgvVjV3Ty9hNlVEcFFxeGhPZVpleGlIQmx3cUNuRUk5Q2N4T1Bxc0ZG?=
 =?utf-8?B?NWZNditzRk1GVUM2MmsrMVZ4djJWMWRMWlNRR1RVcHc4SGQ4TWZYZThNYUhV?=
 =?utf-8?B?clNxWmNZL1M2S3RDVklRNGVwTUwwQTdkU09OdmY0WWlGUXZNTm1taTl4eElh?=
 =?utf-8?B?Z3I0Q2NETUtSVlVuTmo1dDY4KzZtV0h0emNBSGF2VWwzUVUzK2FKck9qSTR4?=
 =?utf-8?B?cVB0YWJVNHdVcTZtZmk5UVBHdlRIOTJJWjBxTlhEaFNGd1hrZytHQk1EeXFP?=
 =?utf-8?B?V3pjRXBqUWc0djhCOE1mMVpBSkttL3prR3FsakRSNDNJQXY2TGozWlZHN0h6?=
 =?utf-8?B?NGVoT3hUcWI1TnJIelppbTZtUXUwQ3YxQkRJMmhTNDByRGg5ZkFUcFFpZytl?=
 =?utf-8?B?QkhucWdoTVp3T2VROXRZM0hsYkt1ajR3UktDSmtZNUZTTW96QmhqQnNTU1pL?=
 =?utf-8?B?S1VJUllMRkJBOE1FaTI0cG1sMUkwY0VyZTQ0clJ6Z0ZhbGY2MDdobWNVQ3dR?=
 =?utf-8?B?Q3c5NmVwdG1DK3NYa3AyZ1IveU5CeGg5Qm9jTEdicjcxUEhIdFBWSFpubHd6?=
 =?utf-8?B?T1g5SklKRkJLSERzejlrakVLSm9wTDNtWDlNUGVZVGswMjBBV2pPVVpyc2VL?=
 =?utf-8?B?TXMxN2tRRWxtRmR0aWxCdjVyVXpYb0IzOThNR1hRS3VOM1doa2ljYUhCalNW?=
 =?utf-8?B?TVhyQWhVakJRUUN4QkpQRE5GeFNReTdrSzViM08yVmJBZjBQejFJRDZEdG5x?=
 =?utf-8?B?VlBnL0VDc251bDVpRDFMdUtpMXQyd21NR3ZVUWN1Vm9lNTBqK01yUGhHMWxu?=
 =?utf-8?B?YVpvZ1gzN3dTVUlyL2FyMVVlZjFTb3BDRVloclRQZElpR0w2TWF0d01IWVZK?=
 =?utf-8?B?UllFWU0ydm9FdWlCN3AzakdmU3BwTWplNzhLMWRKYWpDTXQ4dmpUVzZ0bmJU?=
 =?utf-8?B?aUFNUUt3Q0FKYnVFMjEza0p3cnJITVpGdWJFNUhkYytIcVB2bmxaUmdxb2Iy?=
 =?utf-8?B?RVVXZ2pCSkFqQytvUDlQSE1USXlIaXhZUndWYXYydXQrQlZaRExKQUZ6SmNw?=
 =?utf-8?B?Nm9QMUlsek4xYkFpRlVWU0R2K01ZR0tIU2FjQTRJRjdFSnY3UGZCbCs4YnFU?=
 =?utf-8?B?WndaSEJuM012ekJTbFg1K2gxNFJPeVNBZTJNRk11dmxtU3BUOEN6YmpvMjNa?=
 =?utf-8?B?Mmd3cCtwVTlkQThycThJR3kwNTZjNkJwMyt1WHZTZTBrYWIzRUZyWll4QkVZ?=
 =?utf-8?B?bkp6QTl3c0d1dFdhbWkrWW1FVVY2S0h0MEhRbFJPblRheWtXbWdpUE10TEpH?=
 =?utf-8?B?UE1GdElGcThQUk55aHlUaXZEZGpCVjY3RUVQTXBiNndKSTBwLzJNelJKR0Nq?=
 =?utf-8?B?eEhmYWtTM21ZSG9TM0hHODkzT0xpOURqNHRaQ2J5bGVpUEg5dnhyU1A1WWRn?=
 =?utf-8?B?WC83SERWTDlwaFlSbnJGRE5zTlZRNzJSb2VEVnVGR1ZvSXZzdE0zZW5nZldB?=
 =?utf-8?B?ZEVZdytFR0g0ekJVanNOcTBkTUxaalJrS1BCZGd6c0hZSGlGZWhFQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cGiQ+qwpeermjTnwf49SfrzYo2X24qogP8uYg4427jr+46F5C2rXhOiNOVpHzGuRaE00g4Tl9D7HosODy0a2d8a2ucyLOfdNBb5uI0qCBz+rwYEkXtrtqXy8o+RdGynveH1FeIe9rzmTkdVoBKgrdatAJZCy6bi037JAQPM7qDvGF6aG3zV45h6mC/jfZaA6qgCGaaQNAYwZSErbjeedZnHWyKlue7xzp+va3WnB04X/oAEOKt0DcP82M0i+Ub28YGFmRRFlNzS0AmwHENy1Y1LyXq3bdzI+c0XSzy/wslmZAHE8qrCHo7pnIo5tfts5vn1YIU/u7XIi/gcW1SKIAw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd1cc53-91ee-49e3-f55d-08df104801dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 21:02:36.4786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ai0/SGyvItALv1OqmlU0ONj7YaMfyxoYhiJ4hsdaGBmLntgBJQRZsn9VnNuBCqTQ4VbZkxrL52rHV06vy/9x1BxOm4k7tqcEc/f4rKGkyr4=
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVtYW50aCBTZWxhbSA8
aGVtYW50aC5zZWxhbUBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDcsIDIw
MjYgMTE6NTUgQU0NCj4gVG86IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGlu
dGVsLmNvbT47IEtpdHN6ZWwsDQo+IFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBpbnRl
bC5jb20+OyBBbmRyZXcgTHVubg0KPiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUy4g
TWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYw0KPiBEdW1hemV0IDxlZHVtYXpldEBn
b29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvDQo+IEFi
ZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47
IEpvbmF0aGFuDQo+IENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+OyBTaHVhaCBLaGFuIDxza2hhbkBs
aW51eGZvdW5kYXRpb24ub3JnPjsgUmFuZHkNCj4gRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5v
cmc+OyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGRvY0B2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXh0IHYyIDQvNF0gRG9jdW1l
bnRhdGlvbi9ldGgvaW50ZWw6IGZpeCByZXBlYXRlZA0KPiB3b3JkcyBpbiBjb21tZW50cw0KPiAN
Cj4gRHJvcCByZXBlYXRlZCB3b3JkcyByZXBvcnRlZCBieSBjaGVja3BhdGNoLnBsLiBPbmx5IHRv
dWNoZXMNCj4gZG9jdW1lbnRhdGlvbiB0ZXh0Lg0KPiANCj4gQXNzaXN0ZWQtYnk6IEN1cnNvcjpj
bGF1ZGUtb3B1cy01DQo+IFNpZ25lZC1vZmYtYnk6IEhlbWFudGggU2VsYW0gPGhlbWFudGguc2Vs
YW1AZ21haWwuY29tPg0KPiAtLS0NCj4gDQo+IE5vdGVzOg0KPiAgICAgdjI6IGRlc2lnbmF0ZSB0
aGUgcGF0Y2ggdG8gaXdsLW5leHQgYW5kIHVzZSBhIHN1YmplY3QgcHJlZml4DQo+IG5hbWluZyB0
aGUNCj4gICAgIGNvbXBvbmVudCwgYXMgbWFpbnRhaW5lci1uZXRkZXYucnN0IGFza3M7IHYxIHdl
bnQgb3V0IHdpdGggYSBiYXJlDQo+ICAgICBbUEFUQ0hdIGFuZCBhICJuZXQ6IiBwcmVmaXguIFJl
YmFzZWQgb250byBpd2wtbmV4dCwgZGlmZg0KPiB1bmNoYW5nZWQuDQo+IA0KPiAgICAgdjE6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDkwNzA2NDUyOC42NjAyLTEtDQo+IGhlbWFu
dGguc2VsYW1AZ21haWwuY29tLw0KPiANCj4gIERvY3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZp
Y2VfZHJpdmVycy9ldGhlcm5ldC9pbnRlbC9pNDBlLnJzdCB8IDINCj4gKy0gIERvY3VtZW50YXRp
b24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9pbnRlbC9pYXZmLnJzdCB8DQo+
IDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZpY2Vf
ZHJpdmVycy9ldGhlcm5ldC9pbnRlbC9pNDBlLnJzdA0KPiBiL0RvY3VtZW50YXRpb24vbmV0d29y
a2luZy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9pbnRlbC9pNDBlLnJzdA0KPiBpbmRleCA1M2Q5
ZDU4MjlkNjkuLmUwMWYwYWRkYTNmNiAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9uZXR3
b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L2ludGVsL2k0MGUucnN0DQo+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9pbnRlbC9pNDBl
LnJzdA0KPiBAQCAtNjkyLDcgKzY5Miw3IEBAIHF1ZXVlczogZm9yIGVhY2ggdGMsIDxudW0gcXVl
dWVzPkA8b2Zmc2V0PiAoZS5nLg0KPiBxdWV1ZXMgMTZAMCAxNkAxNiBhc3NpZ25zDQo+ICAxNiBx
dWV1ZXMgdG8gdGMwIGF0IG9mZnNldCAwIGFuZCAxNiBxdWV1ZXMgdG8gdGMxIGF0IG9mZnNldCAx
Ni4gTWF4DQo+IHRvdGFsICBudW1iZXIgb2YgcXVldWVzIGZvciBhbGwgdGNzIGlzIDY0IG9yIG51
bWJlciBvZiBjb3JlcywNCj4gd2hpY2hldmVyIGlzIGxvd2VyLikNCj4gDQo+IC1odyAxIG1vZGUg
Y2hhbm5lbDog4oCYY2hhbm5lbOKAmSB3aXRoIOKAmGh34oCZIHNldCB0byAxIGlzIGEgbmV3IG5l
dyBoYXJkd2FyZQ0KPiAraHcgMSBtb2RlIGNoYW5uZWw6IOKAmGNoYW5uZWzigJkgd2l0aCDigJho
d+KAmSBzZXQgdG8gMSBpcyBhIG5ldyBoYXJkd2FyZQ0KPiAgb2ZmbG9hZCBtb2RlIGluIG1xcHJp
byB0aGF0IG1ha2VzIGZ1bGwgdXNlIG9mIHRoZSBtcXByaW8gb3B0aW9ucywgdGhlDQo+IFRDcywg
dGhlIHF1ZXVlIGNvbmZpZ3VyYXRpb25zLCBhbmQgdGhlIFFvUyBwYXJhbWV0ZXJzLg0KPiANCj4g
ZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9l
dGhlcm5ldC9pbnRlbC9pYXZmLnJzdA0KPiBiL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZp
Y2VfZHJpdmVycy9ldGhlcm5ldC9pbnRlbC9pYXZmLnJzdA0KPiBpbmRleCBlYjkyNmMzYmQ0Y2Qu
LjU4NDA1Njk5MTdmNSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2Rl
dmljZV9kcml2ZXJzL2V0aGVybmV0L2ludGVsL2lhdmYucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRp
b24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9pbnRlbC9pYXZmLnJzdA0KPiBA
QCAtMTcxLDcgKzE3MSw3IEBAIHF1ZXVlczogZm9yIGVhY2ggdGMsIDxudW0gcXVldWVzPkA8b2Zm
c2V0PiAoZS5nLg0KPiBxdWV1ZXMgMTZAMCAxNkAxNiBhc3NpZ25zDQo+ICAxNiBxdWV1ZXMgdG8g
dGMwIGF0IG9mZnNldCAwIGFuZCAxNiBxdWV1ZXMgdG8gdGMxIGF0IG9mZnNldCAxNi4gTWF4DQo+
IHRvdGFsICBudW1iZXIgb2YgcXVldWVzIGZvciBhbGwgdGNzIGlzIDY0IG9yIG51bWJlciBvZiBj
b3JlcywNCj4gd2hpY2hldmVyIGlzIGxvd2VyLikNCj4gDQo+IC1odyAxIG1vZGUgY2hhbm5lbDog
4oCYY2hhbm5lbOKAmSB3aXRoIOKAmGh34oCZIHNldCB0byAxIGlzIGEgbmV3IG5ldyBoYXJkd2Fy
ZQ0KPiAraHcgMSBtb2RlIGNoYW5uZWw6IOKAmGNoYW5uZWzigJkgd2l0aCDigJhod+KAmSBzZXQg
dG8gMSBpcyBhIG5ldyBoYXJkd2FyZQ0KPiAgb2ZmbG9hZCBtb2RlIGluIG1xcHJpbyB0aGF0IG1h
a2VzIGZ1bGwgdXNlIG9mIHRoZSBtcXByaW8gb3B0aW9ucywgdGhlDQo+IFRDcywgdGhlIHF1ZXVl
IGNvbmZpZ3VyYXRpb25zLCBhbmQgdGhlIFFvUyBwYXJhbWV0ZXJzLg0KPiANCg0KUmV2aWV3ZWQt
Ynk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K
