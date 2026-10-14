Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41955CC6B2A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 22:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DED7B608CE;
	Wed, 14 Oct 2026 22:22:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LvFeeRquBWK8; Wed, 14 Oct 2026 22:22:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 190AF608DF
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792016553;
	b=eVOVq4eU7tqfhwD5gD8Gngzs6vv6VcPRQB+tMb+yFiBRqrVX28YTN4I1w4CEKv9NUgaB
	 ooPGVKLxlsoA/Z2q7DkwmkjbqvlYqXgVcRdDbQlKdSAujko8yS6HiKKrW2JHNJrtCgzQL
	 3iZGXcUlTk5MjBT2zp2S1Q6WoS1pv/IJHmQ2pu0DAiGyssGC6xWpzrBwOEJHrsc5b9fcB
	 KZXE3J5ohuszis+kwSbBMNkIQT3dgKrcLJ6TnuelW3Me1KvP2pWhU1pEGpn4OQsYjyfUY
	 RWc8cZVnlYBaoFFUHfyKhJ7lCS7QdnDMaEiYIJ+YIDpYdPmWErgVZvGtDiueehbGGtw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792016553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Content-Type:Message-ID:Date:
	 User-Agent:Content-Language:From:Subject:To:Cc:X-ClientProxiedBy:
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
	bh=X16xKN2yYuHSKkYXOg/JHBrBd9ZDz8K6zONuOODGLsA=;
	b=ayEErHbeu7sqzFJ9v9i8s+k887vlsnfA9TWIZnd75Rbu+KucMlQlZ4F67tXRp4vL1828
	 rpc6QRR4GiHfi3Nh+CtSm52lupmy5dNPHmXIszb2+ToqxYYQ6OIjzgdRktviw49Ko+nyk
	 g3TFNn/vhwLeJs+0dDFtEXpw4LA/YN8aT3YZwVQKUiqMqyIgU7K8fvauatzUY42uaK0CM
	 bn47rx1kDtkngWud2ywpULtFFKKk2bZxMt+9HqO22HyT6ZSl0L00PIZxGvnnUxTus1k/L
	 fUQKiooEgy2HfE82d9WfnhhzzAiRzYBJfU4XZLmR23iZRuF0MK4sq7GxTk/brMg6+0A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792016553;
	bh=X16xKN2yYuHSKkYXOg/JHBrBd9ZDz8K6zONuOODGLsA=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=v8+l5n459LgkI0FELnLct3mwwJDIIFUSZwbPBY6097dy2Z4kYsBmbvL7UFb662jTV
	 F6ywF+iYoFov7ULivyLnU4Up51Y4zrLSbjQRJxl1RP/XfDnN9ZyOKl4bLg0xw2mNTV
	 TVAechvo389o0ARhrZGCr58owxGZ/3yeU+8p1KKSf0VcW8Ht2ZZ4x4ZOqvAbGQMULA
	 1U4AsIJZUaCmfCKIEIIDv6GSxMd+2ahIOAVbnE732L8Nsdj6NChWpNkTYaBiXc9Kia
	 3dZl0inlTZ7JNlvxUhCZ7uM+rZOpMRfPIb5mhB/U0/5Y67VB88+nL1COUA5b1pPWNW
	 eBi4cyH+51spA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 190AF608DF;
	Wed, 14 Oct 2026 22:22:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B74B7255
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 17:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9DAA84009D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 17:47:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fSCceOae9R22 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 17:47:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7643B4016F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.103.21.1
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792000047;
 b=bIrNm0HRqZyEeO7eE5JjdWXmMXtFbEcsSpEiQAyxrxTLMNeV2asdumiw0d0OQm4VdZkg
 nOHFCu3RAydIER2VjpTXRpn3Zi9h0G3azu81bbJuz/2r8/nauZxNSZobY8JbTEclNHdna
 8H2c6yP2pzzw5mmQ1MiUqNGpUQklUXNOP8TQUS8q9Uif2Dk6PN+TktYPzgavMqRNl80P1
 of2/Nyq821ri4wfTDwK4WXACODwu6UFUpmgBl/S8y1jIiwH05YALLORvyuu3NoCTXmNJ/
 h+bsZvnQB2ROhwbjmPfZo5VeSBYu5vL7a+veet/OHSO7Xo2olLXIDuKtYK38N/KXsaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792000047;
 h=Received-SPF:DKIM-Signature:Received:Received:Content-Type:
 Message-ID:Date:User-Agent:Content-Language:From:Subject:To:Cc:
 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=X16xKN2yYuHSKkYXOg/JHBrBd9ZDz8K6zONuOODGLsA=;
 b=VrCdGYuFp/RAx4JASJ/ipy+RNzH7plhPBL9i8D/Y3UleSs8NySqPVzpaUW5w/eT2tThu
 nv0t6EOZQjHXeM/gRyekJt6gWLAq+b5fmB9qmgIyQLY1So0E52/3seJA3hW3asjDMpgXh
 vn3Yf9EbfO3CGtHyjYR4EbgyzONUreEncLAsddgGLGQhTEMOPHkIc44HHUmPhF3pV2CMs
 +3+AjNajGL0KuBxHsZ6MhN9VHyEvB1Z+PRY+co+peNCPq9vpPzxvujyckUYsKP27Q0cxx
 k65P9GzbJbPGOz1t4uG8/+BBw0Ol1PvwMPrNFnhMJkv/4VcnrzM+GR2tns5OQVbKcNg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=live.com;
 dkim=pass header.d=live.com header.i=@live.com header.a=rsa-sha256
 header.s=selector1 header.b=Bs3WWzOp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.21.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.103.21.1;
 helo=cp5p284cu019.outbound.protection.outlook.com;
 envelope-from=ruanmed@live.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=live.com header.i=@live.com header.a=rsa-sha256
 header.s=selector1 header.b=Bs3WWzOp
Received: from CP5P284CU019.outbound.protection.outlook.com
 (mail-brazilsouthazolkn19010001.outbound.protection.outlook.com
 [52.103.21.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7643B4016F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 17:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAr8kNsmqpS8iVznNOarfWz51xnP57Sf4GtVlA74x8lnBjSwCdrBSUHy0gFp/BuLZXhO7BFVZuiYD9970AK2YQSWRKyWLv5NSo+G5TVKqzA3/A2ds8Idaq2/8jvjDhCmENboEF5ZFqPGVCTnMjMVpoAcDpsNIrEd9S55Tbf8I47v6l+MMNi4LLRwfbVcjps/7ADfiATi7jXXnwAFZd/KgNWXiZrHQi7BbYUvvpAMc3/rKkx2JeQsy+3KxXpF+ZPAIge8b9FXAbjsGgRV0QG3KVOHTvTOM8pEG0oOVTyjU96WjSIEgUn4eTcHP5punfc/TmNfw1CYEYiVNqte5XPSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X16xKN2yYuHSKkYXOg/JHBrBd9ZDz8K6zONuOODGLsA=;
 b=vYwRKi5o34E0XjYFvneJ64Ky4YWN/5MWZmvP/r63oP49PofXPj6XZqaZeJqPYXyPJtoSAp4Gpjy1H1KW9ztR4lkNLEQzuWr76hjFlwa2Ec8N+4NC3rh0WAFvFwfnJrtMDsp61wBllZm+08ZvnZeJTqlPAk3xXpbZsN/mF2dkpAZXrSV42BacoNWz92QXE7UWeIH1c0RBH+23Qn6sC1GasSA9M+sVpYhP+ewCRUcN1YjLqG3XyUv1mCoHJd5xb0LqCdRYi6k18GPJgDI7DA7Q2G/17DaBxBQ2ne9bdi9N2miTEX1LmdXGKGcSZcm10PubPUmIUDxOr5c/rB2Spsl9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X16xKN2yYuHSKkYXOg/JHBrBd9ZDz8K6zONuOODGLsA=;
 b=Bs3WWzOpdcfniFqO4Y9d3eCc/luLaX6tfC2G0lBu9Fi/IRkONchprU+CLiyURt0NTLPBYzMw4Pl/kvXI5kFTrGK3JN9YgsXjtunBzmFC6mC2Q0k8Tm+RTVSm7q9pTi36pYuUiaPm9RfyoMWb2ncxzYgcs3tMdmz5sfN97/k5/cnv81QsNWvOd75G+ZuKmQoH4WPcJbnWlnYSx0ftL/EOYd9OiNP3OsLvANeqUpL3hO5eGsjfyYQo/fsFwEOQm5BU0uSOV+p2+KU1zIJdPOev1rvWGypNbzshV74P4xm406hcJrVLoOKL5eUR5lQn2RZ137NZ9H1X8bCSpe5N2jxLxA==
Received: from CPDP284MB3937.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:390::15)
 by CP9P284MB3722.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:37d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 17:47:17 +0000
Received: from CPDP284MB3937.BRAP284.PROD.OUTLOOK.COM
 ([fe80::ef03:74a8:3431:929a]) by CPDP284MB3937.BRAP284.PROD.OUTLOOK.COM
 ([fe80::ef03:74a8:3431:929a%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 17:47:17 +0000
Content-Type: multipart/alternative;
 boundary="------------enugZbzqauoLBkXvmR8LhHM7"
Message-ID: <CPDP284MB39374BC5A0CD11C9253CABF7C79D2@CPDP284MB3937.BRAP284.PROD.OUTLOOK.COM>
Date: Wed, 14 Oct 2026 14:47:14 -0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US, pt-BR
From: Ruan Bahia <ruanmed@live.com>
Subject: [BUG] e1000e: incorrect modified flag check in e1000_read_nvm_spt()
 (Bugzilla #221729)
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-ClientProxiedBy: RI1P284CA0112.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:10:156::15) To CPDP284MB3937.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:390::15)
X-Microsoft-Original-Message-ID: <e397457f-113b-47d8-833f-3deae73c640d@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPDP284MB3937:EE_|CP9P284MB3722:EE_
X-MS-Office365-Filtering-Correlation-Id: 61cfd9c5-97e5-4645-c5d9-08df2a1b3030
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|5072599009|23021999003|39105399006|13031999006|19110799012|8060799015|24021099003|41001999006|20031999006|12121999013|9400799043|25010399006|4140399003|4302099013|3412199025|440099028|1602099012|40105399003|2607281247196008|23121099006|10035399007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFRyTUVXdSs0azlnMHkzNkx0akhXT1NxSUcrOVZON0lKUjYxSndpWnI0OVJ4?=
 =?utf-8?B?U0xPeUVwMmdFM2pkbE5KalQ2d1p4T0FBMjdsTWo4dVVweWZNQncrZE9ETnpT?=
 =?utf-8?B?ZVd0SkQ5bDR5c0lnUnNpQk9heU1pRm5zb2kwWm5tRWs5Q09Qc2xCSkZOSTRx?=
 =?utf-8?B?U05WeGtrSmgrRktubmVyS0tyWWtHdjBqT3ppQ2h5ZFJ0ZUxES2JxZ1QwU2k3?=
 =?utf-8?B?blV6QkpPSCtaUFh3Tnd5MUNtVkI5SWJYcWplbTJQdnYwTTBWVGh2NUNSdHRT?=
 =?utf-8?B?QXFQanJXcSt6NExEWW5US2t5MThyNnRTMCtPZm4veWhvTlRMN3ZsVm9XcW1O?=
 =?utf-8?B?S0tvUjNEM21DcHd2QmFVVlR6QW1TMzVDU01xNlpJZGo0TVdPYnZPaTF3YkhV?=
 =?utf-8?B?TUVHU2lOUFN1UDRsTFlaRXQ1Y3QvNGNuT1UvMWhsdlZBdmkyRnJZSE1iR3Vx?=
 =?utf-8?B?a3V6UFJISmVKMlljai9nd2p3cTM0L2FqTzRad2Z1YnJ1OUsxMlFpV0lxQXlT?=
 =?utf-8?B?WlYrZ2FsOFBFRmNMT3UrS3FSUnNwOFNjOUpCbmFUOHAyQy9RNzhzQ25IQWNE?=
 =?utf-8?B?TGlTOEJKNnN5dWYvcHVRdFd4Kzc4d0VYMHoxOE5qZDBXNTI0SW1HU3MxSDJi?=
 =?utf-8?B?aUZHVWJydlJoTGR4UHdBY3ZnRW1lZ2dJMkhqQUJYMWZIUTZIUEx2RWZUQjky?=
 =?utf-8?B?a2JNZUgxQ3hEOUxLeFZURU9paTR2bmgzaU03VjdPZ29OWGpiMStKVzZRb1Vy?=
 =?utf-8?B?Y2FKR0tuYW9OWG9HaXFHWXZOL216ZXY0Q3VxK21uejRDS29oRXlvakFLUldx?=
 =?utf-8?B?dFUvZGRZaHBKcy9MWjJ1SVFOL1REUndETEFoMnY0Tk42MmdkQ1E2U2FYVzU2?=
 =?utf-8?B?OXlCQXhtYjBWQno1cGljd0NaQVNRdEFWUnROUGVwWnp4VGlncHpsYnNOeG9x?=
 =?utf-8?B?M0dRU2R5c041TUtaUGNGL2l3SVk5UGZjcmg0OXJmd3QxK3RBT1JOOUpLM0RV?=
 =?utf-8?B?d0JsbThuR3E0SHR5aEdOMkdMdnZScGd1Z2FtUTZqU1E4aE5WcGN6MkdTblAz?=
 =?utf-8?B?SlNrZ1dtWElEL0cxU3JCWk04N05TelRxKzl5U0tOaXFKL2VjMnZNVTlybUph?=
 =?utf-8?B?Mi9lWmxtQ0xEamJoalNoUFUwSTNWZW9QRkM4ZE9jRVl0ZjVucng5aFRtZmVP?=
 =?utf-8?B?MnlkNS9Ub2lWQWVPYS9qWXhJcjF4M3g5aTZZOVY5bHpVL0ZRSCtCYldvdllo?=
 =?utf-8?B?cFhCMndrU0VhZ1o1K094TkRiOU9lTUNtSHpWUy9jQlBJeVc1YUxCazdERXdn?=
 =?utf-8?B?V1lybVpOaFd6K01zZGF0eEJUMVhUQ2ovTDEwYTAxVkdLcnU1ZDRNdWRWZmpP?=
 =?utf-8?B?U3M3bHFobS9Cb09wK2VOcmRlNE4zaXlNTlg4Mll2NHRQVU4vQ2xpV3p2cWwv?=
 =?utf-8?B?Wm1kWjgrVTVjNCsrWkg3bkdGQTZ3c0I0OG5oc0Fib0dpK1NoUnVKU1Nzd3c5?=
 =?utf-8?B?QlZ0Tm1mWlZlSERlakJGMUg1eENnNWp0Z29EZ3locExTSzZ5eVNIbVl2UTBx?=
 =?utf-8?Q?mBewEZjohN6eMbFLNEqQSlYts=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGRBbXcyalF6REVPRnlCdDhoVXgrcjVkelI4L2tGRTFIY3BoUTNTV2J1MHh1?=
 =?utf-8?B?bGROYmg2WUNCYUZhdGFXL21TQnp4aFo0VnloWFFnNUxIVVc5MkltKzFQWVMz?=
 =?utf-8?B?MHBVSFJXZkhwdkp0SnRmajdWZ2RNREl2SEhPSFVZMHBOWmxOeEdKNXRTN0pO?=
 =?utf-8?B?T3hMSDRldC92Q2pYWWRlRjAxaW5nZnlQN2xVUm9GcUxQSXZKTDJVeFFTeVdl?=
 =?utf-8?B?alZZWmUwdkdJU3ZIWTdYejgyNlFhS0RGeWkrZ2ZzOFViR0Q4LzQ1ZmxZNzRz?=
 =?utf-8?B?dHdBcFVTR3M2Um5kZGtyUXJVQ2JDaS83bGJybVVrblJoVC9IMXJQVDBPdFpT?=
 =?utf-8?B?bktXSGx1a3NVd1FFM0o4aDdyNGpyNklqbjMrUi9aWGNQZWMvbU9hNmU3M2l0?=
 =?utf-8?B?Q3lZUkpySGl3ckh3RHJEUERBbE9lUW1udXErRW5pRUtnb0VQSk9tNmp2VHQ0?=
 =?utf-8?B?VmJnTXFXM2RiUmMxaGppakUvRjI0aU9panNCQVJDOWt0SEtQd096UCtnYlRZ?=
 =?utf-8?B?MXkzam91UDNvN1hKU29Lcm1RR2U1WURyU3ZpK00xUGZSNk0rSGtLaDd6b05k?=
 =?utf-8?B?Q3NHTE41RlNDellROGU0RXZQZW9GclRqZWJiUjVVQ2RkZWVxeWtOVUp1NzY5?=
 =?utf-8?B?YkNDNFpHZFdUVmc2c2pZa01hZkpobmp5RUYxK3hEa21DbDMvVUhUbDJ0Mm00?=
 =?utf-8?B?WkpLUHp4akNGZVNDblg2WWtmVk0rYmt6NU1JYnhZUzJXbjJsclEzL2VabXpF?=
 =?utf-8?B?Zy9meWVRL01CRnNCZjFiOXYyK0V4QzBKVzdyYTFZQ3E2OENjdE5mSmgzVzVo?=
 =?utf-8?B?eC91blVXVEh0ZlFhMlIyMVk3UWlITjF0dmd6WE1Yd2R3bjRwSHdHQVlrVmFG?=
 =?utf-8?B?OUxXbzZ2bXY1dEZnMmI4SnYxa2dqdTJ4eG16RTVjdmtJdkN1ZzZDTWpFWkZK?=
 =?utf-8?B?TjdsaHdBbkxrNUc3ckJvSFZXOHdDdllmcU5nWkZ4NnNkNXpuT0FOK1FKQU5G?=
 =?utf-8?B?aVU2UDBQT2FGQi9VRm9aQ3pvZUtDNWYydklJV1lXU3U1bjN2MnhrY3hMY2Ri?=
 =?utf-8?B?dTZaL1RIQWJ1VGJlZjBnUmxvL3VBeVlFS2J6ekVIQTRyZDZrM0tGMHBJMEMx?=
 =?utf-8?B?MlZCSTA1WkI1YU1HKzVYKzFMaFJMTmNDeFRYck9DWDF2VExjeHhSNnRON0Vz?=
 =?utf-8?B?UkMxMzVqcDJCa0RVT1lqUkdjNE1uRzlON3lHZTNiMHp0RHZjZmhibDdrTkR1?=
 =?utf-8?B?RnBFNy9hbkx3c2hNako2NXNHazNmd0FFK3FFMmlRWm5KNkNZd1JFTzNEbXp0?=
 =?utf-8?B?Y2dkWUJoUWh1ZmdZdGFOa1RwR3l6MUhvZkFWUE1jeG9GMGphVk9oMWtJK3Z3?=
 =?utf-8?B?OHFDVFVRM0tSVTloZDNubW9WZ010Q3dlR3RBb2R3RGhReGxoTjhBT3lYcnZh?=
 =?utf-8?B?ZEtiS2NvM1pWSHFqTXNBN0IzcmpVSVg1Q3pObHZYOEhHL08zcnVwdkg0dkti?=
 =?utf-8?B?K1k2UURXbFoyV09BTXhKVFVkMkxsZVBsQlUwbHplQ2hPSW9BMXNpTWFpeGgz?=
 =?utf-8?B?UllhTUU4SUJBeVRBVEUrSGtJYmdGK2c0Y255QzUwdGtBU1luRnRRSVNwVXhr?=
 =?utf-8?B?L0dUbUdSTHN5RnliU1l0eHZzblhxdkk1dDdRTlREVHJOWXVXdHBtOUNFOFI5?=
 =?utf-8?B?czJJZy9uWlhHMElWRHJSQTZFRVhlWlhmWWVZaE9IWGZUMkF0Zzdtemg3ZmZL?=
 =?utf-8?B?S25CQkpiSkRmWGsxR0NUWWk5aXh4K0pNUlBRZW9VbkpWQ1pwZ05OTVl2YW5I?=
 =?utf-8?B?ejRuTUdkNzA1RHQ5R3pIY1RWeVZyMXhDRVU5L2JrK1Noc21WdEpTM2ZJeWZl?=
 =?utf-8?B?OHFEN3JtQ1ZFVll2TUpGZU11UDdJWFJURTJHeWZLamF1dmpFVmRqYXF2Rlpz?=
 =?utf-8?Q?zoei5/4RRSU=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-da224.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cfd9c5-97e5-4645-c5d9-08df2a1b3030
X-MS-Exchange-CrossTenant-AuthSource: CPDP284MB3937.BRAP284.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 17:47:17.5375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CP9P284MB3722
X-Mailman-Approved-At: Wed, 14 Oct 2026 22:22:31 +0000
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

--------------enugZbzqauoLBkXvmR8LhHM7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tony and Przemek,

I am writing to bring Bugzilla #221729 to your attention (reported there 
in 2026-07-06 19:39), as it describes a logic bug in 
e1000_read_nvm_spt() that can cause silent shadow RAM corruption on SPT+ 
PCH chips.

A fix for this was recently submitted to the intel-wired-lan list by Ivy 
Lopez. I wanted to ensure the Bugzilla ticket is linked to this 
discussion for tracking purposes.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=221729

Please let me know if any further information is needed from me.

Thanks,

-- 
Ruan Bahia
--------------enugZbzqauoLBkXvmR8LhHM7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html data-lt-installed="true"><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body style="padding-bottom: 1px;">
    <div class="moz-signature"><span class="">Hi Tony and Przemek,</span><br>
      <br>
      I am writing to bring Bugzilla #221729 to your attention (reported
      there in 2026-07-06 19:39), as it describes a logic bug in
      e1000_read_nvm_spt() that can cause silent shadow RAM corruption
      on SPT+ PCH chips.<br>
      <br>
      A fix for this was recently submitted to the intel-wired-lan list
      by Ivy Lopez. I wanted to ensure the Bugzilla ticket is linked to
      this discussion for tracking purposes.<br>
      <br>
      Bugzilla: <a class="moz-txt-link-freetext" href="https://bugzilla.kernel.org/show_bug.cgi?id=221729">https://bugzilla.kernel.org/show_bug.cgi?id=221729</a><br>
      <br>
      Please let me know if any further information is needed from me.<br>
      <br>
      Thanks,</div>
    <div class="moz-signature"><br>
      -- <br>
      Ruan Bahia
    </div>
  </body>
  <lt-container></lt-container>
</html>

--------------enugZbzqauoLBkXvmR8LhHM7--
