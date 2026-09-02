Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17275C61DD6
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 16:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D485860726;
	Wed,  2 Sep 2026 16:10:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eLCopMwjQ8Cd; Wed,  2 Sep 2026 16:10:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788365438;
	bh=cqX99LSYY6LfHhJ4+qx+mEhj3NYtSlslvmORD26zOR0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=75n36Z5sikWUY2XERlktDuKDQtdwjMWYRwD4yWTZ2Q8ltJRU0y/YarsfLKuPum0SR
	 dOfCIfqWyWTWv+hKyS1A+JWlLSgcw6g0nArjwdPZsTo0rX01uxf1YUJNj7Nxti5e9t
	 zL1rzHwoHRUWgd3xFA8FNGM0mtkL3mBvg5M/HH73anrQTxtzskSPqn0d4bhAQ6cbAX
	 ZOMn9kGnwe9kh/34lH1j2oFPsIueD4U4oFM+Wxb8MqnYVXEr1lpBaYZCkJj/1bXsOB
	 ntoqmuhZdFPVI533y9b5J/99e+GfEwcoZl2zNb2jUSSwUxB8CT7niqnih9XQxpKFbg
	 PU3yHOwmKIbHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B116A606F5;
	Wed,  2 Sep 2026 16:10:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2B342B2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 16:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A88BA407F5
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 16:10:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cWSikTgyP6Zu for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 16:10:36 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FdHbMluA
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D211B40750
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788365437; x=1819901437;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=32glSCF6xvRWr5lmsO0pkEvAuGXLG4QiTL6CqCpQfuM=;
 b=FdHbMluA4Ak9xspkCRxJZps5HvwJfi0+p9eRvQnxb4nA58Mhn/AiSOPA
 ScCCSbr40lXDzWviTuqZNTYIn6Cm74LMRJrxkbSRJhOIfZuj787GGB4RF
 uQ2lbZdUtslrWF9ZR9P511JfSnJOWTvdCkgt3mPECunFST+l3vs6ebccG
 rbfsFqzqkSm/I5wONAF2AaCu9BK9VhDYj+tgojqfFiFkM1CmE8y22r0KC
 LWfGpfnIMylpXp18A/npk5mkijqrxANG4eVItw3F6ltyLPB8oQnfVYp2h
 sZEjZKmYtZdVdQsMyaOtUxQIeDTEdDFyl+MWOZwFPUknJq0fXYclIZFPY A==;
X-CSE-ConnectionGUID: CXBRdHGgRRCG2DwhW/Jk5w==
X-CSE-MsgGUID: 8rm7gGMfTai1a2hMZtFXMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="89039402"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="89039402"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 09:10:36 -0700
X-CSE-ConnectionGUID: D1XSG1QeS7CHNZTYouNyUQ==
X-CSE-MsgGUID: zMyMQ23wR96C9whYDOAqaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="299321952"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 09:10:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:10:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 09:10:34 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:10:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cc/lr66GdR7NBOaWyBg/17ZQJ5sg95Pthn4ETcthZd2OIRb7kOIwJWPlumdENhrgFoh8yKclFjllZwbfCE8gb9EKTw/T4W7js2hqT/qaU/07ibYUL3rFkSZj1Qqn78okirdZFq/oOoL0SgtbNYo4rgpD0EHKm0XtJGLoI3DbmlgamwsOyC+GyHGj7dL1ywIAR2ji6PCZUaDBl8Q9+LFIoB/cXwvTXikSgulJdM94mQ5BvzN1ATjQLVJG7APm9i0MkbtJZOu6sIxYBbXP9sfQjc+DQZ5Kp1yR77TTYvRh1svGTvYJ+k50/hfW7OOdegTTOllwnD26XK3c1R/qfIYlmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqX99LSYY6LfHhJ4+qx+mEhj3NYtSlslvmORD26zOR0=;
 b=Oq9xBMXcnFl3sIs5HjizbriN3m9NRlEhkgH+Uag+AB0vpLB2GT7pZOkb1JclDTqMETrxxk+2SxzcdTmyRVbDux3nnShW0zF8S2atBxK4ILB7R+eg01oziWATiN3Yn8vaieKi3o5G2mUPDeYAbf3L0uKazSl9vDTedIoE30Di615nwI+da4sNAPBfYYlr+NOsYnn62GjoEXoW9NO/5tym8/7v+/RyL2kda8EYnn05ak0VCPGJTOO1m0itQ4o6p6tM7G3Ef14QbTamZcE9Na+FBSgI66uzEST5DZjK+kJTJQxVGO/ULVefuGlczTvMFNl420SoRt7EZVxpy8ss1XBKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS4PR11MB180604.namprd11.prod.outlook.com (2603:10b6:8:50a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 16:10:32 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 16:10:32 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "edumazet@google.com" <edumazet@google.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v3 iwl-next 3/3] ice: use per-interface
 clock_id for E825 generic DPLLs
Thread-Topic: [Intel-wired-lan] [PATCH v3 iwl-next 3/3] ice: use per-interface
 clock_id for E825 generic DPLLs
Thread-Index: AQHdIz0XvlRbOY/EJE+5nG91gJ+mdLa7pI3g
Date: Wed, 2 Sep 2026 16:10:32 +0000
Message-ID: <LV1PR11MB879063573C9585C9EDF4685590B72@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260803113507.1858083-1-grzegorz.nitka@intel.com>
 <20260803113507.1858083-4-grzegorz.nitka@intel.com>
In-Reply-To: <20260803113507.1858083-4-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS4PR11MB180604:EE_
x-ms-office365-filtering-correlation-id: 730e750e-fb96-41e7-12e4-08df090cb6de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|10067099003|4143699003|22082099003|56012099006|18002099003|11063799006;
x-microsoft-antispam-message-info: 7+AA8/6V8eJE4hz9wLj9AB2ZZwztefG630tsl8KHY9R5tQfpyX5t6WY/Hh9Xnxw483nqG8llhnlLtl8B0PQomYrlpHsnKSEzVjCdTjc7/KXp8Fgd2wBWNCBg4WMjRWt8CTDxISvrAqMcgoue+Ye5zRBS17xJ7OCQGHuSGFD+evdH4gxXIxzfppCibx+j4L+beii5V9G+4yKn8uSMu5eHr8OSk8DWhUVE4066huQ/t6/VQ/oWWFrl7sHj2k8HVaSEp0CWbk1IHTDNfC+4MEqIRu2wMrUumVXoOkRvP6vWFu63Q88QA/8ZEc05E2UNytaV3FPFP+014qDmzEoaTPb3Jrlj2ob1i9a6X6QH2bGktOnIK62iKrY5G08+tTOdIhTdACwvZuxN0aVmwV0Eu15COh0Mv21r8vRSyOeynVEyI1G6M2NkwgjgGxL9tbYNosq3VEBPkFSBUJ+pVjGWSGbkt4JTGXNwc7R7gX8cMj6IddO8a/dva7nu8IFuyCiyQ4ZUqmD/kzUj1yVsRLs4B5Vx0kspx8cVlvcbHova5DSU8rAz84OO12W4BwSVAIkCjHj/5+FIw+O41YeCLLV6LNLisCgkoo5EWn/nLNYSsnQXR5Vcq6wzmWVFYghx06B4wrC8h1Pan/jWGNsVnuN8/ycJaktGR1QX/HlJuQ6UV0kkF1ovQaYF4rRLZavq2O2V1ab/OV8XdLlLO+pTJDFyEoemhl1DAcSSau2eDnBxW5Xp+Yw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(4143699003)(22082099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ybsu5fTfohkvSjIY+gndAZakiBJk7p+q+sC9z5UsM2uTqBA5jeFaKDMwdrEA?=
 =?us-ascii?Q?ZwAzslZGAihaAgw6Lipk8Z/wxneEcRumAbmOlTHAlvgmEt/eyV4ZMuTPpesF?=
 =?us-ascii?Q?VYeV6qsAA9YHVkyGUDl+r2AdivJHFdzgIT3RSXf2MZaGDTlsgUAilmjcB/am?=
 =?us-ascii?Q?TEBkCwYFR2AvK+keXXNmJTT3PN0GXcDxXqQCkNKMyL5NRyQYWF5XOOUILJTt?=
 =?us-ascii?Q?C+kALP77Shuox3S3e9eCSwBbMoJduJ29gTemKrilHpms9tl1SuokjrELsnzf?=
 =?us-ascii?Q?oXX25Bx4uC/QyEecbvIiaECLCcVe/jRD4uJLplhfCYRbV92p9xnrnC2rYsfN?=
 =?us-ascii?Q?JimY2xTTTCiRR9SAEVMSHmX7eAaHdWXFI5C6VJEvWFmuGRyA6Goq9YKJWJ1e?=
 =?us-ascii?Q?8UtlNlt2PLDIAOCSD89rPbrlI76TDYB36wAtscBhZqyDDlui+EWnkQc0Yy8P?=
 =?us-ascii?Q?XvBHnNmp+ihMoQr6qRjwiBnU/myGVAu9CerH9ZRLTZNxPOhcI89eXyNlIcJY?=
 =?us-ascii?Q?+ZGoPiylIYSdute1/KY/ViYLoML+3W1brAkpWkgfmGG2JX7qGPEtLfYaBHhT?=
 =?us-ascii?Q?S2FjYg5qLg0+xngtXuDzwK6vkDDl/gZyN8T0dsQm3UFi2WfyY7t4Pt3WWuBn?=
 =?us-ascii?Q?NZ7Uv9IzNX+33lj+7G0676czv14R/jeudy9zpYOxLIYkQWCpEbQG6QUJ8p3g?=
 =?us-ascii?Q?SqSQtJ5NfCnK5XqRGOMkk4NPgaEhFKyJAsBYYwksiyL3u7tp8GHe2lJw//MY?=
 =?us-ascii?Q?CgmCCJg6jyrKdsiQLYEy5tUrQgPpGXhbIIvyEPCxX29yL8FAnH23yRtfx/Td?=
 =?us-ascii?Q?fRI/CJ9lbB3Iske3oi566qPN9x+3qkck7jM8a8e6gaIQ0S5+P1AzOBxHgIFJ?=
 =?us-ascii?Q?Cf9I3ENcqmjXOp5fNB8rBMdmC2oRuZxtIg7dDuOq4mK5d0NK0Q5mHg46PBPC?=
 =?us-ascii?Q?500M/KBvnHZui7C7hBjvsbwGhubCiP4OgtBWVdpdDKee4ianswJjVdBh2ktk?=
 =?us-ascii?Q?yqTnjdpVyX+FK8hG9c5SKXBOohK89uNLcyle99b8M7YMulnEwp6DXdwc/E0g?=
 =?us-ascii?Q?HpWmVZa5uSW/WHe3AmxBWCqgyPxDD2iw/R1nJGjn5yjkP7BeWF9YEVQodUls?=
 =?us-ascii?Q?pFbZm53DbUjpgs5JYpIBNgzhfkIdGx9oNqgTHbV2zKXWoJNB9jMnHF75R3NW?=
 =?us-ascii?Q?5r5RGF7ZCGfWWW4Ms6JqZ3bSpm74b3DbM+xML17JNyGLEmUth66xZXuT4Cnp?=
 =?us-ascii?Q?O1hQ+8OQhSEtdNjRmhfg7TK7DVMbD2F77EfWpxNWpQaU6JrwD5iNQ18PeFwK?=
 =?us-ascii?Q?O6XgZLDYOLMmiTs6w1BYkD+/uWN01SgiDg1eOUouLNv7kIqBL2ACZ4/qTwa8?=
 =?us-ascii?Q?G4LwMLKPMLXq0FPo+txbXx81f6RT88vgGXz51+jg79TzJcIMECzE1QoYBaJE?=
 =?us-ascii?Q?m7bRATkHuF8+WhFMraz0ROpKq2+RqqjOB0HDSINOqXoPziZYYtmXc9Jkmo9k?=
 =?us-ascii?Q?2p5T3Y0nTfGDfiTLApyDfnWAQRI3dfB7AMHs7sce/nI9gIeKh5BP07QwmPFk?=
 =?us-ascii?Q?gb40c0pEQ5vYIO5th/eOXoX6VffagLjarsN1RwlSEJopXbXBn6rsmlzgF5rR?=
 =?us-ascii?Q?REVGNOl5FhWSMy0PYEAHdzyNPEJ6VUsLDuccv4oQ19TD4GxK37SVox5oiUp1?=
 =?us-ascii?Q?PEShXCRZq0sEmq6wQ9An0yzHSxkL5SoSHZ3GQwW2gYt43l8QCLOR3aOs6jUn?=
 =?us-ascii?Q?n/rhkvuSaA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5Qi6QOr2kbaplffYpbG+O3atqfKht5CzyH0M+EVWYkhS/syBMfRYbXrK5gJa+x2AXEUpclTl5EsUVvUGA3d2/PYY+Z5w34emZGUFc1D4SSKX6Kk3i5V3XmeaFvnDontRsR5gtWuk0ekLZwmR70ZbomnwBihnhGlCMjgg06W6Shbngs2Mpdg0Br+aNy03MRLyfIqN5P/WKkQENt63iWjnXpD/ZdLTVZG8jIgtpW4x8lxnjBAcHzwlHtdRIoZ2vLIJC9vMwPlyCaGDNoLbCNzzx0xnns9ntcWZEvl3ro8ATrYh9kzsa0Rt6svIHkQQUeDhcAjEfbZzlEONW2QkyKtJcw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730e750e-fb96-41e7-12e4-08df090cb6de
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 16:10:32.1797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqFb4KBSGEnRTZwu+q0YTM5T8uJ7zoJFX1HNM3XB2BA5q1RZMOKFOn2AvBzql/2IQIMbF68x4AjwY9GNjE9CJFy5Brv9zqWm5V4J3ig7ibo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB180604
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: Monday, August 3, 2026 4:35 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gm=
ail.com; linux-kernel@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kub=
alewski@intel.com>; Korba, Przemyslaw <przemyslaw.korba@intel.com>; andrew+=
netdev@lunn.ch; edumazet@google.com; Nguyen, Anthony L <anthony.l.nguyen@in=
tel.com>; netdev@vger.kernel.org; kuba@kernel.org; pabeni@redhat.com; davem=
@davemloft.net
> Subject: [Intel-wired-lan] [PATCH v3 iwl-next 3/3] ice: use per-interface=
 clock_id for E825 generic DPLLs
>=20
> On E825, the TX-CLK and TSPLL DPLL devices are registered as DPLL_TYPE_GE=
NERIC. Their clock_id was derived from the board-level PCIe DSN, which is i=
dentical for all interfaces sharing the same NAC/quad. As a > result, users=
pace (e.g. 'dpll device show') reports several DPLL devices with the same c=
lock_id and no board or signal label, making it impossible to unambiguously=
 map a DPLL device to the interface it belongs to.
>=20
> Since these DPLLs are per-interface, use the permanent port MAC as the cl=
ock_id basis for E825 generic DPLLs:
>=20
>   * TX-CLK uses the plain MAC-derived value.
>   * TSPLL on the source-timer owner PF uses the same MAC-derived
>     value with a dedicated tag bit, so it stays distinct from
>     TX-CLK while remaining stable per interface.
>=20
> Other DPLL objects (EEC/PPS and non-E825 paths) keep the board DSN-derive=
d clock_id. When the permanent MAC is not yet valid, fall back to the exist=
ing board-level clock_id to preserve init behavior.
>=20
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 81 +++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 5 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
