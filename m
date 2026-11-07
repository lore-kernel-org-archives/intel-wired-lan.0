Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC1606D806
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=bc4p+uIG;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QywbwYor
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8DC3406A1;
	Sat,  7 Nov 2026 16:02:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xvTSxD3_Aq3M; Sat,  7 Nov 2026 16:02:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2067F406AF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794067351;
	b=l5U54kI1UoOT9DnRRlEr0HiJCV1BoGKYsNibZeSxz51RzPBI3nXXUSaIpjM9qjlfyzIT
	 zPUvPbcfIJMw/uMworjiTWaoArZJ9qLeNBVR94n0w7wsOJmeHbEsR5GSBfw+6LrBh6b3g
	 lBJpModOI+SHSieiST7c2QvzCtipeu6ZMi68TC9PD9p2yIMI1qCP8ECJlK9lnqJR12+1F
	 mIQfbGHIitpaph54zIxdTyKe78fmGsfxrwek7MJSMl+91H3iLci5OukS4gO70bn0Hotxv
	 omQPYwINGQA3OB+9ULsVLSkV9+kWNLX7+gM58NOtins4LGdMF3au0mVMg/9y2/kWzeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794067351;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I+TzRr62auSLtrW/7L4sguiqEguVL6062SI6TD/pU2g=;
	b=XhqHPXdLunW0HSGJg8r+x7X4C8mWNvVdvQhYjy8TSl5O3GwfnAZYlGBYEOKc3VLfUk9r
	 el98baS4WJrjW67WYOqhNxof5nUW3Y7Wfze7iwXn1IYiidxSKOqZcO/NzZPC7U2HAmbc7
	 y0Y9L3iLGolyp8sBxvAE4LuNohTTGuzfrEgBVzO6yBHCucdIu09GJ8ZcdtqZjwuecQM0S
	 LmMCVaqhAk5ZJyY+V3V9meMrr5uRbbh2RqQmtFBgV/R3u6Lx5xUzVxrVFWPjq2zl8HtFT
	 CbJI24ueFaaxXRd6B/x1bq2v02MMas5DtJ/4MLvezNx7epv8DdkwJncV2KAB4zPfTlA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QywbwYor;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794067351;
	bh=I+TzRr62auSLtrW/7L4sguiqEguVL6062SI6TD/pU2g=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bc4p+uIGZr9TZ08aFP/Vrpb7YUgDqmv4+eWyLbEocykpccuqq8hUBo5POgYUBjTWk
	 1n9u2t9VKJEbF4WEXYoViwiEX/CFXIwdhnh9qDmvjCz30jJbvbpT6ULJmHVxPF+0XD
	 OcQvpMkbasaShIodw0VyWNdASe+4Kw2ts1h1GvxzicV+If7oX7MhSRj1MhZwDNzCxc
	 4CDNSixFwo/c5otybDooUNy4c6+poj+n+ZwuMwsnL90BOvqHQDgc0wzQTb6kXcqMDg
	 gmB61zYkcrkXclKUAQ3dni5d7vXosaKPirK7ILjC+GTXjIHpRrAvI2/haNrUZfud1Z
	 YaNCW9g7LkQrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2067F406AF;
	Sat,  7 Nov 2026 16:02:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64EE837D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 16:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A44A406AF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 16:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vjphP5goGrtr for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 16:02:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E9A4406A1
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QywbwYor
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E9A4406A1
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794067349; x=1825603349;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RO4dGz2S/p36K1MB52+rvnUbriIK4gNT+XoPDYDw0Ds=;
 b=QywbwYor83/vthfvApc2lmN8kuuZXF+nyd74R6IpPxyOIKvlNkPChmhH
 vWOMFZoVh7o3qp8rap7oIc2I54oQlq3e2iBXzJATbXOqakBlAejImME5e
 h60fvO5sDabgpBkab6OS+JHQh21Aavd++wcDGSs88vKzPMbfr8oSWoOuR
 fooN32taMD/INGoBxC1y8MNHjJ6Gac90dt3CNgU8RFj1gmkRM1FcM4UGE
 DPyGu85xggX2VtyMjMtN1JRnnisekjieiTblBDQ1rVNbj6TDTH9SDRmPM
 YfWJgMYhX5VzAL+b940kCNdQDDXduobRwyRuVDr6GKKKazxrP7Tm3O2+z Q==;
X-CSE-ConnectionGUID: JP//kceiRvW6ug4b9zpuqA==
X-CSE-MsgGUID: egPFaQ5kQISG3fe9kuo+mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2886626"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2886626"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 08:02:28 -0800
X-CSE-ConnectionGUID: m4xHYlr6THig89LFY80qUA==
X-CSE-MsgGUID: VYCJSvl7T6WBwuRSxjELgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7339652"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 08:02:27 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 7 Nov 2026 08:02:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sat, 7 Nov 2026 08:02:00 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 7 Nov 2026 08:01:07 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SA1PR11MB9849.namprd11.prod.outlook.com
 (2603:10b6:806:4d7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sat, 7 Nov
 2026 16:01:04 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 16:01:04 +0000
Date: Sat, 7 Nov 2026 17:00:48 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <tkusters@aweta.nl>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Sven
 Auhagen <sven.auhagen@voleatech.de>, Richard Cochran
 <richardcochran@gmail.com>, "Kurt Kanzenbach" <kurt@linutronix.de>, Sriram
 Yagnaraman <sriram.yagnaraman@ericsson.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Paul Moses
 <p@1g4.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v5 4/4] igb: drop AF_XDP zero-copy frames that span
 several Rx buffers
Message-ID: <au9LMP75WIgIQnub@boxer>
References: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
 <20261104-igb-rx-ts-fix-v5-4-bf4b4367129a@aweta.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104-igb-rx-ts-fix-v5-4-bf4b4367129a@aweta.nl>
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SA1PR11MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfeffe3-a7a9-43a2-364d-08df3ce853ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|22082099003|6133799003|10067099003|18002099003|261102123227099003|56012099006|261021121427099003|261022075727099003|4143699003|261026140227099003|11063799006|261028144727099003|261009223027099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: uP0RSxuTFXG4aFkuXnJzULVvhPhXb4QqVHZBEWlck8W+LJDiV2drvju+z+5AlbAHu9CZtRl14ifeO7s/WHSBOyokPTNfnvyQwcdL5n5/naXkq/m5YKfa4oaTtx675/iyLVZEKuQkllN5YEii1AahuuKFbyJ8K4THDbFYFgk+xgJMnrJB0F/yrcIYJBKAZ6p48bBYrV3DRv7bqxwr/dT/3JrZNZ0mIEK8hDlDRWzQ9L8aYP5xraHMmbdzZZ8faPq/Leao/MiCXuvocv57GonlyV/LDdkkJAOjHwOYGt2M68JiyY9grsV5LHifju+6/lk/lnuzR0tK3hMb93Wxk7YVFEWM90LatObpXS0F6oVhkDYcQLCgHibbt8z+RczjqjO8nUjLNDMd9kihQcGxKvJHgXYG9Ta6JTSJ6hHTHF0Xvhw8PsACHSgy72IdI6VSCFTssT7mM+JERqLaC7xH3Ds34fH9y0VIBN6ZAtsUnMJpVe8L9PwFguZumuEni1BB7WZRBu6pFA7XnXbI+eQzGpa5Io9lHjHBdgWwxqdzSJ6K6Kt7GMnF917BirhSfLFMZJJcT8Slz39Kj7kjPDgAJ4v2wKTQMo1zUjEd02lG7Wx0eu6/tRLyPpK1wswiVT/wwrTkLFd3C5LnZ82zkn/9PPWQjzwmQl4SUUrOU9M/RBi6O3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(22082099003)(6133799003)(10067099003)(18002099003)(261102123227099003)(56012099006)(261021121427099003)(261022075727099003)(4143699003)(261026140227099003)(11063799006)(261028144727099003)(261009223027099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UifS/RIohtCdf6wqkSroGnPDvwfJplbPli165RnlAKM8Y24iBx0JT8g1Mcz8?=
 =?us-ascii?Q?lVzTx8idW9UGLEryglYA7ty8TEC66ypS8uvTN4PPeZCxd9HP0fGYjc032oQT?=
 =?us-ascii?Q?SIHszjWON4e8a4gE2zq2oPjAOJCHx8HI3lg2hutHBpCipLtwhCFLXTFvcJDE?=
 =?us-ascii?Q?04+U/zvuXs/fGGvrnLMlAtMpCPkfUt31HEz6Fn3qQLeiAsEZnTMbjSnpcvXJ?=
 =?us-ascii?Q?KqLLlcYohgF6jxoadloByRwo+DUJhbQVlFWpA6HzMMJoIZ7pS/wftSrMa29d?=
 =?us-ascii?Q?4Dj29apVRiMVdFfaz+hulhXAxYxcB9+7UW3afWCPlyqFSZ1USKlnxaDwEk7D?=
 =?us-ascii?Q?3EgqnZqf4L3ZS8yaPxhUG5FJ+Mr7ra1H32zWGOnXlpnsIR7hJ0fYsT5ohLWz?=
 =?us-ascii?Q?TF+z0RBtrE9vQwxIrGeELyxG9zYVA5jIDPk/nrgi4j3nLdDgZpV+YGZiXT4u?=
 =?us-ascii?Q?NekJixPFnnVNSXLMo3MH+55TvpNOqeaFo1KLLGjH1oHFi3oSj/o8PwMEdNby?=
 =?us-ascii?Q?rtiRF01i9o+qLPvsd+riDPRpIOyqg5qSsHXpWNkHTqTb5Z+oetTZkCo2IOnM?=
 =?us-ascii?Q?ETuD6ItwDy27T33aKh0xdGQWJx1k9/yGIDHK6h6cvxU4cfjDChwyugYK6HwX?=
 =?us-ascii?Q?NTVgOB4o1cg1cZ6+aHrywLLgIM32CyvtvpAyxCMa37jnjE5ukM3hH/lIuKjo?=
 =?us-ascii?Q?7nosUnaQJhMRAVv6W0NLmwxqZebygz++eCo/tLEMbwNkGR2asWWvR4yD2mA4?=
 =?us-ascii?Q?z5EXfGAEAk2KwxWInngTrRNhQ9+1Z4gCwjBT8rzjr+6zBBK12YBZaf9as5+E?=
 =?us-ascii?Q?d9gzltr+6OhBmVLIlGAe4mU4G4fbqBvsO9kYRG4O195XUuKV6ghwk7k1BiSx?=
 =?us-ascii?Q?jCIFluvHX9js07l0r5e21ugCDrbVTTaPQ3IJP2Gt6L6amqBrK4hHearf+RD1?=
 =?us-ascii?Q?NFw3cz66COaDJIIkTWPc4SkJN0XqSzDcaNRxHdLdHaOh8n2rj95bXZ8d6Dec?=
 =?us-ascii?Q?KZxKvFuyf5FcQziWmbMDzhweouxkUrKVuBnE4WJpWzQc1b26Qy/GSCIR+IFr?=
 =?us-ascii?Q?1dQwNuL7tyuBTYn8ChZqBNxR9FyFqGPAV1FP6m95EtggEdJpOXYiqjn6KBhF?=
 =?us-ascii?Q?SoGNjAmoHLWkhB4crl05KjktdrGHkPKUypUp5j3sPoFg7Se3FXhd69VtYwA2?=
 =?us-ascii?Q?ewkR7XB1j1F/b6u4rO8wZ/PKo/SWjGat4K1ux79UI1MieItjPdhTHAssiqYF?=
 =?us-ascii?Q?v+ci7hThCdWfxOF8AKowGAIbCQACUoAp9Sv0O7QXoZaqDyp5+npIL4qenEM+?=
 =?us-ascii?Q?ys0A8TK5LD0yT3FjLFD+tkjjW8kBkp8BIuQoF3OQDTdP7zFb5rIIFe0/8L6p?=
 =?us-ascii?Q?AeSg4wFh1QOCkQrextrOOQdUuYc168lo9C/2RHsPtrUSfLvfUIxZBAP/9Fop?=
 =?us-ascii?Q?IQf5kgoztTQujLm9umQJetxRywrPJmjqyR+0uDSebvONjGfLHcvjD2RXRiA7?=
 =?us-ascii?Q?Yc3sOGSlo1Okc3Kx/5p+E33zlrwvR5XnBggSWJy+jQkYi60wqV5WXHXOtsjP?=
 =?us-ascii?Q?qqnS7y3V2nTD0gc/2sxClnhOpvS7mlDXQ0RmpGN9vFUhEQSvVndEz0yAkMMa?=
 =?us-ascii?Q?tITPCGmSlUtzE3fobtlZXRzy005T/chagOHIiQmuUAWsVqje/wmCnXx+AOeH?=
 =?us-ascii?Q?7zeNaqY9ZaPpCUL1+cFN5Ylt46QPvrf9S/n8rQNrFHiSwQsAp16zf/++d3im?=
 =?us-ascii?Q?xEQzSkkrP/Ge/LvOjrPTop8YY7oPqUM=3D?=
X-Exchange-RoutingPolicyChecked: kqB8tKkWUcnFvvRHJrclcFcbAjOxQlQdZ+CmrDRgS/OrnYLViHTJJkutwxJ/+hjIVq62L/Q5QF5eFSN7o4ovfsyLyvIW+AFaiDC0xpDvg79HAxpFn+ClAjocz3/HXcP8asbP7gQ2TbCphZBgTCPD8lNklDuK3c/zubaAoG3nuqx19WhcDSk2QU8h4wRQlDNb4ATVKbhT2B50nM9L74aS+vjBiiDHnVilB/3y+VbnNW5q3q+owRYQp7x5KHNCXUBziQIdI781h1LZJZ5sM75mIhsZyfKaSvEG2f2RN5BELXKnBBuN2giwZywEAPEEc7uYBQUU5RfLwP52kDt1MFlFuA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfeffe3-a7a9-43a2-364d-08df3ce853ce
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 16:01:04.6831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICfM1+/JxE47hU8kjakjnvA7Mepif1JXEHdegALzrdo+P7529JjzPh3JwxubBOpJz5Va2icBVy2gs96/uKzEcBOw3MidYlwGejZBN6xfmLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9849
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

On Wed, Nov 04, 2026 at 07:40:05AM +0100, Tjerk Kusters via B4 Relay wrote:
> From: Tjerk Kusters <tkusters@aweta.nl>
> 
> igb_clean_rx_irq_zc() handles every descriptor as a complete frame and
> strips the inline Rx timestamp header from each of them. If a frame
> spans several descriptors, the AF_XDP socket gets its later buffers as
> separate packets without headers. If such a buffer is shorter than the
> header, the size wraps and the XDP program sees data past data_end. On
> XDP_PASS, igb_construct_skb_zc() then fails to allocate an skb, and the
> queue can stall on that descriptor.
> 
> The previous patches make sure that frames fit in one buffer while XDP
> is attached. As ixgbe does, also drop any frame that still spans several
> descriptors instead of passing its buffers on: free the buffers without
> EOP, and the EOP buffer that ends such a frame. The state is kept in a
> ring flag, as a frame can be split over two NAPI polls.
> 
> This depends on the previous patch. Without it, every full-size frame
> on 2 KiB chunks spans two buffers and would be dropped.
> 
> Not reproduced on hardware, as with the previous patches the I350 no
> longer splits frames in zero-copy mode.

I am missing the point of this patch then. Are you adding a dead code to
hot path?

ixgbe was probably problematic to address all supported hw (i think 82599
has no per-q registers and would need different treatment on config side?)
that's why it was chosen to carry the discard logic.

But here if you specifically are addressing the config side of things on
igb I am having a hard time to understand the purpose of this patch.

> 
> Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
> ---
>  drivers/net/ethernet/intel/igb/igb.h     |  1 +
>  drivers/net/ethernet/intel/igb/igb_xsk.c | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 0495c02544d6..6613ea0eedb8 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -393,6 +393,7 @@ enum e1000_ring_flags_t {
>  	IGB_RING_FLAG_TX_DETECT_HANG,
>  	IGB_RING_FLAG_TX_DISABLED,
>  	IGB_RING_FLAG_RX_ALLOC_FAILED,
> +	IGB_RING_FLAG_RX_XSK_DISCARD,
>  };
>  
>  #define ring_uses_large_buffer(ring) \
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index fb04df82272a..7b098069fff2 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -269,6 +269,8 @@ void igb_clean_rx_ring_zc(struct igb_ring *rx_ring)
>  	u16 ntc = rx_ring->next_to_clean;
>  	u16 ntu = rx_ring->next_to_use;
>  
> +	clear_bit(IGB_RING_FLAG_RX_XSK_DISCARD, &rx_ring->flags);
> +
>  	while (ntc != ntu) {
>  		struct xdp_buff *xdp = rx_ring->rx_buffer_info_zc[ntc];
>  
> @@ -390,6 +392,27 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
>  		dma_rmb();
>  
>  		xdp = rx_ring->rx_buffer_info_zc[ntc];
> +
> +		/* A frame should never span several buffers here, see
> +		 * igb_xsk_frame_fits(). If one does, drop all its buffers.
> +		 */
> +		if (unlikely(!igb_test_staterr(rx_desc, E1000_RXD_STAT_EOP) ||
> +			     test_bit(IGB_RING_FLAG_RX_XSK_DISCARD,
> +				      &rx_ring->flags))) {
> +			if (igb_test_staterr(rx_desc, E1000_RXD_STAT_EOP))
> +				clear_bit(IGB_RING_FLAG_RX_XSK_DISCARD,
> +					  &rx_ring->flags);
> +			else
> +				set_bit(IGB_RING_FLAG_RX_XSK_DISCARD,
> +					&rx_ring->flags);
> +
> +			xsk_buff_free(xdp);
> +			ntc++;
> +			if (ntc == rx_ring->count)
> +				ntc = 0;
> +			continue;
> +		}
> +
>  		xsk_buff_set_size(xdp, size);
>  		xsk_buff_dma_sync_for_cpu(xdp);
>  
> 
> -- 
> 2.27.0
> 
> 
