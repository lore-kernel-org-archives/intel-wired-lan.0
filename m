Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69269CA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FC9840680;
	Tue,  6 Oct 2026 01:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id umUQHCQ97klo; Tue,  6 Oct 2026 01:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6ED2F40681
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791251178;
	b=j0fbxTU1SrwREbGuVvItxaDSfOhB85Mo1Bg04UzXJYhFNVYlOP530RICfj4HzDtr25t8
	 WCa5d0oLp6hZ0kdWmu8mLK7/kVi1ITUDn+DeYfM1D6Nb7qWUj3VCN7B/RcHUlI41PSqPm
	 8yuhNMdFyWWerb19bsmXVzTvpI1IRLJO9SSLdk7Gl2vinGcw5YfWJFbIG645py1ZQXSrY
	 g3P7qk1gIdxJNB03jJZP8TGbOUmUCylbNLA7Qrjw76eWeI8vp1YeG4ZrLxI2ymuaw3qOt
	 FtwRuR/ZsVVYIYNeUMs6KqVpl6B5PXUQgGfWheSun/wre+h7rJx9K9HnfeX8elR3xIA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791251178;
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
	bh=YTwywI6WFQsuma1dHUe146PnsXcNHxB7IW35wIR3i1Y=;
	b=gfEB2qm/CnTRgnYHYZfoyHM+/EyqLiGzVXorEXFebFKMhSAcR9clsfilBxY1CpjL54aM
	 ANzoSorP/19GTdFln3FfJdFKniZPInIx+8oz3fxHKGRvKjW1zRMeYqvIQQuTZUnf3EJY0
	 tFs/0ZlFuZOhTzROqnAILU1G67a/bFqcuwa1RexkseEBZGmO3kVow6Cp+kH6tYjnREkG7
	 6OqcrqRlbsV0i2akBmNzBylJWrTknqTKLaIcKIQndV2fwbvl0rkb47HE2oiaBNiBRbMGr
	 PWU20RdQIJrI6UldNVqpprUppEgyH32p9nzjZVyFoTB+AoJaorweOER+PeBO27dldnQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OJH0U76g;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791251178;
	bh=YTwywI6WFQsuma1dHUe146PnsXcNHxB7IW35wIR3i1Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fDVqHdUU99DW6rAILMVeA+XcCRvqpHWY5TPF999k1H9gkXw/8mhj3mfc6L5A6ANmF
	 Ks43qJw+tGdSusaqhxFm0ZInqE5/S1YYvl1sFhUd3FfggALibkiX69bqXVYu3AB6iy
	 aTWn7k3cR3pNdRzrBr6jT8IQDPFwOfn5ZfH8ynePh+oN0bN1e8SPbiw3sQxe65jkkp
	 a4UfGB4AqvpcHWi6C+LoE+Wv5x0/PMqby+ZHBIA7wdIR7Q6ZGvFqU1IIo3rolbOYjA
	 ruyzOP7DpGjZ4TCBVZmCASL8nLn2DCKnTpscETtYSE56mSJ/5p1Knc5R6KIKO0nu6V
	 AAcxSAQ/tj1UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ED2F40681;
	Tue,  6 Oct 2026 01:46:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5718632F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 485614064E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AprpOvbuEC_r for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:43:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 58FBA40609
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791251028;
 b=cBjwo0qKOLQkiBfPMdzAyqVE91s/ihfVYpnpRIzbP4x51qZOeykth4wpA2Zu83fOWMZg
 e7KdRCOUrbcRFFGyC9c86vh11QCvfzIBvsecxT1rAyr+fiSd0ds/aMuicgwR+QxEWt/ut
 sShoPt21pbTWy7bsC2RQb3hpfhBu5heyjNsVcVbxYOiAlvDaKdtG90JT0G6r4qLzXFLjn
 fU/l/czbQC/XYAVH6VYSLjbhHrZ6a/D3PYfTiJgx9IjhZ5IKhS/fErqgXs0h03ZPnBAjF
 X0uD/tfGW8uJaaGs+7Cx45kOxHKtpy13AjrZ3eiiyv9JiEGydfIYp1CDIQzbc/hN5SQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791251028;
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
 bh=YTwywI6WFQsuma1dHUe146PnsXcNHxB7IW35wIR3i1Y=;
 b=G4HCur8JWj6J/zfzW2E/HQgCiM0kL4RxygFP1J0RUOx8PAXG4z9W9zn8aTtzrdRX3lcf
 ACgP9gwLK6ybm2VOroWWwMEgNriMWfl1FBxmv5LyXKXyHX8MPPskwwIdUoLyx7jFE3eYy
 vxtqSPW5Zrh+6sh+fhhI4R1xJvw+DAYUX0+mOEdfwK+178xby2hzrA2EuHl3Qqa0yKtAl
 R5Kk8uK9LTgCfkP+e8pZ5RaBUJfVRDx6MErQevK410gMtma7jBmQjJq9xhrede/lKKWn5
 KE2Jzxi3fSMXfvnzz3RQVaECi5TiRFyEh4O46ZFwsm/jQUS95SCuL3geI352c6vmUsA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OJH0U76g; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OJH0U76g
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58FBA40609
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791251028; x=1822787028;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YTwywI6WFQsuma1dHUe146PnsXcNHxB7IW35wIR3i1Y=;
 b=OJH0U76gKrFiB5V4jE2sCtOqO0jyqZPO74IMJBwj9+L4baGXpLGiCeFN
 1/VZlpskF9tjTtLsXorouyu3PF3owgghJ8Jgh5UnPaGtKqIHsM/ztqhcn
 GUwQphldUUdtZpgUwdv0PVTBM2VNn2Ovn/mBnnqxPbJmzjQm0TbjjGE+e
 YEMPk4p9EQi81WL+8lfINkMtzHpTCKFsFafRYchy7mQgXwUJ3sI+26TKX
 gfIETDfCAVISr5u8one4tDJ3d0RsHiG9NbvfogUAA7uMJND9YivCOC4UQ
 4EdVG4nEgX5OEih7znyUR/IqaZndkgzUSJFIoTYT9yGlVWcw/zEsIeD7Q Q==;
X-CSE-ConnectionGUID: OLsFHZlUQCO3muafNyQueQ==
X-CSE-MsgGUID: HrPCB1cGSnquq+eQDK3W0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94642109"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="94642109"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:43:47 -0700
X-CSE-ConnectionGUID: L8tT3KNkR2KpGbPAkq0Gbg==
X-CSE-MsgGUID: zn3LCXgnQiuzCnZ5IbJw+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276518749"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:43:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:43:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:43:46 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:43:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcxuW+gPoMYt8HiZF5c1IKUmB52oQAXPHZySY0Q/EGJoLLFhp9ZLNBwZUaJVrXfN/AfocC/Uza8NkEBCVihYXVOw0a+ZfjsH02Kx0smWm7PyDt//l5xh+VQgPs6edMfr4s9d8+kfv4sjgR3fZxNSbw5mLRk5qlAGkVitmTLVq1LNUeyaBZefPT/+sfjZY1wJ25az1+XTUBTLBWoqYiKjv6VX49TXW/7yAXWi1Z4GdKsL2qQX0vLHkLBIc0CEHRlGUXHqoSrIcFtWz9IlvR3Y0YdOzkQmHJNR8akzCmZ8nlMBArl44RS3PP1SlEus53CNv/77IknY9t6hqVddowhleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTwywI6WFQsuma1dHUe146PnsXcNHxB7IW35wIR3i1Y=;
 b=B5khuOX+VWxOY/eOY+MA/1xucZFmVlYb9JGWSxAFDA4+HxbIFc/Zk9avX5R5w5DXkDNZppkfF2LQ1oWYxTfVZ0y1fWdi08QvcHKCnE8TdFv9gCrEa9YOgqBKlcMv8kW/JBU5VbuWHKsxaPLI+wCTez+TOJLQGGkTT30hDWBvvS0MMbBcF/jasZpaTDLTK5yNZISWPPyLNcUxNr8SIn5u6zibH+XiYwHhMHpU1yV0DNPPIUiL3sm+1Un94ePiwl6P2a3g/U5CwAAz8jK64pABvxqFvNdpKUmVOXaMTf6FjJtDIrI/2nXKOFIeHCRvVwCY5fIEf3iMu0uGgSB9hx0IcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:43:43 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:43:43 +0000
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
Subject: RE: [PATCH iwl-net v3 12/15] ice: keep Tx timestamp slots tracked
 until completion or timeout
Thread-Topic: [PATCH iwl-net v3 12/15] ice: keep Tx timestamp slots tracked
 until completion or timeout
Thread-Index: AQHdTUnGzG8c6KsJQ0WYG5BoOikLGrbvzW6w
Date: Tue, 6 Oct 2026 01:43:43 +0000
Message-ID: <LV1PR11MB8790BF8CB5539F31BD2FBF5890952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-12-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-12-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW5PR11MB5907:EE_
x-ms-office365-filtering-correlation-id: 74f95b06-74c7-458c-64ee-08df234b4119
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|10067099003|921020|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: kKPdqmrPYfOqlU9FdArxy0uFoSG6vSzzp2gt2o6wKkLMrcuW2vwoieXCGIiju8GOhjDlk688h5E/V2yR1Cnx5InZfNK9C6JqB9T3eJcQNuRQvATiAh5FuYplIcrEBqgotm6VtRVRscBMcADhUK6Og/AM7brC000GMWbsCeKLzZv0pLBw8k8wDSLOOMyLKVV+0tCZnBugUEFCKKl3DIlaX5vilRO5EbpxZlGeR2YtXwbu4jNXJc79CTvX0jAn4wr9+zY5oxPg1MSYY+JlBWBOV7rTCap44KCnBgl/A9UrF+ypkU49wBj7RHgPv3BOGgnJvCztOW1VWDNDJen+EFPSnohiv/DJAqlGuennZ3yc0t4M7KKq7SW+YW+gsw8Oy724rrbIdNlTEiafgG7o6otX+0BG0HTw3dtUtfh9kMAtQVyeuJzCkdPopzoiGzksCGEIyhFJJP3PzKStzhYZt8LGZXTC0xpX77Qub99g86qcu07LQyOvGiicFCmcSGNSc2DC2svZmdU/wmNUQ/BHo9EGQqlCv6o0p/nVbiJYk/qfA8124dzwvIIb402UnOik/HAX64lnCFj1XzsvnUruUCumSw412xt7JzyQmnup/XratGjGU5Ll/0PhacX7SWIOiSfrpZpfzfVWKed+QCaVqKISVAnT3d0KNuT0oUH3fxcFUXSTZSYM6C4gBm2v6W6wRDbjIVuBHwIfNFvx5gZP/9LJSeA9wxpZBMbQ5xevvScaKLUIt3/U5kzOVfOgAIa0THkr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkY3SjlrWmptQmhuc2lvVWp3dlluVmcvTHBLNjIvMHV2c1BITXVhdStsWkxV?=
 =?utf-8?B?UkdkMXdyYXVKNzRsRjg1dHdmNjl0UFdVM3Q3TFRFUGhQYmMyaThhc0o4T3lz?=
 =?utf-8?B?a2Yra2lhbU1ZNmxEekJCUUQxN1dPb3JYTUxZNlk5emIrdmRiQzNQNlVJUUVo?=
 =?utf-8?B?TkVMeVhNS3Q5RHpVbUNoaVBsdEllUHdCUUhSNDBoMnFFQ2NUd1k0b0piSGdt?=
 =?utf-8?B?MkRzWmtQWTB1UExEYWZFUGVzWDQ5d3hRY2xMKzF6RTFJZ1ZkREpUR2JScjdj?=
 =?utf-8?B?RmpzaHZ3eVZkTHVEcDZwU00zd0syRGkwd2NGS2lUM1llK2ZSaVFRMXAwSzBO?=
 =?utf-8?B?VkMzSEJoQzl4K3BPMWhYU1VoVzkyLzdiS21WWlhHYllkbFNKbmFHQ3M0cWJ3?=
 =?utf-8?B?YzBuL1p4NHQ4amwwSHRVSHcwN3ZyeGpsWXRSOWlXWGpqZWwySnhXdUZJZnNk?=
 =?utf-8?B?VTNJY1hPK1MxYkdYTFJoK045SlNJY21pVGNaWVVIOE9RcGQyMHhUYUtLMUZ5?=
 =?utf-8?B?c0ZJZ2xJTzJ6TERCZW51TWRSVXJwd3hWcjk3M3Iwd1RwVlJSNGtvSEdoS2Fr?=
 =?utf-8?B?M2RBUjJUcyt0ZVprVHpMcVkxSFozT3BhL3J3TXA2dnVKbnQzbWdOYWI5Y1Fw?=
 =?utf-8?B?aE5MQnBrZGFEM2xsQ25rQjBHK2dVR0JySzVEZWJFYWJuUThiLzZIVFdScHJt?=
 =?utf-8?B?dS9FU0VTUjRVWnFSV0Q5c0RuYytmTEN0U2RPb3hYNFZOV290Wi9PY1REWEpJ?=
 =?utf-8?B?N3FmenlTazRzUEZHRjZ6NTA5SGFuSWU5RDFsZzM3ZGFmeUMvRmlacks5Q0gw?=
 =?utf-8?B?NEFFWlNUZExCUFE5bWpHNkV3TXIvczBYT0lHdHlBeGhpYnR0UTR1ZE9NcERO?=
 =?utf-8?B?VjRBVWxXVGJBY2FRUWh5UjBlbG9RSllRVnlFeGZWMW5jTVl5S1RTWE5YVlYy?=
 =?utf-8?B?MkZqSWxQNDJLTHRRSXI5cHIvZVFkb2NKSEZXcXhvTEh2MXlJaUFiQVFpUVgz?=
 =?utf-8?B?ejk1UjNQcFQrd2VvVlpmTjFCZUxXSklldVZZM1pJcWhOa3BEdHMzRFUwaG0v?=
 =?utf-8?B?LzNSZ2FuaGZVY0pnWS8yK2hLRm91UUVUa1J2WTR3UUJLVHJXRWFBZFpsK0VE?=
 =?utf-8?B?MUFvbkd2cHluYnhTeHJSWW5BYkxwcGROQlMwWlZmREUzWkptRUMySjU0S0FI?=
 =?utf-8?B?dk85UmNnMXVqRlhyeUlDWXhCemNjOUg5UmVqR2VUMmlKc3p6RzJ1bytCNWFs?=
 =?utf-8?B?YmtvRVQ4NWNNUjJjWEtLTE9Cd01LVHRnSmlnQ0wycnM3VmtmUTcrMU9pSVNm?=
 =?utf-8?B?VzNPR0FQK3hqODFvREVqWmF5ejBvS0F5ajYzc2dIallhV1QrcVNwQlpuZjJz?=
 =?utf-8?B?NWZ5bWdXMTgranNmMTZoUUVjTmRzb2Nac1dFUlFuYVh5aEFhTWY0NmFrZVZW?=
 =?utf-8?B?aS96c0JUVmlJV25VNldmQ05uTEttMzh1RHBhOFNmc2o4bFIwODBJaVQzSzZl?=
 =?utf-8?B?T2NtalZScjc3QzNKdXA5K3RIZ1Y1QVAvYXVxNUJpUEZsSVJmdVpxd1R5Q0Z2?=
 =?utf-8?B?Q0Z5Tnl6eG1WUVpaV2RzZkVzVzJqcHRlZ2Vwdkx5UUZSeVJvajd3Yzh2UW5T?=
 =?utf-8?B?UlVrcXZvZk96ayt3N3VsK3VOMmlaczIyNkI3eG1OWSs1UFU1b2doVUdjUk5k?=
 =?utf-8?B?ZmE1aENMZHlpUjNES1lhWHJidnJCRU9ScTh1c2doOWorN0JFeEp4NUNZUzZO?=
 =?utf-8?B?K3RhS1M0SjQrVnBMQnFES0Y4UUh1Mjc4dGFVK3lxeE1GajhBRVhqU0V1eTRQ?=
 =?utf-8?B?M0JwMEZhNzhZTGx1N0Q4WjNxTEdxNUhSZEV3SjdHRlp1NTRmMEUybXpZSFZV?=
 =?utf-8?B?S1JGcW9oUU9lcVZ1SjdLUjZxd0oyYnpGeHMyVzZONVlpNU1HcVJzbUwxRHNu?=
 =?utf-8?B?MmdkUEJGUUI4ckdWOFpQZ3E5RWdVS1d6MEY4cW16ampDRkhFS2VkckZFSEFj?=
 =?utf-8?B?bFpiWmtqbFdPOG9oVXhKNTVzazdVUVZkYVF3djRLa1ZoVU1FVFJ5Q0tpZWdr?=
 =?utf-8?B?QTl6dUVtWTJUODREYVR1Y3dIcllBWlhYaFU5ckNBTWRGejVncCt5a0ljYlRy?=
 =?utf-8?B?NlVvdVBoTFRQMW9RbER0b3UxcWlLVnBsdEJ0a2FZMjBqUFlKZjJRUmtWdUUw?=
 =?utf-8?B?TENYQ2lLVnkvcVhhQUxXbDRvNzNteU1ObUJJSzBiNm5ERHdjTndUbFJUVDh6?=
 =?utf-8?B?Vjl3QlBpU2hreFovb3QwSUhvV01CSEpNZEhTdGtXZ3laVGw0ODRKSmoxQkIz?=
 =?utf-8?B?blU0VTlxYlNoOGNDWGhSM0NUbHh4c3kzMXczR0toOUFPWnZJdGpndz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zt+juUFPwUKub9y7OVNBsgqh0V9zRrGxqYkVVbQrHk/EYxllaus+tdTPo6A3hdxS3fTQjyBSihDWWxi3+y43KKC09U4t1WLGsa227R1k7d+kgNX0lsTtKgYAJQDa6liW3GyYc2Ju6PxuasKbua6wMr7SnH+7CAelPgts3gryjtETXdYNFN8QUzEWLg/eCWRooHCDe/dBxbZLVObQbp+XlxD0loj9okvCu8Hchi7BtvMXi5nW2ChasZZBW9B373e/qElYdO1bCIqglQ8kwP/8od1Gvas155WH4Dk8CUkrOdyERHoMGF2GocsYg97Ygvby8lxmmC8aQ7r9gx6txv3geQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f95b06-74c7-458c-64ee-08df234b4119
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:43:43.1268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5L2o5FPURdGulP03Xb/HV6wy5pKGcj7DDaQwNeIu5HBbrXDQTs2wVdJBLqY49EiUu1Qd6CTAJg8/T3azT0eQgHKok7tGB8PMeON4vOXaGS8=
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
SCBpd2wtbmV0IHYzIDEyLzE1XSBpY2U6IGtlZXAgVHggdGltZXN0YW1wIHNsb3RzIHRyYWNrZWQg
dW50aWwgY29tcGxldGlvbiBvciB0aW1lb3V0DQo+IA0KPiBGcm9tOiBQZXRyIE9yb3MgPHBvcm9z
QHJlZGhhdC5jb20+DQo+IA0KPiBXaGVuIHRoZSBsaW5rIGdvZXMgZG93biB0aGUgcHJvY2Vzc2lu
ZyBsb29wIGRyb3BzIGV2ZXJ5IG91dHN0YW5kaW5nIHJlcXVlc3QsIGFuZCBhIHJlcXVlc3Qgd2hv
c2UgdGltZXN0YW1wIGlzIG5vdCByZWFkeSB5ZXQgaXMgZnJlZWQgd2l0aG91dCByZWFkaW5nIHRo
ZSBQSFkgc2xvdC4gVGhlIGhhcmR3YXJlIGNvbXBsZXRlcyB0aGUgY2FwdHVyZSBhIG1vbWVudCBs
YXRlciwgdGhlIG9ycGhhbmVkIHJlYWR5IGJpdCBibG9ja3MgdGhlIHBvcnQgaW50ZXJydXB0IHVu
dGlsIHRoZSBuZXh0IGxpbmstdXAgc3dlZXAsIGFuZCB0aGUgZnJlZWQgaW5kZXggY2FuIG1lYW53
aGlsZSBiZSByZXVzZWQgYnkgYSBuZXcgcmVxdWVzdCB3aG9zZSBzbG90IHRoZSBoYXJkd2FyZSB0
aGVuIG92ZXJ3cml0ZXMuIENhcHR1cmVkIG9uIGEgcmVwcm9kdWNlciBhcyByZWFkeSBiaXRzIHdp
dGggbm8gaW5fdXNlIG93bmVyIHJpZ2h0IGFmdGVyIGEgbGluayBib3VuY2UuDQo+IA0KPiBTdG9w
IGRyb3BwaW5nIG9uIGxpbmsgZG93bi4gTWFyayB0aGUgb3V0c3RhbmRpbmcgcmVxdWVzdHMgc3Rh
bGUgc28gdGhlaXIgY29tcGxldGlvbnMgYXJlIHJlYWQgYW5kIGRpc2NhcmRlZCwgcmVqZWN0IG5l
dyByZXF1ZXN0cyB3aGlsZSB0aGUgbGluayBpcyBkb3duLCBhbmQgZnJlZSBhIG5vdCB5ZXQgcmVh
ZHkgc2xvdCBvbmx5IGFmdGVyIHRoZSB0d28gc2Vjb25kIHRpbWVvdXQuIFRoaXMgd2F5IGFuIGlu
ZGV4IGlzIG5ldmVyIHJldXNlZCB3aGlsZSB0aGUgaGFyZHdhcmUgY2FuIHN0aWxsIHdyaXRlIGl0
IGFuZCBuZXZlciBsZWZ0IHVudHJhY2tlZCB3aGlsZSBhIGNvbXBsZXRpb24gY2FuIHN0aWxsIGFy
cml2ZS4NCj4gDQo+IFNpbmNlIHdlJ3JlIGFkZGluZyBhIG5ldyBjYWxsIHRvIGljZV9wdHBfbWFy
a190eF90cmFja2VyLCBub3RpY2UgdGhhdCB0aGUgZnVuY3Rpb24gcHJldmlvdXNseSBkaWQgbm90
IGNoZWNrIHRoZSB0cmFja2VyIGluaXRpYWxpemF0aW9uIHN0YXRlLiBGaXggdGhpcyBieSBvbmx5
IGFjY2Vzc2luZyB0aGUgYml0bWFwcyBpZiB0aGUgaW5pdCBmaWVsZCBpcyBzZXQuDQo+IA0KPiBU
byBhdm9pZCBjb250aW51b3VzbHkgcmUtdHJpZ2dlcmluZyB0aGUgSVJRIGF0IHRoZSBlbmQgb2Yg
YSBwcm9jZXNzaW5nIGxvb3Agd2hlbiB3ZSBoYXZlIGEgc3RhbGUgcGFja2V0IHRoYXQgaXMgbm90
IHRpbWVzdGFtcGVkLCBtb2RpZnkNCj4gaWNlX3B0cF90eF90c3RhbXBzX3BlbmRpbmcoKSB0byBp
Z25vcmUgc3RhbGUgdGltZXN0YW1wcyB3aGVuIGNoZWNraW5nIGZvciB3aGV0aGVyIHRvIHJlLWFy
bSB0aGUgSVJRIGZyb20gdGhlIG1pc2NlbGxhbmVvdXMgdGhyZWFkIGZ1bmN0aW9uLiBJbnN0ZWFk
LCBvbmx5IGNvdW50IHN0YWxlIHBhY2tldHMgYXMgcGFydCBvZiB0aGUgY2hlY2sgaW4gdGhlIGF1
eGlsaWFyeSB3b3JrIHRocmVhZC4NCj4gVGhpcyB3YXkgd2UgZG8gbm90IGtlZXAgc3BhbW1pbmcg
dGhlIElSUSB3aGVuIHRoZSB0aW1lc3RhbXAgd29uJ3QgYmUgcmVwb3J0ZWQgYW55d2F5cy4NCj4g
DQo+IFRvIGVuc3VyZSB0aGF0IGZvcndhcmQgcHJvZ3Jlc3MgaXMgbWFkZSBvbiBjbGVhcmluZyBz
dGFsZSB0aW1lc3RhbXBzLCBmaXggdGhlIGNoZWNrIGZvciBpY2VfcHRwX21heWJlX3RyaWdnZXJf
dHhfaW50ZXJydXB0IHRvIHByb3Blcmx5IGFwcGx5IGZvciBkZXZpY2VzIHRoYXQgbWFuYWdlIHRo
ZWlyIG93biBpbnRlcnJ1cHQsIGluc3RlYWQgb2Ygb25seSBjaGVja2luZyBvbiB0aGUgY2xvY2sg
b3duZXIuIEluIHRoZSBjYXNlIG9mIGEgdGltZXN0YW1wIHdoaWNoIG5ldmVyIGNvbXBsZXRlcywg
dGhpcyBkb2VzIHJlc3VsdCBpbiBvbmUgZXh0cmEgSVJRIGV2ZXJ5IDUwMCBtc2VjIHVudGlsIHRo
ZSB0aW1lb3V0LiBJbiBzb21lIHNlbnNlIHRoaXMgaXMgZXh0cmEgd29yaywgYnV0IHdlIG5lZWQg
dG8gcmVjaGVjayB0byBlbnN1cmUgdGhhdCB0aW1lc3RhbXAgc2xvdHMgZG8gbm90IHJlbWFpbiBs
b2NrZWQgZm9yZXZlciwgYW5kIHRoZSBzb2Z0d2FyZSBjYW4ndCByZWxpYWJseSBrbm93IHdoZXRo
ZXIgYSBnaXZlbiBpbmRleCB3aWxsIG9yIHdvbid0IGNvbXBsZXRlLg0KPiANCj4gTm90ZSB0aGF0
IEU4MTAgZG9lcyBub3QgaGF2ZSB0aGUgcmVhZHkgYml0bWFwIGluIGl0cyBoYXJkd2FyZS4gSXQg
aXMgY3VycmVudGx5IGV4Y2x1ZGVkIGZyb20gdGhlIGljZV9wdHBfbWF5YmVfdHJpZ2dlcl90eF9p
bnRlcnJ1cHQoKSBieSBhIGNoZWNrIGFnYWluc3QgdGhlIGhhc19yZWFkeV9iaXRtYXAgZmllbGQu
IFRoaXMgY291bGQgbGVhZCB0byBhbiBpbnRlcnJ1cHQgc3RhbGwgaWYgZXZlcnkgc2luZ2xlIFR4
IHRpbWVzdGFtcCBpbmRleCBzbG90IGJlY29tZXMgc3RhbGUuIEhvd2V2ZXIsIGp1c3QgcmVtb3Zp
bmcgdGhlIGNoZWNrIGFnYWluc3QgaGFzX3JlYWR5X2JpdG1hcCB3b3VsZCBiZSBwcm9ibGVtYXRp
YyBmb3IgdGhlIGxvdyBsYXRlbmN5IHBhdGggd2hpY2ggY3VycmVudGx5IGlzIG5vdCBwcm90ZWN0
ZWQgYWdhaW5zdCBhbm90aGVyIElSUSBoYXBwZW5pbmcgd2hpbGUgYSByZXF1ZXN0IGlzIG91dHN0
YW5kaW5nLiBUaGF0IGlzIGEgcHJlLWV4aXN0aW5nIGlzc3VlLCBidXQgd2Ugc2hvdWxkIGF2b2lk
IG1ha2luZyBpdCB3b3JzZSB1bnRpbCB0aGUgcGF0aCBjYW4gYmUgYWRkcmVzc2VkIGJ5IGFub3Ro
ZXIgZml4LiBUaGUgbG93IGxhdGVuY3kgcGF0aCBhbHNvIGNvbXBsZXRlbHkgPiBieXBhc3NlcyB0
aGUNCj4gaWNlX3B0cF9wcm9jZXNzX3R4X3RzdGFtcCgpIGZsb3cuIEZvciBub3csIHNraXAgdGhl
DQo+IGljZV9wdHBfbWF5YmVfdHJpZ2dlcl90eF9pbnRlcnJ1cHQoKSB3aGVuIHRzX2xsX2ludF9y
ZWFkIGlzIHNldCBhbmQgdGhlIGxvdyBsYXRlbmN5IHBhdGggaXMgaW4gdXNlLiBUaGUgcGF0aCBz
dGlsbCBoYXMgcHJlZXhpc3RpbmcgaXNzdWVzIGJ1dCB0aGlzIGF2b2lkcyBtYWtpbmcgaXQgd29y
c2UuDQoNCj4gVGhpcyBlZmZlY3RpdmVseSByZXZlcnRzIGNvbW1pdCBmY2MyY2VmMzdmZWQgKCJp
Y2UvcHRwOiBmaXggdGhlIFBUUCB3b3JrZXIgcmV0cnlpbmcgaW5kZWZpbml0ZWx5IGlmIHRoZSBs
aW5rIHdlbnQgZG93biIpLCB3aGljaCB0cmllZCB0byByZWxlYXNlIGFuIGluZGV4IGJlZm9yZSB0
aGlzIDIgc2Vjb25kIHdhaXQgcGVyaW9kLg0KDQo+IEZpeGVzOiBmY2MyY2VmMzdmZWQgKCJpY2Uv
cHRwOiBmaXggdGhlIFBUUCB3b3JrZXIgcmV0cnlpbmcgaW5kZWZpbml0ZWx5IGlmIHRoZSBsaW5r
IHdlbnQgZG93biIpDQo+IFN1Z2dlc3RlZC1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxl
ckBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBldHIgT3JvcyA8cG9yb3NAcmVkaGF0LmNv
bT4NCj4gUmV2aWV3ZWQtYnk6IE1hY2llayBNYWNobmlrb3dza2kgPG1hY2llai5tYWNobmlrb3dz
a2lAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2Vs
bGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2Uv
aWNlX3B0cC5oICB8ICA4ICsrKy0tICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNl
X21haW4uYyB8ICAyICstICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5j
ICB8IDU3ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gIDMgZmlsZXMgY2hhbmdl
ZCwgMzcgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pDQoNClRlc3RlZC1ieTogQWxleGFu
ZGVyIE5vd2xpbiA8YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+DQo=
