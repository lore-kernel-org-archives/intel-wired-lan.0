Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F748606A321
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=X8e3U2WJ;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=GhKk1zuM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42AF08145C;
	Thu, 12 Nov 2026 16:55:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lh_UU4fk_yY9; Thu, 12 Nov 2026 16:55:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9788B8145D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794502515;
	b=lB2hj04WohQBtuqIG7D5w/mt1EtDWBxNMIXOMV3C6kBrelmNmQTWNuFFDRMJso4PhNxn
	 Tq5RnYwrY96JGnXjSGGll65a1emRTQiYpD0UAEdD3s6pf4Rxlw1+PeruVY2D+7qdQEPMY
	 uCOnxyEUnb9EwJFfgOuA5UYB4y0gyLGW4P4+FcIZnsGBscDaMaAhGN1ZQllmLH8mBvIES
	 sSI9aEOD26G6QIA2tHiWkkselGeNCQUgTm4tslRtDnP7X/k4ijjZGeJd1bbmJRDfrka4/
	 CIPcUReuy3SLDsj2beWKRi2/LpJ/odiAH4CA5/zc/ZoRUuKhy8Da2TEBWa0W5jIBVqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794502515;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Subject:Message-ID:To:Cc:Date:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pD2Z7QeGIF4/kr3rbI/v/QPvTfaXaTFhmqva8MEDnCE=;
	b=PAVJzS+29Wmv0Wm7nrbi29qG8V4LfsPxWkdgbdHL1ulvedmHwxjRFVus0EoeErxEJFpH
	 uQiDIb7CeTEJ2ej9H8vi1Y4I4GqfzZ9ITHfv7jMTVor2dYBetSDTWkVpOHijAE9JYM2Dm
	 7qQKBSfYp9UUqROrpmkmqPO9RwEUWZ1/82oHpEN3FSI1hCGnD3yfp0aIlozpubhs8kd5D
	 doiLCbhmJ4tNDrElld0qWpOlprIYG9gwEXtaFTqgJGzNYBB9ivseTrkTqEq/IGK6ygFdH
	 W7RMMU2mB2nxnKk5tNdc3kFHFHXHQEULTAV9mmYEowcx+p3+LLk4qOpnK2GUZ4yyWQA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794502515;
	bh=pD2Z7QeGIF4/kr3rbI/v/QPvTfaXaTFhmqva8MEDnCE=;
	h=From:Subject:To:Cc:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X8e3U2WJ/Qh7AUTCsAwhVQ178RPA7n4Mky994ExwBQU5Qy1BlwXvlli/kEdRhVsch
	 k93T++4q+ywv1uYgS4O50wDoV39o2DCg/PZqoKIag6+r1ZFtxzZ34VTrb8Q8c274Ne
	 Z1ooIJAplir+euNEVegt56TiWAXN+pe0H7YSEM8JnveVg4OqBngwf7iZTK6udqPJ8R
	 OpplqLUezA0rUCxWmVpGKV2azeciySdi6f3Ecr8GgaQyStuovTQHC0n18pTZbsTp2P
	 VEwHOJfMltwIz91tbyX5yGwXnYmRGHXbHgJm1s/AFseq9IAlM8ilCyHggp+nJCTUkU
	 /aJnzVzVn4LQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9788B8145D;
	Thu, 12 Nov 2026 16:55:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CB681A6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4DAC540217
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cW-1GNj246KH for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 01:40:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3F073403A6
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.103.43.38
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.103.43.38;
 helo=tyvp286cu001.outbound.protection.outlook.com;
 envelope-from=fan.jiaming@hotmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=GhKk1zuM
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn19011038.outbound.protection.outlook.com [52.103.43.38])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F073403A6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD2Z7QeGIF4/kr3rbI/v/QPvTfaXaTFhmqva8MEDnCE=;
 b=GhKk1zuMnkSFsfOuo2T1xvZKvFvdTIX3KWzzo5MXSHFj817FpC8SMOb09cCsW9wHPJfXip7D+M3RDId9wXNxhPQQdZwdslx/AhPJpHkTLcD6rfUwXJpucKWfHW7UWq4eyrmRtasgyjfQI7+U++UANHcLtHEHbItqD7C3r6/VvcodK+mlRu2Qrc0AuwOMdlQDIBwzffPUEHuRUy2X/ngcqugkO54TEQTPbk9S95niW1akQtArCi9lehbs1a5GK174yH3IO7QP020dorcHbyPywKf9EaT3a1LVUG63GTnIb15d9qmJpftLp0In9pIDJLztB2hSDDSIW4ESdHLdYaHCvA==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYKPR01MB447534.jpnprd01.prod.outlook.com (2603:1096:403:900::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 01:40:04 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 01:40:04 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: [PATCH iwl-net] e1000: report RX checksum offload as on when it is
 enabled
Message-ID: <OS3PR01MB10251F4C0DDF4A1AA90095494E7702@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Cc: "Tony Nguyen" <anthony.l.nguyen@intel.com>, 
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, 
 "Andrew Lunn" <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, 
 "Paolo Abeni" <pabeni@redhat.com>, 
 "=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=" <mirq-linux@rere.qmqm.pl>
Date: Thu, 12 Nov 2026 01:39:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TP0P295CA0018.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::16) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID: <eb37067d-9560-484a-9682-028460a0ac6e@milk.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TYKPR01MB447534:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb90c21-c691-4eec-bb47-08df405ddf87
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|5072599009|23021999003|24121999003|25031999004|22091999003|5062599005|15080799012|19110799012|8060799015|39105399006|24071999003|12121999013|24021099003|55001999006|25010399006|4140399003|20031999006|3412199025|25131999003|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnVoYjBXbmlDTW5sZTNYNU1EVGpmbnRWRmI3Tm9YbnRDM1Bra2dXUGpNTUpl?=
 =?utf-8?B?TndlWEpBN0REeVI3MnZhN0hVci9PVXJBN0JIeTFERWNWUHRyMFZDaUxPR0NZ?=
 =?utf-8?B?SFBzV3NOSk1BZGdtZ3c3TmtxRXR5b3JZY3VZcWNHQ0lsSFlnbDlTRDNIZkV1?=
 =?utf-8?B?QVhSbTdpMVM4RzhsY2ExVm5FWlpIQmZldkhCMmJvYWk2ekFQZDQvY09TVFpE?=
 =?utf-8?B?S3QxRHRCelNHNjV6UVRKZjJLN2tWWmxlbTlCVFVrcnYzeUF1LzNIdDZyMitr?=
 =?utf-8?B?SUFhZG9DblU2U1lQVHFjaEE5N1FLQVQ1VWRCdzkxaDU1R0grdXVyVy9SM2pH?=
 =?utf-8?B?c0RLZGJLcmpjUWJMbno5VFBzMzlZeEo1UXNhK3BNQ3J0c3JwenVSS3JMYXU2?=
 =?utf-8?B?NStoemh2N1o5NkRaK3FDS3d2ZWF1eWVZYVhnVUV3cGQyNWFMMktMQUdzWjN2?=
 =?utf-8?B?bUJ4LzNzZnc4bGNNSHQ2aWg0ZnpLamJNdVR2Rm0vdWtuaWQxeGpXdDk1UlBu?=
 =?utf-8?B?MEl1WFg2aGhmTmNEZXFaV1UwakVSRytCZE91c0VjS3psWk5nMTR2d1NJYk50?=
 =?utf-8?B?bG1kODFQTTE3bnBJd0lpcjFRd1ViYkdzTFZ5Wi9kaFlxSHNTYSthUFRJeUhK?=
 =?utf-8?B?bWVIUG5TK2MxVitLeFFFWnEzNzVqQXlaaUNTek9KbmtudlY3V0Q1SUlVRUtK?=
 =?utf-8?B?Q3diN0orL3NMUkh5L3dSTnNreDhrTVBxSks0UGNobGtKZXJyWlF1WmMxT1BX?=
 =?utf-8?B?dVlXWnZucktkN0ErK0VJZEE0N2Q0ZUFoTFZHMGRrdEQ1VWRpZ21WTy94WGM5?=
 =?utf-8?B?dnNTM0phZllCUnpDeXl6VzV2YTlyTHZleDFkckpxY3N4VWtzRkxjenJoQ0JR?=
 =?utf-8?B?U3R6VHZnSk1KUnZUMDhRNWVUUU1vNFNncXFFZjJib1hHUjAzM3FtMWVzZDRj?=
 =?utf-8?B?eDZhMHRIY2ZCSzRRSUdhUElEZlFVbnhKR3RBM3JidDdicVJkQytJVW1ROUVh?=
 =?utf-8?B?RStmaTd3b2dZQk82aFJGSXAwMTVjSW42ZmJMNFl4UkhuZENuVmpQcU1ZK3F5?=
 =?utf-8?B?b3dES2FwQzNLWm5kQjJ3S3VHNnlacEVIYzJOck93aC9RZnhBeDJZMWpCd2tL?=
 =?utf-8?B?cllmNHRwYkVYQ0kyaVczQlpuUkRxRkNBK256V3UwMWtlSTRoLzhXcG1CdkM5?=
 =?utf-8?B?NHpuaEx3KzJaSSthTUwrOXo1OUxTMlNwb0JKNFk4VlFjNEFXSWhNR3dpaTZS?=
 =?utf-8?B?SGF6MDR6cUlqbjc4cTVBb2d2MHVld3B0Q1JSZTFuNVkrVXhjRXBMUU1DT0Fs?=
 =?utf-8?B?V0phRDJKbkQrSlJhWWpieWJXTm9DcjhVV0E3ZWpMeDV6VEF3ZHo3UzFDZmZZ?=
 =?utf-8?B?ejV6a01iakcrVFBxbXpQSUpZRUx1VFcyeFlKdlpXemwrUmZaNE5FWWtWc0Iw?=
 =?utf-8?B?VVdLRjBDRjhJUEp6WDBzRnpKeHNsSE92eUhLVUIxSTBPbGMwSE96cDg5TmR4?=
 =?utf-8?B?cHBEaU9UTjJXSHY3d3gzZUhMYlJtVDNoV1J2WEFLekZ2ZHdlTFRva2RlL1Vz?=
 =?utf-8?B?cElUNmp4UktkVVI0b2ZPbWlTRDFqS2NUMFFSWXhLYXo5bElJWjMxWnJJVEIv?=
 =?utf-8?B?OGZ2THNHTy9PV2JWbFQwMzc3ZlgxRTJpRlZrZ1RtaHRTZHZxRXhBNWdEUXkv?=
 =?utf-8?Q?R/2FFRQH95c1Q2ad5OiC?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blZOZ05OVUtpemI4UWh0bHZHWG5FWFM3TEY2cGJ6bFhBUXdXbDU3SDBIdW93?=
 =?utf-8?B?K1pIYVk5Z2hNWk9tMkptMEs0RUZyQ2I3REU3RlpzNWIvc2JiSmFERUI2RHE2?=
 =?utf-8?B?cXFxc1BDTVVFSWxSSGxvQTBEcWprN21XdHI0VjQzSERjb3l2QmZBaXZPWElL?=
 =?utf-8?B?WHVnSUhTYnR0Y1hqSG5lZVJHN0E2Ry9ydjhab1pCYThwT3FVTnY4Ynl5VEpR?=
 =?utf-8?B?QW1SQXhRQjFDV1UrellMdUY5VzVoRW02K3VBMWtOWXpqRXNxTzNwM0FIRHMv?=
 =?utf-8?B?WlRTcTRmbUtYVDUwVUpPWjAvMHU3dldTeVVJS29icExUbFNVcG5pbUNPSmZh?=
 =?utf-8?B?ZmZBYmhNRWtsTE02Z1VzQnUrcEJEUW9Tb2ZCUEllRU5hR043YzRvV2lDRGZm?=
 =?utf-8?B?K3BVb1BjYVdCdjYwSUN4SElveElMRDRlUUZrUW80VXhiZklZY0R6LzlJRG5Z?=
 =?utf-8?B?cVdoK2N5L0w5YzRTS2VGNkVyMDhUeEE3WWFJVHhhQ3BOYmVnSWJUdXk4Sno4?=
 =?utf-8?B?cXV1a0N2aDA3V3RSTjlmLzAzbXg5aitJajRLYkVRd1prc0pQU2d2MU1ZZTRl?=
 =?utf-8?B?cVVmbFVKTExLaDNTcHpDcE4vWlNSWjFkUFlCM0liZWRhVEp4QnkxU1Vnck45?=
 =?utf-8?B?VmdSK2IrMVoxWkJ6MXhXb29lZjJkOVpjTzJobVJDWTZLNXUxOHFkYkUzeUdU?=
 =?utf-8?B?MXRkWkRiMzUvV3FUZUpwVDJlN2lNWEJNbXh4am1jb01YQ3ROd1JXNGxqaVdj?=
 =?utf-8?B?cW9jcVlzLzVWVVRzWllJcVl3OFZSV21wTHBvalo1dk5UdGtlclkvZFFTZ2s3?=
 =?utf-8?B?STljSG9hU0c1Tm5nY3BYQkdOOW02T0t6d0R4cGROVGdUUmhRSFVEdnppQkQ0?=
 =?utf-8?B?b3N5Yi80MzU5ZWlkOUU3aGVQOHZlR05NcDJyWDg5S1VaeFE2TjhJcEtoamFE?=
 =?utf-8?B?MjRqem9KTWtWeUViZ1p4UDI0V2dxQ1hxRm9nblY0d2tENkg2UU5ZZkUzeGVV?=
 =?utf-8?B?Yys5VkZXRE5ubDJ1TkdQelgyemdEd2NPZ2o4Rk9sc0dINnM3NlF4THQ5elJT?=
 =?utf-8?B?V0VWZGxsYXJiS2dHTGdVMndNZkpMWTJTZHpJaVYxK2s1ZW02RFJXTDE2Y3lm?=
 =?utf-8?B?REhMcGpTdDZxRVBIKzA5TEFCUE5GMEpwNHFQRGZjWUhLTm92OXJsVDNSYVJv?=
 =?utf-8?B?RFRSZTdkS0JmSVRIQWJ4UElyMnZOWEpWS0JiVFFZczNGY3UvNDJCdXFwakpP?=
 =?utf-8?B?R2tRMnJaMVFXb1lydU11MnJpVEFLS3JiczAwQW5ndDBuSllLMElaL3dGcmxm?=
 =?utf-8?B?VHNHVjRPdVlTK3VKczZpV3ZIUmRtQlBtQmxYV3pVSHZORXVEbXdrV21nRlE5?=
 =?utf-8?B?NWZNWHJCblFUcU5pbHRQNXl4UlV5OStCWmZRRWR5T2pRSmd3SWdha1hyV3R4?=
 =?utf-8?B?NC8rNFNBVlpHU3VOZU9DQm9QZ0pGcGxFUnhYd1FpcUJaWGp1WDhlbjFMZmV2?=
 =?utf-8?B?bzVScUFwU2dJbndnWXU0Q2E0akt2Q0ZTTHlYUzVhSlhQTU4vWGpzbXRPNSta?=
 =?utf-8?B?eWlveGxFR0pEalhyZzM4SnN4STRpQkkrMTRGalNVTmUvN1p2WTFEc3I4bnRx?=
 =?utf-8?B?SHVXL2JlQjIxNThjcVFFUGlRVm9oSm5WL0ZtU1dDdENvOHVST2ljNUloYXkw?=
 =?utf-8?B?REVMeEVUWlFrbm9DNFFLMnFEZ3FpSFVSamZ2cldRbFhxWFpBQkdCbWJNc1JD?=
 =?utf-8?B?bWtIcVlXL25TQm9zVHFiRWJKUGJoUEROYnNWWHExL0x2dTVtUW15eGRidTdh?=
 =?utf-8?B?WkF5NTNuUXE0d0MrbUhSV3dzNW5wWWpna005c0JWam5kem5JNC9FUko0UzF2?=
 =?utf-8?Q?BriXq2v3snHA2?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb90c21-c691-4eec-bb47-08df405ddf87
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 01:40:04.0162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYKPR01MB447534
X-Mailman-Approved-At: Thu, 12 Nov 2026 16:55:12 +0000
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

e1000_probe() copies hw_features into features before it adds
NETIF_F_RXCSUM to hw_features, so the feature is off by default. The
XsumRX module parameter is on by default, though: e1000_check_options()
sets adapter->rx_csum, e1000_configure_rx() then enables TCP/UDP
checksum offload in RXCSUM, and e1000_rx_checksum() uses the result
without looking at the features.

So ethtool reports rx-checksumming as off while the hardware verifies
checksums and the stack trusts the result, and "ethtool -K ethX rx off"
does nothing: the requested features equal the current ones, so
e1000_set_features() is never called and adapter->rx_csum stays true.
Offload can only be disabled by turning it on and then off again.
Before commit e97d3207c5e6 ("e1000: convert to ndo_fix_features"),
ethtool reported adapter->rx_csum, which was on by default.

Set NETIF_F_RXCSUM after e1000_check_options() when RX checksum offload
is enabled. With XsumRX=3D0 the feature stays off, as before.

Fixes: e97d3207c5e6 ("e1000: convert to ndo_fix_features")
Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
---
Tested on QEMU's 82540EM model. QEMU does not emulate RX checksum
offload on this model, so I traced the driver's MMIO writes to RXCSUM
instead:

                          before            after
  probe/open              0x200, "off"      0x200, "on"
  ethtool -K rx off       no write, "off"   0x0, "off"
  ethtool -K rx on        0x200, "on"       0x200, "on"
  ethtool -K rx off       0x0, "off"        0x0, "off"

With e1000.XsumRX=3D0 the patched driver writes 0x0 at open and reports
"off", as before.

 drivers/net/ethernet/intel/e1000/e1000_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/et=
hernet/intel/e1000/e1000_main.c
index d7e279b..a52fff0 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1111,6 +1111,14 @@ static int e1000_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
=20
 	e1000_check_options(adapter);
=20
+	/* The XsumRX option (enabled by default) decides whether RX checksum
+	 * offload starts enabled. Reflect it in the features so that ethtool
+	 * reports the real state and e1000_set_features() sees a change when
+	 * the user turns it off.
+	 */
+	if (hw->mac_type >=3D e1000_82543 && adapter->rx_csum)
+		netdev->features |=3D NETIF_F_RXCSUM;
+
 	/* Initial Wake on LAN setting
 	 * If APM wake is enabled in the EEPROM,
 	 * enable the ACPI Magic Packet filter
--=20
2.56.0


