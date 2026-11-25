Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8D606A32D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=XDESjG3l;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=YKY+zhxj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79DC3809F5;
	Wed, 25 Nov 2026 15:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 88R0xPK-Rgy4; Wed, 25 Nov 2026 15:48:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1086E809A4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795621705;
	b=Nx41b22JcYl1T9R7dNgE7zsZayk0RAfjOBjckq1zfaDjvbgQ+hppnsQfsmJDbBkCdTTm
	 trGFL1a+/D7JCplJUpfQg7TCEHOyKySCiSFhspXnRQ80WuwBsMBR+9g6tn+oQyTCt4gjg
	 pEWCxKZBtbc3uRmmFBaHufRElSERoU3+SmXXNSJEcglWHS/n30G9ves4edA7Xtvv/xlzI
	 hzu9XaFrIbAUtwoMZGchFMnbP0e01YG1EWA3JTim8NSekZrFy1fvQWkfQwrcb27DghVAd
	 LuzwOxmse9jOS6m97pqtMLFltT40+Gdgr6V8HA0tvOL0XbMT66U/AzzZ1iGeIsysh9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795621705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x79Z+4o1mMGGgXkrJ+oQH14/uWII/xt/YDVLV87rBPE=;
	b=CZOq22/21ZJki4NjLc1DFFbzuZGY6VVhgq4jHgUMiHB/JyGuQN56AU+u/3dDEZsK0EnI
	 kdIdWj+P/g8K9qEraTcKPSeSWdt7KYvgaMb5KvZXPVwDTgn0/F4D27NYsODBKQJ1YfvVw
	 LWUCfhuo+02qQUjbhMGhQFhNKW5+Qq9Puz0Oguhn1yyJah3aGfHpW6nCwPbrrmbglZKzc
	 CURi1KH6p1V42NOg29olTbxB1T3Rojk+gfWbUF1RB+jF530MEGv/dnPJPNw57sszwruYp
	 DliGeisJOLcq1WVGGvL4AqBr45uYToyMMKWA891TyBNmsA78asIptB5L6fmHI+7gZxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795621705;
	bh=x79Z+4o1mMGGgXkrJ+oQH14/uWII/xt/YDVLV87rBPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XDESjG3lV4WIy/EcBDyA8Fwhimzq3Mgqn4w0cST4T58+fAfo8rkrOhknlIi13hp8W
	 Inqj1+Hx2HJ+A3zAVSNtyoKM98YVpbfvw+DdESA31IERBJbktC5tch6GVJS/VeyqST
	 f0SNIi8TpD/wZWlVOKzfHbzKRWhEjQaIENb4abKQETDWnoz5/yC12V9qIrL4ebRxOb
	 labrtLZsgU58r33KFbjwDpdXTAFOReX3wdtSU47ZlnaII9iS9eoixhXBdInZ+yrcSq
	 zITTFVCbNXZQqaBaR2ibzZHT3yMU20JkftdpU0CQaRPNfcnp6X4QWwvmG7PmJ/qoQC
	 9p/V1PlBQg/BA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1086E809A4;
	Wed, 25 Nov 2026 15:48:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A71132D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 15:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B6D3607BE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 15:48:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NfoqYMT3YDkx for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 15:48:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 960CB605ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.178.238
X-Greylist: delayed 1097 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 25 Nov 2026 15:48:22 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=windriver.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=windriver.com header.i=@windriver.com
 header.a=rsa-sha256 header.s=PPS06212021 header.b=YKY+zhxj
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.178.238;
 helo=mx0b-0064b401.pphosted.com;
 envelope-from=prvs=57898b1450=ionut.nechita@windriver.com; receiver=<UNKNOWN> 
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 960CB605ED
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 15:48:21 +0000 (UTC)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APEOlib341146; Wed, 25 Nov 2026 15:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 PPS06212021; bh=x79Z+4o1mMGGgXkrJ+oQH14/uWII/xt/YDVLV87rBPE=; b=
 YKY+zhxjLEINkwUjodRC2r4odo1kYShmb3O+JkKqpC3AvYu8x+VrwGich40tKEn6
 DaYGlsC545EP2vOyYNfQLywwUllDZzPaT++SerMlN/NeE1NjIZYAnjvh0QaqU+f5
 1u9CrWGr9+tcbRI7uqEw2QPU318koqNkl1fVL+G3GLTYwQapkKyf0MhuXzKYepAs
 GZT9+KIOOVGaxMdkxwbqOWIeBAQpoQQ75jI67KvfZQTKI+S3RtoBRu9/J8XJ/ac5
 RGfA0QFy71kw3jSduaak0DC+BgMVKLbpJrP+qMwDrCzUz4ixaB73mbau2PjKhnuM
 jPiBWw8RQZvu+kQkf6JI9Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020123.outbound.protection.outlook.com
 [40.93.198.123])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j51493qtv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 25 Nov 2026 15:29:30 +0000 (GMT)
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 15:29:16 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 15:29:16 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 larysa.zaremba@intel.com, maciej.fijalkowski@intel.com,
 jacob.e.keller@intel.com, wojciech.drewek@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, poros@redhat.com
Subject: Re: [PATCH iwl-net v2] ice: release IRQs and rings in ice_dis_vsi()
 when the VSI is already down
Date: Wed, 25 Nov 2026 17:28:50 +0200
Message-ID: <20261125152850.16261-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <dfcfedd2-7232-4949-97c3-bc51d28c6131@intel.com>
References: <dfcfedd2-7232-4949-97c3-bc51d28c6131@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI5PEPF0000090E.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::92f) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH7PR11MB6498:EE_
X-MS-Office365-Filtering-Correlation-Id: d4637d3f-a1e4-49a4-dc03-08df4b08dd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|52116014|366016|1800799024|11063799006|38350700014|261028144727099003|10067099003|261026140227099003|261102123227099003|56012099006|261021121427099003|261022075727099003|261026121527099003|261022105027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EMPKupxfbwRtnS780Tpyom7KkOjuriRci/f4vKOuBwJTJVe0ggsGIxTislLHvQ3lajGo9ou/1sjfLTp238Hw0CqLcG+Qh/ZEc4jFBL/pBMy6d9hJmK6ED1ET0uAY41NKscV0gx2zASXeD58WHRWuNlr0O0tJaGn5v6ENd/8w4DIMKjDYbEYKSjWFxQm3v0btW2i4JOb7nivuk/zFsJ0dvsDV9AFf6EQ+IoWjA67/IPuTJu4VasID/2rIsaZLQY/Ug0EDxqZSePbuwPxGI/JRvgGL+V6SvkF3D7oFfmyIHcHXCZnEOFWDbk5br0YOvkHe9r5I5vAye/Ua9fyM0PHDrLaax6LOxLra2N0C6vIx3SOZb4zdD5/WJjBFKcNbuW4EfEULqZmv1cQVF0BC0RhoIyxlpI4lOsmpo5DLz6lfiFqjpM3+36fF0J3nrofPHy95yIxes2XXgBdcFuQBkkw+yttWaB0X7HUIrRwJDbij6Wv34fca0lMZIn4bGjmNeEOb1se2b2GR8DRx6ngDkLUwQq+2B1Q4kWApgq9pwVnvtmw1KqSc+rLG85t+RS5/KCjRn9DKXrrQR1q3dI5nMJ+0/vlYbTAZGXmJjnhld0yE3BImOCl+Z4goKwEOm2k+ENKsP+SOn5MEcg9psovTy+oQKO6jNpSxgfw9YTInDe2ThuCoxP/jqi29hlTl47ZlR2uBxI6h3+7pz+ETEpKJK+hY2alRMwB5eLP7htGVhsUrzR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB7546.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(366016)(1800799024)(11063799006)(38350700014)(261028144727099003)(10067099003)(261026140227099003)(261102123227099003)(56012099006)(261021121427099003)(261022075727099003)(261026121527099003)(261022105027099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xIvN0Xd28dxjyYWNyKwaWwXbQ0J3mco0xTxaU55Rm3ez7CJQSovXgVM7j8vj?=
 =?us-ascii?Q?T9k/abhK8sP0+nmt0IrD9mYYqzvHW1RZ8Drh9sCoFs/VZqAie21jOoE++DXz?=
 =?us-ascii?Q?IxTL3MKsrmx+LLY92u6GCP/yZlYfmNGtSbpPJ8+dRIkZ3S1T/Bz5KtM0wHcv?=
 =?us-ascii?Q?rat4CEP9InOeQIdRSxnwgPlkCdh0by9gjxpqdLNYrge+vySJkCEiFxGa2hHn?=
 =?us-ascii?Q?qR7mgTqME1rHmjdqbxDkltWN+iDFojiRGS8nuA0D0WsPO76y6Y7kASspWYGU?=
 =?us-ascii?Q?xyfgOcG/v3CiYWhPuS3/qmnUHdXcuv6rosHnWUtrhvzHClsJx7wJiZYar2FT?=
 =?us-ascii?Q?inXP6+EcIe1jqM4VnggKAn88B1JtRwIbvfQVjjXxfu39o90eOCZ5hJBazY6Z?=
 =?us-ascii?Q?Uw1uJmLlba6VGjTd0/YH1Z5ZUVuAP/mAjqlaHv5i3WahHzaBO2DBTUhu0MWR?=
 =?us-ascii?Q?mFX7/OfoCfD96PPQr0sPfpfqu1/Ke9QoayRpe09C6sXHngGQDJFUROt4EoVA?=
 =?us-ascii?Q?K5D5e9CWtXakOrcklqwKBTcaqgZkN8mgAz4UXDl0KCZgXmHrilCkSIFlq9No?=
 =?us-ascii?Q?b2JULNel/P+rj+w1cZoc9qKuj/J4tOQ5dW3/7NGeIA+RSDTt/H2UKzP516eO?=
 =?us-ascii?Q?PiACrI+nC4toPDAqG5Evyx3Q/Adik8kEm0hZHR3bGCZWhDZGvwyaFqqI+/z9?=
 =?us-ascii?Q?cWgq7+QT/SdzbqytAJHHTJYDWv6ZAFL9aaeTD6authuYKv6D9UkVoSR46Fw+?=
 =?us-ascii?Q?gqwX3CYOCu/de0RXYaU6zJEDZXvB8UtYM0sQizFF4Qt3uA/khEVNRed5oRaY?=
 =?us-ascii?Q?chNPUDf8HrWSaUpz7gZPTZYRbWFY4AEYxB970scWxQeUxd1mVJbm6Q4W9JAn?=
 =?us-ascii?Q?QutkUko4BjRu7DYzkgC1LNipyZaJFx9IhLrPyR+RffHaC9hTnN14JzPoGvPK?=
 =?us-ascii?Q?Lxb3uYu2aBGnXECVtupu9BNE5+zJrgoHNV5HTWLcN2z19CeawHTKPCDxEGUG?=
 =?us-ascii?Q?aQgxi/D9twzKow9e2sr0IGCLI1sMx9b52mRojBO0XINCAeJ0i5+9Y4apnZeD?=
 =?us-ascii?Q?S8ory0oXWes9RaMnZbfmftp+t3ECuza1ICoKMojcOLRR2un9MuMcBElrIzC1?=
 =?us-ascii?Q?olmnpa9PBQFboDcCldlUEFX6EiCSvCShBQ+p3ksRKBIBHMlpFUfkUFq6cL2Z?=
 =?us-ascii?Q?n5pW88wJ4eNK95zcgZmNCndfGBqH0DI3XXV/F2xvxd0UFBpclT1Jj4I81de9?=
 =?us-ascii?Q?ZMexfzYYLZo1I9jl/hrlvMqRTPtAjMRXuukjoy18XJXUaOAwoPf/Jztd58MJ?=
 =?us-ascii?Q?KFRZjHzU6QDa1n6Y6XVaxH48XrWbJ8dc3rln2OpCb2i+t7MZCEG1tPuhpqxR?=
 =?us-ascii?Q?MH/2rBImTajE5Fyrn3K9xRoMJZ056VW3LzGKToc441BqS7DAy+NBhB6uf+ud?=
 =?us-ascii?Q?UMIx6q3nkkaDtT/uu+2ymmEJRusLRgwTp5IoXQquyQ1CNsOwS+blVpBsYcm/?=
 =?us-ascii?Q?PtKMVdbEXty3CyvZGe7vB78hFKJUanCGXr40HfbkEFBpzqtk8Heu03ogU//4?=
 =?us-ascii?Q?sVCgtAwN/Fc8vor0g8AnKQdLSGxitegQZVOJdqOY9MhrFoFYlVaaa/M6Sbbd?=
 =?us-ascii?Q?1+xeujGZJ/kr6byqWX5QmbSJjBlKpCeJUdrpWyGjF6Iq2ayk2/bRNybgorS+?=
 =?us-ascii?Q?DQf9+kMgcANrynpacLF99cJMIMat/BdKzbocOWAFVuKoW9g71IXK6evDPhVq?=
 =?us-ascii?Q?xDV6BezzClRFx2z3WhNjrun5os1/U2w=3D?=
X-Exchange-RoutingPolicyChecked: EZ6RosdGXE1BGFCUPcOCRulpjt9b255BZLyoMTMXk2J/YVGOWOnM2Fclqa8hUvBZTGFRHZ9hh0vyBIzj4WnOlJTrHl+ytOU5lTCe+nDPioFSzMv1xheKjCW+0kXTjhFJhx9Ouemt17yKdPTgqNBWKLn1S5APm1c6sTbtezS7X0+RiQJMlys9l8cI99LsY9oUvXtserWOd2AnPTLEkg5mp83OY2qsXY+bm/+Rjtr3atoS98ZlBDfB0FGu9mZQrRXBza/Jte55RmRXaMW2Khs/1FPphq7Nvy9mwLIP7E8QdwmSkclb7GXTNTA8Os0ycPAWjHu58plx41ncHpV2Ed27+Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4637d3f-a1e4-49a4-dc03-08df4b08dd7c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 15:29:15.9994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0DQVry5d3eOjqjKsfngZh8fszOe4x9ShEqR6rHoODYFcOv3TPrVehD5LDxTTcl0LN3pA0m0x3irkwXg29FtJJhxt4otl+v8RnMI1Ffro5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6498
X-Authority-Analysis: v=2.4 cv=ScJi5fRu c=1 sm=1 tr=0 ts=6b06feda cx=c_pps
 a=mLoR1drGahLtw5ViIJY7rA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=GMzMhr56eme4z07Y9MEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX4JkWQRrPwiVA
 NhrNtVIrRRhyXArOprTDxDvJ8p+c3ourxeEQw2sahE7E6FEgGu1VU5rt1YHfczgctFiMyP6toK0
 SLphyW5BgPGEXQDPMYP9ImaetKnXIH+BDHkmiJsXjrq60gpFMrHTIqcyd5xTXbiP8uU2qWkcISY
 Qa/XMhDrII0gFLAg/SD+/9q0Ga2bG54qiyAR/DaWv51XHYs+ZPouwfnXCS4ueksB9BPZVj7vymj
 2hHLO0UKTngITPUbw5SV2fv/+VvnoE+6Z64syosgeHWOSoRayEy2esiBnd1AOe6D3JMGQ1HiPbe
 0r1YgY6OA6TRnmE4LSnqVpkSoLBFkFZdi8jehRi91nb/5Lb5vC7pWNz1NxH8p90psmrwxFTFINN
 c6ak5FKcQhNyoDBCfxjK5rSE/HH05tPOoKal/Skdhvmt3b+oBm2K3g4+14SNrLQo7SZZ4QH10qv
 Qg0MzgQAQarrwbAIM0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX3hbBbplfBxkY
 nKy8FM4y/Duy0dh0Ct4MARcZWzG+OaXJDm1+AWwlO+2kJ1B+I2Cc11AOHQP0v023FeDTPfES5zp
 Upgka4Xf40/VHtFSfFZDXPGUtD+AJYq235u0R7dDifkFfNh4Cnxt
X-Proofpoint-GUID: atwBVGEkIbIzMNvwaTHoraW20iVnpjgX
X-Proofpoint-ORIG-GUID: atwBVGEkIbIzMNvwaTHoraW20iVnpjgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250061
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 11:51 AM, Przemek Kitszel wrote:
> I've run your patch through our local sashiko instance, and it reports
> that your patch adds new problems on edge cases. The same issues were
> reported both on your patch just on top of netdev/main and
> tony/dev-queue+some more fixes (meaning those problems are not "already
> resolved elsewhere"). For the first issue (DCB) both my and Petr Oros
> patches were applied (not yet on netdev main (aka -net)).

Hi Przemek,

Thank you for running it and for sharing the report.

> [Severity: High]
> Can this free DMA memory that enabled hardware queues still own?

Yes, this is right, and it makes the patch worse than the problem it
fixes. If ice_up_complete() fails in ice_vsi_start_all_rx_rings(), it
returns with ICE_VSI_DOWN still set, while the Tx queues are enabled by
FW and the Rx queues may be enabled with buffers posted. Today that
memory is leaked but stays allocated and mapped; with my patch
ice_vsi_close() frees it without stopping the queues first, so the
device could DMA into freed memory. Pointing to ice_stop() as the
precedent was wrong, since it has the same hazard.

> [Severity: Medium]
> Can this now reach a NULL vsi->q_vectors?

Also right. ice_vsi_free_arrays() sets q_vectors to NULL but leaves
num_q_vectors as is, and ice_vsi_clear_napi_queues() does not check
q_vectors, so the already_down check was hiding this after a failed
ice_vsi_rebuild(). My statement that ice_vsi_close() already handles
a VSI that is down only holds for the IRQs and the rings.

> [Severity: Medium]
> Does removing the already_down check widen races with code that brings
> the VSI down without rtnl_lock?

Agreed that it widens the window, so the reasoning in the commit
message that ICE_VSI_DOWN is still tested under rtnl_lock is not
enough to show it is safe.

So please drop v2. The underlying problem is that a failed ice_up() /
ice_down_up() leaves the VSI half up, and ice_dis_vsi() cannot tell
whether the queues are still enabled, so it is not the right place to
clean this up. If I come back to it, it will be a fix on those error
paths, tested on hardware rather than build only.

Could you point me to your and Petr's patches for the DCB path? I would
like to check whether they also cover the case I originally hit with
the out-of-tree driver (ice_vsi_cfg_lan() failing on an E830 port
without a module installed).

Separately, the NULL q_vectors with a non-zero num_q_vectors after a
failed rebuild looks reachable through ice_stop() already, independent
of this patch. If you think it is worth it, I can send a small fix for
that once I have reproduced it.

Thanks,
Ionut
