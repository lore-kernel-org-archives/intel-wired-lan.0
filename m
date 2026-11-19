Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21BC606A32A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=CW93KhmM;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WZ09PeIo;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=U4OtrkIr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2AE8402E9;
	Thu, 19 Nov 2026 12:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WA3NVhTNJMhx; Thu, 19 Nov 2026 12:10:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EFBDD40769
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795090200;
	b=FmTiFrc0xk1ldwyQbkCTLJMSb8pA5aG5canQMJdPnMgQakHbWHhmhiOoTNA6ojs/w7wV
	 EnAWnd31ral7jqlB2lXcLMpxhmhSvYYG1/ejyY0u6g9Kd95mtzKup7mBJVxutlh9maxlV
	 hdGpbEkjpPSIQg79Bw3c7JKkz2WMGv0JODZ4ZRKrcN3FljRYSqbTqn5wdsc4ECEZrAGxh
	 XTIgkmSM/s3YColah9LqWSEejY9hpwnByjUDuoGlJyVBxd+62z4ixLls1ONlQ2vCGaZXa
	 KVuOmhRsgxQXWbq4PAVOe+hjoz0uuPsUu10sHVzIYNgDNU3tWg2LeU/hRPIBiTMwclQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795090200;
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
	bh=0Yqn9dxaNj3tfGexBQTtKflt3qpWbHPbUSvvKGCZhsQ=;
	b=A/Ohm1HCF4yTuTlg62UZkZfDAtbfsmazJBB65jVhQFLbZs/26B2CK4Av5w20Zpzqf0or
	 xUAekIRj0FRulC2q0W8D76eE9OCpPHcAeT/zG8d5aJv0fGzTta3b9vuSmFSkVvh1I0Iwd
	 1oB2bj1M+9oVBLiKDNk3gVUiROuGadqpghq7pUXHMgGqxTFXCSjZTLiA1OfzFSn+baaTu
	 qIr6v5ysQuhG9jvQ1WJmXuH6p7Momm92it3oROYe/KLYnx1XuL6wiOnQaqEe8NBoFCovl
	 /GCmnRcB2/1fRzhefB9YWIaUWTxa22Qvlu+Y+yl4xikdOPEa4/aQ1PnCTGgUhjjR1vQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795090200;
	bh=0Yqn9dxaNj3tfGexBQTtKflt3qpWbHPbUSvvKGCZhsQ=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CW93KhmM366XJHc2Xh+r4IIDyvo7WPiyvAAEohq+dsdSI6qzcu6Yxh/pjToz2SzFu
	 1fqIKfCbMHb2SptB6NhcTynqQHEjVJF83KgfAiL4ENnCVxWitHhOYfTaQLLaralZFH
	 7OEREEOs4dAZY9NTa1++zsspegzS1MWhuVoJBAnf51ueqeT0TYvDpPpSYZfRLfnGV6
	 t/iQaQS9qt2szcRQwPvty+vViKjVA1AM3giBMcxoRxCXUzO8fU4JYxWOLEmciQUkb7
	 NexDazRC4dFKinc1HJtx/B64l3C+4HoEw/ncTKGZhcpThKv9+th2hW/z/UnrSF66gO
	 7zObEqjEqakDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFBDD40769;
	Thu, 19 Nov 2026 12:09:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EB8B22FB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 12:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D13C360D53
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 12:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fn8pqYqwtbXg for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 12:09:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8274260D56
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WZ09PeIo; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=U4OtrkIr
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8274260D56
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 12:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795090197; x=1826626197;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=0Yqn9dxaNj3tfGexBQTtKflt3qpWbHPbUSvvKGCZhsQ=;
 b=WZ09PeIoq8+rmYqcpu3b1cIuWh08iaDus8RixCE5kN4r7zmcO/Desaoc
 8z2WH3jrnj8Ba9e/YY/b1Cedaqc84HzL+lA3o/wRAgKZofEZuk8uM//9p
 A8ClD0O7uoBNKgT6a97VyC/J4cCOxNlE7JbuDEr0P7EZ3JpSq6srXSwiX
 21NSqoc8qjPsA4yICkP1v7t8wWYHy+a3qZzzM5C1jOPjFnadIoNayIJWD
 VG+LsLTvbDWa+PZKaIsVpDbqaRS8aGNGOtOEexsYFhC4l1FAiugusO3q9
 cBxDuEuc2RRv2bGyUjHdBC9ApkRADJOwoh8fZji4bFz196ryeqLCPuW+P Q==;
X-CSE-ConnectionGUID: T3gn0ub7RP+LP3XolLFbeQ==
X-CSE-MsgGUID: m4wDuNrrRhetwf8J08Oshg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3781231"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3781231"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 04:09:55 -0800
X-CSE-ConnectionGUID: ntcW5GHCTR6zNZmH8QlbTg==
X-CSE-MsgGUID: y5O4lWeMStq7qyiZMOP8rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="12158263"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 04:09:55 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 04:09:54 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 04:09:54 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 04:09:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Yqn9dxaNj3tfGexBQTtKflt3qpWbHPbUSvvKGCZhsQ=;
 b=U4OtrkIrF0/Ew95KxDD0oH1V5KavGnT3/Fed/egNMwJ5scwgm+CxzeJFM4QGA7W7SrQPF2IJYz0VxIehI+tXYG0TrnZj7ryh9w162AD+j1w5x7NDeJpkNXVk38z6eapKK2EVKkv2MKfMxl0Vacm8iqfOb9ebwmoMUlmiVXHsNlg=
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by PH8PR11MB8260.namprd11.prod.outlook.com
 (2603:10b6:510:1c3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 12:09:45 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 12:09:45 +0000
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
Subject: RE: [PATCH iwl-next v4 1/4] ice: fix computation of ETF timestamps
 for E830
Thread-Topic: [PATCH iwl-next v4 1/4] ice: fix computation of ETF timestamps
 for E830
Thread-Index: AQHdd71fP6eYAUdFVk+3pZfWtgzN7Lc1TjAQ
Date: Thu, 19 Nov 2026 12:09:45 +0000
Message-ID: <CH3PR11MB56689577EE9F918E8F78F55BA0E5792@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261118-jk-e825-e830-timecounter-v4-0-0acd194b7357@intel.com>
 <20261118-jk-e825-e830-timecounter-v4-1-0acd194b7357@intel.com>
In-Reply-To: <20261118-jk-e825-e830-timecounter-v4-1-0acd194b7357@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|PH8PR11MB8260:EE_
x-ms-office365-filtering-correlation-id: 86e3e595-4402-4569-f3f0-08df4635ffe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|921020|38070700021|56012099006|261026140227099003|4143699003|11063799006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003|261009223027099003;
x-microsoft-antispam-message-info: f/sKvuj54MpqYhxssOsELSwerLm75rR6dkYjham3FegqpB3/2L+x9sQHCrF1iZQLM2jHp3Eu7nZhbZIExpQLCa9Zh9DZis+dbDI2SlE9Wv+JtGCJAl5XbuaJN5L09wIgHG92fF/uphzt2jgbLA2I+tDkhlydWAaeyoGl0k2kqP2JBNz5RAHKPHMnykIRBnNC/VxxZzeFmY75mA/1FfKEijV8884+7GhbIiM1ENxPViudZuerJzWSJeipWMUt4zvnAqhyntz3y4N2c/7FYQ3L4VdyrsLxXGT+m7mFWhpYrmGDIFm82++X6qm3d7N7qr30qqYByrx2v7axIgIy/aU7SW/iaiZeLSIZgbjhnMVYkOAsZiUb4kdBeNKTsx/zY4jJvwgNFbAiMZ8x00kP7qkz8iNcXuamKDBulR3sA8oKTN/hgFw2xN9RcVbtiYxt79/BQcu6+hHnjoZBN9mkpfEFCRaKWuAV+anF29OWTMyfkX92GeU0Vz9J2U7D3O3U2SQSCkX/nZNw5fuT+N/w1YeK9TTAXWFYLeCsnTeGFpyzrK6JPmH/l4+P4thWdrstVh8VP1HWtKZhgbulrZiVFtupvoFU8pxsQLmCvEfZ8ndB1BTznJjRrgumFnSsJ6OvIfmg/ARFRiYREIpkkik7C22JDCeAA6nGwfOrd/oQ/PEMZ71VKO023C/PuFCcOdUze9YPn0WDPEi+7PnShcXbIsYujR0Kytp1oglau/wrAw8pNfun0J46Or8rTqMXu9A7oQh9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(921020)(38070700021)(56012099006)(261026140227099003)(4143699003)(11063799006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0JFek9uVjFWeXFKVWNTazJXQVoySFAvWGFPVlJ6YUxCUXdNVVZJNytpVXdr?=
 =?utf-8?B?K0VVb2NkcU96d20xcWZJZlp5dytlSVJSQzc4b2FUSVVhUzBLNWljM2JCcWZ4?=
 =?utf-8?B?SkxWVm5NdjluM3JvL0RzOUNxODR3aTV4RTdlOFkxTEpyNHZxZG9DSWRrU1R5?=
 =?utf-8?B?VG9lWmxSckdWdnlxdUdqRThOVkFYdzBVT1lEd1RzSmQyWHB2U1Q5ay9UV3Fw?=
 =?utf-8?B?cVVrcklNT1FxbnZ1NHBndTk4NXlBd0src1Fsanp2K1RRd3dDdmlreCtGVTFF?=
 =?utf-8?B?VnlqRWtreEplYzdteitTelpsUHlxeGh5YU9lSXFWRGdibW9Yb0Z1Y1J5UlFO?=
 =?utf-8?B?TW03Yzh1QVJOblM3U01Pd3NXNlY2bzFxNkFHV1ppNEFCWElwK00wUjM4cnBM?=
 =?utf-8?B?OGhoR2dyK0NCQUF6S1ZMUTc5c3M2bktRRmhwR0h2Y0NYT2RsLzE1Y2FKeUhv?=
 =?utf-8?B?d1dRUVdnZWdZSW5lSW5WUWhZUFZ4YkRrWGZvWjVZeWJ3aXo4YkVLUTA1NC9w?=
 =?utf-8?B?dUt6WFhvdWFnQnM1aTh6NkpTelZJVjhYN0NSdzZaZ3VlMCtjR0VvdlZsTkc4?=
 =?utf-8?B?bFZFc1ZtdUIxNlVBUHBveXVJMjAzU0U1cjBYanZmN2VnendYVWE1Tjk4Umkx?=
 =?utf-8?B?akMzQkVyMUFIanhQL2hGNWplUUo1cWVicEl2UXJSeWRpMmRvZmdoZEtoVXpC?=
 =?utf-8?B?bDVHOWhyQ3F0cXJOM01pRFJ4MWVNcVB5NzJuaUZlN2VpbUN4NGNab2dQZ05m?=
 =?utf-8?B?UFVLSHkxRWQ5UEVkUXppbkZyQS9xbU1YOG1penhtOGpjSEpGMGpLWlR2UFRT?=
 =?utf-8?B?T3hjblhlQkJkY3FpRXhaNWZtak9LcTBVS3BOUHpTWFJQZnFNQlgyUFpYTUJJ?=
 =?utf-8?B?YmRmQUxkdy9NMU5xN2xKbDBITVF0Si9wYVFsUWxMV09hNkFCbVJZcWJkVE5Z?=
 =?utf-8?B?cjNtZ290aExtNU1sbkVGL2VhOXNHV1d3TzdWaklpVHZVaVlCVVMwS09QMlkx?=
 =?utf-8?B?QkM1VHlMY2M2Zit1Z1I4V2F1RkU2ZjhaVnE5UkVwVEUzeERsUUZpRnZSUVJR?=
 =?utf-8?B?SjZVYy9CVG8veXVuazZFMmFKbFB0OE0xcmlrYzJNaUovbjRjeFgwZjFPZWZ4?=
 =?utf-8?B?WUg4eUMwakx2eDNQWmVoZHJLSTk2d1pqb2xPNUV4MVJOYjFmbmVNLzBVVlBQ?=
 =?utf-8?B?NmZIRys4RWo3RWpOSXpMUXFZbzl6M0FmTVYrZm1aR1pWcE5pYldUS0xJRHhs?=
 =?utf-8?B?QkhzM0V0RzhxcnJxbXNReGhsOW5MY2R2MitwaUdyTUsrVzV4RlY3UFlPNWJP?=
 =?utf-8?B?bGZXcjNEWDVkVHJkSm9JNERoM2Vjb2NVNjdXYVY1V1JmUWpCWHJQb1liUlNB?=
 =?utf-8?B?ZUVDbzFwRTVveDJKRklsRUFOcHlOdkFvN1VmTG5rVnZGclpadXp1cVd5U254?=
 =?utf-8?B?UWsvLy9tYXc2NEI0TVJ1WW8wSzI2T3ZGRG40M3NEa3VKbU1DMzlEMFdURTZq?=
 =?utf-8?B?SHlFcFVlaW5DaVhWWUFQSGo4M0NobXlJaitxNkxKTXhwTm9yUm9Ec21MT2Z3?=
 =?utf-8?B?M3hzSno1RU9pRU13TE1JM21PWmYyRGJZMEFLVGxuR3lJQ0xkc214NE10K1dW?=
 =?utf-8?B?b1RWNkVnQmcwbVY1L2lKRStMUjA3UDNQa1lYaFFabTlZNlFtdmg3eGtJdTMv?=
 =?utf-8?B?SmNOU3IyQU1sZXYvSGRNMWtVcm5kamVBN0V0WGNtQ1VhZ3dwckMzdEtROFhW?=
 =?utf-8?B?RVFJMjF1aWJkT1NLb2ZBZDVXd01YMml2N0gxdVppbjcrOUl4dmZrVVBpWWtK?=
 =?utf-8?B?TjYvS1pTSWExbHdTek96cmlQcTlsNDhOcGY4RG11cUd6Rk9sV2ZWMWMwK2xr?=
 =?utf-8?B?SW1HUXpiWFl3ZGZkTWpDRXY0Wm92U3JFQjhkQkdhTEtRaGNEZlJFWHRoNTV6?=
 =?utf-8?B?elNTUHBLaUVrTXBNQTRXdmVpcG1hT09SdUZrajh3YU9hVGNHVjNpNjZaWFpp?=
 =?utf-8?B?SWUxdjFWK0NSelIwMG1qVDlPNWQyZi9ZcjFBUkFJZ2JXb0MycXJPS2FEdzU3?=
 =?utf-8?B?QmtNRHB6eWE0aWNhMEJPOUJQdWJrN3BsOGRYZ0ZDWG9oM0VTWC9CMkdCT3RH?=
 =?utf-8?B?UnZYUXJzZW82LzBnVXNvQmVGUzFqRzZKZ3VCUWo0TzJ2cTBISUc3ZjBkTlM0?=
 =?utf-8?B?TktwMWgxVXVjVDRNSk9qc29BOWxvTk5vcWY1M2RhOWd5Vitjc2NNWnFHUWla?=
 =?utf-8?B?V29XTlhCWnRHckQ1WThGNUlDT29GQWRhZnVDc3lENFJGTm85OFpCaU9xb0Jy?=
 =?utf-8?B?YkUrVTNDeitGQkF5Mm41R2FMcjVOam5qc2FiQ1pRSnRoV0VkeXQ4NzBYSnRD?=
 =?utf-8?Q?RmekZv3noM2cB3qE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bD2NnbXtZ2ccM2heECjwewzGVRz5ovE4sNR9/GkeauQE/TtltMI8q+ni80oj1zrJuZkWO3frtyc5B8gPE/8qA1fbIYew+mLs1lV6hqsE9NbvHmRDSms0kRz3CYoS+8B7oLJfwHLPfUbx+EQaY5WswW7UctgmFzDy4/N1zktYpzO0j5PVlv4sB/q1iQ7JlVA16lJUTdYPEQsCYQydniw2/NGEdUuyPppwGzMhYY5BilPl54eEUpBhJyuENdvN/r9hwb2fmp99T2pyr/ZaXujqMRXo+MtvZ3Ui5k6gYP6zDn+lmanfXJxwc/DrckjhWGP4JNey/8ffjfhSmhwyaBsICQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e3e595-4402-4569-f3f0-08df4635ffe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 12:09:45.0350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fb0St7YrbIGbYRNfUYWtBRaQvD6EWcaBXHUfPbrQkf+d2RLJPxs27hQ9HverVAR8XxHygE0DnA8VXto7T61tFeO6gSGEuFWeGnFZDN9+Akc=
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
d2wtbmV4dCB2NCAxLzRdIGljZTogZml4IGNvbXB1dGF0aW9uIG9mIEVURiB0aW1lc3RhbXBzDQo+
IGZvciBFODMwDQo+IA0KPiBXaGVuIEVhcmxpZXN0IFR4VGltZSBGaXJzdCBvZmZsb2FkIGlzIGVu
YWJsZWQsIHRoZSBpY2VfdHhfbWFwKCkgZnVuY3Rpb24NCj4gY29tcHV0ZXMgdGhlIGFwcHJvcHJp
YXRlIHRpbWVzdGFtcHMgZm9yIHRoZSB0aW1lc3RhbXAgcmluZyB1c2VkIHRvIHNldA0KPiB0aGUN
Cj4gdHJhbnNtaXQgdGltZXMgZm9yIGVhY2ggcGFja2V0Lg0KPiANCj4gSXQgY29tcHV0ZXMgdGhp
cyBieSBjb252ZXJ0aW5nIHRoZSBza2ItPnRzdGFtcCBpbnRvIGEgdGltZXNwZWMgYW5kIHRoZW4N
Cj4gdGFraW5nIHRoZSBzdWItc2Vjb25kIHBvcnRpb24gZnJvbSB0dl9uc2VjIGFuZCBkaXZpZGlu
ZyBpdCBieSB0aGUNCj4gdGltZXN0YW1wDQo+IHJlc29sdXRpb24uIFRoaXMgdmFsdWUgaXMgdGhl
biBpbnNlcnRlZCBpbnRvIHRoZSB0aW1lc3RhbXAgZGVzY3JpcHRvcg0KPiB1c2luZw0KPiBpY2Vf
YnVpbGRfdHN0YW1wX2Rlc2MoKS4NCj4gDQo+IEF0IGZpcnN0IGdsYW5jZSB0aGlzIG1heSBzZWVt
IHJlYXNvbmFibGUuIEFmdGVyIGFsbCwgdGhlIFR4IHRpbWVzdGFtcA0KPiBkZXNjcmlwdG9yIGZp
ZWxkIGhhcyBhIG1hc2sgZGVmaW5lZCBieSBJQ0VfVFhUSU1FX1NUQU1QX00gd2hpY2ggaXMNCj4g
R0VOTUFTSygzMSwxMykuIFRoaXMgaXMgYSAxOS1iaXQgd2lkZSBmaWVsZC4gV2l0aCBhIHVuaXQg
c2l6ZSBvZiAxMjgNCj4gbmFub3NlY29uZHMsIHRoZSBtYXhpbXVtIHJlcHJlc2VudGFibGUgdGlt
ZSBpcyBvbmx5IH42NyBtaWxsaXNlY29uZHMsDQo+IGZhcg0KPiBiZWxvdyB0aGUgc2l6ZSBvZiB0
aGUgdHZfbnNlYyBmaWVsZCAoanVzdCBzaHkgb2Ygb25lIHNlY29uZCkuDQo+IA0KPiBUaGUgRTgz
MCBkZXZpY2UgdGltZSBpcyByZXByZXNlbnRlZCBhcyBhIHNpbmdsZSA2NC1iaXQgbmFub3NlY29u
ZCB2YWx1ZQ0KPiBhcw0KPiBzZWVuIGJ5IGljZV9wdHBfcmVhZF9zcmNfY2xrX3JlZygpIHVzaW5n
IGEgc2ltcGxlIHJkNjQgb24gdGhlDQo+IEdMVFNZTl9USU1FX0wNCj4gcmVnaXN0ZXIuDQo+IA0K
PiBBY2NvcmRpbmcgdG8gdGhlIGRhdGEgc2hlZXQsIHRoZSBoYXJkd2FyZSB1c2VzIHRoZSBmb2xs
b3dpbmcgZmxvdyB0bw0KPiBkZXRlcm1pbmUgd2hlbiB0byB0cmFuc21pdCB0aGUgbmV4dCBwYWNr
ZXQgaW4gdGhlIHBhY2VkIHF1ZXVlOg0KPiANCj4gICBoYWxmX3dpbmRvdyA9IHdpbmRvd19zaXpl
IC8gMg0KPiAgIGlmICh0cyA8PSB0aW1lcikgew0KPiAgICAgaWYgKHRpbWVyIC0gdHMgPCBoYWxm
X3dpbmRvdykgew0KPiAgICAgICAvLyB0aW1lc3RhbXAgZXhwaXJlZA0KPiAgICAgICBwYXNzDQo+
ICAgICB9IGVsc2Ugew0KPiAgICAgICAvLyB3YWl0IGJlZm9yZSBzZW5kaW5nDQo+ICAgICAgIHN0
YWxsDQo+ICAgICB9DQo+ICAgfSBlbHNlIHsNCj4gICAgIC8vIEhhbmRsZSBwb3NzaWJsZSByb2xs
b3ZlciBjYXNlDQo+ICAgICBpZiAodHMgLSB0aW1lciA8IGhhbGZfd2luZG93KSB7DQo+ICAgICAg
IC8vIHdhaXQgYmVmb3JlIHNlbmRpbmcNCj4gICAgICAgc3RhbGwNCj4gICAgIH0gZWxzZSB7DQo+
ICAgICAgIC8vIHRpbWVzdGFtcCBleHBpcmVkDQo+ICAgICAgIHBhc3MNCj4gICAgIH0NCj4gICB9
DQo+IA0KPiBIZXJlLCB3aW5kb3dfc2l6ZSBpcyB0aGUgbWF4aW11bSB2YWx1ZSB0aGF0IGZpeCBp
biB0aGUgMTkgYml0IHNpemVkDQo+IHRpbWVzdGFtcCBmaWVsZCwgdHMgaXMgdGhlIG5leHQgcGFj
a2V0IHRpbWVzdGFtcCB3YWl0aW5nIGluIHRoZSBxdWV1ZSwNCj4gYW5kDQo+IHRpbWVyIGlzIHRo
ZSAxOSBiaXRzIG9mIHRoZSBHTFRTWU5fVElNRSBNQUMgdGltZXIuIFRoZSBjb25maWd1cmVkDQo+
IHRpbWVzdGFtcA0KPiAicmVzb2x1dGlvbiIgZGV0ZXJtaW5lcyBhdCB3aGljaCBiaXQgcG9zaXRp
b24gdG8gY2FwdHVyZSBmcm9tIHRoZQ0KPiBHTFRTWU5fVElNRSByZWdpc3RlcnMuIFRoaXMgbG9n
aWMgZG9lcyBub3QgcGVyZm9ybSBhbnkgY29tcHV0YXRpb24gdG8NCj4gZGl2aWRlIG91dCBzZWNv
bmRzIG9yIHRvIGhhbmRsZSBhbnl0aGluZyBsaWtlIGEgdGltZXNwZWMuIFRoZSB0aW1lc3RhbXAN
Cj4gYW5kDQo+IHRpbWVyIHZhbHVlcyBhcmUgY29tcGFyZWQgZGlyZWN0bHkgd2l0aCBsb2dpYyB0
byBhY2NvdW50IGZvciBoYW5kbGluZw0KPiByb2xsb3Zlci4NCj4gDQo+IEJlY2F1c2Ugb2YgdGhl
IGZhdWx0eSBsb2dpYywgYWxsIG9mIHRoZSB0aW1lc3RhbXBzIGNvbXB1dGVkIGFuZCBwbGFjZWQN
Cj4gaW4NCj4gdGhlIHJpbmcgd2lsbCByZXN1bHQgaW4gdGhlIHRyYW5zbWl0IHRpbWUgbm90IG1h
dGNoaW5nIHRoZSBkZXNpcmVkIHRpbWUNCj4gcGVyDQo+IHRoZSBza2IuIENvbnNpZGVyIGEgdGlt
ZXN0YW1wIGV4YWN0bHkgb24gYSBzZWNvbmQgYm91bmRhcnkuIFRoZSBjb21wdXRlZA0KPiB0aW1l
c3RhbXAgd2lsbCBiZSAwLCB3aGlsZSB0aGUgYWN0dWFsIHZhbHVlIHNob3VsZCBiZSAoMSwwMDAs
MDAwLDAwMCAvDQo+IDEyOCkNCj4gbW9kIDJeMTkgb3IgNDcyLDQ2OCAoMHg3MzU5NCkuDQo+IA0K
PiBGaXggdGhpcyBieSBkaXJlY3RseSBjb252ZXJ0aW5nIHRoZSBrdGltZSB0byBuYW5vc2Vjb25k
cyByYXRoZXIgdGhhbg0KPiBjb252ZXJ0aW5nIHRvIGEgdGltZXNwZWM2NC4NCj4gDQo+IEZpeGVz
OiBjY2RlODJlOTA5NDYgKCJpY2U6IGFkZCBFODMwIEVhcmxpZXN0IFR4VGltZSBGaXJzdCBPZmZs
b2FkDQo+IHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUu
a2VsbGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX3R4cnguYyB8IDkgKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2VfdHhyeC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWNlL2ljZV90eHJ4LmMNCj4gaW5kZXggOTMzMWIwMTEzOTM3Li5mMzRiMzliODkxYTcgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfdHhyeC5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfdHhyeC5jDQo+IEBAIC0x
NTE4LDEwICsxNTE4LDkgQEAgaWNlX3R4X21hcChzdHJ1Y3QgaWNlX3R4X3JpbmcgKnR4X3Jpbmcs
IHN0cnVjdA0KPiBpY2VfdHhfYnVmICpmaXJzdCwNCj4gDQo+ICAJaWYgKGljZV9pc190eHRpbWVf
Y2ZnKHR4X3JpbmcpKSB7DQo+ICAJCXN0cnVjdCBpY2VfdHN0YW1wX3JpbmcgKnRzdGFtcF9yaW5n
Ow0KPiAtCQl1MzIgdHN0YW1wX2NvdW50LCBqOw0KPiAgCQlzdHJ1Y3QgaWNlX3RzX2Rlc2MgKnRz
X2Rlc2M7DQo+IC0JCXN0cnVjdCB0aW1lc3BlYzY0IHRzOw0KPiAtCQl1MzIgdHN0YW1wOw0KPiAr
CQl1MzIgdHN0YW1wX2NvdW50LCBqOw0KPiArCQl1NjQgdHN0YW1wOw0KPiANCj4gIAkJc21wX3Jt
YigpOwkvKiBvcmRlciBmbGFnIHJlYWQgYmVmb3JlIHBvaW50ZXIgcmVhZCAqLw0KPiAgCQl0c3Rh
bXBfcmluZyA9IFJFQURfT05DRSh0eF9yaW5nLT50c3RhbXBfcmluZyk7DQo+IEBAIC0xNTMxLDgg
KzE1MzAsOCBAQCBpY2VfdHhfbWFwKHN0cnVjdCBpY2VfdHhfcmluZyAqdHhfcmluZywgc3RydWN0
DQo+IGljZV90eF9idWYgKmZpcnN0LA0KPiAgCQl0c3RhbXBfY291bnQgPSB0c3RhbXBfcmluZy0+
Y291bnQ7DQo+ICAJCWogPSB0c3RhbXBfcmluZy0+bmV4dF90b191c2U7DQo+IA0KPiAtCQl0cyA9
IGt0aW1lX3RvX3RpbWVzcGVjNjQoZmlyc3QtPnNrYi0+dHN0YW1wKTsNCj4gLQkJdHN0YW1wID0g
dHMudHZfbnNlYyA+PiBJQ0VfVFhUSU1FX0NUWF9SRVNPTFVUSU9OXzEyOE5TOw0KPiArCQl0c3Rh
bXAgPSBrdGltZV90b19ucyhmaXJzdC0+c2tiLT50c3RhbXApOw0KPiArCQl0c3RhbXAgPj49IElD
RV9UWFRJTUVfQ1RYX1JFU09MVVRJT05fMTI4TlM7DQo+IA0KPiAgCQl0c19kZXNjID0gSUNFX1RT
X0RFU0ModHN0YW1wX3JpbmcsIGopOw0KPiAgCQl0c19kZXNjLT50eF9kZXNjX2lkeF90c3RhbXAg
PSBpY2VfYnVpbGRfdHN0YW1wX2Rlc2MoaSwNCj4gdHN0YW1wKTsNCj4gDQo+IC0tDQo+IDIuNTYu
MC4yMTUuZzQ3ZmRmMjIwOGM1Yg0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8
YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=
