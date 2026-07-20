Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150FFC44515
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 15:06:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF6D280CEC;
	Mon, 20 Jul 2026 15:06:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EIdMdPg5yI7O; Mon, 20 Jul 2026 15:06:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 173A880CD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784559979;
	bh=3GJM6Vgc9h8Zu9NUTPSQ3tDe0wumlxW8SxwGpPmvyAA=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jy7HSzPvY3hW4lglIks7IXevCdZpWF/qAruLf6vM+3yPlJj7AQiJnflrXuREA2CnV
	 CVZKiMQMMvstz6WRVSC7UTxdYznAySaO9mSZ5R5sr85dGydeh5LrNR+8Gaf/zvUWy/
	 OAeKdpT/IWCcHCUyHSgbiSIgfU+VazMZV7/jEogsZajpKxI6XnVeSWOQwqyqtXgcbT
	 wOj3TS5mpMCBHO6UxHjoAfYLbNOHj2Db40qagdO6LOQnICw1zGo3bjSLlynszW9G+w
	 8MoaXhXUmVYRxfMrBr5rH9GPPZMjmG5JNPRUx8oF/OiXW1BZxU2oCsDWA8huqtoryG
	 lPLoINoxd34Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 173A880CD3;
	Mon, 20 Jul 2026 15:06:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A317E206
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 15:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 942BC80CD3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 15:06:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8M2ArsW-Ives for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 15:06:17 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BCE5780C9D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCE5780C9D
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCE5780C9D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 15:06:16 +0000 (UTC)
X-CSE-ConnectionGUID: CNa+Pbn2QKayhQhvwLNXZw==
X-CSE-MsgGUID: LLONa09AQXuluGG60KuRQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="88964668"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="88964668"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 08:06:15 -0700
X-CSE-ConnectionGUID: OpQlenenS7iw3+KR/IDdNw==
X-CSE-MsgGUID: QARjLYblT3+M47IW6o8Swg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="256301692"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 08:06:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 08:06:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 08:06:15 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 08:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g312c9A/0mOO4hX6cK+o9DWSgOOQqL058yB5MHVEvwpVWQ5KZiYYlgou1ziLwhvNo0CkDCx+C+GeTfHiIJsYy2MmO2/eHdADyYMPJls+YYokJJy5XIykj3vo9fHc5QlGM4e2GYLW+1xwbXxnsxYko7nZzJLokO6zIEmuVMj8VnOcNvU5SSXGjkKIGQZQg46xfrcnxlwxf1ZMUKLTPbG7ZJs/ZCCOafRJtNmeHmCIBlsKjlqaTmtxbkqZPqO4VdrI3z91dvGYQlWNNBOpsut0HSVSv0hsvvFQmgfiCUI1skXNiC9ujLL1W4mDUhBze1Np7SKaV9HKNM3BDER+DT/0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GJM6Vgc9h8Zu9NUTPSQ3tDe0wumlxW8SxwGpPmvyAA=;
 b=Ybs+Cuyk5YUVByPwQskhf1DwV2MsAaCo8+eJUYYfDTwnYIAO/O4PSfvmNWv+d2n6beHhjC+//gar2kMbG3URD5jt22bpIXsds0KCXbOduojCwT/Nac5NsMR9Cq1xd7kCnvpBMknpgDB565fa5foHGsyJse1TRjRUYZJ77gal5UFTV3O0aKWYgPMxJsvgXAkh6Us4uT7itVriVKfrPON0148KpQGVS8tgnqU/L2VS4YpZxh4itRvbm3U67n5Qs6khkrO4KFkOriwhH+1Pu3RWUSQQJ7zEfwMWdTBQfOfG3Oi2SBgUhVDG7eHN4EbGFgCPsbM2kWhM9nrqCUjbCrrO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:06:13 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:06:13 +0000
Message-ID: <28460003-47ee-4706-ad95-7fba87d36509@intel.com>
Date: Mon, 20 Jul 2026 17:05:41 +0200
User-Agent: Mozilla Thunderbird
To: Weimin Xiong <xiongwm2026@163.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
References: <20260716025100.118145-1-xiongwm2026@163.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20260716025100.118145-1-xiongwm2026@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN6PR11MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c8ab25-8102-4b81-9989-08dee6707046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: FJ8Oggn0m2kEhgYjp7mKBRtUseURi5WA4Li78mlT5t76hAsdYcwpTFhDmkHVZ2uvbVZVkxBgrZc7x0XclqL2L0cBjuay5rzi0VPq+Fxp+XWECdzyO37lQqD5LMkzdYLgMpSJyJOcerDM0W7R9SN8BICyiPwxUk0zQR6DoQyu0FgmcJOpI+NfMRPzctUw6H33ie+FjBO+s7zHn7mqpbdre7NEFVaz9oYOPMM/YL/rZBF1EFXpEUNImbkrnLdPaxKS2Kejxg0FZ/UAG99B5iLjVXLPOYmIvwTyLDSAgy5aplpa/Q0/57PjyjFajVWBn/zKi4P2Zb21OWZDJA2viHSMML+HErmWZRJbWX0dQmSewMqFy3dmp85qxP8AeNQI5gyQV39VV9SQ5m6NECtJERbYf3KmiU7u+/ejx0CdRooRP3sJEZJ6kXrd2zQGUvitVaIHv8nt7FpGtYPv/QCm833MiP42+dLXjEx2xCK/SCd+pgyZio231Xi1GXM8tWJx+mLlooHR3+q557axiBFYzYx9O3X9BZ8gmiBkBZiRL23QvFjxMy1McGbMO8UKT9fDp6zypbRu4my5dVhwlpBhF3/WUdN0AWbqxHwMLGZZ8NC9SU4ZVGPkrm+qIYoqYKZkGtz+sH3FIpMipXj1s5cZ2MSlgKTXCbkCj2ZGhzJf0M+chE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YklFRmpLTDdQY3A3MlBOb0ZZQ0IwaWhaTEo4cUg4OTQ4dkI2eEFSQlhCQ01B?=
 =?utf-8?B?bi9sWkxJSnlCemxyZHY1STNkdWo0YW5QRmtoc0J0YnowS1pLc0lhb2xnWXI1?=
 =?utf-8?B?eTRueVNSbmgzSFZFelhRem5LN2pPSE1uNVJPakJnazVJYTg4OTBKRWpSMUNa?=
 =?utf-8?B?RWNJNkFSUUxOWHFMTldCTk9UUDJ3aVpYcEFUK1ZaTVV5TjFQQk56b3N6V0tX?=
 =?utf-8?B?SUh0VFZOMWR5cXhpcGl1bGNyUTNmd2lwSzNReHNmQnhpb3ZwQ1BDSW5kd3NH?=
 =?utf-8?B?S0dZVmJ0ZWR5OExPblp5TkZzWFc1SlNTdVRjZnV6b2Q3cGROaldmZ3JaTkpl?=
 =?utf-8?B?M2ptb2s3Sjl6cFZjbFMyVDMrMHl0MmEyZEFKekhRbVlNbmU4aGI0YnVkWE9G?=
 =?utf-8?B?L3JCMzVZYW9CV1ZxL3dpQzVMMUhnalcvbG5jOGpseWg4amtXVHJKdkJjbjRV?=
 =?utf-8?B?Q1VZMHhQM3ZscGRnVTV4ZWVqQ05hT3hqSVZzc0ViT0d2dldteEV4cHZFWE9I?=
 =?utf-8?B?Wk0xUVBtNWhhRUdpYjhzNG1uTmpjZENhalVKYkNwc1NqcENNSDdWWnpITjFo?=
 =?utf-8?B?eEJCY0NBdGlwYlRVVlJDKytDbW4wWXNsdUpkaFE0dWoxSXVtbEs3WVV0OXhM?=
 =?utf-8?B?RGk5b0ZIdytxR0RpaDhVdFRtSXJmeU1mWHVWb3NtWVFzWnNYSk9XQW9ocWEx?=
 =?utf-8?B?aDIwNTJPZUhtaExIVGxFSmk2MFIySkVRaGVsWDhyYXRWT0FwZ2ZTZ2dNU1hT?=
 =?utf-8?B?Q0p6Z2JJRXpXanhkWW5QTWlnZTRCSnZKUUNpK2pXNjNkeExmNWpFTzhoVmd1?=
 =?utf-8?B?UW5zdFFyWGlwbEJScjRCeVI3UnZ4QzBPOWpaRHF4amJwSElMd0pNR2tpNU15?=
 =?utf-8?B?OW1zVjAzR3g5WmM3TjZRejZLb0JqcWRsZ2E5cGdtM2llV3hIMUIycVNwYzhr?=
 =?utf-8?B?STF0bjQ0NUpwcWNoKzh5RDA2S2NLNVl5OFAyL2VrcmN6SldJUE5WUC9PWWdB?=
 =?utf-8?B?SVFIa01tbXNsRGNreldweWpDUkRVNzJnR3YrT1ltZnhFd0gyRXFHS1FERUFU?=
 =?utf-8?B?TjhUZDhtY2E5bFRZU1liWHF1Q1dzWjdkMi9TdE13Y1VreDV4aW84OFVjTTg1?=
 =?utf-8?B?aXlPck16UDl5TGRsNitCL3RzV05nT1RBcTNyN1R2QVovWW1tQlcvbi9GeXlU?=
 =?utf-8?B?Qi9MOFhsaGJNbnBXbEo0aXZWejhGUTdWOEdNRjhxTjVVSzJRYmg5azQ5T2tr?=
 =?utf-8?B?dHFBQjRmSWoxZG5ZUlRYZlo4aGptcXRVNitsRERxM3dBOHc3cFJzTVdqQTFF?=
 =?utf-8?B?bmdkUEhYaWdZbTJDRWUyVmxZSHkyYVo4Y0lZNTgzeUhaNkoya1J0RE5COG15?=
 =?utf-8?B?b3FJeVFQWlV2VlZlcDFZc09mZ1V4dlIydmk4NCtFdTNzaTFQeGdTcW40dzg4?=
 =?utf-8?B?MDNlck45RGswTEZicmltWFhIajJ5bXVPUXl1K1VkU1dGYkZvb0h6Z3UrQlg0?=
 =?utf-8?B?SVhiOGpHbC9uZlRuS3pFVkRkMXp4ZzRRSStxbGZzODF5SWZwbGlkaW1JLzhC?=
 =?utf-8?B?WWZQcXI4OVhVanhFRHlFUU83Smp2QnpNSm92NVEvSnFRYVJZYWhWOGJpRjRu?=
 =?utf-8?B?eHAwVjJPY0Y5cXoveE5zWnQybWU2MkxtMmpNVFdiU0ZFMXdvS0Q5eEZ6c2Zi?=
 =?utf-8?B?TmVaWjYvTml4MHZFeWQ1V0FRcWN6YzZHd3haNGc1V2RhMUhxUi9oK1lZbzVn?=
 =?utf-8?B?b2V6akpZKzhnbjJiN1NGcWtmeitxd1dUSTdqakJkbEFQTDdQai9YYUNoL21h?=
 =?utf-8?B?UDdoekNoaFFLdHVXYzQrZlBiTldQd3hqcEk0TXFEQ09KRWZXRElPeEE2Yld6?=
 =?utf-8?B?MXVEeitOdDl5Q3hFNWlTMm5iWUNWUUFtUWRSUEJheDZySzk1SzlpRktOMnlB?=
 =?utf-8?B?U0FvbWFabWFNWDhKelpvYUlaM2JFU0c1bHJFbDEyZGcvTlhCRkFZYS91K1Jy?=
 =?utf-8?B?Mkg1OHBXQ3lSSkxmV2FaUzB6RDU3SE5BY3Frc1lBYVJKc3BXei8wdlZrd3NP?=
 =?utf-8?B?NjJkNW5FQWxMMzF4dVFDNkFJUXhZMmlwVDYyMGZhYVJYa3lHTnFvaWVXcFh4?=
 =?utf-8?B?S29sSWxCN2s3dUZhNGpHcGhvbTVtZW15c3F1U1RCZHM3YnEvckpEZXR5ck9k?=
 =?utf-8?B?V0hJUTJlM1FtSVVwb0RTK0UyZVY5ZzBEKzd2Wnc0eXBQckFkVHpRUWtWWGtD?=
 =?utf-8?B?MHVmczZ4NHRCaTRmRm5aQ1BwRUtNaTZvdjJZdEdsbSthQkFOeVE3T0ZyTlRa?=
 =?utf-8?B?V0ZPLyswS09Jb0ZwQjI5cGJwR1ZKU05UalZVNXcrQ25oV2FWSDFkSjRHaVRq?=
 =?utf-8?Q?00hAk4SRhEnUwpgo=3D?=
X-Exchange-RoutingPolicyChecked: hveaZCeSFxL2J7GlCHRaETRS4BwA0a9lGCGYFJdnjM0JqzyWVvCmGiRurPYxCdGuP4nIZ2t0S69QYvVNJqPQUODCvIubZaLY/FfSggSkphrp1kvrUjUE/jDC5c9HxClaJK8OYFS8CcS1cXWHo0IDXZjcBtbTfUSwOnaXVvNmnVYFG4hWY/oq7f3hejaJ9tygPjm+qf4kcv6TiELkC09vg7NvMgGoI4ESTnX8LDNqJvbE9DgPYbunKFxxZlFGl8rCnZ2hP/Y+vBLavRSygYEYgJ2j1OOhH3z3FJlmhYn3HyqfP9deZbsFA1JBEe4g+rhbBbMlR4OijriWrg3AUsu4DA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c8ab25-8102-4b81-9989-08dee6707046
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:06:13.1099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hz1l/9JwDfpjSSdt3rMo8IUInXetI6YM5WgDGh2KSpCmuq2PzwOAPnN6qNE3YqmXxX9A8fKly4LPEVsDqUNw+KM+rsIWlg1LuMDBglZW5lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784559976; x=1816095976;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cXaGzqDNmlZAdBNuZwwAfD0MYZ6tGk611m9PG6FpQ9k=;
 b=nYigj0qTW/jZDruMqT7BLBRqws/4fisthXiKhwLABC6zxNCQVapUhTLx
 emtugzmY+EJgMYX0Ln5Y5K//AFmXoy465NZ5xrfu2mCpBggLQKRSHm4OQ
 +VX+YHoQhrdkpSEfghvb8NxtyUXDGhVFzoigQBz9mWtRFDJVpE3DPSLJ7
 RSrtvEQdDMM8GEJIqXqZKUgkPmzkD2SpAYJx7Th0JWl+7kg7cu4CelFBk
 4Te9Z9ZbdDaKYP839owj58ql5hTbWCaKX3T61mPXNxY24jS7YoAAPZPz4
 9MeyvWmrX0DTHTtdXaLlMXfIoMPIwfsvxypE8jyLLKc+I3L4pSzZBQask
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nYigj0qT
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH] ice: parser: use array_size() for
 table allocation
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

From: Weimin Xiong <xiongwm2026@163.com>
Date: Thu, 16 Jul 2026 10:51:00 +0800

> Use array_size() when calculating the parser table allocation size so an
> overflow in the firmware-provided item dimensions is detected before
> allocation. Include the overflow helpers explicitly instead of relying on
> an indirect include.
> 
> Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
> ---
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> index f8e69630f..c109d3c32 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (C) 2024 Intel Corporation */
>  
> +#include <linux/overflow.h>

This is redundant.

> +
>  #include "ice_common.h"
>  
>  struct ice_pkg_sect_hdr {
> @@ -102,7 +104,7 @@ ice_parser_create_table(struct ice_hw *hw, u32 sect_type,
>  	if (!seg)
>  		return ERR_PTR(-EINVAL);
>  
> -	table = kzalloc(item_size * length, GFP_KERNEL);
> +	table = kzalloc(array_size(item_size, length), GFP_KERNEL);

kcalloc(length, item_size) if you want to make it _proper_.

array_size() is used only when no array allocation helpers are
available, e.g. for dma_alloc_coherent(). For regular slab allocations,
we have a whole bunch of different array allocation helpers.

>  	if (!table)
>  		return ERR_PTR(-ENOMEM);

Thanks,
Olek
