Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB9606A31C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LniIc7FO;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hmXMIqd1;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=fzN7pknE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 382D7405FB;
	Mon, 16 Nov 2026 09:48:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nw8KeD77utPz; Mon, 16 Nov 2026 09:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9414640565
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794822524;
	b=rWKTdw/u/6jKwAtMYu0hkmspwFLYR3XPe57hSu6A1xmjXOr8R0tKf5SQJ60tzhkzO5C7
	 QrWf7+nFeWqAeBW+Dza1jzUFXl7aiktbzyKBWnEkavlcPXVPc5Mh6FzuJO9gJBlML4MOf
	 0ccTvpTmKYzNyqoAn7Ljfhw/sIDWKz3l8PCHAy1kudO45yNorEB67QseO2kFfBBqiQyTr
	 cI+4bdheu+Xhhq5bkKPDIRliyKt+IM58uaHmPrpUnPp0JiI4yeFuEkTCERm5KdkuQ6qUZ
	 5l7fKnIJj+ajceOLT40KRvjQzNrO8k7/9YtX/g2K7qt+ne+PCLo6Tq2IhL7psEjkvVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794822524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KKVYp4VS5dVaQKYPgZsM/LBf3/V9Pynlg7XxX6G3+bQ=;
	b=R4g/vPf4m+hy8+SZeVhSG93pNrtvGebEK1KmhX0AEA8YlrF5KK9BL6lJzF07GhL+pVIS
	 7tnSN1P6urak/PPeRP2HEgANlSnkyzZY2QVjoKsP2tl5ozE9rarZulugZIc5hBENDkk4p
	 XRPOpwFgTCaYpO9FZGWAc1TOEFuNQs96btLJvM04wwCyx7b/9gz+h+imRU8nzR7QR6z5b
	 yS4mTQkSXrucW0mlvoCeVtGME1cCs2PUW0YAGXNKI17Z7VtTMxc0jAP/xZLC+j/WFldM2
	 zzrfhkTqBhUj1w25JbktGUVgxRndD8gkY+QB0+GzaPmiUuIfacix+yUPY+c6aa86U6g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hmXMIqd1;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=fzN7pknE;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794822524;
	bh=KKVYp4VS5dVaQKYPgZsM/LBf3/V9Pynlg7XxX6G3+bQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LniIc7FOwt8H5uLSnUSTs2WAEamSCkypzRHkaCzebFQ2yDd97OFbUAMlifc7rmUse
	 Oanf9Sk/Hu+o0jDWVs3oNZ0QGS1FchoS1BY73PeU4TJ1QNFNRvAIhWALIGxdLpETq6
	 H3Qe0AbbC0DDKAklLC0hGR0tjqGjzMsAzDQlIej1IprahsO2VbKFPZ9NN1OTaLuZLt
	 fY0965ZDK1Hp8CRMLqfl9euFS9ZAJzRU6cnstxHlM9tBZ6oNp0o+34jknAfjRyuNdI
	 Qb00QKeTjajkp7eaPKdEIYXysfg7WxIM181f2fKUfLTs6DLL6QAgjsagPVo6FQGSWp
	 42jnnBXW4v+Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9414640565;
	Mon, 16 Nov 2026 09:48:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 62F591E7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 09:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6045340565
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 09:48:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mgwdsLuHSw-7 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 09:48:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00778401EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=avigailx.dahan@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hmXMIqd1; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=fzN7pknE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00778401EE
 for <intel-wired-lan@osuosl.org>; Mon, 16 Nov 2026 09:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794822522; x=1826358522;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=EWi46gXdQ5La6BhlKrlqvOB+PIFBLVJSYJvXYJASE3g=;
 b=hmXMIqd19vv/hyVNK7qBbP7EXOUhK/h1foqu5Ix5qP/eV3hpjy2zgsx4
 dBqwpVuVbf1no1Fs5PjGMzqWMAxjW3aXu+t9ohLzfk2uExbvf7EGPm95y
 Dna+TBQVDAi/FTUlJYZPMl8dmlh3ng1bFB6to6olPzQq1KpybuB7MsRSB
 fxB1OTUYEGNxUNU2arDhUlGr3ahZ7yjW1Nry+exWfzxzVB+F2PQzxB5oG
 9nC1x/vfM+gDZ2f+Z11E36t8hZI+JiVkoXeDsZnniK2ilOvTeb9aak8eI
 SJnjzWzXPmp97uo9lXU3mHfIQdcUQrJF+VfFV4RaSWriAbu3UOnL8Tbpq w==;
X-CSE-ConnectionGUID: 8eUBwlFWScKZg1nfLUmvDg==
X-CSE-MsgGUID: aS6JlImPRlWvhF4AgCtZeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3656255"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3656255"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:48:40 -0800
X-CSE-ConnectionGUID: seD3trzYTg20Fpn2mfENRw==
X-CSE-MsgGUID: CKlnI8WuQ8i51z8ywntPsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9424581"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:48:39 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 01:48:39 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 01:48:39 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 01:48:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKVYp4VS5dVaQKYPgZsM/LBf3/V9Pynlg7XxX6G3+bQ=;
 b=fzN7pknE9oBm4Ew72aH7Oq/MQjHmku4QZzuCnUIqDeOJhnX0/h9UxBzivuCQKTmPhKw6V5QcJz7E3zkmhl2k528zcd+4k7eVFZcSpa9GoaP0GAzspz/IePuaA9Mq6hSknGBYbNhPknTzftvvyyQhb9gfkYKWLjgTG31tCFfnjz0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 09:47:36 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 09:47:36 +0000
Message-ID: <7943b859-5944-458d-a639-a1dad2d80138@intel.com>
Date: Mon, 16 Nov 2026 11:47:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next, v1] igc: remove redundant igc_hw.h include from
 igc_main.c
To: Sasha Neftin <sashaneftin@gmail.com>, <intel-wired-lan@osuosl.org>
References: <20261018185352.46199-1-sashaneftin@gmail.com>
Content-Language: en-US
From: Avigail Dahan <Avigailx.dahan@intel.com>
In-Reply-To: <20261018185352.46199-1-sashaneftin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To PH8PR11MB8013.namprd11.prod.outlook.com
 (2603:10b6:510:239::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|PH0PR11MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfd160a-cbd3-4751-a1f2-08df43c6a4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|11063799006|56012099006|261028144727099003|261026140227099003|261021123027099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: X7cnOY5BCTSXH61bVxCnpsPTnzJL5qRZtAZa+vUE96poXKRCRKtCmlEZ8py2Hi2zEJSV8HFhbCWNo5KtdnRh0lAY6vKz0tQ/M05inEBlvbE1a8OBx8scLfjSi+kuNcbRSIzpGG5WJW2aLBOJxR9BugBIcjUfw6SokwFrJozTpAH0V7/N2LnQ8Vgpvw44QJQFXY3A/8tmVfj+HzQGBkIuIkiyxT6YJepgwP/qLrnVBpbzEHnKUnyMCCVNWogj5MgyDBdDagjGI2jNkm8HsumhYb54uVyOMm2poQ+1HkgY3EfCrVnc46a3Y36qm5EdHSuZotxF6m8NO2hqBkuvSrY/u5ViSsL5JMSFcG5vULRUi+p6fH7BrZg1QIkgk5lxB+EOPRsY8325qUVwzQmvPEmLIBDggW/6s8VFT2MLSdv68LOqZEGUXwE0GFno5NS3+oE1qGbPWoeeIcrzMr7r2VmVIC3QyzYyf0TzJu2QSKZU0WZK0idwYnlW8M8zbRqpzMOLi+rbyBXRXAstnVLBu5h45dZxevJ5v9hwTrJkcnQDk9ZsGyWFu0o6hhzA/QiPGpmDfWLWbva1JX1Sq3PdHGy1KvE5OI+v1h/WRGyPSTEnlk6n3cL2C9HyPGDHki8ADe7X25dRjmd/EKPqv/fp80T5TfV68U999be2wiOpqlNy+Fk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8013.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGlFc3lWYlZ6WWc0WlRsOTliZE05bDU1b3g1YVJrZC92bGdKT0pMRzltdWxD?=
 =?utf-8?B?MkVwMXR0a2pIU1pKZFdjMXlaeTUwOVFEQjdJbmpwNUtwNDlKZGhUSFB0WExx?=
 =?utf-8?B?RHIxVFRlaDFHSTJzbzY3UDcxODJ6c2plcDBHKysxQWdUeDllZDA0NUdYd2Qr?=
 =?utf-8?B?YU5QWnpDczhMSHhBWTdBWmNKSnJTUEJGaWljWU5uaTlUOENmQ3ErcFdJR282?=
 =?utf-8?B?bWNETlNzR0wrK3JOcHNtWEVRR3RadDJaTVd1Tmh3b2xOME1IMDZWNTU5QUxJ?=
 =?utf-8?B?NFJrL3A1dTkyWWE4VkRINS9SN3F0WHE3OElkL0lJcE9OdGRHc1JUL2xkRzc4?=
 =?utf-8?B?Mm84d0lZMTliRzdZVno0d3Ntbklsak9qUW9lU2xIVm9KdmtaMWQ4ejAzVXBo?=
 =?utf-8?B?OUNXN1FxUlFyTlBYenNsY1FWUlE1NjlKNS9NbFJLUnFzblJrRVlUWW5JdUQ0?=
 =?utf-8?B?L1N2WEpKZWJ2WlF4cTVPbE1BWU96anhLcEFPaWtvZU5YU0FwNnpLTEVCWGtl?=
 =?utf-8?B?YW1xS2Fja2RJWk51c0hPTXdOTXRCcXIvSFZPT094NDJvUFd4aDdiYkNqeGg5?=
 =?utf-8?B?R0xmR0FmOUVnRm15N016alVVNGd5aE1hbGpxZEtYL0d1VEs1WlBqOGVaV1hB?=
 =?utf-8?B?WGNwWjFuSlZnbTN5MXlxQU1PUWViYmozZ1RNUDJHdElTU05UcmhHeGpqa1R3?=
 =?utf-8?B?VFVGVTRzalYycFA1dXhmcjBvNElrcjZvMDJPdzA5NzF5YkZuV1daOGFYNGZT?=
 =?utf-8?B?WllrN0laVks2YVFnb3o3RXVSZDlUTnFaSFh0SkN0cVRoVnZjM09QK0JyK0Uw?=
 =?utf-8?B?YldQZGxtV1VhWmhheG5qYXZZS2svdi9XWmpmTThyNG1GdzBFd0ZlbGpxK0Yv?=
 =?utf-8?B?aEtzVVQzVm9ibGQxQVk5TjNlNVlmcjZBeGZhTjhtMnBLdlMyYjlPdVB2SzJQ?=
 =?utf-8?B?ZTBMNTVuVitpbndOM3Z5R3MzNzRQR2pZVUlvd0ZKaHBEVkJNT0EreEgvalA5?=
 =?utf-8?B?cVFXUy9KVWtGaTdHR3IvRU92ZVpmMi9LUE5XYmZrYXI3NE1qaXcvZFFnUHhs?=
 =?utf-8?B?MG1BZURmT2twbHlOYmcrN0EyL0VqeXA0SkhUdm5KTnpjbnhJNHNNYkw4RzA1?=
 =?utf-8?B?NS8ydDNQWlhIckNJVjAxaS8zVGduZmJaQ20wTWNmM0poUk5NRis4NUU1K0to?=
 =?utf-8?B?RXVzZy9zTjBia0ZOY3JXVC9reHVObEpadVlUc0tncm5GcjQ5c3FZSkZYdmtN?=
 =?utf-8?B?Y2FqekNVd0JlV1g0ZFBHM0tZSnRKMHo3OExCcUF2Slp3RGFDQzBGNkZPb3U4?=
 =?utf-8?B?WUtuOEYyL21HMmxSRlVySWdURlh6VUQwQU5aRTBGTnZZdjNzQXBrNXh1ZTBp?=
 =?utf-8?B?VkZOa1ZVYzRVbUhsYXo4OXZZdUcyS0VZUFp5bW9PdzZHU3RYWTdXdTZPNGVl?=
 =?utf-8?B?RWVnUW5qNkdNUkMwamVoaVpNSWwrOU1CVE9YOXZ4alQybTBtZG1yTVNjMFlP?=
 =?utf-8?B?dVFpaHIvd2hmbXNGSmpiRElHa013c3JFL0NXODNYOW1wZXlOSjdqajd2M2I1?=
 =?utf-8?B?b09udGFuOERPSGJQM01xNnNNazNDSU0xMmZ0U0JkUVRnRG1hNDVMellRMzlo?=
 =?utf-8?B?VnE3WldzS2FzQmJsY09XWXVGS0tEdTFEMGpyZytKMW40RTZwZGF4cCtYWFR6?=
 =?utf-8?B?QkJSWkJjN0p6dkdteDhLMXk0R0dPZis2bytHQnFvTFQveTNKSjFHbmw1eGpW?=
 =?utf-8?B?VTEvQ0k1THZwSEtLUTZ0NEVkMjdIcjdJbXRyUXozN043Y0Nac0lhTmhRNlV6?=
 =?utf-8?B?QTdjYm5SSjFJVGZhTG9MSXB2elJRbFRFTkVIeDBuSXhVL202S2dvUWxiZUN1?=
 =?utf-8?B?NG5UR3Y0UGxEZFFYeFdmSlFNSWs3eFNjSDRvTEVLbTVsSHRSMEtqWERVMHEw?=
 =?utf-8?B?L1Z0cnNFSW9Fa09mamFtZzk5S3o2a1BTSkFDQmNaZE9KbnZUdHdMYjhURlhj?=
 =?utf-8?B?ckZRL3pwMmdxdUhqdGExWEprMHpHbWErQ2Uva1RmNzE2Mld6czJBTVhYZUNR?=
 =?utf-8?B?NnJ1VmJCT2tOMmxKTE0vczJuRjRIYlI4LzhwVGRiYzFRMHFKTW1TSnVSc1h3?=
 =?utf-8?B?YVFydkkxV2tzT0RjSkw3YU16cCt2VXJjSHVhcGU2bzhlc0JwMXpOb1dyZUd2?=
 =?utf-8?B?ejFXaTMrckFaakJLdGc0ek5mRzlNdkFQaTZJK0NUSHVDQXpTVGxhZThtc2FK?=
 =?utf-8?B?dSsxWFlRckpwWlhzWGZweG9VOEZNQTVTVVBYRW9mK2JOYStmeTFGZk92Wm9D?=
 =?utf-8?B?K2pZRDFBVzFESVlRUmdURWNEdTB2Y05GS0tKTVdYdldWK1RhODRLY3NKbytR?=
 =?utf-8?Q?VRNworLmD1WB2d0s=3D?=
X-Exchange-RoutingPolicyChecked: AjGovh/R0KmM9mHxwEODI6Fkyw+RsrLjabOM3gUEi3fc0KRJ9qL4JIhzJSCDacIHEGWMlCikgCT/3k6+zHWWyL0coO+Fus+17MkDBSVvIOQ477ol8PpOkxb/yGFrRiY3aWBUYmyk6OIcY73PmefNBMKkCCsWS0lSiLd3ywR1RJ1x2HIwFGCaHn9srCHdn9OsyE9BBqQjNW/EC8SR4G1wBV++g/gy7ww4t4Fm/uFVvnj7PCDQ4+uFKXPR11+d3VjdYduTGoD+uSEvbbRUjwJWfi7sWuICgEp1xNZQop24aIE4z+NOCOhivn6cJ7qHHmUmE0ZL3cT/GBUFHDBjXPfZKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfd160a-cbd3-4751-a1f2-08df43c6a4db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:47:36.2663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfe1DNKoeBO+2IFsxVrpCKuKu5pjqx/IBgLkX7b7QU3pQ4JeSZMsr6nxxtTojMjDvzX8jwiluBc54H9yZGPLFSKhnZS5DPUEqUEPRERSi1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 18/10/2026 21:53, Sasha Neftin wrote:
> igc.h already includes igc_hw.h, so the explicit include in igc_main.c
> is redundant. Drop it.
> 
> No functional change.
> 
> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 1 -
>   1 file changed, 1 deletion(-)
> 

Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
