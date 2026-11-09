Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE561606A31C
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=lvWK90Rn;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GC050Qot
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8CF9607F0;
	Mon,  9 Nov 2026 17:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vl-2YPJazkKK; Mon,  9 Nov 2026 17:23:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2659D607FC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245016;
	b=RJJxtEofevYh8qHdoM5pwN+vjyG0Ed6OvLGlOkD7LImJCI7WMeJQHkE0taM18yZmNzD3
	 LhokXOeAkMJyP+sK9H1bsg1mE219n4s8gXoAM5HERXM3yCchxDfxIkWz1aM4DVx3o9TJG
	 bhxVlpqkLz1ZvCyQnlNKIy9VjXPt4KZZP/CeKv4exK8nOQu69tbG1bD/AcwNEfw4gkkvB
	 4nXaMEKwMK5wUft5VLXGG6sV4mft2pA0jru41SW2w9ZSl1CexCFSOEKQvUUIkxZq6x7SZ
	 5JigRlPbHgGmmQfaNFyPkrt65qrTl7mM5PNmQGw1jRR4wns6sn0vnizGYWX50bIq6dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245016;
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
	bh=fEB4D0biMwx5I/TAzz7/qn9aoSv8oDQxALqqk0I1AZI=;
	b=e5Mra63p+11zRcJm0j6B5zYyuDCDzT5M/MgouoouqguVEPJNhSVDRLIcPhXGVVNzNN7l
	 KqNbZ0aNMsmNQ3mHIUlt7QwHKqttq9cLhilV5YLrHG6mkN3IHcQ3sTIhYQR7fMtJ8YHZd
	 DLnObDC8sXsaeFLm0ECQeTv1ithl3/gpjjhGrWxthIFwfKEUT1mZ8depo26/BFq1hjRSj
	 s6kqFZwnhRDHVPQTCuSzhD6p4dqnkDrgQzQQITG1bZwD04GvB/pNawBFfhEvKp6Wrohxd
	 YaT7a31JqckOLN5ksYnPfeAvxmLEu/makaMxoU3kwzLZ0t5hE7m3p9TStDK36R2lRMA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GC050Qot;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794245016;
	bh=fEB4D0biMwx5I/TAzz7/qn9aoSv8oDQxALqqk0I1AZI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lvWK90Rn4MHj1UplDd0qxwO33lQLrvbBXFQUTMV6l3X/TZNV2I1L49D+TFWS6rD2H
	 I3gzczkiYcWLAFVmIVlRvwHOPJ0KA9KLHm7sOKB/lf9nkvgKpj9XN1cJ5D8+HRNmbQ
	 3X2P+0O1jOWpoerYzkr+2AHUV+HHEM0CqKRJmQe4porKSlkErQZ0t2ikqQ6ytl/7Qp
	 acSSYbRfDzTHjq85fdV+P5EOsHiVk5wcfzgg/pWdKv6BaC7uJFAyTLUCmk2y3cfbRY
	 tk9soQM57wiGN/7RN4kmU0iuRk4rVeNkdEiYhqTzjWYgFXgy1AWbT2YDsK8CQ0XZ4Z
	 PBHzs3Z+Xx50Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2659D607FC;
	Mon,  9 Nov 2026 17:23:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F6E828C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 17:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CA6D607FC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 17:23:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F5Ymy-TU1SLv for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 17:23:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B585607F0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GC050Qot
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B585607F0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 17:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794245015; x=1825781015;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fEB4D0biMwx5I/TAzz7/qn9aoSv8oDQxALqqk0I1AZI=;
 b=GC050Qots5mDl3VAtxrwrsTtnJVClp4uXBO3OdiU9qaGeXo1ThN/pxIF
 DVXSX9FaPV6/Q9QgxX3AAU4lmxvuNHSAb0beFmxtDEZGb7IHGBJPX3xXU
 LevzfOdaoQU/YqfCE/Z4QaglwlwNTm1PTHiXG70H5WgavjDU/R2o6OPdw
 Yol8L9SOreZQY9ovwwpECE+2rApceoo40JC6k8RPJ9G4yAqowDsG5PbTU
 eooHSaVsHgtOpHyw1hBb61y+4+zr/SICMHqVcWCVsZNsf2wDzfmPsSzMw
 upH+gNE09aWBq/ZWGbcLPiezJnO9Qtjkpw4EDurwYPQQo9Ud+TD3fIoPA w==;
X-CSE-ConnectionGUID: IfDd5beORlGFGoEHjVDpgg==
X-CSE-MsgGUID: Gm/J6VruRHiVpR52RMpl3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3077320"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3077320"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 09:23:34 -0800
X-CSE-ConnectionGUID: cyNvO68/QVqpcCB76izacA==
X-CSE-MsgGUID: YRJ5DaXETkG7tjhneUJjtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7947892"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 09:23:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 09:23:32 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 09:23:32 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 09:23:32 -0800
Received: from IA3PR11MB824491.namprd11.prod.outlook.com
 (2603:10b6:208:626::16) by PH7PR11MB5888.namprd11.prod.outlook.com
 (2603:10b6:510:137::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 17:23:29 +0000
Received: from IA3PR11MB824491.namprd11.prod.outlook.com
 ([fe80::c2b7:5964:96e1:8ffd]) by IA3PR11MB824491.namprd11.prod.outlook.com
 ([fe80::c2b7:5964:96e1:8ffd%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 17:23:28 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Naman Gulati <namangulati@google.com>, "Tantilov, Emil S"
 <emil.s.tantilov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Olech, Milena" <milena.olech@intel.com>, "Ilichev, Konstantin"
 <konstantin.ilichev@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
 "decot@google.com" <decot@google.com>, "Chittim, Madhu"
 <madhu.chittim@intel.com>
Subject: RE: [PATCH iwl-net 2/2] idpf: release PTP before freeing vports on
 the init task error path
Thread-Topic: [PATCH iwl-net 2/2] idpf: release PTP before freeing vports on
 the init task error path
Thread-Index: AQHdWDdF7gpugX5w7EOF9nB8mqslGbb9w60AgChp39A=
Date: Mon, 9 Nov 2026 17:23:28 +0000
Message-ID: <IA3PR11MB824491526D7A44D896992628C49B732@IA3PR11MB824491.namprd11.prod.outlook.com>
References: <20261009212537.3996-1-emil.s.tantilov@intel.com>
 <20261009212537.3996-3-emil.s.tantilov@intel.com>
 <CAMP57yWp8O0gXQLcXhtuLwEV5sYs3rJoGWepzO5tr103k_da8g@mail.gmail.com>
In-Reply-To: <CAMP57yWp8O0gXQLcXhtuLwEV5sYs3rJoGWepzO5tr103k_da8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB824491:EE_|PH7PR11MB5888:EE_
x-ms-office365-filtering-correlation-id: 735c58d8-443c-4776-f260-08df3e862ba8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|261009223327099003|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261022105027099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|22082099003|18002099003;
x-microsoft-antispam-message-info: d/SniUapaLMM+BNugk+yuMH07Kdy4ZHSF9uV9U7mlZrAWjozMlcRHj1SEfSy8qfPKYukZGpjAYYaLhLYV1Oq4PhsMyi4Psos2F7UHQe4v8/odAPhSuOjzzITP3DRNCMemw87/316EZ+lQ/ETNJYKK6oJQI2XyeH/hL8/8CDHAuGYH0oeYAIIY93ywH+XTjGKKpQmiJ7GotpkfQjv7ujUgY7a9FZ3wYdvZvDbrccZinG72e1xsc4hKq/voWS2ALJhQ6zWHfK0fib0br9QK1medoc4ED5/EzAapc/Dh3TPcVFMawTvnAmbD6pW4h75AtgmGwve7GVgvOg1WuOiCEfycDYlKMtcfz3Z7j5PhlTptyvuA9dakwLhqymDN6J0lOfkQAoDd3EOWPqPgvFythzmBnxrJ3v7rj3w5t0DKBkoLKEWtTa2bQZFDku9ykUG2HVL8/EN+FiQ2vpJrwA9O8+cOq9ff/Dv4XaC0B0c4QZRScfuT+ZSVqs5+7w2VhBE9dSBfjmKim8QgWKFnPvaDUPshR7FdWdDtv2PRuWeX2Cay7Mqy/Xp/wiRTnsdrJIAtAxKg88q6w2k16c98/3osAR2O8/XdkNuD/a/ykECclrEePbCm47P3n7DfLjg7yrDcV5/FFWNPgYuhWoFagOGEn0E8U53LznUqNN5b7yqWIXCSxN0z4pG+3NSdnwXQZjbjIeYBWGs6lXfGDJ/vDPUvol+23pbMZSplmnWnlUr0GrkOB0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB824491.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(261009223327099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGZmQnBsS2txdndZdW0xWnZWeFFOcVdwQXQ3ejRCeFpKc0IvRjN3Y1hxYzVi?=
 =?utf-8?B?K3A3Z3R5OXFYQkRwZk1BWFdJamY0YSsydUxGV2p6Q3dWellaMmdmc3JEM1cr?=
 =?utf-8?B?MUhKeStmZ3U1aU54VWNKeDYrOVlBS3BKYU1DNGxMOHNpaW9jeGJWb3FRcU0z?=
 =?utf-8?B?WExxcVpuclBxaW1PZEFXMWplQlJYYzlsQVVEUDdzZnBvTk1zRFA2VEVzZ2dE?=
 =?utf-8?B?YVBlSTlaY1lHM3I5dGN4WWFMZENKTzZReEtKaVc4K2N0OWlLbmxWNDUxbDNs?=
 =?utf-8?B?V2JhbUJ1UzQ5NlRCRGF5clFoUXltWkZwa2haWlZmTkx4bDVUMUJXYTV3b1Rq?=
 =?utf-8?B?R2pWKzhkS0VjMytnUk56T3NHT25JOWVUaGxkUWFmc21sTzR4SFlvZGw4M0sv?=
 =?utf-8?B?bGtEYU5JNFg0VVFKS3RBREkvQnZCRkpMMjl4MVVMcm5udHR3NklHU1FIRU5m?=
 =?utf-8?B?RjFSc1J6WndYdi9IbldzT296WVgzOXBmVUx2NHM1M0JmbkJ5YitMNWF1MXdy?=
 =?utf-8?B?TGhtUDBBcUZwVWVzZGpKVGE5NkNYWXREbmVycWduMmVXZUxGVzd2WUdSNktX?=
 =?utf-8?B?c20rWnppd0piams4bFpKS0JVcUQ4Q2ZUN3hYd01GeVZ5SERINHN4eEpnbmVz?=
 =?utf-8?B?eUY1Wk1DZEN0UUVmSGRBS3o2Mm00OTZwanlEM0ZpZEZCUFhydGpwY3I0TXRR?=
 =?utf-8?B?MGducGVIUHRwaXNqY0t4ZzlVT1IxTk4rcUdPQ1ZmT3RQRzF5WmNzK3g1N1Zz?=
 =?utf-8?B?bjVGaEM2a1E4TlVETDFqMWlKQmRDRTlsT3lvWDlpQ0dOU245Mkh1Zk40ZjZ4?=
 =?utf-8?B?bk84MUI0YjhFdS9oSEI0MDZtS3pLYlRjcDk0dFBWdVg4eVJXZmFBaXBjWlFj?=
 =?utf-8?B?U3NGSUF4S21hbHE3SER6SzZkWkVSSUw4a0Z4Vmd2Z3UzV2o1eUJ2OXRUdEs0?=
 =?utf-8?B?Z3VERFE5ZGZ6UjNsL0drLzVkcFg1cmo0ckNOZzBSMnpMbUk0c3liL01BTXE4?=
 =?utf-8?B?N0FsQk9tZ2RZTFhrSDRsMnhrQVN2RDVZWUpsb0hkdXUyb3dWRTZ1RmRwSHpT?=
 =?utf-8?B?S09Fb2NJS3RsdDdrU3YzZDRWQzRHR1Z3bzFMamJ6SXk0Q0U4Q0QzWkNNZWJX?=
 =?utf-8?B?dVF3VUJFRHlwTmpKMWthNG1sYldndGtibHZyQkd4YUNjSm9TVWdvMHVza0xS?=
 =?utf-8?B?MUwzczFiMnhOeEVoTGlBTUU4a21mYXFYZVJzb1FwOEdzRFpuZU5DTnF4NEVL?=
 =?utf-8?B?bmwzV3A5dTd5TzR3RWttak5weUYxUVVSaU9kVEFKM1RrcHk1di9UakU2QzRK?=
 =?utf-8?B?UWRhWURML21jRUV1dENIdWM5YUFmZ2dscjNNVExHVjI1TSs4UzAvQllHYkJW?=
 =?utf-8?B?TEFpRERJWWdMU25HU3pWWGE1WlRnZHdnUXhJNDBZZDRneEpHY3dZalhWV0JB?=
 =?utf-8?B?UlZOOUk3akVCOEIxQ3dTOHdCQnRiQnIxdkZTeHEzcmNIakRuWlhkaUMza1Zv?=
 =?utf-8?B?SUtMYk5TVTRLbU5uQkFYV3dXY0VPQ2xXWjM0NVlkMEVPOFNhYjRacmJqV2Nl?=
 =?utf-8?B?d1JDYVlWb2dPWGUreCs4aHBlVFFEWVgvTW9ObVJubHVoL0d2YXQ0M0w1dXhQ?=
 =?utf-8?B?Y0JyVzF6YVJtYjBHYXRDakprWUNwSWZMbWpZS3hDTnZ2K3dBUEV2QjRtTmJk?=
 =?utf-8?B?VXhxYStLVmxzVXdXM28zNVp3dEdpNVk5VFJhVXE3LzkySDFXVUxnVnFuaDll?=
 =?utf-8?B?cDZWSG5mWEdrR2ZDRm9mZXAyeFNOUkRrTjhQNGhzeGFOc1M0UFRPZnUrVFFQ?=
 =?utf-8?B?TERYUWR2Wlh0L1F5enVLNzdoTU9VVTd4dTJVakFPMHNIU1JRQUw0R2hadlFv?=
 =?utf-8?B?Y0JHaGd3NG81ZzVNV0cvNGg5a3JRQ1VHNE9QaWlWbFlxblRFT29DUjhNdnVu?=
 =?utf-8?B?bGtFWWFnZjBVNzJLMlg1ME9OTnRhQzN4S2RrNHRmNTluYmF2eC9XSDJVVWFP?=
 =?utf-8?B?czFKcDI2ZEkzeWxOOGRad3VacUpLUlQ0WGxYOWFvZ2Vld2tEMHVLbHp1NnBV?=
 =?utf-8?B?Z1kzMkU1eUVIK05YbHdrUGthVlFrZkJ1N0dQd1FjYkVIaVpNbzduR1F2dko3?=
 =?utf-8?B?V1VZMzdrWWhuK29wS0NzZjIyckFmcXdmSjFJKzFIeis3N3FZRmpwK3ZkTjhY?=
 =?utf-8?B?UWxnRE4vS0RrWkxkdkdZNUM0dkVOaEszcUp0THRUR29KQ2lPN3BHY0J6WVkx?=
 =?utf-8?B?cXYyV0VhQzcwMzd1T0k0VlY1SFNLVHU1dGxLQTZLZ0x5Ylp2b0ZRMlRYelpS?=
 =?utf-8?Q?yrBN9IOvurVNrV6VwD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KeGRIxPw4i+ZuyYMKzjhYiKjQvFdcEorjj4zL/cYT3Ec2+iPem6/wXeuyM/eMwPLhkUICR425T4BiDJW0rjNGpjyKgnRqjwRw7AQWHc6q2J7I/XpfutjVq+WPlPm/SfTe1aPRx5UmbdOIdpqxz3HvIB/OdCzwNSBRC2CKm6rTeP+l8OA66vhFpoYJogHQWum7A4ZUVaShroqXdBH5Lt0twByoU0/q+qCNWTal2rzrNIUb64FSAUAiWRvwspAziuO8bye+nZq/GqPratu6LlMt4rym0w2nEwCGfD7dpzQtk6tjHKQUFdESbaklyr4157veou4+/8XMHXrYznzAn54CA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB824491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735c58d8-443c-4776-f260-08df3e862ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 17:23:28.8709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QvMMkx4i3ylbUtWuxhrdDPDpT8en3+A8U8GgE/ONRywJPnwkbgDQ7bbOSJGyofg9n0DEonQ8R5LPFDe2hmlHpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5888
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOYW1hbiBHdWxhdGkgPG5hbWFu
Z3VsYXRpQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAxNCwgMjAyNiA1
OjE0IFBNDQo+IFRvOiBUYW50aWxvdiwgRW1pbCBTIDxlbWlsLnMudGFudGlsb3ZAaW50ZWwuY29t
Pg0KPiBDYzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IE9sZWNoLCBNaWxlbmEg
PG1pbGVuYS5vbGVjaEBpbnRlbC5jb20+Ow0KPiBJbGljaGV2LCBLb25zdGFudGluIDxrb25zdGFu
dGluLmlsaWNoZXZAaW50ZWwuY29tPjsgSGF5LCBKb3NodWEgQQ0KPiA8am9zaHVhLmEuaGF5QGlu
dGVsLmNvbT47IGRlY290QGdvb2dsZS5jb207IENoaXR0aW0sIE1hZGh1DQo+IDxtYWRodS5jaGl0
dGltQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBpd2wtbmV0IDIvMl0gaWRwZjog
cmVsZWFzZSBQVFAgYmVmb3JlIGZyZWVpbmcgdnBvcnRzIG9uIHRoZQ0KPiBpbml0IHRhc2sgZXJy
b3IgcGF0aA0KPiANCj4gUmV2aWV3ZWQtYnk6IE5hbWFuIEd1bGF0aSA8bmFtYW5ndWxhdGlAZ29v
Z2xlLmNvbT4NCj4gDQo+IE9uIEZyaSwgT2N0IDksIDIwMjYgYXQgMjo0M+KAr1BNIEVtaWwgVGFu
dGlsb3YgPGVtaWwucy50YW50aWxvdkBpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gUmVs
ZWFzZSBQVFAsIHdoaWNoIGNhbmNlbHMgdGhlIGF1eCB3b3JrZXIsIGJlZm9yZSB0aGUgdW53aW5k
IGZyZWVzIHRoZQ0KPiA+IHZwb3J0cywgbWF0Y2hpbmcgdGhlIGlkcGZfdmNfY29yZV9kZWluaXQo
KSBvcmRlci4gUHJldmlvdXNseSBpdCB3YXMNCj4gPiBwb3NzaWJsZSBmb3IgaWRwZl9wdHBfdXBk
YXRlX2NhY2hlZF9waGN0aW1lKCkgd2hpY2ggcnVucyB2aWEgdGhlIFBUUA0KPiA+IGF1eGlsaWFy
eSB3b3JrZXIgdG8gcmVhZCBhIG5vbi1OVUxMIGJ1dCBhbHJlYWR5IGZyZWVkIHNsb3QsIHBhc3Mg
aXRzDQo+ID4gTlVMTCBjaGVjaywgYW5kIGRlcmVmZXJlbmNlIHRoZSBmcmVlZCB2cG9ydC4gVGhp
cyBjYW4gaGFwcGVuIG9uIGRyaXZlcg0KPiA+IGxvYWQsIHdoZXJlIGFueSB2cG9ydCBwYXN0IHRo
ZSBmaXJzdCBmYWlscyB0byBpbml0aWFsaXplOg0KPiA+DQo+ID4gICBCVUc6IEtBU0FOOiBzbGFi
LXVzZS1hZnRlci1mcmVlIGluDQo+IGlkcGZfcHRwX3VwZGF0ZV9jYWNoZWRfcGhjdGltZSsweDRh
ZC8weDRkMCBbaWRwZl0NCj4gPiAgIFJlYWQgb2Ygc2l6ZSA4IGF0IGFkZHIgZmYxMTAwMjEyOTIx
NTA1MCBieSB0YXNrIHB0cDMvMTAxMjANCj4gPiAgIC4uLg0KPiA+ICAgaWRwZl9wdHBfdXBkYXRl
X2NhY2hlZF9waGN0aW1lKzB4NGFkLzB4NGQwIFtpZHBmXQ0KPiA+ICAgaWRwZl9wdHBfZG9fYXV4
X3dvcmsrMHgzNy8weDUwIFtpZHBmXQ0KPiA+ICAgcHRwX2F1eF9rd29ya2VyKzB4NjQvMHhkMA0K
PiA+ICAga3RocmVhZF93b3JrZXJfZm4rMHgyODkvMHhhMjANCj4gPiAgIC4uLg0KPiA+ICAgQWxs
b2NhdGVkIGJ5IHRhc2sgODgyMCBvbiBjcHUgMzIgYXQgMjExMy43NjEzNzVzOg0KPiA+ICAgaWRw
Zl9pbml0X3Rhc2srMHgzMjEvMHgyMWMwIFtpZHBmXWENCj4gPiAgIHByb2Nlc3Nfb25lX3dvcmsr
MHg5MTcvMHgxOTQwDQo+ID4gICB3b3JrZXJfdGhyZWFkKzB4NWE1LzB4ZmUwDQo+ID4gICAuLi4N
Cj4gPiAgIEZyZWVkIGJ5IHRhc2sgODgyMCBvbiBjcHUgMzIgYXQgMjExMy44MDkwMTRzOg0KPiA+
ICAgaWRwZl92cG9ydF9kZWFsbG9jKzB4OGNmLzB4MTZiMCBbaWRwZl0NCj4gPiAgIGlkcGZfaW5p
dF90YXNrKzB4MjQ1LzB4MjFjMCBbaWRwZl0NCj4gPiAgIHByb2Nlc3Nfb25lX3dvcmsrMHg5MTcv
MHgxOTQwDQo+ID4gICB3b3JrZXJfdGhyZWFkKzB4NWE1LzB4ZmUwDQo+ID4NCj4gPiBUaGUgYXV4
IHdvcmtlciBpcyBhcm1lZCBpbiBpZHBmX3ZjX2NvcmVfaW5pdCgpIGJlZm9yZSBpZHBmX2luaXRf
dGFzaygpDQo+ID4gaXMgcXVldWVkLCBzbyBpdCBpcyBsaXZlIHRocm91Z2hvdXQgYSBmYWlsaW5n
IGluaXQsIGxlYWRpbmcgdG8gdGhlDQo+ID4gc2NlbmFyaW8gYWJvdmUuDQo+ID4NCj4gPiBGaXhl
czogMWE0OWNmODE0ZmUxICgiaWRwZjogYWRkIFR4IHRpbWVzdGFtcCBmbG93cyIpDQo+ID4gUmV2
aWV3ZWQtYnk6IE1hZGh1IENoaXR0aW0gPG1hZGh1LmNoaXR0aW1AaW50ZWwuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEVtaWwgVGFudGlsb3YgPGVtaWwucy50YW50aWxvdkBpbnRlbC5jb20+DQo+
ID4gUmVwb3J0ZWQtYnk6IEtvbnN0YW50aW4gSWxpY2hldiA8a29uc3RhbnRpbi5pbGljaGV2QGlu
dGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9p
ZHBmX2xpYi5jIHwgMyArKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lkcGYvaWRwZl9saWIuYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWRwZi9pZHBmX2xpYi5jDQo+ID4gaW5kZXggYTFjNzM5Y2RkNTQwLi45YzU0MWRkNmVkNGQgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX2xpYi5j
DQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX2xpYi5jDQo+
ID4gQEAgLTE3NDcsNiArMTc0Nyw4IEBAIHZvaWQgaWRwZl9pbml0X3Rhc2soc3RydWN0IHdvcmtf
c3RydWN0ICp3b3JrKQ0KPiA+ICAgICAgICAgcmV0dXJuOw0KPiA+DQo+ID4gIHVud2luZF92cG9y
dHM6DQo+ID4gKyAgICAgICBpZHBmX3B0cF9yZWxlYXNlKGFkYXB0ZXIpOw0KPiA+ICsNCj4gPiAg
ICAgICAgIGlmIChkZWZhdWx0X3Zwb3J0KSB7DQo+ID4gICAgICAgICAgICAgICAgIGZvciAoaW5k
ZXggPSAwOyBpbmRleCA8IGFkYXB0ZXItPm1heF92cG9ydHM7IGluZGV4KyspIHsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICBpZiAoYWRhcHRlci0+dnBvcnRzW2luZGV4XSkgQEAgLTE3NjAs
NyArMTc2Miw2DQo+ID4gQEAgdm9pZCBpZHBmX2luaXRfdGFzayhzdHJ1Y3Qgd29ya19zdHJ1Y3Qg
KndvcmspDQo+ID4gICAgICAgICAgICAgICAgIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRh
cHRlci0+c2Vydl90YXNrKTsNCj4gPiAgICAgICAgICAgICAgICAgY2FuY2VsX2RlbGF5ZWRfd29y
a19zeW5jKCZhZGFwdGVyLT5tYnhfdGFzayk7DQo+ID4gICAgICAgICB9DQo+ID4gLSAgICAgICBp
ZHBmX3B0cF9yZWxlYXNlKGFkYXB0ZXIpOw0KPiA+DQo+ID4gICAgICAgICBjbGVhcl9iaXQoSURQ
Rl9IUl9SRVNFVF9JTl9QUk9HLCBhZGFwdGVyLT5mbGFncyk7ICB9DQo+ID4gLS0NCj4gPiAyLjM3
LjMNCj4gPg0KDQpUZXN0ZWQtYnk6IFNhbXVlbCBTYWxpbiA8U2FtdWVsLnNhbGluQGludGVsLmNv
bT4NCg==
