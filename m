Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8B606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=nT2IxAGj;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nXfzpIEF;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Fam3gh3W
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62DE7405C9;
	Mon, 23 Nov 2026 18:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ewOEkxdsBznX; Mon, 23 Nov 2026 18:34:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B100B4060E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795458887;
	b=klWXfk/o75uiCwfYzM/t6cdiXB8+EuiOo0k8SBjEOc+cZCWkTTP3Y24BskHPj/bMetFh
	 RdvPlZV5t+OzTM28hDogNLANWr64oMUHRJoz1lWx0ABDiZhpytIlqzI7FnwoTNENiKAAp
	 lz+Wy67/y3H5cAySWqCn3492A37rA8FwhuQKscRZDQXdcgfYP0M720i2m+4yfDulT5jkh
	 RlkeU041tFr0uOqdwTbPnyxUbeGS16uHei4PoDQca8oyvGf5kDf40LwGgoeKloV95vtLB
	 i0L0mBoL6AgDQckSRu4IsXAvcby6dqu50YhzeMvFjkaFQD2PAKeeooBqLZ0yhNyk3iA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795458887;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
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
	bh=SsG2OHQpjbX2kihyyY8cKuovqUp7NT3+ZL1FfH9Uz7E=;
	b=Gpc/bdip2y7RmMFYur72yMk3KgvCdH2GwQBfmNuBu3wJgpJkE7Evu9u8W8rSHKNK3brm
	 kfWVEq7Bb0he1O+kbgoZWD9F9e8nLb89keiWQeAkEz/6u/bnuikgIm9OvMQ4sjkG1pq/8
	 ww/FktDS0cvLXNJUVhThXwkFwAdLuVXRedKygvlr6AxXNkm3bxuPj2Kur1cMys8x2XQx0
	 i4JhAcT3kzkbobltRh9LlLFL4yJgMMOziRPFPmF6gnLww9jPH3UbkvGSVUi0Qh4HBb9ws
	 6d8cEh6pE312lv4k5JqrAQzVocbDzPv1INysyTzReiCvQ2Fs0GpyloL2xfM+ohWlq0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795458887;
	bh=SsG2OHQpjbX2kihyyY8cKuovqUp7NT3+ZL1FfH9Uz7E=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nT2IxAGjqlR7gPbTjslEadPCb3AtOBdZcgXrK/lt/vwtypifpjSaW1i022TyuRaCV
	 I0LU/p/gtsmFGT4n4x97LkzrAzZsh254WjrmpqBt6m61jrNbAFbDh6N2D6TIordsEt
	 +WWddRtpCDQlxaMQkayBl8C25pV+kslGcLeqj22RKExPEt03TA1vcD8bVOZgcrxUNQ
	 /pRs+pGllaxAMzxjhZHoNVncqXz6YhbNQYRnmoqzBkNAQGk5pWkMvbb/mquAJ5IWxa
	 CFKTgFd9MKd/4pIwQsdXexbPYt1mI314n574hT2qgQ0DdUvmtAT/v4WHuZwDKgq07O
	 WoLI644e5bB/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B100B4060E;
	Mon, 23 Nov 2026 18:34:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 49141311
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 469E04009B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:34:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zjAfSbgXk-t3 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 18:34:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3758340093
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nXfzpIEF; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=Fam3gh3W
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3758340093
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795458885; x=1826994885;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SsG2OHQpjbX2kihyyY8cKuovqUp7NT3+ZL1FfH9Uz7E=;
 b=nXfzpIEFOOME/8/VVQnmFEE5smKA1iOZfcZUgvJDzRA4w1uza+CIt1cf
 1EZG6OD8R0hRrqskDcQFHm8lvJNVbiUtrXLOe0bvuLzfvjcq4tUFZoUAW
 N4+qYREVRp7+IjErqjfMPj8/5s2zOo9fotnmKyk0Z871gHY6YVRRuHPhq
 pAN38jWqXzY5zraUP+hMgrHi0Wlh34v58GjDeoGI1xbdrVL1AJrHU6wBj
 Y2NSZ2BCyXike5xG4fQxKWQib9wxotZBQ03bTHumGQUxu9zBW2eTK4q+D
 cPOvsdUVH7zF3iV/I1swYCbNGK073qQGQPRetvv4AoeQx1I5mY4aG+lBg g==;
X-CSE-ConnectionGUID: t03MgkWBTUeuuxQzbbN+Nw==
X-CSE-MsgGUID: 7bsHS4FcShSgbdyvqs2CDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4175504"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4175504"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:32:29 -0800
X-CSE-ConnectionGUID: HNQYL31CTl2Eq0WHVKpWOA==
X-CSE-MsgGUID: Y1J+R76NRLO963INRp4xGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11382958"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:32:27 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:32:24 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 10:32:24 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 10:32:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsG2OHQpjbX2kihyyY8cKuovqUp7NT3+ZL1FfH9Uz7E=;
 b=Fam3gh3WuZFHlESnbE6iZqLQYBV7kxgIXi9Q2/EqNDmU9qvk9T5M1rnEWRnq13dDWCm8kA1ydwaNaPoHeQRErlGUk2g1bT3/z783kx7SgqoxmjuQA0Rl9XWikm6oMxcm5epkEd+4rWi2PFFqSorJz7VXOw2rce+dQslrJtMuLpM=
Received: from IA3PR11MB824491.namprd11.prod.outlook.com
 (2603:10b6:208:626::16) by DS0PR11MB7650.namprd11.prod.outlook.com
 (2603:10b6:8:151::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:31:54 +0000
Received: from IA3PR11MB824491.namprd11.prod.outlook.com
 ([fe80::c2b7:5964:96e1:8ffd]) by IA3PR11MB824491.namprd11.prod.outlook.com
 ([fe80::c2b7:5964:96e1:8ffd%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 18:31:54 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>, Tian Xun Ng
 <luckilystar08@gmail.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "decot@google.com" <decot@google.com>,
 "Olech, Milena" <milena.olech@intel.com>, "Hay, Joshua A"
 <joshua.a.hay@intel.com>, "alan.brady@intel.com" <alan.brady@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: RE: [PATCH iwl-net v5 2/3] idpf: ignore link events once removal has
 started
Thread-Topic: [PATCH iwl-net v5 2/3] idpf: ignore link events once removal has
 started
Thread-Index: AQHdWww2WMZqIMVK60+eTp1AB2HVVrb7qViAgECSRFA=
Date: Mon, 23 Nov 2026 18:31:54 +0000
Message-ID: <IA3PR11MB8244918D4E17B31A89D003FC249B452@IA3PR11MB824491.namprd11.prod.outlook.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
 <20261013121224.84482-3-luckilystar08@gmail.com>
 <e798d410-9dce-4206-87f2-5b874bc44ac1@intel.com>
In-Reply-To: <e798d410-9dce-4206-87f2-5b874bc44ac1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB824491:EE_|DS0PR11MB7650:EE_
x-ms-office365-filtering-correlation-id: c6862e17-2049-4838-ea3b-08df49900c6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|38070700021|10067099003|4143699003|11063799006|56012099006|261021121427099003|261022113327099003|261022105027099003|261009223027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261102123227099003|18002099003|22082099003;
x-microsoft-antispam-message-info: mSEdQJIuJeOUPqgRtHvrW+0CsHrDMF7dRCvje6VILgcoOsPfOWqYLkGEDk/O/avKicizsMoxEB2lemS2QzJlnYEFg3AIVKW7ePvkEXwcYCtcFVD6IIz6ZPHv9DzszpHvwgWZxp/+hF6OSA0CYJ4vcv1J4hK1Lk82fahq+2O0vLa0GIha6c4dlliuNRApP58/b1ZEMhFuVNWWmJe0Ni/QT0Zglcqmo4zzsOpe1ArhkyD0mxDYp/81UuekeO9T9EucYkUN/vHxLQDgwva5/KuN05wXNk/J1P1iF5zK66FQdjq88zqzwedQmua/sDPCvbQN4z80IV2FOVXBQ/bGC4Xfllj4OY/HbzNdhbeI+6iWIcRPB7c9bWuJpbXVxlo2NSo9DLyeCpfyq9peWQYJvSMIoBwYly9SB0iv0lw8UWThMVfZ3S5rGqAggJqtwi0lOXAcfk/Exh0o02QFCdgxNsgt5uGMH1D/pJUSQZn6EB3MJBJICVhrFWz7TinbFvPuLU29M66baEIpFx3YX1bZvI5dv+Mes+c6Q47Id+EO1NmkquG5/uA8HxBUb4V6X3Sv0lyDWf64tmWmbpym3re7b5QB2+L8t+WV2mCg965tFG9tjCsn1/yl+CUtwLDSRkm6tTzEbhQqUtyt4WB13kSl3RFBolsrPW7IlJKaXJ2RtNGetRF4PT0GU3poa8O0oDCxOZiOrJ8ctkdc3XnKCgj0RPFksOq/6QOlh5VP+8gsRWkLcR8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB824491.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022113327099003)(261022105027099003)(261009223027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG90bEQyN3NtWFlzYzRMQzROR01meFNhUlYrRUt0ZVlMVUJ2OEh4RFZmU1NJ?=
 =?utf-8?B?bWtCQnRPNFBlWXp3bGhiRDQwTkFUVUxoMkhwVDd6OHBwZ3NHb1ZoZUd6MFVk?=
 =?utf-8?B?bk9FM3lpTnJmVy9HeXJnN05qN0F0bXJvN3ZWTysyclFZQUtVdTNPcmw4K3h6?=
 =?utf-8?B?ZjBKMnpYUzNnWXdFdGxmZkRud2duWGl4T2RDSEg2ODVTaUhzK25MWHV1bnU0?=
 =?utf-8?B?d0xUdFBPNEN2a251cmQ1RVRObmZyL2pFRjgxTEVSVWFyZGVMTmdxYXB3Vzgy?=
 =?utf-8?B?ZXkvc1kzb3pXejN2YXhyTERzZ0ZnbDFaeVhPSDlTMW1WWVpzaUhTNjRNV044?=
 =?utf-8?B?MXRzOE93VytWM3ZpQitFa0padmNoRDFvU1dvc0VDWUhRcmFvc2NyN0p2UVh5?=
 =?utf-8?B?ZENpaEF2elhhVTQxeWdpSDBKSjFaT1RUaFcwNGxialJMTnpGOW50RWJhaFdE?=
 =?utf-8?B?ak9sZ3p5ejlNVCtkaE9QSXI5SmRlZVBIYW1VLzdGTXBzTng4Y3hVSUowRXo4?=
 =?utf-8?B?NFF4cGk4MlQ3dDdCSUhSUStsV0l4NWhQUStHeTlxWUNpQWVySUFBakUrSk1K?=
 =?utf-8?B?RUZ4bFVaQnhialluYnlCaGpJN1dFOWRYTi9TcklxSWdUNjNHbTJKeXhHUFpC?=
 =?utf-8?B?ejZ0U2M5bmQ0bjVGSU5EZEhacytKTjU2THJmTW84VlBQcDdrNVJicVYvL3Na?=
 =?utf-8?B?aERRaVpHT2lRSGZaUnVYSXVZdjBhekRJWEZJWk9IMlc5NmJhN3FoYW5XQXM3?=
 =?utf-8?B?eWcySjdEeXpXaHBHTzlmWmFkajEzbUZaQjVyQ2plQW5OZGpsbWcyNEt0d3Fh?=
 =?utf-8?B?aXBQdmRwcHM0cE9la0ZwZW9PL3pXL1YvUi9GQnpuNjNlSFM3YjNRTjNtWThv?=
 =?utf-8?B?aExqVytuUGh6N0RRdDJHbVFXOVpxYVJiL3l3YnpTVUtqNmZ3cEtYNDN6bkt0?=
 =?utf-8?B?RHVUblFaL1hWL0dQQkY0aHlnVGRzWEtZL1RPR0dNdnk1bUFQNlorbk5QME5S?=
 =?utf-8?B?SW1ERE41d1JQa0Y3RE5RNW9RdDFyV2JXSEswVFc5NEFyL0Z1K05ENnliUHpk?=
 =?utf-8?B?bnRDd0RhcVIzVzRXQlBrQ2dkYlVpMFFqenVQb2dyZTZ3VStNZDNvZklseFBN?=
 =?utf-8?B?Q0lFdGkzQUg1R1l3YldkVC9kSDhHc3VwNjY1Y3RGYTRtVlVkOG9obk8xdVdW?=
 =?utf-8?B?Qjc1WTlCdW5PMkVoWXVYUTk4MkxQY3NxK2M5ajJHdVZPalJyVmQvd1BTMlFK?=
 =?utf-8?B?Y0V2RVlmWjJlR1dhbmtPdXpkdml1UXhKMnMreHlMRlA5RDBjYnhwTzk3aUdJ?=
 =?utf-8?B?d1pKb0hkYUZYNmF3ZWdEWHpUbDFPUzRheVZPSkkvVjNzQklXcHA4dDJrb3ZC?=
 =?utf-8?B?QmN2VmFnWmhsQ0VwbGRxNmlwZjRIRmVJUHR3SEFMT1dlcFZpR3RscGhPZ1lY?=
 =?utf-8?B?UFhhc0NwQWlVbzA0MG5mZjIraUJtN0RCNDlYbFNxbXRuQ0VsMmJXV1NTQ3cy?=
 =?utf-8?B?WnIxQmtJNytBaDRKL1Zyc0RvMGdhYVJwSWxQZG85aWVwYXVwb1YrVkxUK0VK?=
 =?utf-8?B?endVbUlJclBNbXB0T1J0UzhtUzJvckhVdVNBazlSc1NtMk1kcWdKSTZ4NS9z?=
 =?utf-8?B?RVRiWmhFWVM0N1dhR0hIUStOd3B3MUluODd0ejl6MlF3QWxySHkwcmlvaWFC?=
 =?utf-8?B?YWduc1FEQmF6T1NqRTlld21mVTNQNU9EVzZVekdFNW90THpzTXdlNUhwejB5?=
 =?utf-8?B?UXhtViswdUd4Qjg3TFUxRVdvN3U4cDcwc2FQOTJCb1JFNFRncnlYRzg1WU1s?=
 =?utf-8?B?TE1BbXRoQ29kNTU1NkJDUitESHdZSkJham9GQU54Qk15bFBaS1o0MXhDeXNZ?=
 =?utf-8?B?VzlLU2NodlhURXIveS81R3VBYlNMUnhpbVJPdi9HYW9iRTJlVGUwTWx0eVZ2?=
 =?utf-8?B?ZmNxWWFoY3lCbXhESFh1NWliakxic3l5cnYzWmpZVVRhYXFnVG51dEtxKzFF?=
 =?utf-8?B?d2l5TVFQRWlBNCtubDhkQWV5dHRRcmR6d0xsREdwSXQ0MGU3U1kzZjVTUUlq?=
 =?utf-8?B?bzBaWXBvT3gvaVVMOUEyVlAvL0VVaityb1hTZzFtOU5XeEU4bnNYcG5CZ2Fr?=
 =?utf-8?B?blhTSFNlVmJHVENvaVIrTVBiOEV2Y0poSzQ4WkphWUQ3aWQ4Zjh2Qko2RTFv?=
 =?utf-8?B?Y2duVVpUQ1pLc1RKOVdXN2ZjcWEweU01L2tub3ZmWWMzNnNORHBlOHlXU2J3?=
 =?utf-8?B?d3Q3ZUdvLzlXVjFLVlZtY3l5RlJLL3RCalowcnNFVmVTU3VOZ0h0emdhbHRR?=
 =?utf-8?Q?A91K2gYQep7Tf9wUwU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U0RNIrM47qxZ39ThwLuhYzI09HJNkONs4NyImM2mf+Xew2vAEOOn4emKAiMx6AfHZPWswEOQemxnCosfWhjz3pkjJvvijn1AEl6sHAD13J0wiJNijyMewMg7AX4fFyjuZvk6s0lCmaHCNX7IM+CRvfaj/9WoRSoJDYb0P1Sfxe0GSnumLmuupwaE9v4m8NWOnsgdgcikpwf5EHnpBnGrNBO6Ic8J8++3SRklTcUy/tebQj+cZcFZm934GRcLpmPtbEUi+fnLYRft2HUBuDComUOs92dSml8b6+fkijjpSiQaPVS5j3k+Lh6HYAvtOawDdF4c5dmsirb5EhrfPWrFGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB824491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6862e17-2049-4838-ea3b-08df49900c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 18:31:54.2095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1prqBPm/M1RQWZ53DoDhEchH9pT6Bz98kALny9K2bF1JpwGsOPdLG2SXFanJOpy7fCHG1mEw5d483AXf0qyYew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7650
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUYW50aWxvdiwgRW1pbCBTIDxl
bWlsLnMudGFudGlsb3ZAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEzLCAy
MDI2IDk6MjcgQU0NCj4gVG86IFRpYW4gWHVuIE5nIDxsdWNraWx5c3RhcjA4QGdtYWlsLmNvbT47
IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+
OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsg
TG9iYWtpbiwgQWxla3NhbmRlcg0KPiA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT47IExv
a3Rpb25vdiwgQWxla3NhbmRyDQo+IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IGRl
Y290QGdvb2dsZS5jb207IE9sZWNoLCBNaWxlbmENCj4gPG1pbGVuYS5vbGVjaEBpbnRlbC5jb20+
OyBIYXksIEpvc2h1YSBBIDxqb3NodWEuYS5oYXlAaW50ZWwuY29tPjsNCj4gYWxhbi5icmFkeUBp
bnRlbC5jb207IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4g
ZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsg
VGlhbiBYdW4gTmcNCj4gPHRpYW54dW4ubmdAYnl0ZWRhbmNlLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBpd2wtbmV0IHY1IDIvM10gaWRwZjogaWdub3JlIGxpbmsgZXZlbnRzIG9uY2UgcmVt
b3ZhbCBoYXMNCj4gc3RhcnRlZA0KPiANCj4gDQo+IA0KPiBPbiAxMC8xMy8yMDI2IDU6MTIgQU0s
IFRpYW4gWHVuIE5nIHdyb3RlOg0KPiA+IEZyb206IFRpYW4gWHVuIE5nIDx0aWFueHVuLm5nQGJ5
dGVkYW5jZS5jb20+DQo+ID4NCj4gPiBtYnhfdGFzayBrZWVwcyBoYW5kbGluZyBtYWlsYm94IGV2
ZW50cyB3aGlsZSBpZHBmX2RlaW5pdF90YXNrKCkNCj4gPiByZWxlYXNlcyB0aGUgdnBvcnRzOiBp
dCByZXF1ZXVlcyBpdHNlbGYsIG9yIGlzIHF1ZXVlZCBmcm9tIHRoZSBtYWlsYm94DQo+ID4gaW50
ZXJydXB0LCB1bnRpbCBpZHBmX3ZjX2NvcmVfZGVpbml0KCkgY2FuY2VscyBpdCBvbmNlIHRoZSB2
cG9ydHMgYXJlDQo+ID4gZ29uZS4gQSBWSVJUQ0hOTDJfRVZFTlRfTElOS19DSEFOR0UgZXZlbnQg
aGFuZGxlZCBpbiB0aGF0IHdpbmRvdw0KPiBsb29rcw0KPiA+IGl0cyB2cG9ydCB1cCBpbiBhZGFw
dGVyLT52cG9ydHNbXSB3aXRob3V0IGEgbG9jaywgYW5kDQo+ID4gaWRwZl92cG9ydF9kZWFsbG9j
KCkgcmVsZWFzZXMgdGhlIG5ldGRldiBhbmQgZnJlZXMgdGhlIHZwb3J0IGJlZm9yZSBpdA0KPiA+
IGNsZWFycyB0aGF0IHNsb3QsIHNvDQo+ID4gaWRwZl9oYW5kbGVfZXZlbnRfbGluaygpIGNhbiBm
b2xsb3cgYSBOVUxMIG5ldGRldiBwb2ludGVyIG9yIHVzZSB0aGUNCj4gPiBmcmVlZCB2cG9ydC4N
Cj4gPg0KPiA+IE1ha2UgaWRwZl9oYW5kbGVfZXZlbnRfbGluaygpIHJldHVybiBvbmNlIElEUEZf
UkVNT1ZFX0lOX1BST0cgaXMgc2V0Lg0KPiA+IFRoZSBwcmV2aW91cyBwYXRjaCB3YWl0cyBmb3Ig
YSBydW5uaW5nIG1ieF90YXNrIGFmdGVyIHRoZSBiaXQgaXMgc2V0DQo+ID4gYW5kIGJlZm9yZSBh
bnl0aGluZyBpcyByZWxlYXNlZCwgc28gb24gcmVtb3ZlIGEgbGluayBldmVudCBpcyBlaXRoZXIN
Cj4gPiBoYW5kbGVkIGJlZm9yZSB0aGUgdnBvcnRzIGFyZSB0b3JuIGRvd24gb3IgaWdub3JlZC4g
U2h1dGRvd24gaGFzIHRoZQ0KPiA+IHNhbWUgd2luZG93IHRvZGF5OyB0aGUgbGFzdCBwYXRjaCBv
ZiB0aGlzIHNlcmllcyBzZXRzIHRoZSBiaXQgdGhlcmUgYXMNCj4gPiB3ZWxsLiBUaGUgd2luZG93
IGFsc28gcmVtYWlucyBvbiBhIGhhcmQgcmVzZXQsIHdoaWNoIHRlYXJzIHRoZSB2cG9ydHMNCj4g
PiBkb3duIHdpdGhvdXQgc2V0dGluZyB0aGUgYml0OyB0aGF0IHBhdGggaXMgbm90IGNoYW5nZWQg
aGVyZS4NCj4gPg0KPiA+IEZpeGVzOiAwMmNiZmJhMWFkZDUgKCJpZHBmOiBhZGQgZXRodG9vbCBj
YWxsYmFja3MiKQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gQXNzaXN0ZWQt
Ynk6IExMTQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpYW4gWHVuIE5nIDx0aWFueHVuLm5nQGJ5dGVk
YW5jZS5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBm
L2lkcGZfdmlydGNobmwuYyB8IDQgKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2lkcGYvaWRwZl92aXJ0Y2hubC5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
ZHBmL2lkcGZfdmlydGNobmwuYw0KPiA+IGluZGV4IGQwZGI2MDY0Ny4uMmNmZDIxNmFlIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hu
bC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3ZpcnRj
aG5sLmMNCj4gPiBAQCAtNDAsNiArNDAsMTAgQEAgc3RhdGljIHZvaWQgaWRwZl9oYW5kbGVfZXZl
bnRfbGluayhzdHJ1Y3QNCj4gaWRwZl9hZGFwdGVyICphZGFwdGVyLA0KPiA+ICAgCXN0cnVjdCBp
ZHBmX25ldGRldl9wcml2ICpucDsNCj4gPiAgIAlzdHJ1Y3QgaWRwZl92cG9ydCAqdnBvcnQ7DQo+
ID4NCj4gPiArCS8qIFRoZSB2cG9ydHMgYXJlIHJlbGVhc2VkIG9uIHJlbW92ZSBhbmQgc2h1dGRv
d24gKi8NCj4gPiArCWlmICh0ZXN0X2JpdChJRFBGX1JFTU9WRV9JTl9QUk9HLCBhZGFwdGVyLT5m
bGFncykpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4gPiAgIAl2cG9ydCA9IGlkcGZfdmlkX3Rv
X3Zwb3J0KGFkYXB0ZXIsIGxlMzJfdG9fY3B1KHYyZS0+dnBvcnRfaWQpKTsNCj4gPiAgIAlpZiAo
IXZwb3J0KSB7DQo+ID4gICAJCWRldl9lcnJfcmF0ZWxpbWl0ZWQoJmFkYXB0ZXItPnBkZXYtPmRl
diwgIkZhaWxlZCB0byBmaW5kDQo+IHZwb3J0X2lkDQo+ID4gJWQgZm9yIGxpbmsgZXZlbnRcbiIs
DQo+IA0KPiBSZXZpZXdlZC1ieTogRW1pbCBUYW50aWxvdiA8ZW1pbC5zLnRhbnRpbG92QGludGVs
LmNvbT4NCg0KVGVzdGVkLWJ5OiBTYW11ZWwgU2FsaW4gPFNhbXVlbC5zYWxpbkBpbnRlbC5jb20+
DQo=
