Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7BFCCF2E3
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 14:31:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7082A80DF6;
	Mon, 19 Oct 2026 14:31:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26i1baBT1REl; Mon, 19 Oct 2026 14:31:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E246980DB4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792420308;
	b=ELflbaTzwQJ9zdn43ivzeR1slh+F5uebLybpVj8zAWYcadgm0XI8lptKoGVU6m06Q9A+
	 3luRFWA+TID0HrJr7SlYrX4ge4HM6mU7BK99eYH7a1xGgTeY5CxujdYJid7nD4WUMDH4j
	 5Lmjo8qwke9gfxtZ3EaqW9u/NTener0OYI85muMPTBqnAV2ofgJdFpFDmzuloarGF0Cd/
	 nAevZQXVLpxwAUI9bBgOepVcMs5gAWZHvRcpuxEdA+d60zKf0x8vctiSxnuuuXp8eO64z
	 GZu2M7qDQnT3EJbx/RKxmlEDxeQeX+baQHU8TUw6S3BM/RzjottXpDtBt91ZM4txqPg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792420308;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=z4uXy2tPq6Px5wUywVWWlcBtu2C88Rvq8gAmd3+vGvk=;
	b=EYqqZWHtR77g902YwgpyjMMQ+R9yhyeM212rgo6vei++d+sptp4a50Y9sZZejku5u4oc
	 Zbiz/4AqhJvB+RO0SKszoz4FrfuDLlUNxYK9S3HjR4UNF21R9UcRPekNqM9mYq+nTpsuJ
	 hzY4D1izv9OxuMqFtpGuYTPgxTFudiPdtedxK0OdoB1JUs4y0kwWU7ShCOqY3H97ImAi3
	 WrleNcgSDZCSi0c2lrI/xc4NsuW0ED/cPjETLXlSnggebbpYUBs1EV5T2OuhenCzJtQwA
	 jDnOgvax8nKr8p3/48pXksshy5eXBa2yqESFDGMO2ClP7nOpcFMSz+3UniT935PWl6Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792420307;
	bh=z4uXy2tPq6Px5wUywVWWlcBtu2C88Rvq8gAmd3+vGvk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m8WGu3DEw7Vim/lFECpFyVoQgDSXK0npFAtuYfGW6PKBggz72m+uF0R1XK6qKuOsl
	 IeyHQNFcB1RTPnVrYKvJ+1Ni3qj/ZsGp71b5F1a+S9IlbLsJRexLUGyYYKFjMRMvEW
	 MUlZ5Au6lfykR2oik1IQeOVRk6f2Hzj2V6Dmy3QDyGHneDgw/2VSjf3P4MhFcmb/ax
	 bl7NYHVLjFREW0zrfnye3me7XnbJNzwDvw9cs3ailRzlOnQacgkeJKxU+JnVw4k4qe
	 23uuBL4XZcBGmY5V0lB87hco9MkSpq8dboCh5XGQa+8USnrkfc/LI5+Uf3yj93KPFh
	 Ca9Gp8ZMIedfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E246980DB4;
	Mon, 19 Oct 2026 14:31:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94345263
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 14:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A21F4065F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 14:31:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9gk436dA4yn5 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 14:31:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17B414065E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792420305;
 b=YChE/ADbugxlGZspSeXnuEe3U8l1BLKF80NPIGFlb5wfvd3rFcW0x3WaPRecPSL4FMuL
 PwmaT9xPRszHr5NfAoF3V6mHL+cQHhzv6CC2DIk2V0a83Bl3TeV5Upo05TDb0Nkgu3e9m
 iBVZpE54etur2qe2wZ33o35Ry/aOUX9Vx0zDVTa5XMGtuWmwfljL1ZwVSVLMm3spM45DR
 mmRPLHlyn3aJiocKPcdgqIvoX2kEZWNUxH9U/yCDTZcM2SnL+dYbSp7xewP2v0wGyzAnp
 GVEtPC8NXJ8qVCCsRseiZfAPviMztZqc/jnx/FlNI+KOny//3xSVGuGR5zL1hEba2hA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792420305;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:Organization:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=z4uXy2tPq6Px5wUywVWWlcBtu2C88Rvq8gAmd3+vGvk=;
 b=GcWfxQfgFwwQWjmvoSB+NhHwUAwxf8MJOeJh1WNN/dZAKMhorN5AF1oH9w2JQ/1mBP6Q
 +wp+FrXh394Ah7rREgiK8ncJ4r98vwGhSWR0XP1fNjRXDi+YOVeiDsFU72cCttlchTJaC
 wnk5fYSVSgnHN+pwTyVF1vLsK0y3qF1xAxr4qMf2hEGWetJuXWuPrxZYSqhQQC/m5a41o
 Um+aOIUAGCwK4LUB646aSejHxHthYPRFTfwbxF5efYduduXQgcfyJST5qTOiiku5NSdL5
 MFC64T1Mu9X6lAj14MIlxRvpr2+3t/n+aZ0mBcEIF42m2Ond2e5OdaJHEHwhbbfRmKg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EoOukGWS; 
 arc=fail smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=moriyax.kadosh@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EoOukGWS
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17B414065E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792420306; x=1823956306;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BANR31mUIN1FgLnn0YOQf6/Kdq+DP5M2TpydDrPgtmw=;
 b=EoOukGWSWCMJf43N0qsUbSUOrcTXys+DLT2iVVpgm67Um5MEur1IO++g
 8KudTBU4Od9soMYJTtTPpCnQ2EePYfSDojG8iXAVjEvRzwUQwyveFLdaO
 vf4ly0GzQOH9UjuN2bi7pjZRMSrmYtMqcZFHJx10IkiucOrJUFoD68yRJ
 f58+XGt2QqurMI5XImiyfp2x+0s8dVViteF88yc5tqUx6GouFs1cKXYYE
 SkOS1FBeCA4lx0kx2JVjILZQq1q4OJ814DePoaLeCfp4McB82II3T0T4X
 qYk5Sy/twvHcLy/Eci4sk1vhOkIslDAjdlA050K3Uf9lvx9dVi2kPe9/e Q==;
X-CSE-ConnectionGUID: BhunFHndQrG2KAvgokIQWQ==
X-CSE-MsgGUID: 7Ww7zD3tTt+gRbTC6lqtDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1001394"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1001394"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 07:31:44 -0700
X-CSE-ConnectionGUID: jGO7R7CpSgqicbszHagucg==
X-CSE-MsgGUID: 9Obmn0FORC2fd5oZJVr0ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2527861"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 07:31:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 07:31:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 07:31:43 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 07:31:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWQUCE4/unV7l/wDjRVzg89MWOdKcrGqn8cF7J3PiJH+utEzkYxMuzKpVOW0Se6wFSByUzfF1SczRmgJfwG3++kLmT8wWuTsEWsDISAkKx1E7Wu5qZM5iSHPBNloFQ5WlR5ZklVdF3epxxEWYVllEA8z7fwqqgPsgBKPcSrYA4sf8oG4QVaE+WhcqePbXCQzP+1ONLkRF0Ta8wKFMsEwR05cj5QYNHZMggALGH7q2tGPesjv5vVorA7HOnFFYIGydGXYfMQ9fyNWYfIvWXcDYfP+HuZrn4bIiKYfmHyiKOzK3TEAiIFz/k7xLFGIOeJMuiWF0Khzhw5NR6R2tae+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4uXy2tPq6Px5wUywVWWlcBtu2C88Rvq8gAmd3+vGvk=;
 b=GHfUgsPxbMhvo2iHBfj/QcdcZNCo25Sz3iYBWVKBeF4f0f9a7Kp9naoKanF+tQ/cxu9PCI+WAYm4O+FxIFhczB/FrnDA38zwMA6V323Gm887FQUHiC4mKdtXUyOp3LgqEj21LPb7KBlMjv/bpVVdQZfKXfr7TKjbwwF923yFoR59Dia8I1mMo3vRxHe2Be0UHzuR8Fg70xddxrUc9Upr/Ek50E2T6h6MEdRqYGEIYWbLzLPAlmc/KwuNQBSodq9SYkZxdWYFIAUFZmKVMoRi4aBCVYUj/kV/1l8kBiKlixYCNY2ZAeSeJ7lF+aZs90x2p6Us9OyGJAY2/iFgyNtf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20)
 by IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 14:31:39 +0000
Received: from MN2PR11MB4645.namprd11.prod.outlook.com
 ([fe80::5cb4:804e:bfb4:dad0]) by MN2PR11MB4645.namprd11.prod.outlook.com
 ([fe80::5cb4:804e:bfb4:dad0%2]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:31:39 +0000
Message-ID: <7f5447ed-19d4-4e11-813b-d74489a6a723@intel.com>
Date: Mon, 19 Oct 2026 17:31:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3] e1000e: restore jumbo config after DMoff exit
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Craig I. Hagan"
 <hagan@amazon.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Fabio Sabai
 <sabfabio@amazon.com>, Matt Vollrath <tactii@gmail.com>
References: <b6db5335-cb5c-4a91-b823-1a114fce75a1@gmail.com>
 <20260928210552.13266-1-hagan@amazon.com>
 <IA3PR11MB898645A3712F13CE8E6F0B3CE58C2@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Kadosh, MoriyaX" <moriyax.kadosh@intel.com>
Organization: Intel Israel (74) Limited
In-Reply-To: <IA3PR11MB898645A3712F13CE8E6F0B3CE58C2@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To MN2PR11MB4645.namprd11.prod.outlook.com
 (2603:10b6:208:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4645:EE_|IA3PR11MB9301:EE_
X-MS-Office365-Filtering-Correlation-Id: b9232fd1-4127-4b6b-89da-08df2dedafaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: vM8N/6Xfc+eeWpfiuBj+Emp/bPghZRyN5Zp6+aHIUUBRe1553c+0QWk3clHscldfnk2FhnyZCM4f1aYpbUgvxEEemm3punirFP6mB8c9hu+51KvO4qPhYhnk2Z+lc0oIr0RL4EJQY09lzVDobVeeUEGl1jcHa1ichh9mM7nSZ5UV3bB3XUj3R4d+gAIbJQa1/S6MSt7svg9U+gBXnq17LJH5OEUCeHiiezr04Pbt036vwkO7KbSe34qsVwtjWYJrSp65zk4FhSgZOdbFXACFednIo4sRWozEDNrnL06IzkMT8tO5cV7MOIBtYHUAABOG1FRJ7ZywJbRUmd68UxSmEUDWbACib+xmTiDEPObiCEwNiIymdR491i1dlUl586vsvNENDW2ja0cKQSI6oXFLnyqS0+k9CP1f3jrunq0GpsnSh5HcZlexD+zXbVPLmKv8SKW6LJrqsbbNbLvxhyYQGY1zGiX+R8r+tYoe96ATKJSdHIvoZ4Vd2I3ZsVchyBRI3NtE9vgtsZSNf6T7rTS5JlA0pw4QNvhcdErq+nxcb2ZA765bF5KMSFWpL4ZE1R6GovpI5jQyxiAVwf67gz6un15x5svGCF8JhCt+BmFK0hGkD7LR5UxFRIMqsFk5VEQz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR11MB4645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3dXUW1ibThvOHJUOTY0blUxMWZ4TjEwSGRMaDRaZTUzOU9hMlFFVjBlRFhR?=
 =?utf-8?B?RklYRHdPYmtqcDU4bVB3NXY4Rmp6RU5pSS8wRTRUYUx4bHFVTXlrZjBTbjZr?=
 =?utf-8?B?dERMVFNGQjVyTXk3QmFJS3daUldFMSswR1J4WGppSzJoWlkxQ2FpYUp1VWky?=
 =?utf-8?B?T0syd2piRndnZHh1cDN1VWEzaXpjMGN0TEJUL3F4M2p3anIrbGZhUkw0ZlVy?=
 =?utf-8?B?WWhtTS9WeEtUbC9QYTVKNE5qR2NkeUdESjBaRXB0dVZSWkZWVUFBMFlVNm0w?=
 =?utf-8?B?NG1qWVExUEtwdHdCUFFMVkdhd0tKYW5ac01HeC9EZE9sam1UY2RNNERETXhm?=
 =?utf-8?B?dURkL09OVXp0RkZjVCtWUklyUlRaSy9jQmIwSjB1ay9ZZit3RGx3UUdpeUdW?=
 =?utf-8?B?TXFyV28rTmpNcW5qNmRXNHYvMkh3YVBnVElQa3VHTmU1ZHV3S2Y4OFFJY2lL?=
 =?utf-8?B?QVducTFCK2t0QmRNNGEwYzcxc1FQSFFzRlVLNnp3S2EraUJQZDRjbWFKNjRF?=
 =?utf-8?B?a0p6eU5wZGpPK3NTK2s5U1lRSWRSTkpMS3hSNERkVnczWTdnMlZyTTNlSDhT?=
 =?utf-8?B?VjdDOVNUSXZmRU5CcXhIU0VrdWpyMGVsVGE1TzJvVjBFT2JkcGR0a01MYi9X?=
 =?utf-8?B?QUFhd0UrQmxtY1NJSCtwekVBTHFyaWR6SFpGbk5IeGUzcVJCTWNBOUdHb3FO?=
 =?utf-8?B?MGVMZFFldXE5UGtjZHZ4S093MkxRdkxQaUNqSks2d3NIdlhNTUN0VHU0TWx0?=
 =?utf-8?B?c01uNjNuQldmMXNURCsyQVVZT2ZLN0VWWm9qbXpUUUdpL2MzWnl2L053bkxt?=
 =?utf-8?B?M2ppM1l5NFVhZmpKd013d3ZRYjJEV1NiSUpkYTY2UmVYNkF4UW53MlhwYlFO?=
 =?utf-8?B?Q0FWeGdDa2VvenlSbzQ2djgzbjBPV0RkL2RrVkJ5TmpmZXFtSGZac0J2QmN1?=
 =?utf-8?B?UzVVa0tOcWozSzVXY2xENmlxWlVqUXNvaVJ5ZEhRUnlnVnovMWJQdGUvYjUw?=
 =?utf-8?B?UmtId0ZOSlZsMmRSUGtldUZUaFdydmNENHB0M1pxenp3d3hMR1R0WXQ3Q0ZV?=
 =?utf-8?B?M1ZzcW53WGUwQjB4VXhsYVA1d3I1QUllYUtPbzd1M1VDekRCcXlCUmozRmh4?=
 =?utf-8?B?alhIdzFTM3VJQmpseGV6cXhjRlRDR1BXcGNOQ3l2eC83QWFmR0VSa2RsVkxB?=
 =?utf-8?B?QnBZQklLc3lZRmhpTWl0N1d4UWNmNThmYkpacm5xQlo5NUYrNld2alh4dmV4?=
 =?utf-8?B?MjR6S3VBMGJkd3oxWGxubERiUDgxbThmQnd4cEx5dEoxbEZkN1BjclVwV2U1?=
 =?utf-8?B?cHExM0FTNTVBSU9CY3NRMjVwZHc5NmVyRWU4d3l4aWFLUjVkSlhpbXFLakdJ?=
 =?utf-8?B?Y2Nwbk5OaHVsUlhjMnoyd0IzM2RuaTQ1aVpWMUFqdEdwZ0tyTmtnbjg4QTlU?=
 =?utf-8?B?VGNiVUNtcGJoQjNJM1NXMzN1TmpZZkpNZXpScjI5RENWMDNkVktHL25zL0dC?=
 =?utf-8?B?Tm04ek0ra3ZodjZnaHY3ZEJlU1dNdXhFRTI2VTFiS2xxMXlacC8vT3lnMFFB?=
 =?utf-8?B?T1dGQkcvZFJMb3R2ZGVkb3RTMGVFcVNHUXIxWmthci9GdExzR3VRMjMrVVRN?=
 =?utf-8?B?dnJaWmw2ZjFyemdEdUh5UG92RHlMSWhScGd3WlNWenJTUW5tMmYyWEt3SXpV?=
 =?utf-8?B?bHlqWWMxQ1p4em9YenFLa3lONVlaLzR5c0RzUFhucGtNREY2ejVRYjdtUjcy?=
 =?utf-8?B?U1VuVllNRXI2QmJJbTV2L3hxdHEzdHdNYlV0WXhRNWVGeTVBRXh3bUlrczUv?=
 =?utf-8?B?aGZrd05TSm9Xb1pSRC9pNnJoVFB1NzJEbXJQS0xsLzdxY2xZQ0M2L0xBTnZX?=
 =?utf-8?B?V3ZFS2lsQkFpcldyV2NrS2hUSnVZL2JlZ3dObHhkQ0VPd0pNRHlrRllDQW9M?=
 =?utf-8?B?NUthRndFcUVPTnM2aWcwazByUENjQTE2ZDNkakRNWDMzOGZhbCtMRVBSWk1o?=
 =?utf-8?B?RXNNNkxBVnV5QTgyQ09HQVdXSmJMZURoTjl1SkJCNmY1OC8zR1F6YnR3WEhi?=
 =?utf-8?B?QU1OTnVRUjhHbUZTK1FzK01uRFh4VFpmR2tPZUgxVVNQK3laN0RoQmZHRUE4?=
 =?utf-8?B?TlJmd3BUVklxczVvRGhjRGc4ZkpCbGFRRU9acWZZTkc1OHVsWXFWa3AwdHF0?=
 =?utf-8?B?VFlaZ3JNVmh3cjk1K2o5Wm9EbG1MZ2h0RzlVejZuWUlXOFhrQVlZYXhROVdT?=
 =?utf-8?B?MWZ0ZGtZdG5pWDl1NXJTWXlIMEp2eHRZMkk0MmtSckpPVUI0dmYwNWZwdk9r?=
 =?utf-8?B?dmVaeHc0RjNwbHp2dVZPTVNsZERXS08wWUpBbG0xQzRFaWF5TUpxUT09?=
X-Exchange-RoutingPolicyChecked: O0GSfNkkwwV/zUeUTGpbgMj9BsO56ud2RtcuBTGSw84SbKo17t2j0IloewyfDFOFCsoeMp8yPBeNGqVHp1nT8JYk3JJ161va8wMD79kNgh01I5bh5r+bG/gJ4kmzKMB2nkqqvR4cnf1RqyrH3XEpfA1b0cYh/KZlrvlq4MfYQG2uKSo9WsSw7X5jdH4FKa2pDIZ8BjJrdpbFOa+7XBrXahczBNuHg3d/6yidHIp8uOpn/hxGKVOQFzj9WoTjnzrHqR4IGEXf5t0Ys+xzz7fhW9fDWLTTuh4+U2TIO1gAAuXclx9glmEDohNKlWgVEs6RjLSENzVz6v/QUpCw+M027g==
X-MS-Exchange-CrossTenant-Network-Message-Id: b9232fd1-4127-4b6b-89da-08df2dedafaf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:31:39.0482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9eXVGNUctwaLCuB2dHndooJEeQUZ9CKtd9zzhillTNVv7WpkZlsgIepDEakGcXoXPFyZX24r7r/27v3tH8PLAFJuAOCRg0uOs0q7bYYBm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9301
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



On 29/09/2026 10:05, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Craig I. Hagan <hagan@amazon.com>
>> Sent: Monday, September 28, 2026 11:06 PM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
>> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
>> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-
>> wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; stable@vger.kernel.org; Fabio Sabai
>> <sabfabio@amazon.com>; Matt Vollrath <tactii@gmail.com>
>> Subject: [PATCH iwl-net v3] e1000e: restore jumbo config after DMoff
>> exit
>>
>> On an I219 (pch_spt+) at jumbo MTU, after a link partner reset (e.g. a
>> switch reboot) the interface can come back up unable to pass traffic
>> until it is manually reset. Observed on I219-LM (8086:15b7) at MTU
>> 9000.
>>
>> When the MAC exits the DMoff state on link-up, the watchdog resets
>> only the PHY. A bare PHY reset does not re-run the jumbo-frame
>> workaround (e1000_lv_jumbo_workaround_ich8lan), so the jumbo
>> configuration is left unapplied and traffic stalls. This was seen with
>> NIC runtime PM disabled; if runtime PM were enabled, the device should
>> go through a full reset on resume, avoiding this issue.
>>
>> Request a full reset (FLAG_RESTART_NOW) instead of the bare PHY reset
>> when the MAC exits DMoff, so the normal reset path re-applies the
>> jumbo-frame configuration.
>>
>> Fixes: def4ec6dce39 ("e1000e: PCIm function state support")
>> Cc: stable@vger.kernel.org
>> Reported-by: Fabio Sabai <sabfabio@amazon.com>
>> Closes: https://github.com/systemd/systemd/issues/25925
>> Suggested-by: Matt Vollrath <tactii@gmail.com>
>> Reviewed-by: Matt Vollrath <tactii@gmail.com>
>> Tested-by: Matt Vollrath <tactii@gmail.com>
>> Assisted-by: LLM
>> Signed-off-by: Craig I. Hagan <hagan@amazon.com>
>> ---
>> v3: Correct the Fixes: tag to def4ec6dce39 ("e1000e: PCIm function
>>      state support"), which introduced the DMoff-exit bare PHY reset;
>>      2e7256f12cdb only added a pre-condition. This lets stable reach
>>      the affected trees (v5.3+, including 5.4/5.10). Add Reviewed-by/
>>      Tested-by from Matt Vollrath.
>> v2: Rework per review: request a full reset on DMoff exit so the
>>      jumbo-frame workaround is re-applied (root cause identified by
>>      Matt Vollrath); drop the diagnostic e_info. v1:
>>      https://lore.kernel.org/netdev/20260923235832.473-1-
>> hagan@amazon.com/
>>
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
>> b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 844f31ab3..df7da86a8 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -5264,9 +5264,11 @@ static void e1000_watchdog_task(struct
>> work_struct *work)
>>   					usleep_range(10000, 20000);
>>   					pcim_state = er32(STATUS);
>>
>> -					/* Checking if MAC exited DMoff
>> state */
>> -					if (!(pcim_state &
>> E1000_STATUS_PCIM_STATE))
>> -						e1000_phy_hw_reset(&adapter-
>>> hw);
>> +					/* MAC exited DMoff; do a full
>> reset. */
>> +					if (!(pcim_state &
>> E1000_STATUS_PCIM_STATE)) {
>> +						adapter->flags |=
>> FLAG_RESTART_NOW;
>> +						goto link_up;
>> +					}
>>   				}
>>   			}
>>
>> --
>> 2.47.3
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>

