Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CB606A32A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=sD4Py819;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yw6KXSR1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED4C16078E;
	Wed, 11 Nov 2026 09:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sxHV0M_YRj46; Wed, 11 Nov 2026 09:02:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 504DC6071E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794387762;
	b=bXMHAMeP/2607T5k9hw93sl+y60pwCcuUd9PqibihtbHiefaKWLGZGhhw4ultuG2BZ1B
	 B/yyjxaz1fJIkX3YbXsRjxS74J8ND0jz+QxVKS0st35tgeuKlPtGZRugML2diBEMUGhJ+
	 8uHsmZHQYlsYgEaKIGKDerq7jRq8+RjITP3bsPrJNqp1kMNdeAIURF2Jolo6Irv9oX6lb
	 EipeVCG0wM3p6kv92MofLJxczd6JqV34P3xFTgcs22ebMFrp5Oq6lYG4Q+8/netTVzS+C
	 9087IKRx88hIw0yX9Jd1iKPQUd0LhtKKq2UbmjczNbcsBzjahV/B3FVIKuYG6hpDLYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794387762;
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
	bh=ibvwRrnA3+QoBk7k9lQ6REhTdnNoEnEpHrRcKdC88oA=;
	b=EsTtZMB1Er/Q9qVT8nvNp5vFokjMFy0VwCpKCxjK9L7DpVS8a8H+lAoYBjoZerKojDJj
	 iVpqELPW4x4pqj2yLt0Txx9Ljp84SNMbGHLlWaMwMhMbIJyyoPcxbfrKNukeJewBn7Dre
	 9VdlbIGrCYiNQsq5LH4LTt2eh/PuHGB/Dk0KL/6PWcVXMjMaZievJWkV/dtR0duru4npB
	 H4WdI7mIF8ZEf81OIRxcRITf7oSkWopwsG6/KMDMycERl735DQHqr5+l3dSVjbq2k+XZj
	 4WqmP2N2e4HIzaETT37iTfYH4HWaoftn7oU7Drkw6UbKf9n2aeZo9Yr8v3309vxsGBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794387762;
	bh=ibvwRrnA3+QoBk7k9lQ6REhTdnNoEnEpHrRcKdC88oA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sD4Py819yLdrPf7VIaGwFEN9Ii6srTI0V4hDDRaSuauiFRS8Qy/0XCkmkHb+eG8Vj
	 dRUZLnJvo5qvVrmWQ93NG/sq6D5foHkO2eZIGbSFMCiQC8iRTLdY3Ftv+DjGbEivSG
	 aCiyU7t+xEn3h7/3sJ9c8ILY13oV2mMXps5ycDPgcwIYd7oDCB30yhwCtFKCdtKn3V
	 YdZoZ31142w/r89Y3l8410a5RigcY3Nbx7C8jOZVMVHTDhY751lIRT4+70//4NizOP
	 yH6IU63kMSZB1j83pyqeNjr9B9kJLq4PZzANBqOCm+jyCxyfGoB49tGv37JSKEklqY
	 6dpYDap6iEBhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 504DC6071E;
	Wed, 11 Nov 2026 09:02:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C5B70731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AADB240A1A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQYmzpFc4G3L for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 09:02:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC1E9409FA
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Yw6KXSR1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC1E9409FA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794387760; x=1825923760;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VYejnJwLt8095LTNmxzdFDJg/2Qm2UYmV2bPtQmyBr4=;
 b=Yw6KXSR1Jqf1iq1F6gOgiARJAti4yGDBcG6LIAYnWcYILTxF8lpRA4tu
 AV+MBotqiXzGepuz9TpJg/DVuHQrLa2gEGzAKwPdiCcI0PZNLamSW7FHx
 Ki+40oKNunbqGwyJg40zP/C+kisD7IsBeyHiYGoJLitSDYGUxg1jkOBrd
 g3umOA4k+WwcWaV4+cTLLtLZ/iO4x26nAibSppniRsWXX0DsRBT/kIqLf
 IuqOOsnPqy7i8R9frzgkKzBb5zvPNRoz6eklPmWaf+iALkB2fKUFMWX9S
 5Zs+9qz7+OYhuyGFvvtY8woBlON7b+36/8RupCdgcqUc+zDCyn4unpJ/q Q==;
X-CSE-ConnectionGUID: AHEYaNUxSUWLE7Cv9AvXJg==
X-CSE-MsgGUID: iY109agXSNqODYGI028ilw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3041111"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3041111"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 01:02:39 -0800
X-CSE-ConnectionGUID: 0qqax8K6QdSLJzdGGa8nVg==
X-CSE-MsgGUID: IfiHOHpYShS+2ZKAGYKPvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8468398"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 01:02:38 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 01:02:38 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 01:02:38 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 01:02:38 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by IA6PR11MB087122.namprd11.prod.outlook.com (2603:10b6:208:601::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 09:02:35 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::a93d:4c42:c821:3cb2]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::a93d:4c42:c821:3cb2%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:02:35 +0000
Message-ID: <5d45a583-198c-467d-afbe-8f19398e82f3@intel.com>
Date: Wed, 11 Nov 2026 11:02:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] igc: Disable PCIe L1.2 substate on I225-LMvP and
 I226-LMvP devices
To: =?UTF-8?Q?Daniel_Via=C3=B1o?= <danividanivi@gmail.com>
CC: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, 
 <linux-kernel@vger.kernel.org>, <kuba@kernel.org>
References: <20260925112850.189302-1-danividanivi@gmail.com>
 <179068206160.434549.1717741783856466607@kernel.org>
 <02c36d47-ad50-4f2c-88cc-6c91f62bba00@intel.com>
 <CAD6rab8LEfZcQgcZLmeiDzd-PUi56h=9aBEsuOS2qnoyZEsdxA@mail.gmail.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <CAD6rab8LEfZcQgcZLmeiDzd-PUi56h=9aBEsuOS2qnoyZEsdxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To CO6PR11MB5617.namprd11.prod.outlook.com
 (2603:10b6:5:35c::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5617:EE_|IA6PR11MB087122:EE_
X-MS-Office365-Filtering-Correlation-Id: bae2ead4-fbe0-4e8d-b48a-08df3fd286ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|11063799006|5023799004|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I/6C3nfTWfV0EdD2zp8avbc62ogauAPFJ5go0winnp51qojT64NtK2FmhmgxgWRKd4oSFrDcyWmSIUc68bP9Jg0KLsmOEz9eo93MHTpqO+xskMNl/FTCVRiBe4YIs/9u6JhH8Ob8mqas3xL7unC/uXehHi6xWPO/H7S4s0EnMydIFOG+94yPF4YGTFqj1L5P51A5cnBFdQjooB/qaJdJNUJ52CpQIri1GwRiER/ZrSbLB06LEQek89kE3+bus7hObH3pztnxiyaMLJx2+vAeQs5DYoeJeFOn2kqIFoMQwnhlfuyPs5ljWnsyPNfb+g26nxQnAH9Q+9mtMSaEj1MDvDF9D/TnWDYDtiDXtd74w9GtPY32l6jjH42WXslrGgfg3g25SYufKlVgtQTq4kG09GfwdihxmJdvLarZkpBK4lmVj+kuC+FaKwqYPBvCymo8tu5vM9U1f+pIHVcMh77ZK8pn2BQzRh5DG/6GBXrFUIe9NAWTUGMTeWOSAdyE68Eh2A9A+G38sWxWR67x5ufZ098GaCWCl+b6NuhCpf3R9XDHwsyADWOrgIgMig1nQgNiy5jdciXfpWr/zg4nq7UcIGmBFIawv3UDr8pJmc0RUI/g0RhoqKgAgQaJi3dPvxQHwIjRkX86TKOdtu0UYp/RR6ECFt9LcDosUNAVNIKhbpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5617.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0NQQzdxTXdjZ21RUnZiajlnK1NuM3RxVERCUnpnQXRxeGtKRHVOdEh0YmpS?=
 =?utf-8?B?bGNPa2lRWGYyVG9hN1VON3JDK2plOUUyQWlzYk5INjhYckJGRzVnckRLeEVn?=
 =?utf-8?B?ekw2LzNFemV4S2pXK0RsNUFZNnVDREZVM2RwZVFJdE9QTUZ3Z1QrUDYxL1JM?=
 =?utf-8?B?Q0oxQzVHNjBsNDl0WlYvVWM2ZXI4UU8vaTd3dW0vZzMzUXZ6YUtqRExTeXUx?=
 =?utf-8?B?TUh5TzFnUzhlZHVwMGlWM214a2J1eTZkSFBSc1doWW9YUGxuRU5Xd1BNSS9E?=
 =?utf-8?B?UGloY0JMZWZEMDRad0VuRWt6bkFCK05GWkFKVlVkOGEwMXBNOS9QcTNYaVdB?=
 =?utf-8?B?S1R1ZWJ2clNuZm44M0I1bjUyRUVRaFJhUlJGSWhhZDlQNWw1YlV2M3BVbDZ3?=
 =?utf-8?B?SWJES2JtMko3bWZITU1mRzJDc2hMUjI4RXdCdGdYK01rbGZzTjZQZXgxMXZC?=
 =?utf-8?B?TmV3K1ZjYWhrdTR4RWQ1VXR6T0tUSkgzSnNSRXYxSXJ3VnhPdlVMOUhYb2pX?=
 =?utf-8?B?S01rVGlVNHgyZktvNTlmUjBsNnZxZGtZQktnVkFJQkMzemFSb0NsdjcyQkwx?=
 =?utf-8?B?QnNjWCtlT1UwWkJBbm5pR2pPTVg0aWR5ajEvdy96N3ZldHdLV0UvMTVPRnNZ?=
 =?utf-8?B?ZzRFRkpXdmRkQWtqK2FZd0cvNkdjRUlRcldQS1pCc1VUMndwVk9OTUtDYkV0?=
 =?utf-8?B?VkYzVFlEODcrMHlYbFdpTmxUK2FOQkNUNkFjZlJOM0NqWWlQckFqZm80RVVW?=
 =?utf-8?B?Mkxub2QzNVoxaWpvbkN1Y3dpcjV0eVE3VFdBK2VtS3dVbHFITm9jU1hMRDVy?=
 =?utf-8?B?bHhCNi9FYi9uV25wOU9QWHZlQTJBcE9rQXFjSUpHM1VJMU4xS0JRM2xpUW5Q?=
 =?utf-8?B?T3ZBelRvMzE4NU1mTUUrUnFkbXlydVhqNmIzMU5QR05nSWprdW9oVmxFYWFm?=
 =?utf-8?B?VUxXL0t6UW5SYU9ndjA5ZGNKc0VwNTRTUmRsMFFIcEV0dXZvTHB1NXk1b29Y?=
 =?utf-8?B?a1RzWHpvdlZuUTBLem4wRHNrdlhZTnhiOTl2d1ZwdTZ5RDl5MFlNRHpaNUNS?=
 =?utf-8?B?WVdWemIwRDdaOUtaMThuQ1FIOHJ4cU5IV2plM2ZWTjY3WjNYanFqWm41ek5z?=
 =?utf-8?B?SkloUnRlK1EyYWRkZWhYZU9Dak1ER242bHMyTFFidUJOVkNuZERqTzFGMHR5?=
 =?utf-8?B?ZVgrSzNIcDJnQ2xFdWN5M3dNRmdRWkFDNTI0Y0x4aFdrTStTamF4VHg4bWxu?=
 =?utf-8?B?WHh2M1N1bVFBSlBTYzlodEtIVTE5TnAwRkQyV3VESnRoZEVKMFJjemJnMC9i?=
 =?utf-8?B?MzZHQUVoUm5RbDZQb0krUXU5N1Z5Q3plZ2g0eUtXamNQb28wbzRCTFF3TlJ5?=
 =?utf-8?B?SmQyWHB3RVc2UEJCckRFKytqcjdVZWJyOU00U293bkUvMW0waXEvTi9zc2dN?=
 =?utf-8?B?TEUyRUwrUW1OZERnLzVwUktqOU9FZ0RQOFNPMHBFcGNBU3lnN2FoVnAyb0Va?=
 =?utf-8?B?T1gyWmVtdklaTGJYbkRSZFpEOU5nMVNOYzFkWUJHR1YxZ05kbFU4SWNtYTkr?=
 =?utf-8?B?YVU4VktLc1dmM2xvNTUzRDRKYUZ4NUpwaTE0RVdPRkxIUk1uNlc3VDdER2ZC?=
 =?utf-8?B?bVp2ZFdrV2hTajNQcWNkZ3c3UE02NjY2YXN1a0dqa2dtZkgrNEYzTDM1ZFZm?=
 =?utf-8?B?YjRTL0VEYnRkWkZlU3R3RlY4VUtyRS9yajFaZ1gxWTBPV05aU0c2TUdOcEt0?=
 =?utf-8?B?RmtkbDBFTzJlc0t0OHI1Q3B4Z0lOUGgrSHhTMDBacFRGOFNmN1piSkNtcHlZ?=
 =?utf-8?B?UzgvSGlvRUN2QVM5VHNjVnBHMDFlbHJoR3NSeEdZZVhUNmd4Q3kvVi9ibzRx?=
 =?utf-8?B?ODdoTXl1VW1VNmU4OTlmaWdoSkcrZURoRko0eHBSRWdOcWxZZ0VEc0JGQnoy?=
 =?utf-8?B?K1lualNRc0R5OU04aFhOUWk5UWN0VVJQek9pZU1QVEJWN2hiT0JYNmhSMENT?=
 =?utf-8?B?TkJtQkl0TlBZOW00djJOcFYxc2FqM2krSmFGczR4NVh6N2g1K3d4QzZvVjVI?=
 =?utf-8?B?Rmk2NnRMeVBNcGJSaTFoNG1NNnBhUVQ0V0w1YXJuRFhFdUNQMFEvTUErQXJs?=
 =?utf-8?B?Wmw0bU5ZVElZMEp2dFhFV0FzMmNVLzRwamx0SWZQU3BkUGxnNTdJZmVoTW00?=
 =?utf-8?B?VjdlOUh2UTVCUGZza0VkZzJrUGplRmQ5MUlNbkpnTzNWN3dxRVJCMVlwYWZ4?=
 =?utf-8?B?YmJKb1V3KzVFKzhWQ040aVR3eDQzUFMrLy9mZDlDclNKa2xGcXQ3d0w3OG5B?=
 =?utf-8?B?TWpUdjk1eFNHL1F0Q3Q4NDZ3R1k1TmNWNVlNeHhHbEpKTXdNR2doZz09?=
X-Exchange-RoutingPolicyChecked: i6fhV9nK6jFQZWLEZV1JVs6RlVHdTQBwmTUt9qr0F+2VViX/ZH9Bn1bi/rXc/ntg4NJ45SVYM1u57vUcMYQQ30AjP3ti5D9dgFPVoM8vCFEVCADrCWt/ZZncBYFT3Nor1YgPb08L6Ag3SDCk2alYDV5AQJ6nZPuXok2tcKU8F4eLJmGIAhAF0jGT0njqW00NdBMRT10i9lXarx0930av6LFe4DWLzFyC/kJKzIEfNfiD+9pd0fR33LtfkHVJ94+nBqkd692Tt3Fea6ssMloHoI/2MMkgo96b+4P8C+UUx0GteSh+lcHNuSPh4nFANC+E+CzZLpd05XKoMdyA5pn8KQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bae2ead4-fbe0-4e8d-b48a-08df3fd286ee
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:02:35.3256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMtEgnljbCq6CgUnG/804PS8Bbcccje3pYGDzhYKUxzUhWblo+uFJS743e9APHtpykVfhE2vsFEERk617wjWdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR11MB087122
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/2026 12:04, Daniel Viaño wrote:
> On 09/11/2026 12:45, Ruinskiy, Dima wrote:
>> I think this patch might better be split into several patches.
>>
>> 1. Adding the missing IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226().
>> This was probably an accidental omission.
> 
> Agreed, I'll send this as a separate patch. Note that it also changes
> the TSN code paths in igc_tsn.c for I226-LMvP (they will now get the
> i226 behaviour), so it would be good if you could confirm that this
> is correct for 0x5503.
I confirmed that the new I226-only TSN functionality (enabled in 
upstream commit b8897dc54e3b) applies to the I226_LMVP (0x5503) as well, 
so I see no risk adding it to the device ID list. This will make the 
L1.2 disable code function as intended.

> 
>> 2. Addressing the locked vs. non-locked call to pci_disable_link_state
>> (the possible deadlock noted by Sashiko) - this should be looked into a
>> bit more, I don't know off the top of my head what race is / isn't
>> possible.
> 
> I believe the deadlock is real and already present for I226.
> pcie_do_recovery() runtime-resumes the affected devices through
> pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL), i.e. with
> pci_bus_sem held for read. If igc is runtime-suspended at that point,
> igc_runtime_resume() -> __igc_resume() -> pci_disable_link_state()
> takes pci_bus_sem for read a second time, which can deadlock if a
> writer queues in between.
> 
> The L1.2 disable done in probe is sticky (link->aspm_disable) and the
> PCI core honours it when restoring state on resume, so I plan to drop
> the call from __igc_resume().
Great, so yes, this is good to have as a separate patch.

> 
>> 3. The actual problem with L1.2 substate this patch aims to solve. I
>> checked with the HW team and there are two conclusions - (a) it is
>> strange that L1.2 is enabled somehow for I225_LMVP - this is not
>> expected.
> 
> You are right, and I was wrong about the mechanism. On my setup (HP
> Thunderbolt Dock G4, I225-LMvP rev 03 behind a Goshen Ridge
> downstream port) the NIC only advertises L1.1:
> 
>    L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+
>              ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+
> 
> and the upstream port has no L1 PM Substates capability at all, so
> L1.2 can never be enabled on this link. I will drop the I225-LMvP
> part and investigate the dock errors separately with AER enabled.
> 
>> (b) generally it is probably best and simplest to remove any
>> device ID checks and simply disable L1.2 across the board in this
>> driver.
> 
> I can add a third patch doing that if you prefer. Otherwise I'd leave
> it to you, since I have no I226 hardware to test it on.
Thank you for checking. Since you confirm the I225 issue you experience 
does not actually stem from L1.2, we can skip this for now.

--Dima

