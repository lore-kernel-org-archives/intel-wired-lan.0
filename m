Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD3606A329
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=eq28/7tP;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KU8uHdwX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 494B080F86;
	Fri,  6 Nov 2026 07:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tme4BoQyQ6KK; Fri,  6 Nov 2026 07:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5889480F8D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793949101;
	b=GzkEbZbRNv9Soq5YM0itJtKvSQbTNBMm7UUYFunNN6gCtwPVr8XmHq7/w07vR2ITTR17
	 NZVyfscsZFwaElbP+vy5FOn5Nk7BTTf2HhvZupmqNlizerQ8chjD0dJKSG+e+59G+npTH
	 YM8g88yhp8HCCR4xc+XqTgMx1CD+DTTVzpCfJmNPcyxEDHN2PKgH8Gg25fkd0E+82L0fh
	 c1GX76bLPckuGtkjRedC/9KTiFMwX4BYIwvxSpDV5rcQACkg05clxB5yDiFULuqnnoBHr
	 HlgAsTrVdXchEHeKlFG8tag40avqPQ8J4CVFhRkILZh3Hljx7qg1Hs/mRFjnK46a8tQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793949101;
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
	bh=9ylceJzcyMocHxs62AC8hMXM93tLhGiAuFwCnc2vxnU=;
	b=ltY6jBaXSMAaVvDXIFAaVtrFGB/u+HYSLqAqKttr8aQWgXFqqfXRT2FHx8nJkcWCkcUN
	 qnYiFlLlQc/s/a26V1ULt9+27G4zbFfqJuivGcPRUUbe1tbnTBWBC22fLwslIS2rPSc2K
	 e7eO6z0IH8LPppb1TVt/QRjRww7HGL2ZdwUJq63qQBwMjntGw5zZaq0ZAKSaK9/kiGoBi
	 Y/4oxryfdbJX50VdqnKNt+63rH0nTog3tHbEP+AybraXzbGv/9O+kxNaDOpcH+Fjx3VtH
	 IGFnvHVFep3kffkSt4BE0c/L2E70e/nzIMgn13tybpUfaHtB+873LXw1ErAveGpTQAg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793949101;
	bh=9ylceJzcyMocHxs62AC8hMXM93tLhGiAuFwCnc2vxnU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eq28/7tPmY8gncepGXxlFZtJY20u+/y0vnMX9YPjcA6esQLfKukTv24muJFd5O/rp
	 S2EVs2jUdMWzzJw4QPkqai3z2fW09HuvJ+ATf73F9JDyKvZBzHT641lYlsLhK0spBv
	 zTtzsXeci7BYxF6slKRcF/9krSvQQgcxglNZnamTPjWJ7WHybmoF2sUMYDzQpTBb0x
	 pKkL9Q+sB2FwQSZaL8XDD4KAhkOw0li3WWSWKYUchDembKh97RaFhdFqoNI/hpqWKk
	 2JCgMe4ITX4o4MHcKAlRMGQ3FfFu8A8Kc+5NZwNvb7PQEbQbCucK4Ebo0MSpKvuDub
	 /WpD/DlG33CpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5889480F8D;
	Fri,  6 Nov 2026 07:11:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F97E1E3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 07:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 254CB605B1
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 07:11:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y_TOFBfCRF7R for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 07:11:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8BF22605D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KU8uHdwX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BF22605D5
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 07:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793949097; x=1825485097;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9ylceJzcyMocHxs62AC8hMXM93tLhGiAuFwCnc2vxnU=;
 b=KU8uHdwXNq5kBN3nHpMTqnvvXqREb+JA2riVhwDqjtpo/pZPLUsLl0qs
 L35WyhY+ErU/xCMAvKrDzsZsko0zWnEmJp7akiW9bTkseyxaBTErNQ8Vg
 lTM2y1Zf6qTHfPIOR+JFo2Bv8P03BZsE9fJN4v8C4UMt5ceSXzzC9Oz4J
 hVzxgUy048G2WHe0qC25IaNwdE1ezvYs0vzmf35HPnLEYQT28meZiv90m
 DHlZ5FFB5PB+pI+JkLpgigHzvXQ1m2ZF2/l2r2g5EdtQgu6YOZHms4Suc
 2CteBujl/VIV/fchXVvnwo6H55D+7aX7r4Iw41bT1qFw/Qp9LMrbCSZ2j A==;
X-CSE-ConnectionGUID: f3Obu7QfQK6iMy3GkTcWKA==
X-CSE-MsgGUID: 62coe/aWTK+/ayq0AnkE4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2655616"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2655616"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 23:11:36 -0800
X-CSE-ConnectionGUID: wZVGSM6oSb6Bl7TI5A82Og==
X-CSE-MsgGUID: q+bua1jDS82QhLglOs/4ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7052138"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 23:11:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:11:35 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 23:11:35 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:11:35 -0800
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by MW4PR11MB6981.namprd11.prod.outlook.com
 (2603:10b6:303:229::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 07:11:28 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 07:11:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Naman Gulati <namangulati@google.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, Brian Vazquez <brianvv@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net v2] idpf: fix Rx payload buffer leak when header
 buffer allocation fails
Thread-Topic: [PATCH iwl-net v2] idpf: fix Rx payload buffer leak when header
 buffer allocation fails
Thread-Index: AQHdbYV4cpdVdVZRlUORR+cJTi0W+LcgoO/A
Date: Fri, 6 Nov 2026 07:11:28 +0000
Message-ID: <CH3PR11MB5668959C93EE1742BEF40143D6E5762@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261106002546.2100412-1-namangulati@google.com>
In-Reply-To: <20261106002546.2100412-1-namangulati@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|MW4PR11MB6981:EE_
x-ms-office365-filtering-correlation-id: bf640a2a-4a46-43de-f481-08df3bd52d3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|261021123027099003|261022105027099003|11063799006|261028144727099003|261021121427099003|261009223027099003|56012099006|261026121527099003|261022075727099003|261026140227099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: HnU1WGys6lD6FswaXtR31Wos2fyOlfS6zB8qXLxKnDJ0BHlGGEGFbV0TXsbm/GTkwp1wf6tko2FrSh7QIhTS4TJqJ0sreiNtoqWPfdK1W2ub/3pfLLFWDu5MELfFPF3Kdljqxo1TpHchvJbBNT8sj4kT8a7e9f9w6yNyzCw3aBzXjlYrvpXSVOf0Znj0dWJ/WkBN1dd2eQQgGKB29w0s/Rg86N6b4lAtuDXgAR/BzH84vdRqjZM0c5T/UHIfgicxBWWt6seoLeJu7on/TFEMCCqLuO/wuNtmynTRTwnbra/GwV/G+m6NZEuS6ai9y/OpuD8FpEtRSL2dwYbCTUb3FIHjPuPC5z2G9RRngcX+wn+KN9dK20o7w6xg+nVMOgF0t1Q4PCgYHDwIhf+oNYY9DR9qx6kp2OxAj2DRCOVicPQY6AuwlHZMVYEic513Rxmog+CprzsII/6pfxdMott0JYOjnFwjgGBjvYCfOogJK51BSrdL0WdxVHss/PKYZywzUg9ypO7XtL2fMkRcp9Ycr9hwXMgko75Mye03tMzE61J01S5TWnVnI8P4npNtgXNxCW4aObei44CAQBrY6b5rnBxBlD/vT1wa3ed6q6Lq8NSICMrxHEK6OQ4ivbdGj+W0En3jlNSlIbWGmyWkQgqfvkhTUXnrdbW9Y1jSfDvz1Y+30UMgE6+dvGckqHfNusbB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(261021123027099003)(261022105027099003)(11063799006)(261028144727099003)(261021121427099003)(261009223027099003)(56012099006)(261026121527099003)(261022075727099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWdHUjhwMjFwVmxoeHREenFHM051MTVHdlV5RDB3RjRsZTdpeEFCRHhwN2pK?=
 =?utf-8?B?OUE1MXo0c0ZDdVp0Wi83OHhZZlN4dmp2YzZvY1pRMXFMSnR0ZnFEa2U1c1VC?=
 =?utf-8?B?ODRYbmdVcTRUbGRqL2lCdVRSTE5VUEovNjh6RkswczB2NnFhSjJBRDZOTjk2?=
 =?utf-8?B?NGRRN25hbThjaWJtZnpCeDFpS0ZxK1orcGtUb2EzeHZ5NWZCbk5rZCswRVZv?=
 =?utf-8?B?YkE5MUQxVHJQdkQwUjRPNDlWaUl0OW55bTdZdS9iYzcrREZaaUU5UUlnem1o?=
 =?utf-8?B?a0FpdU4xRnlpbEFtVVBsME5TQVFsbFdaVUcvSHBFNXN6WllkVmwvVHVvUFlh?=
 =?utf-8?B?cm8rYU81dk52N1dmeTc0NDQxR1YxMkgvZ3Z2YnhydFdYZmVJU0RpSGJIRWRs?=
 =?utf-8?B?ZkRya25iV0tRenQ2YkZDQ00vUG9sVjBqU3JMQ1dDdkRJVGxmWTljS2dtdGRl?=
 =?utf-8?B?VEUvdHRiTEovV2pGZjNTWjlwSlVwR200a0J2bjN6SDcxUG1QZGxSRHBqaGpU?=
 =?utf-8?B?Zm80ZTlWdnNTWlMzRGFmZ0N2U1d5NFl3d25YQnF3a3lCek1JYkVNaGtBUXpu?=
 =?utf-8?B?d1pjS21qNG9rZ1AvVEs1WGNULzJ2L1hyOHBMeURGSk1GNG02ZHJZbFpXZjlp?=
 =?utf-8?B?dGR3T0srU1JrbUVmdHQxRVU1Q0ZUNUVIQUVISjdyWVgrMGhWV1FTalNDUnQ4?=
 =?utf-8?B?ZkQvZkJmZHZVNXFqNzlyU3dXUGNoeDh6QWxzZStFYTNYdk80Qi8wancwL04w?=
 =?utf-8?B?OU4xOEFtY1ovYjVraVM2VExySHIzOTRCMnIvUk85d3dxcGlwT3pySk1BWXRz?=
 =?utf-8?B?ZXlnZWZxSmQybDRsaGw3ZzV3c3VBVG0wM3BySWdpUnRyL0JqYUY0cUJ1bVVV?=
 =?utf-8?B?cGF6bjZuZ1p3VEJXQmlxb1pUU2c5Z0lZa0ZDVlZNRVdmdU43MWQ1aXhVdzhq?=
 =?utf-8?B?NmZXQlMxRGtUbXZCOGpPK0N6ZTAwUnZJL2crTlNNTHhRTzY3SDZkNi9CQmZy?=
 =?utf-8?B?bTRJVmx3YllySVgrV2ZXWnpyNnlvWDh6dUc3OEhLa0pXdzdHUFZ4Q3g3YXNa?=
 =?utf-8?B?dWwrSVc1UkRESmdTZzhFTkNHeVRSTklCdU5VeE1ScmVvSStiQW9tYUZranM3?=
 =?utf-8?B?RVR5VHc5MGVjNkJHSVdmWEdiKzk3Skp0RE4yd2haV0dQWElmSzNXdjE2MEYz?=
 =?utf-8?B?YXF3cnRHcFoyK3pXUTMvc2thOEg5R3RJMzYwRDIrWkw1QU4rZ0poeXB2VkJs?=
 =?utf-8?B?QnBPOFZndDV6YVFMU0ltbk5mTFpPWDY0VlBnNm1RVWJSeEcxQTZkT2k2SWJY?=
 =?utf-8?B?ZUd4blN3R0JRNm5UZ2pJTE9QTWZ0R0U3M3hDMXNoRDZ1Q2dJNXQwdlpFSFZI?=
 =?utf-8?B?Ymk1dkFzaHZCOE9MVUJZTEVVMUZZMS9IRU4vcC8zaElkN3gwTWorVWF4NGdH?=
 =?utf-8?B?Q0V5UThndWx6aWlJNmlEalhXQ0Z3cWhoeHRsQWI3RUUrZVc1VzRtd0VkUUdF?=
 =?utf-8?B?cnhoUFZhQ1JnUEFuck44NVJoZTkxY0RaZm1VU1BUZS9ZRUtEWnkzeTVZeVhV?=
 =?utf-8?B?bUMwNEpOdll3aDRYSkNjbk45NC9KakdxMGNncmZwMEhCRkkraG4zYjJnZHNk?=
 =?utf-8?B?UU1hcDYzM3d5ZHgzVklyT05uYXhXYnlIc1RDZlVvaDBOMDdvb1dxeDFMOW1Z?=
 =?utf-8?B?dEVTNEFYQUlnVGtWTFpIMi8vQ1ByODA3S2JHeWl6cUd3UnVYQmZvdFBRaTgw?=
 =?utf-8?B?ZTNOR21QZy8yTkZOUll4R3g0NEJWRDFtR2RYTENPRU9INFJMa2hzSkpJRlhY?=
 =?utf-8?B?OTFvTzVGdkhjYkVEVVB1VXZmSjFXWlJrTThLKy95d3pMNVNlbUdWTTVTZ2tj?=
 =?utf-8?B?WHRJVm1rUTB3eHRpd0VIU3JNWi9tU0JjUjVzRitkZmRJa3lqY3dVclFkc29S?=
 =?utf-8?B?UEN4TVRoakIyUllaa1JkUVhxUE05OXNuM0Z5VXgvZ0FaWkY5NWU5STBBZWN6?=
 =?utf-8?B?N0RSRzhkRUJMQXFvNWVPMitxT0xJS2VxODEvZzBkblAzZHNjVHZGK3QwdWZ2?=
 =?utf-8?B?VEhjdVpLTVFPb0F1MktDMnY2VWtFT1I3NFN3SzE2b3c4QzBXMFFTTDUvTVRP?=
 =?utf-8?B?MXMvK1h6emppWFZ1UWg1elhsYlhCVFExM3FYSlQxRFhUZHNUQjlQc2hYNWY2?=
 =?utf-8?B?TDljazVEdnJRT2hIOCtHUnR2VUpES1dxNjQ0bGM1UC9INkQyem90YVd1YnFY?=
 =?utf-8?B?SHBKbmJMMFVjQ1NzdkRkWDJyd3RVODVUVkViTkJMVU5NQXh5WkVpNWl2TnAv?=
 =?utf-8?B?QzJNeE5McmpkN1pIbENDckRPeTdJMTI0WVc3MHpURjNJLzJpS1orVVFOeURx?=
 =?utf-8?Q?RK0h9PANAkP91ogE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Uac0wDGYhefq3ckkaeV1eN8Ni+fSP4THSTxZLrTE4HIf3jhbwit8D8PuiwX9u1X94spVJ81HxGPtdUvDTPU8HpxcsVSU9Vnu6D44IpOQKmn8C44NYyBaizPt6qEE6DBQsOZIK2Sue649RH+u2u+sZ/DYEzXj/nYHnLeXpU1SbZb+pxZd82zQrP2ErK5CVcNQ33XG4dCdKODAPJqVZg26pnn9yisY8sWudYoKbx9eeEzM5AimjoR5upZtI6Vgv9W5yiHYuZZMeFThqDap5po/4xQySRcJNmwOXj3KUCZQmzca7h5sbtNSbIXN46u7AoN17VyvsrUJBJESVd2JU/7waQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf640a2a-4a46-43de-f481-08df3bd52d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 07:11:28.2738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAE/m/As984zpdQHeGxFe+rkujc8xnuAkquvj78slnJccGjTx21NFeBpbCGWs6ziBlzYRUDefjbvbejyT8rURMcnOc3+DSwvy2AxCL5Af8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtYW4gR3VsYXRpIDxu
YW1hbmd1bGF0aUBnb29nbGUuY29tPg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDYsIDIwMjYg
MToyNiBBTQ0KPiBUbzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gQ2M6IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1
eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3pl
bEBpbnRlbC5jb20+OyBMb2Jha2luLCBBbGVrc2FuZGVyDQo+IDxhbGVrc2FuZGVyLmxvYmFraW5A
aW50ZWwuY29tPjsgQnJpYW4gVmF6cXVleiA8YnJpYW52dkBnb29nbGUuY29tPjsNCj4gQW5kcmV3
IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMgLiBNaWxsZXINCj4gPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGtlcm5lbC5vcmc+OyBKYWt1
Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRo
YXQuY29tPjsgTmFtYW4NCj4gR3VsYXRpIDxuYW1hbmd1bGF0aUBnb29nbGUuY29tPjsgc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggaXdsLW5ldCB2Ml0gaWRwZjogZml4
IFJ4IHBheWxvYWQgYnVmZmVyIGxlYWsgd2hlbiBoZWFkZXINCj4gYnVmZmVyIGFsbG9jYXRpb24g
ZmFpbHMNCj4gDQo+IFdpdGggaGVhZGVyIHNwbGl0LCBpZHBmX3J4X3VwZGF0ZV9idWZxX2Rlc2Mo
KSBhbGxvY2F0ZXMgdGhlIHBheWxvYWQNCj4gYnVmZmVyIGZvciBhIGJ1ZmZlciBJRCBmaXJzdCBh
bmQgaXRzIGhlYWRlciBidWZmZXIgc2Vjb25kLiBJZiB0aGUgaGVhZGVyDQo+IGJ1ZmZlciBhbGxv
Y2F0aW9uIGZhaWxzLCBpdCByZXR1cm5zIC1FTk9NRU0gYW5kIGxlYXZlcyB0aGUgbmV3IHBheWxv
YWQNCj4gYnVmZmVyIGluIGJ1ZnEtPmJ1ZltidWZfaWRdLiBpZHBmX3J4X2NsZWFuX3JlZmlsbHEo
KSB0aGVuIHN0b3BzIHdpdGhvdXQNCj4gY29uc3VtaW5nIHRoZSByZWZpbGwgcXVldWUgZW50cnks
IGFuZCB0aGUgbmV4dCBOQVBJIHBvbGwgcmV0cmllcyB0aGUNCj4gc2FtZSBidWZmZXIgSUQsIGFn
YWluIHN0YXJ0aW5nIHdpdGggdGhlIHBheWxvYWQgYnVmZmVyLg0KPiBsaWJldGhfcnhfYWxsb2Mo
KSBvdmVyd3JpdGVzIGJ1ZnEtPmJ1ZltidWZfaWRdLCBhbmQgdGhlIGVhcmxpZXIgcGF5bG9hZA0K
PiBidWZmZXIgaXMgbmV2ZXIgcmV0dXJuZWQgdG8gaXRzIHBhZ2VfcG9vbC4NCj4gDQo+IEVhY2gg
c3VjaCBmYWlsdXJlIGxlYWtzIG9uZSBwYXlsb2FkIGJ1ZmZlci4gVGhlIHBvb2wncyBpbmZsaWdo
dCBjb3VudA0KPiBuZXZlciBkcm9wcyB0byB6ZXJvLCBzbyB3aGVuIHRoZSBxdWV1ZXMgYXJlIHJl
LWNyZWF0ZWQgb3IgdGhlIGRldmljZQ0KPiBnb2VzIGF3YXksIHRoZSBwb29sIG5ldmVyIGZpbmlz
aGVzIHNodXR0aW5nIGRvd24gYW5kDQo+IHBhZ2VfcG9vbF9yZWxlYXNlX3JldHJ5KCkga2VlcHMg
d2FybmluZyBhYm91dCBhIHN0YWxsZWQgcG9vbCBzaHV0ZG93bi4NCj4gDQo+IFRoaXMgaGFwcGVu
cyB3aGVuIHRoZSBoZWFkZXIgYnVmZmVyIHBvb2wgcnVucyBkcnkgd2hpbGUgdGhlIHBheWxvYWQg
cG9vbA0KPiBzdGlsbCBoYXMgcGFnZXMsIGZvciBleGFtcGxlIHVuZGVyIG1lbW9yeSBwcmVzc3Vy
ZTogYSBoZWFkZXIgcGFnZSBob2xkcw0KPiBzZXZlcmFsIGhlYWRlciBidWZmZXJzIGFuZCBvbmx5
IGdvZXMgYmFjayB0byBpdHMgcG9vbCBvbmNlIHRoZSBza2JzDQo+IHVzaW5nIGFsbCBvZiB0aGVt
IGhhdmUgYmVlbiBmcmVlZC4gVGhpcyB3YXMgaGl0IHVuZGVyIGhpZ2ggZmxvdyBjb3VudA0KPiBU
Q1Agc3RyZWFtIHRlc3RzIHdpdGggbWVtb3J5IHByZXNzdXJlIGNhdXNpbmcgUlggaGVhZGVyIGJ1
ZmZlcg0KPiBhbGxvY2F0aW9ucyB0byBmYWlsLCBhbmQgdmFsaWRhdGVkIG9uIGlkcGYuDQo+IA0K
PiBSZWxlYXNlIHRoZSBwYXlsb2FkIGJ1ZmZlciB3aGVuIHRoZSBoZWFkZXIgYnVmZmVyIGNhbm5v
dCBiZSBhbGxvY2F0ZWQsDQo+IGFzIGljZV9hbGxvY19yeF9idWZzKCkgYWxyZWFkeSBkb2VzLCBz
byB0aGF0IHRoZSByZXRyeSBzdGFydHMgZnJvbSBhbg0KPiBlbXB0eSBzbG90LiBpZHBmX3J4X3Bh
Z2VfcmVsKCkgYWxzbyBjbGVhcnMgdGhlIHNsb3QsIHNvIHRoZSBidWZmZXIgcXVldWUNCj4gdGVh
cmRvd24gY2Fubm90IHJlbGVhc2UgdGhlIGJ1ZmZlciBhIHNlY29uZCB0aW1lLg0KPiANCj4gRml4
ZXM6IDkwOTEyZjlmNGYyZCAoImlkcGY6IGNvbnZlcnQgaGVhZGVyIHNwbGl0IG1vZGUgdG8gbGli
ZXRoICsNCj4gbmFwaV9idWlsZF9za2IoKSIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ICMgNi4xMSsNCj4gU2lnbmVkLW9mZi1ieTogTmFtYW4gR3VsYXRpIDxuYW1hbmd1bGF0aUBnb29n
bGUuY29tPg0KPiBUZXN0ZWQtYnk6IEJyaWFuIFZhenF1ZXogPGJyaWFudnZAZ29vZ2xlLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBMb2Jha2luIDxhbGVrc2FuZGVyLmxvYmFraW5AaW50
ZWwuY29tPg0KPiAtLS0NCj4gdjI6DQo+ICAgLSBBZGQgQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcgIyA2LjExKyAoQWxleGFuZGVyKQ0KPiAgIC0gQWRkIFJldmlld2VkLWJ5IChBbGV4YW5kZXIp
IGFuZCBUZXN0ZWQtYnkgKEJyaWFuKSB0YWdzDQo+ICAgLSBOb3RlIGhvdyB0aGUgaXNzdWUgd2Fz
IHRyaWdnZXJlZCBhbmQgdmFsaWRhdGVkIG9uIGlkcGYgaW4gdGhlIGNvbW1pdA0KPiBtZXNzYWdl
DQo+ICAgLSB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvaW50ZWwtd2lyZWQtbGFuLzIwMjYx
MTA0MDEzNjA2LjE1Mjc3NjctDQo+IDEtbmFtYW5ndWxhdGlAZ29vZ2xlLmNvbS8NCj4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl90eHJ4LmMgfCA0ICsrKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdHhyeC5jDQo+IGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3R4cnguYw0KPiBpbmRleCA4ODVkZjYy
OTRhZDk0Li43MzgzZDgyNDFlYWQ1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pZHBmL2lkcGZfdHhyeC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2lkcGYvaWRwZl90eHJ4LmMNCj4gQEAgLTM3NDUsOCArMzc0NSwxMCBAQCBzdGF0aWMgaW50
IGlkcGZfcnhfdXBkYXRlX2J1ZnFfZGVzYyhzdHJ1Y3QNCj4gaWRwZl9idWZfcXVldWUgKmJ1ZnEs
IHUzMiBidWZfaWQsDQo+ICAJZnEudHJ1ZXNpemUgPSBidWZxLT5oZHJfdHJ1ZXNpemU7DQo+IA0K
PiAgCWFkZHIgPSBsaWJldGhfcnhfYWxsb2MoJmZxLCBidWZfaWQpOw0KPiAtCWlmIChhZGRyID09
IERNQV9NQVBQSU5HX0VSUk9SKQ0KPiArCWlmIChhZGRyID09IERNQV9NQVBQSU5HX0VSUk9SKSB7
DQo+ICsJCWlkcGZfcnhfcGFnZV9yZWwoJmJ1ZnEtPmJ1ZltidWZfaWRdKTsNCj4gIAkJcmV0dXJu
IC1FTk9NRU07DQo+ICsJfQ0KPiANCj4gIAlidWZfZGVzYy0+aGRyX2FkZHIgPSBjcHVfdG9fbGU2
NChhZGRyKTsNCj4gDQo+IC0tDQo+IDIuNTYuMC40NTUuZzZjNWE1MDNiMzgtZ29vZw0KDQpSZXZp
ZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5j
b20+DQo=
