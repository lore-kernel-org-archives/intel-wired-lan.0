Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8506CA6013
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 23:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A3F360808;
	Thu,  8 Oct 2026 23:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5R35vtvFN09z; Thu,  8 Oct 2026 23:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D618F6082C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791500645;
	b=GAugDinhZ84KRub+FVIEmyWejo4YXNjWbZUvCk9vcw5npb53nkqCwBFwr7NSK169HGsp
	 acHIF+6rKduHSaTJ6SahEVO3F7krkBs1te9GkIUO/8iPtVmaVhc+7dgMbMMm/5e1jgGc7
	 dCbzXHlqxshRBojX9cNvhY9FrXQUkzMk8swX5g7HEdTaXexAoe/A0JxfdPH/E+/Aeowxp
	 wYpLb0To9UoQ08VWe8OKJb9iciq4z71Bg/ZvFPRQT/qq8q2ccPTAk1c2ABIwECHdD2hxw
	 5lrlXRT27HogT7oL4N2nu8xvBkdgJD8F+eNDEBbqd0UP5yGuxB4O/iEl6Ihx94kLgYQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791500645;
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
	bh=Y36uyAO36zqT3Z/lpg0viYkQ2x7lSrRdQqp8R8a0YqE=;
	b=ATv+gkS7ewQgdyYrzIVJJJtaCeQjlkfpG910dpr34bY1xYKHYb2hFRMMPgYxsCuD+KIg
	 ezigHvaHqh+EwBrgdTf7q18cycqwXKfexOcPR6F5KUFDIZOXns09ERJAHlm9vcg+RyNC5
	 stvhtv90zTTGTqLavj5to6KkBrXEdw1v7ooRYmZncxQlZFQaxfaq11kHlnbNhv/Bls1z3
	 gw3VlP5IejmLccKHkvav4RICorQLdpyw5bL1TJ3KTGQdhb56z9MfOE1cCG+XbC6mZKBFH
	 Qhj7i/RbHhL0eZLCWOOdML6P00YbMaGmBB/aFs/8hHFAgy+/dk2jIKzPtY7V+Ej6Vgw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791500645;
	bh=Y36uyAO36zqT3Z/lpg0viYkQ2x7lSrRdQqp8R8a0YqE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zlvR/3mFOrD3IneH4boXRRCb9WzCwP8eEHDRyVzZyoSQupjv4zK40r/uAzp4aO3on
	 /6ZLlIW5hSmHHezng9Fe2iBYznOUnba1z9wD2PjBl6YWa62TVhOyitHslt2RejuPx+
	 roA+Iq/hQ5ncChMK6FOwdgPfGhZtK0F5U5Bclc2vqQvhoJ2Dh2tBrOVbll7d4uODb/
	 Z8O5auGqaUUjxrnc/oRxBStmhNeFEgBXPyU0gJABOTFAZgdwnoeZ4osMHrNpb3IYU9
	 ApeK4F8z4kJnUQiqoZIfSsHr69XIcrmyLfGWm/7oXkdPxbClf/UnueixB6KwyJY962
	 NF33FC98NlJ8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D618F6082C;
	Thu,  8 Oct 2026 23:04:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AE07B1D2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 23:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F7FB812E0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 23:04:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ZM-L9lfq-0A for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 23:04:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E2DA812D6
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791500643;
 b=h+682QowrgU7SfPnm1YrRg09XuTIJ0XV2mdDPDMBl0Z+XKlYQU5s8ow+ZHIyJ8wzsSZK
 VpphdWFTGhXINrqov7hd/vSc97NbW8rmabAfAU8MBVc4nrKgZjKBZaH9JqsBtiNaQNutD
 eHY8gQgm8Bh0pvPO65GRj4OEmfDsoXJ3AJqGuIdCQAjYDX8K0rtgoVvP0jrp0t9HFSRPC
 ChT5C74fuUQXnhCAZi/iJ8+Np54kYMBW9oYI5TEJldVv0OpLJ7Qtgcl9Vt5zn5D/uysjc
 48k57j77A/ZgknLUL6jKy8l9bDtBFzfRCaIb/9eHVYqyqjKrI9ydPRz2NaslXIuJXBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791500643;
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
 bh=Y36uyAO36zqT3Z/lpg0viYkQ2x7lSrRdQqp8R8a0YqE=;
 b=F5JL4Es4VveYEt9N2TgVlk2p7XFK2ZE9kgkg+Gsd1lX2IHRP6Aa7wjLi4vC1jeejC6P4
 fMJrWNGprTqdYphmX/pG18gBLf0zyRR2iJDcHtky1ct3QXNI/969HkVm/Do6xiu7DpJ0C
 IeFRrHs0KMgR1rdNYRT6VQ/H5SLp2cEpV2BB5EGdHUoIqUaS+Kpf+DW8yd2LsPVKdlhcb
 zK/4vhCEo+UuE35OywhQoaU6+nzMr0QuHc6EztuM6RG0PYDe4sTprxZW20DaHDnJUU1Q5
 c27PNpEXIpGZPVGgbWhhHpW1AZtQ5AlW6pKMkWXzGl/9sgGh40VyP57JZpDfg+IJbQw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="b/P4k4U9"; 
 arc=fail smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=b/P4k4U9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E2DA812D6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 23:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791500644; x=1823036644;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=b8F218h4K55RwFBFtkCE1+SbubWeNu8Qdl0ACWHfYA0=;
 b=b/P4k4U9ZTSRpvmSBqU9d8FrkCVLzm51JoAEbqG3Xt8Qryp0I0JqgBPB
 jDn8PraqoLuvvyX34wKNWMaTuaeZwHVGMQVggXJcHcfIWismKChdPtRNG
 HUoZRgcmRlhgjZRz2bbpEFf2fF2ud545o+X0VZHQ+/kG8ffxoRDVpgX3S
 nlDanNrKQN3ZPZlv7cgy+CXYSgr6dB6rmp9X1wcPmZiIgchiXTKFFJeiL
 TDmIoEpNiApsDDizpDM80W/+5aHnqqwjRoowEDk33J1GfRz4mfbOIdhoe
 pgRbqgQFE0CLjcgNm/4Ib51ZbEa84KJoD9NqsOM9i/amXfL5TBZ5be3CK Q==;
X-CSE-ConnectionGUID: G5LZAU/BSBCWEB7K/JNt5Q==
X-CSE-MsgGUID: w9ow+vRZRduESD09Xpb5fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="307025"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="307025"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 16:04:01 -0700
X-CSE-ConnectionGUID: jBaBgDJwT+Gt5Jkcn/lHNg==
X-CSE-MsgGUID: uskPi5QAR3OcyeNJoYgK6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="111264"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 16:03:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:03:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 16:03:43 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.59)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:03:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujpdpxqOV1+GMCu8zzGK1IxV9jK1eymixzW+duI2mE6+qSQRWLb+X7F85E80JJgjmtx9yZFsrwUmqqUlCuOZey1YlWPmi6fccgTGXVjfSe44W7PBb9EepoAJHZ4xGOjbdn+jcxMBrjNUlqdIcv/KaEYSMl009A5flggKYzh0sapXCmbKF8/bCEwbsi9lzFwfpk9WCEcS8og8ce+EFALOrLO6Fd7k7cL8DSQgCQI2HnCIyMx212GggiQIYSYXR9l4sn2IbTFZfT0FNBhLKtmfqvMbV6mN4ZGHjRIYuKUKGlmvBzvVmGgl8reVzgkwJJA+bA9kkRgGyMS4hj7V9zJPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y36uyAO36zqT3Z/lpg0viYkQ2x7lSrRdQqp8R8a0YqE=;
 b=Z0x4Nh40uFkOn5XqdPL5FeOvfEkcRb3j76G44xc7AWZtcdwPsTXncRocSi+cwxAvjKVN9Z3qeYbpED47em/Iur+Laktu+/BeEneKIaa4VIDNta/6akGZjWULsmKCRAqPG0eOumMrYts9aC1iGk92ORn9t+Aq2ZcU8Lh92LmuVc9LwS1mKPSprZWYK8qjw1mC1WDRTEoJ74sWWw/ACr3xjRDFndgXCZ2NeQK189vY2L5vlZcsChHbwdH3TH8Ok340bqY1FWiPBy8NurT7fCCbqX844h3xVRwLFfpGZMWsVjJ5j8Giift2OhUysTROuD27FN1IVklJDUsVtkZBwFo9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by PH7PR11MB8035.namprd11.prod.outlook.com
 (2603:10b6:510:245::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 23:03:35 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 23:03:35 +0000
Message-ID: <2bba3179-a471-4fce-8252-d9833d3024b5@intel.com>
Date: Thu, 8 Oct 2026 16:03:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] idpf: keep the mailbox up while tearing down
 vports on shutdown
To: Tian Xun Ng <luckilystar08@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <aleksander.lobakin@intel.com>, <aleksandr.loktionov@intel.com>,
 <decot@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, Tian Xun Ng
 <tianxun.ng@bytedance.com>
References: <20261007055741.30629-1-luckilystar08@gmail.com>
 <a9d7c483-b34c-4b5c-8951-c9f1bb1c1f81@intel.com>
 <20261008065426.86267-1-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261008065426.86267-1-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:303:dc::31) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|PH7PR11MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ae5298-a785-43da-c719-08df2590615d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|7416014|1800799024|6133799003|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 9JhrzuLglKf5ZHZQOUO7M4oScEaNeOYyb/ftyiaSAO8GvgIs6bHW0ZIIWGdHBVj7DBusLDTEJS4uA6IUfhs/p7SvPd1IPmfPJpH+mj2HDGpqqNfKNnqefcQkGzQ+e3NoOlqerq0+07fx6WFVJMC1lQqrWkRHu/ji1rL6RKwIBVus5ns7IhTiWUk96/IkZz9zOPa5keUpbP1ZuUrPGfQDk+WieLDiYSTrmO0bvQGVAYkVQKExUcpATOcGZlY5aacvfmWGoHjw5pTJvXPIfGAPMM6jPJATZuEfOVQEkNeZ4cU/3HBWdPSRJcG9HzNfXUSrUahDa6CvhgouEBSqoIryFamu2HkU98xoAiOc5vnEJPC8OwWccwBM7oGsoRACs5f/Zz1Eacwp+phSgVRrxIG0MU3VTuYl3H6yDlP872Vur7ZcrXkJxy8Bjj8x0ldutFnRyl232sbTFaSf/SlF1YivWCME4aRY5Y/aJHUnRG7K+0QhDR1t8hDAUiekCecRBBdclXLbu1G8EuDgDBXIu/3B36sqWYEmxP0PttPsb6STetjazjNKSgCKC/Mrzg7Pj6vVS8a3+7WPWhQ+S65V8HyHoYVYyOjiKni2VqJi/HjLA4wMhNN0jXzIqeFtr+B38vhM+nDjCZDPczG+v7JqSys3WNaE/2tqyQEyHEnKAhcRO1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBtZGZPb1lvV3pzNmtRTlY1d1VUdUhMU3lDWDRSbitSZ1ZBcWx4N251K2Y2?=
 =?utf-8?B?dzRaOW4zTE4xWlFIelJab05wdnFVK20zcmsyZWZwUnI3clQvOXlad284QUNC?=
 =?utf-8?B?bXJtZ25zZEZHSzk3WWtaLzcxUVdrS3J2anYyV25uNkpRSi9ZZkFTUWtHZDNF?=
 =?utf-8?B?Q29rQS96K3kwbXQ4djlEdjU3Rmk1UzFmZ3BGNE9TQkZqL250OFVlUTR3Tk1x?=
 =?utf-8?B?Zk90cUlOZmJtNXh2MHpMdHBuTCtCR2hBdGt6Vzk4Z21NbVlna3J4VmQ0Yzlt?=
 =?utf-8?B?bFpFOGlOYThuOGkyT1JBcEF3NHVNaVhNTzFJayt3aHRmM1FqcWx0VE9Ddmg2?=
 =?utf-8?B?L0prTXl6UDYyTElZUm5GSjBlYXZJbWFBZXdDNERaY3BRZW1tcHNMODZXVmNj?=
 =?utf-8?B?eEF2N2E5TTBLRU1SK1VXd3dkV014aXdRaWZ5RDZpOUZCUlJ6elA4MUpWZUVj?=
 =?utf-8?B?L2c5OWluQS8yWDhWNUZxemNtRmFuZ0NicDlSMGh2VlpnU2w3SVI3SnRmeEZs?=
 =?utf-8?B?RGUwREUvRzdGcHBQOWVQYUFoMHREN2tMZVd2WTE5VzVIclVLOE02cUJOWkJX?=
 =?utf-8?B?UkJ2UXBUSjIxMkNQZlF3dXRqdWVKVW1zOUMrQVYrNWcxaU5lQU9IT0cxMFYr?=
 =?utf-8?B?OXJQbm9xSUZzSTVRckttUVhQMFBZaHFsdThXTTFZaThyaGw2YXRCamNwU1Bl?=
 =?utf-8?B?MWliOFNQSGRUZEVqbHRzTCs2OHAybnFUU3h1T2g1NWI2ZE9RMlhZWjVaaHo1?=
 =?utf-8?B?YzdzVkQrN2hZOG12TWg5aEtFWDlwUU9QVEx1ZGkwSzY0ZHJvdCsyVk9rQ2h6?=
 =?utf-8?B?RVE2R3RFdW5NNjQwZmdYZURMdDhSWlRoN2NzQW9BclZJZ1ZCMEFiRlRWNXg5?=
 =?utf-8?B?bWp2VExMZW1IMEk5KzlUOWZNcmc2R2tEblB4WldhWnIvbzdkU2pxZ2RwcUYx?=
 =?utf-8?B?N1c4eXBSYmNubzZ0VlJUeWUrVFcvQXJYK0E2aHZ0SjNRQ3N5VkVKRHM2Um9i?=
 =?utf-8?B?THo2N0FBYkdObmxUYkxYMUFFYTJpQTNWWkNYSHNHY3RCMllKK0owLy9GWk9G?=
 =?utf-8?B?Z0ErSEhrcjlFRkZJYnZaVnhHbUZDdTFKQnFselFCN0ltNExMMldITFo4bmlz?=
 =?utf-8?B?djN4dzJVY2NIQ1BMVHhTUXF5VytjOWE4ZDNlMEhyc3FvNEV6Q1p1TkJPOUpa?=
 =?utf-8?B?S2ZjY0tjUmhUTEdWeldRM05ZcVU0ZlFZVWNtc3FFZ1JsdE12VzRseEtDNFRI?=
 =?utf-8?B?M1cvQ0JManpsTVZycVpDTXlreDJjclREUzlDMjVka3RWVzJXRTUwa1RYN0dq?=
 =?utf-8?B?Q0Vzd2gzYTI5YlBtR05aTzk4NjF5V2ZpLzZLMWwyZmZEaHY0QUVHeTJ0SHcx?=
 =?utf-8?B?U1JVcVZwclJRUW9rYWVnSk1pdmUvQTUrZU1IeUx5UHBsdldXMFRhV2JSVHB4?=
 =?utf-8?B?UkJvZlpkaTI5SHZkYWZ6N0Y0YmQwMEdYbVRocnFZaHc4UThyb05PSDB2anF6?=
 =?utf-8?B?d256Vmh2eDJOS1Y5QURvbVcxZDNGN1FZTkRwaC9iVThmajI2UlU1UVA0dWZK?=
 =?utf-8?B?MVNwQXFVVVpqejhQNjRxZWpKdmhBUlI0Q3I3SzEzajB4dE90RUs0OTJoZHBM?=
 =?utf-8?B?Q1RBMG05ZTdvZm8xeE44K0hLdk9uWm5NTTdQYko0Uk5EUkxySDUrdXpVZVdz?=
 =?utf-8?B?MnlhZ1FuSEQvZkpXVjBPY3BjZDFRalFGZlRPZWVzNyswL0M0dG9kN1JvNVlH?=
 =?utf-8?B?V2xBNHhLOUpmSmRvWTZLQ1JpQk1ad3UyRWlBR255d2o4RnNsRlFXZmkrU0NO?=
 =?utf-8?B?dlJxRVlvUnFWL0FPdEF4N3lGMXBuQklTc0JubXlWcWVNR0RpMDJPa1o0Y2Js?=
 =?utf-8?B?aXdsNDZ5R1B0bUx4Y2xJL21GRk92eU80aFUyOFJJbUh3czQyY2VOeUtSRHl5?=
 =?utf-8?B?QzR2NXo0YUk0ZENMQ1gyWWM0RWtjWnBNWXVQVzExSVpBNTRDL3dtdDRmaklq?=
 =?utf-8?B?eXNkMm1GSjBldUtrTURrVk5VRFF5eTc3bng4VGpmYUlKTlNiSng0Vit5Yktw?=
 =?utf-8?B?L2lZM1JCTkIyUm1nYTZmcWpkeTRqalVLekk5Qkk1MjVGRjRvRi9EdWZoMC85?=
 =?utf-8?B?Qlk1cHpQcmpLV01rUDdVUGY1Z1lBRVh2ei82TmVKa0hBWHdFaWgrOHlmcVNB?=
 =?utf-8?B?SVlvYlQzcW9Dd3dYQUFETENXS2pMZGlHSHdrYUpxeHlIMkk4ZDh4WVZKMWND?=
 =?utf-8?B?M00rMkZRaHRsVVA0bENOOThYWTVDWnhOeFdPbXdBVG1CV285ZlNTTXFaL0ly?=
 =?utf-8?B?Z1lqMTYxZXg5WldyK210VHhWRldHOHhoRzRYcWhxWUhVUk5TbitEK1hJalNB?=
 =?utf-8?Q?Fx7n+Xou99H7KVMw=3D?=
X-Exchange-RoutingPolicyChecked: bkI/PW79miSzWpqNgM4L5oI/nNDUjLtA5UYZ2Uzjypf+WSyCwfgAX3qjkVwuyM5fzCGjNWSqZ3fTQaIIJP6qaghNwuajmmPZSS/j9vFYDHSxK+yLp4ukw9lh4NKeGAIqJ8f4XyatnIbBcR0H0r9OcPV9xtrIH4U7XrmwZXPWKnG2oO1KLyVIzMRx3GBjGMWDzJ5gcdAMP2cABC3nuoKOTamWQxrgrSOtY8lUx3kEvugo2fkGMBI4Z8lhI3d2a4c4gx2pqc9XvOsjhYnqAZm5iQ6VjQ9QgXZ61nxIGTUQ3LYSIeJPOkR4qSwLNjRwPcQ3BfsVqIZisZtE3NdZ2DzupA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ae5298-a785-43da-c719-08df2590615d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 23:03:35.0132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIjQgVlxXodkPhHI4znsrUn24usQbAI3OxKe4hJKQPSKYK1Je71u5lLdCLmOoOO6m1nfwXP9EMwtcGgY0C8wzoGwuBmveL5nbWIsB+WxX9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8035
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



On 10/7/2026 11:54 PM, Tian Xun Ng wrote:
> On 10/7/2026 10:07 AM, Tantilov, Emil S wrote:
>> I did a rough draft, keeping your logic and I think we
>> should be able to avoid the new flags by introducing a global variable
>> adapter->vc_xn_timeout_ms and set it based on the flow we're in
> 
> Thanks, that works well. v3 is ready along those lines: no new flags,
> adapter->vc_xn_timeout_ms set to the default at probe and to 500 ms in
> idpf_shutdown() right before IDPF_REMOVE_IN_PROG, and idpf_send_mb_msg()
> caps each transaction with it and sets it to 0 after the first
> shortened transaction times out, so the rest fail at once.
> 
> Backported to our 6.17 kernel (two arm64 servers, two PFs each, IOMMU
> translating): no faults in 30 warm reboots. The slowest teardown
> message is still DEALLOC_VECTORS at ~300 ms, sent after DESTROY_VPORT;
> the queue-related ones took at most 158 ms. With the driver made to
> skip sending the teardown messages, the first one timed out at ~500 ms,
> the rest failed immediately, and every reboot faulted again.
> 
> Before I post it, two things it exposes that I would like your view on:
> 
> 1. Setting IDPF_REMOVE_IN_PROG on shutdown also moves
>     libie_ctlq_xn_shutdown() after idpf_ptp_release() and
>     idpf_deinit_task(), as on remove. mbx_task keeps running in that
>     window, so an async PTP Tx timestamp reply can reach
>     idpf_ptp_get_tx_tstamp_async_handler() after
>     idpf_ptp_release_vport_tstamp() has freed tx_tstamp_caps. Remove has
>     the same window today; shutdown would now have it too. An unmatched

If I understand correctly, this is referring to possible UAF in the ptp 
release logic ... I can't say for sure, since I don't have your patch, 
but I think it is a valid concern. Your previous patch would have the 
same effect, so I don't believe this to be new (as result of the 
refactor) and would be an existing bug in idpf_remove().

BTW, I should mention here, you need to set IDPF_REMOVE_IN_PROG before 
cancelling the tasks in idpf_shutdown() to make sure the event task is 
not re-queued.

>     VIRTCHNL2_OP_EVENT (link change) has a similar window against the
>     vport being freed, which exists on shutdown already.
> 
>     One way to close it without new flags: once IDPF_REMOVE_IN_PROG is
>     set, cancel_delayed_work_sync() and requeue mbx_task, and have the
>     PTP callback and idpf_recv_event_msg() return early when the bit is
>     set; matched replies are still consumed, so the teardown is not
>     affected. I can send that as a prerequisite patch, but I cannot
>     exercise the PTP part here (PTP init returns -EOPNOTSUPP on our
>     parts). Would you prefer that, or to handle it separately?
> 
> 2. A transaction that is already waiting when shutdown starts keeps its
>     own timeout. For example a GET_STATS from stats_task, which is only
>     cancelled in idpf_deinit_task(), can still hold shutdown for up to
>     60 s with a dead control plane, where the early xn shutdown used to
>     wake it. Fixing that would need a way in libie to expire waiting
>     transactions, so I would note it in the commit message rather than
>     claim a hard bound. Does that sound right?

Yea, I think solving this issue in general would probably require 
changes in controlq. For the purpose of this patch limiting the delay 
within reason for the more practical cases is good enough.

Another thing to note, in your previous patch you had a comment:
+	/* Destroy the vports while the mailbox is still up, so that the
+	 * device stops its queues before the next kernel reuses their memory.
+	 * A reset does not clear them on every device.
+	 */

The last sentence is incorrect - a reset must clear the vport(s) state. 
This patch is still warranted as we would like the driver to gracefully 
signal the destruction of vports, however documenting FW bug as a fact 
is not OK.

Thanks,
Emil

> 
> Thanks,
> Tian Xun

