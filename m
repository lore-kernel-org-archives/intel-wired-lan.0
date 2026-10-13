Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28200CC6B12
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 16:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA6E0606FF;
	Tue, 13 Oct 2026 16:32:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NeJca-0Lrq35; Tue, 13 Oct 2026 16:31:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7C36D60643
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791909119;
	b=N4UhsfsNT43syyaOvJZn3Iiinl/WclwgxKeBnK4TAIL7sLHWnZKQqwZLYGxY0FIlW3x0
	 aOPZNqn3hfJGS+TKzVh/t2MTDS0saQ5igzy+LT8mwphoTdQAu4xQPC71XGolbKMtU9+ob
	 xtYSF0v3K/gh4yNP0PJtNIP12ByyzQ9NUsbl8d9YFeVvwxLZGIYUdkPnfzS9mYvxM1iOF
	 OcqDDzplY6laPqetjh3GoVd4FzlAU+srGj5J+b68ehb/BYF6R6LwrQyrZBLpHxhzLbMpI
	 0ZxCZ2UBM/9ohNgN+rCmridRoYJsZVbZ+gQ9PTDj/dUz0C6n35YsbJEFGBMFLhOhbvQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791909119;
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
	bh=afFkGxRxjxC7cbVhQKw5Fd8nH25DELMJN0tG+zm0hfw=;
	b=NoVerjpYbaXCV5wIEy2WSp7V3gEw585djyhXintjNOWDONQ92LKuZH3giyQyB+udV3Sp
	 jPDNrFPkSwLIbZcfJbvdqK8SxQok6BDRcYMpWAaFcweOfDwsFWQB+VjgjFqeESQUVvnCO
	 SSclurRMXkifD1sj6Nfp2ptq1s35OhGYwCPsmEjeaoIlu1XHbu810gvahHbYZeZ/W5dIs
	 DCIUxPSpZ3tEjbQ1JkoAWmIUFjmdPdf68mjKy1K9gGMzT8RA5LJnQmXCcrOBsJmr5qkQI
	 F9shdfHQVh6+ryUru6GIL4atl/VMHdvtPzvFT5NNpvDOhrMj2j8SLAGu792/GiKF+sw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791909119;
	bh=afFkGxRxjxC7cbVhQKw5Fd8nH25DELMJN0tG+zm0hfw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V82bYlM7rSI2iuIMQe1Ug50q1klis6ulAcinFBNIWKGPRCVMbMSwUIwOV18GIkh1t
	 KtPtGYiyrpNzner12DmJ94rcExXKKmylp9mJtvtMgUWUVrBLIEhEhemg3sVGxRCq88
	 hn3PcSfS7kahwK4C4bBIG/0678DuoOPkkwhNsMF1uW6pE24yjTDJIdadB9enPXCF9P
	 Pga9SmcveQjb5uCPsVMyfqkObyOTdlVoxAorF5HM8n3+aFB5BQnW/Cs1xvs2c7ESmg
	 N4c2vXmkiyqwVukoqEa3+VYk1Wzqn/0t54aFW8T74QacKFQKjmKhQWp+5wHMESO07C
	 6xTjYEwqhZrUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C36D60643;
	Tue, 13 Oct 2026 16:31:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23D2F788
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 16:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A16580BD6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 16:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6gPPQRgTcPq for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 16:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EBD6980898
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791909117;
 b=N0oqirR1WxJK76Wn87xsk25rX6a4nZ1scPt9dUqTj+b5Se3ymwqQjQ4+gsp2U9Dj4bUD
 bV0OFaO73S7Fhcplj/WNWfyMtkD5PP1gTOkyrSmh8qW6zAeODeUAM376iKGmsyZN8xblg
 zDjWP5b9jpEXB6LO/Du6Y/bw5rwCwiAYSHBMzvP/QlBtBIPpjdB+1AQHDPnl1Eq40JYmc
 f433LkWYQ6DVg0xmzoCUW9o4QD9MS5sbRNxcMfTuRwvyUbHdlKzQ9orL0WrJOkpApCNtl
 dHmhcLGbylcTEJcRSkibh2LRb+pnSpI1XQo3OQn810O9r04AaI/515sKe6myrnq5VHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791909117;
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
 bh=afFkGxRxjxC7cbVhQKw5Fd8nH25DELMJN0tG+zm0hfw=;
 b=JyqdpiWb7xi1vjq8zINIPh63aUDrRNULJngodeJhb6Ud4BKU6UN9qAPXBr+d5/T6EGTm
 tVjKN1EoxZ8LTSBRPEvXNXMFEBd+bkwbn0/muK6y0TzfqOkPZ7qkRcGqAtRNgsiIj7WIZ
 sPytUFlQyd99wydn4PkrzCRLuSvBzXAn2xsiK0hL3eSn3qgJOJDTOBtSEMjbrsxWVSFtL
 3xeNJGRCOpKl6uIhpXP97gsShRXp4siJEmnBmG5X2Gnv2y2mppztD7Z6z6z7Iv3yU6Oev
 roIbzZzDbUP3ILbIWVchOFQC3iq5KEbS2j7CePnaK/rVR2Y0YtmpCdhvMiA5WKY0FjA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="Eie/cCXi"; 
 arc=fail smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Eie/cCXi
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EBD6980898
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791909117; x=1823445117;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=b23BxcFLjTLhPZbAw9vUNScru+rOcu++7EExCaoPPdA=;
 b=Eie/cCXiKsa/GW08jbhyeQ99Bg736Pmun1zaQy0KiramiRQOUyRYv1V5
 wSHtO9+jPNpdOMTau/E0GNYOA+HguGs4y8Jk5DdYQT6SMOOeU38eH9Ztl
 o5osptecxxePoeCFDlevPxFA8msWdaaebefD+BL6kYxH756KfrFe2comI
 bGEVcu2KzCXBDepwefq5N/Fy8LViKEovFigkDlgOs8hoi6FL/5JHA7//e
 uPWif15Gl0mzmXFDDUECmTCdGRd+/E5Te8+TGUv3WedkttJWumjONrW/P
 xACPuVfOWRI5SsMaj6Hh3r0XB97xCeVtzRXC+v6c7xG3NteJ6Mel/Y7Ez Q==;
X-CSE-ConnectionGUID: stGuXt9lSiCByhm1nWgn2g==
X-CSE-MsgGUID: yyVduQJ9T5CBSSRKQhtW2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="634554"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="634554"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 09:31:55 -0700
X-CSE-ConnectionGUID: NkMOScFjQACblo5z7C0AjQ==
X-CSE-MsgGUID: onVyrpqmR3SZatmWEMkgSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1210204"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 09:31:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:31:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 09:31:54 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:31:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daOe+V/H448ekvycZQogK6jdIDArdt/6ZkqUfP8B5QXvatE3dwyuM0pyDHXzMabclIhyHCiZ/lEKq8dLNyn5XaScrsNlDavOoKIznXTAIW/A4IyDUYMdX0rzDDuT/31P8ngXJKpxmxj1Pz1NZZhZSE3ABMuHaTUFEiLKbolA+BAhE0QUZmkEh/5X2kk1ce605KsNtNmXfRHXoWsUOTIz/P8DbIbuXXSX/rcoRq/Fhn/XQ7rAD80XnXVzQbIi5dQINgASZVyW4quao02XbpeK6mjZfTloLM01hAfqK0LUEYuHJC1hrHiQo9MbCD8ShkHuAhJ/Mvb7f6fC/6PdFpqffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afFkGxRxjxC7cbVhQKw5Fd8nH25DELMJN0tG+zm0hfw=;
 b=kC+3O+ExgKhy3nzrtnoszpqtK7vMSiOkPpHQ5aeAeHQYycUcZQ1WzBriYAqgnz4kefXWnK+3Z+NMPP9i2LiXb3U2M5QgiKSQPH4z61+n42HJsfXiCKF2unIVTSNWS7iN/BLRgYFs/LdUU4KSFvZXIC+GmHoeilQpv76zyZX3p2b4L3JRb4GeM/8LJxpLdi5a0GmhCMguOL8wUNOsWU6FStFhf5F6NCB1vCziuYwcDicJ5Xb2ruDLQiCiJQWv+3cCoQTkq+G4YfQ9IZz/uMmGdDPe++QVC4GI8E4egoP3ZXeOsUTiiTXoelK0m/Jj8AcHLmCJM3iOXmt/rfi+qSC7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by PH8PR11MB9831.namprd11.prod.outlook.com
 (2603:10b6:510:3c4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 16:31:44 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 16:31:44 +0000
Message-ID: <ca88d67c-1595-4bd7-9560-080de7104e6d@intel.com>
Date: Tue, 13 Oct 2026 09:31:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v5 3/3] idpf: keep the mailbox up while tearing
 down vports on shutdown
To: Tian Xun Ng <luckilystar08@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
 <aleksandr.loktionov@intel.com>, <decot@google.com>,
 <milena.olech@intel.com>, <joshua.a.hay@intel.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, Tian Xun Ng <tianxun.ng@bytedance.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
 <20261013121224.84482-4-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261013121224.84482-4-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:303:8e::20) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|PH8PR11MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: a08a4ede-1e09-48c4-4875-08df294777fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|56012099006|11063799006|261009220027099003|261009223327099003|261009221227099003|261009223027099003|261009221727099003|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: W/FwJCOHJ7sppxJTFN2WVPnll3PgOu472NibaRvHRsPgA23joatrfgrADubV5OB36yYVADZEJrf2daHORv/06tPvIRGdX4EGuXsFQsk2hHZpVi9EYJr/Ck3K2VyPzvC8aBE0mqeDjtI1upeKriW6cjJWEDj9DNzeOKdNWTDU3NT51O54ve4R6H4x33sxLfEjSI/5YwyWYDBlsIJf6ZD3pDntbKBIhgHbAFI1KsCNV+fptZT8wnGVyWg4ek2DNLgw0rjng9C3gMkkq5I/ikfuqkiheUQ1iKWxYOT7UG+JUrNbE1uZStig1p74VdVTbfTqPw/fqzr06HWsZeqU2gwBASeLLeFtbwKRV7bccOZfc8kskZfFA/Kpor9aTgtZgWtM0U92SYVWRJvOUthFEo3Z7/VDRWwHcF3MpCEsSLsnHHfe8rBK1972zSpE7FIAlcnmnrDB0ZTCU8/uyaQcrDOc6JuJ82dpA5buLHemBGt6OBn66EzmH9kA8hRktKuZ2E6cDwP1ZUAn4KV3z/pjqcz1qgH0TgdDdPC86Dld3l9BGQQ7D8fqW9jdIDby70OzFK21EbHvEAjo3N3Ue4SEOh2WKZ7+QBhKwzzYZL3Q+WFu2c8eCavanW6iuDV1etRPxw7zqqK6zEARYh+s7vOWiX0YCt42Xs0umehFmMB3uYpA7/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(56012099006)(11063799006)(261009220027099003)(261009223327099003)(261009221227099003)(261009223027099003)(261009221727099003)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBuWUp4bndnc0QxdUlTdVVjVFRRSWtmVGs1VG1pbmp3NXZHY0Y5Qkk2RlF4?=
 =?utf-8?B?dWxTQUdTVUozSW43dEF1VUxINXVOcEI2aTlMdE5ya0RieUdGelp6RXhLN2Zh?=
 =?utf-8?B?MG5keXMxaUZhNENDVDcrcDJ0empUNVlnRkFIejNwWWJYS1h0dUlWaEMraEFU?=
 =?utf-8?B?Q1BSbXlvU1NBVWhYUWFBeDUvV1NTNHhBL0FvaUdMQW1jNUJzOGFvekc1bGpj?=
 =?utf-8?B?QThwMndoaTNPQk9YSHVKcEY1aHV2YkRiKzNPdlFFRVh0UE41bXdxbVJUemZP?=
 =?utf-8?B?cFNoUzVwZnpRK1IzckRYZTFLcG9oSW41dFcwTmd0bkpucXRnQ3hiREY3Mm8y?=
 =?utf-8?B?Q1RXWTNWWFNDcXZDNmQ1S1FTTlpEamExSWlkZ1pQQWVhRFpTWWtjaVVDT2wr?=
 =?utf-8?B?TlljTUlkTHJuVjNVbUFrbVRFSTVJUUxmT2ZBc3ZnaTUzOEpQZnkrN2JHRk4v?=
 =?utf-8?B?OGJoQnFmMHdQVWZwZmlxb0dKbG9Kczl1TStIam5ZeU5Iazk4bVBrNUlRcDE2?=
 =?utf-8?B?Ri9FMExuSVI2K1VBV1I1azl6ZGhnVUdEYTNtclJBLzkvU1hmK3NmVVEvdUw5?=
 =?utf-8?B?NW9qc0MrekJyMWxQeTl4RDhPV09JZDVKenEzUVgrSmVTQklaVC9sbWVWSTQw?=
 =?utf-8?B?SUVNS0E0SWVoMUZ0QzZuL2JwZW96VmV6TGR3ZVN6Rks0VVNJU2pJYmpiZ2lK?=
 =?utf-8?B?Z3ZVcThPZXI5cE9MTy93Ni9WSWVlZGtVNDB3ekJkdzVWdURvTnpodERvdlpl?=
 =?utf-8?B?WFFjMXVJaklSVnI3RHZzM3Q5WFQyeDZJWlVkOFlMNkRzYlRYQ2xnL01lRFcx?=
 =?utf-8?B?VUFUMVFaMXVrZGZxUFBCT1dDRXNNVVVSMXh5SkJpdlhsMlkxclprOW4rZ2do?=
 =?utf-8?B?Q2t4MXVCMURLMjBEYUtIQ3JqRXlKMmh3anF0RFJCeEFwZTVubXFERDR5dC9v?=
 =?utf-8?B?d3NUY1dSOTdBY1pIblZ1SlFrR1dnNHJQK24rNjVuTXd0MGVjaFFPYmJUWVpD?=
 =?utf-8?B?cVQvTGxLWVZQeEIxd0l2S3psNzEyM1hzdU5TdC9aT0JlejVMeHUwV1NROTM0?=
 =?utf-8?B?QlVwSlg2L1ZxTFhYTGNZVW9Sc0RoZVFxWTdqN3BFdVFNZkttR0Fyb2hNQWF1?=
 =?utf-8?B?bE0wQThKMWhnM0U3dVdSeEk2TWVVMWVuVy82cTJMS0pxbHBrZW1ZeG5HdFJa?=
 =?utf-8?B?QkhDZGU1VDZvK0NVMitUTm95WWZGTU80dmtCOGMvZTdoWGRMNnZhZWFDTXRJ?=
 =?utf-8?B?SXNkdm1EYzVvb3dSN0hlZjduSE4yNks4WDljUWhpR3VqbjJTTHdRdHJjd0M5?=
 =?utf-8?B?OWt1bFc1V0d2Q1AvaU5TYkVVOUtrRWdUeHBRSUxDMnk0SXUxb1l5WnQxV1BQ?=
 =?utf-8?B?YUI2VW5GSzJoSU1DOW1PQTBuQTE3MkhFNEl3Mk4vOHNHTDZxMk5FaFVKYVdl?=
 =?utf-8?B?WHJwaFVrbGwxVTQ1U3d1VVAzb1prd2xIQXlFNjE5U0JTYWFGRTNiTFJhVHVY?=
 =?utf-8?B?YW90OFRYZFVOeVgxTnFVSlFuQm5jUlZBYjhtL2p0SnpyeVpOOTNyVFhyNlVn?=
 =?utf-8?B?b0o4T0JiaUN3R3g2Y21peEYyVzF6cVBOUmNzdU9YYUltNWtFb2ovREpPbndE?=
 =?utf-8?B?N3NRNXdqOW9ib2t2R2liSm9mNGRIczFZZWZEWkZDNmhaWGUya0lGZTJrQXBi?=
 =?utf-8?B?VDlZM0hXZ01wK1RGOGNhOFV5MDg2VXpOTjN2dzhmeDNnNmtFbkJXa3BMQUZV?=
 =?utf-8?B?UDIzeEZITDJ4ZDZGNWdaZnQycmdJOU0veU9abmhma0VzVmNRNDBJWFQ4L1JG?=
 =?utf-8?B?YjFaNzd0ZWxjZVZvWkYrTmVVY3VXMjJyK0t5NHpjazR0UE1Oa0RSSDlQb1Vn?=
 =?utf-8?B?ME1QKzh1bXloZEVrOUVlTVVtU1YzMVd1c0xRRmU4SHFjd1FVM3pNMEozUlJ0?=
 =?utf-8?B?WUs3OWFNYkVyTk9WdlVBNWs2OE9SZTQ0bkhxOXRTTzF3NUFHNU5RQzUzdGNE?=
 =?utf-8?B?eFFDbEM3Yk0rYmgvc05ZV0QySHVuQlFYNXlxQW45a0ZRYmpVaVNDbWtTT0FC?=
 =?utf-8?B?MzlvbHEwVmJSU05Mc05lYXR2SThrL1Q4RzBycjNRRTNTVklseFpmY3Q2NEtU?=
 =?utf-8?B?TDM5ODVDenlibkIwbytpMHI3WlUweGpjbDAzb1c0M0Q2SjJPaW1DblVwTERv?=
 =?utf-8?B?cVlxZ2pDMksvL0tDSVFNMzdtRU5EVzQ0aE9NYm04d0dBazNvMTBaVjc2OFBN?=
 =?utf-8?B?cVRYYyt3OGdmb25XN3FocmxjMXVocUNZWXZidHMwSENjZUJxcjFRUHFTejE4?=
 =?utf-8?B?aGRPanpPSzVuZDdKU1VYRXdpTmlER2FtMUlsZnJSM1ZCVmtKV1htZ012UHB1?=
 =?utf-8?Q?2zHymAEdtjZQERpk=3D?=
X-Exchange-RoutingPolicyChecked: xFbfjIDa44bjT3yQcmrwAc4JFexckF/DB6BO+/RAJInKE36A1Xw7WXdwGXCqFp5/1cOsvNkd9uHefuGqiPrLXAZA6heQBi39Av3A22z5n9n6yQQefwoJl6byiEK1PjKA7XK0zTKjYNd7EVagrFIjHJUgZHpac5pUhM9eAfTUMTHQzz5lRFq+G585D86f0FwvgxbnPlrJP7eNE/TMuUgPci8VDRJHTrLCbgZbw5MJN/f8XGYkP0o70KYERi0pc3x5uXpc0t7h6xkCaqM3XJF6lT37oRC4L1k6AnHm8R+CNAJHf3C8LYBt7Dx0R3739pnbqJ6TfYDcN3a6XM12qU1Dyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a08a4ede-1e09-48c4-4875-08df294777fe
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 16:31:44.3377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQUCH6wcMbvaMBN+Rp3RuWOSWM8AUHzCAn6NSGOFQUvOkEAOXeUJcDkGkfuDxL71i5Pfa7Bc1MmFcVfIODzk7RwjO0UKXdgFS9zB08OezrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9831
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



On 10/13/2026 5:12 AM, Tian Xun Ng wrote:
> From: Tian Xun Ng <tianxun.ng@bytedance.com>
> 
> Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
> on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly instead
> of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on shutdown.
> idpf_vc_core_deinit() uses that flag to decide when to shut the virtchnl
> transaction manager down. Without it, libie_ctlq_xn_shutdown() runs
> before idpf_deinit_task() tears the vports down, so every message sent
> during that teardown (disable vport, disable queues, destroy vport)
> fails at once, and the device is never told that the vports are gone.
> 
> A reset should clear that state, but on the system where this was found
> the device kept the queues enabled across a warm reboot. The first queue
> reconfiguration in the next kernel (udev setting the MTU) sends
> VIRTCHNL2_OP_DEL_QUEUES, and the device then writes SW_MARKER TX
> completions to the previous kernel's completion rings. With the IOMMU
> translating, those writes fault about 19 s into every such boot:
> 
>    arm-smmu-v3 arm-smmu-v3.12.auto: event: F_TRANSLATION client: 0006:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0x3ef60840 ipa: 0x0
> 
> In IOMMU pass-through mode they corrupt pages the new kernel has reused.
> 
> Set IDPF_REMOVE_IN_PROG at the start of idpf_shutdown(), as
> idpf_remove() does, so that the event task cannot be requeued and the
> vports are destroyed while the mailbox is still up; the first two
> patches keep the Tx timestamp callback and the link event handler away
> from the state released on the way. So that an unresponsive control
> plane does not hold up a reboot for long, cap each transaction sent
> during the teardown at 500 ms instead of 60 s, through a new
> adapter->vc_xn_timeout_ms, and fail later synchronous ones at once after
> the first one times out. If the SW marker of one disabled Tx queue does
> not arrive, the remaining queues of that vport do not wait for theirs,
> but the mailbox messages that follow are still sent: the device has just
> answered DISABLE_QUEUES. A control plane that dies at that point costs
> one marker timeout per vport and one mailbox timeout. The statistics
> task stops sending once IDPF_REMOVE_IN_PROG is set. A request it already
> has waiting, or a reset already running in the event task, keeps its own
> timeouts, as bounding those would need support in libie. If the function
> has already been reset, for instance a VF whose PF went down first,
> idpf_is_reset_detected() fails the messages without waiting.
> 
> Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
> this series backported to a 6.17 kernel and the IOMMU translating: 20
> warm reboots without a fault. Each PF's teardown took about 1.2 s for
> six mailbox transactions, with all 64 Tx queue markers received; the
> slowest transaction, VIRTCHNL2_OP_DEALLOC_VECTORS, took about 300 ms.
> With the first Tx queue marker treated as missing, the other 63 queues
> did not wait, all six transactions still completed, the teardown took
> about 2 s per PF, and 3 of 3 warm reboots were clean. With the driver
> made to skip sending the teardown messages, every reboot faulted again.
> 
> Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf.h        |  5 ++-
>   drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 ++
>   drivers/net/ethernet/intel/idpf/idpf_main.c   | 11 +++++++
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 33 ++++++++++++++++---
>   .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
>   5 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 470bc23c8..a789230dd 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -85,7 +85,7 @@ enum idpf_state {
>    * @IDPF_HR_FUNC_RESET: Hard reset when TxRx timeout
>    * @IDPF_HR_DRV_LOAD: Set on driver load for a clean HW
>    * @IDPF_HR_RESET_IN_PROG: Reset in progress
> - * @IDPF_REMOVE_IN_PROG: Driver remove in progress
> + * @IDPF_REMOVE_IN_PROG: Driver remove or shutdown in progress
>    * @IDPF_MB_INTR_MODE: Mailbox in interrupt mode
>    * @IDPF_VC_CORE_INIT: virtchnl core has been init
>    * @IDPF_FLAGS_NBITS: Must be last
> @@ -625,6 +625,8 @@ struct idpf_vport_config {
>    * @asq: Send control queue info
>    * @arq: Receive control queue info
>    * @xnm: Xn transaction manager
> + * @vc_xn_timeout_ms: Upper bound for each Xn transaction timeout, shortened
> + *		      on shutdown and set to 0 once a shortened one timed out
>    * @num_avail_msix: Available number of MSIX vectors
>    * @num_msix_entries: Number of entries in MSIX table
>    * @msix_entries: MSIX table
> @@ -684,6 +686,7 @@ struct idpf_adapter {
>   	struct libie_ctlq_info *asq;
>   	struct libie_ctlq_info *arq;
>   	struct libie_ctlq_xn_manager *xnm;
> +	u32 vc_xn_timeout_ms;
>   	u16 num_avail_msix;
>   	u16 num_msix_entries;
>   	struct msix_entry *msix_entries;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 827c795af..e4af4ebd4 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1358,6 +1358,9 @@ void idpf_statistics_task(struct work_struct *work)
>   	for (i = 0; i < adapter->max_vports; i++) {
>   		struct idpf_vport *vport = adapter->vports[i];
>   
> +		if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
> +			return;
> +
>   		if (vport && !test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
>   			idpf_send_get_stats_msg(netdev_priv(vport->netdev),
>   						&vport->port_stats);
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 129bccaa6..21be83dc8 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -194,8 +194,18 @@ static void idpf_shutdown(struct pci_dev *pdev)
>   {
>   	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
>   
> +	/* As in idpf_remove(): keep the event task from being requeued, and
> +	 * destroy the vports while the mailbox is still up.
> +	 */
> +	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
>   	cancel_delayed_work_sync(&adapter->serv_task);
>   	cancel_delayed_work_sync(&adapter->vc_event_task);
> +
> +	/* Bound the teardown transactions started from here on, so that an
> +	 * unresponsive control plane costs a single timeout. A reset or a
> +	 * transaction that is already running keeps its own timeouts.
> +	 */
> +	WRITE_ONCE(adapter->vc_xn_timeout_ms, IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
>   	idpf_vc_core_deinit(adapter);
>   	idpf_deinit_dflt_mbx(adapter);
>   
> @@ -267,6 +277,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	adapter->req_rx_splitq = true;
>   
>   	adapter->pdev = pdev;
> +	adapter->vc_xn_timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
>   
>   	err = idpf_dev_init(adapter, ent);
>   	if (err) {
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 2cfd216ae..331d56fae 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -194,20 +194,32 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
>    * Cleanup the mailbox queue entries of the previously sent message to
>    * unmap and release the buffer.
>    *
> + * The transaction timeout is capped at adapter->vc_xn_timeout_ms. Once a
> + * synchronous transaction with a shortened timeout times out, later ones
> + * fail at once instead of waiting again.
> + *
>    * Return: 0 if the request was successful, -%EBUSY if reset is detected
> - *	   or Tx control queue is full, other negative error code on failure.
> + *	   or Tx control queue is full, -%ETIMEDOUT if a shortened transaction
> + *	   already timed out, other negative error code on failure.
>    */
>   int idpf_send_mb_msg(struct idpf_adapter *adapter,
>   		     struct libie_ctlq_xn_send_params *xn_params,
>   		     void *send_buf, size_t send_buf_size)
>   {
> +	u32 timeout_ms = READ_ONCE(adapter->vc_xn_timeout_ms);
>   	struct libie_ctlq_msg ctlq_msg = {};
> +	int err = 0;
>   
> -	if (idpf_is_reset_detected(adapter)) {
> +	if (idpf_is_reset_detected(adapter))
> +		err = -EBUSY;
> +	else if (!timeout_ms)
> +		err = -ETIMEDOUT;
> +
> +	if (err) {
>   		if (!libie_cp_can_send_onstack(send_buf_size))
>   			kfree(send_buf);
>   
> -		return -EBUSY;
> +		return err;
>   	}
>   
>   	idpf_prepare_ptp_mb_msg(adapter, xn_params->chnl_opcode, &ctlq_msg);
> @@ -218,10 +230,15 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
>   	xn_params->xnm = adapter->xnm;
>   	xn_params->ctlq = xn_params->ctlq ? xn_params->ctlq : adapter->asq;
>   	xn_params->rel_tx_buf = kfree;
> +	xn_params->timeout_ms = min_t(u64, xn_params->timeout_ms, timeout_ms);
>   
>   	idpf_mb_clean(xn_params->ctlq, false);
>   
> -	return libie_ctlq_xn_send(xn_params);
> +	err = libie_ctlq_xn_send(xn_params);
> +	if (err == -ETIMEDOUT && timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC)
> +		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);
> +
> +	return err;
>   }
>   
>   /**
> @@ -371,6 +388,11 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
>   	struct net_device *netdev;
>   	struct idpf_tx_queue *txq;
>   	bool markers_rcvd = true;
> +	bool wait_all;
> +
> +	/* On shutdown, once one marker is missing, don't wait for the rest */
> +	wait_all = READ_ONCE(qs->adapter->vc_xn_timeout_ms) >=
> +		   IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
>   
>   	for (u32 i = 0; i < qs->num; i++) {
>   		switch (qs->qs[i].type) {
> @@ -380,7 +402,8 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
>   			netdev = txq->netdev;
>   
>   			idpf_queue_set(SW_MARKER, txq);
> -			idpf_wait_for_sw_marker_completion(txq);
> +			if (markers_rcvd || wait_all)
> +				idpf_wait_for_sw_marker_completion(txq);
>   			markers_rcvd &= !idpf_queue_has(SW_MARKER, txq);
>   			break;
>   		default:
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> index 5d27805ff..911a25ad9 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> @@ -7,6 +7,7 @@
>   #include <linux/net/intel/virtchnl2.h>
>   
>   #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
> +#define IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC	500
>   
>   struct idpf_adapter;
>   struct idpf_netdev_priv;

Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>

