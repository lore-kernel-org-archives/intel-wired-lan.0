Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F88606A327
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=KOjiRjt+;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e0zO3Miv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDAA540854;
	Tue, 10 Nov 2026 19:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b3a9fUMbQof1; Tue, 10 Nov 2026 19:40:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 469F54085F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794339612;
	b=fP5lLhuA5pyqMSeoSgKqSaUd4OjdcqNDQA7Or2rOJ2cnty8XO8Vy7dIduEBymkpIREaD
	 h76H3k9Us8+fJXUldwrYR4GXaCn8jeEsNcUXEMclgl/73gHY3iOtIp3d1OrTf+IvbX+n5
	 LNG7BAqvf2YCKDl1/fl4ZFLqt86SY2YY+SWrNLtZmxcxEA13maYqq6ULrm84qO8l1iH/e
	 M1jzkrc8W+JmzTqsYl2IfhhjzG4dQIbzMcFuxXoVKBa2BRq2ds+U2GAU0Mdh+FoQdTGY9
	 fdAvygzuCh9T+VSm3jmsuxIv14D3V4ym6ssoZPIB005SeGv6rHMKYeCOnA4ZLX6rwBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794339612;
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
	bh=B4cacyDtESQUP31McQx/3bN3CkZMh68G+hoRdl5LTLs=;
	b=X5sb7IoeRyHzorfi3izKUlwFZUWh0mNl1AxjUtr0Q+cifRi8LmNWiGhMI6lO3Bpn99Zr
	 L/BxZ9KblunXeN1FkOLUPueSZxUUY51mCeAOtsResOMvlRjRH+xZzOva7yCpkwIDeaCyo
	 IBsbsb3F3az9d+4XLGLRACsQCc0FImkDkBxY4uV6t9Y2JIXHQI3LzhICHPnXdH2B9+8zK
	 nLfqSozwnySa5DJS4ViPSVZP+hmmQ4mP5kVCaCbBIEpKk00xLKGpspyu2IXSbqcVR9/Nz
	 aaWoXkJEgqRqw9BCekryAc0XGAhmTV8LcWWHHXQW/bwrO9l7EQLR/Ss3jHCVbcJB/dg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e0zO3Miv;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794339612;
	bh=B4cacyDtESQUP31McQx/3bN3CkZMh68G+hoRdl5LTLs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KOjiRjt+TfuYmRneq59JIKgz1IqM/OFwEiTDQjDNUpC+V9/h9/OzULXh+brvIyhYX
	 ZtNekGUu+5oOlQD0/H+YR/EWA/Dj0sy4aMhxqQAoKSh6/TAzhImyH3pVo9h2AWsLpJ
	 UydenhSon5fiYZNW0lDA5RBK111QsbaDPZvvXJ75h9VWBFH5e+oBwgI1vC79Jk9Cjt
	 iBxmWfBd+GWX6hSQW3lqFsG0Yo6UN1LsF/49gwDOdQ/sxKUz7jCmOVLockyy/4ZuYh
	 ujU76QabpEWaIBp+KrYbJz13Y8i/3fWg/K0sVI3wtRuyx0bH1LvMOgKlbH0/y7BpNe
	 jPFqY5dspYEeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 469F54085F;
	Tue, 10 Nov 2026 19:40:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 045A19D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 19:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE3184085F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 19:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 93eX2skOPpPt for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 19:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8C15D40854
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=e0zO3Miv
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C15D40854
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794339609; x=1825875609;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=B4cacyDtESQUP31McQx/3bN3CkZMh68G+hoRdl5LTLs=;
 b=e0zO3Miv9BQ7hCq/TFCSaMtZiA0/k2uEgo1iZaczwa+F6BN52Kx/63jQ
 fo1AXbnmhEdYdrPyzi01TSucXM9apq3LfuKnBfKHPUMOlJgLVtVkc1+TA
 KeR0K4mtlXSYGAyMFkQbbm3BlSB5hxsTF6y8m09S1azVPFNPDEFP8HvP6
 DxvaA9IT8PlgBOEi0629wj7KSvQCN6qRInyGZ4qj83qCRh7UY5m8TXp67
 pL3Fghz8rj8BO8z/zUVaYKTYuHFXyoZ9hl0WrYId112UKDny0RUxb7Jbx
 WhUzYHhtU0TYYyUiryVnhGFK1dl2INY5nLQ6vLTKJTykG52Lb2aM7as0X w==;
X-CSE-ConnectionGUID: GHAtFBCqTumdgS5ZyHXorA==
X-CSE-MsgGUID: uldzPevAROyRrr3ZgNWREA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3016941"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3016941"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 11:40:06 -0800
X-CSE-ConnectionGUID: jVoukwsrSuqQiDwHCTUXPQ==
X-CSE-MsgGUID: /g1s2oqwRmG32WSO9J2ymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8671061"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 11:40:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:39:45 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 11:39:45 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:39:00 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) by
 SJ0PR11MB8295.namprd11.prod.outlook.com (2603:10b6:a03:479::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 19:38:57 +0000
Received: from DS0PR11MB6469.namprd11.prod.outlook.com
 ([fe80::ee3c:8422:6754:29b0]) by DS0PR11MB6469.namprd11.prod.outlook.com
 ([fe80::ee3c:8422:6754:29b0%3]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 19:38:56 +0000
Message-ID: <cdc9ded1-c765-49bf-99bf-a36341af8a7d@intel.com>
Date: Tue, 10 Nov 2026 11:38:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] igb: do not let a VF set other VMOLR bits through its
 frame size
To: Paolo Abeni <pabeni@redhat.com>, <tkusters@aweta.nl>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexander Duyck <alexander.h.duyck@intel.com>, "Eric
 Dumazet" <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>
References: <20261104-igb-vf-rlpml-v1-1-729621b60eee@aweta.nl>
 <984a9f14-d8d3-41d4-a846-6750f710c741@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <984a9f14-d8d3-41d4-a846-6750f710c741@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:303:83::9) To DS0PR11MB6469.namprd11.prod.outlook.com
 (2603:10b6:8:c3::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6469:EE_|SJ0PR11MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6f2226-f412-4ddc-bdf8-08df3f624268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|11063799006|4143699003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: FNRxo4KU6yvFH8KeGC1zxm/TTmzzIddVYiy4xr3wbEGzuNzS0A7CHvey3RntB14jXl5FIND5Yp+xtaXy4l7cVHTE9vs/zUG1KgNypcv7KxVLxO+WIyb+BzzeBR7KxGvkiWfzWeC8U/2R5b9YhAPwA26aw3N23wV8wGUhln1SdpCwodNIs9EDiD2RAXL9e1+cthsE8VxMhtCpaH/K1tetFO/coTseqaqKjF7C+ETId5XqwqIN2sk2zk5F627n9RFMRwxs1BxfOghm5AunvA97ZlyjOKSSjBMXZ82ddoEijtWmD+9fUOVQNYlsewcBDXYfFCVV/7RTY2Ys6UpT4E24Geq+dNMnXBggwH+FoA7ZxEor1KqC4lotsKK0HrajOtknKr0RIv5h5GS1b+9aKpmVcdqlgzURXQZ9T2zSs4OXYjglfnfSD1r0l6OOCGAu8AebJyBv+UdJHeObgQgyKCOYOxpYDXDoiwWLy1w5kNp5EbId79mcJa6oeUKQp0QyNJFRcXju9by2pmgmJKAzc9IJH90yjoScvYTm4jtkXso+BmPBvr7PzTs3CM+htmFHQLxxBGa4YmCTlzpgeoINcVqymunug7LdXmjOzvaX2ITVHXuv1oz0yKydNcZiw+c1+mEMrCWHrzfTGlo9yUmmkDxN0cRdVv8c+ZLLhov47YAooCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6469.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhoSDlybnc2MnFoVTRrR2x2bmlxaHhTUk95TExpcm8yNVp2NWRKMlI1dC9j?=
 =?utf-8?B?YnRlaDZNNTRTQlZpMTNFSUI1ZzVpYnByREh1dnpUWDBWZjA1SEVtcGtZekQr?=
 =?utf-8?B?L2wxNzRWRWtTYWhBc1FzbndROHRwYW9IRUJNdFA4aElqTUw1T0ROc1AvVWI3?=
 =?utf-8?B?M0tmcDVNM1kzeXR2eGt5bDBVVDEwanJBKzJvNi9XdjR4NmJEMWlVQ2xER2FJ?=
 =?utf-8?B?eHZST0JMY3IzOXZHY2FFMERldkJkS0NneDI2L2xicXNKL2dPZEY3Y2c0d2xK?=
 =?utf-8?B?Y2JRUGQyRnViRHdKR3Z6cUpFNHRHSXNpd29hQnByVEFPaE9BcUVHTlV5YW1i?=
 =?utf-8?B?djN3VHo3RXJtMWRFcnJFdlBwZDZIY203Q3lnU1FneHNORHNvTHpQbllNeTVa?=
 =?utf-8?B?bVJkaEY1RjFvTlhBZVBlV0ZLNFVFb0czZys0QnNMMHVlcFBCRGhCT3J2bU9m?=
 =?utf-8?B?NTliWHZOTGY3d1ZBYnNySmNzQm41Rlh0V3c3Vm9ZTTZEMk5YcTY5M1BJYTNQ?=
 =?utf-8?B?TUZFc0hNRENaZVU2aWdlMWQva2lxSVpvZi9TR3hyVm5HdHJJcUMvRitNS0lm?=
 =?utf-8?B?bnFyb0Jjc0kyNWZrUWwyYVl6NjY3WGU2MHk4ampnZEdtS1kxL3I0a29jVTNC?=
 =?utf-8?B?NVc2VldHcEEzb00rK0Z0M3JOcU5vc2xtYnZSVXRrRUtuSndZQ2w4QkJLYTRt?=
 =?utf-8?B?RXBkZDczRWczVHhvOVlqOHNTZ0M2YU9oUENPWDV0R0V5VnJ6ZFpaRWtNa1ln?=
 =?utf-8?B?ZUExY0lYS1RzdXRJTFdPZGNYT0tWc2JiN2lsUDVBRE5FemhuRXh0QUJEa0Qw?=
 =?utf-8?B?UlNLV29NdUExSWhBZzE3S3ZoT1dMZUR1WFpyK21RRFRCRXlYNWZFMDVhWHhJ?=
 =?utf-8?B?c3FzVXNjdlE2TnpvMmMrKzBkOU8wMWJocjlZUkhlNmtjcmNmYTBLK2pBMWFK?=
 =?utf-8?B?cVp3MFUvaXErTURja1FPN0xBRWpwbll4aSs0UWh3elhQQllkU3dhM0s4QVdO?=
 =?utf-8?B?dlM1VkFQYTg4c0VXSkRlMURKd2huMFd0SjJGcEVPa3drUTQyS0tza0hROXZo?=
 =?utf-8?B?azBlbjRINWxPSkYvZ1EyRGxxVVQ4VFh4b3krK1AxNDdnUlM4dndVQ1VVdEx4?=
 =?utf-8?B?UVdvTkN4a1Q0dElpTUw1NmdpdWF3VGdMUEpvc3dydmFlN2ZWRkZBZm0zeVdF?=
 =?utf-8?B?enFkL3J2QzNBNmdBbXg0L1VzaDBaLzk0NnYxVWdrKzhKZkJ4RHYxS3NpVyty?=
 =?utf-8?B?OWN4M28vZndqR0F1U1B1T2hUV3MzSjA5UDBDZnVFcDF5VklndlN2UVh6dXRi?=
 =?utf-8?B?eVhCdmVoOENEVk1Hc1pUblR2RWozWGlCdGVBQitmWWRGT3o2aUxPajlRZEFX?=
 =?utf-8?B?ZVozVzlBbkhydDhRdmRybE1pUUtlcUtyeVNrZVJHV25tZWx4S2xsL1VFM1ZF?=
 =?utf-8?B?UHh5Tnd4dStzN2RXc2pkZis2dmFrV1hLS1VYVFhRNXBWeHdwbWJ6cjJMMnhp?=
 =?utf-8?B?bGxsajIwNmNZVVhIM1dyZUJsVUxiTFhMSUp3RFN4ODlMMEQ2OTY5NkpXZkNj?=
 =?utf-8?B?T2d6SVh6WWw0dzlPTXFVOXZQUHdEZjNhVkg3c1R1Um8zNkFVV1NDT1MwY2tN?=
 =?utf-8?B?bVplY0kyanZZcGVzUzFzWC9ONEh6K1o4bmdDV2NTbmFLUDR6cXpIalgySEVn?=
 =?utf-8?B?OGxIazNLc3hINUVjZG9SdXJQV2svTndFRmVNNkJOcGVETXNwMm16VGdRUUxv?=
 =?utf-8?B?aVBKK0JRV0FBQVpuaW5lZGp6UlhERmJScktVdlM1aFpkT29DVXh6R0kra2hY?=
 =?utf-8?B?L0ZPN0p5bGcyWmVQWXBLMjc1UHZSMFByanovWXYwQlgyTTFKOWpPL2VWc0xT?=
 =?utf-8?B?blkxV2NLZUFSMFRZNVFucHN4VHl2U2hXdEFRVVNGSUk4NmpuZUpVL2c2QTYx?=
 =?utf-8?B?N2lQZXFMU1krYVhQZGpiSFNscjRNeEk2Y3EzdFRrZTJZQVNqL05UdXIyUVJG?=
 =?utf-8?B?WUZncjF5VTJQbUxvTlFmZEJURkpVTWJFZ3VhSnFsT0pFUEhMN01wWXRvVUV0?=
 =?utf-8?B?b1ErNUFodDVzTThjaE5VWWlQRW5RQ292djlDL3lNbzZzMzl4WEVwZ2ZYTzNR?=
 =?utf-8?B?YU0xYmg4ZlJUTjF4OGxVK0xUM25QRytkMzVVUVF4LzNDNkhKd09xMTRONUx5?=
 =?utf-8?B?SXhPOU9LSCtBdmtzVStTcDBGd2xBUVdOaDl4dmcxSVVuVXRjeDhkTGFuNU1S?=
 =?utf-8?B?bEE4VTA4ZDJzdEtyWS9tQ1lqeUpsL05uKzJZOEMrczB1MFptVUxBc0gxYW5h?=
 =?utf-8?B?RHRYUDFLMFJTRzAxMWo2QjNKQk5UUGEvbVBFazZMMEU1RU5GOEdmVmFmWklY?=
 =?utf-8?Q?wBWe1vC1fXm9BzGU=3D?=
X-Exchange-RoutingPolicyChecked: NW0w9b/Gu9G9wsiwTXVJN9Iwcqcs1PhHx/yPrm1ZX8dJxidZ/1jQyHIE6WDkvU8aUNd29jYcPvUDc941chTmHu31evLWwf0VzT5SZy4XCO4Yillve4tx8Z6S5F8y8uWouKauiaOzmIJL0T4+UE20niJbM72Va5vsNlwt1oMoe0EvYaM0QzavXcqur3FqOVzo0pym/k/e/d5h24DCrdmNFNu+zFqzlm3NkEO/pZey6oqnwRecDaDb7DlGVPlTrMUG+QgibamEtB8pJKraYZHMFbgizmX5pg3aLOoz1B57ux15Tke6BGagxRnxaNZZZAaACv02MSgHHgUtuHTm/Cbcyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6f2226-f412-4ddc-bdf8-08df3f624268
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 19:38:56.7884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl+GQLQQsJk0BhQyX9n9/ezCsIzxv9OCuEfiXY7C6KH4EE3VY/ecl5LmAL75M3sR9lzlQjIGC213clUjtf7SFlB2ZbEs2PqaxDDJ4AZPVR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8295
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/2026 6:48 AM, Paolo Abeni wrote:

...

> I still assume this one will go via the intel tree first. Please LMK
> if I should apply it directly, thanks!

Hi Paolo,

Yea, I'll take it through IWL.

Thanks,
Tony

> Paolo

