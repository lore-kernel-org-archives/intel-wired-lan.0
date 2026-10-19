Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B7FCCF2E3
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 14:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E83B140522;
	Mon, 19 Oct 2026 14:35:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 75UrFxImcOev; Mon, 19 Oct 2026 14:35:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 405274052E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792420549;
	b=bSS16/bdzcU/tAG0tiCgivwr9lIufgGe3z8RJ2mdRWU2GeZQY6JZo9L9TLIFHZtQkjnV
	 s9SNPOETnjEsvYdyZDoxNskZF/3hhDSxwTVQQNV8n3kdMPk3iPz1r9Ap3MBIwyMtyuLpk
	 Rs8S+aC7pW9q2w+X232qPPwVAlXBemNKPk4uCEDrdH2nlr6gw5gKrJHiWXkZzV/gktsSU
	 HCD/iHZ9EWIdM0G4zTDfcbMb3zYvA3/ddN68ERwVyesOKLNGBGrVpFW7f3aFkoo4HPsT7
	 nCVonIO1exX/YICh7kl8kRroTN6HKHk3C9j2RYsRg3ZMsqAR2JYwralr03Hl9493+Wg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792420549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=ScaqbNhQpZ5pM3joeaMr/hJqx6T1bZNj+dzLc3ZnJho=;
	b=X5oo1p8H6StmdcKo8S726qWY556VveHGmdeNOukKS/FQZn6FOwPAOP3TKQNX6+LLlj0v
	 hLA7EmkM0E3e22WIwl5xQe26k9DyWjXHMFrUAHXhJMvllDi2d4iTjUmErQ3s6abqiKW7z
	 WJ9jqAv/51/hka+9GESF2YGt4E2ySVRqMquCIGgBDCgH03XX8uC+ngPCEOehtriy12t2f
	 3dybBBCBrfJcip3Z0QOAfMResjy5GYlktY4l5ptSLqhjv0PfHrBOgxFdsnxAUpuXLseUO
	 zwsL1fBN4QDgmfjmGpjv7iw83taU6YqwIbcVWQWiucK7V3xobQmyuYVvpGTFz2c7R8A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NmdXaJFf;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792420549;
	bh=ScaqbNhQpZ5pM3joeaMr/hJqx6T1bZNj+dzLc3ZnJho=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LbzMIk322V1na887GMQOaZVTm6thA0OuV/uc0/Ejr8ZVARSWGwjb5+VrJE+fpjYDL
	 fBm7dR0/2cIsSaLe3kI7fpW64mtTOOJcyN8j+kJENZ8xdPuVKMy7Ai4ikrdpM30JkJ
	 Am5YNtfq9stwSIJBQ/M54BAlwN4xPEgakvf9UUkq2QoTCvS04JPG6kw5IpsWEl7+J0
	 mmlRbqkSCYyuQyG3XUijrKpfJE5geu/cX770V/CSIYyqOBno1Q6+Sv73Fl57yqrzhr
	 mD+9g+UUepJ4BWLNe+HELB2SsPYzIIcRVD2NGt4c/oITKgke58oUFTmAV+fJ8Yu2lL
	 PCty7rK1SsETg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 405274052E;
	Mon, 19 Oct 2026 14:35:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C8AE1AB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 14:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31F0640522
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 14:35:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 24JNhqx7uGPW for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 14:35:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4DFE24052E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792420547;
 b=EQv8a/4JMYrgopFcr1YNpfbh243DYXxDnJmzmfXfHp746ych0f3kz6NWTwB5WHH9wM/0
 OPC5wSGdzskP76qR1/MOxFQIjSnLUM28h/MugxvvUWMHsPfW38Fqkj5e+UPsyi+TWYJJ0
 pgrUHfkpSBRofOC9oChraPAWddkuUpAU0fxWrcxtUhmxxsWob844ACncta0dagh3PsJfF
 B6qVq1j8O6+0PhBLHNhruAJRSgVZLWztflp/Lxpp8fx2YePIfVQAprJu4YQvBTE1qcyMa
 R533sUcoun22f8DknoHNekA3DgeH2AnUOgtKYWVKhF5vCMoBQt+quh4KJbhGqbP2/sA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792420547;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=ScaqbNhQpZ5pM3joeaMr/hJqx6T1bZNj+dzLc3ZnJho=;
 b=Od7Xh0i0UvV0pD02ZX0LdZjJ9Zv0qbAxxDCI6uHyKgQsPbKyn8PRIlSFW5/lhp+Xpqi5
 uRGs2fdP1CatcKHlTSoIMEyYPNP3GzuCd0jttUBxYVaYxSZkCYqGtRZwHLjDpXSxQf9hC
 b96/VVFXblLPCUGP8fewDtNjVTGPU0qKwsVgIAUBNSZpNJ2GPWOJJy10S18hXnZ3ozc60
 TP5NhkQwWs6DV3Nm6RZUuwGJFVmUvEQ3RHGAyYqjFsBTSNhJrGKDDYnaC7AITaKFek7K6
 ITFDD+IMMlmeXtB1z2pitOJky+/FBAt78V0AOSFVVZQBox2tjSzJ9Clog+TvMmk3zdw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NmdXaJFf; 
 arc=fail smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=moriyax.kadosh@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NmdXaJFf
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DFE24052E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792420548; x=1823956548;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nE24YVT3HISL96dcoE0qWuLaIkJWjGo0NQMufdIODPo=;
 b=NmdXaJFfvXxZSaBly2scbdEj9LBFEHXzdbq9SIllgRKZM80BHCC4SBWS
 Lstg77/OdcRmKtZ0M4BZOCxasSunk+OqUF++GD2jAX33aXN06nvN6EwKo
 fU/wJc7K4GDY6q9d4FfNhzwwfxVqSTthCSxbXpY6AvGSAK0SGArbGVPYO
 a94umR+cmzTHHa/sjwDOIgRWqIdWvWHLnHrpgfgbvwjdBkfv0/q8QpAPD
 vVUey1/+/k4mxJXXHsfYUNIcIMtO4hOwFPIVx8pLKBC0smTqXyX0M1neR
 uioJyDek0sV5yiWYjr5R3Jt7Lds3WUj3k2GT6QMubkTsTKG29rsuYXv8A A==;
X-CSE-ConnectionGUID: RUmhAdJhR5CnSUkmwywZlg==
X-CSE-MsgGUID: qxfj9uewSRCEeP+ZG78bVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1141462"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1141462"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 07:35:47 -0700
X-CSE-ConnectionGUID: J0FLDPQoQbatN+DrCOVDNw==
X-CSE-MsgGUID: hYTkMeXSQruIVcy7bYFthg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4389189"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 07:35:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 07:35:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 07:35:45 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 07:35:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6Mo1MtQ88kU9lbaopVKGOQxdvEJNtgbEY1bMORhtlogGgr+msUH/CRkh6bepcBOmGsrZvGqEADLHpF5erXPqFR2fhfy5ckYdWR5S8U/zntj4uYYj5ukCNvtbTkyqvglQXakP8FgkLfYS0imEmPaX3/KivTTsBft+74XvGHiV7jBN46AhAIvEDLG6/ln/6lY+iycyaDoHyV3G7yxH00ljK9o4AdlAW8m+aYJI8SnZ8UB9rf4NXuqdkDiPoSXxl+kdCvk2qsm9c98yGTngKz3lhoORxiKwnfyUKrN6sbq24MsayN2SM1ppJQn0ISrOafReoh+kYmvmEEoBNsfjjD/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScaqbNhQpZ5pM3joeaMr/hJqx6T1bZNj+dzLc3ZnJho=;
 b=QVPj4QKCZHMtTSchczqnkCqnHSLMjamITMXq9fdm6T2871wv4vjK0AUdmIRBkUed6fvk4nhOE2On6JhrKYkJxlprgHWgmvfxd6/LxLrer2dEBZMaqwsLucwM3GbvDSePY6OmYqCqZUoA2CB/fPi74Huc65DVtG4SPQFkIMKehJmzvRZ3kF99+gcrdZQa/MTer7C07LNkBwQMAhE7Wwc24V0Bugd8G1szQTXasnf9btBbUCc+VMuxhhLA/v5hSmTJjb1jhfcAv4wO/RKPKrtoLxS8BxnpSy6FcYg7r3hKL6dMsY91ZvFFRwMxmNm+nh2E9Aad1HfneRru3MSDkQHsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20)
 by DSVPR11MB9555.namprd11.prod.outlook.com (2603:10b6:8:388::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 14:35:43 +0000
Received: from MN2PR11MB4645.namprd11.prod.outlook.com
 ([fe80::5cb4:804e:bfb4:dad0]) by MN2PR11MB4645.namprd11.prod.outlook.com
 ([fe80::5cb4:804e:bfb4:dad0%2]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:35:43 +0000
Message-ID: <58ad6b76-fb79-4311-ae6f-981d436786d1@intel.com>
Date: Mon, 19 Oct 2026 17:35:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] igc: remove unreachable break after return in
 XDP path
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Keshav Goyal
 <keshav74123@gmail.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260902093443.93466-1-keshav74123@gmail.com>
 <IA3PR11MB8986F43DCC22F802B8236D18E5B62@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Kadosh, MoriyaX" <moriyax.kadosh@intel.com>
Organization: Intel Israel (74) Limited
In-Reply-To: <IA3PR11MB8986F43DCC22F802B8236D18E5B62@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To MN2PR11MB4645.namprd11.prod.outlook.com
 (2603:10b6:208:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4645:EE_|DSVPR11MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d73dd8-8c99-4711-8b2d-08df2dee4170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: FmXkJ68NSLksqf2EWImNXTnc10Na95uh5OajRCxf2QPOq5AsaB648IR6dM1wMZPWQY8Nz5BKGm23CyUdjKkbfEQ+4NbwWxhHDltcOj9khzq0zsN0yytGwOG9ZrqM9mFDagafc3HXV5O6Uczhux/2Uy3dxO6zHg5ee3uIMSL+/7YgSyHF5OBZcZTWHWqT2IX3I+lEu+rP/aaS+T8g6axJTGoqDwur9sPuNCS1tSHLTVLH/vPHQrfU+0AtwFevABwk/Msxzw/xTdqa2s3JgXMEpZqBjlWWf280v1wsT8NEyYdYACfgAUNqDKCJA5DXxpafkQr2/p6L/14oNfBBXD0txUnqsEibXO4o+OvaAnCQCEQtpL0v/yoP5zhe5boTvNt+RqJBcQAC0Y9YKM7IMMwrCw6HxvLJz+F3fcpPsY1Li189E/42kfUTbcpATDDgbrEDyOLckfXMywKunY08KYStXSM1c8h1h589usGCfbQjgptDdAIS9PChJHWmqP1W1jcBPsVNrT7iIaoMbK9djoMtuu22VeuYNOh808nFut/Uqt1d0b0e0z2zZuYv0sjPX6SV9UBZOWF7IrrTFkUoUDJ1WR8jmS1Pgz1kqyrWF8oeOJUJVd/0iq1JqHs2AVigDDcRCLe2N3iQRz6XZ6+EpZoop0YiQ+w8v0fqr/8Q7seKNvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR11MB4645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZyM3VIdHlwVm9lemFONGhIcHh0ZVR2NHlaU3lYQzRRN1l5N2ZnTFRoYW9u?=
 =?utf-8?B?aS9saUVvc0pwWjRiY0N5MnpzdWFQNHVKZzFkeDd1M3hUMDNwODg5NjVIbzRB?=
 =?utf-8?B?VTkycVkvNEFIakRubERTVHpqT0lHSWZRc0hjZG80dGp2eXIvMFZLWXlCM2I0?=
 =?utf-8?B?Z0lhQmR1c1ZHNVY1VExiWDU0VmlzSjNRVkUwUnU3Qlpqb2lQeWZlREc5Ym1v?=
 =?utf-8?B?NTFkMkRBQUQ1bTJyeDBPaHhuZVgzdDkyMndKVkxSMWh1ZmRGWjM2elc2YTE0?=
 =?utf-8?B?OStGQU9IWnVjNTNHSEsxbGVMaElXYU1RV0FrcDY3akt0MlBiNCt5ZlE5TlR2?=
 =?utf-8?B?dkd2VTNHZXZKbUZuaU1yQnBUbmxjdTNwWmE2Wng1MG9XYllZTWhTRHFGT1pq?=
 =?utf-8?B?bDJYb21SOWsydWF1Sm5ITnRpOHFuQ0hKQjNMbnhGVGdIM2VBVjdSMzJpR0p0?=
 =?utf-8?B?RkZsQ1N3WW1OWkVFK05mbDF0ZVkzdzYvWWozZ3JaY2t1aHpoRGE0TUZNR0h0?=
 =?utf-8?B?WjZGTmxvY3RBdXZzV0hkeWU5VFpLWXB3bWI0TzBMaE1aWXFDUmdEZlNGbFZP?=
 =?utf-8?B?K0NpUXcrSVFqU1MzZFNvTWdibEdpTDdLZEhYWjNMRnA5NmlQYUFtQUdTTHlH?=
 =?utf-8?B?NFNIZVpHWEVoRVNXQzY3Nk5VbFR1K2FreDF6VFRzWmxVSndBSjBzVTVaNng1?=
 =?utf-8?B?bWJoajBRbTVVZkZFTXdKY2oxM0lrSlZYOWVtbDgrYnF5SHRuWFJ0U0JvQ0dV?=
 =?utf-8?B?SWo4cHJRTXliWWRnTVNyLzNGM3UwZ21vUUlYYytBMzJHWW9hMEYrTUxQQnZC?=
 =?utf-8?B?aDR6aW93cVFHcmZZMnZNQXNFM2c3UEZKT0xSMUJlSVFGeUliQ0RtUGNTRkVa?=
 =?utf-8?B?KzBNS2JZQUdnWDBESHY0Wnh5TFFLUFZOdTExWEk4cjdpU3ZWSEJIVjlEdEZn?=
 =?utf-8?B?bTFxdE54eEJUY3FhL1diWUZWV3ZIVU5SbDkwa3VDMnhSZGNHT3RjbmJOS0FY?=
 =?utf-8?B?VXNEb3hVbUZkcFBqcUxLaGtNKzhXZ1VHcHpnNTdGVi82WDE5RXp3SHR3eHNG?=
 =?utf-8?B?ZlB0ZHNWbmplbUs0M2o2bHBNSGwvakU4SzF0Y1VueXcrYStwN2FpQU9WRk00?=
 =?utf-8?B?WCtsa1NqaTBndkg2R045aXFXcGNvUFFrYjFDN0ZqWktyZWhOdkU5am56Mm5L?=
 =?utf-8?B?R0RsQUd5U1h0TFNLdHJxcU0xeVJVeFRQMWFpTjZkbFowWGFzNnRZZ2MrWkx5?=
 =?utf-8?B?VDJBQjY4Si9GTE4veWdTNHJpY0RYalRsNEVLZ0ZlcTlaQ3hMN3JOZzlZWWkw?=
 =?utf-8?B?ckphdFRQWGtOMnJ1SWZpUS9yaXVVVVRzdTUvVFVWWWVoNlRmaXZ0c0NZUkF3?=
 =?utf-8?B?Tk11aENrMERHcys3NDVKNVNLajZMd2cxYVBqYWVjSUxVd28yUTE1NEo4Yzhm?=
 =?utf-8?B?VGVNZWk0OG9Sa1ExMkZveXhHVHZRTjdtTDFZKytOV1k0TFV6MXJrV1dWZE4z?=
 =?utf-8?B?c3RBTW9OTWZWdG9oM0NFTm81VzZzK2FRVnRiN3FVMndWcFNUMFNuemlEMnVU?=
 =?utf-8?B?MXd3dUJwRFNkSHJtUlVaV3RLaTd0OGRPNUVuL1F5QVhWYTYveVJmdWJFSEdu?=
 =?utf-8?B?cjlxUEluc3FKSXZnSW5DcDFxSmY5RzUvQitBOGVPakIvVk1iTlNEUmVobUNr?=
 =?utf-8?B?M2RkOXpVS3ZTcUdkZFN6MUNKcUlFV1BzWjlhMHZOR1pvc3NDWDBybmZvRTEz?=
 =?utf-8?B?cmhmdG8rcm94bEZUVFU4aDNVYTFPT3Z4ZWZtT29IQ3ZPUFMzUENMOEtLQk5v?=
 =?utf-8?B?TDdGOGk3bUNGMy9GUnppWlJjZ2RXSXJBay96ejFvNzVxSWJKNTdNMExQaEll?=
 =?utf-8?B?czJVYkJEVDdBdkllbmpmcCtMM3BhcGtVSTBob3hHL3NrSlI2UHU3Q1NOYXMz?=
 =?utf-8?B?Zkx3ZnAyU2RLZE9QMEhuQ01JcGlaQk14ZXFNSUFQZG5SSFF0OGpabzJSSWM4?=
 =?utf-8?B?RUpFaXc3NVQ5T0JCQTlQMWkyLzZmUElQU1NvVGJkUmVtWXpva3Z5RmFPK2xJ?=
 =?utf-8?B?TStrQ3IxYkwwc1ZyWnZYOXZIRnRGamJnbG1pYVo4RWlQVG5tTVkxZFpjWlZ3?=
 =?utf-8?B?bElTYmluTHlSNFArcEFscjMxSCt2VWcvQlBkK0Y4blpDSGkvUWlHMzl3RUhw?=
 =?utf-8?B?UGYzNDlwQVU0Yll1VjREZzJ0VWZubi93K2x0UnMzVUZHekxIWTdCOHBXdjVC?=
 =?utf-8?B?STZ3MXVzUllpQnlFbWV3bzh6Z2VJUU8yMWQ4WDBSWjhIdWZhemxhNHVuWFgv?=
 =?utf-8?B?QWZmZXQ5V0RYQ0Z0aUtLenlRMUppK2g5MVArcHdUVG5OY1I4ZGJ3Zz09?=
X-Exchange-RoutingPolicyChecked: bBuRysWcyx2D5KZXwNfvotHc/b0LJWXxMyxqXQZa8KlvrVUoa8/XumB+UrrFUgIILYEtB3FTtWqHNx71MtYZ7nkshRpOaVau4muFLyHOMh/G5dHzSfP/hAjDVidfNDZWifob5W3aZjVj6yZThFGvabZUNxfRMjQNJqNQffkDdWQVc1LKpOH32B+vP88kb63PlfQf7B+VxeW9A9iy9W4nocRZ5CblpMm2BTodRIcW1qoU0cLra60NFOaGHY79wFS0Z2SjJIGv1bCZppwOEgajiKQ+/BI29+MGCIlyy61QRARhWF7daRcuUgnV+fpd+wFe5tgoTLjYH9J2iv8Mcv0GAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d73dd8-8c99-4711-8b2d-08df2dee4170
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:35:43.4599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffBXVb9Pw1FGURKMSlHubaknoeWFqY7Ug1WxlPdrwj9F7jQeBZ3KFdWXRpv1PraHaV/DsrBHd692X5xi1bdK4Z6hvVdQZzezat41RQT513A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9555
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



On 03/09/2026 13:22, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Keshav Goyal <keshav74123@gmail.com>
>> Sent: Wednesday, September 2, 2026 11:35 AM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>
>> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
>> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
>> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Keshav Goyal
>> <keshav74123@gmail.com>
>> Subject: [PATCH net-next] igc: remove unreachable break after return
>> in XDP path
>>
>> The break statement after "return IGC_XDP_REDIRECT" in the XDP switch
>> case is dead code since the return exits the function unconditionally.
>> All other return statements in this switch are not followed by a
>> break.
>>
>> This was flagged by checkpatch.pl:
>> WARNING: break is not useful after a return
>>
>> Signed-off-by: Keshav Goyal <keshav74123@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_main.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 1fb5f3cbe93c..3b7dd104d8d9 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -2525,7 +2525,6 @@ static int __igc_xdp_run_prog(struct igc_adapter
>> *adapter,
>>   		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
>>   			goto out_failure;
>>   		return IGC_XDP_REDIRECT;
>> -		break;
>>   	default:
>>   		bpf_warn_invalid_xdp_action(adapter->netdev, prog, act);
>>   		fallthrough;
>> --
>> 2.55.0
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>

