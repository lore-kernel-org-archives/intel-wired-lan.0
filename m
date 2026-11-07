Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E2606A333
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=CclfTTXY;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mFpmMl88
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F3B24094E;
	Sat,  7 Nov 2026 03:32:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZwXpdV-mBZMZ; Sat,  7 Nov 2026 03:32:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DBF0E40966
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794022379;
	b=IIe+CrmZnu+6kvcwuQPmwAxtvBGi4eQNeGldfP2LQKU+tyJ/ACmtkIKb9YvD1mtGCY1r
	 HvbUbUu4jk4WB49tZzTqK3hRnBdxU2bIXe5mc92vuF4zw2+WL4C59SvVtuKiRy8VPYq3S
	 pWezNKctV0ICQPzx0BSpiVAn7AUKmTSIZ3KRtMmDz5TrbzG5InHMVasf+d5h7voRS0hc8
	 owpaiaQYkMmIAUGq2tMbDNmYuRavw7G9XqvGBky0tUqB0jLGcYDsa0xBX2KHPrjC8Vo6T
	 Vh404k/2clHMARB/NVH2zUxfnEpxFA/S74vsMBBrL1nOiaKIIykgk/CQSzDWHJg7LnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794022379;
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
	bh=W3cArQinU2DOOhL5HHjf7OIhJWGRMnxeh9Cs0n3igcI=;
	b=EHmfabpsgGEC1NVtsN8CGGgwGi2Ya6/o5aNp3YCxGfWslcrrlYtcsZMgjFyCKeaMbPHf
	 uYipj1Pjrb4Sl4iPe8a5o8ukMhgmsDd8+BDSidm7FqdW+Ca/Omlc9zoyvtkYEgqZUxXW9
	 DOQs07imEdIR49/Lon/hrBt/zpa2aLZyMTtjk9wmQ7z1S2tDiSSUgO4W7LOzwcvh71jkk
	 ur2EdJy90RLYE8kD2y5gK/NP84s+wDD7Pl4DHpiAjYWGhxSmbD3NT5OV+ShS+zL3QqIEi
	 J1gLpeS2JtVNEsoYGuYVAeQ17n2iKoppUYwaJpctRsGoOluHRx480jEuPoedf7zWIXQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794022378;
	bh=W3cArQinU2DOOhL5HHjf7OIhJWGRMnxeh9Cs0n3igcI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CclfTTXYm5qnvujwJMeSOuw5OJcYQZ5tYrqGZW8xtcyWs0I2FoL7WUgQoIvVnxRCY
	 s/XONeDDxRqhqOjmCX9opKJwRcUJkKwuZwarkg9TnILQxUlbZ+ViXHRbKMcqTT2vHO
	 xUEfR0cc0MUNhnAAiVtNse1dGsVGZ2RLbLurUtyDEwFO0MhO6Fh31636GfIJ8+8xI/
	 MmG0BdK+in2P8Oaw88cDDotTlIOLMXitoGDcaiIovmSXBEk8FghXlGwpaWE5DmqTKk
	 n4pydq6gCxvr1/wqkB5ghXYm7YAvsHc8N6IvL7/GT5fRmPBfuRAFXwnmeoTQMN70AJ
	 mEAGne4X8xvEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBF0E40966;
	Sat,  7 Nov 2026 03:32:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C868D2AC
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:32:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C58678122C
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:32:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9YT423aE_to for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 03:32:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91B8981215
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mFpmMl88
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91B8981215
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794022377; x=1825558377;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y8rpzHgrRcUixekChLxVburJblsXpppfgqOeAoKOeBw=;
 b=mFpmMl88YsB75eD54Yjqo69W7pQfVcXGFu16mxoolBeJ9+cVPJtubtb1
 jchB3aZRvAAhiE8dFaX72FkAudAgBYnFXp7P3/nB8rsTYGrreaKDkrD+v
 BhDjlM3+Mf7sNID2MV8j5Da68i8FvH5e/jO8Efq45clzesz3yMIZle+fa
 AfH3yR2dPtLWiB/qxf+xCPeZBLmCAw40Z+/0h1WfXXLian0s6Ju0ht5Y7
 pejRRlgN2ERXLoytm0/v+aqSe+3VfmF0EyWODiBnax8wBrmGQFVxQrnD2
 Haj34dik/OlNTnnX/D9KiImAVxnU7gpKRJPtigCi3eX615tF9BGacpt90 g==;
X-CSE-ConnectionGUID: R5m88y/0SvWjZQPanJdPsA==
X-CSE-MsgGUID: 8/c0B9YEQQObhwaThcHE4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2851502"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2851502"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 19:32:55 -0800
X-CSE-ConnectionGUID: L3BbwEqLRDSR64Dx5oiHfQ==
X-CSE-MsgGUID: uTibMEROTj61+9IMymv6rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9176412"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 19:32:55 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 19:32:54 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 19:32:54 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 19:32:53 -0800
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DM3PPF5217261E0.namprd11.prod.outlook.com (2603:10b6:f:fc00::f21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sat, 7 Nov
 2026 03:32:51 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 03:32:51 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-next v2 08/10] ice: use libie_irq for interrupts
 managing
Thread-Topic: [PATCH iwl-next v2 08/10] ice: use libie_irq for interrupts
 managing
Thread-Index: AQHdQfHi7ondtzSh+E6KLXINseLLTbciTUGQ
Date: Sat, 7 Nov 2026 03:32:51 +0000
Message-ID: <LV1PR11MB87901429BC7B4FAA4983A28590752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-9-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-9-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DM3PPF5217261E0:EE_
x-ms-office365-filtering-correlation-id: d561c4fc-5802-4d51-947e-08df3c7fcd5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|261021123027099003|11063799006|4143699003|56012099006|261026140227099003|261009223027099003|261028144727099003|261026121527099003|261021121427099003|261022105027099003|10067099003|261102123227099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Ao6SlK3TrCN5dQwW/8Pai3TdiGWtdQG3X8p78WCCC9191IGCgbCtdhmAYZRaAgak/oXVd/6M80gvFEnBXlqqFVBdIqMftvOG1xx+f9IBzk5u8TOBqg8ACzUuZtB5YITwU5hZneLO67vw3rnCcxBUBJX/TMfqjFDYvrPG4FLLECkkanGsZSgm0a0HClYA38rM4nQQayncQ42XySR633CTSDq7JWt2k2kVfhwBqkkBn3kE4GmVwUwOD2hi5BWdbztktSRFcJTJYcronQZ22EVZ2APYcdGcdy/HImqDf21E5ffDj5w1OMsXeNj8aUg1vvtm8tL14Uqfw7k1zkTl6iMyDRR/27HIXgdRly093q5yocERUAyu2lpykojhWhlbp8UqtWCw0/UPHrByNVhw1Jw+DL32d9gQhQWvQv6Q93MnttVcur+dJp2kgWOJPID5x1d6pNJNXc8bv/DPS/JzlpYWpkqFQCzVuGSThaxSchKRSLpk6XP6UbP+JqqgDjj5wAcaP3twn/0hUUeKwljAYOxZ7X8osOYys9RDQ9kKnrZugnqXdH7qI1hHIQulb7su46kVQGUpwzgJJ/8q/sCBP3yFztuQifpZiwVK0LrLlRXJp3r/daoGMgq355pA+qvQ0belDL0EARrzbCH9O2k8/fuoUxNbm35L3PBjnQTkvZ1JDq7iTDy/D8HF1VbODTYFOZYWBNt/+AVs6+nEyN1n0IunDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(261021123027099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261009223027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IR6Zd80Pu3TnqVLfpTXLHRp6HOLm+LnkkqpuOCJlapCjXo+vTSyt5vX0sX4q?=
 =?us-ascii?Q?y8ToQ5Zwsmn60f3HVJAVi1mf80AsRrEHU8uD1ST/1ti7ou295+r0rgD0XNQY?=
 =?us-ascii?Q?mLQ3YHx2jiTKJS/fLbhg3l2BVugMaS2Rm8ZKHIImlps7iiWod48+VNu1vsSP?=
 =?us-ascii?Q?M7y7ZRpcunv4YD+kkrTF+RaiEXoTWeRS8ij7KIh4SM+Upjv/nVL0UnZIk/+8?=
 =?us-ascii?Q?qn+cITJ/2ai1cKXbvqBcjBYaG/QiSUtmffbqnCJv4CayxbyHznmVW7z1emkw?=
 =?us-ascii?Q?Fqw2Pd0+j+oG1Lq++RODupU/sM80hP2Cre0hqMYft8JvgYac96sfOoD0WgAX?=
 =?us-ascii?Q?m/T9CV56DO7OybpTML5UamdLiraY2hl+Khm4G1zFDUoemWaDmT1yTW6Zuw5C?=
 =?us-ascii?Q?11wdozhUBTQ6nAtw1ANEgoi1xxeAKOswgBpO6uAN5/Na3OyeWp7xgwEG/oRo?=
 =?us-ascii?Q?3nOpofI1D67YZW5xcJN+pFdEjo0wX/W520GWr6pOLTvaqy+wDRcAG/4HRaAZ?=
 =?us-ascii?Q?Ypic1j2O4upCKyMVWFAjXlzsF05/SnZC/6bgsYAV0asTUxOXEql1WeiGSxPv?=
 =?us-ascii?Q?RLO4EBYbgylPj+P7uQZgiYO0mJO6plzkb0FIMc3UXtWCBbA+FdLtjguhYFOZ?=
 =?us-ascii?Q?ogJaUkObQcGWuyINDis06x3EJIUxpSxVGJ8lxuzG1Ryg4nXBah/Kesk8BYD5?=
 =?us-ascii?Q?S1pjAE+KAAtp1aXkMmDbcsiuAIVT4wZCBC4bHYAD5m6aKMOucTjReGYeC7lF?=
 =?us-ascii?Q?V6hiY88f7Eb0dQUJoVjfHKtwlyJjxrLaweKY/a1270/4V+jfb96eul1crGh1?=
 =?us-ascii?Q?VLTSEo9e82VqtQACYStGCRpikXxiaf5vSh7t67XiWBTbIAskJI1uS3lEcHFV?=
 =?us-ascii?Q?q1CAREvgOeDYFwTyYm32DmlXnSlXFOrGTsgh02RUIJlmnAD0bAZPk6jkzWya?=
 =?us-ascii?Q?JCtFpcjJGQ9HzpJ7WM2sJS40sLnuUI0uR3oL8zEWGLz2TE2tD4vT/iVpLV4a?=
 =?us-ascii?Q?LoYOdtxXSlNjRp5ZXqWm0PR917epXsKi6uiMKdxnNZnH2yCOcyohS3cFtzDB?=
 =?us-ascii?Q?KdSsBAl2EU7VKaGkAS5WicJSi1eMu6TPIjvOCNojI/LPOcELg8ApDDTRDjS/?=
 =?us-ascii?Q?gZ2HNXkQL7c7UhZcGzwZZHxo8m1Yk4hNfZLNw2k6sOWmaxPNglNMJEZdsumN?=
 =?us-ascii?Q?NV81F6UNuPiPjmWzCy3od3+6XQeGCYFUjUmhGbFAnHPjdW8zwrbHlEMyt4km?=
 =?us-ascii?Q?mmDhMysQ7NtxGtTXNF0JBG5bmWN5JkXlFeiPd9Zbqk3cxC9Ds/dbthBuwNim?=
 =?us-ascii?Q?kenRNdWxIDC6tQSXn1sPNLWlB+UDlcp6HAAObCpCUkuSKkSXHSxBH+jZDOky?=
 =?us-ascii?Q?kkCaeSLu86/wKWv007c+bMDzE5elqBalOyiHPyPG6bVUCbJqIfIWV0DTMURI?=
 =?us-ascii?Q?09o4Hxev+eMwKPBTGZMfDDHMBZ5++wvtr8Gusmy8JtAc2sklVvbjqhzwLZ/+?=
 =?us-ascii?Q?9vNoraohIM5YyQhlMj4hMmpGRwA9oRwE9yU30IR/5LqW+hK6lhlEvxmsD46o?=
 =?us-ascii?Q?SdU+RSX72COy45RY9xffROrS61lSHfnjyY0HQ/MvVWihdBBkxDvwnIGGBDLJ?=
 =?us-ascii?Q?l/jaVNLn8FsTBgntdnsWAtBnzlUzXORHLrrDJkDd9vs66znlxgURMCjv3g8l?=
 =?us-ascii?Q?tpupvOu2apnrK0Pu4X/B75I8Jbb7JBeyzdHdcaJCk9XqylXR7U6XJeDzlwdT?=
 =?us-ascii?Q?qFkhpsjlgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uuYnj6IyF9dAOT01xEhoQOks++z5pbHKbINevq8EUMivBeLuQpwX+q4PhTGjpg9+TIRddek23H4MI+g7WRO7srqIDkXUQZYO6KWDrQ7Es/RLrQt38dcHiN1nTeYwN1WshlMxLDi2kAulfUu4tGmTpfDXSE1hP37QJ/MmLC1u8m1xGNU29+mF22x46ZYqu5pO2yU6NSDuocyrV+qH1tgoHANoTdk+RPDIO+BXbM3NKYA7MhaQEAxbqiLHh9f1mld/i1rWnmbpcJbDH4TxNT8qlp7PzYmhoF0nddXEty3byyNw9dNhExpDjGGi0tZbYM1XC576QrWIsgnEFcRDnuppxQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d561c4fc-5802-4d51-947e-08df3c7fcd5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 03:32:51.2986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXuKN72T42t6RYNu/hAoXoS9ULF7Hi7RIKQedRwSPbbWgrkKWD2GEPbDeUDOJGplCjejnHSEQIosRGmW6qss/2hyp943N0g2pEEAZAdLM3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5217261E0
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>=20
> Sent: Friday, September 11, 2026 5:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski <michal.swiatkowski@linux.=
intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [PATCH iwl-next v2 08/10] ice: use libie_irq for interrupts mana=
ging
>=20
> Change interrupts code to fit the libie_irq calls.
>=20
> There is not many difference. Bool for dynamic alloc in libie is changed =
to enum for static and dynamic. Rest code is the same. Instead of custom ic=
e_irq_tracker there is libie_irq that tracks the interrupts.
>=20
> Code fallback to static when there is not more dynamic. Previously it fir=
st used static part. Getting dynamic first better fit the lib code. It isn'=
t breaking current driver code.
>=20
> Dynamic alloc is always set to true if there is support. In libie_irq cod=
e check for dynamic support is done inside. LIBIE_IRQ_ANY can be always pas=
s in case of getting interrupts for VSI. If there is no platform support it=
 is changed to LIBIE_IRQ_STATIC inside libie code.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig        |   1 +
>  drivers/net/ethernet/intel/ice/ice.h      |   5 +-
>  drivers/net/ethernet/intel/ice/ice_base.c |   4 +-
>  drivers/net/ethernet/intel/ice/ice_idc.c  |   4 +-
>  drivers/net/ethernet/intel/ice/ice_irq.c  | 181 ++--------------------  =
drivers/net/ethernet/intel/ice/ice_irq.h  |  14 --
>  drivers/net/ethernet/intel/ice/ice_lib.c  |   3 -
>  drivers/net/ethernet/intel/ice/ice_main.c |  15 +-
>  drivers/net/ethernet/intel/libie/irq.c    |  30 +++-
>  include/linux/net/intel/libie/irq.h       |   2 +
>  10 files changed, 51 insertions(+), 208 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
