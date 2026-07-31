Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037EDC5516D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 13:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2A638130C;
	Fri, 31 Jul 2026 13:39:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QnhtUf3r2K88; Fri, 31 Jul 2026 13:39:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4825E812F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785505140;
	bh=crVk4ieNmNLbwQHcqQqOuTTBex9AIXEqAX7+o7ef2EQ=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rPNuRxsaOJ9BuRUHLiXRdlwst+vpfGjtbXrw2jkTi1zOe1aa+q2ci4YGyUxHwekJi
	 uEVSaDjCy1Fdvei4/oRWWKyRtdR0oIjpuWYDrj0IsS7V0vlAgsRzU8gpXl6C9iZLJU
	 g075NKYfvwUmscelDmpK58k7Nk+B3/PeIgRfMoycJf67xvOzsP4VLa4IcOVfqjYo7Y
	 v8NntKsI/uvWmZmhDMbVqOWjG5ldtnI1uQQjmCpWKC19N6jJoo76EOPeXGvjtAZ1bV
	 XaGTL0C3a9MhRyhbruZVfKZBj+ldUTs26s3LEwKvSw+15ZWzlH3xkEsXDS26qLAskY
	 T4zVvOmQnhsbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4825E812F4;
	Fri, 31 Jul 2026 13:39:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 82F6336E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 13:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7538760AC9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 13:38:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DFm28SbXWbEy for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 13:38:58 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6144660AB3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6144660AB3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6144660AB3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 13:38:58 +0000 (UTC)
X-CSE-ConnectionGUID: 5j2VOp17QW2ieX90ZjQrpA==
X-CSE-MsgGUID: iOCWq7taR5WTv6NsSSFsBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="90018392"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="90018392"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 06:38:57 -0700
X-CSE-ConnectionGUID: Rj60isYOTx6io/Y8HppTCg==
X-CSE-MsgGUID: fcnp8hEGQGajsq/lVEk4Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="257912760"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 06:38:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 06:38:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 06:38:57 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 06:38:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfoasj4A1amQxpEU0qCRAZJRi+3xqbOzSmBgq8Lp3wirkDq7ntjnPdiqD0RvyOyHt75grC2YQxGRXW02yv0I+L7l/nFjmjXPqN3CEpiLo/d1dlRL2oUHgbPbE0r0g72LPJp+c8MZV/dKmJWPF9LVxy99/Qx7fcbZLtSPFgABpcW2unQ8GCco8FR410HsoWg/7qlImSuJMQk3Dug9fyhdfJvOC1Ovbz7ifWMaRr4H6YPUunLZFowTOhPVCcBMD9Lni6SdtNVt4l/tRNyPIRQlV+r+C7RRuyZ6GJJw8Y2Z+UnWHv4dJI1Lr5KGAhkxmrz2aEFN8bzwQqfRAdaXCi9aCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crVk4ieNmNLbwQHcqQqOuTTBex9AIXEqAX7+o7ef2EQ=;
 b=SzHNh1U+8DRTE/6wZztG9vmV1knrF/kCDeuMCB0OSIvKZFTEXYWu/6kmrPialJ82ntMOUZMswq+0GNHc2xRHxLEGc1QJe4VfH/3UofWYDaklxMERCh+JVQzQy7PFRT3gWFKuCiv1uIPW4OAh9Ny9kW5scJ9vUz5fOekketP/LiF6Qk2aSJHBL/K0X35ltYAT3XoeRWk+u3mkCKMH80FKvdfFFJ5Cl5j7v3YSw610yzA5xRf0RvSqkXznhmi74WFJ3+sqy4WWG2E9hPq2jB8RmAUMqR7omcwFjagRV3b0/c1JCB1BCOQQAdq6c09O6+YdlIo92jfy/PskZ29PRisPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LVUPR11MB9859.namprd11.prod.outlook.com (2603:10b6:408:38b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 13:38:55 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 13:38:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Matt Vollrath <tactii@gmail.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/3] iavf: use cached
 page_pool ref in skb helpers
Thread-Index: AQHdIOsdiWiauqVuJUiMBsqD+awPBLaHofDg
Date: Fri, 31 Jul 2026 13:38:54 +0000
Message-ID: <IA3PR11MB8986656385D04962DBF4BFA8E5C82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260731124109.99065-1-tactii@gmail.com>
 <20260731124109.99065-4-tactii@gmail.com>
In-Reply-To: <20260731124109.99065-4-tactii@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LVUPR11MB9859:EE_
x-ms-office365-filtering-correlation-id: 2cb925e1-431a-453b-f2e2-08deef0910e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: sXjtkZfeX8lqV/gv/K/40ct5rGOrN4aYk6BPsX+cxYnlK+WCoyXhVn+haVxGwVF8k3QdyEQq/JyyOi9jIxOS5hBw15sbOm3WM8yX63SMxDcmFAdEVd78f5HNJ5xfE5T3s2JjUxOb/Lt8NiIDjVsDSsljPMOANKhDxW8dGA1etcJOlhZS4QF0tit4VEqb5wR0ThlvzFAm0zMoJhh1s1uhHhbpzh9d2ZDMYGBWkQ0kxGTVlRaZJ9ifIMLP8FBKWpFBW83ntFZ8BatthMUkBjoG5vczROjRYs9hpRb914UfWkKaWuTKrGraHNEbqSI7uCY6LwD4aOcgZO4es1HUXNfw2M8NL2g9PTHAr8ExWQMtaET+0mJJ6p6BUu54BWDVA5hp+ApCVKtUVylnoVsK0SZqeLOtpszMtUL/+gfas8rJV6fusqR62rOKVTsUHnCwjXOqKkHSv2k4WvBOkXObgJ+PDxSIJ0cVHvRgwaVULOZj5dNGpOLh+2z+gsfHP1mtxrSBa0OK6+ro9F5DTfOohLvnsXvHLWc517LzHvzGtDgkVyRrvj7US+vKYqjcAty9ff91BgeJzhFKe8W92UGIQcqoUwzyo8gs2UkgvhPQuSMEVDBaIku1lauT3xzbhhLAiB4XbfNn60u3uSd3WrmC+szYVgfT4JGhdw2WEhmZC3tOfjfqiLZiUgkR6m072wEiLrXrC2NtisjYfpWc81rLqC+SCZTBSH+icgv/dJ/O2gy3Wh0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ynuvBNHhLV+mZel1keO3TPMmtCDaH5uLnGvp9KUJcDbD1LV7gkcuT06z1jQd?=
 =?us-ascii?Q?TDJztxfKCez8VJJpfmhWa9atPFXIooj0hDPfOXQxrwhv/ZHif8krxYUTfzK0?=
 =?us-ascii?Q?hrwpeLsqv9+hqVxhdPVhMjHseBAXdLevGUxekJlFZo3LwcYoNW/5MAxcs3iU?=
 =?us-ascii?Q?O/ug/RqlbdMSRWVAvD23yn3l/UXsiJy9qvaAAxKLiin+IBaZyzDXnF9iO1Im?=
 =?us-ascii?Q?ymxzJIyvtB0xpTlIQSOqVOZmt1im4whE5gNY5Wa9cKaZ0RShBFyzv4JG+0P5?=
 =?us-ascii?Q?LqiUzLjJ4h2QisOY+cZpHKOeymBrz3IpC153MBIIqD488QDhFgb3UiKC5Uhi?=
 =?us-ascii?Q?3FdEQV64FqxFwO6/L7anVfKofA8N33Q8LYU20eG06lYgCtqQhMi9/UNQZ4sd?=
 =?us-ascii?Q?IuhMYRCSyPTQWMqZ6NOOEGHGFD7OlEkropgSWDJhjcKCsBVCK6k1OFkAITYy?=
 =?us-ascii?Q?aEQiKeOY2cRcP4BickSvQtVPdxNeX1Qae0U/pkXDZbl7OOBiQQ61wysHX6l9?=
 =?us-ascii?Q?JUxKJjmao9ANMZBOxMAkre11WxvzbipihVRSmSAnqJqs4c9pXT4HC5JbsYPD?=
 =?us-ascii?Q?qo1L2nEB9rjvvDT4KjFsDYOSevJ4FD+fJQdGmdpdKY3sQ4HwHhMprNFtrX92?=
 =?us-ascii?Q?LmPEQynDAh6s6qlykhWrpAePHjpEo3+072tjifpOQWKNUjttGXeYYNbciwNV?=
 =?us-ascii?Q?5FVNqmtZLKdeb0ScBpUyAf0yxhsdMRiK6rF+Op4eHPE6nYD2ILTpxJuQBaMR?=
 =?us-ascii?Q?VI8vjISqn4SReiL0KQXkLPtSglbP5BKo/wH18z52gkEo8lvx12cZMKKGalRc?=
 =?us-ascii?Q?Z2rcPoyUR5+17x0EYv32Nh0uVxE7MGgK4f955dERAMF7V+5928r+fjaAjTSs?=
 =?us-ascii?Q?nLw+z/jQEKVBpCDpb6xgnspIXmAzsm/O+1X7fi5FbP6NurrT/NUHBWT7aV0G?=
 =?us-ascii?Q?4ywXx40afKZRDtLozGISyFPqO9KPBSf+1TJOAAKi3S+Y7vqW9vlgXGMukq43?=
 =?us-ascii?Q?dSdiIaksQeFf5NLw28XHHWXL2aOknzsRFt8oxheFR299TvG16auPTHB11DH2?=
 =?us-ascii?Q?2jXF7iKHdb03k9y/DWizS9AJF1e7rj71I9+RRcXZWeUn0j2kaw/fnIoAXnFw?=
 =?us-ascii?Q?xQJoKSFFvFD4nRjTUqN6J5TzqH1ymplGy8Jr1BsSSfrHhtCcNI6cGz5iKdUj?=
 =?us-ascii?Q?3abTsQowop15fOQ8Qk0w32tnMIPCtpW+rGkJBy0jwrVWE4FLMCEFJqgIusGh?=
 =?us-ascii?Q?Op3dev0nVWg8Xgqxy5nnusdaJvLdcEQzONTNCtMPy3VerB6+yuxCgbnlKmCA?=
 =?us-ascii?Q?XS8Jreo43H8GVSmIOaF0hGMuxpvl53U/WVUvtJFtrYsYR2G6ejBPU4hKeFd/?=
 =?us-ascii?Q?9Xtmn8ROjXWlchmL+ZQP4hNKBTPGjLhOC95pG/lGPPcMjDSDF6nn6bZQ+bqA?=
 =?us-ascii?Q?lzZYSjPZMP0U3Czxxpw6yysYajoPQhg5vpkRQ+nfAR8bJpnrYwqErxGm/7/0?=
 =?us-ascii?Q?a20I5s5udi/ZcJlyF1B0P1h0/ZAKDPuoJFMlykJIsN0Sv9KX1k8f7xEKoYrp?=
 =?us-ascii?Q?jxlmt2gNV/jwDqV9NLMFou0guGHcpbPB+rYYWQXrhAG5nNOZIba103o9TsGT?=
 =?us-ascii?Q?81/ndFfqX0Dn6WBop7iFp1EnZdJmo3SxDIkmwJovfc4QNA84zSqEDTQEEICx?=
 =?us-ascii?Q?a8QuJlu8T5T4CdFVgVsdhCh8nWyeUVkJQJC7iD8fFV7KWJjycQ9t514MNGCu?=
 =?us-ascii?Q?fT2pFemOBw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qnSlbIVqizKsnrO2lGDRkeoVAqFVsu2bTyA03mBUcETzWX4TgehBg57y5BRU2d4QxD9BY1Ic9GKuBQyXfCu673H8LxIh1icyG6B++f5qfQxgO5U4Z3gU6JRUGT+YR9VBV4L+A3XfA/AVz0DTU/xG8iJUY9XLkkDq9K/QKVOTWwXVrCJkHUZ57rB3ep13f1nDCkErP0ENLZNbCQM0PhhCGMxbx3Fw3GeUOufbziX4urZm390RcwR5yOUHLox10IoXWWw14gJG7G0N9d+1Bzk6Uo4Yipn2rTK5wQZVHEWBN7UYQJ4lKwfGnzAuxoCV/l4wV+/w63j1BPCp225cRs1OXA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb925e1-431a-453b-f2e2-08deef0910e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 13:38:55.0146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K02MSdT9M7AqDXpnxJk9JTAuxPxkc8OxzI/4oKVM2DPlq666zW0BL6+G9LevQA8rNDZ6WYzgRw1gT1bmQPI5A7xkWAPyCdbMWOCEZR0APKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9859
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785505138; x=1817041138;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1Wio2hHBTQxo80GId3XMOY5pFHu8HY9+tBBRHRQavpo=;
 b=dc3gUPbIlFBRqwXBDnZSKO53j27kAK280bXCeoQNyj2leXmquFlp2/MB
 RiKJNiDyyk3i5OQLxRTWRIs+BvP1/9dtBRYRT8JXP10VYXQVV/9KlO3F/
 BCtKP4mncEm9uV4hb0PMx4CYEY26UvhtEEG7ZohSiIQsvhfW0Pg1p7HTN
 o9CXmd+B+CTC/EPq94+/KPZJFV5dO3tW0c4+88Afw3xZOrVyjPjpxA8dT
 8rpL1KQ1FG7GyFIUFTCF4iIR3f4TYCnI1yy3WHOaG0TlC15oIcRzb7yx/
 nFglh/grDaq+m9Gs6JQLbdtMtt1WezHSzSDrEfzzIRiYEZ/ZKSGfxFMee
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dc3gUPbI
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 3/3] iavf: use cached
 page_pool ref in skb helpers
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



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Matt Vollrath
> Sent: Friday, July 31, 2026 2:41 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Matt Vollrath
> <tactii@gmail.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 3/3] iavf: use cached
> page_pool ref in skb helpers
>=20
> Deriving a reference to the page pool from netmem_desc requires
> loading the struct. We already have a cached reference to the pool, so
> use that instead.
>=20
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Assisted-by: Claude:claude-5-fable
> ---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> index 3ae2f0a0ee4d..9dc5f0761d8b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> @@ -1184,6 +1184,7 @@ static bool iavf_cleanup_headers(struct
> iavf_ring *rx_ring, struct sk_buff *skb)
>=20
>  /**
>   * iavf_add_rx_frag - Add contents of Rx buffer to sk_buff
> + * @pp: page pool the buffer was allocated from
>   * @skb: sk_buff to place the data into
>   * @rx_buffer: buffer containing page to add
>   * @size: packet length from rx_desc
> @@ -1193,11 +1194,11 @@ static bool iavf_cleanup_headers(struct
> iavf_ring *rx_ring, struct sk_buff *skb)
>   *
>   * The function will then update the page offset.
>   **/
> -static void iavf_add_rx_frag(struct sk_buff *skb,
> +static void iavf_add_rx_frag(const struct page_pool *pp, struct
> sk_buff
> +*skb,
>  			     const struct libeth_fqe *rx_buffer,
>  			     unsigned int size)
>  {
> -	u32 hr =3D netmem_get_pp(rx_buffer->netmem)->p.offset;
> +	u32 hr =3D pp->p.offset;
>=20
>  	skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
>  			       rx_buffer->netmem, rx_buffer->offset + hr,
> @@ -1206,17 +1207,19 @@ static void iavf_add_rx_frag(struct sk_buff
> *skb,
>=20
>  /**
>   * iavf_build_skb - Build skb around an existing buffer
> + * @pp: page pool the buffer was allocated from
>   * @rx_buffer: Rx buffer to pull data from
>   * @size: size of buffer to add to skb
>   *
>   * This function builds an skb around an existing Rx buffer, taking
> care
>   * to set up the skb correctly and avoid any memcpy overhead.
>   */
> -static struct sk_buff *iavf_build_skb(const struct libeth_fqe
> *rx_buffer,
> +static struct sk_buff *iavf_build_skb(const struct page_pool *pp,
> +				      const struct libeth_fqe *rx_buffer,
>  				      unsigned int size)
>  {
>  	struct page *buf_page =3D __netmem_to_page(rx_buffer->netmem);
> -	u32 hr =3D pp_page_to_nmdesc(buf_page)->pp->p.offset;
> +	u32 hr =3D pp->p.offset;
>  	struct sk_buff *skb;
>  	void *va;
>=20
> @@ -1430,9 +1433,9 @@ static int iavf_clean_rx_irq(struct iavf_ring
> *rx_ring, int budget)
>=20
>  		/* retrieve a buffer from the ring */
>  		if (skb)
> -			iavf_add_rx_frag(skb, rx_buffer, fields.len);
> +			iavf_add_rx_frag(pp, skb, rx_buffer, fields.len);
>  		else
> -			skb =3D iavf_build_skb(rx_buffer, fields.len);
> +			skb =3D iavf_build_skb(pp, rx_buffer, fields.len);
>=20
>  		/* exit if we failed to retrieve a buffer */
>  		if (!skb) {
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
