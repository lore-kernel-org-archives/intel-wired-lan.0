Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51B6C5516D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 13:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 900ED60AD0;
	Fri, 31 Jul 2026 13:39:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P-SjSjOsaYc9; Fri, 31 Jul 2026 13:39:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EB25F60AB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785505185;
	bh=Avbq25dIzKHeyj67X0nZuqFfgwV6hj0SvWbxvhhVWk4=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SPw+722fESqWQzIXgQ2wEqJnycVu6ImQadeFjvQfwvCXZKKnqa0WwjLHDfAmos3vY
	 jM1NKviClvZGKQkKGErvHRS1Y+jum6SCLF17qkvrpTXfmiEZbNmnWshsy+kIuA8IV7
	 pVoF4S+kZMt6DFIHJztyC29GSj0RhQu6XXHfeEPnqdIwxgNoAnMiMW31qyuBrrwIDQ
	 WycVjvPiDphvOAISljIAcdrjteyMAn1t3aRG1J2JXhrv87sYpuT7/KCktobFpNUgPT
	 VgzC2/d/sdohPuiDcIa23uwKe/KhfKfwjCVBXHlVb++9rsCOs2l+z8VZvAQv2Xfd72
	 sweccymDhdjlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB25F60AB3;
	Fri, 31 Jul 2026 13:39:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 142B42E9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 13:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05ADB80A8A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 13:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJlSfj21GBGg for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 13:39:42 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E74F680A87
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E74F680A87
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E74F680A87
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 13:39:41 +0000 (UTC)
X-CSE-ConnectionGUID: WHoaTXHvQrS4NJmgLEbplw==
X-CSE-MsgGUID: R5IF501xSE2eo7A+8+0Xhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="90018509"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="90018509"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 06:39:41 -0700
X-CSE-ConnectionGUID: O+UZZV60QU+AD7dkPa0ueg==
X-CSE-MsgGUID: ZV7HhAliRSGkEuT5KifZbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="257912913"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 06:39:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 06:39:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 06:39:40 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 06:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3sZM+fpC4pxSXy7ntHu/kpWO1YFEVOcxDyr1eik4MQxSMILndHyhtzCMCnocfBQBxXI4A1zpKJ1qnVqN9lpwxZXItofmV8p2MR/Pk85VKBPHKUthzcjXRsqu6kg8FKMWeGpqvn41bTLfwbiqzbs5EXLtgb7l6nUeyeY5mYmAaRpf9B9n+zinFvGsoisrPQq7tyWK0cyB1R9BVjWEFjw6cY25YZyTMsz7AsAoEN7dNsCdwMhp05HvgDLMtEn3pGRW30BP8f9tsNLDi0HonlNQm+1ZTjw+EoM8gDRSImwmpEb36fPZgRavXQ6AqqHtOQVKEG0BcLA172MKB/qnnErbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avbq25dIzKHeyj67X0nZuqFfgwV6hj0SvWbxvhhVWk4=;
 b=OYbMaks9Z5CIWkJhcSp+ykjkm+MoKc+5AiGJip+9BvSv/5IOsjVO1oubNkHRfa3Drt4QtYzSvB3iXxY4Jz+v0MLXdKn7Gq7yotCA4lhPmHbEifF6PThjLhsXG3JhCZx+zGXi8vsFhieASqU/qQuN7kyU1WYwfh1QxJJYQuXVBC8dqdMUHsvc8GCu9iEUNG0lkSGUzIFH5pLuz69Ip1QF3LirTLQFPm/Q7LLtzQOAsw2HimWKXVjRYTUP9xDgxu+CAewZMbH338cO0aVPYsrflOnITBbMKnKR2nTV/isqueBcHBJk95jJzRbpsrVSWNH1edf4p2pqS8zyn1hISrhNpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN4PR11MB9943.namprd11.prod.outlook.com (2603:10b6:806:4ff::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 13:39:38 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 13:39:38 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Robert Malz <robert.malz@canonical.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Jesse Brandeburg
 <jbrandeb@kernel.org>, "Keller, Jacob E" <jacob.e.keller@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH iwl v3] ice: acquire NVM lock around
 each flash read
Thread-Index: AQHdIN0/3FOwU0NlFEqFbcuI07wHQ7aHojVA
Date: Fri, 31 Jul 2026 13:39:37 +0000
Message-ID: <IA3PR11MB898662A202677FDDAAC4A3C9E5C82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260731111008.1266444-1-robert.malz@canonical.com>
In-Reply-To: <20260731111008.1266444-1-robert.malz@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN4PR11MB9943:EE_
x-ms-office365-filtering-correlation-id: a6599b61-5f35-4838-1000-08deef092a82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|921020|38070700021|56012099006|3023799007|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: fAQG9wdNdx/a5t6fH+8xdQCt77h0XOk+beaGxkam6jST/DNqMYOwkEUubV3lkFvJFXKVvdBvilFLqPxxWONt0VxMtbV+tsin1t5VgjBGS9ahmYBByv1fTALfcIANXolb2DDpJ431EsolpeibHGnOUAJOI4U+Dm/INbc7jVCYQ+mvmvJJ6w/LIBTsadzWsF7nZvHkkGgBeMWVIHyRxfFhDaS4MkG8d22vt6+N7g5VaPq5zVFra3Xt4JlHmmXvQzU/fhxpq41IuvrxQsrfn/hqJAFxij0F5CpiCgqbwS/yr0I9v1Yv0zf7KANVvSq7PwrJvdmCVI0zmaTItJ/4wUyJAh5KPINCJFdBWm0IdPYAIppdUqDVGJp8hzzF/cCj1D2NRiYduHu5/QPVI7Ff27uqygYh36XfvhAVUeXUmJgf52hm0yXfKovFP+6i8tDfG7ftcz9Hoqkt6rRRmBff2KcpO72TXjTSc0R5BYBs7cxMQvlttpsUXFFB6IYi2J3WG3k6D26mLabeR3HARctwJrnIZ/yUxamudDtivuQPsxBbYmk4SvshMPqpdRxLWCp4PgPFV1fdu1aCGeAnAQtJNXZl0PdKw4DqPKA0d0KvB5P2IGPJ1BChGOKRA0SK5hQux6JuuWT/Tj9cFlJCTUVZMVBXpMee52oAAnDUGn1v5/eaLgstnEIm4Zkvqkb4Pd52K6PFW5L2UcWcbVE9iDXHxwPld1e+9LkjjoZZP30OHGJ8TUM9Xy3GF6NmwF8luvu130qD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(921020)(38070700021)(56012099006)(3023799007)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EuCorkSFiVCZitJn2XCudDlqOq3QKoK5ok+KCLaiSDdBMEtr1KSFqfp5pxJv?=
 =?us-ascii?Q?odD5a66kDpqgLYD3lQObmX//fwDyUekPNyVDofjEPqY4UXobmiDtk2kNKYun?=
 =?us-ascii?Q?7Tan6BvNTN8eCPpfeujFrHp0UVdI0okeb83e7AqTdtRQTKIGM/WxrEyhI+Wt?=
 =?us-ascii?Q?GOMIVpbaO+XDypcVpgbtjKlMTTon/SOVbqYZp1wpP8tsWZnDc9GPFjN2lTUT?=
 =?us-ascii?Q?W3SoEnkgp4kmAUpcvMdZoj5sA9Ap7a/OiDupWB83MsEm1PgUwqtC1eJdVdgl?=
 =?us-ascii?Q?QG60IpJS/Wr9+sG5WxigNFYJoJyNO9TQ8x/+onFG5fnJd9pMHIi6J08A6PvH?=
 =?us-ascii?Q?rcj9jAZqTxIBon1nSZ/zASBF2oNHHWI9XjvZPWU+pSEreAAuKoGY0SOUTa+x?=
 =?us-ascii?Q?wvM72LhO6S90TK3VjYEAqxgS6oE1bv7plMcPQwpnZ+QDjL/o/8rinZP4EvmD?=
 =?us-ascii?Q?NVs7mFol1OmHV3tE875zlHK276NC8UHtQycTLQQgM3ur9h/y9V0hxDcSFQun?=
 =?us-ascii?Q?cFwmdhOuYlR2VNvyKG+dlXoPHTJyR+J4SOCNGQXYufSIptMXymFDIjvvVx3L?=
 =?us-ascii?Q?ZLRAmszWqZVZmJoxf3uxy81FHgAMNkQ8brACh+jviS49fPIKGj1SRCfxYP8Z?=
 =?us-ascii?Q?+fyxglkh2zPFTphDR/tPSXMm9BPrHZQxFOI/usgv6J8j7sbTZUcURoIMyUeV?=
 =?us-ascii?Q?6XzWxWuJeBjEA2726fHZv1OwVESRyD0EUith2MiUKy7RJ7bSDrQoe6JvYPHA?=
 =?us-ascii?Q?l8tpYUpWmBu7xelw3V+Cj8DaDDhWmLDpyCZQTORuFoudMwephk0YIkQCHif8?=
 =?us-ascii?Q?N9uAal8i6fNjRcD4YbLIWZaGgwKDUDzgpu/t7GEYWG59TqaVxMF5BZj7g6Xv?=
 =?us-ascii?Q?Vyh6JGxnIEtBozdqwVJd44mFfzLtHEH8VvVlu9lAjzvdJRCIEoyNDiTuV704?=
 =?us-ascii?Q?pcaiAjc/YE6scPKcaDRtnOkapHkNNPfaTO+86iEVWMUVBmFvSOKxFldAQz5Y?=
 =?us-ascii?Q?QR7/ePBSLOF+hLtjbfm3JzBC45c3Wlu0ttw3s5aPgF9XccYvMGCnt9BleFX6?=
 =?us-ascii?Q?G1LNVwi2m9xqfarlC9dNLShurvymT5jnnIglSFERecpIif+sbwnofUmvzPDe?=
 =?us-ascii?Q?mqRgUrNuk56gs1h939jRXsicnWcW4Hgw6FvAxtO0a5YqDyudseGabMneNPua?=
 =?us-ascii?Q?vqMZPJhZoliuYATw0K3uDKq3a/GaFJqzH3J4fOzG3t/ZHzj028A86WU7Xyy6?=
 =?us-ascii?Q?YD6USE0XJcT7s6J1KudWeXz7jUfs009PNjz6jYS99uGR3Mr33gfGUtYtU0z5?=
 =?us-ascii?Q?ixdTtzzLMwy7uEWvWsw9H6jLP+7yLl25mg9iidn7iTU28XJ6F1AZ04PMzMf7?=
 =?us-ascii?Q?FugU0GB/Lu7Bx5MO/9CVA1KRvMy4joARLdimBiNVv4mAUPi/xUxT15f8ljRp?=
 =?us-ascii?Q?jd6pmVJExG3tNIoCH5yITA2lYGf0T3tZozZMOKmXSryuDCGyq/JnNWisgQXh?=
 =?us-ascii?Q?g5YulQBlLCglsvPmrzNM91lRCxTTpho67SsPvEa2cyBcavlF7uhcSH1Te4za?=
 =?us-ascii?Q?ApE50ytERyO07lTtzZb/Li+Taja3Y/r8aInPV5QfjWb1ftvb+k/MOrljc0ns?=
 =?us-ascii?Q?4FnPhw/0XAsI/U6SKo9kTzix6eDHPtPAjDegb0GcBmCJJFro0PKYia5fCN4m?=
 =?us-ascii?Q?0VAH8QzVz+bPWh3qOl5DjvLlgWYL0II571TmR8+P+1pm1X7sleIvqJr/6Vu6?=
 =?us-ascii?Q?uiE9//8qMw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Fieuiub6MaYLvLOyFjsK7QAzVTS3f9jTY4Rj9k27pzH1RGAjIIL3BczOFf/9eW5Mz9GZSFXwYuLQ8VoJkXnDv3XUhu/FUQ6VY5xQE0LA8JfipJ0g9AjbnqG74PxqDYOtzBIWNbEkuIjXwcEBFj1n/AlK9GaZUtY0HsTW/kTWdbAWpwcy4TUsOfVNl5pavjYDX6XWfzFnmfHjp2DCPEN+QGR1+8cPdDl+2RT42MM4MCGUQLtkwF653Wak9fSrH5ScMAvw093Dlb0W3qCavmVyQwyMrdGj4nDeJROvAUa/yAkS29pp8QGNvf/Jxdh2IImosxku569RYN8dH+5Cgre2OA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6599b61-5f35-4838-1000-08deef092a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 13:39:37.9127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIgjvqKObXW6NDVBjC/fUcE4clM7IjBSKaS9mAvwJNmM8eGQUOp32BaniK1N29WudpKHKB+/Uxe+C5SbMNnAAV7l3nUi12RTruxiBjfYFeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR11MB9943
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785505182; x=1817041182;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UgB52j/vsxLbBd0wY4CcxTtrF9feyIaUHDhcBA3dhGg=;
 b=f3UComb0FQzEtKSKQJBTjW/J3YSqIHyr9UxnRn45H39p1ZIHMvUT4HKo
 yLwuhBpIxHFg49fMpYNnyNwlAXezcuQEwXvmVAQ78jgo1O9VTidg9yvgp
 dFWVMy2UN3hmV3EwovzM26ZJWVZtmrGDYSf//xhwXHSRxKnJ3FPWjhUM3
 0awtWKqGp6U4aQImekHisdtmnU4keb63A4LNM0u1ffZK3jmCzh04cdLVC
 Jl4EhcdoqW7pXAhNs/OhEwY0WCO1cxlta3WdYonpl6f75KQccxSj6iknZ
 eTQS8D/E7LpBmkzcrf92lmBy67dPkRDBvE7H89GCvKGao1t5RU4ublrJ9
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=f3UComb0
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl v3] ice: acquire NVM lock around
 each flash read
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
> Of Robert Malz via Intel-wired-lan
> Sent: Friday, July 31, 2026 1:10 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Jesse Brandeburg
> <jbrandeb@kernel.org>; Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Robert Malz <robert.malz@canonical.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl v3] ice: acquire NVM lock around
> each flash read
>=20
> FW caps the NVM read lock at a maximum of 3000ms regardless of the
> timeout requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a
> read into multiple ice_aq_read_nvm() commands, one per 4KB sector, all
> issued under a single lock taken by the caller. Reading a large region
> can exceed 3000ms, so FW reclaims the lock mid-read and the remaining
> commands might fail.
>=20
> Move the lock acquire/release into ice_read_flat_nvm() so it brackets
> each individual ice_aq_read_nvm() command, ensuring the lock is never
> held across more than one FW read.
>=20
> ice_release_nvm() issues its own AQ command and overwrites
> hw->adminq.sq_last_status, which some callers inspect after a failed
> read.
> Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
> capture the failing read's AQ error before the release; callers that
> need it (ice_discover_flash_size() and the ethtool/devlink log paths)
> use it instead of sq_last_status, others pass NULL.
>=20
> Callers that previously took the lock around ice_read_flat_nvm(),
> ice_read_sr_word() or ice_read_flash_module() now call them without
> it.
> The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
> dropped.
>=20
> Fixes: e94509906d6b ("ice: create function to read a section of the
> NVM and Shadow RAM")
> Signed-off-by: Robert Malz <robert.malz@canonical.com>
> ---
> v3:
> - Log the failure via ice_debug() when ice_acquire_nvm() fails inside
>   ice_read_flat_nvm(), rather than silently aborting the read.
> v2:
> - Replace the save/restore of sq_last_status across ice_release_nvm(),
>   which could race with a concurrent AdminQ command, with a new
> optional
>   read_aq_err output parameter.
> - Add missing "Return:" kdoc to ice_read_sr_word().
> ---
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++------
> drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
>  drivers/net/ethernet/intel/ice/ice_nvm.c      | 79 +++++++++++-------
> -
>  drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
>  4 files changed, 59 insertions(+), 70 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 22b7d8e6bd9e..5a1ab9654fb8 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1856,6 +1856,7 @@ static int ice_devlink_nvm_snapshot(struct
> devlink *devlink,  {
>  	struct ice_pf *pf =3D devlink_priv(devlink);
>  	struct device *dev =3D ice_pf_to_dev(pf);

...

>  int
>  ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16
> *module_tlv_len,
>  		       u16 module_type);
> --
> 2.34.1


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
