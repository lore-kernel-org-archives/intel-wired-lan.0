Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC8606A339
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Mamqvqk6;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E+y6Ulr0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C418E40870;
	Thu,  5 Nov 2026 13:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7_5VePreB0X3; Thu,  5 Nov 2026 13:20:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60A9840847
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793884846;
	b=YohOs36UlbVRHiej1EnL0JjGfxbTO4PTlJs0sUY52tErilXd6J0fe/mE7jolrFQXQYK8
	 eTZflSAf3hudOH0ffta4QtM1bOcvuvb7oXaa35i3R8lFLgamqHaUlLCg6ed7gB1YCbSlx
	 X52wXxtATp76qVcjv/y8v6Z7YrJ0gqZYhrkgcfvkyizlOLdAedkiYGBR3xpWbUBnUrOnI
	 zlZv4ko2AFI8BhHj1oHxRfdHLi7I4fAKFdsUOmAO7L91RozV9xrYqfhezpa4pXYsHOcFM
	 yjeb4cocROXQUOqYksytrfeG2zgQmhTIWY8ByNIjNQ6d62s0Q5bXkJhEbepXQJAnuXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793884846;
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
	bh=1x85ET5mc1i2HLEFBf9uOg3USJS0vxv6/D5h2dTdn0Y=;
	b=NxuLGf7OP9HC9/myuMY2DEcbn7iVv08lQGbmarj9QnQEWt1/ALKR8Xg1aSZFTMvXwObZ
	 Oi5oyxECZstTg85NoeCDFFAInr48U3Mf5h7xXVBTYkFVpDsLHYWRDJFR5pien7HiCRDow
	 gSS7imLhqM2C9nFHpyFTVEjmHMYveIBOV8RrD/FXRNAdudV4OvZoN1wU5HGjRoFJZrJfP
	 bH8Ey/ibUDXAVpE1kkl1ECKnS4NnClkhWGz0sjIoNXaF0RNHT6GJH75acYKunI04j/Bk+
	 kTwx/xawOVP56ATkrDTzmFPztTZxeWZYLmicjJtNED7kBaUCL/eNb4IZQt6CsLlnxEw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793884846;
	bh=1x85ET5mc1i2HLEFBf9uOg3USJS0vxv6/D5h2dTdn0Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mamqvqk6Av38OecrBFt/cVA3OTYgmYLJgofhkAHu9YYX2LxOMcZ5QALqc+vC3CvU4
	 K+I0nhnl9OkrbhYHUfA+Ta2GilA7pZfdEofsKStti98TCyng4B2Snubs0Z9bvZGaNc
	 ouPPreikKZoS/eLMHRf3my5h6Kt7EXDe1Il+l0TA/K+bhT4tfXCBHxu46wx9UUKZUx
	 fsFxP8aDU7leGSmwbSArOoWNHt5AvaHs4nCq0Qj2eFkDS+lb/40CuA0gERuT7oS0g/
	 3apZkvbBJDcj882uUnAKG0eJElevevelHRm2yDgL7yxXBS54IcSQBDXB8ziG8sCr+a
	 hvoG+kdEeqIfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60A9840847;
	Thu,  5 Nov 2026 13:20:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 71EF234D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 13:20:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57699607D5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 13:20:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xugzcjO-_aVG for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 13:20:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D5B5B606CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=E+y6Ulr0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D5B5B606CB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 13:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793884844; x=1825420844;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1x85ET5mc1i2HLEFBf9uOg3USJS0vxv6/D5h2dTdn0Y=;
 b=E+y6Ulr0JnvqAsM2cT9AHCgId0MS89rr7xNmzuejcwI0+QQqYYZLcw5g
 mI0pWPDTQAdYqcuz7MPRmRELdtalGgtovqVCgSEXaTDnWi7UPMd1BsBn5
 vwiabYpnqo+uevasDnfCJCVn+/OMkJsOUEYV6Fa7nPr9Lub5q7GIQP98I
 d1MoUk+Wqswi7wifdQcFHCWLtZ8eleObRGMB40BHGF+mAXkHFCZA+I51O
 M9UA1tZkKHPwhuLOvPRIuY6LFH4xOwskn7/gaGvnDr4FpwlhNvDG/SC8M
 mLJfHtgR5ZECkO1V02yoUcbPpFUQyTRbiPQNyFrFsBkKRgGU7cTj6Iiev Q==;
X-CSE-ConnectionGUID: Yy4+QllRQTugOItTG9yVDA==
X-CSE-MsgGUID: AxLWQ4C2R6WbuVFDFutQSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2557310"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2557310"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 05:20:42 -0800
X-CSE-ConnectionGUID: GE5Gfgw6QnaD+2DZzOBBzA==
X-CSE-MsgGUID: xnmIIDrYTVqKa3iS1fkPeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7417629"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 05:20:41 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 05:20:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 05:20:41 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 05:20:40 -0800
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by SN7PR11MB6947.namprd11.prod.outlook.com (2603:10b6:806:2aa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 13:20:38 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 13:20:37 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Simon Horman
 <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "Machnikowski, Maciej" <maciej.machnikowski@intel.com>, "Neustadter, Marc"
 <marc.neustadter@intel.com>, "Temerkhanov, Sergey"
 <sergey.temerkhanov@intel.com>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start with
 PTP lock and incval
Thread-Topic: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start
 with PTP lock and incval
Thread-Index: AQHdTT3/mw0oX4rl5kuPy79D8beTq7bhGAuAgCg2T4CAFmfWAA==
Date: Thu, 5 Nov 2026 13:20:37 +0000
Message-ID: <IA1PR11MB6219BE8C90BA9A3BC9E2A9F192772@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
 <20260925222824.270640-2-grzegorz.nitka@intel.com>
 <20260926170543.GA13925@horms.kernel.org>
 <a71ec0bd-bbce-4801-b79e-8b7d648aba6c@intel.com>
In-Reply-To: <a71ec0bd-bbce-4801-b79e-8b7d648aba6c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|SN7PR11MB6947:EE_
x-ms-office365-filtering-correlation-id: 01708580-dd05-4f99-5723-08df3b3f94ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|38070700021|56012099006|11063799006|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261102123227099003|4143699003|261021123027099003|261009223027099003|261021121427099003;
x-microsoft-antispam-message-info: rzMCbH94WmNdcwtknawPocMJEsWQ74I5hWH9vI+8dMSNEKhfGeQ0e5tr5AZPf8uYOD3aqhpMXCIAFsmWVGv0QWI6oSIibRsmcOG7Nt8X0BwZbrAXavalGCgUl7gO6IVHSO02ta/q2VmFwSFrSF4G1hqfh0XaXi/SI1h8E9MGSKmoDgTk0xPDTuyID8HPInL+nKX7FbRf+1sZfLEPfusmK+cH0iB/yUKJM0kcAll2O6EACVVVYAQFB9ZlRm2BWRQz+WGC8VUtwNa5QmZ925H3jNJtiJMQN+C0cdys46Z0nZvkKP23uvDtvU8hJHcBwuLmIHw7J1ZoSvpSUH/KFyCubH3IF9x/ggv6DZ66T6iH9e8OFk91kXvJbpnb0nhgkWKyYP4h4ywfNao4oS8viThWSgIPNSlmzgLGfPr1LTLy+DwTsHTpn6TUjWi/OtK2CCWq7dVFcVfEHkQ0d+ShLBT4+KHIf2SZqz+gM40+9Q32ZTnMPf+lp5zNNLDqDRIOjRY7rm+lTc1K0zFoQH5sCnIi+Nh87Tu2avVETUEmlYAV8U1vE6uNXYgI1gfk6ZDw/jaGpwRFFTlpnlrOmnmCpoFBzTHad7+5yXwyH47/NHhZLaL8lKC0K+QUqIyM6cakzaYQSPYKoDHEJZCooJ/7JuH3Oq7cn/YSlmBQG1Z+le95wWwtFgz8aKchnuaVfLysOfRJkE5+ftvGHdbWh0lKfpHkixWSBiBQaFyWAYw1oJNDFRw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6219.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261102123227099003)(4143699003)(261021123027099003)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVBRdzdCb1h4eUxiditobVo2djVsTXhEMXZ2VkZwM09UeHJIOUVFREtLY05y?=
 =?utf-8?B?RDlwVlJPZkNSRHJrUFEvUklWMGlocW42K05Dcm0wSTJpWmU3UWdLOUFDdVFt?=
 =?utf-8?B?eG9UZHV3T05jUTdQbHdkWFhYNVNHRXlqMGRvM1NHUWszRU81cUdwamthZGVo?=
 =?utf-8?B?OWVKdkkzSVNMWU5XOTN2NXRLY2Jqa3B5ajlJbVJjUitqenVCUkwzMFhmL210?=
 =?utf-8?B?YUJBVTlxL2U5YUxKVUw5RlR6T3I3aHd4RVpTeUdtam1BVy9ELzdGMnR5MC9k?=
 =?utf-8?B?RXJaVjJOdy84QlkxM2xUTWxEWU9jTXUyZVQybVZYV2dBRlVYd3FTV0FJTGps?=
 =?utf-8?B?THRKb2pVTVM2Z3hYUWpwRGxkc1Y5Vmk1L0dDM1JJNGJ6Y09ET2lNSi9hVmtP?=
 =?utf-8?B?Y09wWGZORkdEdjZ5M0Y3R21jYTBwUWc4R0pRQUM1ME5MT3lYQWIwWXVLSXEx?=
 =?utf-8?B?M1pIV2FBS1VIWXdsVlRVTGQ0azl3YzhYQ0FKOXI1NW5KU0VwZnBDZUI2RGp5?=
 =?utf-8?B?aG1KL1dpZkhYa05wSUM0TkhITWJYSlA0cWdYZlBBVjN1YzdZNDNGSmIxQmpF?=
 =?utf-8?B?ZzMvMithdUcwNEw1emtlbk1WYkVOVEpMaVFIWkZsdnFRWlhnZXlZbmQxZUJY?=
 =?utf-8?B?Rjk4bk4xazRQM1lTcmhxNHJpUFZIMVlBRFA4YXl2MUxsMERwWVBzdU5FZmp5?=
 =?utf-8?B?aStEOEI0S1V3eG9iZlFMOWYvbmFkc3c4UWRmV1pWQmZkWElMd1gvNVR1OXdC?=
 =?utf-8?B?RlhHdHpxUzVHRm9vMGlFSllOaVFldnhiejdOa3pmMFFyWUFrVlJQQ09ZRmlz?=
 =?utf-8?B?ZWJuKzlRR1g1bURVMGxjdUFHTnRXblhtMFFzQVNnZjRVUVZjbzA0WnA5L1I4?=
 =?utf-8?B?N0RnU1dVRmJxZGd4N0xEQzROU29teThHTXYxZHp5L3RQYnU0NElYVFhoS2Nn?=
 =?utf-8?B?QXNlaUNjTmw0ZVNzN0tzR3NPYmRKMmpSU080WHBaTzE5VzU4Y2dGUEJpdnQ3?=
 =?utf-8?B?eG1KM0tJcDVHcjdkYTVZNTZXRVNGWEtKa3I3K1dSdERqT1F0ejk5UkxvVHRW?=
 =?utf-8?B?UGZwT0kwc2NiTEgvSC9XV3dnTk42KzhpZHlFOEVXeXErUlMvOFIwTUtXTXov?=
 =?utf-8?B?a0tzY3Y2blBYNFptdDJLcG40ZktidlYzVXppUXc4QWUyYkVGdjZBQzF5azFS?=
 =?utf-8?B?eW82U0FSTWUxMDdQb0UrbCtYTk5Wc3Z4ZXFZVzh4YTFVckNBSTR6dDc5V3BM?=
 =?utf-8?B?MlhBV2N4aGk1d1hGazMrSDJvQ2N0N2o5WVFmZWFlbEU4ejdSK2MrWkVmZDYy?=
 =?utf-8?B?bWlNeUlpbVlINEFMaElObmNNRk5DUHBYanpjdWJic1IwRk5kV0NvckIwcGNE?=
 =?utf-8?B?aC9ndmVwdWRuZ1VYTkJuTUVNZ0hzU2JMQktMbHFydUJmL2JIN3FaTDdoVjFL?=
 =?utf-8?B?cERqZjJLZ2RuMWNKR2VGWC9nTHRDMFNPUTdEM2w4YmNxdEp3cFRuR0VoMk51?=
 =?utf-8?B?cXRaTDB4WHJmSHc4Z09qb1JKRHFsNmF2UnQwQk9nT3BPcTJvNnBzdC9XeEJs?=
 =?utf-8?B?Y0V5TVc4cEJKbXZFYVFoUkJtbUQ0N1YxWS9VdnVPa1ZEekM2OGNtdGNpZGtJ?=
 =?utf-8?B?SzEvUjhIYVRJdkFsTmZEeG8vY3BJd01qemVoNUpzKzdTZjI1enVnRE0yUmVF?=
 =?utf-8?B?NzJRV005ZzIxOXlUUkZmejFENlZJMTZ6eGtrVEZZU0pPalRPSDd5SFM2OGpt?=
 =?utf-8?B?MzlGK1pvcTVlSVdaOGpKUUZoK2p0T1BkQ203TlpoK3VJNnhYb2VENGVhcWY3?=
 =?utf-8?B?K00yOVpYYm9lT1E3VmZKenVYOVdHcE9BY2Fnc2NJbHBjVTBVcDZSbHJLZzlk?=
 =?utf-8?B?MkdwYjlPV1dmYVoyU0cwZlJ3SC84L0hQekpodklTSUxxNnd5S2hWZWI2NHdw?=
 =?utf-8?B?UHZUTUEvUEI4U3NFSGhpR2xoc3RsdkJpbHVBbjMvQkVuZnNUTXJJU0d6R1Vv?=
 =?utf-8?B?NVJpQmRDZmV4MFh2aEV1anF5dm1yNlh0azVsbkE3Y1Qvckg2QkFwNG9lOTdP?=
 =?utf-8?B?T0lVRTlQVXFDaGtWMENrbnNXSmJabWE5bW1CMDE4eWlmeStBMzhVWXQrVFcv?=
 =?utf-8?B?cktWbDZnMmxWWTVnWTNsNjBrMXh0aGo0VldjbGJzLzFaN05lbEp0cndPRUlo?=
 =?utf-8?B?b2JiYTBGOE9LM0pUR1hnYW1tRXluN3FnREZuN2NVdkwwd0h5QlRHdGozSlZI?=
 =?utf-8?B?emtucFI0TUI3VjRyNG1TUE15RzhmNFNxUGllZTlQelZzSXEvVEJ0Z2RTMExR?=
 =?utf-8?B?aDZYMmEyNzllUUIwMU5ZMEIyRURKK3FSWGVDYjM3bkNUSEdNeEIrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Kt4InSrKv8ckhN5BK+pksrbc7A0E+3/N9kQgpBZjXAvrff7JDPXVn06QTjFIymZvli+240Kt6xXeg7C9AgSgYcQJxBvg1mlluYlDrStqxuWbpRNB75ot1eGHfxr6Ri1n7iPTaNrGkZIFZ9bJxoJ2etqsy0E+3cTyZ5jVvjNdzFe7qZ82+zt8qpAwjPb0VmJlZq3WIF0jFRzpGQ9h34PXLchT9pgaUmYGv/Ne/ZoEMNv6TMhGbD3W3OC8fQ6KCmcNRe2I2zCJCS72ykzyvKtYLfaBEc3nplZCDXkXaoQVVzsKgDPlKs5udveMMcL3YzwMKJJBXP/lV6IsbXxq1oPxng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01708580-dd05-4f99-5723-08df3b3f94ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 13:20:37.2635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dL0D5hBwGOnuovswRxlMJ4GsulSCZ9kbmWo5kXhAAy4vFBPC+kzGKmmQhL4HkXu7mZL+kIYQixC77N/Q30J5+lreiTD4wSpawBmUdN3oMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6947
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2VsbGVyLCBKYWNvYiBF
IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDIy
LCAyMDI2IDk6MTAgQU0NCj4gVG86IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47IE5p
dGthLCBHcnplZ29yeg0KPiA8Z3J6ZWdvcnoubml0a2FAaW50ZWwuY29tPg0KPiBDYzogaW50ZWwt
d2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyByaWNoYXJkY29jaHJhbkBnbWFpbC5jb207DQo+
IGFuZHJldytuZXRkZXZAbHVubi5jaDsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xh
dy5raXRzemVsQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1
eWVuQGludGVsLmNvbT47IEt1YmFsZXdza2ksIEFya2FkaXVzeg0KPiA8YXJrYWRpdXN6Lmt1YmFs
ZXdza2lAaW50ZWwuY29tPjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xl
LmNvbTsgTWFjaG5pa293c2tpLCBNYWNpZWoNCj4gPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwu
Y29tPjsgTmV1c3RhZHRlciwgTWFyYw0KPiA8bWFyYy5uZXVzdGFkdGVyQGludGVsLmNvbT47IFRl
bWVya2hhbm92LCBTZXJnZXkNCj4gPHNlcmdleS50ZW1lcmtoYW5vdkBpbnRlbC5jb20+OyBPbGVj
aCwgTWlsZW5hIDxtaWxlbmEub2xlY2hAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IGl3bC1uZXQgMS8yXSBpY2U6IHB0cDogc2VyaWFsaXplIEU4MjUgUEhZIHRpbWVyIHN0YXJ0IHdp
dGgNCj4gUFRQIGxvY2sgYW5kIGluY3ZhbA0KPiANCj4gT24gOS8yNi8yMDI2IDEwOjA1IEFNLCBT
aW1vbiBIb3JtYW4gd3JvdGU6DQo+ID4gT24gU2F0LCBTZXAgMjYsIDIwMjYgYXQgMTI6Mjg6MjNB
TSArMDIwMCwgR3J6ZWdvcnogTml0a2Egd3JvdGU6DQo+ID4+IEZyb206IE1hY2llayBNYWNobmlr
b3dza2kgPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiA+Pg0KPiA+PiBpY2Vfc3Rh
cnRfcGh5X3RpbWVyX2V0aDU2ZygpIHByb2dyYW1tZWQgdGhlIFBIWSBpbmNyZW1lbnQgdmFsdWUg
YW5kDQo+ID4+IHBlcmZvcm1lZCB0aGUgUEhZLXRvLVBIQyBwaGFzZSBzeW5jaHJvbml6YXRpb24g
aW4gdHdvIHNlcGFyYXRlIFBUUA0KPiA+PiBzZW1hcGhvcmUgY3JpdGljYWwgc2VjdGlvbnMsIGFu
ZCB0b3VjaGVkIHRoZSBzaGFyZWQgc291cmNlIGNvbW1hbmQNCj4gPj4gcmVnaXN0ZXIgKEdMVFNZ
Tl9DTUQgdmlhIGljZV9wdHBfc3JjX2NtZCgpKSBhbmQgcmVhZCB0aGUgc291cmNlIGluY3ZhbA0K
PiA+PiBiZWZvcmUgYWNxdWlyaW5nIHRoZSBzZW1hcGhvcmUgYXQgYWxsLg0KPiA+Pg0KPiA+PiBC
ZWNhdXNlIEdMVFNZTl9DTUQgaXMgYSBzaW5nbGUgZ2xvYmFsIHJlZ2lzdGVyIGxhdGNoZWQgZm9y
IHRoZSBzb3VyY2UNCj4gPj4gdGltZXIgYW5kIGFsbCBQSFkgcG9ydHMgYnkgR0xUU1lOX0NNRF9T
WU5DLCBhIGNvbmN1cnJlbnQgYWRqdGltZQ0KPiAoc21hbGwNCj4gPj4gb2Zmc2V0LCA8PSBTMzJf
TUFYKSBvciBhZGpmaW5lIGNvdWxkIGNsb2JiZXIgdGhlIHNvdXJjZSBjb21tYW5kDQo+IGJldHdl
ZW4NCj4gPj4gdGhlIGluY3ZhbC1pbml0IGFuZCB0aGUgcGhhc2Utc3luYyBzdGVwcy4gSW4gdGhl
IHdvcnN0IGNhc2UgdGhlIHNvdXJjZQ0KPiA+PiB0aW1lciBjb21tYW5kIHdyaXR0ZW4gYnkgaWNl
X3B0cF9hZGpfY2xvY2soKSAoSUNFX1BUUF9BREpfVElNRSkgd2FzDQo+ID4+IG92ZXJ3cml0dGVu
IGJ5IHRoZSB1bmxvY2tlZCBJQ0VfUFRQX05PUCBmcm9tDQo+IGljZV9zdGFydF9waHlfdGltZXJf
ZXRoNTZnKCksDQo+ID4+IHNvIHRoZSBhZGp1c3RtZW50IHdhcyBhcHBsaWVkIHRvIHRoZSBQSFkg
cG9ydHMgYnV0IG5vdCB0byB0aGUgUEhDLiBUaGlzDQo+ID4+IGxlZnQgdGhlIEU4MjUgUEhZIGNs
b2NrIHBlcm1hbmVudGx5IG9mZnNldCBmcm9tIHRoZSBQSEMsIHNob3dpbmcgdXAgYXMNCj4gYW4N
Cj4gPj4gaW50ZXJtaXR0ZW50IGNsb2NrIGRyaWZ0Lg0KPiA+Pg0KPiA+PiBIb2xkIHRoZSBQVFAg
c2VtYXBob3JlIGFjcm9zcyB0aGUgZW50aXJlIHN0YXJ0IHNlcXVlbmNlOiBhY3F1aXJlIGl0DQo+
ID4+IGJlZm9yZSB0aGUgZmlyc3Qgc2hhcmVkLXJlZ2lzdGVyIGFjY2VzcyAoaWNlX3B0cF9zcmNf
Y21kKCkpLCBrZWVwIGl0IGhlbGQNCj4gPj4gdGhyb3VnaCB0aGUgaW5jdmFsIHJlYWQsIFBIWSBp
bmN2YWwgaW5pdCwgYW5kIHRoZSBwaGFzZSBzeW5jaHJvbml6YXRpb24sDQo+ID4+IHRoZW4gcmVs
ZWFzZSBpdCBvbmNlLiBTaW5jZSB0aGUgaGFyZHdhcmUgc2VtYXBob3JlIGlzIG5vdCByZWN1cnNp
dmUsIHNwbGl0DQo+ID4+IHRoZSBwaGFzZS1zeW5jIGhlbHBlciBpbnRvIGljZV9zeW5jX3BoeV90
aW1lcl9ldGg1NmdfdW5sb2NrZWQoKSwgd2hpY2gNCj4gPj4gYXNzdW1lcyB0aGUgY2FsbGVyIGFs
cmVhZHkgaG9sZHMgdGhlIGxvY2ssIGFuZCBjYWxsIGl0IGRpcmVjdGx5IGZyb20NCj4gPj4gaWNl
X3N0YXJ0X3BoeV90aW1lcl9ldGg1NmcoKS4gVGhlIGxvY2tpbmcgd3JhcHBlciBpcyByZW1vdmVk
IGFzIGl0IG5vDQo+ID4+IGxvbmdlciBoYXMgYW55IGNhbGxlcnMuDQo+ID4+DQo+ID4+IEZpeGVz
OiA3ODFmZjhmMmQ1NzUgKCJpY2U6IHB0cDogc2VyaWFsaXplIEU4MjUgUEhZIHRpbWVyIHN0YXJ0
IHdpdGggUFRQDQo+IGxvY2siKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBNYWNpZWsgTWFjaG5pa293
c2tpIDxtYWNpZWoubWFjaG5pa293c2tpQGludGVsLmNvbT4NCj4gPj4gQ28tZGV2ZWxvcGVkLWJ5
OiBHcnplZ29yeiBOaXRrYSA8Z3J6ZWdvcnoubml0a2FAaW50ZWwuY29tPg0KPiA+PiBTaWduZWQt
b2ZmLWJ5OiBHcnplZ29yeiBOaXRrYSA8Z3J6ZWdvcnoubml0a2FAaW50ZWwuY29tPg0KPiA+PiBT
dWdnZXN0ZWQtYnk6IE1hcmMgTmV1c3RhZHRlciA8bWFyYy5uZXVzdGFkdGVyQGludGVsLmNvbT4N
Cj4gPj4gUmV2aWV3ZWQtYnk6IFNlcmdleSBUZW1lcmtoYW5vdiA8c2VyZ2V5LnRlbWVya2hhbm92
QGludGVsLmNvbT4NCj4gPj4gUmV2aWV3ZWQtYnk6IE1pbGVuYSBPbGVjaCA8bWlsZW5hLm9sZWNo
QGludGVsLmNvbT4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtl
cm5lbC5vcmc+DQo+ID4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pY2UvaWNlX3B0cF9ody5jIHwgNDggKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4+ICAxIGZp
bGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5j
DQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcuYw0KPiA+PiBp
bmRleCAyMGJkMTgxMzY1MGYuLmQzZTRhZWI3ZTQ5NiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcuYw0KPiA+PiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jDQo+ID4+IEBAIC0yMDQ1LDcgKzIw
NDUsNyBAQCBzdGF0aWMgaW50DQo+IGljZV9yZWFkX3BoeV9hbmRfcGhjX3RpbWVfZXRoNTZnKHN0
cnVjdCBpY2VfaHcgKmh3LCB1OCBwb3J0LA0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiAgLyoqDQo+ID4+
IC0gKiBpY2Vfc3luY19waHlfdGltZXJfZXRoNTZnIC0gU3luY2hyb25pemUgdGhlIFBIWSB0aW1l
ciB3aXRoIFBIQw0KPiB0aW1lcg0KPiA+PiArICogaWNlX3N5bmNfcGh5X3RpbWVyX2V0aDU2Z191
bmxvY2tlZCAtIFN5bmNocm9uaXplIHRoZSBQSFkgdGltZXINCj4gd2l0aCBQSEMgdGltZXINCj4g
Pg0KPiA+IG5pdDogSSdtIG5vdCBlbnRpcmVseSBzdXJlIHJlbmFtaW5nIHRoZSBmdW5jdGlvbiBp
cyB3YXJyYW50ZWQuDQo+ID4gICAgICBCdXQgaXQncyB5b3VyIGNhbGwuDQo+ID4NCj4gDQo+IEkg
YWdyZWUsIHJlbmFtaW5nIHRoaXMgaXMgdW5uZWNlc3NhcnksIGFuZCBJIHRoaW5rIHNsaWdodGx5
IGNvbmZ1c2luZyBhcw0KPiB1c3VhbGx5ICJ1bmxvY2tlZCIgc2hvdWxkIG1lYW4gInRoaXMgd2ls
bCB0YWtlIHRoZSBsb2NrIiB3aGlsZSAiX2xvY2tlZCINCj4gbWVhbnMgInRoZSBjYWxsZXIgaXMg
YWxyZWFkeSBsb2NrZWQuDQo+IA0KT0sgYW5kIGFncmVlLiBMZXQncyBrZWVwIHRoZSBvcmlnaW5h
bCBmdW5jdGlvbiBuYW1lLg0KVGhhbmtzIQ0KDQo+ID4+ICAgKiBAaHc6IHBvaW50ZXIgdG8gdGhl
IEhXIHN0cnVjdA0KPiA+PiAgICogQHBvcnQ6IHRoZSBQSFkgcG9ydCB0byBzeW5jaHJvbml6ZQ0K
PiA+PiAgICoNCj4gPg0KPiA+IC4uLg0KDQo=
