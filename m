Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1518C531C7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 10:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6581280B28;
	Thu, 23 Jul 2026 10:04:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NEka2jP1pIVj; Thu, 23 Jul 2026 10:04:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91AE780AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784801083;
	bh=tDH0PtbtjSR10zpkAgtJpJK0/2yrCfE8qVTYCw1+Ta0=;
	h=Date:From:To:CC:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=91p8Koff9f+jstFpFg28I9KYgp+xQ79529L6RtKvqbKolA9EYg7WeOCgktaUrigr5
	 nRKeVNa9DEtp4EA29EUeXDEFYaQZ8CjdIJ/gTbgcauHW4QwS0KwIBOr5qa7eiOIQ0F
	 rt2+gSwTCOBMVPZ04AvoxlowSt23wQJEdVlbkNpU/vn2b/wu2WfTJhk1dbp6ci1OmV
	 OI3MFCkJr63I7idoRNQMk5MNShbNwte+PSU1WNCF+nhqrhHjd333pgmpnR10ENk7Y4
	 mHL14SFV1urHkDy9uQJAsqffeYS6B8rkfD1OhtHPxU+FOuKzYacabR5osOKLoeC0vM
	 IRv87XxqA4ghA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91AE780AFB;
	Thu, 23 Jul 2026 10:04:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DA000786
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 10:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFF4F40899
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 10:04:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ieBReY4iNeRX for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 10:04:41 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 99F764088E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99F764088E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99F764088E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 10:04:41 +0000 (UTC)
X-CSE-ConnectionGUID: zVBn/UR6Q+m4K709sagGoQ==
X-CSE-MsgGUID: YOwO+NNnTSyAoGATmpA7Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85571593"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85571593"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:04:40 -0700
X-CSE-ConnectionGUID: 5hhM2fZwR6q89OALdILmsA==
X-CSE-MsgGUID: xNV60zH4SYi3YzUZPL9FHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="252051682"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:04:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:04:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:04:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:04:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ4tGDv1cUNW6muHrg3SbsqcloJjW2tmsvG6bcdMKSvSRx1PrzOEuQpWlMx4G4YlT6UKp3Ve51m7f2q0VHbDz7zZm5BkkvUCZ4H5eg+ytkh9EWATJiCihdX9hUJQItsrjADRTSeRT/R+6yirGA1L0E66O8MrzCtku3pY9bvPp7r6GjvWrjdsRc/hPZsYGKTFMpcZeGZ/kTynF7d7XIWuqTOGZLV572goFMv7+Fy+9EZTz/Ae0h6PnIUkq89IejzkO3cY1kaX4EoADw+cnIEJhEWIn1xGIrK31ssgfrRqhh2dAYQaEM8g44uupEfltPxLgk3JKcIne1wd7FUMgxB3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDH0PtbtjSR10zpkAgtJpJK0/2yrCfE8qVTYCw1+Ta0=;
 b=mei2sQmAzwxZxP8naJkdneucONGLpdjOXsiXt8ISFksvMv+AUR1+ZgdcQkADPnzszJEP7mcMid35Moli92p1Kv/3g3w2ZPUfH2B8HBhEbjwoj0uGIgiWmkXNvL342PJWIh2PSu/pa8WfxGhc/T7oJJaGW8j8kBv6vwyqotQ6R1fhmKuixQoyRQhCcBW0R1q2XJybCA7bMSJgp6HSHpozBO9ONyfFQbE1B3TzYVTSEmwOwYun99dTFGUx6A9W/PftCXmfcgxCZCrV9VkttCoVTijWYlKIylXPyd2EHvaav4G6n1xFN0mqKGIRRvWT8GMy3uIVjYU+fMGc0QStpiXsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7797.namprd11.prod.outlook.com (2603:10b6:930:76::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Thu, 23 Jul 2026 10:04:36 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 10:04:35 +0000
Date: Thu, 23 Jul 2026 12:04:28 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Chenguang Zhao <chenguang.zhao@linux.dev>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, Chenguang Zhao <zhaochenguang@kylinos.cn>
Message-ID: <amHnLHrb0eQI9C3D@boxer>
References: <20260717012416.168107-1-chenguang.zhao@linux.dev>
 <CAL+tcoCdbjC4cHjm5C9mDTc05biiJfCRB=e0r0Ssp1qTwdxeJQ@mail.gmail.com>
 <20f83ab8-d99f-4b10-bab1-cd5c6202937c@linux.dev>
 <CAL+tcoAtn_eg0qwGf+6BJJGvKztNAgBm7tjY44H183=ZOw7zbA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAtn_eg0qwGf+6BJJGvKztNAgBm7tjY44H183=ZOw7zbA@mail.gmail.com>
X-ClientProxiedBy: VIUP296CA0069.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::6) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fe9a8e-2231-4d24-aef2-08dee8a1cc77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|13003099007|6133799003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3AAAc96DfFPd3JEkADthZDTJ1k+/5G7+8c5Z+LmncqgBUYlCq2M7R2jjd9a94G41dKj6E6CZGsCiIH2wS/NFhYZN50vAV/dbLcNsUaXOS/z7oY/T1mNaQxFxt1uqxvQgsHyG2sxdE2jdqcibiNW8pGrfA+svj+Xhl4LzbkkpQYcTddVAzILXW7qiKtQjzelQI3mNx6EgC+9k61chaSMNxpEDW3zYVodSaqp51a43Gk6d8eYTT8f4Muwbu2ig5W5DKMCEv+1rlORxC80Z9XyzVhcJEj6EEhAxIQfrNjnyrguRL21y8/OdSIRLeqE8Mk6k8MPo3sWNZhTF5PbT0CD19kjy8ph3ErL4WBNpbsAk27n+6Din3Hn9H2xv7zo5lhV2oKFivrjKSbuM2RWN2peGN/tuJbGRx733jmZkxATOSm3S5WHtW8BKFkLzPfedHiinQfM+jANQiImT7Hh1yEGzCrGqkK4wQ8FJfK7lCcOxi7caTmV+QOnAa5ApH9Uj8xOn0oE5hcvoTH2pAKJZG4/kjNkxG9t8vIoWHcCjoYvSQtN2e8/ulc8PRXwYqKiL4k29nMcQ8LPuVxod5x5WZsgxgwbBoNiSdWuWVOlU4DMIjSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6117.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(13003099007)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NExUQlRYYTZVTmZ0NWtsbWhYUWF6WDNUSGxlZWhlbk01VC9BWWJYUFdkQ3Ux?=
 =?utf-8?B?aDcreVJpVHljTW1Hc2cxNHhzZjlSc0dkSlpZa2d1ZG13SThYLzF3NGVNUkVx?=
 =?utf-8?B?S0pLZlRWZ24yRnl5RnJOV2tSTnhyRkJ1OVpFM2xGanE1Y1FoZFBMdVlhUEdr?=
 =?utf-8?B?ajU1WCsySFJPMWpXODAvYUpBa3JYaUczTDJkSDhKd1FyanFzT3czUnkxcnRB?=
 =?utf-8?B?aFNFdTB6aVhLVGs3Q1VMYWtlY2VWenp2MU1nakZSb3hVODZ6WUlpa3V6UUwz?=
 =?utf-8?B?Z3AwOVRsYWFRNzd4R1VhZFJJdW44WHhWbHh2K3M1d1JydGN1VFdPemdNbTRY?=
 =?utf-8?B?NWU2VlNDc3lVVFQzeS83ZTkzTWhycXdSZVEzN3lMU1NUdXQ5WGRBR1p5dGFZ?=
 =?utf-8?B?M3RrSE0wK1lXU0JwdW5Zeml2dUM0UFU1emxRM1U1MVNYN3ZDRFV4OEVGMmpt?=
 =?utf-8?B?Y0JXVVFkYk9Cc2YrS1k1d1FGY2Y5SWZYZXJETUFrWlR5T0dTNmFvTTRNTjFX?=
 =?utf-8?B?Qmh3STJ2eUJrMEN3WENNOC9wak5OSkNWRDNnVGZadVFPN3V6MHpwTkFkaXpV?=
 =?utf-8?B?ZkVwZlkvR281aGhjWElQR0pTNlZUY3pUVDViMGc3eHBZMnpLUHVqeFBhcDJQ?=
 =?utf-8?B?Q3lZeEEyTkl3cUoxckhMWDg5dGR2SnM2dDBIV0ZMRmlmY2Era0tEWlNhaUtI?=
 =?utf-8?B?SUh2anZ3R21keHMwWjhvQXRCaXBQQ2F4RUYzdDM1czdJR2tTYk5CZGY3SGlQ?=
 =?utf-8?B?YWFsVGFvd1JSUkRMVzBHYUFWek1xOFhDUTFwdi81bnc5ckJMdzNmMUpGNU5q?=
 =?utf-8?B?cmxWMzJTcUNIMTUzQ1MrTHROOGtseEN0M1RiZndtanZ0TDl2emJ4dktRWWYz?=
 =?utf-8?B?ZkFxM2tzV2RRdVNlT3ROSFNyU2I3VWFRdllHeTNucTlxVlJBc090MGlPSzA0?=
 =?utf-8?B?aC9ud212TXVhcDNLWCtKMW14dnpKV0lWNEdTZUhmY0ZpT3lhZlh1cCtvRzJu?=
 =?utf-8?B?NmtpQXMwTS9XM1pwQjlVc0ErUXNTMmhKL2lTNVZqdnYwS2Fpa3NZR1FHWVdv?=
 =?utf-8?B?TzJtanBzQUtsazMwczRubUtJY0NGZThiV25HNFhrS3NoQjREcEdDaGluMnpK?=
 =?utf-8?B?Z0lLbFdBVDJpenp3Vi9tdS93VmhEanBpaVZoUE1YTE1pSFhDcjdieUZQVS9G?=
 =?utf-8?B?STROL255eDlDeHBHMlBBU0pEN2IwR1ZUOFhOY1VPVXJvSGl3NmdiblZ6UGlY?=
 =?utf-8?B?UmxpeUZZcVcwQjgzWTI5N3FUeDVXcURQTlN4QWZLMzFFVFFqdjVraG5nMDFz?=
 =?utf-8?B?eXBINksrVDUrc1NIblFBSm14MU05OUY3enhjWjF1N09DekdJN2dGTmF0WllO?=
 =?utf-8?B?VllOck8yMGVRZ2wxN04rT2pHbnowUVI0MlZaRlRVbGlra3djRWlGeWJvN1Rx?=
 =?utf-8?B?WDVTN1dETW9sWVNITW9jekdjUGZlRXNKdWxaYnBieUM5d3EzUWhoc0NEMGRP?=
 =?utf-8?B?ZFFMbmQyRmRXdlRRR1lCcE5uSGVYeVpPRktNR09idGlwQzVDbE5tSFcrS1R3?=
 =?utf-8?B?SmM3eVdLR3Y5cE5NVFNHM0dER2VZUnRYdXloQkYyVWhBcnR4N0FIcXFPRTg4?=
 =?utf-8?B?dUNpQ3NaRFJ2Vk1aMFBGS1RPaFZXUnkrZEFNTjNLOGVKcVNncEZxZFltM2o1?=
 =?utf-8?B?L2hnVWRxSnZnbENjRWRYUFJjK3h0WlJLZ0JYRy9GdERWUEx1RS9nR0dGTnQ3?=
 =?utf-8?B?RjhnZ1Z2Vy8yQjhVaGhHbWJvaUUzRGZlMW8vRmM3K2psbmhHT3psZ2tjQnhT?=
 =?utf-8?B?UWY4bEpCL3FYbGd6aFFlNUtqS2o1a1hkVWI1ODUwN3JTMmJ0bUpGRlllaTNp?=
 =?utf-8?B?enFJSzJEZkNaODAxdzFCV1VoWlBvVHFGM2VPTmZVdUo3dzVMcTJTOGxGYWNw?=
 =?utf-8?B?UVdzMlRRdnRUalRoekpSMXFEWk9XTDVUU2VSTXZBbGExNXBUbUsxV3NiVEh2?=
 =?utf-8?B?UkpiRHJYalRLUlBLRXJWRFdOK0ViZEg4ZHpLbzIwVkZPdEZLNmdLa0tNVU82?=
 =?utf-8?B?b2NNRDBoV1h1aEE2Ynp0cFMxUVFNMnlYSXhZRUszVURkU09qR2FJVXBJZEJI?=
 =?utf-8?B?N21tS1BibkcrcGFTQU1iSVhXamxLM2tvSkZTS1hKVExSN2tCWkM4cUFHeXVV?=
 =?utf-8?B?emdiYWFOQzhLLzFsVVcyNXc5enVrajdKakFBcEFvQ20raGt5ZWV6REtqb1g0?=
 =?utf-8?B?Lzl6T3VXZkowZ0hTWFR6eitOcXc1SU5FRjEvMFpWNVdDMnhOMUVHN2c0cTFP?=
 =?utf-8?B?WFI5STFIZnhHZUl5WmEyekh2NXkrWU5JWllndDRNSmI4Y2s5WENRR2NNVU5Q?=
 =?utf-8?Q?uc7f8yQi3HY2uEuM=3D?=
X-Exchange-RoutingPolicyChecked: CqtkhoIsFSnx8GfPquLQ8GIoCIp8mSGDqUE3zYRYvbxBQiktGRzfm4qV8HSKHSzCTxu6sCUpEmf5N2nGjwTbrs4ajH1274VVluhW0PFQYRWYhZY9SjTFHzM9NmKSMEksplI3p18rPZBy07AhQoo0ELrmVGj7sypm+nSZfm1uwY9119fZ2J5U7xeCB8TeosDxYjJbgLiIBK7eM1lYNiMcUFE+fq1ATGMF9Ey3Uiwe8W7CCVV8Mk4ABkGogQuRsEsQJIXQMfpYcKrD3EXvjtK47FFmKGUQ1a+xaUQ+cplCItYYL1zoDK5eGf1LqcyDZqjaG0ipxbD7tC5rvKhRvE8u9w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fe9a8e-2231-4d24-aef2-08dee8a1cc77
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:04:35.5679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRx1LlWmCzOdodAPSdZxOYy7EvqrWWIXhgoUUkYDwubgonc5stPDd9oJNostTgxTr7g4pU7kiiNwmkJajszGr0WeyIwru3iT5nF040SJ4so=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7797
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784801082; x=1816337082;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=TjDSpO+YDJuulvjXN6QVlSoxrmiGG04dp0pUZSjtDYE=;
 b=c1itijUCeEhLBShmNFSW4vjuW0n1JxdNkVi1plr3L8Fr0CdnDjp4KPWV
 no1M5K7Y4onI9KZG8EiOQNt+WBsdlnB0uNmEoXCriBmOmgBGlzrIX+8U6
 aK5EtSMPBg3ar8JONo4cmfh9/R1AkfISWFnT3STP8FLrSh3oVZ/ciEljA
 60ZV154rxHVMREwtsmVnb7AYxHkhS96XTcWQxJxKIXlnWEVs/V4tTlDIl
 bRlb9428mGaclxcb5Sg8T1R/yH+qPalcuJTkLT0vWoMN4YFvIUDbLeh+R
 kfTlRMjvKgzwI8oP9zyMVAvjFfBDG2gmzBULsmKyfQhKDP7kcTOoF4mYa
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=c1itijUC
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net v2] i40e: xsk: fix multi-buffer
 XDP_PASS skb construction
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

On Thu, Jul 23, 2026 at 03:59:44PM +0800, Jason Xing wrote:
> On Thu, Jul 23, 2026 at 3:02 PM Chenguang Zhao <chenguang.zhao@linux.dev> wrote:
> >
> > Thanks for the clarification.
> 
> Please do not top-post.
> 
> >
> > I agree: the minimal bugfix belongs in -net for stable backportability, and the conversion to xdp_build_skb_from_zc() belongs in -next.
> 
> Right. That's what I meant. But I will let Maciej/Tony/Olek make the decision.

Thanks Jason - agree with the logistics you are proposing.

> 
> >
> > Please apply the existing v1 bugfix to -net:
> >
> >      https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@linux.dev/
> 
> If we eventually need this patch, then you will send a v3 patch
> instead of asking maintainers to pick it up :)
> 
> And feel free to add:
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> 
> >
> > It already has :
> >
> >     Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> >
> > I will drop v2 as a Fixes candidate.
> >
> > In parallel, I will send a separate net-next series (as v1) that replaces
> >
> > i40e_construct_skb_zc() with xdp_build_skb_from_zc(), based on
> >
> > net-next. That patch will not carry a Fixes tag.
> 
> As to this version, my tag still holds:
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> 
> Thanks,
> Jason
> 
> >
> >
> > Thanks,
> >
> > Chenguang
> >
> >
> > 在 2026/7/22 07:15, Jason Xing 写道:
> > > On Fri, Jul 17, 2026 at 9:24 AM Chenguang Zhao <chenguang.zhao@linux.dev> wrote:
> > >> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> > >>
> > >> When AF_XDP ZC receives a multi-buffer frame and XDP returns XDP_PASS,
> > >> i40e_construct_skb_zc() copied frags incorrectly: memcpy used
> > >> skb_frag_page() (page metadata) and __skb_fill_page_desc_noacc() was
> > >> given a virtual address instead of a struct page *.
> > >>
> > >> Drop the custom helper and use xdp_build_skb_from_zc() instead. On
> > >> failure, free the xdp buff in the caller. Push the Ethernet header
> > >> back before eth_skb_pad()/i40e_process_skb_fields() because
> > >> xdp_build_skb_from_zc() already called eth_type_trans().
> > >>
> > >> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> > >> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> > >> ---
> > >> Revised as suggested by Maciej:
> > >>  - Replace i40e_construct_skb_zc() with xdp_build_skb_from_zc()
> > > I might have a different opinion on this patch: yes, it actually
> > > belongs to -next material. The process should be like: 1) fix the
> > > issues by v1, 2) refactor it by v2. The reason behind that is the
> > > helper was introduced in 2024 while the home-grown part was in 2023,
> > > which means it doesn't help for stable steam to cherry-pick the patch
> > > in older kernels like 6.6[1].
> > >
> > > [1]: https://www.kernel.org/
> > >
> > > Thanks,
> > > Jason
> > >
> > >> v1:
> > >>  https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@linux.dev/
> > >>
> > >>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 73 +++-------------------
> > >>  1 file changed, 8 insertions(+), 65 deletions(-)
> > >>
> > >> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > >> index 9f47388eaba5..1319a5c22625 100644
> > >> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > >> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > >> @@ -3,6 +3,7 @@
> > >>
> > >>  #include <linux/bpf_trace.h>
> > >>  #include <linux/unroll.h>
> > >> +#include <net/xdp.h>
> > >>  #include <net/xdp_sock_drv.h>
> > >>  #include "i40e_txrx_common.h"
> > >>  #include "i40e_xsk.h"
> > >> @@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
> > >>         return count == nb_buffs;
> > >>  }
> > >>
> > >> -/**
> > >> - * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
> > >> - * @rx_ring: Rx ring
> > >> - * @xdp: xdp_buff
> > >> - *
> > >> - * This functions allocates a new skb from a zero-copy Rx buffer.
> > >> - *
> > >> - * Returns the skb, or NULL on failure.
> > >> - **/
> > >> -static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
> > >> -                                            struct xdp_buff *xdp)
> > >> -{
> > >> -       unsigned int totalsize = xdp->data_end - xdp->data_meta;
> > >> -       unsigned int metasize = xdp->data - xdp->data_meta;
> > >> -       struct skb_shared_info *sinfo = NULL;
> > >> -       struct sk_buff *skb;
> > >> -       u32 nr_frags = 0;
> > >> -
> > >> -       if (unlikely(xdp_buff_has_frags(xdp))) {
> > >> -               sinfo = xdp_get_shared_info_from_buff(xdp);
> > >> -               nr_frags = sinfo->nr_frags;
> > >> -       }
> > >> -       net_prefetch(xdp->data_meta);
> > >> -
> > >> -       /* allocate a skb to store the frags */
> > >> -       skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> > >> -       if (unlikely(!skb))
> > >> -               goto out;
> > >> -
> > >> -       memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> > >> -              ALIGN(totalsize, sizeof(long)));
> > >> -
> > >> -       if (metasize) {
> > >> -               skb_metadata_set(skb, metasize);
> > >> -               __skb_pull(skb, metasize);
> > >> -       }
> > >> -
> > >> -       if (likely(!xdp_buff_has_frags(xdp)))
> > >> -               goto out;
> > >> -
> > >> -       for (int i = 0; i < nr_frags; i++) {
> > >> -               struct skb_shared_info *skinfo = skb_shinfo(skb);
> > >> -               skb_frag_t *frag = &sinfo->frags[i];
> > >> -               struct page *page;
> > >> -               void *addr;
> > >> -
> > >> -               page = dev_alloc_page();
> > >> -               if (!page) {
> > >> -                       dev_kfree_skb(skb);
> > >> -                       return NULL;
> > >> -               }
> > >> -               addr = page_to_virt(page);
> > >> -
> > >> -               memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
> > >> -
> > >> -               __skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
> > >> -                                          addr, 0, skb_frag_size(frag));
> > >> -       }
> > >> -
> > >> -out:
> > >> -       xsk_buff_free(xdp);
> > >> -       return skb;
> > >> -}
> > >> -
> > >>  static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
> > >>                                       struct xdp_buff *xdp_buff,
> > >>                                       union i40e_rx_desc *rx_desc,
> > >> @@ -372,14 +309,20 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
> > >>                  * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
> > >>                  * SBP is *not* set in PRT_SBPVSI (default not set).
> > >>                  */
> > >> -               skb = i40e_construct_skb_zc(rx_ring, xdp_buff);
> > >> +               skb = xdp_build_skb_from_zc(xdp_buff);
> > >>                 if (!skb) {
> > >> +                       xsk_buff_free(xdp_buff);
> > >>                         rx_ring->rx_stats.alloc_buff_failed++;
> > >>                         *rx_packets = 0;
> > >>                         *rx_bytes = 0;
> > >>                         return;
> > >>                 }
> > >>
> > >> +               /* xdp_build_skb_from_zc() already ran eth_type_trans();
> > >> +                * restore the header for eth_skb_pad()/process_skb_fields().
> > >> +                */
> > >> +               __skb_push(skb, skb->data - skb_mac_header(skb));
> > >> +
> > >>                 if (eth_skb_pad(skb)) {
> > >>                         *rx_packets = 0;
> > >>                         *rx_bytes = 0;
> > >> --
> > >> 2.25.1
> > >>
> > >>
> 
