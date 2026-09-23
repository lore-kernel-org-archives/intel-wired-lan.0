Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE21C982EA
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Sep 2026 09:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 276B380BE8;
	Wed, 23 Sep 2026 09:42:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lFoy7_KZ7Rhk; Wed, 23 Sep 2026 09:41:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2F92A80906
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790156518;
	b=DNNdGDlWjdVdEcVOtVMOnM7BrWcdEkAgJgg91dFcLo7OH53oCEtnkmZNXOBZxsfKJO5k
	 pQIw+2n3AFQsKFXyMJJa65BHmY3hVyje7Ip0gRStGiz/wCoiqBWLVat1lJHLf4MAa7if1
	 fP2kBpk+Ul/5wxdAyzHDA0UtvkoN9wQTXzQsCRQ2HU1P9/RTH99XFbrRA8Fud8VHihaAA
	 m01x2x3akRT1o+D9G+ZypXnpz9a4ZYvzxkuvCp9WgyteuB5RHiDcYu4BHSDwHS6HUd9Ok
	 huCfVbj+jJWzL0AT2VI/yJ9W3R7wFy2P8U2PF/lI6BVlhxcT5Ol/hatsHKzzFDR3mtw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790156518;
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
	bh=2Elcp07LbyUXBSXXB12NxnqpVtC1/PQagu7kLRrUEck=;
	b=k+pJ0UoABwymUneqvaxukUJ/6FznwT9nBHQaipr75HURVbxv6PiaPw5ej27/ptOBx0JF
	 WhcGkNKQDbqnYoDfNi2rE8IvxmFzZRQ73ikyxlG+NEu8VTfwX4Rclk7vdgOzozdYBMIxg
	 FbooLFlrI/ho6xtml9UD5R7VtHetnO6YD4gJmjPE8PX+kGbEVopYlKE+KIT1MHf6QhR7v
	 BqLLa6LhyuOPKi/mPABFp/ckvbwmc1bEXuwcyHlZSV5xdKU3WnKlvqeBsgtJM/A9U1/6A
	 c+fZ13PS3XZefWSDGBGD04VE2YxFgKNl1pB0mg/Emc/fMfzgjnEUu8suwrjTO9fYqDw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790156518;
	bh=2Elcp07LbyUXBSXXB12NxnqpVtC1/PQagu7kLRrUEck=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=39ACs/568BnxlX7I0TapOlhkQgfLAGUZdSv7Rl0v2ZY0z2ruVmm1OUVqfPi4yTTh3
	 252ngCXXWG6RUjR785a2PAN1nwE9g/LbMhEUmuW3JpseTVV+pKikDe711MQpnI6Sl/
	 8Xuu2+E+/lqYAzytBcSzk4Z82SBU9lgYqWz9/CM3rikzQLmL+NvGkSh0R0hbKrV0Wz
	 tvwnlXfmnv1u090SKGsDpgtkV7Ce10j+bNs1QXil95IyE/gHHPDyMR+ETbc6gX9JvE
	 tybhGxl4yQWOnxjTu022qvw/mDpoCR2aHW5Mnadvm9V5L6+mGt8ylzwODOZ/hHQIAi
	 1NdTiEfJD1BPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F92A80906;
	Wed, 23 Sep 2026 09:41:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1546355
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 09:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B293260661
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 09:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mSQrjVZhH834 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Sep 2026 09:41:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C45BA60607
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790156513;
 b=ghVo5HROPX3cSGaaNMmEOBOl+RDF1ttQNVBPYi8NcWI604YiRMQioGyWQuGIVLVUhD30
 qUxqYqwh5YSw1I8clShKX9IFcDwUj4cO8lYjX13cpwBCKHlMzDE3fyfDLmBougMJ1A3/j
 iXTWQFWJTqmKA4+a7UrKEDvy5pdqXRNHQ5oGZ3Sb0EnB97ThE+bIudgLVPYZaQLu19oKg
 JOJbFZ3kToZbBRwdbnA78pzYZYP/vtiNcVLdrfwDSv/aCF0Z+MFzHyqfA3XYGHzXd9AtG
 qHdH0x6a5yLGgv72at1gu/fQSQi4m0mbEmdRjN1xK1nP+Mn73EPfESCKksa6CafD3LQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790156513;
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
 bh=2Elcp07LbyUXBSXXB12NxnqpVtC1/PQagu7kLRrUEck=;
 b=e3x4zw1UIHD9aua+95NKXvYHoxr/l6xtKnUg222pBuY5qXA+vT4ajkLSP7KNMEDkt8+E
 cMT+eS9E9UaR3k/pu6IHxu9y78UKwhkhhAdOU19See/aifp9Opc2L8JLrQVOfgwctzDo9
 ZfjZBPKxIpyeDihaPRvcEmGwfvyaVMkStEld2ZzHNK8xar1cKnrtQ6qLjf38LLaDUedyb
 6YSbqtso8U4AZC4epBLvLHnvk3BinxQK/AwVc9NFGapFvQDFfwtomE2D4TqO7bqPQy3gn
 KgOwdUrNxRu4YJhTBMqpeMvxdXFCRdtXEVQC0l+0+xTXRNf/dUfx0rUQdBBP/lUGHTg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Cr3ZX8BB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Cr3ZX8BB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C45BA60607
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790156514; x=1821692514;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2Elcp07LbyUXBSXXB12NxnqpVtC1/PQagu7kLRrUEck=;
 b=Cr3ZX8BB8WeNvJzKK33oIs9nW16CRZtvLXMJHHnIrtqZdfA7ZUoAghfG
 /yHmH8ympkCz9a4whJcy4VNYv0ICbjBaIH0VYRAmuu46+p8dWvbOeBgoc
 CjtlfoqcPdbaZndd1psBROj5FEjSTg+QEUbUpa2bpyA6Hxlf7WqCAkk2Y
 YtbcxBFniPwCcZX/nlSoZyetowNYXjAwcN++A/s3uiXfMKW3P9jVLkvCT
 xiV4C4SmhW6kM3muvIJmlnCLnyYYqyhewEX988doIzWEoJhRCXVbe7hN1
 sUd3Of3R2d91EQRprDUycnULiNtTweQXxcLA97XydwIKRawBCVpl+dxA+ g==;
X-CSE-ConnectionGUID: D0k9u33TS7eYM2nUWYxeCQ==
X-CSE-MsgGUID: kEaB4k9UTJmchvyc8MM4Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101494245"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="101494245"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 02:41:53 -0700
X-CSE-ConnectionGUID: Pa3QjUfUSXGu5j1wNC0Prg==
X-CSE-MsgGUID: CujV8R/PR6qQuJJKrICrIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="273018558"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 02:41:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 02:41:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 02:41:52 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 02:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avIIqxXh+vH3etsUqPKsHS8cGvnpQqkS69JGclS4TpP3sXJ4TMA/uspMeKItf4tfILaeU8gpLVKNi4zeAC9lUB8+QpTOrzfvBhCATNCNfo2ZAHQiU7huMnsPgX/PXFDgADKU/cejvhKCRSJzMRp4NwNH8rb0FJKI71/KRA9mRN/NxqYE6mnzpunW7WB2FIZV9KLnbXJFwQoqEX+tGJzO4qR6i4iEB+CabTyniPmWWVQJYjkCLFarrzs/zjiUdjLAJziW4NB66tCZy9WBtR6HAS282ydh3JhoUeMp4klxA6TZy+JBtQ3UZ6t5sBIet7Fx7H9luW5t5dQxsz6FdEKM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Elcp07LbyUXBSXXB12NxnqpVtC1/PQagu7kLRrUEck=;
 b=PdbN8Ad6g81/IMAN1M9IWsjLDRjZA44X7tTWHeUYJz4kJ6HppYTUvSjbywyBWg1489CSSUcZnwNiJHCfrL3JzU9AHQ0nbcejimDsvzqm9rBW+gDYNYDislNIm512Lzzudghf6UWpvfNXsfK6Am8uREHc4wiOIuUO6+TMkn237jJTtvb4ue1fJKnTFyyXW3Q57upQpiEZL4SoBpsW8SrCePuPur06yRgL074ApkZ8ZhQF3jC1h+7HMIT9onvVAYMnq8yL2zw5NtGkPoakqgsSI9WJjRKZndvARdjnmkR3CKj+7TP1YHDxT5QHTzRY4MhsfWVqlnRruyYKhkvkctE5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA0PR11MB4733.namprd11.prod.outlook.com (2603:10b6:806:9a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 23 Sep
 2026 09:41:32 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 09:41:32 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v2 09/15] ice: E825: clear
 PHY_REG_TX_MEMORY_STATUS prior to soft reset
Thread-Topic: [PATCH iwl-net v2 09/15] ice: E825: clear
 PHY_REG_TX_MEMORY_STATUS prior to soft reset
Thread-Index: AQHdSr10rzE/jPNIAkyGKlTn+dTI47bb6YtA
Date: Wed, 23 Sep 2026 09:41:32 +0000
Message-ID: <IA3PR11MB89863DAB7CAB1ADFE4BD0AADE5822@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
 <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-9-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-9-e55b692d0e6b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA0PR11MB4733:EE_
x-ms-office365-filtering-correlation-id: 2537f22d-6228-4026-3ec1-08df1956d9ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|6133799003|10067099003|4143699003|921020|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: xhudb/ZKp1AbBcmhEuur5kY1M1rqkPbLq3Wh7kAeb0RHvL4K/KfeATRkrJSz1PXcVoAZ0TWAQKf7cPgg7e0f2WTWqNWw8k2LyX+EqhRluqA51pcwiXbwvq1EVIOP67zwPB4aX3zYLPkFFRtTmQm8dTMnyN1Ba3/6+PvM/kVa38OwPxiJFWFT9eQsoauPVAjF0BJeqC+nm4h2z1kAnerb9xZ05sn4Hns62FEYFrwMCLsXyugnO7r+1yjw5ND6IZ4VlQZMvGI+VfjKLL10dK+6NuiYh/QsjXO4mdMGcRdb4Vte+cuHep3z5NCaKDi0bQhCVR35Af9aFUICMuncxOPes9/HQK4NZax1neGe8EYYigOqpPQuEnfITWCnZpKEm17uxdNRCbr3ZQV1s+T9FL9kLNEExdsaYLMHXPTAnCGJT4l0C4NDyuAziVCmxHh9H5IWlrLgRRZSfnVU+q8UGohXzHo5YpspLtcKJPiyuSvW5VOICovt5ojKOvepEt2d3BJ+OOcW3g93/4YcqKB9+h9v+kcjKliJicRjhCUi9ko4ZvIAz6nE7KqTJs4pwo6mJfqIzwzgB6mPANqE3dXFR0F2a+BnejosUUAG42RpR+6TN35SiQd1XrPrMWRXhvNLndFEhlA2MvpZIzHLZ8HZQEC3XJQ42fBLb3b631xcVX4jGdurPt7lDhkI35GE6DV+X+io24IKdYb5e8lbMR9sPtobvgs7YVWbNXqW4dDjSUoMu1MD2Iy2E7hWujVCG8K0QRLn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(921020)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVJZQ0JWUXk5VGNBbDVPMDBocTNHZ3dKOEdkNmY1ZDF2Q2VsWmZ4eVZXTnhG?=
 =?utf-8?B?MXBiVVF0Ny9EQlEvbEJiSmhTTWtZdkxYT1RNV0dxUlJKRTUwSm94ck85WnNM?=
 =?utf-8?B?VzNYMVJXdTFJeU9tZ2Q3MGxIMFFuTlBWN25PR24xUWIva1hOVlVrWUR3YTNN?=
 =?utf-8?B?QU0weWNqa1pWb0Z6WjdSZzh6T2JWOVpwUVZwMUlpOFhaS3lEem1CTEdLSUhO?=
 =?utf-8?B?N3Z4d0lIamprSmpNaVB1MUR2WmxGZlVsTzFvU0x5QzBLcFVJMWU2MVJPNEQ1?=
 =?utf-8?B?ZDlPOW1mQWRFak5TdGlvUWRPb3lxR05uVytVQ1pNQ0RuOFFBNXdtY2ZZc0Y0?=
 =?utf-8?B?OHZPTlBVMjg1VUJKbkJrYVRybUJFWVpPQnZUSExITWwyeitZeGFNV2JHSDIz?=
 =?utf-8?B?aXQ5S3J0Zm96UUJOUVFSNHhGNzdTeXpjSmlGWkZNYThONDRwUm1yY1BqM24r?=
 =?utf-8?B?RlRVcmxBaHYxaFpiYXlJc0VlQUcxTDZDTE44bU9HQkhHblM5TG9ycTNoVHRE?=
 =?utf-8?B?NEpQa0MrMUdGWHJmaytrRmMzTk5qZkd5dGNDNlNuNWgwbjY5NDZSM1gzcElO?=
 =?utf-8?B?WlZMYTBKNU1aa0dTOEIxZ2xOdzJFclllWTd1VHJjV3J0Zk9lVnpod1VSbXlq?=
 =?utf-8?B?Mk5Tc3RNS01NbmF2KzlWbkU3WXZadjkvZEtYQjdabU1EME5iaDdzSC92anBa?=
 =?utf-8?B?ZEhRSkVkM3M3eFBsOTEyNGE1VVFVMXQrK0xqN2ZDSnlMZFZDWkxBZmt1NUdP?=
 =?utf-8?B?NkVXVGVBa0RHNGVLU3Q4SUFIY2NteXNnUHJwTCtHV2tPWDlub2F1YmYvTDIy?=
 =?utf-8?B?U3ZuMDFBSTlCTC94MFNvbFBiWWFRTFpoSTQ3RG96RWEzWkFieWRCbXYwZHgr?=
 =?utf-8?B?RzBKZG9KYlBBS2hKR0MvRG9MUFBSM2ZJYW13WWNGQ0ZRQUVZVm0rdEJibHpQ?=
 =?utf-8?B?clJUVTRNT0lkZVR6QXpxRkUyWldFdkZjM2RRa0ladEZBc1RvNGxUOXpWdHp1?=
 =?utf-8?B?S1E1OVZFVGtVRDQweWF0V3dzMjFhM3c0VE1EeDFVd3lkRnd3cnNlRWNIdkpJ?=
 =?utf-8?B?eVE2VGhpSXNZa1hWWkVUbURzaEtjaXZVckxKUUZTYjF2THhYTjlxUlJldFR2?=
 =?utf-8?B?dHdGZ0c2TmJLZWdJQXNJOGlnaDRjTFVkdEtkaEpQaitwdkltUkFtN2ptbjFv?=
 =?utf-8?B?UDJIcFFaYTNmc2diUjd3YmlOZ1UrTE1SYXFDY0swZVM4bEhBNWNKR1BSZjFK?=
 =?utf-8?B?NjZlNzhsMEh4Q0cycVJSTnpzd2cwYjF6NVJtQTVpZG5ISkhqSENZNWpBcUFI?=
 =?utf-8?B?Ulk0cEs5VWxnYzFUa3hXRTZlSVNJc3ptWFZTbzhqWWRRRmFhdUorcHZ4V2Vh?=
 =?utf-8?B?VVJ5Rk56bVU3OEdRclc3dVMyeHdlRUpTeW1sN0Zvb1RsbEU5bHY4KzduQ3dj?=
 =?utf-8?B?Y2gvRmdjSXFPT2xaYVdReVc4aDRtNHB4aWJJTGdKNTJEbTZYYzRFNWY1Q1F4?=
 =?utf-8?B?YUVHWk41NHVDT1A5b3d6THlxbytqcm9sTHlQWGQyR3B4Sk1CWDNzbGtmZ2F3?=
 =?utf-8?B?eFh5WFJuT2x6NUppSUg0N0pDQjdSdjNMSVdoM05QK0dtVnJuRHZ2UmRjWW0w?=
 =?utf-8?B?V0pVR0JIQ2xKNmh6NEh6Q2tjeW4xRG1MOHAxYkxFYS8wbXlaZzUySWdQclY0?=
 =?utf-8?B?N1RoNnhXdXl1YjROQVFLdVRlMjJlQ1cxVXFkcWZHc0M5SS9nVWJiMmR6OEo5?=
 =?utf-8?B?WEZlL3NjaWkxNFgwbmlhQ09NaHBuUHVGd29JRjNHOVUrVFRCMmo4Vi8vZi9E?=
 =?utf-8?B?MGx6WUdvS1JkbmhIVER2Rjg3cmczYThOWjcyU094ZElFck5LdW5Eejlzdm5w?=
 =?utf-8?B?dXR6ZUlhVHY0a0xmeWl3ZkR0bTAyYkRwcGI5VG5jN2xDZW84WnVSSlI2VnZJ?=
 =?utf-8?B?M0wrMnh0K2xlcERjTksrbWhJNUR0cVhIMzl3cnAySEI1OU92eEFwR1ozeTNo?=
 =?utf-8?B?b1c1U1o2T0ZqRGMrcHd3S2ZHVjZmcnRXWHBtemlmOFVJcW9vRTlscnhNYnZn?=
 =?utf-8?B?NEJCdHZ0OEdUVWxZdkgrZnl4U012aTlYZlVYc2tYRWx3UkNOMm9JTElMNWM0?=
 =?utf-8?B?WWNsTm0va1dNNUU3dHZlaEYvSkRZWWpTTHBza09rbi9Jek5IeXE1SVM5bHc4?=
 =?utf-8?B?cW14SjU4SURQQnpWYW9rMFU2SFBMVndYZE1aNWFyd1RFbkVzb3hMbno2RVhB?=
 =?utf-8?B?ZzlRbm83UFk2SUlzaEtPckxvemRkL01MZytxbFI0eXRaSFR6bEFyWVF6Q3VR?=
 =?utf-8?B?SUxKRFVubkcxSWlxWGowRXFSZXk0UTdTUHRpQjRKUlhuUENpVTdXMm9kSllx?=
 =?utf-8?Q?6gP7xWRYb6h6EwTk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 240w8xAMpYFeA+yqXgns79oxAhRKXliMI2dInZXYf/V5+JfzxwbEI3lx8NVwBXg9HBI1WorPcXn8VMIZBWXDf7FprZ01eQhB8a3G8ENxKoWZUkSz0lj4MYtvocFlYb/nxyz9BWI9671ipSfx00dUU46DBgaBSM4qbMbV6+Jw7TnOpmexWS02V/tQuT4TWt2F3fX2iFEZe5fqz7LJMMVjoFb8iYBJdBm3xnYMpNT9hLJBy503PmkfKdA+MbHlIU/C29yoQS981dot5rU/dRQP80w0w0vbKdD4TPsVn0GJMogv4l3sqC54pkDqg6uUzeJo2nH5uxlsUm3AV6/T0fcN5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2537f22d-6228-4026-3ec1-08df1956d9ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 09:41:32.3320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ObIyXVgCHBnW0LxJUIN4vQ0RxLhe322Q+3MrwR1KuWgHTHIxj0KNUd396HIO72/Fdx1ucHrqdAvMJ8axCbpA5K1y8eiiPl1KnxFOMFAt4aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4733
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgS2VsbGVyIDxq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyMiwg
MjAyNiA4OjAzIFBNDQo+IFRvOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVs
LmNvbT47IE5pdGthLCBHcnplZ29yeg0KPiA8Z3J6ZWdvcnoubml0a2FAaW50ZWwuY29tPjsgS3Vi
YWxld3NraSwgQXJrYWRpdXN6DQo+IDxhcmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+OyBJ
bnRlbCBXaXJlZCBMQU4gPGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3NsLm9yZz47IE1h
Y2huaWtvd3NraSwgTWFjaWVqDQo+IDxtYWNpZWoubWFjaG5pa293c2tpQGludGVsLmNvbT47IEtv
cmJhLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtvcmJhQGludGVsLmNvbT47IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7IE5ndXllbiwNCj4gQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGlu
dGVsLmNvbT4NCj4gQ2M6IEtlbGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29t
PjsgTWFjaG5pa293c2tpLCBNYWNpZWoNCj4gPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0ggaXdsLW5ldCB2MiAwOS8xNV0gaWNlOiBFODI1OiBjbGVhcg0K
PiBQSFlfUkVHX1RYX01FTU9SWV9TVEFUVVMgcHJpb3IgdG8gc29mdCByZXNldA0KPiANCj4gVGhl
IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgaWNlX3B0cF9yZXNldF90c19tZW1vcnlfZXRoNTZn
KCkgaXMNCj4gZmxhd2VkLg0KPiBJdCB0cmllcyB0byBjbGVhciB0aGUgdGltZXN0YW1wIG1lbW9y
eSBieSB3cml0aW5nIHRvIHRoZQ0KPiBQSFlfUkVHX1RYX01FTU9SWV9TVEFUVVMgcmVnaW9uLiBU
aGlzIGRvZXMgbm90IHdvcmsgcHJvcGVybHksIGFzIGl0DQo+IGRvZXMgbm90IHRyaWdnZXIgYXBw
cm9wcmlhdGUgUEhZIGFjdGlvbnMuDQo+IA0KPiBUbyBjbGVhciBvdXRzdGFuZGluZyB0aW1lc3Rh
bXAgbWVtb3J5LCB0aGUgZHJpdmVyIG11c3QgcmVhZCB0aGUNCj4gdGltZXN0YW1wcy4NCj4gSG93
ZXZlciwgbmFpdmVseSBkb2luZyB0aGlzIGFzIHBhcnQgb2YgaWNlX3B0cF9yZXNldF90c19tZW1v
cnkoKSBpcw0KPiBwcm9ibGVtYXRpYy4gV2hlbiByZWFkaW5nIHRoZSB0aW1lc3RhbXAgaW5kZXgs
IGhhcmR3YXJlIGtpY2tzIG9mZiBhDQo+IGNoYWluIG9mIGFjdGlvbnMgaW5jbHVkaW5nIGNsZWFy
aW5nIHRoZSByZWFkeSBiaXRtYXAgaW5kZXgsIGFuZA0KPiBkZWNyZW1lbnRpbmcgYW4gaW50ZXJu
YWwgY291bnRlciBpZiB0aGUgdGltZXN0YW1wIGluZGV4IHdhcyBtYXJrZWQNCj4gYXMgdmFsaWQu
DQo+IA0KPiBUaGlzIGNhbiBwb3RlbnRpYWxseSBsZWF2ZSB0aGUgaW50ZXJuYWwgaGFyZHdhcmUg
Y291bnRlciBvdXQgb2Ygc3luYw0KPiB3aXRoIHRoZSBhY3R1YWwgbnVtYmVyIG9mIHRpbWVzdGFt
cHMuIFRoaXMgb2NjdXJzIGJlY2F1c2UgdGhlDQo+IFBIWV9SRUdfVFhfTUVNT1JZX1NUQVRVUyBy
ZWdpb24gaXMgbm90IHplcm8taW5pdGlhbGl6ZWQgd2hlbiB0aGUNCj4gZGV2aWNlIGJvb3RzIHVw
LiBJbnN0ZWFkLCBpdCBpcyBmaWxsZWQgd2l0aCBnYXJiYWdlLiBPbiBhIGNvbGQgcG93ZXINCj4g
b24sIGF0dGVtcHRzIHRvIHJlYWQgdGhlIHN0YWxlIGRhdGEgcmVzdWx0IGluIHRoZSBoYXJkd2Fy
ZQ0KPiB0cmlnZ2VyaW5nIGEgY291bnRlciBkZWNyZW1lbnQgZm9yIGEgdGltZXN0YW1wIHRoYXQg
bmV2ZXIgaGFwcGVuZWQuDQo+IFRoaXMgdW5kZXJmbG93cyB0aGUgY291bnRlciwgYW5kIHByZXZl
bnRzIG5ldyB0aW1lc3RhbXAgaW50ZXJydXB0cw0KPiBmcm9tIGJlaW5nIHRyaWdnZXJlZCBmb3Ig
cmVhbCB0aW1lc3RhbXAgcmVxdWVzdHMuDQo+IA0KPiBXZSBtdXN0IHJlYWQgdGhlIFBIWV9SRUdf
VFhfTUVNT1JZX1NUQVRVUyBpbiBvcmRlciB0byBjbGVhciBzdGFsZQ0KPiB0aW1lc3RhbXBzLiBC
dXQgZG9pbmcgc28gbWF5IGNhdXNlIGEgZGVzeW5jIHdpdGggdGhlIGNvdW50ZXIuIFRvDQo+IHBy
ZXZlbnQgaXNzdWVzLCBwZXJmb3JtIHRoaXMgY2xlYXJpbmcgYWx3YXlzIGFuZCBvbmx5IHJpZ2h0
IGJlZm9yZQ0KPiBpbml0aWF0aW5nIGEgUEhZIHNvZnQgcmVzZXQuDQo+IA0KPiBUaGUgc29mdCBy
ZXNldCB3aWxsIGNsZWFyIGFuZCByZXNldCB0aGUgaW50ZXJuYWwgY291bnRlciBhbmQgdGhlDQo+
IHJlYWR5IGJpdG1hcC4gVGhlIHJlYWRzIHRvIFBIWV9SRUdfVFhfTUVNT1JZX1NUQVRVUyB3aWxs
IHJlc2V0IHRoZQ0KPiByZWdpb24gdmFsaWQgYml0cyBlbnN1cmluZyB0aGF0IG5vIHN0YWxlIGRh
dGEgaXMgbGVmdCBiZWhpbmQuIFRoaXMNCj4gY29tYmluYXRpb24gZW5zdXJlcyB0aGF0IHdlIGFs
d2F5cyBoYXZlIGEgY2xlYW4gc2xhdGUgd2l0aCBubyBzdGFsZQ0KPiBkYXRhIGFuZCB3aXRoIHRo
ZSBjb3VudGVyIHByb3Blcmx5IHJlc2V0IHRvIHplcm8uDQo+IA0KPiBJZiBhIHJlYWQgZmFpbHMg
KGkuZS4gZHVlIHRvIGEgdHJhbnNpZW50IHNpZGViYW5kIHF1ZXVlIGZhaWx1cmUpIGl0DQo+IGlz
IG5vdCB0cmVhdGVkIGFzIGEgZmF0YWwgZXJyb3IuIFRoZXJlIGlzIGFscmVhZHkgYSBkeW5hbWlj
IGRlYnVnDQo+IG1lc3NhZ2UgZm9yIGVhY2ggcmVhZCBmYWlsdXJlLiBLZWVwIHRyYWNrIG9mIHRo
ZSB0b3RhbCBudW1iZXIgb2YNCj4gdGltZXN0YW1wIHJlZ2lzdGVycyB0aGF0IGZhaWwgZm9yIGEg
Z2l2ZW4gcG9ydCBhbmQgbG9nIGEgd2FybmluZw0KPiBtZXNzYWdlIGluZGljYXRpbmcgdGhlIHRv
dGFsIG51bWJlciBvZiBmYWlsdXJlcy4gQ29udGludWluZyBpcw0KPiBhY2NlcHRhYmxlIGFzIGNs
ZWFyaW5nIHRoZSBtZW1vcnkgaXMgYSBwcmVjYXV0aW9uIGFnYWluc3QgZmF1bHR5DQo+IHNvZnR3
YXJlLiBDb3JyZWN0IHNvZnR3YXJlIGFjY2VzcyB3b24ndCByZWFkIHRoZSBpbmRleCB0d2ljZSBh
bmQNCj4gd29uJ3QgcmVhZCBpdCBhdCBhbGwgZXhjZXB0IHdoZW4gaXQgaGFzIGFscmVhZHkgY29u
ZmlybWVkIHRoYXQgdGhlDQo+IGluZGV4IGlzIHZhbGlkIGJ5IHJlYWRpbmcgaWNlX2dldF9waHlf
dHhfdHN0YW1wX3JlYWR5KCkuDQo+IA0KPiBGaXhlczogM2VjNDZlMTU3YzdmICgiaWNlOiBwZXJm
b3JtIFBIWSBzb2Z0IHJlc2V0IGZvciBFODI1QyBwb3J0cyBhdA0KPiBpbml0aWFsaXphdGlvbiIp
DQo+IFJldmlld2VkLWJ5OiBNYWNpZWsgTWFjaG5pa293c2tpIDxtYWNpZWoubWFjaG5pa293c2tp
QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxl
ckBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2lj
ZV9wdHBfaHcuYyB8IDEwMCArKysrKysrKysrKysrKystLQ0KPiAtLS0tLS0tLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDQ4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwX2h3LmMNCj4g
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jDQo+IGluZGV4IGM4
YTY3YTMwNzgzMi4uZTFhNWZmNTc5M2QxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2ljZS9pY2VfcHRwX2h3LmMNCj4gQEAgLTczNywyNCArNzM3LDYgQEAgc3RhdGljIGlu
dCBpY2VfcmVhZF9wb3J0X21lbV9ldGg1Nmcoc3RydWN0DQo+IGljZV9odyAqaHcsIHU4IHBvcnQs
IHUxNiBvZmZzZXQsDQo+ICAJcmV0dXJuIGljZV9yZWFkX3BvcnRfZXRoNTZnKGh3LCBwb3J0LCBv
ZmZzZXQsIHZhbCwNCj4gRVRINTZHX1BIWV9NRU1fUFRQKTsgIH0NCj4gDQoNCi4uLg0KDQo+ICAJ
CXJldHVybiBlcnI7DQo+ICAJfQ0KPiANCj4gQEAgLTExNzcsMTkgKzExNDcsNDMgQEAgc3RhdGlj
IGludA0KPiBpY2VfY2xlYXJfcHRwX3RzdGFtcF9ldGg1Nmcoc3RydWN0IGljZV9odyAqaHcsIHU4
IHBvcnQsIHU4IGlkeCkgIH0NCj4gDQo+ICAvKioNCj4gLSAqIGljZV9wdHBfcmVzZXRfdHNfbWVt
b3J5X2V0aDU2ZyAtIENsZWFyIGFsbCB0aW1lc3RhbXBzIGZyb20gdGhlDQo+IHBvcnQgYmxvY2sN
Cj4gKyAqIGljZV9wdHBfY2xlYXJfdHhfbWVtb3J5X3N0YXR1c19ldGg1NmcgLSBSZXNldCBvbmUg
cG9ydCdzIFR4DQo+ICsgdGltZXN0YW1wIG1lbW9yeQ0KPiAgICogQGh3OiBwb2ludGVyIHRvIHRo
ZSBIVyBzdHJ1Y3QNCj4gKyAqIEBwb3J0OiBwb3J0IG51bWJlciB0byBjbGVhcg0KPiArICoNCj4g
KyAqIEZ1bGx5IHJlc2V0IGEgc2luZ2xlIFBIWSBwb3J0J3MgVHggdGltZXN0YW1wIG1lbW9yeS4g
UGVyIHRoZSBQSFkNCj4gKyBzcGVjLCB0aGUNCj4gKyAqIG9ubHkgd2F5IHRvIGNsZWFyIGEgdGlt
ZXN0YW1wIHZhbGlkIGJpdCAoYW5kIGl0cyByZWFkLW9ubHkNCj4gKyB0c19tZW1vcnlfc3RhdHVz
DQo+ICsgKiBiaXQpIGlzIHRvIHJlYWQgdGhlIHRpbWVzdGFtcCBtZW1vcnkgbG9jYXRpb24sIHNv
IHJlYWQgZXZlcnkNCj4gZW50cnkNCj4gKyBmb3IgdGhlDQo+ICsgKiBwb3J0ICh0d28gMzItYml0
IHJlYWRzIGVhY2gpLiBUaGlzIGRpc2NhcmRzIGFsbCB0aW1lc3RhbXAgZGF0YQ0KPiBvbg0KPiAr
IHRoZSBwb3J0LA0KPiArICogc28gaXQgbXVzdCBvbmx5IGJlIHVzZWQgZm9yIGEgZnVsbCByZXNl
dDsgY2FsbGVycyB0aGF0IG11c3QNCj4gcHJlc2VydmUNCj4gKyAqIGluLWZsaWdodCB0aW1lc3Rh
bXBzIGNsZWFyIGluZGl2aWR1YWwgaW5kaWNlcyB2aWENCj4gaWNlX2NsZWFyX3BoeV90c3RhbXAo
KS4NCj4gKyAqDQo+ICsgKiBEdWUgdG8gaW50ZXJhY3Rpb25zIHdpdGggYW4gaW50ZXJuYWwgSFcg
Y291bnRlciBmb3IgdGhlIG51bWJlcg0KPiBvZg0KPiArICogb3V0c3RhbmRpbmcgVHggdGltZXN0
YW1wcywgdGhpcyAqbXVzdCogb25seSBiZSBjYWxsZWQgYXMgcGFydCBvZg0KPiB0aGUNCj4gKyAq
IGljZV9wdHBfcGh5X3NvZnRfcmVzZXRfZXRoNTZnKCkgcHJvY2VkdXJlLiBPdGhlcndpc2UsIHRo
ZQ0KPiBpbnRlcm5hbA0KPiArIGNvdW50ZXINCj4gKyAqIG1heSBiZWNvbWUgb3V0IG9mIHN5bmMg
YW5kIHByZXZlbnQgbmV3IHRpbWVzdGFtcCBpbnRlcnJ1cHRzLg0KPiArICoNCj4gKyAqIEZhaWx1
cmUgdG8gcmVhZCBhIGdpdmVuIGluZGV4IChpLmUuIGR1ZSB0byBhIHRyYW5zaWVudCBzaWRlYmFu
ZA0KPiArIHF1ZXVlDQo+ICsgKiBmYWlsdXJlKSBpcyBub3QgY29uc2lkZXJlZCBmYXRhbCBhcyB0
aGUgUEhZIHBvcnQgaXMgYWJvdXQgdG8gYmUNCj4gc29mdCByZXNldC4NCj4gKyAqIFdoaWxlIHRo
ZSBzb2Z0IHJlc2V0IGRvZXMgbm90IGNsZWFyIHRoZSB0aW1lc3RhbXAgbWVtb3J5LA0KPiBzb2Z0
d2FyZQ0KPiArICogc2hvdWxkbid0IGJlIHJlYWRpbmcgdGhlIHRpbWVzdGFtcCBtZW1vcnkgd2l0
aG91dCBhbHJlYWR5DQo+IGtub3dpbmcgaXQNCj4gKyBpcw0KPiArICogdmFsaWQgdmlhIGljZV9n
ZXRfcGh5X3R4X3RzdGFtcF9yZWFkeSgpLCBhbmQgdGhpcyBzd2VlcCBpcyBqdXN0DQo+ICsgKiBh
IHByZWNhdXRpb24gdG8gZW5zdXJlIHRoZSBtZW1vcnkgaXMgaW4gYSBrbm93biBzdGF0ZS4NCj4g
ICAqLw0KPiAtc3RhdGljIHZvaWQgaWNlX3B0cF9yZXNldF90c19tZW1vcnlfZXRoNTZnKHN0cnVj
dCBpY2VfaHcgKmh3KQ0KPiArc3RhdGljIHZvaWQgaWNlX3B0cF9jbGVhcl90eF9tZW1vcnlfc3Rh
dHVzX2V0aDU2ZyhzdHJ1Y3QgaWNlX2h3DQo+ICpodywgdTgNCj4gK3BvcnQpDQo+ICB7DQo+IC0J
dW5zaWduZWQgaW50IHBvcnQ7DQo+ICsJaW50IGVyciwgZmFpbGVkID0gMDsNCj4gKwl1OCBpZHg7
DQo+IA0KPiAtCWZvciAocG9ydCA9IDA7IHBvcnQgPCBody0+cHRwLm51bV9scG9ydHM7IHBvcnQr
Kykgew0KPiAtCQlpY2Vfd3JpdGVfcHRwX3JlZ19ldGg1NmcoaHcsIHBvcnQsDQo+IFBIWV9SRUdf
VFhfTUVNT1JZX1NUQVRVU19MLA0KPiAtCQkJCQkgMCk7DQo+IC0JCWljZV93cml0ZV9wdHBfcmVn
X2V0aDU2ZyhodywgcG9ydCwNCj4gUEhZX1JFR19UWF9NRU1PUllfU1RBVFVTX1UsDQo+IC0JCQkJ
CSAwKTsNCj4gKwlmb3IgKGlkeCA9IDA7IGlkeCA8IElOREVYX1BFUl9QT1JUOyBpZHgrKykgew0K
PiArCQllcnIgPSBpY2VfY2xlYXJfcHRwX3RzdGFtcF9ldGg1NmcoaHcsIHBvcnQsIGlkeCk7DQo+
ICsJCWlmIChlcnIpDQo+ICsJCQlmYWlsZWQrKzsNCj4gIAl9DQo+ICsNCj4gKwlpZiAoZmFpbGVk
KQ0KPiArCQlkZXZfd2FybihpY2VfaHdfdG9fZGV2KGh3KSwgIkZhaWxlZCB0byBjbGVhciAlZCBQ
SFkNCj4gdGltZXN0YW1wIHJlZ2lzdGVycyBmb3IgcG9ydCAldVxuIiwNCj4gKwkJCSBwb3J0LCBm
YWlsZWQpOw0KRmFpbGVkLCBwb3J0IGFyZ3VtZW50cyBsb29rcyBsaWtlIHN3YXBlZC4NCg0KDQpS
ZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRl
bC5jb20+DQo+ICB9DQo+IA0KPiAgLyoqDQo+IEBAIC0yMjk1LDYgKzIyODksNyBAQCBpbnQNCj4g
aWNlX3B0cF9yZWFkX3R4X2h3dHN0YW1wX3N0YXR1c19ldGg1Nmcoc3RydWN0IGljZV9odyAqaHcs
IHUzMg0KPiAqdHNfc3RhdHVzKQ0KPiAgICoNCj4gICAqIFRyaWdnZXIgYSBzb2Z0IHJlc2V0IG9m
IHRoZSBFVEg1NkcgUEhZIGJ5IHRvZ2dsaW5nIHRoZSBzb2Z0DQo+IHJlc2V0DQo+ICAgKiBiaXQg
aW4gdGhlIFBIWSBnbG9iYWwgcmVnaXN0ZXIuIFRoZSByZXNldCBzZXF1ZW5jZSBjb25zaXN0cyBv
ZjoNCg0KLi4uDQoNCj4gIAljYXNlIElDRV9NQUNfRTgxMDoNCj4gIAlkZWZhdWx0Og0KPiAgCQly
ZXR1cm47DQo+IA0KPiAtLQ0KPiAyLjU2LjAucmMwLjM5NS5nZDFmMzUyNGUxNWRjDQoNCg==
