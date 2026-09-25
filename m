Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9728FC98321
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 14:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A6338129A;
	Fri, 25 Sep 2026 14:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VAviNgrJxHu2; Fri, 25 Sep 2026 14:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 78B1F8132B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790346666;
	b=JMVvb1FItBIeQt7/D2mft+0JX2IJTDQELUETjLmL1QX6U+nQxrZxeNAUzVmgAnUyHXpc
	 0KlgAw99cV4wyopd/WMb4gopFCv77MkfESzU4wLLc5fLrxOYBpwLQYGto+KPEUgdDj197
	 mZwitadH3pKbrUeS4XX78borq7xNBMWgJbHg9c3mT4cgtVwieCOSeglvZSD17++Iaetax
	 7Wxojlc59C9IEvN6wsKZIpVGEPfAEC2HX1ZVhgR9fS7Gkj+eMYMgOq2TD7BbrrZCkZGgj
	 qkRSvekwrQZbXCRnvydM+PdBrYjnlLEdvMQr8yfVuqKgq8han2UlmRxTQyJvJJXaV5A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346666;
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
	bh=Wpa6gi8E5Jrlva4CXfMkOY4NjOKMYTPD6ZNbdjotCaw=;
	b=NYQ50QY6N0iOLIf++wXwi5kEjPn5CHUx1f+YhCex828PNIjKdjBbgJdmlqRMDOciQAN7
	 Aue/J7J1dLbLi1FJ5YKjxAQKhszSYA7C8Gmb7OvC9EsiwzYUuXWDdln+rmOYK+mE1HfUe
	 ogLLvAgTWq4gfRFLmzIoiZWLFVL9qdADbSwV7suVZG8LjsKRL5G0SedCRe5gVXbWj3ciE
	 x8DEY4OcSyyAY7El7T/+QtXNTTQIU5UTHq4fGoWcHMIQYKOZJDIHzN4twgyqm3juJTAdK
	 hyRRSEQx370CTobjXzYjO7VEaUF0zfiC60acCCcca0PcLUq38U9C0YdiHZJA9fjhOyg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790346666;
	bh=Wpa6gi8E5Jrlva4CXfMkOY4NjOKMYTPD6ZNbdjotCaw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=86YIDYcXzWIJWYYV48wJJGDOtWFoCf0ny8ttgBmt+5n0wr6dQEXJk5MTUC0F7NVbS
	 fL7in8n6MIPgCswt+lwH1hyTRjRx8PwJh4UMC6RJeg6HQ2Byn3C4u/s1MrlHNh5zeU
	 OsXaFVSLLXqju9seI6B994QxJFfJZbiWhBdH8dz2Nd3bvkkP/i+GpSvcKX9dRBQcYS
	 95MkAyRk0QpOC9WcGRXduST3vcmJFY67iT7EdOX+df/+YrTw5yC5sjuyP3F4ausGKZ
	 KUe1wa6/fjBzb87R6rHYBgEmFykROvUX6ucZ2Bgu2xyfsh7tfuEU16Rb8ahujdMJYM
	 FFxWyzWE04CsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78B1F8132B;
	Fri, 25 Sep 2026 14:31:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FCB5194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 10DB64016B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gzWwAurVjv_v for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 14:31:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 176594005E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346664;
 b=Ht2688ErKQBvddCXYOx9FR4BpLyfnU+RoWXnQ/pZxVnGXEgPquJU3Y0L8RspWaFgKTIT
 X/KHatEWTE9oBHsisxqybY5SrV3DxVz0HLpRZxgzvABqcoyJS9kKGAarnMVK6A3Js9ljB
 maO5T4JI9fDnR8e8hp0wilnPQShvTSoK9NHEek7jWWvi0e034I0Kt1sPv/KMjdkyjd1Yd
 NxwRIbak/ZpbXSjVIxZocDa7zLqDUW2sewvMSuLRcTkCRVNzJSEgf6FDkGBgI60biInlJ
 CRhp+VJ+BqSk4/M5qlTWec2EbubcqUp4hb0cyh6ofEeA9q/XvXQETUkaFnY1RotQQdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790346664;
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
 bh=Wpa6gi8E5Jrlva4CXfMkOY4NjOKMYTPD6ZNbdjotCaw=;
 b=O3z1WPbmTUBQl7mZ9Hbg2nDAIzMxurlZN+hE3dTikvR7qLQ6nGRjuuHvDFRE/oVJzUK9
 B5lK09dwuJmo/Ft0/AsIdYQXRv8l/e36Qs0eHdUCPdZhF09LLDMaUwvTNj5umsXaFCEBN
 r41U1BHKGM83i3NAfr4Um2ngGfjXbfjTJg4ZW2gHVu/cgR7danGX9LykNA05+/fMGUWNl
 UPxgstS9tK9Q9mqRi23havYhwJ3+gUwbyji87DbGtfY/Z5/JZOlqOJKLYpc/dXBmhB/cU
 w4K1ddQcjln6S8arQKpx+Hw3l+ac8OQkqRZAezCYhfN2Xb6BMn4B1TMsll9ALBL5s3A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NJTr2RSO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NJTr2RSO
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 176594005E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790346664; x=1821882664;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=N6icq84vY7iNscAeXx5MKvNAoSYkBrnuyrUVMYsqu/k=;
 b=NJTr2RSOeAUFkU4wk+f9yrqpQeA/6bm9axhvOk7NwfAMt4G7lx3xb2IJ
 p5UxW6/XO3scNNmCRG47J6dlfulVccJVS1Exwe6GscrbhireBAaQkzJ8U
 Q9PsLVUF54ce9t7V0qNutqKIDpBtux7OnpeO/8C6u+3mNvpEYWaVW+wnw
 3gUvQwxrqpV96lCa5jWbzSK6GcCQX7HsNb7KrAB/QyaDpU++tQKlHq0Tn
 C5dsXrEcGEpQaWMV0uv0aBm00UCo+5hkwnN9P8NvComBAobXala8sUPPT
 gKdOwzRjF9rx+tOKhbvsYAil+NI+Ibui5jp94hK6Wnk/GP4Iyapo8dVxg w==;
X-CSE-ConnectionGUID: WizkH5rzTwe5UNilMsX/RQ==
X-CSE-MsgGUID: onKvzGxYTJSHKB2c+cKmQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="116661500"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="116661500"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:31:03 -0700
X-CSE-ConnectionGUID: Zpxbe4CpT6uB63M3NZn9SQ==
X-CSE-MsgGUID: 4ohUdGDoRv+kVnQsNcXOFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="303854631"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:31:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:31:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 07:31:01 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:30:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgkhgA6NR0/jj3JrXbYGdJT2k431lfQJ0140O19Q0hDX0vNlX0Md2axOhEEGtEtiUlrouKtQph2w0oLq/RZ4HNDTdcLHdSVkuTqiqpopm9kpImp2chEyhwOiMXJ/c0QaJ11p0ckz3pC4vdvvO69WT8ehCtDt5m1E51WBQ0ixQz/fkgDNvGD0XZs8i0AOFzEtf2H+T2oo0QrNx1N4SAeBeGfoutuOnxxGrlvuBjF9iHcCvqxbYww/ix4ZHjDNxFLCOez843E4kuDygovu+HXmZ8KcAbG1SymOb3k4CNR9tQykGvjU6w1mWUPkNNym6Ud2Hnf0XQPOm74sc5sbP89rcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wpa6gi8E5Jrlva4CXfMkOY4NjOKMYTPD6ZNbdjotCaw=;
 b=pTaWSxhk909ntXdXWqHu/zJm3bmamHCsyHE5Vc1yHiZr0HZPvvxzk7mVm9YiJYKPyTr1Hfxz1y64HiWQlYSAnMwHRZ+CMficEZr+f8cF8zCwzDFJWAufE3XgPsOQ4p2Q79xPJae+IogJNJZR2G2B9SL2QJaQW0VIzTCvWGYK/MKOqtM2YTUQoDLqOpLW0P/RNsf/qBCVPdd+KUNgv83MZi2Ktgcl0HVrOSmdleU3GGC8Aj05PXBFbLr4BoFIYdQIqQeqUKYe3+KQb9uZGa42IKheSUXUXjlqcwREKrI9rz8zB+iekhYhUFNqcG2D5QDvLtzmzkMSHiCVq7xiZ+iHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SAWPR11MB9572.namprd11.prod.outlook.com (2603:10b6:806:4e2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:30:55 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:30:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
 <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Schmidt, Michal"
 <mschmidt@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "edumazet@google.com"
 <edumazet@google.com>, "horms@kernel.org" <horms@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH net v5 3/6] ice: extract ice_vsi_new_stat_arrays()
Thread-Topic: [PATCH net v5 3/6] ice: extract ice_vsi_new_stat_arrays()
Thread-Index: AQHdTPGWdhyozjaAd0aLjj82Z1L9q7bfWwFA
Date: Fri, 25 Sep 2026 14:30:55 +0000
Message-ID: <IA3PR11MB89869BDCBD365DD0BEB74FFAE5802@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
 <20260925132636.123300-4-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260925132636.123300-4-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SAWPR11MB9572:EE_
x-ms-office365-filtering-correlation-id: c0051f3f-66c6-41ee-146a-08df1b119bea
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|11063799006|10067099003|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: DGrDEO/UUf8sllHzFwlnC0o/Qy/VOa+iUjzT/7yj/vboh81CAhylvC3J6a5EjkBt1Vhe2HqBw5ugB08LCnXhWnUe4a3ucYGDo96FyxSlGs6qxwGd30DGtbIGsq2oeTNFX2J0Z3Bsg1U/Bt8zZd7NkvAy2zqAG5tuqKENlh2QQyoDKFM8/lk6l3trDM9xEalYdeOb47cQf0fZuuKCF4LEF5ABtR1BxZZ5q2Z3DHFbH+a92Io2xTalXxCqJWiRuMnzP9xLwoh8U2RIyUU7iqAAQeLSX6zFfaD/9xUbaAVTbSvtx5paK2LttHRAjbHulHXnkcSmCnO1m0LMvViH5N4LjhRkkLoTwKJzZ0VBQfWkL55JpY1w/CiP7ZzUJE9dkcukCzk5mbSQYBapQcKJYhdBSbF1CIhOWamg344rVlyNKgXdHFBdpn6uVzZS6ws6KAO4ihND1JZri82/spG4+CeBBrcAylOdKO8/tvwURA9aQBd3iwMJ0/u91+b/w+V7ZlwFfFfzLVG4ZT6fPFwJUMAJMQgZz8QPR1rbrk9zZ+pLNl5V73QJ25d+kfdIadj8bIn+YIB8la2CzSz35GzMxApvArPMG+FtqJIc/L+sXJdHK4Ybr4RGZRhchLdd8Vh046CWa9w0DUTvgLMlbNe7oiJP3GanxSIWBbE6/Tw9/tOGwPrFaamP3PjN6sKfrTvbmbIB7tJ1s9kDgkgZ8JDL1uLoTrHusMPQLS4Iaya/pPZFZRs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(11063799006)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A4r7micWh98YF8i6jdaSfJvqvS6HLwJD+tqkKRJ9rp9wc6XsK5psnDvRoJxV?=
 =?us-ascii?Q?SSCB6iumtX8usncw0yxgI7TrZ8eE4TXhGFPBhEsgatejO+bZk2KGozm0UAua?=
 =?us-ascii?Q?VjeW98OA5B02lh2j/yAZlCvv6CvZQ6mioR60xmSZZoxEtqimk1HNF55RC5Eg?=
 =?us-ascii?Q?j2kUJGENJqDJt+x0t7DOpYzcrfT6fEnYaOT3qTN8+s3IlvJQEA9l9WeGaZgv?=
 =?us-ascii?Q?bu6MS79JEeibbiV8jFgu9x+ntMhI7Q4Gzzy9mqB6GL52FyMYM1ncB3oTznh/?=
 =?us-ascii?Q?8c153N/fAHYHx7zZ4GpKoa81tEWNHrvPzBoMsB6+nkscg/Q5anMG2fY160re?=
 =?us-ascii?Q?BbRjQy/+Nn8kV3mYrHm8+FTCPxd8z8uHCyzhe9G1KHEyphdjdxENLluXPrHM?=
 =?us-ascii?Q?npfgMxgkCWEEyqgqeW5bsgOJ+I6L5vo1ScmCswuImFAe55nfza2bocbzUG9K?=
 =?us-ascii?Q?nKFwcxLMBlZG8njjKfQWwGSGU47QbCXeNI03Ste7cgxdt/l8YsP6ZD41hPf+?=
 =?us-ascii?Q?ScQPHGCGaQqH4/PqoTKTjVrdz+pBEHWnDpCJoQktK3rmmCfXxGfh0zRrP6oU?=
 =?us-ascii?Q?QkqosGwktjYd4ysL6hLgvUR4Et8XzS7Je2Le5teirqmhPraIT1csUjqtVf+4?=
 =?us-ascii?Q?15km9hLo1Qh2Ypk34P5xk54OUmdmjzqQ1s/bATuZ2iGl7o0X34KV0xuGRpn4?=
 =?us-ascii?Q?zZNhhGjs893PBWgV8aWWX/xnvZR4kNDsQ+tjsT3TkY8Wf29+HI1hNHV4/6My?=
 =?us-ascii?Q?Dq9NDytfmcfaerYXKR4H4GmlDAFv3tPv5wJt3yLCCD+OLq2qMHHJ2mFMVwDY?=
 =?us-ascii?Q?Bd7qSCK1i6g8tBlLdbWDKjFarl25C8fVVDTuQ1MxaK7Y+jWJiHPf2UdIzDP/?=
 =?us-ascii?Q?wOQAIxTC50XAgJMw4EI2rwdLfpx2g2AJDzvpW3SZtDANjnnmV3wHFeUenmVT?=
 =?us-ascii?Q?O1XJ8epGdjySPRaacw4UI0j3k/gx3xPPP4kcZ+osbEt9L+Yq4FCggvwUfhDM?=
 =?us-ascii?Q?R1Q+sB+xN53q+mvE7hrf3Fj4mTyfGTJ5SmOndhckq6s4vCZRPZuhnFaHuqBJ?=
 =?us-ascii?Q?avwbnVnJS9fm0YmiVxxCBNIY91sUjNLFlYNlrddMdS9BBKZGCWR96nbzdQIt?=
 =?us-ascii?Q?haua78yFQ6TT9wVuaQcjvY38j2ZFV5M8V9jADZklskEmARbdJqsEAW/8x9ct?=
 =?us-ascii?Q?mfiPp+Jz7KJvzZ4MuhfKAzmM5KlIqvgEy4p4VoIFAesLB1vm4StThWqJhdY4?=
 =?us-ascii?Q?Ca9Y+z/fcT4pP7AgaZn73JrlTL8kHaq5UxEeY7E2TMVIAYvcbq02DHd4Z+Zf?=
 =?us-ascii?Q?vQk+zOTaYg+SVX37D5QfAgRDE48vN3ifDPYTcNqDM+v33mHr8DLPjuc2bO9V?=
 =?us-ascii?Q?PuKh4spebbYRxgWK6lIUOs2TNJmAH7z6cRWqMnAU6tCLxwc2iW9ll5Tgm0e/?=
 =?us-ascii?Q?9Ljn2nx5MUOwW0Kb9O+pHl0lN5kLq+Oh/0g0+k5u5c5uuiiyBRAvTY7DpgCA?=
 =?us-ascii?Q?MN+JrUvVVmGt8PitPAOnjh9nAxtQBfGgUIsc2F7fyZ1SS0nXMPQd78ONvAz7?=
 =?us-ascii?Q?YiXmzo7UBhRBxAvN5CaJ4vSD65BTadQODO/hyzLfLkx3Wx6GXsOmSO+CDGQu?=
 =?us-ascii?Q?Zd1dcaIur7c0Q5O18XLR8jPUKsE7MuG/Vi+e+QoAkSeE6hJAOWRqDJyDi8mf?=
 =?us-ascii?Q?bWPfFBCcWEl/DaCTmjGu6sZZvW4dJhL384QyE5ONPX+UXC5nkXpQtYY3W16v?=
 =?us-ascii?Q?uxplojgRCg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rFD8qeZYXOCr//AciHkH/XtfzZi39SPg1yYlJXhqn4No6EY3Ql5J7CGqtod5vg6X2GV3SA9q50hYQhJvB3A+DVJK29wzl2fqn9pCnnuZw9oggiRFVZTVEJAhBM0S5JSBSLqk/7fnCmwJF1aI6VA4PnOHnePLBniB6PkgTF4cLlHiRA5nETJyeNHMIcraFCdVDwxFfc0wljzANiaeWE5kpM9PzuMrqgO5aO4m0WZjpasCy5C8Hh0nuzlWK0Fl5TpJZ60HD3wXOD7ghn3KnSacf8xSKSJX75wfuNKpIvXPQvga7BJWCws8DOKQodF3fvAhJEuIYVC80/QQUJesXB+YAw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0051f3f-66c6-41ee-146a-08df1b119bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 14:30:55.3639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BS2u0C9ykc+Lfrfmd77gfowHMOlfM9gKOXAgYYEuqYcE2d1JMXer0cZ8xIbY4oHNE7vheRiTVLswy03WsNwgFCaQyEB0v11gMrmibwpDvWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9572
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



> -----Original Message-----
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Sent: Friday, September 25, 2026 3:16 PM
> To: netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Schmidt, Michal
> <mschmidt@redhat.com>; intel-wired-lan@lists.osuosl.org;
> edumazet@google.com; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH net v5 3/6] ice: extract ice_vsi_new_stat_arrays()
>=20
> Split the allocation of a struct ice_vsi_stats and its two ring stats
> arrays out of ice_vsi_alloc_stat_arrays(), which is left with just the
> lookup and the store into pf->vsi_stats[].
>=20
> The sole caller keeps passing the very same queue counts as before,
> vsi->alloc_txq and vsi->alloc_rxq. A later commit adds a second caller
> in the rebuild path, which cannot use vsi->alloc_* because it has to
> size the arrays before the VSI is reconfigured.
>=20
> Note that the error path no longer clears pf->vsi_stats[vsi->idx]; the
> early return above guarantees it is already NULL.
>=20
> No functional change intended.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 47 +++++++++++++----------
> -
>  1 file changed, 25 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 1414127d32cd..ed32ae2667c5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -519,6 +519,30 @@ static irqreturn_t ice_msix_clean_rings(int
> __always_unused irq, void *data)
>  	return IRQ_HANDLED;
>  }
>=20
> +static struct ice_vsi_stats *ice_vsi_new_stat_arrays(int txq, int
> rxq)
> +{
> +	struct ice_ring_stats **tx_ring_stats;
> +	struct ice_ring_stats **rx_ring_stats;
> +	struct ice_vsi_stats *vsi_stat;
> +
> +	vsi_stat =3D kzalloc_obj(*vsi_stat);
> +	tx_ring_stats =3D kzalloc_objs(*tx_ring_stats, txq);
> +	rx_ring_stats =3D kzalloc_objs(*rx_ring_stats, rxq);
> +	if (!vsi_stat || !tx_ring_stats || !rx_ring_stats) {
> +		kfree(vsi_stat);
> +		kfree(tx_ring_stats);
> +		kfree(rx_ring_stats);
> +		return NULL;
> +	}
> +
> +	vsi_stat->tx_ring_stats =3D tx_ring_stats;
> +	vsi_stat->rx_ring_stats =3D rx_ring_stats;
> +	vsi_stat->tx_ring_stats_len =3D txq;
> +	vsi_stat->rx_ring_stats_len =3D rxq;
> +
> +	return vsi_stat;
> +}
> +
>  /**
>   * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
>   * @vsi: VSI pointer
> @@ -537,33 +561,12 @@ static int ice_vsi_alloc_stat_arrays(struct
> ice_vsi *vsi)
>  	/* realloc will happen in rebuild path */
>  		return 0;
>=20
> -	vsi_stat =3D kzalloc_obj(*vsi_stat);
> +	vsi_stat =3D ice_vsi_new_stat_arrays(vsi->alloc_txq, vsi-
> >alloc_rxq);
>  	if (!vsi_stat)
>  		return -ENOMEM;
>=20
> -	vsi_stat->tx_ring_stats =3D
> -		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
> -	if (!vsi_stat->tx_ring_stats)
> -		goto err_alloc_tx;
> -	vsi_stat->tx_ring_stats_len =3D vsi->alloc_txq;
> -
> -	vsi_stat->rx_ring_stats =3D
> -		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
> -	if (!vsi_stat->rx_ring_stats)
> -		goto err_alloc_rx;
> -	vsi_stat->rx_ring_stats_len =3D vsi->alloc_rxq;
> -
>  	pf->vsi_stats[vsi->idx] =3D vsi_stat;
> -
>  	return 0;
> -
> -err_alloc_rx:
> -	kfree(vsi_stat->rx_ring_stats);
> -err_alloc_tx:
> -	kfree(vsi_stat->tx_ring_stats);
> -	kfree(vsi_stat);
> -	pf->vsi_stats[vsi->idx] =3D NULL;
> -	return -ENOMEM;
>  }
>=20
>  /**
> --
> 2.51.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
