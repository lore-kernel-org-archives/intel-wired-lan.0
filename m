Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63488CA5FFD
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 11:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3336240640;
	Mon,  5 Oct 2026 11:14:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sc0d9ZoV_clt; Mon,  5 Oct 2026 11:14:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2FEE2405F8
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791198867;
	b=bkRmbbYJ81uMF7MovJEhOkMEQoOCTF7aqEUl1nAr4Ng+cnvC7UmQC+5B7kIYr+4yNL/G
	 lFuQXpG6nHhAIljSsj3YCk7tIxgBc1N7CYP+qYQ0bLu2LaqTXCQMUOApfcNtnnUhdcCt5
	 FAsHdYRZHWeLCINLeoZsmujtXTkE+QGhbFP4lRQmPFYR703fGfdevOO6NvSlQiRQZlk3Z
	 Q3CRpxBhXtYe25PjgRjZaZrWRqdg6Xg4uFfQ6sUPToYF7bAw+LgdZ9gJ6125ZccbeBJbY
	 IeIS/8xDtq/5lF4m5QcMuoG1v/s4vGSl0AVkZ57OfymQiyaqtPDQ+BBfOshCYRf4jEg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791198867;
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
	bh=lCo+g2ULmi+v0cXXGCK1iDeWiUlWu0V4YTcTSOXU3vQ=;
	b=RobNLBFHemmZnd33rwHOEfFnut00XRyPKaXNe6Dxa2ODMMoFLArO2Xr5SdLej5m3aP+N
	 cgy/rqSB61aWpFeymBQ7A4vljEd1kl5ERuWQAdC4ED2DT1O9WH+5TwWg4CrosxNOkOOTN
	 uAcvOJCpJ+t1RAz6cuwVde984hzS/JOiUAw1bEpGLIcCFJtALwzjaBUR3nAml6eeSJBcB
	 rUbs9C0x3rhDuXRIKPYo7HwrK/qst+hpPUWR8MubEiW9p7u+5eJiDVdPivOSylohng72G
	 9C9dDs/x8lMya0OJ55DxbU+844IQy1+5FvaJC0FfF9fJHTSBx9o4cY5Xkc54pDtsMAw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791198867;
	bh=lCo+g2ULmi+v0cXXGCK1iDeWiUlWu0V4YTcTSOXU3vQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FIV9ce9ZJLXKVdlFEi9Z3tIX95iUBFcOomt++J8JqMwTVFPUAhKBcI+QeTBIPfbUF
	 qIjTv1ZDWTmjtghz4w2eTvlphTbfEMyFOPoahnpaK39HnMT3puVP4cXQhq0z733sEi
	 kzZN3iF8FcqMCDRzVFHA7qbdRJvo92rkEDLKd5MJQRd0DgLy+vAIqDTdWTfGJh0IbY
	 xC+JAjeQjMGhRx74z4ku3hiEcnTwSEFy0utMiVKr7AKWWw8qoL03xZp9TKUQdlsHVx
	 h1gtDiTNSZ3lUGjy6rbG7shzukiWVPCRVq1EhmGpTp2zLc6U9LHv+SvYxcNnRTcSWR
	 OfaQoX+eAF2FQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FEE2405F8;
	Mon,  5 Oct 2026 11:14:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CDC4282
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7221B80BDF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:05:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TFv4SxSPR7cY for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 11:05:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7D74F80BDD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791198337;
 b=h3rYsCwr52TUJTg1avxBGuNGtqbGX872r3G/BrFC81VRb6ZKTyGcO12S4kPpHuDfOKMI
 nqbQrHs0XPnXWtOe3F/33DZuvEU45h5a8X592r/2Gs/CjdO3zsyxCr52yYjPya7HJbdrr
 NiSTEUSsuVj9G8QyrrZSSWT4cXH/y5qurxmc85dpDdRSuTQVKQXE/ImJaHkWLgx13IGDx
 mdE1r/shtWkfCBGjrfSSCoZCEJo4w6um/y/stL/rjcegiV4OcucGGpedW6NKkXmOoKIOL
 BzS645WErM9OqRgQQAVqca67al8khOISNPFckcGnqMsMZzu4Nvb1YNCxSMn8UFvIgWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198337;
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
 bh=lCo+g2ULmi+v0cXXGCK1iDeWiUlWu0V4YTcTSOXU3vQ=;
 b=pZyH7o+H33LB3kccQmbPyBdnA7+g7VGbmO71r60OG8IPV/WK2vtto456ZXR4uJ1NEvly
 RLiy/K4Nm8Jazg0q3TFFCsKSVYaL6kYfNUO3KlJ9IvGy9Er2+JNIfYNICarnpw3i4owh+
 0HQJXI4m1IIujdd7kCgm1LE39Ap6JUn3YLIQvzAhLRZMGzk5M2jMcZlaTI1GjacHEgksF
 3F9jql0+A/xsnZ5LAQGSbm392YVZk67e+zMMgGf8tCF/mSXXqhjYr3SHeChO2vM/hKLWt
 2llE+Zt5v4p6M+DbeX7L/D7I35Zb4YM4LzHhRTzwwWOOgk53FK1xRWm4iSY0ibkPX/A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=X1vcPvDq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=X1vcPvDq
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D74F80BDD
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791198337; x=1822734337;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lCo+g2ULmi+v0cXXGCK1iDeWiUlWu0V4YTcTSOXU3vQ=;
 b=X1vcPvDqQrNNXRH+WdyyLek7eNpLLzZAIksBm+7E3kz8r1EcUmvzim21
 81LBp+NkuFym0eJrCo17LPQYnryy7M9ztPXb19/Vh9+gY5bK52WAqUx0n
 cseyO8nAmDEUY62Iu7m8BLodaziGkecNCiPCol2pdE0p6/h9ABsCmyRl2
 KApvWU0fhcuyEfmdU96O0P9389lnb+YeSjDYs9uQnXshU64r/CPbxkU3/
 cNJXr5S1EBmeh2uYoxHb2lF5K5y80YMDK1ce+SxSnvGGhr8mWmyAc733N
 4ZNzW9yrsDw6aGvQFcOktMSFYhsmBSOAxp/FdXf1nagMMFopk46t88cW/ Q==;
X-CSE-ConnectionGUID: onfQSkGKThaEAjDSzVlw7A==
X-CSE-MsgGUID: sMbpxuXORn+JRYqyydQC2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="103235941"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="103235941"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:05:36 -0700
X-CSE-ConnectionGUID: iZwhwtGGQN6h0+LRGFeXSQ==
X-CSE-MsgGUID: UhtQCPOnSzysKYN6x+18ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="303044574"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:05:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 04:05:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 04:05:35 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 04:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tm2ZKnRAiazzqvgCXoQekk7QQNWK8KS/rMtv8WUf7q7E963JWn96LiPAFU1ykY3jfuBYZaYfGZNON/AMz04DajzNbR+ZdPUktwapt2p86TNgQb+DN3kea2ES+bwslxonhrD8OShKSs0eITkA9aDce1t/LJrtTP+wtYqQR/9U6yT5cCn34cW3Jfg5YyiOWWLscPljLjrw3WdvFKkSEY8DiIDvGb/TU/EGcrBCbTipH4KCMjkB26Ubv7dXT7px10SIEe17d4kJOnKY1ZFpi0VE5LTaKFHUXeUJysZjpQJE5a31gTz1UHVXrgTJFR5ardNynzhhzvbmlLGkF5iwRtmokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCo+g2ULmi+v0cXXGCK1iDeWiUlWu0V4YTcTSOXU3vQ=;
 b=tsfsi+pLnN5riCkaRBWPIypzM7cxr/GVatuL64mxyLWygapxPo68dyN/+O6iFYCUNCqzfRF8sXJwH6IUVvsq3aOfp7WvEEWvsXr0UuAtyLC9gi1KQ9G0LMLi4KvcU0nqhzro1hWuQpQs3kCZpG8pF+Ql5JGLmzF4VRkktEPhcCMBAWo6KnAoCWAFHKrrZat+5f+Zf6rvw5iW9MKMc1O2rpmqxZe70foEId9xkyUOyNXy5li+Sb8yGaz5NhD9fgslBLCYte7wt75/AxyxlJP3s9BHah1Sxz4uAC1tQYwNx0KsvwTaRRZ1A0MVRkr4lDc/Ui/vNZQLPeUBl3FyFLax8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 11:05:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 11:05:21 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
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
Thread-Index: AQHdTUnFDZd1Qmy1kE2m2yP4zTqkrrbu2DTQ
Date: Mon, 5 Oct 2026 11:05:21 +0000
Message-ID: <IA3PR11MB8986C5F1FF9B8AB32A22D3AFE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS7PR11MB7784:EE_
x-ms-office365-filtering-correlation-id: 77f007fe-eea0-4676-458a-08df22d08c7c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|11063799006|4143699003|921020|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 9KI8QhslsOn/SieJMI2yUMf0ByKKPVb3RYVEHOtBREQxF1z5yaypcGMrVe7I0EDpEHcIY/BY3beIlSRlIMoizd31tAxWJToxNTfRN2H6odw4WHfOKN+3WGeKQG7cnB5zF3Uv1jR/Y0Hod1nZd0vN+DStzo8qzZNS2mYyTKgtmo62LMGRihq84Mxw8E44Oz+oSQMC10k8IYqfCwOj52VSmDH/rFZ4RR2HKBp0YTrWFJ2nxRGumOqtwEXG8MXvQW4MoOJT5JVVF4aSuZMrkUGP+5KllgtLvFtyN3jhEDBuwtEV65jFiIkvY6WVXwmpk5VZjYm0v0OxvSuSpY+aSfTuZkCmbwWLjjv11RUD7FjOeRDZFAP+8inQBHPvqtc4zlOgZUBZQmSWYw48UHstiSrFqqGDqyBeYpwR4gJm1QxdOm0w/JlXP6ZTPqRuJgA21hMUR0sEVA4dYIybCzo8uEk39D6lWH7AZJun2/66JsVsh3khBMGAQnyNWbD30yA1+k/WudA+fOJ6N1rGByfjyF+WrGDuyWGMR4wvpYzR59tPXNQ9HfI7/jVECzdkHvyLz9izzE1U3R8BkJrSJfIhbDSD0imtD50lj/s1pOrVmTD9WaE5sqAGgG0MUOFzX1DU20ZtPpXMObLcjGdH/cbnfE+w/U3mlHiI6paPZee3AURg48N0azHghLFbpujIwUv1TDVadMNx4tI51KRENFu+is1qk/RXLW4uEF0g4K2oubM43oDOm6/hwUfVB8I7XIwnVA0e
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(921020)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDkrVzFwdW53NkMxSHZJazdTUGNHM2ZRWU1JSTFvNXBJWDJrNWdOR0FsTlBF?=
 =?utf-8?B?dGlPeitLOFJNeUJyNUwzUDc4R21HS3VhNm5pRzlzMGFiUklnUW56Y05xT3p3?=
 =?utf-8?B?dVhkN1pudktaMEhVcU9rWHVtQWJhYTRjN3h2SXBncmo2cEswL3FmUEpTQ0o2?=
 =?utf-8?B?YnJ0YXhxNm1vaVJ6NlRwUGY3SitLbndtN3JCNTNqQlVON0RVOEtucXlWMmxm?=
 =?utf-8?B?ZEJRVVFVUFg3dWZKbDN2WERxUlE3Ti95WEYvcWdFbEpUamdCREE0bUx2Ty9x?=
 =?utf-8?B?aEZOcXFzOS94a0NrcCs0aCtyQmJwb2FWRUxKQ2d4QVhVRXczYU0vM3QvS2pD?=
 =?utf-8?B?ODYzL0ZiakEya21Ob25manJxbCtUQm9YUUhvSk9hYU04OUZpQ3lFaGluVG9V?=
 =?utf-8?B?R0d4MW0vdVhmNS83cEpub1NnejU2Mm9VTGFhUThCQzVHTlVLVktjY2lub2Ro?=
 =?utf-8?B?S2xHamQwSXpnd1Jkd25aV245OWs2Y3RYRkQ4SmNnTGR3VEwyVDNuaGJkU1o2?=
 =?utf-8?B?R0c2bkJRVmkzcmFVa0xiemhHZUovZWhVdnEreUM1bXlvckNxSmNsQzNQUzht?=
 =?utf-8?B?emg3VkZQZFB0cG9aY1dzeVhPVXRYR25YT2RJNytLM2hhRm5XY3dZL0k0OTFw?=
 =?utf-8?B?MFkza1hsUnNLY3lEQmNDYXIvQnJQTU8rQWd5djNWNVlqRkFUMmJEeE9NSS9G?=
 =?utf-8?B?UGk4TUE2VktKTmZ5WlVXaE1HQjNOT2xVRzNPTHFWZTlpV21RTTIwM2hENTd5?=
 =?utf-8?B?c3ZGL1lkUTZHYmVEc21HTTJNSkEySXRVcmlPYmtCRTduQ2RLSmovTTRiTXdv?=
 =?utf-8?B?ZlVCWW84VXNHenpCMHhLdGZYQ3EyUUNqMng2NXRJUmF4dzAwMGpzbWdLZ0pE?=
 =?utf-8?B?MlBwNUEvMnZkSVVyNUphT1NlcXF6cy9mMlJydWRyVm1RajRVSUY4eU1zRk5r?=
 =?utf-8?B?eTBaRC8xd1FobGNrMDZGRmxBMktNN095VEQzYy9HQ1hQQ1BZU1I5VXlWQlN3?=
 =?utf-8?B?S1dyK3ROUXlUa1F3QXVncUlQeTZwZ3QxOGZ0S092OHNGbFFsSEdlb3c4MklV?=
 =?utf-8?B?VVl1cHpRTTYzbmhJYlN6VHRzeU5KMnFTbzU5dG0wNXhDNVNaNkxkTmZoYStW?=
 =?utf-8?B?blc3ZUZhcjhVRi9yeE5HeUlWbHNLS1dCM201ZThRNjlYb1ViN0ZXdEdtd1Jx?=
 =?utf-8?B?OU1MSkZWYkpqM0J1MmhSc3l0d0VvdE9ac2RmZFhXei9IZWZ3OWc4K2w1cGxw?=
 =?utf-8?B?WFBNQlFMa2FTVmFHNm9QWHVvajNUeEJzR1NJcThBQXBMWUw1ZDYxRWZ0MUM0?=
 =?utf-8?B?V0pvNXdtTFBLQ0YyMThHcm9uaC8vbmdRUmtHbFlDVWNOWnlGcnBRQkl2TTQv?=
 =?utf-8?B?N21aN1hsblRvb3llT1VlK0gwZTRLSm5wRUJLTEtTR1BiNlp5SzhPVk9IWFgx?=
 =?utf-8?B?MFZTUGlacXBwcjd5ZG5vZVlmdXVIVlo2U09LZWlvT0tacjMxdTM2OEs4cjVM?=
 =?utf-8?B?dW5FMFVocUtnSEtPejR2bG9LWXZTRk9VdkkzcVJ4ZWxsK1U1NTNuV2kyUW14?=
 =?utf-8?B?azdTNldOeUt1dWxCRmNINUVUZ3doZ3YzUTBkUlllOFBvMWhwL2xLS01VYmky?=
 =?utf-8?B?b3VBU2t4OXFlN3NRczlIdytBOXFqbzdxU1ZIbE93NWRqbnRNZXcrYjB0cEN5?=
 =?utf-8?B?ZVRCNndoZHBTUEplWnNMTEkvZkFyK0xYMFM2c1RkWHdjcVpyMW54QXI0bTdH?=
 =?utf-8?B?VXBpdnpqM25VYlovV0g3UzhmSXVoWExBK25kOWI0bWtURW1EN0VzVlArVGJk?=
 =?utf-8?B?b0V6UERtZkZRZnkvNEwvY1duVTVpa2lpY2paelZ1QTcyR0d3cnBxdmxpbEt3?=
 =?utf-8?B?NWthc2Jtenp6MEl6d3VOQy9ZR2tyWFB2OWpmekFnWUhCK1NaTThaaU1JT01r?=
 =?utf-8?B?NHJnOVZJdUE0aHVndTIxUnJ6aUNLVTUvcTZPbnVJK2Vta1ZIN3JEeWpVSDhZ?=
 =?utf-8?B?OUF4bVNXbTFZVG9YZjNvVFgyazJQTTJMZ0EvaDlDWUdCVWdCb0wwSjNLT1N0?=
 =?utf-8?B?L3RDbnM0dVpFK3lzcjlqNlg1KzVlUStYeTE3UXo0MjFkY3B4aS8zT2liMk9P?=
 =?utf-8?B?M0pvYjZKLzIxaDkxTmZ0M1EydXJ4TWlQc0IwSlV5RU1qMG5ZWEVKdXZDdXRn?=
 =?utf-8?B?eEpOaktRV242SWFmVWVRZ0d6ZFlXdU1HOTJscEg5N09rMnNLOExQc3hKY2I2?=
 =?utf-8?B?RDVyckEvaXVSL2d5OWZaTzdpUTVuUW9UOEtoYkx2djJsWE9KOFpUWWZFR1Av?=
 =?utf-8?B?cUZYNTdKeW5lMEYrWlNCaTBOTWtoZ1publlDZDdOOU5acFI4QzVzcUhjK00z?=
 =?utf-8?Q?VpEEJYw00sUiP2RU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zywrOIoOzIvX9avJnxJvLP8iQNkAzuttuy+EdvcXhDmGNHxY5Eosm1uL1ten7syFPNBO6ubdx1eAK52pprSCqTqFM3T6Csh5255+FWyKjPrMWs5Em3JqKyp21WVnGZ/Z3TB2FfmcPIf52HI+CEuhvqIeaEI31PCC62nQJ8ngzRqlSrLNOHpD3Tob4MrO3oyHrsycI2ZhETrZ5t4YR7mzoBW3+W5L2NuL5t7QB9zB7newEi3P2jYR5K0Y4RyKMhJD3iWLBe+RBmDa/ZpFUUFGRCHj4Wxz7mmCmya2iP++dX7ZW+fEMlEKf1qrDyUxx0a7h32pX7qlMC8Nk5pgLCSsMw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f007fe-eea0-4676-458a-08df22d08c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 11:05:21.4937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nCsbgm8uwyrFqfHODqXoVenVcPoDZzDyZpXXlSiG7T2wyjCpWB/g39ZRyDGJw7qAXuPUKo91ttXI0D3Fj+L87CF6XBHuNSeW8r8oLumJjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784
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
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjYs
IDIwMjYgMTo1NyBBTQ0KPiBUbzogSW50ZWwgV2lyZWQgTEFOIDxpbnRlbC13aXJlZC1sYW5AbGlz
dHMub3N1b3NsLm9yZz47IE1hY2huaWtvd3NraSwNCj4gTWFjaWVqIDxtYWNpZWoubWFjaG5pa293
c2tpQGludGVsLmNvbT47IEtlbGxlciwgSmFjb2IgRQ0KPiA8amFjb2IuZS5rZWxsZXJAaW50ZWwu
Y29tPjsgS29yYmEsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua29yYmFAaW50ZWwuY29tPjsg
Tmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgTml0a2Es
IEdyemVnb3J6DQo+IDxncnplZ29yei5uaXRrYUBpbnRlbC5jb20+OyBLdWJhbGV3c2tpLCBBcmth
ZGl1c3oNCj4gPGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVsLmNvbT4NCj4gQ2M6IEtlbGxlciwg
SmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgT3JvcywgUGV0cg0KPiA8cG9yb3NA
cmVkaGF0LmNvbT47IE1hY2huaWtvd3NraSwgTWFjaWVqDQo+IDxtYWNpZWoubWFjaG5pa293c2tp
QGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgdjMgMTEvMTVdIGljZTogd2Fp
dCBmb3IgaW4tZmxpZ2h0IFR4DQo+IHRpbWVzdGFtcHMgYmVmb3JlIGZsdXNoaW5nIHRoZSB0cmFj
a2VyDQo+IA0KPiBGcm9tOiBQZXRyIE9yb3MgPHBvcm9zQHJlZGhhdC5jb20+DQo+IA0KPiBpY2Vf
cHRwX2ZsdXNoX3R4X3RyYWNrZXIoKSBmcmVlcyBldmVyeSB0cmFja2VkIHJlcXVlc3QsIGJ1dCBh
IHJlcXVlc3QNCj4gd2hvc2UgdGltZXN0YW1wIGlzIHN0aWxsIGJlaW5nIGNhcHR1cmVkIGJ5IHRo
ZSBQSFkgYXQgdGhhdCBtb21lbnQgaXMNCj4gZnJlZWQgd2l0aG91dCB0b3VjaGluZyB0aGUgUEhZ
IGVudHJ5LiBUaGUgcmVhZHkgYml0IHB1Ymxpc2hlZCBzaG9ydGx5DQo+IGFmdGVyIGhhcyBubyB0
cmFja2VkIG93bmVyLCBhbmQgdGhlIFBIWSBkb2VzIG5vdCByYWlzZSBhbm90aGVyIFR4DQo+IHRp
bWVzdGFtcCBpbnRlcnJ1cHQgdW50aWwgZXZlcnkgb3V0c3RhbmRpbmcgcmVhZHkgYml0IGlzIHJl
YWQsIHNvDQo+IGRlbGl2ZXJ5IGZvciB0aGUgd2hvbGUgcXVhZCBkZWdyYWRlcyB0byB0aGUgcGVy
aW9kaWMgd29yay4NCj4gDQo+IFdhaXQgdXAgdG8gMTAgbXMgKHBlciBwb3J0KSBmb3IgaW4tZmxp
Z2h0IGNhcHR1cmVzIHRvIHB1Ymxpc2ggdGhlaXINCj4gcmVhZHkgYml0cyBiZWZvcmUgZmx1c2hp
bmcsIHNvIHRoZSBmbHVzaCBjbGVhcnMgdGhlbSB0b2dldGhlciB3aXRoIHRoZQ0KPiByZXN0Lg0K
PiANCj4gTm90ZSB0aGF0IHRoZSBpY2VfcHRwX2ZsdXNoX3R4X3RyYWNrZXIoKSBmdW5jdGlvbiB3
YXMgaW50cm9kdWNlZCBhbG9uZw0KPiB3aXRoIHRoZSBvcmlnaW5hbCBFODEwIHN1cHBvcnQsIGJ1
dCB0aGF0IGRldmljZSBkb2VzIG5vdCBoYXZlIGEgcmVhZHkNCj4gYml0bWFwLg0KPiBPbmx5IGxh
dGVyIGRldmljZXMgKEU4MjIsIEU4MjUsIEU4MzApIGhhdmUgdGhlIGJpdG1hcCBhbmQgcG90ZW50
aWFsDQo+IGlzc3VlcyB3aXRoIGludGVybmFsIHRyYWNraW5nLiBUaHVzLCBza2lwIHRoZSB3YWl0
IGZvciBFODEwIGJ5DQo+IGNoZWNraW5nIHRoZQ0KPiB0eC0+aGFzX3JlYWR5X2JpdG1hcCBmbGFn
Lg0KPiANCj4gRml4ZXM6IDEwZTRiNGEzYTNlMSAoImljZTogY2hlY2sgVHggdGltZXN0YW1wIG1l
bW9yeSByZWdpc3RlciBmb3INCj4gcmVhZHkgdGltZXN0YW1wcyIpDQo+IFNpZ25lZC1vZmYtYnk6
IFBldHIgT3JvcyA8cG9yb3NAcmVkaGF0LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1hY2llayBNYWNo
bmlrb3dza2kgPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5jIHwgNjQNCj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9w
dHAuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gaW5k
ZXggODE4ZTJlMjY1YTdlLi41MjIwZGUyNzQ4MTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWNlL2ljZV9wdHAuYw0KPiBAQCAtNzQ0LDYgKzc0NCw2OCBAQCBpY2VfcHRwX2Fs
bG9jX3R4X3RyYWNrZXIoc3RydWN0IGljZV9wdHBfdHggKnR4KQ0KPiAgCXJldHVybiAwOw0KPiAg
fQ0KPiANCj4gKy8qKg0KPiArICogaWNlX3B0cF9pc190cmFja2VyX2RyYWluZWQgLSBDaGVjayBm
b3Igb3V0c3RhbmRpbmcgdGltZXN0YW1wcw0KPiArICogQHBmOiBCb2FyZCBwcml2YXRlIHN0cnVj
dHVyZQ0KPiArICogQHR4OiBUaW1lc3RhbXAgdHJhY2tlciBzdHJ1Y3R1cmUNCj4gKyAqDQo+ICsg
KiBSZXR1cm46IEZhbHNlIGlmIHRoZXJlIGFyZSBhbnkgdGltZXN0YW1wcyBzdGlsbCB3YWl0aW5n
IGZvcg0KPiBoYXJkd2FyZTsNCj4gKyAqICAgICAgICAgb3RoZXJ3aXNlIHRydWUsIGluY2x1ZGlu
ZyB3aGVuIHVuYWJsZSB0byByZWFkIHRoZSByZWFkeQ0KPiBiaXRtYXAuDQo+ICsgKi8NCj4gK3N0
YXRpYyBib29sDQo+ICtpY2VfcHRwX2lzX3RyYWNrZXJfZHJhaW5lZChzdHJ1Y3QgaWNlX3BmICpw
Ziwgc3RydWN0IGljZV9wdHBfdHggKnR4KQ0KPiB7DQo+ICsJc3RydWN0IGljZV9odyAqaHcgPSAm
cGYtPmh3Ow0KPiArCWJvb2wgcGVuZGluZyA9IGZhbHNlOw0KPiArCXVuc2lnbmVkIGxvbmcgZmxh
Z3M7DQo+ICsJdTY0IHRzdGFtcF9yZWFkeTsNCj4gKwl1OCBpZHg7DQo+ICsNCj4gKwkvKiBJZiBI
VyByZXNldCBpcyBvbmdvaW5nLCB3ZSBjYW4ndCBhY2Nlc3MgU0JRICovDQo+ICsJaWYgKGh3LT5y
ZXNldF9vbmdvaW5nKQ0KPiArCQlyZXR1cm4gdHJ1ZTsNCj4gKw0KPiArCWlmIChpY2VfZ2V0X3Bo
eV90eF90c3RhbXBfcmVhZHkoaHcsIHR4LT5ibG9jaywgJnRzdGFtcF9yZWFkeSkpDQo+ICsJCXJl
dHVybiB0cnVlOw0KPiArDQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJnR4LT5sb2NrLCBmbGFncyk7
DQo+ICsJZm9yX2VhY2hfc2V0X2JpdChpZHgsIHR4LT5pbl91c2UsIHR4LT5sZW4pIHsNCj4gKwkJ
aWYgKCEodHN0YW1wX3JlYWR5ICYgQklUX1VMTChpZHggKyB0eC0+b2Zmc2V0KSkpIHsNCj4gKwkJ
CXBlbmRpbmcgPSB0cnVlOw0KPiArCQkJYnJlYWs7DQo+ICsJCX0NCj4gKwl9DQo+ICsJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmdHgtPmxvY2ssIGZsYWdzKTsNCj4gKw0KPiArCXJldHVybiAhcGVu
ZGluZzsNCj4gK30NCj4gKw0KPiArLyoqDQo+ICsgKiBpY2VfcHRwX3dhaXRfZm9yX3RyYWNrZXJf
ZHJhaW4gLSBXYWl0IGZvciBQSFkgdG8gY29tcGxldGUNCj4gdGltZXN0YW1wcw0KPiArICogQHBm
OiBCb2FyZCBwcml2YXRlIHN0cnVjdHVyZQ0KPiArICogQHR4OiBUaW1lc3RhbXAgdHJhY2tlciBz
dHJ1Y3R1cmUNCj4gKyAqDQo+ICsgKiBXYWl0IGZvciB1cCB0byAxMCBtaWxsaXNlY29uZHMgZm9y
IHRoZSBQSFkgdG8gY29tcGxldGUgYW55DQo+ICtvdXRzdGFuZGluZw0KPiArICogdGltZXN0YW1w
cyBiZWZvcmUgZmx1c2hpbmcuDQo+ICsgKi8NCj4gK3N0YXRpYyB2b2lkDQo+ICtpY2VfcHRwX3dh
aXRfZm9yX3RyYWNrZXJfZHJhaW4oc3RydWN0IGljZV9wZiAqcGYsIHN0cnVjdCBpY2VfcHRwX3R4
DQo+ICsqdHgpIHsNCj4gKwlib29sIGRyYWluZWQ7DQo+ICsJaW50IGVycjsNCj4gKw0KPiArCWlm
ICghdHgtPmhhc19yZWFkeV9iaXRtYXApDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWVyciA9IHJl
YWRfcG9sbF90aW1lb3V0KGljZV9wdHBfaXNfdHJhY2tlcl9kcmFpbmVkLA0KPiArCQkJCWRyYWlu
ZWQsIGRyYWluZWQsIDUwMCwgMTAgKiBVU0VDX1BFUl9NU0VDLA0KPiBmYWxzZSwNCj4gKwkJCQlw
ZiwgdHgpOw0KPiArCWlmIChlcnIpIHsNCj4gKwkJZGV2X2RiZyhpY2VfcGZfdG9fZGV2KHBmKSwg
IlRpbWVkIG91dCB3YWl0aW5nIGZvciBpbi0NCj4gZmxpZ2h0IFR4IHRpbWVzdGFtcHMgb24gYmxv
Y2sgJXVcbiIsDQo+ICsJCQl0eC0+YmxvY2spOw0KPiArCX0NCj4gK30NCj4gKw0KPiAgLyoqDQo+
ICAgKiBpY2VfcHRwX2ZsdXNoX3R4X3RyYWNrZXIgLSBGbHVzaCBhbnkgcmVtYWluaW5nIHRpbWVz
dGFtcHMgZnJvbSB0aGUNCj4gdHJhY2tlcg0KPiAgICogQHBmOiBCb2FyZCBwcml2YXRlIHN0cnVj
dHVyZQ0KPiBAQCAtNzYwLDYgKzgyMiw4IEBAIGljZV9wdHBfZmx1c2hfdHhfdHJhY2tlcihzdHJ1
Y3QgaWNlX3BmICpwZiwgc3RydWN0DQo+IGljZV9wdHBfdHggKnR4KQ0KPiAgCWludCBlcnI7DQo+
ICAJdTggaWR4Ow0KPiANCj4gKwlpY2VfcHRwX3dhaXRfZm9yX3RyYWNrZXJfZHJhaW4ocGYsIHR4
KTsNCj4gKw0KPiAgCWVyciA9IGljZV9nZXRfcGh5X3R4X3RzdGFtcF9yZWFkeShodywgdHgtPmJs
b2NrLA0KPiAmdHN0YW1wX3JlYWR5KTsNCj4gIAlpZiAoZXJyKSB7DQo+ICAJCWRldl9kYmcoaWNl
X3BmX3RvX2RldihwZiksICJGYWlsZWQgdG8gZ2V0IHRoZSBUeCB0c3RhbXANCj4gcmVhZHkgYml0
bWFwIGZvciBibG9jayAldSwgZXJyICVkXG4iLA0KPiANCj4gLS0NCj4gMi41Ni4wLnJjMC4zOTUu
Z2QxZjM1MjRlMTVkYw0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3Nh
bmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=
