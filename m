Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5651C44515
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 10:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D1EE80BCC;
	Mon, 20 Jul 2026 10:30:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wj6SKrD6mA0a; Mon, 20 Jul 2026 10:30:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95AD980C16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784543401;
	bh=2pQh36pt1h4ISkvNICitKUmRuIygDM8xczOodnSygNw=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2j7Vjg/HusMzTrgJ94qsoGNEGINOi1Ka0hzQAgLDKJUVmWgcpt5I5GQtCELbrmfZl
	 1c+dD9ix8ae3A9Y33sRlBVrbZ0T5Zdnnn7WNllCm5K2wI6eTDeHu49yB2YDALj77kF
	 I8QnbFRL0YUTa53iNWZdv+8AuqhCIbuoedIml786G3eVQ9ZurFHWEMdUic+BmnAZPE
	 vyNxpd9/2pq6UtRZHoHvTHJn+dJZu7SaLKruDtndP+HSdArNnwYHC9yLAL3ARBtOLD
	 LrTJchfnQaz0DREXCbedg6sp4pmCnUA038IsH933SCWgK1TZNiBvW5T4mu5xpSobC9
	 Kp7H/MdqJnc8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95AD980C16;
	Mon, 20 Jul 2026 10:30:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 15DA11F6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 10:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFB5360669
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 10:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FXfkrCdoF6B8 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 10:29:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F11CA60643
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F11CA60643
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F11CA60643
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 10:29:57 +0000 (UTC)
X-CSE-ConnectionGUID: gllF8zYEQ46p0rLliULmDQ==
X-CSE-MsgGUID: DS6VBx3BSkGa0pDNljiv0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="87659817"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="87659817"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:29:56 -0700
X-CSE-ConnectionGUID: q3vBuyeyRWKrebaMomrKlw==
X-CSE-MsgGUID: MQBnAfSxQ9Guertc30p8kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="253474512"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:29:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 03:29:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 03:29:56 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 03:29:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwHJfyA9gedNGrMg+WmADqkOnCPyAJs+AIG5Ns/Dp8JOBI330i/T1hrcLVIAf47iWpMpw9SYiTzRQuIFt+dr7b7GZhRtYRREJEpCjcOSAMuAkSQsKu1SV5jX5fV5XOUeYoGD9amvnN8CvMVObBqIs8UPX9laUnPZ2D1Ci2LgDgq9JaDCEAn6alzvz+kib/o5X+luUWs8hbT/i7XUaH2VY2sGvMV3Q9XhxkxbRApTlQTbbld5xA7d4jyxGTE7ywp9obN10ZU5oVzXdEjaAJahGhtkdV4wI4jvVJGKKrfjF3IiYAZomf+Td6pq9XezIFCoOxLKyiYUieGt4FDQ3j3acA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pQh36pt1h4ISkvNICitKUmRuIygDM8xczOodnSygNw=;
 b=xj0/m+KpDFcgcvjpHJblljk1BY5tIZoMcf1mP4Bi+I8oPuhWMYzTSvvfRHENL6yM0REH1NB4qhnM4B24Xp4c19mSA7tNnVpOKdKL6Q84KGFKVcHhFFLc79P4zB/O1RNv8Fp5Czxzd1IidLdja0BuRn4F4ArtjvBMk/Xa2VcJCPDNRoGEht/ODhIQtNuqCQAx0YqV1u4ZK7d5zjQ308MCAJ7EVGTisjK8Zi8AANuifKGcKQYjW7VJqZdvmE89xQ5wNGuIslqnapdE97aA774iUC4bILBsiqW/Ge4N4zxgwENzKvsb7Cpf052OnwvGuy7trL6gQX+08dj4JmuZWQ6rlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS7PR11MB7905.namprd11.prod.outlook.com (2603:10b6:8:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 10:29:53 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 10:29:53 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "horms@kernel.org" <horms@kernel.org>,
 "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: suppress DPLL errors
 during reset recovery
Thread-Index: AQHc6E7amyzELAJTs0ioU9dd6IvdbrZ2lGtw
Date: Mon, 20 Jul 2026 10:29:53 +0000
Message-ID: <IA1PR11MB6241CF46DF862A12EA9833498BC32@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260520115213.10864-2-przemyslaw.korba@intel.com>
In-Reply-To: <20260520115213.10864-2-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS7PR11MB7905:EE_
x-ms-office365-filtering-correlation-id: 18ecaad6-5213-44a0-08fd-08dee649d647
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: +uYrzWSLR7AiuHnHg+JnCDoVu63DVpCQ8yUAK1bywoVcWESJi2GmD9vEKdWMdKQCw5LFJkejeKfI5wIPmD8AE96pApQzEe+fyhdrBAXGNQN0aOEuFyuQSruN8ogJxuu37ygmXmiprNaTigv2tgEzmyhT3eT4+cTCqtUlTD7CONaxBEBk0bk0fn+IEvpH0FKc3Du0FLGxrvcALVCdyEDaKPVheSmiY+bd6zju1yICIyam/DvGNnz2KPthrivrhte8IyhSOv11QpSaSIG605l3uG0ybSZir8kLv18EwdITC8wrT4dd7SaJIGasr5EAzMprNs9o8A9WG1HkZhu8pS+CiEwLeQC469LMml+npo1e+jllZfJlwJBwp724h4BEjpFnKoQy9n1YZ2LbJLLsehHojzU3rccCjMrmulECqSOfYelk4fzvQSTJjpgace1785crIANMRDoYX2yVsQ62kX3DQBlRwoID/vNhnGtBzfFYd5zhRUqURd8cUUVbbMqN7e7jaTlEzmzmL2ITybcfOQ3yoZhvKuW+8EjpHcYwWnEix8uSanNsCeLsBcUHmOp15kldO4zuWeasAbRb6edtXHxBy6Fy/oKkOkIsBGz2mIMBBUyXOgtp+DKjXJy1cFEOnkpEbyjlm6htGzb3gYQPaRkTxkR9q7QIBsnjIaQh3d0gxF3BeCiHdPIXHk5Yryjw2D3vI/5N/V+3qIKk1qV6JBfy6HUlicmy2otP89DpgRhdlh4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ljq1i9LTq7UNTCFKGYjJUk/SPqL8miR+KvzwawO0wSz+Pls6hejd/C1F6Xfq?=
 =?us-ascii?Q?yW8uJIdQkDU2e4P6Pp3LyCBq2dUP9dbWlw5rDfLAX9UT22VLounV56IQXlnq?=
 =?us-ascii?Q?UqdgYA2JDQzrYVCoN7GZZ6BReW8R8Z4RqTQzwbVswVty9ob9GN0dCt1S49LW?=
 =?us-ascii?Q?hz6i0VJWTlJAz1GpWNwgyOJlojo1esZvtexeDSD89/iv0VxkJO4gz/W2Esx7?=
 =?us-ascii?Q?gxFGxbO0wkZJX0pobxmuG/tsQhzbPSpXfMTWM+2fpyw7geQq4MxcfmgKCVFh?=
 =?us-ascii?Q?aggljVeXaSjsFwc09560mk/MHQu36BNwxXBIZMQAqWRuVYpoi+0zfd0bKe3j?=
 =?us-ascii?Q?ZYxczFUUysHDxF0HvtHDgDXsJd4KB4TkNUuvsuBYI8dpQOnirPzlwV8TeOpu?=
 =?us-ascii?Q?0PC1AClnBwiKlPSIfbxr7hZIjJmJh1lMHbSu0qUPYsZX/UpLEbVGJ0gDKcK2?=
 =?us-ascii?Q?CeF5/hD/9hT99r6wlviDbT01tXYO39yCbP5ak0Z3n+97Z+wLwHGglWUJkRFI?=
 =?us-ascii?Q?SU27eEZHTSFXtTYeA+ZPV8g4jLfyLiOhfaR02kFcOTdsDm9WQTyKAgzmPJ3+?=
 =?us-ascii?Q?ZM5PFg1j5isU5Lbq47ezeM5EtJ+zNvT/vGnI02dZgP3HarmDL0Ia9CHx2+lG?=
 =?us-ascii?Q?CRV6XWRXIjupVyUfZjmlWLzO1em5fEN58gYRLFP0FXrBWwn9Yi4/E8tTm1x5?=
 =?us-ascii?Q?u2qNkkS7wqyqD+rCp3ctRFNJSPmNK/nTc2nAw6DNFpOUHhlYh5ooUipgV4LG?=
 =?us-ascii?Q?3nD/gJQPGPsphjfLhIMYv8upwWKQSY0/JzrmaycuNuwjfGD68VO6FMmW2AFC?=
 =?us-ascii?Q?fg7L+e1UIUBumcT1QS7aO0E654ZL3fRge79gt32OrmUQUgMUy3vsazIyeGka?=
 =?us-ascii?Q?BwY75B0Ih1oXdhNjAjbjeSk+n3PreS9Q7uy52Tddck1BNrUaX9XbB1tyIE5t?=
 =?us-ascii?Q?dv50gGalxYErk3U6V9mml0QkR2VFAkr/0mJnWsvKa/mleqAHq0MKbzmpf6uv?=
 =?us-ascii?Q?Goxk8rKqTcjkCjwZkLWJ8YpXVz+9NNl2BtQbMOIExPBjtPMCdGo+ndGFXgR3?=
 =?us-ascii?Q?Ca7TvFFONiuAx/zCPMOrUOcYhjYUfPLG0b3n9IMU60AKBnHqJ19UDPLFHSmC?=
 =?us-ascii?Q?sSezLEZlXwpDMj58HSqw80YkVhO5tc6Svxc3AwPRrYXM6ns3gIGkzYaUMiFa?=
 =?us-ascii?Q?kTFbYxZ4rMN94Ye+3IDJheiPFAxDV9E1PAP+/5nw2VysL9GzlNyRij5THnzQ?=
 =?us-ascii?Q?u+pO5OhO60nTQEKblyNMtNXIoRCinIbgsouWvOQimiwa9UqBVub6R7AdiO9y?=
 =?us-ascii?Q?XUtrSHMAyZ+YLe/7Zl2/hsnbX9t4R3aNmpNjS8kWLJ0h0QVKOQH2002ymPIj?=
 =?us-ascii?Q?owloQ2aCLEJmZFhf0ytDHy8i0RWFufqniOy+/QcHKUNcWyFWbbUx5qJvvF4s?=
 =?us-ascii?Q?GcdGKiS1HE7whzKh8n0wNYncvQA5Mua1Fo4n0OmphN6e3ilFNy2LmuazOx8p?=
 =?us-ascii?Q?euU6cPGtHepju/aKON9QPy0zSEoOH68ULHKlNH7I6atjD+RM/vMPjeFuCUrB?=
 =?us-ascii?Q?8CqFrllr0MXlTi1QBc2u1csTSOnzqIA1PlVVJhtVFAH+/n87TngY7mgBkAj/?=
 =?us-ascii?Q?GJUY0cUb/tckYiYrfwv334WwfcbDXtKPEVNpmrVMC0skHr3C8R4BNy/bqA7G?=
 =?us-ascii?Q?1VPTQg8jnDYSuslfxS/RN7ZSrx0W+oN1NSfNoMAxZ2PdggRw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AzLgG1ZXpMVsLoTjvhH7nyQXiv5I5+F+hPh+q/v77hedkgijEyatenrOZW3L1poOsZOok/PYsnb0R2ycFaTzWhsXOMBECLfp1+NsdyaawHtZghE6ZRstpCfBMU75rQNGcljKemmUjwqbE+gKb0Hpt9hmDS3PoWpT16FN4TgRf7kgnF83HJF4XJE8Hzdn9+I8lGq79YTLdF/KRV9b1Eu53DDTe8nawsJI4y2ziypPAVVgnqt+J1c9b4+E/CU5JDhaIH5DUCXU+A4/oh6p9oz+k7vSSC9Xx0hDu+nEyKM8kb/BTwQ0PzTnS5PgZwYiVyrbMV6QvRo58i/6GASQxYSnvw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ecaad6-5213-44a0-08fd-08dee649d647
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 10:29:53.4852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJcc51q//nS7oebQ42W180tSwDkpI9yeh2jIa6qCiF6AjJMzYD+bdYLt8R4AmAofOltHeEHKXSTv+yrrA3nswA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7905
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784543399; x=1816079399;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2pQh36pt1h4ISkvNICitKUmRuIygDM8xczOodnSygNw=;
 b=dgiTxCJ2Se8zLluPU9Fw+fuEBM22vgKD0275X3mor5pJ/gLqoNYRViRf
 MYkdX5OdR+3z/v2fWAmFX3+QV0dp7lDBbYXft+HIsPH59VoQ2NWANqV+f
 8+UBepO05L40X5rLnB3nfGjo2wOuCDlw6EQ1z6q4AOuYHpNtUxV6QDm/B
 EMNQBNYEXHmn08EaIjaX+1ee0yOdufvtbPlCNqpblxVKGP3HAi7rnY+/R
 AtaeTolcLBsDd9qLoT2uMfaFBlZH4ME/wB+8wPrqn1qo6vs1a26Tj5K+q
 mokl2DajIREydT3NHiAoGrPq1raGKkuBwQuAk/CfNVAYV2BsIaNiYGnxC
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dgiTxCJ2
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: suppress DPLL errors
 during reset recovery
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemyslaw Korba
> Sent: 20 May 2026 17:20
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr=
 <aleksandr.loktionov@intel.com>; Kubalewski, Arkadiusz <arkadiusz.kubalews=
ki@intel.com>; horms@kernel.org; Korba, Przemyslaw <przemyslaw.korba@intel.=
com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: suppress DPLL errors d=
uring reset recovery
>
>During reset recovery, the admin queue returns EBUSY which is expected beh=
avior. However, the DPLL subsystem was logging these as errors and incremen=
ting the error counter, potentially leading to unnecessary warnings and eve=
n disabling the DPLL periodic worker if the threshold was reached.
>
> Suppress error logging and error counter increments when the admin queue =
returns EBUSY, as this is expected during reset recovery and not a real fai=
lure condition.
>
> test case:
> - ethtool --reset eth3 irq-shared dma-shared filter-shared offload-shared=
 mac-shared phy-shared ram-shared
> - observe if dmesg EBUSY errors are gone
>
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> v2:
> add missing EBUSY check in ice_dpll_pps_update_phase_offsets()
> v1:
> https://lore.kernel.org/intel-wired-lan/20260520105311.5336-1-przemyslaw.=
korba@intel.com/T/#u
> ---
> drivers/net/ethernet/intel/ice/ice_dpll.c | 19 ++++++++++++-------
> 1 file changed, 12 insertions(+), 7 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
