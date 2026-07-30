Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C683EC54FD2
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 09:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C82080C73;
	Thu, 30 Jul 2026 09:09:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jtc10Ec0dg-w; Thu, 30 Jul 2026 09:09:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A54C80C68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785402562;
	bh=uByXzIDHkUu1oi0UtoEeDGeCco6mXb8iFf9wRwo0uAE=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PL9jhD6VrhIWNpCT/e5MfzjstcN+rpVwthYpQg1ByurBdTS0r2v9SLt+Tn6rC4P9e
	 YNbrH8ElyeFhcmlaR7h/hY5XV82uUwdbo7BX0EkWQ3J/n9RNosmVYZOJwNvrof+T1n
	 kIzcmaAj5H68uXzO7fbLONwHBZeXK0/fLmnyJU+vaT2Hvf0Kpt54/kn4sDFMGlhMAK
	 +g6NJNCPTN53DDOCjGZL7bjONoIwgE+qdgR0mDy+ggMdRFTpD1ERhg1xo72Q675bl2
	 iSs55OoUHiLXnr9kihHE3dxyAte0rNMEMRjFXwBPmyqlBrrHmCZ46xDF1h4Wl8z6ZD
	 vJ6P/JZj/FIAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A54C80C68;
	Thu, 30 Jul 2026 09:09:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 009AA27C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 09:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6B5D40767
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 09:09:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ze3II-UTkcSh for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 09:09:20 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B608B40726
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B608B40726
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B608B40726
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 09:09:19 +0000 (UTC)
X-CSE-ConnectionGUID: I2+ciOQGR4ux0gIrCrclSw==
X-CSE-MsgGUID: 35IETZ8cQ3qm5HzfbdYj9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89697957"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="89697957"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 02:09:19 -0700
X-CSE-ConnectionGUID: ByJS3DojS5et0T73WRAR0w==
X-CSE-MsgGUID: BklKv1oCR0S6jSlCjlkv7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="260303912"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 02:09:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 02:09:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 02:09:18 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 02:09:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdPpv1zER3sJjkAGaZp0sFbpqQpHefGdP5Wtc976jVuDbmXnVynAyXig1AAIu9rV4vxQnODUqIN/oZ94LQtG7hUhkv4nFhh61st1ddKEtNVj9JszVKjbEVMsimhxtWVwIYYgPEYp6Ygh2Txs9rLLM8mBEEdfBO8XlQ0Z9r+f+/tq0EzP1tRNWYP9CHBT/UviCfKO8K94PJJqvHfcqzQhAHmp1VDKO/VLVc2oC0bLg76M6hCATkAqqTOPbxUNQ3qTw2CXYteE3wgPrT5Nr7X+pWQO3RbQn+vL8xd10RK3beF+yHqEO1hwqIn+m2ZV6BSWPL/4zspAvzRz78895OmZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uByXzIDHkUu1oi0UtoEeDGeCco6mXb8iFf9wRwo0uAE=;
 b=dkYjuIxcx2K8pZlO4o2iCwY1egDLgFdNq1d6ZFqgQnxUHh+2WrWQXzQ/I+2xSlXA6reomFGuOY7x8cA8jEK5mQ01AIlZFTEMeaNrOgw59coSPi7DxBOg6I0pxzH1zhcL6JUHbLbs8zxhHr3RFWJbzEaggXYrZy6sqI7GIhaN1IuT5gshLVucxXF0lvC9uLCN+p9yaZQBayaT9qGztW7vLKutkvQF+FNSUY2bzocEdgPC0siWHjJ59NMXHgLHz/mrd7B3MNWFaEnz3yfAvZsS/ulkTREhOP1sAcerZ69m5hfVTO+Ak/KFyoXClEzOzyPzOzaEHS2YKaP2LdMMCnnahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB9498.namprd11.prod.outlook.com (2603:10b6:8:261::10)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 09:09:13 +0000
Received: from DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925]) by DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 09:09:13 +0000
Message-ID: <7ba33aa9-97f8-4b14-aba5-40335e0ce2de@intel.com>
Date: Thu, 30 Jul 2026 12:09:09 +0300
User-Agent: Mozilla Thunderbird
To: Stephen Hemminger <stephen@networkplumber.org>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>
References: <20260722084655.2d190adf@phoenix.local>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20260722084655.2d190adf@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To DS7PR11MB9498.namprd11.prod.outlook.com
 (2603:10b6:8:261::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB9498:EE_|CO1PR11MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1cdfae-9c54-4568-cad2-08deee1a396e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: J+KFcXk+LTxMN/IW13t/eu+nAhblYbtD+yREvbxGiWJ7VgDAqhErVJzzKUmQ3/ehcQm0WEHD040/LnaS+oUbEAVYTYnk1z2ER3u/otq9f8LrltO6BVD7DDGWsGkl1TNMW5+ZMGEmRIvA4n9KA+XyXgBVeo0RZhKHodrSyy38uC5kBYFn2PlW80PlMd8JjZ1TDa4rjs2FoIRajoVr4ioyX4y3weAFPMXeW7R4VvX8ohDRGGSRXWP9kfdKKjxauXLGSDYI20VjooMcqMzQgmE4EFKPujwqsRAmaYBfussXaUW7dQSTrY2kkZv+/VXu/b/xxdoS8bHMrT/dmiJch8Vphe5/HtmVwI20lR/als/BZeHE/HdVeiLfjJ1XlGGLREaP6k8vqLDNYa5AJ1vvQjhQD4t7+1pVc4txucTcU5P7cbUa1W3ahTe/Kp6v33/3e6SyL4kcsoees5OuLHxEJdhiOCp8r3iBSbkj033Djhz8BlSg2sXLwWaBirbv9OV7VlhbDaaUEeVbISBaEY5z+O5bm8QU97zFnv7pQAzG6T+6JaOhbtlWwa07Y+Q/FABHimR63E5/j9B6Py538y7JxKXxnIXkDZyd7rZ4bjVde9DGuZ2YiPZDf5QHEntotpjlTaGjDB6vYwKdRdGsxAnWrEJR3w+VMrP79w5OGSlum/NUtHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB9498.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHhqeTYva1FpaHl6d3pBb0NzTjFXdDYxTm1QUzQ0T0gzVDhjc2pLcmplZWpl?=
 =?utf-8?B?YWduTFRuajZtQjdYWGZYTzlxbDVjT1lyUWdKSnlteFRkR2NFS1BIaHRXRkxw?=
 =?utf-8?B?ZkJRRHhwUXVhT0dXWXRyUk5iLzRWTkY2WU1aeXlqZlFueWhCMXdMRU9JK0Fn?=
 =?utf-8?B?S0pOeTVRb3BRYzFScEh3WGdSSFhldzM4SG1QZldoRjIwaDJhWXFiVitzN1dQ?=
 =?utf-8?B?bUE1WXlwQ0k3SEhJRVdEc1d5Y3ZKaGdHQzJWenVvRUxqQW40Yi9YQnZqaDln?=
 =?utf-8?B?YUM1cnZTcEZyUjRpK0lQR1ZNNFBIWVh6WGxSYWNSTmZQR1o0VWRsSi9FM0Vv?=
 =?utf-8?B?dUFsZTFOUkV6ZmE2MzlWaElxVU1YalpJQkIxUVpDdDlkcXhWejBrSVJ2b3RT?=
 =?utf-8?B?SVJLbG9uK2pEQks4b2tSUm1pKy9nZFZld0hJMURyQzhyMW1wYkN1MUFjWGpV?=
 =?utf-8?B?dDVVUWtyYVhON1BpTmwyOU9lVnRHZk1UVWtqU1M4V3NSaFMzTGVCQUV5Nnp4?=
 =?utf-8?B?RlYzc1d2YllEQ1ZuVUpnV3VsMkhVelVZcnNMTlhYZituWitDQkxWbmxQOW9m?=
 =?utf-8?B?UnF3UExqdnE3WWJ5bm5vVjJQS0VjTmRkYk1VWXpXL2IrenUrSXVSUURhdEpL?=
 =?utf-8?B?V29lZUc1aGFrZFErYVFFMDdFcE1TK09nemZoLzRRcnpneWxNZlNzTEpyMHlk?=
 =?utf-8?B?N1NSQ2JoUFVOZmkzazdySStjc1lJcnlkNXJKNEZnWVRvbUdRSWNBUGNOKy9h?=
 =?utf-8?B?WkJTeHp6dzFCUWdLZ214QUxVaW5kQUZObHBqQjhYeXd6NzJwcTdVQ0dOTWRW?=
 =?utf-8?B?TlJpbS9YdWF2U2pQZ2szTzVHNXlkUHF1a3ByL1A2bmRwZEdIUGZlZFR5N2xo?=
 =?utf-8?B?UFlNZXVOVEhYUUEvRXd4emZtdldDOGE1VERpc2RWN090bDBUOWIxV2VXN2JG?=
 =?utf-8?B?MnhkdG5RRUZWaTVOK1RZRDQzalova1dGcjdyVHAvY3B6ZnV2ckczUHlnOG13?=
 =?utf-8?B?UWFTUUo1ZS92YTAvUVREcVljb1pWZWxXd0RDeW5uNGpKMnVMMlJrQ1BZNWlT?=
 =?utf-8?B?TTZpb0JlM0NvbTljblpZVGJHTnB1N0g2YmxTbTBzdHBqNVhCRHpxYUJhM2wy?=
 =?utf-8?B?Ky80VGZDUXB4Z3ZnZzMrLzdmT2NKZkZSNTl5WFd5Y0N5RkFzQmp4L2JlQ1pH?=
 =?utf-8?B?U2dtT3ZNdVduSEJORjVwNlJYWmROamxpbGdqUG1KUVZSTVpRVDVjWXFhaTFk?=
 =?utf-8?B?R2hkSkFrRWt2Tk42YmkyeWViZkZDcnFzdjNENndBcHREbnlQYzhDQXp4MWJH?=
 =?utf-8?B?YUlqRVhpeEgzRDd0NzJ0YXNuV3hDZXJ4S1JnWnlzdS9Id0JtSEIvVmNOekVM?=
 =?utf-8?B?ekIyVEFpR1RiaVZjTFBxZ3hqekZMQ0tiS3h6V3ZsMmtuRFFjTlJzZk8rNjNK?=
 =?utf-8?B?V3VTQU9PUnhvYTBreXJMZTZ1dDZQYXVoMEVmSlh4ZVliQnlZWlRBMlBiQzNE?=
 =?utf-8?B?TmxWYzJ6RkRFTHZSZ04xM21jbldFR1lObitqZ1lYT09KbkllOGZpZVVKSEgr?=
 =?utf-8?B?OE5qVmduM0xXWnJ3VHFwWXpVdm51RGZhNlVPeUVRcnE4Q3A0M0dHR0oyU1ZI?=
 =?utf-8?B?TDlveTdTbzQ5WDk4OFhRQ2o5NXY1RkRrM1dFMkpyWitieVpiY3dNZWdVS2Zu?=
 =?utf-8?B?djF6UEVFWjc2WTBaWHF1elVLc3gyZGJBeTVzRXBXa1F0dlZEbmtpYmlBL2wz?=
 =?utf-8?B?bFFXQXg1eGhGYUNwV3YyaDhkTzE3RllOTTlVRHVmTHozT29iUnBGL1ZzZ0RQ?=
 =?utf-8?B?OUExdFRvRXFnSUoyNDhYZmFpeDBFUjVZOVBDUHpLbWlBVFNHVkdrQnBPSDBK?=
 =?utf-8?B?WmNsZUJIallSWlpwdHI2WjdLUkJhMWtXb3Y5OFhCRjQ1dmZBOXNXV2FrUk1q?=
 =?utf-8?B?UGlPaDhEN0cvMTFUNXZ3aE9xVTd0M3dvOG5NQlRmK28yeWRZYXByeGN6Wngv?=
 =?utf-8?B?T1lLMkY4MlRiajBEcFVvNHJ0WlEwaDE2dmxnK0pJRkZDZDdrOFFmMGRzMWc1?=
 =?utf-8?B?NFBRMzJXaEdOeTRtQTQvN0o0bytlMUc4S3NtaHA5a2thb2s2QWJwbGNjRjBz?=
 =?utf-8?B?K0x0WGxwR2MwVXd4WHdNbjlHbU5MY0dlZTJiN1lwbmV5MW1YUHE1blI5c0ZG?=
 =?utf-8?B?LzFiNTN5OEdMUFQzQU9MMXkxaUhHTzRZUUFuVzA0bXRqYyt0MXBCM1NyR0Fx?=
 =?utf-8?B?SDJ3amlTWWhDYkdLYnVlejlZYUwyYU14eURjV2wrVjZtSFdHWndDMFN6WHJU?=
 =?utf-8?B?VUFjZzNOMjQxMHB6WjgraXZqcm9kMVVMTEFKUEU2QjlmSGt4UjRRUT09?=
X-Exchange-RoutingPolicyChecked: UuRTrran0lzBJmsnJ7bgG52MQ3ENs0ZOy1ad9zYMzV2LmXneVkkVFQ72ylHSonbCjLJynAhJVyvNRXTAJTYCr9vq/Rr3NJu7ef4bqMp8zBNH8wqJUUP/g5L5iHqd2yoAA1zke3J6jKCqh2qY2jmBrQwwaPpiWQNxWC9fe76/AatxUIc2L9cH3LB9rXWqWlYT/UYmxky2x7xyAeHTcmsG1wiujvfD1PLN4oUnUUVY+m4SkTOubg9F4kLk7vNhMGiAI1n5xQSzFN+IeudHmDWBSBHvDKTdBCjpbuP464YDbkhByotUQHsSvm90wRwQVoGkzsJ1ey/xyLdgxp0A5JrD6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1cdfae-9c54-4568-cad2-08deee1a396e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB9498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:09:13.5636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RO3Nyyp6VA1IVzBD+5AZisrE+vOodh4TGLxZgVKfnSCprTEsgsCSgvHT+3hFS9IaTF10Qlbn35kt4UuuZezjkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785402560; x=1816938560;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=esW7y5QQpa5tNR/7GLQSYsocb3wwMSfm969Ia+I9i7s=;
 b=DGS75jM1wppvRj6GrAayVzE8I2MpF7JDqBY0shasFgT5FtdUMvHvyzbw
 4SBSkcAGvpFqKqe7wSfpzGHTMtaepIyLyTLaguZ/8lsg/pecSI2e2OUa3
 we8aGR3MVTtcp00dvOXIbsn4wbM5N177oh63/EIJTjbdttYRaEa9tvAPL
 +RMLSmdr8FOfyOiqiYzigQ4GmfneWd79A6ZVabhmMfztMdlSMeCWE+fCl
 OsTWdC5oGBPGTRqbfSeTAA5U6OQmp28U9m54xrPyJc927WoxXvDtEaD23
 ZaArZuevcS8EzoMa0lgbR9OtBwjbbdLw1yNH5R0YAcjuU0xYP1nHaItkN
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DGS75jM1
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] Fw: [Bug 221750] New: igc: Intel I225
 silently drops UDP broadcast to port 68 (DHCP) when interface is a bridge
 member
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

On 22/07/2026 18:46, Stephen Hemminger wrote:
> Linux networking does not really use bugzilla, instead use email.
> 
> $ ./scripts/get_maintainer.pl drivers/net/ethernet/intel/igc
> Tony Nguyen <anthony.l.nguyen@intel.com> (maintainer:INTEL ETHERNET DRIVERS)
> Przemek Kitszel <przemyslaw.kitszel@intel.com> (maintainer:INTEL ETHERNET DRIVERS)
> Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
> "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
> Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
> Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
> Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
> intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
> netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
> 
> 
> Begin forwarded message:
> 
> Date: Mon, 13 Jul 2026 16:20:22 +0000
> From: bugzilla-daemon@kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 221750] New: igc: Intel I225 silently drops UDP broadcast to port 68 (DHCP) when interface is a bridge member
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=221750
> 
>              Bug ID: 221750
>             Summary: igc: Intel I225 silently drops UDP broadcast to port
>                      68 (DHCP) when interface is a bridge member
>             Product: Networking
>             Version: 2.5
>            Hardware: Intel
>                  OS: Linux
>              Status: NEW
>            Severity: normal
>            Priority: P3
>           Component: Other
>            Assignee: stephen@networkplumber.org
>            Reporter: eslopez92@gmail.com
>          Regression: No
> 
> ## Description
> 
> When an Intel I225-LM NIC using the igc driver is added as a member of a Linux
> bridge, UDP broadcast packets with destination port 68 (DHCP client port) are
> silently dropped at the TX path. The kernel queues the packet for transmission
> (visible via AF_PACKET capture on the interface showing PACKET_OUTGOING), but
> the frame never appears on the physical wire.
> 
> All other UDP broadcast ports (e.g., port 9998) transmit correctly through the
> same bridge, same interface, same code path. Only destination port 67/68 (DHCP)
> is affected.
> 
> This breaks any DHCP server (e.g., dnsmasq) running on the bridge host, as DHCP
> offers never reach clients.
> 
> ### Keywords
> 
> igc, I225, bridge, DHCP, broadcast, TX drop, dnsmasq
> 
> ### Kernel version
> 
>      Linux version 6.8.0-134-generic (Ubuntu 24.04)
>      Also tested: 6.17.0-35-generic (Ubuntu 24.04 HWE) - same behavior
> 
> ### How to reproduce
> 
> 1. System: Supermicro X13SAZ-F with Intel I225-LM (PCI 8086:15f2), igc driver
> 2. Create a Linux bridge and enslave the igc interface:
> 
>          ip link add br-fvn type bridge
>          ip link set eno1 master br-fvn
>          ip addr add 172.31.0.3/16 dev br-fvn
>          ip link set br-fvn up
> 
> 3. Run dnsmasq as DHCP server on br-fvn:
> 
>          dnsmasq --interface=br-fvn
> --dhcp-range=172.31.100.1,172.31.254.255,255.255.0.0,12h --dhcp-authoritative
> 
> 4. Connect a DHCP client to eno1 (directly or via switch)
> 5. Observe: dnsmasq logs show DHCPDISCOVER received and DHCPOFFER sent, but the
> client never receives the offer
> 
> ### Verification that the bug is interface-specific
> 
> - Replacing eno1 (igc, I225-LM) with a USB ethernet adapter (r8152, RTL8153) in
> the same bridge: DHCP works immediately
> - Using an Intel I210 NIC (igb driver) in the same bridge on identical kernel:
> DHCP works
> - Sending UDP broadcast to port 9998 from the same bridge via the same igc
> interface: packets arrive at client
> - Sending UDP broadcast to port 68 from the same bridge via the same igc
> interface: packets never arrive
> - AF_PACKET raw capture on eno1 (host side) shows the DHCP offer as
> PACKET_OUTGOING (type=4), confirming the kernel hands it to the driver, but the
> frame never hits the wire
> - Wireshark/tcpdump on the client confirms zero DHCP offers received
> 
> ### Environment
> 
>      Processor: Intel Core i9-14900K
>      Board: Supermicro X13SAZ-F
>      NIC: Intel I225-LM (8086:15f2, subsystem 15d9:15f2)
>      Driver: igc
>      Firmware: 1073:8754
>      Bus: 0000:01:00.0 (PCIe x1, 5.0 GT/s)
>      OS: Ubuntu Core 24 (snap-based)
> 
> ### Other notes
> 
> - ethtool -K br-fvn tx-checksum-ip-generic off was tested - no change
> - bridge-nf-call-iptables=0 was tested - no change
> - br_netfilter module unloaded - no change
> - net.ipv4.ip_forward=1 was tested - no change
> - No iptables, nftables, or ebtables rules present
> - No eBPF/XDP programs attached
> - The igb driver (Intel I210) does NOT exhibit this behavior on the same kernel
> 

Thank you for the detailed analysis and information.
I've done some digging and it looks like an issue that has been fixed in 
firmware.
Your environment shows I225-LM Firmware: 1073:8754 which indicates 
version 1.73. I believe the fix to be available starting from version 1.91.
It may require an update to the AMT FW as well.
Both should be distributed by the motherboard vendor. I suggest to 
inquire with Supermicro whether they have a FW update for your device. 
It may be included in the full BIOS/BMC/Bundle that they offer.

--Dima

