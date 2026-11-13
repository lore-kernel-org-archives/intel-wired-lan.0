Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43BD60A2604
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ArIp1abX;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eKFEzN0u;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VPxIeJeq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F617408D2;
	Fri, 13 Nov 2026 18:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNEMYkxLfS_O; Fri, 13 Nov 2026 18:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BAD09408E0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794594919;
	b=NiMHS+DwyOPGZNw5aOtAtVpL1eqpDlnrmDW+Wj6I1CRfpyL4KL8N56F1ZnvNQwhY3hWu
	 Dx4Jsk2KguW7V774bDszenTnhgNPK4UBPdbtFrytnOxw3oVDwUIyQMygNyvlMqur8/BiH
	 qDpqU9vds9nZWCklvvDExLdqcp9/pKV4CFJ1x/Z/VHXve3liVyp+N37aTShOnlT9wEw8v
	 jVzeSKCPqtsr0yXG5pcL8+tzrir7RFgrRvdTANwzZbjwkictf2bfc8XqBA89Wn4UPDvb2
	 I8WNB62b3dkF2GZoDRXUe8yjHlpSf66Pb7dsC5Rtz4DopvZw4djllw4seGGfcXwFQfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794594919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=FKtX6p9IDwKKULOXOvEjoiHlqRjmObP3HxAY1uO8o0Y=;
	b=iH4Y1pDoMeDnJ6xX7og5AxMyhNobKW6+YqM5yvtm2APxKk61j8ElPzElv1oAW4elsTTe
	 SJpowO4krBWvVDv2My/4bCszBLuI56myYOasTUxOWa39rbWmH+k6g/1QgkH+aeaLVE18w
	 9P+Wi1SnqYzDiv0kYcykoMAqiY464+sDnEYWTZVwwMUpE99BzoXlUjstsRMNSQkC5lgWc
	 X9w7koQa/DK9p+rm+3MoVeSJm/b2EWKCjmlExnhheDDBxqrfDcFRKLzMc6A36BYeqFYlU
	 bLirFzZVkkvPkwsKQDyqQiTnjwzX9R0FNrTi0x9yicgoxSEYmNAybagd/pP8+m9Jq/g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794594919;
	bh=FKtX6p9IDwKKULOXOvEjoiHlqRjmObP3HxAY1uO8o0Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ArIp1abXLCZlGsBtsn6eruYmy4lx6BJ51CdJ6R93HS19f2z5crUcptaKN/ymd9Qw4
	 ua+NEeGt5oY0cOvUGgH64yyHTqrfQH2xBmTcRKQZZ172JaIrAh0EpRM9I+vwLNw92E
	 bhMntUiGFMcWQXS+k/+FjeqU0HcpbI+wHF+zAecEbLIxSEVkGAfJUueCUsOhB/g1CM
	 y/d8jxIQQJZpCGLZdd6eL3N8gfvktbXNldj6JfCImeut9muXwy4Laaj1Yfh4o1hrN0
	 c2ANDTI7YG2FxsxqgN65rgdcLnFAje8VGhMC2iGjTYZz7lFh+X6+7SjQDN7cbjT5Rq
	 VZKmotvyAT9rA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAD09408E0;
	Fri, 13 Nov 2026 18:35:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F298B2E5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 18:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7C0E60DA3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 18:35:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S2e_PUQFB6s3 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 18:35:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 531E960623
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eKFEzN0u; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=VPxIeJeq
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 531E960623
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 18:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794594918; x=1826130918;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iE3t2CxtAQBaQMiNHdWxD5b73Zc+wQ/kxmYHdD5JxaI=;
 b=eKFEzN0uY0Vgbrw/eD/6jFWjxEd23w0hOLfINbzUU2F+T2tF+80yeXvA
 00xdpa9kUFJy0DOHwsYspEHNic8IhtmXr6RxZUSwQmvRfFWdnStZ/5Mz9
 PASVElg1I44BaULN4aLpcRUcqpAuQ3L0QkR36RW81p40SswQmd5vuLnuq
 0V0wJUBsFKFIodJclTfSvK9K7sXcXWptOjqybN0Q8p2K64yibo/ivFuIt
 5AE+uc0NdGonlrtmnjsGzw11XlPaNbsw1Hsm0Efm53dn3hHKQ1dL8G7W5
 nLVutYC59SQGidVV5CdkL8O+UKbcyUIsrwKpeaq6MpJSaWQLrFIWbVQKx g==;
X-CSE-ConnectionGUID: O7x/CKzISOSrTgO2LNjRhg==
X-CSE-MsgGUID: OxgIsA8oRiquXKzNRIUiUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3419357"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3419357"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 10:35:15 -0800
X-CSE-ConnectionGUID: 0HnF5ovmSCeAtl1pvIXUNQ==
X-CSE-MsgGUID: aNLAHQ/ATle39MSp1P9SOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9003030"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 10:33:20 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:33:18 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 10:33:18 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:33:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKtX6p9IDwKKULOXOvEjoiHlqRjmObP3HxAY1uO8o0Y=;
 b=VPxIeJeqLXLRho1OBQwodZ1fqStRLHEM5cBXZj4FWMVOlkRZlyKyBHE+2mWdRlgS7pDBhnTnZ+hKscfC4b8gpLaz5eczf9oe/GZzlg0CVjjTSx0Y7/CDi637oBe4dlvFK16Gu+a1nYfvsJvLr7RxhJ4BmgwSguHEEcVe4Zs2LXA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) by
 PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 18:29:04 +0000
Received: from DS0PR11MB6469.namprd11.prod.outlook.com
 ([fe80::ee3c:8422:6754:29b0]) by DS0PR11MB6469.namprd11.prod.outlook.com
 ([fe80::ee3c:8422:6754:29b0%3]) with mapi id 15.21.0592.010; Fri, 13 Nov 2026
 18:29:04 +0000
Message-ID: <6bcd0c58-7110-480d-9fc1-0abe0dd5a354@intel.com>
Date: Fri, 13 Nov 2026 10:29:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] idpf: reset mb_wait_count once the mailbox is up
To: Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Madhu Chittim <madhu.chittim@intel.com>, Emil Tantilov
 <emil.s.tantilov@intel.com>, Joshua Hay <joshua.a.hay@intel.com>, Alan Brady
 <alan.brady@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Willem de Bruijn <willemb@google.com>, Shailendra Bhatnagar
 <shailendra.bhatnagar@intel.com>, Pavan Kumar Linga
 <pavan.kumar.linga@intel.com>, Phani Burra <phani.r.burra@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>
References: <20261109-idpf-mb-wait-count-v1-1-c6584754df78@debian.org>
 <20261113174251.GA18859@horms.kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20261113174251.GA18859@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:303:16d::31) To DS0PR11MB6469.namprd11.prod.outlook.com
 (2603:10b6:8:c3::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6469:EE_|PH7PR11MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2ffaf4-07b3-4e32-043c-08df41b3fe95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|23010399003|376014|18002099003|6133799003|22082099003|10067099003|11063799006|261028144727099003|56012099006|261021135927099003|261026121527099003|261021121427099003|261022105027099003|261026140227099003|5023799004|4143699003|261102123227099003;
X-Microsoft-Antispam-Message-Info: sIWLQlgzC3q56sZcEdoilMxvnv3Fmlm1cemUP8IACM0qQLA+uvnILKVUWcN8ZNQakkEZio+PhPdT7GstvKR6CralzwKwhQ4NSCAjBPt1oDdkMg1wNrxBDdf3Pb3wk8AupMO5QqEEk/OQdDiTQx5VJvJe4jtybNK7D9XLGbnb62L/8LRC9rvm0+YDMiFcdTDmJ8saeJmj68QplvINKRZszFdom+lnr7OiDIVxbM80HFPmQ8yjsWFRHmmHFzLdRzcbFzDZQXj1Fao4bi5FCT28yy2tbhEJ9PKDfUlgaZ9H5jxoBMaV+8eG5m49Y/0YKrf7XGJWk6/DSMsJpVH0yL4TXC1hbKFnVBDA9Bj2fYMr6SdQy20slOx+0hoM8+1KSqxuZZ/U/9YV3mJ5LmPFUdKSdtYbUjVxCzZeEVe4sQ4P3+irx0Z9V54wW1Ae1snlk+k4ULp3a9wscwFyCQ0lg7RrgiSf+uqga/7niO8uIPeRV9+1wyVk9Yk5wmd1cLCeic529BdKvZ899zgBAZWlLm/yEerLi0CpddysPaxcn2jGK7LatLnjX5Kr7jNmrEKbeF+vqoFX9YsMhFhQdDu2MIU2cXJsgk+3541inq1KKHfZbMRgwc76Wu9cGyNu+14zX0SIFhwT5fR7MslUHiyFAmnj5gDU4TZ98iSo7U/6a7riCKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6469.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(18002099003)(6133799003)(22082099003)(10067099003)(11063799006)(261028144727099003)(56012099006)(261021135927099003)(261026121527099003)(261021121427099003)(261022105027099003)(261026140227099003)(5023799004)(4143699003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1Z6c1hLM2tHNTYxdlhqcURFMDJBNXYrc3YrWC91SUdaaEFWS3JaZ0JnVk1L?=
 =?utf-8?B?WWwrSUJjcmQ4MHEvOUYvRk9RKzBrNi9YdStTRjNpWUxDbnZSakRCQlB0QSti?=
 =?utf-8?B?c29jb0tjRDkyaEcxUGpWVUxUSHppTGhLUzNEWUxDYVBhOVJyRUNjNkYwOHJZ?=
 =?utf-8?B?VVgyeUJhSmlsMC9kSHBmblNnbWtudmVEMytacTRKZlVpejZjZVRtdVVNQWxr?=
 =?utf-8?B?azJjRGFmYk9SN1d4amRwc0tyVnBNUmxNbngrUXZrazFFdUE0OWN5UHpJVkJG?=
 =?utf-8?B?VjF1U2JEN1YreWdHOVNkLy9FUmo2ZFNEOWk0VjU0eE04aTFKdXdiQXdXbkIw?=
 =?utf-8?B?enFvMUpoWnNxNEFPdWVhaHNzbWswWlBoT01NVERYQlZXaTBFR0ptOTJYeHJX?=
 =?utf-8?B?aEFISHVPUDk1OXFyRXhTRG1IbHZYaUVwbzFJVjliYUF1YUtpdDJaSlFBTmxF?=
 =?utf-8?B?d0dlUXRCVS9aOTNoTmpyYW1YTklUcGhVejRpejlvOTlKS2ZTc2JGTE5xZEpM?=
 =?utf-8?B?TUFHZ0VVaG1LNzFuRWdiVis4Vmw3Vmw0NHREVEV2QTU4djMrcG44M2dJdWxa?=
 =?utf-8?B?N2dmMTN0a0hYaFJxa2RQRzN1QnRJS0t4NmF6SGNvTGZiV2ZJR1JFQ1Q5OThV?=
 =?utf-8?B?TFBqWEdDK3BXeC9sd0dHbTF4dEQydGJxcWZUQ3Q0ZnJIcmp2ZzU2K2dESStx?=
 =?utf-8?B?dlFIK3FUcWp2TlBaQWs5UDZJQmhXUWJJeWJlL0hlcGNZQ3hQSUtWa3BjWUtt?=
 =?utf-8?B?RW9PemFiMXZkRHI2N2Q0Z3IzcGFQeXN2ZWdTQnZNSlVxWEZBeUVhSktXaDR3?=
 =?utf-8?B?TDJUM0ZQN3RmQzg0SWduV2ZmNVZwL2IzWFRVc2xvTFhreW1ONFEzYU90c1pC?=
 =?utf-8?B?bXhteU82c28wU2lvOEFCT01ZRjFNYmViREhqUSsrc05sSGpzc3MxcURIVWg1?=
 =?utf-8?B?OHgxbjZlM3JQVG0vSE1YNkw2NVAzQjNORzg4eU9VaENYcHM4WFZPOUpnZnNj?=
 =?utf-8?B?RDRSV0k4ZXAwYW41Rkt3ZmhTaldXUWEvbk1pT01KV1NpSDI1emhWVHdkV3py?=
 =?utf-8?B?UXZIUzcwT2VQTEJRV2lwd3Y5ai9tU3krNURYU1RjS2N5czlmdDR2QnhLRFFS?=
 =?utf-8?B?czcwSzErdWMxRXdZNzlHeE8vdkZ0by9qdnIxeFpudEpPSFVrTm5Jcm5EWjRp?=
 =?utf-8?B?cnkyVktLUlhtZ1pkUzZNdFRoMEpsbkdrYTdjVHY4WElRVzVza01Qa0Vqaldo?=
 =?utf-8?B?RUs0bGJGNCtPSFhBdVpFYzNxeG05NytwVUtJd1IyNGFSWncyUXJFMVZpeTY2?=
 =?utf-8?B?bG9JdnJBNFFhR1k3dHRYeHVzZHd2S3dDSzFSYUdHMmtUZldZU3o2NFNBaTMw?=
 =?utf-8?B?WVpzMFA4MEppVHFGRksvUU1xSUp1UFY1M2lhQWNWVkwvNXYrd25LdEFxeGFa?=
 =?utf-8?B?YXN6c3Y3UnVwZnlYYVVBSUdXcWQ5RytJTkhQZi9xMlRpelY0YmJTR0J1QXBZ?=
 =?utf-8?B?MWk3MHZwcHdlcTVIWHlDT0FiNEdlTm1yaUNESXdiVzlzZTFDdUNwOG5ienho?=
 =?utf-8?B?M2ZRWUJwSEtzQm9YWGIva3ZubThLbFRWS1V0aWtkUWdaZUVlMG5qNVFXVkVt?=
 =?utf-8?B?Z3dMWS9aU1BxSlplN2Vsa3U0SHF1TVU3YXRLTWQ0TmRlOHlaTkh0bUtRdVhq?=
 =?utf-8?B?UE1hcWhRZVlPdTlFMXQ5aTRUako4Y2RkTGd1cEYzVjBDclNDaFp1WUVJc3lo?=
 =?utf-8?B?RWtta3kxTlVVSlhHTlJZUnZOSUYva2RsOVRzVkJvOVoweC9WSWdmMThLMEpX?=
 =?utf-8?B?UGcxbStmYXFTdXRhNlM0UWI1bVVoV0JJb3ZhNkphWjh2N0llYjR0VDMyanN0?=
 =?utf-8?B?cXRTS2JlSzNWUmFYV2hKd0NMVHBuWTFpcHNnMVU3RHJZT1ZHNW1tU1A3Zy9z?=
 =?utf-8?B?ZkpRWFVac2tsZG9GdVVrdGtyT21vZytzVDU2cEJkUURJWTlLNkZnUngrYU5a?=
 =?utf-8?B?Sm5iZ0x6K1BoMGVKV2hHakRjenRUQ2hteXNFenZMUW5OWWxDdEx5d3NRRjZq?=
 =?utf-8?B?Zzg4bG5jNXlxQWJTMWl0b2VURWNYVENZVG1TL0QrUkxOVG9sMnlpRVo1Mm1C?=
 =?utf-8?B?eUY4NGxMRU5rYmlrYUtpWFhNWVB3cVdkSUViZWU5T1VtY0FvYVcyUWxKVncz?=
 =?utf-8?B?OGJZcnhIT3EzU2Z5QjRhRWVWaTV0N2tjS1pFRVZVckRTOWtRckVUSEFuQ092?=
 =?utf-8?B?ZVdEa05icmpLVC85bHJ6YlJpR3dPbkxmcmQ5VU5LeHRaQnZuSGw4R3ZNVjhX?=
 =?utf-8?B?R3YrTlpVUnpRNUpZaFhEWk9aU2Q3M1ZQc3NqemdvMWRCellXOEZOSzRIajZl?=
 =?utf-8?Q?iGCPfZ3KOVCjXcDk=3D?=
X-Exchange-RoutingPolicyChecked: Up2BxQJ/WFbQ3YGw1UuYe66r564NexZRb2Q8fJKgq2OrmWXSWm5qvzZ9T8vwGtzezpnkNtd7gyPO+txAb4TPWRvENUWbI2Pj2+76xQ1aDKMsMTncqIB2gxHfbZKz4nJ+IYvvmDF8i7dUpLfj0+nIjG/bC1KvMj4aBQtv2HtdVyGO1q/FCQMoiqYeSqjTckoUxIpQURBqifIh/pqShDrw7bbLjThEC4s31cLEToWLQMOkr0W3B//LmxHp/yZQsRdEILomeR2wbnLTWWlnU63PNaXrnWY/KAVyT+NvkD/xo0mawrS0N8luXaoeD7SnElpW98O6XXueAyNV9AUvG53ebQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2ffaf4-07b3-4e32-043c-08df41b3fe95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:29:03.9741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Av204z9TOnXD1ha7USJ58GOLxS/Oe7b+TZO/cBISlijZFin/LRdi2RMGzRoc23BCcGlDzdsmT/KgIPoIWI1hGTCFm//RldnuyJCsFluEBe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8478
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/13/2026 9:42 AM, Simon Horman wrote:
> On Mon, Nov 09, 2026 at 06:43:27AM -0800, Breno Leitao wrote:
>> idpf_vc_core_init() retries a failed virtchnl version and capabilities
>> handshake up to IDPF_MB_MAX_ERR times before it gives up on the device.
>> Each failure increments adapter->mb_wait_count, but nothing ever clears
>> it, so the limit is shared by every initialization in the lifetime of
>> the adapter, including the one done by each reset.
>>
>> A device that fails the first handshake after a reset, and then
>> recovers on the retry, leaves one count behind per reset. Once 20 have
>> accumulated, the next failure is final, and the device stays down until
>> the driver is reloaded. This is seen in Meta's fleet on hosts with
>> recurring Tx timeouts:
>>
>>    [ 2176.496801] idpf 0016:01:00.0 eth1: Detected Tx timeout: Count 21, Queue 11
>>    [ 2176.508763] idpf 0016:01:00.0: Device HW Reset initiated
>>    [ 2237.412541] idpf 0016:01:00.0: Transaction timed-out (op:1 cookie:9800 vc_op:1 salt:98 timeout:60000ms)
>>    [ 2237.412578] idpf 0016:01:00.0: Failed to establish mailbox communications with hardware
>>
>> Clear mb_wait_count once the handshake succeeds, so the limit applies
>> to consecutive failures only.
>>
>> Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
>> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Tony, maybe this should be routed via the iwl tree?

Hi Simon,

Yea, I'll take this through IWL.

Thanks,
Tony

