Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398D3CA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DEB880AB2;
	Tue,  6 Oct 2026 01:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id btTBv2S6ZwTJ; Tue,  6 Oct 2026 01:50:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3D41180ADA
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791251442;
	b=EZhYRHchesXgQoz9qimWOXqAVn32Ncm2eXF5Ov3HE7LZ5ld4oB64yZlxAiFlgCVAJ5VX
	 JqLR0YT6csWJTlIAWEFLjW4gi6d4QBeqwBOakn2bEdCIWhoVFRSFwoJ4VbQ4IUwvY+ELy
	 VuyyLqHSmY6nCAUiH1MlTM3a+SKI02ReGXwuypfjuuJXMFgnYWzzYlxGTObU6N49FC5pf
	 chJ9iIirmhq5KxlDRblL1PlC3iA5mqkSWw0vbhDrJyWFitwOttRes+Y9sLDlBAWB9K9IR
	 NLqFT3Rh3ArbSLiUPYXjAJeMM+pfpbolXUJV9jWj/efryVfQ1RIIv9vWgyOKjJjiNKw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791251442;
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
	bh=rFpMQ7tTMNac2F1cgh1HGVgxVwUddcU/FUqAb7Jbq+c=;
	b=cYnSn+LCdACIAwziiCyESvzqV5ml1hKUjhmX4vxCgwrcE8tHXXdtxzf0vH+Vb+od4jtM
	 WEkdsFAKO5ENQehzNbswXDpK6sUhkNvB6R0wSJ7HXJPrQt9nsjHoFGmPKocgGFWOGSlpM
	 pKxSCQ6/V3/FOBzgAvJjP7/ZQpfS4Yk78shkh6CJjDJrtY5OAN5GNTt/GPGRY6UH3fOsH
	 s0NVadNFmr36TOt+ZZn+5x/mRPaBhCUiFFBK7u5FRDOJc6aYoXFdwIN3WiMKqQpkQx18s
	 5T6dDh5o6peCm8uq9GP4yocMVSG9mCSBsckEoRNOU0yopMrgK2ulDYXTHlUcPh3pXjw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="cZS/bTwg";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791251442;
	bh=rFpMQ7tTMNac2F1cgh1HGVgxVwUddcU/FUqAb7Jbq+c=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2IAH6xDeVORoamjP44M8UbrOiIH1paaH107QI6GV3hiGl5/QOtcjr2gbrfxK3Aj5T
	 W0wumCv3u/vTQJ7dlray47fqE0yf+upbWwXUgmEC7pfUBZLVsOfbSBBa1FLyJxfvek
	 YfimlYL2Y+gJbrGeezjM6HWtp2GOGm/qgvpRnvEDifqQSLhZ2VJuHhgcE+2WqGZyGi
	 ajLuQdaveRTPy4Lrk1lvCQ1TvS3NIQZSqlw8e1R0HMNZ2ov5IRrWGwDIZwjfKvgKVE
	 8MFZy0a0n22ji/7cEM21dDkJx60vXKDQg5axvd0t149W1nuKPq2u5r1Jc+joWfbJx3
	 pewp6KofWAfmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D41180ADA;
	Tue,  6 Oct 2026 01:50:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 692D234E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A8C680ADA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:46:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lB29BqR2bj7b for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:46:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 834A380A95
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791251211;
 b=PCfv5k/B0GuhbVgkN6WBeeoMbyEU9Yir8eiuJyHDXbVgPadnZpCue/2+gzA90xeSUf5w
 OzeAgBpcNv8Lh3vycTsk1RDXPXIw91Wb0/ld5gjP9iNY4WMZM2CmET7k07tIrHM1jCIkh
 tSEe3yYf7isR0sQlL/7Eaw7dfh1z/pOqpo05zU3RrY6dmrGi9lLUEkF4TG9RUe+esooqi
 srpvFWYmMgdQ9EgI4cLnqW7mlrKTHcSG2R2337ezLHEOB4rnxp34YfXS4SGEsjDaQlXs9
 NxsvvlEP4Ur7l9/l0+i0sepASquALZhhj4PoZFZHrnkz6shKFz8xL0SWqpQSBi2RiNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791251211;
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
 bh=rFpMQ7tTMNac2F1cgh1HGVgxVwUddcU/FUqAb7Jbq+c=;
 b=aaYyEEZ6It6Q6h7EMEHn+1NpSi3UDNdEH3E3zSnj1WkIcMrDw2gw00tVTk0LL+YILIN1
 AaYtQcc1DbLuOGQSNF/ShkowwDxdzjn1apdkfnkcLD+XwMiWXDLrg3kXwxrQEr16PXgKA
 my07+Nk6E+zc5w/tJmy+PPO/ZcT8cS4avM/3by4uD71zxWo9PwOwedKX6Kdbm4gnsanxY
 PDuwgaEzQTWYl3HWRMMFwOODJ/UeGNHNRDqHudiYT+oa451cPcGlYPAg0CC05Of3umXAV
 KkCz/vVOt2TiVWsZyOTrYuMgVca1A4UgnQYPMA5KddM7oCz6M7X0+ew2/J/O0nkKKMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="cZS/bTwg"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cZS/bTwg
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 834A380A95
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791251211; x=1822787211;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rFpMQ7tTMNac2F1cgh1HGVgxVwUddcU/FUqAb7Jbq+c=;
 b=cZS/bTwgAQPEg1YjGByBpkkQtfonIp9Z6bPOzodYxyfEL8wo6pdsLRgA
 Bka1Jr/iIcShEAJvMfuuqKss1GkbPZkPq+NCSSUd60l8cO87OUrljOMkz
 EtwLwhC8R2KetceMJ3B4G5HCCNP6LXxVzmdu2xf5F+vXweBjjmSJF1jFV
 bJ1ojXFzMGrPkaLbFVdgZPQWVulb2qfw2i6PdQcf8NGM1ZTcFvGuGhBwG
 +angldSfNlZ06OVapxbteoQ18OTj9Pi/644XU3Q5j89ipt/hsQ9JiW2zj
 Uoik2NOZI9+rE0ihTsqk+mDaISDirQNkiCtXFEuAA0K3k3gchpSt9mt4U A==;
X-CSE-ConnectionGUID: GokG5OZiSHeCd8fuMi39Jg==
X-CSE-MsgGUID: Qro+Xu1qSU6chOJ8HD8xZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91957072"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="91957072"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:46:44 -0700
X-CSE-ConnectionGUID: EPyK0Hm/Qe2FHlGP/GdP8A==
X-CSE-MsgGUID: +T4N/EE5QxSZHaMWrKNjhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276499100"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:46:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:46:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:46:43 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:46:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBJfnamz00eLEL19h/PO1soHR2xju/N6KqOh+PpjBqE+ycSCMZ4x8239Ei7Z6wiapR7RaWzAE1g3HQZqQ01C+mQHCaNNsMKir/E0V8WOWLO+ah8lV+ipkS4LDR/lIz3ElS9SA7I17ofd3VfAE4Bz3+Fyda7pKXynD0IITXR8L1azrgdUpQi4SN94b8c7ox9/zbD7DM+lVGZ2IGtdmv8jFqZeE5QDY12K5hHT/wtEkCOSZA4WxOYMFfK6EmZXFiT7TT42r90HuRwlTBmZgUKnlaumU7dKoRcIns5co066HJMOFTgJjRqoHP48jQ4/+ZZO3iDEQ04tk/Nq+ow9p5ezHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFpMQ7tTMNac2F1cgh1HGVgxVwUddcU/FUqAb7Jbq+c=;
 b=vOZLU3jMJ4SxFTiZUJpT295MSFwfiu7dnLXXFg9eVYAYioq4bP0y585nyZBwvTFAFZupA7gg/wClzbQ6NSC+7L25UlzzKuAYSsCy5WGc1eSXWot36yOrKVOyhsQFPaAsxHi7OhvMSafAR8lBcG+QxCX/hMjcAbW4EjPNpSm7leof/ofbUkGYFD2J4ZL8vBjqLK+hGWQlnm38q7i3dL/XbSgTcqD5JosI4S5ZYvUTu/qhxEutwunBHDFnw5WziUPcO70SfyqjjWCEujqqfb61T7GbeeHihFxyFl9u3D3F7UisRx9rSmgIOFbav6BILX6wE5+IlfthynTpHoLVcvp4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:46:41 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:46:39 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-net v3 15/15] ice: Recalibrate PHY after settime64 on
 E825-C
Thread-Topic: [PATCH iwl-net v3 15/15] ice: Recalibrate PHY after settime64 on
 E825-C
Thread-Index: AQHdTUnFdXd0cC0sAUWIDYoelw1DfLbvzjmg
Date: Tue, 6 Oct 2026 01:46:39 +0000
Message-ID: <LV1PR11MB8790DAC8FAB8EBB1CCEE7EE790952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-15-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-15-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH0PR11MB4824:EE_
x-ms-office365-filtering-correlation-id: 43f8d899-8653-4549-c873-08df234baa0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|921020|11063799006|56012099006|4143699003|260925021311599003|260925021911599003|260925022911599003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: iKcR4XEmlO7dietw5fbRL20PVQ4+B8iauTGe3agVFt/9yaSkhVv5ZTffq2yAvIL2ycHxUGZ6ph0XQmmaORbalRcDYimUUawzPNI3MGb5OOpPcESvNF6PHsZxcoEsbfx45PsX8J+lTyE2vqkh2h1bCybfpLChUzs+wIqVXAHYonCeDnrxv8n5iEvoSvN0otppS0wMIC6WfYtgcBhqZQMQH2D0UD3PE7KJa8WyIgEiYm6EnBp1S95PnJa6mhjE+iT2oymH8rx1Eqn0Q0nDA3NFuBfAgXZx3a2c5WfH1gKNuRUakiyRPbDVUH9qbu0GoKhdCMJjj8JZ/fHW84Smtz8rfFKx8L4kaNAIYzg2vnt58BtBdPwme+7sjB9aVCuYJVY3e0q2mOhZXn1jQGNb7/XHQ+Tqul+rmpteTENFuFzL24DsNhc9GL/ooyYEVvxqa45U8ra7VEUwKXRT6wjvgV+BE1y2CCcE1pDy5tW4t0rgsYXWtovrEtTXv70NWy4XWwnxCYxkIMSE2FdA2Dc6sqxWGXdLYkX31l1RG7wivAN/pxVdUrTG7NuXrB3bOqOEPSbPcRB5PTuVjCxfMR3qStHQkZAh0a/JxJeFlcZRKb0yoVSN7TxfRj4TmdR249qOF3jh5fIUlmLSwAhRRKTPEhF1wQyypBhTqWMA7ctDPTx6cgwvAAJESAXtNQ//22ewGTdi77ynaAl8WO26ADJ9Hh4UbXwR/iK6HuexUxSDGxlIID0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(921020)(11063799006)(56012099006)(4143699003)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXJRU0VPbDdXTE0wN21KN3Zpc09wSFpIcjFKZ011cjdxYXNHaXBiVGEyOWRB?=
 =?utf-8?B?TmluZjNNSzVjQllnSVh2UEdEcU1sdUo0djlpTHN2NTh1YnpackxqMmxOQ29E?=
 =?utf-8?B?OW0yckc1bm11anJCTDY2ZitvbnFzQ0pZS2dGbWpYQjNSSG5tQlRjbUp6a0RV?=
 =?utf-8?B?ZmU1SktNT2tOMkhVeDRQb1gvNjl3V1NZL05BdktLTk95MjhTOHVmb3F6Si9k?=
 =?utf-8?B?czVzWEI5b2cvNThGN24wc2VGZ3JTZWdVTHRWdzJKNE1uQm1zaFd1Wm4yZ0tI?=
 =?utf-8?B?ckFVUjQ5a2lScmZicVN6Zjkrbi9ndUhlU3NrMmNtaW5LYmNHMHhMTm5acG8r?=
 =?utf-8?B?Z2h4dVpVeG93WmZXaFUrYmc1N0hmRkRWMWFjVisrMVovcEoyc1BJL0FJNzdP?=
 =?utf-8?B?aGxCMjl5dXlLYloxY1VJWDBNVmFxUlNUSVhoVDN6MXMzQklHOXI5ak53VHpF?=
 =?utf-8?B?eThwM0ZKc1l4L3JGN3VFOFpGLzJBZXVIeXBPK3VwR3JqbGY2bk1NTnpsb2pT?=
 =?utf-8?B?L2QzMmtRRkNCNHpYQmtScWxXYlhUdHFCWEpSc1AzaUhTQ3JaZFFWTDNhMURT?=
 =?utf-8?B?bDVCWUdpZndiS0pmUUxXcEhzMlVuM1BhR3dxMjZOTWprSHNsTndOZitZaHpD?=
 =?utf-8?B?RzFkTzRQRDNTdDhGdDErTDh3RkdwT1F0WVlSV2xjdmlPT1AwbSsxUXFWVXpn?=
 =?utf-8?B?aE5peGtiRVFHdXhLbHZIV1RZb3VxVUdtYTY1dG8wSFdFQ05HUnVhZ3BPZnBS?=
 =?utf-8?B?a2QwREt4bWt0eFFZb3BvVWN3YXkzbU8rMWx4ZXlINjI4M1dkWDFFV3RHelBI?=
 =?utf-8?B?YjQrNVNER1l5TTF1UGFXRGJBV3E3dDRZY1NaekZqWTZpamJUK3VmQzlKVGVI?=
 =?utf-8?B?b01iR0ZGWHVMSFJRdkt4Y0RlQ3lqaE1tbzN4eW9Zb1VIa0QzdE1LcFQ5a0VF?=
 =?utf-8?B?dGJKd0FVRmI0aXJaY05aNERwZjByYUdjbFlUcGIzQTJITUNxaTdpS2pPOHdZ?=
 =?utf-8?B?ZmQrdjEwbTdkS3lhbzNFeTNuZS96K1ZjZGJDdWpJaG5qemk2U281RGZ3Wmt5?=
 =?utf-8?B?cW1FOGRHSk14bWZqdDR1aUtXRlNSVzNtem5ib3FKakpBUWE5UUV0ZWdETHlv?=
 =?utf-8?B?a3FNVktTZlh1S1ZJdG5keE5aN0RaOERDeDhXMDd4VnZtRlZYVElaNjJZRTg0?=
 =?utf-8?B?U0NhalBxaEpsbFBMMzNIVEJjTVBaa25mWkQ0MmFnRjBXTVFxbEdnL2hIdC9v?=
 =?utf-8?B?UG1haGhLRUE2SE0rRmpHbmdNU2FndzdoZzRtazdoTmxRYVBqckhremFxSW9T?=
 =?utf-8?B?Z1ZYZEhpcTYrdXF3YkhJMUliYVhUb0dVcGNuWXNLZHl4UlpUUXJiUXp1WDNp?=
 =?utf-8?B?OUVkYnlXdlc1SnJOeXphdnY2dkhnOCttOWZndWxwbHlZNjF1dzdra3VhajhM?=
 =?utf-8?B?Y1oyNXlzU3NVVXNOMnlKK1BobkxPdFg2V3FaOVVoNElJVjhGdTZxbkoyNTRM?=
 =?utf-8?B?R2lad1U4NUpEQ3BZSU0xSThWNDdUWVY3bkJLTzhoNzNPTFdNU2JRSVNsOTBY?=
 =?utf-8?B?VDEwMzU0NDI0RlVXOEtSWVdRbTdkaUM4ZEpuaGxLTGJDYkZzbXBpQXdIY3RX?=
 =?utf-8?B?NHgzbE9hRCtOeVIxRmNIYmdhazI5WFczd3laeGhWZ2RReUVsYXdMOGcvS1RN?=
 =?utf-8?B?Y0JXM28yNTllakdRd2R5dmZqeWE5ZWZVYjBOV0MxN1pZc2V5ZkFhbmhkU1g0?=
 =?utf-8?B?eitvSnVPeEtFT3NRcmlKbnRtY3JmKzRTRmlUbXlEVUNCeFI4NXFWRG5SSW5k?=
 =?utf-8?B?TnhUdG5aZks5S3pFek9lbEIwRzJTQXRzZWViYm1lU3BsZkVGTFpSeWQ3czFK?=
 =?utf-8?B?cWoweURUaElvNy9EZnNRTEl0ZFlyMTFMUU9kdHBnbGZGRHVtSEF6MElBTmw0?=
 =?utf-8?B?ZzFTdC80MkZkYm5PUXYxMjlUemtXdlJ5b3Ixb0RWTHVaV2EvcGNOczljRWY4?=
 =?utf-8?B?d3lCdXJjdWpvZzRXNEFtR2NzYlJ4SklZSS80SlZoWWI5RkZHck9oY1dnSVBj?=
 =?utf-8?B?WVNYd3pzTk9WekdRMlVBbWJ6enFXc1U2dzNSS3lYSzdQNzkxRCtBMnRtNlhZ?=
 =?utf-8?B?VXhiNjBMV1cwbFI0WGZOMHBpOVQ0VmJHN3dKd0VZZWpNNTZlNHBBUTkvb3Vm?=
 =?utf-8?B?MDU5L1VFdzN4YkRqTUZrNDhuMDZoZjFZenA4SEk2WGRyV3ZKaEdIT29aSTFv?=
 =?utf-8?B?UUlnYmFYd0htRTFiMXNUTkEvK3ppZ1hWNGFGZ3hxR2NkanBBWjhRc0Y1K0Jt?=
 =?utf-8?B?RUlzeUxvS1V3cGY1eUlqaGRPYmNXajk0amRZcWpiN1N4Nk5WdHhTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cawUqSyXtwc567ZVwSnsX/J2CX9uS9FAdMh7rZHQbzyi5X6qaIIfEmW8ao+FtT4kR+uRYpehMj7GXK7kWTVtFGdmsjuajELock9wV4OZ2oBHhCFSNIY11KyDdGgQEcsRPMX3s/luPKllwnDtjUXN2UvnFPOE7rOhCPxsWCKteSvhKRjHaLE0ULSbj8kIm5PfaK8h4mqKc/ubPE6oLXIAl3qyKq8mMyk6STtmmd9YtVfZOwftBZY7HY99uCnkg74DK5JiAqwW9bCzMea0VbPkek9kmQwIfY5RrFURi3kYfNxm3YPpK2DCNhxbQihjRvzUyV+DfOUdbEIzmWJ0COj3MA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f8d899-8653-4549-c873-08df234baa0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:46:39.2278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWUyoakS7+cBlnWG7PffcuQcaADOuWP85/+wFXJepYvErmqCx84yAna1L3qvdxSXA+oYlVoJhNZhGK2kcRxGbgDpPeX6RZH+ebydSCowMXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
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
QGludGVsLmNvbT47IE1hY2huaWtvd3NraSwgTWFjaWVqIDxtYWNpZWoubWFjaG5pa293c2tpQGlu
dGVsLmNvbT47IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+OyBMb2t0aW9ub3Ys
IEFsZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCBpd2wtbmV0IHYzIDE1LzE1XSBpY2U6IFJlY2FsaWJyYXRlIFBIWSBhZnRlciBzZXR0aW1l
NjQgb24gRTgyNS1DDQo+IA0KPiBGcm9tOiBNYWNpZWsgTWFjaG5pa293c2tpIDxtYWNpZWoubWFj
aG5pa293c2tpQGludGVsLmNvbT4NCj4gDQo+IFRoZSBQSFkgb24gRTgyNS1DIHJlcXVpcmVzIHJl
Y2FsaWJyYXRpb24gYWZ0ZXIgbGFyZ2UganVtcHMgb2YgdGhlIHN5c3RlbSB0aW1lLiBUaGlzIHN0
ZXAgaXMgcmVxdWlyZWQgYW5kIGlzIGRvbmUgZm9yIEU4MjIgZGV2aWNlcyBwcmV2aW91c2x5LCBi
dXQgd2FzIGFjY2lkZW50YWxseSBza2lwcGVkIGR1ZSB0byBvdmVyc2lnaHQgd2hlbiBFODI1LUMg
c3VwcG9ydCB3YXMgYWRkZWQuDQo+IA0KPiBMYWNrIG9mIHJlY2FsaWJyYXRpb24gd2lsbCBmYWls
IHRvIGNvbnZlcmdlIHF1aWNrbHkgYXMgdGhlIGVmZmVjdGl2ZSBhZGp1c3RtZW50IHJlcXVlc3Rl
ZCBpcyBub3QgYXBwbGllZCBwcm9wZXJseSB0byB0aGUgUEhZIHRpbWVzdGFtcHMsIHNvIHRoZSBy
ZWFkaW5ncyBmcm9tIHRoZSB0aW1lc3RhbXAgYXJlIGluY29ycmVjdC4NCj4gDQo+IFdpdGhvdXQg
dGhlIGZpeDoNCj4gPiBwdHA0bFsxMjU5MS41MDVdOiBwb3J0IDEgKGVubzgzMDNucDApOiBTTEFW
RSB0byBVTkNBTElCUkFURUQgb24gDQo+ID4gU1lOQ0hST05JWkFUSU9OX0ZBVUxUDQo+ID4gcHRw
NGxbMTI1OTEuOTUxXTogcG9ydCAxIChlbm84MzAzbnAwKTogVU5DQUxJQlJBVEVEIHRvIFNMQVZF
IG9uIA0KPiA+IE1BU1RFUl9DTE9DS19TRUxFQ1RFRA0KPiA+IHB0cDRsWzEyNTkyLjAyN106IHJt
cyA3NTI4NTE5NzMgbWF4IDExMDIyNzc1NTkgZnJlcSAtODQ0MDg3OTggKy8tIDUzNTYwMTMzIGRl
bGF5ICA2MDA5ICsvLSA5MjMwOA0KPiA+IHB0cDRsWzEyNTkzLjAzOF06IHJtcyA5MTMwMjA0NSBt
YXggMTM2ODk0Nzg0IGZyZXEgKzEwMDAwMDAwMCArLy0gICAwIGRlbGF5IDkzNzAwICsvLSAyNDE1
Mw0KPiA+IHB0cDRsWzEyNTk0LjA1MF06IHJtcyAxNjAzNjMxNCBtYXggMzU3MTE1OTQgZnJlcSAr
NDc0MzMwNzAgKy8tIA0KPiA+IDQ2NzQ2MDcwIGRlbGF5IDQ0ODk5ICsvLSA0NTI1NQ0KPiA+IHB0
cDRsWzEyNTk1LjA2MV06IHJtcyA1NTU4ODgwIG1heCAxMjI5MjEwMyBmcmVxIC0xMzA5MjI4NSAr
Ly0gNjYyNzMxNyBkZWxheSAtMTM0OTkgKy8tIDY1NjANCj4gPiBwdHA0bFsxMjU5Ni4wNzNdOiBy
bXMgNzU5NTMzIG1heCAxMDgxNjM4IGZyZXEgKzgzNzA2MyArLy0gODAyNjkxIGRlbGF5ICAgNzEx
ICsvLSA5NzkNCj4gPiBwdHA0bFsxMjU5Ny4wODVdOiBybXMgNjA0ODUgbWF4IDEwNjgwMCBmcmVx
ICsxNDY3MDYgKy8tIDI2MzUzNSBkZWxheSAgIDE0NSArLy0gMjYzDQo+ID4gcHRwNGxbMTI1OTgu
MDk2XTogcm1zIDE2NDI4IG1heCA0MTg5NiBmcmVxIC00NjcwNyArLy0gMzQzMjUgZGVsYXkgICAt
NDAgKy8tICAzNA0KPiA+IHB0cDRsWzEyNTk5LjEwOF06IHJtcyAzMDQ5IG1heCA1MzU2IGZyZXEg
ICs1MzM3ICsvLSAxNzMwIGRlbGF5ICAgICA3ICsvLSAgIDINCj4gPiBwdHA0bFsxMjYwMC4xMjBd
OiBybXMgIDI4NCBtYXggIDM4MSBmcmVxICAgKzEwNCArLy0gNzU5IGRlbGF5ICAgICAyICsvLSAg
IDENCj4gPiBwdHA0bFsxMjYwMS4xMzFdOiBybXMgICA0MiBtYXggIDExOSBmcmVxICAgLTEyNCAr
Ly0gMTQzIGRlbGF5ICAgICAyICsvLSAgIDANCj4gPiBwdHA0bFsxMjYwMi4xNDRdOiBybXMgICAx
MSBtYXggICAyNSBmcmVxICAgICszOSArLy0gIDEyIGRlbGF5ICAgICAzICsvLSAgIDANCj4gPiBw
dHA0bFsxMjYwMy4xNTZdOiBybXMgICAgMiBtYXggICAgNCBmcmVxICAgICsxNCArLy0gICA1IGRl
bGF5ICAgICAzICsvLSAgIDANCj4gPiBwdHA0bFsxMjYwNC4xNjddOiBybXMgICAgMSBtYXggICAg
MyBmcmVxICAgICsxNSArLy0gICA1IGRlbGF5ICAgICAyICsvLSAgIDANCj4gPiBwdHA0bFsxMjYw
NS4xNzldOiBybXMgICAgMSBtYXggICAgNCBmcmVxICAgICsxNiArLy0gICA1IGRlbGF5ICAgICAy
ICsvLSAgIDENCj4gPiBwdHA0bFsxMjYwNi4xOTFdOiBybXMgICAgMSBtYXggICAgMyBmcmVxICAg
ICsxNSArLy0gICA1IGRlbGF5ICAgICAzICsvLSAgIDANCj4gDQo+IFdpdGggdGhlIGZpeDoNCj4g
PiBwdHA0bFsxMjgzNC4yNjZdOiBybXMgMjcxNzgyMzgzODgwOTggbWF4IDMwMDc5MzI4OTUyNzM3
IGZyZXEgKzQ3OTE2NCArLy0gMTA0MDg2OSBkZWxheSAgICAgNSArLy0gICAxDQo+ID4gcHRwNGxb
MTI4MzQuNTIyXTogcG9ydCAxIChlbm84NzAzbnAwKTogbWluaW11bSBkZWxheSByZXF1ZXN0IGlu
dGVydmFsIDJeLTgNCj4gPiBwdHA0bFsxMjgzNS4zMTVdOiBybXMgODY5MTkgbWF4IDEzOTc0NiBm
cmVxICsxMTEyODkgKy8tIDUzOTIxNCBkZWxheSAgIC0zNSArLy0gIDI4DQo+ID4gcHRwNGxbMTI4
MzYuMzc2XTogcm1zIDU0MTUgbWF4IDg4ODQgZnJlcSAgICs1NzkgKy8tIDIyNzk4IGRlbGF5ICAg
ICA0ICsvLSAgIDUNCj4gPiBwdHA0bFsxMjgzNy40MjldOiBybXMgIDMzNSBtYXggIDU1OSBmcmVx
ICAgLTMwNSArLy0gODQyIGRlbGF5ICAgICA0ICsvLSAgIDENCj4gPiBwdHA0bFsxMjgzOC40NzFd
OiBybXMgICAyMCBtYXggICA0NSBmcmVxICAgICs3OSArLy0gIDMzIGRlbGF5ICAgICA0ICsvLSAg
IDANCj4gPiBwdHA0bFsxMjgzOS41MTJdOiBybXMgICAgMiBtYXggICAgNSBmcmVxICAgICs0NCAr
Ly0gICA4IGRlbGF5ICAgICA0ICsvLSAgIDANCj4gPiBwdHA0bFsxMjg0MC41NDVdOiBybXMgICAg
MSBtYXggICAgNCBmcmVxICAgICs0NiArLy0gICA4IGRlbGF5ICAgICA0ICsvLSAgIDANCj4gPiBw
dHA0bFsxMjg0MS41ODZdOiBybXMgICAgMSBtYXggICAgMyBmcmVxICAgICs0NiArLy0gICA3IGRl
bGF5ICAgICA0ICsvLSAgIDANCj4gPiBwdHA0bFsxMjg0Mi42MzddOiBybXMgICAgMSBtYXggICAg
MyBmcmVxICAgICs0NiArLy0gICA3IGRlbGF5ICAgICA0ICsvLSAgIDANCj4gDQo+IEZpeGVzOiA3
Y2FiNDRmMWMzNWYgKCJpY2U6IEludHJvZHVjZSBFVEg1NkcgUEhZIG1vZGVsIGZvciBFODI1QyBw
cm9kdWN0cyIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hY2llayBNYWNobmlrb3dza2kgPG1hY2llai5t
YWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogUGF1bCBNZW56ZWwgPHBtZW56
ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFs
ZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxs
ZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5jIHwgNSArKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KVGVzdGVkLWJ5OiBBbGV4YW5kZXIgTm93
bGluIDxhbGV4YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
