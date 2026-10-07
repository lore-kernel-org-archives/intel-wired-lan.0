Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBD2CA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 17:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A73A85626;
	Wed,  7 Oct 2026 17:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MzjS4qrbONA3; Wed,  7 Oct 2026 17:42:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 62E1E85612
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791394570;
	b=MmQuEbwkQpnix95LHJk9AKAEjb33vXI8QJBdpJu6vCj3opwpxwo18ZyWfojeOXbhuPFE
	 sL+RzPRJH5KtyJMnDWPCNX49FVPzoryOfuDgxyciFQfJKMNqnVN3aSGLjXGyY3vjTSHIf
	 JhIJ5W9wEOAFzRLtIkCDwrjxZcNmLydQpNMSh5iyiacj5cJsKx8LUC/RYyeLboN+RANcx
	 tJNfKChzYo0QFCr+2FAc4gTv0SUbIf/Or2j25b+hWCFlszMma/hiTvyY9b2o9/uTsF0Lm
	 mId8UWzjBbf2wMCpx1pqV76yrl8yvSGkTuDHC3NekRSAgRp6MScA2AIVK9Nvjmr5IhA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791394570;
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
	bh=mhMMiBl5KVs7uXNAq0btGciH7773EviivWJ8JBUlfz8=;
	b=qNU8BdTlTJW8IPQli8Ifq97KEG9kbL+YlKxuWt3YA+ZwU8CfODMiJEGmwhlmvbm+xwKU
	 vlGuRaUVK3RbkthPnkDccZGTyNuxVW9NQY2ZXR1QyS+AXACgcRf0mcGYf6sXLzJhooTzn
	 O3vmTf2fTWu/uqVsUNDnsf915KW5Rug9CAtywZwjyv3RSzHEIq5vOGeqlnVaqh4wxL2fE
	 i+4DH9Glj+aXxrDvGryUdOI/wiA3IPXw+ZYrd97f7vuw5emNZrSvUgxVKC98Z+i7oeRSU
	 70Uk4iQ65i/r4r3US35LaJ7XzKKoZE6MG83+QErysLIapRaTC0pBcLjx4Z8XkBWRzdQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791394570;
	bh=mhMMiBl5KVs7uXNAq0btGciH7773EviivWJ8JBUlfz8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k/Hee90mKJCrV+qRlB+p/cZayCqeyNgi1CNUifzSNWb9RKhGxXKukombi8rU1Ob+O
	 du/4b1DaBMXsy3wD2mm0okbxO/jXjVrE0XfL65JoBacPi5P+Mh2OMblV6X/dMr9cf/
	 WFQ70JpCs8uEAHj7Jndys4IFuzIt/zW+vEtQWCquvs9LyoCbrmr5DPsZo4HKoRnWlL
	 LC/Jc5oEBevNcYM/8wC/rQHa5pYCDjsPDGTMaQpjpLTUMmhNZ6xpkDcfwWM3OdFYs4
	 ZoWQpOyKDanSxUbMghAa+RKv1ZbkJLirp1JdpQ4BQu8Los513FjmvgOAAfGQuOoW2u
	 cKkvRveQwmEqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62E1E85612;
	Wed,  7 Oct 2026 17:36:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4942175
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 17:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B7B74029F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 17:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ARUEbdrUIa_J for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 17:07:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7DCCB40062
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791392852;
 b=pGUB1B8qJFKBOcC4bwWVFV774kHwqI04mzcl51H7kGDkrnPj0ltnnA49uwaRqJQhwcAK
 lhipMq3HSDnHBdEmuGlmw3zpMWjOBmXend2UPQQJYfYJXW/vxtibHxnPu/s3ay6p2j/1m
 zbiOcRxFgeSvm2Sr553z90TVQK1km3uU2yW7Lad3kR0b66CNZnUE6dtZ4euGqlSiUPJUI
 OTOXootsfkfpOsxkKcivnbzqzVrYDe1D22GyEyDOokgO/uy7nMKXxk+53yYaQsFETSxyg
 VqYHzWxY60Z8Yrtr9kdgmSX27JZswiLHfcAPlvmifrbkFBpe9cvSCEMZByg6XAfdReA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791392852;
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
 bh=mhMMiBl5KVs7uXNAq0btGciH7773EviivWJ8JBUlfz8=;
 b=FO2e7R0YBpTFchPDslDVer8CkgZrQ1pgZWx/qD2+uaAD5PJ2YJ7Sx24Ei4aaBrwb3/ru
 TIqXFnGmtGLl6AYafGB5ueS507toY34F5qcnA8323Y3UxnNHMUd4v58dFkos1FBEAyonK
 sZ560h3vofFA27mZQvD127rxwFVBKfEko90bwfv3Jes952X9rVIKCgLH9bBSGO9F5A73o
 RKBElmhP908iCPhV9rOmmO7MG2CkuZUnDnYrVpexAD8hZH1r3ZCqe3afAltztJtsYcElt
 +qpl+wUWWmS2Ykc1f/5f4/kP6eo//v6OKn3gE9XaJQeeaAyFzD7rUfbVBzgW8ZAC6Jw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cuNX6wFN; 
 arc=fail smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cuNX6wFN
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DCCB40062
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 17:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791392852; x=1822928852;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4D0vt6H6y+0gwqecUz0ff5ClTB0f5vMvFAZUfrihse4=;
 b=cuNX6wFNp9MQIelVrLKP7YmaPopob/GdZ/jxuW9ZzRd7Xlbc+HJaxrWO
 AG+k89axt0AsSKd31mXQoSQlvyuKrYBuWWpwYHrdomcKo8LnF0VyQ0CG/
 4t1jMTSbdOzLbX3QpkUjCFJv9Qf9wbKwbCozMTfT77SkAFsW26xlkMXzy
 JMSFmx8VuhaK3OT95lHMcS7nOWLnb3Hh+bH8fVOSws4IW/+Kps522ntoY
 dxavazOT7S3giJA9gTehIeVh96KpZWL/74nANRqwndq2vdjMoRg9pATBs
 SSKMB4ESPa7UUvYMfz2pWENNY8SujF7NzbOhETf84OXbjQTtPrefMvBtB A==;
X-CSE-ConnectionGUID: s9P/GcxbRKiI5OG9WH5JXg==
X-CSE-MsgGUID: a1k15ZodTAWLa1eSDPZUfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="168638"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="168638"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 10:07:30 -0700
X-CSE-ConnectionGUID: R+L6tETqTWGewB5rtWPJoQ==
X-CSE-MsgGUID: MlxTms/aQEii5XauvFxC0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="303767743"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 10:07:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 10:07:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 10:07:29 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 10:07:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iznMjSBNFUckJ7t6qpVyaLyvR+2W9BaWzXLHaNiqU1Dms5HsBjEo0tUjJL+9P/Zh5SGYeM5P+zs/jVd8r78ay1bLeoirSicnHFMBnjrS48N0yfhRLd/SCcpukTW7nQ2ttgJ0sAt421QyBEw7uC1GnVT5dXqloKNxCFPfbOrn4KCvXp40+TKDL9I30QP2u90M9JqHupQMEtNyQHoOIxRQVmfB4Er9xSrqYtdMAdxAiRp6JJy5lcgkTrMrYyWh+VadVn6D5U24UiXBGgd3CEa7CDqG4HJ1r2ldDKcSKxhttE1/oBq6FdzcHr735mS1rnK65JHmKyyqkd0491ppK+iROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhMMiBl5KVs7uXNAq0btGciH7773EviivWJ8JBUlfz8=;
 b=OxoPYgC8g15mW4ZswmHn2AbR4I0Ju4BYJ2pUrmxb1/BgpVkGKXMJJXt8LXjEeiJ8V9DOenCNnebrO1+QVNMQUbtaGIaCReP0MqSt6/FMFZhab/c79UVW39ZmHFEKl2x/TR3jsxfJArgsZT/XPsAOKKiV/zwP6TPEe37A7ZFFcGD1veOigWI6PClEjD+4kc1AQAUXWxqBnhhl62uAFPTb18/Z3fWTaDmQXj9i2lKG0xYWNv8hs9vngwNu5hydpK84guisoSraltfKP3Pb0eoSwEUaK/L56DvX9BhG43VsjCPM5GJFMMtQ7pemC9TkE3uwo1rwJcQ7CGFTFXDRLZqBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by DM3PPFF2E67D388.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 17:07:25 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 17:07:25 +0000
Message-ID: <a9d7c483-b34c-4b5c-8951-c9f1bb1c1f81@intel.com>
Date: Wed, 7 Oct 2026 10:07:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] idpf: keep the mailbox up while tearing down
 vports on shutdown
To: Tian Xun Ng <luckilystar08@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
 <aleksandr.loktionov@intel.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, Tian Xun Ng <tianxun.ng@bytedance.com>,
 "decot@google.com" <decot@google.com>
References: <20261007055741.30629-1-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261007055741.30629-1-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:303:6b::30) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|DM3PPFF2E67D388:EE_
X-MS-Office365-Filtering-Correlation-Id: a510aed0-178e-4987-ba1f-08df2495756a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 148dSEMkvGrmmyE45Klk5OdzTffwzS4Z8WWHxgY/I8BvATlDW3NuzGpfqvm91Y3AWRetbh05RWufxTtG3sJMmFsMBrQD13G5IgGYt20fTpoCxZNG7hwmgrtwnCl/SFBwNg0snP3jp1CWQnXbWKHuil6XgtR2OaS0OgLlvSA254dPOrpjJ+cWKh+abUuL20Lwe6YDGTGdZE5l/adiLSE0CGW6IgRObkzlgCrXHLidLQ0Gl9A6C4x9j8n+GPoGGil0xsMeA0O2VpF/nmFy90pfMqjwMiwuq+5EX/sx25E/ZcqvLGt58z8jwcNkrjSTWnRFhV5XHuIu3xHYRUPq7S8SWTHaEf2O51CwhYc8luYSJcTLZF87Hjmyx5Vv+kNWePWSNkLk9v6VOZH7XLt4McxRV/TAIxcfZmcL5394By9PGKMvzB//DROoO9Tdh22FrYDLJq0E78A/q0q4OkmmNJE7LDQIE0VCeGTgqin/s3ALrY2f9edtDPhMwHozGiYppCsKpmVANayCZ3AeGT5QQ1vLmSO6AEw8RKaCVeZ2zNBrldkm/zZrpb66nNqmYvu38D9IoH5POCMVHHpsXrudvji2cWdxY2gnkdwBnOv83ubyQ9EM38Tene8l4PgQiYalyknT63QbNlBRei5F42NG8XsTzHwcTBtmIoo4kFjk2tIfe1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUszSlRpdEZlVXd2bXZYYkhvc2FvcjVIK3dHVWxma3owMkRpNzFGeGUvRVdi?=
 =?utf-8?B?UDVFanNGdkRuZ09PaDZPY0hjbFlTR2crNjVLVHdkZ1R5ZXFMbzRjMEV4b2VG?=
 =?utf-8?B?V1FGRTdHaTNsVTFIUTF6MmJDM2Y4YktxMnRvOEhHQVpEY1Zlc3NjSTU1K0pR?=
 =?utf-8?B?eGhlNjB5bE1yb1VaVVdnMWM0MmtJa2cyeWhZY2hjZ3pqalBEanpNc2s3KzBM?=
 =?utf-8?B?TlhZZnlkYkhucUlaZmIvSWdKeHkwU0VVNVgwS3Zib2JLaTRPdDVycmVVVFA4?=
 =?utf-8?B?M05GZHJJMURlTk55UlMrcnhYUHZIcnJ5WTRMaEZhZEp3NGxXaDgwOEFVKzRp?=
 =?utf-8?B?Wk02enpCK20wU05VMHRobytBL1RBaHVobWZnMnUzdlJaQ29nMEZtcHFUWSs2?=
 =?utf-8?B?SkJ6T3NMQlNQaVFpZjgzT2tndjBCbFdScVlwY05jUzdVL2dPWjZ0Yi9jL1VU?=
 =?utf-8?B?VFJXOE00N1RJYXlRZHFwL1dVL3ZGUXBSM1ByTXZQc2Uzc0lNTzJxYWw3UThH?=
 =?utf-8?B?L3lzL2dtYnBUWFdyM2k1UTZCSlM2enAxeG9TNlZRM0d1MzVsbEkvc0t3OWE3?=
 =?utf-8?B?ZFM3Z1lmV1EvYisyc3pDQThRODJIZE9JMzdBanJiS0ZsT0N3N3V0RXNyZXUx?=
 =?utf-8?B?UWpvaVBFYkh3YlhYNmNlV1R3VkVJclZIYzJ6MlplNlZtK05OZVRxZHEyaERl?=
 =?utf-8?B?Tzh1Sm80dWVpamlwSExUV3ZXWFVmWTVuVWg0ZkxrekZVYW8wS3Z1cGh0Uzht?=
 =?utf-8?B?K3ZSNmJaa3Y1aWt0cDNUN0RpV0lyZjdLREdqQzBmN0EraXJ0YUVHMFdPRFpM?=
 =?utf-8?B?WEJ3TmNxcWM0bXRmejUza3ozOGNQQ0dHakxGOWhlaWs0YnhqZCtXMURacmhq?=
 =?utf-8?B?NkMrWnlTK093MlQzNEhHb2RXQ1BqR21VTDhxQnJuSVB6dzZDWU9pZ21JWTBI?=
 =?utf-8?B?R2UrcyswNkNqelVLL1hwbEJpYXk5L3FWR09UMjhTZjlMZ2xSZWczSlhKb2Ew?=
 =?utf-8?B?VHF2QW9ZdlY0UUFMMWFNMzg0WjhvM1dFQWp3MHg5TzVoWjV1dlluZDJJaW5B?=
 =?utf-8?B?M3pSdG9EbjFHOVMyckd4SWNxVE14c1l1aUNlZVV4bkd2aUFNcS9xMXI4TTJi?=
 =?utf-8?B?TUJNa0g4WGg5OUdxejBOSTlmVjlNM1lrSWo3VGlWTTlqNlAvaUJ5bTFrYStP?=
 =?utf-8?B?bzFBYW5RdEpkdXBMSkdnZmE5YjIxcmZOcTlVeHlVVXY5Y1E0UXU2YVBzN3Vx?=
 =?utf-8?B?dTJYM1U0cGxnUTRrdE9TVXk3enhmS3BXSS8xbDBSTnZPSjJ3ZG9hOHFsMnJT?=
 =?utf-8?B?UlI1TW1RRklwVmhvV2tFaWJ5KzFNNkV2Q1cvWUNZc2FOanFsS2t0UDdPdTB5?=
 =?utf-8?B?V0VYcXZvWCtRaTlTWFdvL1JpZHNFenBpVTY0a0hCZGNzSUNMQ2EwaG4xOW54?=
 =?utf-8?B?dTRDSWdkY2NyaXBicFNScVA2ZWxBNnZMTFBJUWhhV2kxcGhIdk15QWM3TklZ?=
 =?utf-8?B?c2EwZDI4RjM4YTZ6Qno2ZFRyWkcwNzN5M3ZTVkJubU83YmZ5Y1NSTWpyczUy?=
 =?utf-8?B?b043cit4SlViMmRhbUt1THc1MzBJRUZyUzVXVGRPZTVJNkpERlZGVHhWb3J5?=
 =?utf-8?B?VFVXckhRNkN3VlZwTmc1ZnppZUVsblhKNy9ZcUo4SkErRExBM1ErRnJTZDJZ?=
 =?utf-8?B?WGJGeDlEOVB0SDQ5S0ZxZHhnQW1aUW5MRnBVQy83Tk5UK1JkU0tNSExsUFhB?=
 =?utf-8?B?UHlFRHpaNTBkZWNYOG5tODdGdWpIK2dERm43VTNaTzR1clRJSkpXRUVDQkJn?=
 =?utf-8?B?cmNUNktQTENVYVIxbUZuVXkrTStzKzExMzFkWFNRUWJISXBFZTdha1NtdmZx?=
 =?utf-8?B?elcyYU5PUjcrNDM4R2c1cU1sWkJBRnZiYnNDS0hrVkJ0R1ZvWHp2UXRlVm1Y?=
 =?utf-8?B?OElIa3dOUktscU9HVEEvVHFpTEo0VGl5dGluNzcxTXhaTmhsT0xaZjF2OWpR?=
 =?utf-8?B?QjIwblU1VFNuNDZKVGtvZEoxc0VyTmlNS2lqZmJkdU9GaEx1K1RrOHJ6SkRI?=
 =?utf-8?B?Z2RRRGFZNXhIOUNBQkJIcm9UTGZKRUFqRVREZ1BuU1M1dlUzbTlNYXdmRXZC?=
 =?utf-8?B?cGl0OFFpc0praWFUZ2czcUliVXErMkk1d3UrQVA0cmxVQjlsaTZmQ1hST0kz?=
 =?utf-8?B?dnhTdmFHL25EV0JPSUZZR2NsOXA2SWtOUDJ3TnRSckxaTFVFSDVyWEhFK2tm?=
 =?utf-8?B?YjgvbkdwZlRmRUdoMWNJaks0MEJXc2gwNFJQM3V6L1NFY3N3VldhL2hrRFRu?=
 =?utf-8?B?a29YNDlVOWdWT2k3a0ZZbHlnRlJ3MkxUcHlzQTN3eXJUSzRCb2ZLUTE3VTZ0?=
 =?utf-8?Q?dBujvNOaH0cFDbwE=3D?=
X-Exchange-RoutingPolicyChecked: cIbs93pcTcFhXYFGti7ZoJd8V3Yy4UHVsvXe9Zn791FOCp2wTj3a03jsoH9gwTsz8MmrH1XcuT8eWS/N3QfTBJO35qQpMEcBk+2NLEwH1HngBfTIquc8eBnPMTOLa0P/I3g3MWq0GSUQ1LMRqDN2Fp62tzVhYWIO5/OhaeJf8tE+sNLhw7plrFGPbqhf6MxcjhJksWYm0akk/odUKAdL/Lcsdv6dLIvG2XLuc7NoHJ//PDDegaagcJdg4E8urTor7fJ/u+6A/ep0BcNlkCVtsrQN2xM76Kfp6JrAr79xyXVuxuL455r4laFf9EJAKbmc+nblzbN/6Sjut1rdoa0LlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a510aed0-178e-4987-ba1f-08df2495756a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:07:24.9925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkTpbkA0bQlxAGU30VpRFf4Pw0RAtq00k/oTHS0Nv4uARVWyRpqSa6XyS20WjS/Fk/PRwArtaphGES4zAKcyRKdgm+cIPhtL1y/InKkf33Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF2E67D388
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



On 10/6/2026 10:57 PM, Tian Xun Ng wrote:
> From: Tian Xun Ng <tianxun.ng@bytedance.com>
> 
> Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
> on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly instead
> of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on shutdown.
> idpf_vc_core_deinit() uses that flag to decide when to shut the virtchnl
> transaction manager down. Without it, libie_ctlq_xn_shutdown() runs
> before idpf_deinit_task() tears the vports down, so every message sent
> during that teardown (disable vport, disable queues, destroy vport)
> fails at once. The device is never told to stop its queues and keeps
> them enabled, with the ring addresses of the kernel that is going away.
> 
> After a warm reboot, the first queue reconfiguration of a port that has
> not been opened yet (udev setting the MTU) sends VIRTCHNL2_OP_DEL_QUEUES.
> The device then drains the queues it still considers live and writes
> SW_MARKER TX completions to the previous kernel's completion rings. With
> the IOMMU translating, those writes fault about 19 s into every such
> boot:
> 
>    arm-smmu-v3 arm-smmu-v3.12.auto: event: F_TRANSLATION client: 0006:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0x3ef60840 ipa: 0x0
> 
> In IOMMU pass-through mode they land on pages the new kernel has already
> reused, which shows up as "pagealloc: memory corruption" with
> page_poison=1 and as crashes in unrelated code without it.
> 
> A function reset on shutdown does not help on these devices: with a PF
> reset issued in idpf_shutdown() and PFGEN_RSTAT polled until the reset
> completed, every warm reboot still faulted, and the reset the next
> kernel issues at probe does not clear the queues either. Delivering the
> teardown messages does.
> 
> Set IDPF_REMOVE_IN_PROG in idpf_shutdown(), as idpf_remove() does, so
> that the vports are destroyed while the mailbox is still up. So that an
> unresponsive control plane cannot hold up a reboot, give each mailbox
> transaction during shutdown a 2 s timeout instead of 60 s, and fail the
> remaining ones at once after the first timeout. If the function has
> already been reset, for instance a VF whose PF went down first,
> idpf_is_reset_detected() fails them without waiting.
> 
> Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
> this change backported to a 6.17 kernel and the IOMMU translating: no
> faults in 25 warm reboots, against a fault on every warm reboot
> without it. Each PF's teardown took about 1.2 s for six mailbox
> transactions; the slowest, VIRTCHNL2_OP_DEALLOC_VECTORS, took about
> 300 ms. To stand in for a control plane that does not reply, the driver

I'd probably bump this to 500ms to be sure. It's good that you measured 
the slowest in your environment, but there is no guarantee that would be 
the same elsewhere.

> was also built to skip sending mailbox messages during shutdown: the
> first transaction timed out after 2 s, the rest failed at once, the
> teardown took 2.8 s per PF, and every reboot faulted again.
> 
> Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
> v2:
> - Drop patch 2 (function reset on shutdown). On a VF it queued
>    VIRTCHNL2_OP_RESET_VF and then freed the mailbox, and on these devices
>    a PF reset does not clear the stale queues anyway (numbers in the v1
>    thread).
> - Set IDPF_REMOVE_IN_PROG in idpf_shutdown() instead of changing the
>    condition in idpf_vc_core_deinit(); no new idpf_is_reset_detected()
>    call (Emil).
> - Bound the shutdown teardown: 2 s per transaction instead of 60 s, and
>    fail the remaining ones at once after the first timeout (Emil). 2 s is
>    about six times the slowest teardown transaction measured here.
> - No VF special case, unlike what I suggested in the thread: a VF whose
>    PF has been reset already fails fast through the existing
>    idpf_is_reset_detected() check in idpf_send_mb_msg(), and a VF with a
>    working mailbox leaves queues behind on a warm reboot just like a PF.
>    Not tested on a VF; I have no VF setup.
> - Compile-tested on net-queue dev-queue (W=1, allmodconfig and
>    allyesconfig, no new warnings); runtime-tested as the 6.17 backport
>    described above.
> 
> v1: https://lore.kernel.org/all/20260917105205.37561-1-luckilystar08@gmail.com/
> 
>   drivers/net/ethernet/intel/idpf/idpf.h        |  4 +++
>   drivers/net/ethernet/intel/idpf/idpf_main.c   |  7 +++++
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 28 ++++++++++++++++---
>   .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
>   4 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 470bc23c8..5d2e8a346 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -88,6 +88,8 @@ enum idpf_state {
>    * @IDPF_REMOVE_IN_PROG: Driver remove in progress
>    * @IDPF_MB_INTR_MODE: Mailbox in interrupt mode
>    * @IDPF_VC_CORE_INIT: virtchnl core has been init
> + * @IDPF_SHUTDOWN_IN_PROG: Driver shutdown in progress
> + * @IDPF_SHUTDOWN_XN_TIMEOUT: A mailbox transaction timed out during shutdown
>    * @IDPF_FLAGS_NBITS: Must be last
>    */
>   enum idpf_flags {
> @@ -97,6 +99,8 @@ enum idpf_flags {
>   	IDPF_REMOVE_IN_PROG,
>   	IDPF_MB_INTR_MODE,
>   	IDPF_VC_CORE_INIT,
> +	IDPF_SHUTDOWN_IN_PROG,
> +	IDPF_SHUTDOWN_XN_TIMEOUT,

In general we try to avoid adding new flags as they tend to spread 
accross the code in weird ways. I think we can replicate the logic in 
your patch without the need for introducing new flags.

>   	IDPF_FLAGS_NBITS,
>   };
>   
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 129bccaa6..fa27ee1cd 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -196,6 +196,13 @@ static void idpf_shutdown(struct pci_dev *pdev)
>   
>   	cancel_delayed_work_sync(&adapter->serv_task);
>   	cancel_delayed_work_sync(&adapter->vc_event_task);
> +
> +	/* Destroy the vports while the mailbox is still up, so that the
> +	 * device stops its queues before the next kernel reuses their memory.
> +	 * A reset does not clear them on every device.
> +	 */
> +	set_bit(IDPF_SHUTDOWN_IN_PROG, adapter->flags);
> +	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);

Case in point, now we have an overlap with SHUTDOWN_IN_PROG and 
REMOVE_IN_PROG, with the shutdown logic depending on the side effects of 
REMOVE_IN_PROG. I did a rough draft, keeping your logic and I think we 
should be able to avoid the new flags by introducing a global variable 
adapter->vc_xn_timeout_ms and set it based on the flow we're in, like in 
this spot instead of the above, something like:

+	adapter->vc_xn_timeout_ms = IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC;
+	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);

followed with the error logic in idpf_send_mb_msg() that allows us to 
bail early.

Thanks,
Emil

>   	idpf_vc_core_deinit(adapter);
>   	idpf_deinit_dflt_mbx(adapter);
>   
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf52706..5f5d72671 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -190,22 +190,38 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
>    * Cleanup the mailbox queue entries of the previously sent message to
>    * unmap and release the buffer.
>    *
> + * During shutdown each transaction gets a short timeout, and once one of
> + * them times out the rest fail at once, so that an unresponsive control
> + * plane cannot hold up a reboot.
> + *
>    * Return: 0 if the request was successful, -%EBUSY if reset is detected
> - *	   or Tx control queue is full, other negative error code on failure.
> + *	   or Tx control queue is full, -%ETIMEDOUT if a transaction already
> + *	   timed out during shutdown, other negative error code on failure.
>    */
>   int idpf_send_mb_msg(struct idpf_adapter *adapter,
>   		     struct libie_ctlq_xn_send_params *xn_params,
>   		     void *send_buf, size_t send_buf_size)
>   {
> +	bool shutdown = test_bit(IDPF_SHUTDOWN_IN_PROG, adapter->flags);
>   	struct libie_ctlq_msg ctlq_msg = {};
> +	int err = 0;
>   
> -	if (idpf_is_reset_detected(adapter)) {
> +	if (idpf_is_reset_detected(adapter))
> +		err = -EBUSY;
> +	else if (shutdown && test_bit(IDPF_SHUTDOWN_XN_TIMEOUT, adapter->flags))
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
> +	if (shutdown)
> +		xn_params->timeout_ms = min_t(u64, xn_params->timeout_ms,
> +					      IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
> +
>   	idpf_prepare_ptp_mb_msg(adapter, xn_params->chnl_opcode, &ctlq_msg);
>   	xn_params->ctlq_msg = ctlq_msg.opcode ? &ctlq_msg : NULL;
>   
> @@ -217,7 +233,11 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
>   
>   	idpf_mb_clean(xn_params->ctlq, false);
>   
> -	return libie_ctlq_xn_send(xn_params);
> +	err = libie_ctlq_xn_send(xn_params);
> +	if (err == -ETIMEDOUT && shutdown)
> +		set_bit(IDPF_SHUTDOWN_XN_TIMEOUT, adapter->flags);
> +
> +	return err;
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> index 5d27805ff..b0809d149 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> @@ -7,6 +7,7 @@
>   #include <linux/net/intel/virtchnl2.h>
>   
>   #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
> +#define IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC	2000
>   
>   struct idpf_adapter;
>   struct idpf_netdev_priv;

