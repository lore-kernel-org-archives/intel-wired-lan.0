Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3997C88E72
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 09:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E9CE60629;
	Thu, 17 Sep 2026 09:40:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GJidfGNf9bJl; Thu, 17 Sep 2026 09:40:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D59FC60840
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789638018;
	b=jSMyCGWBDi1ZjIQPvLNvnBVaR4A0LvNZlj2Ofm3E84oicbZ0sNfERPFhNuReMmS6cow9
	 OgiGzlZ6OY6ibTbEJNUYkk8t5aUpFkDzwcTcufsawXFMQ3j4YlZ8JvS0hIj+bhOJctqVV
	 H0R5f9RdHw5Ky2Iflqd61ZHjbnsYftXNUXjl9SFpbqWVHb1pP7NcTtBuA/0rxjss5YQ/O
	 Ba8f+JAaeL2pEq2rh2XfYJb/TkmAu61BBLgt7/SwRaeX6kWqz594bibCzxkT8tJJdQAU3
	 lE8wAaSXq4GyPDNliD6IiA+XcUakOd9oyfitb0+nhXex5L4A8PSUPhN6QWWTEHfKK9A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789638018;
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
	bh=jj+IdsU7oDLcxvjNpPsJa4gkQT9K/mM/j0dlhDB7i8k=;
	b=XXkU0aYdiczzX2WMgCL+DqU2LHu/qH9NnGO3oRXmAbGZudZftUzaj6buzVfCUzeEMU3d
	 2nGYa0iPMkIuGfKRAgtWFnVjmt25Oh+DpwTSO3MaBeRoiC6kGbwHhS6GnwtwlQeyBAnwG
	 vlMWKhTHT8svOglYbo+a8+q8g6c21ea6ClN1rMMIUYPmdiiTCi6iRFm8UGPj008ELxUyL
	 5FrntFUw/Iq+WLLN6/RamEeIZ3JiQ1rrKu27w/JahAqhZpCLO7QLlE/jKUG2VJovi6qAX
	 tEx09YFjpnuLIXYfIckN+3UqeYanZV35UWTpyFxdnlJ5vrKh6XcnqIgZ9I/6e4mIc2Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789638018;
	bh=jj+IdsU7oDLcxvjNpPsJa4gkQT9K/mM/j0dlhDB7i8k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E8KoPaU2/F/OYr6y237uwEBNo9KaWKSYa3hZQOvYAs0PiCuqEz4/3PrmddJJYGytp
	 u7xiE62yFzPKqjLwVsnLjJUXVDhmi57UZeOdYCbEG50ey3J3ds7fIHhLS6joNZ/fiA
	 fRpy5MsGodAyra3Dtb4DoqSC+kzbqnkFtbFJMFeY3oV+XkWRCHhS0iq/LfS/mf2buM
	 u1UN9iT5FT2stoL8wDoJhx85Qvt+N/CQ7/N4MlDVq+59hwYnfli83CKHBqF8V6HQ8r
	 Ct+aj0RSjItv67+FLilRdNaQWKf6/U4njLtJ87XPdiR+9uejGmUfo73FPD/v14hACt
	 5VaEvatNk9ehA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D59FC60840;
	Thu, 17 Sep 2026 09:40:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F8A92EB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:40:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 211C040746
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:40:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7VntDtjNk0a4 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 09:40:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5E6E6406FC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789638016;
 b=Rac5bXI9o30ymqznSL28Jh7+AhtHcCYhySBsLo1nCm7lPMKfrn4ThBHRui8XX/8Dl5y/
 bskLcPTvScHZCugU/LNgAxJXfrJdsdGdjN41nKbBOVaavXpZUXHFsAcZEl991Ny95/jOo
 3i9dsbTISI+z9KhJV/jUIhX5AV3hluci0MvQ6g10nUbPA16eEbt7pQBN4CXg8giC0aaaz
 yZW51lFN7Lu7zoQ0YyU1bznZRgEQxZSmkQwgnEETmjRGaG8kSphWP4OrH16rOIP4Ri+8Y
 zQ9gnNNZLJEnejIUiXDqKq8eGKiC37friIddX/2pgiosIyCs9fSVUiq5J29lJ+7Hf1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789638016;
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
 bh=jj+IdsU7oDLcxvjNpPsJa4gkQT9K/mM/j0dlhDB7i8k=;
 b=H5G/pafxiJK534wR0bMhMDcnrroMHQVw5dX0Vl8INi19geoBn8Sn0OYo9f0t6GvcUWaY
 Lb+Uab+/MfRTkvBzAU6tA7bEbV/Gv8/GL4SSWyL346eUU2iq2LOlvqKkkxcWhP1e0ilWl
 SPf2XgwPVULZzDnSmxrg0omIXDP640IJSYpR6fSJzkFdkvAivZ7fnGhJejte4sPl7UdPV
 69bujeRzztZyEm6TfI4YV7IuOrZ6qUvHV5o3JdkALLHnehEL2l0bKb/VRyLv0p28bqLws
 YnnD5YEOa+470z/kLhk4FENyYGK7NZvAXf5yOEFeoR6MIGRs1MKdk2K1QEQ4/6H/nKg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=N+SM+QnA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=N+SM+QnA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E6E6406FC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789638017; x=1821174017;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LIHjt7VCv6PtB0lujLVQm6EJyayu2e+mtZkJyqrZtfU=;
 b=N+SM+QnAFlk5IeHfQf64ItrRty4JM4qxoUg3zvmXH6lczTARmJ56ByZM
 PoaBA6YGFrsmcY1pQROAnswum+GfeO4kVLLElBUNFponi9GH77SOJFo54
 TGFYSW2wREb/pXknq6U8CdxJ94yTSoVzy9GJXQGJlVyteN/6b+qlKJHhO
 d4qVh/i7DvRye974ItJL3rNlJHfKAaIE5btmELMmY3qwo9D6uRf12Gfzy
 YBmV13TMqo2ELa5rPx8cyyRwivClyMGZN/6iGi93jZ43+UvcLT9q/pmEn
 BV7Lk1N0aTQrug/Xv860wkRtP/ARg6MeMUGgG6SCofA/0n+emSo1QN3v+ A==;
X-CSE-ConnectionGUID: FLDveotHRhm3po3qPWkY6A==
X-CSE-MsgGUID: YcL5PHkCR7iXCnJU7azshA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88978150"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="88978150"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:40:16 -0700
X-CSE-ConnectionGUID: WPKjbOpbQXic9FJlg24Vhw==
X-CSE-MsgGUID: /XNwiT4OQeCzjU5B+XS9TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="297170146"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:40:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:40:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 02:40:14 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfXRysf4hsVv5orGtU2svq8528O29/X9+qIQjVuOv3v4YgASCUXCir39P4W2slRiIJL3lLqttTwh2opSKe1+FnjUzUV1jC/kKJDXFifBZSuYJkBl2rvFBVNMPbOhVjDDY6DzKogD0JFs6qc0esAuXD3+UEcLmdIkcbAc2q9Hibjpkts9DKzAh14ZcAp+FIyZBYfuU8eD2DFpVjpd5YPKLCvI53lMrAspKGu67g+dW30Xmpk/T1TjhPqWGsG46KkzxHgoiq04xYuAke8coeiuc+OAu+7+9wI+0M252IE30lfypEtalBVSzoRX+c/My6U/dGCCBOE4hr8npjzxA8pWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj+IdsU7oDLcxvjNpPsJa4gkQT9K/mM/j0dlhDB7i8k=;
 b=Vd4ywhS9SIO5L1A1P89twsm4ib1SNk/qKdCHHREGE10+iqyWJGp8EHG0tdwgJ3Qupn8SH+kc/FdpvgStTMsyvdPkD3DG58catGxuCovHWJmr0SAngWhvFYoMfEjaBG1T/33VeKWTbD4tNpd3JfiDGev2iRgoaFC8FPhKs+JmuFcl/5/rWjkOp0sfbHXPjY/LbSdY3QUdUpVu3txK6Wg0LEbfRUQx772KsZiF+azDlpP8MLKFyUJhZqcCBpXYW1R9WY4O3n1yjgeTv7CfXEpieiHTt6YaecVmh2suzs3+8ZdV0PnWKfk9tM8StcxNQbzL04J4sP8TiQi7hiuVXSdTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DSWPR11MB9798.namprd11.prod.outlook.com (2603:10b6:8:3c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:40:12 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 09:40:12 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] igb: fix uninitialized first word
 in igb_set_eeprom()
Thread-Topic: [Intel-wired-lan] [PATCH net] igb: fix uninitialized first word
 in igb_set_eeprom()
Thread-Index: AQHdReLSUmE0GtWSvU2pDNl6wGujC7bShT/Q
Date: Thu, 17 Sep 2026 09:40:12 +0000
Message-ID: <IA3PR11MB898642B2EB4F40739620B64BE5B82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260916135254.1016847-1-xiaolinkui@126.com>
In-Reply-To: <20260916135254.1016847-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DSWPR11MB9798:EE_
x-ms-office365-filtering-correlation-id: 8b3b09cb-2544-4250-366c-08df149fab9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|22082099003|18002099003|921020|38070700021|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: yFyJNwFk7H95cAfpIqpFdpxmm6iJHr0TzK3FibOQ4zDxXh22Q/vd1HNbcHT6L+lMPUcV5Oz+WG9wXICvrWgsDCG/4hCHDh+x4A1LaxC631q5MfVq6c/bSbz4Cm9e5vUlifSroKKLuWwwmJ2qBDPu9BTx8Lh+8/3iwcFHNjmIKBClJBGAWLb+E4qYvrRykCrdoLORwDeHHldAWhFcx6kMgq+o8jK5k9EBoO6sy+SVtQwsO63+qjdmt4bGdwxt9sF/2qLqXzhy1gi/ZIqLH+dFK4Far64mjUjL+VeWl8IF4P82BSAGP51I3wUE+BRVIQxt5iLPO1sFpm68Vadsl0YfrPtbC3LJVYsszUb2b/+YAthCipF7Z/9SnPsq8ssMEJPvlD0tsgTx6K+0s1i+zyVhU2dgOmiTuhaWH7JeNoO0bUMQfhe/kx9bmo1ILulzo9b7sgzCGf1oYyoCUML0OnY+xzZbYWul2RlyNku2QysbVIovijB/xoxooLj5VKVgS0ZkdHbGt61rKFB+EWq/qVO5GCgYwf8N62HWEaRilygpuude9yRKLTbap1t0IEraRhAZ90KW1Y48COIhX9Ue+qnbmKA6iN4PVcyNt0Jrfq+NTTqto4qeom0IJiG+0UdrmvEfRNoNFG1YRVgyaJG/YWIj4ULCe10inYvO5CH2eNAzW1dwYmp86bEapuwzzHoqPJ8oHQBnVJO6SCnvq7p4LYcXAaSJlCmlIQx67RD36i9n1wHXUthVsN/ndry3VEdOqj4R
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(921020)(38070700021)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oy4+ZLI9NzXWTbBF6zaVBOmmEXxVGaSxhGdxwrcPI6YA9Jrewc9KyQ3DEsvS?=
 =?us-ascii?Q?jHyiRspWiSrKJzR3fowvwoSDfXi5dtVMe1CDpC3KiLe56wbzBv6TteL0kGku?=
 =?us-ascii?Q?qEen5XboH+HhiaYY6VDmQRhCRanjLG0c3VYKNnR2rlH90XPh+EDfWJ9I277H?=
 =?us-ascii?Q?GQpinTSQaMP+XF0sMKlu5g9H+Y85KIDQjAkkiaYXjr9gZg8jcOGLAEOciRRf?=
 =?us-ascii?Q?YQR5ZgIgso2WI0eAKOY5LQssgHZ3tSU/UX1Kz18EB7rgc8m6HFsyLF2xc71P?=
 =?us-ascii?Q?X79RavdxjT7omjqHpoGrR6b8/QPswepbW5WMviSvVj44OwTnhhMTvA8+viiD?=
 =?us-ascii?Q?PTJCnvujOi6JWOxNw9heFyKO37m6pTKjQCUfxe0Ie43Mxv/6b5PNyZ1Lnkmf?=
 =?us-ascii?Q?5pSVM6JkubTNJkfafIevvRcGRtGHirUH700olnTrPzHoyUa3hhd1rn0OZ6mO?=
 =?us-ascii?Q?m2dvt09oQOsSDPY5bL3L9TMv87WjGNWXi7nQXZy5lcpqxPrk25BZogm2bxBI?=
 =?us-ascii?Q?XtPC836y5LeXtbZgN9Op3WEvnxuCh37uXzOWW9slMCpyGe5LY6rr7RtTkfPd?=
 =?us-ascii?Q?Ban14+8/wzS1ibZ5jOSWew0423r67MJW+ilWvFFLGQ5u1sDxSDNTDWOWKkgT?=
 =?us-ascii?Q?hkcq9ppObIdPzyGxoyjnLJQ231RNM38aHrFF7YDVXhKTOJZ0nfSZi58L4kfL?=
 =?us-ascii?Q?L7t/NP6V+aflNyvkqpzVEVyxuLmuALmMrLUQdOf4Srlu2Fsa9JoElW9Je1s9?=
 =?us-ascii?Q?TVKMB0F9o0WrvKGPmaGy2OSvvlSXPzxwqSWKkDLgj3yyhWIYa6KlIIqcAajt?=
 =?us-ascii?Q?8uP8Eq4M8i/e1RonLPx9UzA3KTTLZdCxmZYeVhBE2TZzdJDLcf3OWMuq3iMN?=
 =?us-ascii?Q?OPSjkZbO07eXspEpTxmoWUOWGKBiz5cgtIjSn8MET84/ZPaQvI62QHGqKbA3?=
 =?us-ascii?Q?1msxQfhcAm3drICPAtBRhoCnlKaRKhf3A9gf+RL8N2ogPvbHFDea/6cnagd8?=
 =?us-ascii?Q?NmJBEnQWtUnRLWcOl5/h8a/e7oKaqenDXPMFqsqmrknRX36zauzjejyh56Ub?=
 =?us-ascii?Q?Ynzm69sPoXoZpRMbO4N+ZLVzZ9j5rsYmuY1yoRSvWCek8kOEBEFLg0tDWOaT?=
 =?us-ascii?Q?kxOnxR/8rctOW3UFr0LAHNzZaFy2UQzlZwJKosJKoW6Cgo1J8pK8Gq17++NY?=
 =?us-ascii?Q?dhSG9ZqiKw0YUUrrC+uJHPg7GLYzTTqFPvTPhlx570qFtKrnv5rrKAhTaxgz?=
 =?us-ascii?Q?e4M5DBRpqbYTPfegR/me08KD2JxKes+sEBDSPJUchOqNObwz9tvQzrC+cLOL?=
 =?us-ascii?Q?gYCWicPoSdIOWhAeaOK/mGlxIxq4RaHyViODoTQFVJ5IpBD5bYd9WhF3Lhjy?=
 =?us-ascii?Q?FS542E/7KGkpGtFB5R8nJ+E+VTsdEj9maEzkH3nGqqRVl2YcbYY5hUN0nfF5?=
 =?us-ascii?Q?eb1fKgc9ES7XIgVHYKkP3Nrs5DsIaK99dBybF5EUO463DkUOFQpwYmLqNnZz?=
 =?us-ascii?Q?4/uglyXEZ36k9PYyv8QfbG5meX9TD2bTNtiirAOMquwEgb6hcYzKPjumr9AM?=
 =?us-ascii?Q?b1UQYzYV+kBv8v7/huYcke6JjR8GMInpPyhiYeShUudpf5PE5py+Ht2lRT+L?=
 =?us-ascii?Q?D9cSRJ+8z8cDv/+6ARF6TAiTWzJy7CYjPMJyJNKqJ3G5NXlsz1JCUN+2G0os?=
 =?us-ascii?Q?FyJTq4TJar29VaFAyOwO6dWg+U1rcTUqxS67W0SzQZVHIAr+sO4J6Hb6V+c7?=
 =?us-ascii?Q?KaL7vvFW2w1reCNIbttW4nsv/83/nNY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ovm3L/rHYKM+w/NHYUamWm577fcvHkbLANYnYWCeYuaVeIPp9HpowNlLlj3CKt1UUM5OvnoLXPWUlfhG7IY348AAP5KEQy87adIxG2kbG/+z0k9cIJdPEgHsM/aGqytIRRwUD+FzohfrEvOD4ulSRbsaX3lJ957MMZzxOl1yp+gE39c74WtAdtqow8g7LmTNjfFiywz2jZn8WmuZfKbOWE/6NPMKHzn2qY9LB049P6Ih8Z/rdL+z7I5ErunX3vc+XIG8AHYWnfOqVOn9tX5WI6zlaZXava0oJO0KJ5S2kgT2HxqTDAx5Fop+Ulu1QokTVVQkZpG71K6UVFjObJAOgg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3b09cb-2544-4250-366c-08df149fab9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 09:40:12.0862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlaecTHalf/S5sEnT8i9mZ25FROiTqNo+i4mbdiYyrufXLGuYmnFs0VgIhxfC7WQ/kldBx4vFxHmMiJHD2wyx64AgbD7suQ7YpzWfaoHENU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9798
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
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Wednesday, September 16, 2026 3:53 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>;
> stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net] igb: fix uninitialized first
> word in igb_set_eeprom()
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> igb_set_eeprom() does a read/modify/write of the first EEPROM word
> when the requested range does not start on a word boundary. The error
> from that read is stored in ret_val but never checked, so the function
> keeps going with an eeprom_buff[0] that kmalloc() left uninitialised
> and programs it into the NVM. The read failure is not even reported,
> because ret_val is overwritten by the result of the write below.
>=20
> The write is followed by nvm.ops.update(), so the corrupted word is
> covered by a fresh checksum and the damage survives a reload.
>=20
> The read of the last word already bails out on error, do the same for
> the first one. Skipping the write also keeps the stale ret_val from
> being lost, and igb_set_fw_version() is correctly not called since the
> NVM was left untouched.
>=20
> Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 65014a54a6d1..19ff9eb2c4d2 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -814,6 +814,8 @@ static int igb_set_eeprom(struct net_device
> *netdev,
>  		 */
>  		ret_val =3D hw->nvm.ops.read(hw, first_word, 1,
>  					    &eeprom_buff[0]);
> +		if (ret_val)
> +			goto out;
>  		ptr++;
>  	}
>  	if (((eeprom->offset + eeprom->len) & 1) && (ret_val =3D=3D 0)) {
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
