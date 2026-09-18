Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A262C982D8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 15:45:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D32340B13;
	Fri, 18 Sep 2026 15:45:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LQ4kSm_BNpuN; Fri, 18 Sep 2026 15:45:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 664DC40B24
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789746312;
	b=n3kcmNIZ8Cv8WrHxzhZI/DyVGm3mTel9eEDjV+6TPdxO8hXqaCk+VqWAMGmsCxfyQsyy
	 X4+ChOzoHxNyPCRtn87j7PBZvvSi9J2BNwMLiYmaRfyx8Y/CAEEeq85x/MbaCO9QXs2DM
	 L8GVJV4dAikwhGHrvEkAxU2GMBVcacgPPcHFb86W1zVkARABdAM0l4IkwO35ANQOYS5fC
	 QAAyUBmTpEPRPdYxquVARCnDLZiFVKyDNPNBU7tCARZKHU4K4v7tAEtyCiPE6DWgzso+L
	 pOKErnPgG4nQq8QzFoO9MKHrFpxLhupfMrvszg/ZOQ4On4be9BcGJ2Zj4QimxT6e5kA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789746312;
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
	bh=ojjcglf7/4UkX2MKeQCGcV9wHIpUzoZwJHOqiuCVnl0=;
	b=FiizlZw8EIY2t06VqQyNzYSy6zSMIhfcTuDybGVnG/kj7p3X1BHMfvhyHUvpXRT2xRFN
	 1raXV7IhngSnNEpSwrThsTka9vO1b7NzkTYY4a2xlLVfx9bM1uUnj9sh75xXwYO/4Af5c
	 bQv12WPrTT9VEl9SIH2kCxgklhHjuyVF+wHtv2eECAmbxrVRkFVzFLDS1zbXfO9ODQ99G
	 fj2ZzBVX7aukWoylnXrvwL4hEybJHL2sp4ezff3zeg9Ro5Im8pM1fudtKxEwjytv09Ws+
	 mDl04z441azocxufjhaq7yEzBaG4UMfYSNvATFwPtH/C5eGRhTLBB50+l3eZMmtlHlQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789746312;
	bh=ojjcglf7/4UkX2MKeQCGcV9wHIpUzoZwJHOqiuCVnl0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pp9pqyO3xASiXfrz+CVdf77SK7QEiitRZmRv4xxMUG0Zpp+JcsqAow1sFMNuwJAmL
	 ncRrw8JQNX2xM6IDY0ksiVmIlz7YE7o+PdIMLra6I2KIl4udhtZuYwwg1lZ2z5dKQG
	 ECS3tJYkgWn2TrRhIDyIJHyAk5uFoT6oE48ONNcx3Wdm4C9Zay7fGacOYHXZz8ZtCD
	 DTnHO7pvVdRNk6P1/dBj3WBRTg0JdjpwpXoqJ4qS4ABZKJynvUw7ctbW7HPzywINIU
	 WXNnrJGUBqnN/HraSUjVdw6/xveK31EPnqVeBRY3bKYgbU8CZUCn6CeZDOtKrjZ3jq
	 xo+5kijLyMkCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 664DC40B24;
	Fri, 18 Sep 2026 15:45:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2114413D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 125D840122
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:45:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fPzOvqMHLiey for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 15:45:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4E1F0400AA
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789746309;
 b=H9YDMu+zgwQfYla8yIZvOs+uoV92X4JfSSjbPaLppgW7oiiOAvLtyknLUByDqKaRahX3
 ceKKvuoTgWDz/p7oHOMqRO1dGDsQAbyU/Z1v9bfjyI0A92VwSXsElbHPqBOew7Hq36vWO
 X3IHuwhTiUFlAtpv9FnIEZMl4Jhd6qjjp4YezBa8mD5Jajm6VTIAIt8Gzd2k0Dxakdrgc
 uXlTb9Gxw5O8utvGc20cpCpoUi3LcZ0trrsYiP3Z2WAaWRXn59JCl9KC7oXZsE/o+q/Sm
 uwCrKXb0R+Sup2T5UGlQjuZNMQMM2+LQAhYWiAI5gJbEQVjiDcAI8IK9D9FDkadTe+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789746309;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=ojjcglf7/4UkX2MKeQCGcV9wHIpUzoZwJHOqiuCVnl0=;
 b=VvZ1TA5ipnzEzIEcH0nm7Xw2LIUx/0ou2UKyg7p8IejYtXjnW8hzJw+rT6fD2f/jJsmL
 EJ9gSHtClkIWJU+YHXiY+oxdexCClfcZ8/YAFL8nNoeXbZN7bljDzpUtUHLikpu1uB7r6
 YDQ9J6onHjkYlsnxYtFSHqBemnVrOy1uDBJKoZ6OaAGOmp/Jzm29hjscfB3ezHe8wgyY+
 zYRmSv/keOYuMgEC+uYMhNcnmZDy9SN6bF5N+eRGcUnjvyaooakQ2B5ZoicvD+UGJE2Fe
 8a6qITgAP1e9/9rNh+eB/ic0+Z34sgkjdvVlTlOQcrdxhhiBwz0MPIYMOEkn/bHefLA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cMyfBQu1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cMyfBQu1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E1F0400AA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789746309; x=1821282309;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xC5cDiHJqBX1CVvfVDPRa5PoRJQ8zKYZUqbGK9l9em4=;
 b=cMyfBQu1yl11ybo57fOOmZy/L5go0MQ1R1CHpl8FrAkw9sJKdUY0yYJ6
 RMILUkYjmGA8IwWSfR4ANoCpD4G76+Z3FtmoxhShgfpG5pMZiSYeW/rh6
 1w1BMonyaNqPC7feyKxYZ5g/0anMIHfF7SPPYlzCy8a3i3LVyq4ic4mXA
 Z3FlWTrF4FD6bJE4pT8QBf0NBXW9qkkbRtmbOxfcarlsI/bMg2iKPnp5T
 OWV0XPdZxOwAd37kNaoBAtQoGq8xHwdlWA87ldJnBn/moFmGtQOCXxSt9
 5JQyxuJhmxa0CEmFYnr1OMNdBcOykKnd0B8O/j3HGnMvcQGK9XYRKqg01 A==;
X-CSE-ConnectionGUID: CrsM59eSRTiFUr+jwq6JKA==
X-CSE-MsgGUID: 3JcHFXirQ6eOBkbpwPaaWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="77825107"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="77825107"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:45:07 -0700
X-CSE-ConnectionGUID: MlDMIPGfQdqbOCmu9sORxg==
X-CSE-MsgGUID: j8UKAKH5TXKBQVWdrlXgfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="271129298"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:45:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:45:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 08:45:06 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snx9WR9Pm6OoEmYUzqDPi6HBi1/9mTEC8IlDhn6Nh19AlakLG592pJDlfSD3bDpcSaY9PZs+9IV7aLKfr2lVF7KDpsNS6sfnAm8vinuM86914nXpoBLGYa6U1vaKetpyhxgsCl7cpsbXm5T+/jKpkVF1LHxFJbQfJGPINFGHAa7xqRgW5lK1mANINIw8ZKlYU1zLu/zN1y/2LJ7VkPQpCyGKBRvcgMfYKY/C/m9+g1ft+cZS0AvWK/TSAzFCWDvy4Z6wKM20Ir71nkiKGhoJXcSQjV3SAoA+EqNXxJ8SDVj+pb1LkPKAXVS+SiGLL8iMJVR1uKkj3IayPvQBSlUcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojjcglf7/4UkX2MKeQCGcV9wHIpUzoZwJHOqiuCVnl0=;
 b=V9TOByeXQo+CHsDfOpV8wavb0JbvIHH0oswJZeJoP7REuleoTEPID9s9E0j8jxfd9OcgZS/bVd8qJvDWQ6s00i60Km1wmmczd7WxrlDBkhuUDUyShkHCJeB4fLHU0qmLO25j0cOpNemdpKhLpIvBUhLaSCYJTLGyq8+B+D5wgeKFL8IlkrJr3IZAkuEG4oKwogcz+UZDTiOvESMfH/AYNzNefs8haCU+bJ84lw2/b/CA6wfG5D3XgfAI6lL2SODTJ5ZsXW0HeECj7ZGJ1druseqyFMmKL18Qaq4TdQwzOISf0v7jGCSdp9yaXs+DsREqREceEMtWkwbYY9BcMU2bgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF8622363CD.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::83c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:45:03 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:45:03 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Tian Xun Ng <luckilystar08@gmail.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, "Tantilov, Emil S"
 <emil.s.tantilov@intel.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Tian Xun Ng
 <tianxun.ng@bytedance.com>
Subject: RE: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down
 vports on shutdown
Thread-Topic: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down
 vports on shutdown
Thread-Index: AQHdRr6ucef/9VtgoUmXjw86AmfVcLbUe8Tg
Date: Fri, 18 Sep 2026 15:45:03 +0000
Message-ID: <IA3PR11MB8986B87C6FD950C4AD69634CE5872@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
 <20260917105205.37561-2-luckilystar08@gmail.com>
In-Reply-To: <20260917105205.37561-2-luckilystar08@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF8622363CD:EE_
x-ms-office365-filtering-correlation-id: ebfd2551-ff99-4bea-5f43-08df159bce47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|11063799006|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: mpOPjnmq82rm4/+NmaCBHfdZ4nHcsB9oTxQjboVYYwAYZpJutM46VVtrCAngaRlff1M9ME69IZDdgcfRqXVCzUOf9mxmKQyUMdkLNP2A2vqhbdR/OmqG3z4AXWXviNtuG8RSmjq00l4qLyxakOGPnW4yWvJ0Q0WxlllTl08Zxyve6MseY8bavUWu6gtQE3ZQUb7QXFfFMc+w2gUSgY5mRDrxuFgY4ox0gJqdDKSvvOPEf+qJYmPhcFtz0bFI1azlIs1qwmM4dizFEpKewvtsootVFbq1HNHkWS8d7ZPvNFZSsEcQjxVokHagDZ0uOVe0NCXGJIELH6TUi8697Xzu6/DCRWh68zcwXA3YUPrexiJYPqnwr/8Lby4qvfWxCFF4p6K9/sW8xyLSsw8+PGZUR66L8P1js5FXbC9LxDE/9u+ta40BVUdhPQXlAZPS2mA0Z0JGdE5eG45vw4FIdwrT87QMBna2w/+IVTR/+qk50QssXicLMRmZtgAvnVFDtpx65LkkAGe4A6iS0WCVFyJLNxglbpjFbaDaclhYJBO6fnzeW15rfIQMnWX87KAS05AVsrx1BiiP0ao/gCcpAuOsFSRHCGzuWNW9/rj/H+aXHHNBDFFoxh/SLW2YbKveQx+qnE6rN5ddlJH4WlxiUSoNyKDg0Yz559kl6rfbBmiI0cz3Kbe0OgO2fWCWQgmEAP2MohU3tdMM5j+qjxVYHpsMEhdWdtrNjVtqfyc4mBN5Dec=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(11063799006)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N0KqiJ2wTj4igBHO7JEkDve37DZgCkSA6WXN492h6Sm2Y3Q4lW8UQe7yR4Li?=
 =?us-ascii?Q?a6H5vYKaPdA0bqHvOXzNwTIzr/xz836Bggg6nX+HXvG7ffhtGFCEKpCy4RnE?=
 =?us-ascii?Q?rESz2t0QPRAY56YGQAp4phoethhGWnEJ3+s8AL12ExNO5k4tsZ1AzsxHbxqX?=
 =?us-ascii?Q?hyEOi6uVSmGY/V5Ulg9fqTwHax/azPDTq1uqCrhshKhmj/TxEEAk41i7rYvR?=
 =?us-ascii?Q?xE1gfv0sw97iZbuEc4vhTo0yU8KrN1/p+6CMr8buEm/D0VGaKar3G85NOpwn?=
 =?us-ascii?Q?MoOK9UON+ok5IT2UlH3OQ/V7Gqrr6GZ/M6IfhJkU0dfNaeob70D0RGt/nmdv?=
 =?us-ascii?Q?orff+01hH2IEJVxfvm08q6Kb5hOqf3X7iSiKC6QEJnjHqSKcbnAr53isLPoE?=
 =?us-ascii?Q?gxbnRg5XUu1yc9tSGA5ztCAoDLLuybRalshCZl6Zah3es5w+2zs9cJ1yi18H?=
 =?us-ascii?Q?xk4MlYtDim1sQDfaQMBq5Cbbg792yNijf0VU+aUMeXfJFY7EBnrSGT9BYI/h?=
 =?us-ascii?Q?gS4vTxY0uT0nzYKwCaBHQWuThHKtHiGIrm15Kp6HZxqaJVZX/sz3xSD7X+xq?=
 =?us-ascii?Q?V9WtlluRJkN21p1sJVI/KIf4x8x7o+5vBMYRGFbr7pmyyX6ogkkwaZrQW/RE?=
 =?us-ascii?Q?VnJUOzS97+NrG3TciEZ6XJ38j19pO2J+cCycggz7OzHPv8OTv9ZkJaY8PLit?=
 =?us-ascii?Q?eXrfD8YYfPh7pv1LZ8US/C7IRrk9F3YHoOqgX91pL8QMmBHNdmOptffLTYl8?=
 =?us-ascii?Q?wU9yfIN6r2BV+cxZMgfPZRSEJdcwz5meLLIECNl6JsTAirxwur4nQMxsaTx3?=
 =?us-ascii?Q?vurUJWSIEtlsIt9/2OSrqgRVVNVL9httS2mcCzGcrwE/TsLkOva6Nct4vnn9?=
 =?us-ascii?Q?6li1f4UolSucy8BSxpronNhnVCAfrJInhUQU9EgJEIjx4Yj0oL3FxJMvzCa/?=
 =?us-ascii?Q?DLTe2buINRZaEBhTIOzr1iEK5Ei9GjxyFwC1iFhreu1CE0pPHEQvZN1RdRiw?=
 =?us-ascii?Q?u5+lgBZWhL9jvB2SWtthZazIJu79/eaScBtIhBGoKBSE6lUxF3fqdePiU0bF?=
 =?us-ascii?Q?9qFdtqFFq5eqY90dC4nT8p016sFE3tOIMWepWJCaTxPHOJf2c/+P7f/8TYRp?=
 =?us-ascii?Q?EFTQXITPDQeX1sUzrmPX+HPjRNk+hY/1g5Ch1TnwWiVY6VfyNqm8ZiQp+MH7?=
 =?us-ascii?Q?IjDK4CJj2ky/gfWrVZMCDccqd9IEZmFu3MACCmmOXW+9arUAikuBoTXwZnO2?=
 =?us-ascii?Q?QQqAaHhCX50Dg/foQda2kbRxaGlePtxtiAa8vXmBK1Rdz34qM8K8gOdni+lM?=
 =?us-ascii?Q?3EsgZayykij0diKI6uLHypz2qDEQPQbdvI1ymd81dqYilK7gi4/hQe5sieRD?=
 =?us-ascii?Q?DjdKx4T0mWkVv7m5XtHqLo+pJnb2w9JMbIgQPv+vs9I7XwfHO7sExWzTi642?=
 =?us-ascii?Q?QZOwpJk+4aHYRzi2hc4OrvcLATClrisFu7leF2Qw/xgTLJJip7ofMhsQVaCW?=
 =?us-ascii?Q?Cnuk5NvSz/ICjs7Izq/3r9v3W+anH1DexJAjDlpGEpqih2XGqdq13COau8zK?=
 =?us-ascii?Q?XlyDE5ITwmYliRvN1swRTX8wfbdd1y/Ag0d5+PVSofdF4dggkBdaBRP8nRFS?=
 =?us-ascii?Q?nmpzZZscEeLvqmFpQWVy8CjsOVXGG/cNrCHlYnFo+KLfEtZrqnKq4ojSixiS?=
 =?us-ascii?Q?78Wt0DWuiJ4hYMitWNPrZDzTynCNhSep7lDrNqcfJqiSVUW/t6QVvnCWWkWm?=
 =?us-ascii?Q?VJwrc1/Gc91SkWVQPEbytBo3XbEG67Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aMNcbK8dDW9IpCNwxreRbcuNCdVB/X2XiyMgNP8NacTMJFIqQroYaegwBdXMWC0r7QRIAk4oWdPFlqiunVyPUI5NjKYjMyHIX0lHY3T/e/PXI73QU+4Zm+26LDqPlQfwp87Jf+c1p/eTZjDrBKZP+pPRCDRT+EnE/IwDawLwKbBHApc2oqOkqXTts7oKyTk46xQTq+IZyRo2Ml92dI75eUkH8+sor0atOMEzrqMyreMm1rsQFx3zBuopQ/5/Ma5z+uM5bz78nKBm71tmKoLtG4gc8Uv0V7tISMUw9UDKZ2h6VqBP/wR2Aa2usmCJutxuE9vmzlzwj0TeEOo3ka/QOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfd2551-ff99-4bea-5f43-08df159bce47
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 15:45:03.4185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Legmh8BRCRBijjiDZdkbB1fAuwePc/PFgv3DeK4NcN1c9a5LqroSXhRg7YTe/JUQT0okw6Xz2EKdstIyDnku/bL41thV4XtgvEbuRjxkk70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8622363CD
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org



> -----Original Message-----
> From: Tian Xun Ng <luckilystar08@gmail.com>
> Sent: Thursday, September 17, 2026 12:52 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Tian Xun Ng <tianxun.ng@bytedance.com>
> Subject: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing
> down vports on shutdown
>=20
> From: Tian Xun Ng <tianxun.ng@bytedance.com>
>=20
> Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
> on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly
> instead of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on
> shutdown.
> idpf_vc_core_deinit() uses that flag to decide when to shut the
> virtchnl transaction manager down. Without it,
> libie_ctlq_xn_shutdown() runs before idpf_deinit_task() tears the
> vports down, so every message sent during that teardown (disable
> vport, disable queues, destroy vport) fails at once. The device is
> never told to stop its queues and keeps them enabled, with the ring
> addresses of the kernel that is going away.
>=20
> After a warm reboot, the first queue reconfiguration of a port that
> has not been opened yet (udev setting the MTU) sends
> VIRTCHNL2_OP_DEL_QUEUES.
> The device then drains the queues it still considers live and writes
> SW_MARKER TX completions (qid_comptype_gen 0x2800 / 0xa800) to the
> previous kernel's completion rings. With the IOMMU translating, those
> writes fault on every such boot:
>=20
>   arm-smmu-v3 arm-smmu-v3.17.auto: event: F_TRANSLATION client:
> 0016:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0xffb70000 ipa: 0x0
>   arm-smmu-v3 arm-smmu-v3.17.auto: unpriv data write s1 "Input address
> caused fault" stag: 0x0
>=20
> In IOMMU pass-through mode they land on pages the new kernel has
> already reused. With page_poison=3D1 that shows as "pagealloc: memory
> corruption"
> on most boots. Without it, nodes crash in unrelated code, e.g.:
>=20
>   Unable to handle kernel NULL pointer dereference at virtual address
> 000000000000a830
>   pc : __tlb_remove_table_free+0x48/0x118
>   Call trace:
>    __tlb_remove_table_free
>    tlb_remove_table_rcu
>    rcu_do_batch
>=20
> or with a slab free pointer that decodes from a slot holding 0x2800:
>=20
>   Unable to handle kernel paging request at virtual address
> 002613b73e862c6e
>   pc : kmem_cache_alloc_noprof+0xc0/0x3d0
>=20
> The early shutdown exists to avoid waiting for transaction timeouts
> when the mailbox is already gone. That is the hard reset case, where
> idpf_vc_event_task() shuts the transaction manager down and sets
> IDPF_HR_RESET_IN_PROG before idpf_init_hard_reset() calls
> idpf_vc_core_deinit(). Key the early shutdown on a hard reset being in
> progress or detected instead of on remove, so that both remove and
> shutdown keep the mailbox up until the vports are gone.
>=20
> Hard reset behaviour is unchanged. Remove is unchanged unless a
> hardware reset has been detected, in which case it no longer waits for
> message timeouts. Shutdown now delivers the teardown messages; if the
> device stops responding without a detectable reset, shutdown can wait
> for the transaction timeouts, as remove already does.
>=20
> Tested on arm64 (64K pages) servers with two idpf functions, with this
> change and the next patch backported to a 6.17 kernel: no stray device
> writes in 151 warm reboots across IOMMU translated and pass-through
> modes, against stray writes after 20 of 20 warm reboots without them.
>=20
> Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on
> reboot")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c    | 18 +++++++++++++----
> -
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf52706..646b6e074 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3197,14 +3197,22 @@ int idpf_vc_core_init(struct idpf_adapter
> *adapter)
>   */
>  void idpf_vc_core_deinit(struct idpf_adapter *adapter)  {
> -	bool remove_in_prog;
> +	bool reset_in_prog;
>=20
>  	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
>  		return;
>=20
> -	/* Avoid transaction timeouts when called during reset */
> -	remove_in_prog =3D test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
> -	if (!remove_in_prog)
> +	/* Shut the transaction manager down early only when the
> mailbox is
> +	 * already gone, i.e. a hard reset is in progress or has been
> detected,
> +	 * to avoid waiting for transaction timeouts. On remove and on
> shutdown
> +	 * the mailbox still works and must stay up until the vports
> are torn
> +	 * down. Otherwise the disable and destroy messages never reach
> the
> +	 * device, which keeps its queues enabled with ring addresses
> from this
> +	 * kernel after a warm reboot.
> +	 */
> +	reset_in_prog =3D test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags)
> ||
> +			idpf_is_reset_detected(adapter);
> +	if (reset_in_prog)
>  		libie_ctlq_xn_shutdown(adapter->xnm);
>=20
>  	idpf_ptp_release(adapter);
> @@ -3213,7 +3221,7 @@ void idpf_vc_core_deinit(struct idpf_adapter
> *adapter)
>  	idpf_rel_rx_pt_lkup(adapter);
>  	idpf_intr_rel(adapter);
>=20
> -	if (remove_in_prog)
> +	if (!reset_in_prog)
>  		libie_ctlq_xn_shutdown(adapter->xnm);
>=20
>  	cancel_delayed_work_sync(&adapter->serv_task);
> --
> 2.50.1 (Apple Git-155)

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
