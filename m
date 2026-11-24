Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96C606A321
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=7CpktNwt;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WpWaURvB;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=guchVMl1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92B0E6084D;
	Tue, 24 Nov 2026 14:27:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGiXsZZQVXpB; Tue, 24 Nov 2026 14:27:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60B2860814
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795530423;
	b=WluShEDK7ZBzQY9dlYZDIi7/izHZNbMOPMbOmYJ84ho+Pc8Mdu4wQP9if2Idi5oVnIl1
	 W4ngE77Da0QXC7Mb+jSDqrA2adLiCF4DpxHUqJBSS9zLtfswCKKzf6UdofQwhvcWPxW8D
	 AR44oeCvhPCsJie5eU2ZlipPcGfCKqm+mt/ITl2RJjJx0BoVCEzsDwmzouTWD0IDylGFT
	 eBV1pbKTT115T8N87eVTGyH7x6oIuBiWMCp2sUlWwKURE4wwANXtkrgJ6rnIo6PGE+VQM
	 HoTe937JDZivHMciZgwYl7n9RYXQKU+JRf+a1H4rnGhKWdj+36DwELuXJps6Ce8Z0tQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795530423;
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
	bh=V0auLGjx9LUG89XGtmiz28b6qEzOlnBN4vQCT7caVZU=;
	b=Dx67HgGfVzO+HdMGAnPX6IqJD6XnaDps8auoc6iU2/fgv92jGgffNutISHl6u2344XKc
	 mhWeNmgXcvA0GCLZL4ucz+1i52prJoi8qZfldOBWAw+3WFbUUTx/lnI6NKyQ7BhlDqCRE
	 IPcBBJP3DFWLMB5t2CYI2QdyNBvlDMaW+nbQvwVsCMRJmj6UqQd9CwLsGzlChhmXO8FCR
	 xJiu2TKA02Duc1Chr0q+oIHW7vhDy7e4SogRqEkgtkKt4tpzGe/pxYNmmTjRj6sFFlNWd
	 2+cdOH9ONpD745j/jAQezCmRNguUlxBPmlW2/YCAhUDLWZAxdE52YYvue0kREiTKYkQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795530423;
	bh=V0auLGjx9LUG89XGtmiz28b6qEzOlnBN4vQCT7caVZU=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7CpktNwtKOl+wYPnoIJHLA2MX2eAnbWzvKXznT5Na7qbzKp7JGuFElm0TBAtslYSp
	 RttBwwtBPv5GuuBCPWXkAu8d3Ustd0M3dvfPsPIJKOvnV3BZUtacvpORwCQmMSSAuf
	 cUAZnwUYX4Jo3VvAvoz0k6K0cKn+ozNzmImxxa+oJyOtT/jJwzsXMVGCutovzA6QLy
	 PZhAKqh6vS1gnb8iH8m6fibrB+QUT0cJGi20yeUpudJC5dMy8fbH+tP4022CWWGYku
	 nsIpv0RAi8vqtEdzsadQmWAw757PU1VMyQAkb321NFfIc/58Oey43+DAYjG+mIGW+Y
	 lrtrMFteuVm1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60B2860814;
	Tue, 24 Nov 2026 14:27:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C0A161C9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 14:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A695E400AA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 14:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MHgsyCPSOVeB for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 14:27:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B2B65400AC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WpWaURvB; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=guchVMl1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2B65400AC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 14:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795530420; x=1827066420;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=yZl451D0fsc2D1NDkABxM4Z3kivK4ja4kPl3uKnfkfI=;
 b=WpWaURvBbReqrNfdRh/OBkPrqbebTG/e0uH9udj9d2cbar9jsMmcmiYi
 /4ezt0HG3Lu04ewq4Gf6+r1fNoCqVn1aIKB4h7q2kSn8UupuVOW4Nh70o
 FE6Yc2AbcxtCFLDv83KC2gWcmSUAhqwKL+OJhLTwWecpKNVHyBju4PWNk
 NOCN7KxCBBbgUm6MKE3ZwIjXX8K4dbIwlyENtdnGHGCnk/SoWE60rQ5HV
 YTQGdmBiX/bxBs42dZxXpbQK2nB8ha4psb+wJe5d/7w0ZF0u0vCA4/b4O
 8w/GpOnU2D6N7KtarSWYOdlZPoJGQaP14FmaFUJOuFWMeUmLJmUi7Vi7n w==;
X-CSE-ConnectionGUID: BeZpyi9ITRmJQaVcA7d4+A==
X-CSE-MsgGUID: uMejNruRQAKfHN+mQ/+nrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4479044"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4479044"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 06:19:37 -0800
X-CSE-ConnectionGUID: K8G29tA9QIyolphtjY+4vA==
X-CSE-MsgGUID: p9NArJrRSF64ZubthH500A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="13592314"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 06:19:34 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:19:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 06:19:33 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:19:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0auLGjx9LUG89XGtmiz28b6qEzOlnBN4vQCT7caVZU=;
 b=guchVMl175jSZwxY20Ibo+R6NauPHr8nkQov/KoFGXxIyiJN+oa+ioH9fsC5Caaq5SRAIR5W9BPh7fXn4FbTqnkd39GDGrB8yg3rWksR4gZI7IU68Lun0Z5AvUw4Xy7ba6bWtgCW3Dlsa6PPfVrFLBFhlLm+F+h+u5c+pYhhgnU=
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by DS4PPF25B1C4D24.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:19:29 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 14:19:29 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Karlsson, Magnus" <magnus.karlsson@intel.com>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, "magnus.karlsson@gmail.com"
 <magnus.karlsson@gmail.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-net v2] ice: account for XDP_TX buffers when cleaning
 a Tx ring
Thread-Topic: [PATCH iwl-net v2] ice: account for XDP_TX buffers when cleaning
 a Tx ring
Thread-Index: AQHdfBf69bQPUPmzMUWpQastvNVvnLc9RQsQ
Date: Tue, 24 Nov 2026 14:19:29 +0000
Message-ID: <CH3PR11MB566895E95586F94B282D5AFEE9E5442@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261124132942.1102882-1-magnus.karlsson@intel.com>
In-Reply-To: <20261124132942.1102882-1-magnus.karlsson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|DS4PPF25B1C4D24:EE_
x-ms-office365-filtering-correlation-id: 1ae80baf-347b-4d7d-4146-08df4a35f3a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|921020|38070700021|10067099003|261022075727099003|11063799006|261028144727099003|56012099006|261021121427099003|261102123227099003|261009223027099003|261026140227099003|261022115727099003|261022105027099003|261026121527099003|18002099003|22082099003;
x-microsoft-antispam-message-info: BeZ+g+uQZHCCL8JCJMJb0NyN69K6PrqE8gJnb1j3Qdrbt1KgrkdPQx3t6fq3UkvOH7/5ig5WcYpNTnIJ7yU79GxUyKt7f1Nk1ZNR5C/J1nJTCD80lXdDjGK3+xCIpKJ6wiy5Jnr/w5UAn02NAWuEvDkW2BjCz7G+Dnw2uONfzP/mZBJl/CLhd8PkwIjRAwur65/PKKqGgsuPxI/yw6eWmv6GCOahhCzo56/3bxC+f422gWDFTJLR5ukCCqfwpr3oHyYxWPsnKZRheP3aTVG8HtX3guWEPQUvT6ErRy1Ogu46uleaUmAc9zepYMHIXiE3dvf9QssIOjFnhNQLQC+xuxmC3njwZFQoMeLpe1bhc2BmmkcEwnL+yHTEfa3yIa7Sx/eBCVYZ04wew9nszbJyXpWH5HenwW4ExpFUgR4wZdbuWXf0pPyJEuB1yMwb4tFuU6X6mijD7EdxaUcOZ/hBifNLd3UZkcxDkHiHhkhGDzOTQFFPPy2jFBOberEl8WBG6IIB17XIDf3MdIIMC8nQhlY+s3S5BbvYPS/k+6TXOJ/NRv86H63i4z+jc/YpRoznIOQw7zmqgOV60/RiiW4Yn3LXn2gLoOhFn+f8uU2dpG2N/Dgr/++Oh5wlQySiciNaqrvi6ICXLlQZQ0ljVo6sRYKkYRDZIdWyzyPA64US1ZI5/exZ+ol2Wia6vmvwf9by
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(921020)(38070700021)(10067099003)(261022075727099003)(11063799006)(261028144727099003)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(261026140227099003)(261022115727099003)(261022105027099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jCq8QRyX0L8xRxsSP0nN3o1FToseFMVsjKmi0cXu9DqSO66iWzF74dWJQZWs?=
 =?us-ascii?Q?ouGXcLsnMJVdB+BMnTuwGvgOcM2Aq2zStBffkXcKKsYo0HF6zWBVi+fFPsyY?=
 =?us-ascii?Q?//4j2vf9kuS2YaxZfl/ue3KIigf07ZyeCjAn4prFvjWgK68Qv4+DlBnnkjs8?=
 =?us-ascii?Q?XA9h+mbZfz8jzkVvJaThZEjW4QRroumfP7uJjJe0PE9KuICcMxRNeC9QAvHm?=
 =?us-ascii?Q?+xgF275G2cmUwQkAWqacULbaqIcIxTIb2DjpMhz/KaRlrNEnJn4w24Y3CDpa?=
 =?us-ascii?Q?tm6z3tJJKB+VBHmU92oajAO73emdmMHHVffSqx4XikIW+fzfTUN797VY9Q8c?=
 =?us-ascii?Q?4qqHgtrbBD2rHwLShN7FYU9VILtWVHShQCzPW86EZJO44iI0Dx3p4O5UqSka?=
 =?us-ascii?Q?Bt2PelkEpMHRGiFSc5LH+cOpHruHichlWattKoK09SXjV8WdePgP3DyhYc+x?=
 =?us-ascii?Q?vhyljC3c+ew9laulSURwSRXVUnn0aftD5oTydbiFX7u8rVMqUTk5gtfPkAp9?=
 =?us-ascii?Q?jA+CYSS4vl69FscLCH5vwsd1eI3Is8bTYNgy2TgOjjsMLM8TrPcjEs3Gm527?=
 =?us-ascii?Q?qyGpKa9UV/gtqVpupAGTnRKMFFmzPU9o8Qpna3vmYIkdWonT3+fd4sl84jL+?=
 =?us-ascii?Q?UUNO6bCpModDzthLXL6Ww0g5cW90rX+Tmn9EypshmtoyaJaDk1tciNarK+3/?=
 =?us-ascii?Q?iZuxjWqbK9EdOhqFi1jpfy0JD/Bj6g6IBUFAMbm87kXT4Mf5/BHhQ5P4W4wZ?=
 =?us-ascii?Q?28oYhswtMG5mETWtMbHLk6T9Om78SJSM2TE8hk97BNibEza6a1J5zQ5f/yaA?=
 =?us-ascii?Q?EVVQnfRgrutgkzj2K7Mh858XRbDgvSScHTZ6QdyPJCjTN2OiD0iqH13WHbDY?=
 =?us-ascii?Q?S3TF2wALncbzKV2xK2IWa3IdJkW6qiyL4Lc5BW0TibgbEo/Kvgivfpoi/8HM?=
 =?us-ascii?Q?laiFOIbIgsxANBUkUOEUEI/zDD83MXPbJY/9uFtLwvvRaMA+LvvJSpFC18QV?=
 =?us-ascii?Q?KUw2pb68/GeLIrZkdLdqqu0axggmQ0p4VD0hnJzTdLSHDr6ScTEc+2W+aoS8?=
 =?us-ascii?Q?0oBN/oxPEj3si29kninm2cjsZzb0kYf1+ZrTAdKrpm/wHIUIyzQYXWSrFysR?=
 =?us-ascii?Q?urvCHyZKGTalSpx0KaflYCBqBpbZs0t/PMyYOeUDIGvhocsw3hi6/H3Lnd56?=
 =?us-ascii?Q?enDX9bXbvu7x/janegq96gHUPdf7DHwEEmNGs0dql7c72FOhQMX5247ptiVw?=
 =?us-ascii?Q?1a0SQ20UmOBW3TG6ENDuca4ngacQNgDb585PbHeQ/R92IYWeWk+mt07eSE7y?=
 =?us-ascii?Q?cKhoDeMfXzeLeO33mYnWPkQdXg3cP3r5qIp6U5Meya7EuHVo1+ASkt9Rm3lf?=
 =?us-ascii?Q?kyC0y9vFRVFS/qyzxPm3ldfzqmgL4FeVMAx5DvLa3gDEsqKYL9U5JmNQQRm4?=
 =?us-ascii?Q?ZuJz1IMwb9Qfbq2pHL/7WCL0u0TgrQaNM+lkQN8wqrMK1+Gn0CURBkvv/gF1?=
 =?us-ascii?Q?N1Qig9TrHxKimO/PPn4GpVvtlukOwpoe6NlHJIbSk3C5jdUc5LUyOt7hE/qF?=
 =?us-ascii?Q?lqw9v3qtxklX7SH5W+PUgbPU/yCyQF1iOUS+IzsM8bORqcJCa1Gfw4iC1ycy?=
 =?us-ascii?Q?GYuMZfNR0p5v2u0G6EHhDxCnqEPwk6QfrjbNJtQPG8mus3pUvIvh97EaMofA?=
 =?us-ascii?Q?CNTdma2WugfHcxEuohfY9G6GBMGh9KKwHF6nGUtbtnUwfN6bWW9dCO5tyRJ4?=
 =?us-ascii?Q?+Xz5WJSKttt41zn2caO4HgWdRprNfgk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k1kycN9ljMzJH3S5IEukH77/E2p48zbJplTaXKIYIVJ2fPMFRP7LRtIr/6yAjPnP7smb3p19ZX2PTpD0a33QNZz4vIKw9UOInS5XDbG3WWQOiBYsFLdPjBgdOatBoImh4wuXEz3ZlC6m7rUbJ1UVWZpkcQN2Fvn68bekcy5RYGfEZZlswjvdjMI6wa+rrW/IMz9aqjC+dU7jvNKkF13ud6OKHc7CA6LzLw46gt7IC4yalgOixF25ieVZwIahg8wJWG0vgon+yMcO/LuQIlk2xXH6BV/J8g23vW4s8XRdQDAQtc7Ih1D74P3FzgoA3Jq3SMlGTE1Q2TgO+0i+59YL/Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae80baf-347b-4d7d-4146-08df4a35f3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 14:19:29.0291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHJyM/MYoif1zg8ELsq/9jRqE1viMdmSa9AfiVQq/+ukRw7ifVys1WO2y6yjlrOt+l0DgJ/1YuJYUDGpQvpXtogPTha+8SnZiv4y7mUL7Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF25B1C4D24
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> Sent: Tuesday, November 24, 2026 2:30 PM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>;
> magnus.karlsson@gmail.com; intel-wired-lan@lists.osuosl.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH iwl-net v2] ice: account for XDP_TX buffers when
> cleaning a Tx ring
>=20
> xdp_tx_active counts the XDP_TX buffers on an XDP ring, so that
> ice_clean_xdp_irq_zc() can complete AF_XDP zero-copy frames in bulk when
> there are none. ice_clean_tx_ring() frees the buffers that are still on
> the ring, both through ice_xsk_clean_xdp_ring() and through
> ice_unmap_and_free_tx_buf(), but leaves the counter as it was.
>=20
> After a ring is cleaned with XDP_TX frames in flight, for example when
> an AF_XDP socket is bound or unbound, xdp_tx_active therefore stays non-
> zero for the lifetime of the ring. ice_clean_xdp_irq_zc() then always
> takes the per-descriptor slow path.
>=20
> ice_xsk_clean_xdp_ring() used to decrement the counter for the XDP_TX
> buffers it freed, through ice_clean_xdp_tx_buf(), until that helper was
> replaced with a plain xsk_buff_free(). Decrement it again for each
> XDP_TX buffer it frees. ice_unmap_and_free_tx_buf() frees buffers on
> regular XDP rings, which count XDP_TX and redirected frames rather than
> buffers, so reset the counter in ice_clean_tx_ring() as well, so that a
> zero-copy socket bound afterwards starts from zero.
>=20
> Fixes: 59e92bfe4df7 ("ice: xsk: Borrow xdp_tx_active logic from i40e")
> Fixes: a24b4c6e9aab ("ice: xsk: Do not convert to buff to frame for

Why two fixes? Do you fix two bugs in one commit - better split into patcse=
t.
One bug makes reproduction more often - mention it in commit message.
Leave single Fixes: tag per commit please.

> XDP_TX")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
> v1 -> v2:
> - Decrement the counter for each freed XDP_TX buffer (Maciej)
> - v1: https://lore.kernel.org/intel-wired-lan/20261118135952.1063685-1-
> magnus.karlsson@intel.com/
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 1 +
> drivers/net/ethernet/intel/ice/ice_xsk.c  | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c
> b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 35a480a1e172..f26646825a1e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -228,6 +228,7 @@ void ice_clean_tx_ring(struct ice_tx_ring *tx_ring)
>=20
>  	tx_ring->next_to_use =3D 0;
>  	tx_ring->next_to_clean =3D 0;
> +	tx_ring->xdp_tx_active =3D 0;
>=20
>  	if (!tx_ring->netdev)
>  		return;
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c
> b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 0c1ce3e86a45..2d9dbdb82cdd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -942,6 +942,7 @@ void ice_xsk_clean_xdp_ring(struct ice_tx_ring
> *xdp_ring)
>  		if (tx_buf->type =3D=3D ICE_TX_BUF_XSK_TX) {
>  			tx_buf->type =3D ICE_TX_BUF_EMPTY;
>  			xsk_buff_free(tx_buf->xdp);
> +			xdp_ring->xdp_tx_active--;
>  		} else {
>  			xsk_frames++;
>  		}
> --
> 2.38.1

