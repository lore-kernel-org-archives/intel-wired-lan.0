Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14E0C44501
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 11:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9590740655;
	Thu, 16 Jul 2026 11:04:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2tDn1n85qhB4; Thu, 16 Jul 2026 11:04:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1B26407A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784199842;
	bh=xBB9oxqzDqygeRrwCB2qkvTGOy9MRw6gz2pK3nsn1MU=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8k2TbbBv4/2JE8dSwN3jE/CgSkaXhmwG5o7zi8K+6wHA1RTuVKdVrpibD5UgyUW0k
	 odV4g/W9dW6BBECrjASH0JqwMq4btgHp0iQP6v34Km5USQ86F0YLIJYF3yuDYzMgT2
	 LGvqEz2VAe7PaKEtDxjdz7RMIzhgrDR+KP3fDkmgscoUHUBEqq54xTYQvZ3FM5n1dZ
	 rVndyeqK3YE/C7Xrti+0efeAfIWUbGVg86SY7QOPJ3hs9iIba8yHnJklUFJuqSlufZ
	 PWVxNX+IH2xZK9VFQMn0PZSp+jMXeUN48pyJbwQFyo16PmA2U7hc0SqUGHLwNwzxEq
	 O70BOfUFHwkag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1B26407A9;
	Thu, 16 Jul 2026 11:04:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E3828426
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 11:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C974480E55
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 11:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6PVB4Zfx3qOk for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 11:04:01 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D938C80E4E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D938C80E4E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D938C80E4E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 11:03:59 +0000 (UTC)
X-CSE-ConnectionGUID: E+2LddrjQvO2J0B/JulvVQ==
X-CSE-MsgGUID: uF4Pk6E9SeieRRoHqzZDSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="87399927"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="87399927"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 04:03:59 -0700
X-CSE-ConnectionGUID: taOjNlMUQ+mN2w8HillRaw==
X-CSE-MsgGUID: GG2P2+lFRYeQVhJOiWL5yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="254720275"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 04:03:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 04:03:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 04:03:58 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 04:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BudUln5qsZ/DSXDbZF7IUXkHAraJdygB0N7XBuDFr4AdYXPpb4AZN0L4c9goXYQtusb8ZLfJI4suZrfItYvWurxP5w17FDF2UOBYRydO5qpomJTjH0bCfWHJSrOP/ZIjneKo7+oQayOtkqw9LTvyaWIt5ioOsjvkbak7n5kcthbwWxMM7maRqUbvREpoBJ34OG0Ly0WYfqt/80uA5dsz5LZCdfmIdUW2Q29pNDUZ9gtljFhQq1m2mq9b5WkBY1ks7H6iqgpX6sVOXIyFS/MekVIWCWzoGE+0HUnOmi56opoL4Zfvd246n7U6xj2Cko2jp4lj2XKQJJA4a6xKQ6HM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBB9oxqzDqygeRrwCB2qkvTGOy9MRw6gz2pK3nsn1MU=;
 b=IduXsaRmk4nNHz11ZPKWekrU5o/3JMnedvsjFizRKj9oMn7lvve1rVbMfwfWiBGZnCcEElXRFCXpzQpyp/dy0TkRhwhVtMCNPeqywDQwMVTF1Qzf5TL2RyWNkK6BLeKimIJx7i0h8B+taZramZKk9pV9LyffBqOOgyHYSEYZOiIkY28HD/hWOFGOokMl+NaBDC9llDEbqrPXsDQGlNx5nwRmbPlCFsU4XNIXStfc0Yx9EyI1ezFP8jzy20f8hLrt3ah2cXTgDlrDJP4l5dXzJeFQDtp515VF4OIGJsMzbAN584LMFpyZl7OrAASIR5gTk4zyza2zCpjAqFadE0+Ugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB9509.namprd11.prod.outlook.com (2603:10b6:806:47e::18)
 by SJ1PR11MB6249.namprd11.prod.outlook.com (2603:10b6:a03:45a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 11:03:47 +0000
Received: from SA3PR11MB9509.namprd11.prod.outlook.com
 ([fe80::5c18:b82:4518:e09e]) by SA3PR11MB9509.namprd11.prod.outlook.com
 ([fe80::5c18:b82:4518:e09e%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 11:03:47 +0000
Message-ID: <46dde8c9-1d39-40d1-b1d0-973d274fffc8@intel.com>
Date: Thu, 16 Jul 2026 14:03:43 +0300
User-Agent: Mozilla Thunderbird
To: Viktor Donner <vikdon@gmx.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>
References: <1dbf956a-e981-4b2a-ab5e-ddbd5905663c@gmx.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <1dbf956a-e981-4b2a-ab5e-ddbd5905663c@gmx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To SA3PR11MB9509.namprd11.prod.outlook.com
 (2603:10b6:806:47e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB9509:EE_|SJ1PR11MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd91e2b-47f1-4349-1f39-08dee329e921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: yKtEM9V9+REwzHXqbPpuGGUW0RtwRhW+4RFvyfsEyvXJeLfAakrtTs7Bp46ICs2xqNF5Rm7JT7j7ZWIZYXpXt2vgFq06g9PMJOuhnZWvDpmUeP9K4aOJ4djWX1FwZhlUi5nabcjuUeQYIdDWz8oCwdM6Qu+peCf9uNw9eZyMXEk5laILqVbLy5IXOpBlalAc3BZhsZmS18tv6H8GRigiTmesCV21/PDdxXEPCpfbhAy9qNCO8sH57UrOucJuSatESoGwahoMHfQnwbKaeoo6Gb9qaKfTLMlC+K0J9sfb/oKsb6CI/j7V6/IyL2qLAOziM9R6ZCfGSNquKVoaw8vlS+YQH946LqYAeNMwKOetSks+6q1p+2+PBRAjqCocOQdbCgfLQEYV2CexrtPlt5pH2yBWYBSzmAuCGhUrvL6qo1Ie3mYzDPXWWs52WEzY3eFzfFcw4bblYOjx/qnbSET7vhE8MeafUSReOShNL/8a/1aAL4xl+3/tBBGcTMpeQ+t7cnGsgH104CBthaYPD5tQOfFommLRCqhMGCc1OkjEcx5o2AZIqgX1J43zZc3SvyjQuf09pkdQfaxvhDARSDXLXxBLjNwbtGP3W5tGabz4+0iI+4kAqTB2KpEwW1xs9mOm8l+OlDfgd2rSALe+tzRhAPOVOJpLFBfNio6bnpNKoDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB9509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFpRNkJPZ1p0OE95dEZqN3BoKy8yemlESTZOeC9WTFFpek5Fd05lbTc2VVBH?=
 =?utf-8?B?MUNwMlFkNUg0a2xwV1Nwajc4djBIdGNGLzduRURZY0p4QS9qMS9HUWYyREhz?=
 =?utf-8?B?WmJEV3dnOFJ4bXRrd0ZDL0Q0NGhOUEJ5MzlKTGFtZDQyd2JiOHlOVkJkaVFR?=
 =?utf-8?B?Z2tlS3pLRDM1dU9SRnRNem05U0JJS0RncXgyaWllNnQ2d01OeGNaYmRXTS9v?=
 =?utf-8?B?emNQSWdJUUtWNWtrODlzS0NlL056OS9SUENRNXE1Wi9xMDZMTWp4SGFJUkRI?=
 =?utf-8?B?M2tXa2FENWE2aThGYWlyU1p1UWJrcENCcWRyRVNKdnZSNXFaZnV5Zzd6YVhG?=
 =?utf-8?B?U25QYW1DeEJ3Nkg5aUR3dzV5bmhYUzBReCttN0JzNjdmT3ZrQUwrK2ozekRr?=
 =?utf-8?B?ZnkwMXpEd2h3SFNDdDZKMHRUOXlGRDlBMnBSdHd1YzhISDd5SGc5QjFRaWFJ?=
 =?utf-8?B?S3NoUDRvT1ZZYkNqT09oSnpxdCtkVkRSVXNJOTkvQXVjY2x0UktTZEZIV3JT?=
 =?utf-8?B?c2FBcmdrZ1l6NFJDNUpORkg5WTd5bS9wY092TERLYTMzUnMwMTJDMHVvR2pr?=
 =?utf-8?B?VGVxZE5rUmhLbjNjSEFUMitvcXIrZDVLMVpmSURnemEzZm1BaTdQdlk3RUw4?=
 =?utf-8?B?RDJnT2xkeEZmZmRiTDc2R1NiRkkxdXg0Z0xlUUs3akxRVjIrY0crZWhzNzNs?=
 =?utf-8?B?NDF0OEIyUWdiQnJabWZhMGErL3dwR1R0c0RLY2UwVWVDR0NHYjE5OGZ4OC9L?=
 =?utf-8?B?a1F3U0Z5QzJNZUpCWFFPdFpVN3BNalJnWjlKdXExQTIyZ3dXZGlERk9Zc1NS?=
 =?utf-8?B?Zk9IcnJYNUdpbWtHUG0zVEswN2Z5NUhQNkFDd1VEK0NOR1VnYllPWkY2aEZj?=
 =?utf-8?B?UzM5M0UycVFpWDl2a2NHTjdYR3lIUU14ajN1cUViSFNmM2lXSzI2cFFkenZS?=
 =?utf-8?B?K21wNmFsbHVPQ0tMVnAvYi9hN09PZDhDcHFySE1aWGg1R25RckJBSmU3TFlh?=
 =?utf-8?B?RW5ZVGQ0TjB2OGVocEpLMU5IMmVpWWtzMUZDaDVOVVVCenkxQ0E4OWFWU0V2?=
 =?utf-8?B?ZE1jUEVFdGQzUlBVa1I3SllaTFJwUHUvQlY1YzdCOVUyK3VMVTJ5R1NIbE9E?=
 =?utf-8?B?VjJzRXRlSjFWcWVBandDb0twWnN1K2pJTUtuREtYWU5JT2p5VE9oNTRpMjlH?=
 =?utf-8?B?U2NYemNWNmJTb0VHSXRRZW80QnRrQUFqWlZJVjhzL0ltdmVSYVVDeXFqSEtR?=
 =?utf-8?B?b2d0M0JLblBtUmltV1FMSE1PN0QzVTU0UjlXNERVU2hIUmhObWVweVBYRFln?=
 =?utf-8?B?cDNiM2hZTU1xUk5QcDVqMllNNEhnREo5NmRyLzFMdndyWkVqeTRtNTFONFZT?=
 =?utf-8?B?bVlTNXpvSXJRL1BNUmpzR2t1UFBqK0wzQ1ZjWG4xbklsbW5xN1QvSmovSTVa?=
 =?utf-8?B?cXlheUFaY3RCN3laaHhvdUhzR0pZdW5tWXZDVkRmVXJ1NHMyZmJXdy82bVdM?=
 =?utf-8?B?WE5aZmVab283YkRZN3Zkby92eWlJZFcyanRVUkxlc0QxcU9oUm1qZEdrc0ZF?=
 =?utf-8?B?U1l2b0pkdERQMlJhbGZJN3JLT2NSR1JzVmpPU0MxUC9xeFROSXZlVVBXZ2xh?=
 =?utf-8?B?UisxSUc4UElIZHBjS2xvMWIyWGUzTktENENHejhFSmtRUHRZU3dyWE8vU3VE?=
 =?utf-8?B?RTdyQmNHTFhYWm9WaXhSREpqZFNxOFRaTDBtTEsyN1JtQ1QweGN0dkJqWlJa?=
 =?utf-8?B?dnpNN2dXNXFkZi9tTG9pOExnQjNqcXZpcEVIVnZLUzF1a2VqVlpyUEVicUJh?=
 =?utf-8?B?SE5DbWJKendjdFNKYk1ZMTNFU2ZUaVBlbGNqbzlJLzlpOHFpemZkb2h3OVZZ?=
 =?utf-8?B?TU56V05oUHhDd1FBdFJTLy9meHl0WW5UQmVuODhyeW5nekdNeWFqS1pvRHJ1?=
 =?utf-8?B?MTQxTnJma1hCdjlCNjRGYkpUN3ZzaUdYWG91bmxYbXJYemF6a3FDaThWTngz?=
 =?utf-8?B?QTNLVUs2SjdJSGdYSWlJYW1WQXZBcFcvQ3pXQVhaaU9IbTcrWnlESXYxcHFm?=
 =?utf-8?B?U0lydFFjcHFodHRLbm15UzVJcS9mMENlSWtTTFN0SW1XN1JQWllTaGx1SWpD?=
 =?utf-8?B?RmE5VkNXa2dVdVlScUFXZzRaeUxFSjBxbDFhSEpmakc1T0tnU2VXU0VtNWxK?=
 =?utf-8?B?eDVpQnR1SFE0QUVKQkt4dm40REljRlU1R0tjQUNlbElhNlNoV0JxaWl3UW0x?=
 =?utf-8?B?RlFEc01qcDNkWGI2dEdIcXR1c2ZTOVU0b3BZQ0Y3NkNuMEFSRmFTUTFIT2xF?=
 =?utf-8?B?M3lPNzhIUWRKOGJpUnBZY3ltSUJXUUNCQ0FpVTgvYXFQQkNKSEUzdz09?=
X-Exchange-RoutingPolicyChecked: MbUi/IeLHjLVcoztZLY6RgVfZ7XqHpZSXWFLJB0Th13BdJySCnw7gl5a7kPeKNuzPhcm/Nkkx8ap9eVK6c7xkhDpkUeYLe2ZEZBh3BeKhvV5H3QAJASfrICzEL2nOQlFeTCLiXlsKYy0rRu03yJ4qn/vFMgXDR4/BFKEu8yBUNrVFHlI550sUJiPpRfZoNCJCoBVTjsrTbT8hhzqxA1FaT+LScdJKF0p5r8ix+ZBfWkOG2NIRzTGfsrlBgHWHWxuqMqhBMkvkXKFFjrSCTwRqdR/YF4la3SZcMO7KQ5l73a/v9oU+YDA3H/VlJ2iPxNx4uLUPAdBttPGNxkn5kJtKw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd91e2b-47f1-4349-1f39-08dee329e921
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB9509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 11:03:47.8457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waeasG18yD4Ni1g43H09R8MTflPe+5K2LrGofn/76ZECAJz9KthH+cJSL5HNmqlW6y5DHxDj5umluY6fpq10hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6249
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784199840; x=1815735840;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cJtFAf8OtLa2ObTQq937KWrRQAgJ4m7Acnxxoq+tKWg=;
 b=CAsL9MZ3D003vI7z5wRbrPK8byWf9H1Rz6RXJ19hTlKgyMXu/TjEGjKT
 WVBYM+GAgA0BFFZeN9buZUdIEH8O7YKl5cpUKjQjNGiI4BQDS3rmkhoHj
 mpUDzXjoiGOQ1t8HhOrxtkUvN1NZ/ECwxImSnPp8FXLsEIAPBiNkOKLFL
 AoV7XmrwKLDz/V83LsDAQM0qgFJi4LDLfdBcKV8PqIVPusoluvmEpcpps
 SI/Mbr9imRIYOqZ9IfOXV/nQPberbOm6CHuLZqsxiDU4oLpruK1Oqn5Wg
 RKrKK4C21iISaRKoz1r2fSwJXsBUQRXjd9eFawfYzQ/6or3ufd/gfNcA5
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CAsL9MZ3
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [e1000e] Intel I219-LM host becomes
 unreachable under VM network load when AMT SOL/IDER is active
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

On 12/07/2026 14:56, Viktor Donner wrote:
> Hello,
> 
> I am reporting an issue involving the e1000e driver, Intel I219-LM,
> network offload, and Intel AMT/ME remote-management state.
> 
> Environment:
> - Host: Proxmox VE 9.2.4
> - Kernel: 7.0.14-4-pve
> - NIC: Intel I219-LM
> - Driver: e1000e
> - Driver version: 7.0.14-4-pve
> - Firmware version: 0.4-4
> - PCI address: 0000:00:1f.6
> - Link: 1000 Mb/s, full duplex
> - Host bridge: Linux bridge vmbr0
> - Guest traffic: VirtIO VM network interface
> 
> Observed behavior:
> When running a speed test inside a VM, at approximately 600+ Mbit/s
> download traffic, the Proxmox host becomes completely unreachable over
> the network:
>
> - no ICMP response
> - no SSH access
> - no Proxmox web interface
> - the physical/vPro console initially remains available
> - a normal reboot may hang, requiring an AMT hardware reset/power cycle
> 
> The NIC still appears administratively UP and LOWER_UP, and the bridge
> configuration and IP address remain present.
>

Hi Viktor,
I'm not very familiar with Proxmox, so just to make sure I understand 
the setup - 7.0.14-4-pve is the host kernel, and the e1000e drives the 
I219-LM device on the host, whereas the VM is running VirtIO which is 
bridged over vmbr0 to the host?

And eventually after the speed test has been running for some time - the 
host NIC hangs with all the above symptoms?
> Relevant boot messages while MeshCommander / AMT remote management was
> active:
> 
>     e1000e 0000:00:1f.6 (uninitialized): Reset blocked by ME
>     e1000e 0000:00:1f.6: PHY reset is blocked due to SOL/IDER session. 
 > > After completely closing MeshCommander and rebooting, these messages
> disappeared. TSO/GSO/GRO were enabled again, and repeated speed tests
> did not reproduce the host lockup.

So the issue only occurs if MeshCommander is active at the same time 
that the speed test is running in the VM, and TSO/GSO are enabled?

> Please advise:
> 1. Is this a known e1000e/I219-LM issue?
We get various reports of I219-LM hangs related to TSO/GSO from time to 
time (GRO specifically is not supported by I219). Not sure whether I 
have seen one mentioning the specific scenario you are running.

> 2. Is blocking PHY reset during SOL/IDER expected to prevent recovery
>     from a TX/RX hang?
This depends on the cause of the hang. If it is the part of the data 
path that is specific to the host - then it should not prevent recovery, 
but if it is somewhere in the PHY - it might.

> 3. Are there recommended driver parameters or mitigations other than
>     disabling TSO/GSO/GRO?
> 4. What additional traces or register dumps would be useful?
A dmesg dump from the host at the time of the failure may help. Were the 
above two messages the only ones from e1000e? Normally, if there is a Tx 
hang in the data path of the e1000e driver - it will show in the log 
with a dump of some registers.

> 
> Hardware:
> - Motherboard: Gigabyte Q370M D3H GSM PLUS rev. 1.0
> - Primary NIC: Intel I219-LM
> - Secondary NIC: Intel I211 using the igb driver, currently not cabled
> 
> Regards,
> Viktor D
> vikdon@gmx.com

