Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1FBC79FB7
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Sep 2026 21:07:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C30C1810D3;
	Wed,  9 Sep 2026 21:07:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W_IV_dyKclH5; Wed,  9 Sep 2026 21:07:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D1A5C810D5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788988058;
	b=LcPrs/alFfo6DODfvx2num35UXIjThLXGL3jIE7IPzEX9go07JIRJjkIBBuHC9UdcAjy
	 rN18+2LKoF/iWgJ0H4fuKPoBo00flP3Q3QrOQlI7Tz8jG4uH3yPbboJJr/FUFlPMsoP5T
	 ir2udLeNnWIOjWv7Ps/SkA6+xEvAnAbfbTId64qXSilHkbsWEG9Kd5KkK7cc8dDh43pMt
	 HSRmw3p3yF0ArauIwtLVOHz0ID3uD2XrLSD7hSdfN137IATa1//OfKIb0ezMirSzOvNUZ
	 /FhEUdgnIup6xZHqwmhydG/fKaunFNkmdxBDFdXGmlILxmeQ6e6P538p5icPT68vSlA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788988058;
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
	bh=nLyimXp8JTxnbPZz19jW3P520bgTGkKnLBYzikm4h+4=;
	b=az6BVi1oPuyxhAII9F0TrxMv4gA1sptrqDXnU8KVpt2offaBfLjOjykcPcm+cGWfUFKO
	 WYpCgQO3ExIIYeWht/SCr5Mke9NA/lR6j2dbo6iNnd+dTFcM7CqJ/Wbh73ObyGgiZov4n
	 CJdYxRDDpUznsWY+Az+gV8a3OQixPWDVHOiS1fggicuiPZv0DNr5GLoDP/zF/R58UYiKH
	 s15NqgAxcfshhFa0OOS3UwUY+H372D85HtyoNOBArRJHLJbK8HdoKay3FKtbuWims99R4
	 yie6W9WjHkKutxhwpkLM6AcV87cSsVhdSthfu++QVfZ5/mm156wZmuCKjDvHxa5tTig==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788988058;
	bh=nLyimXp8JTxnbPZz19jW3P520bgTGkKnLBYzikm4h+4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pXh6ffd7bDuhUDwptUWTxvnfig3dn3VfsadcKDAEWLUy/HYlaRXOFe6d1Ql8eEo5q
	 OsDvj7H6Hs61BQvyD4Ngma2hWz+h7knyMwG84YZmHBzgiZ7+dae0lkWd0U//4h3sxd
	 o8XmTDdWlEjMPSNtgaWOB8yU906ra8H4EALmFh5Nx0OuEkBRXikImjYc6g5hbxgQWN
	 9khzz/E2BWtwG/V/EYYPrE6LVyYJmp8ATylbjoyB1jV+aA28UigifOrOCJsJVAn2ut
	 D2XguFW6oeyaLCRP2LaUsYKAcOflUl824x1Q8ZHRn7FFCSSyidexK9vnml8ZBD5pQ9
	 6Xh2NUO37YEMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1A5C810D5;
	Wed,  9 Sep 2026 21:07:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7286B724
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 21:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6440340A83
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 21:07:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HbjgDDzRI6bK for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Sep 2026 21:07:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7E3C040873
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788988056;
 b=onSagiI/KFv24b4O6k2ib56d57FNpiJsCHLQyQlmWANdU/K75stc+prfWdCRyinRsUNJ
 JsFowRDRGRTCWCeufSWizZFUsnPN/4t4W2g69t5sjxPxcslmdUG8hhdSnfG5qHhXiZxu1
 17mmruFLfulykBqqXEDgxsjIOupZmWuiPziC2OgaoCCzZXkVZ1sIv/wx7oHq57MW/cFGT
 sHIp0iM0gH6SvOU7h4Dqli4TiWLCPkRJzj+3jjsYx65XlzYpnbcZWRc0HZT7Teca7MZDk
 YzmxXDiu76a1iwl92Nfijv6mBiKueZeXzWMFB87WVoPmOoXKpWorLA/n22qQsW7TomA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788988056;
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
 bh=nLyimXp8JTxnbPZz19jW3P520bgTGkKnLBYzikm4h+4=;
 b=JQNuWPOV1YAs9XwU/xf8UTDMEAah1yGDA6FB2+SEsfRXHQVuE/Kiyvcsdifdzcnz9ER9
 DmHMalQ3jLkzE6y157nB2NpQ1QzorsBstU0cjyL3hKN0KznWxiq+3jz3DNXHPinYnBU4r
 QiiDFostXCOVTM84YpzhXQstl8yO+xRwb2xlg8Ffv24ydXPEcGi2QL2C0f8aVKKoGq7X2
 RECg8TGct/pbELvvg6R9258YetmVAlkTQkpDMPQEv4Zwh30bcorFjPWGSgkU3W38SQltw
 Iv43JF6GafPN7Aw4szo232vWcXCFyolPLiGHVnxfU1tW3NVLRjwh8Gn25myzK7l+ViQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Zqq45Jzg; 
 arc=fail smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Zqq45Jzg
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E3C040873
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788988057; x=1820524057;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WP6MudzK5A7zUe4pkERwImbLE/glDURH1XV0HxrMj3w=;
 b=Zqq45JzgHqSoR/puS5TF4LGC0ZVJJ14LOGTLWEpaaHr3uY61GYeATFoo
 l0Q5ZKdTTq5OVuYGXA/m5DWv0nT4aZYrHn7N29JD1JbRxvQJSBkXAFkqh
 7twaFk6FsY1kWhTjS1adP/zxchXeTS/amzoIe+4n52PQ6ioZttDTNkaJW
 12bPV6KGVae5w60gsw9yDZhvRivLy5uYmBY1j+T5+/RWIMZA/UROEDM6G
 htQ7PQaxK/w0SvO8sjbdg4W6aGdgxgZjAk96GbISARyyg78NUU4KxiFCz
 Ze5dQmqTw9n/HF6MMRX6Izq2lAj6cdR+FMydQVEawUS9Wymy0hUNrh+Yl A==;
X-CSE-ConnectionGUID: RgVZABdoQjaDnCBbtCZAdA==
X-CSE-MsgGUID: uY3/AC/pRpyPu0skG42ANg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93253070"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="93253070"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 14:07:35 -0700
X-CSE-ConnectionGUID: jpqHCJk9T327TdWMGIvCTQ==
X-CSE-MsgGUID: UZdfs4kTR/6YWeOE1vv2lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="265229536"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 14:07:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 14:07:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 14:07:34 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 14:07:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh16Sr/sOSqy79iBIR5YNVQe3MRkoKV1ZOZI5ig2g/3hzK/eN5GLzEX6PrxQEmMpG9IzuttxIKHtbQMXhGmhZa2zmEB72Z3K/Mlj2wz53Upjbl+SwT0AioYhONFCHb7BCYK72ILFBzxdBNiJhwQ34oJZm7+xE1eeuGvDYgrCpaAnNJfaUOsXFhnUc6EWSMI+fRujdPMIoyJ5oPd3FwDzuQo22lSaiy8uiZLDron7DSp2CdrLBiAp9+/9xbdjQ9ZXZ/7Y8xwvvJUXwlekpflgBd3GFMd9CrDb6ItwO8g6AOYdGrD84bBixfbyHKB+Why7+vVbPrkYEbpxaWDKikI39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLyimXp8JTxnbPZz19jW3P520bgTGkKnLBYzikm4h+4=;
 b=ElWMnImSQ7cbIG62R3aWZloB/Aob7pez9YPJfNWPcMia0fNqIVUu2YgPE1uccXmY+e5y9nsG1uVLVOrg3nTRpmyTaZ3tq4pC8A4x/EEpdRN+R4lyeb8lFl+kETfscbXVp0Fqv9Bi3Py7Gm8Kz22sfHxc1GTG0j3KnEKgigM6NKOsCPhQ6TKpoJSZLaNu8wNuUiUphBuWz7csatyuxUjfSFiDEt/KNhFoGrKg7Q4nXUN/CafyHln2qiR4Svb+L4Zb1SD8y07oKEZT9s+vBOj5TgJLT1Kk0KZwUnbMaOZJBupMhVxzcrJoSIN/m9SN5kWRtXJN/0wI3Thmi21uxdckxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by IA0PR11MB7864.namprd11.prod.outlook.com (2603:10b6:208:3df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 21:07:29 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 21:07:28 +0000
Message-ID: <e798b454-1f26-4502-a705-9e32dedcdcb6@intel.com>
Date: Wed, 9 Sep 2026 14:07:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/4] intel: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::34) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|IA0PR11MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 9898ca1f-ecf3-4a26-e194-08df0eb65af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pARq5/PIwNeINLhhSbKa0BapfoOA76CfVEm4qyL7zhZbSaqCMXd5PYWNNzJ0A+rJLwm1BCKiBvoN/fH8RZe2Y3lUdJceBzE+/Yr1wMzdGMfNi61bGtor6mLPjVlSAxdqquDOOEG0VqKgnZfV+24B2/45IjCG6IPHXChXV75Ow51z+T2h/ef1JD+nvnj+0xCJCBQl8W2f99mO5FV6mtnDbpmeSaMmMbwfWMvGCDuQ0/OpBldAHYyzv6c1rESMuovmKvw4mj7r+lBfItqp2w86kOVNg+BLL7hgm2qTyxhWXM6/E/lj8SFOUSID+0PnkTX7/rovJHDMydgoEp3hNU17a45obiaRYnDhRtGuZJotq8NqAGh7ZSxpQS3Xib2UFPS5Q0KzZCMVE7kzZRLoefh6b2HVaw0VwbX7NYF1mjvHwwYKkbOrGmGaESiGSfjZ+YXdxk18UisFC3sUvO9B66I6azdEH3sJoBFPHEPmwqQ3ol5m6h+05cRdqIba9T/v7Qo9bFzfP7jtYZytdixoGEuNGos10JqnNk0fnBTx3uZtbFBfJ20BOuZvO3V8FqqbQecnig/hi3eDn7+2dcV1j7p/oeHDp5TsjKkMl9w51supCHUYPvwAwlq0VDQdnoZeD8GIM875/4ABbHe2gtMvuRDJF+SB15Y4KdKOnsAB7Kl8FcfnvuizPp/UYcU8buvhqaLmqRopNswuHPXwrFQNNNDdyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5oM1dkN01JRGNwU3NHMklsOWdHeTJ4bU5JbHNJNmRFa1Z4YTVhdEZwbXJC?=
 =?utf-8?B?cGlkeC9iOXg1T3ZyUE5QWUlyTFVWRk1rcWpCYzB3VkJMeUUzdWdBZkY0SHBR?=
 =?utf-8?B?VXFSTVlucDlISWVFdE42emRvajQrM0VaaUIwNVQ4bVdGVG9PT1h6clhDdDNP?=
 =?utf-8?B?K2RFRklQaEdyVkMyTTE4KzZzdE5rdkdIS2ViSVUxQW5mRjcvK3cyUTN3Y2RG?=
 =?utf-8?B?cEZDRS8wWGd5U1VsS3lQRWtWbW91MEk4cXQzRk12MkFmemdvd3hrV0tCQmpI?=
 =?utf-8?B?TGU2VmU5ZXpSMzF2M2RSd0Nnb3dTdTR3K05kY3cwYkIySlBSNDc5UnhsVnhh?=
 =?utf-8?B?L0hmOGFoQ3FYaHVQeEtlb0dXL1M3Z3g5a2V6YUFLaHJMS21nVmNmdlBpMEhw?=
 =?utf-8?B?L3dYbmw0WHA4UUJ1ODVOL2ZwRkpXUEVMUmJsRzI4NWtpdXFPQ0NHbU1DRGVn?=
 =?utf-8?B?MC9YaHdaZ2pwMmUraGN4YjZUaTE4eUg2a3g4L1NlUjl6cTV3MU9OWHFENk4v?=
 =?utf-8?B?L0E5SUV2cTdLN1JUZlpvbGRUZWtjZHZuWHVuRXhZeC9UWkw2U1ZPSHIwNzNE?=
 =?utf-8?B?M0phZ0xBS1BBMmpaNU9EUDdRUjBVQktMUGhIa0NDdHVQckt1T245ME9CVXR4?=
 =?utf-8?B?T3dJN1ozSS9XWnA1QkJtcnh0WW5ZdjJJYUpJcEcyUXh0YlcrdHIvOEhZdXlq?=
 =?utf-8?B?OElHeFFuSlczM0FmR2hKa09wTHpTTXl3YlN6aER2azRnVlFkbkc0UG9BRU1H?=
 =?utf-8?B?RkcrTFB4OUNPU09LUzk5TUhyV0ZaQnlOQWRyZFZlRjE2N2FlNXhIV0pUYnY5?=
 =?utf-8?B?MEJmek0vb2l1a2NNbmM3bFpVVm1TazRFbWthNm03cTkwd2MwMnFuckgrUSt2?=
 =?utf-8?B?b0pIWVVJTGplOVVOMkl6NVpZVm0rYlN1QXVlZER4UEE1bzk1VTJZamEwQTdw?=
 =?utf-8?B?SnlWbFRhT2VnRzF2V2JYdVB2VysrR2owUk03d3RvcTlQbXlQcTZWdmRwbEhm?=
 =?utf-8?B?M2Q4MXJJTUtSeW5CK2NsV2hCUjdkMHpuRnllVzErbks4SU5PU0lyS3NJNDJM?=
 =?utf-8?B?ekdIYmJJZGxucVAramdmSHdFSW5Nc3ZtY0xoV2FpbmFmeXU1aEw4OS9ZeFVh?=
 =?utf-8?B?WktSQ0pibGxGMlBsQldaSlkyVHhncmVkYXVpMXJqN1Q3MElUMUduOWlnRFNC?=
 =?utf-8?B?QitOTzVkL0NSQytTc3k0cHJIRTF1RnJrTjJ0ejVQQmxzTHFXNTVmbzU0SlMw?=
 =?utf-8?B?UVBaeUpRcjFLQzBuUDMvK2xGM0YxL214TjBPakNGaEwxNXNXeVRqQlRzZjNO?=
 =?utf-8?B?K3hQYWZVYXY1RFQ0Yk1ERFNNOHQ2RmR4OXh4Q0pKYkpwY0RBb3NyYmFWclN4?=
 =?utf-8?B?M3RPZmlMSkI1R0FKd0hnY1JmS3c2NlV4K09tVC9PTFFqK1k3ZzNqeHhlenZk?=
 =?utf-8?B?ZmRZdVhOamY2ZzNOUmFjQ1JVdlQ2Nm4rOXRMdi83dEtCUkgyTlREb1k4eG1V?=
 =?utf-8?B?NWxHbGkwbXhKWFhmMGx2SDVsRXJnMHUzREpIeGdxR0RoVXZMOHZNN2N3K0FP?=
 =?utf-8?B?YmM3bEhQL1JVVnNSWHI4L21aMGsxSFFncEY4SmJVTDlxWVQ2V1JmazVWNFU2?=
 =?utf-8?B?azJrSE9xT2hSWlVheVpibEllMGs5bjZhTUpvKy9QREh4emlIcnB3ak4vZldZ?=
 =?utf-8?B?Y0RaSFdSTnNJRUYwVWtjeXFlbi9EQlBhMWVXVTA3TUg5YmRsczJKTE1wa1JZ?=
 =?utf-8?B?bk5wQVZhWkw5RHc4dUtoSWVuaTBVNXhzVU9Pb2Q4ZFFIMUE4VmUwN2VhV3ZW?=
 =?utf-8?B?VFVGeTdBZkY2ZVd6MlpBbWMvNEJyQlVaQzRwZ2RlUzh6Y3Nadndkc3FQR2tt?=
 =?utf-8?B?Y0o0SWIwdnUzYmhWcVFVa2VOTXlMRzhlR2tsTFJ3UTRPa1hkTHdDY2pIdHha?=
 =?utf-8?B?YWNsaTlwTGIrLzRmTDVhNytkeVRaanF6ZVBTSC83eFBDQ0JDVU8rczdLcTFS?=
 =?utf-8?B?VHZ5VWlPRUlpa3J2aEhJR0VCdjVheVVET0k0SFkyK3NZT3RBWjlGbm1hWlZo?=
 =?utf-8?B?N3NEbnkrUCtEY1BDT0R0eDlMdkJvdTdhK1p2K29waklDQldoU1FxNFNFU2xY?=
 =?utf-8?B?dEkrWUZXZmlsSVBES1NaYzRTVEZoMlVEaERDNTI4dTNlejFzN3lmM1A4Tnpk?=
 =?utf-8?B?R01iRVNSK2NRWS9qanFzdzV3L0dOeXR6N0RBSUh2Tjc2Q2c4dUVHbHAzN3M0?=
 =?utf-8?B?b1pENUI3elllWFZBb3RkUWZkWEJ0U0c5YzZzdHV6TGlxT3lBbkc0bmtKaURv?=
 =?utf-8?B?cHpvL1dXZ0J6M0UycTZzdEErQXpVbEwvb3UrRkg5WjBIV2VtTnAwRmM2Q1Az?=
 =?utf-8?Q?L82ZeilQYJDZEHLM=3D?=
X-Exchange-RoutingPolicyChecked: SIGTKPCqx4pMrHlK1r3aLefrNCXgL/q6/D21lLWA376DkcxBu+xldIwmU6xXxBEA3OgJR1l0hjfr+fe4m1u9i3q4qkL+yVfL3TF6yNU2Ll9yDUCIg2DftwfqzxXefKdeCwMzsmQ+z+qQWDLdtbPDu9logXbmY6vMEc/sk7wRBDDxNhwnSBpI+A1iX9qvlHZ0967CQ742OMjd8LdKBu9m3b+GB/phV7QrZhhxny9gtEQ9cGjLNf5Twid7e/gD9NwkeeW1BrqozHP+mO9I2cdyoo4xkTiEEvj6+14p3GmizOZcYaVgSedzXrhHB2G+q43RcChlUIzuHEzSJ9spdqc+Zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9898ca1f-ecf3-4a26-e194-08df0eb65af8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 21:07:28.5819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6NFrrm8h3m6ltzFqM/hRY+fcAW7vwIj2+RH3wsFhUyyNHzYBcNJglyoozjSGc9mw3sUShxb3Uw2wOuUzPjI2VG3H8QzUjj7Qq3z3QX9AQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7864
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



On 9/7/2026 2:54 AM, Hemanth Selam wrote:
> Comment typos across the Intel ethernet drivers, split per driver.  Found with scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Comments only, no code
> changes.
> 
> v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
> maintainer-netdev.rst asks, v2 designates the patches to a tree, and
> each subject now names the component it touches instead of "net:".  The
> series is rebased onto that tree; the diff is unchanged.

Thanks for the changes; looks good. However...

netdev maintainers: Everything looks good to me and since there's no 
testing to be done. Did you want to take this directly?

If so,

Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/
> 
> 
> Hemanth Selam (4):
>    i40e: fix typos in comments
>    ice: fix typos in comments
>    ixgbevf: fix typo "enble" in comment
>    Documentation/eth/intel: fix repeated words in comments
> 
>   Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
>   Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
>   drivers/net/ethernet/intel/i40e/i40e_common.c                   | 2 +-
>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c                  | 2 +-
>   drivers/net/ethernet/intel/ice/ice.h                            | 2 +-
>   drivers/net/ethernet/intel/ice/ice_main.c                       | 2 +-
>   drivers/net/ethernet/intel/ice/ice_sriov.c                      | 2 +-
>   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c               | 2 +-
>   8 files changed, 8 insertions(+), 8 deletions(-)

