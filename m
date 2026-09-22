Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74BDC982F1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 10:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 780F3605D3;
	Tue, 22 Sep 2026 10:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HeQpDtN9v-wB; Tue, 22 Sep 2026 10:57:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 28FA6605DA
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790074643;
	b=YJ9blq0bhbcZQcrHBDUwcb7pe2wDEt9JNsqyA0BEHiAtvbyRXOvZyGVQpRO3YfStM4Ok
	 nLslygxgsJCkQT/YJcM7apCpEEJJjsCXObCwV75+xQmJVNeEgpfXBX9ngTVvsq83nvcrf
	 GEQyHrKXEyMKQRlfbvdH6ftdDvjKH5BGFPdRJ8w3QRP30oRs3BmUWM3Qg7CfTbJDF20Qy
	 CVOEufESA+7jopNnHqfh4mY8JI+M+g7HjwqAR8a41LVR3tV/c4FB34fdS6zNbrPxggbGf
	 ul4lZHoBMy17QnUD0mtaGGDuLN9sepUNvLoMryNi9FeJQyviyFebjgGfTXzVJ8pORjQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790074643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=Eqa6Vl3R8Sx8qmvFyl4XhN6a8fv8PmP0iLkutwixXPE=;
	b=tZWdVDf6+wocEewmvtVphzQpUyivKf6E4CMN+OCEUXmiiS1V2LkeR3WSH/K8zsLkUTPV
	 k3u5R5s+n/xuThuVfu9E4lFO8jngNKAHS3MBbsJ9Y1rrS4fGd/+tyOlDsZ7/J641Y5t1L
	 LswKuPWnyfNCTOJtAAFNs26ajFI2ItqR5ZQ1fWZ6A2ZF7NX69jLXDsd78/86nqRxOFK+U
	 cvWROQmMw8pLjFAzN6gpjKpY5+/QWg3tNxUbIa49lEn2jgw/k5Z94KEOlq36QSvxBWXoU
	 mcM0tMKG04rBWpx4LJ6zRU3ZX6FdEBg3OWgddjfpUn9HNwTmjfNYS0TVE4bbPAUIFlA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790074643;
	bh=Eqa6Vl3R8Sx8qmvFyl4XhN6a8fv8PmP0iLkutwixXPE=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WuOvEVbvtw8M0q3BTgnxhiI3ynopWrctvD/oUhqhWQ/N67x0KhF9AoesH2G6oN/DC
	 3AfwEZRmOVaGp7iz6aIuxHDITuwG4SGjljwXGCs6AjDtw7jfnxP5Urc0+k4RbMoB8D
	 xAW7N3LNlTXpY1+wSTg+1mYo8UOBhz+1XcMmqvlEeOpkNnl4u6yypht4m2MSKbKjbx
	 WzXNr4bpZYklu4J5uhc3YcINwEsQ8SgwwFLZHev3Lkk/pnW7iIJEqIAuVv82rUGC2w
	 XFqLj94bagWwV5IaFveqCaCwSl9B78Lb2SCP6iDWHcEMlMyE/ZKPKAHblJEbmu6qLJ
	 fxKdo44B3duDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28FA6605DA;
	Tue, 22 Sep 2026 10:57:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1073313B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 10:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA9F2405C2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 10:57:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0P_zyuyiocfi for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 10:57:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DF7F540599
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790074641;
 b=H+SVGnjbmNsk8IvwBPopl0Aktakf9DK4FapkjPgDLrPtMRC8eos3m1Qv4aYcvLcE5IKW
 rON1X9t4+jtmjiQpvsR0g5QiSjPiORXXFJNtgy2p9hIDT7UvtAlBeAIl0MexxOf9yUQWN
 /zMWUu8mACoF8zwz3E6abJhRWQfAcFNv5+gzSQwaSubOgbMFk0ns/MhMt4Lo9ak+jdmPr
 V5KMrAbkZJ5Nia4XG66E8KsmHwbIuCu5AU8qPzF4DwB1R14VQgNtJz0HOmHWADbm5EQHv
 XDrIihL31P+AjucYsxnr7zmgdhFzLI2pHLY+l2Ija6XzCjEdtztHxwhAso4MXlMlTRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790074641;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:
 References:From:Content-Language:In-Reply-To:Content-Type:
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
 bh=Eqa6Vl3R8Sx8qmvFyl4XhN6a8fv8PmP0iLkutwixXPE=;
 b=P5yzbn93QS395+H/p0Ci2+P1j3sD0XJr7kus9KHW3yJPvWSMvy5VMuXhZVwYSZbmbG4B
 +T7hSCiUIhucYZ5MzC6Ry5zI5E6bvG9EAbjyDUP5IYi04k0jVbea2nqy+ggomCszg/D19
 W08B8vRLHZmBdbKLnSf4u4uylil7zKuMZB0Xde3/WdMmuV+Itx4DtIl/lbg749SaR1F1E
 t98xqqkwOUsZWIDT6ZJmothf/zaZR91DiePBeYnX2qv48uImjcfGma+vHuUeNDdXzr/kI
 BntQ5Ln4DRPGZZaTzyMj5rlqxQVaNanbs+sYyRbjDnK+B7aJr0eqCJkZdKOSZun1oEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hoUshfPs; 
 arc=fail smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hoUshfPs
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF7F540599
 for <intel-wired-lan@osuosl.org>; Tue, 22 Sep 2026 10:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790074641; x=1821610641;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=K1qzp5shanzvLM3O3wMElmD8ODRR6IEczretrllINtw=;
 b=hoUshfPsnvCmw35cgUKnghu2UrD0kJWGYiVQgsksex1Q+aiBA6HPAXGs
 uOwqQrh71uBGUer8bnUqwNS5TU4qSJ9KyF3KJTkJK7k8ij+aEKIRoobrw
 TZTrYFv2WNGH2BfU3M/cbl1W83u+GqQVqu1i3clOpyLG6fPcBi1+3gH5h
 xCxpH4RGnscp1MuzT9txkPI57otPNK2/w6FPpw0wjFtCAO2A4ePP882Yd
 h11nCuWPr7vpLCuIs/wDrV0MornPXaIcljy0VdspkGePHO5vVDFqx1cx9
 vuJwKXC4Jv3tIvuEQsNzzRkH6rRDBXuEQhj3ZstXf8HNM5IcDgLB0bN/g Q==;
X-CSE-ConnectionGUID: CGNL2WFGQIWvhT87E56ONw==
X-CSE-MsgGUID: 230jOgUJRVOjiA168oCOIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="94496905"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="94496905"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:57:20 -0700
X-CSE-ConnectionGUID: C7b1mzrnSnKhu8sLuLnPwg==
X-CSE-MsgGUID: +lsZg8fDR5i1RLRQefN8EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299320042"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:57:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 03:57:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 03:57:19 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 03:57:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkCGDTbJxxzeHN60W3GMYPm2hs6G2jZQ4797RfajDL7fguhBBLfmnqpuefKpk2OR3P9XgFm63xlUnTigeBiEoWplbg6HaWeD3lgKG7oG1ozC6xwygPnBEC4Um5UecgytP8yfd5XOgfIgc3TlTU/fVg/AH/ZxJgqoL66mF5LX+ckLkb4HyylIOy2v+RMnCHpJnU68pf3aB5B33/XLeKO8tW4JMIU4ogaxUTa7t+ZzY8GIGxCKsBBuCMv8cbKgJXsD5uJHA0mPvocgskrwCn38MbJeO5AZ6d2clrEKtbviHvp7es8HVoHn2TRrfk90onKRkL/7kjkg79gEFZMOIq9a+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqa6Vl3R8Sx8qmvFyl4XhN6a8fv8PmP0iLkutwixXPE=;
 b=hF5zMKsuJrrXbz8ZU9G9UPuudcqZeLKjr8s562IpOxMK2FiQNG3QQ+U+aHCLeS7wD4AWpjzcf1DZSJnG2Tnw7j0xL2XWAfWNd3liA0S+t8LXIXt43Zv9DbnbSXEiFO7kQ/6I9mvg85hYcENkU5QrEuLrH8BvhQSKFKCWH8W94EVFnEmmm3kjolvehl+kwe1I5SZmSLqZAtI6FJQH4hgBwPbCPyJ4m/6NuEzHO+C6/MnKY8+S1ACsDNwlCnxfHy97E9oZhm09FkcV/3ilRk4qBIy6OGDbt1ZF4AG8Dsim/Lkp6iNG1f5f0K1JKbrp3jiAo3SdUtYJdJdjU90o4WCZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 10:57:16 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 10:57:16 +0000
Message-ID: <0deef257-4468-40fa-b83e-4a3a05474f8c@intel.com>
Date: Tue, 22 Sep 2026 12:59:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-net, v1] igc: Fix typo in IGC_NO_QUEUE macro definition
To: Sasha Neftin <sashaneftin@gmail.com>, <intel-wired-lan@osuosl.org>
References: <20260922103434.55912-1-sashaneftin@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260922103434.55912-1-sashaneftin@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|BL1PR11MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: 1241368e-3b6d-4d18-212f-08df189843d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UszsuVhVTyDs8Sn5jyqMp4QXk06mnWpypdq1oPItAzv8dNehyzTCadboakt9rOeGTiz0HGAApNGZAIeBgSpRmo9R5mcZ+S1eEKoZ83WusRlz6pcmkZnzV+psVxjHqEibVXZK3d64x1KFXDq70Ut1Q+8J6sMOYC1WNXjbIs95YMOtCXHH20Bevn/FgVAONXcBYNcGXBpLTMM7Osz9FdCmC1H6tQJU3lSOmZz2/WdhCpX8rqGjhlMU0ZLR3XskkR9tt6jfa6f3umM5w+CW4EbBcUZ1NUjeJ/VYe4i/4ey5shks5MH1yLvjXnrB8ymD9fQf/1cN/PFD9QCzEF0WoxQIOjjHtNzpNOm7ba5fAuqTPDIp6TzFDd63RwzsLrU5CDVvHtPoh/bJWn0IytVkKE6dfdSiUgaQcIexr8bEGUtTwHCX06+ybzzuCURFHyKMMI0o8ipvnUL7VDeb8de1aY6mS5Vf0YaDpoQ4z8eRISZkqIZTcpvQKwDj0AG9yBBUphyLTXkypxjd0MU2qlQU77som3cpq293Yt9DxdoTY/7jFb1yNz8eDcPEur6I6HT55Y26zWhBZQLT/DEo9N/ofaTN6UgBO/f+1Drbq+tYFfHu5Gfalxhzi6lePsQgI0PU0FVg6i/NfiVlgxgi/GsKsR7UJdc/YcXMlJ/2y5vo1NjxsPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1FtMTNpL1pHUkZ6dEVaRytxYkNCbW15elJXamRETFdCTVRvYTZLb2hTc0xP?=
 =?utf-8?B?SCtxSHBhY2hNNWFYRHp3WnJZYlgwZDZRSXNYbmxVQTFwNnVxU1pXcURBd1lV?=
 =?utf-8?B?eEVUYUNpamlBc0xjZ1NGaktFUnRxdGVROGphUSt2WHNIaW9JSmZqY0w4R0lu?=
 =?utf-8?B?dFJvb1JaMGY4eDRKMDN4djNTTlNtS3FvaS9IYVFqOUxCTlpuZTNpS0FOTDRx?=
 =?utf-8?B?TjZMRXBMM0ZSdkRLam52MjVCOHoxbC9YY3M0Y25FbDRvTmRjaFhPODk2Vk1G?=
 =?utf-8?B?OVVjeFViVUF2RnhXTjdBaVEvbC95VGRZc0Vrai8xZGdrRW1waDZtYUcrLzNo?=
 =?utf-8?B?SXJRWkhTYnRJc3dxMWdYR3d2cE81b3BIdGN6eFBnRWRBdGVvVVdrbmpQQWI4?=
 =?utf-8?B?VUpsRTBmdC9pTERpSmdXdkRhd1NkRWFuOGhZR1JXcWs5d0o4WVRoSGRRN3Er?=
 =?utf-8?B?OHpUbEw2Wi9sMjV5ZWIzc1BkTWx6U29jRit4eUtJR20rZ28yQ1hPaWJWandM?=
 =?utf-8?B?WmROR0pKTUcwUjAyL01XRnhjKzFFTitrbk9ldDJLcnpDRStlMnoyTUN6YnRk?=
 =?utf-8?B?MDFQVHoweEp4Sk9vVkdkVlg3VUoyc045RWovUzdrVk15dGVoK3BCOE1lK0NZ?=
 =?utf-8?B?b3RUQk1qWnVCZ0U0dFBLRlNTVUtydVZHc3o1R1lrY0RFcGVzTXRnOXFlRGUx?=
 =?utf-8?B?aEExM2VYWGg0Ujllb1V6UlRPRnJDKzBEWTlpdk91cFNsbHVaYkpCaVlLUkJ3?=
 =?utf-8?B?NUJaQlhkczVPL2lXNFJUZ3Yzdm1OTFliMkIvRXg1NlVTQUZONnNSWUwxdThl?=
 =?utf-8?B?dllFOXpraXorVTIxK0lSV1JzaDhlSFo2V3Izdms0VEhXVGppZmFTNmdTWjVR?=
 =?utf-8?B?dGw3Q1o0NWdLUzdrNDFPdVJpZEVSbzRDN3ZJRUtGYzNweFRYQ2Z4NUJHWUNX?=
 =?utf-8?B?Y3RKa08rOXpvdys1MUk2VnBDQ1V0MU9UVEdaZjJQR3k0MEozSzRIRzh3dEEw?=
 =?utf-8?B?UURablRqa2JaanBacUxZU3lHa0xuTzk4MXRQcFNYdTN0V0Q2WjVIaHRHRFNs?=
 =?utf-8?B?ZXVHd2QxVW50Y2RCN2FZb3pmMTBHUDdYMXRabElFSUhDZVZqeGpVTWJxbkZh?=
 =?utf-8?B?WGVnN3dvNXl6dER4MGlyZ0FaUzBodGNGZmVWT05kcFFZbFBmWTlUdFMxNTVB?=
 =?utf-8?B?M1FweEM3QkVZQzVTQWhWSmhvS0ttMHFXVmpTa1Y3a2Zkd3lKcXltSjZDSm5T?=
 =?utf-8?B?dmVxSENxeFlKRHZST25CdXY5ckxMOHRRUlRqM1dFdnBjdUIwcUcya1p6U0w1?=
 =?utf-8?B?VS9qeXh1Mk1wQ2ZkeFN5R29JdGlKK25ac2M1UWpFUGxkTG9EQ3dCRlR1NmQv?=
 =?utf-8?B?NEVpTWM5MjJKdXpqaVpuQWpKM1lNN3BFMFN6Ujc4VWNBU3d2RlUzVXlPWCt4?=
 =?utf-8?B?QkxUTFBaekY5SStBS2JuTDV0WjZsbHh3WjJRb1BhQnhlc3k5VU9XYkFKNUJu?=
 =?utf-8?B?ZHJ6QmJxZVN0UUttRlBLaWJ5aTJtVVg1a3BJY2x3cmFIUFdXTXpiRUtGYWV3?=
 =?utf-8?B?bm11U0ZHaS9xcjVnU05NUEp1TVNucUxoSm5BMVpXR2Roc3gwK2lKdWppOTEz?=
 =?utf-8?B?djUyYlFzOUEwaGozOUtQYnhXUDNmV2F0UiszTDZ2ZGN4TlUrTCtHbVNia05C?=
 =?utf-8?B?VVEzSlBMdDZadzZOZ3k3U2NhMnRYbDJ4Vk1BUlNMME9tNVlIcGNQRHVCL2Nu?=
 =?utf-8?B?eUhUNjJLQ2UxQnJjL3dWdzkxR1NBeWVGUmpHY2h2T2lVNXdVY0lOZUxEaDBX?=
 =?utf-8?B?R0tFUEl4V0RDaTZyRFpVOUtIZ2lJUHZwQnc5bWdZQ0ZxT3pSVFhUYWdLeE1C?=
 =?utf-8?B?NE1pYU00TnByNWRLZ29XeXAzSmQ0Z2NoQXhlNzJjNmY2NDFxbEtzT0cwb3dW?=
 =?utf-8?B?Y2VaMDJaNjZROU1HYnp6UDl1QjhsUWNUdjZBSjdielk1Snk4WjBPUVB0VHVz?=
 =?utf-8?B?VWJhZ0RZUEdzcVgvT0swQS9hd3Biek5ZL2Z5RnRKTkI3YzV2UWNFbkVIWFV1?=
 =?utf-8?B?M2NCRkNML2tDQnZTY3Y1TzJaeHJPOGNXOHdZYjBMbk1CQWwrVTlNaFFFV2pK?=
 =?utf-8?B?VzBZTUNhZHJmTXRYOXpPY3NubVlRUWpKWXVkTkYraFM0clg5MzZyR1VRdklz?=
 =?utf-8?B?dEdoblRHQURMNXBTTlpGYzV1bDc0QTl2WEk1N1V3OUE5N3NYMGVGcSsxcmx4?=
 =?utf-8?B?WGJTUC93VGUyNVdVRGZqUkpPcUlLdU10d2EzYlEyZDVSUFRhN0xUcG1LVFNT?=
 =?utf-8?B?bHZCUFZ5ZFZ5U2VUVHBzdVFoV0hwVDBqVUVqRlV6MlVyemZlNnA3ZEcxSWFw?=
 =?utf-8?Q?c1MLHjdPuRiVx4NM=3D?=
X-Exchange-RoutingPolicyChecked: lY+ODWlYIl2r3l9svOpDz7G7BsboWYNWzODG699f5QO48zyMH61TyZzeF94J6LuskTBlCDy8snS5Qfm0dO71apOB6Eo6X7VgNkgsZgvrSfvMqpncNiIDLpbHZmyW9HgLaqLpf7Cz1LrSr09won4Z5cbLb5Ct84fPNadjChcRD9P3jZhZKTqBbqYdW8Co5l9r2KGyPJdhF3pHBqZQhKz079JmvpCZqwrtZ339yGIWfEGMvVenYqw+V5d0+Pj01sw9R2hRnynJjj243c0Glil7XiwTpMWzopUbHsPNl+1rwS0xjEKUbzmD58g0F+ra365I+VxleI8/z+a7lXRLBRrxOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1241368e-3b6d-4d18-212f-08df189843d7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:57:16.4223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoLNwd8aD0DQxfBlU5x8c2aSjoz60fDd1wLNrHLpn2caXuEffLiFrSeRHAxSJG3AMgbatOqsOwHpmUF9AdLYFEaeDznEyKDATJRpSawlDEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5271
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

On 9/22/26 12:34 PM, Sasha Neftin wrote:
> Correct the macro name from IGC_N0_QUEUE (using digit '0') to
> IGC_NO_QUEUE (using letter 'O') in igc_defines.h and update its
> usage in igc_main.c.
> 
> Fixes: 16ecd8d9af26 ("igc: Remove the obsolete workaround")
> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>

thank you,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>   drivers/net/ethernet/intel/igc/igc_main.c    | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 3f504751c2d9..ab55b88d4d96 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -721,7 +721,7 @@
>   #define IGC_LP_EEE_1000BT_MASK	BIT(2)
>   #define IGC_LP_EEE_100BT_MASK	BIT(1)
>   
> -#define IGC_N0_QUEUE		-1
> +#define IGC_NO_QUEUE		-1
>   
>   #define IGC_MAX_MAC_HDR_LEN	127
>   #define IGC_MAX_NETWORK_HDR_LEN	511
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c..ba75350291f5 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -4223,8 +4223,8 @@ static void igc_assign_vector(struct igc_q_vector *q_vector, int msix_vector)
>   {
>   	struct igc_adapter *adapter = q_vector->adapter;
>   	struct igc_hw *hw = &adapter->hw;
> -	int rx_queue = IGC_N0_QUEUE;
> -	int tx_queue = IGC_N0_QUEUE;
> +	int rx_queue = IGC_NO_QUEUE;
> +	int tx_queue = IGC_NO_QUEUE;
>   
>   	if (q_vector->rx.ring)
>   		rx_queue = q_vector->rx.ring->reg_idx;
> @@ -4233,11 +4233,11 @@ static void igc_assign_vector(struct igc_q_vector *q_vector, int msix_vector)
>   
>   	switch (hw->mac.type) {
>   	case igc_i225:
> -		if (rx_queue > IGC_N0_QUEUE)
> +		if (rx_queue > IGC_NO_QUEUE)
>   			igc_write_ivar(hw, msix_vector,
>   				       rx_queue >> 1,
>   				       (rx_queue & 0x1) << 4);
> -		if (tx_queue > IGC_N0_QUEUE)
> +		if (tx_queue > IGC_NO_QUEUE)
>   			igc_write_ivar(hw, msix_vector,
>   				       tx_queue >> 1,
>   				       ((tx_queue & 0x1) << 4) + 8);

