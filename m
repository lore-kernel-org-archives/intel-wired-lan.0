Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89912606A31C
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OTr80WEW;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H5UXHU/h
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61CDD60621;
	Mon,  9 Nov 2026 10:41:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXttdGGM9Qdw; Mon,  9 Nov 2026 10:41:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ABFF060686
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794220862;
	b=o8zlBDIzffUrduqnWRHIuBbwkG9Vvv0yfxAAkThtBfbBf/383rO9swp1pZXmsWBBeQd7
	 GBKAKC8LJcrUGCDW/NLMefIxuw/bpOybCcAgwWFukGZViwraJrIFqlZyy4pgAt0HhH1j6
	 u/XUirqR78U7ZICbgL6XYQrcvmkVFVa80TlC7TJ+aI+/ulwYyh4HnVQmrm9J4nTbYS8LO
	 7M/kPpNizCPaNGJfXKtNK2cnguYvPp+OJnOCvRy9h4jGc9FEfXvOqmhK57sq8hH5Dkglx
	 wXMS0Eh2gPiXCHVS7hpOgkWFu6ere8Uaubh01Kic6urtyJPLa+ZVwC+ys1C+WO6H1mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794220862;
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
	bh=iTZUie8uuFSP11YjWVA1EQR5hche8B/2X5k0Tc1rF5E=;
	b=maiym9TfMqPj6izmFd1aX13eGD/PiehVOom6Ixw6W0TR1+4YvRYgO2hxWBzV48qAeuVG
	 A1OByU9jBrcJG25bme+Lc/8DOExuuFO2Zzqs1c84qljwsROEEHzPsBWk7fToh+dPHbYkK
	 6SBafvch8EYTh+IkByS0VJBh3XnCyjEwhzLSWiDc/eLGS55LjrnOYZPVtjMYuJLyIszQp
	 6V664MqE5+K0/0LZU2g7uIsrA4ZQ/hyGOFWwqY23NMfqrggitExvSmJIou6JiLnW/50yk
	 fExn3Ri8EFo+u5xpWE3MMQkr9kLMrLizoJBnEW29njLLE8ZJyuejyMf+QjOZCALx9Kw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794220862;
	bh=iTZUie8uuFSP11YjWVA1EQR5hche8B/2X5k0Tc1rF5E=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OTr80WEWoBNnp/KdgRPYylXpEt7PByMT2HSwEXVflAn8tI81Ht8guGFnHGu7UvJrq
	 IPWnBDBsJa7wbIVETWZTp44XqvccaDGrp5vPCa4iIQ+7c8C1kubWWGTlwMSX7REA8q
	 o4QN0TK35zNQrzMvILvh0L6N4W9AcbKMnJ4bD7H6T8GM17LPAQ9JOtR8e64JYhLE3z
	 vI3/AFqXvM6FsG1r/ie7KiyeiE2adNrB63OYtLgwPbJM9f3tgQrs7JTRApTG8wzCmf
	 LThHuZxCMHSWcbOpmlysJhudUw5YLura0DDC6C9AeZ/wVlbkRH6SnqpKb1cIN9pOvB
	 MNcwEcxSndTgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABFF060686;
	Mon,  9 Nov 2026 10:41:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E1A6235
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 10:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F42D80E5E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 10:41:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PJUFTrRvBc26 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 10:41:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B534B80E1F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=H5UXHU/h
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B534B80E1F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 10:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794220859; x=1825756859;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=5xrgjzPA7/QHhWEcYmJixhYTsUxFGagj0dd24576zkE=;
 b=H5UXHU/huFjdnrMHLaX0Xi1LZLjRnSRLcMwlIjZQlkFlBScxIkvAauBa
 W74LdfaGRAffxWV1f4U3FeohCER53IBFzFVEIqzNHF5puqC6+G2QIoSn2
 XvcQgdf+SiZH7EO9mKsjM+ZzwsEzMlfetOV1Aea+gzioOCosuBa1Jciv0
 S/vro/beDl8n4UkYbW2FhN3XFDduwSCySG8NYXKUPNw/bwBZaSm4kCq2y
 RXmzgShKyo8v3Y3N+uwXuJtZp1QKcYAlxMOG/OcYxZJG0eyi2REsZZnu0
 tvgCjtaJKSoEu9fJIh+Sb7rWYQ1j1WrUfEjVCZg9mD/eXNOzQODTVc0QZ A==;
X-CSE-ConnectionGUID: tGZMYtgmRbKV/0E6t9bc9Q==
X-CSE-MsgGUID: eSW7qVgmR+yEmxD2h5ny+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2940084"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2940084"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 02:40:58 -0800
X-CSE-ConnectionGUID: GorNBtLRQJ21AJ8TkEZK1w==
X-CSE-MsgGUID: g4MvIg1bTke+yCicoz6eXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7864825"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 02:40:59 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 02:40:58 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 02:40:58 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 02:40:57 -0800
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by BL3PR11MB6313.namprd11.prod.outlook.com
 (2603:10b6:208:3b0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 10:40:55 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 10:40:54 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Sasha Neftin <sashaneftin@gmail.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH iwl-next v1 1/2] igc: remove unused extended wakeup filter
 definitions
Thread-Topic: [PATCH iwl-next v1 1/2] igc: remove unused extended wakeup
 filter definitions
Thread-Index: AQHdb4/Rwjy+xBz3S0SRmWIUhwTuarcliiKw
Date: Mon, 9 Nov 2026 10:40:54 +0000
Message-ID: <CH3PR11MB56689526CB276EA495EE1DB10AE5732@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261108144503.97783-1-sashaneftin@gmail.com>
In-Reply-To: <20261108144503.97783-1-sashaneftin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|BL3PR11MB6313:EE_
x-ms-office365-filtering-correlation-id: 79a422b2-11a5-4eac-e6d1-08df3e4deecb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|11063799006|56012099006|261021123027099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: gAhhrNylLrvKeWo0HmPlkLAZypHknXFNxxF/1UQH68800dLLWCWQzHbe5zinffdVDPolm5RcZC0lnvFziJf6nJ56wOGDOt+u9YFGMDpcMAlBW5uQvtXTq1Y8b54YVMAZd2sXG2RkzivSaxkocOmZa3JGhG3d77DOtNomSMsToglSAmTacVeo75stGED5RjhV3uq4A8xlGKxM4I1sLQFD1aPsmdKjS+8sqf0c6XOoHoKZFAvYdaMMQmF56DaL5QcAUTwllAbAjDFA/7MnvcahPCK88z6LEKY01bfZYdpZ/b/hhms4Hn278VE7edQVpjENzEQj+DZ5+ltEKnuDoVIIx9JidAG/t9Yv73bpJw6Mlci9DzwMV5nSE24v94xeSDbeDpWykwN8WlGjGts+sN3Jk4u/m5GREULi8hVfi5CAr0s94f7E7QVErjPno40EaJk1CPG7wcNGbJERZJIO2bQA2Y36lu/VouiDf1UWmWY5kENzU3jiygX5Bn/VH98Oyx9/ulu34/ffjN9uooHe2wzs0VnW8r8hREMhXoCch5kKaZXZehNCiRc+FKHeTxK1jV1AEych+qJ9sATECwfPmSjJg2ufNhhbvOhP6ZSqUhGlEZVwrlOBWG85SfqUs7CzXkiqos+Uqj5UX2/97fki+i1iyWPO8Gj5bSIj1Ns7dm61m0PzHURKRBZJYYdhAljfycopm6vhxLMfGj9MvxV+QVt2exCAP8A1cSDECPTYrfJUPLk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FAhenFpCeM5xYbxESuXQ2C6XoFYs3a1a3KsiHBsxdj4ekNY5O+KsyOAxNfU4?=
 =?us-ascii?Q?eSk1reJW2VCu33koXHoVylU1kSpxZ/nLXLAymnUpWXieOAbbuAJwKmXcsq9q?=
 =?us-ascii?Q?gxwRpVw5hlWlj+WdTkxqPrFfqr2vxrtkkZFeQZ4jvA9lH7pd2XNAQZY2RYmF?=
 =?us-ascii?Q?Vvjw0ARebqDJWauUTYA75h1ccx8je6ssm3H6aKvLx5e77hmZ3A0nRcjqc0vz?=
 =?us-ascii?Q?LOMiCXnMQKaH6wWXVF943mb77CkVrwdmsNovs63k6GrVSQVnHU9szoTRLhkI?=
 =?us-ascii?Q?aVNQfymnX+n10p7WdQK9C33dMxCiDvJc4iwO5vbyFQdWGkKs+v3Bba46K4sL?=
 =?us-ascii?Q?Oa2QUHKXQ7rWOhFjklq1OW3qebjzvSb+EXWzuiLQJxJ4ShCB9GZJlD2ce/ct?=
 =?us-ascii?Q?1u/NBR510Ad8HTyJ01ZGNvFONljq76E4OBhpMsjez37A3yEr4O4/PtpA5+iw?=
 =?us-ascii?Q?4xeDB8Wwc0YCkW9q3sN5i0/ceO0wSKFwQQmb1vZ8mTgFchMFJ/SIqRORTETt?=
 =?us-ascii?Q?IDs48kjURwnzZgSLuOKMOpEgPVNG+rp77U3CB7uEmf5ynv0Yr+AmlZmeyAWD?=
 =?us-ascii?Q?12KydzqsSPds5Y7o1zhAz4DkvPNO9CUH0pwK4lJJMFkSLUdBQIk85ciXVaBY?=
 =?us-ascii?Q?QpxzNS5zk2dbSxgUr2O9W24VDMU8lFhMLwpT4+kjZs9d05DgInK0r5dx2HpA?=
 =?us-ascii?Q?PirCOwB8XE6dTtiE/mnTk8MBZ2rRt/jq8UWIyZUgwxBULTM5Uu3GFn5XAxfj?=
 =?us-ascii?Q?oS2lOrD52Mqd7LX7TmvC2pErGqvjs4T5RlBa55jJVSfKsq8dWr83jkTLmVjp?=
 =?us-ascii?Q?K57Oh8dX6J8X0ophEtVGW0bhzfF4/47uVKNjwqmYkP24Dc2v14tUjlSObZML?=
 =?us-ascii?Q?WDcX47JdOliLxzHcSAd+T7+ydJImn/GGddh/hRlaJ6VY425qpR1D24VQN7V6?=
 =?us-ascii?Q?vLtQ/q+lFNABXr0sDpKoaIWsx8ec0jY6cIUuCTrEdNkGvfGgD0YZ3WfzZ38s?=
 =?us-ascii?Q?k9djxrHHYYn9fDoGUacI87Yloaqppl6mhSlA2c/ngOuqGZ1wO/zgh5Ir9yFT?=
 =?us-ascii?Q?5jdg+b3wzRNQJO6oioymG2Z2W+gJFNDBwgf90DL6zLefENNZajxpSI2MAsXK?=
 =?us-ascii?Q?J/RjwC9ikmKGrqFb6kcgDP89jdYGIHXD1eMgQFxBkI4FX3XWIJ+kRiHjgKjG?=
 =?us-ascii?Q?5MWafXAxehCTjRBzcEdTGHoS5LCU8jrSLzYHGqd/umgljYBrcudzOC03xDZS?=
 =?us-ascii?Q?yNMVq/x+kUWlZ5L/blJ9DJQS/eg0TmQKjwP9vF2gOqe+yxb+h5lVk8OJ/cVo?=
 =?us-ascii?Q?4kxFjniUUFTnpwdbXuqCjOpo+2VM05FrMU9DYNQUZMVYoOQ+wljR2itS1JDX?=
 =?us-ascii?Q?5zsGmEjuDRQECg8tnvbF6aT24B6LQCYlwsVGGA0U1kxBKk124SkNH2zjm3h2?=
 =?us-ascii?Q?xG7eLO3240n2dpNyY3NgOHtX3ChIq+QO7fgK7tEgpEURvj/vzjHhY7IBN5Pb?=
 =?us-ascii?Q?ofCWMoyoOBudgmwDZNg8qCZS8LleZ23mlHZ6209UKz5r/gykk1CgGX+lbfed?=
 =?us-ascii?Q?oRd7aX/lAiZMKGTkTCEWK/CUDy93CunGMAzcmuk1+xfPLAwdVSupFyIE1ZuB?=
 =?us-ascii?Q?rF8U0bqvXG+cf8cVaeWMLnflB1mDaaHyjzyb3ltLJ6SlIvJjP51LFY4F6Bu1?=
 =?us-ascii?Q?Hg9oWIv6BOyF7QgpxwhGV6nqanJL9mBc6l6zKi6W1EVKr5Z+qKFz7lcM2rRy?=
 =?us-ascii?Q?kJqtpDS5xnyfAcu6Dy4ieBpz58wkudU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tWEtQByolzJMNpOkcCrbRYiJXFwtCbTCWq2+XrO4fszqG2WcD9yUH8hF/xzcY/mwgJmf+qYuA1N5LnJJ0qN3y8qAqr3cVN/UVEKL1sg2Vf6++oZU8IyJNxFNjCu03fKn/4K4vLKUUuae+LB28Hc6wl5oVJiGp9SGGHnyqiTHEmo8Crw2wnd4JXpsvVgCrCsrhZhWIHPx3+kxvOWd345LMxZdixPv0WPTnofoOBdbFbSqzaW/92WkHE0gbPqsccUm9gww0mAka/Fs9qsMc5kHlxgRgyiUWkUQDb6itO6EAfdfLjIivX8Xkrm1m1NZMqDYcNouC73K7oNLeVyL0QzYZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a422b2-11a5-4eac-e6d1-08df3e4deecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 10:40:54.9616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+rsEGAkt7uA3c/XnbHGq8obaTDXj2WerU3OQrwbyGbBuruQrnYm2WZgfVRLC5PKxZHEuwF06RmW8ULnCUz8CQgPMLpmPfvVf81pVVDuLB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
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
> From: Sasha Neftin <sashaneftin@gmail.com>
> Sent: Sunday, November 8, 2026 3:45 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Sasha Neftin <sashaneftin@gmail.com>
> Subject: [PATCH iwl-next v1 1/2] igc: remove unused extended wakeup
> filter definitions
>=20
> Remove unused IGC_WUFC_EXT_FLX9 through IGC_WUFC_EXT_FLX31 bitmask
> definitions from igc_defines.h. These extended flexible wakeup filter
> bits are not utilized by the driver.
>=20
> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 30 --------------------
>  1 file changed, 30 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h
> b/drivers/net/ethernet/intel/igc/igc_defines.h
> index ab55b88d4d96..369aaccbd24e 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -26,13 +26,6 @@
>  #define IGC_WUFC_BC		0x00000010 /* Broadcast Wakeup Enable */
>  #define IGC_WUFC_FLEX_HQ	BIT(14)	   /* Flex Filters Host
> Queuing */
>  #define IGC_WUFC_FLX0		BIT(16)	   /* Flexible Filter
> 0 Enable */
> -#define IGC_WUFC_FLX1		BIT(17)	   /* Flexible Filter
> 1 Enable */
> -#define IGC_WUFC_FLX2		BIT(18)	   /* Flexible Filter
> 2 Enable */
> -#define IGC_WUFC_FLX3		BIT(19)	   /* Flexible Filter
> 3 Enable */
> -#define IGC_WUFC_FLX4		BIT(20)	   /* Flexible Filter
> 4 Enable */
> -#define IGC_WUFC_FLX5		BIT(21)	   /* Flexible Filter
> 5 Enable */
> -#define IGC_WUFC_FLX6		BIT(22)	   /* Flexible Filter
> 6 Enable */
> -#define IGC_WUFC_FLX7		BIT(23)	   /* Flexible Filter
> 7 Enable */
>=20
>  #define IGC_WUFC_FILTER_MASK GENMASK(23, 14)
>=20
> @@ -61,29 +54,6 @@
>=20
>  /* Wakeup Filter Control Extended */
>  #define IGC_WUFC_EXT_FLX8	BIT(8)	/* Flexible Filter 8 Enable */
> -#define IGC_WUFC_EXT_FLX9	BIT(9)	/* Flexible Filter 9 Enable */
> -#define IGC_WUFC_EXT_FLX10	BIT(10)	/* Flexible Filter 10 Enable
> */
> -#define IGC_WUFC_EXT_FLX11	BIT(11)	/* Flexible Filter 11 Enable
> */
> -#define IGC_WUFC_EXT_FLX12	BIT(12)	/* Flexible Filter 12 Enable
> */
> -#define IGC_WUFC_EXT_FLX13	BIT(13)	/* Flexible Filter 13 Enable
> */
> -#define IGC_WUFC_EXT_FLX14	BIT(14)	/* Flexible Filter 14 Enable
> */
> -#define IGC_WUFC_EXT_FLX15	BIT(15)	/* Flexible Filter 15 Enable
> */
> -#define IGC_WUFC_EXT_FLX16	BIT(16)	/* Flexible Filter 16 Enable
> */
> -#define IGC_WUFC_EXT_FLX17	BIT(17)	/* Flexible Filter 17 Enable
> */
> -#define IGC_WUFC_EXT_FLX18	BIT(18)	/* Flexible Filter 18 Enable
> */
> -#define IGC_WUFC_EXT_FLX19	BIT(19)	/* Flexible Filter 19 Enable
> */
> -#define IGC_WUFC_EXT_FLX20	BIT(20)	/* Flexible Filter 20 Enable
> */
> -#define IGC_WUFC_EXT_FLX21	BIT(21)	/* Flexible Filter 21 Enable
> */
> -#define IGC_WUFC_EXT_FLX22	BIT(22)	/* Flexible Filter 22 Enable
> */
> -#define IGC_WUFC_EXT_FLX23	BIT(23)	/* Flexible Filter 23 Enable
> */
> -#define IGC_WUFC_EXT_FLX24	BIT(24)	/* Flexible Filter 24 Enable
> */
> -#define IGC_WUFC_EXT_FLX25	BIT(25)	/* Flexible Filter 25 Enable
> */
> -#define IGC_WUFC_EXT_FLX26	BIT(26)	/* Flexible Filter 26 Enable
> */
> -#define IGC_WUFC_EXT_FLX27	BIT(27)	/* Flexible Filter 27 Enable
> */
> -#define IGC_WUFC_EXT_FLX28	BIT(28)	/* Flexible Filter 28 Enable
> */
> -#define IGC_WUFC_EXT_FLX29	BIT(29)	/* Flexible Filter 29 Enable
> */
> -#define IGC_WUFC_EXT_FLX30	BIT(30)	/* Flexible Filter 30 Enable
> */
> -#define IGC_WUFC_EXT_FLX31	BIT(31)	/* Flexible Filter 31 Enable
> */
>=20
>  #define IGC_WUFC_EXT_FILTER_MASK GENMASK(31, 8)
>=20
> --
> 2.47.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

