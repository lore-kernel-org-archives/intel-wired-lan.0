Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF43606A326
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=UE4BxOS6;
	dkim=pass (2048-bit key, unprotected) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=PKKWqmMJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42B52607EB;
	Tue, 24 Nov 2026 08:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i5NA6js2IqWX; Tue, 24 Nov 2026 08:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3DD9B607CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795509413;
	b=JpzlffiPMAQy9cqF2U3Syyirbq2yLRLH+qjaSQdqkMOKbnfWASiaKFeB8Lrm00sHJuUm
	 gENac0TSUcZYpGhOIprb2+KroiG7mwMCtyUMoOpTry490H/cl2MtLFGncNIjXAIHUu9R7
	 H9GlgruKrPBTHSV1cRA5dj/HOFDesFDn8nSni346NfdJjdauCje0/2LOoDuEY3+Tvyn4C
	 MvYagOIylV29+6h3iopvQJBomAi6ezPPWox1rkDywWj5VaNZX2YxBkzFtXmcx4nCjFiEE
	 yNYCpa16UHaW+3vMpB0dYFXEdhldZbthJ3+xGFSD/WgAh6gyMfq09YoCm6/S0uMb2xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795509413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fn4T8+2eG58Q113G8qUOcFoFTQOg73KHaQ/yhdyuQFg=;
	b=VLJt55b9IDbtnEVgK0ezMdNyW/fI8ltzeEZEI9YOxkCkTN6zRHwMlrfa6uS8M5aONxaX
	 M/zYhORaiThsHrMU4a6YkLOyLkvJVwRFU1R+PSHQCOl7ABVeV95U6xS9ubMLWYrQ4lTtQ
	 26sEf1csBcwkjAlVYvIkTYcTjhctn2bSfw1PlcyQtTFMLWHBr/dMg35jjk6zp/50BzxzA
	 RWXm5WYndf1VMu8Ml4KGKG1ZsKnbZ0LzAqKIfSwte4vHlZ+5MiHLfyjZZUp2CcMHg+nsa
	 47XR/ieIbEp0IGqenXJV9V5ICmHiqOi8+ZBf4LFKs9upPS8pXtHQikzkVPiKJaJEr0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795509413;
	bh=fn4T8+2eG58Q113G8qUOcFoFTQOg73KHaQ/yhdyuQFg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UE4BxOS6AR5iI7u3WDsJRwiRAQ3IDniC8c7lmEJPihmSVwrB86WxrM147hJg2KMx2
	 FHYm5iPzKmHeYRBPpBOFr43mY+p1hkkwab0ItII64VdFm2wzIvYPCXLl8sojgQFU9B
	 7GUf6Uww9ZDi9RRtShyIJYvEO/RsGd3W/xFR35eUj5SlKcPaemY6NuwQxQieEjjoDw
	 Rg+jGzhdNtkn/cEoi0VaGCU6pEi6BO8BS/GtiaLqsWe38w9TgQ7qFwWSRUcec+pEBz
	 E/3WDc04VSIp3+I01u1Iuy3XW9ABhYksIOZrSqgFMku9NJYZmEXxfcS0ANnOTk1I4f
	 LCXelV3S+hxNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DD9B607CF;
	Tue, 24 Nov 2026 08:36:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 680363C4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 08:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4DCD3402E5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 08:36:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lhPOAiPQ_oSv for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 08:36:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9061740068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.166.238
Received-SPF: Temperror (mailfrom) identity=mailfrom; client-ip=205.220.166.238;
 helo=mx0a-0064b401.pphosted.com;
 envelope-from=prvs=57887fb7e2=ionut.nechita@windriver.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=windriver.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=windriver.com header.i=@windriver.com
 header.a=rsa-sha256 header.s=PPS06212021 header.b=PKKWqmMJ
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9061740068
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 08:35:48 +0000 (UTC)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO5bEt5160083; Tue, 24 Nov 2026 00:35:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=PPS06212021; bh=fn4T8+2eG
 58Q113G8qUOcFoFTQOg73KHaQ/yhdyuQFg=; b=PKKWqmMJfMuBQkHsBO2e0dIl/
 jEbTqScH/JcdkV8nE8rSs5Nn+BQMx5rpEnjf6pYfA7R1vcMKHoIXBgoMvaGXIPKK
 kudTK7UpWJT7iAzT/oph128VNvbRYqhtGkNxItTRltJ55QaJCJq/b3wuPdiacBTE
 5r9hDAQPrViq7SjvkAVsMVIKv5CvQhqbu1VDmtADJYu3LJh1HhLnWYLhCuQSa8fS
 gj8gw0/oH1nrsoS589LfDH9xfhQqwfHTMA9izK4DgUYNdJfVWxnzLYNgkEnY30pI
 dallcBx6e7gFSBgSPPPRmqAWQyf+iOkMUMleMQj7SUcMdrTdwjv9FFlXyuUOg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023142.outbound.protection.outlook.com
 [40.93.196.142])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j51d7rcxu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 00:35:25 -0800 (PST)
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by IA3PR11MB311547.namprd11.prod.outlook.com (2603:10b6:208:53e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 08:35:22 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Tue, 24 Nov 2026
 08:35:21 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH iwl-net v2] ice: release IRQs and rings in ice_dis_vsi() when
 the VSI is already down
Date: Tue, 24 Nov 2026 10:35:06 +0200
Message-ID: <20261124083506.14071-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::36) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|IA3PR11MB311547:EE_
X-MS-Office365-Filtering-Correlation-Id: d10deea2-0b5e-4720-74a1-08df4a05e0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|52116014|1800799024|366016|376014|7416014|261021121427099003|261026121527099003|261028144727099003|261022105027099003|261022075727099003|261026140227099003|261021123027099003|261102123227099003|11063799006|10067099003|56012099006|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: JpJE1cz8W78mIe8VPOf3cK17xDgQItPNzliR4mwOTjmOSeJ+qiZNdzkPfOf57naItviTDDS7R9FWq1p4ffiQ3y0sbB7RQOruWTg+P5ZqTHQJvpFERNrmrJYvuQw0SzL+H4zo4KA14p+h62v0BJ6lNRY1tSg5lHABDSrJWI2DyEvEu74VhjSUQ7ZkyEZdofOkduHoMEi7Q1Y5O9M4lma2+j8VA29n6yviLp5rlcgXE/7Cwe4EFywfNJ1MW6V7YUd14HdwwroGpPcbglDV/YjNfs2GcubJLAtYpgP3e3EN9E5wKTKClGmAidalzgzHJdWkIBHYQdwZo0vT1TdRJY3NKngnNDOULsSiq95wpTcn3JlfHQEcvyalnwCILM1wZpaQLYAh5ZieFJc35BQoUuLqPrEOLMjFZ861zwJo+Ipd7ofrrmlWy4OOMG9X3D3XQdoXCqloM9E+R8xWqB1BeG5q2ZyMnnkzUyDZus805xJY8yhIwxbk1uirmmI2Y/uHeTZnZWUtmROPyc5znrQ31avqZoBbRw4bHMuiWTPjj28fbe4OjbYCtfZoRwAMzTxJrYeas7GAt0XjYGXXUcS6TdP38L8pExv/UnrCnFTScNgUgqME8EPaV3jaPVyEg715GCii
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB7546.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(52116014)(1800799024)(366016)(376014)(7416014)(261021121427099003)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(261026140227099003)(261021123027099003)(261102123227099003)(11063799006)(10067099003)(56012099006)(261009223027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XpKCyhvKR7A7VJs8skN6W9yXZULGbLcKeZ7hb6lDxOklSUlhNeHe3fzOLoSD?=
 =?us-ascii?Q?QFZsfezimA8nGA93vuMCnl4vuWwGt6NJUyYPDhH8dwoBaiI07Fp9KMM28V/y?=
 =?us-ascii?Q?3egFjt1vlT+Kwyzg45qSt342xpj+4WjwJYfiEcpEYB4b1onvzWen/fLdAtZZ?=
 =?us-ascii?Q?uOy92F+TdVegtGnWygwrxVchAskJ1Zy9eMbNzTxnbJYc0I7k12a3rbcoT01o?=
 =?us-ascii?Q?N7YoUi0wRTv9I+8lSYdhaw/TepCE++iQ68lqxZzapgyppDgEQCsgecBswi9Q?=
 =?us-ascii?Q?B+ty86etFgb6JKttU7X3bu74G/RKtcQsFcgJOPEOQQsJU1XiiqMxG0ZahaGj?=
 =?us-ascii?Q?zJuhbVDqPIGamylweH738MKC55P5iyaUmSt4qlsgOP3VR9YnN6fmQc0IKsB8?=
 =?us-ascii?Q?xs8eOKO5NQLpEEKNQ+9F+yr4k8MoDHIoVCzRFO8025oIYercS3J3hOYDTr93?=
 =?us-ascii?Q?8SLNHv4wwu26iKWnA/WIUS51AMW+cwC254t+VDyQ2kcX5CJyHmVVqxgRE8pC?=
 =?us-ascii?Q?ItRBUigSlzMCETbD107Tkc2wJTTiUeSrZcdkOMu3ALCxi3wPh40BHzzAHJhV?=
 =?us-ascii?Q?6xpJ9nOHwSI2J2Nu5oItPtDczBBWQawRk9WWfG8QTPy8ab1yc5x7M9OKMS6I?=
 =?us-ascii?Q?JtggB2hwE5lQxI0nX9truFnohxbqyzfkW1kYuIsjDj2h6da4CUa3+aZYbHC1?=
 =?us-ascii?Q?c9J7+QxDO9OvP1bHsZu3aLf161flIEHAXdEAMgredk1/7LvlIlPA5UZaEpKU?=
 =?us-ascii?Q?74v3nh/22YxH/aNw8s7bCyIEJdGt2ThbE1ok10NPqPhxPdvQQ7+6ldhe6al+?=
 =?us-ascii?Q?hwrPLRT7XlUlppW3VUdbehsJIb+80Rh4hDZmvpnSPYXjY1I8gxULC9qlMHrY?=
 =?us-ascii?Q?fxbSrjUeXbwe3f8U0NSoAUyGBU8A+VWl910bQdr3oVZ6FpyeKiLxvmO/CbV1?=
 =?us-ascii?Q?bZ1BMcbL/itdI7c9+fEX0N3NBZgHFuNaVcmiL2p10jAJwtGn4u+LDlQVlJJn?=
 =?us-ascii?Q?ym3LVlVCa2VDG3el1fJKrTQFwlYVFEuKWE44F9BJC5EwrvcD1eiaHfHh7g+I?=
 =?us-ascii?Q?4fun1MYhM3p0enVkOgyxsvdLATQ4ajAe97YFzXCgIW8k5JOdWwrNMsSKaFV9?=
 =?us-ascii?Q?B9FfAnALJOHyww+e6N1erypsnBU0Ek2DkY29+M/Rva+yupilmBTJUityjPQb?=
 =?us-ascii?Q?tbHys1NyHtBrE5joLOdGA86IZlK3LB4W/eZiZkkMXEjCIvV6g75520p7XA+8?=
 =?us-ascii?Q?F65+M5A2zPqa4EuRucWxgr8GfwDRt4PxlnbkEmwduhH7dVruVhGmZjDg1gG1?=
 =?us-ascii?Q?5afidZsIIPpJDxBr3HPEeD3S/vN9O/Mr5MdjR+J7gAQftNLGGu/2UUtUkb8A?=
 =?us-ascii?Q?NkwHWbeDAYFA18I1ku+fM+24viSZQPiE3LVz09rLdjFYS+jMC34YCqQhkygj?=
 =?us-ascii?Q?SkjPzEESLMYNdLdtXwFN1+gc2m73O65cjLmMk88QRazAY21/WI3rcy6H1JsQ?=
 =?us-ascii?Q?JfV9qhlD49AiBjquZCwv4ieOSg7RDeVPYEHkuNOPjjbak1bZ+R/WVWlKKJbH?=
 =?us-ascii?Q?H6KSqFLLJvhXhbo6dUIqRTC5Wy1aK6hn2RQbMSqxFdlLcPM+GX/dtfLBtvQN?=
 =?us-ascii?Q?pfvO3fHD5c72MuQDy36tf9SSjkl6ZELbPzRuK5CFSSg5qxLSsbfnxwtvltfA?=
 =?us-ascii?Q?Mmt7r27MdP8T5TVJUkJ5FQ/UQzwG0TvvouI36UztUr0ruCiquN77gshc2i3i?=
 =?us-ascii?Q?mSECLFuygossMtQ/tFqkQvL79Vk22OsDIwBlDqRYdDWakdbyUF8WtLO7CTcg?=
X-MS-Exchange-AntiSpam-MessageData-1: H+INzwkKtPBeXsg20YU7W8ElGIYjrXxKR5s=
X-Exchange-RoutingPolicyChecked: Km/PnFk5RWDL178u1d//v/6AxHnjvQf97Vk/zDW2mrB1kkAxPVwmm7JgR78T3BKANd09nHW89YLbLbEd0vXsGk5oWqZVFwA/DzYv/PEOcPt05kcI44u/HqLyQR2F3KaIAp08bGaM0usC2tAzQ/H0yum+E0ZDmOTW03da8uWmkSPCngoH3YJ2MqjkaAoUVyuLgK60k3FYvI0Va1XMxmcLAi+pONAD9YnlSJ7lgWr+Ms+GOCcjOIlBhnLKr0DTfy0KgpthBCZgDgCveTKKYEtt/bZ4FKiBhLRJJM4cYm1RNFpmDbkFZ846lKmqYiNtrIVHpzVFoTNvEXXzIdl+rGc0Uw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10deea2-0b5e-4720-74a1-08df4a05e0e1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:35:21.9447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvt/A4ALdXmXyv7x1d7nAKVONRfFStwch8CHX7KFotI7SvKf0s45A/nlWTqJhG0ujQ+3/JS9U/snkpf8dXTzLpGAOCB9Qy1YuZqNL9ZW8Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB311547
X-Proofpoint-ORIG-GUID: R6-Jkpd8_tTAcTFmOWLd5bVi1TZH1sQ7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMiBTYWx0ZWRfX5aJJZzlA8xb0
 XrmNBl6ZHX5lq1hQtqd2If/xHZq2rjjZHTXW7F9WmbAWLmfgTaqqqPTZxLC3ENu7pjJDYc58Wrv
 6CMFiOOEADn15TQvgZTP1x9OIwK0HI7zeKS3Zx0fWH4adbbdboXQ
X-Authority-Analysis: v=2.4 cv=GZOCDgXL c=1 sm=1 tr=0 ts=6b054c4d cx=c_pps
 a=Db16Y4lORBbdbxOstMYGNA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=tsWWKMcrzgDGkEzjiCsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMiBTYWx0ZWRfX/8oUG6ElIE1L
 6e3J4ncZWQtHWf/9KYQ4iw1smKs8P82z0YAUqNIyHvAoQiP7yA/wrxllA8XUv2tq+RuBsWXKAbV
 woAnV+PX3HNynYc/bqPROyXkYNK+Yyi3HIGPZp51qh9oipClA8wSG3q1/+RnNSDrR7CYuyhYMBi
 3JppcU5Q7YwOQJLUFRP6McA1Hl//dSOMx5sVBhpGManJGip1sPjOgzPajZdENBeGEgMAFqXpjDC
 9PBzsSg+slMBm4JyQBEbqJMLO0LigW8WQzb3+xEuaI3mGeRdZnxhICwf2vKPe5R1Kb+C+11ch5k
 DXezOdC16+TlcKLMrJuG+uQlWJWjxloUmV9I90jWxylDUJ95eBsBVsfuK/yLoxIqI2NKpgRhZWm
 Mge/yaa8GlTw+3AlwKKE8YI/40CwZnGHoxFlZBTqaZK3gk/4lOfXErLaHhTeXHKAqZxPgAUVXLt
 cOaCj60Ej4s29KpYsow==
X-Proofpoint-GUID: R6-Jkpd8_tTAcTFmOWLd5bVi1TZH1sQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240032
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ionut Nechita <ionut.nechita@windriver.com>

Since commit d8c40b9d3a6c ("ice: check ICE_VSI_DOWN under rtnl_lock when
preparing for reset"), ice_dis_vsi() sets ICE_VSI_NEEDS_RESTART
unconditionally, but still skips ice_vsi_close() when ICE_VSI_DOWN is
already set. For a running netdev, ice_ena_vsi() then calls
ice_open_internal() -> ice_vsi_open(), which does a full open: it sets
up the rings and requests the IRQs again.

A running netdev with ICE_VSI_DOWN set is not always a closed VSI.
ice_down() only cleans the rings. It keeps the ring memory and the IRQs
so that ice_up() can restart the VSI quickly. If the restart fails, the
VSI stays in that state while the netdev is still running, for example:

  - ice_down_up(), when ice_down() or ice_up() fails (the latter also
    via ice_change_mtu());
  - ice_xdp_setup_prog(), when ice_down() fails.

If ice_dis_vsi()/ice_ena_vsi() are called on such a VSI without an
ice_vsi_rebuild() in between, which is the case for the DCB
reconfiguration in ice_pf_dcb_cfg() and
ice_dcb_process_lldp_set_mib_change(), ice_vsi_open() runs on rings and
IRQs that were never released:

  - ice_setup_tx_ring() hits WARN_ON(tx_ring->tx_buf) and overwrites
    tx_buf and desc, leaking the previous arrays;
  - ice_setup_rx_ring() overwrites desc, leaking the previous descriptor
    memory;
  - ice_vsi_req_irq_msix() requests the PF vectors again without
    IRQF_SHARED and fails with -EBUSY, so the open fails and the
    interface stays down until it is closed and opened again.

On the reset and mqprio paths, ice_vsi_rebuild() frees the ring
structures in between, so there is no WARN, but the ring memory still
held by them is not released until the device is unbound.

Call ice_vsi_close() unconditionally for a running netdev, under
rtnl_lock. ice_vsi_close() already handles a VSI that is down: it only
calls ice_down() if ICE_VSI_DOWN was not set, ice_vsi_free_irq() returns
early when the IRQs are not requested, and ice_vsi_free_{tx,rx}_rings()
only free rings that have a descriptor ring. This is also what
ice_stop() does for a VSI in this state. The race fixed by the commit
above does not come back: ICE_VSI_DOWN is still tested, by
ice_vsi_close(), under rtnl_lock.

The non-running and ICE_VSI_CTRL branches are left as they are. In both
cases ice_ena_vsi() either does not reopen the VSI or, for the control
VSI, the only paths that set ICE_VSI_DOWN also release its rings and
IRQs.

Fixes: d8c40b9d3a6c ("ice: check ICE_VSI_DOWN under rtnl_lock when preparing for reset")
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
v1 -> v2:
  - Shorten the code comment to one line (Przemek)
  - Drop the Assisted-by tag (Przemek, Jacob); an LLM (Claude) was
    used to help with the code analysis and the changelog
v1: https://lore.kernel.org/all/20261106171657.583713-1-ionut.nechita@windriver.com/

Found while chasing the same WARN_ON() in ice_setup_{rx,tx}_ring() with
the out-of-tree ice driver on an E830 port without a module installed,
where ice_vsi_cfg_lan() fails and ice_dis_vsi()/ice_ena_vsi() then
reopen a VSI that ice_down() left with its rings allocated. The
in-tree paths above were found by code reading.

Based on net (f66469d9905b, "Merge tag 'net-7.4-rc2'").
Tested: build only (W=1, no new warnings).

 drivers/net/ethernet/intel/ice/ice_lib.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7cd2dd066ef5e..92a086aa629d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2852,9 +2852,8 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 		if (netif_running(vsi->netdev)) {
 			if (!locked)
 				rtnl_lock();
-			already_down = test_bit(ICE_VSI_DOWN, vsi->state);
-			if (!already_down)
-				ice_vsi_close(vsi);
+			/* ice_ena_vsi() reopens the VSI, release it even if down */
+			ice_vsi_close(vsi);
 
 			if (!locked)
 				rtnl_unlock();
-- 
2.56.0

