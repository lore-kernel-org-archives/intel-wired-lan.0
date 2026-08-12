Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79396C5B56A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 16:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1ED1140908;
	Wed, 12 Aug 2026 16:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s-h_hjVWg4BO; Wed, 12 Aug 2026 16:05:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47C8940902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786550717;
	bh=bup4SxC/1mDNMhOxfmoGHbZh/u7Z/O6xeVHTuyeaP5w=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JeFxZnva3ghXFtqFX38i2sUKPitaOI57EhGNuPvXGQbCLEbEMzbuGyM+AGjMBjIiO
	 joFqIgOIVDjRFEO999RihdkAwmOnnj0rwxAeVms8mxoQTdQGYqWvBV5T5GexrQB502
	 7n/wyGi56oNY6je6g6P1fIetHFGBk1rXrtBk4GSTbzXlU9f9VfevAdFO/GMQpaR7jY
	 9i/5j4CM1Xw46+b6fAUEMFjqJ1xoesaQB0gxus0svOMV9ad2LON8z2JUbDyCz0wnXd
	 VU2e7iBOWP0I8k4a+qodfM55DKTETVVBHdGyFZWConttprq79pJfEx6fZkakWFqBkG
	 XY433yCZcc8fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47C8940902;
	Wed, 12 Aug 2026 16:05:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C71FB1F41
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 16:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5F87811BC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 16:05:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VSGcVWBn2FUa for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 16:05:15 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B671781199
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B671781199
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B671781199
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 16:05:14 +0000 (UTC)
X-CSE-ConnectionGUID: ZHHPWDeyT+C6jCOVQyyDXQ==
X-CSE-MsgGUID: yvPJbxYGS9qxGy6TVps2gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97774327"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="97774327"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 09:05:11 -0700
X-CSE-ConnectionGUID: 6WRsKiziRWiCdMs29Vykjw==
X-CSE-MsgGUID: 9ZDiuDidSNm9iH+20y+8cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="301939789"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 09:05:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 09:05:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 09:05:10 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 09:05:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7glFYh4Y4xbMPL/DlYn6BoR+aXZckACqWGoc/gEvGLsYJEcukD2+KYztUJqf7oJejzTs/ne+3ootRzO2J3+ATKftEM7fJc6vshe0TkCX7ZlABSy3oLJ7QwszpaHIRBlwfMMzvARmsHWQMt/hrTZ5/o4RDN7ABCVSHrXW40ivRKGPwxHCDBpo3tbaW+lF8y2o76uqNYxiL4Kr6ujY/8rn+EgA+EnWFLGSVmA+EgTdbf/g/7cF97BnMBBKb98YaLoeFnGWinmMU5aA9GHCx7JjdeMloA4SiAgwXT5mGoed/XAORzXgCQnIjjSNdkB8Ttw1W+i1aMo1HtMc2g6sr6F/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bup4SxC/1mDNMhOxfmoGHbZh/u7Z/O6xeVHTuyeaP5w=;
 b=TP4cZaR0RBNXauVLD3int7c3of3TcqC33MDyhU5mXo12wTiwJiaRfDGlcx9wsucxj1OuhLkf+TZUWTVVgXBLfPiMcNfGphw1q7uxBUJQPK1sOrBFNKVJFRuPBpKWAeZlzUZWRwp9TRacHjheQagWihzjm8amCS8FSpQjNhDj62jACveM/7EldBl9ZUZtZEjyHWu1hlSNd8CuLkSxidlmysEEIqUvHTliY6g1/PawM0udjez87SnSmwOy7gnZKHjNUz34ENIPyHkUzUY2RuAd06MLxuJ9UPenI5Snax5RC5LbG1aMzFM7y8tKgBq5h0WvD1AOhzfMDxJw1FMO3go9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SN7PR11MB7018.namprd11.prod.outlook.com (2603:10b6:806:2ad::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 16:05:08 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 16:05:08 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Thread-Topic: [Intel-wired-lan] [PATCH net] idpf: disable DIM work before
 freeing q_vectors
Thread-Index: AQHdGE/1GG4Ezw3QzkKZCtwme74M27aat6Bg
Date: Wed, 12 Aug 2026 16:05:07 +0000
Message-ID: <SJ1PR11MB6297611A5C7A767FF4E406149BDC2@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260720135846.76229-1-mhun512@gmail.com>
In-Reply-To: <20260720135846.76229-1-mhun512@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SN7PR11MB7018:EE_
x-ms-office365-filtering-correlation-id: b87fb4bc-411b-4bf5-7728-08def88b7afa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|5023799004|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: oj7kU8AppNwjItlzEAlZBa+DBkvf4QxnrJbaYAgogwJ/iFzWxjuuZ3dxXFhTL7b2X2bdxZp3a0SegdhQOHnfqe/s/7u29QvOCWa7Ri+YUGU3xSPUh5+MpuJtZJFBAyQ/F4lT/0g+GvIaT6vV17zb3QJjM3lN16Le+zGg7wTfTSZoHdWyaJ0iGbLAj0xBmJB2pbAT/2ycKIg85b7DwIDPI5oEcIe44vro5PiBWcHW40SkiPlY0oDU3noMzCi9QTYFy5vBdELzvgeCAHhI45Ix/FOwJZTLn6SY44jA8QUncjgk4/BhAkEiAMXCNzVV+h5/IGrwyW5kGP3mifCE0ZAGWp+ZBUDBQ/OEyZBV2TY08jLUTItxek0QNHPTsPFluMp37VdIBzbDy7h8M6y4dBZi8qDK8E/QKJkeGbXQnlVm9hrmZrWZk/1SnRlOOIF8abnkBYeiyvqRp4/IxJ3Nl4TUb4EPfsK9/wUtLOXhzA8BR5k7xcmEOgXhVBxQMix06SAsOO/yXS+du/dzdGqqqjY8/3Dri7utqgk6K7JPJ2ZWu4dyR4rQuMoQKa3L1hc9pT8suFoBC/5hh/zy03L2MDJuMnfRuAIx9gKFzYCUEg1vgLzKAicz9YZZi0vyxnB2oNnElOrlgkFZ/fiZKIW37qSa9zdGPp4le7cXpSJgI6cu+1pm1NLpo7TIHkgtyMG7BYdcyrEDCHCliYoUHByFMzo4nOgVfsMpkxEj3nxOlLBZaJk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6297.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fVNW24a+Ff5do0BU51lD73rZoDGBQLS88Gzse2R+pUdfQlCXL2gz4FhCuh/Y?=
 =?us-ascii?Q?Cgs12M/vS/N1td9ldsb2rscuaqLRmg/Np43YSptttGkXJQWe6Yic1kc/R2Bw?=
 =?us-ascii?Q?xVBQsqddRMmtEt4E5o1QHJ8+FkXpD9FqyNC7Hcpq7o5v9MvJjuaDWNpsL2+D?=
 =?us-ascii?Q?RDUZRRvQNEKn+ud3AG52iSeQiw6D23vw5azWV/B+KyMyAJj6HLs+a18r0lZs?=
 =?us-ascii?Q?uJwS/8zSPddbB7WJgGLXJPi7VGUVFym/kJXEarw8Pq6VrhaMypLLbU4dgISX?=
 =?us-ascii?Q?EfW6hCF/GI32LdWFHPNnZF+/M7WmMQ1F/E1PjQfr8kqPSTjUNP1QoActxaEn?=
 =?us-ascii?Q?73uUsiPWqPm1onx4MMNGK76KdPgl46TtThG0Kiy2JClee0XLfBitodlPvsks?=
 =?us-ascii?Q?OfReIuNiwRFm/dQqxX48ANFLdQ2OxJA8Us8tEEWylKQCxCLoLHNCkQB+YvQI?=
 =?us-ascii?Q?1txx0Vp4RVaBF1IVOIrxWxmK4iFzWjBCNuqqtelcyMS0YVdfU1/iH4p/G3tX?=
 =?us-ascii?Q?KR2F+FbqP99WXD7KJ55Nq1RZ0d5OiOStBpSZqJTDZvtUiSNfZSmiUa4eqDae?=
 =?us-ascii?Q?m7L+v6ckyfOlVvozQbfrVpt/8G4f3eToCaM0tEAKZ7jbLx7uXV/uv/FEYCKP?=
 =?us-ascii?Q?MsSe9F41HAABTLM4xDeeiJ8bBKvcdMQUD/G9IupCt6AL50ZCPlJhEZGRmkHn?=
 =?us-ascii?Q?ETyYmKxj8vunxDz9O3VhnJm8B71Jx797NE+IunMHZQ8S3VEcu70AJzI7TZMr?=
 =?us-ascii?Q?38B0DRU7sjp0zxiQPE9RR1sSmAZy+rIQ1gDprhNyq9ypg4dMjxGSa8CpMZkl?=
 =?us-ascii?Q?4j9BZ+j4A0eH0+sIHXW6T29cCwhDC9xoOJsBl9mFgJOOn2Iq4kUmLIZXj0J7?=
 =?us-ascii?Q?pHIatrkrFcX8j387KnDGsaECyohD7lwZ7cWNhKM/Z0cScgaO+Tg1h8vTEBPn?=
 =?us-ascii?Q?L66gZHZ+0Z8A22YBHIUrE92zBvHw4e08enG7xmAr+80TowPibjUEvHLGYiMh?=
 =?us-ascii?Q?9RigksG1S1CVHP54b/8mmHiB0Y9yuP6LV24a7TVobTZZE1NlYYqtpGz1UAjY?=
 =?us-ascii?Q?2nPmdBtWBaCbgWYdGLLS05nBz4gZqLtlhForEyjS7zUKPBG+r4bttSwVNzkj?=
 =?us-ascii?Q?JendptxmdBrrpO9HscJOp0u5qyCkgPqP+Ux+y0APo4OMG8ziSMadKt05/OfE?=
 =?us-ascii?Q?7RC6trPy2JkG6pw/y4UWJoMS154bUa6ly9is+Ne4eo8rv9N2QrSp+MIMct6/?=
 =?us-ascii?Q?EdV/qYDb4sIViI60NGAZEOEthH6u0SPisAkiinojwFs2LwP21+DPm4nHBqsq?=
 =?us-ascii?Q?oSs3EBuck1+ojt5LRuKSQZ/FrBPpG4dcDpcBLpgVcyHjFc792U1TiCl0nsnd?=
 =?us-ascii?Q?rVFict+HNhTe+YNutdU0gmVSb9zywpU5gkhGa+8u6iKing1eYTrJgW/+8u4l?=
 =?us-ascii?Q?jknv+/K0eHlkK3/xPaxAfz0CbinH6f4aJq0/NvR0vzxaJ3I1Z8UtXliNr9LA?=
 =?us-ascii?Q?jfh+clEXWFuQa3r1nFfFcLUsdm+3vbMInIGuh/jKGLmdPsrlsrUk93Yb8ckl?=
 =?us-ascii?Q?K2tZ6R7Al/dp2ZBJckjS5avtsL3SUu+cLTY6xHUwgPzLynOxHdGgPNw1ELwt?=
 =?us-ascii?Q?QQbY+iU/31SY3t4ooXOhQ0CIyY3gbeNvwBKxNvVpwi7VRB2VqP0yv6NBKaRR?=
 =?us-ascii?Q?5ckVQm0zM3OHpkfHl06ma9VBhzsqZ6U0Ks6zS+23gmWb3c6Gt9I5Yuv9uAs3?=
 =?us-ascii?Q?hwyJBJdtyQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GQlCG+XYBolAWOasjw7lJzgHT8lwPbHv3bj9sGpsYdAYn1oFrDQjESr+8zh/FEUtytoki4zKrYVtAz1vW7lkK3EHNmMnXL23hd0eTFq3mL+FxxwjLVtW4Mh5QDOCFpHsn/OyXD8fV24lzfcryyd2PuVEe0DKmzl8F2VJX6uMCcoa2BqhSyZLsdwGlgm4IyH/k/AryRHa6WvJ5ytZPCPRRV7ky9AA3zWVLmvWi1usP2i3LldNHEvKR9WBHgQ7p0Y6nzE0gjpYH/mV2InZEGKwhebVHu192CRSAYKSKCyD3HZJrcFMgmm2EtANpR4RgltPP63YGeBUVgkjlJlssZ/Z8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87fb4bc-411b-4bf5-7728-08def88b7afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 16:05:07.9324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2SlNcmoCx/dC22JGa7YvK6IZ1wX2uv7KNosLXs7/d728nVHEK347tk5HTjLVNzH02zs/tIkc4WE7LspLZnPhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7018
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786550715; x=1818086715;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vOcyhzqvvWZnHYhq5zxzz9Qd8QQSed4eREzO0jas67M=;
 b=ARONH01D12M0SFBm540ZjPGglL8/0pTvd+Xr0FvJksZhGzxz2DTVM4Ej
 N63CMdsv+sz61woCd6h9JPV1pLeGyYcma72kIOrC1MzV+zJS+9dsmYs2s
 bAcTx2Lnyxcbqu3XWoKoWThfBLOrF//eqZs0T5q4S0V/LeWwKDrnBEqXp
 VZLrnmg4W5aHithBK9s2/vceQmZfhiVC0fyZ4F/BJNv4p05kkQoRFiMgH
 OLgMlpdlBo0pcWceOxOByMoOIVkCH/nlJWe5XiSXmmAhi4nOeEkLvlynj
 2N/XXxtzdyuVX8tUEPoDBvMFy+zqDlD6b0jx/6mVByTskkWs63XwbsPe9
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ARONH01D
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net] idpf: disable DIM work before
 freeing q_vectors
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Myeonghun Pak
> Sent: Monday, July 20, 2026 6:59 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; intel-wired-lan@lists.osuosl.org
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ijae Kim
> <ae878000@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net] idpf: disable DIM work before free=
ing
> q_vectors
>=20
> idpf never drains the Tx/Rx DIM works before freeing the memory they live=
 in.
> tx_dim and rx_dim are embedded in struct idpf_q_vector, they are queued
> from the NAPI poll via net_dim(), and idpf_vport_intr_rel() ends with
> kfree(rsrc->q_vectors).  Nothing in the driver cancels them.
>=20
> idpf_tx_dim_work() and idpf_rx_dim_work() then run on freed memory:
> idpf_vport_intr_write_itr() writes the ITR register through q_vector-
> >intr_reg.tx_itr / rx_itr, void __iomem pointers loaded out of the freed
> q_vector.  No configuration is needed to get there --
> IDPF_ITR_IS_DYNAMIC() is defined as (itr_mode) and idpf_vport_alloc()
> initialises both modes to IDPF_ITR_DYNAMIC.
>=20
> Draining after idpf_vport_intr_napi_dis_all() is not enough on its own.
> idpf_net_dim() is called from inside the "if (napi_complete_done(napi,
> work_done))" branch of the poll, and
> napi_complete_done() has already cleared NAPIF_STATE_SCHED by then.
> napi_disable_locked() waits only while (val & (NAPIF_STATE_SCHED |
> NAPIF_STATE_NPSVC)), so napi_disable() can return while the poll tail is =
still
> queueing the work, and a plain cancel_work_sync() would be re-armed behin=
d
> the drain.
>=20
> Use disable_work_sync(): schedule_work() on a work with a non-zero disabl=
e
> count is dropped by clear_pending_if_disabled() before
> __queue_work() is reached.
>=20
> Move idpf_init_dim() to idpf_vport_intr_alloc() so the works are initiali=
sed on
> every path that can reach the drain -- the three "goto intr_deinit" sites
> between idpf_vport_intr_init() and
> idpf_vport_intr_ena() get there without the enable side having run.
> Nothing re-enables them: rsrc->q_vectors is freed on every exit from
> idpf_vport_open() and on every idpf_vport_stop(), so the count dies with =
the
> object.
>=20
> It is a race, not a deterministic failure -- net_dim() only schedules onc=
e
> DIM_NEVENTS events have accumulated and the profile index changes.
> A KASAN ifup/ifdown loop under load is the way to see it.
>=20
> Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
> Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
> Cc: <stable@vger.kernel.org> # see patch description, needs adjustments f=
or
> <=3D 6.9
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Found by static analysis; not tested on hardware.  Testing by someone at =
Intel
> with an idpf device would be very welcome.
>=20
> disable_work_sync() landed in v6.10, which is newer than the commits this
> fixes, hence the annotation on the stable tag.  A backport to older trees=
 needs
> the work held down another way rather than a cherry-pick; happy to send o=
ne
> if the bot reports a failure.
>=20
> libwx does the same thing in the same order -- napi_disable() then
> disable_work_sync() on the dim works -- in wx_napi_disable_all().
>=20
> Based on v7.2-rc2.
> 2.43.0

Tested-by: Samuel Salin <Samuel.salin@intel.com>
