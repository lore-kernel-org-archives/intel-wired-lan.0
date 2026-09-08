Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD3AC79F99
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 18:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A347C806E8;
	Tue,  8 Sep 2026 18:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zm-e3axauB1k; Tue,  8 Sep 2026 18:07:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3887880CF1
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788890866;
	b=ssiP9Fc/xoSyY+QLWppyPQEmjhRDR4SiVldVslESlfoL9cVA/KJr2hkXaD3M5WpCcWW3
	 9MYxGZuixHlufm3UDMnduhkn2rEGv9PWzhVbzf0AfwUblHl3Z8ox/lHv3Uq/nSj5OWk0j
	 YlcNKDf08Sr6NULgkRAE3dBAZCC+Qx9Fgzb8DmjfjC7MupLYxbcaHZDdkjRaY1kZaVsfL
	 suAgyaD+1OCcj6A73Bhd2XW7kpS8diR6xT8lN9bXDhhI/eFowq2+r56LAriPB/2V5HRzZ
	 Nu2yH2nLA+msws+G6+7aoOw0+T9ZFNjgSb69vAYyH++0U9MlaUl0fOwS5/i4OEdIGjg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788890866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=6A42Lotg13erzoi2c2Ih5BMoty1TGvpRjgib63hRBS0=;
	b=i+cQzXqqmm8SJV/MUvHwkIcZ8FH+Zgcz4Mpdqxka309+bxi5AX59jnR5YYmljweNEI8o
	 R9ewFp0/kydm52VicjeMNGTft6ubmKWD+1/GdC9vOeXvws1MrfxZB972pqD7zPW7sQDiu
	 qfkCWO6eQIwD1S9UGftDyH4mDirI0e45UK1DNsiXnEeoex64bC+i8Ktux+6Vo8ZykpfxI
	 gxr+q2YtEZ0r1YEDTCqQFzbZ/L1noRghsx4YoykV/LLyhHD/Zg4BqO23LeM9RTHRZJCNm
	 6pg4Vlb4pPnIpTw4u7UsZUjlkuqFgQ1ELQopktmAmp1smcQrlHJVXQY4KQy7E8LV60A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788890866;
	bh=6A42Lotg13erzoi2c2Ih5BMoty1TGvpRjgib63hRBS0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4kdjL7AldLiQEMEMR461kinxo+UGHoZCOP+b4fQDKIb2kJ2+AV+0A28Lv6GvBRaGT
	 lfN5R81lnfOHbPzPEg4q3dx/jpnccM95ZLMy7pD3yO1PIc/DwaoZc2CCg9saIrUsW5
	 koX/HmziwYsmgnn4tlLEqwQVWb+tCwbdk/tw4t3dZpBkfff6EN1JTkCfjmPfHejZ5a
	 FY8Nn9dV2XbrvtO6el72u9fK0tw2JzJDPnvusJgHRewNu1gIKK/U7vifO6zHxqI+Qr
	 IaSqoUfHqzd9A/ELP7udEMW19cfy8HjQ+YIPYXdG3bvBdNwqHiDkyUl6vFggmntCXO
	 iwZPf7K7XSN2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3887880CF1;
	Tue,  8 Sep 2026 18:07:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 27622769
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D46E40176
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:07:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qAQh4ZpfQuN1 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 18:07:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 260B94009A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788890863;
 b=BPIk9nvxUBKsk3qrSVveBJfIoQLIuN36TpsYHeYgH2RKA7z3DFpkM1tjJLytC4xgGv85
 Azf+mIWJNuNQ5IDrt8blDNmcaRjOWx7DmtjlT24+v1xgrYRlCpPf9+/6E/qP+HNjBUKIk
 DYAeHWZVgCeO9j+HFIFbYeK/OeZN+MbVzXE8R6SIsaWYcEVwXtBX4KsyuEizTPZSJ3RvB
 IDtBnCZtvHmx3z1AKzIcsnCh8bnjP6NrtXfaW4dapNv3LQkZIRyyPZbrUpuUpoXClSZXR
 d6r9NqjlFHkaHhTTS3/MoORCLdfPkJkEqRTpTk1HVseGem5gJ4+KrnmNHc3BQCoqx0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788890863;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=6A42Lotg13erzoi2c2Ih5BMoty1TGvpRjgib63hRBS0=;
 b=QsA/TpE4xi3h414NwcSLc7K2GiuCo1SJPbpC3FEVvWJc+eQUxTNA23Ccm+3AjmKKWiA6
 Nza6fcm84ZHFx88awK5KeLEcEtcaok3Hv+mKkt6Z1r9ux2l/dK/BWi4BcioWYYabYCeiv
 0TQZ8y6rpCyQsvXQz6C5eA1r94TT1zAyTeWwIVG3x1ZTIFENDdRYSmh8nQEdzND3pkzer
 sSfKixdd/iUECuI0mXM+yhHrSIvpl1TNNTA2ita/aHBkb8Cn5s3D/gZorsrNu61Z+OGUM
 DGcORzXehgZPkaVmRSG6sbTua0+IqB6VlQkd5JTggnsU52vYgbK842eGTmX5CARqhAw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CaPKrvGp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CaPKrvGp
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 260B94009A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788890863; x=1820426863;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6A42Lotg13erzoi2c2Ih5BMoty1TGvpRjgib63hRBS0=;
 b=CaPKrvGplAgOZYO4tfuHd1QfqfZt3y9tUNKPNbAbQq9JYE+/uNlJc+Wb
 zy+V2eRG1ylF+AIsR5vKxKesIO5UylKrWWSw3kPW9A5cHv8tP/naM52+3
 m2V9e5EOjexsMHJDTHVUzydUST+32fgNB1UxiehiVYY++72i25lmwHTgC
 Lt1eUliGGgzEXk6QXiKiVdklX+QQwf/bDktnm/hpA+X5rP4LyyrEkXu13
 MYwwcTt9lGVlZxrllxcCBA/hCbMI6FGqkqatYpQiP52cus7n33dqZJ2j6
 QyVyJvYO4fCmzQcDWqGvUFu0kHvMBVyeOyMsG57NPJOFV5gixi64CPviR w==;
X-CSE-ConnectionGUID: F0nS2UHWT0SFOYvMrpq6jg==
X-CSE-MsgGUID: gTZNGc5LQ362LBq4w0XfYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99966342"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="99966342"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 11:07:42 -0700
X-CSE-ConnectionGUID: EpE8QgwvR4OWsEKdjKpaGQ==
X-CSE-MsgGUID: QG2eyGr5QQ2QE5nieHqZsA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 11:07:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:07:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 11:07:41 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:07:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUZ21oqAi/MgJjjq8yzhfR/dfDN9t4CUCgdbRpCt/12OdHvR1qQvASI/3W+mWI7YK5aqM96YMTRcA5nd9ot2SnN4du/lsiNJE1iKCP6IcKigo0ZJA5iVQY4RQH9iUYSv1HO9Qjcffoh35Q5mxTe5pJgnqbDU66YWMeg9xdwP0fM1PT/pQJxutIQu0euRXArhWXayBuGs2I28kFEP7qPt3keH1sstkAk5kQFrhDMuuE5Pht/h8brJgPws1/8itrObF5duaG4r2j9G8nCTk2oWNubGb/hDjySOVLGDyPG6JW4KqsvuuPqAxXx/T2vS+XQhLuxSAGRssK8lQAsAKyBUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A42Lotg13erzoi2c2Ih5BMoty1TGvpRjgib63hRBS0=;
 b=xDNbIDbZjbbwrAaJfUhd1YqKfcI824KMGxuWspF/y1y9yd+uEw+N6Hl1hukqcaZt9/BBdFNHig/Al+2u7KkV6I/iFgjnHP9rLHxbt2jo0X1nfxOtglLu3yTckU0/2N7RrhuW84MimYxAyyWMw8QB3p8tXer/hisLwQSz+9iKJiNPBFyweBERe8wfV/WuBp7MKvVOKxaFs2dgSWqDQMUIVkW2ehSVZM2KHfdW5YIwNlQp8MY/5J9Y9rVUWQXJh13Zzip5RdICm/6HvTd6eWb2B0bq1IXIceNI3bc4kWC3ha2t+17qRBibv14TiBntJMdIF9gUCIRY9C5Gsmr30eQCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW5PR11MB5763.namprd11.prod.outlook.com (2603:10b6:303:19a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 18:07:36 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 18:07:36 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
 "Cavatur, Ranjit" <ranjit.cavatur@intel.com>
Subject: RE: [PATCH iwl-net v2 14/14] ice: don't clear in_use until HW clears
 ready bitmap
Thread-Topic: [PATCH iwl-net v2 14/14] ice: don't clear in_use until HW clears
 ready bitmap
Thread-Index: AQHdNOTVE2IQcgoXPUWpEvm7Al3fzLbFD8tg
Date: Tue, 8 Sep 2026 18:07:36 +0000
Message-ID: <LV1PR11MB8790A639AD86BC7784C49A6190B12@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
 <20260825-jk-e825c-minimized-fixes-v2-14-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-14-8223f95d26e3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW5PR11MB5763:EE_
x-ms-office365-filtering-correlation-id: 66f47d28-ca61-420a-a341-08df0dd4103c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|38070700021|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: a/n5mf2MQUF6lVARhA2KpUclStC/45DU4rp5p76+WaHHlLZHd7uBURwYFhMmKH4t6wpQa6fytWrirvysrpjKr9GUlZctJ7K7ir0y1I7U8ESBLT5SOBYil0qk5rSWyFy+1ZhjHQQRf4v4W/NPxMA7VmvSxSkGf0d1+UNYnHUvQT/rvwZ/DWkDeyZd/CSLzfNG5+jkeftyE0WXmogOu3Gu3l06d7xQJF0Qm4MSW4LB/TFuWAlVaWb/cM/hPbk6CPxaLIAgTnCJp4idLPsNw7F8csVgAu9B60dpfnVLQf6ldpbgjgPfRFBQD6WezAyFYFaaLw6fn8wpQf2WnY4y7bH47Y+YhKGx9ibABrancZxihs2OrcE/0fF4dFNHj6DXn8/VOo2AzHq5+sDN5NfnI3KBRjHLpLttFXrhREY8eFzAbPUIw/aMSn3q5fqrBbTeur33fIs9Sca9Jvsc53NaZ050EuvedrRt07P/fw7CLchaJjcG9HcTmR/MeqsARYHlDWLds/BPRsGf5aI7PzCHlBmhL5MvNTZsda6FYVCljb0KfG6y982I69uDoHjaeYf0OSuy1mnb7MqbSn2CvR6LDTCT0hMiY63csNEqliREnaHdYdCw/CcF8wQe4fPAcqBDzZGLH1I53/nSnjWH1DHf3KWNx5XPujnXi/UCJCxChP5NqjJMoWEksi0zPaLAJFg5kphRb8yWErh+ynHk74FPaTURiykSffm6yEhIgMfjk3+Yg98=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(38070700021)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2ZwZHVOOGVLVzBZYmRWRWtpRTRKTzJUVWxCK2lLTDc4aTNiejB1RjlYWlNP?=
 =?utf-8?B?QTdRMkc3blhjZ3VKNkxqcnhGa3pQLzd0Y2FIeS9kN1EyVUR5UkM0LzJvTjdm?=
 =?utf-8?B?SmIrM2c3RWdGSjBpbU9BUFRwamtVbXlOaFBZM3NwMVoxZFFCalZGeENLdlBD?=
 =?utf-8?B?RUt3K3VqbXc5cnRYRG5JVkpRbmRMRVAwVER6TVlDTFJTdVNyWTR5MFlGcnI0?=
 =?utf-8?B?UG5wSjB1Qk9TaGttZkpGR0J3d0xnbkQxSnArdXB1eFd5emxpQ09DejNOMlNk?=
 =?utf-8?B?bndjMms4SFlIK2FZME1ycDhFN3dCWWRTZmw2Q0hyVmtXY0ZXaG43SENjQzlu?=
 =?utf-8?B?eTFlWEFzZW5XY1FkRVFVL05SYW9hYURBVk0xRTlkdkxmTmJiYnVaRi94YWJF?=
 =?utf-8?B?bFJqdGhBV0VJdTRkaENwM2E0Y0ZrWGtOQWlkMHBZYXluQnlTamphTUw2dEN6?=
 =?utf-8?B?ODB4dWUzc1lMTS9GL1NQYXh2MzUrbzlucGhxV1k0dDlhWEFzbnc4dGRDaFhE?=
 =?utf-8?B?MXFSK0VzbTdVZ20yNDFKUU5TUFZxQ01NcklTbHJYOXhOWDlHRUs4TitwdklG?=
 =?utf-8?B?QXVKbGxIS25KNjhEMUZHVVRUMllpc1pqcHJadHJZbExaK0Z3dEM1V2RGRG0x?=
 =?utf-8?B?emdtKzVXZnpPOHZ0eDNXaXpHTDlqNnlwaWFRVEUwZWxjWi9UeVpEN212TlFH?=
 =?utf-8?B?M0cvbHBLK040TGthcmppMnhBeHkzRXk4ZXBaR05oallhU0s5QmVURlQxN0lF?=
 =?utf-8?B?UEFMMWFtcnNjRHMwdnlGaDRlZ3ZjVk5SSThCUE1lQ3FZS0tvZjFUMWpOdnpD?=
 =?utf-8?B?dFhaa0RWTGtJZ1BSRXA4RzhwemhkNDVjMFB4Q3lPS3M2bnJMU01UWCs2NWsy?=
 =?utf-8?B?OHRpc2Y2TE1adi9ueGhtcmFCb1NVMHRzRUpLUnptUE13anBOSnRuUjQ0VGVq?=
 =?utf-8?B?R1ViTVYxVXBialU0S3Y3NWR5ZlpyZ2tHU1ZCZ09OZDRQbEdPVVFQaTB2cmgw?=
 =?utf-8?B?WnA3M0gyR1hGTHdtWnAwcHdQS3lhajVNb1BFQkVNTThhdVcrK1VMU0tHMmU0?=
 =?utf-8?B?cDNKRFUrRHY4cDduTFFOb094aFN5czJNWTdDd3RzaVZzQ1JKc2ZyMDJMMytT?=
 =?utf-8?B?WWwxY1U3c25MSk5aZnQzSThaUm5EYi9Ec3NLUnZTZHdDL21RMFM4TTZ3d1k0?=
 =?utf-8?B?NFg3QkloS0JrUGpQZHRpOVZnWmNnZEFZMzM5dDNpU1RKSGIwK05MdUxhTDhO?=
 =?utf-8?B?aVFqNXRSR2k4K0VMOHZTdGszWWlTc1RPbzB6UTBmS3M5blNmYmp5MGQ5UGFk?=
 =?utf-8?B?U1dlQTQvNWtEcW5SdjVaSkNDbXNUeTBZNXVPZTFjL2hkak1FZVIvbEd3Qjgx?=
 =?utf-8?B?bW1MNW1RRVBVYjFFZG9BOXFLTlI1QVdIMEwzSXVzL2pGcXppTGpWeS8zVnhl?=
 =?utf-8?B?Rjhud1NCMmJvSnAvT3EwRTJ0WDd2Z0w1WG5MWlE5SElqQzNEeGJwWWxuaTRF?=
 =?utf-8?B?d2N5WHFMZmNuUDM0QVp4WDZOcGprV1VGWXBiQ2loMG10eG02OWFNYjRMQllL?=
 =?utf-8?B?NUh4NTVpRTJLSzFMR2YrdWlwdWRscXhHYmFaZEloSGFnNHJVQmpJWjYvRjVW?=
 =?utf-8?B?cDQwRUhUME1STHFlSUgwNGxjK3pVaW5rMTdmQTNDcnNLVmJhcThMNEVwRElv?=
 =?utf-8?B?eWY3VFNxTjFudmh6ZC82d1hZM294OVNtd0VWV2dqTkk0cS9GMlU5cml5cGRk?=
 =?utf-8?B?UGZJbUU5bStBS2hKczB5WE4xcVNnVURpQUJ5WTNWdmxxbEtlMWxmS1lrWGpl?=
 =?utf-8?B?VnMwVEdCSVVuN0ZzV2hlL2I4UGpVVUlDZlBUTGJZczYrQ2FRbHhCNG5RaHpH?=
 =?utf-8?B?bytDc1VWeHkrZVJ4bUpqMysyOGZhTW02QVUxczZ3aytocFEzQ1lsQnlLMGc2?=
 =?utf-8?B?U2pLOFdoNG1LYVJJYms3WE1IZkNRbVFWS1l3QjNvS0Z4SmJQRVNsVVlNMFlN?=
 =?utf-8?B?ZDc0RGRCK3RyOVVmTGVCYkhjSVZhRnIrT2ZDcmhHRWNac0w3T05SVVFydjNa?=
 =?utf-8?B?Z1dZWHR6dm1iUWJVYkcwSGoyVXE0emJBT2tzWk91emRGMWllWEhoWTYxN1lq?=
 =?utf-8?B?a01VMC9VMVJKNHRzYmpmeGF4a0ZlZ1l5QlR5U2MwczEvOEk2VW0yaXVsTVoz?=
 =?utf-8?B?a2RESWZTQlM5czJUcy9WZWNaRHBVcVdlQkc3cDFsZnpjSGxTV2dMRXdtL0h4?=
 =?utf-8?B?VjlzRGd4N3BWUE1sMzM1SHZCT1I3aVEzMFNJeXNnR2ptenBhL0ZCanJzMGFp?=
 =?utf-8?B?eDdKd0N0OURMVlJiRlpSRi9LZ1BUV2N2WW85NEFpTXpQY1JRSG9zZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nWcoDbWZNL2D/RqmsCIq5/fOltFNo4or5pOY3gs705cWGneSQ2s9SZ8vK1W5eGbAv8iS6gj7L5dmXHom0p3U/W6YJVZ2ijJLVyMNuJNjzTj8gSvpM173V2tz1ENrTW/ANT3+T0lFao7yjSpgMjb0AMtRBMrgfoGUCveoR9tilsN0wVupcaAcXPVSliJooUQmodtp7wYE8Yuzwn7uPUeZMUvA5uVHCaMeoUbhs2Tji2RR85lNKfDH7JXnBN9gqfLS7Eiv2yBE53sNfJmEMqep8tena78gmNH+ch0FCWny9A+WP/GHey9TfqtpatoRvQwfP9a0bnR84p832aSKRwWpJQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f47d28-ca61-420a-a341-08df0dd4103c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 18:07:36.5878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGiNsQ7eu2ZIn7/d14vXfzj0rcwNOvntx4ayEsZhCZSN/isrLE1xpsnZEyc1+FD4N68s9LWw2hGD7yMS6wWtmwI0/MeUVCpXlN6QdYuzth0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5763
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWxsZXIsIEphY29iIEUgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNSwgMjAy
NiAzOjU0IFBNDQo+IFRvOiBJbnRlbCBXaXJlZCBMQU4gPGludGVsLXdpcmVkLWxhbkBsaXN0cy5v
c3Vvc2wub3JnPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTWFjaG5pa293c2tpLCBN
YWNpZWogPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPjsgTmd1eWVuLCBBbnRob255IEwg
PGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS29yYmEsIFByemVteXNsYXcgPHByemVteXNs
YXcua29yYmFAaW50ZWwuY29tPjsgTml0a2EsIEdyemVnb3J6IDxncnplZ29yei5uaXRrYUBpbnRl
bC5jb20+OyBPcm9zLCBQZXRyIDxwb3Jvc0ByZWRoYXQuY29tPjsgTm93bGluLCBBbGV4YW5kZXIg
PGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPjsgQnJvc3MsIEtldmluIDxrZXZpbi5icm9zc0Bp
bnRlbC5jb20+OyBDYXZhdHVyLCBSYW5qaXQgPHJhbmppdC5jYXZhdHVyQGludGVsLmNvbT47IEtl
bGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFU
Q0ggaXdsLW5ldCB2MiAxNC8xNF0gaWNlOiBkb24ndCBjbGVhciBpbl91c2UgdW50aWwgSFcgY2xl
YXJzIHJlYWR5IGJpdG1hcA0KPiANCj4gRHVyaW5nIGEgbGluayBkb3duIHRyYW5zaXRpb24sIHRo
ZSBFODI1IFBIWSBoYXMgYSBzbWFsbCB3aW5kb3cgd2hlcmUgaXQgZG9lcyBub3QgcHJvcGVybHkg
cmVzcG9uZCB0byByZWFkaW5nIHRoZSBQSFkgdGltZXN0YW1wIHJlZ2lzdGVycy4gV2hlbiB0aGlz
IG9jY3VycywgdGhlIFBIWSBkb2VzIG5vdCBhdXRvbWF0aWNhbGx5IGNsZWFyIHRoZSByZWFkeSBi
aXRtYXAgb3IgdGhlIHZhbGlkIGJpdCBmb3IgdGhlIHRpbWVzdGFtcC4gVGhpcyBiZWdpbnMgaGFw
cGVuaW5nIHNsaWdodGx5IGJlZm9yZSBhIGxpbmsgdHJhbnNpdGlvbiBldmVuIGJlZm9yZSB0aGUg
ZmlybXdhcmUgaGFzIG5vdGlmaWVkIHRoZSBkcml2ZXIgb2YgdGhlIHN0YXRlIGNoYW5nZS4NCj4g
DQo+IFRoZSBkcml2ZXIgaGFwcGlseSBjb21wbGV0ZXMgdGhlIHRpbWVzdGFtcCwgcmVsZWFzaW5n
IHRoZSBpbl91c2UgYml0LiBUaGlzIGFsbG93cyBhbm90aGVyIHJlcXVlc3QgdG8gcmV1c2UgdGhl
IGJpdCBwb3RlbnRpYWxseSByZXBvcnRpbmcgYW4gaW52YWxpZCBzdGFsZSB0aW1lc3RhbXAuIEFk
ZGl0aW9uYWxseSwgd2l0aCB0aGUgcmVhZHkgYml0IHN0aWxsIHNldCBoaWdoIHRoZSBkcml2ZXIg
Y29udGludWVzIHRvIHJlLXRyaWdnZXIgdGhlIElSUSBhbmQgY2hlY2sgZm9yIHRpbWVzdGFtcHMg
aW4gYSB0aWdodCBsb29wLCB3YXN0aW5nIENQVSBjeWNsZXMuDQo+IA0KPiBUbyBmaXggdGhpcywg
cmUtcmVhZCB0aGUgUEhZIHRpbWVzdGFtcCBtZW1vcnkgc3RhdHVzIGFmdGVyIGVhY2ggcmVhZCBv
ZiBhIFBIWSBpbmRleC4gRG91YmxlIGNoZWNrIGlmIHRoZSBoYXJkd2FyZSBjbGVhcmVkIHRoZSBp
bmRleCBwcm9wZXJseS4gSWYgaXQgaGFzbid0LCBtYXJrIHRoZSB0aW1lc3RhbXAgaW5kZXggYXMg
c3RhbGUgYW5kIHNraXAgcHJvY2Vzc2luZyA+IGl0Lg0KPiANCj4gU3RhbGUgdGltZXN0YW1wcyBh
cmUgYWxyZWFkeSBpZ25vcmVkIGJ5IHRoZSBpY2VfYW55X3BvcnRfaGFzX3RpbWVzdGFtcHMoKSBm
dW5jdGlvbi4gSG93ZXZlciwgdGhlIGljZV9wdHBfdHhfdHN0YW1wc19wZW5kaW5nKCkgZnVuY3Rp
b24gYWxzbyBjaGVja3MgdGhlIHJlYWR5IGJpdG1hcC4gSW5zdGVhZCwgbW9kaWZ5IGl0IHRvIG9u
bHkgY2hlY2sgdGhlIHNvZnR3YXJlIHRyYWNrZXIuDQo+IEFkZGl0aW9uYWxseSwgc3RvcCByZS10
cmlnZ2VyaW5nIHRoZSBpbnRlcnJ1cHQgZnJvbSB0aGUgSVJRIGlmIHRoZSB0aW1lc3RhbXAgdHJh
Y2tlciBpcyBjYWxpYnJhdGluZyBvciBoYXMgdGhlIGxpbmsgbWFya2VkIGFzIGRvd24uIENvbnRp
bnVlIHRvIGNoZWNrIHRoZSBoYXJkd2FyZSByZWFkeSBiaXRtYXAgZnJvbSB0aGUgd2F0Y2hkb2cg
dG8gY2F0Y2ggY2FzZXMgPiBvZiB1bmV4cGVjdGVkIHRpbWVzdGFtcHMuDQo+IA0KPiBXaXRoIHRo
ZXNlIGNoYW5nZXMsIHRoZSB0aW1lc3RhbXAgcHJvY2Vzc2luZyBubyBsb25nZXIgdHJpZ2dlcnMg
YSByZXBlYXRlZCBzcGFtbWluZyBvZiB0aGUgSVJRIGR1cmluZyBsaW5rIGRvd24gZXZlbnRzIHdo
ZXJlIHRpbWVzdGFtcHMgZ2V0IHN0dWNrIGFzIHRoZSBQSFkgdHJhbnNpdGlvbnMgdG8gbGluayBk
b3duLiBPbmNlIGxpbmsgaXMgcmVzdG9yZWQsID4gdGhlIFBIWSB3aWxsIGJlIHJlc2V0IGFuZCB0
aGUgc3R1Y2sgdGltZXN0YW1wcyBhcmUgY2xlYXJlZC4NCj4gDQo+IE1lYXN1cmluZyBDUFUgdXRp
bGl6YXRpb24gb2YgdGhlIG1pc2NlbGxhbmVvdXMgSVJRIHRocmVhZCBmdW5jdGlvbiBkdXJpbmcg
dGltZXN0YW1wIHN0b3JtcyBuZWFyIGEgbGluayByZXNldCBzaG93cyB0aGF0IHRoaXMgcHJldmVu
dHMgdGhlIHNwaWtlcyBjYXVzZWQgYnkgdGhlICJzdHVjayIgcmVhZHkgYml0LiBXaXRob3V0IHRo
aXMgZml4LCB0aGUgQ1BVIGhhbmRsaW5nIHRoZSBJUlEgYmVjb21lcyBzbGFtbWVkIGR1ZSB0byB0
aGUgSVJRIHJlLXRyaWdnZXJpbmcgbG9naWMuDQo+IA0KPiBNZWFzdXJpbmcgbGF0ZW5jeSB1c2lu
ZyB0aGUgaWNlIFR4IHRpbWVzdGFtcCB0cmFjZXMgZG9lcyBzaG93IHRoYXQgdGhpcyBmaXggY29t
ZXMgYXQgYSBsYXRlbmN5IGNvc3QuIExhdGVuY3kgaXMgbWVhc3VyZWQgdXNpbmcgdGhlIGljZSBU
eCB0aW1lc3RhbXAgdHJhY2VzIGZvciB0aGUgcmVxdWVzdCB0byBjb21wbGV0aW9uIHRpbWUuIEkg
bWVhc3VyZWQgYSBjb3VwbGUgb2YgZGlmZmVyZW50IHdvcmtsb2FkcyBib3RoIGJlZm9yZSBhbmQg
YWZ0ZXIgdGhpcyBmaXg6DQo+IA0KPiAgKiBwdHA0bCB1c2luZyBhIHByb2ZpbGUgd2l0aCB+MTYg
U1lOQyBtZXNzYWdlcyBwZXIgc2Vjb25kDQo+IA0KPiAgICAgYmVmb3JlOiAxNTkuNDAgbWljcm9z
ZWNvbmRzIG1lYW4sIHN0ZGV2IDQ1LjI4DQo+ICAgICAgYWZ0ZXI6IDE4Mi4wNyBtaWNyb3NlY29u
ZHMgbWVhbiwgIHN0ZGV2IDQzLjQzDQo+IA0KPiAgKiBhIEMgcHJvZ3JhbSBnZW5lcmF0aW5nIDE2
IHRpbWVzdGFtcCByZXF1ZXN0cyBldmVyeSAxMCBtaWxsaXNlY29uZHMgb24NCj4gICAgdHdvIGRp
ZmZlcmVudCBwb3J0czoNCj4gDQo+ICAgICBiZWZvcmU6IDYwNC4zNSBtaWNyb3NlY29uZHMgbWVh
biwgc3RkZXYgMzQ1LjMyDQo+ICAgICAgYWZ0ZXI6IDk5MC4xMyBtaWNyb3NlY29uZHMgbWVhbiwg
c3RkZXYgNjI1LjY0DQo+IA0KPiBJbiB0aGUgbm9ybWFsIHdvcmsgZmxvd3MgdGhpcyBjb21lcyB3
aXRoIGFib3V0IGEgMjAgbWljcm9zZWNvbmQgcGVuYWx0eSBvbiB0aGUgYXZlcmFnZSwgYW5kIHRo
ZSBzdGFuZGFyZCBkZXZpYXRpb24gcmVtYWlucyBhcHByb3hpbWF0ZWx5IHRoZSBzYW1lLiBGb3Ig
aGVhdnkgd29ya2xvYWRzIHdpdGggbWFueSBtb3JlIHRpbWVzdGFtcHMgdGhhbiBleHBlY3RlZCBm
b3IgdHlwaWNhbCBhcHBsaWNhdGlvbnMgdGhpcyBjb21lcyBhdCBhIHNpZ25pZmljYW50IGNvc3Qu
IFRoaXMgaXMgYmVjYXVzZSB3ZSBoYW5kbGUgYWxsIHRpbWVzdGFtcHMgaW4gYSBzaW5nbGUgdGhy
ZWFkLiBJZiB0aGVyZSBhcmUgbWFueSBjb25jdXJyZW50IHRpbWVzdGFtcHMgYmVpbmcgcmVxdWVz
dGVkIGF0IG9uY2UsIGFueSB3aGljaCB1c2UgdGhlIGxhdGVyIHNsb3RzIG9uIHBvcnRzIGxhdGVy
IGluIHRoZSBwb3J0IGxpc3Qgd2lsbCB0YWtlIG11Y2ggbG9uZ2VyIHRvIGJlIHByb2Nlc3NlZCBv
bmNlIHRoZSBpbnRlcnJ1cHQgaXMgZmlyZWQuIFNpbmNlIGVhY2ggdGltZXN0YW1wIG5vdyByZXF1
aXJlcyBhbiBhZGRpdGlvbmFsIFBIWSByZWdpc3RlciBhY2Nlc3MsIHRoaXMgY29zdCBpcyBtdWNo
IGhpZ2hlciBpbiB0aGUgY2FzZSB3aGVyZSB0aGUgZGV2aWNlIGlzIHVuZGVyIHVudXN1YWxseSBo
ZWF2eSBsb2FkLg0KPiANCj4gSG93ZXZlciwgKmNvcnJlY3RuZXNzKiBpcyBtb3JlIGltcG9ydGFu
dCB0aGFuIHNwZWVkIGhlcmUuIEFkZGl0aW9uYWxseSwgd2Ugc3RpbGwgcmVtYWluIHdlbGwgYmVs
b3cgdGhlIGRlZmF1bHQgbGltaXQgb2YgMTAgbWlsbGlzZWNvbmRzIHRoYXQgcHRwNGwgd2lsbCB3
YWl0IGJlZm9yZSBjb21wbGFpbmluZyBhYm91dCBtaXNzaW5nIHRpbWVzdGFtcHMuDQo+IA0KPiBG
aXhlczogN2NhYjQ0ZjFjMzVmICgiaWNlOiBJbnRyb2R1Y2UgRVRINTZHIFBIWSBtb2RlbCBmb3Ig
RTgyNUMgcHJvZHVjdHMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUu
a2VsbGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX3B0cC5jIHwgNTkgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkNCg0KVGVzdGVk
LWJ5OiBBbGV4YW5kZXIgTm93bGluIDxhbGV4YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
