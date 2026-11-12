Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A78606A881
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5WqgFVCj;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=m8Kx8IAv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D7A881412;
	Thu, 12 Nov 2026 15:28:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cNlqfZsovP7e; Thu, 12 Nov 2026 15:28:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A2164813D9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794497336;
	b=HKsEalUlxt4xTJTRdA29TadQA7f+n+jCpmUBvvjCwOW5sWIyes7NX4KD9R2L5YqfYoJt
	 Ty2xaa3iE2qgigLNmbvWxTw0/zZ7VlzFzfIm52nNRHwgW36HVq2PNID+wJuSD84ShezTi
	 rmOVUgLb0fgr4c880Wuznwf2UqLlfjnz/dgFtLF+oZV7XGSgxKEr9b8MNK4eSuz/Dn7j7
	 uxRLfMzyi2EMVU9q+jmRxDCko+FPqUL6ls4KJWa184MzCa099P7yiv++Ljo1Al5MVwMkE
	 92qa/Y1/k6bHLnd15NwwMSbPwj+uaGdpA+6nT2aalgSp7vRYxbss8shjNWZa7gBvH+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794497336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Subject:Message-ID:To:Cc:
	 In-Reply-To:References:Date:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SpL8Jf/FXMJSX+dZMz1med1vzTlNAmUNDFzbJrw8ULs=;
	b=bYViC5t/ds+PSyJn497QwnZUlp0nt1zoowxTBbpdwpca5sMYp/qxl/1a8lJo+dCHhpfI
	 s/d75RpxFZVYhEIp45i1y+JMBb4W1Xzxuds+URJc29I+kJzImcRbb9jOMdRAjNGx/GPgz
	 ywO0JJOZgA+sPdx+B8W5B08Zxc/VQCF9JN2MLWfebvZ+BQ+zhV9MKxKtN1sD1Bz+vIkqj
	 GzWUoRpulWU0AaDISaIniug9yfdVPhE8L3EX0hpR5IoM8g/61VUY3v+t/dOL9gLrNqQSi
	 UlhjvFwCVnaIxo5ivvxcGynLuGDu20J8LALnQHaXyx8ODlg7JXlZihDzbLbTmJU/VOg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794497336;
	bh=SpL8Jf/FXMJSX+dZMz1med1vzTlNAmUNDFzbJrw8ULs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5WqgFVCjBHBw+cWXc7tARKXSIwOQOUGk9w1yR6nrByrr7DthZ7PIoeVKDMlKkBIJK
	 d1NnG6GlTmxo6844Ta8E9KV73ytA4HlTF8H+HLw5ucJdqe1zNCoCz9J9Ee7fqN60X9
	 8h6qkQM6vlFF5IRNPxnPXQGI39JYPQ86XAqiKq4wubd6UBfDCB/iLpPmU3UanlkRSg
	 N0+rM3DgYsADwas6QPqgnGQpYyR99pdFV8I5j1TZvIzzQpf7riRyaxkRQd8HzSo8m7
	 rhlCtlYD7epojtFt+hlN663CO8pl1UMFMQOqZOkYmuw/s1CJTxt+x5ARkmeLWXtQiD
	 JzAcMXsLYQHUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2164813D9;
	Thu, 12 Nov 2026 15:28:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 38D6E1399
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 15:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3677D400B0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 15:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ME-N1_QG0Rw for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 15:28:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0FF84401A1
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.103.66.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.103.66.28;
 helo=os0p286cu010.outbound.protection.outlook.com;
 envelope-from=fan.jiaming@hotmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=m8Kx8IAv
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn19011028.outbound.protection.outlook.com [52.103.66.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FF84401A1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpL8Jf/FXMJSX+dZMz1med1vzTlNAmUNDFzbJrw8ULs=;
 b=m8Kx8IAvTB/oxpoW2pADT1Capoz4Yo0Y0MgiFch/AbCnzzGswXqxr7ysRARM/gEIMNBL9a+FZSGJq2/BNB4rwlLGXM+l77Iu2e03Bye2O6IbXCVQhdjppaByksus4LrMfBOr0SioalXgfDYUgW98BXQvIL8JM58jYf0/a+m+JzjphLSO/FUlHjd0J6zqkXszrAKVqpEwgnWoXQG7R2APem8E/DEX6KrMVLNHGhI/o9EsQgi2uTKkagbo1BiO9v1Xja0cLpyvt2gVsnre+BbmVERJzwBncATOboWNVxTv4ypXQctTjVsDGJGjnQOfh3NC4ocPP2+6k4LIt81APUro0Q==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TY4PR01MB17272.jpnprd01.prod.outlook.com (2603:1096:405:334::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 15:28:45 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 15:28:45 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: =?us-ascii?Q?Re:_[PATCH_iwl-net]_e1000:_report_RX_checksum_offl?=
 =?us-ascii?Q?oad_as_on_when_it_is_enabled?=
Message-ID: <OS3PR01MB10251F4C21F0D62EF3F4DBB6FE7702@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: <netdev-bot+sinfo@kernel.org>
Cc: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, 
 "Tony Nguyen" <anthony.l.nguyen@intel.com>, 
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, 
 "Andrew Lunn" <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, 
 "Paolo Abeni" <pabeni@redhat.com>, 
 "=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=" <mirq-linux@rere.qmqm.pl>
In-Reply-To: <179444769837.2168702.18320155804189818970@kernel.org>
References: <179444769837.2168702.18320155804189818970@kernel.org>
Date: Thu, 12 Nov 2026 15:28:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::20) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID: <41447d7e-bfa5-4f2d-a097-42c3ea6473c1@milk.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TY4PR01MB17272:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea85920-4749-45f0-1bb2-08df40d1a3b4
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRkx4cscieLP1hGE+NZojleYRUJZT64yUU7elzI+YycmqjdaFiOGdFM+pAv9b5ZReLaEm/eGrRK/RHkSunwNL+0xmokL+AVdffHWMNfKavyQpAEexW0o79LS8T/xvxiypvVEqWjuP8Ok8SbnXGsD1o0UHdD/Nvct81mdsw3al6TH1k3xJuZNfP5LGVSbi26E9qF5OhhK9oUROPzPAP0gSWRIkrpbFtF6da06kA7/3t1L07BmmAkyZGPIMRInA6Ma1JuGisVxF8bBd5tatfXhz9CmmU3Vr2+xbNThU4KF8faNZZlPFVcnIMmKT9rW8qu7G6OerDjMjTUlY6NlnGBwbhd3CN9Hv5ddLC0tp34XxcMMBvqrD1TQvJdsQVwyCjW/fLPxpIHdwdtmMvpcdYUu+P2TEdsx8azPDzs3AHtZ+mEsbRD8te+kkBuK6khXc6L+QMuwSrVZkFVcjZF6+AO7uF5bFnpIs4mGOfv5n6VtdsDh40xQcNLs9WWgcvXV5QzV0e1ccRzCB9OlfxD2hPZzHfq7KFpH8moEsOUO6de1rAK83NynY5MOIUsCQneDLxwIC+cYyAZPgUHZRLliqzv78vF7sNBJN1BtAYIvTur435/G4AxY80OEjOvG7FiRcXBYdroesFp/3+fzGjvq7ZPa/ZK5xFNToQ6JmBB3MacVdfzXPqsPy96K5rPdXj9GALdpxa7+fUg6ypPPO5n+3S353H53eCi2pcv0HEqc1FuVUPYEY=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|25010399006|4140399003|8060799015|19110799012|15080799012|6090799003|5072599009|25031999004|24121999003|22091999003|23021999003|55001999006|24021099003|51005399006|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZitwZkhIR0RoL0dpN290SnNtYmlNS2Jzbldad2k5eDE2T0dXMEhWdGdyOGxy?=
 =?utf-8?B?ZUMwemVUZ0ZQWVBZT2gvUlZRSFFSRDAzczArR0FiRWNPdGlvTURYaHc3WlN1?=
 =?utf-8?B?T2tQc0tkNC90dlE1Z0JQeDZucmZkQjA0WlpIU1BtZ1RQYm9Gc1JCUklSVzVu?=
 =?utf-8?B?NXNydUlDNTdLb1FkTi8xbUg0eDZaN2ZvUWp5c2dlREJXemRQajNjeFNhN2pU?=
 =?utf-8?B?NDZMcTRocXc5Znd2QkYyUkoxZHl6Y1d4NTd0Y0o2cTBDdzZLTWZoSkwxRmFP?=
 =?utf-8?B?MnhMck9ZVmhDSzJSSlVhMnh0YURFdFF5RFFUb3Z6Z284NUtxanY0VjJlRkZV?=
 =?utf-8?B?dWZDWVVrOERmRTZrSXdKVnFRR1VkRUNXbnRha2FyNVUwclNiWmtuSnZiTEpI?=
 =?utf-8?B?dVhQTTd1ZmFDZURTeU5qZWV5cnFoR0hZU2lNMitVUUt6LzYwMTN4QlhSWHBq?=
 =?utf-8?B?WFRlL0RDRGZJL09iRVlsck5XUUl0ajRoc1h3cnpjM1BDampaZ1dad2ZYQ0J4?=
 =?utf-8?B?RFBuYUQ2UTFhSFd3Nmd5dldGbTM5dDE5K2ZETDRJTjJkS0NsdzIxcVVYRER1?=
 =?utf-8?B?dnpGb1NjMFBTM1RuUDJvRGdoaG1ZZDFNY1ZycjY1TmVDRlE0dWFhWXErZ2Ry?=
 =?utf-8?B?REUzdU1mWEp4OEVMWFZGclFKQ2lMNnNxQTJWTlY0M1E5YkJZRURjaGxYMk5z?=
 =?utf-8?B?RTZSMVBSM0gvS1paVlpSM20xSjhKZGJFNXc0Q0NiRlZKc2dTbGViZWhLRGE4?=
 =?utf-8?B?Q09SMnJIcmV5Nk4wcmU1U2VWaU1NVWcyYzF3OWJBVXkxczAzL3hzZlBQbUZJ?=
 =?utf-8?B?VEdiUzlIa1c3bDk1NXRqdklTNEwzUkxadU1uVGxzYjNGdVlZb3pGcVNDS2Jz?=
 =?utf-8?B?RDhNUEJzYU44VVIvQUxMZGV3UWZEbWNiSEF3Mk1FMVFzNHEwTElhZ2VOKzQ0?=
 =?utf-8?B?VFhrWFZ2YkZSVTY4empjSFhyZm1CN0pTVHl0YklkcmdYTlc1K1ZSbkdqczVX?=
 =?utf-8?B?U1dXUTRYYWJJWVVPeG83Y0NDTHhSRk1pdWFNaFNkaDN6czJLN1cxR2kzQXEy?=
 =?utf-8?B?cm94b01EWHlPbW9Bb3lzUmR6c2ptN0hpL2xreEJDWTQ5VGxqSHB0NzZnR2Jw?=
 =?utf-8?B?a0dWZW4zVnlobVhUb1VGVld0VXRwMXF6RFBGOWwxbnJ6d2FPUkRUbG4zOGgy?=
 =?utf-8?B?WEF3cjZsN3dvWmI2WHJZQm1CMmQ4M3A1OE5BejlDak1NbGFjK1EwWk5PVjNT?=
 =?utf-8?B?dFp5WCtEZnJ5R29OdGpTR3pNZnlidEJsZklKYkFWNTBFT3BkSTU0NEppNFh1?=
 =?utf-8?B?TnRVb1o4UnRPdEl4VFBrMmRQWVM1K1k3bWRNTVNuM0lMd2VVVE9HVk9ycDF3?=
 =?utf-8?B?NlhZS214eERmL2hOMlhYa1E4WDRxd09yL2lubUhRaFRuTnl2UlhlVVNQUzRz?=
 =?utf-8?B?bDM2eHFoZjlZYTdZWUszTWxpVDMweUdhS2tDWHV3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmMyK2swMEU4ZXcvVjJTZ09ZMHRGYU45TXg4OEZKL3g2S2puYVhiVm9xcXpv?=
 =?utf-8?B?cWFRUG1HU2FnaFM5QTdVWVdxU3BrS2VXU2JwRXBNU3krbTUvdjRNVU1hUDVG?=
 =?utf-8?B?TUdsa2xQL25aY3l4UXJocGF1S3BiaVRId05TQXRSQjVvRExwc3orUzJuOW9O?=
 =?utf-8?B?MHcwbStxQ01IYUc5VTdJcklnR282MlFnTTNuK0RSeVZCdnZIR1VIWnpZajZC?=
 =?utf-8?B?TmxjNm9ib2oyZ1diNlJkWjNCZnNGRm01blN2ZjlGeUxETTlCUk1Zb29zbFEr?=
 =?utf-8?B?NWJqSXEzNmJuT1A4S29ITVhHRWhKYjYzbDBEMFpvNnk0ZlhOMnJoMTAyUm0x?=
 =?utf-8?B?UEJySzk0aGErMFJaT3V6WGhISVhza0Z5SFVLRWdWQ29WYmVsbzRUSUY4MFhv?=
 =?utf-8?B?b3J3THl5SGpGc3ZJUGFNblE5TDlsZFVVNEVJdnlkMnJHdFIxT3dTMktHN0Zx?=
 =?utf-8?B?c29wc0FiUlFRSUdRT1F4U0FuM3JiOXRqSzVXblZFUldFL1FBcTVQK1JlMXEr?=
 =?utf-8?B?OXFJMlN1TytMK0pjOWxvNEM1QTJiV2pncXFRaGQzYTU1cy9HdDVadHR5SUFN?=
 =?utf-8?B?VzUraE1hb3ZMVzhHVVZ4Qi9Cc1pMczRkMWY3RFFsRWtqVlF3Tmt1SER3V1hT?=
 =?utf-8?B?N1JhL1VLTzhzRFlKT3JqUWdMQXZEeWJnYXlHSXVtVWkxcUUvbHIyZ2FzemRZ?=
 =?utf-8?B?VFcxYkovQVR2ekI4Q25jaWt0dFUxOHoxeUxuK3oxUUU5Mzc2WHUrRHBxUm9G?=
 =?utf-8?B?ZXpaTkhhSHVKKzNrdm5wQ2RKYXZKdEtuUTQ3aFJTQnNWNCs5QjZJbGJiaUdL?=
 =?utf-8?B?S1NXREwyWHh4VVpYdGFyOHY1aXlYQ3VSdEUxMUpiK2lJT09WZXNOWDloeUls?=
 =?utf-8?B?UGFUR0hEeUpmZkZxaDdkU0FvL3BlcllWM3FPZGdSdjRiTjdpNTVyYmhmREJp?=
 =?utf-8?B?cjZXWXAzUHJKcUdXSlhBbUhvQlpDdlV1b3FLaWVzT05pY3NCSVh2eHdoYUZZ?=
 =?utf-8?B?VC9jN2lPNU5LTkNrL29leGRjamZORXdBNHZIbDhEcmlFbGlhWGYrWHRmc1BJ?=
 =?utf-8?B?R20vN1NRMHdFMThmbDJoYXRaUFIxbmhGM3NwYTJabUgzMzRnQXV2QVNHK1U1?=
 =?utf-8?B?SFo1clRDQ01UUVpIVU1OWkJKNm9NUHBROUlrNWdYR3VpMEtJSWNYTFY2VEZB?=
 =?utf-8?B?MHFOWWFKbGY0WjRiM2RwMEtzTXdwZzU2S3gzazNwUjNqR3JOQ0REcmdtL1VJ?=
 =?utf-8?B?SVFWbWFDb0RZa1JDOHVleG9XSFJibktsTFRLaHp3SHcyS2krMFF5VmFtWTVa?=
 =?utf-8?B?Yk80WnVEdXlHUnFTRDJseVNCeFRoMHFrWmxiZGFFbXYvVks3RjRwMGp5cEx3?=
 =?utf-8?B?akpCSGNRdnhPWENLd2xWUHkraUt0ZXU5L040anRDNXZTdy9DOHcva093UGx5?=
 =?utf-8?B?QkZGUnlLRERxR0pvMHg5UW5PVGM0Q011aHFjOWhVQWllVVorNU9iZXdmaHI1?=
 =?utf-8?B?bHFJemdaL3JrbFF2Wmxwd1Q1cnlHM1ZRRktDMkRqRUpLTW9LRnpmV0lzMkkx?=
 =?utf-8?B?Zm9Kb0tpSXdJUUIzYk9Va282TmVyZWF2N3RmcXc0L3lrSDYreGFoWWhDcGdJ?=
 =?utf-8?B?ejdVL1o1SkN1QncxK3F4QVVnUkJtTXVRZ1AzdzNZUFBxczNkK2Z5YjVBWmJy?=
 =?utf-8?B?UDIxSmhrOVpLMmpaZ1ZzejRORWpvNEdRdlNwQ28vQkpuR2ZXYThyUHZQRGtW?=
 =?utf-8?B?T3lKdUw3MytrZjBPU29FQjNyd0ZETENnK05sTzNwNEQ1N0VCOHlOQnRnZkhj?=
 =?utf-8?B?Z3h1OVdDSGt0NkFUNlEydjZjdUVlTWh1WlVJNzJBRDNPcnVwM2o4SFI4akUy?=
 =?utf-8?Q?3U19julbWt8/T?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea85920-4749-45f0-1bb2-08df40d1a3b4
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:28:45.3527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17272
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 01:41:38 +0000, netdev-bot+sinfo@kernel.org wrote:
> This series looks like a fix, but its
> commit messages seem to be missing some information:
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Hit during development. I was writing an e1000 device model for a
small VMM, a learning project, and it did not behave as I expected:
the model saw the driver enable TCP/UDP checksum offload in RXCSUM at
open, while ethtool reported rx-checksumming as off. Reading
e1000_probe() then showed the ordering problem described in the commit
message, and I confirmed it on QEMU by tracing the RXCSUM writes, as
shown below the --- line of the patch.

Thanks,
Jiaming

