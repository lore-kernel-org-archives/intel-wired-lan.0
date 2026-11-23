Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40793606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6qk/M7qe;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KBjhnE2Z;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=P6t+9QjD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B7A9606E5;
	Mon, 23 Nov 2026 22:38:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6kJIY4ab25qV; Mon, 23 Nov 2026 22:38:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4559E6068C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795473509;
	b=MBJblpcU4j9PbwUfjm7oMRp0+dgVF1Yjagb/J+KvO9ypKCi0iph+DD2ulQnIjyX9jycN
	 aJ8W64Sni1zy0A6DW/AnXAIqan1RmzEfPcPQunbmj3Pa34+aEuApUkFelile2TW0rZj/8
	 7WC52fnJACovYBdt7+l/kEDQAG+Ght7F8O4DPLu4F72FEEL/mnt1Hpf/H14ahop88SHtY
	 3QXEaGkEUE6W2OZ5pJImcatHSKmGlbLdmE87ww9RKrHKS4oQRZEANBCkFBtNXWWCBFj/v
	 bHnEiPXCTSQ4NM3h49nKozPfTKnlagNXUzk+558xcS/zPBn/7/fOlijT97g6kkA21uA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795473509;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=dRevLf68eGRZgwnW2AR1+kJ/vw7jKhX1qdcdxSnp960=;
	b=mk79LBh17wyBvt5JzVASNTrIKivkAti3rLJuxxHv1dNpllQWml0JkzvXjaobtvunsSXR
	 lxpai6zQaky1hWp20CTLWiohogix0LNE4iKXY9MPg9JDZV1oLYSbNMzcNMSE7CG7Dgqxi
	 MFXARr7hKYb9pt82exrBKTIWRNUAf9D5Y6fzq+2OuosAoAIh1DNqXgozOM8kAhumZXngG
	 ZhtT2JxiJXx2+6lCIdgwGRZiubPXwnI80c8igzBi/ghXvlOIUGxIUl7qmQQTYDkkDHKgz
	 03ZmFV0Rd4yBq5ybHVEp0Ad4FSZlBy5Jbswujg7O8PTujFnmN9VyEb6PvYyyUW/jrgg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795473509;
	bh=dRevLf68eGRZgwnW2AR1+kJ/vw7jKhX1qdcdxSnp960=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6qk/M7qeKdWyvDvIcWqpqL5NYeXLU0S0uV4ymagtxb8cGK6UUFY3WcVQDvmaHCEGm
	 6YTNH19cVDz/tjp/Ru7HJ7qqjPql+a3YKmLDE40Y635buN+AFeF7818sfl0DFc2e1q
	 ghM8B4WcgG2ezkvQzVHqSTwo6FLp2rVhMq9gRV19vSS30htlCzLpDy12khtUBxu6wR
	 +MxM2jk/aU8suxwqVa0yacnKPgJVCsX9T1/VJcv7k5vw6AnCyc8pCD2h2EJ7x4SMtv
	 WI4SigMDi1wc7RuFebfrH5KJfB6ieGlVHDRBGdUKAUV/9Qw3ahUu1cbXR6I67DNv/q
	 uLNO70HXbk9tA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4559E6068C;
	Mon, 23 Nov 2026 22:38:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AA73D32
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 22:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70E9080A68
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 22:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ydbWSbt2_g79 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 22:38:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 681F480A65
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KBjhnE2Z; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=P6t+9QjD
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 681F480A65
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 22:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795473507; x=1827009507;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o7n55YGUwwSxDsiHAJkF3BCuUCDCecGZU1nBmTQYZDU=;
 b=KBjhnE2ZWT5AOujFZcYgwm2kx81bs37cg5Hb30OCd8n9WfutmEq0Belf
 Q/e/p0M31qsWkb8dzAX8Hv3ff+pYJQhAh9lMfiqsfM8Bb63d9mKkP5fi/
 2i5wvyLMJWPKXf1vlJrU6ez+05oaZ2C/4QyScAPBEPFIQktQcbPUnCvUj
 eY4yylkcsIkDGQeaeI2tAnlJOGBLnqfmVbU/GZMvaQeTCURxmPrXViQq5
 QFhvSYZ9c9Vy28G5UpLHpM/xEFry09wJT9Bbi9FVmIEdcROrh3lR9Qa3B
 UWq8MXi4+qB9DGbIdgqeEJXXYjppkeGRlripwnVtu/uiasMiSVsFNbj3P g==;
X-CSE-ConnectionGUID: NZ5pclEiQIKMRO1OjEPoPg==
X-CSE-MsgGUID: uZYQL0WaQbSI79Hwjgi6cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4194326"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4194326"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 14:38:25 -0800
X-CSE-ConnectionGUID: rS2xKv0mR1i5U8a1S9tutw==
X-CSE-MsgGUID: Hj5KKqbZT12owJwIhsd6hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11388456"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 14:38:26 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 14:38:25 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 14:38:25 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.35)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 14:38:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRevLf68eGRZgwnW2AR1+kJ/vw7jKhX1qdcdxSnp960=;
 b=P6t+9QjDUdoOisyl6FFUrYpFv27KRRfVQHTWruWoFP8aZKXD8iFGlSLVq/nTXK+tUWoHtKJAZCfnlMf58bAdteKbhpZXXRxcRXmusaXakrJXMeUr1ZpmRL4I/LyFLND/yHdjSKpnszooHzEg0WZ/PntRfkA6w0fTAOaLtgvQcls=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 by DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 22:38:23 +0000
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c]) by SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c%4]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 22:38:22 +0000
Message-ID: <37d8a917-f113-4d34-b152-a4d21a2871dc@intel.com>
Date: Mon, 23 Nov 2026 14:38:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ice: don't unintentionally switch to symmetric
 RSS hash
To: Jakub Kicinski <kuba@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <ahmed.zaki@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>
References: <20261123205600.1794292-1-kuba@kernel.org>
 <20261123205600.1794292-2-kuba@kernel.org> <awSrrR6RfQYjhPU1@boxer>
 <20261123134109.30ba46d5@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261123134109.30ba46d5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::31) To SJ2PR11MB8451.namprd11.prod.outlook.com
 (2603:10b6:a03:56e::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8451:EE_|DM4PR11MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d51a68-d5f9-4ae8-34d7-08df49b27a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261026121527099003|261022105027099003|261026140227099003|261028144727099003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hBEyNa9yIIm6bPcDth4xwx1hMvs3y6g8O7iWxQvF280WSXBMF3In+/Sp+isMvUVo7KrRfgBGwjLC489Qctn4BNHHsZ9Rk4+BeKHg45dSksg4DWcTmDqEcviFFfwmKMToXvnFUD0VGG2L/wkmI1Un7Qybecc1uRBGCL4WNtBr7CMM5JlXqMlNZ/ZrnrLIZjrH8gKUFV2A16W2kX7fsL4iWuHXs1XoylLpvpZB9J5XZjPXbsAuZmWdTJfKh4HnLsYdPwU6WON+jCaQy0BKUVyFMJxL3fqTKdJ2TAvI7Zx+Kz9U1loipOcXiy8UIpN1ebhtMa8bMzNC0bb4IooJFyJOBdZ0zYaVghnD1zLvLE+h0sDGcrfIxE8iZhOuteZ8z489Z+da3ZGu8Aeq9n2KhHhyzb5Cr4CJtTddEZDNgxihwv8iNn4P7FvOTpguidbfBHZJvp4oQX1ZXubJegFHnVOBuv+erHjg8jPVln/R6UqzTq0IyW+SL6ptF8lNwVY6yo9xeRQB42NvR90uSYUNIb9kyzLUi4t7QtLBV2XZouCpapwS+Lxp2iwmheLxgp0R3d0ADEz+tyOKRc8zFN1Ho08Br3ZaCut+BBLhVHoxkKrBAfX7snXjiOMWWFXncF+71hztZ+cQqQLRA/znoxC3+pV6JhXyzdbhCjppReokWNsLG7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB8451.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmhRUUd4ZEZwcExvZGtrQ1UxSzMrQk9FRFVZdTFtQURWMDNQQUt0YnhpVnNS?=
 =?utf-8?B?VmxYUzlaT0FuOHNLdjRIbzlTVk5xb2RuM2lDNEhqYzhHa0pCNzVKWUVBZ2Vt?=
 =?utf-8?B?RHdYWnJrUytYM3puc01ldTdNNXNDREFXd2VkSlJZY3dmN3lRN1hqRkJzNUsw?=
 =?utf-8?B?MExvNTlLUVk5RERGdEFYdEFEeDNJYW9RZEd4Y3d3aEJoMTFNMHhRT04velRh?=
 =?utf-8?B?NHBCRDJVeUdhck1JUWZGS1VuVDdHNmdpNWZWd2IxbXlydG5YcThIOE04aitT?=
 =?utf-8?B?UmZQVjRtME1sRjF0SXArUDhhalpwWXFtZHgwWGllbkdCcE00NHA2K2UvZklj?=
 =?utf-8?B?djVnTllGM3ZBaGxFbFkrVlNLVGQ0YVZwa2RFTTg2TndycmJxdzlmT3VxU0xO?=
 =?utf-8?B?Zk51NDRZOVhnQ0RoZytxZXFYVENUOVRMY2NvM0lwZmtjRm1XTmFXYTl2bUgz?=
 =?utf-8?B?bi9YMjFFZGJMV3NaaDU3TXZyVUdidGpOTnJMTGFiVmpRYVdEdzR2TDNQTnNu?=
 =?utf-8?B?cERsalMxRTZ2VHlJNnhVNTk3Uk9LTGpQNlJISkJESVpzcThFR2MzN1NMVkdo?=
 =?utf-8?B?RkhBODlPL0JHSXdJcm5BOHorWHcwSlA1cC9PZW1WQkFkQ3BHRlRzd0lEUzJ3?=
 =?utf-8?B?TmtlMmM1L214V3o0UDk4NUNiVmMrSldJZUpia3NZK1pNZW1iWW8wQ2d2VXh0?=
 =?utf-8?B?bTJrYmRZWUZnNlN6SjM0ZDYvcjI0ekFNRkRyb2djOU9IQXN5QkFCWjhqN0RY?=
 =?utf-8?B?ZVRnQkp1QjIvYTVzL2M3OHVIcWcyS1hieVhKb3M1ZVVBblZOcDZWeWNHMTlO?=
 =?utf-8?B?cit4UmpNNXNzQklyRHR6NVNLd2pRdWR4NEtRU1VxcnVnTzJ0S1BYd3E4N05N?=
 =?utf-8?B?Q2lTNC8rVWhqbHEyK2JSYmI0emFwNWV0ZVhyN3ZhcXZBVVpDRjQ1dUVFUFI3?=
 =?utf-8?B?dnkvZ2JCWkc3ZGJmenU3enRLYlI3SmdMclpLUUlQTUppdzF4dkFHbmgyd1lV?=
 =?utf-8?B?NmdJOU5nUFBpTEQ2U0p3czJyczZSN3ZlMXBWQXg1RENmSW13ZGR0MlpaTGND?=
 =?utf-8?B?SzNwcVJZdlJhc3NGN2MwQmYzbVNESzlMODlJYVJtZHlXODVlZTN4eVpuRGJw?=
 =?utf-8?B?dmpjZ3ZvYlg0YXQrZ2ZmbDM5YnJVNE8zZ3FxZkUzOGFBVldZZ2xYSERDMTNW?=
 =?utf-8?B?UlpwV0lmQ2Z0TFJVaFB2bGNJd3hVaWlKUFNWTVR3MGxHRnlXM3Bxc0xsS1Jx?=
 =?utf-8?B?N25ZL2RhNEs5ZUlpZzlzZWZ3eVRSenpIaGkyUkdtMFJPblBwZVlveERtUEhk?=
 =?utf-8?B?SXphUk00aGp2WGw0QWNmVi9uTE5vaUtmQjZTN1ZMeGVWa2IrRVc2a1IwT2JO?=
 =?utf-8?B?QlF5d3NlUUQ4TjRIdUlVZWxLZllHcWI1dEFQNlFOS3hmNmlLUkZUa1lQZmNH?=
 =?utf-8?B?aEVPdWNmc001WU5HbkdZK3hrYVN5bDl1MjZ6ZERtLzN0K0NxcmhGczBDR01a?=
 =?utf-8?B?UmpCdnR1VytvbXBOR1ROdHJDdG1PYjlBY3NRaDY0TVNDcmtIdUFLWk5PVkUv?=
 =?utf-8?B?NktiK3JZaklDN0d5RWRhQ3I0MWhKSzlmWTQ4WS9YV1dxNHV3U3QyaUNYTW9q?=
 =?utf-8?B?bjBYVGpyeHFLdHY5Y2lBQU1saWVjUksyeDZ6RVhHZFhVU1dta1g4OGt6Y1lQ?=
 =?utf-8?B?S3MvR0IwSWNKZURxS3Nua05KSkw2bGI3aHZOTU1DNjlldkRldWRCVVpQL0kv?=
 =?utf-8?B?QXNLd2JBczQ3eGtyV2hQTk9BYjJySTc4TE1Lb0N0MTlMYUwvRjNCWGJVdVEw?=
 =?utf-8?B?RUVtNGRCK21Gcml0ZGwvVklzN1hVYzV4K3ZkRzAvcEs3NHdJQzIrcWpQTUNN?=
 =?utf-8?B?QkdFQmpselN2UC94NTJldDdqb2dsdUR0cjZzdDFqb2kxcWEzdjZnRTZ5MEhX?=
 =?utf-8?B?U3hhOCtZRzBnbVAwb0toNmIyaUJGUUErWE5TN0h2akRrZXYvNUtJK0d1TldT?=
 =?utf-8?B?cG91ZmlvOWN2b2I2UXBTYWN1VFIvL0k3NDI0YURySy85aTJodkhValRJTGM4?=
 =?utf-8?B?MkRCeTZ1MWlhbnZBUEhqdVd0TzRzVWVlVkpJRnAva005T0o4NHRHWHp4Q1M4?=
 =?utf-8?B?WXNIZGJ3KzdlaVJCYzJ5Wkp3cG1RM0psL0s4b3c2Mlk4ZE1KVDJlWnB4bytX?=
 =?utf-8?B?cm16NmRGT1BGM201cjNvMkZVbS9EYzBWeTJ0Q1krVnNOZWYzSTNRSms2MkhC?=
 =?utf-8?B?RXJDZFR3SWtUVktFNElwRG1xTzF6MUVNbkJuYnkybTNpQWo4d0k4Nkdtb01B?=
 =?utf-8?B?ZTJScEowYjRsbFNSZVQ4dGo5SkROVWRncTVyU2NuQWZ3T3NXU1JOL1BNTEo1?=
 =?utf-8?Q?ktydRPlnoOp7a+bI=3D?=
X-Exchange-RoutingPolicyChecked: afmrzM9yXD5N8UUg3qKUNH7qlRaMw6nbUomBk4tS+h9GapgL6SYd10wnBoErFhVbHKXM3cvwRVVnbAdEHfOBS9IVGATzT59mlw5PECDO5FDlQd1QAI99/zlWeCGB4WphGKc1+N0/gF629xIARR2Et8T5ddffZ6VHbkf9vrqxiMKfCp8MfntyWhI/Jl8y402sXtWRwlwh+omLyG//QoU/9VkbJJl1W+UiVhqgW5zpfHkAkczUmXf7zUC5nUEzcuAN63rT8K1vTZ3Yo6QHNYuWDMFBIEW/AxrYNVpcAqiTS2Zp7GeEeBYNpVXnaTknwjL6Wd1goYFOdWwrvd3yk9i6vg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d51a68-d5f9-4ae8-34d7-08df49b27a8d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:38:22.0944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfJvjvxjLOfsBj8sRmrnKfNlIFSt0yj1a++vcSNkcMQNgdltc/GyZzM1LWcNRfhxw5xwXDXW6a3i5gOeChsKCTf4nOtUs97bJ2kh3VfKIsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7181
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/2026 1:41 PM, Jakub Kicinski wrote:
> On Mon, 23 Nov 2026 22:10:05 +0100 Maciej Fijalkowski wrote:
>> Let's just get this damn thing fixed ;)
> 
> Thanks for the quick ack! 
> 
> BTW I started going down a rabbit hole of fixing more bugs in RSS
> handling in these two drivers (eg ice assumes that rxfh->indir == NULL
> means reset to default!?) but I gave up after 30min. There's certainly
> a lot more left to do... let's see what Clashiko points out.

Yea, we have a lot of "side quests" like that which still need a lot of
work :(
