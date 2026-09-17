Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91366C982D0
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 18:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D74060B8B;
	Thu, 17 Sep 2026 18:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0kTiKvEFAPts; Thu, 17 Sep 2026 18:24:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 978DE60B7D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789669482;
	b=Px6fcdYiOpLKHAelit+WJ2ZMUumH8dFSNjgLj8FDHYPTAsXhdLz2oo32Yfk+IqyxrQdB
	 0D7O6ZND73aFtdj4EIr/Sa+MvH2ckULfBwLSxO8MHS/e1seya8pByhzyG7agzgdLaA5az
	 RLDT48dTKGkdgFwvNSV3Rt9+6DxsUI4tTFx3BLbqwdZZPd8AXtT21KOhYDvfdTqc3lHFq
	 b7SxvQVqoIUjgnMgSUnHGhBAg5IMMhaPNdBaMcKCg2NRWhY/BOO2Ln/Y+o+hM2CCiqv+W
	 GtLE3ljtWj5+lo/bUaBP2BVpDFvZzliGjk9iX6aIRWsJtFI/LF6u0+1QqYUrIOWx5bw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789669482;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:References:Content-Language:
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
	bh=ztYrZrgByEbZLKo6GIU6mEa6ETSeEAHGEQUiSCtqNr4=;
	b=Hkj1qzX8YcPVHcvSQL6xfq81kj30VJsuQOrqEitaGMebiAtAHAPSkXhNd4y/PKmbKETQ
	 c2ozsEA7xwhJ2yEojzw+ttYZguFhHvFDd8NbsZ2eyoQL+yKiDPdg2/qIX/vod0FXPEWbu
	 fw9n+Wp0IyQDClsAUSw2YATbG3Svj0vp+DJLE7HCTIRITsNJIVUjmGGQxmDV07owrKW/Y
	 yjxrAjVGuHsJ7o7oxKYP8Y0krbW5fDhUpx4PdApA/kiazcSAjQkfEbzzm4CtM4APHbb1f
	 Yuh8sBObxNKxn/q2f0qNz0q6vAYmCafmBhh7i9v+G+Z60Hq0YG3E27YFaoprk9IAOkA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789669482;
	bh=ztYrZrgByEbZLKo6GIU6mEa6ETSeEAHGEQUiSCtqNr4=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sg/WpfyawgQr5VWqIvKTlwb/nettuTjuD070HoRw+OFa7h6MZxbeoIShO/iNE4Qq/
	 EaukwJfbxAU8rR1N4LbB92XxSbI2b/nRVVCCPIKLCnY/+GykxY1fYY4Sx3EY5ah3Yb
	 w45JMlGGwzl52AKsRGkd1p1iL4mCVwcl7V02iuyCdv/U7yAmU6miQhh38ZCcNm0ePy
	 98bnjNMpZ4B8K4s+DPUR8n179rcx6RzDMyeZu09x8HpzxNNVCLmpCC4tCUJc+21N/R
	 xwNDy9CnUNZnmLJekxoODNKHinW1MAx01hsniwFbgwdI6WSozuDf37ZMQjOv3+1R9s
	 9iKVOLu+jbbwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 978DE60B7D;
	Thu, 17 Sep 2026 18:24:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1DE7422
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 18:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C29C381101
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 18:24:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1e2ordk3sNAR for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 18:24:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6E7A1810F1
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789669479;
 b=qLLNcXIEey2krZKDjgQbvmNuUDfrNyTggTa7My31kHyvExTG17jaMJhI6gwaflerUgOO
 YCy0q20fDgAbR15NqofrD1ROs5mdtlmz2slCu9aIeSBVVGAt24aMp0TCIVtRiEgdMzwgn
 EoQZe0gaHIkMJF7+sqCkn9t67qw6IHOU8/CnYresnqTIDMkrsVVNV0ZK5jXbdIh/xUUNc
 J+lCk+39azZ+On2Asg+oKpviPdd1otCC/AiPLdvJaujYTxrzxYTIjddmwaHv+7BqCN+5m
 tQb7gfEgzZ9Wp5USyJ+JDPdBISh0Zf7GXJPL/UELDja4sAhDeLUE1qwetyF1D8umS/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789669479;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:
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
 bh=ztYrZrgByEbZLKo6GIU6mEa6ETSeEAHGEQUiSCtqNr4=;
 b=FPrvpmxVX5K3W7EN/doiwWYHdQGMh5nlYmAUky8CSiuBHr8Uz4P10yoY0w8cCuQ4cfLf
 sKiwGyWfh3nl8CfSS8SFS6Wv/d2NrjQ9XZvgIn7qzc8ohVyxm0VmeTKLdxAAVDJl99HIL
 19OyJG4PUhfGzwIqoHLAKsgfLsC28+gBIJPZVE2DNw4N5KyMEk1jHuXBaR/LgraT4kkJe
 82fceMbMu6jGQpj1jVy3Dsf/mj7xj7URskQRzamJPHVD0VM/fQD6P9YdWGdS06Rr7dQZe
 al6O9a0w/eA6NTtgm7mpiWJe8t9AnYdVX5aDVivRPgW0ZVuW+grG5E28Xv9zuhQcTgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AwwMZHrI; 
 arc=fail smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AwwMZHrI
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E7A1810F1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789669479; x=1821205479;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Y97JIk18jPYaUDas7U9XxY6Kyd1BYJmcTXWaYArRtUM=;
 b=AwwMZHrIpUzYF99Z4esxWQqsAbnTQtmp3iAWJxHqVsnyvOn/a0esI53y
 mUE+v3iFTgCev+uoyGpop9KYaQDRPe90ZGzqUCPyCc1e5fdGT+Fswg4ME
 ggDoR6wJX2U5Cn1d7s52VweXLN7QHzU+6ewalzqotJb0mHiQAXIwOurGG
 szXNAZ24jNIM3pNFq2OAn6R8E9Bolq+kQbA0U7/8YGZ/E3oCLlJGloGYC
 RAYaQTth4wCqVhabbBJTRaV4KAq2NivL6W4D1JEZb4e/ns0kDrmCWR4Xi
 2MJ8LkWjqqcdWsE3tZxhrulOJZeF9KaoRGlJSpv5FK4LWJawOIX+Fc0Ld Q==;
X-CSE-ConnectionGUID: 1gQFUVj7RjG9F3xcSqMhOw==
X-CSE-MsgGUID: VeWqrl76SMm6uJedBy9CRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101471800"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="101471800"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 11:24:36 -0700
X-CSE-ConnectionGUID: GR0AuTI5QfeTXBRFzFbgAQ==
X-CSE-MsgGUID: 9X2y7ExhRg29u2guvSJUYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2143412"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 11:24:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:24:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 11:24:35 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:24:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7AwmoQqZEOiwm0zgZREZid0M2QmAPN9tNBdHTPKqgh8rVnwsStuB/SPJw3MiK83b9Erf2oJ1KdtAEoYkuNa9u8ud5mqOMq3Ha8vaoVDL8e/iSdWA8E4zlp71x3ah5QkKz6w3M3Sw340Feih672rtZZX8ZxieF000YDWYK5PrcgV0K8p6YkqcWjqgjTpIAlF26YAa3LbmDQV9T7jCunMxGJWUbuHF9T8GTaIXQTxUfHY1yr93IJbQI7MeeeHgiiOFPw2jyWe60UTTaQdCid5igG0ba2nfvTXiwWQPHepxGq2pOyU8b9wQLiPPQ719TjFIkBzA+00qV8Wej/EJCTiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztYrZrgByEbZLKo6GIU6mEa6ETSeEAHGEQUiSCtqNr4=;
 b=IXsK1+KjPvaODKjzDTBVm5I2RYvnAUM+q8nqSkbdgXTK8+X8rVhlaphZLXAs1D8OE6HO18Wes1BhPHbrw2G6jNHHlNbq/E6lnDZqfYqbGeieqiYwcBz0XTwFc31nzZhxNc235qtBDnyly5Yv/I+6yfSwJJTOmQgu8M9LLXpB5otL8r0rACDkNgoaWuWfJEUPgapW9a82ASxUPLcALP7YXrrAJxuqqpQ9j96z+sbZ+squUm9MDG8/vjefbO/sTSeRrzduL83JdXegqHq0EzmtlB7ztDPEBWzDQlp+shQPR/R/urCI1AyLifWZTa/9GXOJVXH4S4iNQbzrVOzal7rJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 18:24:16 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 18:24:16 +0000
Message-ID: <a1a0545e-730e-40bd-9935-8f5e3fc5dfb9@intel.com>
Date: Thu, 17 Sep 2026 11:24:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ice: fix empty PTYPE set for GTP RSS profiles" has been
 added to net-queue tree
To: Takeru Hayasaka <hayatake396@gmail.com>,
 <intel-wired-lan@lists.osuosl.org>, Marcin Szycik
 <marcin.szycik@linux.intel.com>, "Nowlin, Alexander"
 <alexander.nowlin@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>
References: <20260727225659.Cz3qz%anthony.l.nguyen@intel.com>
 <CADFiAcLvxVh=E9Esjh1fQBVqtu-t_=8hyTCW0_dfb2VTKiJ6=A@mail.gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CADFiAcLvxVh=E9Esjh1fQBVqtu-t_=8hyTCW0_dfb2VTKiJ6=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::17) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SN7PR11MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 043f5cb6-0819-4d97-e96e-08df14e8e1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 89YjQXqvF4RRGshlkLtEZjmskuwAYqqWBPcuwAlGXTLba5Kl0Xyv5fi6fsIuGPyzs9cuWRWo/8fd9kJIMPOr3JO7dspjhrTVLsKOTgQQKOqi0tCX35TBmJf02zAEWeiL+9+HC4dmIEyWS2maL7CUUN/pUxdarjwhbb7Q1EEcxEplUl3GZHy+QstJt8zdgsnTDGQvhLHIuG6UI4zGnGZw5WFcwDFxs+iMXm6SaLwpiObQg8PSX2M6j+Pjpvo9ru6dGsWYWoz6JnIWOnCHxcBMWruuYGwtoVLB5r4Xw9PXfAmc3tz1LWpkpMwi08jIAkrHsBhG6a1Ec6ZZN4hHVV43KKGMvOA9WpZPcbRp7KB1xkwzhZSWvkmibeLRHzVcGnpufynVlT6QqmxTKA8x021ZIp7KlEZd/ZYujhsinI86uxCIWeOdkX4h9V1n8mKS92d/8wV29i4hmi1HsPmUmMAW2RphGisHe6QJyuLpNWWeprkB0K7Eod8VhwsLIoRKXx96now21LtU4iNkhqjqk+0BetcvlmQ6A2EnQQ7+ea+erJgqBANN4ltkeIr9G98u/CeQBTeAt+I6uYQog4OCvpq5RHADD4skkLRpI3aZBZFWAlv7gNyw4jMPg5o/z+039J86G9KKgeBR3thYGrnn7qikNHMTEmlAmc40qlE1+GpH6MQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0gybXhWYkxoZFBOWDhWU2U4RDI4R3NYSGpLWHl2L0xKVzJKeDEvU0wzOXlX?=
 =?utf-8?B?dmhlRzFJcFI0YktnVERQcFNOeXRYZGhQdmV5UklnQjQ0OW1EZXp0dWlyWFhk?=
 =?utf-8?B?RGtNSWx6NEx4enRRVUZpTkx6SThxREYzbmNIWjlQMmNEWVRBTFFwRFdjN3JT?=
 =?utf-8?B?Vkl1MndyR3hkOUdmWUxWNXNQZ25kVjQvVFF6cnd6RHF0ZDVDazJzdmd0a0Nn?=
 =?utf-8?B?eWlBSm9aNTBucmU1dUwyVlpMWkE2QWpJczFwOVJENG9ER3hKYSs5bXVYanJ1?=
 =?utf-8?B?dHhzSy9ueEo3QWVsbjdmSGEvZ2RHQnFheE92cVFBVW5CSng0V2VQc2gydExU?=
 =?utf-8?B?L0JkNloyNkFZSE12enFvdkdkd3lQNllDb2xJL3J2UFhnejNxMTYzWjE4OHdW?=
 =?utf-8?B?dnp4TlpGTTFUK3hvRTh3VzRHYUdqOE55Z2pleFRJbEJKV3RzNktrMVJ1bDFZ?=
 =?utf-8?B?bW1HQS9sZGtySmt3TGNnb1liUk44Tk5vMVZZamN0TFJiWUR0WDFIVVBuQWJK?=
 =?utf-8?B?dXNkOUE2TTRIRktTYmo2UjNxRXpoZXZmM1ZrOXRMS0ZLR0x2Q0x3aXN4LzRO?=
 =?utf-8?B?dnJLNHQ3UWhzVlpDbS9tZDJEV2M4d0lYVkMxV2RKWXNWZHh0U2tOOGRPOURu?=
 =?utf-8?B?QkxRQ1VlbjlaK0xNbmwycTM1TjRObzVUaHduNU1TNmwvOWtLVzYydzFBM1Jo?=
 =?utf-8?B?bi9ad3MyWTRUM1RmdCtYdEtocFN3Y1MrYklYL2ZmSkwxQWVEcGRlYTlEODEy?=
 =?utf-8?B?VUJVVFhmeCt3MGN6REY4SU5hSjN2T0pJbkhFQVM2aGFMVzM3ODI0OERSc1gv?=
 =?utf-8?B?TlFtODJhSDlTSHROZVlHOXJFNExYSmdXOUo4bGdwM3BWbnplTlhzOEo5RTBR?=
 =?utf-8?B?N09WWXRzZVgwS2s4UEdObjB2d21TSGVBSmVUQUlXMWRuWnJrUkdkc1dqY0VU?=
 =?utf-8?B?SkpDWHYxU2RIL3dGR3QwWFpKcVhlWEptc2RyMGlOcnYzc05YdFhHS1MwbU9i?=
 =?utf-8?B?SThGTGthRS9CWWVxVk5BSi9MaXpONDRVREQ1TUxuQWJvZndNNDVPV1JJMWNO?=
 =?utf-8?B?WitGUno2aUdWejBDTm5pN2ZKbUJJaE5SVjNHeXk4YStTR3Boa0xSRG9TZWVp?=
 =?utf-8?B?V3poYm41VG9IbkNkVE5CSzNDWUg5L0pXc1E2TjA4aHJITFNTaUFxSjF2UVo1?=
 =?utf-8?B?Qlc2UlhDSUd4ajU3RzlIYllJSUFlZmpsWDJpam9vcjBCSWRpNk81VFpkM2kv?=
 =?utf-8?B?TkVKV0VuN0FmalM2MDd3Tk14UFJobUNabHlRV2IzNHpJSzZYaTU0QjZjYmkw?=
 =?utf-8?B?b29Pa3FqMi9FOG92RVNvZnVmbW9LRm00MHl6UHFqM2I4elFqUU9TNVRMUUlj?=
 =?utf-8?B?ZTRMMTlubkR6T01NWER5dG5Sc2ZYbXYyd1cxakcvSVNEK0ZvNE1SODlOVHZl?=
 =?utf-8?B?dStHdlR4YlhTS1FKZTBvQWpaV2o0U3Jid1VFVm5sb1lJNkNLMGU1MFovN29a?=
 =?utf-8?B?cGlsOWFrd1gxRzQrQ2JnWjhPUFYwWGNCWG9taCtKdTVOYzc2UTRiOW1PRllQ?=
 =?utf-8?B?cUErOVRKWGNtQ3FLMFp4L1dOV1U5MmUycmRRVFpEcUcxd3AzYzl3R2lqMW9E?=
 =?utf-8?B?OHlvUUpMdzZQYUFKbjJWZ291d2l3c1dRclF5eHlwbWEvWjRCcVlZNUtsUThN?=
 =?utf-8?B?ZzBsSUdGeHVPY2R5a1FlazYzdDNEK3dPVy9UZDFrdkgvaDlocTFLN01ZaURw?=
 =?utf-8?B?dFIwMnp5UHRrM3NkVU5rRk1maTNqUjU2YVBXTDJSSytCT0FNVjV0emxzWVF5?=
 =?utf-8?B?TGl5NTJsVnc0SEJRT05tYndVVDZTaVVrWFd3cFlYQXVjRHhYYjNkN21Ddldw?=
 =?utf-8?B?aUtYNjNSQlhWWjZnUGxESE56WTV6RWxWMDJVd2c5ZnZOQk8wVGprNHVnSTFJ?=
 =?utf-8?B?ZGt0aEtSRWNqWVBIcStXMWRORENvTnNkRUFubVBBaXp5Y2gwcm11czVsN2hw?=
 =?utf-8?B?M3ZIS05ZMm0xcGdFK2hEbG41alpXUFd5bTRTRXVnazZnSVd6QU43YnBHMjMx?=
 =?utf-8?B?T3lzN1ExZGxwcGtKSnFsMUlCUVhRSHo0eW1rWHA4b2Q4cWhidVZtRG1uTmxo?=
 =?utf-8?B?dVFpZWR6bjFOWHNndSsyOEM2aWtGRFFSdnEyZlFFS0JVQS9XMmdJZ3A1ZHRB?=
 =?utf-8?B?SGFkUWs3SGNzSHNBbUd3UkFKbWJBQ2EzMkdheWhTRFJOamtyUlcyZ3pVc25E?=
 =?utf-8?B?WTUrU2pSTEYwQkZLTHZwM0xsSVJwY29zcWtOT3RZRDliUUFWWEpsSmtLZlIy?=
 =?utf-8?B?R2t4MCtpamVMclA1eUdKekU3L3JDcEhnL05KU1RQeGlEUzNxMzhkMWJZMjk0?=
 =?utf-8?Q?7DZ6iGAdk72TysyI=3D?=
X-Exchange-RoutingPolicyChecked: DKRm73SHbwrmVpMcjRRrQ4z7RqqwRRdvVN6M68eaUk5XQYLo5ZqbFHvF+IxHRV55NbLEBC6e1B/9BU8rudMXIwPraoRAgFgCuP2gGTczpVgqxbUQ2BropDO0K91NQBxPiqftqSdg0mX0lo5GYSSnihfxxR6gNFMxMa85fZ9LS7odjW4SzrrQE50qJONZn7ItLms8wr1mhm81iiUCUfebUZX2KAoWSt3pSe3f8X0+CZoraw/MpY3mAqsXmXype8+ZjPExp/qlG/r+Hul5Vigx7s0Z8Onns398HtwlkWLX/fyzoZfnjyowykeWv0DyAOgabgjhotbcWxKTyCqTjXIcsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 043f5cb6-0819-4d97-e96e-08df14e8e1d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:24:16.4919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpfL3j2fjv/bFmkDJ8UmqGS7NDCUylUnv+lbwwanxXvEIZDmRI99/Wz/Q9YEjxW9brpnzKbetgj6ZEP4NcphufjlnM6NODUvgI6M6K62BOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
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



On 9/16/2026 6:13 PM, Takeru Hayasaka wrote:
> Hi all,
> 
> Gentle ping on this series, posted about a 2 month ago:
> https://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=513764
> 
> Please let me know if anything is needed from my side.

Hi Takeru,

Our validation came across an issue while testing this and we're still 
working on getting the scope of the problem. The display (ethtool -n) is 
not showing the expected fields; we're working to see if it's just the 
display or whether it is not programming it correctly as well.

Thanks,
Tony

> Thanks,
> Takeru

