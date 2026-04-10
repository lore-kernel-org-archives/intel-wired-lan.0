Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE338F45A0F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Apr 2026 22:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C07C4125F;
	Fri, 10 Apr 2026 22:32:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VC3w1yx8fx-w; Fri, 10 Apr 2026 22:32:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A29441257
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775860350;
	bh=MVgNOP7ex4PWqghHtO3559iwRYvhMrkWYr2jQfhqRH8=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=K0bQRMhEF5BLgiIdZpZEINjrYhBXFHSOUDDrtrcrnuLv3jjaHxcZMuPFLPRobih8d
	 a/EEQcQxHRGH4jDT1+R+929AmE29qrwP2OXDdCbjKHTmM9b75osQZt7pkvS2AoJze/
	 MgEebQNyxCwgLsNtPqxoIgvsGiHoDr2a2qIy+3d55xbzT6EgSCP27+YHTUaw2Lci2i
	 k0PT2cqPCJPBvaccGRbSe0X5eCxTL+3WlUZ/wj56OYF63VwIIKNPthwbaVizaiQPrX
	 DJEoPZwr7BFkYy4N0fmU2sqiVXnD6+0wW0EPGQNa8qLmfYbxQQujz9E3gUwoYDcOIL
	 VBgCmRZadhW5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A29441257;
	Fri, 10 Apr 2026 22:32:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EAC6194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 22:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2FF6D83CE2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 22:32:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r9k-52gti0mV for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Apr 2026 22:32:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EFB7583CE0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFB7583CE0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFB7583CE0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 22:32:27 +0000 (UTC)
X-CSE-ConnectionGUID: l6P2YzKvTci/UkZ0SqQpUg==
X-CSE-MsgGUID: 8qQv9QoMRtC5xtqZfg9+Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="87586326"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="87586326"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 15:32:27 -0700
X-CSE-ConnectionGUID: /I5rwyVFTYuwahJryImm9w==
X-CSE-MsgGUID: bsv8ct6RS36ZTM7LnRdVtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="229090709"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 15:32:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 15:32:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 15:32:26 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 15:32:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdIzgjOGq8ncbzR6yxw40qjHpoPiBygPcxz2ayvjqeJsC/RgQS7VlaNu6uTEALFmDC0/EEkd1RGqD6rZWUf2OvyOiihwl1NOVcHWYpsw8BlAvr6JOstopcdNG7VWe+oCYwyckUSKOFZ2GPzHwdQgYVnRgkno40UiV5C9lxhuPWXMzNp1Iwj2j4i5qPLeeuWOWWr6LMKau+GyVRnInooaDOVZ8B8chk/YuY9r6cc5KCghBcI1TbpoknGNr0OSkDN8Wf+3EJ4a3rXXsrtTvn6DgLIkSlc2JQ5xYg6RJRv99B91r70Jip421XtdTjlMZSNZH7oW+NU+kqjVUox7i3+bMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVgNOP7ex4PWqghHtO3559iwRYvhMrkWYr2jQfhqRH8=;
 b=gOlD1oI4a7oL9XHK2GdzGla8dvaXVNq8K+kvLmpy4zSHK7vclSh5SWxNK+KG3WHvk5Okq6nAL/DbN6+ZaXRMUTZ63S88U4FpNYMJuo1jC4SWVlnG9Lo0Uty+kkhPfhDUf9YwJoTrJadpLsKVCMPl8Rr8gefdO9bd/frmVczyjlwZjLy4avRJZPrrlwUXQhpVhHCzOlqAVo7gdFYlY54ka6zcPFfNyj2rlFKd+OVD8V09z82Q5ycbSnr8OZRgzoCMiv7M9WDPXfKA+XOkF3E6rdAm/IwV7Q/TmI9WgVi6F2N0rlvS9hMti8gnohGaQVfxoM6cL5Wp8NX6AiBP1yxVsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 SAWPR11MB9546.namprd11.prod.outlook.com (2603:10b6:806:4e4::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Fri, 10 Apr 2026 22:32:21 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9818.014; Fri, 10 Apr 2026
 22:32:19 +0000
Message-ID: <e0691ad1-9727-4250-8ae2-dd7c8fd9d1f1@intel.com>
Date: Fri, 10 Apr 2026 15:32:17 -0700
User-Agent: Mozilla Thunderbird
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Petr Oros <poros@redhat.com>
References: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
 <20260408-jk-even-more-e825c-fixes-v1-3-b959da91a81f@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260408-jk-even-more-e825c-fixes-v1-3-b959da91a81f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::8) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|SAWPR11MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: 9710d2b5-02ce-4f07-8e6d-08de975106d7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ow1uNLz8Uvmm07d5Itc/gQ8WslRBjQiauOoEWRY6Mml31cesb2g0KRQSnSo7rUAfp8zRSplLsvjPrEGi7Sn5JrCAiFC4xEIfZkAdoIR9Ruy8lpTV0Al4iv7OfHHWKJXFvqsd/a7fhHMxvFK11WdqX8vJGZtI7ly/CQqXVJlh4CL73IXqFnJcRhrd3zQUaPr58durp30m1zbaIWSMtYF4u5BBBbz5HgEYRGuUYr90jx2AZbQSdisxNp26rVkPV8jUntcv63YJrTW0ic73wyzwwuz0Ak9Tp/95sYpNxjZcicSknFpXzkvmY5zGV7NyKdIrw16DNwtqIbsPyK/M9brqQ728BpwgivkpL7tyqdkk7+SuJSuam2iiEGLpqp/BSJdiqf14Vsc/3KnT32wiAJpi1opFYSkJjIFtgW5yNSyWZbL3yC/y+1rBjrsT+oGYOLtgQjLfPt4PHgkFUFdoxSsUf9wgyFzsGBgYDnHl8hd5NLjPCY7dWkRKnFqViIurOzswRjJI8huWeP3k/aimmdLPYI4XLo2cgDmazIjAqIs4EkoFzjbaCJxH2WtgdcZDrY+ngubJsmWS+61sBQfZYAv2Qc3Hkz+PezFUO+UTJfhj5quZnu4WeKQ5THtQxWUoS+mMmwm984ileRDmY96PyBwYI/TYK6Nr6vEhAE9Myk9ayuXqqY4pINJvcbj9+4gF7SK9D9LrScIuAh6lICSktKM8Q72WtjkdGRlH6nWVXENFZdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7579.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q25kMWE1Z3ZtMnliVVMxb0FSbmRhaUk5Z1QyUDRPekp6cktWQmlhMG5sbXda?=
 =?utf-8?B?Y0ErY3hVMFQ0SmJkZ2FaUUlBKzdVQWJ1L0hDQnE4MUg0R3BqNzJzWFBpd2N4?=
 =?utf-8?B?Z05JZnRScjhVem9KYTBlYzUvZlB5a3RycnUxcFFjTGlnOWl3bk9IUHY5bnhI?=
 =?utf-8?B?d28zSk9HbVZtM2RhUzZTS0xJNTBkRWdxcVpHTHdQNkk0ZHMrZEd5UHFCcDAv?=
 =?utf-8?B?N1dnSG00R0hCMHo0ZHFyZEZ3djRDTjl1OEJTc1RUUlF5Zm9JL3dlbk1JdmQy?=
 =?utf-8?B?Z3BpQ0J2bGxKYlZsRlJQczBYbEtUTklETXFCRkFPT05tcEQ3SUNBbzRUL3Bp?=
 =?utf-8?B?bjByOGxrTjFQQzlVTzJGeVdZcUdoZlFpM3VxT1RqU0hVYnFIZkEva0VrVzFu?=
 =?utf-8?B?OGZ3dTh5Znp0QWE3cXhSNjBqYnZsSlVFNTg4L21EbjdxSTlVajZDeGFqNTgv?=
 =?utf-8?B?eFBTTUdZZTdOYm9lN2Y3eEMvVUY0d2gxMEw4aHJpWC9zM0VFK2x4WnN1K3BQ?=
 =?utf-8?B?TjR3aUxQdDQxc25sMTVqRHhPNjdteVQvb0kzN1ZqMDBMZmRWd1BIY2Raa0Rl?=
 =?utf-8?B?S1dzOGhZNEozTFVtQzl3RDVScUM5N1plYmQxaGJwNVFKQlkydmRHSmhtNUZ5?=
 =?utf-8?B?STVpN3pqSFJxakNsdWVmVEdFME82Q2g5cERuY3ZIUW0ycWhiWEpiNGUrREFy?=
 =?utf-8?B?a3ltbHZvVU1tN1UyYUxqaTR1ZllZajdwcVd3T0VJb1JmZGRDWXJJNFVtUW9t?=
 =?utf-8?B?SVh5WTA3WjV4U1pXNWp5NjUrSnZyWUxPUXJ3ME9PR0FvWHJ5Ylk4akhIYnRZ?=
 =?utf-8?B?cTBlbXpVUkR4bUJVcGlTa1haT3k2YnFvN3JXWmd5T2ZlYjJiN0phS21lS25G?=
 =?utf-8?B?SlhaSnFzV3hHL2QxcmdkaHczcndxcG1LWEI2STdubmZXMTNoUFRJY0JueXA3?=
 =?utf-8?B?blJvRzNneFdncExldExLbE5jczVCZEM4TjJxWGVJd0FDVDlhZlEvMWtGRFFl?=
 =?utf-8?B?S2NBRWRTdHI3WktKdVYzQURORXBNMU9VY3hQblFBaUpPWkM1dksxcUtkTlM2?=
 =?utf-8?B?R2FmVlZsY0lQdlJpM0JwY0xsZ2pvTE4waEJzV2E2b2JLYTB2RkpTeTRYRDZp?=
 =?utf-8?B?VVJNNHB1OS90QjJPRHBsQ2p4OXBhcDhhV3FvTzdVQzFOWVdON1EveHp4WDMr?=
 =?utf-8?B?anhEWURlTDZvL0R0K1VYeExKN3RoemdMNHAzSy9ZbFErUUZOU244WUhsNDBm?=
 =?utf-8?B?Tk9iME5ZZ0VQbzhSZTM5NE9HZjUvOUhEU0Naa1ppRTBoODJNbVAvRGpKZFVa?=
 =?utf-8?B?amUyWkhZOUZVQ3FZcVhPUk9BUHNNTlhjQTVFSHlqZGJydTZ1QXFxZW0wcmRG?=
 =?utf-8?B?YnpkcnREZEptT1IvMFlLWHIvUis1Wjl2YUhST2Y4YWpKV1U1WHVDT2NzRGwv?=
 =?utf-8?B?L2VpRmpPYUlTRk1lL0xuU2VzWitFWE94SDZpQVVLSkJmdU5iV2RsOFVpcExT?=
 =?utf-8?B?WktqSmpHbzAwMWkzNlA4SDJBMGZ5R01QdSs1YmlYbXhVU0ZGSUd4a1RjUXY4?=
 =?utf-8?B?amdEU0Vsd2JyV2NicDBRb2FHSGRoMXUxcERtU2NUNlBYMUpxcmhUYWxoS2Ja?=
 =?utf-8?B?VW1ISTFCeDZiNWxVZmdNb0pmV2lYTG8ydEppOEVtejNkQ3MyU1IrblhiVXFr?=
 =?utf-8?B?RWwyRFFMWVVQdHhONDdlRmR6OUJLMGxvSzJKL0VFRzZjODBHT01jR2ZUcDdN?=
 =?utf-8?B?Snh3QWE0TkdTSitqanYreUtybGNTMmJMVWZuSmZyUENud0RrSkFnUmx6SDQy?=
 =?utf-8?B?bkR4M0ppK2U2dzVnYi85TDFWaHpwZVpDWW1CWXViV2JGUzFUUFNFSHN2QkJB?=
 =?utf-8?B?ZW43UjJpMXNRK1JoWkQvcFBWeTMxdDd2N21iQVlqeDFncklZR0lHMTVlck1B?=
 =?utf-8?B?ZVE2NSttY0lJTU1ka0kyb2FkcjNQVnkrQXdpRFVjdjQrVmtMTkI1eUppbWpN?=
 =?utf-8?B?aTNyblpyYitNdUo0WGVSdjRkaXplUkpNZldObVBjbUNSNVBQVXBHNDR4dnBY?=
 =?utf-8?B?THZ4TTAwVW1HS3c3VTRVZ1l3VUdVR2xJSjM4UDBqYW9WR3pJRmVrTHFoM0dH?=
 =?utf-8?B?ZmxiTytFWDBrazE0ZDBLM2JYeGQzUXdiOUhYVmVHMFNrZGZZUlhPaWFvK21o?=
 =?utf-8?B?NTRZMHorMU9TZTQzVk9HTWR0anpVeVF3ZmFoUklFeitaeUV0UE4zWG12UTAv?=
 =?utf-8?B?TkFxYTBER1lIak5ESldsUjhJc0ZuMEpwTmZMcm1ua1ZmZW5Qb1BDYVRubElL?=
 =?utf-8?B?Uno1QUhnY1ZrR3FJVUhPdGVBdC9uUUU2RVI4d3pXUXd6ZHNOVU0yZz09?=
X-Exchange-RoutingPolicyChecked: gf2CUnjzS6RSTqKfYaunN1WLzFvvITjE7S5oHocaKro6AzbBaAxUviLvur4MhCdvMM5ZqowbbPkE5nv0DKsLiTZsN9E9xIEoDNN2yuXfnpChZK2d5MKJi4VFW1C+tTySyHotZJRHk9axYCyVKkqsqmLgdjG8l50bBmiGm9i4kCLZ99VqnSxfVTIGwzlFMl2O7SZuBo0gjBTqlcINGNYgwH73ezlkeviNWIh6E7DTGwXKZrmYE9s4plXKjlmv4ZrUeX5pLfX1/5UqJqOLpra6QahcddFdBre6SCU2wAIqOeeXRQZ8WbmAaovPy1zbGDAcyQsCZWD9dhoDmgNvSixltQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9710d2b5-02ce-4f07-8e6d-08de975106d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 22:32:19.7815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAfwi3BIcfxhH/2xkfKuC6Dzq+Yvbijx/2iR35O2WU8QV4TNXTI0CR24QE4/4yMj7i3dq8Tr9VsgNhmEmczUB/tDLizL3nSqz6TUO5lKaB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9546
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775860348; x=1807396348;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sI4k6V+1k6e+jCEI2JmWXERg/KYJQXRWREVfwtqc5cU=;
 b=YSfeIRCRvwZhKbDPCOYaAubt//iueeWIR25cEbRvzNhOuXbbWyqF+H4a
 LvTgZevmJUa667GqvPVjmq80mEzSbO9VsrVfNme7orOw4zDlrFYTC/wih
 G2ivs4Qv8uKAMNWbWUus9N58P6PI+4APDXw7RWmoWeilgS3x6PPKAmJlw
 fmlT4RYYuDsjuES8wOns/Q88PJUNe8n02yrescjjp5ICI901AahrU+YWp
 nQwbO95npY0iKAb/YuX1QYsO/pyh7ob4R1Hx5P8rIdhYIxcJNqxdrR2XO
 Vhkeprt6LyxCDQrWw3f7AKwG7QGotgTHS8SiSQD8KRJQ3MRnQxLnTMmXi
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YSfeIRCR
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 3/4] ice: fix ready bitmap
 check for non-E822 devices
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
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Timothy Miskell <timothy.miskell@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 4/8/2026 11:46 AM, Jacob Keller wrote:
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index ada42bcc4d0b..34906f972d17 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2718,7 +2718,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
>  bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
>  {
>  	struct ice_hw *hw = &pf->hw;
> -	unsigned int i;
> +	int ret;
>  
>  	/* Check software indicator */
>  	switch (pf->ptp.tx_interrupt_mode) {
> @@ -2739,16 +2739,15 @@ bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
>  	}
>  
>  	/* Check hardware indicator */
> -	for (i = 0; i < ICE_GET_QUAD_NUM(hw->ptp.num_lports); i++) {
> -		u64 tstamp_ready = 0;
> -		int err;
> -
> -		err = ice_get_phy_tx_tstamp_ready(&pf->hw, i, &tstamp_ready);
> -		if (err || tstamp_ready)
> -			return true;
> +	ret = ice_check_phy_tx_tstamp_ready(hw);
> +	if (ret < 0) {
> +		dev_dbg(ice_pf_to_dev(pf), "Unable to read PHY Tx timestamp ready bitmap, err %d\n",
> +			ret);
> +		/* Stop triggering IRQs if we're unable to read PHY */
> +		return false;
>  	}
>  
> -	return false;
> +	return ret;

I got some comments off-list from Aleks about this "conversion" from
integer to boolean here. The return from ice_check_phy_tx_tstamp_ready()
is 0 when there are no timsetamps and 1 when there is at least one
timestamp available. The negative values are excluded in the check just
above this.

I guess I can re-write this to be an if/elif/else chain instead, but I
wonder what others on the list think here.

I understand it is slightly confusing to have a return which is 3-way
(error, 0 or 1), but other solutions seemed inellegant. Using a bool for
the check means we lose the nuance of the error code (and the distinct
dev_dbg message). It also doesn't let the caller decide whether its more
imporant to continue on error or stop on error (which might be dependant
on each call flow).

Just doing "ret ? true : false" seems stupid since that is literally
what this will do given that we already excluded negative values in the
check above before returning.

> +/**
> + * ice_check_phy_tx_tstamp_ready_e810 - Check Tx memory status register
> + * @hw: pointer to the HW struct
> + *
> + * The E810 devices do not have a Tx memory status register. Note this is
> + * intentionally different behavior from ice_get_phy_tx_tstamp_ready_e810
> + * which always says that all bits are ready. This function is called in cases
> + * where code will trigger interrupts if timestamps are waiting, and should
> + * not be called for E810 hardware.
> + *
> + * Return: 0.
> + */
> +static int ice_check_phy_tx_tstamp_ready_e810(struct ice_hw *hw)
> +{
> +	return 0;
> +}
> +

I got comments off list about this "unused parameter" and empty
function. The E810 hardware doesn't have a ready bitmap in its
registers. Thus, this function doesn't really do anything. I'm
considering if it makes more sense to move this comment into the
hardware wrapper layer and drop this function (and thus its unused
parameter).
> +/**
> + * ice_check_phy_tx_tstamp_ready - Check PHY Tx timestamp memory status
> + * @hw: pointer to the HW struct
> + *
> + * Check the PHY for Tx timestamp memory status on all ports. If you need to
> + * see individual timestamp status for each index, use
> + * ice_get_phy_tx_tstamp_ready() instead.
> + *
> + * Return: 1 if any port has timestamps available, 0 if there are no timestamps
> + * available, and a negative error code on failure.
> + */

This type of return is somewhat confusing and rare. Typically functions
returning int either return 0 for success or a non-zero error code. In
this case there are two "success" states. C doesn't have anything like
the Error types from newer languages.

The closest example I have is functions that read from a socket or
buffer or file, which return negative error codes or the number of bytes
read/written.

I could change this API to return the total number of timestamps
available.. but every caller just cares about whether there is at least
one timestamp, so I opted to shrink it to 0/1 in order to allow eliding
unnecessary checks for devices with multiple ports.

Thoughts?

Thanks,
Jak
