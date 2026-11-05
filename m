Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4560606A326
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VrnG3ypa;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YsWGaEIF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFE148114C;
	Thu,  5 Nov 2026 18:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKrKFQJ9SNOn; Thu,  5 Nov 2026 18:36:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E104E8119B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903800;
	b=s1+XDmo27nZhNaME5FY62oDp2D4AxGxkYDOYnsBiW6L6dIFV2mfNq8VODrHE6VYt6cXa
	 IJ/HU9mR4/ZpoAhshEcEKi/AsuRtvAaqtuKOTNY7GAIevRL9lAOIrnL8aIYECTNqYrmEW
	 9DO9crx0ghXdIiH7Q4AODlH1+DZMNrt/yM6T6/kC+HcM9ooYNSybFkqu4zZ4dRZiHSHse
	 ooYgOmF9MVEZqnP1AcOzP943pjZsxaOQOPFD8MRVrjD/CRhTYdz9O5e7BaIfJzv6ZTGx2
	 BE/7Kg6HUp4KF0za9orsbFWV0naCZrbjS1jLAWpjaTFlmpUp5+0Zcjx220djd5smInQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=6Ir+0jj+rxGz1+jJOL6n351TZq1gLM90FyYCwA9Xi8o=;
	b=HjyVAyjFuTJyhUseousT7vj7ael6VKJHHGI9F7dmmewVfZHwUJtLOjl6TT8jDGJA+ukW
	 jCbR1PvmDpmjVt9kr4FV3rmw6CZzJpaW4taE1Mz+5QcycjmCwrVpT1SRCMgMdvy3Yg4uX
	 r4ZhbNSbSlL9SSXU9uUMCAMVBnIoNmxhmb7BCmEaBs0Ges1RtAPRIcD53JKmq53OHGYxv
	 SmHJrc1ah+Mq8zXrggJwoyR5w7Qmvk8mtX0P5y9Escf6j6hh9ti5wVx0YsMimI+NXn/g9
	 f6qb8M1YsvzfFdme/4g/mhLFWklqCalNoJWgKsPWqG2tBth2nfnOhEv0TKdrPtGzSjg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793903799;
	bh=6Ir+0jj+rxGz1+jJOL6n351TZq1gLM90FyYCwA9Xi8o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VrnG3ypa3ZwMbPlCnKVklOKurZAFVVsdwSTnFWUZFeRVqgCChYN5ZL33ik975ofst
	 NEYcGEx/DqONOjUrlLFdCGTRB6SzkLAjIMesVABT6gYPK8wNyE2xpp0FxzgZm/+Hoa
	 EEYfecbbslePv62Aip/UB4Q1QXLr8f6P7Awaw/7qpOenb8ecma+zVqpIJtWblCjBga
	 nAOZhAsGxHhPnokyLg9/9sJW25tZNm6I5khf7Hsh98YF4ePeb5l8jew75DbSTAZ0Cw
	 Y/eW4Cc15h+ogvIIhqh1a0jLlCxaag8tLjDufmWLFEh28aqqE+8Dgi7BWb/Djm3/yU
	 YGkox9TZMl4Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E104E8119B;
	Thu,  5 Nov 2026 18:36:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F2E7B52B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3957406FC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W_0OchOS04cN for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 18:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6727406F3
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YsWGaEIF
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6727406F3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793903797; x=1825439797;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Yidw0sRvmGO2sPAG98FM3T8CpnDAuDp/l+ZcF8rKojY=;
 b=YsWGaEIF31E0EtGMqd2c8gY8rD4apkbnWUBPAfyav+7mpXBQdmP6q52j
 gb3c3SGxuQiI6H1xBYjeYKny71U6kJrnKa3PbRjwvmGklG9czHeaM8euJ
 8ZYSQMJxa7gpoEq82lrENSdh5gh0BpfDxrZtYxQruxZ7ZKqqGC2Uvmee7
 sIlgVr5s6/5SMXpgsuP835ndvMDqO8ZJhiFMkUzOfMotlYic1phuK0Jum
 OX/03N+T423DfqYCeY9WXWd93mXzkUCqUKJdZxLtiDcgbafyzj2qxr60l
 uyA82yrxC48Nl83xGw8GDWovoGiy2xr5MDLMwU5NKZCft10/yxfm2DhR+ w==;
X-CSE-ConnectionGUID: 5Q1wI59XRs60nBUro2NfLw==
X-CSE-MsgGUID: pr+Qe6/9TKqIOspOpUNC3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2608202"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2608202"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 10:36:35 -0800
X-CSE-ConnectionGUID: HOxJsNv9RgCw/x4eDkwLBw==
X-CSE-MsgGUID: uNQ/81C3Qc6sHQUipoLSrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6971794"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 10:36:34 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:36:34 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 10:36:34 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:36:33 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:36:31 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 18:36:31 +0000
Message-ID: <b576c53c-7a8c-45ae-87cf-352ba2fbe52b@intel.com>
Date: Thu, 5 Nov 2026 10:36:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
To: <bot+bpf-ci@kernel.org>, <meng.ding@siemens.com>,
 <netdev@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <corbet@lwn.net>, <andrew+netdev@lunn.ch>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <rostedt@goodmis.org>, <mhiramat@kernel.org>, <daniel@iogearbox.net>,
 <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <richardcochran@gmail.com>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>,
 <wq.wang@siemens.com>, <p@1g4.org>, <gerhard@engleder-embedded.com>,
 <kerneljasonxing@gmail.com>, <horms@kernel.org>, <skhan@linuxfoundation.org>, 
 <rdunlap@infradead.org>, <mathieu.desnoyers@efficios.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <martin.lau@kernel.org>, <mason@kernel.org>
References: <20261105071706.7043-1-meng.ding@siemens.com>
 <4c0a0855167cac39dcf8b1c103d0f98a8898a14866daf9b97a127698bb1ea0b9@mail.kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <4c0a0855167cac39dcf8b1c103d0f98a8898a14866daf9b97a127698bb1ea0b9@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0300.namprd04.prod.outlook.com
 (2603:10b6:303:89::35) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA4PR11MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d8dcc2-5ce2-4c6f-c81f-08df3b6bb5e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|56012099006|5023799004|921020|11063799006|4143699003|261102123227099003|261028144727099003|261026121527099003|261022075727099003|261026140227099003|261009223027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: hBKASUU8sDGI174sWkXkadub9tonALbfHgmvlhv6lOHW43h2sy//jN7wQPSVrBgru/6H3wWO/piHHPus0B8S8ozW8QLsvrmdTKQWqdWADxIEObDwjSgN1rk3MSdmjN3wEvnhtVGpE8n9TE0Ynp/Nky/meKsAZIWbC76dPMkw7vpF6eFh8VojQ6XxFREgCQM+51oqEx6j9QuR0LcZwTWG46pRYi4zsEGRl7D42PZ8B/+LRYhkwZ6/MLwBFhxDRJo1f8yrPOlrD2TDpObYTF4ubd3gD+R01gzU+Fk+JrKc2PWb+8M6N/51Vzwgp/0bW3rcbDC0gm1/LpuTjhoNTW1MuahxZlSYcavb6q0+3n0Sal0LRITU0vCco9j4i3UPvN0+P1965YuOMp0HzCpRDObN9hhAPHaaE5j1I7XZ4FzHPCqnJ9OHqKGFwYtTa+2/C/cSFP/nELFtBtiiwE9AEO8OkP4XOXOqxIfQTbBCij4Sw0mq/TNlXIlJ2Z0KtThrbH691gWWMRDRnmOweJe8EI3BcTdwhMDzbHZ3X++90N/Yb+xMVY04WiAAlv1NbsbqIYrI/JSJxmaia6dfsLcddcFRvA045q+HwxuudDvrh0Tj9WizfpVEMnVX0M0UDV59W2olS2I1tN07J3RFYuILncX5/KciRUwmvworYAnF6RPk4dhGpdIHVYkLh83Bxcngq5nglAa4UBx/OhNitV/7LNuhQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(5023799004)(921020)(11063799006)(4143699003)(261102123227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261026140227099003)(261009223027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVErN3lmNG1BdXlFTVdkNmw2S2cvQkxxc3VybUgrSXhKdWNtcEhoY0c5Q1Zw?=
 =?utf-8?B?SXFUMVIyVWUrVmM2Y1RDT1JlcGs3bG1NTFYvamVYQTRFQ3lDM1JFRHIydHU2?=
 =?utf-8?B?Ym5SMjlEYmNVQVV0ZlVaZWlTMDZWODM5SzVJRjN2TnNXaGVJa09JV04wUUNp?=
 =?utf-8?B?WUNKdWVtZGs3a0Y4Znlpd2daTmJidU0wUUd2MUx6eWlRdkNsazJWME16SVk2?=
 =?utf-8?B?d3hSMy85YjlWSkVONXpnb3Q0NkF3KytETXliMlQ2ckNXdGNXZVp2M25kNCt2?=
 =?utf-8?B?K1lHdDFUc3N1a2RGWGJBclNKMnBnckVNYW9HMFFmRVd3eTlLV1R6RUdSU0dw?=
 =?utf-8?B?MmlZNldzdDl3LzM4QVB3bVc2QTZZYmhKM1o1N3k2WHpQd0dEUUpHR3lSbStu?=
 =?utf-8?B?SWwzekNLRHEyUENxOTRoaGNhaHZJcjhIdnpXcWdoNGRlWlJoVkFETnhpbTJt?=
 =?utf-8?B?ZytpY3BYS0JmVzJ1OVkyK1pvNTZDdGpWL1g5UVJQa1NNdjFNejYwbVozaFpl?=
 =?utf-8?B?T1AxSWVhcHRvNkJMdGRSTi9aL3pQK2lzd2hMYmp2Y3ltMTJSUVlRd3lJbzRs?=
 =?utf-8?B?ZFZCTVlLb3JDdEZBSzRSU292NmxlQ2FWbGpYY1dFSEtYbm5nOHhZWkVKdGR2?=
 =?utf-8?B?Nkx0STZmaTFpZ0FIV2I4eDFLekJXbXJsU2YrYktpZHlvMnNDK2dXOUFIVjA1?=
 =?utf-8?B?NkpScmU4Rm1mM0s3ZEZlQ0UxbFkxbldWNnI5MmJ0dFBCOCtRNHdaVGxNZU1Y?=
 =?utf-8?B?QXZPbE1qSXZpVEllaTN5QlhoeEtQTDJac2pzaHdTcXRtNzd1YU05eTZXa1o1?=
 =?utf-8?B?VmxYUVNnVDdxS0hkRDExSG9qSlEvOS9ickpaa0dkWG95Tk1rZ3gwdGhucTEz?=
 =?utf-8?B?a3B4N1lJK1NhblJMQVg0U04zYXlYeGtneHNzSUJ3ck5PTklsTW05TFhaYmhM?=
 =?utf-8?B?ZVZWUGEzMDJ2Nml1dGpRRVRyYXltODRZTTVEakVZWnRkVHlKcGpBa1JXUnRk?=
 =?utf-8?B?U2tRby9lOGxPalZWdkt6cllZZHorVWdZTUJ4c3NBamhhekpvODdMMDZ1RUZI?=
 =?utf-8?B?c2tTK1pxNXM1ZndzeVdyQnc0TnJMTnloT3pFL25jUE1GNXhRWW1zQytEK1ZY?=
 =?utf-8?B?MWJRQkRkV3grdDYrdVNOc2FRQ1hKK3J1bDFtS29nUVNDUW9rMHZWZWhlUW5E?=
 =?utf-8?B?eXpaNjRpNGxLRnlEdmZVaW10bFJ3T1dOcE4xa2R0RXUxdng5RCtkNWV5MHhF?=
 =?utf-8?B?Tkhtc3krZjliSWQ4aVNlVjg0dGJBRG43RUhZcmkrRkNPMGhvK2dCOW91eTNm?=
 =?utf-8?B?MERQSUk0WUNUcVlRTk93LzNwTENCYVAwYkhoU0tncVBSdEpqcnhSaDhQWjZJ?=
 =?utf-8?B?b0Y2NTBobG5HZVhpU0x5NVJPRWNta1piNGhYbkc0TmVOZ0tDRmhxMWcxejJm?=
 =?utf-8?B?dEE3dTJuNit2cHE2SzhySC9CeFVzLzFvQlljT2RTa0craGc0aUpSSnBoQWw3?=
 =?utf-8?B?emJ0WTFRSEpNN3ZXOThab3N3RGpLYTZYYWpSRVVRTjNwT0FuWE8zTjBlVk9G?=
 =?utf-8?B?US83RGNzNktwaUR5eUZCcnFKck9kUmZZRGN3c1FybmwzaGtKc1hZMzIvRmJV?=
 =?utf-8?B?L2paRVR0NDlFT0x3UEg3Sk8wakJQcVgxRURVVlp6VXRSdkY0dytmY2ptN3J0?=
 =?utf-8?B?d3RlK21FdDdQdmF6OGhrT3ZDZXNSaktmZ2RrMEtia0hoN3p0ZktNaFpjV0lH?=
 =?utf-8?B?YjRqYWVZY1R2dEt3QkN4ZjhqVml0dkZDMWdxd01kb0VEMjliRnJCNko0b2hD?=
 =?utf-8?B?dThRZlB1dm85Q3hkcjVWV1pwSTRIVGRkb2l6VTVPL1A2cUIzZExVN2JkMFZI?=
 =?utf-8?B?SitjeDZIaUVENnorckpwT1ErT2ZUMDdlNFhoUFFDMmxCbGtLSWxrbjBTeXEv?=
 =?utf-8?B?M2JoOTBPbGlValJ4cDJXUXI1S0h6alBjcllEQUNyUlFLd2F4T3ZJUXNpT2k3?=
 =?utf-8?B?c0tadjJHNW1FSVZaTkg5dU5VUlgxOCtLc2NvUVFJWWRwWW9YcW9lVzNGcU1i?=
 =?utf-8?B?NFByZys0ekpQZHBBNkI1bFhydDV5REMrWDlvQWNwNkFVYjNESy9XNE14TkFj?=
 =?utf-8?B?dzVBRmo0bVo4MTRXL1J1djV6YmVsbDAreFE4bnE2QUxwVDJmMmRZSCt6cERj?=
 =?utf-8?B?V1RjVGRtbVk1UXF1SXRCTDVrdStHMGJpNXlJNit3SExqbEQyQWUyaEIrcDJN?=
 =?utf-8?B?SmVxczBZZHpDR1kveTBUbjhjcTJwVy9oeUd0V3JsTFhtL2NJa2F3SUo5cXE3?=
 =?utf-8?B?dk5adWtGaFJpZlA5bkFLclJiR25jdkQ0eURCeUxtSnQ1NWE4NUlWUEZXa3Iy?=
 =?utf-8?Q?JEWkLnjP1udtUyLM=3D?=
X-Exchange-RoutingPolicyChecked: zm3jfE8vJgf3vIfgf/7NqSz6yM4brxakVZcX1OiGnlyD8IumT/EMg9wOUErd1sV6xRAIsDzQdj8zleASDq9aQj0rnQZjrYChFBoTXfJqAwEX6TIk90+V1wj+kSMfCggtFq62X1ZpSoZnduFSwj/1WJ2lzlkA9uDVQTqeraHcLugaGB9RCXrQegT37ppWx9J4DUyxBG7IWqx7zq/Go7enWthwALrrReVUL/icpFYUtUqgwIYFpx2LwHH2YuQbSTfkBZbuWDUhYpjN+obFqTlzCPYGFwGtYvbqMFCBXx8Z03K2TdouCVVn4HY5PWtI2gw+hkXRTTUM0JkrftJy34UOBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d8dcc2-5ce2-4c6f-c81f-08df3b6bb5e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:36:31.0792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYRfQfdGfIpryxBT+Bm8i8lv/cweMWWBo/bYX4xHfZ3UwFN+0oZINRBsc9JqPjLFeGH79Sk7vKICuaapxO2W7uOGBmJbfbfGRXIq63d1wEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9204
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/2026 12:04 AM, bot+bpf-ci@kernel.org wrote:
>> net: mark skb NAPI IDs independently of busy polling
> 
> TL;DR: Commit message only: it blames e68b6e50fa35 for gating skb NAPI IDs on
> busy polling, but that gating predates it; 97dc7cd92ac6 introduced the
> dependency. Suggests rewording.
> 
>>     net: mark skb NAPI IDs independently of busy polling
>>
>>     Commit 97dc7cd92ac6 ("ptp: Support late timestamp determination")
>>     added support for deferring RX timestamp conversion to
>>     ndo_get_tstamp(). When the timestamp is consumed, get_timestamp()
>>     uses the skb's NAPI ID to find the device that owns the timestamp
>>     cookie and invoke its callback.
>>     Commit e68b6e50fa35 ("udp: enable busy polling for all sockets")
>>     gated NAPI ID bookkeeping with CONFIG_NET_RX_BUSY_POLL. As a result,
>>     when busy polling is disabled, the skb may not carry a usable NAPI ID.
>>     The device lookup then fails, so the driver callback is not invoked.
>>     get_timestamp() falls back to hwtstamp, which does not contain the
>>     converted timestamp, resulting in an incorrect RX hardware timestamp.
>>     Record skb NAPI IDs independently of busy-poll support to support
>>     drivers that use deferred timestamp conversion and future driver
>>     features that need to look up a device by its NAPI ID.
>>     Signed-off-by: Ding Meng <meng.ding@siemens.com>
>>     Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> 
> This isn't a bug, but is e68b6e50fa35 the right commit to name here?
> 
> Before that commit, __skb_mark_napi_id() / skb_mark_napi_id() was already
> inside '#ifdef CONFIG_NET_RX_BUSY_POLL' with an empty stub in the #else
> branch, and struct sk_buff already had napi_id under
> '#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)'.  That gating
> goes back to 8b80cda536ea ("net: rename ll methods to busy-poll").
> 
> e68b6e50fa35 only moved the socket-side sk_mark_napi_id() out of the ifdef
> block and added sk_mark_napi_id_once().  Both act on sk->sk_napi_id, not on
> the skb.
> 
> It is also about six years older than 97dc7cd92ac6, so the message reads as
> if a later change broke the deferred-timestamp lookup.  In fact
> get_timestamp() has depended on a busy-poll-only skb field (skb_napi_id()
> returns 0 when CONFIG_NET_RX_BUSY_POLL=n) since 97dc7cd92ac6 added it.
> 
> Could the message say that the skb NAPI ID was always busy-poll-only and
> that 97dc7cd92ac6 started depending on it?
> 

I think the AI is reading a bit much into the commit message. Clearly
the bug is that 97dc7cd92ac6 depends on busy polling. The wording could
be slightly more precise to not imply that e68b6e50fa35 actually
introduced a problem, but I think that is a bit of a nitpick, and not
worth a reroll of this work unless something else needs to change.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41989099174

