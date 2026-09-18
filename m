Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC820C982D8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 17:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FEAC40BE6;
	Fri, 18 Sep 2026 17:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id elKrbABB6YBy; Fri, 18 Sep 2026 17:55:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A481640BFB
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789754128;
	b=OpQLnbTrcka1XV0v0BDOZNXkIq70rYx7pn+CnZmnO5lTZRLlKyHMptVf2GPlP0TiFWVN
	 SWYSpEr1K5LT9rM4wo1vDUHeeG1LacyuUcexEhttCVcn69MJd9wu/KP9uxwiCtwjAiuxG
	 pvdv9gdepfYaL1G51e6p4htKIBffRRmdB/jRXUlWtPw5at04quV1R+YcdQ65lK33qBNMy
	 NeZv9I6XQyLuQ9dV9v9vnAmJ6NNghpBxLpvfMHcSikfGbicEb5fd5wvLQ1DRGCLCRy0Ai
	 6gWUNLe9OX2FecmlGW3KkXsay3jMklThWDUqA5neyqmoYn9PEMjxqenypDaSuRJA1aQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789754128;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Received:Received:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=e4Px3+UZn58SNNjoIqp+FtU9/o3ks4MiVrnc8ufWUf4=;
	b=bSWPJxL05iofPzENcLOvHGAe9ePVUoaNdezRHBiaHVbymvRByMW2e1YcfFBzoSGVwwld
	 OwpPiTPpFlG5auxyMRn56XMI0yG1OehCDdkopzKFWUMV+w8UBBdsp9FO/BPpx4ZJknLov
	 PVFuHDNQYglvrZqMP7JlSq++0OQiYf13uUsnsFo7VcueD+PilGtGUWtj2ewrY7Os8A6fy
	 PgTgM4UZcnWVvr++qw/6Zo0BDp7PH1a+fcn4qjqdQFz+UuZ+MDMw5ZZCII9lUf4MjcMGt
	 bgIhe4uvOpHZ0uOB/rc5KGsttTElS1BugvFipWAzjX0sjdvtjYZ9aNKMD0aQJAkkIHQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hAqtNehX;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789754128;
	bh=e4Px3+UZn58SNNjoIqp+FtU9/o3ks4MiVrnc8ufWUf4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0rX1l0Lsvl7JvVmTT/XpsHX3nrrGSyXP2JDjD1KmYFnwZk2ubKD9zthQPd8yIs3K0
	 u0cTZngK7/Ah0jpJBcgW8B1TXmaTbssxQ05Cj6zpqnTSfKXFJ617oiIjMT124IfcqR
	 2D5XxyR5K7lbhWbE1uSXW2HmRV3Vpgpn3MpYmL0QVd9Ma4x6kVCq5k+UFiy8w7LZLZ
	 H79TXCXCVP54pdEs9t/PjRno6WyExDMNxAwpj67N///2KEjO1T+ycyVF1WeNprBHPM
	 RmAUIeybAWXcKRnEPuSUDXnZ2DGjx/zsw1EtAumAtbT/sb4cT9MBf0E4mDYXte+xfq
	 963S2Hx7z7uBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A481640BFB;
	Fri, 18 Sep 2026 17:55:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C6B2113D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 17:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B836B40BFB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 17:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 581HNURrZ7CV for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 17:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C7CFA40BE6
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789754127;
 b=nWeToeKa5xEBw+km3BSQ8xpg8wPu6hN2EeBefKBonjx8Iu4zeeUBm/J975bYPJepkir/
 NyNTxZ9CYaazva7Rm+N1O5XkqE+E187m0zPLpI8VdfAunHBWrTzUMV/fdcIYRUtRRWBdH
 9TPd0nF4r1If5P5WHJOUeU7f4N//Dsk9nv97gZNLp+UlFdVC+p0x0XLWtGr7wnYY8vXWA
 boJdvnkxGbzeNo/K1NdcCvV8vcGxDtArvBcruizyzGNHn74RiXESljqN6pyJqka060FCl
 nyaip2Osn5VuqaXEBKktBQ5GlyOyT4ub+ZEa6fjlrBqgX48nlPiPf8Z/RysU0P23k7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789754127;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Received:Received:Received:
 Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
 Content-Language:From:In-Reply-To:Content-Type:
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
 bh=e4Px3+UZn58SNNjoIqp+FtU9/o3ks4MiVrnc8ufWUf4=;
 b=D7J8TYoFyWYE57H8d98482vcnMatbPczmmXHku8w2lekirzPHxR8ToI/IS80Gu3mJkXb
 kDP5DMjb7PsxyJrse9wKNz6l9ydwiXWK6Lb+2N8ekG/FKYfk/uWLvvPqZUTBH7WGR2Ea1
 /CXHha3x2bM1dgPjacsVWBpRamJL1sw1apBmMN/O7jKV3lXPtKrIDqCimIAmvKhgdsDzv
 b0lIbc/tYF9Qbu7v9SRsgAeV1bnMI0CHerR/g8iSzxQguE+9E9DcnxQjZVg2bceNl/mWr
 zXTXr6ikyMQujZF0RGmPvfuIX5/UgOtBSpdKxlBYh71aPUZP/iXGgeYKYUwmVMwocEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hAqtNehX; 
 arc=fail smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hAqtNehX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7CFA40BE6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 17:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789754127; x=1821290127;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OLl1cPoe2VfeGYURwf+h8bhyeQC9mALK1AC7uqaaXz8=;
 b=hAqtNehXio3S14CeFpnWeEOHndJC6uy//NugRsGjuBOXC3GVWDO3Oo8k
 Hoa++1dEvwUT0wpIgSKO0XwnNiXb9z5YD0ryi8Gxbn0aR8SWtJCGKKa0Z
 RYuKcK1+0SNbmC4XFCZbhkbrcBtSzNiIpZ0T+Vq7CJ1t80j9eE/KeV1ec
 ji2kVAoGgfm7zOK+85XFb6MzcZj8IX05CAfg72owp9/dDkNXptPZGcQAy
 TwUsoMtKs4ZlsYHgepW9mxDRdAQvV95Cw70NpJYFQIanbDRrc6mASHi9u
 vRnGxw6jj5nALY1Fh2XFK0wItOxN6gmbS8RLk8d3RK/okqJcdqyl27toB w==;
X-CSE-ConnectionGUID: 38wpvTMTRbCeimEfjpEjTg==
X-CSE-MsgGUID: mEO0OmXmQEqLEcGvQ+tbNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="77843580"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="77843580"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 10:54:59 -0700
X-CSE-ConnectionGUID: ZuhBIfEmQx2t8r9Wx++nmg==
X-CSE-MsgGUID: EF6mcdr2RV6Z2EH0UuBByA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 10:54:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 10:54:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 10:54:58 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 10:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iq4Y39S8yf7vySBq+aKjALO3xkpIvhTP8pMlzf0+wLIo6Xc2dtV1dwPRJcYi/oZlSbGcpktJLpLB/NFdeg+GHu+aOrLe3FsINEf1wr1At7KjieUdjtN4R/6VhWecFsnr/2K5fIjM8yyHHSfWpXUhKXIYq0w3anX14XRcW1MwjAap5t5z42HTQFDgfhCCDhZDOOzhzokQQN0vY1rk5JqP/q5n2vU4jjgTW+V7zdeVHaY+kCfex5K4l0L1Xd+sGCRAgruseU2tJG4WnCCB6p/M0wqKkQn6juSn4wbl3IOA4BbQiLODFzuzO+oRkWxyJVLAniseY88iWC9+nGEV3ah/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4Px3+UZn58SNNjoIqp+FtU9/o3ks4MiVrnc8ufWUf4=;
 b=k8kymKt+pWATUwvcP9dWcAb9tQbdfsbZF7ztPdALPaNbY3eEoY78TUJ25XZ3Xz5dWLiu96burz3wilx9JpqB9mhru7nYls//VABOkE9ufD/1tlprBEUfe8IzdaNwcZEEgEVbjkT3ykRYjwsNyuJmFw5in3YcXSohQPmOYsCNbhs8kpbLnPUe2qUM3Wnk7acAZpsNGDtSsUX37QvocnfVkXei6HKmPqdULD2Mwa0833y/DjIabA8MdC3yjkClFjevvytEGV1OU/HWIguNuIxLlVTqnL57r5wPr1UIP8JnmazFYV9A4CSLhilyfIkuY/vcHNpUArM5Nv0QnDqu2cO9Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by SN7PR11MB7539.namprd11.prod.outlook.com
 (2603:10b6:806:343::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 17:54:55 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 17:54:55 +0000
Message-ID: <49cbb19e-dcce-4bdd-8cfa-68fb2445f952@intel.com>
Date: Fri, 18 Sep 2026 10:54:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 2/2] idpf: reset the function on shutdown
To: Tian Xun Ng <luckilystar08@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, Tian Xun Ng
 <tianxun.ng@bytedance.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
 <20260917105205.37561-3-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20260917105205.37561-3-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::26) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|SN7PR11MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 17083b62-3bfe-475a-6abf-08df15adf2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|10067099003|11063799006|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: SoIYneYu7vQQmWGEeWvot5aYmyBaLbyyv6FJ6eY4sOvtZSOVwC6xfXjswUz6MLV/WeU8R/Laj56hmjXafaEk4cQbhDG1zrCnVLW/oTq2jkIXCwt/QPLic8yWcLY+DIyfsb/wGEIJXixY8tMfaDYJW5NpcfaQ4aAcw2YFRwlShKDuhmtMM9gG4UxHPEQnyKtimOmieWRVZsyFORXLVnJGkh2Ue9Jve4BUbelJEdGJ89fDaWy8cYA18jQ6TBQGICUmqFFCc/02YiEO9LiM7+vOKE6bHTsb4gILAJjP3AsPOf52mafyq9OJ27X7LhrqgtcWd2eyu1bBy/FojkjcrzMLI42kmkv8/Igupqd8/ZQdCgLqk2SieAEsRQ30zXPqdzREeG76yjnLe3P26RXGP7OnpPkmFbQd8I8sVpuppnh+KrxtuBef14cccQBOZcDsE9DIbr4gNOzjh5I7ZCv5zUpTCc0wxwY3yNIfpbD+LZmya4G2vsmPxqLJjMt+FZWDNpU9h59OOzuxRiFbHx8cf2ejSABczUPty4whQSlqGucgkGXBqeHFrQYW+nvTVVYTwWIKRJdgTxh1gAkdxH2brgF7RUtW33rrAFkr6pWGpR2Cb44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGc3NFhDZDlHalE3V1hsQkhTOFY0bi9mTjE4VEcxY0p2QldmdmM4SmcxbnNP?=
 =?utf-8?B?bU0rMnE4T2JHZmpDRnpsN1NWR2FjS3g4a0xoRTQ1azZUMloxMVhUOVhDdGVO?=
 =?utf-8?B?R29va3pxQW1Zd2QxMXd5SGtRWjJFS1VxYmpSejlxTHlPQ3N3Z0k4TUFMY0Zt?=
 =?utf-8?B?cUh6cFZobzFDQTlvdlArVmh3TmxtVkNuOHlJakpKUDdEWVVacU1Ed0Z1TVND?=
 =?utf-8?B?clJtcllGVzhoR1BuWVB4L05sWHJ5MTR3Qk5XV0xMNkg5aUg1TC94ZlZJeXhW?=
 =?utf-8?B?eGorYzNmbVdCdjExS1VYVmxnaHFTdUhwVDZ4eFRTNXU1eldLcVM4UmtBbTYw?=
 =?utf-8?B?aVlCN054eExCYU9BaW5wV1JMd0l5M2tUT3VaYXNKUTJPL2NmWVhmYkN0TWlG?=
 =?utf-8?B?TGVxMnl6YTRvVElMVTRpSGZqem9idk1nWUJDTTV3bVI5S0Y1bWJQOFJHNlVa?=
 =?utf-8?B?N2RpSXVqQmFYTHlsdDRobkVqRFB5N2hXRmhXU1RrZENtZSs1M3VCaitjbG5F?=
 =?utf-8?B?Qk1COVgrcGpuSUJWNmhNUllxWGVOdm5EbXBMTHArVGdVeUxjM1I3SVRpUktP?=
 =?utf-8?B?QXlkN3A3a2pVY3hSbHRvbVdHQzU2UXExeVFhZDhiVG5pdUFNWGp2SFVnTjBJ?=
 =?utf-8?B?cHpKZVhxcEhHM0FUN0xjY0xGM09KV3JmblhjaERBN05TR0dDMUtrcTVTS2Nz?=
 =?utf-8?B?QlJrT3ltTjdNcGF1Y3ZGSm15V2wvN0tNOGRjd3pyNnBITzNUTDNpMlM1SDRp?=
 =?utf-8?B?SWpWSG1nV1N0eWwrM0RzK0JWdXhYTzE0NU9iS1FZampkUVRpQnY0VEE2bnlV?=
 =?utf-8?B?cm9YMmE4Um1oZ3VCOFZkUGpkOVZ6Tmp5dTNCK0liWEJkTCtwOC9BRTB0c2gx?=
 =?utf-8?B?MUphTEg0UENjWFdUMkFBK3grOHZSOXBoaGhMUkNjOTF6Y3J1c2hNSm9lWlFL?=
 =?utf-8?B?VkhaN3gySEpDZFV1UmVEekV1UTlXK3cwVlBnbmk2Y1kxelNMcDhqMHVlT21V?=
 =?utf-8?B?L3VXMG5STS9UeGU5dHNlNjY3c2ZvRy9PSWdnUC9MSFVFYjVmYys0bEpRSnhz?=
 =?utf-8?B?eTJmVFpPMll0djVkc2FWTlRaNTRWc2xVcXJFajJFK2w4RnpOYmcva0RxRWU0?=
 =?utf-8?B?ZmFJaEtiNVRXbU4wdE8xTTFVRWNidzJUNEhvK09PSUtRb2xUMGJ2c05zUytI?=
 =?utf-8?B?bWI2Unc1bk5ZWStqdmhBWDF6VkhPZ1pZN2trRWl1eW9iRkhzWFRXK0RVaEU2?=
 =?utf-8?B?Kzd1anorOC8xQmJ6bldxRjNTTjRzaTl5VXNtUXQ3U2MxR1NTWHBsYnJQaktz?=
 =?utf-8?B?d1RTcTE5ZzZicmRDZ01DV0NVYnhOUHJzdm9hd2srbmZRckhQeGJ5MXgreFdP?=
 =?utf-8?B?NEwveGN5YkRaV3BKd1hZazBDNno3T2o1cGh4ZXJSUkkycEc0SGpoSEJtYmhz?=
 =?utf-8?B?c2ExUVowNENBVDNCdlpSL1Z1ZmhGSkFGdDluajhUcnZOWjJnc0R1OWFCOXlp?=
 =?utf-8?B?UUZPSzByOWlaTHpMellvUFJyN3cwSkl0dFp6L0RVSEdLU0RZUHNUU2hMRVNM?=
 =?utf-8?B?bkJkc1VJaTJlcVp6cTI1bTc1cXh2eko3cWpkUGNVRnZMVzZtOGlST0FLYjU0?=
 =?utf-8?B?SThSZWZUS0pxWlFvUTNkQ1RRRDFFOUVDYnRoWnA1b1IvVXhDVU4zK293WktD?=
 =?utf-8?B?Y2dDRWZkMHJGWlZLVWhBS3RvVXZ0MGNzUk9yeTdLbGgvbGhtaEpxMUNnRCta?=
 =?utf-8?B?cjJIbUlQSEFHSnVQR1d1eGdyRkxEN0FFRG84OGJ5SDBrRDh5eGl4UWpXYmJG?=
 =?utf-8?B?RjVqZUpRcTkxNUR0ci9BbGdKN3g0ZFRzTWdSZjFtY2ZMUlh1REpIVDNDSmxs?=
 =?utf-8?B?V0J1TzJOdXlOSWpOeFplcnZtVUkxL0ZyWXFlcXdWWU5YOE9CamdYT0UxM0Rw?=
 =?utf-8?B?Z29IVjlrVVZydkxndVNITmFVYW5ibUxhdnU3L2pEUUU1dy9NekhaL05ydEZ2?=
 =?utf-8?B?TDNPaXdKOUczUGlBT3R2WEJ1U2NMOTd2Vy8xWXVEdTlna0JNdmQvQnV4NkRK?=
 =?utf-8?B?ZGZLMUppa0dseUFFTUJESTBJK2ZHWWpBR2NGbUtxWkc5ZlgydXNmdzFGVXBO?=
 =?utf-8?B?ZTB0QzYxcGNpRVZDZzFlVDkrcUYwd3FHT2Q3RkJUTmtyQlpGMldaMmRlc3NC?=
 =?utf-8?B?andZeElhQWZKYzVQbTNsK1dCeG4zYzJLZ0JNbFRxcW8rdFdqNVpTekNudWNp?=
 =?utf-8?B?b25yS3QyRkxVOTlQVlFuNjhjRUVkUUpwS3JCdExRMkI5RlJsTzhnMU5CYloy?=
 =?utf-8?B?eVRSVlQxSjFYVFEzckpxQi92MnEzQ3FxSlAwN09mR2tsYlhYQ0NydVhGeUFn?=
 =?utf-8?Q?Uw8w44DjDhER2u04=3D?=
X-Exchange-RoutingPolicyChecked: XIu44ZsdexmIcAi+77iruQt0rXAX02E3kbbWH7tFixdeCor/cthZjFc0ZfQKf1hVmoEjuCTzh/aDXY10sPVcQ680lD7bYaNTVe9/EFFGOFB793kBO8yJP7KeWsYQilyfa0ogfoyljnqIB8blNOZLCOKE9a8VuUV6z9Qo4VheVwvIB6kJd9iDByDefhSWYXV3/p+yHEBkgDCon8guaZfqwQD5tNp30oO7MZh2AWK5bckDZvDZjLh66ZWK5g+tUopmaZhI37wP+Y8GMXezTgraiuFG+ilXoVof8zALaRtk3HdcCWIkSs9ED0LtN8NVfIWnkCxjiu6+FckdosJI7IWmHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 17083b62-3bfe-475a-6abf-08df15adf2aa
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 17:54:55.5942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfskG+upjayFvmAE7VKLwUd7bGPWbPi9Frf++1VYg/ljUy38KWZNdqR9mPLSS1VR2/ihxXTDS4AuObztsyO2KYd0dn1zcs9qi69iLJ27U44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7539
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



On 9/17/2026 3:52 AM, Tian Xun Ng wrote:
> From: Tian Xun Ng <tianxun.ng@bytedance.com>
> 
> idpf_remove() ends with a function reset to leave the device clean for
> whoever binds it next. Commit 4c9106f4906a ("idpf: fix adapter NULL
> pointer dereference on reboot") replaced the idpf_remove() call in
> idpf_shutdown() with idpf_vc_core_deinit() and idpf_deinit_dflt_mbx(),
> and the reset was lost along the way.
> 
> Restore it, so that the kernel started by a warm reboot or kexec finds
> the device in the same state as after a module unload.
> 
> The reset alone does not stop the stray completion writes fixed by the
> previous patch: the next kernel's load-time reset already performs a
> reset and stale queue state was observed to survive it. It complements
> the previous patch, which makes the device tear its queues down first.
> 
> Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 129bccaa6..d7cd449fc 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -197,6 +197,9 @@ static void idpf_shutdown(struct pci_dev *pdev)
>   	cancel_delayed_work_sync(&adapter->serv_task);
>   	cancel_delayed_work_sync(&adapter->vc_event_task);
>   	idpf_vc_core_deinit(adapter);
> +
> +	/* Leave the device clean for the next kernel, as idpf_remove() does */
> +	adapter->dev_ops.reg_ops.trigger_reset(adapter, IDPF_HR_FUNC_RESET);
>   	idpf_deinit_dflt_mbx(adapter);

This alone would not be enough, you need to make sure the reset handling 
does not trigger in the driver. Sashiko is also marking it:
https://sashiko.dev/#/patchset/20260917105205.37561-1-luckilystar08%40gmail.com

you will have to set IDPF_REMOVE_IN_PROG, though I am not sure if that 
alone would be sufficient.

Thanks,
Emil

>   
>   	if (system_state == SYSTEM_POWER_OFF)

