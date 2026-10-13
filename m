Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DCACC6B19
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 16:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FD3B605CB;
	Tue, 13 Oct 2026 16:41:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NDD5362xpFI1; Tue, 13 Oct 2026 16:41:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B0E6B60643
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791909714;
	b=Zpw55HxfDHqqjpiTmaQgqQ/9Ks8/WJD729g4JHSm2QvZZophZULpv+ibrCCBqKFytgmO
	 UcnkC6Etm5l6RlJ41yEw+sAureIoRrYfuzSmfqjvA2zJHvEp1fo/K+Fr5irqSWdu4rwc5
	 VurNl7YkcWbD9W7haQ/jn4tXpH13EGMOzeF/5EE6rW3Zij8CxwHT9EZV79BDM4LfEmLN0
	 VaJ47wCAbpjvpv57+LCqwH8xVCx7KRoKpd4HqH16oTmWYZKVlIJs6mK8VfD6ldh7lkq03
	 F5K6xW/suSdxM4jLFXFja6rKAsnMdqOUiBWYL6Ee4gVwQVvF89B+MQUUgZAXyJfQx1A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791909714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=TZE6ifFgIG+7vNhHjqa7S68/fe3VKY34MPsZfdy1mos=;
	b=j07wOai1H24+BI2Pnt/51aCYtTlVabb0AWxpHkmoybn4ZPFPssr5j7BbNKHloIGbQ+/U
	 1PPfqYtH/qI7X7m9Q8U5Fg+3F44t3tbEUCkbsCfTG1fefPGIbLD3ay+RKIl8f74fUZi02
	 g4rNRLQQhxdWXg2ogkEQYznlBVwLqKt3L3Kl4WUAbRamtNJCOlUMOr3rGCoQ2mf0jjub4
	 PhjISx3NPwtgZQWZjvnp5jkYfT2gaSqa783A3Bq8TSzxePIXcy2t2WY2ENVRmBrWDwF7U
	 KoysDjQghEWPjOeyc6q11getaxXHXq6LoVwuaU4ccUMk9XfAQn5WbQhDwxVHpXlwmGA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791909714;
	bh=TZE6ifFgIG+7vNhHjqa7S68/fe3VKY34MPsZfdy1mos=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RcFZXFvyATXkA/k6QK4XWdVTxcGBBomZAp4RavmBnzGTu4ZO4bASnTntuQvYMdM3G
	 tlFWTygNfy7h9CD33oE+AXThIsraGvSQHsSzI18/c03rWBHfrS18apW6QWjBighOhm
	 E1xISQAeF5fWHcCtDgFMNKfpBCZaE+zQKaXG3QfziGvyPHq+iby7VEKQNmR6az3Ofz
	 d9ya7I96nevy6r2+o55Jn7yuQaRb/JjoMg7d7wg8y1zZfRG+tlLskIKYKVrT0OhTCZ
	 LitER2JHIrGqcc9p4ylUPcpoEzEMLXHKYnbYpjYZHVP2Ue0pVtE/+SvbNS0UCdVs0g
	 LaF38az/5vLag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0E6B60643;
	Tue, 13 Oct 2026 16:41:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 63691DE0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 16:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5592F4009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 16:41:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id my6Q3HgGoA12 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 16:41:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 418674007D
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791909712;
 b=j/9pZzZIOhcAmFJ294t/WcNAJ1Lb/I5WsP5yrpI5/I2D4LtPysCZB6QqnA3Owoytj9uo
 mWbtBTloDIJ8eDui5bVdvuDzPKaVsLEQTIpE9jns7npNrj5gf1gbYcuqpkcnjraoZBOuZ
 Ba4i3K7/Ejf4qQKmFWiEUs9FwHbIY3FKKK605yi4XbskAABX2YBUu5P982lgNEkx/8F9v
 9QcDgEWcTVgvVllq4MXVyAMYahrkhQnAD8093b7OdUGI+A9r3R2bNCsv2BPrQGSutFP+H
 2ENuWpyto0fsaVhvUqfUc16BuWQiPRwNl4Q9bbv+vDF2o+zdatlkD7ywGbOkptScd3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791909712;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
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
 bh=TZE6ifFgIG+7vNhHjqa7S68/fe3VKY34MPsZfdy1mos=;
 b=AG4lQtZ6FLT1NWRCfXQnxqpIAvG+KZljlcF2d1GGrDbqu9JBZwQDGxFnl1OCyhe29G/s
 pKxUwHfirFqebvjZsY0naaYEvPYVrdVUmuOM/D2m5NFz62ChxUktMHNljK3WwW68b2/Z5
 njon9duZmCMmyG0cK36aWpORfv0sTVWFJYWJYqwSttcLhp+FQw58lEiTJsgFJMK6NnnMc
 vCQQsoc9T9Yro7R66YbUiZbEpkIzDfdTVtQAMBA1SXvYZwN1gfe0Q420JNDecTQ3XFtNq
 IPVhbzeyy7y3+iKgk3wSYF1hFRPUKXkbLFnOoTSXw9arUu3bUyt1mjf4ituy3j70NEQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QCxw+rIj; 
 arc=fail smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QCxw+rIj
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 418674007D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 16:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791909712; x=1823445712;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qb/hBytI2L6NUT81QsXW/fsl8bcmLX3FonHG0YkmyNg=;
 b=QCxw+rIjlTK4QjioL4Os9iM5WTwvYggV6xBOQX4PmNc3ulztvhslokHd
 92c5zE05bFfPpFKW72QRpM8+Zv3OoYnEq8Vh/f3N6O4PBT8NBymZffAKI
 4Dm4krAXfIc9aLZvNd8XqcF+v86cPskw05nh8EpNWd0RAvTaHALuiMrWb
 3+rcxhbyG3JT5IIb7e8lNbtJ7BXJ3w9Ni3PN/XCboH4etslIH2TUQQSTP
 AhpiXG0En+ac6//I/LcTN9IfhqSTLVcRuyomMdq67MO5M1IXSrEzYEWvY
 m9J2/ZT0GvXB17ycJu9UZGPbrx7lyOMPOpwG1aa9Eb1yO8IcL5hmMZn8D g==;
X-CSE-ConnectionGUID: DGdd0TMTRh6M8Nh/XLP+3g==
X-CSE-MsgGUID: 7n3wmY5hTNKDG0c+oQ5Q+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="516280"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="516280"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 09:41:51 -0700
X-CSE-ConnectionGUID: 4/lSlzylQbiAVwgJBykxAg==
X-CSE-MsgGUID: M2l/7VfoTma8YTizOvgv4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1529847"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 09:41:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:41:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 09:41:50 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:41:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKnP2KLo+57Ij9K5Aw2b3OTZRbmUTgkMwaT3QH+1cu4dOhkkOiV2ZDevRNAl1wu8P5QYw/oZl7EGNyXNJUnbk7xiEbOXlU9ilflEBm/dTEQyEHQdzSI5Dha4OWr63ALrmW4xqBhjKvROvYDLxcyJyZECVw962dhxljMjaUyviE3acekds2XjV98jmwiPiWKSGPwREt5CoajChhoy2A2Pncfwe3DCsC3EH1S8JjY3zvT+hh8BgQ0ivIMQoCZp24PJn5Ldt3CvvJYPr0IEiFtPxEpGga0EGLnevhnGIkWFc4Icn6H3xqh/VmoPwjJ+kumwQd5gXH4iJ8DxGwVO8IuYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZE6ifFgIG+7vNhHjqa7S68/fe3VKY34MPsZfdy1mos=;
 b=IZuXnWdZCEXokWKGd1UI2+iZTq3zAVtA0awSGFjs2RB/D5DsLr6mdMVlxFg4lel97fi0iHRRDbL07WXEunNI47Pc4WtThSNo/AbXdp0WPvDS9MG/GFArP6aBcXRoATGc2AFv/w8i1dt0pRA0mo2y+28h6l+pU4AwhM47vntqTp4XdlAYTpRBqQ5jszWU0FO+Un3RqnSwot5SZ0ZepSQnc54XG2gSVaga+4oEu/t6KThu8NJqddmhk2EAFYhmrMUF6Cu778LVKUIg7CKoG1BXUhjPSykWf9K89XoymW90d474UKXoPoC16H96Cv0UDsXzABEMpahg8f+r7hNEJsK20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by DS7PR11MB7905.namprd11.prod.outlook.com
 (2603:10b6:8:ed::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 13 Oct
 2026 16:41:46 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 16:41:46 +0000
Message-ID: <c9375bbb-1528-4221-8052-f6fa8aa9bf18@intel.com>
Date: Tue, 13 Oct 2026 09:41:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 2/2] idpf: release PTP before freeing vports on
 the init task error path
To: <sashiko-reviews@lists.linux.dev>
CC: <intel-wired-lan@lists.osuosl.org>
References: <20261009212537.3996-1-emil.s.tantilov@intel.com>
 <20261009212537.3996-3-emil.s.tantilov@intel.com>
 <sashiko-outbox-166100@kernel.org>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <sashiko-outbox-166100@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0343.namprd04.prod.outlook.com
 (2603:10b6:303:8a::18) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|DS7PR11MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 946841b9-6ecb-4722-4e1d-08df2948dec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|6133799003|4143699003|56012099006|5023799004|10063799003|10067099003|11063799006|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info: UIBHyWoEY4M+Bb7uQ/LhjDeXj8VcLFC4tQu+5TPFP6ofCmvHcIxgKSQNhhZU2mFUqHEp0UkD5cWzcMAx1+wjE/1Sy+TvzVcLd5XvILgtFJBjq9rfDUyHrqyfBxC5JbIgkq8xxBdBUWX2Zo9m5gmwS9fkk/yhAoaolusnicADeU/AvjrBSOIlI6PmWsPMZMEBNZpbRPseNjbGorP5aOiTjlDJOYuX9kYPNUQXWRuipIvcEu+qP8Rjqie8N4mMgcgLe+PKwDMS5Un+yIiT66jr+5661NrHEHt8/idnekm4am3ZrMK2rNlzwocHSShGxYys+8W56aQzkSfq7rBRXZte+kRcCVyGGPWkaKAXDHgnSkTAfngqNA7cvOMlXLmDuLgl4hk+YuEuk5nXGmoPEVRBQQRgww9mH1G7jzuDkMquTGQApUpqtQ3biIRKH1+NM0Mu+MqmeL/EM7uGWpbWaYnvY6UnY6YDHNjWXMzGnsdKOvCV1MZQEpPRetfFUUx+hYyFYf9dSXbQRvgc0tA8GLbSSSv1w6haKe5QqVA6KM0etUtPItRLSMjIk/reIScwcm6Bpc4oGw+MHzW6gk1yZVP4KjZcyUTJFPriOZRt1HsWFubIaLIY05by2927y7CPJMph3Luy16c4T47ziemdOhQ5GWxvCBQSpRtAfeXs9UdYVQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(5023799004)(10063799003)(10067099003)(11063799006)(261009223027099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THdsZ2lBVTdkSXNWaE9rN2ZzaGJPcGtBSkZ4MHlETFhIN3hTcjlOU1Q4YWJO?=
 =?utf-8?B?czVTN2tCWW5yellrKzhiMkp0MElEM1c5ZW9FcXhBMUdLM01YT0ovVjR3Szhy?=
 =?utf-8?B?NCtyVVVLVkp2OWQ5M3pBalN4bzI2OUY5UFBjN2pZcndYM0hkSjlaSzN6U0ZX?=
 =?utf-8?B?ekJiVFdUMEZNS2lEMkFrWTUyWG55YjBldW4zRDdRRHFRTi9xbzk5U0grQzdn?=
 =?utf-8?B?d2ViSTJ1cFZJNmU5SkRpODRiU2M0bGhnTC9GeFRubnBkQmVPbnhtRHJFQnpV?=
 =?utf-8?B?Mm5lMUo0SW0xTDVMS0NCZ3h2NFp0dzBoQjg2Z0xsVmFyVk95RW0ySFgwT1NR?=
 =?utf-8?B?eEJ3Mkphd2trd24rWldZcWd6U2c1TlQ4azhPWGRMamJ4TjN6QnUweXhualVo?=
 =?utf-8?B?VzBHN0ZpR25aUDRvb1luelZKTHNLZmw3dVgxenBGME80MjNPTi9vTEgyYmU5?=
 =?utf-8?B?T3dzYkpPUTRyWlRnMmlnK1EvZmszZWlvYWFRc3VaTVdlMmdMZnJoOUlKVU1Z?=
 =?utf-8?B?VVU1RmpLcXNZOEd3YmM1bGYzd1ZZN1VzbXZpSm13dlNPSVk0RHNTS2ZiQkJD?=
 =?utf-8?B?N2d4REFzSmVBYUk4aXlxcjRpclZTY05MbGZhYVVnSHpaZm5QSG5uN2ZRM1Ns?=
 =?utf-8?B?bkZSSTE2U05tSk42K3dPVDk5SEsxN2pjcjloTktabFVPdkFvYTJleExDNTFD?=
 =?utf-8?B?V2h1K21PUXBnOC93cE45eEVhY0dnTlV4YllScjVZR1p5NlBGZmlzbCtrRE5h?=
 =?utf-8?B?bTBleXhZYmRMMGI3M2ltbS8vOU5BZHZmTkJsVFZIL0FNUml3SGJqVmtZZk54?=
 =?utf-8?B?RWFmbnhLOEZmVW1mL2ZVN2kzWldoUnZJL0lwek5uTVcwVHcvb3dpYXU0Yk5s?=
 =?utf-8?B?YmY0M3ZLcEQ3Y05oRFNSOXdIbDUxbE9OOVlESjgzSDFaV296TGE3dGw4MTRY?=
 =?utf-8?B?RkFvci94bFRUTDJEYmc2UmRabFF6RHV0c3VhWitLNnpBNXJ0Y2tvUmJJZldT?=
 =?utf-8?B?aHEyOE1rNlhtQTFYaEhyMWJyN2FVTUpRMzBSci9MZ0huaTh3TkZCcldVMHox?=
 =?utf-8?B?aFFsaCtoMlFGZFczWTBtY0pqNGM2bGFqT2MvWHQ3TDNCbU1GZHMzS3pidTJz?=
 =?utf-8?B?ZmhZcy91Y1N1STFGVkdyZWVuRWpqR3dOeWsxMHI4VHBQQVFGVVFWU1hCMmt2?=
 =?utf-8?B?NXRvQmtLcEdLWWg1eTZ5SUU4Zm5hZkpGU1VLQmhxS3FqOHFEQWtucWo1REhh?=
 =?utf-8?B?dkJ1RmVBQ2VJK25GNjF0Tmtqa0o2bFgvR1Zzei9udG1Kd1o1aTYzeTZSWE9Z?=
 =?utf-8?B?dEg5NGxRRlZNSTd2R2VjcVFxVE1Qc09EVFU3Y1lIT3E5Z3I3N253cVNQMlVh?=
 =?utf-8?B?TGNjVXg4dUU2T3pTcGE4aDhzVmFHM1NlTFRRUkQ0UHIrQjFvakp4ak9BNzhv?=
 =?utf-8?B?YkdwV3c4LzNtaGFrTURmb2djOW52Zm5VSFhhS2svZ1QvaWFUaS9CSWk5UXNZ?=
 =?utf-8?B?U1VLbjBpVzF5Z2VWMlZJd1A3dDl1d241THhNS2E0a2lsRW9aZ2ptOEpLcllo?=
 =?utf-8?B?L0d5SENPMXRrWGlkSStJUzRsM1hRdjI0TzF2Y3k2dkxHRE9LZWFZdFFMdXRl?=
 =?utf-8?B?M2VYQ1NFcDFyanUvc3hUYUx1MS9mc20xa0V2QWFlWGVuNlgvUGFrUUZvVzRo?=
 =?utf-8?B?a1IyeWVMOHAzMDJkeDlsdEQ0TVBtcklvY1VxZ0ZET05hM3E1WHVTQ0NZMFY4?=
 =?utf-8?B?V1ZtY1RSd0I5UFZ0MXR1bjFNV3AyaStJVTVHbmtYVHIyTjA0ZlI4cFFQQTdR?=
 =?utf-8?B?WEJOK0JSRVQ1R243UytLQkwwY3pjb0dUYUxYOHY0VWFZRWdvbllQc3Yyb2Fy?=
 =?utf-8?B?Yk03YnFqUEJzRFZPMDNWT3Z1Ti9PL3FGcnRIeGg2bXNIdHBsbkJHaXhFU2FR?=
 =?utf-8?B?NmpiclNnNFFPeHlHV05HMEU4L3NHM3hUOU5YSjFTbGNvNzFRM0tMa2trK2cx?=
 =?utf-8?B?c21vQzhyRis3OFBFMDVEQ1NEVVVjd2lmRW1WYzl3dVZnRDRBV2NYc3c3ZHE3?=
 =?utf-8?B?MUErNnlUSHhocVhpZXVzT1VRMzU1aUZhajRxZmd4b2VraFNxNUo4eTA4aE1z?=
 =?utf-8?B?R0xka2pybUJIM1VWUWpNOW05dEw2UzUzT1ZhelVUMllyMFRXR1F4QVhVL2lY?=
 =?utf-8?B?VXZUWHM3UXppekE3VW1BR1ZURTlYL1RNQ2w3VXo3ZXZHMGlXTVlvenM5Qjk3?=
 =?utf-8?B?TnlpMXhLYmsraTlIWUwvN2kvdk9tQWNJNnY4bW9RUnVxVWt0WnhqU3J2VWEz?=
 =?utf-8?B?VGxJSmkvUU9qRU9PLzlVYzJxUTZYOTAvN0JEMUxORUVZbmFuc0xTckNod2ZY?=
 =?utf-8?Q?6BXp/zrbClLyJWlk=3D?=
X-Exchange-RoutingPolicyChecked: l8m7CqxuqDQUKSkgdOk9pDbsJIlcx2dLecJtCq+WJFmCkYgm1ikLgLqrs0nGtmgjsjNtrsVAqgVZ3A3rcMWRkYrJVIgRgJi0ZaYhFRxMmwVOweEAw48t+vPhELPQO7BDDuoYdavGoXiW6DqdArzZBRcck9fM2stWpawYluQtCjxw72gm9IhANR7rRoXk6s030wNNPuLRJLP/YXNyUlNOIdJg2W4cy3x70l/AuLKz15xErIS0TscT6xy4sGp9OSQuwBwSnK5L+VUFX+8zTJysYCyVJ0em2yBqfOn8+gSq5i3z+qQIuh84ngrLHw5xePF5JClga9YgpI3ZlWRILjLXYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 946841b9-6ecb-4722-4e1d-08df2948dec4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 16:41:46.2923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFQSJ6G5rkUPsl33vgsSvXFwIwF5zI0rSHcJGOMr48nQpJ9RK8xj/ieKObFv3fytb4tTT8fVlU4OIy69Se2mTgJHt6Rzu9bqxtOdO9NHjTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7905
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



On 10/9/2026 2:56 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] idpf: double free of adapter->ptp due to concurrent idpf_ptp_release()
> --
> 
> commit 140d271eb2e765967ee1a351714e7ad1ecc7d8f6
> Author: Emil Tantilov <emil.s.tantilov@intel.com>
> 
> idpf: release PTP before freeing vports on the init task error path
> 
> Release PTP, which cancels the aux worker, before the unwind frees the
> vports, matching the idpf_vc_core_deinit() order. Previously it was
> possible for idpf_ptp_update_cached_phctime() which runs via the PTP
> auxiliary worker to read a non-NULL but already freed slot, pass its NULL
> check, and dereference the freed vport.
> 
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
>> index a1c739cdd5406..9c541dd6ed4d4 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
>> @@ -1747,6 +1747,8 @@ void idpf_init_task(struct work_struct *work)
>>   	return;
>>   
>>   unwind_vports:
>> +	idpf_ptp_release(adapter);
>> +
> 
> [Severity: High]
> Does this create a race condition that can result in a double free of
> adapter->ptp?
> 
> If idpf_remove() or a hard reset is triggered, it invokes idpf_vc_core_deinit().
> 
> idpf_vc_core_deinit() calls idpf_ptp_release() before it calls
> idpf_deinit_task(), which is what cancels this init_task:
> 
> drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:idpf_vc_core_deinit() {
>      ...
>      idpf_ptp_release(adapter);
>      idpf_deinit_task(adapter);
>      ...
> }
> 
> Concurrently, if this asynchronous idpf_init_task() fails during
> initialization, its error path (unwind_vports) also calls idpf_ptp_release()
> without locking or serialization against concurrent teardown.
> 
> idpf_ptp_release() performs an unlocked check-and-free:
> 
> drivers/net/ethernet/intel/idpf/idpf_ptp.c:idpf_ptp_release() {
>      struct idpf_ptp *ptp = adapter->ptp;
> 
>      if (!ptp)
>          return;
>      ...
>      kfree(ptp);
>      adapter->ptp = NULL;
> }
> 
> If both threads execute this concurrently, could both read the non-NULL pointer,
> leading to concurrent executions of ptp_clock_unregister() and a double free
> via kfree(ptp)?
> 
>>   	if (default_vport) {
>>   		for (index = 0; index < adapter->max_vports; index++) {
>>   			if (adapter->vports[index])
> [ ... ]
> 

I will address it in v2.

Thanks,
Emil
