Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F85C5AD4E
	for <intel-wired-lan@archiver.kernel.org>; Sun,  9 Aug 2026 09:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B59266068A;
	Sun,  9 Aug 2026 09:22:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KMsUad2T3QJw; Sun,  9 Aug 2026 09:22:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E00460616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786267325;
	bh=cT25JJXhhNxR7igipOoG4r/WzY9pGjCG2QoblrT4whE=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MpsqTrKxB6XxDAH0TT15ODNM98vgHg+d+HEhBf74Jctj+zcSQaZU8JCBbPxBXf+BX
	 AF+7uhO0f/DlHvPp9rEUgB8BRn8QUXgzfzkA3kNBY2FTBHtGH15x6hyxYdUMIQryoV
	 H/haYMcfmFzW0no7JDLKS89Ki09uiVlQPO5Tx0ObkJSBferQ/zqH26tThbXaem0EaW
	 OQlT+bFUUt1zslQlo1yXc0OA9k3VLolD3X+/e01hq6CPGjRKR+B9/XN+C22YyRv0Lb
	 mmf3wA80t5pTmTaPIvcl00ONDHQrTR8/yaoccPmX9AKum00xYx6221CTHjr0WdwScs
	 FZFfFWZpihrdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E00460616;
	Sun,  9 Aug 2026 09:22:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BC472B6
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Aug 2026 09:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A4A180DCF
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Aug 2026 09:22:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AR2exhY4VDcR for <intel-wired-lan@lists.osuosl.org>;
 Sun,  9 Aug 2026 09:22:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1404E80DCB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1404E80DCB
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1404E80DCB
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Aug 2026 09:22:02 +0000 (UTC)
X-CSE-ConnectionGUID: oMh9ufCCQ62v5jYd28OLzA==
X-CSE-MsgGUID: xl9TgdeLTr2z/CqaoUZZXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="97961838"
X-IronPort-AV: E=Sophos;i="6.25,213,1779174000"; d="scan'208";a="97961838"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2026 02:22:02 -0700
X-CSE-ConnectionGUID: yBG03OHqSli7ipHrfZcp/g==
X-CSE-MsgGUID: wDciv9fEQ4+1O3V5DjZvLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,213,1779174000"; d="scan'208";a="258913911"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2026 02:22:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 02:22:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 02:22:01 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.23)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 02:22:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Olbq3lkOYlSSn0+XXw9J1blKWORmBMzG2fIQUH+C86CrEjha2x8Je4I7pDU4LM41JS4ZHtCQcz15uMqV5V0l5k0yzIYiKzpRNbFj69ARMPjHJYjFTZJtDVKMcz41WnsGxk/IsM9n61+oGUuY2IuKgSYEPdOHqN6qjRQDqkrjQMAeX3eOG+mZfjQslRrX5+f9TV87PXuxjC9cBhHJWb6Cesi2I6DWQI0u/QDf9ynb7xPFIw2QgH67pd166jOCgM74FrQ8jK5ipzmpYvQv8QkEiOFbF/vXknPLO6AnB7xjoZbTq9CRZoMYSTC544NIPJkbHhfBqd2sh665Z4mIqSVyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cT25JJXhhNxR7igipOoG4r/WzY9pGjCG2QoblrT4whE=;
 b=f0cc+ricGgmveCPNxECUDM2AXk2Tbck0/K+8yoLzToh/tmQmlSLkMN8bW5Jp+VyXS9y0CIyQbmpNS68IXmAuRlSehltJ/9oKp9JEgEtIAcNwTClFnhuzVnkfyAz2u1+RXAilQi0GQM+jgP3pTlwA6L7cGNN6rIvRVEQLAeQVNDtlbe8heowVNJLxKfg6LZ/YG4XcbnB4f0TGhVtsTQPz0cmCE9jqJ16JAdnx6FeVjUdvHir7rG20o0ToQj0XTZ1fJAdoHaiTYhyKHdE6uKFwdue+5sjysToWoHF3YHvoYCrZiKvWWqXUjAE1/QypD/45AOCIDHaeleU46Z03yrFsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB9498.namprd11.prod.outlook.com (2603:10b6:8:261::10)
 by DS7PR11MB6200.namprd11.prod.outlook.com (2603:10b6:8:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 09:21:57 +0000
Received: from DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925]) by DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925%4]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 09:21:56 +0000
Message-ID: <835dad4a-6873-4983-af3b-ea7b58f93a12@intel.com>
Date: Sun, 9 Aug 2026 12:21:51 +0300
User-Agent: Mozilla Thunderbird
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Ivy Lopez
 <skunkolee@gmail.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260806172452.32139-1-skunkolee@gmail.com>
 <DS4PPF7551E6552AF076FA235232DAB1E95E5D12@DS4PPF7551E6552.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <DS4PPF7551E6552AF076FA235232DAB1E95E5D12@DS4PPF7551E6552.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To DS7PR11MB9498.namprd11.prod.outlook.com
 (2603:10b6:8:261::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB9498:EE_|DS7PR11MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d87e49-629e-4e80-a337-08def5f7a899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qtmo7g8/9XhSwy2kda92FBh5GDSseBNq44oLc49TyWXuDO43GDkAa5/Sds8PZt86FDXS3j2GztA+kmVbuA/h+L+czBlPpRO92/r8q/FLuoSjbeLRYBzcPr0cMEY9b2mlsPO6ba2o9TNFVB3hokb+zRG4wqPlO8liVXoJjfjxpiPrrr+3qqoztAvSy1erB6uxbuFf9qOSjeV07FNRJQcJwXUlbH4FGa43d5FPrb2vhhHYbmMz6+vZYRWk8VyVrVGKUhB5QkqTQ9sysRRBhgrLvumwSXUMmz68mGJW3TisWJxWGkCGYAPyzG5CQSp0bKXN1VeEJZYytJ6G7IqzHmxI6rC+9gx3eFDUnlELfe/LfrJ0A/DXaxP2tr5pdNt2NVY85lloU2AexfHa3tAa3ULK3I3eJ3mEKdqIwgg7kBJCChC3NbPk/Zu6p/A7y3U7U0oJ17N7TxquG6SAad69ORqSf73HJUqRy6UKKPqxbaZ5OU1OVjMo6P+bzXWzO82DesiTl92AxmCrc+aIzbX7lXv/zjs+8H2NVlw94s7A928hMmehHNPOTM/X9svA8pIrddDb15093sN9Wsm2xH/SyN2sATUUAhuQ01SPaWw2iIGm5fNKQWoppybj5wHGe/z+/ZGTn9wzGWFl0B4ZYPrEw11wki9pxyxPoA6lw1iGcI1CGHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB9498.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjJkdVFDSmd5b0ZITmVlcXVyd0N2TDhwVkxXeUpGd2Nic0tUT2VBS1ErOFVX?=
 =?utf-8?B?SjBRSWxORjRyTkt1dTBoeVBRWUwweVAyUlZxMFZEOWJDdmhsWnJBSXNTWWFu?=
 =?utf-8?B?R2FSWGJPZDl1dHBCSWV0MXZ3Rk9RdWx0cXZPOTJkTERkOU9aeURWVGZLZSs5?=
 =?utf-8?B?WkJaL3lTQkd5VndBeS9JUDE2b3VrWEduN0JGS2dweW5JTzVMYXhxRU1CVy9M?=
 =?utf-8?B?VWZENG9jWGF6SUFqbGNEci9oOHpvUHd6NllMeWJOYXQ4Y21naW1UUHdGRGY0?=
 =?utf-8?B?UHlCNzN0RWtoL1ZTWld1UXRRY0JYTWY1WXkzdHJOS3prQUY0dTZLaTRUcDdt?=
 =?utf-8?B?eHpBdnFnSDVURmtkUjM5WTVRbjczaHFoTXFZQ3hIZGoxS1JqQlN4cHVYU1Rh?=
 =?utf-8?B?M3dOQ3pCQ25XMWxhdUtmWmY3UjFlY1RMR2thYVhsU1N1OFVXenhMRDM4b08w?=
 =?utf-8?B?bjBzUWJxZUxyUzl1YXV5eUNoUElmcnF1WHdQSHZBNVhSWU9EamVLRFFaSjMv?=
 =?utf-8?B?QU1ZK0ZKcFJXNWM0V2lzWHlweDM3aEN6dkRtYXNYS3gyc1l0dnBENWhRcU03?=
 =?utf-8?B?Y3MrMDh4aHNCaVhCbGlTRDJ3SzJDNVlCTWQwaUlSUk1WY3RwRVR1MEcvcVpX?=
 =?utf-8?B?YmlFM0ozRlVvalhHMzRxSWxzN1BNa3FVWktOeGZNK3FGYmUzYm4rS2NDdWQw?=
 =?utf-8?B?UFBhR2hnSGptVjFqc2JNWFd2SGFDQnh3eFkyVW5zQ3NjdndIMkQ0Q3NPdmNv?=
 =?utf-8?B?OTY1T1pwekIzTFMyL1MrVnA5TFgrU2JxNWdXTmVRT2w5SEI2UXpEV1dUZmRh?=
 =?utf-8?B?SjFKV05Na0UvZVBVMVZGZ1hnUFUyUUtpVnFJQkxpUXlOQ3JKcHM5L2FGSmI5?=
 =?utf-8?B?amczRW1wMzk4OGY3QzNnOUpHOW8yOVlyZUczeE8xRHNlcE1oaXRsUGZVSW45?=
 =?utf-8?B?TnV5aTlYWjZQeTZUYzBOY3VpcXhDZm13NUNoQjJOZCtZbU9CdnBja0taUEV4?=
 =?utf-8?B?QldIai9VMi8vQVhydFg1WDcrT29admpEVWpuaW9MRjg2MUxtcDM2OVdzYlFE?=
 =?utf-8?B?bnVLdEtGNmF6TnVMVWk1OHNycFA3K2ZPQW5sN00rVmNDb3RRZ2xBQnF2UytC?=
 =?utf-8?B?akl6bGJ4bUpjZjJwbVNodjZEdWNJRGI5aWtKay9sZjhUcFhzcFJLK0F6dUto?=
 =?utf-8?B?NERSVC9OTk9TOFV4N2FUZkx4czdVanN3bHZLMTZZM2lFSWd4TkZGdEpBOHIr?=
 =?utf-8?B?QlQ4ZzZpWnZoSXUxOWEzUUd6anF4WkdIeEZzTndwaUtxSHdiTVorM1RxOVov?=
 =?utf-8?B?aHdqMTFxR1Q0eFhPdjQ1N3ZRREU2eEpLZ2dEc253Z2tLM2lKSERMRGZHOHZw?=
 =?utf-8?B?VUl3RWc0THFib0U5dkJUVm9GQnoyUE9kMXc4NWhyVGs2MVRKOG16SFY1ejV3?=
 =?utf-8?B?MjNRcmMwSklqcGlJOXBvVHdNSUg5dmE3ZFRtUEhKK0grbUJyMmFKMndJVDFo?=
 =?utf-8?B?eHRUS2VTb3Z4N1c1QUNLYmFNZnNrV21qL1ZnNnBHcGwvbzR4ckVKSlJOa0tM?=
 =?utf-8?B?NWpJdklpMGlIUlk3YjNqbEVTR2hSaDlwWFNpWTRFUHNFQmtKbS93emZOL3FY?=
 =?utf-8?B?azA1VFhYRlRxZnFORENwVEIwdjZudHRuTmxieSt6eGthTWtvZ04zVEJvMjdj?=
 =?utf-8?B?VHlFd3FNT0NzRkZoU1FFaFVoazUrNG1oWlFBQ0cyVzJ0UjhreWJOc1BZMlRZ?=
 =?utf-8?B?Y3Fmay80THVHekVuTmZ6cWhNQi9wdXdpYjFHYnBrcllZOTZYcHl5bURZeHNN?=
 =?utf-8?B?Yktzc1NtcjdUL2xOdEdscVVOZ3ZwZXVBMHl4UFFiOFpnSjQ1cDVqcEowVDFn?=
 =?utf-8?B?anVmcWVjcE4rR0JxcUN1aVlHN05Za2hqV01KeW1MdGFyRjZjMXFDOUtCNElL?=
 =?utf-8?B?TWp5TTU3bGV4SkhMb2JpSk5sN25Ndkk0anAzSERuZ3pvcFJpQUdqbm9KL1po?=
 =?utf-8?B?WGZZa2ZZTDdlSXp3dUlSdEMzTXZiR0VCRDRsRVk5MnlwYk9wWXBqN0N4bDhC?=
 =?utf-8?B?RTdHMVJESlFMeE85SkNIZUpZRnFwOGpqQUkrYTluTDEwWnpjbWFkRklYV0ZQ?=
 =?utf-8?B?ZXRvS2Z5S0ZWQlF4SmtQVEQrQkUxU2prL1lPS0VGNFJKVy9DZ3RPVzQxUWNn?=
 =?utf-8?B?Z2o5K3AvUzZ1ckJxTGRFUldCY3RpVTVBYzhnNUpNRXp3dk0wd0l4Sm55akdX?=
 =?utf-8?B?ZXhMOHA2UGFBSUhsS05pSnR1RWFna1BEYUxuUjRaOW1VVFJRSGFETC9TZ2JU?=
 =?utf-8?B?Um9WL2pLVWVJcWhxRWFtemZueGtKbXV1QStMOXdiUlBPR2svQlgwQT09?=
X-Exchange-RoutingPolicyChecked: JaX+t34kxMP/OzgNRxDaHAbLPxoPnpDmLkHc+YeTIk5KMYKHDT2Hw20Q4GD4I3TctBPStFh5CtCQr1T0j5rT4n6ohFwDS1Tm4UELZ0JTB7u05i88Gjygy1fVoQifasDrmomTXaTAHkadotzrLAoPibE/K0O1IDZysR1T9diRE99jBv9RzOVNM0oJEQLfENt/71hyZHkD61JEDvtMwtsAT6gnIc0SrBgmUPFx6+kJ43h/BTLH9jTrlq3VIM5wPL8eStl2be+/A5HPcjwuIEBflKUAwhyZpyoaEti6jgpVNJD9QUv8mAYoKM6hjkXb5nS+RNzp3tlI7qZu44Q/hwMSAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d87e49-629e-4e80-a337-08def5f7a899
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB9498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 09:21:56.8485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sc0LlWI3H8DenzoVuhWXGm+RefzwX7dU/h6u0HwTBNEYI3Cc/OwrXmz2ei///teaKXl7VKHhQ8mhVlTfKGrWjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6200
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786267323; x=1817803323;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EsyMg37BbiApEVaI/wZpsygBk7fpS8tcjWDlCssKGI4=;
 b=dgUsyggzaJKyBxvAPE2Hwndezd6YNo7XzpuNgr3i9UfJBQBCDqsHLwBk
 wRyiSBOfu4PhCwq9dJeiYCNEa0HSUVhcKGLs1RdDkKZvAHimCTD7f1rym
 0aGREmH8qg/o8fI8RaD+TxDW6cqE2186Kki2tR4AtvZAI7OEBkpxik3XF
 BuecwbatGc6owkldU4vh8tp73b9+T8xfp+Kcksc5okYWtFrv427Ysa+Bx
 TgPlGcaXyO3kwWN/WDyZtGeI6ZSABjaxlPk+QTNdz50G4xJF6j/xewzNe
 8fsLgMM1hn4rDt6bdCP95Huj8h5rbtGo8cyVkk8/5OU7Ar4hNsp1+jOIn
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dgUsyggz
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: fix incorrect modified flag
 check in e1000_read_nvm_spt()
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 07/08/2026 13:56, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Ivy Lopez
>> Sent: Thursday, August 6, 2026 7:25 PM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>
>> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
>> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
>> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ivy Lopez
>> <skunkolee@gmail.com>
>> Subject: [Intel-wired-lan] [PATCH] e1000e: fix incorrect modified flag
>> check in e1000_read_nvm_spt()
>>
>> e1000_read_nvm_spt() reads two adjacent 16-bit NVM words as one 32-bit
>> dword for efficiency. When deciding whether to use the shadow RAM
>> value for the high word (data[i + 1]), it incorrectly checks the
>> "modified" flag of the low word (shadow_ram[offset + i]) instead of
>> the high word's own flag (shadow_ram[offset + i + 1]).
>>
>> This can cause silent NVM shadow RAM corruption:
>>   - if only the high word is marked modified, its pending write is
>>     lost and the stale flash value is returned instead
>>   - if only the low word is marked modified, the high word is
>>     incorrectly overwritten with the low word's shadow value
>>
>> This function is used on all PCH chips from SPT onward (SPT, CNP, TGP,
>> ADP, MTP, etc). The bug has been present since the dword-read
>> optimization was introduced for these chips.
>>
>> Note: this was found via code review while investigating a separate
>> reproducible packet loss issue on I219-LM (SPT+ PCH). Testing showed
>> this fix does not resolve that particular symptom, but the flag check
>> is still a genuine logic bug that can corrupt shadow RAM contents and
>> should be fixed regardless.
>>
>> Fixes: 79849ebc0e06 ("e1000e: initial support for i219")
>> Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> index aa90e0ce8aca..87cd1cdc6f10 100644
>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> @@ -3473,7 +3473,7 @@ static s32 e1000_read_nvm_spt(struct e1000_hw
>> *hw, u16 offset, u16 words,
>>   				    dev_spec->shadow_ram[offset + i].value;
>>   			else
>>   				data[i] = (u16)(dword & 0xFFFF);
>> -			if (dev_spec->shadow_ram[offset + i].modified)
>> +			if (dev_spec->shadow_ram[offset + i +
>> 1].modified)
>>   				data[i + 1] =
>>   				    dev_spec->shadow_ram[offset + i +
>> 1].value;
>>   			else
>> --
>> 2.55.0
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>

