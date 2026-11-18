Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F9606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xPFGe6wx;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QStIFCcI;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ayY/tIHE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53A4340792;
	Wed, 18 Nov 2026 18:55:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nb8beCYERUD8; Wed, 18 Nov 2026 18:55:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F95140621
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795028100;
	b=TGPen1R9A0uOWYxuCb0sW1H2T2CBvyfwVUXJodjHxoc6j/Y+SzTRogrkxg71tXTyq33U
	 pgYTEv4xthdBJ9lzbgQTIkhmVf+QshcZa9NWlEngs5eRDV/J03yTo/Y2ULxD0dWEgEGmL
	 2EamW404oR4fGvmrZJ5kD0tBC1ymEWl//VVsFZF1bk33YmprfCpXkEIPAnUI9af5IZ+AE
	 o9t2xgfuIL0Rgk6C+cIBMksRF1nEn+Mz3BrhPB4EG2wqCRjZnP18Ho9YGtfg2xQgmjAtW
	 pSSd64sRnrI5h9hIonEaCg1Qmyd2JteCaLdMvq1fAKITF+AACOvtH75eilcwhQkFcvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795028100;
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
	bh=xpQs8WLrFczt/xSrO+5FamjgeCPKiAnh9bkrZ9HjLvw=;
	b=pXfWfai+0n3UMp0VNqcwqwRfBLZkKXECaj8ZR6ZF4bhUOvQrYR9dxx6bZKz4s8wh/BRY
	 DsMCmLyFTISXN77UF2ipchCE2GoZ/+Ts51bnmfjYwR8NSIOzQUJPl+AIFlQ2vDkZ0P5hX
	 8UvvwdVMbbV3zjpQnM4srzSttfZ5n2zY5n3mv/XFSSYqCCfhwvws2wWQ2nTfi7nJeM0Yj
	 P0o4oTr8ASSEt3HGLAvMQXr4XEyS/2Zx3ldK4kb7/0KhQma6YHCimGHpNT+LON3s25036
	 23x8QG1oEC9EDpa0w5YvBZxvoMlf9CWGttV5fcP5cUssce919iSulgQqL92wfe+CMYw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795028100;
	bh=xpQs8WLrFczt/xSrO+5FamjgeCPKiAnh9bkrZ9HjLvw=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xPFGe6wxKkIxD2nq2x2BaNcnUf9Tyc3CxZWH3/bIckwCg9SxXzhQ9zGiPdslUooxc
	 WxPHeBk0EbvHI6zdtg51FnMQOG+OCKWbFl6DDsXHZfuK55va2pIv03Vm9sgk8pQ/Mg
	 G+6pIjayrta97mnqbNha1TkcaMuVxKoG4RtGKuIAjt6jM+sO28V1ALwAZ5cJVGYbb7
	 ToVe0x0FBRHUjgNk0SLpfCU4LxBotjY4hgfE/ktxbCB3Btyz36AIuP3ZAAZf5VjzFV
	 6HCV3Vtt+YywkTRkKwfW+gNJk7Kr4s2caS8IE9RC78kD3GAXHcM0fCZKyBvjb7418y
	 geYJTTPOI2LqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F95140621;
	Wed, 18 Nov 2026 18:55:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7180649B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 18:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5746240095
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 18:54:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hxLuwL_DXq16 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 18:54:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E60B840200
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QStIFCcI; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=ayY/tIHE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E60B840200
 for <intel-wired-lan@osuosl.org>; Wed, 18 Nov 2026 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795028098; x=1826564098;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=MoZ0UAL656XcJneHT/8LXV7TIdagsLEcwp111LS2SZM=;
 b=QStIFCcIjwuSF1lXWCjT51dzIur8ce3MFbW5SekBvzmwP7SiGtVlc12l
 bkaV3joyi9Ay8kKkjqrGUfj4OeGNlNr8jA50cj8OGoC8tUesvWnNOcqZg
 frTUcRMRw3da6JDb5uFQmOLo3u/r0NSuJ0DNxc9wQEW3/TfINf5EZW0K5
 ydJHNRCulzeKn1GpwaA8bN20OR4KKGCLce8r4YuKL9YZzR+0lAUixJq+t
 6eeNgugyPaD9e72jTAKNQ8jejhYR/rBTE/iwvdUPzYKor/yZQ74VfTH0n
 kH722sUCOONPpMwtdfX0u7qr6/knOfHsiEhD6ltZIgQfJR3Vwhy/nvrhP w==;
X-CSE-ConnectionGUID: C1hVa7nTTQiGN6lJGTTJhg==
X-CSE-MsgGUID: HXIbeTZPTT+mFczTdziDeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3751013"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3751013"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 10:54:57 -0800
X-CSE-ConnectionGUID: 6+PSURMAR2agRmj9wBaYBA==
X-CSE-MsgGUID: HPrRU/OERv25FYMLayY7ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10459890"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 10:54:57 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:54:56 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 10:54:56 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:54:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpQs8WLrFczt/xSrO+5FamjgeCPKiAnh9bkrZ9HjLvw=;
 b=ayY/tIHEvI3KczkqE+HWGCsHznzqm8qJYlcykHbtxbML5rPDzs1RqIE7e3VND4EWJe/7geQHJwJJRpEKJXZyGAOheBPxRdNBNB7CcEIQWl++bgUocyu/liNmEHKw+wsdEog4Nn3E3XUML823gkfIYbAMSUFXk6uu5+kuar9jrJg=
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SN7PR11MB7974.namprd11.prod.outlook.com (2603:10b6:806:2e7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 18:54:51 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:54:51 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
 "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>
Subject: RE: [PATCH RESEND iwl-net v6 1/7] ice: Protect the control PF pointer
 with RCU and a rwsem
Thread-Topic: [PATCH RESEND iwl-net v6 1/7] ice: Protect the control PF
 pointer with RCU and a rwsem
Thread-Index: AQHdWvMYkZBKHrH00U23tBspQqhVGLc0ZoKQ
Date: Wed, 18 Nov 2026 18:54:51 +0000
Message-ID: <LV1PR11MB879019CE34D25E4ADE752692907A2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
 <20261013091235.1423979-2-sergey.temerkhanov@intel.com>
In-Reply-To: <20261013091235.1423979-2-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SN7PR11MB7974:EE_
x-ms-office365-filtering-correlation-id: f18d04ca-042f-4756-0087-08df45a56d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261009223027099003|18002099003|22082099003|11063799006|56012099006|4143699003|261102123227099003|261021123027099003|261021121427099003|10067099003|38070700021;
x-microsoft-antispam-message-info: kZ6SyFPeOyDYwBt2x2Ei58srXo/bko3UStVJMv46uKCMzmzBa5FxL52zxWsKZETabVHldk4lQATYT+rR49y/K8xiiWa2/uhm3fKDKBOvR4iJ+N+MKSMM/TkIrnKg0cjc7ChyHGS50/el8dpDzsQk40yOH28spwNSgXqx+8sm/GUIO4n+PtvjEUATyQqmGh1HatUKS+Y9jzqkFx1OkxwP+HnbgN2E+GAmj1UlkFZqFyn6tuYaA/L0cm+rzmSMWBFtNhjCKD4zYdxkLdBu320xHaRTEVgRGQ0bqFy2bLlHft0Wv+eMOf+weIZwqzOZGjpZ2JWeAd9iX5uSkXUa2tkjebp33Cn1dEhpHyJYZBaVgfLx8ZAIpiwry64Ch917l7NRSwA253xjVOvRFa/+pjcncPBVHMRnUd4p/aNISUhzc6O7dPzYK1k208/+/qUiLzjEbEHNJgyOo87J4JpLI/AQO3Lv+O9CgDjQaaWdyq0Hxz3qhaKYOpPps7FLAtbb2eaT4l17Om68/GTFjiH4XUpj1QxCcXW5RXKEXO/kF+UHvCSXgXWuID2IIoo6MJiXlIZQ6ePTWREdIZ8YTE2utwlhlp1qGu0xjCd/lPHcYvFVYLAWG3ELQQUZ2jkDWHIa25wNEsjtHDI2FqGfUpZHU729DU1ztmT5d5+JSeFBuM8cXEhwl0ukvSwXRSB0PYLect4ktvcVcJ8A/jyHdQXMSck20QJ4Im0rf/O1oAGCbxClOuI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261009223027099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261021123027099003)(261021121427099003)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oW30XxeqfxbAcbxk/4Ud4IZNe/Y0QS19VfI93iqJO5WFmn+K1nxhtauPccP5?=
 =?us-ascii?Q?ZgkHy5ZGY4mbQl/IuCyapqKOEQEzzFCQ6A5uRm6SMqANdJDT6S7lsCl9RCT+?=
 =?us-ascii?Q?6AW6BU3329RO1Oh6DRwo+S9SC/4RQGpd845aPC2tXYSmRIbKg5f68bN7Ry3Q?=
 =?us-ascii?Q?9QsGy2DZW/cXpsmGLmciMF6dNa8Yk/bnseWgoAG/lOB9gN+ExnaXaOIx+oeY?=
 =?us-ascii?Q?TFFTPd1AtH2W65jpJaEa1G9d9398NTVg1bRlyUNDy9J05MDaJSVOIGwHWE33?=
 =?us-ascii?Q?NQTIEbA/7tL1pl0ke4bJ58edfrrrhEyN/tfchPauHakXpUiQX4mwcji1A1bZ?=
 =?us-ascii?Q?LV7wVsCSdherF51miNBpIbrUfTqxAtaJ3S9amg6i7ECiaWdaT2eCdsUV/6Yg?=
 =?us-ascii?Q?jMVId6n0EqixoPDgMoA35VGYl4sRbu9RpAbgTKbZdlD7E/wJMEWBJqFlOKQ0?=
 =?us-ascii?Q?bCxwGPdFP4kMqqBJak2WQpVk3bD2AIxZ2vAA1mdyIg6YUbZnfdawcn9j9ZQk?=
 =?us-ascii?Q?ZQg4tsUC9PguvpPEQQHgbLn2tCjzvTXE4ehHU/8ND4qgfWE5dNSOmGbnQwa6?=
 =?us-ascii?Q?tzQjX7WBy3pJ2BKxpRP316PKaxKrpgeuIhI0/b94pznpXVFLB4jJnn+R8jmo?=
 =?us-ascii?Q?vMkBhNkfkudvuZPkLcTKRNK6oSXzwdCAaNpvu3xXpkPQt7YQruuUqRLFPM3K?=
 =?us-ascii?Q?8pDPKV75lzpwKRx2w/EKYhT3VgLRgjIud6VIok57MaE04VoIli40v30VX2tX?=
 =?us-ascii?Q?ng40c7evubFXwphMi87Z6q+UQrFp02bwy4hdg1id3vDzDppAH2B2ri1Jytxd?=
 =?us-ascii?Q?o4vDmFJBfGeMZ5NglU652Rv9blvgQXNTHrGGiljKjA8hmc/Cjk+Jr98Rzgu/?=
 =?us-ascii?Q?d/tzN9ntjSJVsNEjUCwJTSaGymSkc1/Bab4IfDh8bpzh5j2UnD5NxyKY/P2H?=
 =?us-ascii?Q?CR1ujTW3VW/jozxMuv0ELTKI96vFoM68uszKTEBCd4XmN62z2526zjaRmCC3?=
 =?us-ascii?Q?ddz/BAx7999xkcGobzJ6s2qMhEn1QZH8QuG9S5n44vvRbSwt5C0qErGXnVta?=
 =?us-ascii?Q?EYpHjl2MDREJ1zSC6CtkqEID4gNLi+l54C0a+UbFynAW+qDerNQxhqyOff5k?=
 =?us-ascii?Q?MpoWXb+Y5sJpk3mE/bNm+CzJloZ9hfRNV5W3tTHxc1CA/710bIKMJMvIbiaK?=
 =?us-ascii?Q?byk/OknlBzsJV6xY5p3SRTLnVLhM8CXiw7Iy0mkZZnjcM5YEkvMRDmWbQJRv?=
 =?us-ascii?Q?acku/R29a5cZ0fZy4OIx3g97LG3SwJzdc3moDzVn+7tSrIS9iUaiX0mYpZ2a?=
 =?us-ascii?Q?kAGqAT/DlY0nhWTz20R6ZosxwbesceseVj6MQAAuTQ9exaMbbKLQGpL0OUi8?=
 =?us-ascii?Q?D9OmImyl032SpcDpeQnxIoy4d8a0k5LoEmR62xB/g7lYSraUg1Hvfi23FlrW?=
 =?us-ascii?Q?iiIPdvWG7zxQm9icwumQae8tUxZP+c+kbXrK6EX/CozqKle41CEjTRIlhND+?=
 =?us-ascii?Q?g7rrkzdTjlb8rES9fbNPLIaDbQA69+Qa3XYKkIdUNC+4W85UKQJhfZItdeH6?=
 =?us-ascii?Q?wSwANXs2rKq5HOnBra7t9aDDo2ix0KuGWsA8Ge0LJ/c67/VIDZgF5h4US3X+?=
 =?us-ascii?Q?gFMd0AWhpTk46isdDvqUwBzkRh0EG/vYG1BN9ISfe+DiX5ELrI/GWUukl7oZ?=
 =?us-ascii?Q?OgGHuEvXTM6jryykztWGWIlKeT3N+8f590rk4S9J6cd3o4grurOEtABeNQxN?=
 =?us-ascii?Q?/GRd887YHg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jclM2ix7/McudCN/U9vxA2o/pGMw06a/stSRJ30IsO0o/LAZI/IeB3nz16hmGUEpcJhBvGACfwpZXGmRgHBCH10LPfAGQ7T87iMZS0TGDf4135d7n7aILL09s6nrmuV3NWypU64IjkWtS21Tbdai5E0LRHjNvnsJLFlwvAU68M/tKFg0L3xdAp0LfE1RJDyhX/D6qPd1Zk2B/cVdV5H/7kRWGqOhCrlxWM11QedMVRZap1lITytvADqwU1/+3QS5af3g8ouaQigu0nGNq7OaJbFWmphB4V6Zipb7T/ldDmW0pXNCq/QhO5+LFlOGSI6uRjaIBs3G28QdYt3AB08Rxg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18d04ca-042f-4756-0087-08df45a56d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 18:54:51.2528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cF9fJmYuaKZf+etAVdOsxsmyuqutC+YfwES5d4ZLOxhdI38VkLFPpJVJfu+3y/mYRTc6s1u3Rmz8YhUj9UcNqAJcx4l+UUqdOE5Q2m8HHoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7974
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

> -----Original Message-----
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Tuesday, October 13, 2026 2:12 AM
> To: intel-wired-lan@osuosl.org
> Subject: [PATCH RESEND iwl-net v6 1/7] ice: Protect the control PF pointe=
r with RCU and a rwsem
>=20
> Mark adapter->ctrl_pf as __rcu and route every reader through rcu_derefer=
ence_check(), publishing it with rcu_assign_pointer(). Readers that can run=
 in an RCU read-side critical section are wrapped accordingly.
>=20
> Add adapter->ctrl_pf_lock for the sleepable users which cannot sit in an =
RCU read-side critical section, namely the PTP hardware semaphore in
> ice_ptp_lock()/ice_ptp_unlock() and the TX reference clock paths in ice_t=
xclk.c. Pass the resolved control PF into ice_txclk_enable_peer() so it is =
looked up once under that lock.
>=20
> The pointer is still only ever published and never cleared, so there is n=
o functional change here. This only puts the annotations and the locking in=
 place for the lifetime handling that follows.
>=20
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         | 25 +++++-
>  drivers/net/ethernet/intel/ice/ice_adapter.c |  1 +  drivers/net/etherne=
t/intel/ice/ice_adapter.h |  5 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c     | 82 +++++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 23 ++++++
>  drivers/net/ethernet/intel/ice/ice_txclk.c   | 20 +++--
>  6 files changed, 119 insertions(+), 37 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
