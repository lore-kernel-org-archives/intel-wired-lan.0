Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511F8EFCD90
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Mar 2026 10:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03D1641223;
	Mon,  9 Mar 2026 10:32:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SyHY7_jLWpoX; Mon,  9 Mar 2026 10:32:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5F4340A5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773052367;
	bh=KgJjVoVKQUk05QFFBcRXWBP4IRtbDF5AbNvZYR5fMGY=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bNqTMUCWuqrHgDcYjxkk9v5j1mv6Rg3Zs9V0V3q/86lPECaeZFdIZgNc+OehYVzcp
	 WtgG3kzW1j/amXvy8+qkQdbh+7yxJCgMX0+pA2zNzH6+QbYg2K02e1cvflcPKGaN29
	 fUsN/tvmY+158pir0qPJPMIvILyYr1JCKDpimNvpMN2LjAXrUGREWNsWmK/lA8PfKx
	 wI2TDOHnS2IQ/lrGxo+1MefYB4j+/5UIFHfUOHc0pNIfmvOBZDNMSdIaA7feltPfkm
	 Z5mjpqEkJdCQAAQWnWU2jPINqLtCbS6yXi8weM9l8iUN2cfeqeblz/65RQdyJZucKv
	 /3KaN70jolylA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5F4340A5C;
	Mon,  9 Mar 2026 10:32:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 48D55158
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Mar 2026 10:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39BE760751
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Mar 2026 10:32:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ev6ISKeZErN7 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Mar 2026 10:32:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=avigailx.dahan@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6EBCC6070C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6EBCC6070C
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6EBCC6070C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Mar 2026 10:32:39 +0000 (UTC)
X-CSE-ConnectionGUID: gmvfvT/4S5KdhW4HkJhOvg==
X-CSE-MsgGUID: BlY1EFKQRLauAucQXQybMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74116786"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74116786"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 03:32:38 -0700
X-CSE-ConnectionGUID: Cz8FWRJjScq9m+zNdj0tTA==
X-CSE-MsgGUID: MptueMyxRAK3A+2TkKbJWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="245697437"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 03:32:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 03:32:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 03:32:37 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 03:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fg+bkof5krS4DtgDfs/Z8ZOj3U8/IsZmkT2YjE1aeGFQJKSpNLocmZmS9eC/JtAkxky8LN+Pb7CFnP4JPqKdAYW+eJB+AAGdkrHBC72HYoEbHZ1Ozm2e1OT1NJAoRriePxig9k2c87tLI+dphEwjvrlnC9Sxtqr5IX7aplABTTpplBQ1v2MgP7BR0QbSgmNNMxBDsj9F9iol/EV23kEznQLMiJoQZECLLLNNrg6yznuAIgglCUb15Xf4VknNUaW6AJnaYWpudJbxyS6nkA7NdOtPAw7d7VFFDGhU6khL+T4AxI3XXfT7gl4wWlZrBsf64B3syIWQ2GuCZ2tehcug5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgJjVoVKQUk05QFFBcRXWBP4IRtbDF5AbNvZYR5fMGY=;
 b=TLdfiaH+iVTp+f8IAAG15gZ/7RlAd17tCJeb8VgAbgLum5MDFueBGU2obgwkw7EJYeMj1Mf326hZn+r9C5E/238FKtjy3T+cWtE5Qln8Z3WU6w/iINnnuPRVlAAzGUQpGhGflkrpyLxpqX6HD21lNqEZuW5lS/8ClXorxxhWOkjVOBCC4axzTPAsCgTyqC/+eKNNX2U/7PVvh1lYszgYHaqhNgOoQs2S5Wk0Nfzw9XD11FaDuNN5wOp+fVxrt5fcASEn6+bd4EDEDHtz4VmSuMMQN01ypErRLg85WrsjBQeuPFt4+s85Qs2fdPJAQZ42sdlKlYPEAMHvrkHsOUazpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by SA1PR11MB7037.namprd11.prod.outlook.com (2603:10b6:806:2ba::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 10:32:34 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 10:32:34 +0000
Message-ID: <fec0ebc8-09ab-4bbe-916d-6ba524bd60ab@intel.com>
Date: Mon, 9 Mar 2026 12:32:23 +0200
User-Agent: Mozilla Thunderbird
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 <linux-pci@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Richard Cochran
 <richardcochran@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Dima Ruinskiy <dima.ruinskiy@intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
 <20260224111044.3487873-2-mika.westerberg@linux.intel.com>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260224111044.3487873-2-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To PH8PR11MB8013.namprd11.prod.outlook.com
 (2603:10b6:510:239::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|SA1PR11MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f93bfe-2a57-4b74-ed6b-08de7dc72d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: GRx+Ov7YOGPRC5PIa0rXZMYiAJI9+gg324pb4kJBb12/EakC2rMBjhCORHwWvkxgvLTs17eRXfeZG/ln4OprOsKG8w9KjWob8QhDn3XUtIU21OfYnj5HporJY9uxSoSAvf13AGweyWcZpGCNiU5Hjf0OG9sFLWPkiGbY6D9zer46dmYaAqlOhEw6jmX1j7JZz8LIoa0G2W7WjTIezSsved4Pn4EKc5xhBdtxG3x96tlGS1POjB4XqlrOl08TbZn+DmgS4nAoWSH3GujkG0jGlW/BeFqwenff26q00YlkE7r073bXXY6LMs4lZvbYczvvtJKBovJm3oKBDp4PQ3hCTkIuWC6fJLFYD5OHWUD/nQPTTY3IFqY6rMnHpHj/95LspXbvk/+Q9I0KJMF+togFvKVqgDnJFRJVM3Hs5a/YL37xprsJ/Iioz4oRz4HAFSoe5eD9LyJWHlVGMe/qHIdTQM3p+qI2TIw02/JvK98BUMO5aGQoQUEN61uEO00PdEjX6m6qRosBTJpDjjwy+onMycua6po5L9G1/p/D3Ks7FisEOC8IjdFzt4NyG0tPHpH1oIXc5IE6RzjT8F8ut1Hdp2px7XM916fUv21bMx2oIvdOHoXq0IuLNl6fQRqhuUrE8uJaqrEPe9DVc8d4tgTWFNPPxoBsuVmBLAtGSz1rUiai6w9d4PM4OLaddceta5ctI/CKh0i/1JlNzz00SUc3ikn3p3svHoXuSUseYTEFMQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8013.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnNEVnVvMzNrb3JPL0c5bkw4UGgraVJ2RjBFaXVZYlFneFo0aXJDZDN2SHZ4?=
 =?utf-8?B?WHBlVGtMNjhrUlQ2SVozQTNDM2VkU3NBclUyV0owcXM2bjh3SW9IUXRDbGN3?=
 =?utf-8?B?VFppWDdNVkRPbUZuU29mK29vNklycDEwNTY4UEEvb1M5NjNkT0NwbHRJdEhw?=
 =?utf-8?B?bTVIQ1lWcmJSY094ZzFlWUVmMzFSMEdYaGtrRm5FVUhmQXpaK1R3UGpKeXdX?=
 =?utf-8?B?ZDRYd2YrQVN6L3dpSGVSQ1Q1cE9CWWk3aE5hanpYSmtiSzFKSDBicUtLTkdk?=
 =?utf-8?B?VHFEdjdibVlJRnJrb1VqU1JUd2JNdFBTUDdSQ0tTYXhjcncxQW5TMjRIeGQz?=
 =?utf-8?B?cHQyMzlBUXNoVW9PTDZvQWVheFJlMTR4aXZmbjVxcVBHL1dBRmEvbzlMcTFT?=
 =?utf-8?B?YnpJaEtINFRMQk5OejZOUjJXUzNBbmtyVmZNbEdOR3g4WlpOYUY5VXJFcnRW?=
 =?utf-8?B?SWIxNEtOVDFoSjdqYWcxVHdKQXVHRVlkRm5kK0YyVDRQN2Q1cE5abmwrUmNv?=
 =?utf-8?B?b2lqVFhMV0t0VkdpMEhUb2ErYTU3U2NjR0RKcGsvZ0E5T2htT2lUSXVYVFUv?=
 =?utf-8?B?TkhoNWhLMGx1T3EraEJycW5UOVFNbXZsM3pvM3pOeWFXNTdqTndpN0pJMHZF?=
 =?utf-8?B?L005UmwrbzFIMTFOR1l5YUhjZjczWXlVQlB6VER3RmVOcmVqVVZZeG1neEU5?=
 =?utf-8?B?NTljaHkrSXB4Tng4bHpJZC9sdGRPMDgzTkVZeFdFTE90am5aY3lQWG8xRzY0?=
 =?utf-8?B?VVFlQk5sNnJmVnBQS3A2eHFaVk91NE9aL0x1V3N2dUkyZG4xZlVoNnAzYjFE?=
 =?utf-8?B?LzcySjcrSnZiU0hhUSt3K1M5dytnejJGU2JPelEwNWlZTElLSC8zVGtiK3lh?=
 =?utf-8?B?VEoydEtsY2dsYkdLVzZTb0MxOWZLSmFkQ2ZnK01MdXFBS1NWZmhYalZvejZZ?=
 =?utf-8?B?RDR0OE5yYmFpN3EyTVBNOExYWGw2QlhmR1FEOTEvenBFYnhtdE4vd0ZDMVo5?=
 =?utf-8?B?VG9SMXJwOGxaTkNQeCtIRUUwVTViY2ZPeTdLU0dEYmpmbzNrMGErbkFtRTI3?=
 =?utf-8?B?UUtLOUUxbUpwRWJnY0xqZzhUSXhySE9Qb3dUc1Z0YlVEK2hUQjNTRHQvYldm?=
 =?utf-8?B?NkIyN3VNMEQxZHFaTWpEOE0yUVZuN3ExUjZzNmxUUHZLL2JqK0xIZTBKb0hn?=
 =?utf-8?B?TDdHQ0pZWlF3TGQ3MWxuU1V3L21zVUlJOXNLOTdDTk8wMC9Jc29WWThxTXRI?=
 =?utf-8?B?cXprb0c1MC81ZkNxclRpTnFTemtKaDVnSFBJN2U5emJ1TVo4UzM0blNEOG92?=
 =?utf-8?B?ZEFxTzMrNlpFK1Y2NmsrZndtY3hGRG9uT01GeWU5QlcyS1o5Y1lpY3pJODdw?=
 =?utf-8?B?OEhpK3MreVp2MDA3TWtnWWxnZDEzOGxZeEVMdkhQaEJXK2NLbzhzaVVmVFYw?=
 =?utf-8?B?YUFtNkdnaGpZTFZtT2NXL2QzUlUwdkVHc0JaNGt1MlhqQytzMlJYNUdhZy9X?=
 =?utf-8?B?YzBOVzV4NE5CcjdKTDI3UE52Mk9UdWM0eW9jUWdscTAyQkRsQ1Z0MzBYZWxO?=
 =?utf-8?B?WUlvZnlLUFNUSERpYkxETVpFOTJPODB6enBGK0V6MlpBNTVva3Vrb2JNRFp6?=
 =?utf-8?B?ZWwyTXVqd0tGVjA4NFBaeXhwM29yTGxnWmthcUJnYTRtSXdnUlBSU2ZVejNr?=
 =?utf-8?B?cGRkbXNmNkFUVlJVakIvUGdsMVZ3VE50Sm5Jc280Vk1XWTlwcGM0MmVJNVlP?=
 =?utf-8?B?ZmxvL1JTaWRZNmFJUUtrOGdjQkZoTW5BQ2xHSlFtbHc2cXkvVXZnTmFrS0NI?=
 =?utf-8?B?WHFuRWg4SWVsWDY3cE96YmtKQ0lPcjdkM0ZQVFJqVGhvOXpTM1pCUUthaVpL?=
 =?utf-8?B?dDZOUjRaRDJhTUovcURmSzFzZzk4RnAzVUdNaVpqdW41L1RlUUkrUExDT24y?=
 =?utf-8?B?cDFzbTdaaWpUMmJsbUlrTmxnV0VjTmhEM2tKNEdBU3ZDMTJPejFWOTFRQW1Z?=
 =?utf-8?B?K1htRGdGL29XbFpVT0tNMmgwK2lRRE9Kb3hrb0RwOFlHOVN3aytFc0o3Qjcx?=
 =?utf-8?B?dGpiR0gyVFpsMkhnM09ldGU1U1NDZ0luVnlDd2JoUXI2aGRjZklqbjl2YkVW?=
 =?utf-8?B?eERYMUZ2UWE4SkpMTEJjajRjVTJTc1RmNUNJR1lBa0hLdWFkVGxLenFvVFE1?=
 =?utf-8?B?Y2Y5U1loT3lvWnBrd0lKcmxOMVViSVJaSXpqKzhkM0pwYVFIUGU3S3lEMkEz?=
 =?utf-8?B?OVZoemxkRlZiQndlUnRSYjhCV2JTRGRCVTYwejc4WUtscnFJSC9IYTlKWVhU?=
 =?utf-8?B?RWFuUVk0RU91U1lkajJlU0RqZkpmVDBiL0VsVjdOL2xXc2YvYWNCdz09?=
X-Exchange-RoutingPolicyChecked: tWYZer5iwAXj6Sk14yvRWLp0t10HUOUI1xL99GsoWRsitCh7AuvZJGtLN3X977NNP1mvKunHp2UDCmG6nmDGU0P8f3ETvEdhHNmg+0X7puSpJXm9FLGUIb+WS8CfvcUQTVPLLNmO2RWoO5etmDHXJ4tjImwD0iSHLG6h6y8zbklwH6KUBNjl9iwTS3Dgy3Hxhu2rGyDdiyjZOBdtXA8rRdEEglkK6HVFO+28puvI1La02ss7jQQttI7rrn8KjTnes9+3xhPrb2CtfbxXO5GRdZHfnnLxnOIAiHLb2dbz8NTc36+D0b72iNqMcICSCToLFn4YXjmozExwe5TlwkT7uQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f93bfe-2a57-4b74-ed6b-08de7dc72d18
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 10:32:34.5795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92ZULQGCLzisXxizz28e775D9V5Zg9k8T7AKwW26e1isxx0TGNPxFgJOjq4CZUXflaN84iPKx+8Iv2q7ocUaanMAvYC4KbC0H/AbvBwYbfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7037
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773052363; x=1804588363;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yV+wWjBmKcR6TbgffFE+zob6nsbmROAAxVu4tWNU1t4=;
 b=hi8+rFh+Bg/WVN/bV+D0E13X4vN0I+bBfbyLn/dx2Tx+LZX/4MQnHOYv
 X8rjSlpbHiy5+15wwpl/C+dEj4wPco1mjwF6ebyoWc3GeTRycj5KHOhQO
 wEvi6Vj96Sxd+kw0xYDMW7jY+RFIyEjjVnMVwJPmUcL5+rgoegcDx7Igg
 6nkMBKucO99Sx18zWTJxxdps08Opbcblk4PlESxlrT4m+COW2yY7JA1ZK
 fXj7j+UTrbsI/zkukpCqD4lQubgw0h87z0cYfDXccKuRbOC+Jcc2kun3T
 OpkDcwWOyI993SHBDTRO1wT8Wi5jViX5rB41M3XzdGAEdlnRaKdFerF8c
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hi8+rFh+
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH 1/5] igc: Call netif_queue_set_napi()
 with rntl locked
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 24/02/2026 13:10, Mika Westerberg wrote:
> When runtime resuming igc we get:
> 
>    [  516.161666] RTNL: assertion failed at ./include/net/netdev_lock.h (72)
> 
> Happens because commit 310ae9eb2617 ("net: designate queue -> napi
> linking as "ops protected"") added check for this. For this reason drop
> the special case for runtime PM from __igc_resume(). This makes it take
> rtnl lock unconditionally.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 

Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
