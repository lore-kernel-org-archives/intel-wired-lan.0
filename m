Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EB4CA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 11:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8E694061A;
	Mon,  5 Oct 2026 11:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WTo3XlhKVK-H; Mon,  5 Oct 2026 11:14:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4D495405F0
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791198865;
	b=ILow8VPgDSjyJzqxKUQK1FwKWAUM2Mge+yp8d5mMsx+rQ3ZwH7/R53G9rwkCM/xx4wXF
	 H/bDYTFgmqmnsKT4Y1Ds3C/c+fM6V60X/AXQAzIPpuBdBisiVSQrbWAB+ydEJ+O+Jif6K
	 d++7tmizDB96Kxt9BZ19B8wYMbRN8aE5pytb8NNVqsdcX61t2kNNXLb2JCGJC8VFd54TL
	 h2k3IiAL4dFeHA4Ahx+FqKBaqMozS4Td9e6djNm3QhYkYihKoKSGYlIPUbgquTpIkotPJ
	 Oig/2R88i/PKq5Mg8STqzSTBOgJNFS563dQ0kjFt52PVkQPthzIW5mXQFwp4PcuK6hQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791198865;
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
	bh=fkFdcDMQHxMPgpgqAJUoMmJwYCe7Q7LRCWymSwr99PU=;
	b=aut7jN8iqsRe1uuLshyHAuWxAmCNaHgo34pzvF176cHEHghYEK/9/HkuXZxANLZR3WO6
	 RjboaNnnvSLtX6n0rc7JUcQywzNDT7xCOX7x88NCVIAUH4EX+j16TWKiJkCIMm3lMb9E9
	 G7v/e3HRxi5TkWtH/uve855FFwM/0GkO7EqRVXwOsPEG8NOgySitkbGbLbOMRpdQ2ozP0
	 ZKYZz6zUoDd2KXaR+oKez4YEQ2Tf77CHbVNsGzolCdphKsAwhvMqTEr9XhSthUbOK/oOV
	 NJoOQRJvb5e85zBRiLZpS9uQB/jIhUN5iccXu9wICYOkqHtOblms8uMduc7QC1br5ZA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791198865;
	bh=fkFdcDMQHxMPgpgqAJUoMmJwYCe7Q7LRCWymSwr99PU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UVLoivEQJkdjpG3tBSs1V2r6jOGnhE7TpfK7x1VwSfOLDIF7yABa4fiqJ58FReK6F
	 qyS22oN5pqgUYX84MyN6USk3Q00LZhcuCUQQBIu0KaNHWt/zcWkVABZtVViW5ttsPz
	 AsBIbySrErEdvl4xmP7/PXmOOqW86NLNUA2oNkmSD0XeOjke0WIPBKMjDs7e9GARtN
	 klbXak/MKmId8j+IkCCLgHpDrkUv+hKHz8gcn1f7e+4pVbiiqBgypZVIYdzXZStAX6
	 NNKXILh5LIJDnyIVFeIv3ea77fhjW1jRRbdyx1kQcrlS2+iQjPAvFkJ9Sfrtwi62uC
	 UpPnSW/nmkl6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D495405F0;
	Mon,  5 Oct 2026 11:14:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D0DA1A6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:04:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E1BA80BDF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:04:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4r_4pVIv8l3W for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 11:04:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CBAC380BDD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791198261;
 b=iJhYzV7WsuTy51derYjXyCnU8lVVpmcZy8b6IRctprocUT7Uzyi7cnLBd812LZ6eHZDs
 U2RiK3vuMoehxS6I2BZUkXBEezgfqGge9v193a1wmD7bdMrcCQVi8iOZhFoUSDHB3+2sB
 cVjpfOda9pW4UCWqXE1mTP8FRJmKvehGVNd+kXi79K1O3exHcj9gu1XIng9OaglGIUbVo
 EY0W92AXYPnx97PCuGJh2KpWVzlyKs3qbqgn/7cBKFNtUwEct+V75i1pHpcvGqCzc0KIC
 XU9nnCCH1a5maM46DgwUb2PP4s5e0gAAFbpDNBFkL2uIc3+am0RPNsHxnmLFycs8YzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198261;
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
 bh=fkFdcDMQHxMPgpgqAJUoMmJwYCe7Q7LRCWymSwr99PU=;
 b=VFpUvD8gmpcpRvrnUZcVzuoSNaqqPf2DlZDpGTmV/kE610aBpzVDDaY8BtQJKr7o5yCh
 1BkLz8pxVSyuHsFk13uKdvk0bRfxb42kHw/sZrH0JVyPIEAGt8RKO9PQ/Ww7g/VaVVoi4
 mDq1De2POBWZEX70o8o2kPypPkFW6CuBXSNFF38Hd+b9cvhubTND5QoVJ8z76twfbq7VL
 siEtOuFMB0XwYouSvDEun6Uw0f8gwVmwr8fX/W1Bqri0Y1ssAcbmQMIZzO512ez+eeGgz
 goK9mnh5133eBbjyw6vQpgKv8TbU/qkdQSa+BYpMRnrpzI36P/cGjYs5Aj6MgQqQzoA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kjj6e3Jf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kjj6e3Jf
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBAC380BDD
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791198261; x=1822734261;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fkFdcDMQHxMPgpgqAJUoMmJwYCe7Q7LRCWymSwr99PU=;
 b=kjj6e3JfiQEUzC85vj9ki2K2He1DRBOvwc5kZWgNb6LSFk0x6F+5US+F
 vObP0YVH0OEMwJBV+sXh4Gvbx499e0QM2G5n6cNPT0vGatIKauGKWab2O
 BlJXVODHFpVLbqdSu0QQlReWUd5LxEhg2ALPQmiK8I2W3MmfUk3TZozGe
 20D8NkeR3FRP4dtUyZOvvEnKvIf0p6e2sLIGSI2j/qwmZNhOSVjb8h5id
 f4gF+MDSloxVAqNpmincP6c2WXpDIbhNVI3+Iv1DpRPLQOGQXMAoomwYl
 t6rtefF+oJiY4gmzq71GxIbge57o1+wnPOIWFpNszsXN0bDG4E1eVd/fe A==;
X-CSE-ConnectionGUID: ACCNxqYzTcWtGzalDXp/Pg==
X-CSE-MsgGUID: Si9W5HRdTq607tqZ2HBkzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="94356164"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="94356164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:04:20 -0700
X-CSE-ConnectionGUID: eTMTOcBwRXaW7ZbelGvgxQ==
X-CSE-MsgGUID: m+Zfh/DgQ9qcx1cxFR0sSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="284675618"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:04:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 04:04:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 04:04:19 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 04:04:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pw2ZxdbXDtgGp3TE2YtTJsT9ZiypCUvfAxZ4YmDg/yIZdEfI4eGK074jSTgnE2IQ3fUzJSXL1fPahnNRwrCE3J4VYAutEjIogblIf2SADPuDOq0fDKa+OgHSA2K7b8gghOELYhenpqHqz5mEzzATyvLfYUvwsDukdj5c9fr+Gd9Q/Um/XezbOy/5WyIvmQHLxFulhgQ0/2diTsQNwkP7CHcP2bOHjIdBvS0FFXa3V2WNrBVO2UcboCK2CstWgBMHzJYiDyEJHq8aAFvBh+VtbvPyIyHX0GNdkLn4cCdD0bjeS3kCOKxiPGgDCCltBaJ9nzgQxy9FxAiZY9N/U+ZeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkFdcDMQHxMPgpgqAJUoMmJwYCe7Q7LRCWymSwr99PU=;
 b=aATej/XoQu9tkGs9LojpkyAr094GRQKrv8mIx4YGAcOwZuT26wFTWeVhmm2hnETgvRRrjQhdY1wLQ8vTiWBhQY9LMSk6xUok86KKneYJOLdOGYEnQcRHmCIVopygcyNWVZaS7YIi3eYCdQ7pE48agTL0mo8px73GOfqYlk6cCTnaYQgkVq4MmByqrDkhitLVlmPxSewRbwgCodNQefcupzOBS6s9z7MMJIN1FiqkK7RmA/FyJqC1JtT1cVHL2Dv8DJkd77B6geOoYiQFXo091ioQsjyy3SnO1+/0MSPmQ4Ih9e8bDg/XLKTVaiuKMRivFTg3C8I8e/Z5FshAKB9t1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 11:04:17 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 11:04:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v3 09/15] ice: E825: clear
 PHY_REG_TX_MEMORY_STATUS prior to soft reset
Thread-Topic: [PATCH iwl-net v3 09/15] ice: E825: clear
 PHY_REG_TX_MEMORY_STATUS prior to soft reset
Thread-Index: AQHdTUnFKDtnEyfI8EudxGSnecEe+7bu1+qw
Date: Mon, 5 Oct 2026 11:04:17 +0000
Message-ID: <IA3PR11MB89862C989E49388E54ED9298E5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-9-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-9-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS7PR11MB7784:EE_
x-ms-office365-filtering-correlation-id: 27ce241a-158a-4299-e97c-08df22d0662c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|11063799006|4143699003|6133799003|921020|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: KqS7K9NbmVQH45nZX4i/StXQfvnK5XKr9N3VGs1s4gc1iJwgh7NqmUXM5iNQ4gNWPWVg5VQ51RHcHYKhCHvYRI0RF6/Vqrbl6/LwM/pMMylFovx4RkhN3YLYxmmm+OYmQA52G1y+w1K1AH06Ug/YIjuqyqtKrb7v9cih4W8pJxNgMxxw7kxxN7Dt/NO4nIjq4FDHI8sbfk5M8dI1UJdPF1nWvETmJL4gGejIb0kah+9jh630HqjNhE0PON2xp0XX/SVgfPhj+da4Qi4DdbOjy/vRnG1x3RQjM2CEu3S0JPUKqoC+ge3EC2dGxt6Pxv7btQTmczas9cLEQFaCez/cQ3CTYR8LJAiLI6cMqsCFKiUCYb+c8GmwYdw/YGI6DFrJb+Sxa11KUYPR0byB6dkNZq/HNSccVPDjgNCVWoAtUD9+IB9SnJguA8lZsoiIpSQHD9S9Y3fDEHucwIyBgtBTnx8Ef2/U/Ld4jA26wPIqADgd/VhsRktF7wFka2uJuwteS/4mPZmlN2fJ+qs8xQLmmNWkN9Q3ZCgA+N8WWPCf6PIpfNm3LywErUEwwcg/pHK/kN6Z3GglBp7UOF4Gb8upIp+tlYRKbZE8vyaQ3KCch63rJrXo5+Gswc/n7XPnRFEPxieifdVFyjFi5OqhilEw1tFuNgk7bTW8h6lP08kr3cY1DWUyBSQPLtrqGb5nn/JOQ/hs29I1rvahQhKCbGFainL7G9Jp6YJdbSzkU7P1eRvo3/XiuQMPwcYzPYEf9iWD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(921020)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VThrLzJ4SjkxVHExcnl2a2w4ZVphYlIreE9hT21PMnBuS3lTSFVVSXFCOXBO?=
 =?utf-8?B?OE5NMG9rUGl5MWIrN0hDV2tDcHUxZElQOG9BenZrMENCVG9seGFVNTVCSjYy?=
 =?utf-8?B?RlV1NGQ1VVZaeFEyaTZqT0N1TGJLU3N0MVUvNmpWSXg2dTc4T0JUdmJWLytS?=
 =?utf-8?B?M0tWTktGU1JtbHBqQUhaaEVDRGNqbWFyU2ZrR2tYeXBXekhGRGNPRlZleER1?=
 =?utf-8?B?S0NnYmFHYnA5c1dLNkJreDJudjQ1bWNSU1FVRGhXckgzZk9qbjFjTXRMMzIr?=
 =?utf-8?B?NU9scXA1dlBOdkl4R2hYeUtuN00zekR4WGJxbEM4WHNERm1KRWFJUTBYd3hL?=
 =?utf-8?B?a1JtMnVjVkppUXRoRWZPcmtRTVZqdHdacXBIcFRibjV4NTVJVU1pQUhFb3Fl?=
 =?utf-8?B?RlZsMnBXcXEyWE53djJveHNiMm9oOGFlMkFrSXgzVnBmK1lKZXRoREtHdTFS?=
 =?utf-8?B?dWk4cTNqODhkR3RoZjRDM254SW13YjRIRnVqTGozSkwxZlRoWVJBNVJ1TEdm?=
 =?utf-8?B?V0xVOU9nWHpqK2N1SnhQK3JuZzJuTFhYNHZqMktHb2ZUSmhjYlpabkhoYm9l?=
 =?utf-8?B?T1AzV3EwYkFxdU9xcTR0eU5IdVl4WVpLWmtQS0MyT3pKU2JkV3Zla0RFWmJ2?=
 =?utf-8?B?ampESG13RVVybGpwOGtteVM3VU9IZzdCYklodXk0bzZSWU1mRitmaGRhdWF5?=
 =?utf-8?B?R0JUdUtCdVAvTDU0SG11VUdaZlhxKzdPY2VwQ3p4U3B4Z2ZTZFFycnVPUDlq?=
 =?utf-8?B?aXpDd3lpMHM1UGRPOTgwV2FNVFBIZUtHNng2WCtJeUsvVlVPNmt6NXIvTGlN?=
 =?utf-8?B?VXROR0VkS1YxUEpjRDF5eFBQc0EwWWhSd05IbFlnb2FFWUl4bXR0cWd0ajlV?=
 =?utf-8?B?MmxBNmZjc2hoUHJzNlBZM0hpdGU0YXc2cDFSL20vdHlsUVIyMWRrcjlTaHZw?=
 =?utf-8?B?cW1PUEd0OVpnYUYwaUQyWDRzSmZFYTMvU1Q3TWcveEpGSXhwbkpiTmRicGtP?=
 =?utf-8?B?emFHZ2RoUUd3ZXN0a2FNWnI2UXZGbVdoUStNS1ZaampYMGdVeFRyUXdTOUxi?=
 =?utf-8?B?c0JUTnpPc1NSTUhtWlRBSWtNOW5XeitWcXhldy93R2l4ZjYzeXlmMUl1a0hh?=
 =?utf-8?B?MVJoSlNzaE9hUFcwbG1KU1pJSHRuWmtEVWY1L0gxazFaL2o1c0diWXZZZ2xa?=
 =?utf-8?B?OGNxUlVhMmVhWldLK1hEMkFsa3I1d0o2d3NsVmgxaEVWeDdRMUYzTGJjTVlY?=
 =?utf-8?B?N1c1Q1dvSFltdzcyYmo4NUdZSHUzSTVzdENjVnZ0cFA4Y0RjOHFGbldPUUlM?=
 =?utf-8?B?YTdxL3hkM2tPYkFKSkdXSHl2c1VKMENJazNOY2NRMldXd2ZYdnZIbWUyN3pI?=
 =?utf-8?B?MXdPTFNTWGxzbDdMbUE1VVZmVmRrTXZjZnc2bVY1QStQUDFWWnN6dHNSQ2Vy?=
 =?utf-8?B?enV6c3ZNMFpOYlpNajd0RFh5YUJvY2FwSURFOEhRblhwSml5bmxIUm5SRUhX?=
 =?utf-8?B?bjRBZnhtT0U2cVdFZmtPK0F3aFV5b1l5clZHeTlGcU1Ja1BTY09ldEhkNklR?=
 =?utf-8?B?ckczTVpPRFJTbnlUdXBkTVNIcjQ0QVRFSXRucWZITTdxaWdiSFd1TkVPa1N6?=
 =?utf-8?B?SHcydzZabWVsZEs1RDZtYy9MTHM3TXV1MEN4clJPYlcwczVhWEQ2MnI4YlZv?=
 =?utf-8?B?cGxRN1g3TzczQm9mMjdLNEhWRU8zN1M2NG82dE9PYmpzZFY3TzlDNkZVQmJ1?=
 =?utf-8?B?aWVkN3dNWUpxRWFkT2xtVUlQWTVOMGFWWnJYS2Vac1B3T0N3MzN3YVpkNnBO?=
 =?utf-8?B?dmpwZnJSaWxoZVZJU0dRODU4cWZqR0t3UDZxRUlSTjZVQlUxQmN6NVpjaTQr?=
 =?utf-8?B?N0VGVG9sa1ZQSFQxbmdabWcyS2FlejN6RnNWU0xLQktGdFo3bUtFeTVuUE82?=
 =?utf-8?B?WHpIWmg5MW9VWHpHbTVXUStna3IzNWVYLy8yUk10ZGt4Ynh2VExWL3NZSzhx?=
 =?utf-8?B?Y1hjRDFCRjI4Yll4ODRRMDh3YnoydTNiQUk4K2hidXNUNVRQMUhhRDA1S2Jt?=
 =?utf-8?B?NU05bjlTbWljZFZpOWtwWjcvWkdyK3c1LzhHKzRDM21uS2luYXFsbHYxbTFi?=
 =?utf-8?B?RnJ3Z045b2V6WTFVRGZWVi9HYmxnNWJKVmVRT3B5bTN1eCtYcXY0Y2NPMDJh?=
 =?utf-8?B?SktNMFRWb2FNVmF1MDdoZWFrUG9kMnN4d1lVMithMENxQVA5Z29UWFpkTW5C?=
 =?utf-8?B?blFEOStyaXBRQUFWZGdkQ3BBbHh0cmlYZEp3RmdlcVpEeXJZZkduQXJ5WDFt?=
 =?utf-8?B?cGp2c29RY0w3bXNyb2Z2Y09ZNVFQZXZvdSs4aFkzT2xmQlR4Zy85elAvZVVx?=
 =?utf-8?Q?OBwC8AzkA05Duy8Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l/a0iWzvlTRejCm+8uYlefWazkCz0Hdw621mvyeEh2ek94elOD5M+nVLAUGLYyliOxeU89ixwfj4vw5hTV9h76XHwBTUqiW9+cJ7qFYfMEeh44Rasv5EbKhPYcW0/6CJKlmveFKK6j0gQnEOesk+r3GaAGPFZtR5260eUSobeNA+1WpOd9+T8HVvvnZJES5X4KR3iBnwRp1xr5tEid20gy+fx8Olmdrw8jvDTQvjsaN+bzeebIpXibHqT6t0V686pnGkurvXyQqdRxDdugYwfl8rHqNZrIrn3oCM2gz3dEE3f09BpN90yIIi9ldFT/I8g11IsjZhOkHgHa+yJ83YfA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ce241a-158a-4299-e97c-08df22d0662c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 11:04:17.2507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4pmYZiWkjG7qwjNE/ZxPLKO4m8q5Gc6VyywD0tuYbo5YA/r5BfrvAyT234jnBqVOWf4xjC1RY8j2uIy7qqGy9ds5rakDuII8byVlBBGS9A=
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
SmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgTWFjaG5pa293c2tpLCBNYWNpZWoN
Cj4gPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggaXds
LW5ldCB2MyAwOS8xNV0gaWNlOiBFODI1OiBjbGVhcg0KPiBQSFlfUkVHX1RYX01FTU9SWV9TVEFU
VVMgcHJpb3IgdG8gc29mdCByZXNldA0KPiANCj4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24g
b2YgaWNlX3B0cF9yZXNldF90c19tZW1vcnlfZXRoNTZnKCkgaXMNCj4gZmxhd2VkLg0KPiBJdCB0
cmllcyB0byBjbGVhciB0aGUgdGltZXN0YW1wIG1lbW9yeSBieSB3cml0aW5nIHRvIHRoZQ0KPiBQ
SFlfUkVHX1RYX01FTU9SWV9TVEFUVVMgcmVnaW9uLiBUaGlzIGRvZXMgbm90IHdvcmsgcHJvcGVy
bHksIGFzIGl0DQo+IGRvZXMgbm90IHRyaWdnZXIgYXBwcm9wcmlhdGUgUEhZIGFjdGlvbnMuDQo+
IA0KPiBUbyBjbGVhciBvdXRzdGFuZGluZyB0aW1lc3RhbXAgbWVtb3J5LCB0aGUgZHJpdmVyIG11
c3QgcmVhZCB0aGUNCj4gdGltZXN0YW1wcy4NCj4gSG93ZXZlciwgbmFpdmVseSBkb2luZyB0aGlz
IGFzIHBhcnQgb2YgaWNlX3B0cF9yZXNldF90c19tZW1vcnkoKSBpcw0KPiBwcm9ibGVtYXRpYy4g
V2hlbiByZWFkaW5nIHRoZSB0aW1lc3RhbXAgaW5kZXgsIGhhcmR3YXJlIGtpY2tzIG9mZiBhDQo+
IGNoYWluIG9mIGFjdGlvbnMgaW5jbHVkaW5nIGNsZWFyaW5nIHRoZSByZWFkeSBiaXRtYXAgaW5k
ZXgsIGFuZA0KPiBkZWNyZW1lbnRpbmcgYW4gaW50ZXJuYWwgY291bnRlciBpZiB0aGUgdGltZXN0
YW1wIGluZGV4IHdhcyBtYXJrZWQgYXMNCj4gdmFsaWQuDQo+IA0KPiBUaGlzIGNhbiBwb3RlbnRp
YWxseSBsZWF2ZSB0aGUgaW50ZXJuYWwgaGFyZHdhcmUgY291bnRlciBvdXQgb2Ygc3luYw0KPiB3
aXRoIHRoZSBhY3R1YWwgbnVtYmVyIG9mIHRpbWVzdGFtcHMuIFRoaXMgb2NjdXJzIGJlY2F1c2Ug
dGhlDQo+IFBIWV9SRUdfVFhfTUVNT1JZX1NUQVRVUyByZWdpb24gaXMgbm90IHplcm8taW5pdGlh
bGl6ZWQgd2hlbiB0aGUNCj4gZGV2aWNlIGJvb3RzIHVwLiBJbnN0ZWFkLCBpdCBpcyBmaWxsZWQg
d2l0aCBnYXJiYWdlLiBPbiBhIGNvbGQgcG93ZXINCj4gb24sIGF0dGVtcHRzIHRvIHJlYWQgdGhl
IHN0YWxlIGRhdGEgcmVzdWx0IGluIHRoZSBoYXJkd2FyZSB0cmlnZ2VyaW5nDQo+IGEgY291bnRl
ciBkZWNyZW1lbnQgZm9yIGEgdGltZXN0YW1wIHRoYXQgbmV2ZXIgaGFwcGVuZWQuIFRoaXMNCj4g
dW5kZXJmbG93cyB0aGUgY291bnRlciwgYW5kIHByZXZlbnRzIG5ldyB0aW1lc3RhbXAgaW50ZXJy
dXB0cyBmcm9tDQo+IGJlaW5nIHRyaWdnZXJlZCBmb3IgcmVhbCB0aW1lc3RhbXAgcmVxdWVzdHMu
DQo+IA0KPiBXZSBtdXN0IHJlYWQgdGhlIFBIWV9SRUdfVFhfTUVNT1JZX1NUQVRVUyBpbiBvcmRl
ciB0byBjbGVhciBzdGFsZQ0KPiB0aW1lc3RhbXBzLiBCdXQgZG9pbmcgc28gbWF5IGNhdXNlIGEg
ZGVzeW5jIHdpdGggdGhlIGNvdW50ZXIuIFRvDQo+IHByZXZlbnQgaXNzdWVzLCBwZXJmb3JtIHRo
aXMgY2xlYXJpbmcgYWx3YXlzIGFuZCBvbmx5IHJpZ2h0IGJlZm9yZQ0KPiBpbml0aWF0aW5nIGEg
UEhZIHNvZnQgcmVzZXQuDQo+IA0KPiBUaGUgc29mdCByZXNldCB3aWxsIGNsZWFyIGFuZCByZXNl
dCB0aGUgaW50ZXJuYWwgY291bnRlciBhbmQgdGhlIHJlYWR5DQo+IGJpdG1hcC4gVGhlIHJlYWRz
IHRvIFBIWV9SRUdfVFhfTUVNT1JZX1NUQVRVUyB3aWxsIHJlc2V0IHRoZSByZWdpb24NCj4gdmFs
aWQgYml0cyBlbnN1cmluZyB0aGF0IG5vIHN0YWxlIGRhdGEgaXMgbGVmdCBiZWhpbmQuIFRoaXMN
Cj4gY29tYmluYXRpb24gZW5zdXJlcyB0aGF0IHdlIGFsd2F5cyBoYXZlIGEgY2xlYW4gc2xhdGUg
d2l0aCBubyBzdGFsZQ0KPiBkYXRhIGFuZCB3aXRoIHRoZSBjb3VudGVyIHByb3Blcmx5IHJlc2V0
IHRvIHplcm8uDQo+IA0KPiBJZiBhIHJlYWQgZmFpbHMgKGkuZS4gZHVlIHRvIGEgdHJhbnNpZW50
IHNpZGViYW5kIHF1ZXVlIGZhaWx1cmUpIGl0IGlzDQo+IG5vdCB0cmVhdGVkIGFzIGEgZmF0YWwg
ZXJyb3IuIFRoZXJlIGlzIGFscmVhZHkgYSBkeW5hbWljIGRlYnVnIG1lc3NhZ2UNCj4gZm9yIGVh
Y2ggcmVhZCBmYWlsdXJlLiBLZWVwIHRyYWNrIG9mIHRoZSB0b3RhbCBudW1iZXIgb2YgdGltZXN0
YW1wDQo+IHJlZ2lzdGVycyB0aGF0IGZhaWwgZm9yIGEgZ2l2ZW4gcG9ydCBhbmQgbG9nIGEgd2Fy
bmluZyBtZXNzYWdlDQo+IGluZGljYXRpbmcgdGhlIHRvdGFsIG51bWJlciBvZiBmYWlsdXJlcy4g
Q29udGludWluZyBpcyBhY2NlcHRhYmxlIGFzDQo+IGNsZWFyaW5nIHRoZSBtZW1vcnkgaXMgYSBw
cmVjYXV0aW9uIGFnYWluc3QgZmF1bHR5IHNvZnR3YXJlLiBDb3JyZWN0DQo+IHNvZnR3YXJlIGFj
Y2VzcyB3b24ndCByZWFkIHRoZSBpbmRleCB0d2ljZSBhbmQgd29uJ3QgcmVhZCBpdCBhdCBhbGwN
Cj4gZXhjZXB0IHdoZW4gaXQgaGFzIGFscmVhZHkgY29uZmlybWVkIHRoYXQgdGhlIGluZGV4IGlz
IHZhbGlkIGJ5DQo+IHJlYWRpbmcgaWNlX2dldF9waHlfdHhfdHN0YW1wX3JlYWR5KCkuDQo+IA0K
PiBGaXhlczogM2VjNDZlMTU3YzdmICgiaWNlOiBwZXJmb3JtIFBIWSBzb2Z0IHJlc2V0IGZvciBF
ODI1QyBwb3J0cyBhdA0KPiBpbml0aWFsaXphdGlvbiIpDQo+IFJldmlld2VkLWJ5OiBNYWNpZWsg
TWFjaG5pa293c2tpIDxtYWNpZWoubWFjaG5pa293c2tpQGludGVsLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcuYyB8IDEwMCArKysrKysr
KysrKysrKystLS0tDQo+IC0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUyIGluc2VydGlv
bnMoKyksIDQ4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwX2h3LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX3B0cF9ody5jDQo+IGluZGV4IDA3YjU1ZmJiODhkZC4uZTgzYWQyYmI4ZDQy
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9o
dy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwX2h3LmMN
Cj4gQEAgLTczNywyNCArNzM3LDYgQEAgc3RhdGljIGludCBpY2VfcmVhZF9wb3J0X21lbV9ldGg1
Nmcoc3RydWN0IGljZV9odw0KPiAqaHcsIHU4IHBvcnQsIHUxNiBvZmZzZXQsDQo+ICAJcmV0dXJu
IGljZV9yZWFkX3BvcnRfZXRoNTZnKGh3LCBwb3J0LCBvZmZzZXQsIHZhbCwNCj4gRVRINTZHX1BI
WV9NRU1fUFRQKTsgIH0NCj4gDQo+IC0vKioNCj4gLSAqIGljZV93cml0ZV9wb3J0X21lbV9ldGg1
NmcgLSBXcml0ZSBhIFBIWSBwb3J0IG1lbW9yeSBsb2NhdGlvbg0KPiAtICogQGh3OiBwb2ludGVy
IHRvIHRoZSBIVyBzdHJ1Y3QNCj4gLSAqIEBwb3J0OiBQb3J0IG51bWJlciB0byBiZSByZWFkDQo+
IC0gKiBAb2Zmc2V0OiBPZmZzZXQgZnJvbSBQSFkgcG9ydCByZWdpc3RlciBiYXNlDQo+IC0gKiBA
dmFsOiBQb2ludGVyIHRvIHRoZSB2YWx1ZSB0byByZWFkIChvdXQgcGFyYW0pDQo+IC0gKg0KPiAt
ICogUmV0dXJuOg0KPiAtICogKiAlMCAgICAgIC0gc3VjY2Vzcw0KPiAtICogKiAlRUlOVkFMIC0g
aW52YWxpZCBwb3J0IG51bWJlciBvciByZXNvdXJjZSB0eXBlDQo+IC0gKiAqICVvdGhlciAgLSBm
YWlsZWQgdG8gd3JpdGUgdG8gUEhZDQo+IC0gKi8NCj4gLXN0YXRpYyBpbnQgaWNlX3dyaXRlX3Bv
cnRfbWVtX2V0aDU2ZyhzdHJ1Y3QgaWNlX2h3ICpodywgdTggcG9ydCwgdTE2DQo+IG9mZnNldCwN
Cj4gLQkJCQkgICAgIHUzMiB2YWwpDQo+IC17DQo+IC0JcmV0dXJuIGljZV93cml0ZV9wb3J0X2V0
aDU2ZyhodywgcG9ydCwgb2Zmc2V0LCB2YWwsDQo+IEVUSDU2R19QSFlfTUVNX1BUUCk7DQo+IC19
DQo+IC0NCj4gIC8qKg0KPiAgICogaWNlX3dyaXRlX3F1YWRfcHRwX3JlZ19ldGg1NmcgLSBXcml0
ZSBhIFBIWSBxdWFkIHJlZ2lzdGVyDQo+ICAgKiBAaHc6IHBvaW50ZXIgdG8gdGhlIEhXIHN0cnVj
dA0KPiBAQCAtMTEzNCwxNiArMTExNiwxMiBAQCBzdGF0aWMgaW50IGljZV9yZWFkX3B0cF90c3Rh
bXBfZXRoNTZnKHN0cnVjdA0KPiBpY2VfaHcgKmh3LCB1OCBwb3J0LCB1OCBpZHgsDQo+ICAgKiBA
cG9ydDogdGhlIHF1YWQgdG8gcmVhZCBmcm9tDQo+ICAgKiBAaWR4OiB0aGUgdGltZXN0YW1wIGlu
ZGV4IHRvIHJlc2V0DQo+ICAgKg0KPiAtICogUmVhZCBhbmQgdGhlbiBmb3JjaWJseSBjbGVhciB0
aGUgdGltZXN0YW1wIGluZGV4IHRvIGVuc3VyZSB0aGUNCj4gdmFsaWQgYml0IGlzDQo+IC0gKiBj
bGVhcmVkIGFuZCB0aGUgdGltZXN0YW1wIHN0YXR1cyBiaXQgaXMgcmVzZXQgaW4gdGhlIFBIWSBw
b3J0DQo+IG1lbW9yeSBvZg0KPiAtICogaW50ZXJuYWwgUEhZcyBvZiB0aGUgNTZHIGRldmljZXMu
DQo+ICsgKiBSZWFkIHRoZSB0aW1lc3RhbXAgaW5kZXggdG8gZW5zdXJlIHRoYXQgdGhlIHZhbGlk
IGJpdCBpcyBjbGVhcmVkDQo+IGFuZA0KPiArIHRoZQ0KPiArICogdGltZXN0YW1wIHN0YXR1cyBi
aXQgaXMgcmVzZXQgaW4gdGhlIFBIWSBwb3J0IG1lbW9yeS4NCj4gICAqDQo+IC0gKiBUbyBkaXJl
Y3RseSBjbGVhciB0aGUgY29udGVudHMgb2YgdGhlIHRpbWVzdGFtcCBibG9jayBlbnRpcmVseSwN
Cj4gZGlzY2FyZGluZw0KPiAtICogYWxsIHRpbWVzdGFtcCBkYXRhIGF0IG9uY2UsIHNvZnR3YXJl
IHNob3VsZCBpbnN0ZWFkIHVzZQ0KPiAtICogaWNlX3B0cF9yZXNldF90c19tZW1vcnlfcXVhZF9l
dGg1NmcoKS4NCj4gLSAqDQo+IC0gKiBUaGlzIGZ1bmN0aW9uIHNob3VsZCBvbmx5IGJlIGNhbGxl
ZCBvbiBhbiBpZHggd2hvc2UgYml0IGlzIHNldA0KPiBhY2NvcmRpbmcgdG8NCj4gLSAqIGljZV9n
ZXRfcGh5X3R4X3RzdGFtcF9yZWFkeSgpLg0KPiArICogVGhpcyBmdW5jdGlvbiBzaG91bGQgb25s
eSBiZSBjYWxsZWQgb24gYW4gaW5kZXggd2hvc2UgYml0IGlzIHNldA0KPiArIGFjY29yZGluZw0K
PiArICogdG8gaWNlX2dldF9waHlfdHhfdHN0YW1wX3JlYWR5KCksIG9yIGFzIHBhcnQgb2YgYSBm
dWxsIHN3ZWVwIHdoZW4NCj4gKyBwYWlyZWQNCj4gKyAqIHdpdGggYSBQSFkgc29mdCByZXNldCB2
aWEgaWNlX3B0cF9waHlfc29mdF9yZXNldF9ldGg1NmcoKS4NCj4gICAqDQo+ICAgKiBSZXR1cm46
DQo+ICAgKiAqICUwICAgICAtIHN1Y2Nlc3MNCj4gQEAgLTExNTIsMjQgKzExMzAsMTYgQEAgc3Rh
dGljIGludCBpY2VfcmVhZF9wdHBfdHN0YW1wX2V0aDU2ZyhzdHJ1Y3QNCj4gaWNlX2h3ICpodywg
dTggcG9ydCwgdTggaWR4LCAgc3RhdGljIGludA0KPiBpY2VfY2xlYXJfcHRwX3RzdGFtcF9ldGg1
Nmcoc3RydWN0IGljZV9odyAqaHcsIHU4IHBvcnQsIHU4IGlkeCkgIHsNCj4gIAl1NjQgdW51c2Vk
X3RzdGFtcDsNCj4gLQl1MTYgbG9fYWRkcjsNCj4gIAlpbnQgZXJyOw0KPiANCj4gLQkvKiBSZWFk
IHRoZSB0aW1lc3RhbXAgcmVnaXN0ZXIgdG8gZW5zdXJlIHRoZSB0aW1lc3RhbXAgc3RhdHVzDQo+
IGJpdCBpcw0KPiAtCSAqIGNsZWFyZWQuDQo+ICsJLyogUGVyIHRoZSBQSFkgc3BlYywgcmVhZGlu
ZyB0aGUgdGltZXN0YW1wIG1lbW9yeSBsb2NhdGlvbiBpcw0KPiB3aGF0DQo+ICsJICogY2xlYXJz
IHRoZSBlbnRyeSdzIHZhbGlkIGJpdCBhbmQgaXRzIGNvcnJlc3BvbmRpbmcgKHJlYWQtDQo+IG9u
bHkpDQo+ICsJICogdHNfbWVtb3J5X3N0YXR1cyBiaXQuDQo+ICAJICovDQo+ICAJZXJyID0gaWNl
X3JlYWRfcHRwX3RzdGFtcF9ldGg1NmcoaHcsIHBvcnQsIGlkeCwNCj4gJnVudXNlZF90c3RhbXAp
Ow0KPiAgCWlmIChlcnIpIHsNCj4gIAkJaWNlX2RlYnVnKGh3LCBJQ0VfREJHX1BUUCwgIkZhaWxl
ZCB0byByZWFkIHRoZSBQSFkNCj4gdGltZXN0YW1wIHJlZ2lzdGVyIGZvciBwb3J0ICV1LCBpZHgg
JXUsIGVyciAlZFxuIiwNCj4gIAkJCSAgcG9ydCwgaWR4LCBlcnIpOw0KPiAtCX0NCj4gLQ0KPiAt
CWxvX2FkZHIgPSAodTE2KVBIWV9UU1RBTVBfTChpZHgpOw0KPiAtDQo+IC0JZXJyID0gaWNlX3dy
aXRlX3BvcnRfbWVtX2V0aDU2ZyhodywgcG9ydCwgbG9fYWRkciwgMCk7DQo+IC0JaWYgKGVycikg
ew0KPiAtCQlpY2VfZGVidWcoaHcsIElDRV9EQkdfUFRQLCAiRmFpbGVkIHRvIGNsZWFyIGxvdyBQ
VFANCj4gdGltZXN0YW1wIHJlZ2lzdGVyIGZvciBwb3J0ICV1LCBpZHggJXUsIGVyciAlZFxuIiwN
Cj4gLQkJCSAgcG9ydCwgaWR4LCBlcnIpOw0KPiAgCQlyZXR1cm4gZXJyOw0KPiAgCX0NCj4gDQo+
IEBAIC0xMTc3LDE5ICsxMTQ3LDQzIEBAIHN0YXRpYyBpbnQgaWNlX2NsZWFyX3B0cF90c3RhbXBf
ZXRoNTZnKHN0cnVjdA0KPiBpY2VfaHcgKmh3LCB1OCBwb3J0LCB1OCBpZHgpICB9DQo+IA0KPiAg
LyoqDQo+IC0gKiBpY2VfcHRwX3Jlc2V0X3RzX21lbW9yeV9ldGg1NmcgLSBDbGVhciBhbGwgdGlt
ZXN0YW1wcyBmcm9tIHRoZQ0KPiBwb3J0IGJsb2NrDQo+ICsgKiBpY2VfcHRwX2NsZWFyX3R4X21l
bW9yeV9zdGF0dXNfZXRoNTZnIC0gUmVzZXQgb25lIHBvcnQncyBUeA0KPiArIHRpbWVzdGFtcCBt
ZW1vcnkNCj4gICAqIEBodzogcG9pbnRlciB0byB0aGUgSFcgc3RydWN0DQo+ICsgKiBAcG9ydDog
cG9ydCBudW1iZXIgdG8gY2xlYXINCj4gKyAqDQo+ICsgKiBGdWxseSByZXNldCBhIHNpbmdsZSBQ
SFkgcG9ydCdzIFR4IHRpbWVzdGFtcCBtZW1vcnkuIFBlciB0aGUgUEhZDQo+ICsgc3BlYywgdGhl
DQo+ICsgKiBvbmx5IHdheSB0byBjbGVhciBhIHRpbWVzdGFtcCB2YWxpZCBiaXQgKGFuZCBpdHMg
cmVhZC1vbmx5DQo+ICsgdHNfbWVtb3J5X3N0YXR1cw0KPiArICogYml0KSBpcyB0byByZWFkIHRo
ZSB0aW1lc3RhbXAgbWVtb3J5IGxvY2F0aW9uLCBzbyByZWFkIGV2ZXJ5IGVudHJ5DQo+ICsgZm9y
IHRoZQ0KPiArICogcG9ydCAodHdvIDMyLWJpdCByZWFkcyBlYWNoKS4gVGhpcyBkaXNjYXJkcyBh
bGwgdGltZXN0YW1wIGRhdGEgb24NCj4gKyB0aGUgcG9ydCwNCj4gKyAqIHNvIGl0IG11c3Qgb25s
eSBiZSB1c2VkIGZvciBhIGZ1bGwgcmVzZXQ7IGNhbGxlcnMgdGhhdCBtdXN0DQo+IHByZXNlcnZl
DQo+ICsgKiBpbi1mbGlnaHQgdGltZXN0YW1wcyBjbGVhciBpbmRpdmlkdWFsIGluZGljZXMgdmlh
DQo+IGljZV9jbGVhcl9waHlfdHN0YW1wKCkuDQo+ICsgKg0KPiArICogRHVlIHRvIGludGVyYWN0
aW9ucyB3aXRoIGFuIGludGVybmFsIEhXIGNvdW50ZXIgZm9yIHRoZSBudW1iZXIgb2YNCj4gKyAq
IG91dHN0YW5kaW5nIFR4IHRpbWVzdGFtcHMsIHRoaXMgKm11c3QqIG9ubHkgYmUgY2FsbGVkIGFz
IHBhcnQgb2YNCj4gdGhlDQo+ICsgKiBpY2VfcHRwX3BoeV9zb2Z0X3Jlc2V0X2V0aDU2ZygpIHBy
b2NlZHVyZS4gT3RoZXJ3aXNlLCB0aGUgaW50ZXJuYWwNCj4gKyBjb3VudGVyDQo+ICsgKiBtYXkg
YmVjb21lIG91dCBvZiBzeW5jIGFuZCBwcmV2ZW50IG5ldyB0aW1lc3RhbXAgaW50ZXJydXB0cy4N
Cj4gKyAqDQo+ICsgKiBGYWlsdXJlIHRvIHJlYWQgYSBnaXZlbiBpbmRleCAoaS5lLiBkdWUgdG8g
YSB0cmFuc2llbnQgc2lkZWJhbmQNCj4gKyBxdWV1ZQ0KPiArICogZmFpbHVyZSkgaXMgbm90IGNv
bnNpZGVyZWQgZmF0YWwgYXMgdGhlIFBIWSBwb3J0IGlzIGFib3V0IHRvIGJlDQo+IHNvZnQgcmVz
ZXQuDQo+ICsgKiBXaGlsZSB0aGUgc29mdCByZXNldCBkb2VzIG5vdCBjbGVhciB0aGUgdGltZXN0
YW1wIG1lbW9yeSwgc29mdHdhcmUNCj4gKyAqIHNob3VsZG4ndCBiZSByZWFkaW5nIHRoZSB0aW1l
c3RhbXAgbWVtb3J5IHdpdGhvdXQgYWxyZWFkeSBrbm93aW5nDQo+IGl0DQo+ICsgaXMNCj4gKyAq
IHZhbGlkIHZpYSBpY2VfZ2V0X3BoeV90eF90c3RhbXBfcmVhZHkoKSwgYW5kIHRoaXMgc3dlZXAg
aXMganVzdA0KPiArICogYSBwcmVjYXV0aW9uIHRvIGVuc3VyZSB0aGUgbWVtb3J5IGlzIGluIGEg
a25vd24gc3RhdGUuDQo+ICAgKi8NCj4gLXN0YXRpYyB2b2lkIGljZV9wdHBfcmVzZXRfdHNfbWVt
b3J5X2V0aDU2ZyhzdHJ1Y3QgaWNlX2h3ICpodykNCj4gK3N0YXRpYyB2b2lkIGljZV9wdHBfY2xl
YXJfdHhfbWVtb3J5X3N0YXR1c19ldGg1Nmcoc3RydWN0IGljZV9odyAqaHcsDQo+IHU4DQo+ICtw
b3J0KQ0KPiAgew0KPiAtCXVuc2lnbmVkIGludCBwb3J0Ow0KPiArCWludCBlcnIsIGZhaWxlZCA9
IDA7DQo+ICsJdTggaWR4Ow0KPiANCj4gLQlmb3IgKHBvcnQgPSAwOyBwb3J0IDwgaHctPnB0cC5u
dW1fbHBvcnRzOyBwb3J0KyspIHsNCj4gLQkJaWNlX3dyaXRlX3B0cF9yZWdfZXRoNTZnKGh3LCBw
b3J0LA0KPiBQSFlfUkVHX1RYX01FTU9SWV9TVEFUVVNfTCwNCj4gLQkJCQkJIDApOw0KPiAtCQlp
Y2Vfd3JpdGVfcHRwX3JlZ19ldGg1NmcoaHcsIHBvcnQsDQo+IFBIWV9SRUdfVFhfTUVNT1JZX1NU
QVRVU19VLA0KPiAtCQkJCQkgMCk7DQo+ICsJZm9yIChpZHggPSAwOyBpZHggPCBJTkRFWF9QRVJf
UE9SVDsgaWR4KyspIHsNCj4gKwkJZXJyID0gaWNlX2NsZWFyX3B0cF90c3RhbXBfZXRoNTZnKGh3
LCBwb3J0LCBpZHgpOw0KPiArCQlpZiAoZXJyKQ0KPiArCQkJZmFpbGVkKys7DQo+ICAJfQ0KPiAr
DQo+ICsJaWYgKGZhaWxlZCkNCj4gKwkJZGV2X3dhcm4oaWNlX2h3X3RvX2RldihodyksICJGYWls
ZWQgdG8gY2xlYXIgJWQgUEhZDQo+IHRpbWVzdGFtcCByZWdpc3RlcnMgZm9yIHBvcnQgJXVcbiIs
DQo+ICsJCQkgZmFpbGVkLCBwb3J0KTsNCj4gIH0NCj4gDQo+ICAvKioNCj4gQEAgLTIyOTUsNiAr
MjI4OSw3IEBAIGludA0KPiBpY2VfcHRwX3JlYWRfdHhfaHd0c3RhbXBfc3RhdHVzX2V0aDU2Zyhz
dHJ1Y3QgaWNlX2h3ICpodywgdTMyDQo+ICp0c19zdGF0dXMpDQo+ICAgKg0KPiAgICogVHJpZ2dl
ciBhIHNvZnQgcmVzZXQgb2YgdGhlIEVUSDU2RyBQSFkgYnkgdG9nZ2xpbmcgdGhlIHNvZnQgcmVz
ZXQNCj4gICAqIGJpdCBpbiB0aGUgUEhZIGdsb2JhbCByZWdpc3Rlci4gVGhlIHJlc2V0IHNlcXVl
bmNlIGNvbnNpc3RzIG9mOg0KPiArICogICAwLiBSZWFkaW5nIGV2ZXJ5IHRpbWVzdGFtcCBtZW1v
cnkgcmVnaXN0ZXIgdG8gY2xlYXIgaXRzIHZhbGlkDQo+IGJpdA0KPiAgICogICAxLiBDbGVhcmlu
ZyB0aGUgc29mdCByZXNldCBiaXQNCj4gICAqICAgMi4gQXNzZXJ0aW5nIHRoZSBzb2Z0IHJlc2V0
IGJpdA0KPiAgICogICAzLiBDbGVhcmluZyB0aGUgc29mdCByZXNldCBiaXQgYWdhaW4NCj4gQEAg
LTIzMDMsNiArMjI5OCwxMiBAQCBpbnQNCj4gaWNlX3B0cF9yZWFkX3R4X2h3dHN0YW1wX3N0YXR1
c19ldGg1Nmcoc3RydWN0IGljZV9odyAqaHcsIHUzMg0KPiAqdHNfc3RhdHVzKQ0KPiAgICogdG8g
c2V0dGxlLiBUaGlzIHByb3ZpZGVzIGEgY29udHJvbGxlZCB3YXkgdG8gcmVpbml0aWFsaXplIHRo
ZSBQSFkNCj4gICAqIHdpdGhvdXQgcmVxdWlyaW5nIGEgZnVsbCBkZXZpY2UgcmVzZXQuDQo+ICAg
Kg0KPiArICogVG8gZW5zdXJlIHRoYXQgdGhlIGludGVybmFsIGNvdW50ZXIgbWF0Y2hlcyB0aGUg
Y29udGVudHMgb2YgdGhlDQo+ICsgKiBQSFlfUkVHX1RYX01FTU9SWV9TVEFUVVMsIHJlYWQgZXZl
cnkgdGltZXN0YW1wIGluZGV4IHByaW9yIHRvDQo+ICsgcGVyZm9ybWluZw0KPiArICogdGhlIHNv
ZnQgcmVzZXQuIFRoZSBQSFlfUkVHX1RYX01FTU9SWV9TVEFUVVMgcmVhZHMgZW5zdXJlIHRoYXQg
dGhlDQo+ICsgcmVnaW9uDQo+ICsgKiBpcyBjbGVhcmVkLCB3aGlsZSB0aGUgc29mdCByZXNldCBw
cm9jZWR1cmUgZW5zdXJlcyB0aGF0IHRoZQ0KPiArIHRpbWVzdGFtcA0KPiArICogY291bnRlciBp
cyByZXNldCB0byB6ZXJvLg0KPiArICoNCj4gICAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBvciBh
IG5lZ2F0aXZlIGVycm9yIGNvZGUgb24gZmFpbHVyZSB3aGVuDQo+ICAgKiAgICAgICAgIHJlYWRp
bmcgb3Igd3JpdGluZyB0aGUgUEhZIHJlZ2lzdGVyLg0KPiAgICovDQo+IEBAIC0yMzExLDYgKzIz
MTIsOCBAQCBpbnQgaWNlX3B0cF9waHlfc29mdF9yZXNldF9ldGg1Nmcoc3RydWN0IGljZV9odw0K
PiAqaHcsIHU4IHBvcnQpDQo+ICAJdTMyIGdsb2JhbF92YWw7DQo+ICAJaW50IGVycjsNCj4gDQo+
ICsJaWNlX3B0cF9jbGVhcl90eF9tZW1vcnlfc3RhdHVzX2V0aDU2ZyhodywgcG9ydCk7DQo+ICsN
Cj4gIAllcnIgPSBpY2VfcmVhZF9wdHBfcmVnX2V0aDU2ZyhodywgcG9ydCwgUEhZX1JFR19HTE9C
QUwsDQo+ICZnbG9iYWxfdmFsKTsNCj4gIAlpZiAoZXJyKSB7DQo+ICAJCWljZV9kZWJ1Zyhodywg
SUNFX0RCR19QVFAsICJGYWlsZWQgdG8gcmVhZA0KPiBQSFlfUkVHX0dMT0JBTCBmb3IgcG9ydCAl
ZCwgZXJyICVkXG4iLCBAQCAtNTgwMiw4ICs1ODA1LDkgQEAgdm9pZA0KPiBpY2VfcHRwX3Jlc2V0
X3RzX21lbW9yeShzdHJ1Y3QgaWNlX2h3ICpodykNCj4gIAkJaWNlX3B0cF9yZXNldF90c19tZW1v
cnlfZTgyeChodyk7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2UgSUNFX01BQ19HRU5FUklDXzNLX0U4
MjU6DQo+IC0JCWljZV9wdHBfcmVzZXRfdHNfbWVtb3J5X2V0aDU2Zyhodyk7DQo+IC0JCWJyZWFr
Ow0KPiArCQkvKiBFODI1IGhhcmR3YXJlIG11c3Qgb25seSByZXNldCB0aW1lc3RhbXAgbWVtb3J5
IGFzDQo+IHBhcnQgb2YNCj4gKwkJICogdGhlIHNvZnQgcmVzZXQgcHJvY2VkdXJlLg0KPiArCQkg
Ki8NCj4gIAljYXNlIElDRV9NQUNfRTgxMDoNCj4gIAlkZWZhdWx0Og0KPiAgCQlyZXR1cm47DQo+
IA0KPiAtLQ0KPiAyLjU2LjAucmMwLjM5NS5nZDFmMzUyNGUxNWRjDQoNClJldmlld2VkLWJ5OiBB
bGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg0K
