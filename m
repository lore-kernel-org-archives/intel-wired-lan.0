Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C4FC55174
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 14:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62B17404E8;
	Wed,  5 Aug 2026 14:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b4Y8L7P802yT; Wed,  5 Aug 2026 14:24:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 732C740507
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785939882;
	bh=rre9Fn5CbjOFBC+G47v+bAidAjjiQ4JbKxkNa+TEjGw=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xxAq3DvGF72qmk4309HAKPdH5D6NcmS4STw4O/WGH4pb9Iy7mW++zlYkBtKCZSxe5
	 KwApdOM9gAx1hCt0DrDSNZ921FxlBBUd7HgkEswYTY7R2ohsZNUSdN5LDQgaSNXW/1
	 CViuLUOSRg2jGmBznKeOETYfxjCgpQ0ElNGRtpsvN/Vh2L6JKzcf+wlgcOV0mZn30p
	 8tg1PYL0Q5z6JvbsNQNLb3pgqSJCQUxobMcNBwTQSZc5fry/Wf/bQcaXLr5Ri25anU
	 yIsKZQxqxka4IMScXJk7E1k9UlA/9BQFkQznE1pJbiT4FCGQA6kNMiN10LONMUFklF
	 fq2SLdXGIWd7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 732C740507;
	Wed,  5 Aug 2026 14:24:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 227682DE
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 14:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DFE08071B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 14:24:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L2OVvCQ_P2y7 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 14:24:40 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3A5CC80305
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A5CC80305
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A5CC80305
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 14:24:39 +0000 (UTC)
X-CSE-ConnectionGUID: 1UStrQY2RaewoEmKvEzbEg==
X-CSE-MsgGUID: vcuhlI7USQK45he/oz6Sow==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86373532"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86373532"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 07:24:39 -0700
X-CSE-ConnectionGUID: tkBzMCgkSWCCAej39s59fQ==
X-CSE-MsgGUID: 8EX/njh/RL6tId6rFukhmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="261278569"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 07:24:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 07:24:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 07:24:38 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 07:24:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/99SO7jFnkwh3KCyXU7JbxOk57H8wuKLEbmjqXwtrh//qN9BcAZeMDtHJLA5ozfQmdEBLwrYpVKP/UeiJSWC3uop1xyTAcvqfNRW5GDULueHG7fOkYR9YVL2KtmKjqVVQrzsrTHd7touExnf8ajF8RSV1FUNwXkPvg37lcsplUjeJPNCyd5lMKBnUPW757UYikSJBaWhHLO+TchFPBvAJpS0j95qOgrn4FjCx+fHPXUocc6xyOqk3nRq4waOpkNWc2puF3GTQOavN9nroZx1H0TPXZhHFfRoKhA6iR9jjkFD+In+JxmIFKZqISmwreTD+lenfTgiGf33MrZlK7iLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rre9Fn5CbjOFBC+G47v+bAidAjjiQ4JbKxkNa+TEjGw=;
 b=PDn5NvxahXUwiQUQ4zj3J68ztRyW8kVU/pdt9ynbRrVpZHGaoXM5VrjxHf+6AUo5D90LpDl4nHvX5wppSCPwhtjtp2ZgyK1QocI/q0QRej4juYF4dkmM9upGCmISchdS1IDWmtyevBBO3EcHcSLJbznOyAuZGvUmvn0hF1tzqkH868SUIfKTaHEMR9Med8tGj6GbY0ttH6M67G5NkBsyvPrSRtErwNx4RRJg9qVyr4k3SyiTlhW3ryYeyVOfoFXGnhbio9SdtkcTilYHSq3b5Ae2XKh2ShuLrc2vIdPICAeB+tgcsXK8wwkIo2xU/ZfusvRSe4LDJ7RGkv4xRjZJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB7855.namprd11.prod.outlook.com (2603:10b6:208:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 14:24:35 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 14:24:35 +0000
Message-ID: <87c1d160-5e8f-4f23-8c85-eba7949f5730@intel.com>
Date: Wed, 5 Aug 2026 16:21:56 +0200
User-Agent: Mozilla Thunderbird
To: Pavel Begunkov <asml.silence@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kohei Enju
 <kohei@enjuk.jp>, Jacob Keller <jacob.e.keller@intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>,
 <nxne.cnse.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20260505152923.1040589-1-aleksander.lobakin@intel.com>
 <20260505152923.1040589-3-aleksander.lobakin@intel.com>
 <7dfde9fc-63d0-4ff9-8c59-63af279cf85e@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <7dfde9fc-63d0-4ff9-8c59-63af279cf85e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1PEPF00005B90.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::627) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 41edecb7-e88a-4899-4656-08def2fd462d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|7416014|366016|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: uVs0tr47ccZuTRzvnheRPvW1Dtsqdhsg9PBHLrH8gkKN2IAQsyxjZfn/cJFqIr2WTsq5DSWKH4erWFuFY83l5q+zrfm9IuHuhsAi49Y5ea+cxor8Fi9glPWWl2piJAthNBUaRr+a0jkDHvsHhdtJgAs+KEeIXtEfjZ9bA0pKGAb3HdXu2mZirO5XoPt20eoD6+I93g8tpNKb09HnzijoGmvPXHMVadgmsKZkiGYkXRe/AWoMFZVQylpHfBSJeyBbUBwyaCCe0tqWzw/JEB3Ci1r5oN41bfA+71tK6FNtXecepb7zg+DbzFn4hhFitL+DiXJbFczGYuBJOFcjou5E17oKNYOnEetXTt9hdKt4cfc59/kF8fLUeXhCutN68+/OxcZZU3Ze/X6ugwfvTg6YiwxyEH6tlSlOolqy7/EVQ9+Dj1PI8yYIB/sTeONKy00p1NvRJMfgCWZSTo6Y32D/JpjKZC0+jUbv8ygj8Em0x+cKPGc1OkyzYj93OixyE17cjQaeUC8lqKINyoxl60HdBITbfexlkxOrWc9W9TU1y7p8sXJ5446kXycbRzApf95RbIGPJWhbe+yDYREo7kVfsvvSUc+AyAqYgIlzwm0LXFjc10KsNsdTp9K0njA8NKADVyos5f/rerxPvGFjo3E3WbKBR60wgtXJEpJwiwugRrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTlBTCs0STJoUHRqWWxRYk9ucmk5V1M5REFKRnYzZXpiUGl3VDRmRi9iOXJr?=
 =?utf-8?B?TGtYRTNpeUhkOHhEOUFLbkQ5dGsxRUZWaXVtc0Nqem13WCthN1RVTk5SbXE5?=
 =?utf-8?B?NitKb3drVVk2cWdZMzBYb0R4MVBNTU9zQUZTZmhPRi9OR0tBdlVPTjlEa3pO?=
 =?utf-8?B?UW5JSlVZbFJNNUxpZUJCUDlIbDRkSXh1TGZ6NmEvYTRvMWR4T0YvdDZnd21n?=
 =?utf-8?B?cVV0SEJaM2orcUN3TjFtTVRCQllBcGovOFhweWdkdzhjdmJhNzJycUN3SDdl?=
 =?utf-8?B?U3J6MW8wSTh3OXpHNUwwODV0UmNlRzhyOGJaODJQSE44M0hITnlCUWYxeThK?=
 =?utf-8?B?cEtrUCsvOXlCR0VUQ2U0Ym5yN3BhTmNzSTdyanZCRFBFNVQwYmVzNlllMG5m?=
 =?utf-8?B?OEk1dk54MDBiUk9ING9qT0Z0ejc0ZWM0WitaOC96Qzl1Z2JKQ2xhSk8xMjRp?=
 =?utf-8?B?MGVmUkR3NmJPNEcwdTg0WENxWW8vcGxwVVpZWW4vVENGMURDOXBiVVUwYUU3?=
 =?utf-8?B?NHNPZDR1d1JKbEl1enhnMzQyWU9xTDJBZFo1V0hWRk1lbkN0RlB6RlYyN1lk?=
 =?utf-8?B?YUdGZTB5a0FTaHF5c3ZWWmRvNVA1Q0JtazJ3bmVIRys1L2JIVWN2SmlWbWg2?=
 =?utf-8?B?cnltcXdqTUNZRjdxekFSd3p2UlhEWFh2NWZNUnRzd0kyZjBWYmhBSmtwWlQ2?=
 =?utf-8?B?RUJUUU9BUzFGUU1KTWQ2aHhuVmFLUjA5VnBLc3grdXJvbEFQWG5mSkU3LzZF?=
 =?utf-8?B?WTVKWDEzZ0YyNS9vRUxNandxVkVnNi81MkZKRDhvSERUNmIvbVVoM2psQWRS?=
 =?utf-8?B?Q0dFWEN4aXVtMGt6N3d2Ni9TblJSYm9BZkZxNTU4b2NYTi9xdDczdk5MTlpW?=
 =?utf-8?B?M2pqMkpGeUpNbXFpblBQMkpaRGN5Sjd2TStDa0krL3FHZGlFOWlmTmxqT2pt?=
 =?utf-8?B?dEFsdy9oVk9pNGRsUzVrVFFqcFhhcFo2Mjl5aHZxZWM2L0szbHFCeTQ4OHRK?=
 =?utf-8?B?TEo0ajBndlZWbFplZDBhMmg4UGVka2d6Mm90RGZpWVJJNDRCSFNvbDVyMWZG?=
 =?utf-8?B?N24yYUUwQ1d4MEttMUlYblFudWZIM3BvM2xiZnQ3RkI5cTZFWkRHUG8rSW5Y?=
 =?utf-8?B?bExLc3l6RTlVRVMwSVJUeWNSc1Rid1Fqc0oxQlgvMHJ6NHBWNWhrNlJWamlN?=
 =?utf-8?B?YVBRc3NBQTAzdkoySW1jdnJZZFZBc295SzVlSXlXZm55R1NrYUsyVHJ1anRS?=
 =?utf-8?B?SDJHcUxIRVI2T1Fna2treDVCdEpRbUdWL3k4bFV0aFlDQTNXTGRZWkVoNjNt?=
 =?utf-8?B?aGlkQXAxQWtiMnBTMzMvV2VIWFQvZFcrdkxBL3dwTmZsTEtHbUVUQWd0dWhj?=
 =?utf-8?B?RS9mQTBYdGFRekw3Z0x4YXoxQThJeHZaTTV5UWpiZVRVNlJtemttaHd6eDQ2?=
 =?utf-8?B?VTMzeWIvOFVDSXJrNFJHL2ZDcUdNcjQ4Wk0vZTAwMWZFNU1IRkxMcm0rWTBh?=
 =?utf-8?B?YUg4a2kxWG9qaElOSDFBRG1VZlhsS0lpMGJzbWtSOHJrYlhHUlJPZE1VZGNm?=
 =?utf-8?B?dUlSREwybnIvb1YrWWFqUHVPeWRXNFhkZGZKVXR3a0ZaUG9tL2tHYUJKdTFu?=
 =?utf-8?B?RnRLOEl2Tno0bjkyRUZjZklFbElDcjNwU3d2bmxYcmhkVTk0cUdOU0o1ODBZ?=
 =?utf-8?B?c3ZjaFI5Skc1My9PZ1ZwanpLaW1EaHB3bU9HUGdDMExNK1NDR0pya2RMbjVY?=
 =?utf-8?B?TmVoc2FrNGpxcFpmN0xhNVdCT3JSSGVSYnJhTVc2OEYvU0ZXbldVbUhKQ05p?=
 =?utf-8?B?TzdxZVBNRE9oeXhFZ1pKNXJIZU1BTTh3UVEvQlR1ZnExR2xQeWtxR3FtTzZx?=
 =?utf-8?B?TnpqMlUyQnkvY21KVk5VZ1pzUVQ4V3hyTU5NRzdyd0oyWEQxK3BDcXl0MCtk?=
 =?utf-8?B?RWJtV1dMZUxVSzdrUEJnbUhlNlFXRkJZUUxNZ1N1UHRWR1htcmV3azREczdV?=
 =?utf-8?B?Qmw4SllwMnVDUnB5V3M2VHVtWHB2QXJWNHYydE9PemZ0WFEwd0oyb0tuZVkx?=
 =?utf-8?B?TFZibFlFUVY4aWhjMlpNU3dCUDdsSWJZVzZSeDN5TW1JdnZISjJ0MGs4em1B?=
 =?utf-8?B?cXJaQkkvTmtYMDVBWThMUExhS3ZtbWVIWUZhVjBZNThqQk4vc3o4U09nRVpU?=
 =?utf-8?B?Tnl5OG90MFBQb2ZUeUYrWThWM0d1N1dZblJmbU41MFlxcGtOMUFxNjFrWUp6?=
 =?utf-8?B?Vm8xTm53SkliY0wvM2lXWENwbXg0ZjV0NXlFR2VtVTFabDBmUUh0RzJ4VXZC?=
 =?utf-8?B?T2E3eElwZm1mZkJKS0M3cXRpdXVWYkdKV3lrY09SZjd4d2hLSGp1V2dOVEVM?=
 =?utf-8?Q?9lrOy9TxAb5/rPVs=3D?=
X-Exchange-RoutingPolicyChecked: PK4sVexIjqd46q0KrhJ97O5UooblLcB44JxA4OiXY+SsxSd0spqNeaZcPS7dfV1LGegsWxCNjQ2H/b3+sfoalmGb+t6f89YrBqQrbEvmvULcICY/b7CuDASyc550c8ZfhNRPuVcId/6FObaOGUAuHZGpkgV7t3O37VKkKVlAaD4iUzqaPD3QNKgPDhbbZT+uUXR9d0Lv5MzGp39cSfE6s6++wtbkIfwcpHMFB1Y3YLmKqUEWFzuseJ4R95Yq9EWa1c8dxGiL9Q/hAGnmX5e/bxSxzY3b6ybNpKJg4kQLjpXLRnH67dAleecuWv5yUAEKyXaeycrFt0dy1PB0Sv5/zw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 41edecb7-e88a-4899-4656-08def2fd462d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 14:24:35.4474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtlZd06R5poht6rVMt6A2v7k7UayXqTN9Hkl09zAthwxxr106R+XGFagPrlQHQgfglNG4hFdVYu1vepOlRAf+OAfCSyrtqBbudQBztrYiT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7855
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785939880; x=1817475880;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LeSEZtLfwKOI5bqAHMfMKzPVKgvI0CQ+TRhMWij6SBU=;
 b=meqO6fe9tH0byaVLJgX0LzMQjHKSex5Gkc10+BC5ad5orP6pTg19zpEu
 aVAF0dUQWcyo9X1tv6oY4742xdegrd5pKtdX1mDu1iBHchafzTTvFI/Vo
 Jn7fdtuuedi1eU0JK9lqnPrV/yisxyUhYtH9tFaeR/Wm8wsl+kXrCtcGR
 TVhxoLEt+GsIH1f35dwd+eK/ypoybEvyWDKsa0dEcd34Wm5H6V/eaarIN
 +zYyl0z0VWVPO+H6jX/yV8BQM0ZA+6TxXe4zqAJbhYs47mrtag2u+w7w9
 eMsmGgvDXJN7+nxwfQVEYwSqyPJocs8tZGOHNTvOgOpEq1BDqRjDkCWum
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=meqO6fe9
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 2/5] libeth: handle
 creating pools with unreadable buffers
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

From: Pavel Begunkov <asml.silence@gmail.com>
Date: Sun, 2 Aug 2026 14:02:11 +0100

> On 5/5/26 16:29, Alexander Lobakin wrote:
>> libeth uses netmems for quite some time already, so in order to
>> support unreadable frags / memory providers, it only needs to set
>> PP_FLAG_ALLOW_UNREADABLE_NETMEM when needed.
>> Also add a couple sanity checks to make sure the driver didn't mess
>> up the configuration options and, in case when an MP is installed,
>> return the truesize always equal to PAGE_SIZE, so that
>> libeth_rx_alloc() will never try to allocate frags. Memory providers
>> manage buffers on their own and expect 1:1 buffer / HW Rx descriptor
>> association.
> 
> Maybe I'm misreading it, but providers don't expect that. It's
> fine to use page_pool_alloc_frag_netmem() and friends, just like
> bnxt and other drivers do. net_iovs are refcounted in the same
> way as normal pages. Hope it helps.

Thanks, I'll double check. I could've misunderstood and done that due to
the unrelated problem which was fixed recently in the core.

Olek
