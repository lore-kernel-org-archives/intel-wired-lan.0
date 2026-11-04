Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56624606A32E
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 23:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=AUpZXhBS;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SQD1jLtT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C85940467;
	Wed,  4 Nov 2026 23:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uP0DOAF3R1eD; Wed,  4 Nov 2026 23:46:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7AF9C4052A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793835990;
	b=gAa5pXYCGRi7roSJBnCvpRD7CmmsyGsHJB8O0vywvJxTDnxu960E6/UR/J6BRhGmB+Yx
	 BF88L/0Y17JPx6TfO5St/Q4+uq76CWXFIRxjrxju7axLeH5IGTRQUBWwre3aeLURF0Oil
	 bY2YbYMeUo0VLZVX8iSBe4DmbFd4zaZe9NBGEOPCUXpmcz45hm25FCc0ufGVihngHYCcj
	 +St9Vy9DgTKAP9volsd5g0wdjNvpL9q8+GrLFaHM0RS2FNhNePwKXI37V25JEqQmFiNW0
	 P5h79zh9LJ8rLo0pVxTjnzrn8162PobTPtAuUZzMe/c2GHvtHl1TNOJ7BLHVatAbcPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793835990;
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
	bh=1zgV6KPhyiBn2IVk+0hjPXqAGXNfSnVZnDnqWstVWho=;
	b=q0/VRs3jw8E7xOIG/1LoDNGhtZ7Cs5M+kTh09OTqGUZP6kCa0etLuAElblwdghUm5hYg
	 9435Ic9LimxqubSYSpg4eOEzVGkF+sdrfGsQQ2yVBkA8IktqrJb04u/BE7mx393a/AZWF
	 hW79BMEOE91VB27LPdKRfBmTMHbwhAuABnZF8KISCMCm5NifyJCWLnejbRl97VnKnf7RD
	 utmKhibhhj5VHPSGOR8UFVBUPf4q0NgJJ1bK+6qmcRzfgIH6GgKJOkKrqSQfUbbQatZ/q
	 9nim8QIHNLz8R0h3A2r97yQzA67bs4K5H01hMGcUrTPnuisJMgbTrFrYwUdyy80zo3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SQD1jLtT;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793835990;
	bh=1zgV6KPhyiBn2IVk+0hjPXqAGXNfSnVZnDnqWstVWho=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AUpZXhBSx+TZf/XE7AfjOk3glPhiNS2J82AzZ0KY2Ov46FbhAv/Fl54kyNfZT161l
	 xLFAeM+P0B044uv9wxHG8RoyCJyLi3NuATxj2iYEEN4n1tSaGKSE4RVoBGHiJ4Et4y
	 rKuUHddnDc4oaz6D3eXdMxlssAtX3Kmhxd8qdDBaMRPmhSjiX94O1VHAkCxc3N9eYX
	 y1kn82OwgPrsmXR78Fuux5dpDtVWL33nLvdQ6s7vPZAMEGLvNqRyxl/9fl3EWUxRe4
	 +jofnP34Nz1YkF+lcyCd7/imGRtdy+t6W2cp0TI718HdEtgEIQGH4+FRADypsgEA9I
	 0iDKRWJ1Elh3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AF9C4052A;
	Wed,  4 Nov 2026 23:46:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AF6B37B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 23:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7026340467
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 23:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vryrvO8DT1va for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 23:46:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3CC74407D1
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SQD1jLtT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CC74407D1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 23:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793835982; x=1825371982;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5vsUsMhUI/ct+Bjj9VbBP8AVyxK7QiXXGUfZ4dgxYtM=;
 b=SQD1jLtT8zw2REpWqau6XDj9YljtIBtOOHtgWtkPxBzO4vX1bK5fxUEZ
 2NADyZi+n42UZHRoy3PzYf7d6mou76t0Fak8Dta1LRZLiGOtrQn66mysL
 47iBVecMGiOdCRGp2lGjHkI1heR6JimlnQtjvevCyjz3Li8PcwOnVEcnt
 r4Aj+U7eQWIWdaqTBIsqrwc28CUTMwXIoKcjVPSIcqlOv9YcfH0Eqidou
 YQHe8rm0P3W5UlCKEduqOzKldeY+0FgFAKl7vTuG+ZB9xWhoMXfMO22he
 Ryf5CaLoKXfrhGSO6xJjyoYjhl5c7aGjRFNMt4lZLb+LQYmvBLsjAdEFq Q==;
X-CSE-ConnectionGUID: aHbarbhcQzyEWpxIL7t3/w==
X-CSE-MsgGUID: bTUXmOD+QqyrBEomWiBk1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2484671"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2484671"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 15:44:49 -0800
X-CSE-ConnectionGUID: J+snlLo8Qy+p5KzHXoRvpA==
X-CSE-MsgGUID: yQi/GaU1QZqdqKcgeRB6xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7181978"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 15:44:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 15:44:48 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 15:44:48 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 15:44:50 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA3PR11MB445477.namprd11.prod.outlook.com (2603:10b6:806:533::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 23:44:41 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 23:44:41 +0000
Message-ID: <c4535137-2af2-43ad-95c3-21ed7740bc28@intel.com>
Date: Wed, 4 Nov 2026 15:44:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@gmail.com>
CC: Eric Dumazet <edumazet@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
 <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20261027121442.907414-1-magnus.karlsson@intel.com>
 <20261027121442.907414-3-magnus.karlsson@intel.com>
 <CAL4WiiqJ8K5wXutDRk_XR8KfpWMxhYF_K1eNUVqq7HuyahO87A@mail.gmail.com>
 <CAJ8uoz2J5EbN++dts69BVJoAW8+T3bEtgHC-t3EtVtURQH-QWg@mail.gmail.com>
 <auCjwM+9Y0v+kg6v@boxer> <auCj/vK5BjeRbJw1@boxer>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <auCj/vK5BjeRbJw1@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA3PR11MB445477:EE_
X-MS-Office365-Filtering-Correlation-Id: edbcc94f-1c01-4a19-edbe-08df3acd9880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|261022105027099003|261022075727099003|261026121527099003|261022115727099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ltUzYSiF9robMLVrM/w4U3JI+NwdXKajzqPUFDq8XBG/eIDnnvnehs8/vOUKMD1VcqlkdSXE+S2wnZxzkJ4j26MzffLeempkM0IDzyoTgh4ACkFai7AkD6JjQHYnZhkOP/Gb8YxfRER2fICc1wUW1zxfk8bqfLUI+yp1XAGM1s9tihlng6j7+JwtLGCOoJC+WTIfeEwW5yNVgn1ndGO3dq9TMkYAQALM2/FcxOoI83LhrX6dH5EZ/KgAwQXi1byp9wtsOAMi1dbqBR1dqiTqbjKNNPioS79u9mkO706FJZdxsTZuFtBuFjZHNXLPYkVWNHOZ6tJSHxxPB6qqWQ1WmFfQbTmrXzPkdY0iI3UGaAc1A55rtL7+6z/HfQufYYUzsDmLQrlYUEah9QT5vX46Z2ENlkbPVx5aDH6+FCRdBlqL8amD0n/cmVfw/XJBbMAlwtV/i0wBBYGuMMeKqL4JtGgVhkRX8LFaGIEQIrmO8+GuQUc+eJlPrJO5IHfjpCGxOQ8OCoJzSKK4J1RoQ+60zlLR4fLQBdtOEXm/d0CS5+LFE2bs+sAy2RyWwMIQiTsS/MtA2F6RRdnN+uD+q/X6uaRoomu5wqb/pEpu7neQ4DLaQSl2pOMhURCGmaN6Yr0TtVblWi/9GMns7sQLOA3yJ9uCuvkidqgt50io8lWQQbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(261022105027099003)(261022075727099003)(261026121527099003)(261022115727099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WSs1SjRaMEJrM252Yk5sL0dzcXd4MGlPcmQ1a0hWWTNSblhGNkZtMDdEUzEx?=
 =?utf-8?B?Y1poYnlrTTVHQjNBV1Ftb0JrZTc0SFAxUURXYUxZeXlNN0JPQlhLUk55RTdM?=
 =?utf-8?B?bHhNMTRkOTlRcE1rVGRBU0N5M3JmR0VPNlFCeDFSc3BjdVFJeFA3cVlFdDNU?=
 =?utf-8?B?QmhGSEl6dVhNYldBd010aHEzbFhKd09HRmZLa3NEejdtVWNoaUpFOFRvbUFU?=
 =?utf-8?B?dGV3N1NoWE4vQjkrb2ptNmpuYnB4SUdna3hWNDY1eWkrM2htQ3pscVZQVmRM?=
 =?utf-8?B?WW1HeVNWNkU1WmJXS0RUME0rbjg5YzV2cU5rTmpMWEo1NDBCa1g3d2luU045?=
 =?utf-8?B?UXpTMk5GUzBYUHRvSHZJZG9RUDN6d1Bvd1I0eGlHVG1MK0UyaEFMUnQyNHZv?=
 =?utf-8?B?MFl3K3JOajdiM25Rb2o1MDcxS1J6WkdLQzgyQkE2VXlMYUUyNStyK21SK1VS?=
 =?utf-8?B?NmxEbXJ5cFF5N1BsempMR1dEWCsvNVFQTWUrUS9lRUt3YjY0akM5SXlKQTVw?=
 =?utf-8?B?Q1gyQ0ZyeWpyTkg3NmlaZFAxdjFRMXVEdFl6Vi9NZWxxME0yY0pETm1PS01D?=
 =?utf-8?B?K24wM3o1YUwzZlpKbVl4Z1F6ZC9oSS9lUStZeGFzV2E2bC9YWEV4ejl1Misx?=
 =?utf-8?B?QVBWelNWaUFDRWpzZ3lGOGU2MXpNRWhPRnFmbkhSZWIwcUhYSHVGV2I2aW42?=
 =?utf-8?B?NU94bzhvejYzZXZVQ2NyamMvdlRza25MMjNQSjdBSFF0c2tNd0hVWFlpQ25Z?=
 =?utf-8?B?cWcxRGIzNDJaelpPMjRDZ1A2OC90UUpWclMrMUNtVE9LcXRsWHhtRWNpWUcx?=
 =?utf-8?B?cTRRUzFYUmx0T0ZVR3RaSU1IL0t6SlZhblhpZWEwU1pUdVFsWmVHd1kzeThR?=
 =?utf-8?B?YTJlNjE1cDdaUjFZVnNmQVFOdmh2WkxCcVZKazRKR0REOHROSUxxUUVreFdo?=
 =?utf-8?B?WFp1N2tJZVBYaXVXck5yZkM4dExPZzNHUFE4bUpaTE1rMVA4cFBXcE5pR2t1?=
 =?utf-8?B?bnMvOElpNnZBZFlYcGpvU1dpeG5aQkVadlpOUTJ2RzNzWmF2dk9TeGNONWRQ?=
 =?utf-8?B?UVRPRnF0Zjk2WjQ1RHFCR3dyWVdwUk1qcjBOeTFidnNtMTd5cmx2L0UydHdx?=
 =?utf-8?B?VnltODRUVmQvTnNIYThTMmRrTkI4UjVDTE1jTk1HK1piK00xNFZmNUpnSXNR?=
 =?utf-8?B?S0RHQUJ3dTRldkF2bFlpek5ud3R1a3RFcGRFMTZNRTR1eTFiazAxQVI5N1VW?=
 =?utf-8?B?QUdSU3JGdTdxUTRCTS9zdHVhelVKTTBXT29ESnMzQjVvY1orK09SelFMeC9m?=
 =?utf-8?B?bUVPMzVjdWc0ZlNCV0ZuTVdlMS9OTm5POTVuNk9TZCs2SGxjbk16SklWY0Jl?=
 =?utf-8?B?aGtIelduaTJDRDZLZGZvcUNBOEJiTEdQUUpaUkNSWGk1ZnNyTmphb1NWU0li?=
 =?utf-8?B?b1JPZkZsQk5uZVVFNEEzUmdPUkRVQ3dTb2VTK1YrSFE0ME5HakxOQ2N6ZmtW?=
 =?utf-8?B?cTJ5ZEdWZitjL015a2dXZnlkU3RHY0xRaEk4MG9EanhlR0tuODlKcHpaY1Vl?=
 =?utf-8?B?QXNNMlcyOFRvdFY3Um5ob01HR2x2N01XbzdZWkZWeENsa0Z0S01ZWTZxTi9i?=
 =?utf-8?B?cEdVcmVld2t3elJkQmRyOVp5d0phZVNGeDhRK2hweXljTW5zUEEvdmtYaytN?=
 =?utf-8?B?T1RrcVlWakZDamZPM25TQllTR0ZtRlZKOFdSaUJsTEZKMlpXWnBJV1BGOFdu?=
 =?utf-8?B?a0dEMGdEZEdKeDRRMlduU0VPQ2VJRFVUNytJS2p6Q0VyTjdvdVhjazJWckl2?=
 =?utf-8?B?YTJTbVpJNjNKT3FhcThQMHNtbmtWa0tYT1pTYi93MHo1cXIralBmY2FxTFRO?=
 =?utf-8?B?QkNLc2NEUWZwR2pydzJXUGUyQ0xZV3FCNHdLZllra3g1Mk82azIrd0RYYldC?=
 =?utf-8?B?RWN3MGQ5UW1VanF2L1BCbEFaK2tHblU5VGxmbHpKL3dXM0F2bURyaVQyVmFM?=
 =?utf-8?B?bDhlREorV3hKbXdHUDRySlFaTEpGV0sreFRoNzhHUjBJNzA4OHRDZWtiZStF?=
 =?utf-8?B?dlNGWWFsdmFCenFmSGNaSkZhdDJBYTNrRXB2NU1EQnZXeE1VR1Nsc21FWWpi?=
 =?utf-8?B?THZuYmQzQUdHTWtnMzRQeDB6b1NnTXcvRHc2ek8zZEdubFVrYktZYlZ1TlZ2?=
 =?utf-8?B?QU1wckUxb0Q5MHROZVJlaDZTdmdxTjNoWTB0YldhYXBLVTNEMnpiWTVMR2ls?=
 =?utf-8?B?cDVPTVZOdkxzdlFUeHF0eHFmZ014TnNhb0dBSmgyUDBiMmtVM052TDRDWEFq?=
 =?utf-8?B?SmJWa2hBRUtTVTRScGtKQzk5eUJuRG1JZzJqZVRzK1YrUXEzUExCOUJDV0Ey?=
 =?utf-8?Q?rwy0yASTXCT5s+wo=3D?=
X-Exchange-RoutingPolicyChecked: xAbipNvl7soGtb9OCsNtbB8QafzdGR8xzR8+fNJ8jUI7OsnStzPZF7J4SE8d8aYerYbLl2+Rb06Id44S7cof1JFqC/y0UeGhQyWXhV8FPez6sBdBxC+93ngc7XHUxyIdt7Qs7T8RLIwZeBuKzX5Gf8D+z7lkLQqpCf7fVt2IrcTb11po5h7oZutZczxMJIsM04RCL/L1cGHJ9web9C5s5rgd11kgX73AAroCkOflEFEIb4ev8MbbYqi6/cPXPZVD4BJxEPmYm4ydPno9DaxPMvexxU80ngT+aIJUJmqqk1dFfjSuaLvOm2h/xK9iTpJGded9BtLhWenJjRs5A2rKHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: edbcc94f-1c01-4a19-edbe-08df3acd9880
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 23:44:41.3628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWbp0etQFIxcQy/iFTs5D4nnxPc3CpsmMqnY+WtVGTUvX765l6d1aVY0zH05RnRw9C5nLQYumz8rGS8HQBicNzGDtW2VHwJJm6MZl0gaKk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB445477
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

On 10/27/2026 6:15 AM, Maciej Fijalkowski wrote:
> On Tue, Oct 27, 2026 at 02:14:40PM +0100, Maciej Fijalkowski wrote:
>> On Tue, Oct 27, 2026 at 02:56:07PM +0200, Magnus Karlsson wrote:
>>> On Tue, 27 Oct 2026 at 14:43, Eric Dumazet <edumazet@kernel.org> wrote:
>>>>
>>>> Le mar. 27 oct. 2026 à 13:15, Magnus Karlsson
>>>> <magnus.karlsson@intel.com> a écrit :
>>>>>
>>>>> That USO works for 64-bit systems is just pure luck. Currently, the
>>>>> computation of the UDP segmentation header is performed using sizeof()
>>>>> a pointer instead of the sizeof() the UDP header that the pointer
>>>>> points to. Since the UDP header happens to be 8 bytes long and a
>>>>> pointer is 8 bytes long on a 64-bit system, this works on all those
>>>>> systems. But no such luck for anyone using a 32-bit system as 8 bytes
>>>>> != 4 bytes. So fix this by using sizeof() the UDP header that the
>>>>> pointer points to instead.
>>>>>
>>>>> This was found by an LLM while implementing something else that used USO.
>>>>>
>>>>> Fixes: c91a4f9feb67a199c2 ("add support for UDP Segmentation Offload")
>>>>
>>>> Missing prefix? This was really:
>>>>
>>>> Fixes: c91a4f9feb67 ("iavf: add support for UDP Segmentation Offload")
>>>
>>> You are correct on both accounts/patches. Do not know why I missed this, sorry.
>>>
>>> Do you want a v2 with this added?
>>
>> Current policy is that you need to wait 24h with posting next revisions.
>> Eric marked it as 'changes requested' so yes, you need a v2.
>>
>> You can add my review tag as well, thanks for auditing intel drivers
>> against this bug.
> 
> Also I believe currently we should not CC netdev on iwl submissions.
> Przemek, Tony, correct me if I'm wrong.
> 
Yes. We historically were cross-posting Intel Wired LAN to netdev, but
as of recently we agreed with Jakub to stop doing that since the list
was being overloaded, and it wasn't promoting review from folks outside
Intel anyways.

Please submit a v2 with these fixes to the Intel Wired LAN list. No need
to include netdev.
