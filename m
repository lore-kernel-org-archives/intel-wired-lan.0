Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7791606AEB2
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=W/7aZL81;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KOs3vfSq;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Kf0ty2en
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B492A40E50;
	Fri, 13 Nov 2026 12:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKbjEhqDz-0l; Fri, 13 Nov 2026 12:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BEB6840E5D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794571567;
	b=OcSQH408mbgPnu//NV8cGwj+rPijFiQUg7TkY8czPWYOGaGqodtO2WvEMHH6P0+aFI3N
	 Xq68l8Or4kMcfWwcLlODAB64m036yFHhryWsXTIeNlu9nncHWQGhgV/pr9J/9xQyRMp3I
	 +KlLZXVMNDkIPI4wG6z5Y3Fyf9hzInT6MIboMG2r4drJwM4qFiqFRu2bIiDBM3ODNx6kf
	 jW6WKb5HPdjg8deGvhVJsFZKfq1E7yhs/7BUqxOAR/XsGP6SSa5NhfZgu+Q/XSWwFsmx6
	 nSlLcxeiELu6JHuJ0x4w6xoAr3hol6WjuNMwqDQKBDRWTeeG+BwuqEy5Hcwlu3nScjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794571567;
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
	bh=u0sUp+926VJv4VKcJhWo1TNu6Z0KK/7VH8tdLdsCALE=;
	b=j4n5qI9653VY5ldBO3nU1tzcWwFvvCYz6u4bjOw1Hj243CsOVTNJxWSL1dQ4CAMF01GW
	 Jk4fmvjwxsS+P0x3J0CtsgA4hBtJjw1rogStURUWljEVVp6IV6DVq1U94r5mFU7wVR3yP
	 WenUNKb6p2dzAVgIa9CBuM9ys/xNPw7HlnQ3QcQvEciy4izPzwQxRIPao/FAT2sHA1KRR
	 7z9adCPvPADFpxPBvX8rIflV5/9LQpJLP8Q142RezlvkqZ07WXp0i90CFbWdOdZ3lIBrd
	 /Z/g3HFlc+o3Nnmy0pEYfVn8r2lfpUr88ocPoLLM/b+8jOl4gYkONhPmQvvfkaT481w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794571567;
	bh=u0sUp+926VJv4VKcJhWo1TNu6Z0KK/7VH8tdLdsCALE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W/7aZL816T2g5W6TEtOfkQElt9I+JPgfMz7kkBkc1KsvDiwPcY5XyG4UIn8ocL6W8
	 RFwC6y/jSgHBCyAY6RwdisR2GHH0kh103gunkRvI8eS70oCFyuJW7ov6uJNudKfb67
	 hCXwovLkgjO+PCEYa9siegmIE/BcRwCIikqFrNk8GDTyAjcENRAAk3tzbdUZ080Nv4
	 uma1XM7JTkcDqN5H3iU/6oyCAEL0pNismPSiHaLYgnWJz+o5emdqEWi0KivKu+zgy+
	 SLI7PMcYh9/fis0hz7jbSs10vQZ9L7lmkwWxHDoAmv1IIQMFCsEVzgUSGrICNHlv6L
	 ysQXQPadfWYNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEB6840E5D;
	Fri, 13 Nov 2026 12:06:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D55E3235
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 12:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B98ED4051F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 12:06:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8_D2wS9ssqu9 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 12:06:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6ADE14051E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KOs3vfSq; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=Kf0ty2en
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6ADE14051E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 12:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794571565; x=1826107565;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BlXU84ZKPOlYCINsu2tiM+duUdNk+ILxHtNvaVcEpkI=;
 b=KOs3vfSqmb0k8fZbqZNk3lgRPdiCsva9uph1zrC8r0om5yPuNtIzZC8H
 HRTeMahb8F4kZVTh+Aw42utR/rP3l+p/p+pI0TJ6+myFFqzzsXmpBhNbl
 kEQB51Plwu6aCkR91QjiJ7uP1EoR/ReA8Qan3P9DZ2+BbENlFTai8gdx5
 56A5beI8fA7i65teo0EZum1gZJktET9K3Sb4ZOf67y/gzCq70Dc2vs4PR
 zPyDO+DZFNr6kzMvSxmDjSpR2AtidQAIwwW51BaQZqCixP5K8CqDYMRgO
 242WzROvPvwJpe0s5AUAG0J/TuQHluZpYrEfb7m421arOc31nxfvurWYr Q==;
X-CSE-ConnectionGUID: BYfs14D+RMCKpvDxb6dAeQ==
X-CSE-MsgGUID: /VJl+nA0RGW6igXiiiDd+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3466082"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3466082"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 04:05:51 -0800
X-CSE-ConnectionGUID: BR3GQXNXSrqXmCBQGQv9cw==
X-CSE-MsgGUID: 60xem91LT2SaCyZ/MT08+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9325680"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 04:05:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:05:49 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 04:05:49 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:05:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0sUp+926VJv4VKcJhWo1TNu6Z0KK/7VH8tdLdsCALE=;
 b=Kf0ty2en76yDtoccUE74zcicAGgJ8luxSaTYC6jN81V3/GOOwvhNzzQAMxEZ+cJ2nZTOAE2T14/4OuxC0SLY5ad9aeW/ETK++PqdpyLND5CwJR9KRN7R1fW/ssGLJ3VK54VWnJOYk+BgOoOZW+u9anAKWP8vFYTzvprII0ULroQ=
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by BL1PR11MB5221.namprd11.prod.outlook.com
 (2603:10b6:208:310::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 12:05:45 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:05:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Tianyi Gao <tianyi@cloudflare.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
CC: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir Vdovin
 <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, "Vyavahare, Tushar"
 <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, "Jonathan Corbet" <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, "Chris J Arges"
 <carges@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>, "kernel-team@cloudflare.com"
 <kernel-team@cloudflare.com>
Subject: RE: [PATCH bpf-next 13/15] xdp: add kfuncs to load the stored RX
 metadata
Thread-Topic: [PATCH bpf-next 13/15] xdp: add kfuncs to load the stored RX
 metadata
Thread-Index: AQHdcTPANtbVY2uFjEunpjbbw82/Abcr7CIw
Date: Fri, 13 Nov 2026 12:05:45 +0000
Message-ID: <CH3PR11MB566895B67CB1C3E21DFAA92994E57F2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <1985183a511a2217fe0f42582cbd16f023d8991e.1794281983.git.tianyi@cloudflare.com>
In-Reply-To: <1985183a511a2217fe0f42582cbd16f023d8991e.1794281983.git.tianyi@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|BL1PR11MB5221:EE_
x-ms-office365-filtering-correlation-id: d5ceab0f-c86f-4bea-183a-08df417e729a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|261028144727099003|261022115727099003|261026121527099003|261102123227099003|261026140227099003|261021135927099003|261022075727099003|261021121427099003|56012099006|38070700021|11063799006|4143699003|261022113327099003|261021123027099003|261022105027099003|10067099003|22082099003|261009223027099003|18002099003|6133799003;
x-microsoft-antispam-message-info: hf6PdouPfyQMvkDxpFOQ7udeuL2XKJQQEfbVQ8HgS74rN63wZtzL/kqfdAF4WfZkLfp9gBn342hwzq36iB173tHBy1BXNX5TsSac5fHALUP3bTlTwntvrOo9CZsMPv/NuNJOUmMPkQMaaTN1zYWx3v9EeDtol90+bsI0T16b1OB9mTVFWFk4sRSyzq5PekpbePxgA8F0f0O5o/R27VZ+SnBcejoIUaEId/aHv4AMH4HapcMv4qI3MJkzYbNtdvBPtM7gFGK6h9N5IXivF4uZTbJTgiY70Owx+SoDa5pdfjmwcDHEzsvLK1OTPk4O1eVTWNwQEXHBrrChxA55186IbPq5ptrw2pcvyhyapaGA+SkZgW+JiJVfRtDBvg0qGf2H0w8d4PT7piQcHUKdVYP1YR5w376NyNKgIty7W9bwYXnorl2IwStIgREzgB+MMH2TKdfZtdRnr0RgWoYIyuS4nVCid/8ohFpbxvTL+7aLsP+fnLgl6ClVn1atdbzD5WDFM9wHx4PV1X5Jt9xwzGLaWYziUWOABnwAihX+EKUlafFPGH779th21iT1VFSdto0eTLBDJVi4IPbgAzLsWctJGCBQwRcMDp3ZuOqUeJnMuMYdP13G4n6uunCcRTSqgwSbKl5B4AIW+iUaqHHtFyP+as2zjPRo5RLa7zxZJ6Wqs8o4+pUmdFd0J34FCEPMQfgMExH1pHOEcEcPjvr6Zw1U2ER3hweAqZYGxiv221vUJy0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(261028144727099003)(261022115727099003)(261026121527099003)(261102123227099003)(261026140227099003)(261021135927099003)(261022075727099003)(261021121427099003)(56012099006)(38070700021)(11063799006)(4143699003)(261022113327099003)(261021123027099003)(261022105027099003)(10067099003)(22082099003)(261009223027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gr0LdRcXJ3kVTJ8w1XIP+SaI1QIH/UjNRn35DiOz2e2wZqwugerJi4WNwx4G?=
 =?us-ascii?Q?Lxn8Q9r5wwrrZe3v0ia+56OUC7yJMFL+ktfSv45jjalqIXKhIzrsL73TRg6n?=
 =?us-ascii?Q?+7PoEp3+ziEjVvZj2L23vrfzKf7dqLBSI9M33R4dv8N9vFYuNsnTWLXJTexE?=
 =?us-ascii?Q?yAebXPLlfULF5l1yiiYyGTe+wimnBQFGMbF3Mo1AxG6gzbep2OvjPpYrITZa?=
 =?us-ascii?Q?uKHOdpRPZcBjwrf8R9ZSDYcvho2hkNm52RPWpy3Fm1H1FwQyuCmrcKZ9qiys?=
 =?us-ascii?Q?7pfc/J6Qj1ws4/NgVtgityAx5sx0IfdqcW14kUD3cLjPWQlubVvI8SvrKiwD?=
 =?us-ascii?Q?RViYjPypg+MiwIFqqC7vNnu2Rlm8ziZNtXoqoV92SMmhwFrNJqLO/W2oZY1S?=
 =?us-ascii?Q?LIhzMtUDzW4FKdCk5cFp4lWV9z4JhQkX/+KVp+SltX1TcT48BD/5Kg5wJQ6u?=
 =?us-ascii?Q?cq4oshCOw10tg5OplBJLqdGnwNLQa9428YlQ0uqXhKoNR9+pvKqIGPBtX0n2?=
 =?us-ascii?Q?wTmEtyVLvP/lK5mvI4rv3bvDPEUe+DHcOATN3WJKPiwhhvgDz3YuUqABC71d?=
 =?us-ascii?Q?1ey4S+99gx5mqwtsxEsSNdzT6z/hRfHVaDCYRrXJUiUYglSnl7fG2MbNjpMF?=
 =?us-ascii?Q?fEG383a+qXix5Pw/9E/YDNtENrBm9AEv8t5TUkgBJUkvQE67d8Hup6DUqCyb?=
 =?us-ascii?Q?SQHYu4Z461UyF8GethInNef0rKZ5XFpTe0PMHB64RScJsGNpHV1fQB6q8ETz?=
 =?us-ascii?Q?RLBgNGj4/Z+g/WaF2/Wathq6RWitPY7wl1ClbuHVKM/0k2Vto4oyEnvshMEy?=
 =?us-ascii?Q?HyIOhPZ6xb+MLcLnUxDWKIp2IN5qVS0YGB+tqx0/BC5Vny84Pe3Oji7habkA?=
 =?us-ascii?Q?6L9tRNMTbaLqUECNEuKCZvxcZ4kweET0XYbpK+wWBG+AeNKoBFBpmRm9kQxR?=
 =?us-ascii?Q?zXUzRu6YZvACmLBYDtIPu+OX0kjJiy8CtRgjkqBRPzpIxc7GsDvJxKZOifUl?=
 =?us-ascii?Q?12Ey7WbEdHRzR7sc+ZayaOCv85UDbyxM2nl4Px/F7/9cJLU2l4cw5W+yFQkg?=
 =?us-ascii?Q?MU+Lne8gO3C1hr9W9KwZOsJ7blibWfv7aS4Tk+buPinMkggqt7nOBvHwivyT?=
 =?us-ascii?Q?YIiDzmlkL5xCc3Z9HvB+9+LswVo3e+6xtwFhff6IAke5jrQYv2mtZN5IcOUQ?=
 =?us-ascii?Q?06CoI4D4buCLZFiREhaJC8ux3n0AlHZl85Dn+eoyOKobJ4MbKQAuVng0j+38?=
 =?us-ascii?Q?gNFc3JHGcrOOuO1PtFBaIhAa7CJ/qgpJNMQ9eW82WwFHws4576GM/p1i/ZmA?=
 =?us-ascii?Q?DCu7v8Mz9UvRLbkMB7yEMU5/6jRD6GHIIxEfun1v07xIDFwJzM6pSxHZWhXP?=
 =?us-ascii?Q?JKXgF9KcRVRmsXzAC6xdaHL3bb71ueGh24h9tr6lo8QXs6hNST4Fgu56rnqx?=
 =?us-ascii?Q?a4eaT4Ek2mIGiw463SNTJhx8UEaTps2kdf7uhcE2WzT3VDaNpFtpHv3u3zki?=
 =?us-ascii?Q?ei/S6m3fitj+wkAbRnegVAaBPujBl89aNloA8JvKQTb/7fStqh2yxZrImWlB?=
 =?us-ascii?Q?gtc6x9vjGYiPIo8rzaUm+5oh+8zBsvTgsWyXFw5Gl7iUxY2xywt0/BMeIlFU?=
 =?us-ascii?Q?mgGim177HgnYkbHmh+lv0NDPnZb02i13SniJdT3ED/BtXVBuC2foORqEUod+?=
 =?us-ascii?Q?OpwcqJpbLQcA7yKZFdwtZ+6Pi3mZOUv7d2QrdrItTzYVHWOoOg8jj2A6VWh+?=
 =?us-ascii?Q?2CBFerw21g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xTj5cMVM5LWZkdzk2277dpMdkUMjjQpSg9AP4bFxCmCOc6yogxBRN+Xps4p9La9gJBRd0G8AjhU5EQGdI3HNpEqa2ReSVnKlRTCM27ivZkNVQs2IKHDV/F6fiSnvF+ZKooM/fuNtHoDrIyPyMlVa9zj68weg0jFxhS76oSvPmIgfV8bMBFlBtGEso66vvArucMckMXI/L2JYGkmz+aeOPgvLS7WngieIV/dQRQ8ct1ffzK4TNy7qpF/MCOTkr1gnDXhooLa2pULIM7DCCwAZeHBmAqLupKvy5niz/OkRxgPD1//egVLg6ahoZvshQxW3TbVjfz6RndP/sGVAkgLumw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ceab0f-c86f-4bea-183a-08df417e729a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 12:05:45.4222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqjT3CKFD0F9tYW+q3ic0aTTKxjHhfdT4E+XDKKXiz+iw8KZ33rUzBikE/Xvm/jGfAvE7e+ntuOpXg1d+5O1vWShGmmdgry+jUa/Ymc3hEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5221
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
> From: Tianyi Gao <tianyi@cloudflare.com>
> Sent: Tuesday, November 10, 2026 4:57 AM
> To: bpf@vger.kernel.org; netdev@vger.kernel.org; Alexei Starovoitov
> <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Andrii
> Nakryiko <andrii@kernel.org>; Martin KaFai Lau <martin.lau@linux.dev>;
> Jakub Kicinski <kuba@kernel.org>; Jesper Dangaard Brouer
> <hawk@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>; Stanislav Fomichev
> <sdf@fomichev.me>; Lorenzo Bianconi <lorenzo@kernel.org>; Vladimir
> Vdovin <deliran@verdict.gg>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon
> Horman <horms@kernel.org>; Andrew Lunn <andrew+netdev@lunn.ch>; Donald
> Hunter <donald.hunter@gmail.com>; Eduard Zingerman <eddyz87@gmail.com>;
> Kumar Kartikeya Dwivedi <memxor@gmail.com>; Song Liu <song@kernel.org>;
> Yonghong Song <yonghong.song@linux.dev>; Jiri Olsa <jolsa@kernel.org>;
> Emil Tsalapatis <emil@etsalapatis.com>; Ihor Solodrai
> <ihor.solodrai@linux.dev>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Vyavahare, Tushar
> <tushar.vyavahare@intel.com>; Jason Xing <kerneljasonxing@gmail.com>;
> Nikolay Aleksandrov <razor@blackwall.org>; Madalin Bucur
> <madalin.bucur@nxp.com>; Ioana Ciornei <ioana.ciornei@nxp.com>; Jonathan
> Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>; Shuah
> Khan <shuah@kernel.org>; Randy Dunlap <rdunlap@infradead.org>; Nathan
> Chancellor <nathan@kernel.org>; Nick Desaulniers
> <ndesaulniers@google.com>; Bill Wendling <morbo@google.com>; Justin
> Stitt <justinstitt@google.com>; Chris J Arges <carges@cloudflare.com>;
> Jakub Sitnicki <jakub@cloudflare.com>; linux-doc@vger.kernel.org; linux-
> kselftest@vger.kernel.org; intel-wired-lan@lists.osuosl.org;
> llvm@lists.linux.dev; kernel-team@cloudflare.com; Tianyi Gao
> <tianyi@cloudflare.com>
> Subject: [PATCH bpf-next 13/15] xdp: add kfuncs to load the stored RX
> metadata
>=20
> A program on cpumap or devmap cannot call the XDP RX metadata kfuncs,
> because they need a device-bound program. A program on veth can be bound
> to veth, but the veth callbacks return -ENODATA for an xdp_frame. So a
> program after the redirect cannot read the values that the program on
> the NIC stored.
>=20
> Add three kfuncs that read the skb core extension area:
> bpf_xdp_skb_ext_load_rx_hash(), bpf_xdp_skb_ext_load_rx_vlan() and
> bpf_xdp_skb_ext_load_rx_csum(). Each returns -ENODATA when its entry is
> not stored. They are in the same kfunc set as the store kfuncs, so they
> are not device-bound and need no driver callback. A program on the NIC
> can also read back the values that it stored.
>=20
> The RX metadata kfuncs could return the stored values instead. This
> patch does not do that. Relaxing bpf_dev_bound_kfunc_check() for cpumap
> is not trivial, and it changes these kfuncs for existing programs, which
> read the values from the RX descriptor of the bound device.
>=20
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
>  net/core/xdp.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>=20
> diff --git a/net/core/xdp.c b/net/core/xdp.c index
> fdda072a5858..4df3984479a7 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -1081,6 +1081,15 @@ static const void *xdp_skb_ext_get(const struct
> xdp_skb_ext *ext,
>  	return (const void *)ext + off * XDP_SKB_EXT_ALIGN;  }
>=20
> +static const void *xdp_skb_ext_load(const struct xdp_md *ctx,
> +				    enum xdp_skb_ext_id id)
> +{
> +	const struct xdp_buff *xdp =3D (const struct xdp_buff *)ctx;
> +	const struct xdp_skb_ext *ext =3D xdp_buff_skb_ext(xdp);
> +
> +	return ext ? xdp_skb_ext_get(ext, id) : NULL; }
> +
>  /**
>   * xdp_skb_ext_to_skb - Set the stored RX metadata on an skb.
>   * @skb: The skb that is built from the packet.
> @@ -1296,6 +1305,85 @@ __bpf_kfunc int bpf_xdp_skb_ext_del(struct xdp_md
> *ctx, enum xdp_skb_ext_id id)
>  	return 0;
>  }
>=20
> +/**
> + * bpf_xdp_skb_ext_load_rx_hash - Load the stored RX hash of this
> packet.
> + * @ctx: XDP context pointer.
> + * @hash: Return value pointer.
> + * @rss_type: Return value pointer for RSS type, see &enum
> xdp_rss_hash_type.
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-ENODATA`` : the RX hash is not stored  */ __bpf_kfunc int
> +bpf_xdp_skb_ext_load_rx_hash(const struct xdp_md *ctx,
> +					     u32 *hash,
> +					     enum xdp_rss_hash_type
> *rss_type) {
> +	const struct xdp_skb_ext_hash *entry;
> +
> +	entry =3D xdp_skb_ext_load(ctx, XDP_SKB_EXT_HASH);
> +	if (!entry)
> +		return -ENODATA;
> +
> +	*hash =3D entry->val;
> +	*rss_type =3D entry->type;
> +
> +	return 0;
> +}
> +
> +/**
> + * bpf_xdp_skb_ext_load_rx_vlan - Load the stored VLAN tag of this
> packet.
> + * @ctx: XDP context pointer.
> + * @vlan_proto: Return value pointer for the TPID, in network byte
> order.
> + * @vlan_tci: Return value pointer for the TCI, in host byte order.
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-ENODATA`` : the VLAN tag is not stored  */ __bpf_kfunc int
> +bpf_xdp_skb_ext_load_rx_vlan(const struct xdp_md *ctx,
> +					     __be16 *vlan_proto, u16
> *vlan_tci) {
> +	const struct xdp_skb_ext_vlan *entry;
> +
> +	entry =3D xdp_skb_ext_load(ctx, XDP_SKB_EXT_VLAN);
> +	if (!entry)
> +		return -ENODATA;
> +
> +	*vlan_proto =3D entry->proto;
> +	*vlan_tci =3D entry->tci;
> +
> +	return 0;
> +}
> +
> +/**
> + * bpf_xdp_skb_ext_load_rx_csum - Load the stored RX checksum status of
> this
> + *                                packet.
> + * @ctx: XDP context pointer.
> + * @ip_summed: Return value pointer, ``XDP_CHECKSUM_NONE`` or
> + *             ``XDP_CHECKSUM_UNNECESSARY``.
> + * @csum_level: Return value pointer for the checksum level.
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-ENODATA`` : the checksum status is not stored  */ __bpf_kfunc
> +int bpf_xdp_skb_ext_load_rx_csum(const struct xdp_md *ctx,
> +					     enum xdp_checksum *ip_summed,
> +					     u8 *csum_level)
> +{
> +	const struct xdp_skb_ext_csum *entry;
> +
> +	entry =3D xdp_skb_ext_load(ctx, XDP_SKB_EXT_CSUM);
> +	if (!entry)
> +		return -ENODATA;
> +
> +	*ip_summed =3D BIT(entry->ip_summed);
> +	*csum_level =3D entry->level;
> +
> +	return 0;
> +}
> +
>  __bpf_kfunc_end_defs();
>=20
>  BTF_KFUNCS_START(xdp_skb_ext_kfunc_ids)
> @@ -1303,6 +1391,9 @@ BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_hash)
> BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_vlan)  BTF_ID_FLAGS(func,
> bpf_xdp_skb_ext_store_rx_csum)  BTF_ID_FLAGS(func, bpf_xdp_skb_ext_del)
> +BTF_ID_FLAGS(func, bpf_xdp_skb_ext_load_rx_hash) BTF_ID_FLAGS(func,
> +bpf_xdp_skb_ext_load_rx_vlan) BTF_ID_FLAGS(func,
> +bpf_xdp_skb_ext_load_rx_csum)
>  BTF_KFUNCS_END(xdp_skb_ext_kfunc_ids)
>=20
>  static const struct btf_kfunc_id_set xdp_skb_ext_kfunc_set =3D {
> --
> 2.56.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
