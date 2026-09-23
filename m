Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33016C982EA
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Sep 2026 09:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F229380CB1;
	Wed, 23 Sep 2026 09:48:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y7uVD4jQJ0PA; Wed, 23 Sep 2026 09:48:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1434E80C6A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790156885;
	b=CpnD4nXQBbSA0pgNKkCq+lZyoZhP2KrRqkx+npDobI/4aIwpJMFc/fIiZPZvedZOcFZd
	 5MmdSM7+dK1l34ZLLxrixNJ8FhpOFc8SJ6DMKBaOgFLUow4KlkjiJuF6FUbbrJjOuEDpv
	 Tl+15DLh78AHQdpRmU4MOnC/A2TYXpAp4JJQEkk3DqT7xuUdjb6dzSq68ScDst9gbjA6k
	 SBWRpPDcoKoKWJgAySbevmZBA6hPMYQsORH0aiKfzt7OG16z16J7epqpDVIxsQ1o4aq/s
	 Oqw/1kATM0b4m2xqKWby5pUt+cM4bjpZiHhjgfU57/JzJZI7pVXccHkzn1u/u1PUI6A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790156885;
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
	bh=s/+1Sw0GOhAV6aEyxDh3k52oJXron9DMmutyu+sNPUs=;
	b=NEeQLO1BXNjbyyZU2SdmkiLWAEv5FfIgsU3QGic7DoZ8ncdczTemLsQFwUogdqFYLzLO
	 hxCx9usvgWhatbFr2NTLmZudD1JdsPDShI3K5kUrnlPkP+HPEHaTl7NS/koA5yxCIoaqN
	 4JlB2tzm4nQ198XwP19uY0l4k8Qi4w/+oBWeImszylWmro9I2t548yn6F+48iwXt+TEB1
	 jHftAj71RZPzwEiCM/gjGUWr+RqgrnUooLlrMsX3IGF+oZZxiAqNQGWWNqHKFWBLkcCDs
	 zoaG1G1v19kJMp7gCBN8gkERKC73QsHkQB2j29XzjGgl8uAYmZYH+HoQP5jiWzh8Fmg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790156885;
	bh=s/+1Sw0GOhAV6aEyxDh3k52oJXron9DMmutyu+sNPUs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pgGDtXH7rb7t+zmMDddn9M8PoyF1xEp+DF2mfmt4Seymtwz9j5Ablxtfp2lyqUfU4
	 sduIeBIHnbmXmPtwHdiXdUxa+lxB1dyZAJpoue+cNnIhfXGkwQ36ZxNKMhNf9Cm7X3
	 0r6an0fY5W/cTBQ+PhYDFKU1rtudkCKbz3Wq390UhWctyFZ6lYnZIXLIobWAAnnTTJ
	 RBaJEE1cgEAl0VUURY+FIAwvkrK8rUDX9aT7RURahdonGkB7Hz3x2R4piEbpYnZrrp
	 tYXXNswSf+waQRIqMUSxYTCj4WCceE3Ue9SblBNNmuohKHXJtkY31qRGIQnOUfMd8M
	 YNS3UdLj0BMdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1434E80C6A;
	Wed, 23 Sep 2026 09:48:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3147D355
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 09:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22CDD40631
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 09:48:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V9sEpBPmYCPy for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Sep 2026 09:48:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3596440624
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790156882;
 b=NUvLo3a2hT4LqPwxwv8hTpCEgEueXug1nBhQr2TrjoaXQs70uQSjlH0yZtU4VIz2LCLV
 MnrZaFMudxvjJPq6oC3dYkEMvlhv/Xo8DC7Pt56m0OVMd1MNWJiiRVV2Oa0b5ZhXo9rDd
 Ow6y+RwW3KR8U7j2KTFxsEsIEjsUXj4/vTaPRZyPdlkK7FV+tIh463yQKciEcDvo5O2l3
 4+TzVyNuzJvYOK0L++6u7hlWBDAacQv1JXRrYfvLETSEMug3KtTQ6+qzqWlXMxR4tX2EN
 QY9khP83b0325kGwumI4z6Ds/koHi8z4AsCMoFr+57sriS/OUkxiHN6YQr8li37MG5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790156882;
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
 bh=s/+1Sw0GOhAV6aEyxDh3k52oJXron9DMmutyu+sNPUs=;
 b=mea2dguIQdp3P6BJjqoGQDGC95wZi6lZBefN2CeNQPG+cAbvhTXxlpct4fwSI1/3Zalz
 zdxkbcDULmpfWtha3zl4doQ7SVHabKChOejLmD9o0T+x15GzvalgnhNNwrt8Mersdv61Z
 5BatiPUsAyUMLR69iTGHifLtFsvZDHOBoNMthtjiOgzDK+Fzgrvu53SPfBmMWOr8kmh+M
 HsQLagiQKuvx1GhKUxIn1A78CCTya+vi+tMi28GSqsi7V7ibl+542T8/SaXqXZTldV67w
 l5zfnCTAKt7wJe2kEnmSmFH8+NvDUqkH1wm3KUCHFaI4yJ6QgMLTWRb2qLJV5Lu5i7w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EOZFaPB2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EOZFaPB2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3596440624
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 09:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790156882; x=1821692882;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=s/+1Sw0GOhAV6aEyxDh3k52oJXron9DMmutyu+sNPUs=;
 b=EOZFaPB2xlWNUExTyQaSTQX514kk1mC/55ev4oXR/NbjAPLQ7HtZKvLO
 F/YfQkjBRstoN57UFtZ8LI+gmoG3bWXisf5B8pau8C252rXne3g6yqX8W
 lDm+S+Uy8V8U+yry2V+1b/ED73GWcT6HnFpbiAn5wb7P1uC3SjgsejqoK
 PVZE7iKX3l39MqJaZ5CBIVSGf8BB0D1Rtcur16chVmZ3PXfehs2eVKVzx
 oq6Gfi5O/hIFXThUefA/RCq6yucVoYXVgr37uovXTG/lDnXu48pjlhymd
 f8AoYlw0UBoYA/7VgnQh/dhN87juFf2LhD58ApKxhsMrscw2+xmWAeCJj A==;
X-CSE-ConnectionGUID: OIrBg7YdSzadpB0GBordSw==
X-CSE-MsgGUID: LdQ9XlOTR9aXJ7MMXy0BoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101421765"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="101421765"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 02:48:01 -0700
X-CSE-ConnectionGUID: zUj8W4rRRfqCi4Qlj0fo6Q==
X-CSE-MsgGUID: XfvPB8ihSNeHDG7ux4gyKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="272133689"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 02:48:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 02:48:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 02:48:00 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 02:48:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqZgwJzYWG3Ay51dwzgc34TLF7ImUe/VnRhlrOdtvpae9CpqtEmpLRAsHA6bCVKU3RNo33oI1Vww0Gkr8axGoYZQyJXM673aKEz1s13jEmAIAWnMPTo0n9uPxFzeygVQmzI7bMs7iIrO2smzkbiv1KH3Q7Ovav/qACT0uoqE9wvw6fXXEUdllM4nE88dMVZo6qRJRg28Ygy8/lcRKfAv1XlObKmd1mZdRpG9z5rfnbxCjOME9EIkNl3l+fnKEDQNoYpO8iB2rMf19gYiixUg1RKnLR/mCCGXdlVCMxTa0SPyhbOuzHqxQ3pdElyd5b+ZnLpf3QyhdUy44b2nqVTa3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/+1Sw0GOhAV6aEyxDh3k52oJXron9DMmutyu+sNPUs=;
 b=hvjf3cBM9tE+m0okNczsdfOnZFz6OlNp2H1sihvuItQFdnlHUQ0FEjCl5bQVAPpePlwtaZsADTQES5wtvOcH7pzIJP1QfR2fAxhldGmvGzc2H9Sy+vTPEHtSz6F4ItTCjrKwi+OsSLQ1JGTfnh1yBq8ENnQ6oUROMpYP3Mb26DGUIR2dpZ1nlqZUHla/B+7Do90TeIr/49Mv7wFy7wkQNKYDwyQ+6/orow3S9UnE6JQ8NJMyTzm11mO1l4oCjn+qDXLuIknVr9EqQUfcjMTlIHJ1rQo6WSZSr2wwVNZjWJZfIDBM+let8vU6QP08I66t8RtcLJM7Q3bHzQ6dWf0WAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB9487.namprd11.prod.outlook.com (2603:10b6:806:47e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 09:47:53 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 09:47:53 +0000
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
Subject: RE: [PATCH iwl-net v2 01/15] ice: use reference counting and SRCU for
 PTP port access
Thread-Topic: [PATCH iwl-net v2 01/15] ice: use reference counting and SRCU
 for PTP port access
Thread-Index: AQHdSr2v4a/LDrjZAUOcY8aDqAOZhrbb61lg
Date: Wed, 23 Sep 2026 09:47:53 +0000
Message-ID: <IA3PR11MB89865E16941481F634A03E9EE5822@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
 <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-1-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-1-e55b692d0e6b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB9487:EE_
x-ms-office365-filtering-correlation-id: f3a92e81-2727-4a34-537e-08df1957bcd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|921020|56012099006|11063799006|5023799004|10067099003|38070700021|4143699003;
x-microsoft-antispam-message-info: TyyNCPqr2nHl2su6XUoT/UhcPv6FodRVPHmTuoKoKGS7B1OdF7rntMbvuB0QjoLSEGRxmh0awA9fzp3/H8cFz1EUbj62S6ZEZf1J2fpQCPjhC5GAL3QkRnmcWbYtVrN0kVcgn25wluK2eQq9CWlcpJZ81riZDGFSWgd1rPVEN11cI6T3RB2KxCIpWxt1xYWdihWMoaicpH5TR2ywYsn53ylguyppgOeMwOXABdi0CbDQJoysh0a4iocX4ueAcEjvKTx9rxUhABDs29LrDYbhkKBJV9alzdMPwYOPgvRTdANgb/KkTsJbPm4cVGxbedfWGnVdddmU3Pv2E8qtyVuSudV3JvmWGJPBZNB/g9uzCI8M0U0DUJJqQiSiP9Wis57xQbYl+cnZpRG6JHs2pPRpDJ1U6By5inU4IWILkP9mSebjSfjNqYtuk7VW6XRCFa0vnDNnojtYHOhue180kKVIa1wrAOvXeAmcJzbHehuIl51Fu3qCgtKI66yYuTbPouqRZOM1K33B6jXX9tHnsBGK/oEQvbMYJFZuArmvyMpYuXG+HSgnan27dfHq34rCYQBST7XNL/iBxQWbXuYDPlTD3dZk0iHgjjw4aZDNDM7m6eBH/JxRkFCvS7M5kiRVZgdyzkL1epFQEjwUOuUa9JxnbLLxpnM/IXfrE+bNIJJQKZvMKyc/NnA23UrI9TRrPrRn1zTrUfcYjCiGAgtj9nC2q9s9tUZ574N3IIU66oumleweKYuSIpzckKBNWKOf/pYx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(5023799004)(10067099003)(38070700021)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3VHL2hRTzZaak1JQmQrUUU2NjczRmU3YXBxRWlmSnU3b3hnTGoyM29lcWdM?=
 =?utf-8?B?ZisxUXk5ejg5L3k0ckF5aWgvMjh4QUlLYmZwSjB5S1ZleitBNkhhRVE0cHUv?=
 =?utf-8?B?bUFtTDZCTE52RTRYOTRKcDdIOWgzMlVjS1dQS3A4bnU5bTZHN0VUT1BXUlps?=
 =?utf-8?B?M1ltR0VNN1lvbWZib1RvTGVuYUkvUG05NGFaNjhTT3YrMVF4UWJJOTF4V3FR?=
 =?utf-8?B?T2NCa3Y2WXdvei9vYVptRnBBbTVra1F0dGF1YmtEaDMwSlRJQytDenVuVWQz?=
 =?utf-8?B?Z25Bb2JUZEtNZ1dtTGFnZlVVOHRITDdBSkp0Y0xkZXo0N0FuSU9Dek9GcUhh?=
 =?utf-8?B?SFc0NjRnSzVqc0E0Nm4rMnRJMThzejB0RHNTVmFveHFrZ3VaaFdqVE1yQm9P?=
 =?utf-8?B?cVpHTSt4bnFSbDZWR2hqNnRqc0dOaytQSTVETHN2T0JObzRkRHlEeU9SdFBt?=
 =?utf-8?B?MmFaeVB0MUlSNURKSWdrV051cUN2b2sramRCbGVVTHZsSStrWkZRRS9nQW5G?=
 =?utf-8?B?NXNuQUxIbWxXZ1FDTFJGM3FiWmc2d200VU9VZ1hQUm1DUUJYbFBmMkxkRlVV?=
 =?utf-8?B?VStrMHFJaGplRHpMVnh3MkRqSWVEdFZTOENvTW9GNGt1ZnBzMllNWVRvWXBi?=
 =?utf-8?B?N003QVgvMDkyclpDZXRidmF1UTQxYmVTS1YyaXoyTzFpSmdCL2dUcDFDZlRO?=
 =?utf-8?B?RjFZbmw4Sk9JS2hMQnhsY3F4c3hqWUhWekhqSGYwQy9YaFhNMkp4NXlvbWxD?=
 =?utf-8?B?Y0lLNXVReVBIS1NBWkpvSVJzVEFRZWlUa1paOFl5QTJpT2xzcytHcVhkNG55?=
 =?utf-8?B?dVdzOTE1UzJXVmNsSW05TXBrN25zbEx3TXNoK1d2WTNiM2xqSHE0RjFXK2xP?=
 =?utf-8?B?a0lFU29XcEcxZWRmelJoODltOGVrd0pQU202SVZkRkwxRnQ4V25xbVBCTkVx?=
 =?utf-8?B?K2ZkNVZqZ1d6MjZwc01rdGN4Y2I3Tm9lRDAvcmpXQW1pcW1UZlEwcTFuWito?=
 =?utf-8?B?MWdJSmFPMVVpZmRhemwvZXRHZWxHeC8zZWw3QzBENUEyU2xjNms4TjdaL2Vk?=
 =?utf-8?B?TlFIcUw4a3hyVE4wc3Y3L2Q3c0ZsZ2h2TGp3M0pQM3NJOVhZbjZjdWhqTWM5?=
 =?utf-8?B?alRaczlPVTl0VGEzVExBczA3TEJvU3ZHbzliNWVrUkJiOEcrTUwzZU0vRFdV?=
 =?utf-8?B?OTJMV1ZPNXhxeUJRS1hHS1pLajMrOHBYZWhEYjA3enBVK1pjeTJ6RVRGQVhN?=
 =?utf-8?B?SW9PdXE2dVhyNFBUdzdiOGpuRDQvbVZZZXdJMVEyNmNRWG1UOFY5YUlLZ25H?=
 =?utf-8?B?ODllSWdpSlVSSE10Vm1JeVV1VjM2RThGUnpIVFE0bWlhOUJwWGhOQkNtVkdm?=
 =?utf-8?B?bkRTck9DcVp5QkY4SjlrcTJNWjlGUnRZWkdpeEU3MUorV1Y4WlIrNGRVcWgy?=
 =?utf-8?B?VklhNUFvdVJVZ3NYQ0VGanl0WkdYZDJiRHJIN3J1T3JqQ2VaOWREQ1UxZ0V5?=
 =?utf-8?B?MklxVk1KSzNPU3NyeWtEYWNwTElBaHVmUFBuaWpoYk94am9FNTRsWkVjdlVX?=
 =?utf-8?B?K05mNFhxMi9YSm9EUzJpVmFTZ2RRYnVoVUllaUhzRFpUZmNxd0JPOTFxRmN3?=
 =?utf-8?B?TjBweGU5ejgreGZtRXZmdVZnSVI2VytYSEhwU3pLQzdsRnplZHRuS1lKb2tE?=
 =?utf-8?B?QzQydzR1MGUvNENVUWZiQndoUjloa3Rob0hGZDQ5dmd6SmpaZnM5NU1GUWwv?=
 =?utf-8?B?ZGpsL2R0dXJSeWpYSjJaZTIvYmduMDVnek9xL2NnRTJIUTRwUTRDak9vaEJB?=
 =?utf-8?B?czhzaDFNa3NoQnNxbDZmZlVQR3dra2RMbGovc0JEZUY0UVpqRGpFREtleWtI?=
 =?utf-8?B?THhlRUlNSGlIbWlhdUpqelY5OWFYUVp1SzB6R3dBUENURGgzYXNYTGVsNFBM?=
 =?utf-8?B?RzRTTnhXdVFGdHE2dUZTcEJKQnJuMEFjRTFWc1IwTk5MMzhXWUFPakQrMlh5?=
 =?utf-8?B?QUNOV1RpNGdxNHA1OEhUelRDcmVHeWt1SHV3R3BKMG5BWDZQMVFsQnd0LzF0?=
 =?utf-8?B?bWRkOGx2WFZuRTN5bTFkdGRnejB6bmpNNzluRjhNYWIxNS82NnJVcUpMK3lS?=
 =?utf-8?B?djZERW4ySmIra1lGSTlVSEI5STV1NVgvc2E4b1pTajFWUndlVkVaRFNMVzZX?=
 =?utf-8?B?OUdpT3dMdXVGOUFvcERGc0NoUVBkZE53d1NSbkozbEY4Z0RQaDZ1bnlJNC9v?=
 =?utf-8?B?dU4vS1ZpYnpsWFFlb1BRV1B2SWpiVW5hbEk1b1ZsZ3F4UWRCNUZnQlUrZ3kz?=
 =?utf-8?B?ZzV2WktGbWJFMTZIbk1FeXA2NEM3Yys0ckliMmM0OXRkMVhDNXgwNG5aWk1u?=
 =?utf-8?Q?vMyhVCCetIKeDVX0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Lcza7Dz27X4J8mEfCa8mMetBAkEftJLkM4talopEoj3w0bhia/j7pEOTU/sOpnBtShrCsdaTUD4hWYVWRNEAh9qUEPE1Rvm499Hhn75Qk+ehvWrKR/iVDfwdVUdmfsEcPVba2p/n046xUBhhmBiRdZOqa6Vz+DvIyeTzfMckhaISkIGFvwTvArg01nPhSPtt/UwqdSOszt0LK+oFQQOZGteVyXsqqnIrDmkoxc2/JWUdicyfJ68ZWBMkQe5WmfwNl48EraJ+Gi5xNB2xwpbkiP7MvzwrUtNYPKAYFuuR286RtQRxIiGnrj5XodkT9XIaaE19S5Ewn2TgYHzvRDV6xA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a92e81-2727-4a34-537e-08df1957bcd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 09:47:53.0684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhJ83NRacoZ3jBAKRcH11hEFv+io5fcDAB54u9df6Xu9a42yqycXw562tIiZqF1ojiPIuE9TZMCGzeCQLiF0pAI6XlcZM4aglHKtVTG64ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9487
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
Z2VyLmtlcm5lbC5vcmc7IE5ndXllbiwgQW50aG9ueQ0KPiBMIDxhbnRob255Lmwubmd1eWVuQGlu
dGVsLmNvbT4NCj4gQ2M6IEtlbGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29t
PjsgTWFjaG5pa293c2tpLCBNYWNpZWoNCj4gPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0ggaXdsLW5ldCB2MiAwMS8xNV0gaWNlOiB1c2UgcmVmZXJlbmNl
IGNvdW50aW5nIGFuZCBTUkNVDQo+IGZvciBQVFAgcG9ydCBhY2Nlc3MNCj4gDQo+IFRoZSBpY2Ug
YWRhcHRlciBzdHJ1Y3R1cmUgbWFpbnRhaW5zIGEgbGlzdCBvZiBwb3J0cyBhc3NvY2lhdGVkIHdp
dGgNCj4gdGhlIGFkYXB0ZXIuIFRoaXMgaXMgdXNlZCBmb3Igc3VwcG9ydGluZyBQVFAsIHdoZXJl
IHRoZSBjbG9jayBvd25lcg0KPiBtdXN0IGhhbmRsZSBtYW55IG9wZXJhdGlvbnMgdGhhdCByZXF1
aXJlIGFjY2VzcyB0byB0aGUgUFRQIHBvcnQNCj4gc3RydWN0dXJlcyBvZiB0aGUgYXNzb2NpYXRl
ZCBQRnMuDQo+IA0KPiBUaGlzIGlzIGltcGxlbWVudGVkIHVzaW5nIGEgbGlua2VkIGxpc3QgYW5k
IGEgbXV0ZXguIFRoaXMgc29ydCBvZg0KPiB3b3JrcywgYnV0IGEgZmV3IHBsYWNlcyB3aXRoaW4g
dGhlIGNvZGUgZG8gbm90IGFjcXVpcmUgdGhlIG11dGV4IHdoZW4NCj4gaXRlcmF0aW5nIHRoZSBs
aXN0LiBUaGlzIGluY2x1ZGVzIGljZV9wdHBfZmx1c2hfYWxsX3R4X3RyYWNrZXIoKSwNCj4gaWNl
X3B0cF9yZXN0YXJ0X2FsbF9waHkoKSwgYW5kIGljZV9wdHBfcHJlcGFyZV9yZWJ1aWxkX3NlYygp
Lg0KPiANCj4gRml4aW5nIHRoaXMgaXMgdHJpY2t5LCBlc3BlY2lhbGx5IHNpbmNlIGl0IGlzIG5v
dCBjbGVhciBpZiB3ZSBjYW4NCj4gc2ltcGx5IGFjcXVpcmUgdGhlIGxvY2sgYXJvdW5kIHRoZSBj
b21wbGV0ZSBpdGVyYXRpb25zLg0KPiANCj4gVGhlIHBhdHRlcm4gb2YgdXNlIGZvciB0aGUgcG9y
dCBsaXN0IGlzIHJlYWQtbW9zdGx5IHdpdGggbW9kaWZpY2F0aW9ucw0KPiBvbmx5IGhhcHBlbmlu
ZyBkdXJpbmcgUEYgaW5pdGlhbGl6YXRpb24gd2hlbiBlbGVtZW50cyBhcmUgaW5zZXJ0ZWQuDQo+
IFRoaXMgdHlwaWNhbGx5IG9ubHkgaGFwcGVucyBkdXJpbmcgZWFybHkgYm9vdCwgdGhvdWdoIGEg
UEYgY291bGQgaW4NCj4gcHJpbmNpcGxlIGJlIHJlbW92ZWQgb3IgbG9hZGVkIGF0IGFyYml0cmFy
eSB0aW1lcyB2aWEgYmluZCBhbmQgdW5iaW5kDQo+IG9wZXJhdGlvbnMuDQo+IA0KPiBUaGUgdXNl
IG9mIGEgbXV0ZXggZG9lcyBtZWFuIHRoZSBkcml2ZXIgY2FuIHNsZWVwIHdoaWxlIGhvbGRpbmcg
aXQsDQo+IGJ1dCBpdCBzdGlsbCBjcmVhdGVzIGNvbXBsaWNhdGVzIHdpdGggbG9jayBvcmRlcmlu
ZyBhbmQgcHJldmVudHMNCj4gaXRlcmF0aW5nIHRoZSBsaXN0IGluIGFueSBjb2RlIHBhdGggdGhh
dCAqY2FuJ3QqIHNsZWVwLg0KPiANCj4gSW5zdGVhZCwgdXNlIFNSQ1UgcHJpbWl0aXZlcyBmb3Ig
dGhlIHBvcnQgbGlua2VkIGxpc3QsIGFsb25nIHdpdGggYQ0KPiByZWZlcmVuY2UgY291bnQgb24g
dGhlIHBvcnQuIFRoZSBrcmVmIHJlZmVyZW5jZSBjb3VudGVyIGVuc3VyZXMgdGhhdCBhDQo+IFBG
IHdpbGwgaGF2ZSBhIHZhbGlkIGxpZmV0aW1lIGFuZCBub3QgYmUgcmVtb3ZlZCB1bnRpbCB0aGUg
cmVmZXJlbmNlDQo+IGlzIHJlbGVhc2VkLiBOb3RlIHRoYXQgdGhpcyBjaGFuZ2UgZm9jdXNlcyBz
b2xlbHkgb24gdGhlIHBvcnQgbGlzdCBhbmQNCj4gZG9lcyBub3QgbWFrZSBhbiBlZmZvcnQgdG8g
cmVzb2x2ZSBhY2Nlc3MgdG8gY3RybF9wZiwgd2hpY2ggaXMNCj4gY3VycmVudGx5IGJlaW5nIGlu
dmVzdGlnYXRlZCBieSBhbm90aGVyIGRldmVsb3Blci4NCj4gDQo+IFVzZSBvZiBzbGVlcGFibGUg
UkNVIGlzIHJlcXVpcmVkIGJlY2F1c2Ugd2Ugb2Z0ZW4gaXRlcmF0ZSB0aGUgUFRQIHBvcnQNCj4g
bGlzdCBhbmQgcGVyZm9ybSBvcGVyYXRpb25zIHRoYXQgbWlnaHQgc2xlZXAuIEF0dGVtcHRzIGF0
IGltcGxlbWVudGluZw0KPiByZWd1bGFyIFJDVSBoYXZlIHRodXMgZmFyIG5vdCBwcm92ZW4gdG8g
YmUgYWNjZXB0YWJsZS4NCj4gDQo+IFRoZSByZW1vdmUgcGF0aCBmaXJzdCByZW1vdmVzIHRoZSBw
b3J0IGZyb20gdGhlIGxpc3QsIGFuZCB3ZSB1c2UNCj4ga3JlZl9nZXRfdW5sZXNzX3plcm8gdG8g
ZW5zdXJlIHRoYXQgc3VjaCBwb3J0cyBhcmUgc2tpcHBlZCB3aGVuDQo+IGl0ZXJhdGluZyB0aGUg
bGlzdC4gVGhpcyBlbnN1cmVzIHRoYXQgb25jZSBhIHBvcnQgc3RhcnRzIHJlbW92aW5nIHdlDQo+
IHdpbGwgZHJvcCByZWZlcmVuY2VzIGFuZCBubyBsb25nZXIgYmUgYWJsZSB0byBhY3F1aXJlIG5l
dyBvbmVzLiBUaGlzDQo+IGF2b2lkcyBsb29wIGl0ZXJhdGlvbnMgY2hhaW5pbmcgdG9nZXRoZXIg
dG8gaW5kZWZpbml0ZWx5IGJsb2NrDQo+IHJlbW92YWwuDQo+IA0KPiBUaGUgaWNlX3B0cF9yZWxl
YXNlX3BvcnRfc3JjdSgpIGZ1bmN0aW9uIGlzIHVzZWQgYXMgdGhlIHJlbGVhc2UNCj4gZnVuY3Rp
b24gZm9yIHRoZSBrcmVmX3B1dCgpIGNhbGwuIFRoaXMgdXNlcyB3YWtlX3VwX3ZhcigpIHRvIHdh
a2UgdGhlDQo+IHJlbW92aW5nIHRocmVhZC4NCj4gVGhlIHdhaXRpbmcgdGhyZWFkIHdpbGwgYmxv
Y2sgdW50aWwgdGhlIGZpbmFsIHJlZmVyZW5jZSBoYXMgYmVlbg0KPiByZW1vdmVkLCB0aGVuIGl0
IHdpbGwgdXNlIHN5bmNocm9uaXplX3NyY3UoKSB0byBlbnN1cmUgYW55IG91dHN0YW5kaW5nDQo+
IFNSQ1UgY3JpdGljYWwgc2VjdGlvbnMgaGF2ZSBoYWQgdGhlIG5lY2Vzc2FyeSBncmFjZSBwZXJp
b2QuDQo+IA0KPiBUaGlzIGZsb3cgZW5zdXJlcyB0aGF0IGFjY2Vzc2VzIHRvIHBvcnRzIHZpYSB0
aGUgYWRhcHRlciBwb3J0IGxpc3QNCj4gd2lsbCByZW1haW4gdmFsaWQgdW50aWwgYm90aCB0aGUg
U1JDVSBjcml0aWNhbCBzZWN0aW9ucyBoYXZlIGVuZGVkIGFuZA0KPiBhbGwgdGhlIHJlZmVyZW5j
ZXMgdG8gdGhlIHBvcnRzIGhhdmUgYmVlbiBkcm9wcGVkLiBTdHJpY3RseSBzcGVha2luZywNCj4g
U1JDVSBhbG9uZSBtaWdodCBiZSBzdWZmaWNpZW50IGZvciBleGlzdGluZyBjb2RlIHBhdGhzLCBi
dXQgdGhlDQo+IHJlZmVyZW5jZSBjb3VudCBhbGxvd3MgdGhlIG9wdGlvbiBmb3IgcGFzc2luZyBh
IHBvaW50ZXIgdG8gdGhlIHBvcnQgb24NCj4gdG8gb3RoZXIgZnVuY3Rpb25zIGlmIG5lY2Vzc2Fy
eSBpbiB0aGUgZnV0dXJlLg0KPiANCj4gT25lIG1ham9yIGNvbXBsaWNhdGlvbiBvZiB0aGlzIHJl
ZmVyZW5jZSBjb3VudCBpcyB0aGF0IGljZV9wdHBfcG9ydCBpcw0KPiBlbWJlZGRlZCBpbnNpZGUg
b2Ygb3RoZXIgc3RydWN0dXJlcyBhbmQgbm90IG1lcmVseSBhbGxvY2F0ZWQuIEFzIGENCj4gcmVz
dWx0LCB3ZSBjYW4ndCB1c2UgdGhlIHN0YW5kYXJkIHBhdHRlcm4gb2Yga2ZyZWVfcmN1KCkgdG8g
anVzdCBkZWxheQ0KPiBmcmVlaW5nIHVudGlsIHJlZmVyZW5jZXMgYXJlIGRyb3BwZWQsIGFuZCBp
bnN0ZWFkIGFyZSBkZWxheWluZyBQRiBwb3J0DQo+IHRlYXJkb3duLiBJZiBhbnkgY29kZSBwYXRo
IGxlYWtzIHRoZSByZWZlcmVuY2UsIHRoZSBkcml2ZXIgd2lsbCBiZQ0KPiB1bmFibGUgdG8gdGVh
cmRvd24uDQo+IEluc3RlYWQsIGEgMTUgc2Vjb25kIHRpbWVvdXQgd2l0aCBhIFdBUk4oKSBpcyB1
c2VkIHdoZW4gd2FpdGluZyB0bw0KPiBmaW5hbGx5IGFsbG93IFBGIHRlYXJkb3duIHRvIGNvbnRp
bnVlLiBUaGlzIGhhcyB0aGUgcmlzayBvZg0KPiBwb3RlbnRpYWxseSBhbGxvd2luZyB1c2UtYWZ0
ZXItZnJlZSwgYXNzdW1pbmcgc29tZSBwYXRoIHJlYWxseSBpcw0KPiBzdHVjayBmb3IgMTUgc2Vj
b25kcy4gSG93ZXZlciwgdGhpcyBib3RoIGxlc3MgbGlrZWx5IGFuZCBhIGxlc3MgYmFkDQo+IG91
dGNvbWUgY29tcGFyZWQgdG8gYmxvY2tpbmcgaW5kZWZpbml0ZWx5IG9uIGEgcmVmZXJlbmNlIGxl
YWsuDQo+IA0KPiBGaXhlczogZTgwMDY1NGU4NWI1ICgiaWNlOiBVc2UgaWNlX2FkYXB0ZXIgZm9y
IFBUUCBzaGFyZWQgZGF0YSBpbnN0ZWFkDQo+IG9mIGF1eGRldiIpDQo+IFJldmlld2VkLWJ5OiBN
YWNpZWsgTWFjaG5pa293c2tpIDxtYWNpZWoubWFjaG5pa293c2tpQGludGVsLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9hZGFwdGVyLmggfCAgMTYg
Ky0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5oICAgICB8ICAg
NCArDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkYXB0ZXIuYyB8ICAx
MSArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyAgICAgfCAx
NDUNCj4gKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDEz
NCBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkYXB0ZXIuaA0KPiBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYWRhcHRlci5oDQo+IGluZGV4IDRmNjk1ZjMyZGEzZC4u
OTNmMDQxOTQzYmRkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX2FkYXB0ZXIuaA0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2Uv
aWNlX2FkYXB0ZXIuaA0KPiBAQCAtMTcsMTUgKzE3LDE5IEBAIHN0cnVjdCBpY2VfcGY7DQo+ICAv
KioNCj4gICAqIHN0cnVjdCBpY2VfcG9ydF9saXN0IC0gZGF0YSB1c2VkIHRvIHN0b3JlIHRoZSBs
aXN0IG9mIGFkYXB0ZXINCj4gcG9ydHMNCj4gICAqDQoNCi4uLg0KDQo+ICAJc3RydWN0IGljZV9w
dHBfdHggdHg7DQo+ICAJc3RydWN0IGt0aHJlYWRfZGVsYXllZF93b3JrIG92X3dvcms7DQo+ICAJ
c3RydWN0IG11dGV4IHBzX2xvY2s7IC8qIHByb3RlY3RzIG92ZXJhbGwgUFRQIFBIWSBzdGFydA0K
PiBwcm9jZWR1cmUgKi8gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lj
ZS9pY2VfYWRhcHRlci5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9h
ZGFwdGVyLmMNCj4gaW5kZXggMmRjMzYyOWQ2ZDBmLi44NGFjNWVlNWE3MzkgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYWRhcHRlci5jDQo+ICsrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYWRhcHRlci5jDQo+IEBAIC02LDYg
KzYsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L3BjaS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3Ns
YWIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KPiArI2luY2x1ZGUgPGxpbnV4
L3NyY3UuaD4NCj4gICNpbmNsdWRlIDxsaW51eC94YXJyYXkuaD4NCj4gICNpbmNsdWRlICJpY2Vf
YWRhcHRlci5oIg0KPiAgI2luY2x1ZGUgImljZS5oIg0KPiBAQCAtNjYsMTggKzY3LDIwIEBAIHN0
YXRpYyBzdHJ1Y3QgaWNlX2FkYXB0ZXIgKmljZV9hZGFwdGVyX25ldyhzdHJ1Y3QNCj4gcGNpX2Rl
diAqcGRldikNCj4gIAkJbXV0ZXhfaW5pdCgmYWRhcHRlci0+Y3BpX3BoeV9sb2NrW2ldKTsNCj4g
IAlyZWZjb3VudF9zZXQoJmFkYXB0ZXItPnJlZmNvdW50LCAxKTsNCj4gDQo+IC0JbXV0ZXhfaW5p
dCgmYWRhcHRlci0+cG9ydHMubG9jayk7DQo+IC0JSU5JVF9MSVNUX0hFQUQoJmFkYXB0ZXItPnBv
cnRzLnBvcnRzKTsNCj4gKwlzcGluX2xvY2tfaW5pdCgmYWRhcHRlci0+cG9ydHMubG9jayk7DQo+
ICsJSU5JVF9MSVNUX0hFQUQoJmFkYXB0ZXItPnBvcnRzLmxpc3QpOw0KPiArCWluaXRfc3JjdV9z
dHJ1Y3QoJmFkYXB0ZXItPnBvcnRzLnNyY3UpOw0KSW4gdGhlb3J5IGluaXRfc3JjdV9zdHJ1Y3Qo
KSBjYW4gZmFpbCwgc28gZXJyb3IgY29kZSBzaG91bGQgYmUgaGFuZGxlZCwgaXNuJ3QgaXQ/DQoN
ClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGlu
dGVsLmNvbT4NCg0KPiANCj4gIAlyZXR1cm4gYWRhcHRlcjsNCj4gIH0NCj4gDQo+ICBzdGF0aWMg
dm9pZCBpY2VfYWRhcHRlcl9mcmVlKHN0cnVjdCBpY2VfYWRhcHRlciAqYWRhcHRlcikgIHsNCg0K
Li4uDQoNCj4gIH0NCj4gDQo+ICAvKioNCj4gDQo+IC0tDQo+IDIuNTYuMC5yYzAuMzk1LmdkMWYz
NTI0ZTE1ZGMNCg0K
