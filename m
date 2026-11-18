Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08931606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MLxBbZFE;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MfkUL1sV;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VzseLqVy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D560C405DA;
	Wed, 18 Nov 2026 13:50:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iLmk5h6-wWAP; Wed, 18 Nov 2026 13:50:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CDE6540684
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795009809;
	b=Nt1KXJCiQi3eeojRx8xXYlLGu0BOPNk6tCy7HytyB8jXVwtH6wtiAOs9esnd5ePBucS/
	 z8gdtLuS9iWkW01YI5Tnfh8IcG9SldSrDQ5ytFKUNppSldZPxmHVPcS2m4aL2zIyVYuPw
	 6LMYmBNRsg03FvMrQpjqhcjfKRdtN+osanHvhv3x+6DklY8ev7XeWuVV5hf0tc3qbIShT
	 qWGJttoXbMTHUT6F0meH2JY8Uh3vVFfYRj/Upkfh5YzCKQ3CsLZQqBL6zS0BMmZTW5uFo
	 2go85MCP/4S0VGVu6CUocc9B3rV61NLXR5ApwCzBR4Q1vBfg1JbDdH3ionQvo7fEQTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795009809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=6aAki9gGuYbeAG0nfkBOfvhMs/+svL5r4wAjso2qihA=;
	b=C7O3dwc1nKsqjRPc6QnPEvK4jJZXmZeTx4AkzqOpEol3aqmkiKl1figf16H6omjoWDXS
	 d0GZKBJEVia//278O/g2TK5O7MMgt0rvLLqzOIs/szVoK8J+ZKoXU4vLf/Vi96qI/qlXi
	 /l79jjnmC+yeeAl0rMC/LYwxUxIlvdRZc4EQ5UI589jmw9QQqLlnng+NPMARToLy5apbI
	 PBQmjV5aBnqaQ2Yw55eNjDRORsnkb9SPc4nvXscD39CV9TfB0+p1xIpFKwyNaD1ZKjqi1
	 GoRv2keKdyBBY9eZdtQcJTmSjeZ5HWMI8baVZCsrtlazuoMNaeGEPWRFffi0ucxPjDA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795009809;
	bh=6aAki9gGuYbeAG0nfkBOfvhMs/+svL5r4wAjso2qihA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MLxBbZFEJISe3PKVElRtuRUJW8TyqsUXC+v5vDmNo6V1bXN9mRp7myZRC4cbK2eDa
	 IFcNsfFnboQl91uq/hpbfKmJzi+5Vkf9WxX9ki60T/dGFd90+h36WNJhRdLVbELKXF
	 3ANCFjdK7fj0OnJNzTgoJie9YrriQr0NDtzU3tAMCioOZiOj+TAgybYntS050yGLph
	 YsE0Hk6HNZ2O8yuSh4+QIwTNvqZdK7SPRilHql0aWn/kmM+52g142rVF+XqpyFzWhV
	 vyARGAdC/fRBshTXAsVgOMPW8voqC9Ko59HyCPQoZ96CeavLS7v4pKrxYuVkZ+H0Xv
	 Iwpopnaw6GbkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDE6540684;
	Wed, 18 Nov 2026 13:50:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 49765977
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4539381208
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:49:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hy3x-fP2lVMC for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 13:49:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5733081203
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MfkUL1sV; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=VzseLqVy
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5733081203
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795009771; x=1826545771;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xFJQOjqNYFOPih0ZP9irPDhDXI16j4dd6XtTVTl4nqQ=;
 b=MfkUL1sVYlpWCARCOMSi7hobwazrVj9hZEtRpl0OS8ua5aoFHO342ouc
 2Evq4ueHugUDUrZpsq11JHFLhBU0I6eAIBPHwAgNd82LQ/zqKeqeTWhIt
 MpWuG0muMmItz3H1NUQlUajQiT9CD78lKrHJ7mpRLcXKSiVhT9o14Zlht
 Q8e3fbBw2nFoIXV8Js1Lz9oTvMcontVrMPvoEGZAxQKsgKPw7SU1O0dTq
 ZFkQUtTmbeatnzRQndTI/05Y6Et51tpmRo0PtloJaxrf+nIMr9e9bTRsu
 DiiE56U1xe4JhfhK74b3b62zp2rkeNO68XwnjkNsQZpVQyeA+Xg41HODW Q==;
X-CSE-ConnectionGUID: eOXsZ01dTaSMp/aCyF4hnw==
X-CSE-MsgGUID: O5rX5Y3gScSbnmpK84vL1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3705184"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3705184"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 05:49:24 -0800
X-CSE-ConnectionGUID: RIvEJEKqR5SOvd1jx/Em2g==
X-CSE-MsgGUID: bm6XH0RxT5KHPl81/cp3/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10681587"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 05:49:17 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 05:49:16 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 05:49:16 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 05:49:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aAki9gGuYbeAG0nfkBOfvhMs/+svL5r4wAjso2qihA=;
 b=VzseLqVy2jNdBd65PsSF0SeRx/uZWP0fueY3a+tg9ECi07peCBQHWIfQWmAvswUySI22fQRmTemaH26zA1ouNUXffuKtNHF/2BGVmMNNna2kYqxXA5COBfS2W6kpNbC/CjXrG44XONdkJyLaXsTrRUUtJpXrn/9D8FiXUNx8cus=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SN7PR11MB6851.namprd11.prod.outlook.com
 (2603:10b6:806:2a3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:49:06 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:49:04 +0000
Date: Wed, 18 Nov 2026 14:48:58 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <edumazet@kernel.org>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
Message-ID: <av2syi6lE/Vp86QW@boxer>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
 <CAJ8uoz0MMUx68rMZWoZs-JwjodpRixwQSrgpyta1NsanGPn=dg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ8uoz0MMUx68rMZWoZs-JwjodpRixwQSrgpyta1NsanGPn=dg@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0201.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::12) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SN7PR11MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 8daf82ec-3ffa-493b-5712-08df457ab561
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|56012099006|261022105027099003|261021121427099003|4143699003|11063799006|10067099003|261026140227099003|261026121527099003|261022075727099003|261021135927099003|261028144727099003|261022115727099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WwoJH3ioqTPJMN/vFiXDi3eAV0K126vBT+dFLXyDIfe/nQA5K4QpVEdZ/r6Ktw/6wIVsLZIFeKxWspnaRO1BZnLzEe0f3EsgzLRTUTbXmB+DXU2cF6avgGP+nw/WMB6c7P+5llTx/5iMT0rdvzA8GOQr6WxFlrIEuqJ8+j3N0UO5mcm5gMo8CbGYdb5LwWBFZV7l4YfFIyi/M+qwSZGmkVyQj7oeH0+s2aZs3ghs/6vVjSFwBSAU6/0D10+42hAwd21vx6frbM6TK/6I/RS4732HcHv2d3lTz/A7/DSssikf9yQ2501pTJh1OL1pF0wRiGepWnFQL+/tgYQvFiT2F9JMnU4EGBAPW4LvjysdGt7a8bqwa3g6ZCtf5OTn7vnvugaZvz+ttEbA5vUun7yXILcrRdOxIE3SjqahNAE48usGWu7WloMI9GOBZ6yvB+YMGMusU/Q/bjrxgT5t5fek3tbrX6UdHDmXLgVkMUMTDhE7Cu9gOnDhjgEhhirvCNRY8q38UCdtbZ3mWj+n+vi4fVSra2PfXb2Y4CEiYFrDY2fM0qEJD2a3gf2EDv3Qh2ChZwwrF6kDAgPkpNqkXFTF2wUHEIly9UbK42txhgscL5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(56012099006)(261022105027099003)(261021121427099003)(4143699003)(11063799006)(10067099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021135927099003)(261028144727099003)(261022115727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GAX3GeMmx3ZFsiu8lDhbz/i3EE3nSTck2nwH19oWC6+js1g5zh04IrudF6xH?=
 =?us-ascii?Q?aZEkvmFrK+pu8PSgoyCvERI0O/p8WmoXFtauz2fxyhb6dzmPwjcht9pEz6j3?=
 =?us-ascii?Q?l05l8SAkD8ajrF4eylGre2RPcOwid6gLS8PEb8S8/C6KPoG8NFAzP7VBus2e?=
 =?us-ascii?Q?cQL8/XpQrMsgm1AaXAUUwUrmXNHmHRH3nmaBUdXSQLYp9sGc0696B6VSoKkb?=
 =?us-ascii?Q?ahlIONYciDdxcr+hjqxOqJBbpuzL4CE83gLIL7E1eElrgt96z7R2+vD/37yJ?=
 =?us-ascii?Q?UFLg/o6uQYihD6jEpavVBCYoh3wD114UjbfP8D6xAzMmTnEQfQYnNSjDKDaw?=
 =?us-ascii?Q?Hw1TyqeX8FDgtBVk0x7/fhyg9WOmji3tnl81/Z8Ah2USj0sWMfs1ztoaH1jE?=
 =?us-ascii?Q?KNp0qYzaWYb5pOyEtBUa9RMNuQC+tat+x4tlN8X8yCW+z6Z9TNWwPTph2mvs?=
 =?us-ascii?Q?C/6t40Z27lBPcIN843rzpHNUDZ+N9pngeYpmuSiXCH/cMMlJNlMC+GTM2A5H?=
 =?us-ascii?Q?+NWRt3nPOg92ysp0K/Ob61NJl3iMtMOpYKlVkzxTKu9A3LbWgP/pEcSByMQl?=
 =?us-ascii?Q?NmgNm/Bolpmm6NqIikQYmaAuM11aWnhxGCithmZdAq3EVd++XD96cayKiZ6d?=
 =?us-ascii?Q?Hdt0czfSi1cnfoOO959oYeZ3hfcrdIzAcsYwsogyZfopxOYVtMEBndlU7Qxl?=
 =?us-ascii?Q?+ATgqnsCzM+Rl6MkTJfTAxVJfTrn2HPQFNaR6bSxbnHnNNGWML56GbwJPxbw?=
 =?us-ascii?Q?0Dqui5ltESMUQWblPwNcYD0C5zsOSPQb9mtvKH+iLnXRBNDi0QmG6dBBzMGj?=
 =?us-ascii?Q?gpDr5K/DdwwS6kgnrxaymR8zMgUZ7ladBsj2bs0CKfs2KVVY9JnbS9ppaDG+?=
 =?us-ascii?Q?h68rT6XKGIN7j7WnRyB3Bthq8zPQ0BSSWaYPBbIM+54KgLqllsNufl6hGEOb?=
 =?us-ascii?Q?UQm8YxJmKAHpkqXmmV5qFd+0xDJpcqij7fIP/FzVYSZGeHWc54tDZDffTq1A?=
 =?us-ascii?Q?uSN6SHRxEIfiTODSnNftuo8xPZFk3wXoLHNUFB9CT0MFPuacYM5EDU3FuONl?=
 =?us-ascii?Q?fkPnG+LbjV3zGYlQtyUXS4qUDmzaSH9Fie+pVdld7SLhDKOulMT1UHORzKy9?=
 =?us-ascii?Q?nONpnpVEVzDj2lk6gdltM72EBcfaTp4vqwUCeGMpQUTuWqr3vJ6md905Ine3?=
 =?us-ascii?Q?OdX3H2C8CKjMNxo83P+LlWZwt7YnTQveu7GT/3DZtQVFu5hm5N8jxCK7l4Do?=
 =?us-ascii?Q?Txyim8tt63x2hhVhEtWtjw8Tm4iTnc7wnibnU7EuvzHZe4GLhzTPkZQ2fkgE?=
 =?us-ascii?Q?jAMXNrfM+2yJ/wgMw6GKxOrt4H8239LYK9YFjnTsJXhRJJCqbz5bTrMar8Kk?=
 =?us-ascii?Q?3CUg8QFniLOHsBCR0eB2DzoLt+yTqaojMRscpQ23z7ffn3xCMjZ3NeK8KezT?=
 =?us-ascii?Q?WehOnjQnjTsjN0pkB72TGFMVx1X8F+CmuDp/2Hn1w/Hlz2zqx/09LvHJLQf/?=
 =?us-ascii?Q?jr/rlaIbW9A0argX3tMMX1qeIIp6NxL0r9VXrU0Kn+zfDXqeh3SqRO+FvE8/?=
 =?us-ascii?Q?8Ab28Tt8feemCq7s24sw4W9zL6eXbN0zIRwGDaN8rmWT21FM8+ZGRCM5VevO?=
 =?us-ascii?Q?JiGxnFBtiWC1nTvfk7PfM9RpM7bBoyKQPYmZNsxHeUEOyJadH/c5mNY3YgJ+?=
 =?us-ascii?Q?30E0dcUHy/8Fulv3pcEJpNXNMIGCjWXCzRYvMGz4KXPIVQfVgAr6oPmpta+4?=
 =?us-ascii?Q?hpIpNG7KDhIT2b9PHpJFr25faEW9OIE=3D?=
X-Exchange-RoutingPolicyChecked: I0wimIPRgoOJH1ftapw7LhlZpe/T0lWoIQtAEjCDNsUwYSfd3E60oQkYUf3jBc1CzzSzePPJ2fLZkeVuqcMraCvd4kt87M05n/Y65az+1q1U5bgKME9cfwC7I3PadrApoPXt1IfN1LVUIOkTSojEmqUIlqmEvo/ibBMMeCvYUodJiTroWF11U3E/4uyAr1B6rz8wswQXzJFo3vk/Mu/tT0872Vr/o8bA0ZXKRJf2dL3a+fB5IAWXUTd8tHvfIGIZd1WkPP8P6Nxb7SYzhr05t/+Vae6KeFMyAo437UJM8fCE9NL8Opm4g7W/Szv93yAslarggUdtD7qhC9XGEzSs1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8daf82ec-3ffa-493b-5712-08df457ab561
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:49:04.2160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lk3L9TnzL/mA+AnBsZoQXi6qmsEAzhhnLvZL1hTAfs7Bd40D4NBtW4spCfV7faWNaFfeGHB8u+KpL0wnxNuhyOyS540O1WlbO3K3MRBetdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6851
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 02:37:06PM +0100, Magnus Karlsson wrote:
> On Wed, 18 Nov 2026 at 13:00, Petr Oros <poros@redhat.com> wrote:
> >
> > I think this pull is a good moment to ask how fixes for Intel drivers
> > should flow, because it is not the first time a fix spent months on
> > intel-wired-lan and then hit a wall on net.
> >
> > My patches 2/6 and 3/6 have been on intel-wired-lan since June, v4 on
> > July 8 [1]. They were reviewed and tested by Intel validation there,
> > and four months later Sashiko found real problems in them on this
> > pull. I have a v5 and will send it once it is tested.
> >
> > Jake's E82x timestamp fixes went through three pulls before a part of
> > them was applied [2], and Maciej described the same loop on the i40e
> > pull in September [3].
> >
> > I know Intel patches go through iwl and are not applied to net
> > directly [4]. But for fixes it means that the review which decides
> > happens on netdev months after the iwl review and validation, and every
> > respin goes through both again. And if iwl stops cross-posting to
> > netdev, as Jakub suggested [5], Sashiko will see Intel fixes only in
> > the pull.
> >
> > So does the iwl round still make sense for fixes? Would it be better to
> > send fixes straight to net with iwl in Cc, and have Tony's ack and the
> > Tested-by from Intel validation on netdev?
> 
> Glad you brought this up. IMO, it makes no sense for fixes to go
> through iwl and it makes contributing fixes (or new
> features/optimizations) a lot more painful. Sometimes even to the
> point that you just stop contributing something. I am not in the NIC
> team at Intel, but sometimes I have to do network core work that also
> touches our drivers. In this case, that patch set goes straight to
> net-next (as iwl cannot and should not take core patches), but any
> driver fix that I find on the way needs to go to iwl-net so that it
> can go to net and be backported. So the fixes that my patch set are
> dependent on and that should go in first are instead sent to a
> slow-path (i.e. iwl-net) and after X weeks/months appear in net and
> then net-next. But my patch set in net-next is dependent on these
> fixes so I have to either wait or just cross my fingers that my new
> feature is stable enough even without those fixes. Not optimal in my
> opinion.
> 
> So anything that could be done to speed up this process would be very
> welcome. Sending fixes straight to net would be great. The validation
> team could pick those patches up from the list and run the regression
> tests against them, or would that take too long?

Regarding providing Tested-by tags, could we lift the policy where only
Intel validation is allowed to bless the patch? Nowadays with AI regular
dev can spin up a nice pile of tests by themselves.

So if you send a fix and you can find a peer that will test and review it
for you, I don't think we have to wait for validation folks taking care of
it if they are swamped.

I also don't think it would backfire on us and we would introduce some
bloody regressions, given we have {s,cl}ashikos in the pipeline.

> 
> Anyway, good initiative. I am sure there is a solution to this that we
> will all like.
> 
> /Magnus
> 
> > [1] https://lore.kernel.org/all/20260708125755.706263-1-poros@redhat.com/
> > [2] https://lore.kernel.org/all/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com/
> > [3] https://lore.kernel.org/all/are4rBUJO3mzrkO8@boxer/
> > [4] https://lore.kernel.org/all/20260721174642.7749143e@kernel.org/
> > [5] https://lore.kernel.org/all/20260922112216.41e6f8cf@kernel.org/
> >
> > Regards,
> > Petr
> >
> >
