Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5135606A339
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=h/HlBxaN;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=eQ/thbis
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B33BB607D4;
	Mon,  9 Nov 2026 17:18:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IfmtKDJdHhkm; Mon,  9 Nov 2026 17:18:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0A9A560720
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244736;
	b=EZrAbq8NEvz2jdeLm/WdfYJd+StDybCTgkAEEs0Y5/g3/wKcw+LSiGsfXqs3re3Ujsgk
	 pHSnXgL76Phl2yexQulhm0JXd3TI7SXIoGdurLleuejyusOzra3NTeuhum9Jti4IQFAU4
	 Jkym+Rty7tWCG+xf4ai5Kp9yOhlNnYLSQBjaWBL6jALxqVAnybcpMzNrJ3FGCy9pG4YcF
	 MgS3oq+KwLNk+8RFkYK9UqpPSFLP3E3PC3eUEHLzqWCXPNRliavZP/4166305of6GO0nK
	 MZFHTMod9hIq2C5RtWIfe3K6ISTlRsq9kRdOJHVrroQeUgLD3k3uwUQ5P3g2euCo49g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hytWD9a2VKx1375ydkRbOIQtDmQfvpxJlUnWTyatKr8=;
	b=Ua1w1x4Hf1igcp6h2HEyT3fXVO/ysstP1wUe2wamd4BP+taJB8te2PHgceWq7vgajlgq
	 lOZcSJK4vyQyj/nFREFa1CigjJrHH1VXgpLjLbRPTFusGrsJ98M0EgCdtfKDjaHd1+WdA
	 dSGOWgCywMm2h7whtVu4B5F1OLt1XLnr39+FDxhBSfoiqomlbhsla0uO3qjuDdMtAnikH
	 JOflpZnK64TDK7B7gM4acSyQxiwqY84EDLgb+F5VhHQwoVmJo9xm0EsN67YONoq8hJg/Y
	 79Qab0dK4bA/d6qkZg3HATq3vPcbXZchXHjGu1Xb6krcyBpltVl0WsxwH+rCI08TE1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b="eQ/thbis";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794244736;
	bh=hytWD9a2VKx1375ydkRbOIQtDmQfvpxJlUnWTyatKr8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h/HlBxaNqdp2N/HieSBSW7DrCechtRqXfcb/krYl7Wl6M71YWZei7d7aHXxa6TG+c
	 OPkOtOQtSUU8uTiOw9uMG7Hc6dp0QV0gu5KEfexfP0pPlncv8whF0BEn1J6GBTDbq0
	 tXd2KWBBgE13yyllHrxtP+q2YNOHwd9mA5QuWgbT76X/YCJfmb+I7cGM+OUapVpn6T
	 NB4kj8As3IVwexKrjA1YgMuqyTPedkdA4NPi4/ifacX7Zwex2SWnLNeavUHidq0c9l
	 qFkruiURO4Urqfu34A94KkZlMk0IcjMIv0CgYX0oFUlvgUMzDuh7cvhhxJl6ChJMCt
	 00LP9FfcU2AWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A9A560720;
	Mon,  9 Nov 2026 17:18:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AEAA137A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 20:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10EF56085F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 20:53:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RVFdsgAE1FPN for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 20:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9260960617
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=40.107.201.49
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.201.49;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=anthony.pighin@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=eQ/thbis
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013049.outbound.protection.outlook.com
 [40.107.201.49])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9260960617
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hytWD9a2VKx1375ydkRbOIQtDmQfvpxJlUnWTyatKr8=;
 b=eQ/thbislYbm5E7Qvhwceba7Nr+hpm+2IiM/Go40tCkYR79YNZDJy8PrKgXx+D1fIWMTlXjdEAERIV7e0/YY8ESRY+xEKTrZteD2EfZjAH1vCTgqjz9shJj2MTORdPVIFxC+iiNAmGHDcqOKMgDFfPYsdEJqv7BsaOyduvhdkGDwEttDfoZgxBzT5mp7X3ibjuFyZzY9az4KNZx6A6GAd7uelGd0mZAd19t6eCUMPtGwnUXVLv8ZXO7+5H5IPgfRLLPfypS8hCLcdPXrRVYyOMiHv97wcEpgFO8/EVdM8Szbgo/dviqA4qVk9Ba2nvVkI8RPxnCxrv1M3mhhGmU6yA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by IA3PR08MB10310.namprd08.prod.outlook.com (2603:10b6:208:507::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 20:53:27 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%5]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 20:53:27 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: stable@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Todd Fujinaka <todd.fujinaka@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] igb: Retry the D0 write of the i210 PLL workaround
Date: Thu,  5 Nov 2026 15:53:24 -0500
Message-ID: <20261105205325.2624892-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::12) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|IA3PR08MB10310:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f4700e-0f68-476e-8892-08df3b7ed717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|23010399003|1800799024|261026140227099003|11063799006|261026121527099003|56012099006|261022105027099003|261022075727099003|261009223027099003|261021121427099003|261102123227099003|261021123027099003|261028144727099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: S0J3RZkMcvcH6IDwbTpbTK8lcmD1ExsgP6lruqVS0wv6HvbOuo72wskjkswqAVG9WgK6XTNlno3ZYgWIVClbuwYZFkPvEsv799vE8ySVR7n+NjkLQ2YEh6ehnubwxMt0mrFNIh3LrwAbvkT0KRG6XcSeCx9dK/p2Ix/sfd+lPAdffHenJ6wqHA0NhuVvn5MCjoaFL+v3uandJrScIKB5dI4WVyySoL7+JEn233F27jlJy3rgTpRCRQJOXWmt2xZ1KDVqnHOZUX+DHESDC9HnMp8crmk6ZYuCpNcOZ+DRZ95mIKsq4Eq9kq49z6CICXn7KxTCYK31Zd7vsHGw/LkursctGdxt6FJsp+9hVe9oIbDNfo3d9u9qURrsnO+njg7n3XN3o33TpqPIJ9/oDCU3p0rmKn5cdElhz6oSFz1R+O02OpabMEsYSaUCtFJ87gzU8gM8bHgfvYqSiW2KXiAR5tA1EqmF4sGbO7NzCdnMWzxtmuWB32ROXYydQZUdLbJDogJLgYpSYMnmTgpOurrwAKXXevcvwqzBXIt3MUFXdaRhVPnNvRQRKH0g22y7XeMWsd/QPcr3qDGB5dqeO0sAzRopnO/pWz6UxBDUE4Mv4SLV4AjbYdWT4057rxNkCEZ4Lo9TdY5Nz4PVab+ki2DHoSJ7TAmEFmZzN6OOrWRQtic=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR08MB6951.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(261026140227099003)(11063799006)(261026121527099003)(56012099006)(261022105027099003)(261022075727099003)(261009223027099003)(261021121427099003)(261102123227099003)(261021123027099003)(261028144727099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0iWSCWAL1sbQHfhgWxqsB3vl+swQZcXhZ2obj+KLDU1YQ2A6clyLeBuzkmcD?=
 =?us-ascii?Q?iuLpJDwtkDN+NaDIUSchw5k7i9vjEB3/jmV469+Sxn+WvRH9DB960mW3Yr/v?=
 =?us-ascii?Q?g1v98IzfngC9GayXARBOqI7RNRSiul10Kutm7WXBzqtEUsdBEcGMk461VRuq?=
 =?us-ascii?Q?heWWZ+DTprd2DZkrW9CMIRYeDTcYUoQXTim9o8KSh5lKnMnmRV/8fDYE7Crw?=
 =?us-ascii?Q?UK6yi6v8HNgzxMk7bY+altdTHBJdULsViQcb+0VrMrg15IuvtAs+PkZLYqiF?=
 =?us-ascii?Q?/G5odAZjMp6l7fpHacRUHSjcEGLTokRrh1ubCOHSMktPTWkhX4ACRIHgEEY3?=
 =?us-ascii?Q?i4SMr27+aM2Nl7UmD5shNGALD8ZnzRD3x5m7d76xywdOG6YwowbYsAMaDgP6?=
 =?us-ascii?Q?b8s/CZKrocpBvktrt3Vy0zV842KeXzD/rizwfpT20XjfC9830ViBZsT2fCwo?=
 =?us-ascii?Q?+fYHy5kx4A7Nux5q2WJqr3D235v+xln1PxzJNnjj4JLhjkHZDrZo+QjXGd/n?=
 =?us-ascii?Q?r+tDrerihqLbhyQXAeanL6ryltgUz6oMUfjqZOQE85ch83i7b1w0s/1QWiYZ?=
 =?us-ascii?Q?fmh5UOpYhkCG1kvaClFs8GH2x5sJQAQJOcGZdlwPApDH0L3l+E5vncInFkfU?=
 =?us-ascii?Q?nlmrKexNqKE5PNCVeCjWXI3QQABKywqiKce/s8/u0KY6t0YH+lDx2wDO8GAq?=
 =?us-ascii?Q?Q6SdF9rcEXvEiKfFmYuU4j1V5gweeNiwTXTzYkZQbon8j5dFTSneOWsf87bw?=
 =?us-ascii?Q?PiOAnehG6vKE2u/PIWGopxlbWHFbXvTDPvKjTdBAMVdtK74uUe6Gwa2uf2lX?=
 =?us-ascii?Q?9vo+utcE1RnS1AnAo1xrNT3Av6GvD+K++8MyGA2jRdpN1Ebl+bK+Z3W3K3ji?=
 =?us-ascii?Q?XY/qHFFhqkangnJt0AN6/SOXs82GktiVJMp+w5uFGRr+Z7i8iz79d/GrzV4q?=
 =?us-ascii?Q?bpcYKfNZtNAry70CAgjkXyPl+UvuCxlPeS+enZRp1A21FSSw/cayyBdb55Ez?=
 =?us-ascii?Q?KcKfQkhtzMiBK6MRk8B399vKENQzJ303Q1eJNCV15z/R5U06/b1frLE80f8V?=
 =?us-ascii?Q?N0F61AizISX3bREIjD2Kd4tWRmjbonAP6uTuHrOsptyqXjHjyDXzQCHe+55v?=
 =?us-ascii?Q?OamPJI6bcBr+tvN1fILo5Bi94X+oljmRiKyhlVUqcMXw/sDQnmT3N/pCjl8W?=
 =?us-ascii?Q?YiE0R691Wdy8ubv7enyDrNo+RbBqV0uP7TfWoparCWf6zwjuFZ47TgKL+IW8?=
 =?us-ascii?Q?q3FcGzfvQtdmqLZqskVcDmPfX6yeho0uX0Mngn7WaEtaTnyw3Z7td0LxoUMr?=
 =?us-ascii?Q?mj0xgrQZy5Qt3MaVtkFSCWIMB3cNHV1JOL5D3Ni+Is5wlVeW11UlLhZ5ubfo?=
 =?us-ascii?Q?1Ij93UFovbHF4Zyl+pgMjUgSzC8vILUruMl4M0kv+gYAOh9h9RiAoregLZGK?=
 =?us-ascii?Q?bmavtkjeejTckWbgsJKVUv+ONa2POe5lIMZ3TC9h8XaG85AZOCc0zhE6bjv+?=
 =?us-ascii?Q?o++coe4/Cq3FdFNRCNgUKyElI/g/r5EX1koKica4R1kLJtzHsFfb1xnqiZt1?=
 =?us-ascii?Q?VI9RT4Y2Lo4J2WYUS5pRwEyNTxBrOvDvYgQyF/oud2r8dMLSd0mjh3M6Sfev?=
 =?us-ascii?Q?9gKdvgFgMJ4dswswx4mxDRIYfU4iepSeNNV/1k/YzS1AwNSv1Xi7FTNL7kFA?=
 =?us-ascii?Q?qXIE6B/IU7tKJgafEOnXDEp8ANnKeZsM2KLg0CZifJ6CZpBsxVEEYQoRRq1y?=
 =?us-ascii?Q?08QMUiCG/A=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f4700e-0f68-476e-8892-08df3b7ed717
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 20:53:27.2649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4D3RKhZMi+BBC1b2Gseu9/A95zwqkQE7dSt+hXKosK7iBLXQksATzIcvYECMMNT6x49Ln54TUxpiwN0wN/7YWGcZhX2u//fhP8//cJ+LO7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR08MB10310
X-Mailman-Approved-At: Mon, 09 Nov 2026 17:18:54 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the PHY PLL of a flashless i210 fails to lock, the existing errata
handler transitions the device through D3hot.

On some platforms, the root port frequently reports link training
while the device is in D3hot. The generic DesignWare link check
then treats the link as down, and the config access is rejected.
If the write that requests D0 state is rejected, igb ignores the
error and the device stays in D3hot. The next MMIO read fails, and
igb reports "PCIe link lost" and detaches the device. Every later
link setting fails.

  igb 0000:01:00.0 0000:01:00.0 (uninitialized): PCIe link lost
  igb 0000:01:00.0: Hardware Error
  ...
  igb 0000:01:00.0: Cannot change link characteristics when SoL/IDER is active.

Retry the D0 request until it is accepted, up to 1000 times. If the
device never reaches D0, stop the workaround.

Observed on LX2160A systems with a flashless i210. To confirm it, a
test build of igb forced the workaround on every probe. Without this
change, igb lost the device in 15 of 20 probes. Reading the root port
registers during the workaround showed link training reported while the
i210 was in D3hot.

With this change, all 500 probes on the same systems reached D0 with
no lost link. About 70% needed a retry, at most 21 D0 requests.
Tested with 6.12.92.

Fixes: 948264879b68 ("igb: Workaround for i210 Errata 25: Slow System Clock")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
---
 drivers/net/ethernet/intel/igb/e1000_i210.c | 33 +++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 784f9a7bcbed..fad7cdfea197 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -7,9 +7,11 @@
 
 #include <linux/bitfield.h>
 #include <linux/if_ether.h>
+#include <linux/pci.h>
 #include <linux/types.h>
 #include "e1000_hw.h"
 #include "e1000_i210.h"
+#include "igb.h"
 
 static s32 igb_update_flash_i210(struct e1000_hw *hw);
 
@@ -812,6 +814,33 @@ s32 igb_init_nvm_params_i210(struct e1000_hw *hw)
 	return 0;
 }
 
+static bool igb_set_d0_i210(struct e1000_hw *hw, u16 pci_word)
+{
+	struct igb_adapter *adapter = hw->back;
+	u16 pmcsr;
+	int i;
+
+	pci_word &= ~PCI_PM_CTRL_STATE_MASK;
+	pci_word |= PCI_D0;
+
+	/* Some host controller drivers refuse config accesses while the root
+	 * port reports link training. The root port can report link training
+	 * while the device is in D3hot, so the write that requests D0 can be
+	 * refused.
+	 */
+	for (i = 0; i < 1000; i++) {
+		igb_write_pci_cfg(hw, E1000_PCI_PMCSR, &pci_word);
+		igb_read_pci_cfg(hw, E1000_PCI_PMCSR, &pmcsr);
+		if (!PCI_POSSIBLE_ERROR(pmcsr) &&
+		    (pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)
+			return true;
+		usleep_range(50, 100);
+	}
+
+	dev_err(&adapter->pdev->dev, "Device stuck in D3hot\n");
+	return false;
+}
+
 /**
  * igb_pll_workaround_i210
  * @hw: pointer to the HW structure
@@ -866,8 +895,8 @@ s32 igb_pll_workaround_i210(struct e1000_hw *hw)
 		pci_word |= E1000_PCI_PMCSR_D3;
 		igb_write_pci_cfg(hw, E1000_PCI_PMCSR, &pci_word);
 		usleep_range(1000, 2000);
-		pci_word &= ~E1000_PCI_PMCSR_D3;
-		igb_write_pci_cfg(hw, E1000_PCI_PMCSR, &pci_word);
+		if (!igb_set_d0_i210(hw, pci_word))
+			break;
 		reg_val = (E1000_INVM_AUTOLOAD << 4) | (nvm_word << 16);
 		wr32(E1000_EEARBC_I210, reg_val);
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

