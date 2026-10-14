Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C8CCC6B1F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 10:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E86EA80C72;
	Wed, 14 Oct 2026 10:45:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lc1ZawOxylfv; Wed, 14 Oct 2026 10:45:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3CF2C80CB1
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791974730;
	b=OQOmcuUm6x6IosXeiEP/vn6Y3mYTc7kBv8bz54rcY4DbcCDBsfqtLWQslIkQMW7AQCbz
	 4IdphdVWm0GKK0PoBoatt2vK94YUqEKJXRINBqbSkXwnrhjsuJFNSIpwDE36muAYSaRsa
	 4v5wGr0Vkb+2jqfc7g//1KKE7UE1XUyCjqeuoy5ZhwdJZJ7ln6loVH1H4t2BhBrDTVfw9
	 mnaei6hIH4Gv+8Fs4aubWVliWiJqTMnm0+JBHrGQN9TR6UMYcoh1DVhFNxfXCmvFrkmrB
	 DI+XY3ZbhXUU5bbFVVP/9BHOns3NF7aw79QTqXs2siPOPbXLkBjkBlab1UZt3Q/6kDQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791974730;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/DwQejAILhC1tS+1OOtnkUe6M76OyLfY+xOAnhmEWHc=;
	b=kR1m5NcRziNSja4rg90xcTMYr9YenAX1gXaiH3l2NVzExFgCT4ofF/lAiPZpHGKvgwWg
	 8YntNxX00jUlAIOuDERwLEG+gLvrhhDKjR5MIb5a152jYn/Os2asVOnA/QmZ5NtzP52xl
	 qn9bqiUEB6VA+o7Sv1qaVu0S+9Y7qc3yHqfb7i4q3O8+rup6Xd4jyu8jrUIKzK5wUsEtv
	 nGvvknxlAHeyFa/iWBeh4/aPT2A4QmkXZe74xkXknHdwV51/d9wEuRDpr76zomhX6vpEu
	 t9Gucb0IvsG3vy3E/OwTl83RIaPZtA0+6I3E87J+m2bpXYxApyCjVQs04WzIKs2x9pA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791974730;
	bh=/DwQejAILhC1tS+1OOtnkUe6M76OyLfY+xOAnhmEWHc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p4vFVTpGR9teLCaW7tsvQ3KZjZrdat0/5tIDASofuf9c6J5ZL8LelkO7J3jVJuIGo
	 Jx2o0pPvphPSLAcqgcclOHQAvNp6oF9M914iAazlEj8iWXHjZqtiBpTovFIL/tjPH4
	 GpW6CfsU60BSWwPxZIWMEUq2+0ENhzk+Q4XXh8Wm3H+AlL+nG6CJ4EhGCbUajQG9jT
	 /Tv8W2rslea3MOG9XIQESFrzebv9ybQ41PK7AavcxPFc25B2ywkbXiTKU61OW2dVgR
	 4U0a+PvaWFg6Fu/gMqcC5OdumEV2EihuwqxIShsppswJ2LL3xIWM8TRdW+E2ZjRHcp
	 9xoe5a40NmRRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CF2C80CB1;
	Wed, 14 Oct 2026 10:45:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CBB9D255
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BDBA4400E5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:45:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cDSTw_ZdJoAG for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 10:45:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 00C3D400AA
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791974729;
 b=GXgCxXVyN+3gFFnQm1td0EeXdyyY0ffbeuc2vPPbkPjUL26GxfJFALWetDbEGgbZLoXP
 HtAsdsaofZ4j0fSHjVtPXGxLxZZMvm3xedadtQe+6kVbEqr7ac78eD9yDdrgyTLUF8Efb
 JsTY9k940fLGyJbjBO87V1Qwgi8Y3DUDh2Qu9WR6HAS3ozgDAsBp57x60AOyqs3XBjTA7
 9E0pe8+JgXaGKSphdsuOLcSu6NJ8cvWPxnRCol32GrQ+lTfK5oR2KM88J075W/M7L6F00
 bLdhKB3HrTdmAsNyekZbgkzwZlBXyeapxr1RfipfKoMcpa1xDfe5XMn4JgJBMOqMr0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791974729;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=/DwQejAILhC1tS+1OOtnkUe6M76OyLfY+xOAnhmEWHc=;
 b=X2mUC4iN8RXarjSpNcEggg8ZqOUM6TFPQFFjOHGCDOdqVAGjkyPnXBSQDW9ujvdjNyg1
 10zoP+koEMFdnLXuv5gMGvXPU2FDC/mf0xpoz3LHwIOrXiNFe56K0/GeACCe1KdF4aivz
 SsFvqPnikBhS8B92OSFYpL+zIn34Qmx2K3++tapn1EcXOnZkyafuLd4OGOz01mIJkPRG7
 5mgTTcNmFnlgx9FMWOQ19C9nTuRDqgzl/Yxj+T1h3KXeusmvViiuE/rpicGjYmXh8iM/v
 IJYZt3rLEluvO0DonF6MX9WPuKWuPXGMy26qXJXk66G3XgIfW2QfH517AqWDSK1Rz6g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JfaABrS3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JfaABrS3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00C3D400AA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791974729; x=1823510729;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/DwQejAILhC1tS+1OOtnkUe6M76OyLfY+xOAnhmEWHc=;
 b=JfaABrS3Jrtx7YphHBN61dmm1psoyqYCazGRsSnmeIFytVanQ1hR5eu6
 J9RrKhBdpAesBywer6SJcGiTAQribCF7gPpVQvqXoBpfYiXOg5bWkL9IM
 5qYboP4zAh36pkEDHVGOimPxd/2ft+VIFy4FihyBGl8EpDxja8eGpUQao
 8nKPlSyV2Fm1OQ0yxHYjLFr158h9Ae1l+yUeEABRht4JcZEQnXOD1z6dA
 LpPMg8ln9g/WXnOf/Xn/B8BI+F/sVmOkxz7xlZYE5GQfnrwsCg5mVNvf3
 Yj0KaVikjl6+y4IZ77B9/PbbMibxuXjxG5cA5TSJbz2ype4sWEaMW8Fqc w==;
X-CSE-ConnectionGUID: BROiOzMCQZCoXJYdVrVSKw==
X-CSE-MsgGUID: XGO649JqS+KmLpK8CO7EcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="604377"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="604377"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:45:28 -0700
X-CSE-ConnectionGUID: TDa9q9JrT5WgjRwbjJ4B7A==
X-CSE-MsgGUID: AQLTh0/uSF+fy00Lmp1QCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1721911"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:45:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:45:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 03:45:27 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:45:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWsTcxupqtqsOCsTY5tP/mIBW8Sh1izwpRL1DIPZB0brRjUoQ8q/yE6ULpO3NAOBolbojSXSv6pLV4/ApQMKaOsnWZ9y7I9lbHhBoEKawJ7lUkq/s8cmWC1wq0qWwGqpUC0w3jiF7DV7aTpRy+Tf2HhYDQTtzG3qOcMU8il21rTzbj1Iar4foydMd4DQJNG2jMx7eTnKnvYwFF+GG2IczD7ytxM2rz9uSMc5FpfQlutfEg2EX4pE1Z2c8t9CrDz0Y8xDIxxd8stkfHR/cHPuRLM9UseGXoqV8OtzOgFuZg226n5rEvhOZvVsluirvkoFVu/qVG3fwcAxwd8+833V9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DwQejAILhC1tS+1OOtnkUe6M76OyLfY+xOAnhmEWHc=;
 b=Ss20xX+TtT+oHHVTXyKnqzUUsxgBYCdmVdPLxIYdXXeOLEmFxGPkEnjgGH3X8D/gfANv8d+A5tohNK4hEtMdkuumUOpUlAIHk/vel8wPECR05wh+V70Sg8l5/xtIbSdwmzBFZLVXFsu/htWUHx4ZqSXQG5LM4ZBQOSaSxTAeki+qqu10vNpgJOeRxM5m6Yh/zeWjZWx5NcQQvBQnT6AQiO9Zg7VGa64g4rFMlXyhBVKB75OoLYBQxmanUkxxugGvf1SeRSpFSA8afuSQekBjdrbKBHR/e4ZzJXTfQr9kG7unQy3s1avDZeBLslAhMSOwE+WAckvhHyFoK6YiPAS/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by CY8PR11MB7363.namprd11.prod.outlook.com
 (2603:10b6:930:86::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 14 Oct
 2026 10:45:24 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::ac6c:1d96:c766:799f]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::ac6c:1d96:c766:799f%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 10:45:24 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Josef Bacik <josef@toxicpanda.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "Juergen Gross"
 <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr
 Tyshchenko <oleksandr_tyshchenko@epam.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Manish Chopra <manishc@marvell.com>, "Rahul
 Verma" <rahulv@marvell.com>, "GR-Linux-NIC-Dev@marvell.com"
 <GR-Linux-NIC-Dev@marvell.com>, Shahed Shaikh <shshaikh@marvell.com>, "Simon
 Horman" <horms@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH net-next v2 02/10] net: ftmac100: check for failure when
 pulling in the RX header
Thread-Topic: [PATCH net-next v2 02/10] net: ftmac100: check for failure when
 pulling in the RX header
Thread-Index: AQHdV2iHHEYlMsgcHEGDYxV8k6LOw7b842RQ
Date: Wed, 14 Oct 2026 10:45:24 +0000
Message-ID: <DS4PPF7551E65523B99324D12B953A2A328E59D2@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008-b4-pskb-pull-tail-drivers-v2-2-8f2bd9bee138@toxicpanda.com>
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-2-8f2bd9bee138@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|CY8PR11MB7363:EE_
x-ms-office365-filtering-correlation-id: ebac24e0-c59c-4ebb-7e3f-08df29e04088
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|3023799007|22082099003|10067099003|38070700021|56012099006|18002099003|261009223027099003|11063799006|4143699003;
x-microsoft-antispam-message-info: tpyrpBoWu5HClKqW2X55wgQYeMHX7epQt4ozgiiO++QSiv+e3Trt3p5QWE92udNbKPI0fanzz/a/BKXlUXCTZqeSPFVMreZb1cpIaOkglyDPgRhchLqNC66pIkuJWjm4HrEiY1VSz3q94H0W1xOIjPAdDL1GpFu2YyLyDlS63qf4YA7ARU6tTuQoxSVgQDWiZ9n6r2YnjUXQOFh9TIkWYOqKHFcCIkHltqw68jJZPo4+B24fKFAutzJoQ12c/s9zeTjlnUMlfci5NpZs2L60hGuxJtlnejBScXtMF96ZKHj5ZXIGceknrS4FApvzLZIiFNXzDyo2KQv7evaE37R7HXRoIBGjR2BsGv7FPbSxiC6YSpmDIVe5KK6b+EkqqR7tr1EyWhqjnHD91jnMQR0NMv37I3QU9WYImUXBHfeJmxhMKHeYurj0DUO34L61E/7tjnofh5zRGxnpnKLR0JK4xh0d1mg5B+vHMlJE5oN9SVqf7G0LGpF1A8uwbA/MXqbuRfNFZB/vVs23C0oNUS0hc6wMhHbMdyEeeE7OUMChUzFVy0bMPM+h5FXTxRE9cm8IBTTC+1ePtyKXa29ZsueymFFAPvs4BX/QnmcNF7sk6pTt6YJs0QNVCAA03fAs6IhpcaD4j2lNjf8/y1RazyeHSWhudA5k2HIOXBeqjxFQ7KbWO7VbCzfgI3OMjGKHvGmrmqtj+35KdDag21mobqxy2GOKDSRbeHj+74eLxH9z2VQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF7551E6552.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(3023799007)(22082099003)(10067099003)(38070700021)(56012099006)(18002099003)(261009223027099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGYvVmVaL3htYjJDQi9ZVkZyY3NXc1FiMG9xeXVVWGMxN0FmVHJSZ05tdjJZ?=
 =?utf-8?B?ZHFTbUZCOHdUODBEcHN1Mnd4Tyt5d0E1ZHFwcWk0VmJxN1JFTzVQRDR4YkhU?=
 =?utf-8?B?T3ZvMDc2NjhXRTRpWVR6UG5nRU0zNVFtZ1pIajh6YWRKK0NxQmhDbmtTL0Zq?=
 =?utf-8?B?NDRiNEhlb0d2R1RYSEFPMEJySitQcXdpbnlLRnFFQ1RZZEM5cysrYm1KNDEw?=
 =?utf-8?B?dnVVTUc0NG1jL0Q3WFRVNUtOUkhvRVNpRzZ1dUVJc1JSVDRHUDdDYnRidEJU?=
 =?utf-8?B?Z0x3YnZVVHNWOHlTQmpLR053U3NDV0xqNlhSc3NWTm1INWR4SGduQVBiMEtS?=
 =?utf-8?B?OWU3K3VtWkVFdTNFVnRVVEFBSU9SUlpJVi9OVCtVYVpHNlROQW1xRXFlSFl6?=
 =?utf-8?B?ZnpwSG5tVmUxSFZSSG9LN0grYWRjODk0SmxGZUJlWVE3SHNsR3l1V2l5QUg3?=
 =?utf-8?B?L3NobVVPb2FodXVpWUdxU2R3MUFvZ2E3TlVITG15MjZuRHhoODY4eG9abFVt?=
 =?utf-8?B?akFFZG8zQmh1OFNuUCtPRFdvK2ZaeE9paEZFNklldHZrb2puOTN0Ti9ONlF6?=
 =?utf-8?B?cHVWQUFZalVsUjVlblB5TDdXTFJBRXF6ZUZpaDlpTnNsM08rNXYrZEJ1VlR0?=
 =?utf-8?B?eXdrRWEySXMxZVlOZ09idHVOVU5CWWZSdGNXRHhLbjA5cGRDa2tJRlpwRmhX?=
 =?utf-8?B?d0x5NXZ6U1NZZjE5OUNqdmJ3WjVVSHhUZFpWdWdoMEhwVkRxOC9QY2RnU2Zy?=
 =?utf-8?B?aHlGVW9SY1VkZ1VWY3Q4KzdyRnE2QnVOc2RLVFR3cERVcEJNQ2JBRUhIdGhx?=
 =?utf-8?B?b0RsS3VOeXF0WE01SnJZK0dJclFNZ3oyUk1Zb3psNHVmWEFHdEMvTU1yVkxo?=
 =?utf-8?B?blU5V0pDWUVuSU1Ha2ZVckF1bDliT09pbllOa2YyemtPNnlKMERNNTV2cXEz?=
 =?utf-8?B?NnBLclVVNWdkbXBhVEVZYzJxM1JEdWp0M3FjMHFNWlBUa3BZUXNqUlVZVVpu?=
 =?utf-8?B?Rjl2dStmakFOWHRCOEhHVXBrWkJXaDBOdmZybmVzT0E3T2xqSnU0RnArVUxt?=
 =?utf-8?B?TjlwWnFGYXJuVTdZdmJYaXBtcllKaFdySDBGVWQzMW5oUzFlN2pqdVhiZHdH?=
 =?utf-8?B?bUcyR3c3dm05UTkrdnJxaXZvRnU1N1JOV0taTXo4WTQwUnc4UUVDOWdsUmQ2?=
 =?utf-8?B?dnhGNkEvSzZVTmpMTXlMK0d6MHY5SzJESGNNTkRrcUN0MStld042eHdlSzB0?=
 =?utf-8?B?R05pOG9tUU1YdUk5aEllblpLQi9tT2wvODJ5Q3ZkTzRxYk8rYURISFZCWU1n?=
 =?utf-8?B?cGhyWm41Qk9aV2xyVkZNT0QzUTBqQllNTWN6V3BtK2tIM3lSRThYN0V3Lzd2?=
 =?utf-8?B?eldQanBtOStuVkR3QnJZQ0Ruemc4MVNmYVUvT2IvNzBBWE43QXNKei9HaDlC?=
 =?utf-8?B?RUo5OEFrd0t3K1pCelFTeWlNSWcraEFvODQydWNabWk3R0hUeDQvUU8zTity?=
 =?utf-8?B?RzJJMXRzOXhYcWJ1VVo3T1hLREx5ai9xWHB5a3l2TGZ3cU5uSlk2Q1ZFZXpI?=
 =?utf-8?B?YitqeGpKb3p0bGlHTUcweGgzckhQbUNtSVRzZ1hZNlBZRC9kQlNnSysyZTNW?=
 =?utf-8?B?R3NkSHVEVkZkSzdSNnBkR0xJeE53SERlMXBnU0tmRXpmWXRwVlVjNW95UThU?=
 =?utf-8?B?MEE3eXh2QW1YZlp3SnJqR1lSQUpnQzZ0Ni9FL294U2cydTM0T2dJWm9qWFpN?=
 =?utf-8?B?WlRONjYyc2hnaHhIRXJ1bnRWdkhDK3dCMGVPS1A0Q0dudHUwM3lRRmRXTlE1?=
 =?utf-8?B?SDVXWHJMaERBL3VHZGFqOVN6ZFRlb0dTaGZ2V3liYzdMaG9hLzdsdXBRNks0?=
 =?utf-8?B?TEd0YVZWS2huTHgvV1BYU3FxZGgzSnhIbnZ6MXhDdElKVzMrY2srdUFIbk83?=
 =?utf-8?B?VHo1eW1yK25GRXl2enNCRFViU2dObHl1VUNIOFkvcW5OYmJHL2VaS3FuYzRh?=
 =?utf-8?B?V2tSQmk4NDYzaWhUNjlsN2Zmd0hpaEZKTTg0WklMUWpNY3dkOFEwckFSeXVo?=
 =?utf-8?B?eG9CeXdsaEhTc25KSmtQNXphaTN3R3NSRDdjQ3hpd1NkZVE0eWppSFdWcHVw?=
 =?utf-8?B?SEJWOGR5ODJxT1NzOGhrbllFc3pZR0dCZU85SnBMUnc2c0Q4M3JCTHVhU2ZV?=
 =?utf-8?B?VmFWblB3a3RvUlp2ejBHdkxFT1lOQlduRU12U2c5ZGV0WkhMc2I3aS9TaU9n?=
 =?utf-8?B?M1U2N2RhR0xaaVNxbE9tOGRyc3A4N01HVUpXRGczUzFiMlBVd2NjSDF6Z3N5?=
 =?utf-8?B?OG5CWll2dnBRcy9Xc0hNUDZZVi9vQ2RscGREQ2RYbTN4MlpEMG1Bbzlqbm5m?=
 =?utf-8?Q?KnNsjj4yaxBtd4ok=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Zk8NcIyCP/eeAJnpcwIonmZajaUG/9NNt5Wok2jjqx17VPnl7BbxAyDWkPQlf2s92sNT4OCu8js2EEeQY5t7i3Yz6FzxFuztVaSYubT0LXBfkkcbuVuS6qn1X0XlL61Y/K6vaksyG9+2x8sld+qS8gdhQZh4Mujae8ZxRVAY2JOiQrWiKh5bHjyBTXWfKN2NYJ/MN3nDGI9bZssUnmCL0FyiJeMi9BM+0BfvJAPBuI7NbtMA6dSadN0tDhVr8LPkgdFhxR94c6Ij+D8+crk1VEopj+wPYOhHKXEpAcfM3Lu7KYm9ivMOUkyViWdole0l9wgvZoeHGq5GBu7YJtcAEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebac24e0-c59c-4ebb-7e3f-08df29e04088
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 10:45:24.1352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CU+PtffOEZJI+fw5TQNWimc3e9zD5lhNnRbryhnVI3qXZAxzYWJKc6Q2QBqFhJx4DZNfjomMkEs4oRlqNT6r7rjQ16oXaGp6sGzemaDm2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7363
X-OriginatorOrg: intel.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9zZWYgQmFjaWsgPGpv
c2VmQHRveGljcGFuZGEuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciA4LCAyMDI2IDEx
OjAzIFBNDQo+IFRvOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJl
bmkgPHBhYmVuaUByZWRoYXQuY29tPjsNCj4gRXJpYyBEdW1hemV0IDxlZHVtYXpldEBrZXJuZWwu
b3JnPjsgRGF2aWQgUy4gTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgQW5kcmV3IEx1
bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD4NCj4gQ2M6IFNhZWVkIE1haGFtZWVkIDxzYWVlZG1A
bnZpZGlhLmNvbT47IFRhcmlxIFRvdWthbg0KPiA8dGFyaXF0QG52aWRpYS5jb20+OyBNYXJrIEJs
b2NoIDxtYmxvY2hAbnZpZGlhLmNvbT47IExlb24gUm9tYW5vdnNreQ0KPiA8bGVvbkBrZXJuZWwu
b3JnPjsgSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPjsgU3RlZmFubyBTdGFiZWxsaW5p
DQo+IDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPjsgT2xla3NhbmRyIFR5c2hjaGVua28NCj4gPG9s
ZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPjsgTmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhv
bnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xh
dy5raXRzemVsQGludGVsLmNvbT47IE1hbmlzaCBDaG9wcmEgPG1hbmlzaGNAbWFydmVsbC5jb20+
Ow0KPiBSYWh1bCBWZXJtYSA8cmFodWx2QG1hcnZlbGwuY29tPjsgR1ItTGludXgtTklDLURldkBt
YXJ2ZWxsLmNvbTsgU2hhaGVkDQo+IFNoYWlraCA8c2hzaGFpa2hAbWFydmVsbC5jb20+OyBTaW1v
biBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcmRtYUB2Z2VyLmtlcm5lbC5v
cmc7IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZzsgaW50ZWwtd2lyZWQtDQo+IGxhbkBs
aXN0cy5vc3Vvc2wub3JnOyBKb3NlZiBCYWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+DQo+IFN1
YmplY3Q6IFtQQVRDSCBuZXQtbmV4dCB2MiAwMi8xMF0gbmV0OiBmdG1hYzEwMDogY2hlY2sgZm9y
IGZhaWx1cmUgd2hlbg0KPiBwdWxsaW5nIGluIHRoZSBSWCBoZWFkZXINCj4gDQo+IGZ0bWFjMTAw
X3J4X3BhY2tldCgpIHVzZXMgX19wc2tiX3B1bGxfdGFpbCgpIHRvIHB1bGwgZWl0aGVyIHRoZSBF
dGhlcm5ldA0KPiBoZWFkZXIgb3IsIGZvciBzbWFsbCBmcmFtZXMsIHRoZSB3aG9sZSBmcmFtZSBp
bnRvIHRoZSBza2IgaGVhZCwgYW5kDQo+IGlnbm9yZXMgdGhlIHJldHVybiB2YWx1ZS4gIElmIHRo
YXQgcHVsbCBldmVyIGZhaWxlZCwNCj4gZXRoX3R5cGVfdHJhbnMoKSB3b3VsZCBmaW5kIGxlc3Mg
dGhhbiBFVEhfSExFTiBpbiB0aGUgaGVhZCBhbmQgQlVHKCkgaW4NCj4gX19za2JfcHVsbCgpLg0K
PiANCj4gSXQgZG9lc24ndCBmYWlsIHRvZGF5IGJlY2F1c2UgdGhlIHNrYiBpcyBmcmVzaGx5IGFs
bG9jYXRlZCwgaXNuJ3Qgc2hhcmVkDQo+IGFuZCBoYXMgcm9vbSBpbiB0aGUgaGVhZCwgYnV0IHRo
YXQncyBvbmx5IHRydWUgYmVjYXVzZSBvZiBob3cgdGhpcw0KPiBkcml2ZXIgYWxsb2NhdGVzLiAg
VXNlIHBza2JfbWF5X3B1bGwoKSBmb3IgdGhlIGhlYWRlciBhbmQNCj4gX19za2JfbGluZWFyaXpl
KCkgZm9yIHNtYWxsIGZyYW1lcywgd2hpY2ggaXMgd2hhdCB0aGUgdHdvIHB1bGxzIGFyZQ0KPiBk
b2luZywgYW5kIGRyb3AgdGhlIGZyYW1lIGlmIGVpdGhlciBmYWlscy4NCj4gDQo+IEFzc2lzdGVk
LWJ5OiBMTE0NCj4gU2lnbmVkLW9mZi1ieTogSm9zZWYgQmFjaWsgPGpvc2VmQHRveGljcGFuZGEu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZhcmFkYXkvZnRtYWMxMDAuYyB8
IDEwICsrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFyYWRh
eS9mdG1hYzEwMC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFyYWRheS9mdG1hYzEwMC5j
DQo+IGluZGV4IDQwYmEwMDFkNGIzZi4uYTFlYjA0ZWFkMmQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9mYXJhZGF5L2Z0bWFjMTAwLmMNCj4gKysrIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZmFyYWRheS9mdG1hYzEwMC5jDQo+IEBAIC00NjksMTUgKzQ2OSwyMSBAQCBzdGF0
aWMgYm9vbCBmdG1hYzEwMF9yeF9wYWNrZXQoc3RydWN0IGZ0bWFjMTAwDQo+ICpwcml2LCBpbnQg
KnByb2Nlc3NlZCkNCj4gIAlpZiAobGVuZ3RoID4gMTI4KSB7DQo+ICAJCXNrYi0+dHJ1ZXNpemUg
Kz0gUEFHRV9TSVpFOw0KPiAgCQkvKiBXZSBwdWxsIHRoZSBtaW5pbXVtIGFtb3VudCBpbnRvIGxp
bmVhciBwYXJ0ICovDQo+IC0JCV9fcHNrYl9wdWxsX3RhaWwoc2tiLCBFVEhfSExFTik7DQo+ICsJ
CXJldCA9IHBza2JfbWF5X3B1bGwoc2tiLCBFVEhfSExFTik7DQo+ICAJfSBlbHNlIHsNCj4gIAkJ
LyogU21hbGwgZnJhbWVzIGFyZSBjb3BpZWQgaW50byBsaW5lYXIgcGFydCB0byBmcmVlIG9uZQ0K
PiBwYWdlICovDQo+IC0JCV9fcHNrYl9wdWxsX3RhaWwoc2tiLCBsZW5ndGgpOw0KPiArCQlyZXQg
PSAhX19za2JfbGluZWFyaXplKHNrYik7DQo+ICAJfQ0KPiAgCWZ0bWFjMTAwX2FsbG9jX3J4X3Bh
Z2UocHJpdiwgcnhkZXMsIEdGUF9BVE9NSUMpOw0KPiANCj4gIAlmdG1hYzEwMF9yeF9wb2ludGVy
X2FkdmFuY2UocHJpdik7DQo+IA0KPiArCWlmICh1bmxpa2VseSghcmV0KSkgew0KPiArCQluZXRk
ZXYtPnN0YXRzLnJ4X2Ryb3BwZWQrKzsNCj4gKwkJa2ZyZWVfc2tiKHNrYik7DQo+ICsJCXJldHVy
biB0cnVlOw0KPiArCX0NCj4gKw0KPiAgCXNrYi0+cHJvdG9jb2wgPSBldGhfdHlwZV90cmFucyhz
a2IsIG5ldGRldik7DQo+IA0KPiAgCW5ldGRldi0+c3RhdHMucnhfcGFja2V0cysrOw0KPiANCj4g
LS0NCj4gMi41NS4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2Fu
ZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==
