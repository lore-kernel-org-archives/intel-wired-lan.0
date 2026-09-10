Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74483C88E42
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 21:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CD62811D8;
	Thu, 10 Sep 2026 21:11:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lg6dbkENniKc; Thu, 10 Sep 2026 21:11:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6344D811CD
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789074709;
	b=q2dx5X7iFW2pQTFZNzb7vSR7/LjqcITGeh/cUUbY+IbphuVVltslDlYm06ASyUtXi/hx
	 V7D1g/Ji3ESlLUexbtcD6gY5kO5HDvWVQJfVGy7gqTgIdxBZi/fTE4y7BYxPsiimMGiA1
	 Hs/3JrPto+gVKWeHWVvGFc18ILXXEfABopBFTm8eaagBc8otKhdjPOdezkaUzSNJuYRYk
	 WUx7sp0eCqtHIDZk9McL0gH2ZfMUsR5pFPYGAxawsIRgkBJXpYk9M3fdPIkjsGtWloRVb
	 8V3CLjEIaNTrBrXK64Fc0qf3TdeGf17rakVslKFYN+oRoiqbP7LgPAa3kOXYfeFu7Sg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789074709;
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
	bh=SOg7YicXcUWS3VpiAzszbBCFdSMxJlqzUAjIYpb9tpU=;
	b=tVMQN/XTFyPfgOhjKC/lHEjdNI+q27oC8re4B5gNfaUK8JRmvshsmYfC9xhWWtpHDvxA
	 aFE4RZwu+hGosOF2IwJm2TYMfUINWvRaRkO7RWxTSsuvIqw2Pv8sfEjF6Pk/VGuzy00mR
	 kM++qhLwoODOGAqNdkfHnnA7zv+fBecudLmBVAlDSbCA9g0DcB+Gpy7UHvkBxbsg0cfXI
	 w1CoJcgCSRVlzzbT/VS45HkrA8/5CJHvheQ4kSh1LqFne5pCWL+h71fSgzyQVaSIetlKu
	 LN37oCwgDibg7ufEdxK5EO7QqMJIehJ14i8Px03RzxcHPjku3Csp1k2m0YTzIs8qKqw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gdodx4f8;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789074709;
	bh=SOg7YicXcUWS3VpiAzszbBCFdSMxJlqzUAjIYpb9tpU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wDwmtk8kIHeC1LxKUI3OBxyt7Orj/WPa+CT9DGdhFXdlIiRkuF7ZCPoT93ZSWwQg9
	 Q1G24dupmybL3apONYGw7MLSPYlC+2DAL1BdQXq9mJVAbmWh6gt0iMfFvvzfPi+O8v
	 mCWknd3VL+fvuvz9YtlfpNs/aSjN3G8QOuu9F6GiGeLj422JoCbqIsy73yTmvsamcA
	 WRa5XhY66DDRAZEAMns/AM8g99Hq0V19oOancdDrGOPerb6qDJPbRGNu8DdLi/HczP
	 sIyIXB+25GTZFMJagHGL+KyoPA+sDtFNCaFmVaqRtQyTgt99hP4T+U9LA4ez5Yi1Ek
	 PsYJ6F9GTCW6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6344D811CD;
	Thu, 10 Sep 2026 21:11:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 590B7769
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 21:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E78A81125
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 21:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HLZQhvAgMCWY for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 21:11:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D8BEF811CF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789074706;
 b=AC5xKD+6bRCo9/8tq6B07KAH9OtL8Xr+MSamdtZZacxMS3UoDC32emCfYEykjf6oawDx
 Wr8SQvXqZINxr/bB2PkiKLm0J2PMWemvuXOYQYdnE1q5Yecm5rthyJf9OgDeIe74gevDX
 lxz21v41c8DZiXeA+1ZrOSX6r1gaG/t81A7e6TK3NGqYAM8pOXRt4ieMfEsHrxbeBqcap
 heU4028kJ/VvPstURPeSDq2kkRZmjWhoR+GqNSzZNHKMQfTZxAH/OHN0hsKzt2rVRgo1n
 whGEHiag7Q/vyMD4+P2Gp1zvr4yN59HD6YVaEKdEKIBpLDxGd48G/E8oN4rlB4zdrUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789074706;
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
 bh=SOg7YicXcUWS3VpiAzszbBCFdSMxJlqzUAjIYpb9tpU=;
 b=k7fQYQgNrcjd4pExtOwfYy/KJXIzidOhghHpC2IMTaAQC8Hz4RNoxTV2K9GiKWeESpoH
 dHmvtTiZQ8p9HbIvjT9/+pXvsCEK7BY/xH1IPacdybykA52fMLwFy+b3ziqD9mlHbomZX
 KlQ/+OAqtVOCXhnpTatjnQLeh4B4l/NZPK2JlA15zYs5YtZPKUKIghFkU8bf38poh1w0l
 jUZ6DWM1clq1er/Iyq+8AYA5d0s3/80pn7hwB7mhZx1YVUXvvUk7L7igW9GGZ2FskeE7+
 vkeBKTNDnFRZ6ahONgjoYW2xSgODAeuiudsDgbIEh+kCsu4xjF7Zd1rWJv5dBxYULYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gdodx4f8; 
 arc=fail smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gdodx4f8
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8BEF811CF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 21:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789074706; x=1820610706;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+OL7Cm6EG/gc67/iAubTN+mXKdDFT+sauIHl5hU7NJE=;
 b=gdodx4f8UJGv1jjFxwFyqWlMjtF8Zh2wLIpNwdOxgoCF5bSvwWN5r9I+
 6NnG268ev2CAv+uS9H8goLVi+piYbGuBMUEUiZtL5nPHdXDRZ2Odmv2At
 BrP1ag8682YEzW7H5DI5l8fp+sxhUfJVHGE0a8rItq8z+++0IkJpFwinp
 eSZ3Zaqf1zCUQhteErwXhJ6QiED2YDouwJP2fG7Uo5m9fI0Cr9IY45lsT
 HPvmUU6VpoF0TfNvT3u7hzcWBYkbFKdjYisCAsL2Odlto+1cW8XWcFgIH
 UCE0Iwkv5Qm4ukuaf8mk4iBfE3zFzBvx5pdWqJYYcXxXPa6jipb0Qxue5 w==;
X-CSE-ConnectionGUID: XRK0u02uQMCOCPzaxUt1+g==
X-CSE-MsgGUID: 74XZ+9WKTwGCYgD3kFdNgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89576068"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89576068"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 14:11:45 -0700
X-CSE-ConnectionGUID: ezz6vABgRvusKmMKdYO4SA==
X-CSE-MsgGUID: a+svewTnRqeQdgi5CKQfaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; d="scan'208";a="296728899"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 14:11:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 14:11:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 14:11:44 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 14:11:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YziUYaWEzfuu3EuieLw7BRAOXLOWXqH7xHRAybJXBu/HXt0gnv0+WJkBGVPGXbgefo9OO2ulZYGWsiO4kE6ZayiOj9nkfgmMfhhsvNWRLOARJry8NiJ2RZ0wyWLME2DocEG0QfxXaB+9Io6OW8Rx8PDU4LzgKpg5UE2MtYD+Fvk9UD5G+k8UJr3pZ32yahagjwY4l5lb2k99CGNUDeew+woI8mQHtMu2B4IhubD4/VEHR9VNoPHG5G2oXUjT4+JZZdCxyHd8ajbLxXA6390DzRKPHUDamkYjYeVRSgLUD8SucBebcz4e24q5a5WEO/X+AqnQ8vu3F1GULicWckFt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOg7YicXcUWS3VpiAzszbBCFdSMxJlqzUAjIYpb9tpU=;
 b=brrqVAGPJ1m6yRvr0n5rCXM/fPzKcgdb0V3Ogu8wiyxTfPySfbR10tVBiGtvFtxlxeXOWT0sfcCRBCe9aahNhq0iRdY+Zl9V58ivwgiIx4+PLBvt71a5i/MpO4XGEdB41pwwAVnqCLtfpYHHZe/YhQGGeHu0crN5RsmI4Im2lDcDCoCCzhzwjxvJ3Mj7rlFvMmhjaD2c+PSi8J/95sTW2OuHlT87m/usTt/tkYH6o2n/iAuZqYwz+vjCOdHHIuE3mQnExcSCKZ+3bFyIYFPADk6Fv83wPvuqduQd+sW/4axGOcY8tgNAmyQRrgywvZhCza4YvnBLiTz31PU9RHyB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by MW4PR11MB6713.namprd11.prod.outlook.com (2603:10b6:303:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 21:11:38 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 21:11:37 +0000
Message-ID: <aca8d358-7edc-4939-9e2e-10616fe4d1f6@intel.com>
Date: Thu, 10 Sep 2026 14:11:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ice: fix double dereference in TP_printk problems in
 ice_{rx,tx}_dim_template
To: Stefan Metzmacher <metze@samba.org>, <intel-wired-lan@lists.osuosl.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260907164810.1048081-1-metze@samba.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260907164810.1048081-1-metze@samba.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0229.namprd04.prod.outlook.com
 (2603:10b6:303:87::24) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|MW4PR11MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a3c23c-6272-48dd-d0fd-08df0f8019f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RgHYDSsnErBPAOy5WWwxIpef0+qDDcUcHqZK3IID4R8NZozFa/JYrkJbWrZwHa4RQoKnXqyONhJtAEbG8yOC4EEtLY8skk//KlifanZ4zLQjCupxjWf/o+OWK+/eB9E0UzYaimOtTJtP0DbnmhT3ZORfpYDqfVaAbulSwaMvbHEErRr7+YDCdjSyU5NDYlGoo+GqppMhOTLt7znnSepLdIZiGY8Yj57sX9oJR/oE8YhXNCOBYFHXwgJlA8fkwcywrXQMM6XcJ6KjgL+NlyDI12MyW/BZpHiF/+jYrbnUEc1Jj0IpL8rmeFrmaEMGcsBubXCNKPZ29Euiah5YYSn5qe79R6fJMtlkxyWIjmHJ6cE37CWR6PaS5jQR/t460TQlLQ7oJbacfBokEjv23ZocD4x+ErGBqsmjRLHcSOsum+XKZdFpE1l8dxCGwuqWILlHWOF1Q0lvd+in284lBTIhLXCrsUeTizTYG0yXjPvK1IzlTHWgSogh9h7CdHR3/jNyWO8oBd5mQC/bCSNhMx62UuFdu6SJ1v3TcbTWv+tlhMP152AlzbluMxmP+8ok6Lv7CHuX/ZvXJoAGHOGJiX+qIRm16tGrJOmZxSTnToFbBl5iwLXc0zJSS2GD2ACqrKaO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2NMczFrVW1hU2lVWkVNdW5EMGR2K2hNanNoeFowOGxwNGZNeHBYUWZNVjA0?=
 =?utf-8?B?UFNOSEMrZTNCUmJjTCtKZXU2NWo2M3NMMG5GL2kvelFGOUZETVdFWGxTVEdZ?=
 =?utf-8?B?N3dmMWJ2T2lDcnhwVm83MnQ5V3JTZnAzRzdaUnZyNUtoSHo0c1Z5citYQzJ4?=
 =?utf-8?B?aENBQ2FodmpkN0t1cEZqZU81OVB0K0wrby9VLzZhTHh5NkhZWkJLUlhZNEY3?=
 =?utf-8?B?VXpWbVJIdTJwRURCcExrak4rSGQ5Tjl2dmRZOTBYb00reHdWcDJ0ZHpIbWlO?=
 =?utf-8?B?U1lKV01uK1I3dDJ5TVZncU9XZGNTdmVyUDRSQ2lTbGdWRktqc25Gclk0V2t3?=
 =?utf-8?B?NFBMQnowc3AwVFo2T05TbFBZeDJyUXNHVDlnbVhmbXFhZWY1SkUyNUVkWW9U?=
 =?utf-8?B?bG1LYTlDcWZTMDU2U3crQlp2S3Q4Lzh3MFlpUTEyQ3FucU5uSDVyb0pZd0tU?=
 =?utf-8?B?VnN3WElNdFArcmZDVTN2TC8xRkhkVitqRkVDekZ5QVZxc25qWVRPNTQyc043?=
 =?utf-8?B?UVhlUU1manp3c3krM1YzaWZzbWhacWtkS0czU3RyenhsQXIvQmRJd0hKMmVO?=
 =?utf-8?B?UzExMVZwWlJWM2V1eFlPcnVKU3EzcmNRMFo3T0FpNGZyWS9lbDl0RzVPMXpR?=
 =?utf-8?B?VStKTm8vRjlRN0dnaG5DSmVpUWdBL0lmOTZ0a0cxQmhLMUg2Tm43L3VDODV3?=
 =?utf-8?B?R3plTW9TWDdTa044Sk9hSzc3L2VqOGd0b0o3SnhjRk5BeVNNbFJpNnFxR3B2?=
 =?utf-8?B?bHp3NVg0ZExkL016KzFSOGlmNTNQWVZJMnFqaGJ5VVhBUGcxRFRmNWU5WHJN?=
 =?utf-8?B?WUcxZGloOXN0S0JNMTE2ZStVV2h4NDN4aS95ZmYwZXVhOHZoMkdUWDVtMGQr?=
 =?utf-8?B?azJLcnRBaXJWdmJBZ3dZR0JVSjF0WERKd3U3QmFwcjJRU1hUeGJHQ0prTDI3?=
 =?utf-8?B?Rm5QQW5velhqTDY1TGdJSnlsQ1pTdmFwWnNRdkhSY2JKOFppSENKcHFKanRH?=
 =?utf-8?B?Q1JXU3N5enhtcUkyU1I1UlpCVklUZ0RnalpTWWx0YzE5dmdGQWNpdEppVHZu?=
 =?utf-8?B?T0pvc3ZNblJUQnkvRXNVaHRsczY3WlM2WEsxck15bTA5SmlabUtaUlBwaVJh?=
 =?utf-8?B?UmVnalZ4dTdNS0c1YmFiK0JBclBZWWpnOC9jb3FQN3VBbEc5UFc3NDQrQ2l1?=
 =?utf-8?B?VmJVcmo2c1NUMk53S3FCQU5ZN2ZVZ2NDM01oem9abGl4VWdHN1ZPNE1YdEdM?=
 =?utf-8?B?MktnTzhYNFdReTBVb1d2ME9DamV6ck8vYjdjWm9YdWlDeTUwc2cvd1FrR1dP?=
 =?utf-8?B?S2ZxbGFvbXpYWDVrU3Nqa3pNb2lQQk9BV0kwakdIRGRtbFZZd1Y3RkhIR1F5?=
 =?utf-8?B?U0NMVWhrZHZZQU5Nb0d6V0luUEM5K3VPUTlGU3pkMU1nM2k2ZVEzQU5wcXEy?=
 =?utf-8?B?VldZZDFpNCtSWFpuK0NBdEJlVVB4b3BRSUdCNWIvaVd6R0N1T0QvR3pFY2Jw?=
 =?utf-8?B?Vy9CQWlLY0t0YWtZU09qL0E3OHV2S0pRQW5lQkwxU0dydmlUSkxQdFoxek9i?=
 =?utf-8?B?NTk0aVFpcXZJNHFPaDR2ZFVrMWRmU0k4eU1VMkdtVGZ5VFJIclM4N2xFdVFs?=
 =?utf-8?B?SDdURUZVU25SR2RnY1QzenpvMzgzRmF6dmdRY1FnSzhwa240cjZaY0N0U3ZW?=
 =?utf-8?B?cGRRNVd3T00wenRDQUxBUVZ1MTNYNkFZMGsrR0FKMDZYeEt5NHNpZWYrdk5I?=
 =?utf-8?B?UEVxWGZFMGNuMGhYd2tOTHBZSGdydHhJdGRrc2xic003RGRKMWJzZzNNV0la?=
 =?utf-8?B?SFNsaHFrRzJZUmQ4U0xZMTJNUVhuOWdralJpYm5SVk0zaC9lMGxDK1I1Q0dv?=
 =?utf-8?B?N21XZkF2eGdVQUdqZkZvMy96NGdxMUlHSCt5WkxGM24veFdlS0ZkTlZhSS9Z?=
 =?utf-8?B?NjZLUmlxK3U3SmtUR2hjZXhVMGc3K2x3Uk1SaDkrNVdjQVE2cWZzVUxYelIw?=
 =?utf-8?B?NDFWQW9xM1dQNThPc2N0ak5XNlpsU2cyYXkyczgxSDdTNFZGME14L2s2VjhK?=
 =?utf-8?B?UGVOUTIvM1ZqaHNveVFtSHBJRHRWeG55ZXpWclVzT0lJd0hWTHBjRDdkUTlv?=
 =?utf-8?B?M24vdzAySm9VeHVIT2lhbHZmMDlEbW1WVXhYR2Q4Z3pjTXRLMzdGZDYrV1dW?=
 =?utf-8?B?RDkrL2ZXNlFBWU9wUjBzUFJYU3g0b0Z5NmVBUXhINXYveHpVQWU1WHJwbStj?=
 =?utf-8?B?b2N3U2hjdVl6QkwwY2drdU0wb1RCYmVnRjUxNkNHb3Exb01BTlpScWFBYm1E?=
 =?utf-8?B?UXplYjROSXBXYkwzSmRMaTh6MWJBdHRJRnpjRFVlNk1NNE8zYldwTEtQQ1Bz?=
 =?utf-8?Q?YKYcIeLkrwYzwrSI=3D?=
X-Exchange-RoutingPolicyChecked: LKjKwBGq9yyKde1dGWCr7AzHzvYK9aY6dV8HvuMSqaCil65BVkzCyHZ8yUYs3dOGF8O7LtusCf/Kcxk5EG9B5oPDb6D0LBzXPxcalXG73AkYUChynHiL8uXgopeOyUzfmsKR45qy6ea9r66WtO4H1UVsMM/mLnMoJVPLWhMo6zqIxQO3/NfKTmRazbgzzkAEGm+U6h4PLhaOluV6fo98wK6l+yvFAcxvoj9inSO2qdvtNYWyKm+8jfp0XMJ6/IJkrVAJlFpvnu12QV0Fo0Q4K5DKn204Lea3zndXfgogUF1k8Gj0US95XtDTG6GVdS5kYy4bBq3ooMBgUwzcuJhy8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a3c23c-6272-48dd-d0fd-08df0f8019f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 21:11:37.8333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gi0LtYg6rzUcYU31t75mzZJemAOjHpUp1KM8joHakQsW68IByR0mUK5SxK0NflCGaVQZVb7eWxjCrYrsnQ740cbU549j7GQ3rInP1MoVibE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6713
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



On 9/7/2026 9:48 AM, Stefan Metzmacher wrote:
> ice_tx_dim_work and ice_rx_dim_work generate the
> following: "has double dereference in TP_printk" errors:
> 
>   REC->q_vector->tx.tx_ring->q_index
>   REC->dim->state
>   REC->dim->profile_ix
>   REC->dim->tune_state
>   REC->dim->steps_right
>   REC->dim->steps_left
>   REC->dim->tired

Thanks for the patch Stefan but Jakub has already submitted a patch [1] 
that's en route to fix this.

Thanks,
Tony

[1] 
https://lore.kernel.org/intel-wired-lan/aqFp78nsYmT8gRDO@gmail.com/T/#ma04a6a8301063209e8eae383e31293953f4eba46 

> And the first one hits a WARN_ONCE()...
> 
> Fixes: 3089cf6d3caa ("ice: add tracepoints")
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>


