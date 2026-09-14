Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEF3C88E64
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 09:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A020605FF;
	Mon, 14 Sep 2026 09:39:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TA2ZUUDGcZyJ; Mon, 14 Sep 2026 09:39:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E24BC60664
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789378744;
	b=ASLRYk0K5pVyGc1X4i9LVZrXTtXc3vsX/BLSNu8PC3OxWzwMV0bsLtoX5WrtbqzWu5Mk
	 7vIKNnKPxpASBOGG8MkmdJ4kx7t0S98OB8QieK+t1cVUaE2wEa0EGvdkGltAwnEK9Z6tT
	 pLEa7ZdCSCKBuCAMNGUYIwen7eWvojLsOC9ppAixpebOB7c8nHKnaPwG+EDxNyRmS2/kF
	 ijgJE1Uam0+2T+xGzk95rpFQN8HF3q2KlaSBzPBxjw7H//a2EJvzASoVLK6Rt7H3kyePa
	 PCJZq+KhTdYdWlEYLegyz7l364wzcIVI+1g4aMLaXSy4P2/xFyfvYsZeo6e5czoo0aQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789378744;
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
	bh=HZti4DxdMRNWsVimcZznkN1SpjtMmQJtRlX5iwlwP+o=;
	b=Odidg99hp8aMINoQ959o4XxQASJ0srh1i5tfrWGYXo3NN0uQXy5/KYdwI+RbVx38s2kn
	 7XCmOove+IzgWv2dSn2JKZQDCjoQRLs+D6n5eC/IaQqwwN/JTWivvJJ+tQtUhuScXj67j
	 z2raA9wwSWEusIzLzpZyjJCCxfmDWuaVGBSgOLgyF4gJUjn501z3LHxdKeGqyBQtw+ep6
	 Wpjfr8Dp52LseN8+mMBV6o86njwYX9nHeYYalOgq4mh5zY6im2eCv/WEAEattaIRKOXOJ
	 Z4A0Xy8Tao/1dQRDWtaBwy787L0r8VVAJypKWNdr9hs7k8ybKiOJsyKUfvZzNEtLPGQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YmRPwDgX;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789378743;
	bh=HZti4DxdMRNWsVimcZznkN1SpjtMmQJtRlX5iwlwP+o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dy5zTwVX9bjilo3MdEchJ1n8tyv2zItLrWAX49dhrSlunzq9eSrLVv2PGj4HLCcEH
	 rWATa9V+mv2Ibs2cKimu89tSt7qzOeTuo1kJ3c5GUXCAV62MnpBhS2r7jWSnn4u2cl
	 f/1hrvEAVmX4K1mgA7l9sqFhmaXcE7CB5ViYI+XGPJ21G5V8enPTffv3SPhhtwLHE0
	 p3khj2c5qBnG+HZwp7zEKJDFy/iuVL9Mvmf7qqiQ2BIt6mnpy9pwfTA38T8M324K/z
	 tydwLNi/I/h44V1xahP45VKcZ2n3Zdy3RS8Ok+EwuIJ/IV4Em49HgDVVq787V/9Seh
	 LXPNOkUJnSXVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E24BC60664;
	Mon, 14 Sep 2026 09:39:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B78EC2D0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 09:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A12BF60664
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 09:39:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5oKBieMnRp3J for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Sep 2026 09:39:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 747D3605FF
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789378742;
 b=X98JjabsIFtpHr7OOXKnHB2mChO+66jTufvHRrik5iSdcoV+NYkD1JW26E7OO3EbvIR5
 QilH3JW1Z0EkPQFR6kWr3bFyK3yrD6b6UXp3ndlwvXAhQekJq60ZsrPfUhPZ+mlMmjBMz
 /S6zmMvBm+DvSH0V1ri0X2ZmJ8B2ijrvnHlo0aN03s2hG90Zgvzm1w0FqL4DHCLAke+bq
 5I6EdKShT84oDJ1rfEKCx7C3K8Q9BP3tikjfi2QSYFpJzvkySvPzmiiabkqdn0RBJae9l
 vzC6mp1h8Lk2wvtkDfkymjp2cVkXzcSn8F7Js9QzcOqDP4HcHuUsxRDiav+Gh8C4NfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789378742;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:From:Content-Language:In-Reply-To:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=HZti4DxdMRNWsVimcZznkN1SpjtMmQJtRlX5iwlwP+o=;
 b=bRhorvvQQn47neNCQSTY6UoNzX88bIL6z7glYabqu6floxgqMJaGTPiOAYKnY5J40hCX
 QdOIupFEDQ6aE5TSXtfO7lTMVmuMuzy4LCGWXvYN8N71VdYYncDTwpw6w6PQP9RokS3vS
 wQ2GBz40+hTKc14jivEoaXkqRPvWqnKQo63P5mkXqe4ZaglmjfRzMYLQsIwYFVP/KWk8F
 8AGMWu+uRgCDHtim5JIFD6/Q0Psg6Sa8hwEzwgo+tsRv6cVV1CHyYrgwFMlLbF1kOErWj
 +b+BoHwzpGVAkGsvFmgmFUzi8TPtf/phTqrs7bK65t6ZKcFL/NUNrOJhNV/OAuI0zRw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YmRPwDgX; 
 arc=fail smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YmRPwDgX
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 747D3605FF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789378742; x=1820914742;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NqaFDU8S8z1VyACCBaus6TI349lDg2Kg/VmwGXDgRJQ=;
 b=YmRPwDgXz1oxTWHzPI/3HErDN+x8fw01/YhCEzghv3oPhVinLnmk2ZnM
 v9CkEruus2tYhYG7pyn4HKJqj8EPXC5f/FWMkuM+tLfPAASyu+TptVGYp
 E0at87HADtBQAP5WKPVtOvqXiwdRumrgVtqxXl5cDq4h0YyTcxK5ADPlb
 Xf2AOulU0TmYRSCZ2HfHP85KfmcRUwHLc9T+l1rK08Gzb/Ef4fxKAAgQb
 b8S57GHBwA5ey57AnOt76e/G+LMwWtv++YGqh7tcxYhSaglfgJHjv+yjM
 v0NvUhLwuIxyDdvLQu2zINFh/L4KSqLNOicKP+okrIyadnFkRTppmlwTC A==;
X-CSE-ConnectionGUID: 9P7+WWNKSiqafHO95ddnXQ==
X-CSE-MsgGUID: OBYdJdPcQgONVcPG7hWEKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89663947"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="89663947"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:38:59 -0700
X-CSE-ConnectionGUID: 1zRrCjCqSLi7bJ3nZyzIhA==
X-CSE-MsgGUID: lRDBvQBcQim23Ed0PlSQFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="310864736"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:38:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:38:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 02:38:58 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyvmjfD+zrxbz6fxqBhip9QimW4gys5kFXa/jSkYxoHOuMVGswmx4fCrX6QUttiNUAjrWZDjlXTZm/zRSKJMkiQM0zdKUMDh6U94+/qZtQJh16SOEYXHyBmSN+NzckV0y9ENasuiS1EnTqGtdbpofyLJfPWqpEU3h6pdK+iFJ/LR6i/sNK7LVrk5WyE+p7D4K6/LdSEnGHctNBVHN4J4LK5JjXzQGsdJBQR5+xOT5qatg1jdEcKlHCdMZ6YFjYmSpOoP3XR4tUSexDdXow2c9N6pEXHlV1C8c2MyJUOrHwxI6H7jf4q58Pks+FLEYAO6iEJBoE73/ET4Q/lYTXZ4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZti4DxdMRNWsVimcZznkN1SpjtMmQJtRlX5iwlwP+o=;
 b=A4UH6tZahhozCk3mtRUgcad4PkodC5qqp6NWqKhN5SeTq4dzvimkQJN/4+vw4+cJsn29B6kxL+B+3/2YfnWsrRi/hvhWhMesb8u/2RPbuigfLoHMFIjwJJ95jPLJ8DaFoHdT+CzPV0GuhFKIdCCZRVeKAwVDz1GJkCbC8eBBVbBSFqt8ZYmFDOxzcMUydge0WE1658c0zZQklTYvX1dY8Yz7GuF4OUdqPIyxr3i9UX+t2jWaJj6CUs4w37F48JQfVm2q4HS/6gWvlOKGcIJ0CtnJIF+nKEPkwzTr15wpJs6TjuBDf1hTULSi8dvr+CdNwhvSM/42JgJVcim8vLiQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by PH7PR11MB6331.namprd11.prod.outlook.com (2603:10b6:510:1fd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:38:55 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:38:55 +0000
Message-ID: <ef57af47-4e98-4912-8d64-7d8ff5a0e456@intel.com>
Date: Mon, 14 Sep 2026 11:41:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ixgbe: do not busy wait in
 ixgbe_devlink_reload_empr_finish()
To: Linkui Xiao <xiaolinkui@126.com>, <anthony.l.nguyen@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20260914092626.263886-1-xiaolinkui@126.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260914092626.263886-1-xiaolinkui@126.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF0000091D.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::92d) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|PH7PR11MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a2f7eb-15d9-4055-183a-08df1243fe41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|11063799006|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: h1LDC7dW+o6qV7b9rxorODeEhNwNfcwGkGaY7RbTVzSWihRTActmJMmbMVVzw53hpRcSP+Ue+vN5yfgNFCMLHjKANTImwsK1nnU4TXNj6VA6RA17Co/qBirmkUVjaQy7SU5Eqz3nXcYkSztW1H9xD663fgcmtnfkgB0T/Eb0dbxnAVwS3p5ZnmDElqK3lV0q2JY1dFeJmOg/kDKSmPPn9p8OiNmTnItOQKZ/zwBwRXJBsVuMdiEfk9apQIT4sG+/dzi+zG3URzTaQFidFTlw7X4CiRMA+/AMlV7ckQNCjD3NKDl7lQmwUHcyYbAdL34XHnx8VvopBhsIXXQ2ng/CJRVcZB51D9zoSMyrpwEZUWcoG/hgxLf3HCowyMYz41F+55jNDBQ6PKohn2I1mNeqToUPa3qN2SfwP/5NnI/HdVIB+COf33K1cEnTrWiOJquDRqnkQ18cFK+s/NqpS+J7ugtuwjIcfh77FcFy8pgeskzl9HxttYvcVvRXo8nZlLbdcf48UETvYr/DY2mwVkMyqQOjHG/C7K8Nsfm7tIk1ZhixKbSSI1GDk54H8x55ZFDjIoTh4a/shApTGVLZChHpM2uacZbhk/CehdTdeG8QToGNVaoErB/9JhoTqHHr16Po0Kc6sC5Z8SY4XVU4YAhp9C6DNN3EVev/xSjnoi4QaUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blN4Z2VqcUdzYnlqaW1sWDBwUzBBV3hLd2NOMGNkSStOakVMa1liWkZteFpa?=
 =?utf-8?B?dzZ4VWxBR2wrazk0K1krZGp6QndBK2dyZHMwK0hicVBYMW15Y3cyWlcvc08w?=
 =?utf-8?B?WGRhVVhZd2lnSlozOS8rY05EeGNNeTB1NHhpZEc3dHpMOE5WQnFmMjBGbnVv?=
 =?utf-8?B?R3lRNS94d2IzTkZmNkl4M2Q3R2J6QTBEVFVKcFJVc2ZrNmd6Q2JaeEVMTnJG?=
 =?utf-8?B?Tnk5MTBPaU5FbnlNNFYzUXNQaWVNVVBUVDhFbXphem8rdXh0dm5XOEt3WWxq?=
 =?utf-8?B?a2NYSTJPeWlnams3QlYyRW1kQ0UvRklBZTJOamg5U0Y0Um5KNFpBa3pkNGF3?=
 =?utf-8?B?UTIyVzgyV09WbEhxTDEyTjY3Zi9FYnFYRUg2bE5WdVNtemI2YU55MTRYWnBE?=
 =?utf-8?B?ZG13SlN2MWZ6aC9SaW1SRmNPMmNuMzRjd3N5NWpaTzM0VWZzcC8xR2psNysr?=
 =?utf-8?B?MmI1cHUrdnNIbWZ6RDQ3bDluOUZGMTg3aEtMVjRWSXV3dnJaUE0zY2F6S3Y3?=
 =?utf-8?B?aDcyZjZQNGpJbnRNZURGejc5TmNsUFo0SWhkVkVZSkpMNzBQQlpQUDJtZU1N?=
 =?utf-8?B?d0xSQllzKzhjOHRtNWYxQlBjOExMZVVuQnJPTkQ2NzBtdlFid3ZVdDREK1pW?=
 =?utf-8?B?UmxieXlsN2FNZzRqckxuS0ExZlZQdWIwRmtnYnFZUFlGTE14d3MrT1NrRkVN?=
 =?utf-8?B?cnhvNVF2Y20zeFY3Q2xJVzlkQkg4eG8zRU1SUU9BODdmRmY0bldONTFxNXN6?=
 =?utf-8?B?RlJzQTRKeWMwWGplYklsd3NJMTcvL002VU5TZExZclgyOURBdm4vUXg1ajBX?=
 =?utf-8?B?SzdYSDUxWklmMGt6TVEwejVIbmxoL25zVEFFaUJHdk5sOGNvekNVb05TRHlt?=
 =?utf-8?B?L2JIMldhdFhNTlVCOXN1S1lEb2VtajFZcUtEbDI1eW0xd2Vtb2Q4ZURQSkpq?=
 =?utf-8?B?aUxkQlBUaWFodjh6QUhMV2tCNm1hakxCUVhkMHg2enNiVHZxOENNUVlHZllo?=
 =?utf-8?B?ai9iWW93dXdzZGFNNVJlRkdtNDVEZlF0NDFlZGNRZlNnbXhqV2EwWm1wTDNM?=
 =?utf-8?B?YTRReStiNUM2bUFad1U1UXljRVlTeTRKMStTM3hubTVvdlFlaDBoRllhR0Z4?=
 =?utf-8?B?b0VhVGpIcmZ5RDhRd2JGN0NSUS9NWmRWSmRxMExtSWJiYmd6cnlHZXQwNWlt?=
 =?utf-8?B?bklvWHdYaWUvalpvL1NaZVN5NHUrbE5Ya0VSNVFqNVk1TGNRc3MxdVk4RTRo?=
 =?utf-8?B?KzFqRFVvNVdXMlIyRzk5ZjBNYzFIOWVGWnRQOG8rM0l2ZUZSQkQvOFZESXhN?=
 =?utf-8?B?SnJPWkVISDh2UUN3b2FhVDgrczZ5cWkvdEkyU1VYVnNnTjQ5Y1UzMG5zak5v?=
 =?utf-8?B?ZXczd3Axa29BK0xOZDNNQnJNZGVFWXBGZm54Qm1MalByZnBwUHFGbzNjVkJl?=
 =?utf-8?B?ZHBVQTlNUkFPOWhwczRPVWRrZjZxbWx5VXZybkZHMnBQWFB5UnArb0dZVk1Z?=
 =?utf-8?B?ZEZxamdWeTBHcnhRbXNqamZ3eWRPMmVnT1Y4VUx2TmU1SHJYTVo0TG1JeVFo?=
 =?utf-8?B?NTAvL1ZHdVdUZkFGc2JtY0JYQldmOFgwbzhHMXpuR3JML0YvNllXUlBSQWhP?=
 =?utf-8?B?Tk5zMlIrYUc3UVhZZ1AxYkRqbHJXc25jN00wRGZaeVRTRWpleXd4a1lNMTJI?=
 =?utf-8?B?MG5FN2Izekk5ZkJrNGZwVDlGb1pRelJYOTFHcjBncWYvUzVtSlorQjNVclcz?=
 =?utf-8?B?RTF2RGZ2ZzZXcW4yOE5NZHNQNzFkYjhtb281Y2lVbDRMOE44Qk9scFJ5MG1T?=
 =?utf-8?B?RmltTVJEUWlEMU1pcDhYT2JlUmFMRzYvRFhGdEczOGpwUGVMQXZTcXM0bEMy?=
 =?utf-8?B?WHRLY29GOUpwM2Q2Z2lYVjV1SVhpZWJobU9yaEpwOFZ5U0taaUgyb00yeEZn?=
 =?utf-8?B?eXpJR2dPYXYxeE9TT2ErK3BWd2ZYQkNYdERleUJpczk5NmFaTVRLdDVDMEZE?=
 =?utf-8?B?SVF3ZDI5T1owaTJDTWJBak9vek4vdWtvTWRtbmdnWGE1TG4zUGZrTEtoeUM2?=
 =?utf-8?B?YUM2L0RkRi9FaEM5T3EwSk1lZUpGbUI2dGdaUEtmZnpQdGRSTjFEYVhQTmIx?=
 =?utf-8?B?d25iU2Q0Y053SUtlQ3JiWWVHb2hRNG5oU0QvY3pLeGkzQVJocVFINlo3UU9M?=
 =?utf-8?B?eDV2TWhyZ1lXV3ZoWE1DVmtFR2Zmd3QxUWlQT3Z6TTNlWXY5V1RaaTR3NEJN?=
 =?utf-8?B?clNYRFJteUluSjd3emVCaXhmMy9VZWYzMk9xK2FUZjBkeTlmQTZ4ek5ZNWYv?=
 =?utf-8?B?RmR0TU9FcTF1VTA4NXhYNy94blUwSUduQldkVTIyRHZncUIyR2dab3A5TW1U?=
 =?utf-8?Q?Ccwlmiwdtq/5L0U8=3D?=
X-Exchange-RoutingPolicyChecked: dP1OOjsPrOC7NLO7v+VY+DnD3nkJAzwAc81e36j2DHzijgll4NrJiv4ZM0jPLEk9FlgT60iL7mrCKQuemDYSySd4j9958Fm0dQdlUK90Jk5sZwZXxvjLkLRCiV9n7G/uR3vW5xbGfxrF90Rw8R0v8IHo+s3VM3omSdRKnVgJkmHyw93ajO6ktr96sefbJyUwg/hIM9u3IkZGTh61EwKGGinAHHEG7z5+wlD1tiP2IfWUdzLgzUTq2D5G3arzsLedmVm6mldANywzbfapapYidCwCGgWnTeWWg8rU2IJfteawIO7TNG0hwluOPMDSQ8w/E8MiqVHr1ioVptF+wyoB7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a2f7eb-15d9-4055-183a-08df1243fe41
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:38:55.1325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTPxf8oS9vWxMX9sWycs/z6juLm3Dk1OuWaBucZebZImqQ6TBPA/eJskktL9eNS8KQDoTAPDmX8yVwbKN6mevhUSRg4rrWTz0DkMRUrzM30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6331
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

On 9/14/26 11:26, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ixgbe_devlink_reload_empr_finish() is the .reload_up devlink operation,
> so it always runs in process context with the devlink instance lock held.
> Its polling loop delays with mdelay(500), i.e. it busy waits for half a
> second per iteration and, because the loop bound is 20 iterations, for up
> to ten seconds with preemption and interrupts to the timer subsystem
> effectively blocked on that CPU. That is long enough to trip the soft
> lockup detector and to stall RCU grace periods, and it keeps a CPU fully
> occupied while the firmware performs the EMP reset.
> 
> Use msleep() instead, the loop does not need to be atomic and nothing in
> it holds a spinlock.
> 
> While at it, rename IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC to
> IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS: the value counts 0.5 s tics, as the
> comment right above it already explains, so the _SEC suffix is
> misleading.
> 
> Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

thank you,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
>   drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> index cf8908b82f8a..7ce0a0cbf9d2 100644
> --- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> @@ -430,7 +430,7 @@ static int ixgbe_devlink_reload_empr_start(struct devlink *devlink,
>   }
>   
>   /*Wait for 10 sec with 0.5 sec tic. EMPR takes no less than half of a sec */
> -#define IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC	20
> +#define IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS	20
>   
>   /**
>    * ixgbe_devlink_reload_empr_finish - finishes EMP reset
> @@ -460,11 +460,11 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
>   		 * may be not cleared yet, so begin the loop with the delay
>   		 * in order to not check the not updated register.
>   		 */
> -		mdelay(500);
> +		msleep(500);
>   
>   		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
>   
> -		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC)
> +		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS)
>   			return -ETIME;
>   
>   	} while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));

