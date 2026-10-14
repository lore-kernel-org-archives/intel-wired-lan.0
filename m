Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CB3CC6B1A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 10:45:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B2FC4052F;
	Wed, 14 Oct 2026 10:45:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FzVWf4CsBzb1; Wed, 14 Oct 2026 10:45:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D7AC940585
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791974726;
	b=aJTRSmole3YwL265QYeRPo8nuocDm2sGy/RXh2QuF9fFFt+tkZGHFwkkDiQS8cpG/dhc
	 qB2SpN9J88CbTVsEogbWYBDSLZyMZvL2/zB8Nr1eIGxDoHTeqjzS8HzG0A6+7ihXR2LtW
	 gY11aH+s2k/kKxYXocEeYiYx2igBj1CHOTY5hPd2BYBDFfI0rsVRQFp/9K9C5hgzCOQsU
	 mABgJGDfe0SCf3XWRl1iAwUj1E4vxwO5Z+8UxFpswZ1HdFRlhUNQDEwOD6ytCpSgtzIEQ
	 9w2auqtnn2msDZybaQo9xRhG90V+0vGgeFkrLnDFACnJdkudHKFlTTjbz6nhR6pElAw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791974726;
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
	bh=xop0M7r0e7P0bfukbeIAWui74GztOvG6zi8Sln6twnI=;
	b=RiT8mM6TyoAhtYC+jOGbA+fZa1NbE0Cx89n36IUw/0pGJoyI3nGox6diTY9BKqOZw1/g
	 9lStdA1OOXzypxgBxq2mtxzM1oEaVGqrJSYkfU4D5mj7EIHB9JkWpDaF2/OgqTE7G8296
	 /zig9CsEHBk1yC6uA0BlRbE22pcu12tryzCLxuGgR+6CE5EvuGbTTv2cHilDJyNJEVr5n
	 l7ErYlSF1fo5XO1ppA+rCQv0hMC9pdYEIjhUgFLbuBkwHz4g5M7os3Wr8dVfhNJh+QHSg
	 4vLyvkNdsAkLiatFXe/vV5SNTHD6Lo+quDE0IAjvsRvLtzxgiOnxdfrt5iNOSEiNprw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791974726;
	bh=xop0M7r0e7P0bfukbeIAWui74GztOvG6zi8Sln6twnI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=72RS567jWApdU2xuWQATRj3Q9ufXR7GC9/ppjHJyIpR67jB834Yc2j2diDrrrjV0L
	 BUYQ5mkOYKr1QYq/WkqFGUVKvY+QnkUYofhZxmApowaF/xF9IoHHeR/q+gg2RWYmmO
	 l0ErHiOSci8vW71YOtTcupqTul1Xuit4LtzisCUDi8mR3IbprGBDfDk5lfKKpq0dmg
	 A/hnBKL5liTyV5CGRj3Kh+JZahlGQxfMlleich5z+WRAxWPx+gZwu3FdyVnMByunIi
	 HExbHus4PoodROxPXQvX6R6G/w/0ITgKoHrAFH2B4AYpLhT5omGYM+s3Cyps5tVJgd
	 ywYLBxV2j7qdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7AC940585;
	Wed, 14 Oct 2026 10:45:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 16A7B255
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0C644030A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:45:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SNqDgEoJ4J1x for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 10:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2DF73400AA
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791974724;
 b=SNbXemtbGutSmR/26qwODEozorCqRmyF5EeZGufSvsurLbwo95CDCK16K9Zul744aky0
 QhtPbw1QtK+buMZjCDbJMgvQKimyY08vyH0Jzx6PrLWUPKnR9ds1i1zUjnh2lEOS4+lfU
 crM3mYFduSFkyOaxXGL51IAyj6q08DPQ7ASk8rQwfCSV9Mh+D/JQhEDjmW9jvxfGI6cIm
 tQlPd0Y04yF6NkPEFwT8U7wyuzza89lCX9Kt/h4nwgLlg+JdAys+NJHvOnVpCF1qOn8mz
 CAAoWLAJNph8GCn055XoE7e5Pi4tpm20VfsVaHj2oVACH/sAEOar2Qm5pt9i9AK8r3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791974724;
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
 bh=xop0M7r0e7P0bfukbeIAWui74GztOvG6zi8Sln6twnI=;
 b=U5/ZRSn5XK78GXP1d8S5FRU1vT48k6B9oilzRnZ4sM7HDirNDt/xAHNrSZ2pQpxManLE
 A27Excfho3ofv5cer4TEky8qogLYyIBYHjAljeZD5LUsJefYrgt5CgEg5h5M4bDr+YZQJ
 eKDiTk9Mc9Fj3qEph+5wKJccJkECqXjaC11T9b+6dVd5SJo7ImSynSLpsP7zKZ3CgPSOd
 P7X6FSJRe3+tot8IB5AzEywFcll09fhWONC9q8n0GueP8gInFgFZLYfFQG35JK3kxJ13c
 LAPW1hq9KQDB04HlaLIDfIIblkbB/Iv9Lv8qYt/IZXIzCLdhurEHplNpYFhkcp8e2CA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="Slk/iR8y"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Slk/iR8y
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2DF73400AA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791974724; x=1823510724;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xop0M7r0e7P0bfukbeIAWui74GztOvG6zi8Sln6twnI=;
 b=Slk/iR8y6CIMQVKoOnIxNyNOMZh2Z1CQ/JtPvMbGN4mR9PkgNIfiCCN/
 SxIywsyeBPFOFm9o6ghU1URL1AAvySwYOBHJjIeeQOyD8rMI2sW+f/Cfi
 T7SSfF5f3H7gQozdDscG4NEY9QofOaN51HuBILPE29h5dOMBTcLZnOnp5
 qQJsP9asqNu0uzCmMTFa8SpheWRjyyP8/iu3m1UZGTVX3hTMcMsGVYnyf
 rEVodCrQuzN46sx8nrxDmeIMCY4Po7/ereUHM8LfVIpknA19FM5NYwnMg
 qqYH/82YcRBfgjqmROGPOJe3cCgAvC91brd+/wRXppMEfjOTaI3v+smFc g==;
X-CSE-ConnectionGUID: vj3Ku0WQTwKupPP0d4e0fg==
X-CSE-MsgGUID: 2xPIITJ8RkGg2vvPyBX7Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="604359"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="604359"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:45:22 -0700
X-CSE-ConnectionGUID: aXLIELklT2WMPbhKrv+xAA==
X-CSE-MsgGUID: u71+VqHhS5OFrh3BzxjRCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1721891"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:45:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:45:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 03:45:21 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:45:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuKLSMKKBVAx8mDfl4Izf7QVwNyhiylTSKoEmB7/NOyQ1bY9BLSfMTwtyJvDGHo9a6pshdUJWNOA2kvbwZo079xjhZduT8DKpFNd9dRmVW4yjakZJZY7aDSQmYgfIUxANH600XkTKMInBPLjRPA7mgDYF3ihPxo2rkeZR7hMV0irbkp5THsl8A1q3TlSiTm+MYtosOsvyd+ZTojE5hy0yTXfiGQFwRElmEaBdxh8GPimffso6WtkanKUrqKdjLubKWIgQ6lUIHxr05Qi5THZqXI+nfj3DXEnQKpM3YassxLvhMq7b664jyWlDsF3lyO+WZVDVDBz7Y5JOgy/0Y6lQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xop0M7r0e7P0bfukbeIAWui74GztOvG6zi8Sln6twnI=;
 b=QaPFFj+iGpQUPoXgATw9WGVwAmA5sxow2l2H5ZjUc8aALWAXVO6yqs/GmPEn5+md82MGT6LOTGnBYvh3GLFu4OFj4CbZMQ2cMgxJ6pr24wDiKIJZ8OOR6jgIh90tH9AZkXAtEXU7/vbsTyTJJ0nh36KHpMZU5hPj+CNk2NIA+CBW5RUF9AlsTq8iGFJbaibBlitINbGLSt0l/V/fAqSSBYWmmaRx08n5jDS8DH3+0XYIyY695Yo8EYezsLpXpA54IlG0nG6H3rYXxehsK8Wb34L9cG0vNftvtAl+L+6znv7pG89ymNOwTQ3vl2vQ1AFszvPX1jG3XiB9aWEk2eLj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by CY8PR11MB7363.namprd11.prod.outlook.com
 (2603:10b6:930:86::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 14 Oct
 2026 10:45:13 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::ac6c:1d96:c766:799f]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::ac6c:1d96:c766:799f%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 10:45:13 +0000
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
Subject: RE: [PATCH net-next v2 03/10] net/mlx5e: check for failure when
 pulling the Ethernet header after XDP
Thread-Topic: [PATCH net-next v2 03/10] net/mlx5e: check for failure when
 pulling the Ethernet header after XDP
Thread-Index: AQHdV2iJatk7MKYekE2967GwUxR+Erb841iA
Date: Wed, 14 Oct 2026 10:45:13 +0000
Message-ID: <DS4PPF7551E65522A6F7D9184041F91FCBAE59D2@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008-b4-pskb-pull-tail-drivers-v2-3-8f2bd9bee138@toxicpanda.com>
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-3-8f2bd9bee138@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|CY8PR11MB7363:EE_
x-ms-office365-filtering-correlation-id: 6ea6007a-f369-45f6-2bdf-08df29e03a0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|10067099003|38070700021|56012099006|18002099003|261009223027099003|11063799006|4143699003;
x-microsoft-antispam-message-info: MvP/bmtNWmYmVAGFdbjUdaCERwu3f3YCcAvBiU0rPBca3omrn37OlslQBpscqbMX7KRvXGjC43Xub6BXT0KtN3OuHW+AM9++ZDvgJjohSPtDSd3aU9WXB9/vW4W9vE9miAB8v0QlqfPlrefy09A01xF2d+QRSrXNECeTMwYYTilnP0rYRCtp5KzB+VxOjmxSBB5TutW1FFoeh4/4MFeOf2gz3SxgV6J/bGrTMGTBVuJ0PnVIJVR8tMxY0mm7y4eAiyjCDfhU+5tvTajMY9WsQJoyx3kFg0dN/kTYLnffKYYTe6V+s67saE9UklbpbONqSYEO4Xn7uUbHwVcQb0/WEf/diNSHvs8udmM22THepguASZBU1znn100CC2bRK/fTvBaWFRrO4PxY0V2PQJhs/YcOYrI/dB2MEwIxIUU1bpIo0VAW9POn3akrqZuJkcuaxVoJ5tqy/zDrmfrQTmw9zehW5ZMNZG4uQ4rSovHuGNWIlVtf1oGlxD/rkQk0Oho+Xi/hQUgPx71stTZN68OHGARPPLXsjyqFMFiM8wrX0xlzoD6J0jF53HcIMk3Dv5rfUqYgZghzDFWFCqw++9R/NPj2icjSF+IXhYeRlnKdBN7lkQxuNYb5qkc3h9KccNc0w6YMp5ztDRoBgeyPlgI99cJGMBYEW7bUX8gDlu0dUGlgQg/SaRuRPodD8ZZTOoChnmmA5v4JGwhZvhRiU3+rRDh3PF+2HL3KOQe7POL2IDI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF7551E6552.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(10067099003)(38070700021)(56012099006)(18002099003)(261009223027099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnpuaHdBRDNqeVlXazgzQzV5c1FwNm9BSGZaRUtmb3hRRFIxQmZzVFJ6emlT?=
 =?utf-8?B?ZXBnY3IzUnVSRjllZ3A4WmUwdEFBcEJmY3pHc3FDSU94WG4wRnJLNk0xb1pk?=
 =?utf-8?B?MCtsWHRVNHdRM2xkeVlscUN0dU5UdEkzUGhRM0ppV3M2K1ZyVU9NQmZGNnBR?=
 =?utf-8?B?bEYzMWMySXZOamRhZVBvMlhuVjVIbHRMQ0ZTNVVFSmlKRzY5TkphcWVGNnVK?=
 =?utf-8?B?K1BzREszcCsxdktIakw3SEpyMS83aGJZUTF6YitSVFVlYlJ5UVBWSE1Td3pZ?=
 =?utf-8?B?dVhneGNWQmVRSTV1bEp6VWRpcnZ1c24wc3dCcFpScWt3aUpiSWhNbk1SY0cr?=
 =?utf-8?B?WWs4TEcvYjc0VmVVakFmUkNXaDRSLzZzWkRTL0N6ZVRPeStiR1JSWlNTV0k2?=
 =?utf-8?B?Q2lzR2M4SnQxR0xLalpZQ3Q4RjVxVlBMMHQ0L2duOTFPRHpYNk5hVDc3YUNp?=
 =?utf-8?B?Y1F5Qm1ORkdneHovbTBPL3NzbEFqUnlmUWVKeDYxU3dqN241Tk51S25YcWtF?=
 =?utf-8?B?cnRBem5EMDZPOW9hck5wSENaRUgwa1I1YXhrVHdzcndvdFJZTzJsaGNqeTNR?=
 =?utf-8?B?Q3FYRFQ2NXJiUnlQcG4yUkFzUkdqRldTZzFzUkVqQnNycS9aaVpvazFxdEd0?=
 =?utf-8?B?akN6cVVHQnhvbFZvUytIamZpd2FONXFnRW83cWFObjI4dFRLbHF6emkzOWxL?=
 =?utf-8?B?eStyaTg5RFFsem9OSTM0V1FqdGVzVjljeTRoUWUzbkxLOTdqNUJQMmEyQ1JJ?=
 =?utf-8?B?Y0VUb0d1OU9HdVRHOXVXMHBrZ3Y4d0xJTXZJV2dJQWl1cUIvMGN0WUUxUitt?=
 =?utf-8?B?MkVleGdncTRFcytrL3RtMWwxWC9ZMFdiUmNycWdHL2d3cytRNEI3cHBCVmdi?=
 =?utf-8?B?S1lsY2tnYmFvVHVSYWVGb1kxclFJUUFabDBBMi9vSm1nNmwrZnFaUG5Uait5?=
 =?utf-8?B?YnZOSVBIYUNsZlVNVStsQUtNVmEzWGJjU3crNmVGMHdEbmpWeGEvQW5DU1JF?=
 =?utf-8?B?Ykk0WlBpT05FK3c2azJaWHlqTW1qOHVlUVNGZ0NEQmRqTU5teUpnRWtWYVYv?=
 =?utf-8?B?aWxuWDg5QTNJQ2FPY3lSTnp2UzdsdFlWT3F1NmpFY0kraHVFQ2JDQkdjYUR1?=
 =?utf-8?B?ZmJDcDE2WjNHUVhIZjR0aVY4MHJlQXkyZm1BclRzMjVIdXhUWWFqMWNBcHFK?=
 =?utf-8?B?NndjS3ByTU1MQVptYnhVaVFDd0xZank4blB5L0JqQ1lFT0grMk92UHhKY0pQ?=
 =?utf-8?B?VG5mNHdmSTR0WXRESGdnd2lnL0FSa25wTWxOUURZQmdyMWFiMFB4eFNkZHJw?=
 =?utf-8?B?Zi9xWUo5alNLTWFJdHpRQ3dvRVZJOXpNQTR1M0NUMTNRTitGN1dTWURPWitC?=
 =?utf-8?B?N2RGeTNZN1dvTkh4Z2k2aUZnTTVFeE5GdmF0d2JHV2Fab1hsak9JdHNTZ2Qy?=
 =?utf-8?B?SHh3VnptVzAvbjQrV2tOc3NtMHdBTUloVFJMMHhBRXdScjVWSTU0d0w0em5U?=
 =?utf-8?B?TTRFb1g0Wk8zUFhnM1psaUcrUmplNjFGbXo2elQxVXM3dTQ1QXhxRVJHM1Vs?=
 =?utf-8?B?OWRVL3VzRjRKTWx3VDNDNnVqaW9JUUVZTEU3cDdDQnJmcURzVmJCV0FQMkZE?=
 =?utf-8?B?K0hIKzlDOFlPQ09QMFJqSzFEWVk2K2VaT3NBTXZJYVpRbTkwV3NnWFpKV1NY?=
 =?utf-8?B?NlJkRTVIdG1VcGF5azNSMmRyMkN6RUhXdEgxOWJyWTBwUEZKQlJlRVJMYTRw?=
 =?utf-8?B?UDBiVlVhQ2dxSnMvMll5TGd2bjcyL043d0I5akF2Z2Q0QzI0U1MzNkxBeERM?=
 =?utf-8?B?NGd1SnEvWXZFbjJLT2dpUlZyeWY4V3g5UWZlVmFJYW1ocEIzdEJvM3hlWnhS?=
 =?utf-8?B?N0pVUVJVOXBkLys3Tm1keGM1MStVeUlaZldUU1dYVmZGaWxkU1VzWU8wbkhy?=
 =?utf-8?B?RCtIWkVFb3RMaldlblMwdmttUGs1Unhwa2xaclZHSWVXVUtlRVBDbU56dDIv?=
 =?utf-8?B?MDIyQ1gxRnNpQlF6blJ3aS83a3pKTTdPbThwZEV0QksvYk9KZFRNK2JyeHhq?=
 =?utf-8?B?V0ZUTTJZeis3OUptSkgxR1RYU2dpMlNyS3BaUFdhMEx2NWJvaFhhOW1QcUhW?=
 =?utf-8?B?RXo4MGJ0MVRUb3RDLzFJOGtnVE1KaGRabnRSNjBnaFVFOGdmaUxHWTNDYnA2?=
 =?utf-8?B?Z214NTZQWHIxbWhPaVFnN1lXa3JVV05MSHRTbnRXSzRhTEk3K2Z2ZW9HN3o1?=
 =?utf-8?B?a1JoOXZmNW1IUkRhV0JxUFNDd1F2U3RJa0gyQ0ltVjAxZnk5QVBwcGVZTU5X?=
 =?utf-8?B?cVRYb2IwNFhtMlNSZzlRUWdXb1ovMHdVblFkSHAxV1A4em1qc0duc3d2Q0sx?=
 =?utf-8?Q?L9VIaqPFG4HLo5xQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UJ8fYqezKewW5D/7VkcJDAWFUMT1U1VEFuRGGwW57VccFdQR7xcALoqjoJ9/dxQrhlKpz6yLgJjM29qkuJYDMVpGXzjp3txw+j5KDrdnTPJhK/+6ESb1m7NgyklBijvYWnSz2+JNNwQ7FGSTyS417V71afvrcrrsEgQYjLlZ0qlNvjIIl/xkTZoTz9aTI9vZDgas1JYeOhm9YETf65PqCmj9C2/RlMx7yPjEUgOskb+68AKs/2WU0032rXFa+t9VFisQMMjLCmE+GaMn9dHlqFzUVNZxA9PoG50SGZarvXKd48leUyjuGoU2N7drKbcJq0pf7r+TYB4k/I+4lxK3Og==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea6007a-f369-45f6-2bdf-08df29e03a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 10:45:13.2579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNIdGqgzq7rQGT/KiUWclkMcIQ+I/Yh+XCNgVkK6kG6nQfLE1fwqP6IA/DYA/WxpH2Lc5V+hXwwGDVzV+1acKf46IJ5//4+hK4ydOwHZ4U0=
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
YmplY3Q6IFtQQVRDSCBuZXQtbmV4dCB2MiAwMy8xMF0gbmV0L21seDVlOiBjaGVjayBmb3IgZmFp
bHVyZSB3aGVuDQo+IHB1bGxpbmcgdGhlIEV0aGVybmV0IGhlYWRlciBhZnRlciBYRFANCj4gDQo+
IFdoZW4gYW4gWERQIHByb2dyYW0gbGVhdmVzIGxlc3MgdGhhbiBFVEhfSExFTiBpbiB0aGUgbGlu
ZWFyIHBhcnQgb2YgYQ0KPiBtdWx0aS1idWZmZXIgcGFja2V0LCBtbHg1ZV9za2JfZnJvbV9jcWVf
bXB3cnFfbm9ubGluZWFyKCkgcHVsbHMgdGhlIHJlc3QNCj4gb2YgdGhlIEV0aGVybmV0IGhlYWRl
ciBpbiBmcm9tIHRoZSBmcmFncyB3aXRoIF9fcHNrYl9wdWxsX3RhaWwoKSBhbmQNCj4gaWdub3Jl
cyB0aGUgcmV0dXJuIHZhbHVlLiAgSWYgdGhhdCBwdWxsIGZhaWxzLCBldGhfdHlwZV90cmFucygp
IGxhdGVyDQo+IGZpbmRzIGxlc3MgdGhhbiBFVEhfSExFTiBpbiB0aGUgaGVhZCBhbmQgQlVHKClz
IGluIF9fc2tiX3B1bGwoKS4NCj4gDQo+IFVzZSBwc2tiX21heV9wdWxsKCkgaW5zdGVhZCBhbmQg
ZHJvcCB0aGUgcGFja2V0IGlmIGl0IGZhaWxzLiAgUHVsbGluZw0KPiBtaW4oRVRIX0hMRU4sIHNr
Yi0+bGVuKSBrZWVwcyB0b2RheSdzIGJlaGF2aW91ciBmb3IgYSBmcmFtZSBzaG9ydGVyIHRoYW4N
Cj4gYW4gRXRoZXJuZXQgaGVhZGVyLg0KPiANCj4gQXNzaXN0ZWQtYnk6IExMTQ0KPiBTaWduZWQt
b2ZmLWJ5OiBKb3NlZiBCYWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX3J4LmMgfCA5ICsrKysrKy0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUv
ZW5fcnguYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbl9y
eC5jDQo+IGluZGV4IGUzZjkxNWJlZWJlMS4uYjFlMWUzMGE3N2UyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fcnguYw0KPiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fcnguYw0KPiBAQCAtMjA2
MCw5ICsyMDYwLDEyIEBAIG1seDVlX3NrYl9mcm9tX2NxZV9tcHdycV9ub25saW5lYXIoc3RydWN0
DQo+IG1seDVlX3JxICpycSwgc3RydWN0IG1seDVlX21wd19pbmZvICp3DQo+ICAJCQkJcGFnZXAt
PmZyYWdzKys7DQo+ICAJCQl3aGlsZSAoKytwYWdlcCA8IGZyYWdfcGFnZSk7DQo+IA0KPiAtCQkJ
aWYgKGxlbiA8IEVUSF9ITEVOKQ0KPiAtCQkJCV9fcHNrYl9wdWxsX3RhaWwoc2tiLCBtaW4oRVRI
X0hMRU4gLSBsZW4sDQo+IC0JCQkJCQkJICBza2ItPmRhdGFfbGVuKSk7DQo+ICsJCQlpZiAobGVu
IDwgRVRIX0hMRU4gJiYNCj4gKwkJCSAgICAhcHNrYl9tYXlfcHVsbChza2IsIG1pbihFVEhfSExF
Tiwgc2tiLT5sZW4pKSkgew0KPiArCQkJCXJxLT5zdGF0cy0+YnVmZl9hbGxvY19lcnIrKzsNCj4g
KwkJCQlkZXZfa2ZyZWVfc2tiX2FueShza2IpOw0KPiArCQkJCXJldHVybiBOVUxMOw0KPiArCQkJ
fQ0KPiAgCQl9DQo+ICAJfSBlbHNlIHsNCj4gIAkJaWYgKHhkcF9idWZmX2hhc19mcmFncygmbXhi
dWYtPnhkcCkpIHsNCj4gDQo+IC0tDQo+IDIuNTUuMA0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRy
IExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=
