Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064CACC6B0F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 21:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8F9460681;
	Tue, 13 Oct 2026 21:51:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vb2DqTkDuGap; Tue, 13 Oct 2026 21:51:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC4B46089E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791928305;
	b=QnWvA3IJX26cHSfGOsBvt7nTeFOGHSdwC1PuOCqILq+myzBqUO2qRHdudyUKIyZ5B/gW
	 KawdBjBpWDtimyLM8ehMLJ8+pnq5n4ibPfdHA4MlsE4K7UzcJLVuSI3IBd99pKltCogSH
	 4oyRBLh7cEUePDEd3cfIEcQg21rRk6FUFxobKsLwuYHKHw1x+DjOnAkkfijkPhbzLBm3S
	 w82SWdBn1jSXeCB4UqIYvdTDUtP/ls+tsDW5NOqlwGyQyMwhmZz8FI2nzxrv2vdoG34M9
	 Gz/hOdQ+IzkFCHXdnH5Q8wCdRcoY2GQ7NaBDdpy+HS/WsflBgPmd+Ha97U1zSx1iKrA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791928305;
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
	bh=1N9+qFU+ap5aTSjAFexGzRyk1AAYrsJy6PZzHmZnfMc=;
	b=XCEQgoqdfPjveXk3Gyxgs0pwaAuOpJRqnWMYgxKJxyx41KEn69+iJeDRczIA8sY7yuZ/
	 BNgk49FLzBziAU1JlgIQGwD0ZF6aQA2sOB/lwPfq0gFwUS1glcLByGhf931h9o3vRFWWU
	 zC3tyBsStc/w80Puqz6uLObYItLlEHzUDQbKq5uMDZsdmUzr4Y7DL4+v8Fm0m0aP1DrVl
	 y7j9/mAQ01zrl4o4U9lw9REvZkkyw9pfK8/Bzj03ehCez2EEAt3QTS1l4giWc2UZnQ1cR
	 jZ5KKx4Ol2cC8A2XBIHoSrKl+1kpte419xPzY+iwx1P4NVTRlxC06fFkz0dQ8IoCfhw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791928304;
	bh=1N9+qFU+ap5aTSjAFexGzRyk1AAYrsJy6PZzHmZnfMc=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FrOazNUs8Oq5pcq3+JEwifAM9sP43t95yvDIfB49VYPOXVbvmW3OVNP86KghgyiuJ
	 S9gScGAutF4Wz/Jn+TVg79E2HVs+mn9VYbdxcVHdQW+qp5+hsnld0CH8fwVZQJBaHC
	 Z411QEYVlShma4N1zqZDjmX9VWgK2KIHJ+cNKES978PV00z+P47VbIp6o6LX0PV/79
	 GmXZt18lin43wtYDyiElC9RBT8c65jLeprbGXlmyShyYL8G0ZqXIazLxgT7x1QA3sn
	 eO1Eo1wIekAkLSWjlimhZ4QPVf2mzdbw6LFNU6api5+025SgMHuEPPl4jJY3OIAAWq
	 YNnTzjGe7EcSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC4B46089E;
	Tue, 13 Oct 2026 21:51:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 971A92AE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 21:51:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89436809F6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 21:51:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sTs1vjMKstLi for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 21:51:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4941D809EC
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791928302;
 b=GFU9UFOqFDC12B5YHJjbI2vscvSXvAiDgdDgY/nBj8R0tb9Ha4Xu7J2I4kbqLqr+ndy4
 a5tb1l045vXEt6gmYsgQLGw7oCUm5DLlln8XYc8LG1NnztF8EpLzSf1H1QEK8BQBqUxYj
 7/Y0/q3s0CuoWEkaNHpNx6GPwTkGWYmRVA0JUTDuZocLuzqKieuEU19S3NboSzKI/lErP
 0fLYQuQckMPgIT7XPb5G4O1put+waJbJwzvVDmqvC1O6FVTbOVn+anDc3QEyQN1coHC3l
 qyEAQf1Oj77FbG/DS7wwsjGs23ma5LeP2adx9CdKJhNU3YVtdXPcu8xYB5xyRo4/PJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791928302;
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
 bh=1N9+qFU+ap5aTSjAFexGzRyk1AAYrsJy6PZzHmZnfMc=;
 b=smBmT953mHiNWCYDGi0uQ4yaKbNnx4Kb+n2WaXN0dp3n7fHR8CH+k3TeyBnWe6kAlvQI
 Xzhy/YnaPxykWeLjf5chNMabhFK8ZbQqjOTq/tmn0WATgKyF9sH8NHb4/ea32Os+E+IK3
 oNKQkOlTx5bBhI5JV1wtUiQtC7fy+RMZvZbeNM6YOGmUXDFEnjUZ2tenVj4wPPHK9kthl
 JOsCfXvqjG4pH+XMb2hbzDXdKkZjMbY22p6wjaZsJHxeJZ0S+/Kj85TJV+5d8R7Jb/kHr
 lGdf+TlbJIAWKGCyhcgaHHAsJhW884qBWBtHEmt1Uq9G4cUymR07LpQZsy7aRyZ5Crw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KnBhMid6; 
 arc=fail smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KnBhMid6
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4941D809EC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791928303; x=1823464303;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=eZooBcaIxOjNh1B8j7nEk6C0RGPQ/+6B9iCtvhyzVjw=;
 b=KnBhMid6c0jYv5c9OAQuWqGCt4Vblyl5Ydsvsk6ZHuA0v1gPCvi2Fouf
 3+yoOTVOZsHjck/D8BbPX7crC4SyZvFhIMKoQTuaZRbbYgSi0GX2q+6Ui
 calPUiJtptBUt6WU3nF4nI/zT+bI2AWbX9fsZkZAHdyCShGvSYhSiUb1M
 JWcL1aPY/17l0SW8pVEl1GreeSArKAJg3LyFCXH0WmbosLm0zEGgjju/X
 mRYPmA1S/QSSfEUfKYXyqJDNu9BYTc1Rqe+/4tXBP49wmH18XlpHldZJ2
 Jd/dBhfZ4OuPAUGdOb1nu9gHnNx2vrA9ICI0Qop3pQN0OTuRWHbajyaq/ g==;
X-CSE-ConnectionGUID: fMzf4B9qTVOndUuJDCiiyg==
X-CSE-MsgGUID: 8Z64MPqfQzSxhS6WOVcljA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="675461"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="675461"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 14:51:39 -0700
X-CSE-ConnectionGUID: K44kLlu2R4iWTYQL82np9w==
X-CSE-MsgGUID: AyvQMovKSNSfiTmGuXPeJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1344198"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 14:51:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 14:51:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 14:51:38 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 14:51:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+JxItxWEZ+TmgPLXvhlVWg1XyWNGnR2+YjOJ1btmS98QW8rIakz4P8rrhP0dnWNG9sv62jySQnaeRPNy69UCKNf9guYmNvZFzCimoI1U090SKUrCvjMtPUoRNmQeKOPnut2QV7CDSrY5VnccX5sIBIvxmllLsV2wYK/uXhXHe75C/a0NkjN+f+2CYCBGDZV4WhhqR/Kah8shlzLb4H7Y97hWKGoWx7ThXCNG3eSFfsVdFf5/ZL9m0qWdT2V8C6UFkoPGHhj8jU2UBycHf6np9rUpBpLER0dm/6ADskE+EayjJCj2B0A9NuQ0GWBF/1WpTEwOMDkP6AU2EsFZXemSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1N9+qFU+ap5aTSjAFexGzRyk1AAYrsJy6PZzHmZnfMc=;
 b=RLefNkeqlnam2cB6vcFdU8QvPuqAJWlddFXmJRyHu448s8INdP1kozD5Uu8lgS/k70X2ggOf3vwTm9DJl8BUoKYjdLEV5RNL/ORXlXLu6uJCQEZXA8PNXErj0xGt8GfYW3c+IIygmU0iui6H+gE/mtE5g5KOHOGOBYqr9BTPScWDIy3LCsJITzGU3GG4mL9RmvivqG4BCgAV1UfmnB13GiJ1gvW2XHzyUUUJBh/gokjuCT3mi+9HggsRsVsuKB4xiv5kNWbQwrFd7zm8Q2t5kyOE4vjmopUZJxaxFJ8tLrvXjX1PO850xPW9INO66HSimpiMKvHtd98ZcmkP+8RZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SJ0PR11MB5893.namprd11.prod.outlook.com (2603:10b6:a03:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 21:51:35 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 21:51:35 +0000
Message-ID: <6ddf6d9f-6e97-4030-bad4-017ff1c456f1@intel.com>
Date: Tue, 13 Oct 2026 14:51:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 2/2] ice: reject partial NVM update on eRoT
 adapters
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
References: <20261008141418.958066-1-aleksandr.loktionov@intel.com>
 <20261008141418.958066-3-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20261008141418.958066-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0149.namprd04.prod.outlook.com
 (2603:10b6:303:84::34) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SJ0PR11MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c18df8-414f-4539-672a-08df297426e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|10067099003|18002099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Bxwgh6ug+uU7wxW311DY5/aAJuWve6MZlCXbRdgo4pQ5DePslqpTGmssa5YWQXKYcWSGygWOAGNdC045bkzzA/x1ExkjBg1MGNW5tNTj6NEI9NwdVxlifD8acDxBFJ2ZhcnjQuSS2JRYfjVF/ytKpG3beq4XBM/5QUSre8xpA8iZNJzHw9qRD5SvbPGPbsh7ITCFNjacez4RgmBxs25JMJV3JS4TWSIKChGwmkCpEBWVEgswKtaNCkU0EpUfu3ZtlXcPEH4y9CLuS7AjOQ2fmrwwPPb1VjxO/L3lWs9BUT3QOqLvlvqMg7DHbXQRNgN8mOHVcjFa138eVgQ/hrSCvyKj/CbpnPth7LHv5jWUmDRN7V8e9l3lNW5YfEdZpvI01J1g0KJG2iW2X6amnna7pD6ZqmjIVCToTAGCQZmJMEjPWtZAWkF1VvnWjnEvG3K19j+4WAvw8Eov6rmpiPWF9qZfUSEGkM/bqWCyltE7o5RkHjiOrl3atMoGgZLprLPc2rC3dJrz6rtp6SA5SbkzP+FOsOumAncNUFSg9eimZ5VPRcec9nRGTsyY98FXx49fm5HCJfwrofXPP0A4vJy69BIsagWcYHFEv7U36MF9HfF0NxbKqO/tSZJeujhYa9xC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VytCVDNEMzZINEdxbXRXL3JuS3Zxb1Z6QWFITFNMSEZ3SVQ2dC8yaWxhZ3Zh?=
 =?utf-8?B?TVpiS2UrR25xS3FLUjN3K3JrUTRHenpJanc0OVV0UG1aMEcyd21QWHNzbFln?=
 =?utf-8?B?TFhMTDZOUnBzVFVyaU5xR200SURzelVDVzVMQm1DWEVtT01JVlhPQVcvZi9Z?=
 =?utf-8?B?V0FCN01nemQ5b21mdW1idlIwMlRQdEFFdCtUQkNYdTFFQ2Z1NkVXU2ZNWWJM?=
 =?utf-8?B?TjNjRUlzRDRyN3ZIanRtQld6aHl6dXpqLzFKY3Nvam1RVVFlbmhyTkhHY3Jp?=
 =?utf-8?B?QnFMVnlqZ0RVNFBwVnFNbTZRWmRsSlFzVnpEdmNSaVJ4NkF0d0NoSFVNUVQr?=
 =?utf-8?B?QTJ0QnhqTnNIcUwreUlnbHk1NGZ2Y0s2LzRQbUhucFJoZzU5cStzTDM3b0Vj?=
 =?utf-8?B?dHQ5LzZTU04xekxyeERtVkF2TCs3cjhrbWR3b2Q2b1FxN0gzWEVLbktNc0dM?=
 =?utf-8?B?QUVTRHBBR2FPU0UzemJSOENXMGU0dGhKcC9yYXJyL01IVGhna0diSGsyQmg3?=
 =?utf-8?B?NndxWXBKZHAwcVdlOXdJNTNEVGhuVFVlcDFBc3prYjk0bk9SdHpoZVVMbCtD?=
 =?utf-8?B?Nzd4VFNRY0xKdVFmbmxYUmxvSUczaCsvZCs4OU9PbHBTQStlN3EzN084bGwx?=
 =?utf-8?B?SFlqK3dwV3RwcEN3SGtPM3BQY2ZCV2ZNNXpaYUFybmJldmlDNHVndkxLOXU4?=
 =?utf-8?B?WmRPRzFBNTg3ZXlnN0NHZTI4eXlEY1ZKN3BQNkJ4T2pOa21OZDI5bFBHYUl0?=
 =?utf-8?B?bkhXOEF2b05hRFVCVG1wWjhnRExzdVlrVHlpVUwrOWk3bml5Zkd5b01GV1VX?=
 =?utf-8?B?WFg4RHc0bDZNQ0RMaXhQMGh2bWEyZUFnVVExTFoyZk54Tm5xOTNNY3M2NGhF?=
 =?utf-8?B?WmdkYW8vRkI1dG0xN3pkL0NnQ1F2NXBRZ3l1RGkwUEpvVHF2MnJuTlZWcXgw?=
 =?utf-8?B?L080TFlkWnY4TldncXZhREo0enpYZTd5ZjlwRGQ2VU92Q2pHVTVDbjl1dVZi?=
 =?utf-8?B?N2d1SFlmNmZuSDB6aURRNkZLaEV2akF5eUxzSE5vUDhTcTJXQzI1Yzg2akJK?=
 =?utf-8?B?Q0tyeElvei9wQnh6ZXgwVGxRNmVwUlBtSVAvK1Q1UzBLcmx0TU9DcHlRaTBY?=
 =?utf-8?B?YmdLY25xbHpSbTZNSzF4dVJXV0E1UWpvZ0RzRUlSYk9jUFFjY0phQ09mS1Ax?=
 =?utf-8?B?N3Z1TGp4UENmK1ZFNmdZcHJDdW5CV3E0MUdoUG5ObDVrbmt5MWRuOFlNdkFX?=
 =?utf-8?B?Z29uS1ArYzNNdGVJb0dZZ3l6a2ZCMi9FV0dFL3U3VGRVa1RNa3NoRFk3WkFV?=
 =?utf-8?B?cGIxclVxdWVXdHBVNFc3YStWbVE0N202RFN4Y0dibng5MFpFR2RUR1dYZEJl?=
 =?utf-8?B?MmhNc2RaQnAvbklxYXdDVlFRTlNhRE9ITEF0UG56ZnovaXJYS3NTUDBvNlF3?=
 =?utf-8?B?WDVxbldLY3YxQ1I3YnlaQnI4VVNWL25wdGdpNU1IbXZBSG5XazRpMVVVUDlU?=
 =?utf-8?B?ZzVrT1NPZ2FLcG5hSml0MEdrS0lwZU9xdWlIKzVyT0ZLa09wYTg4N215blhx?=
 =?utf-8?B?WEZiUTQvS1lmdXk4cVZGRjNyM011YUFJTCs1dUxvS2lMNENRL2p3ZG5mbFV1?=
 =?utf-8?B?T1B4R0pURC9YQ2V0WjJra1JpemlneEcrZFdQbGd1Q2pZUjZOb2tHcmNPWk03?=
 =?utf-8?B?ditRT25ldm9STWFlc2M3UmZqQk5oY3IxUjd0d1hwVUZPcVVkS0ZOeU42KzNW?=
 =?utf-8?B?ZGhmbkhXUlFubTVDNVF5UXFML1d0blVEVG84ZzlXTXdwUjV1ekYvK09xQW1P?=
 =?utf-8?B?N3MrMzFka1ZpZ3h2cm01cFRFVGgrd0huSXNWbFJWMnhBWTY5VmFXazJxcWNQ?=
 =?utf-8?B?R2h6TU5HeTd1SWZuNHppWGtsaFQwU0wyd3hMREd5TFJEZm9QbHZYV1dWNllJ?=
 =?utf-8?B?ZEppZy9LMWkyZmRFRGg1VHc4RDczMjVFQzJFdTl2REZDNi9ta0kvZnZSam1w?=
 =?utf-8?B?UU50Y1U0b3o3YXNyelkrWnNlL0ZyNlJQUXZ5WFJYemVXN0xwek83Zkl1N0RD?=
 =?utf-8?B?Mkc3M2czQnRSZldqS0YxRU5GaFRYaWROMCtDbDhpY2pYNEZmSk5NcjBEZ1JS?=
 =?utf-8?B?eGxaMFJtSkQ4UStjczBsZmM3Vk5pOU5kWDhqRFp4Z3dqRG1rcDJmeDZqMFcv?=
 =?utf-8?B?YTYrc20rMkhVVGpneUFPSTNEQW5tYnBYNUlrRjdyK2JRYlp0a1IxaDcyeEJP?=
 =?utf-8?B?MHFSTEp1c2pySExqa3BrdHN0WWR4NlN4WFFvTjA1OU1heTE3VUh4NHE0Rm9x?=
 =?utf-8?B?LytrRlpVMitMUnh0c2lPNU1DT3ZhUHppZXd3aFgzNzZ1U0FjT2tocGQ3YSto?=
 =?utf-8?Q?hFx1C9+DZ7xrOB3M=3D?=
X-Exchange-RoutingPolicyChecked: L4PI5p9fKhy8rsjMxwRIelZcFtQ+z4ZcNwgxM/PEtRHDlLnC7lCQaZ0v4Oa8vYcrsqZhk2XHyRYlkY4ynJWCe94Pm6qNFjMBXOTwjl9EsdJL7r2EpFfFq8lXpz8GWi2I78KVREOagVPm28iXE2R/zrKsCa1z0+Pcyx41ae7NmmuaD/2b3s4sR7lUt8fwuMbSj3KAuQyE2IKBcGUzCNRZkR3ZzSC5ci8y2ckyh7C5mvjmqIkkf3kJksSt62P1UpmUweiimRF4jzr3XGF55jSmNEqixAy05tvLTVDFXYARyUvxDerXbwZWdx4E0gLp0qhPbxY6OT5C67obRbiW9ongEg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c18df8-414f-4539-672a-08df297426e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:51:35.7461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRlXxti20aE66qlRoXN4z+R18wRCjtWL6WkEKvhYClh9qDD7i/L+wC9FAe7u88wvbO3XgtgzPKSpLLPj18RV4O6w8NrgeTW1C1tjigabAIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
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



On 10/8/2026 7:14 AM, Aleksandr Loktionov wrote:

...

> @@ -220,12 +232,27 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
>   	struct ice_pf *pf = priv->pf;
>   	struct ice_hw *hw = &pf->hw;
>   	size_t length;
> +	u8 comp_bit;
>   	int status;
>   
>   	switch (component->identifier) {
>   	case NVM_COMP_ID_OROM:
> +		comp_bit = ICE_FWU_COMP_OROM;
> +		break;
>   	case NVM_COMP_ID_NVM:
> +		comp_bit = ICE_FWU_COMP_NVM;
> +		break;
>   	case NVM_COMP_ID_NETLIST:
> +		comp_bit = ICE_FWU_COMP_NETLIST;
> +		break;
> +	case NVM_COMP_ID_MANIFEST:
> +		if (!priv->erot_present) {
> +			dev_err(dev, "Manifest component is not supported on adapters without eRoT\n");
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Manifest component is not supported on adapters without eRoT");

Hi Alex,

I don't think this should be reported to both:

"
A number of driver configuration interfaces pass a Netlink extended ACK 
(extack) object to the driver (either directly as an argument or as a 
member of a parameter struct). The drivers should try to report most 
errors via the extack object. System level exceptions, indicating that 
system or device is misbehaving or is in bad state, should continue to 
be reported to system logs.

Messages should be passed either via extack or to system logs. Drivers 
should not try to report the same information to both.
"
https://docs.kernel.org/networking/driver.html#error-message-reporting

> +			return -EOPNOTSUPP;
> +		}
> +		comp_bit = ICE_FWU_COMP_MANIFEST;
>   		break;
>   	default:
>   		dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",

...

> @@ -1013,12 +1067,37 @@ int ice_devlink_flash_update(struct devlink *devlink,
>   		return -EOPNOTSUPP;
>   	}
>   
> -	if (!hw->dev_caps.common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
> +	struct ice_hw_dev_caps *dev_caps __free(kfree) =
> +		kzalloc_obj(*dev_caps);

__free() is marked as deprecated by netdev now so we should probably 
avoid it if we can. Also, this is missing the separating newline for 
declarations.

Thanks,
Tony

> +	if (!dev_caps)
> +		return -ENOMEM;
> +



