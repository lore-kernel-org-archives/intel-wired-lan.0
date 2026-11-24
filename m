Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66248606A31E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=L2nrUCIl;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bmTXph7k;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=N1lQID5e
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D91180C10;
	Tue, 24 Nov 2026 14:48:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eUibWR2oPSUc; Tue, 24 Nov 2026 14:48:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D693080BDD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795531714;
	b=aDETdnukE0/vg31LnFReC+9uvay1MY6m7Y9TpEy3svyjkss+Izulx7IMGHgGftbTWSOP
	 daaljlMlTNxDLoqR+QZAi47zGJdqtRGx84RlLdxZYKdCYn4XUOn+wKTLJctwLCMUnX+so
	 3vOMzx/WDf5lTgjrclRFkHg2+tMDIQ0vuCVbNXuoBvWb7okYZQgj8Jn3LCwuB/fMkxcyA
	 bereiRlM5l6CunasD2ZUbzS24XT5Br4uq3ouNBAFLXYGCiXCAXtNS9MEA8a6B6ABYwNro
	 ErSa+g0q3qSuabUod0Y8UoHmijQXUUh2YIQ335JNQvvVnHL9FBLOpMZxRWEOkpYf2lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795531714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=gdMTPUehxHpFXUNfoj4mQEvreoVTguY/+Mcq/NUf1RU=;
	b=paMZ0F5//vG9B/Zy2JovTc8l1jlb8afM9vigAIu/KXgI4dG2EYyys9Jl4RuOhF/A+kHl
	 NESh0bL25qz/1z9JsOWGGrSYP2wnOUKBqa6HE9p+Oz1GolOTejqvUJXqtQbdQ/aJJkmBJ
	 8j2xpzalPQjrreK2909b9AayakJ998LcNd7yXWVtssgEz543R1FBvWCJJtAPI4/7oNPK2
	 o7o7S/R/iE9/L+AM0mn8HwGRKO57q9c2bKwHA8x1UixpzuSEIScQtWkfQ/7qGAUHv+WV4
	 18KqtvwNMkIWfNgC+7HIxRwOdJBx/NpRvCR9hKx9UAkwjS6j/iuBaphE6YLtBWMr9eQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795531714;
	bh=gdMTPUehxHpFXUNfoj4mQEvreoVTguY/+Mcq/NUf1RU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L2nrUCIlPih8NNVXwGZXP5u3UvFlSGes5xZhezVcwTptV5/6zyHYcpsyWbPEa55mI
	 1gIPV2i/jiV+hDp9yV2905kE6jL5IjmiXF07NdI/lQPuzC/e1Wix1YeBfyQ61It8zq
	 S0kAeMFEFxEOD4GerG+2HtnNI0xOYScxuduzViCoDCdL1nGoKIXW6NmuCfmniRMtYM
	 D/OkdADXqYmZ5j0oGf9ON+naLmvAJ9hiCp4XA6J+JvXPeSahrmpvaGroVE4P6TYm1I
	 kJ5pfLJHOgNsHbFAA9hB9VRpyQdiEppmhuqP2HgrzTAxBbOMe4hdo6J7tNIIheK3yR
	 WWV08TKutEe6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D693080BDD;
	Tue, 24 Nov 2026 14:48:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A6F7079D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 14:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F9C1405BD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 14:48:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jDuBbmTcVZe8 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 14:48:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 08D8C405AC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bmTXph7k; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=N1lQID5e
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08D8C405AC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 14:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795531712; x=1827067712;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rdGnCDvEwB15UdUe+HUXFUBTLR+P7QcbyA3JfKVp1dk=;
 b=bmTXph7k7M8LKXztkgpGI31OYKJZ3xhRjCJDr38AxPptaFch6eXP7qX0
 4sPI+xisUcnhJvE5OEk1VUg0LAP1FkIUHJ+XS9rXIhjqUrMRaEO9SxGgK
 vw/wWk4cXCMiDHmiFWG3H50l4nHvsQ7VJrg9mb2EInrqJ1SWoCZL7qKAT
 4hcNZidumjyp8PW1M7mls06biXTxdquEQcAmSsTTpoSH2wI3fI/hZvy31
 J8GGsPPepwkjDCnkDjRlKoejP/Y9I8CyY/SA3bi085rnZ56G7BhI2DzGQ
 89pEE2rFyQwdqKn9H/ufnY+JEWKlke0+8xyuhx+k3cpNUWJWP3NGVl+sW A==;
X-CSE-ConnectionGUID: G9/GEco6QqyXclUToYdGpA==
X-CSE-MsgGUID: zKtFFXfiTD+FLz1kZQeEIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4424897"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4424897"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 06:33:08 -0800
X-CSE-ConnectionGUID: IfnjQw7hRGez1OrAQi0jZQ==
X-CSE-MsgGUID: sxS0f5pBTf69JuPDSkSCIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11932697"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 06:33:08 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:33:07 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 06:33:07 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:33:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdMTPUehxHpFXUNfoj4mQEvreoVTguY/+Mcq/NUf1RU=;
 b=N1lQID5ecpPoITNLgT+EmBioxLQmSK+Ocmxr8g1nveymOh3aVR8AkZJv8PLO1o0sbtMPzt5N5TZ3kS/JD6PLpCLViK2/b6PVTt26VySBgf6pakXLWze8pwsjoEuo3LNdkkVbfoxhj0ezc7u+eJcURfpCzQhvaJhNWaSSQZAkQ2k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by MW4PR11MB5890.namprd11.prod.outlook.com
 (2603:10b6:303:188::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:31:04 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 14:31:04 +0000
Date: Tue, 24 Nov 2026 15:30:58 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: "Karlsson, Magnus" <magnus.karlsson@intel.com>,
 "magnus.karlsson@gmail.com" <magnus.karlsson@gmail.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: account for XDP_TX buffers when cleaning
 a Tx ring
Message-ID: <awWfolL1o5YEn2TM@boxer>
References: <20261124132942.1102882-1-magnus.karlsson@intel.com>
 <CH3PR11MB566895E95586F94B282D5AFEE9E5442@CH3PR11MB566895.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR11MB566895E95586F94B282D5AFEE9E5442@CH3PR11MB566895.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB8P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::33) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|MW4PR11MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: f0143888-5087-4f4e-909c-08df4a3791da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|4143699003|11063799006|261009223027099003|5023799004|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261022075727099003|261026140227099003|261022115727099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: Uv9vNlDBFV7wbzgyKN4dzEmQCPtoJBuhbEr3wgOf+Uf96ncknq1EW3bQE6WsgMYszekJEZUoA8EqVh4TOh6NXcd12fWKD0Bxw1Lx+QDccMD/SZ0yQuwKPc7WiKaxSIxs4eXut5LdkBISpjyek3Dbco9v8C1pZh95GHZGCTJp8jtxb1IeCYmCkOz5CxbkCTsLisVK0vhO/oOKZRUxkGKHoDLKc8FpIoKWxxokkQscwncA72FFLdEqtwDbSL4ljTz7jQ7344XRzp16h5GiXohIlvnHNyAxytUNaDN0aB+9OkoirriF0t44dmi6zxNLiBZ+D5urAv9MuF+9Cjf3haesKT0SEl1OAXbpZF1Qur6ximRNhAsR0r/l0OHHwWhKjcK2nQHwMFcFct/yB+ZXM4XcNKIlrDV/ViDqP1MaOY/c/DVFkzWcXOhuf4Z+bsBrx41ECrXnwpgQvE6ACdF8RcILevT+pbzjAUEV85CwdKqYDHbZKuuUsGcbkGPeyGEgH8OisoMtzzQktPboKAUvmX2CY7y4YYgl1bQgAaJOEB9Hfn5ijoNG9AG4xQGuerhcK83O6nUW5cV2ZdhJgLoCNJtl2aSp2vihc1w1yQS5BQctTJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(5023799004)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003)(261022115727099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQf/Bztv0vPzZCbUpUyKLR/YyualrQxRtlA2Jv/pAIf+f80gGsW6fV4zcUkH?=
 =?us-ascii?Q?8z0oiE8by0HUoWjUraIf5zQA3gRi9xg0tjI3AMd3UvORQfS3c/GYnJQupljE?=
 =?us-ascii?Q?1xbk6HAiw+c3Wpx66B6eZyQS6U8kA6UkCwLc4PJiMN801f2VzMMjKpIbCRo1?=
 =?us-ascii?Q?4GnftiqfYJHu6HL4Dda5zsqV4IMJoc0hUJhP3aXmhpAQFSvJkOP4Yweu6DvO?=
 =?us-ascii?Q?3PL1YWlnVM+lmNtS5KYY6UBluZUvTAFA4tFUaBUHroMJD1zZx9scY4EuJbFJ?=
 =?us-ascii?Q?VBm5+cot8qxn26kBP8YCCEB3VQCkBPiyx3So32oIMMulN3CKZ4ez6Z6LTjUl?=
 =?us-ascii?Q?OzQYToOXRS7j2vv/4idYSaNiG7AYxWXaMEr3nNOUUYmKOOZzH8iHVhLeduZU?=
 =?us-ascii?Q?FTmc2Yt1IPNvEKpeq+q9zUbMtt+3iTwQ4PISbdi629tjZQLzD8o/ZD5/deKP?=
 =?us-ascii?Q?drimfmGTA8Cu8zK0cYBfIjv1qmZFfEG2a/xlbtL3W2sbiPBDNaF0BcVUAbar?=
 =?us-ascii?Q?SFrLkQwIQxOuziKbSKOSYH2mL/ASDLMgyvZT68bX2wW8xxRHyMynVYAjLdL3?=
 =?us-ascii?Q?m2hG7aUvVNn4i7dr2kpfN3XTsUF8Usgv1VqLC5dMFBWOcvPOpkXV4rdqz8W9?=
 =?us-ascii?Q?DLE8tKBC2p2kvBQDLYzPbErGZtwJK0PSQN9ChO2lhtuoeoCVuNaApEH2CZ50?=
 =?us-ascii?Q?VQBKojBmkuCtoPk4A2l+qu94TcKhSuYE3pv+oR7SJ1Le1G85smbVtrnjKh5x?=
 =?us-ascii?Q?lzeyFnDI6Cj1mYW3QmXyq1NfpcJWjAKcENrjLTIR8yF81+JhxP7gI8l55/SF?=
 =?us-ascii?Q?jumKQfjhYyAb6Aw3+aXoN5WSpQIVX3JOIr3fEv2ihdBOMi5X/Qns7+sXMBQU?=
 =?us-ascii?Q?F7jw2Qfrr6rXG9OxnCYiTBV3As/rv1lQ2T5Jd5UgxbfucYYVmu/uupEmkjL7?=
 =?us-ascii?Q?J/8LUtTDiLGTZ9f3elTX7m09IATWTgnAllArGFSs5VeBxSfOBq8PU/suUdS+?=
 =?us-ascii?Q?k7jqAQnUzOjRGFPkkoqOksUJsSxhGoSN0IgHAo6zLT1MaC2I3Jtq8j6Fsume?=
 =?us-ascii?Q?B6wj3/InAUUMXjKb9V/GMbcUClPVYJsl92Vqhg/JvLcpZTtQ8asMllcg4hvg?=
 =?us-ascii?Q?AhwTliNbeBXieLw7eaPX4nnYANHgTK7kxdD/S7ofiLzKipna48jfNOP2K4DZ?=
 =?us-ascii?Q?NPFI+mAYSzee6+gGPP6WmN1k71+O2l8f4wacrp9esNjeRYHMwj/r9wjsnxvM?=
 =?us-ascii?Q?Aw8jGoH1Uw7ZPGpYPkWlcm/4tH3oBxhHqe5B6y2cAp4riuGjJUkhD8F3xWab?=
 =?us-ascii?Q?VkUBWFB+U9kI6yzrUkjbbmyfBeGof0vWsMMvEnbs991IEYj2I1qIVmGsRpZa?=
 =?us-ascii?Q?1Z/4yhKQMN6QAYIX0ReNDqvK8yttCM4KTTADxCEHYdZ8BJzsFQ2xQMAxz4Xo?=
 =?us-ascii?Q?z+6NL4e+fVjd5NMsArYfKY+vflrm4AUSTqxjnwuLMXiRPputu17ASfu1YYw5?=
 =?us-ascii?Q?mdHvW+KwycVezQJL146mSowsuvO3WHkPDS9bCDiN4OmStwYrgGaZCpulMCJH?=
 =?us-ascii?Q?/vzp2KdayM8JJWP2JwVZqarlsmXAPxwc9f8xUHhHpG3qsAwraMn1czeaI2of?=
 =?us-ascii?Q?3b6ximmfe94sdp135r+vRjHQcTyHg7aL3VPEJXUiwW9f/eSAkNklX01H0Sh3?=
 =?us-ascii?Q?THzseU/UsIdau2CYspEpYZXq6DiBYZic5BFiQlB3TmZNI5hCghsTuAXIfWQG?=
 =?us-ascii?Q?gEGQh5M1WS2DpjDm2dGSoOR2qJqhe0E=3D?=
X-Exchange-RoutingPolicyChecked: JCqkWpDwIgHvcFkGSMVilnKirc0tEFmO9Jf3BkyMxxgHAHSGdb+x0CSqOaoiTrp+7/lgA8lpNQINsrhrDrYH4h8HwtBBY26oQ3p+J+qMAyhLrIkgyznTrRDyOnb42ri1HE9ZcylzoHqsM7Oh4QrhFjqo3UHAAX2vvMdKjFIv8abWMGpNzgQ+R4jla27zOSybJkNxyRvFbeIM+sW0Svj+I6Z8e2NC+a9cKa96NGNEhwd8PeTdvOkQBDs2XRlRlGkz88NvH1abyP4DFsGMMhYPmcxXPTSQay7fUTdzK58AIrTFkE5zMZExWSM/QLGyPIFPoT3QtruZ5gUyDvxkxmhPXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f0143888-5087-4f4e-909c-08df4a3791da
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:31:04.1705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DSSo+XCKPSjtfGXSvxCKSCu8Oav+laDdI5uebcpJs8+KRbldEqEu2pmzUGresNA+fC8jUA8E2yz+ckMdZH82uU4iIToLEcxuSPDJT0/XYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5890
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

On Tue, Nov 24, 2026 at 03:19:29PM +0100, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> > Sent: Tuesday, November 24, 2026 2:30 PM
> > To: Karlsson, Magnus <magnus.karlsson@intel.com>;
> > magnus.karlsson@gmail.com; intel-wired-lan@lists.osuosl.org; Nguyen,
> > Anthony L <anthony.l.nguyen@intel.com>; Fijalkowski, Maciej
> > <maciej.fijalkowski@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>
> > Subject: [PATCH iwl-net v2] ice: account for XDP_TX buffers when
> > cleaning a Tx ring
> > 
> > xdp_tx_active counts the XDP_TX buffers on an XDP ring, so that
> > ice_clean_xdp_irq_zc() can complete AF_XDP zero-copy frames in bulk when
> > there are none. ice_clean_tx_ring() frees the buffers that are still on
> > the ring, both through ice_xsk_clean_xdp_ring() and through
> > ice_unmap_and_free_tx_buf(), but leaves the counter as it was.
> > 
> > After a ring is cleaned with XDP_TX frames in flight, for example when
> > an AF_XDP socket is bound or unbound, xdp_tx_active therefore stays non-
> > zero for the lifetime of the ring. ice_clean_xdp_irq_zc() then always
> > takes the per-descriptor slow path.
> > 
> > ice_xsk_clean_xdp_ring() used to decrement the counter for the XDP_TX
> > buffers it freed, through ice_clean_xdp_tx_buf(), until that helper was
> > replaced with a plain xsk_buff_free(). Decrement it again for each
> > XDP_TX buffer it frees. ice_unmap_and_free_tx_buf() frees buffers on
> > regular XDP rings, which count XDP_TX and redirected frames rather than
> > buffers, so reset the counter in ice_clean_tx_ring() as well, so that a
> > zero-copy socket bound afterwards starts from zero.
> > 
> > Fixes: 59e92bfe4df7 ("ice: xsk: Borrow xdp_tx_active logic from i40e")
> > Fixes: a24b4c6e9aab ("ice: xsk: Do not convert to buff to frame for
> 
> Why two fixes? Do you fix two bugs in one commit - better split into patcset.
> One bug makes reproduction more often - mention it in commit message.
> Leave single Fixes: tag per commit please.

There's nothing wrong or unusual with having two fixes tags in single
commit, the fix needs to be atomic so this suggestion is bogus.

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
> > XDP_TX")
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> > v1 -> v2:
> > - Decrement the counter for each freed XDP_TX buffer (Maciej)
> > - v1: https://lore.kernel.org/intel-wired-lan/20261118135952.1063685-1-
> > magnus.karlsson@intel.com/
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx.c | 1 +
> > drivers/net/ethernet/intel/ice/ice_xsk.c  | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > index 35a480a1e172..f26646825a1e 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -228,6 +228,7 @@ void ice_clean_tx_ring(struct ice_tx_ring *tx_ring)
> > 
> >  	tx_ring->next_to_use = 0;
> >  	tx_ring->next_to_clean = 0;
> > +	tx_ring->xdp_tx_active = 0;
> > 
> >  	if (!tx_ring->netdev)
> >  		return;
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index 0c1ce3e86a45..2d9dbdb82cdd 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -942,6 +942,7 @@ void ice_xsk_clean_xdp_ring(struct ice_tx_ring
> > *xdp_ring)
> >  		if (tx_buf->type == ICE_TX_BUF_XSK_TX) {
> >  			tx_buf->type = ICE_TX_BUF_EMPTY;
> >  			xsk_buff_free(tx_buf->xdp);
> > +			xdp_ring->xdp_tx_active--;
> >  		} else {
> >  			xsk_frames++;
> >  		}
> > --
> > 2.38.1
> 
