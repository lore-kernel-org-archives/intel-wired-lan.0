Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0562BCA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A611880BCD;
	Tue,  6 Oct 2026 01:46:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id duF5HZzcRYoK; Tue,  6 Oct 2026 01:46:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8E5EB80A9B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791251176;
	b=KHoXK45SoQU6DLIDzxhGXL2YcbQb3MzDvKdC3FDyOOFE9B4v/YuP3Qcs6derQj6kb6X5
	 PE+ZCL9j7dnOMP33mJECBp30wtZh8Nw2/N8T34B4kOe+d2gI1U9adOy/goP3RAszI/55x
	 7yqxTh0vf20bYTWXLbGOCP13kbX57o7/dxkT9BQUcU/foNY5MEDxeuqEnGLvTVtH3g2sx
	 u56logJC9pExLxv1aYwWT39u8tIoUt62vtCfhrJMEoElUfnNbPXnXIbMYhwkQ9KFjUE/N
	 kbAO0kxz4N3TaKgFJdY1zsz72/dOXCPp9rR2WNDZ4bla25fe1ErPRuDcHuuwX64zd4w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791251176;
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
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zHdiN2RLewLTiLuo+nwPiH2cynizmPFzl5M5juglmWE=;
	b=f91hWwm2bNKNLOk2DcbFD4IrmLOAP9qbuWSa4VTmGK3ntEhe0Ed8bWWdSqQMUmgGXmPZ
	 Fiw4FyXOZZ76VZDoAclvA4Ncq/UjsNC88nm7AS2NmX7HJVGSYNwf/fm2TFoYi+JJuop5w
	 lun5oSbezMRGhA/rXukpo8hFigo/+CvCaREO9yMRMgIs5U/XJX+6cabyDKmyJcMylRFEc
	 BAz5sOLNg2JrZSHh00r3P/Dzfp/gDjYc6uZszKnVMT/bvj05b9wGGQmY/7/u1G+TeC2PE
	 NSWfu88PheEKsKIqvq9djCi35z8gMhHjjyEWIm70E/e4GSpfcbAFx6YsxfQz2hMvyHA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791251176;
	bh=zHdiN2RLewLTiLuo+nwPiH2cynizmPFzl5M5juglmWE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z5r5maIULXI0d2FpLWUfWeFE5vUvHkSL387KJEyWzNXeYFH64i8UYy37R03ko9aal
	 JYH1FNCT0/DmDNchPtrLnXKO9r9EucKIJyIhTNHxouB6cemZSsk3bF5NGAtyaot16y
	 72HDrx4UtTpyt/+BEOqrS2wD3VsxkPPTci7qEadygbXNh3z0jeiR+pQSAANVeQp6bc
	 o+Y5Hin8bn/WInPPcWjLuez6dOdIAzqIWYEd9nh5mNdUC7LfjW5kLz9E+3QPNN3wzr
	 fJ5yOEQG6lVC13SIRoO1SZQ2n57qoJCNBBu7+ekq+iY1tGOo5GvNSoVgzXJHogq56B
	 yjTE3/NynXkDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E5EB80A9B;
	Tue,  6 Oct 2026 01:46:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC80C34E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D25C6402F3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VkTIyXM-UN2Q for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1BB5A403BD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791250975;
 b=Z5GMkZVWAZTBzLcysGr7Jz1qlBMEcV+KRke2I4HCcPHg5katDl0yfhx5TOn3kOEul3l0
 qRTnTworj0XtYOH3ugQI/mrKrbAk0YopAuA/Lp69MaUrAyXOgDe63EUrKJnzr1Na9iEWK
 HTVxqmwXl2vHPrljApRUyk7r60eo+LrwJAoH1Djv5mlY72xZqOrVDl52SH0RDAI2Zrm3h
 RJCeqeGR6+mQ4y6Pc3KUppy7LgL8RiFxxoRuZxFWvmnS80ddwHx28U3S+cZLH3/ksJ11t
 TrMBDFKAQQHf1mNJyx5fpVtZdf+vcOT99bNimZi8ywdWtra+LG8vcNEInD7fnvdUTUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791250975;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=zHdiN2RLewLTiLuo+nwPiH2cynizmPFzl5M5juglmWE=;
 b=p1N7zZieI46GVdqEZ7PMEjpR6qGemiIrTtLhIH3cOn6BSldlWr7/3o5JtZu14Bj4zexP
 bAfUPKhToh7dQgVPH9bD8DmvHCRvRveEjXq4YXYl3hApYFg4sH2L4PFiQdimFVtna7416
 yy80hV1wsO1lAAwPhoeiGZurBMuHhmsaVR5Of6ePP6C1EWvX4cQ8Ap0BhcdbVCfblXnx2
 unal7BpgZYnlkb4UMk5kHKn/nbqX9oApWa+TDIrBWQXMkw2P9rW3Me/uAM2YKZs9ZA5U/
 Bv+tjYRY0ksds6q4Dm3f5dr1iWNE84jCIcAcCYJus2nmIegKIq9NFu7GdeeSGsIqjjQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eE1CSEvS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eE1CSEvS
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1BB5A403BD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791250975; x=1822786975;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zHdiN2RLewLTiLuo+nwPiH2cynizmPFzl5M5juglmWE=;
 b=eE1CSEvSHvaH300S9TYB24HBcvw30O7t5teOzsQd3FPwVIgUZnvWMFZs
 wjhhzVfK5DVnXhekfwhl3eVxmg6QH09dRS0RR3UneDv4U5jIFaNzg1SBK
 YRWR0gBSx9C/oUgYWax4ZGqcdDqiPQx3kGkKmXzkRhEloj0INlwgy2Te+
 /WSySXAcBwCuUINdgX2fiIqP5UIi3POP8PIW8ZJeMnMt7HAwDraCZXrgU
 Cc9/tnyi83KwgYGD3MsukiLSElRmZNRNc0ue2qtqq1k5yuLOfYsIGdYIS
 J13+hlR4MKIeb4d2Qo2U+pOkfGW4WA/fzW3LXe9wWEu1ppXuWaFngztu+ w==;
X-CSE-ConnectionGUID: +OqmBaK1TN6vggQiXp7GJQ==
X-CSE-MsgGUID: lsuEuqR+SnuZc+8pmirkUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91067081"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="91067081"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:42:54 -0700
X-CSE-ConnectionGUID: RbV2+I1GRGS8xRnWDmJA0g==
X-CSE-MsgGUID: F+8ykHObTs+TOZHy8qC11Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="273372910"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:42:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:42:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:42:53 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:42:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMoPcrb/TSGLJ2n8xiI7yXyJNnNlLojC6MXJ68tWMXL0QalCDMOi4SJHCvjfysP1kYAD5wZY0XB8oiRQPPyJNpemUNY1Wyk6dBvjntduYK4iTGe1nss5NUGO6kkeOkAMZnIp18djV+QqWfHslVIouubCSx8rE3ut4np/yArp8RhBZA8se4iIg2hWJZqDvmvKe4u6EEdABUscFTjMw6ATgrm1O347VHDh2Vv4M7JWZ56LvjyRf1H0ksuU31LCMAmeJ6vwY/7iZEe51rUCZTj4/aWDxYQcNsBU7BcmN6h7+CRssSdXkqsX6AHLpX7CxTMSvmQvyhatgqCiiEpCDDPCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHdiN2RLewLTiLuo+nwPiH2cynizmPFzl5M5juglmWE=;
 b=a3dX/wkhLAdWc604rcrPtYr9MlWQL8n1ov6L9W9c9aJiQy8aJdQbc4LsY3wkSJFdRNTSCUcEQFvj9unXVRheneCyt2wAobZEVK0fwT1OWnZirdE+WLoGnTumJIQKt3kXcXnyVh/y/23USv24XTD9lTf2jftOxdGnRYU9nV0NrFVP8Fy554WbsJfOhQN53mjcRyi9HpQcAkmgnb5mTXvdY5P8iCHT3YZpX5zXgaJKBWHZlviPOaojGVPGu+JC86PtL2rXz8wWXCY2Zo1jSU21hx/gvXaO97i5nQLvApqmSVOc43db0hvPEtT8VRmNagOhl+0oDcDrBcW46F1hSG0e5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:42:50 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:42:50 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Oros, Petr"
 <poros@redhat.com>, "Machnikowski, Maciej" <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v3 11/15] ice: wait for in-flight Tx timestamps
 before flushing the tracker
Thread-Topic: [PATCH iwl-net v3 11/15] ice: wait for in-flight Tx timestamps
 before flushing the tracker
Thread-Index: AQHdTUnF8TAx1UfNjEimFdXdcpaR7rbvzU5w
Date: Tue, 6 Oct 2026 01:42:50 +0000
Message-ID: <LV1PR11MB87903B2D50A1561AE59946B290952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-11-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-11-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW5PR11MB5907:EE_
x-ms-office365-filtering-correlation-id: 1037f513-0ded-4efe-6a9c-08df234b21a7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|10067099003|921020|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: uX2XaKpVHlyPNTudF+p/9xlZ3pw/lWOAkvbp8TWLoIdOz7GP1Pl+/uQhwVmR4l2OXTaMrUGwR7n92rbF5Cyl7KtJbYxgdF/9hGx2E7gJMyDTRhXu3zGBX5EgQbyYaIu8mlxyLhgREx8+n+QPQw6B3+XFBwG14C/eyp5cje8eTUAkox08+tACD2lIJd2ZcjZAQdyesnqWG57134/WLOnbVO/JCXhKw8/UMQnAJ7ceOkkhwe/NDAXDDBvU/DfnwlXHDmICMRJ/VHd09yQMiErCU+aKqehew4C8GWosuAgTWapl9hztnLXzxSzhl9z+H3KtPmmyWGF6EmWb7Qf9JAnZTxAB0uKod7GXIr6PlFNL1/yjjDinmDjy37N81/ELs5xbXZxCA8C8ySRGI9syuw2mlFpJ/+YfTAcZc/+L8EjJ7tWaEeBKKp7kuMZ0keWn0JXdtUZczyu5/yWG2XC8wgqZiy5/OI8hjbPWk3xOZUkTpFmYFoP7i6+tDybVWaRCBluXRhGkJxilfAOUw/S06lrTZ/h98qWJYI0VGp/1aMpO7ltQu4X83ZizkDoa6q7M7vqKZt002gnfM+gQKYS0yx4XiBgUxIt8ONUxxR3GQmZ6rsSI1X3nDPAmunnrr2BUsKDFtbCVTE9X0N2cDJQ5iZmomTIZF4VtnJPlfB7YO4z4jApEAnhxBYD3CfZGLntxqsIFhSQZl8aBq95hYMSLVFhyQWicsrpLBsMb7WidCVabTl8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk1OQmthakpTTy9hZzVjM0xPVDQ3aDFlV0Y0RW0xSjJ5OHdGVzFtcjRGVGZi?=
 =?utf-8?B?WW12djAvL1c2ZHdvSk9weVJxZjFBdGtsMWUyaGRtQk5kQ21ldlorQVZVTGJU?=
 =?utf-8?B?cHBiQUp1cGw1ZTlQUTVzZlZ6Tmd6ZTBibklZZERxRW1ZcEtqcEF3aUNWa3Js?=
 =?utf-8?B?eTRYbzlxRW5VQkNRT1VYaUlPQWJTdkxUc0dpVmlkVGZLckVzdjRSM09tKy9F?=
 =?utf-8?B?cWxSOERyekVkcCs2TnZadk1Tc29BSlBDQjIxU0dJOFhWRDBQdldySm9qMTVP?=
 =?utf-8?B?VUR0bloyQmtmdjZSdFFPZEI5OExTL1FGRzVrQ2ZJc2VnV3ZJVTM0UVExMWFq?=
 =?utf-8?B?OTNjajlldlI0cjZFc0VMaU05UysxT1ZkZkM1d3NZWStjRWh2Zy9aYlZEb0pV?=
 =?utf-8?B?ZUhMeDg1cFhnc2Y1R3ZWOXFrejNXN0EzZWgyWlFMaGpJRkFOK2NDQnZOUG9v?=
 =?utf-8?B?dU1iMEI4UjNtd1ZKUzRablFUVjZ1U0wzcDc3VlN4ck5NaFh6SmdxTVBQbHdP?=
 =?utf-8?B?QkpRN2RVZHZnNkowTzQydEVKTTlZSTF0cU5rbnhYbko4WGpTQUJMaEthb2dq?=
 =?utf-8?B?MVl5anhBa00xNkFYN3F5dGRZMlZzRy81Z3grdDBaY3V1TUFnTnpPc1JwTFZF?=
 =?utf-8?B?SHM4a0dNYWJYUHUwaTl0eSsrSUh6bmV0UGpCNnRxd0pNc3hLN2NmdnJSY2Zz?=
 =?utf-8?B?SkRPTEpFMkxNelIwaWM4ZjlkT0R0M2R3L1dDSnNEcDcrb01PRXQwcUtpdnMx?=
 =?utf-8?B?bHhIdi9qZnFhMXdpSXZ3QjdjMVNTTW5jOGFGb05RbXp2ZUpHR3Rzb2k3Mk0r?=
 =?utf-8?B?NmdpMW9tZnk1S3ZCL1k4TGxKdUE1MkM2UmVzTE9iLzRWZjQ2RmJHazFxR3Jy?=
 =?utf-8?B?T28zdUMwT01IK3JEMHcwTFZrSXI2ZFc4UjFYQXd2SytFWkJ2WDlxU3BQZWUr?=
 =?utf-8?B?dlVFNTQxYW1GTWxjM3puUEJWc3duV3RyZlNpd0RMb2E3Ykl4ODZDMnh1azh1?=
 =?utf-8?B?V284QzZuc2pHVFZ0YXFyQVdRVlJ5TE1IczdwVzV2NG9GTkEvY0g1NjdhOWVE?=
 =?utf-8?B?bHVBOWxjSHFPZGpPOVVvcWl3QzBTUGtUaHFlSzFSZWNOSTJsa3dJZlRLWk05?=
 =?utf-8?B?TmRSVnZUdS9DK0ZqRElHWUxkR2daNUpSSzlEaUh3cGtCTVpuaUNsZTJMWGV3?=
 =?utf-8?B?MVZ1Y1N3U05yQ2g3N3ZJY3VKeVNFV2ZLSm01YnMxeFprWklMbFNZR045ZHEr?=
 =?utf-8?B?RTg0a0xac3UvNGIwYXpHYTRCeTFybGF1LzQveU9PL3ZkR0d6MnQzVjNlbytv?=
 =?utf-8?B?VklPRDMxZzhqMGY3ZEtYa0ZUbHEyOXlsVFloSkpBbmU5dDhqdE0weUIrc2px?=
 =?utf-8?B?R2h5UGZPZnZMNmpJTzJGUUQ1ckkrRnVBMGlBSnlDczZ2eW0rT3BzL3c5azZo?=
 =?utf-8?B?SXhpVGRpMDE5TUJwQ1gxZjBOZVFsM01PUFhpY1JqQ3NwdUlRc09zYUxTS0FO?=
 =?utf-8?B?TTltbk1pb0hQWUs4TGlhcWJaYk4zNUFvbzYwZW84TDQ3a2hDY1J1emFkc1pj?=
 =?utf-8?B?OExvSStaZXVvd0lNV0o3ZFlyY0wwSWY1L0pDZkhiLzhxb0VDZTFuLzlZMFp3?=
 =?utf-8?B?S25rbEI0OVJGeG1ra0FJY2lnTXV4UytvQ3FOZWkvYm93MnVtQ3dJakVEOXNS?=
 =?utf-8?B?RjNQTVJOeTNQcnhTeHNsRGtadHBDQXFGUkltNTFDcVpwdEx3QmFWZnBRSzI0?=
 =?utf-8?B?ck5CdlpNcDB5WnZYQit0VjNGcXhpZWlDMGJ1VjZBMkdQQWtDT1lvL3FOcGlY?=
 =?utf-8?B?cFRPY0pUNkVGRHdnK010OTNsZXc2aHVic2F4emttS25OOFByeitIZElOUE5i?=
 =?utf-8?B?SU4xYkFrM2FiRkhvdW41VGUydUlSTlhyNVltaGUyOXFQNmlEREQ3bzZscXB1?=
 =?utf-8?B?bUUvNjRYZE9mUVBHWmhMbmlnV2FDSU9RSTY1NDUxT2xtYW44bzRGcVV3b2tN?=
 =?utf-8?B?NTZQL3lIVDk0RDh2eENsTDhhQjNoM3dzbEV3QkNhV2lQaytqM05xSHorVmMr?=
 =?utf-8?B?d1ZhVTZqWnN3ZkdOSDFCV1M0QnJkTDNaTlB0T05OaEtqWUVseUZEYjc1OTE3?=
 =?utf-8?B?T0hjditMUzdSMHhoWmdLWEExcnFoMW1oZll6VEJJbklRUE1MQjFpWGdQdjg5?=
 =?utf-8?B?eHNEUFdIcTdDeU0zT2JzNmoxMkc4dVVUUzlNM3ZCQnFEU055UngwR0sxaUN4?=
 =?utf-8?B?YjVJS2dpc1MvNkN1ZEF0MTMwemJnWFZPc3ZvSGRlaURrMDZRQ2ZFNGNwS1Rv?=
 =?utf-8?B?cHhxMDluTVBIaGhXSGhaRDZ0S052MTQ5Yit0QVE5L1o5ZFkvSnI5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D1cs1bYsEhmGfC0bjEiTlTWgt7yDnfkLdLB7VPxLF+bl+nON7MFNdO87R6iSA1sbbwKrQLcrOtDixgNuudfnvCz6/04y70W8mAqx/bFSOHoipy+aiqIMcwrLdv+5gQiq+2BCweOSpy2kCPy2gRQE4meSFiiQWTpvXQADTyLWUQcp71nufKmjingR8Q4CqAJqGASS0td4JQHPucMesr9vsApRIqZdRdupb1zaU6ql0KY/2oHPdG4EeamGz2Tqwdkt3t1uokl8hUgFpIe0Sv82nICo0p7tyx7JVTeY//Qgjs8OJI80PZqXAl78atS/0GnJKZ+0apLu4CpthHg/k8J4KQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1037f513-0ded-4efe-6a9c-08df234b21a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:42:50.3747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/2BAkQcvjjxpULUAirPd5PbNThqAZTXqq8FxSn/WrU4NihbuxsJEfqfl4vIf+Bb2sbGWxgd1TCo+Ld35+d7LV12EVTt5aYZJbrqvDkTTTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5907
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWNvYiBLZWxsZXIgPGphY29i
LmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI1LCAyMDI2
IDQ6NTcgUE0NCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9z
dW9zbC5vcmc+OyBNYWNobmlrb3dza2ksIE1hY2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRl
bC5jb20+OyBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IEtvcmJh
LCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtvcmJhQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9u
eSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IE5pdGthLCBHcnplZ29yeiA8Z3J6ZWdv
cnoubml0a2FAaW50ZWwuY29tPjsgS3ViYWxld3NraSwgQXJrYWRpdXN6IDxhcmthZGl1c3oua3Vi
YWxld3NraUBpbnRlbC5jb20+DQo+IENjOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVy
QGludGVsLmNvbT47IE9yb3MsIFBldHIgPHBvcm9zQHJlZGhhdC5jb20+OyBNYWNobmlrb3dza2ks
IE1hY2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SCBpd2wtbmV0IHYzIDExLzE1XSBpY2U6IHdhaXQgZm9yIGluLWZsaWdodCBUeCB0aW1lc3RhbXBz
IGJlZm9yZSBmbHVzaGluZyB0aGUgdHJhY2tlcg0KPiANCj4gRnJvbTogUGV0ciBPcm9zIDxwb3Jv
c0ByZWRoYXQuY29tPg0KPiANCj4gaWNlX3B0cF9mbHVzaF90eF90cmFja2VyKCkgZnJlZXMgZXZl
cnkgdHJhY2tlZCByZXF1ZXN0LCBidXQgYSByZXF1ZXN0IHdob3NlIHRpbWVzdGFtcCBpcyBzdGls
bCBiZWluZyBjYXB0dXJlZCBieSB0aGUgUEhZIGF0IHRoYXQgbW9tZW50IGlzIGZyZWVkIHdpdGhv
dXQgdG91Y2hpbmcgdGhlIFBIWSBlbnRyeS4gVGhlIHJlYWR5IGJpdCBwdWJsaXNoZWQgc2hvcnRs
eSBhZnRlciBoYXMgbm8gdHJhY2tlZCBvd25lciwgYW5kIHRoZSBQSFkgZG9lcyBub3QgcmFpc2Ug
YW5vdGhlciBUeCB0aW1lc3RhbXAgaW50ZXJydXB0IHVudGlsIGV2ZXJ5IG91dHN0YW5kaW5nIHJl
YWR5IGJpdCBpcyByZWFkLCBzbyBkZWxpdmVyeSBmb3IgdGhlIHdob2xlIHF1YWQgZGVncmFkZXMg
dG8gdGhlIHBlcmlvZGljIHdvcmsuDQo+IA0KPiBXYWl0IHVwIHRvIDEwIG1zIChwZXIgcG9ydCkg
Zm9yIGluLWZsaWdodCBjYXB0dXJlcyB0byBwdWJsaXNoIHRoZWlyIHJlYWR5IGJpdHMgYmVmb3Jl
IGZsdXNoaW5nLCBzbyB0aGUgZmx1c2ggY2xlYXJzIHRoZW0gdG9nZXRoZXIgd2l0aCB0aGUgcmVz
dC4NCj4gDQo+IE5vdGUgdGhhdCB0aGUgaWNlX3B0cF9mbHVzaF90eF90cmFja2VyKCkgZnVuY3Rp
b24gd2FzIGludHJvZHVjZWQgYWxvbmcgd2l0aCB0aGUgb3JpZ2luYWwgRTgxMCBzdXBwb3J0LCBi
dXQgdGhhdCBkZXZpY2UgZG9lcyBub3QgaGF2ZSBhIHJlYWR5IGJpdG1hcC4NCj4gT25seSBsYXRl
ciBkZXZpY2VzIChFODIyLCBFODI1LCBFODMwKSBoYXZlIHRoZSBiaXRtYXAgYW5kIHBvdGVudGlh
bCBpc3N1ZXMgd2l0aCBpbnRlcm5hbCB0cmFja2luZy4gVGh1cywgc2tpcCB0aGUgd2FpdCBmb3Ig
RTgxMCBieSBjaGVja2luZyB0aGUNCj4gdHgtPmhhc19yZWFkeV9iaXRtYXAgZmxhZy4NCj4gDQo+
IEZpeGVzOiAxMGU0YjRhM2EzZTEgKCJpY2U6IGNoZWNrIFR4IHRpbWVzdGFtcCBtZW1vcnkgcmVn
aXN0ZXIgZm9yIHJlYWR5IHRpbWVzdGFtcHMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIE9yb3Mg
PHBvcm9zQHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBNYWNpZWsgTWFjaG5pa293c2tpIDxt
YWNpZWoubWFjaG5pa293c2tpQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgS2Vs
bGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyB8IDY0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQ0KDQpUZXN0ZWQtYnk6
IEFsZXhhbmRlciBOb3dsaW4gPGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPg0K
