Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BAEC55167
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 21:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1AFF60A6F;
	Thu, 30 Jul 2026 21:19:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8A1Ay8uKkwYI; Thu, 30 Jul 2026 21:19:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06009606A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785446386;
	bh=IvJqWqlQmp4t7pV2AdZuZOAxjxOd0kvDvflrAD7b4bA=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g1ZqFU4l1grbCB95gp13pI+Jm8j8ja1DcLU7KptMdV8J83/YyusbfWmMwTY/8SlF5
	 adIwHhu+kCtcKPwDpXTGiUINvCkUwBUDRME/1fFxNbqul0IbI0GQZvtpcE+PJdzrAi
	 6BuY53K1rO1cL9Ea6HnnJS6L9cgI5w8O8RfpnRMpHcZQqQ5DglOYw5pATsasBwnRey
	 +WoLwITHglt40ME4hBsXvGxcc/1i6Prx/EDj0YkEy7VHVgV2FS11ewL3cv8+OT/Lki
	 ZIibv+u6EYjSDaioeul+g338L+1p76/GcPgdaJmp2/ASWwY3tZqYCyhRDF2nHb9N8+
	 qGaWLBUrHaNXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06009606A7;
	Thu, 30 Jul 2026 21:19:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0ED5826C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 21:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0097C606A7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 21:19:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HaB_UTvwVcFT for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 21:19:43 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 293576064F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 293576064F
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 293576064F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 21:19:42 +0000 (UTC)
X-CSE-ConnectionGUID: Zf3nfmauT/qrZCncBDB+cQ==
X-CSE-MsgGUID: dYMtnsbDRnOAvJ73LqhwyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="97449624"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="97449624"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 14:19:41 -0700
X-CSE-ConnectionGUID: MMpIx3L7Qbi1/S1L3KTdwA==
X-CSE-MsgGUID: 2yw3GaXvTIGxSVQio/01tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="256489773"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 14:19:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 14:19:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 14:19:40 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 14:19:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSJvVDnOfn27YjRS8V2mCy5u5Hx8lE3/Xg4H479JxCTWpnJzc6ZT09a4JvF/5zYxuF4iqIVsd11WMUIYtWsv4CxKFMD9vNM7waq2Nn6QjvQ6DkjFL3+1TXaoERGTSqbtgKFARPOu3e/Nn4oMQcTsMtldGynvNufzcJk5H3Ak7QTeB2EATkJx0zwcGhES43gr97usM1me6sHPdYOmY6Hz2y39CR23kAiICKRzT5Z1nAWB3zI4DgHBw/AAEvLR+ytIJn1aJmT0gsyqKCROKTk2tQF2+bz/IOOoMiFDvwLjox/8kdOk8HjFbu4FFPxfkzu2zYf+IEyycJrlG6WKctB3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvJqWqlQmp4t7pV2AdZuZOAxjxOd0kvDvflrAD7b4bA=;
 b=RdYMJStlJFFgS/nbbLar0fUWfxkYNgl6jDikw57GQGHWhO1EEtCssP0QhzRx83Po3fV2yySXq/ZSnjAjmA7QXAnjf1+la8RDBcGxmgA2ZlkA+HrhXz3vQ9rYZFvX5mrr9TrLYPoSF96ZpUuTCEA2xnHEcJ6f83i5XIs+4c/87jx3+n7MOi78bsp9C2JEyFrmG2NAWbsyJgUreLSNsDCvULV2IfWahrRf9qQtjx++jaIoxsttGRlBmouOJT6Bi5bi0qVky2oL718HviWFdVbq8g8Ai8NaanpTucj6nuR1HOh2LeiPnrIhLQsT+W2nU83YOl6r8QQrNdkSdVjKn7aFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9)
 by IA4PR11MB9231.namprd11.prod.outlook.com (2603:10b6:208:560::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 21:19:34 +0000
Received: from MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46]) by MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 21:19:34 +0000
Message-ID: <a83c7d3d-64e3-4b0b-ad13-007feade1f17@intel.com>
Date: Thu, 30 Jul 2026 14:19:31 -0700
User-Agent: Mozilla Thunderbird
To: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: Marcin Szycik <marcin.szycik@linux.intel.com>
References: <20260723145137.644693-1-tomasz.lichwala@linux.intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260723145137.644693-1-tomasz.lichwala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:303:84::8) To MN6PR11MB8241.namprd11.prod.outlook.com
 (2603:10b6:208:473::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8241:EE_|IA4PR11MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f94cdb7-78fe-477b-4fd0-08deee80407d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +oHVRrcSk3rQu+5B+ixL0WEPGhWAkFN/EeBGrS+2I9ZCC6SXaibLQBGAUga0qLs7QXU0CREu6I5tQBh1FYpCD4zp3WLGMLPpyOxuoftJzBA8EXYrQRlzbKnxiKNCVHigBCjbGuoWnHXtr5vPcnxCrPFMtrn66kCb9mnxIg3gSQ91M2ewhuh7kc0L0JeDK+drSw0cAhv/S0mXkeaB7iA5ybLUtrj8+NOYV5FAquphTxQZ+fuEXJy5GlfPfJzVTTn+w1N3txtuNhLEFOo52h5m8E5chogULGyHvvH1kPn4CqkHvtxtwK+EcMRsjbZcYaBzSHfE82WY1jS7/+SjXrbTSFCLstd0PxWmHwKy4JAqlD3wB311CGPx5/vn7cMEPKmlrDyp7Lhl8SXl1slvW9MWCpGh1UpuVFsv4PaoGeYrrBFOCoHKDYGiabW8D0FB7i5Ph+/YIvCxLtNQzNC62VdT77jjnalJVsI8Hz3dk6jeu924WGq5mGngIeIwwqolVjh9rTG0uzdKmOPXEYYY6qD5rstW6yniOmvdMnUy2MipESA2hUvzaLahuI9cBJS2SZLDj7QZ7V4/h2cqdiw7TVUlaJPjyXSTIgOFPxlx21+kO76acUnFKxxm5xHO7z3w157CgwvJHJBQVTwSr5rCWY5sYqD600M8wwUR5Ou6IxOPJNo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR11MB8241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWp0ZTg5dHkzMnJlRGJlUlk2TStKSUxKdzZUek13TXYwaWNwUkRGTVVkczFQ?=
 =?utf-8?B?bWtsYmF1WGlFeUZ3Z1RHWnlLMGhTSWxvMytKU0RVcG5mdFFlbHpXVkpSSXVX?=
 =?utf-8?B?Vjhyd3Bzczc0TE5yaGwwa3ZsK2dCN2JWR2NIckJLTnF2TzRXNjNMYm1GbTJW?=
 =?utf-8?B?TDltckRSU3lMbzM3MnIrVXRqOEJEOHl2eDY3OERuYzJhRHd1bm5NU3JwaHpI?=
 =?utf-8?B?L3YydDRGTnVqbms4bmdNdDdVVG03N3cxa2RNR2x5WDlPMTZPMmJiRks1bkJa?=
 =?utf-8?B?TDZwS0phU1gxbW83bkhwV1UrY2RYUVQ0K1BEb2VzVXdFZnJJTG5Wb0J4cUk4?=
 =?utf-8?B?SkhaSzlkSmo5cDFDUERWbDE1Mkx2RVFvcTEyOWl0bXV6TU1nRU9WNTJrdytP?=
 =?utf-8?B?cXNvTkxSV1lDazhlZCtQYzZTaUt5YTNDNWFVd0VRMmZWNm15dk9oZHFWWHlJ?=
 =?utf-8?B?ZzMwMC92MWtENkNweXI4NWZhSERWZkZxQzE1ZnQ5TjZtQWJqTDZ5UGYzZUtO?=
 =?utf-8?B?ZFdMcmNLUFJKNVZPQTBXL1lOR21zdk4wU2JnNHdLQmgxMlNQcVQ5cUpJZW13?=
 =?utf-8?B?MFJQRDFvTElIckt3TjhlZnFSQ0pOcmZkZHZIdmt6Qlp6aHE4cHhKM1FEMzB2?=
 =?utf-8?B?OFZlNGloZHN5KzAyNUtyUkwwNXhPZHNUWk9zcjREcTVaRjExbkwrVmJTaFkz?=
 =?utf-8?B?YUlmaExJZDdCQUJyRk5yTEJlNXNrUVB1S2gvTm1GKzNCM2xrTWtOZ0hha3Fx?=
 =?utf-8?B?b05pU3ZCNHJjQjdYeGE2czI3SXdaaXR5RjE2d2RiTnFrS2xUaWs5WU5nOGFm?=
 =?utf-8?B?aFlxczZGeWI2QzBNQXFJd3BrMk9uYUxpdTBCdXRYS0IwclBXa3BoRTVYMS81?=
 =?utf-8?B?Q2xVUzRhOEthYkNBSUo5VmEzbG9Nc0liQW45Wi9EUkZxSjNyWVFqbFVVanZR?=
 =?utf-8?B?R3diWlZEQTNtNFozanpTQzhNRWhuTWtyTGhRS0tpRkJOK204S2NUcDRsUmFH?=
 =?utf-8?B?dC8wVUx4TGVCL1JoOFZWY3loTndWRjZLT3AwTXdCbFhBZ09NR3VWdG5pZWFa?=
 =?utf-8?B?NnRqZEpwNHlTTlhOMXFWNTcxdkpYL3c2RVdWWkY1UThtL054bTYxR0tDc2VD?=
 =?utf-8?B?TWl3ZG5xTTdnZTNKU1dhcmdtSEJKZWd6Ky81R1dHcTlnVER0eDBuUDBFWWVF?=
 =?utf-8?B?T1o5b1QrdnBMeWpHZ0p4Rk1TV0cvOTEvRVB0d0pBVndHOElKdHlDRlUya2ZR?=
 =?utf-8?B?alNsZkVJYjlxVmRMZTZFUkF4WllxN0MwbEUrY1RnSUVZK0F2dUQzV1hLVkgr?=
 =?utf-8?B?TGNMMWRwZFp2NGZUUFVucG5KSXdOcVlkYXhRL2Uwa2hBbDczd096MVpBS0hJ?=
 =?utf-8?B?a0I2U1pHYU9FU2pveFdTRTQ0dlRwUlVmakcvemhUQ1pnWjdrNFhrSHplamFF?=
 =?utf-8?B?M3RWNjZPN0VmNCtVb1MySEJsUDBxWGU2dGJaN3ZsemUrZGxxL0lrRVE3akNu?=
 =?utf-8?B?ZjYrM0hNTFMwYnpYaXF1a25NYVdnbldSTVk3R0VlQlVLNzhUOWtjSS92S1Y5?=
 =?utf-8?B?WVVLY2RvekZCVFJCa1pTSDNqR1FLcjUrWkV6OXE4QVM1ZGZBTnFIMDRmY2dy?=
 =?utf-8?B?SzlNY09Hdmc3UWVCbFkxZ2d5M1FVb3FaNzlqN29JeE1TSXBMcHZWWGszSmFm?=
 =?utf-8?B?NExLdjR6UzNvVWY2UEhyOWUxb2xqOEVxZXpIMm5GcFRiWGVFY25Vb08wM2Ru?=
 =?utf-8?B?SG5RWFViQmx3L2FiakZxQlNId2pGTlUrTGk4N0FxS3ozbExEdHNsN1plN1M2?=
 =?utf-8?B?ZDdjTmIrUnYwZEFpbk03UFBvN0VGQ1dpbFRBWGZFZ2ZVbkZGNS82TEdrUy9r?=
 =?utf-8?B?bkxVVEVyZUM4RGtlOEVpZXdwd2N5bTQyMWphYk1QVldJSFNYTlFVZVc3WHly?=
 =?utf-8?B?OVZQbUpDb0dJdnMvUVl0N0tpZldNUURIV2pyb2RFdkNjWmpkakkxSjNnN0ZK?=
 =?utf-8?B?TTVXUVh4S0lGdEFIcUY0ekZIMmhnRnQ2a2NpZ1lhRG5wcyszY1lRakhhbWQy?=
 =?utf-8?B?Y3FmL1NEeUJ6ODZkNGFVYk81QldWeU1sbE83M0p0dG9iNkVJcFk5NEE3NHp4?=
 =?utf-8?B?YitLcUV2dDRSWlFwYzJjQVEyREVmWjY1QWtyNzZDb2pycUR4ZFBVZ1JOTVRu?=
 =?utf-8?B?eWxpaU1HZHpjWDZIZnhUNDAzcDExWTZiby9sT0hGNldTcVhYVDZDeUFFeUMr?=
 =?utf-8?B?SUx0MHVTeUc0VkN2SjhqMVBwZVFsdVBJYjRCVzcwTFhiTEZGZFZUdGVQUEdS?=
 =?utf-8?B?RFZhSmRxUS8yQnhhR25CYUZhK1Izdml4cDAwUlcwQm9MeGhjN1N1bDRVWWpw?=
 =?utf-8?Q?UpIHwJ1Jpo9hvA+Y=3D?=
X-Exchange-RoutingPolicyChecked: qieH76XvKkUERi1yxq+3NbrNLZdrxUEuTEDcNE6RR/olmJbP5vkuoaL1LS577NsvRQ66WNRwIFIXuq0QajzXebwACSd/aXaRG3gvHD9GyoWTyLjY21KWfTuskp2LmUOZ+foc1QEoBSvW/cx8AF3KNCxPKEOAZg9JVjcEm2LcVXdi13PnXoyqbP1kz0sakY41NZoAHihWi/vwaL0bAm6lL/NwkwHtb18JP8/2Eqx6aWYityRD5w9+lRgmAtSwzxy4aXt028AHc14XqXbj3Rcx7neMDiHIr9ciPTV12xtU/x1zxWZZEIFgTWW4XEzvOnK9i+n3kHoXxnk162RAM88ewg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f94cdb7-78fe-477b-4fd0-08deee80407d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 21:19:33.9774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaFjDzQgENPXpOEfVHMFex+7+Vj9O1m7u4l77b/4L9Zonq4Dkzlai5Lg/v7WuDTKvCkBKhC6FvE0zFYxG8CsZ3QqML/Bs/xRKZljmQcSR54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9231
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785446383; x=1816982383;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gv/QoF9uAIS0UF/LpU3sBsrFwg3TBgOwAPwEZ6nytkM=;
 b=A8ewUM7hs4zg2k2m6EM4JRngSEN7TbX5hoRbj3APq2htdmDfkz8W6pAO
 u9OTe563gwt6SnQzRF/qxHM8fBbTmPqJgqrVTBlNqdhBVfXA5cuF7wzqA
 /8uutCBlv2Sae0eR7zIqIsMHWpajoSQGkEnjPgHTqvDRGDZ/TeDiakWbO
 Afn4l6taI6ustKX6NtFrv7h7Gj7IBvhwIafYrqNXeMKhOO5ZER6jifCEl
 U7mA2TNNJLQs72wmzIxU9RksTtooWhWO9caeuGMS8JJYb4Txmkhd7fob4
 h835KDnQIRuYIE8nTTZ0TEf6qDQIUnszqk10vWdPKoqHzNl+2VBNFgYbZ
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=A8ewUM7h
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ixgbevf: fix link speed
 reporting for Hyper-V E610 VFs
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



On 7/23/2026 7:51 AM, Tomasz Lichwala wrote:

...

> +/**
> + * ixgbevf_hv_read_links_e610 - read link status from PCI config space
> + * @hw: pointer to hardware structure
> + * @links_reg: pointer to store read value
> + *
> + * On Hyper-V E610 VFs the VFLINKS register does not carry valid link speed.
> + * Instead, link status is exposed through emulated PCI config space at offset
> + * 0x209 in VFLINKS register format.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static s32 ixgbevf_hv_read_links_e610(struct ixgbe_hw *hw, u32 *links_reg)
> +{
> +	struct ixgbevf_adapter *adapter = hw->back;
> +
> +#if IS_ENABLED(CONFIG_PCI_MMCONFIG)
> +	u8 data[IXGBE_HV_LINK_STATUS_SIZE];
> +
> +	for (int i = 0; i < IXGBE_HV_LINK_STATUS_SIZE; i++) {
> +		int ret = pci_read_config_byte(adapter->pdev,
> +					       IXGBE_HV_LINK_STATUS_OFFSET + i,
> +					       &data[i]);
> +		if (ret)
> +			return pcibios_err_to_errno(ret);
> +	}
> +
> +	*links_reg = get_unaligned_le32(data);
> +	return 0;
> +#else
> +	dev_err_once(&adapter->pdev->dev, "cannot read link status, PCI_MMCONFIG is required for Hyper-V\n");
> +	return -EOPNOTSUPP;
> +#endif
> +}

I ran Sashiko locally on this and it reported the following:
Should a failed link read here return a fatal error to check_link, or
report link down and return 0?
When built without CONFIG_PCI_MMCONFIG this returns -EOPNOTSUPP on every
call, and it also returns an error on any persistent
pci_read_config_byte() failure.

>   /**
>    * ixgbevf_hv_check_mac_link_vf - check link
>    * @hw: pointer to private hardware struct
> @@ -909,6 +946,7 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
>    * @autoneg_wait_to_complete: unused
>    *
>    * Hyper-V variant; there is no mailbox communication.
> + * For E610 VFs, link status is read from emulated PCI config space.
>    */
>   static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>   					ixgbe_link_speed *speed,
> @@ -923,13 +961,32 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>   	if (!mbx->ops.check_for_rst(hw) || !mbx->timeout)
>   		mac->get_link_status = true;
>   
> +	/* E610 VFs always read link status from emulated PCI config space
> +	 * because VFLINKS does not carry valid speed for these devices.
> +	 * Skip get_link_status caching since PCI config reads are cheap.
> +	 */
> +	if (mac->type == ixgbe_mac_e610_vf) {
> +		s32 ret = ixgbevf_hv_read_links_e610(hw, &links_reg);
> +
> +		if (ret) {
> +			*link_up = false;
> +			*speed = IXGBE_LINK_SPEED_UNKNOWN;
> +			return ret;
> +		}
> +		goto decode;
> +	}
> +
Can this cause a repeating reset loop on the degraded configuration?
The non-zero return propagates up through mac.ops.check_link() into
ixgbevf_watchdog_update_link():
     err = hw->mac.ops.check_link(hw, &link_speed, &link_up, false);
     ...
     if (err && time_after(jiffies, adapter->last_reset + (10 * HZ))) {
         set_bit(__IXGBEVF_RESET_REQUESTED, &adapter->state);
         link_up = false;
     }
A device reset cannot make CONFIG_PCI_MMCONFIG appear at compile time, nor
fix a persistent config-space read failure, so wouldn't every watchdog
cycle re-arm __IXGBEVF_RESET_REQUESTED roughly every 10 seconds, leaving
the interface permanently down and continuously resetting?
Before this patch the Hyper-V check_link callback always returned 0, so no
reset request was triggered. Would returning 0 with link_up=false and
speed IXGBE_LINK_SPEED_UNKNOWN for the unsupported/degraded case avoid the
loop?
One related note: the dev_err_once() reads as a benign one-time notice,
but the underlying -EOPNOTSUPP is returned on every poll and drives the
repeating reset behavior above.

Thanks,
Tony
