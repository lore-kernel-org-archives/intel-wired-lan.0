Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F30606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mVjsDrS/;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kagun1L5;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gO5pQZiM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EEB2812D6;
	Thu, 19 Nov 2026 11:11:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z1PZ330dE_Jj; Thu, 19 Nov 2026 11:11:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4D246812A1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795086687;
	b=KIl/GUbB0X/M5Vuh19BF0xEymWcwXXo+Q/xbx0R3TmAn5OEFspDRP6BHUsKBu6rGgI/0
	 3WHpTy24evqPm54dUQZva0moHe3Y+9yR5rP2/PM/DCV8Ynqvg0iZk+xuq5sFsKH5Zwhx+
	 1ED1kKDdspMY2tJ+etGuzGtMpqj4YcendUQQzZ6QL74cF5+P3onvEGNBbt2LSAknx2QFN
	 55qqtZL9Cm86m7+PX0y/x5mqifzrXixnvlFsOs9P1GOfKBJD7lJcIgPSo3IlcAQp0QsQA
	 yFCqwGEzXWEu8m0kzFTcMTpza3w5prHqS0GxbM1VNzqhehUPXAqg0prCGgeViRW1vwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795086687;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:References:
	 From:Content-Language:CC:In-Reply-To:Content-Type:
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
	bh=NfCNOAZtk7pskrMBNZGe2W7FobTdyRHQHhOXR1C2nqU=;
	b=axgcOhuBPaTtqQ7FOcSgdXXS2Jzo7kiE9H/BOyResw9VufcYs+VSn8y+WihFiiHGW7zQ
	 MWCZ1P1JdZ/W2kIjXgDbJtECdvUDVpNnW4EyJDGSBEwFnvwaBNv4YufIqpqk0JfQVgafM
	 fkA9+Bez6VrvJns3Mma0oG/LBELxyjjN54tEEGBz8120E8mVHk2EY5OO8uvgifnl2GkrP
	 AUJLBLn5hpp/B0hLOTS47e1ns8tJj8RQ08D+NyQOOguq3vbheFWAuaYf4iV19N60twO9E
	 IkRlCCPGmPaCEsqr9PzBe59P7asIjYet5A9Sb/4Ohy5TVBXU5dznPFxj58h2nalZvnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795086687;
	bh=NfCNOAZtk7pskrMBNZGe2W7FobTdyRHQHhOXR1C2nqU=;
	h=Date:Subject:To:References:From:CC:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mVjsDrS/Yx+CDn7HcVbJ/jDkIalvXP12/wPIK6KoPkqDi6zoxiQXM72Ajxv6eOoOy
	 XtxKMS6N6DUC6q7gqGviy2GPOfgU3pU+iUb4UfyCPSXhpinoiJGjsCTRgO2RnGTOW3
	 P2VBSu5uIpsavalLKr7XeI9TG+So7lwZIcGnIX6gWhl8A7zNBzK/D7IHyc9M1tuPms
	 xMLv5xy1Mcmlwwyyzgm5/KDZUNVM0W3wogRGNvBnNQ1IqhhusqCNFkqZFXMfPjl5yX
	 YPXjngclxcnAf+otNDMpIi2vUyboexckVaEwVgUjrZR6wLOBZgI/n7zlZZPITFN6Vb
	 RB7K5+ANUTfGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D246812A1;
	Thu, 19 Nov 2026 11:11:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C10C2F1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 11:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5101A40A52
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 11:11:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vPxKCzaH5c5c for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 11:11:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8303B40A48
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kagun1L5; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=gO5pQZiM
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8303B40A48
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 11:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795086684; x=1826622684;
 h=message-id:date:subject:to:references:from:cc:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U87ERlUYzn1ZILUV0HqCCW8R2rpUd3u4EUPmB8amqpk=;
 b=kagun1L5hfxQ4cpdra+RZcUKSLBBiZMhJg3BaFE7E78gzW9KQfiEhjP0
 wnXe02kz/eRp1IOsBa0/CEWhZ/fqiz7JhgrnV6OSskUC+LyGsNMGthuFC
 a3K/w/u2GguakwPqFnT3rG2aRtoluEg2wAZ8j8qF9hawlfktMeO6LOI1W
 7p8wUy39SiSBKTfeJnCxC+nnCs6RYvGqMhrTtyMNnSR0l2XhTy8UdO9Lb
 WyzbjMyhv6lHpfXXurHeuOeaoAHD0viORXHY0Gpg3sWDYvEuADDGsKS1j
 NDSNPcJIQkkl7p2A3PtNTAuqv6GHrbhQTZv+SrwvcCOyN4btUTB82DnNR A==;
X-CSE-ConnectionGUID: pRDD8zn0Ry2+9tvK/8NPUg==
X-CSE-MsgGUID: mcUBNwW0RbK5Bu5Gse9fog==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3820033"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3820033"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 03:11:22 -0800
X-CSE-ConnectionGUID: qADxsje9SXKpz3zK8OfM2A==
X-CSE-MsgGUID: prUEc7TIRu6rMSVt50IPVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="12150482"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 03:11:21 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 03:11:20 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 03:11:20 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 03:11:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfCNOAZtk7pskrMBNZGe2W7FobTdyRHQHhOXR1C2nqU=;
 b=gO5pQZiMKosXa0c/Q85re+3KT1LgnGaL8tkESYcX5l58jzcmfQVPfrqFW5Fy2TWfpeP4tXBxnNW1yPLxLZkM6o2Pv0MuuIDuOIatqVBx7iCtkswMsQBQK140xYwFn1sA9yQUHwGlHZqn1ulujQrXU4xsmZwVjkVBnqvyBDDVSI0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV2PR11MB968400.namprd11.prod.outlook.com (2603:10b6:408:423::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 11:11:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 11:11:18 +0000
Message-ID: <d736c9f0-ffd6-4232-8bf5-06a8c7c4addd@intel.com>
Date: Thu, 19 Nov 2026 12:10:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: use the queue pair's XDP ring in
 ice_qp_{dis, ena}()
To: Magnus Karlsson <magnus.karlsson@intel.com>
References: <20261118135952.1063685-1-magnus.karlsson@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
CC: <magnus.karlsson@gmail.com>, <intel-wired-lan@lists.osuosl.org>,
 <anthony.l.nguyen@intel.com>, <maciej.fijalkowski@intel.com>,
 <przemyslaw.kitszel@intel.com>
In-Reply-To: <20261118135952.1063685-1-magnus.karlsson@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV2PR11MB968400:EE_
X-MS-Office365-Filtering-Correlation-Id: f071446a-9dea-4005-c9a5-08df462dd54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|261026140227099003|11063799006|56012099006|261026121527099003|261022115727099003|261022105027099003|261028144727099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Uaahm5Hpa1B/bCvX8dv+HdIYY9CK4w25L151kbDRjdDpOtEOdeDnl+hssOygwhGygxmYsu9Un0ZjUqLoYbEHYBy6aQNpEkMbJFhe21lkdK4oZ/I9fwT/9XKQ7c3pnGbcpek9d37T+Wa7wTFVEKq/FmSAoIEegUgYvpxxTZHVxlnGLeJHDA7Xg736ystHr7ltH1H4g+3YGao7TRbx4+9JGypPK5jxzqoPZ+1LJNw+r4WIM84eWfch39P8FxwiWl5AQmf88I5elIx8CUkMEQMLIMpfiJ3LCBEgnJq4oprlN5dWiwjquSNp/Xh+yCAwDIbMaQfEczOEm9VIKuVuf+k4ZOuE9kf5S03Qx8OaT6xQ3df9cH/zt5/jCs9/DER8UDggkAcdHS76vSJnIiqlhz0lDN3xrKhOeld9Io9lXRnIxZ2gb5uTou2LJbWOPW3KPQ8Vck8yZaa7+bIe0MhUOOSlaHKUQM0MO+rsEGijOXdBZaf1u4ya/8oM26kjmyyza1OXVfq7BWlUbwr2R5bO7BiR65Pd/FwJcX9ltXsnHVdZWZ3az/Wp+kqH4/7P9MndmOhPTn8HyHoyM1o/wbBOKWAdXSujmb6y2RQK/LiehVy+0K0dG/UYhv033miiAe1pZgCZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261022115727099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVRPVWE4ekREcW1NNkpQT3RKNGdGYkowK0x3eWVoTzJqalBJSWRwSjBQTTFM?=
 =?utf-8?B?RXlnYjNFNzc1UHcwRXphYkQrUlZ5VndpcUlhVW5KZVNJRmVlbXNzaGNMR1hQ?=
 =?utf-8?B?QWwwMkRNamVybXJKRjU2TFYyRGdmamQ0YjBwU2IzMmh4UHUxbFhTUHhZaVBp?=
 =?utf-8?B?dHF2dDRETXgwdm95SDJiK2JVOC9sWTh2UXB3bXRMTFdrTTBpVHY0RUJiNVVV?=
 =?utf-8?B?eTdpREtwS2ZpYWlhQzFJNWpGWVFmOFdldVpwK1hKb1ZVQ2thTzVCUm9UbkFU?=
 =?utf-8?B?a0hIa0h3c0MxZ1dCM1p6RXhSN2pwN1puY1Azb1R0cndXUmJNYXA1VCtjNXF3?=
 =?utf-8?B?UzNOTVBURmw4ZUJtWnh6RUVYOFZGUVhMZ1ZRMTBKQXo4cXJwZTFlUUJwSVpW?=
 =?utf-8?B?NlVQa0NqeG9JdzRLMkhhaWp1b1l6SHZrZndzNXQwclpuZlkzemxiVUdGU3lu?=
 =?utf-8?B?aUl2Tm9pbVhxOWJlbEVjTm5oTmRmTTZOQ3cwdk85WmJ1ZGdCSUNvUndpaUxN?=
 =?utf-8?B?a0hHRW9lL1Y2bmdiL0RBM1ZiOU12SHltcjlPeGN0YmwwZ0FybFhuVjdRQ29D?=
 =?utf-8?B?MU84VWpEVENwRDVYTFpBejArMWxBZGdtK29qNFo2YnFaNGUvN2JmRWNZcTFo?=
 =?utf-8?B?ZkRpWU9RZGpUZkMrL2NCVmplUnFVMzJCMXdrVUh0eHg1akZ2MUdLYUh1cmpZ?=
 =?utf-8?B?aS9PcTlMd2lwVm9BUHZQT0FnV3ErY1grc0ZoVmNBQS9MS3ByZ3o5am9ZcUpm?=
 =?utf-8?B?TnlqME9uSko4a3dSUjFGd0RRbFRVSnhXZ3RVd2tBV09MUm04NjBTelNFeE9N?=
 =?utf-8?B?MmpqSUpFNEh0WGsvZUJPdDhjNXBseEZyeWJWVXZHU0t2WEkzYUNrNitqYUd6?=
 =?utf-8?B?Mngyd0JUc1h6cGpNdWRuRlg2akViQlI3dzRTZ3d5dmF1aWQyNGE4MWMxWE41?=
 =?utf-8?B?eGtFQmlqMkRRRzA2ZFliaXJlZUNyOGdNNmJjYXZJY0NtekpLalhVWTZOanZq?=
 =?utf-8?B?Z0pSdGF2OU5INkhvNUFFMXFLUG5wY0hwRlhRaUQrbGF5a0lKSFRLTEhjQjY3?=
 =?utf-8?B?aFBsdHdTV24vU0tkOEVpcjdSVWZMWUNLU2M5M1BNV01rdjl0R2dLcjJEekR6?=
 =?utf-8?B?ckY3Q2VSc3g1Skd4cnFyQ0lMSTBxTnU0VlZNM2R4WUc4SFBXQm04U0dFcC9M?=
 =?utf-8?B?TVNoSjBwcEZ1aW1QZGRBUXZZc0NzbnhSaVA1ck44Nm9hdXlvekREQW0rOWpO?=
 =?utf-8?B?R3FwWWx2L2xzU2xLcjNoNS9ISEQwTWxlRURSMzZ5Rmo0bkdJaEE2NCtmYy9Z?=
 =?utf-8?B?MmgxN25NbkRrQlgvOUpCOURvT1RneENkN2c1dm9CeDY2aGtBSkZUeHJvbk5m?=
 =?utf-8?B?ZUhsVWxqcjgxNjY2aldSN2h2NXdKM3N4Y2FXVWVFbWhiWHF5T0dEanhHeXYr?=
 =?utf-8?B?c0tIcFFSRmwzRXU3VnlITGhscC9FcDgycHJPbG5EdUpkY01wVVo5Q2JHNkdp?=
 =?utf-8?B?aEhXTHZPZjNORDBBQ0twb1lIa3ZKSUdIT1FBZ1EwVG45ZUdINkpUS0F6cWJj?=
 =?utf-8?B?Nm0vZkRQK1U2Z1dBc0c2cit6YTRtOWhxMnF1eVJaTzE0WklNV0dPV3pWdktZ?=
 =?utf-8?B?dlVlV1hac3cyaFJlRVRiWmlHdEVYNHVTRnQwTXJGNHFTVFl4aHJhb1ZkZTAy?=
 =?utf-8?B?bDAyanBjU0ZBZnZIRDRxVXMxb0ptQmZmdWRvL0pHMVpyYkJydzluVGFrbHA3?=
 =?utf-8?B?dzNzbnE1S3U1bkVweElPL0QvOU9sQ0ZhbklkMm9lVE0rb25icGdZd3pXUW1p?=
 =?utf-8?B?YlJxM2haNkI1dXd1MEdKWFoySHJRTXdTQm1PcHBsZVoyWWZtLzQ3MGxCZGhk?=
 =?utf-8?B?OUFkK241aVJ3RE5FNVJnUTNwZkMyb2F4YWJHTFkvUklXSWlOZURvQ0ZjSndj?=
 =?utf-8?B?K2RFRk5PVmZWOSt3QjVONlZkNXhOT0dyc24vTEQ4TXN3RUpDZlpPdmZabTM1?=
 =?utf-8?B?eDgybXhac053MHN2ZVRsRmFJMDNKMDBUd0ZkOWM2ZGtTL2t0UHM4SVBKRzJa?=
 =?utf-8?B?a28wcUszb29ITTdIMjFzcGszWUxpdHpmbUJRSE1iZ0NPLzVvcXo2NkR2WVBE?=
 =?utf-8?B?cDFDK2VzWEY5VTRlVlJmcGd4Nk9RMzdFbHZVclRndUwwV0VzTEE2YjZMSzZy?=
 =?utf-8?B?eW5kcnZXOEpuelFZZ2tlK0duV0dic3BkVFNZcGw3K2ljTHNEVHJ5RHowTlRH?=
 =?utf-8?B?K0VURzhzN1hkcXBic0FKZmJPemwxZWIwNlBVNW94Y0hLaTF2WkhSVE11ZWFO?=
 =?utf-8?B?d285NFZ3eHpyWEJRTjB5RGVSQk1wTlFXK29MT1ZzRUtoZ2pJWlJqMFA5M3Zp?=
 =?utf-8?Q?SKRm6Gg7fyafg/BU=3D?=
X-Exchange-RoutingPolicyChecked: fMrO+CSEjsP0++tsV4y1ScBQ1VXKABjNiCOflDFKT1nap24IkJPkHCCAPn1UgGaOXbdD7X/kADdlA75OftnWHOBu6IEEzE9AqKiSvAwOI4IC0o3u5dS5LsZPygXI5Q9jgH5YjdfeRcMwvoo9azvg33GbV5ry2zQbWvKMcjWYXBXFccr464ANyoOFA/jFwXv21fyJ5rnVHOb6RQuXiPbwlkS/438sQbRDY/QdST+FhsXa7fjPhWE/PK/CcSf8q9HpVBNZ3BkJAgUv3/XEWLoECMYpmyj6bzpFSvCZmu3rUE6HBabXjzeXFaJIFlOmqyAHW2NHBNrHGkUJE4eYWod/fw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f071446a-9dea-4005-c9a5-08df462dd54b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:11:18.1060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7ba1I8AwGcsdibUyBr9QZN/epTExY4lDv9sVCNn4TGAGzOLnWcrx1xLUqR2ZZLRGjAfPE8WnboKZ1Osvea8VqpERT0Q8cybzy1J3da6Qb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB968400
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Karlsson, Magnus <magnus.karlsson@intel.com>
Date: Wed, 18 Nov 2026 14:59:52 +0100

> Since commit 9ead7e74bfd6 ("ice: xsk: use Rx ring's XDP ring when picking
> NAPI context"), an Rx ring uses the XDP ring that is first on its queue
> vector's Tx ring list, both for XDP_TX and for AF_XDP zero-copy Tx. With
> fewer queue vectors than CPUs, a vector carries several XDP rings, so Rx
> ring N then does not use XDP ring N. ice_qp_dis(), ice_qp_ena() and the
> ring cleaning and stats reset they call still operate on
> vsi->xdp_rings[q_idx].

Breh, I've had this for some time already on my GitHub ([0], BTW you can
cross-check with my version) and have been planning to send this soon,
but you were first :D
Thanks!

> 
> As a result, a zero-copy pool is attached to and detached from an XDP ring
> that is never stopped, cleaned or reconfigured. At the same time, another
> XDP ring is stopped and cleaned, possibly while it is in use from another
> queue vector whose NAPI context keeps running.
[0]
https://github.com/alobakin/linux/commit/9fcdb9c92bf241254679c247b401c6500e21dddf

Thanks,
Olek
