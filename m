Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29B8C79F80
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 07:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A62D60B43;
	Fri,  4 Sep 2026 07:00:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9U36Y1b1Cxcp; Fri,  4 Sep 2026 07:00:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BBAA96078B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788505242;
	b=PbtZWXiGOSxMViO5OuQ5SFKmWlqiXA+Tr3lU5E0jiIQtgDw9bAVC63IRNVql2DLLKVAA
	 D4hKsHTROXNxiCLSgAx+AEDurstMupSDZ9Zj2PpUR9pPSPauQxcMp31PSu7bT7GOlPqci
	 uYBJpie4SfkqUbY/343uM16fHS37J7HGL+NMyeuab2xsgN95c67hkqluRExHfZiAmweyJ
	 R3nZjm1N5YBd8OYzAn+B703/kce2Y/CVPWdz5dXbcwt4i1IB4gvOHxOSoK8rgv1PqX9xH
	 8+T3M2mf+wSt8O4TxEIeHUYXHlh6PfnTwckpBXo1OEcjUx1gUu/bgLXLeT2aDKktvOw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505242;
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
	bh=FuxrFqJfWUl1cnrmOrMQ9S9KM2D+37R/cCSUJW/UqUQ=;
	b=aLTewiwh1RUyaOV+VwaFKaSDt9ai05o/3a/frwEEqh+tQvbzzmCsjLdu4oU9q/TjkubC
	 S4RjFSBc+dcZLcug1ilIc2IGPHcJAOo7MHo/Oo+J/WN6Lb9kMUYwljwMwfp+jwU+1sbh1
	 hTMenjoBAKkTuBLO1t7M7xvexWdmnfvgwV5GpskWMrOiyerRmLX/aT0+UhyQOmQhCT9SR
	 EVvQGjKCeLMd5ajdYrqRjSMHeBxpMcovEfO1CcSuHZiL+je68hQq5dg6rDph1fAXyUVbl
	 TWm9AS6eSGdio4+ppXxF8ChemYxUFfw27eJmkW3JqPMJGc+OmPa04ZRAlOYIqgVThTA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788505242;
	bh=FuxrFqJfWUl1cnrmOrMQ9S9KM2D+37R/cCSUJW/UqUQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=drBuvh4zNYy1RZ9amZ5WME4LPhdVe8zbtVYFyDsaM/t6nmzyaTA2ApoSBi1aLPZR3
	 rO+KQ1HxuWuwHPh7XZkEohYz6nYiSEg8ZXnCb72dRWrzjsSMb/3mXRKwCBaM6ENoUM
	 1EcvCTtOUgmLJNMHqvqqj6VRvGqZghEWiPptQ1E2Xfdta7B21T+uyP5dGB+sQl/7uY
	 7owr4WXIsoit29uhH8QtYeIiOK578018uhsGe8rml6afrZK0rSiBzq47V3rK3n2E21
	 PL80hxEkEIXtFTJJK20PzeUXea3YdciON2i/VQBikZHE92WUbxCgPuadFsKxpSCwjh
	 IUjRA2bktaRZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBAA96078B;
	Fri,  4 Sep 2026 07:00:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A4CEB2C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17280400A2
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rt4VYiHZLbch for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 07:00:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B549740080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505240;
 b=Nh6RZxTKdqsNH8dmbgeq/+9g2Pflzswits1w1y6YLvHeqxiQUCdoZZLx+hWFl+X834Rl
 zIZs1lpiVygr8dH3SXgCclMLN/ROwRmpfq3O03b/YZE6hTkP4fHTZ3PFS7iX7/3qofms2
 J8mLI/Y80Opkm0gV+iXSLO3AWWUSoUvwEi7RnlUQjhSJ6ZMBzZ9zIvONz7mjpwTp3RmVs
 3N7kNuAbk4U+eT7q5tDWLthkbKxEnLEC+cf9JsC1GVmck11UTED+FvtPu1q5Xq3zoGjLj
 go83KmLtoqa93zJiRONsdsmiwcuklRB+td5wTJojWzvcGOwqms6/mnKYRYPS+Q+H/lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505240;
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
 bh=FuxrFqJfWUl1cnrmOrMQ9S9KM2D+37R/cCSUJW/UqUQ=;
 b=dVEkUW5dh0kx1UKF5S+cjcCooao6hVbm99Qh3P3v63QomYNus9ORFyZm3DWArz3FWybH
 EzYJbA6I9uFj03Aw+BuaYgVCukyvsEfg1eKNDD4K2ZrK6pcxdg4KeLQZxHgy56aTEFWV8
 8Z531lp7EaplQq1BX+ZZMaIbAC4AsxiTtAIT9GPOmt32hvcn1u7g2xGGHJxtkIjjCjNZD
 zrRbyND6miVt2tGYYkNw+en7IIHqjkpGEw4oziyuZXm4uJUZisxKr0sO5JDRl0wghI4Xl
 +Ovc86j7z6h0mtrOLo6jtlv3pByThPtRn47NYBFxBRVlBmjRZxzRBUlYJbV+nF3NmMA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cE+RN4hl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cE+RN4hl
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B549740080
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788505240; x=1820041240;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oO225ulwOne7DUoTItyk9yjDAIyuWN+mY+XAm0tjtuE=;
 b=cE+RN4hlFFTGTg9saK534wXRwJpoWg7biuX0PFTvu8vv30ZXY+SWtfu0
 6uMAtBTKv3KZOidipNjc+bvmJ+zqy3H96JxNrT0OEqDnXnY1aF/g5ju8Z
 tb2updMfNoZT53CRtLO9QwQQeq1dJlbSKltRlt5ypzQ2fjnyk1pS8Vw9k
 LdjcUazGOG6gc3HE4lRs+HTMZYqkIKPIH2UMUhL0ILRKLQEJx0EGa4U58
 izU3AuLjtGI25yDXuHAanv0UK/sWHabdfD3Alcgvxn/RTBlxkgpyUuXhf
 bnPS/rdB6KsJoKj9PfNLgHCH+s/Lm/qZ3d5WKpwyMtwNxesiP40/+D0VZ g==;
X-CSE-ConnectionGUID: W1aPVg90Sf+sEJnbMJk+vA==
X-CSE-MsgGUID: SLjdwTIGQiG6yowTDYBzAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76556303"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="76556303"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:00:39 -0700
X-CSE-ConnectionGUID: 5Kp8ZRpHT4KS/64KfvVxdg==
X-CSE-MsgGUID: 8CwA+PO9Q0mXRRHldZ7Dtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="265614330"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:00:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:00:38 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/BLPGgZMm1jH378AWNUQnE7r00zX1f38K4xD2Eg16ji0pHnDiFjcCvan5T25RGFs2Z5J9R6y/9wt5s1TmdGJOCiBZ+WAtVh9NPrdF3JUsWYcGhdwzQ5AIMdX65aJM7Z1NxMoAyTljvbQIBSlFth0omeRqghCrhe0Sy1YZ8kNMkzuIaX6FYgn7GBmrBypR2R/iAExIszR4aGiI1QYgA9FX6tB0NENDT1zFd3El+3PU+LKc3SOB63US775j+xWXJqmIq+FVTcKRJw1wH5GgGUKqxpYXOJrNwk+5qkMdg0mxe38CpIGvttLdtUZNv82V2bOTsTiv5P65YhU0UBQOcTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuxrFqJfWUl1cnrmOrMQ9S9KM2D+37R/cCSUJW/UqUQ=;
 b=eeVMOjXNhrURagTXNhfcdZ0Iw+Z4PEwutMNHP/wQjljnCr15y77SUIvP/ypX6Ug06wi6AMqKSIY91pOPJT7n9aLSSU/9mOeoukFFHsgbMudQ2aexabAuJClKp1jkW6O4lZxV2zzcIxYAEmTeUY9JchxYZ48GFp5+48NbuSPkmgti3L1W2zgjpWl95Aqzecvyji+DxymC4/pfA2ugKFnr4OVMhOMMrgcP6t6zmSPtzI5/pdejNRl1A5k/I+wdrPNGup6cHyynHsKgp3gKFZ7SgESYkHZauz2uujeuWuassit1LAKgAft+t2DxFde3CdQGJw3+wuZwpXgV3TjzWKC1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:00:26 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:00:26 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
 <sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Cao, Chinh T" <chinh.t.cao@intel.com>,
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 04/12] ice: initialize ACL
 scenario
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 04/12] ice: initialize ACL
 scenario
Thread-Index: AQHdChZNJj/Kc47ueE6wkca+kLszVra+N/Jw
Date: Fri, 4 Sep 2026 07:00:26 +0000
Message-ID: <IA1PR11MB6241B13F3768756E131EEE238BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-5-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-5-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: 572fc490-c020-467c-92ce-08df0a5232d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: d+vAGeRyqOjL3L4cdIJq+h632xBQtDJbIuJwJMcy4pDpuQgqijM+Ej2A11a4NFZHuMg4t4OzeEximRci8GVs0VTf9pQfpd/wFVwxDQX2idWBnW+D2XS88m1ghcbbzdX/7jsO5FcqPPqJk13kXo8us1jHz4wq/3geUGmjrs0AftNioTsRwnXMRNK3zgZ2lXLo3qnE8RTngrC5QqwoyarzH2ekyxIobjfREovbi13U/XiG3ZdPSmL/a/Ms7hUf10bJYDp2dU1jWT8Ii9frhv5TZAL3Jry5rfOD+OBRKervpS/L7aZ++eWOd6+kNR4L5ChEK2Swpb8RC+QBSAAvCdIIeRXlbo79oKCTx+LLaHzTcoWIgJLH76+ZZWcmcRdx1Y3MJ4+w0y5EsvMiF6RywA6JYEREoOPvvT0x5wiHHLgar+CTDENpDKCJpEZUwcuPhs6uDELxRW9u28ntB00ISk3qWSUbdaQshGiZ6KxYh0emJIj2XVSCKs/JUKKU4dQddldk0AyTflt+Q4jlub9r26ar0rvJSpAlxtz5fWRJR2tqvRX9eZx36ok3mGjiomlEl+DAMvWMs/fhk0X5z37tBfs/fXQCKZfaxqqLDZtFJX7TiCZRM7U3SE3M1gq9cZu7PxIXeqtMHf3xVXsvlq8qI4sVXpbXs0QDSEfXq8kPt3Bt+7Eynz56WdP6Mx6Tmg+A5zZc3KHnIrZqrI5Cu4UgYzvZQme1nJUu1CjGLmtLu5lGzao=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L4mtfWuYfXCaMLTHvblzRkVD3bcNHGzzqlQ2GhfqNWlVvu20OMjf8BmjnpB2?=
 =?us-ascii?Q?Sgg4zjHlEQcAbWfHXoLBt3wWcZGTw7DLbgaLSRG61sN6jNKAacwUsspmBoKv?=
 =?us-ascii?Q?m8QlP7R1ee4c/cwEInOMMWNZWULbOAWuEgs8Gyfcx8Zk6/f5bCpOF0q6j/pm?=
 =?us-ascii?Q?5WvnPJ8R/URFw/uA7Y6wO31KHAMa7CS14eCd/JjudeMS/T6xssvI45u6Go1z?=
 =?us-ascii?Q?0APtXKTgFiuG2RSnOOGqZbs9LfLDn024nYjJDde+RrNL56jQfmfQ1ivo5Uon?=
 =?us-ascii?Q?OT62z6/7SGCW7jqzqvC2Z2gRyENjLXaMTRKx5sRgUc3fUmeNaow7P8qR0V/Y?=
 =?us-ascii?Q?zo9A+xPPJ3m1P6hZChJ7UnQe0RswYyBrIBTdBZqna6wMzYEuSpFjCkkUC4rG?=
 =?us-ascii?Q?bT0vWWM9gqG40IBoCOY6BWfm05L0PhJqjqEcggExen8qMzNb/HxQfANsTIdE?=
 =?us-ascii?Q?a0+jWo2Zjv001P8Kt457rvNq73P0OvWwCgEkIuFlJ0aE0L89qEZO9A9k9rCt?=
 =?us-ascii?Q?VJxjnh8/mNel785YibgREvLpaadOQJd9fJ/PClEz2Hw4Em1YXeSioJ1GHGjx?=
 =?us-ascii?Q?tMMrfNXt8qvwvuiYbiftAQonlLNeIigjPDNsFwzjtp+lQXKaEQcJr2ewsFU3?=
 =?us-ascii?Q?bcqD2iblkQbZnuCx2+c1jAmHw0Cy1UmcCe8MLiIAshQT1WZ6KIDcRWo+9mZy?=
 =?us-ascii?Q?SXbKfYY3fLNeq2umrWS8y/75PeSpsfhjTyH1wHfc/uNoNXdttO/3LlF2Y2eJ?=
 =?us-ascii?Q?M0g0X4Fz9S3xPAelZTYXndqC9sa8G7Ee8VhoH2+JN4ES8EZT3kULJ7lZWcx4?=
 =?us-ascii?Q?ygWcP/ud6Z5xxRUDdRkiA09lYhQjDsm8yGUVk3mqHd+VPWEcz7Vn+pEEajVn?=
 =?us-ascii?Q?guRajGp2Jzy/OHscrvKoJXlGeT5UtR1SuGSJqFerrw5Cl0kuvIAGrpMRyU2N?=
 =?us-ascii?Q?5EMcTMXDDTjY05jLqQRbszhpaPT1vbK8VAzFHpEcV7tk6kybKG6ANOc0D67k?=
 =?us-ascii?Q?i402DaC3beTQeKhr19j9J0Ts7FYLdBgYNZomLJZv7kh5v5jhk5CgDwaNIrkY?=
 =?us-ascii?Q?lFhXa6DAtvq7JB9BheP3RUqC84e48RtDu1FsY/or3PHRLwq74KYXS/ELHYPa?=
 =?us-ascii?Q?DFT4ZN32WMfoIB6rFXfOdiDtiw6ECLKK60fQEqOPLDzGmlm3DLVCMkjYSwyZ?=
 =?us-ascii?Q?JZFt2oIdaYur0kFr+PY4BBFkbHf2PIMDaiyJTx1GAJapRmEF3vf22LqzUo0Q?=
 =?us-ascii?Q?uyvagPsEn8z35qJmbwYdykvOVjcLeBV+iJdFnnh88Ffd22xR2+KUFZqNQFGM?=
 =?us-ascii?Q?9PlmMzgDU9thioykmSOix/Cs96md+p5sUW8pQ8PZYvE9Li8f5oWpznsyCUXS?=
 =?us-ascii?Q?+1UfaZcbD1km+WyBeicwk6kQ/2PbiAnI8UtJ+/qkzSkA8Z4i4pR1PZ+R/1pA?=
 =?us-ascii?Q?oMcy3zZViSWoxfRLQKmpYSikJqVtTrT1qcgCACp6nHnYoGwm/UGo6ki21BRx?=
 =?us-ascii?Q?034lKsI7hd/KXi+koIsotG/+6Ek6617LBsuWoC7LXKJQWp/gTJMfdQEpJR5G?=
 =?us-ascii?Q?gPEFNownUBZNQXfHpb6VcdbLSSmLYwfIybTrZ6Cdu7DAt0VZ0L+SyA+Sw7En?=
 =?us-ascii?Q?oO/mLOjsezgXlADm4h1CIpSdGFjQUkfxhqrL+B+N3p4wd4Qf9vBjgzrNNW7d?=
 =?us-ascii?Q?LiKpA6wrTpyveK0w3F6tO3l7IqyV5cYeMH5Iyero8H0TvJ3u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kCn63i9TqF5tdfSIfBDMSEmw6WDTR1k+BplIuvwD7A0O+D4/RdTuR/kKTWSF8BgRGadSXquN4NZxLTHL1nKhmcCFCrs8xIjrcmlYhQAEdpeIQDo39ZbBPANkH1pw4CIrnn5vURSZhQEVqk8GgBftwtDLYI0+Oe5ZtNrigZApSTiBGmjWDPPqH9QR8fDHShp6gr8Ml1nadMxkYOCuvVPDFVeV1fJQkV4IbVu6DzCviMmYxmVSGIm2ujviJ/+HRCjPz6XTZoGHKnZ9BKp/lU8L2HZ/jXKIj3Qcty1EKgvuIkAZBFEP4jKMqzfMmMK01u/X15YNI7IO5Pm4BclBWS2pAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572fc490-c020-467c-92ce-08df0a5232d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:00:26.5892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUnlxAGaiM8g1QBkX63+skM9MpmNAKRFRxwEKeu3a4L+aGWR+dyZRGZ14A5RZs3VzSR7iDHS5yR4/XbrXAI9Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: 02 July 2026 16:00
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Nguye=
n, Anthony L <anthony.l.nguyen@intel.com>; Marcin Szycik <marcin.szycik@lin=
ux.intel.com>; Cao, Chinh T <chinh.t.cao@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 04/12] ice: initialize ACL =
scenario
>
> From: Real Valiquette <real.valiquette@intel.com>
>
> Complete initialization of the ACL table by programming the table with an=
 initial scenario. The scenario stores the data for the filtering rules.
> Adjust reporting of ntuple filters to include ACL filters.
>
> Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Real Valiquette <real.valiquette@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v5:
> * Make ice_acl_rem_flows() non-static. Remove its call from
>   ice_vsi_manage_fdir(), instead call it from ice_deinit_acl()
> * ice_fdir_del_all_fltrs(), ice_fdir_replay_fltrs(): skip ACL filters
> v4:
> * Introduce struct ice_acl_hw_prof in place of using struct
>   ice_fd_hw_prof for ACL. It didn't make very much sense, because most
>   members were actually unsed, in addition to it being very confusing.
> * Now, ice_fdir_rem_flow() won't be able to remove ACL profiles (because
>   ice_fdir_get_hw_prof() no longer returns them, as it should logically
>   be). Instead, create a new function: ice_acl_rem_flows(). It's simpler
>   than the previously used ice_fdir_rem_flow(), because it doesn't need
>   to iterate over any arrays. It also doesn't need to call some
>   functions - it should all be handled by ice_acl_rem_flow()
> v3:
> * ice_acl_create_scen(): add check against max match width
>   (ICE_ACL_MAX_WIDTH_BYTES)
> * ice_acl_alloc_partition(): change `row` type to int, throw errors if
>   subtractions underflows
> * ice_acl_destroy_scen(): add a call to ice_acl_commit_partition() to
>   clear availability bits. We don't actually destroy scenarios outside
>   of driver deinit, so this doesn't currently matter, but should be done
>   to futureproof the code
> * ice_fdir_update_cntrs(): remove `flow` and `acl_fltr` args, pass the
>   whole fltr and read those values from it. This prevents passing
>   literal value as acl_fltr, ensuring the correct counter will be
>   modified (previously there were some hardcoded calls)
> v2:
> * Add unroll in ice_init_acl() in case of ice_acl_create_scen() failure
> ---
> drivers/net/ethernet/intel/ice/ice.h          |   2 +
> drivers/net/ethernet/intel/ice/ice_acl.h      |   8 +
> .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  31 +
> drivers/net/ethernet/intel/ice/ice_fdir.h     |   2 +
> drivers/net/ethernet/intel/ice/ice_flow.h     |   7 +
> drivers/net/ethernet/intel/ice/ice_type.h     |   7 +
> drivers/net/ethernet/intel/ice/ice_acl.c      | 116 ++++
> drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 573 ++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |   4 +-
> .../ethernet/intel/ice/ice_ethtool_ntuple.c   |  86 ++-
> drivers/net/ethernet/intel/ice/ice_main.c     |  20 +-
> 11 files changed, 841 insertions(+), 15 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
