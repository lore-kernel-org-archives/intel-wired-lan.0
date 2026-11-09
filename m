Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAAC606A333
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=IM7LeHxt;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KMRtCMD3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F492605E3;
	Mon,  9 Nov 2026 10:59:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W0-5d3Z3EpR3; Mon,  9 Nov 2026 10:59:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6C427606C6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794221995;
	b=YoKHleW7Qv0Elqa21NZL/OIBfvAzxEMq7h3CFu0alJ0OB4/P/G2JtwzIYpHZgFR1YXFB
	 tU7MY/fzE61IXmTBw+NA41nyABaETvRjz825OyvCpvE407Xp13e8Tan0yRRweT0EcYKl3
	 b728XYmDSkX5bfkXOCTEdHfdmfVBeaOZA922YlqnRRaa/0lPNPab6JjO0qgu9d6N1eLgN
	 vTA33PktXzKG72Wlllmf/htx87Xc0rhRld8b6GQfQBBaci0elxEE07ZCxVGaF2zub/Eak
	 n7YspRUBgAtxvLmmY8iGinPwZXJ+pdSbRL7EB4w5tNk2ywoioJRaGk1wPx6alapN3Iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794221995;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=nPmJXgggE5T4LfyvPxpjyiisDcl+ymcn/TYzyNT/dVc=;
	b=iWUdhDmOnsiUy/hEjALqqNfLGhcr2HE4LTu4zZro+ybpmnLrZuNH0R0SNlbhUh+qt/FC
	 eJUxeiR9BrE/N1QPR2yqX/aYYBcZh1J/A1/rNq17y/TyLJuOokUcy6u/zHwaq1dgoXKsV
	 ex3hNISXxeFuUp06Sb51HnrRfJurKStDnLMCAUyWGgFYi/ZF2QuoTFV6Xbv63NWhE+dsu
	 6xw3iqqQ/ZADPDhXm9LXrktymcuy3NB7Jfar12zNMP7s6SEYFWZvruWQ6K7gGWPqRVGWV
	 TJkbwajAos4FnWEw3y/sNc4WN6ArDzCDa5ueQW5QyD4+ys2CXvUw8VgNKov1w1kPClA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794221995;
	bh=nPmJXgggE5T4LfyvPxpjyiisDcl+ymcn/TYzyNT/dVc=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IM7LeHxtrrdjn8Lt9UT/jUwwvX+dZoBlHai/6wYtZsWs8LKo/TynciekwDi0u7KUy
	 uSwPWUjwAMn9KllZa3cZgE81LJJiaUI/HSu4JKY201iRrgl8NdM7pk/PeIVla1CVdM
	 H+JY4yplywe7QagPBP1BK6xVXSz2Kgn0kAZB53bNYOdHm0LDFXALij6lFqQLKUd+cl
	 csNrIzuWPZyxeVje4k8BdCPSWb77cjuw4Y8zjAhxAYM5LGSLZWhbgUyk2+UTqYHvXw
	 ZPQmVv0qoX3HGWk9F7Cl0z8NaCZj8Is+/Sy+orMmxh0GY8Rw/U+w5OFWSo6S5jJJn0
	 yPqkmp6+JQ3qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C427606C6;
	Mon,  9 Nov 2026 10:59:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E5702AC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 10:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8EF9E40661
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 10:59:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EAUeqje57IpA for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 10:59:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B44B405B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KMRtCMD3
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B44B405B3
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794221992; x=1825757992;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=nPmJXgggE5T4LfyvPxpjyiisDcl+ymcn/TYzyNT/dVc=;
 b=KMRtCMD3ZCF8HHRoXtwVX9nRSu86IQGKv1MTh22CxIhOUOS4j88bjQnI
 IlqDKL+BWEBfnxwU5QoGD6j2MJ/mUOH8pLrkS9/Xn7RAs5D6SyQd6dhXP
 WTXknW3sWSDkgGsQXsHAqxiWCcGsVdwTeT25vAhWcbWHoxbiagcxfNrbO
 gx5JvXW7RB76xTdBgoOMTm/qFmw6BooDz8cYbbzZfV7UNZRP+z6cr2Uc9
 oHSAIDKsX64zvlep3CNDspueoofURJSrKz8CK26PRaCohWYApS5NlHYub
 Yw6yHCMkXeZ3wfdk6EKrCWTMQeO5GZlZUEBA4D9lkN4oHC7662YOs8vAx w==;
X-CSE-ConnectionGUID: xr2lr0/iT3ibfCbEH1lZ7w==
X-CSE-MsgGUID: fuUVGGMFQMWQCAHZjT/csw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2935787"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2935787"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 02:59:51 -0800
X-CSE-ConnectionGUID: 40b9i33qSLapsQwbpc3u+g==
X-CSE-MsgGUID: 5/dyn1BuRMquSqzdwxfaVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8166313"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 02:59:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 02:59:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 02:59:50 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 02:59:50 -0800
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by LV0PR11MB9839.namprd11.prod.outlook.com (2603:10b6:408:384::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 10:59:48 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 10:59:48 +0000
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH iwl-next 1/2] idpf: add direct access to discipline the
 main timer
Thread-Topic: [PATCH iwl-next 1/2] idpf: add direct access to discipline the
 main timer
Thread-Index: AQHdaru4w5ROS2uPck6KKilUZcg+IbcapRYAgAr4N9A=
Date: Mon, 9 Nov 2026 10:59:48 +0000
Message-ID: <PH0PR11MB49045CEE642A9AE32FB96C4994732@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20261102110717.77800-1-przemyslaw.korba@intel.com>
 <20261102110717.77800-2-przemyslaw.korba@intel.com>
 <sashiko-outbox-193331@kernel.org>
In-Reply-To: <sashiko-outbox-193331@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|LV0PR11MB9839:EE_
x-ms-office365-filtering-correlation-id: c768a440-4a19-4d11-0b20-08df3e50927e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|6133799003|10067099003|3023799007|38070700021|4143699003|5023799004|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021121427099003|56012099006|261026140227099003|261009223027099003;
x-microsoft-antispam-message-info: Hijag431EV3EdmMcoqypu6siT80tCgStOswb6Om08EkDM+7EDon5lvfh3UWHsHrgezlN5Leojpaa23sxOrHS9gA7LnuzjYOvRZ1TNFPIVH8ToXFtNa7uLUQtPVXdSl8wQQ6WbTaoH/ECKspLOROlhTonceNLGvWtkz4tDasIVRqlKKJ4rRVS1Js9TcqNyPBqyCpDGXN3VRqSCBe4KEYdpXBIDIjwqt3vMQPufSPXTWVloVm2aGAPdNE/lQq8JrH0hHWEgbFc9KVhCCRthsL5EqyjrmSouR03c/DYUsWPRuY+G9H4vp+806NIi5WHPpPmtFesrYviySH2cVU80lXemSrZ79HN2+EwOFoDduaTmWkRWbeAyH0piJjK0o89b6PmY3rOJVE9zXXb6c2gns1lxwv2kFgzO+ZR0awAA+usdcoxUPjFILmL8T6DNpaNqd9BNqneKASV+qslyLNm5vW1+FzdTQde5wWUWVlYtjdK7ffOlt0OYQgimQQEZNG0qwUIHXzNqiJcMua1oUofunPGpM5c1HS43AoSoRLjkZ/5QCGIZ982cel1STQ6OS+MgXBby4aoj5S28aFoUfU7+01IOno7Et4zzzr5D32Rvh7IYLJRHKQBOwb1Uaw7EOu2Q5ICDh3mlps97JVdf13lpiZebs7VqmZfzqn7iAAMLp5ZsVw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4904.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(38070700021)(4143699003)(5023799004)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003)(56012099006)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3YvNElDaTYwdUFJV25PLzlMbmI4Ui8xRWgzbHdjcmJ3Nkx1V3d2VXB3SWFj?=
 =?utf-8?B?UDZHVGZVVTV5WnMrdlh6Q2w1YzVLQi9uZDlaSTY5QzNjVTJpejFubHRZNGFs?=
 =?utf-8?B?S200a00rTkgwNUZweHFTN1kyam05TkxmU25RUDFsYjdnZmk2TFBJK016eUVs?=
 =?utf-8?B?RGh0dlJFSERqa3FxRTJNVGZWUDBMWGZuU2pRWFcwdHArUStoZVJFMEU1VnJC?=
 =?utf-8?B?RkNsSGkxSURKa1BDd3BrTStLM0txM0VQcW5qMkU3aDZiUVFmSzBTV2JjcGU0?=
 =?utf-8?B?aUVUTnlUZjZ5VklCYmZuNnRkeXlkQjVlTzM1eXI4V1BiTDl1Ykg2NmhZVWlY?=
 =?utf-8?B?bmlzTTBXc0MrZnNQT1VDQlAyTjljNUozb21FbWpQQzJ5OGh3b2pKRlFDL1ZL?=
 =?utf-8?B?aVZvTkhXcEl5L1JZcytOR3hTKzZZSkYwMk9LalM1ZjJjYVVZeEhzQzdaL1JY?=
 =?utf-8?B?azZtY2pxWFFIR2FtTmx1MzBTV2VieThKbnJZMGlpQ0dTOUhvemR0ZEh3SnZx?=
 =?utf-8?B?ZDFDdktMKy9FRjVHYkFRL2UzekNvSDIxTmw5ODUwMGF6cWY4UWZPVHdQVkNY?=
 =?utf-8?B?c0lueWtzWkFGclBOSC9zWC9SQWxCb0hIT0YxaVRDa1BpNWZDL2NSbk8vUndB?=
 =?utf-8?B?MmtIc2xIUDk2TEJDQXk1UmV1S2pTYzJtRHN5d244K1k1OXp2aW1xejIrY2Yv?=
 =?utf-8?B?L3JMVGpWMGZWQXBQTHZFbG1iMUFmNXRCZ3hVWmdFRzY1MWdFSWFHVndrS3hO?=
 =?utf-8?B?N0U5cnNGNEI4Y1ZqQzNSblVFTWZSb2FjM0w3YjgyZENwYlJNQXUzR1k3c09E?=
 =?utf-8?B?eHhVd3VUUFQ0Q0RFVklMUnptMEdGeVhId1k2MXJQbmNDN1djL3ZQNU5RblFs?=
 =?utf-8?B?dGxxZm5FWS85blRxNWRqcWlyb2JlR3UyNTRjdXZMeEQ1TmN0Y3NGRHkvNDhx?=
 =?utf-8?B?YXk5Q2UrYlMwWi9qTkFPbHlwL3RqRmZ4MzIyZ3VudGQvUmloR1hJVXkwSEVu?=
 =?utf-8?B?ekk2ZkVGWlNVck13bUVHcVFzRGx3cFNOZ2VDN21iK2ZldGJnYnI2RWp5dTE2?=
 =?utf-8?B?VWZjeitocjJUOWp2UmZPOUQ4TUo1ZzQvT0pNTGVSenlJc2JNa1VuWXhQcWtp?=
 =?utf-8?B?WHdQaFdIZ1VCUko3MGNmY0kyeDhMVmZoUEhvVUtSNTJFSTNhb2lYanQ5bkgy?=
 =?utf-8?B?c3BmS2RPa2xwaW1Idjl2NDV5ZXFFc0JVbWF2U3kxR1lYVzFqRmhIMDl6UGxE?=
 =?utf-8?B?Q0g2NllaOVora3JyZnp1VWsxME91dk04NENtaXZ2bE9yNVBoTWhQR1p0dmpw?=
 =?utf-8?B?b3JoVDkrY1ZoV0QrMHgvbWhNMjBXVElZcjVqMW9ma0JxK2NNZW1DZmwrdnNh?=
 =?utf-8?B?NWM0MVNqWWpTZE5wSFkybnkyc1NoTlFLZ3dQOVlZTzd3VkM0dmVuRm5uelBo?=
 =?utf-8?B?MzU5SE05WkVYTEhDbUx3NjJCVXJ3cTErRHJ5MWtYYndndCtHSjQveWR5NWVK?=
 =?utf-8?B?KzB1cWdoNEI4c01NZEREUEszbHd6ZGFFYWRYMzM0cS81OFczQTNPWkpENUZq?=
 =?utf-8?B?cXk5NWF0WDZhdmFVZXNRczdvcElNeE9WS1R3TUZ3elQ1amI1UDMvMHkzUDFy?=
 =?utf-8?B?WGhaVzdqb0FmUVdIV0pLL3BNVmRMb3R3Vmd5dm9Fd1B2RStTVmNNaHgwK0RO?=
 =?utf-8?B?TVpGaWZ4Q3gvWmZzY2xic2RHbEttUU9PREZ0bEQ3Zmt6d1ZVSldMaFJJZFFq?=
 =?utf-8?B?VnNVWXFBdDIxSHZhM1ptbGxSWjRhOE5leTFTeDlRbW1ldHVPMENlWHVSbS91?=
 =?utf-8?B?REh1ZThkUGl2SVIyM0ducFVsU0pwWGdna1d3bmlENDdGL29XNDlkOG4ySzd3?=
 =?utf-8?B?Tm1YVXowczIrWWxXU293bW5iQy8zWjRTSXE5NzlQUzFwdGRxTGl3Tlc0VVhW?=
 =?utf-8?B?S3hIWnQ1WlZYUkRRM0swZktGMEoyUVFKZ1VvRzJ3a0xScGlHYjBCT1VvV0N1?=
 =?utf-8?B?bG9kbDZQdGd3dlIvZFV5YUJDY0I0bDNzdHJJc1YzSnVweGlQdThSNVlQV3hY?=
 =?utf-8?B?KzZBT0p4VnpSRENiUFFYSmVvb0hPU09kZGtQeWpQNlVGUWRPY3NFdEpmS2J3?=
 =?utf-8?B?NS91Skh3RjZYNjJ1VkhnVG1wWUNBUU1qN2txNUhVeWFSNXlzTVdkc2tGdGM5?=
 =?utf-8?B?V21YaDVULzJhOHRoL3F1QTBhb1Z4SCsyMkVTRGhCTFdXSUI4MXdhQXJrWFpG?=
 =?utf-8?B?S2hkMVhha3Q5OUFlZE4wNU1XSnJSSG0zR3N3RU9SbFh0MzVaSUxCWjNSQW5F?=
 =?utf-8?B?ZmJuQnhlZG1yeDhEbzJ3ZkY3NHpqU1NKcnFVQ1J2WW5PL0FlMlJCZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dv7M/ormvuqaeliLxC2e0H+2M8LXegxJJTIQew5OuqUOp3sSI1dnC5w332wlwOI5UOKMa6i/ywS3NtodrXlcPED2NCu172gMXsunUxzHOs05G7v/CmKD88lfHYyhyJMr45dQkbztvx+MT9bgLWh0QYNHL3A+jgXBEBQrduH0Ebi9w0TDMSVt8/QPfCQFZJtt/5HiiVp+C+Ypak9Y3RqciO+0Qph7g15M8C2S+4mog/kqH4qQRlLU/Lx5rVflAW2D2SeoQ6dT4SgKKhJGTJ5z7BupTb+bHBm0dPAQPxat/VLC2Rbl0G0RFLTyuLYP93YySKGwH61UeQB9jg1YH7/kmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c768a440-4a19-4d11-0b20-08df3e50927e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 10:59:48.5759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUYGhIhKoN+tUU2x4h5krLq61OurTl1mX2CNogbu1gulUBn3AjSAI/O9zT0qfvpa+bfL0ac/edV1VjLwt4gjT4feRA7QyIZkD7KfU79pSiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9839
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzYXNoaWtvLWJvdEBr
ZXJuZWwub3JnIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE5vdmVt
YmVyIDIsIDIwMjYgMTI6MjggUE0NCj4gVG86IEtvcmJhLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3
LmtvcmJhQGludGVsLmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggaXdsLW5leHQgMS8yXSBpZHBmOiBhZGQgZGlyZWN0IGFjY2VzcyB0
byBkaXNjaXBsaW5lIHRoZSBtYWluIHRpbWVyDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29u
dHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0
byBjb25zaWRlcjoNCj4gLSBbSGlnaF0gaWRwZjogTlVMTCBjbWRfc3luYyBkZXJlZmVyZW5jZSBm
cm9tIG92ZXJ3cml0ZSBpbiBpZHBmX3B0cF9nZXRfY2FwcygpDQo+IC0tDQo+IA0KPiBjb21taXQg
ODljYzMyM2NkOTIxODllMWUzZDA4ZmM4OTk3NTgzNzkzM2Y5M2M5ZA0KPiBBdXRob3I6IFByemVt
eXNsYXcgS29yYmEgPHByemVteXNsYXcua29yYmFAaW50ZWwuY29tPg0KPiANCj4gaWRwZjogYWRk
IGRpcmVjdCBhY2Nlc3MgdG8gZGlzY2lwbGluZSB0aGUgbWFpbiB0aW1lcg0KPiANCj4gVGhpcyBj
b21taXQgYWRkcyBzdXBwb3J0IGZvciBkaXJlY3QgUENJIEJBUiByZWdpc3RlciBhY2Nlc3MgdG8g
c2V0IGFuZCBhZGp1c3QNCj4gdGhlIFBUUCBkZXZpY2UgY2xvY2ssIGFsb25nc2lkZSB2YWxpZGF0
aW5nIG1hcHBlZCByZWdpc3RlciBvZmZzZXRzIGFuZA0KPiByZWNvbmNpbGluZyBkZXBlbmRlbnQg
UFRQIGZlYXR1cmUgYWNjZXNzIG1vZGVzLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3ZpcnRjaG5sX3B0cC5jIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3ZpcnRjaG5sX3B0cC5jDQo+ID4gaW5kZXggMTQyMmIz
MGQwOWEzMS4uNDI3YjE1MjgxYWQwZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pZHBmL2lkcGZfdmlydGNobmxfcHRwLmMNCj4gPiArKysgYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdmlydGNobmxfcHRwLmMNCj4gWyAuLi4gXQ0KPiA+
IEBAIC05MCw2ICsxMTcsMTkgQEAgaW50IGlkcGZfcHRwX2dldF9jYXBzKHN0cnVjdCBpZHBmX2Fk
YXB0ZXIgKmFkYXB0ZXIpDQo+ID4gIAlwdHAtPmRldl9jbGtfcmVncy5jbWRfc3luYyA9DQo+ID4g
IAkJbGliaWVfcGNpX2dldF9tbWlvX2FkZHIobW1pbywgdGVtcF9vZmZzZXQpOw0KPiA+DQo+ID4g
KwkvKiBEaXJlY3QgYWNjZXNzIGlzIG9ubHkgdXNhYmxlIHdoZW4gZXZlcnkgcmVnaXN0ZXIgd2Fz
IG1hcHBlZC4gKi8NCj4gPiArCXZvaWQgX19pb21lbSAqIGNvbnN0IGNsa19yZWdzW10gPSB7DQo+
ID4gKwkJcHRwLT5kZXZfY2xrX3JlZ3MuZGV2X2Nsa19uc19sLA0KPiA+ICsJCXB0cC0+ZGV2X2Ns
a19yZWdzLmRldl9jbGtfbnNfaCwNCj4gPiArCQlwdHAtPmRldl9jbGtfcmVncy5waHlfY2xrX25z
X2wsDQo+ID4gKwkJcHRwLT5kZXZfY2xrX3JlZ3MucGh5X2Nsa19uc19oLA0KPiA+ICsJCXB0cC0+
ZGV2X2Nsa19yZWdzLmNtZF9zeW5jLA0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwlwdHAtPmdldF9k
ZXZfY2xrX3RpbWVfYWNjZXNzID0NCj4gPiArCQlpZHBmX3B0cF9yZWdzX2FjY2VzcyhwdHAsIGNs
a19yZWdzLCBBUlJBWV9TSVpFKGNsa19yZWdzKSwNCj4gPiArCQkJCSAgICAgVklSVENITkwyX0NB
UF9QVFBfR0VUX0RFVklDRV9DTEtfVElNRV9NQik7DQo+ID4gKw0KPiA+ICBjcm9zc190c3RhbXA6
DQo+ID4gIAlhY2Nlc3NfdHlwZSA9IHB0cC0+Z2V0X2Nyb3NzX3RzdGFtcF9hY2Nlc3M7DQo+ID4g
IAlpZiAoYWNjZXNzX3R5cGUgIT0gSURQRl9QVFBfRElSRUNUKQ0KPiA+IEBAIC0xMDcsMTAgKzE0
NywyMyBAQCBpbnQgaWRwZl9wdHBfZ2V0X2NhcHMoc3RydWN0IGlkcGZfYWRhcHRlciAqYWRhcHRl
cikNCj4gPiAgCXB0cC0+ZGV2X2Nsa19yZWdzLmNtZF9zeW5jID0NCj4gPiAgCQlsaWJpZV9wY2lf
Z2V0X21taW9fYWRkcihtbWlvLCB0ZW1wX29mZnNldCk7DQo+ID4NCj4gPiArCS8qIENyb3NzIHRp
bWVzdGFtcGluZyBhbHNvIHNhbXBsZXMgdGhlIGRldmljZSBjbG9jayByZWdpc3RlcnMuICovDQo+
ID4gKwl2b2lkIF9faW9tZW0gKiBjb25zdCBjcm9zc19yZWdzW10gPSB7DQo+ID4gKwkJcHRwLT5k
ZXZfY2xrX3JlZ3MuZGV2X2Nsa19uc19sLA0KPiA+ICsJCXB0cC0+ZGV2X2Nsa19yZWdzLmRldl9j
bGtfbnNfaCwNCj4gPiArCQlwdHAtPmRldl9jbGtfcmVncy5zeXNfdGltZV9uc19sLA0KPiA+ICsJ
CXB0cC0+ZGV2X2Nsa19yZWdzLnN5c190aW1lX25zX2gsDQo+ID4gKwkJcHRwLT5kZXZfY2xrX3Jl
Z3MuY21kX3N5bmMsDQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArCXB0cC0+Z2V0X2Nyb3NzX3RzdGFt
cF9hY2Nlc3MgPQ0KPiA+ICsJCWlkcGZfcHRwX3JlZ3NfYWNjZXNzKHB0cCwgY3Jvc3NfcmVncywg
QVJSQVlfU0laRShjcm9zc19yZWdzKSwNCj4gPiArCQkJCSAgICAgVklSVENITkwyX0NBUF9QVFBf
R0VUX0NST1NTX1RJTUVfTUIpOw0KPiA+ICsNCj4gPiAgZGlzY2lwbGluZV9jbG9jazoNCj4gPiAg
CWFjY2Vzc190eXBlID0gcHRwLT5hZGpfZGV2X2Nsa190aW1lX2FjY2VzczsNCj4gPiAgCWlmIChh
Y2Nlc3NfdHlwZSAhPSBJRFBGX1BUUF9ESVJFQ1QpDQo+ID4gLQkJZ290byBmcmVlX3Jlc3A7DQo+
ID4gKwkJZ290byBjaGVja19mZWF0dXJlc19hY2Nlc3M7DQo+ID4NCj4gPiAgCWNsa19hZGpfb2Zm
c2V0cyA9IHJlY3ZfcHRwX2NhcHNfbXNnLT5jbGtfYWRqX29mZnNldHM7DQo+ID4NCj4gPiBAQCAt
MTQzLDEzICsxOTYsMzUgQEAgaW50IGlkcGZfcHRwX2dldF9jYXBzKHN0cnVjdCBpZHBmX2FkYXB0
ZXIgKmFkYXB0ZXIpDQo+ID4gIAlwdHAtPmRldl9jbGtfcmVncy5waHlfc2hhZGpfaCA9DQo+ID4g
IAkJbGliaWVfcGNpX2dldF9tbWlvX2FkZHIobW1pbywgdGVtcF9vZmZzZXQpOw0KPiA+DQo+ID4g
KwkvKiBCb3RoIHRoZSBtYWluIGFuZCB0aGUgUEhZIHRpbWVyIGFyZSBkaXNjaXBsaW5lZCB0b2dl
dGhlci4gKi8NCj4gPiArCXZvaWQgX19pb21lbSAqIGNvbnN0IGFkal9yZWdzW10gPSB7DQo+ID4g
KwkJcHRwLT5kZXZfY2xrX3JlZ3MuY21kLA0KPiA+ICsJCXB0cC0+ZGV2X2Nsa19yZWdzLmluY3Zh
bF9sLA0KPiA+ICsJCXB0cC0+ZGV2X2Nsa19yZWdzLmluY3ZhbF9oLA0KPiA+ICsJCXB0cC0+ZGV2
X2Nsa19yZWdzLnNoYWRqX2wsDQo+ID4gKwkJcHRwLT5kZXZfY2xrX3JlZ3Muc2hhZGpfaCwNCj4g
PiArCQlwdHAtPmRldl9jbGtfcmVncy5waHlfY21kLA0KPiA+ICsJCXB0cC0+ZGV2X2Nsa19yZWdz
LnBoeV9pbmN2YWxfbCwNCj4gPiArCQlwdHAtPmRldl9jbGtfcmVncy5waHlfaW5jdmFsX2gsDQo+
ID4gKwkJcHRwLT5kZXZfY2xrX3JlZ3MucGh5X3NoYWRqX2wsDQo+ID4gKwkJcHRwLT5kZXZfY2xr
X3JlZ3MucGh5X3NoYWRqX2gsDQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArCXB0cC0+YWRqX2Rldl9j
bGtfdGltZV9hY2Nlc3MgPQ0KPiA+ICsJCWlkcGZfcHRwX3JlZ3NfYWNjZXNzKHB0cCwgYWRqX3Jl
Z3MsIEFSUkFZX1NJWkUoYWRqX3JlZ3MpLA0KPiA+ICsJCQkJICAgICBWSVJUQ0hOTDJfQ0FQX1BU
UF9BREpfREVWSUNFX0NMS19NQik7DQo+ID4gKw0KPiA+ICsJLyogUmVjb25jaWxlIGRlcGVuZGVu
Y2llcyBhZnRlciBhZGRyZXNzIHZhbGlkYXRpb24gY2hhbmdlZCBhY2Nlc3MgbW9kZXMuICovDQo+
ID4gK2NoZWNrX2ZlYXR1cmVzX2FjY2VzczoNCj4gPiArCWlkcGZfcHRwX2NoZWNrX2ZlYXR1cmVz
X2FjY2VzcyhhZGFwdGVyKTsNCj4gDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gQ291bGQgdGhpcyBs
ZWF2ZSBwdHAtPmRldl9jbGtfcmVncy5jbWRfc3luYyBhcyBOVUxMIHdoaWxlDQo+IHB0cC0+Z2V0
X2Rldl9jbGtfdGltZV9hY2Nlc3MsIHB0cC0+YWRqX2Rldl9jbGtfdGltZV9hY2Nlc3MsIGFuZA0K
PiBwdHAtPnNldF9kZXZfY2xrX3RpbWVfYWNjZXNzIHJlbWFpbiBzZXQgdG8gSURQRl9QVFBfRElS
RUNUPw0KPiANCj4gSW4gaWRwZl9wdHBfZ2V0X2NhcHMoKSwgd2hlbiBkaXJlY3QgYWNjZXNzIGlz
IG5lZ290aWF0ZWQgZm9yIHJlYWRpbmcgdGhlDQo+IGRldmljZSBjbG9jaywgY3Jvc3MtdGltZXN0
YW1waW5nLCBhbmQgYWRqdXN0aW5nIHRoZSBjbG9jazoNCj4gDQo+IDEuIHB0cC0+ZGV2X2Nsa19y
ZWdzLmNtZF9zeW5jIGlzIG1hcHBlZCBmcm9tIGNsb2NrX29mZnNldHMuY21kX3N5bmNfdHJpZ2dl
cg0KPiAgICBhbmQgdmFsaWRhdGVkIGluIGNsa19yZWdzW10sIGxlYXZpbmcgcHRwLT5nZXRfZGV2
X2Nsa190aW1lX2FjY2VzcyBhcw0KPiAgICBJRFBGX1BUUF9ESVJFQ1QuDQo+IA0KPiAyLiBVbmRl
ciBjcm9zc190c3RhbXAsIHB0cC0+ZGV2X2Nsa19yZWdzLmNtZF9zeW5jIGlzIHVuY29uZGl0aW9u
YWxseQ0KPiAgICBvdmVyd3JpdHRlbiB1c2luZyBjcm9zc190c3RhbXBfb2Zmc2V0cy5jbWRfc3lu
Y190cmlnZ2VyOg0KPiANCj4gCXRlbXBfb2Zmc2V0ID0gbGUzMl90b19jcHUoY3Jvc3NfdHN0YW1w
X29mZnNldHMuY21kX3N5bmNfdHJpZ2dlcik7DQo+IAlwdHAtPmRldl9jbGtfcmVncy5jbWRfc3lu
YyA9DQo+IAkJbGliaWVfcGNpX2dldF9tbWlvX2FkZHIobW1pbywgdGVtcF9vZmZzZXQpOw0KPiAN
Cj4gICAgSWYgbGliaWVfcGNpX2dldF9tbWlvX2FkZHIoKSByZXR1cm5zIE5VTEwgZm9yDQo+ICAg
IGNyb3NzX3RzdGFtcF9vZmZzZXRzLmNtZF9zeW5jX3RyaWdnZXIsIHRoZSBwcmV2aW91c2x5IHZh
bGlkYXRlZA0KPiAgICBwdHAtPmRldl9jbGtfcmVncy5jbWRfc3luYyBwb2ludGVyIGlzIGNsb2Ji
ZXJlZCB3aXRoIE5VTEwuDQo+IA0KPiAzLiBpZHBmX3B0cF9yZWdzX2FjY2VzcyhwdHAsIGNyb3Nz
X3JlZ3MsIC4uLikgb25seSBkb3duZ3JhZGVzDQo+ICAgIHB0cC0+Z2V0X2Nyb3NzX3RzdGFtcF9h
Y2Nlc3MsIHdoaWxlIHB0cC0+Z2V0X2Rldl9jbGtfdGltZV9hY2Nlc3Mgc3RheXMNCj4gICAgSURQ
Rl9QVFBfRElSRUNULg0KPiANCj4gNC4gVW5kZXIgZGlzY2lwbGluZV9jbG9jaywgYWRqX3JlZ3Nb
XSBkb2VzIG5vdCBjaGVjaw0KPiAgICBwdHAtPmRldl9jbGtfcmVncy5jbWRfc3luYywgYW5kIGlk
cGZfcHRwX2NoZWNrX2ZlYXR1cmVzX2FjY2VzcygpIHNlZXMNCj4gICAgcHRwLT5nZXRfZGV2X2Ns
a190aW1lX2FjY2VzcyA9PSBJRFBGX1BUUF9ESVJFQ1QgYW5kDQo+ICAgIHB0cC0+YWRqX2Rldl9j
bGtfdGltZV9hY2Nlc3MgPT0gSURQRl9QVFBfRElSRUNULg0KPiANCj4gV2hlbiBpZHBmX3B0cF9p
bml0KCkgb3IgYSBQVFAgY2xvY2sgY2FsbGJhY2sgc3Vic2VxdWVudGx5IGludm9rZXMNCj4gaWRw
Zl9wdHBfYWRqX2Rldl9jbGtfZmluZV9kaXJlY3QoKSwgaWRwZl9wdHBfc2V0X2Rldl9jbGtfdGlt
ZV9kaXJlY3QoKSwNCj4gaWRwZl9wdHBfYWRqX2Rldl9jbGtfdGltZV9kaXJlY3QoKSwgb3IgaWRw
Zl9wdHBfcmVhZF9zcmNfY2xrX3JlZ19kaXJlY3QoKSwNCj4gaWRwZl9wdHBfdG1yX2NtZCgpIGFu
ZCBpZHBmX3B0cF9lbmFibGVfc2h0aW1lKCkgd2lsbCBjYWxsIHdyaXRlbCgpIG9uIGEgTlVMTA0K
PiBwdHAtPmRldl9jbGtfcmVncy5jbWRfc3luYyBwb2ludGVyLg0KPiANCj4gQWxzbywgaWYgY2xr
X3JlZ3NbXSB2YWxpZGF0aW9uIGRvd25ncmFkZXMgcHRwLT5nZXRfZGV2X2Nsa190aW1lX2FjY2Vz
cyBmcm9tDQo+IElEUEZfUFRQX0RJUkVDVCwgc2hvdWxkIGlkcGZfcHRwX2dldF9jYXBzKCkgc2tp
cCBtYXBwaW5nIGNyb3NzX3RzdGFtcCBhbmQNCj4gZGlzY2lwbGluZV9jbG9jayByZWdpc3RlcnMg
aW5zdGVhZCBvZiBtYXBwaW5nIHRoZW0gYmVmb3JlDQo+IGNoZWNrX2ZlYXR1cmVzX2FjY2VzcyBk
b3duZ3JhZGVzIHRob3NlIGRlcGVuZGVudCBmZWF0dXJlcz8NCg0KVmFsaWQsIHdpbGwgc2VuZCB2
MiB3aXRoIGZpeCBzb29uDQoNCj4gDQo+IC0tDQo+IFNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBz
Oi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MTEwMjExMDcxNy43NzgwMC0xLXByemVteXNs
YXcua29yYmFAaW50ZWwuY29tP3BhcnQ9MQ0K
