Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD1DCA9EC5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 13:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1230F60607;
	Mon, 12 Oct 2026 13:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dD_pHMJqStvJ; Mon, 12 Oct 2026 13:55:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0272D60665
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791813326;
	b=mmq/i2efNa/eeceStK/CUVthNfIDdycci+/cPrl2L2cRE16na17adyc+0B7u1M5YOPi2
	 g0II0/Sv3Hgml+xvZMKvnHMyW1kEOluYqiojLhNkubVMXyknZiAqUsLhtkiRs+J5sOpls
	 q7ShRd5DofL83VX3j2zf1PuW+OB6KyKuaa1icDJt/xQCFvjmqCDLzRSp06imuC9POjwwN
	 ZlSnjou3X8zihMsfpuLMyEeU72IzIoyFY9FvobtL+MXSmy36y3uihQF0Isq6R250kHUXz
	 aqSHECx9hKp3dgMx4CjYrOo3HVxBTECO58wKiQ1/iEj6Hkryw06nFNjx1105/DEsTVA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813326;
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
	bh=kb+zkIxX1CWvzORZI9PYvBtVnQwIwYCZmuJLsJrbh6k=;
	b=hP28cHCXa++/ThLgD8DGy0Bd8NTzvtbiN95N7EG7oVpcm59WtYcX52GTpAiyBhg4SPue
	 c0r6dMAeZRe/89r8I61Te3GHKOvl0ShvlRrTkNTWtH3+Q/4EZBGzbPKhdPcUIBlxvBYPq
	 kdPClOh3Pb6iKMno0AVp+moOuk7wla23U6v65XlKt16S4JidROwuTcvBvTqs81IyUaHeT
	 NNTKaZpzB/70/NPnfbjk9eQg951mN43l6S/ETF1kzD1LHs4ggj15UpYcMEAy1NmNfFQB7
	 fovrk89xt6cUnvrnHysNdSLPMAayK+HBEUhE5s+YthAyWUjDK8FQKQDEXbBkg57pcNA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791813326;
	bh=kb+zkIxX1CWvzORZI9PYvBtVnQwIwYCZmuJLsJrbh6k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vMHPE73/NJuF2sEt8obwwcf+Jm3WqQE5tNq23iCRL/Mrn4inNaO3md0Z0ZRA7AtwV
	 sPMHq4+ovXRo4kDKTtODfYrGmHlYu6cNeozB7ijjWR4UJTRGWGMYZF9Z2lAl1zGc21
	 w00LXivkTvP7wGAXpGSX030TnudZC9R7eIq1H9UyPVcKUXdL62rOQuK05Umb72BnOs
	 ykKfL1W6kI5jdPVWSUnpvkFAEcL2Ocx/VelACNG4IeBXYk6UsZGfjYQ9ztuKribIKR
	 luP4TFeYNZ3wzHQI86oytUe3XJVBzrJjLgjDzYpw/J+OMphtvm9Pj2DiuXyBd6Pb6M
	 txgXPcURicVsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0272D60665;
	Mon, 12 Oct 2026 13:55:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FF46156
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8105F405AE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:55:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52xFy6TsMzzM for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 13:55:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D751A405A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813323;
 b=PViQNOGj519corlYobw8EzL20uOqHwaZ78uS1ZcwjRw3PE+KOijzS7Hun5wRRukHZSSo
 QuBR7RODDXAicRvHY61iG5WZQN/grd/XJF65elmnZMx/iFzsuR/JSzsLFlPfG/qPOHqCN
 qdXHKg6PeqpYBPC0380+UsFzvXTYFcuz2FVyARO/xnEvnYSYtXIG7CkQ0fL/QWlO3yl5F
 V9JrSTyCgwV3TiQkeDrID6FZqE9qBOwf/q0rp6Y8aXiW9A9X1L3J1DKzJ2nusorTaRZES
 /zzOwOJ29YF37eE/YJbYZYlU3DSsE6VfekTDeXMMvZfm5R18ytzDyyESksWG0IjMsGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813323;
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
 bh=kb+zkIxX1CWvzORZI9PYvBtVnQwIwYCZmuJLsJrbh6k=;
 b=ajFusMSEbDrJYzkBMiOYiWsfdWX8aHF5oUzGvU5TYVHcdWhIFzrClL2eZoi0w1oxwWTg
 CcDutyPcowVrJafa5UoKDtzof6Rfs8ABS9Vujdh9wQoOBxVk4u6WhoEeA47TmZ+PRdBTm
 QQj8AeO8VMlv3u/Vo+9VtMbBW4lAIOSSWvf2bH7gU6+WCZUfmvdiQji53TdQY7ytjtp0L
 srHLoqep4wsyT/t/byikVRCOLQaW4CSjmcthmIf0WhFlT3l6qeDPNIX/h/GovZZZn+mrl
 Hh3w3pX4WrkffJRVE750S/gOQNN/CNYrDqXkWOKka0xHvgV1Dk/V5vZETF4uMsK+bzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LyOED31l; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=patryk.holda@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LyOED31l
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D751A405A4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791813323; x=1823349323;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gsCfzGDyqRLFXA2bYuwlx0GWQfX8Ju5Qtp7Huxhbxqs=;
 b=LyOED31lVtJhz7up1ugIbmGy/T0MNKUzRX2p2BQWXjgqKvqhnbwQB677
 qWx3J/HtWPH68E4or6e29mqxlm8MEUX5GtLmmIvCeMWa8MdGpwO8Vt4eq
 rVedwFykg5ZbwOD9M+S2bWUZ4vmP1zeRSXPzzZI/kDDYupW2H/EvwgRF1
 4jO2sclPWgGh6TnIIa1xY2kjEgx3kTD5TPlqayWYwVDUR9xWiFAzj45tr
 IS/6UWnc6J5Xq1EUr+IEnzf/tVDWNm2bvleEmMpdObTEASQ9SSB61MFfg
 +3eWitx73QXgn8l7XzXE2EoG2dbzNhqtDSzPP2vZmRcLf7vL6ACMXLAao Q==;
X-CSE-ConnectionGUID: DKNtyF6BQ3OB3K2WURbCHQ==
X-CSE-MsgGUID: Vju1+BzOR2WsQIqslXr3IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="397485"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="397485"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 06:55:21 -0700
X-CSE-ConnectionGUID: hD3Nsws9QoCJCHfeBGN6Sw==
X-CSE-MsgGUID: urCLmptdSC2odcXJ97S2Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1227632"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 06:55:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 06:55:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 06:55:20 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 06:55:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D71lRXG0GwDzOOeghAaHtVKb98nJlgsNw/SWh8M/LbS9VZ6+G6yllOSJ1eZrN6uUsE3mcPirb0W+tTLxqwQrq3MPRihhLUjUsofdRwbKkriMlkaCXS8vYODRGoX9mYWFCLqq+19vs+LphE60VN2yNbqC+sg40Lr7dJV5yTOl/BPWEcV5NTuAYDNsoKB+NJ9b2JLOaf5aaqCH3QLvPvdF7Aw8dBa06vQA+tjX0rpHQo+k2dbiCiGel+mFdSegwN4uRdp1YTQywPL+3f7+Kxp3D7fPL9/rwP825t706pv925+y7qcw8reL6IU2ml5t1VURsrTN1votIZuZGmQwCW2SPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb+zkIxX1CWvzORZI9PYvBtVnQwIwYCZmuJLsJrbh6k=;
 b=mc9h/uEdSizZptHATK6pAmJ8EmOuB0/95UTY2G4v4FHVoM9izup6DVPw9gRQv0ncmRS11DLVNGVkoyZ88Kb2aGJBA6VfsI/uDC59R/sN/5eC+xB8IRUOjO8Iip+Hg6W+kH1vm2FwNT91jOhFeux7exsqMzR+I6RtwSVnzHy3AR8Nb358CiwYlm5d/h/TSl2oJu7SJ74Ym6Q1f4TkVsVFCK+mfocuupA/0JBNfY653yxxaVh2LG3oO7XkdTcsrpJB6ZW2bcZZNpTv8ZLWd11r51StzZt7QV8vnbs7NZM/nlgZye20iPRCzwCtBuYA74Ov2xBt+yAQUKlg0zHBZRPfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 13:54:41 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 13:54:41 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Kushwaha,
 Priyalee" <priyalee.kushwaha@intel.com>, Kiran Patil <kiran.patil@intel.com>, 
 "Drewek, Wojciech" <wojciech.drewek@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, Simon Horman <horms@kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 2/2] ice: don't offload drop filters that
 bypass higher priority filters
Thread-Topic: [PATCH iwl-next v2 2/2] ice: don't offload drop filters that
 bypass higher priority filters
Thread-Index: AQHdRemW7uA2mDJfAU+90sesbDyyo7b6Fo7A
Date: Mon, 12 Oct 2026 13:54:41 +0000
Message-ID: <IA3PR11MB93012B036857018EC5938E218A9F2@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260916144130.2699902-1-poros@redhat.com>
 <20260916144130.2699902-3-poros@redhat.com>
In-Reply-To: <20260916144130.2699902-3-poros@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|MW3PR11MB4652:EE_
x-ms-office365-filtering-correlation-id: 1ac0f93d-f0c0-43ca-75f2-08df28685d1b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|10067099003|18002099003|3023799007|38070700021|261009223027099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: r+3AAsrrH4fEKxrhX5+93+KEAftGIw4uual0xnQHTXFWBGAJLbv6TNdky/XETpPewhwqp5J5n5TmR66W8PQEQ1UcZaWCQ62erNOmdsJ+ThTov57JnLz70MMLKcPOJZJwg+aT50NQmQGzaAjYac1lSoFwWIG1dfRinQjeoJxTHaFpGaSEOg7+vGNrHgut/Sl+yIHQc10orR+GcwF8+nUl2inqBuULkRGhLGNwIkij+3LodYcK6bLDFg9RB0gAwX8HQ+L6cqCmyZ0pn9hUn61ppZV/x8iSNVuLG89GFpaPajl87gGVUJ7NlLqyfABGv3h8NIukE6Ib38D3kg3aErfZVt2f4ug8j2DVINSV5+oLp/gJiy4wk6EaMLXKE8RsdL19MXFpp+8RiwkJzEctDm64FlWvEMUu2KbmW+AuyI8wwSyya5330yaybE9cK9YQJRmgFjAKiIaAQjxx+w5Wrv+D3o9YjgkEK9+fkBS8SUC5VmE06CBprxEMRJrgCe1Ub1WU9mcYyPRljduvDVBoZ5JYkL2ixvrLG3gkpI08ryusfzjJt46mE5w8enKSSILlE9GZuh88UV0d8KZeynU+0ErDi6HoX5rh2Te52fBpGsW1tirPAS0egzp6kw/zEnaiGbZu2XFQ+ZYn/SKN+9Fs4QWG+Bh4p6ynleNcwAYzuiAl9wpwFK9t1x1jX0s4Yga3x98dvEqlLZDltZy8K5bh3jN6tdoQjzkOskgdPRl1nIi+b2w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9301.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(10067099003)(18002099003)(3023799007)(38070700021)(261009223027099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ENh8YB0SiuDKoPHTIVVftWRTmnES3Yv5OsMug0EXV5HmX0gBZwZ7eMUQwG?=
 =?iso-8859-1?Q?c8vLw9LQC9FDBFD2KkqG3ndfXI9SZvsE8GHiJ4Vpe/w2qFh06wr9Rpfov1?=
 =?iso-8859-1?Q?Otct5GntluxmQIGF7MT1tQXUz2iOK5Haiai86xEK8sdEalCVcw9GQ08b+J?=
 =?iso-8859-1?Q?jo4qvS3Jlp+7kKz+PMtlXeo22Dt9OBerR8OAKq5WW07p4Oi+rT6YA5EEw3?=
 =?iso-8859-1?Q?wXg7i5WxF76qJPuqKnVpLEsze/IDtXH2b1SslkuJ6jbCJBpsz8SVsTEfa/?=
 =?iso-8859-1?Q?sfHq8O7bMpwyKv5nsEjMA1jx20rKavmD5SEUjjXUuaUPTZIkDGjkBSHKOo?=
 =?iso-8859-1?Q?okho25fM/kmENyH9yZGgjyXyj+r8UTgkpgcxV5lv6iCxbelo8+MXbm+5Ph?=
 =?iso-8859-1?Q?8rL0omfhPzyFJB2ju9GaF1pZJKE8U28P/fwf0NFP3C9qEioazIUExOuuGk?=
 =?iso-8859-1?Q?NzAMYiFWMJ1iaRleDj/mjJH+SZDHei2qM1LAS1PQEFHE5XgorY/ecMZfxC?=
 =?iso-8859-1?Q?bWB+eBeYYkXxc1u35ui903+mdHdcT4Xa7IPGdrq+QAtLQtJley+08tLy/J?=
 =?iso-8859-1?Q?9oBXVxIZagFl6oumPLkDK1WigGh0F9KgRIxho5GhAn4Y+lmG918ASLWLkS?=
 =?iso-8859-1?Q?X+cK/ADLBpAblqfRNoSXfWxuJFoeiGTjYIp1WQp2dq2UtWhMIEtqqM3Pl9?=
 =?iso-8859-1?Q?IAJ7JiQrnuzP10fQogNqGNQ8yG2zMXi2ZELlgTCodK7e29SZ1oOTdpYbos?=
 =?iso-8859-1?Q?nEc1Ro3/YVAJLT3+QTfNhWT6lvnYtNW+4OobLmpzzLtvkTf/VdzX9UdJ/U?=
 =?iso-8859-1?Q?EdFyAiGPsnW0wdq9R6aZineV2DPwQvSR8gzJaNbCGDb6y5ixBcu4eIxzDN?=
 =?iso-8859-1?Q?bunnLenDFH6AfIs3DNAAotYGo7Sc4Kgh37RyqZFxEPYDYvoN9mGRm/9Vl7?=
 =?iso-8859-1?Q?JvEU/9Y0HbEQs+5w5d61MZwWC1VDtF/MgUc/c0O1CqJHOlfNDqVrBO59I2?=
 =?iso-8859-1?Q?qOmpuBXQzBsn1uHxZDSVvAABf7TY6LVAX7fz7J6UI18VHCDr1f484f/dAY?=
 =?iso-8859-1?Q?KHNxfJ5DEDcrI/kYObidXjAqQflweS5FSyyzwzNGZ0QMmG9pyUwiSfzVVR?=
 =?iso-8859-1?Q?cMFSR8WGP89w2+LzTE2z1KjCE9QQe6IJDvKVNmdXf9E6larjWKU5Fdb3oi?=
 =?iso-8859-1?Q?Gkfj45oW9yZgU8afmqi7OveSe3r6cKnqsu23Wy2AMzUvFTHANDAvsItz4N?=
 =?iso-8859-1?Q?WR87MKdhFLhYb/rUZVG396pA4/sJf7WwKW8BgZUSPgVJdYyadc2Z0aO/Tb?=
 =?iso-8859-1?Q?VTCcwMMpAe3u51jioEFWC+sqVSiPtmW+Ols96W+Ve0s2T8y0NhMJi5F3Jv?=
 =?iso-8859-1?Q?vn9/+fYlrIVHr5nvL7SPBOuW3orfiwUwNQ5YfvtP2866oKsNdQOhuKz0EZ?=
 =?iso-8859-1?Q?EorbFGNylsAniQt1Xz1tOYvRqx6d4nY53bJJbOlnlueDm8epPdEfsavzlZ?=
 =?iso-8859-1?Q?7jtFgVnE+DFiSAjp/7Uj4SuhUSblsi111dS0yv7fHk8PbdiSwNadd+xo7S?=
 =?iso-8859-1?Q?as5x9ikpSlk5j/Rm/4ScOoOPHYKyZ5dkqSxSu7celVGsMtug9cIEkzERe5?=
 =?iso-8859-1?Q?Pqcliy8NlV70EVynj0Cd8+K1b+VA7+T/d6rzbNTmEgO7abvrRAc5n6AA5D?=
 =?iso-8859-1?Q?oBXPn4zdB57wnNE0TRb3Bciyov1ig1nNUD591KGLDo+iKsrYNBo9IhyC/r?=
 =?iso-8859-1?Q?TcYig41rmjAr2lfHYQVwds9+ax2hrMYEDVwmu3cUAr0TR8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OJYdgdRwFGLc8XflPiuPC8x5fjrNSib+5mExQGnVCy1Yx0aQRmjdieOAYTppp9smiQuiKCH8M3nWG8ws99VXVzVEUCqRsFIIcaTXYrlsscDf3/PNGfxhFtrnVuPcpUmWJDJVZvqgZWzXZ0I228ckFiHOxMx+mqPpvNovgq7Fr71/zKD0QrlxN8DgDTzW7vSBh3wVMAKqQBeAFUQB5Xnc98XcBvUZI15BM+tsyUu3xj7ewnVBfooeVe7bBCZZPRTBGw/mhdyadLi2Sx/Htnr8R+cqECA+vCPt8WFSFpTEZOPk+gswzW1wtGG7BBzvFL1hz8qHTpGmKz8pjWC9G9NYAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac0f93d-f0c0-43ca-75f2-08df28685d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 13:54:41.3653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+1kmA61bJmjQO2MrgnEQatgl88nvhzxcARstALJWSmwE7FD1x/W4XHWrhSY9L5/AdTQqDTfc4fqvqMXpr4VgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
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
> From: Petr Oros <poros@redhat.com>
> Sent: Wednesday, September 16, 2026 4:42 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Kushwaha, Priyalee <priyalee.kushwaha@intel.com>;
> Kiran Patil <kiran.patil@intel.com>; Drewek, Wojciech
> <wojciech.drewek@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Simon Horman <horms@kernel.org>; intel-
> wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [PATCH iwl-next v2 2/2] ice: don't offload drop filters that byp=
ass
> higher priority filters
>=20
> The E810 switch gives drop rules absolute precedence over forwarding rule=
s
> regardless of recipe priority (verified on E810 in every combination of
> installation order and match specificity). TC however requires filters to=
 be
> evaluated in priority order, so when a higher priority filter stays softw=
are-only
> because its match or action cannot be offloaded while a lower priority dr=
op
> filter is offloaded, the hardware drops packets the higher priority filte=
r should
> have seen:
>=20
>   tc filter add dev $pf ingress prio 1 protocol ip flower \
>       ip_proto l2tp action pass
>   tc filter add dev $pf ingress prio 2 protocol ip flower action drop
>=20
> The pass filter is rejected (unsupported action), the drop filter is offl=
oaded and
> the hardware drops all IPv4 traffic including the L2TP packets the prio 1=
 filter
> should accept.
>=20
> Track filters that were presented to the driver but not offloaded and ref=
use to
> offload a drop filter when a higher priority filter on the same device bl=
ock and
> direction is software-only or is offloaded with a forwarding action, whic=
h the
> hardware drop would equally override. The refused drop filter keeps worki=
ng
> in software. Filters are compared only within one device block since TC
> priorities are not ordered across blocks, and a shared block bound to mul=
tiple
> devices is tracked once per binding. Filters with skip_sw bypass the chec=
k
> because the user explicitly requested hardware-only operation and refusin=
g
> would fail the filter add entirely, and the tracking applies to the legac=
y switch
> mode only, switchdev pipelines manage rule priorities themselves.
>=20
> The check does not analyze match overlap, so it is conservative, and it r=
uns
> only at drop offload time. A conflicting filter installed after a drop fi=
lter was
> already offloaded cannot un-offload it, and filters the driver never saw =
(added
> while hw-tc-offload was off) are invisible to it. Installing filters in p=
riority order
> with offload enabled avoids both.
>=20
> Fixes: 0d08a441fb1a ("ice: ndo_setup_tc implementation for PF")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v2:
> - track one entry per cookie and filter_dev pair instead of one per
>   cookie, so a shared block bound to multiple devices of one PF is
>   protected on every binding and each DESTROY invocation removes its
>   own entry instead of returning -EINVAL for the later bindings
>   (sashiko review via Simon Horman)
> - pass the filter device to ice_del_cls_flower() for the lookup above
>=20
> v1: https://lore.kernel.org/all/20260910154824.3603687-3-
> poros@redhat.com/
>  drivers/net/ethernet/intel/ice/ice.h        |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c   |   2 +-
>  drivers/net/ethernet/intel/ice/ice_repr.c   |   2 +-
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 159 +++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_tc_lib.h |  23 ++-
>  5 files changed, 177 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index db3c7015c56c43..6c596e5a315175 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -643,6 +643,7 @@ struct ice_pf {
>  	 */
>  	u16 num_dmac_chnl_fltrs;
>  	struct hlist_head tc_flower_fltr_list;
> +	struct hlist_head tc_sw_fltr_list;
>=20
>  	u64 supported_rxdids;
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 3b76eb58666c07..3e6976cbb45c22 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -8392,7 +8392,7 @@ ice_setup_tc_cls_flower(struct ice_netdev_priv
> *np,
>  	case FLOW_CLS_REPLACE:
>  		return ice_add_cls_flower(filter_dev, vsi, cls_flower, ingress);
>  	case FLOW_CLS_DESTROY:
> -		return ice_del_cls_flower(vsi, cls_flower);
> +		return ice_del_cls_flower(filter_dev, vsi, cls_flower);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c
> b/drivers/net/ethernet/intel/ice/ice_repr.c
> index 096566c697f444..312a1bda460035 100644
> --- a/drivers/net/ethernet/intel/ice/ice_repr.c
> +++ b/drivers/net/ethernet/intel/ice/ice_repr.c
> @@ -223,7 +223,7 @@ ice_repr_setup_tc_cls_flower(struct ice_repr *repr,
>  		return ice_add_cls_flower(repr->netdev, repr->src_vsi, flower,
>  					  true);
>  	case FLOW_CLS_DESTROY:
> -		return ice_del_cls_flower(repr->src_vsi, flower);
> +		return ice_del_cls_flower(repr->netdev, repr->src_vsi, flower);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index fbd8cbad150a98..fec6970a74cfbf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -2269,6 +2269,117 @@ ice_find_tc_flower_fltr(struct ice_pf *pf,
> unsigned long cookie)
>  	return NULL;
>  }
>=20
> +/**
> + * ice_tc_fltr_is_drop - check if a filter carries a drop action
> + * @cls_flower: offload request describing the filter
> + *
> + * Return: true if any action of the filter is a drop, false otherwise.
> + */
> +static bool ice_tc_fltr_is_drop(struct flow_cls_offload *cls_flower) {
> +	struct flow_rule *rule =3D flow_cls_offload_flow_rule(cls_flower);
> +	struct flow_action_entry *act;
> +	int i;
> +
> +	if (cls_flower->classid)
> +		return false;
> +
> +	flow_action_for_each(i, act, &rule->action)
> +		if (act->id =3D=3D FLOW_ACTION_DROP)
> +			return true;
> +
> +	return false;
> +}
> +
> +/**
> + * ice_tc_untrack_sw_fltr - forget a tracked software-only filter
> + * @pf: pointer to PF structure
> + * @filter_dev: device the filter was requested on
> + * @cookie: unique filter identifier from the offload request
> + *
> + * Return: true if the filter was tracked, false otherwise.
> + */
> +static bool ice_tc_untrack_sw_fltr(struct ice_pf *pf,
> +				   struct net_device *filter_dev,
> +				   unsigned long cookie)
> +{
> +	struct ice_tc_sw_fltr *sw_fltr;
> +
> +	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node) {
> +		if (sw_fltr->cookie !=3D cookie ||
> +		    sw_fltr->filter_dev !=3D filter_dev)
> +			continue;
> +
> +		hlist_del(&sw_fltr->node);
> +		kfree(sw_fltr);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * ice_tc_track_sw_fltr - remember a filter that was not offloaded
> + * @pf: pointer to PF structure
> + * @filter_dev: device the filter was requested on
> + * @cls_flower: offload request describing the filter
> + * @direction: block direction the filter was requested for  */ static
> +void ice_tc_track_sw_fltr(struct ice_pf *pf,
> +				 struct net_device *filter_dev,
> +				 struct flow_cls_offload *cls_flower,
> +				 enum ice_eswitch_fltr_direction direction) {
> +	struct ice_tc_sw_fltr *sw_fltr;
> +
> +	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
> +		if (sw_fltr->cookie =3D=3D cls_flower->cookie &&
> +		    sw_fltr->filter_dev =3D=3D filter_dev)
> +			return;
> +
> +	sw_fltr =3D kzalloc_obj(*sw_fltr);
> +	if (!sw_fltr)
> +		return;
> +
> +	sw_fltr->cookie =3D cls_flower->cookie;
> +	sw_fltr->filter_dev =3D filter_dev;
> +	sw_fltr->prio =3D cls_flower->common.prio;
> +	sw_fltr->direction =3D direction;
> +	sw_fltr->is_drop =3D ice_tc_fltr_is_drop(cls_flower);
> +	hlist_add_head(&sw_fltr->node, &pf->tc_sw_fltr_list); }
> +
> +/**
> + * ice_tc_drop_bypasses_fltr - check if a drop rule would bypass a
> +filter
> + * @pf: pointer to PF structure
> + * @filter_dev: device the drop filter is requested on
> + * @prio: TC priority of the drop filter
> + * @direction: block direction of the drop filter
> + *
> + * Return: true if such a filter exists, false otherwise.
> + */
> +static bool
> +ice_tc_drop_bypasses_fltr(struct ice_pf *pf, struct net_device *filter_d=
ev,
> +			  u32 prio, enum ice_eswitch_fltr_direction direction) {
> +	struct ice_tc_flower_fltr *fltr;
> +	struct ice_tc_sw_fltr *sw_fltr;
> +
> +	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
> +		if (sw_fltr->filter_dev =3D=3D filter_dev &&
> +		    sw_fltr->direction =3D=3D direction && sw_fltr->prio < prio &&
> +		    !sw_fltr->is_drop)
> +			return true;
> +
> +	hlist_for_each_entry(fltr, &pf->tc_flower_fltr_list, tc_flower_node)
> +		if (fltr->filter_dev =3D=3D filter_dev &&
> +		    fltr->direction =3D=3D direction && fltr->prio < prio &&
> +		    fltr->action.fltr_act !=3D ICE_DROP_PACKET)
> +			return true;
> +
> +	return false;
> +}
> +
>  /**
>   * ice_add_cls_flower - add TC flower filters
>   * @netdev: Pointer to filter device
> @@ -2284,14 +2395,24 @@ int ice_add_cls_flower(struct net_device
> *netdev, struct ice_vsi *vsi,  {
>  	struct netlink_ext_ack *extack =3D cls_flower->common.extack;
>  	struct net_device *vsi_netdev =3D vsi->netdev;
> +	enum ice_eswitch_fltr_direction direction;
>  	struct ice_tc_flower_fltr *fltr;
>  	struct ice_pf *pf =3D vsi->back;
> +	bool track_sw_fltrs;
>  	int err;
>=20
> -	if (ice_is_reset_in_progress(pf->state))
> -		return -EBUSY;
> -	if (test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags))
> -		return -EINVAL;
> +	direction =3D ingress ? ICE_ESWITCH_FLTR_INGRESS :
> +			      ICE_ESWITCH_FLTR_EGRESS;
> +	track_sw_fltrs =3D !ice_is_eswitch_mode_switchdev(pf);
> +
> +	if (ice_is_reset_in_progress(pf->state)) {
> +		err =3D -EBUSY;
> +		goto track_sw;
> +	}
> +	if (test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags)) {
> +		err =3D -EINVAL;
> +		goto track_sw;
> +	}
>=20
>  	if (ice_is_port_repr_netdev(netdev))
>  		vsi_netdev =3D netdev;
> @@ -2304,7 +2425,8 @@ int ice_add_cls_flower(struct net_device *netdev,
> struct ice_vsi *vsi,
>  		 */
>  		if (netdev =3D=3D vsi_netdev)
>  			NL_SET_ERR_MSG_MOD(extack, "can't apply TC
> flower filters, turn ON hw-tc-offload and try again");
> -		return -EINVAL;
> +		err =3D -EINVAL;
> +		goto track_sw;
>  	}
>=20
>  	/* avoid duplicate entries, if exists - return error */ @@ -2314,28
> +2436,51 @@ int ice_add_cls_flower(struct net_device *netdev, struct ice_=
vsi
> *vsi,
>  		return -EEXIST;
>  	}
>=20
> +	if (track_sw_fltrs && !cls_flower->common.skip_sw &&
> +	    ice_tc_fltr_is_drop(cls_flower) &&
> +	    ice_tc_drop_bypasses_fltr(pf, netdev, cls_flower->common.prio,
> +				      direction)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Drop filter not offloaded because it would
> bypass a higher priority filter");
> +		err =3D -EOPNOTSUPP;
> +		goto track_sw;
> +	}
> +
>  	/* prep and add TC-flower filter in HW */
>  	err =3D ice_add_tc_fltr(netdev, vsi, cls_flower, &fltr, ingress);
>  	if (err)
> -		return err;
> +		goto track_sw;
> +
> +	fltr->filter_dev =3D netdev;
> +	fltr->prio =3D cls_flower->common.prio;
>=20
>  	/* add filter into an ordered list */
>  	hlist_add_head(&fltr->tc_flower_node, &pf->tc_flower_fltr_list);
>  	return 0;
> +
> +track_sw:
> +	if (track_sw_fltrs && !cls_flower->common.skip_sw)
> +		ice_tc_track_sw_fltr(pf, netdev, cls_flower, direction);
> +	return err;
>  }
>=20
>  /**
>   * ice_del_cls_flower - delete TC flower filters
> + * @netdev: Pointer to filter device
>   * @vsi: Pointer to VSI
>   * @cls_flower: Pointer to struct flow_cls_offload
>   */
>  int
> -ice_del_cls_flower(struct ice_vsi *vsi, struct flow_cls_offload *cls_flo=
wer)
> +ice_del_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
> +		   struct flow_cls_offload *cls_flower)
>  {
>  	struct ice_tc_flower_fltr *fltr;
>  	struct ice_pf *pf =3D vsi->back;
>  	int err;
>=20
> +	if (ice_tc_untrack_sw_fltr(pf, netdev, cls_flower->cookie))
> +		return 0;
> +
>  	/* find filter */
>  	fltr =3D ice_find_tc_flower_fltr(pf, cls_flower->cookie);
>  	if (!fltr) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> index 752af65e70b7bf..47444b7dadd257 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> @@ -139,12 +139,33 @@ enum ice_eswitch_fltr_direction {
>  	ICE_ESWITCH_FLTR_EGRESS,
>  };
>=20
> +/**
> + * struct ice_tc_sw_fltr - filter presented to the driver but not
> +offloaded
> + * @node: node in the pf->tc_sw_fltr_list
> + * @cookie: unique filter identifier from the offload request
> + * @filter_dev: device the filter was requested on
> + * @prio: TC priority, lower value is evaluated first
> + * @direction: block direction the filter was requested for
> + * @is_drop: the filter carries a drop action  */ struct ice_tc_sw_fltr
> +{
> +	struct hlist_node node;
> +	unsigned long cookie;
> +	struct net_device *filter_dev;
> +	u32 prio;
> +	enum ice_eswitch_fltr_direction direction;
> +	bool is_drop;
> +};
> +
>  struct ice_tc_flower_fltr {
>  	struct hlist_node tc_flower_node;
>=20
>  	/* cookie becomes filter_rule_id if rule is added successfully */
>  	unsigned long cookie;
>=20
> +	struct net_device *filter_dev;
> +	u32 prio;
> +
>  	/* add_adv_rule returns information like recipe ID, rule_id. Store
>  	 * those values since they are needed to remove advanced rule
>  	 */
> @@ -214,7 +235,7 @@ static inline int ice_chnl_dmac_fltr_cnt(struct ice_p=
f
> *pf)  struct ice_vsi *ice_locate_vsi_using_queue(struct ice_vsi *vsi, int=
 queue);
> int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
>  		       struct flow_cls_offload *cls_flower, bool ingress); -int
> ice_del_cls_flower(struct ice_vsi *vsi,
> +int ice_del_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
>  		       struct flow_cls_offload *cls_flower);  void
> ice_replay_tc_fltrs(struct ice_pf *pf);  bool ice_is_tunnel_supported(str=
uct
> net_device *dev);
> --
> 2.55.0

Tested-by: Patryk Holda <patryk.holda@intel.com>=A0


