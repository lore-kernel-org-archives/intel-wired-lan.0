Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B670C56208
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B124240645;
	Thu,  6 Aug 2026 13:05:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d9TrPHittE4I; Thu,  6 Aug 2026 13:05:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4156C40637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786021501;
	bh=poepirtZc4WgSHbdBW0Y+btoQqjnCvsZ4Ovp/mFmFK0=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nX2MAAijFUr7Hqr7UMBUnE9N26D0k4AL788eFaikRe7pgm7LADFwqoUzPU5y1q+Xb
	 KFTo92p9JClozNp15q7kRXd1kwP99SHdS4ZJt8og1KqqbAi4eBN5ghE62wvGYc++mB
	 005KKDIGH9nWjxajvLj21e/SHb8HzAi2uHHawL4rhv5QKeltbGeu6SLFcb9PsumKXL
	 o7SHCir9Xp4TGQpvw+dsyjvLrv4VMIxEr47lwNUKuZ3VdAjHHDXQIIkB+5hpVXIz3S
	 lT6qnE1vsI10O7Nd0YQXGzqwAmTMiXG9UalRiFXi7tRIDcQWca8YfwKufFFGECmhEQ
	 xYJGX2qYkhLjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4156C40637;
	Thu,  6 Aug 2026 13:05:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D5163218
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 13:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6F7D80E01
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 13:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bnMYuv5fERma for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 13:04:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1244E80E00
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1244E80E00
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1244E80E00
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 13:04:58 +0000 (UTC)
X-CSE-ConnectionGUID: m99HV0GlRymtFJyq5k8gEQ==
X-CSE-MsgGUID: Q2tNW8SWToGXqKKGD+UDZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86379260"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86379260"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 06:04:58 -0700
X-CSE-ConnectionGUID: 0HpehmsuTL6SINoc9nMMRw==
X-CSE-MsgGUID: JAPheFiyQzWU4Vleg6f85Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="258225229"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 06:04:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 06:04:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 06:04:57 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 06:04:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPQW48Dd6AC8rw9IbBcVoyEf2wgUqBfwujlSn8mIYiNAgEOF+AnvHTNz/a9WrbR80JHBcCu7/hggvvhnHCH+/3odAfQiDfuRuGgo8nTzpHnuf5Q/xzLWRWrNP6t28a/oANMiFrJQlNV7y31PPycWi88q/hb8tXm8qm4YUsjBTvWVfLQ+37n97AHKCzssiItgjdvd4fFsV2dPIcf0wispSJ8tNWo8qq+s4uVW+aQqXiFShLaomUwrorvghAncIFq3GqSGkkKDEg2Qa0bCOAUHALx8mxJL/RGlC3ikJyy+QOPnnsm/EcaxKpZ+bWwtOHXyElf0DwJ1IyrZFNMBO81jYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poepirtZc4WgSHbdBW0Y+btoQqjnCvsZ4Ovp/mFmFK0=;
 b=dCQ3pQJfSNFnXJqfz4M2Gmms/O+NcFs6qhMrvyVAybWviTgp1m/zV57hEV6W1WVOZv2F19/P0OppMWbGlFKNisKXiCE3XLb5BTGXeXmPh/lDW82E2+RXIi6ZV3H5euQhPecz8WqZqneCv8MqH6f/xeb8rHxXb3rQC/73ixzkUQ0qXpzlmVVSdvFhhxvC8wG+4KL1YmkiiTOGftiDuptUFOwqz5TKOfiX8SMovjfTz6Mz0ZVK7oXTb3FML2bco9skRMhfHM8l0CCcZ+SuyN7fauyDtKhwFlcx90qGxxqEgpel1G1XalmKEZo6MEjzD+kx9hz5/sCkstMj+JIe23vdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by PH0PR11MB9750.namprd11.prod.outlook.com (2603:10b6:510:397::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 13:04:49 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0292.015; Thu, 6 Aug 2026
 13:04:49 +0000
Message-ID: <a1abe12d-fa5e-4f53-af12-45793d8f8e1a@intel.com>
Date: Thu, 6 Aug 2026 15:04:44 +0200
User-Agent: Mozilla Thunderbird
To: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: Marcin Szycik <marcin.szycik@linux.intel.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>
References: <20260806104621.700901-1-tomasz.lichwala@linux.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260806104621.700901-1-tomasz.lichwala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0057.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::15) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|PH0PR11MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3161a0-6672-4fb5-7d4d-08def3bb4c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|56012099006|10067099003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: TDfIGAVw5JUH+fPgt1jVztqkr3y6iwDOgfKK6l1ScV3W9OcCv2TGkF2Kjd4FvAf9JlMDqvDKxBIrfMZfwQNao81O5ks+H8rNA9ihWvg5zHZwNHw8IR9vJ8/AWOi4Gcf1pPFAMOXC88wCAYl2cAGMeXhNNT24jxbgyurGRH0cXGQ7z4vli3rebgftGy+CmvXTq/mA7gGq0/0xQXNw33okOUX9igiMi77+DA6ghSvsXW03y8wtD4NujF0MIE1Xbgb/ONHgIzmOnBjJAwGSH4LQlQ0pjjY1kMYwqWFyNZP1vD3AH35Yvnymc52SgntuHnfvuYCNzzL8V73jj4tr3KUjkiJQsrcNldG47GzUMmiHlDrRNfNNZLhhEi0UZ+YKFMrYqDsBWw8m33SOcSTIVN/W6c+FXAKVSWBjC7bsyEedOV6Ho/p/mEUIEqygs4C7b0AUmvfQ095kfenPYEW1JUISYfO9+3QWS0btpYukI4rgUxlxZ1jy/yNc9nlbqxr0bScOaG6xxTslNkJkQELPiRIi2foh8/XqQF/4OlYGllve5AZrKX8778xd6s1r3WUDVFqjziM2CdIGUcUplIg6OsBV9WYs6Qxm+xDSFQp5jriyvT6D5KNzy3LCoZjgN11D6R8IyoB2I0gkNjkuwVqpqMRqPTqASkQN8buEQpkCu4EdGIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEovSGNzMzErSHc0Z0JJRE16ZEN2MnZJZEFIZUU2KytyeXJmd0FhR244VndQ?=
 =?utf-8?B?SExGT1daZWRPVGJ0WFFiWUk2ejdtaTlhamVWUVJTbUJnUGN2TDVRK1VOM0Jl?=
 =?utf-8?B?aEN5U2Z5ZS9VUUFUOVRJQ1l3S0RWbG8xR2RxRy9lSlNPTmVpSjRJTU11SXk0?=
 =?utf-8?B?cmNZUVBKeTFkeW5LODJkallQenZ3S3NQb1hxc3dYVEVXMy95SDZ4QjhRRVNw?=
 =?utf-8?B?Vy9vZVdvMnd2ZU1TSnRkVktxSHZoNDF4a1Z0N2tnVSt0YVVFSVJvYzlvVnZE?=
 =?utf-8?B?MFhlMGNXK3RuTzM5aXBsYm9NMldTK29WdzEyT1VXYnhzY0JET3B2TGl5Zndm?=
 =?utf-8?B?VzBPZnFoblQvMWxDcHZzazNFSUV3UGlpeEg3dkNqZE5GSEN0REg3QkpUYjBp?=
 =?utf-8?B?RFNxelVjOGJFUU50VVZPU0NtSlBmaWRZYWJXT3JWaU5aMVF5czFpeSsxemwz?=
 =?utf-8?B?bnFlUlBra0hITDB3aUJ4aGkrMEpTMDUzY0V4L1hBU1BvYnlEN3AzRWF4SGNC?=
 =?utf-8?B?YS9kMUhEZ0YzdUZaK3RuRnRVaXZwOHh2Z3dDVFpmZkxkY2EvWWUvR0xlYlBR?=
 =?utf-8?B?aTVJY2NxcmtCWHJBdzV3R05tYmlJZ3d0Qi9nMDdKdVF0c0tDYUwvckJVc0pE?=
 =?utf-8?B?QXNIa1hUQllRRXpsZGhuM2ttMGtMdWIvb2NTWjh6S1hQbWI1d3VJZjdRZmVj?=
 =?utf-8?B?ZW43b2JlNUtBdTJza3U2RXc3T3QwSERzaWJMMSt5d2dubForNW1JQ3lySS9G?=
 =?utf-8?B?WUtVcFhDUUtXSTZVRzhXK0cxQmxreHZGSDFFZjcya2Y1UDFtVlJWKy9jUmlm?=
 =?utf-8?B?bnAxdGdKdzNlSjNONCt2cE1WVnhqRHpuNTFVbzhqUFJwY29Xb2t4L2NNbnhP?=
 =?utf-8?B?alMxVmVqZEw2SUVJNmdyOHVJb2lZelptOTVUMVRBR3VCVkZYQ1dIWW4vMW03?=
 =?utf-8?B?V0gySUtnaU5BNUhDdHp4alhYVXJNd0ZLNVRsVVZYZ1FTdlUxOFIxN2FYczRy?=
 =?utf-8?B?bVdGSjFGd2pYdDV0ZnVVei9Ca1lHeGorRWJHYUY3SFY1WHMxTVJ5ZDNucW1u?=
 =?utf-8?B?d2pqY2swbkFiZlkzUW9lUU5yV09zK0l5K0RoY3JLTVBIQWYraXprMUExR1hL?=
 =?utf-8?B?bXpTWUVKeDhlQTFOM3RaN0dqR1JLcTRLWTNtWExQUGc0c0VjSjEvTHZ3MlFW?=
 =?utf-8?B?aktibHFIaUhQUEcrK3N0a292TmljOFBJTDFTNGlYSlpnKzNsdGtCZlhYTFF4?=
 =?utf-8?B?bWxiSG9vcEVVNDQvNkVMYzc3UnFJWktqbVQycXNjQjczNkhmZGROZ3VOTVpM?=
 =?utf-8?B?V21hc3Y5bGExMEhicTJOd2x6TWNWd002ZjQ3ZlFvTUo2cVJQYXZEeGFRVGcr?=
 =?utf-8?B?ekFkRFZpR0V5QURCbmFaOGdnazVKaC8rYnBIK3hQVFM1WGlhMzBlTXg1MXAy?=
 =?utf-8?B?MDQ5a2syOWN2UGV2bnVUTVYxRFgrcS9iT2ZlUzAxek1OcnZMeWt1MlNZMUY5?=
 =?utf-8?B?citmQXovRThBaGNNcG93WFJNd3lxNHFkclJ5Z1l4dFdrc2ZpcVZuajlhRzNP?=
 =?utf-8?B?U1JOUFRQaEtmVDJYQ2lldUtjd21iM1dLRlJIOWZ2dFBuNGFHNHFVMDloQnhz?=
 =?utf-8?B?K2p2dHdNQng0aWpLZUp1RVNRL1I5UHZWbWE2Z01PdS84aDVleGVCNXp6RTlP?=
 =?utf-8?B?TVU0T1dOMkpsUEJMalNNbTJOL2cvc3pZNUpwbHBvWHpJVUpOSDVVWThRU2dY?=
 =?utf-8?B?elNEOHBCOVRyeU54Y1JEMm0yWEtSbWYyWVI2U2JMMzRXV3c3VDRQRzBSeFBH?=
 =?utf-8?B?cWljb0pUbWw0Rm1oTUtyR1JvY2dRcW5LZkl5QzBVcThhUmxGbnZQKzZ1QWNs?=
 =?utf-8?B?c1R3MXJXRGlDb0hjODRYTWtPV3Z6bTBCUXRuU2wvUGJmWm1rcjhBNllBNmVn?=
 =?utf-8?B?VVY0a0xXN0NkVlUzTVVwbGdLaWdGUGFUdVFRS0NyaksxL29yamZWODN4Y05W?=
 =?utf-8?B?VDRsOTRPUlhFNXY2UVQ0ZWdudXVUaFpLdzY0dXIxd1RGK051dEVsRXo3ajh0?=
 =?utf-8?B?SUl6ZlhYcldWMTMwWUdLRkNjblFadVhzWitYV2ppUFpTU3JKMzQwM3BBMDhO?=
 =?utf-8?B?Y3liQ01RdGoxeTFDWUREU1JVandORlBKT3BscjBwdWVKUTZodjdJcW1uY0Fu?=
 =?utf-8?B?Y3pmZ0Q1YVQ1Vm15cGgyVllNY3hhN05XSjQxSkVmRDA0c0wvTXp3aVJidTQw?=
 =?utf-8?B?Z0xGcXY3a0RHTDlKWFVCSDNPZHNwNC9tV0JzYjM4LzlBanlCQXJ1UE5MYmRa?=
 =?utf-8?B?M1ZvL20vTVNvTlh3dHhsamdkelBqVU9aUTIxb2hoYjI3VDdMbjRqZXFMeXU0?=
 =?utf-8?Q?D041Nl7lsx2PTKAI=3D?=
X-Exchange-RoutingPolicyChecked: rZwYAHne1MTfQdvzzHMKFcIJ0T+aam5WJyP5A4Oa7dwAjpReCF6bZucDf1c1OXNmnPQP+YT9dHsh8McKTGvAaFkzt2UiXrVUWM5QpltkfRT+g7jXgMD9YUfLzYBAlP0WhaNY64EJ99AU8Wyoif8f3GGVoM/tv5be6aqCxBJKw8eJf8S5nAtt1XUgj3IQbTqpabWeP21wHzFh1XctXyQcSu67tqOfGsHVyvxOI+DkorK7K91w2xJ7YZ5WezzjKMWFMhozvY6sVV5xk90LvPbcWUJ3iMJiWgSIhLKLxU3XvQC/vxoDs8OgK2QYl2wXxna589nsQecH+sTHWuBOKFk3WA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3161a0-6672-4fb5-7d4d-08def3bb4c0d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 13:04:49.6436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdukDwR6SFdrj76ZXc9NXDndOv1cFysb+a9d4q9pK+l5zzedTgJwr/B9k6rwOVFtqeAgAO0CkDto80hjBkj1KqEs9RTkrS0P9OR6583rXqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9750
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786021499; x=1817557499;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4d3uQglCgNqIYUC2CmaWPXjJwBW1EmXyUqOr4AhFIHw=;
 b=KshIjM5a+LuWVVWySslGoQNZNKk3TEgITdNpVA17Jv8dKZXpFVg8jk4y
 +9OVh0AG0QyB5bWlZBbdO76HdRQZV5xHlnhCvgSfcrR/TfkNgvzU1tB5C
 oBphTaeUnrdc6jqDsaYx3GuskIufis9dX+4/30e1BgsmTvkUjo3B6kax4
 rL/cLzi42FRq2EbZQCxPdYneEE8gyPFfR2FztmxfqnmHHMjNY9I5uLXtb
 4gQ7pmN6P8/eoDVG6+GA5QNYYWDkiDFVQD476LjFaAue1nYkAMgeZzslp
 boijwWoOj6G7Goz+EXWg9+rgXVxKuwAKz0SL8ZR3WPiwiOt30muxUTb0p
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KshIjM5a
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] ixgbevf: fix link speed
 reporting for Hyper-V E610 VFs
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

On 8/6/26 12:46, Tomasz Lichwala wrote:
> When an E610 VF is running under Hyper-V, the VFLINKS register does not
> carry valid link speed. The existing code reads speed from VFLINKS, which
> does not reflect the actual negotiated speed. This results in ethtool
> reporting a stale or incorrect link speed.
> 
> The Hyper-V synthetic NIC exposes the actual link status through
> emulated PCI config space at offset 0x209 in VFLINKS register format.
> Read and decode link status from there when checking link on E610 VFs.
> 
> Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
> ---

next time please provide changelog section here

>   drivers/net/ethernet/intel/ixgbevf/vf.c | 77 +++++++++++++++++++++----
>   1 file changed, 65 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
> index f6df86d124b9..8ad06e28b5de 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/vf.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
> @@ -1,14 +1,17 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright(c) 1999 - 2024 Intel Corporation. */
>   
> +#include <linux/unaligned.h>
> +
>   #include "vf.h"
>   #include "ixgbevf.h"
>   

[..]

> +static s32 ixgbevf_hv_read_links_e610(struct ixgbe_hw *hw, u32 *links_reg)
> +{
> +	struct ixgbevf_adapter *adapter = hw->back;
> +	u8 data[IXGBE_HV_LINK_STATUS_SIZE];

following Paul's suggestion, you could add:
	if (IS_ENABLED(CONFIG_PCI_MMCONFIG)) {
		dev_err_once(&adapter->pdev->dev, "cannot read link status, 
PCI_MMCONFIG is required for Hyper-V\n");
		return -EOPNOTSUPP;
	}

and this will give user more information

IS_ENABLED() is really nice macro :)

> +
> +	for (int i = 0; i < IXGBE_HV_LINK_STATUS_SIZE; i++) {
> +		int ret = pci_read_config_byte(adapter->pdev,
> +					       IXGBE_HV_LINK_STATUS_OFFSET + i,
> +					       &data[i]);
> +		if (ret)
> +			return pcibios_err_to_errno(ret);
> +	}
> +
> +	*links_reg = get_unaligned_le32(data);
> +	return 0;
> +}
> +
