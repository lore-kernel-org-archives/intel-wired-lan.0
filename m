Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DED8CA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD299402B3;
	Tue,  6 Oct 2026 01:42:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8-GAEtPxeaBG; Tue,  6 Oct 2026 01:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0459A402E6
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791250962;
	b=jrvZPRoKBY1+XOfpf0Uu63inyeeRP7kCyzQPMw5pAa3YG8ohtfCOFwz9JbpvUd8ZfPky
	 bKQw+0/evBLzDa4yWcXYYWtOW2+OipdgBW/EkjxsjRaLkq11MnCrPaDEzFLoweF8ZkREQ
	 AKb3OBgi/St2KpvkcCjKvsD/7HWczLIm3qCo8QyMdmDhu95luVMmBK5yKRaF3mmiREaq6
	 B7DZJ+n0NKydTQsT+Ox5m0EmkDftaT0pKFycVA3jA1BS4H6zGuzhMGosYsEuIHwjJdL12
	 WBw3h/jP5xLHQyX7qZudXh0tpA/QwdfDdhc3d7Jcug9JCpZUiG3t5+TIxfcClOmZjkQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791250962;
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
	bh=A4sx7MnI0xL//YsDgSomityn0TQBT7CD2POp17z5HEY=;
	b=UrrkX5+DaJFEopvEgCzhI1/6+Nul4OJCeKIf3qNXN1/G1eQqhjrrvYmMm1UwVxzD5uq7
	 XsSEZcb1cFzed7Typv/J74y+sfDgiMM01nehyylJ95N6rbDdZmcbGbxRJB2pm8pnuI8S0
	 Fh2bm7NDRB8TrmUGsgYSB0+BLCvLk8+kDz7Xa8lneEVrmePR9JMGI1W4VZFUUiZbqKTke
	 zb7DiX/7Buqx0I5TJR8gOIc7c+3Zs86h6RiRvpYGS3/pSNnfGShwcUw/U3TFV/wVreuUD
	 79Q/2Qq0i/U5tH2Q3Mard7OBEwcQWj9Bmzme7C3pRfYlBu1f1QNu55tW3T9sNEcKcsw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791250962;
	bh=A4sx7MnI0xL//YsDgSomityn0TQBT7CD2POp17z5HEY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P7gVzDJoDds9XKJKWbqvrUtJPUBLdtfGHyCC6DDFat7Z7/VQA97OoXjCKt1+XML8b
	 TpE7Aks1PMGWekvSEC4k4KNUeFUoCVoaW8n2jc0jzawxDAzCy7Iwu407EXthu6NdFw
	 HUqoEOhr3rDBp0oLcwPNcqxiRpTOsDpmwn0P3woKSHhfPKekeIiQOw9lGsKyjjvkw6
	 39AswgufZ7ldlEy5/k9VwT9xtLecfO+Kxnh73CW7sUBMSypIT1xA9A5kPunSCkraky
	 rUYVuPG5WQtoGs0oyKSGlMijhgbsNK7+vNwyZN0Mku9teQl8CkpI/4ta1FnQbalif+
	 jtVGNATy3RfWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0459A402E6;
	Tue,  6 Oct 2026 01:42:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BF9832F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DDA5400D0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:41:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kNhmKJ69AluH for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:41:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 42ABC4009D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791250882;
 b=BQ+xKUJBST2EuwUcxjd+AFbIw7YAncCMTF9cGpq6zYzWz+T7WgDWNmSgFM/0XRKdsu4X
 kKMbjVHds2N6YYZfD+Cj3CT4P1AlxM+n2vIUidCCQAceEEKkuhq83vEL0+SkYQjNV6eRr
 CdjHuzVU2iKZJtf1SCTgImPOhtKZhEZgi5WAsn3n+/2IXBXrZ9yVca8L8fGKdia261dqc
 BiUJiFYQJ3wTNW6JHnz33KWoiJJc/ydvEujF78dqNSvYGiLs3rYpJcq07vVUVMkqOBVQJ
 QXw32cVcGzShXCiY4KOqSNfuVMz9QRWKu4s9Apa1Yq22+awZFW3t+YdeuOb22aYwgfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791250882;
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
 bh=A4sx7MnI0xL//YsDgSomityn0TQBT7CD2POp17z5HEY=;
 b=HoZYbhn5BQkNU6I7aJvrD5c6rMmTP47i9lKlTzWLjSCe7enzdQbZHsMJNC8weULn/5vh
 d88+J4KVytiJVntR+V4XABC1GF7iZrHkCdoC0/cH4ctFbW7hP6eBg3ST3cyzeWuW9oWmB
 1I5tMzfNgpZtWJH2lI3XRAU8p8e6M9BgKNVKl90EKas8JzBhQusVxC5kLoTwXpWRyHex2
 XbhOEbS37iln+EsFw2eEOEMI6r+R9p05axsEuVYAvogViDFXNHtm9CT/z+Q+2Xg8UK7JG
 U3JqH+oM1fdupnT4y1SJzYF7NZQ4+ORG+PBK754Pz5w9Pwmz5XNTqOQrC6uBJDY3WBA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CSSTUNE3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CSSTUNE3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42ABC4009D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791250882; x=1822786882;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=A4sx7MnI0xL//YsDgSomityn0TQBT7CD2POp17z5HEY=;
 b=CSSTUNE3XLPp/5wlqyT66NlVQWuwgt6Rir6RpOqRM786eOrOw5wg58KL
 +F7HZNYYuF6p3/yaUHtNtkWHR4T9DFU9yN+rjbDK1g5lNrybpXd1enQQO
 AK0uRgz9zZEWfBhtrryODhcAw+kqcRKBducWWzu2cCQ58WJ9EDKGStftR
 jPliVCHisd8WIT8rvUShtXSBDQ3CBCIUWRaAckL40MBpMhc1CDDEpk0bc
 0p+ZNRhJ/xIRFqD0pYQxHvtsR58p9aSp52vknDPzM5mW5sNscGxd9VXj4
 H7vNpKyYK29IOZF30ctOs56otw7R9NuQi62Endxq+N7HYPpFwLSYYiY8a A==;
X-CSE-ConnectionGUID: iGgfON57SIqNvVorfkUMvw==
X-CSE-MsgGUID: tWBgzEG1Tp+kt0I4jhMiHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94641991"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="94641991"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:41:21 -0700
X-CSE-ConnectionGUID: Z7v+vATNTIiBpYC7VDKHmg==
X-CSE-MsgGUID: rnhhvFhKTT67yBqsBFmqzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276518169"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:41:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:41:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:41:20 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJslqT5VqzqA8QuHLcFuOkcrwvEH29NXkYaODLOB8gK+abp5ElMz2PzSe+ZUWFo+Ze6/RfSpxi+WV7oZbiqjgZcYohXKm5teFoRHE9b5D6ZBHJ+AZaTEa2YCbOgbRlZYo3GujKCAx8lMH5ZBjVicY97uwgTWrVujrlSm5KkCFR0GwdmksaLczagduGYZ9Dosld9WyXOEa/5Bn/8jx3aX1cdaIsIqOqBAuFs93cmuahxKw9WHfuAgL66HJnBfQ9LEeaQVaRnddrcyt41ZstTXUt6P2k59v2jukb8qDHq+QQTZRq6C6X0SMnnqsJU533faP81erqz4+LYB7TkOJKe8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4sx7MnI0xL//YsDgSomityn0TQBT7CD2POp17z5HEY=;
 b=W3AKkRcnF4XN5ZrCzA55pA6Q7EQPheHyJHYnp7LYi+dLPzuC2vYItNByH8hZO74Y/Wqd68TwwvrDhzfhcF87mpdkT0w1nQdz/kuVwPsKx7F4HPpF7+/1mxlZN455SxI1LxOOFwty5BKBxsSpDfswnrdXiSCx3xnbsy6e7hXhC+Yql4qXTQjYyC7/My1ERGZETkjJ9Vc+ciCwQV0sEhakNcCltiqRafRNDRpdxFYx6cA5YclMge1JjPVemLh0NzMblP2Rq9lsTyHavVXTrVS1tzyO+FG8/nc5v7SV6FrzCvFxew33rxh2dCDFomIDvM8cpuxUK18qV4vpK1/483cK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:41:17 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:41:17 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v3 08/15] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
Thread-Topic: [PATCH iwl-net v3 08/15] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
Thread-Index: AQHdTUnKgxwQ4q2WrE2QjIzDz4RGSbbvzLaA
Date: Tue, 6 Oct 2026 01:41:17 +0000
Message-ID: <LV1PR11MB8790A851B5FAB6EC7B2965F190952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-8-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-8-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW5PR11MB5907:EE_
x-ms-office365-filtering-correlation-id: db04eee1-1a60-4aae-fbbf-08df234aea2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|10067099003|921020|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: UOthQil6yb/ewjJNAkPthKL+oLtLm8zdcXvsVidJwtzutzqz5TTgpEn43wcNhxHdZfkd/IUMtdpkWxWYldvCvFaNT8wnmWn/m9I1MWqIGWRJZO6jrA2ZIeZBWx0sdYM1P3Tv8r3AZl+CjAsMGguy1b5vWVdIPNXEvWqcsv0ijxlC4vtrNlaoGfv0zJRXE2uuZgiOPdPg/s6TecZ0JZ0GpKKEcdDs52C23aMmJw2bNpnr5ckxhy4YMvupZgk9KdKa4KPptYXYfN+fmhR02g+IyYFwUkH2vV9+f44j1+gp4QHS4O6OkDVK1pWrb8o/c64Jt34DDCETtikViNDlcT7en32BlFxE+Df2cCg4zD+kqJhD8iHdbF/cAI6l7SmOXOvtifuU+6B4mOhQnu84v0jNOVkBr8qPY3hW5M50b7ENWPDmvbr32O11Qyib1BSBiIemq7G2LkvrOvy6wOMG6+o97TWLOaQDsCI8tKZ8gAAtDLGxz850CRU/dRLflpIVHlhdonY17nr/LnKiwlNn2F9heVOignwJUFMpmm5W0B5XQiNCTw1RJ798YDpxCJsLWHCAPspa1/pJVoogJ8L+KjH9URYzlAglh36aQmmUJq5cgz0rVVzOPO5kxuQN4+K75QiriQfyCFekxz0Aj1YdfbGMQgObPJObbOhEIhirdrIMsw5VWk4a6EjHx1+c1OMQvj2Chxy0qwiiZFdXftu3VmcuCC7maZWs5pwJD4AFf6JevWfJ+cA0VAHRJyQ3vYHcop5u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cThReTFBcVZhRVI5dVlYUTQxQkdMSVhNbTgwRXhiWDF4Z3Z5NnNVZ001Tkto?=
 =?utf-8?B?Q3JXTk1wZ2puUUFJRjlIN0Z4NlFtU1ExMW11alRaSEIzbnQ1Z3VCb2x5ZGZC?=
 =?utf-8?B?Zi9idUNSTm5GZFMxbE9kbHhQcFd3bmVZNEtDcWF3TTJ4SUMvdmltSENpWWxL?=
 =?utf-8?B?WUVxcDZzOEx2bzQ1aGFEYnRHcXN1Y3hMRm9HcVdSaDUydTlibDVMS2RBYzVo?=
 =?utf-8?B?SVVUc1J0cFk1ZEIrUUZsZG5BQjFUeDJaL2dISlE0enAwbjJtTnphay8xNm9i?=
 =?utf-8?B?cGFZTldVbk9sOWJlalhmdk9zY3BrcVdJN0tsTERvbWJpbEVMWkFKWkVlVGhx?=
 =?utf-8?B?NG5RNzhxNGtiS09tTHBLMURGQWhacFFSOUx2REkvTnhsdGtaZFRzM3RtOXo1?=
 =?utf-8?B?TW5YS0ZkSWM5aW50Zk9LMkhVNitGS0VVcVlkTVE0Qnk4amtCcUxITGVOaDA0?=
 =?utf-8?B?NkExclh3c0pFM1pBNUIxbzIyM1ZhZHJhSXNORG1tbXBZYTBKT2hqelp4L1Rv?=
 =?utf-8?B?cmEvYVp1NmFGRXZsR080MVNlQ2xvQ1RLcnhLaTE0ZGFwL3Jmbjd3bHF1VGRJ?=
 =?utf-8?B?VFozdGl2aWJPYlZWNFlqL01neVJQYzlIM0FwLzh2dXl3NjM1MUliZ2ZTelRv?=
 =?utf-8?B?Njc4R2JWejFBZlhPb01KY2ZrMjVVd0xFK1RpbHBWekYzQ3BzSU1qeVh2eE4r?=
 =?utf-8?B?cm1QWEdadURYcndVVXIxOFFlc0I3NTFkMmVZKzJiWGlpN1V0aC9QdUFuaWl1?=
 =?utf-8?B?aTJLOUMrYXFxWU1JWWN4T0c2K29ERWJPR0dFVDJhYnhCKzlpaTVJbHBFN0R3?=
 =?utf-8?B?ZkV1ZkVYdFRCM1RxRUlXSlhVaTZVMThDN0ZzbG1KeEVna0RwejNoV1NiY2kz?=
 =?utf-8?B?YnpmdmwyckgxVEdYSjdONE5nVys4TnRMaHdMRGVTb3FsWTN0ZTBYTGpCTXU1?=
 =?utf-8?B?Y1dURU5IMzFybjc3QWJlbUhEQzFRL0Z4ZU9PaUMwTzdKNnRLTzhCKzhDbG1K?=
 =?utf-8?B?RWxLMHB2anVwUjVKYStiWldmM254N01TQVpOVFNaREtobXZmbnJqVCtlcm5r?=
 =?utf-8?B?TStJQ1FtNTMyOXg0bzRqWmNoTExkTVV5bXdSenhPcEIvWmFDTEdoMjl1QkU1?=
 =?utf-8?B?b0xzVktUTkplV0dIT0VKWGxOWHJVNGpLZ01RK1ROK1ZTalVlWXdBQkdtSnhi?=
 =?utf-8?B?dm4vcjBHL3FoQm5BTmFDbE1PN3R5UG9mekx2WGI2aVFmZ1Avb3ltMmN5aFkx?=
 =?utf-8?B?alc4QnZDK1pMVVFsNGl0Vko2dTJEdStuUXZhQXgvVzBaOFhUeEFMRTRwVFdk?=
 =?utf-8?B?a2QweWVTKzdqNXVVWlV0azM0UG5CVDRvYXJ2MkNaaU9ENHFaRDBqOFFJV1dE?=
 =?utf-8?B?cCttcUFWRmhHVVJqbmp3SjRFbUxBb0J1cjBncUhyWEFid3RhVXArRFBoTDBt?=
 =?utf-8?B?MEtmMHBwMlJra0pRd1lCd0k4a2JGT2Z1aVI0YmYvNHBZdVo3YVRTZ0tMWmJZ?=
 =?utf-8?B?eHFOY09EYlIvTm5iQ3JlUlFCOGJDYnRTUnRxRXlqTmtCRnFUbjdKYlo0WTFq?=
 =?utf-8?B?cWdvWWo3MmlKQlR0bjloNFV3ZTF0VlRCY3RLckhhYmNyZk91OE9SbjB1NnhT?=
 =?utf-8?B?WW9PNUNVS21iTHBCbStZMnFyRHJwcTNtc2htTGhQSFVydmQ2cUtySE52ZzBG?=
 =?utf-8?B?YjRpR2VmSCs3UndzZFk1ZVdQWEdEMENxbUZKM3phbk16VEhLRFFyUnVBSEw3?=
 =?utf-8?B?YnlPdE5oUm51ak5FNWNxSTI4d2Nwd2FDSTVtVGVVNlRoYTFKR1htbHYzemVJ?=
 =?utf-8?B?bXY5Z1dzNjhjWURic1ZydXkza0xmd2xrMzNjYnVCR0s1ZmNHK2RMV3RQczE0?=
 =?utf-8?B?YWZhamo4dG1sQkcrU0hVNHJ2bktaaTBsRGY4eGowTDFzY2IyL0VJT1ZxRk5Y?=
 =?utf-8?B?TytPQXZlK0tBblk1SlpMbWpka3hhNUFVdkMwNVdmM3FHYjZFVCs0MnV4Nkky?=
 =?utf-8?B?ajFXWVV1SzR4Q3huVlNkeUNZVXRrQ2tZQjNrZUxyY1dVLyswZXJrQVppc2hQ?=
 =?utf-8?B?YStZdXVVaU5Qem5oSnZpbmVqSGRGaWkvN3VuTUlUT1JtSVVMNFdiMk5td2Rz?=
 =?utf-8?B?ZzRCcCswYzAwK1dETjYwK0xqejUrNkYwYlNQdGdEOGtFTkVVbXRlS29GaS9k?=
 =?utf-8?B?ampiZWtTVmFVdlhQQUFESDZaSkpvN2pDa1JhSDRRSllyWElUV01YWmhpNDFD?=
 =?utf-8?B?ajc1NFRGMHVaT2JtUUh3Y01rRFgyUWtnYmRMUlhra25XQ3p1ODh0Ni9pYVVa?=
 =?utf-8?B?cUVtRmQwTXl5T0lEZFRJSlBvMkNna0Fad0ZYcGJMNlMvRUVKUnZRUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FsIiQVQSC6zPavaERono7hKxupmgXHbB0mG17CBwfG0gD9JP9KBPbDfnhgvpw15E+kRYS62dNwFMK+Sql+3f0RtLwdqRMqdB+7L5diX8tRGQm6lWMTjHHXxBOmG4Q01wEc010SGrEEy448YuFdI2toFGbevqduefpBZ0zOVv1sVB53r4PIrG00dR9jKUD6lS6sZ+cV5KdiRAUpOnJeBJ97ado3V9dJVA+zAqAhU1rc2Lc2LTB51iCBVEmaQW+owYyqmLdZ32tvF7vUPaxE3tnlBYo1Q/FaQhHxOSDkPxnXCedRAbjajF3cId1A7OCLQo4SYz+JOnx3OyFmhI89yzvQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db04eee1-1a60-4aae-fbbf-08df234aea2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:41:17.3122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CPpGIU8QAlocQ/NwZFt2oPAAgi4LKS7laz62H7G9jY1Wc9K6P62zt9TGGe4vipI++Rgjq5GJ41NX0UIw7NfL33kmlJAPtGgx/qtQ1JqXXk=
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
QGludGVsLmNvbT47IE1hY2huaWtvd3NraSwgTWFjaWVqIDxtYWNpZWoubWFjaG5pa293c2tpQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgdjMgMDgvMTVdIGljZTogRTgyNTog
c3RvcCBjbGVhcmluZyBQSFlfUkVHX1RYX09GRlNFVF9SRUFEWQ0KPiANCj4gVGhlIGljZV9zdG9w
X3BoeV90aW1lcl9ldGg1NmcoKSBmdW5jdGlvbiBpcyBjYWxsZWQgYnkgdGhlIGRyaXZlciBmb3Ig
RTgyNSBkZXZpY2VzIHRvIGVuc3VyZSB0aGF0IHRoZSBQSFkgdGltZXIgaGFzIGJlZW4gc3RvcHBl
ZC4gVGhlIGVxdWl2YWxlbnQgZnVuY3Rpb24gZm9yIG9sZGVyIEU4MjIgZGV2aWNlcyBwZXJmb3Jt
ZWQgbWFueSBzdGVwcy4gSG93ZXZlciwgb24gRTgyNSBpdCBvbmx5IGNsZWFycyB0aGUgUEhZX1JF
R19UWF9PRkZTRVRfUkVBRFkgYW5kIFBIWV9SRUdfUlhfT0ZGU0VUX1JFQURZIGJpdHMgdG8gaW5k
aWNhdGUgdG8gSFcgdGhhdCBpdCBzaG91bGQgbm8gbG9uZ2VyIHRyZWF0IHRoZSBQSFkgb2Zmc2V0
IGFzIHZhbGlkLg0KPiANCj4gV2hlbiBQSFlfUkVHX1RYX09GRlNFVF9SRUFEWSBpcyBjbGVhcmVk
LCB0aGUgaGFyZHdhcmUgc3RpbGwgY2FwdHVyZXMgVHggdGltZXN0YW1wcywgYnV0IGl0IG5vIGxv
bmdlciBzZXRzIHRoZSB2YWxpZCBiaXQgZm9yIHRoZXNlIHRpbWVzdGFtcHMuIFRoaXMgc291bmRz
IHJlYXNvbmFibGUgYXQgZmlyc3QgZ2xhbmNlLiBIb3dldmVyLCB0aGlzIHJlc3VsdHMgaW4gdGhl
IGludGVybmFsIG91dHN0YW5kaW5nIHRpbWVzdGFtcCBjb3VudGVyIGJlY29taW5nIG91dCBvZiBz
eW5jLg0KPiANCj4gV2hlbiBjYXB0dXJpbmcgYSB0aW1lc3RhbXAsIGhhcmR3YXJlIGluY3JlbWVu
dHMgaXRzIGludGVybmFsIGNvdW50ZXIgYW5kIHNldHMgdGhlIGFzc29jaWF0ZWQgInJlYWR5IiBi
aXQgaW4gdGhlIHRpbWVzdGFtcCBtZW1vcnkgc3RhdHVzLiBUaGVuIGl0IGNvbXBhcmVzIHRoZSB0
aW1lc3RhbXAgY291bnQgdG8gdGhlIHRocmVzaG9sZCB0byBkZXRlcm1pbmUgaWYgaXQgc2hvdWxk
IHRyaWdnZXIgYW4gaW50ZXJydXB0IHRvIHRoZSBNQUMuDQo+ICANCj4gVXBvbiByZWFkaW5nIHRo
ZSB0aW1lc3RhbXAgaGFyZHdhcmUgaXMgc3VwcG9zZWQgdG8gZGVjcmVtZW50IHRoZSBjb3VudGVy
LCBjbGVhciB0aGUgdmFsaWQgYml0LCBhbmQgY2xlYXIgdGhlIGFzc29jaWF0ZWQgYml0IGZyb20g
dGhlIG1lbW9yeSBzdGF0dXMgcmVnaXN0ZXIuIEhvd2V2ZXIsIGl0IG9ubHkgcGVyZm9ybXMgdGhl
c2Ugc3RlcHMgKmlmKiB0aGUgdmFsaWQgYml0IGlzIHNldC4NCj4gDQo+IFNpbmNlIHRoZSB2YWxp
ZCBiaXQgaXMgbm90IHNldCB3aGlsZSBQSFlfUkVHX1RYX09GRlNFVF9SRUFEWSBpcyBjbGVhciwg
dGhlIHRpbWVzdGFtcCBjb3VudGVyIGlzIG5vdCBkZWNyZW1lbnRlZCBhbmQgdGhlIG1lbW9yeSBz
dGF0dXMgaXMgbm90IGNsZWFyZWQuDQo+IFRoaXMgbGVhdmVzIHRoZSBjb3VudGVyIG91dC1vZi1z
eW5jIHVudGlsIGEgUEhZIHNvZnQgcmVzZXQuDQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhlIGhhcmR3
YXJlIGVuZ2luZWVycywgdGhlIFBIWV9SRUdfVFhfT0ZGU0VUX1JFQURZIGJpdCBoYXMgbm8gb3Ro
ZXIgZWZmZWN0cy4gSXQgb25seSBjb250cm9scyB3aGV0aGVyIGhhcmR3YXJlIGNhcHR1cmVzIHRp
bWVzdGFtcHMgd2l0aCB0aGUgdmFsaWQgYml0IHNldCBvciBub3QuIFNpbmNlIGNhcHR1cmluZyB0
aW1lc3RhbXBzIHdpdGggdGhlIHZhbGlkIGJpdCBjbGVhciBpcyBwcm9ibGVtYXRpYywgdGhleSBy
ZWNvbW1lbmQgc2ltcGx5IG5vdCBjbGVhcmluZyBQSFlfUkVHX1RYX09GRlNFVF9SRUFEWS4NCj4g
DQo+IE5vdGUgdGhhdCB0aGUgUEhZX1JFR19SWF9PRkZTRVRfUkVBRFkgcGVyZm9ybXMgYSBzaW1p
bGFyIHRhc2suIEhvd2V2ZXIsIGNsZWFyaW5nIGl0IGlzIGZpbmUgYXMgdGhlcmUgaXMgbm8gYXNz
b2NpYXRlZCB0aW1lc3RhbXAgY291bnRlciBvbiB0aGUgUnggc2lkZS4gUmVjZWl2ZSB0aW1lc3Rh
bXBzIGFyZSBzaW1wbHkgaW5zZXJ0ZWQgaW50byB0aGUgZGVzY3JpcHRvci4gQ2xlYXJpbmcgdGhp
cyByZWdpc3RlciBjbGVhcnMgdGhlIHZhbGlkIGJpdCBmb3IgdGltZXN0YW1wcyB1bnRpbCB3ZSBj
b21wbGV0ZSBjYWxpYnJhdGlvbiBhbmQgcmUtZW5hYmxlIHRoZSByZWdpc3Rlci4NCj4gDQo+IE5v
dGljZSB0aGF0IHRoZSBzb2Z0X3Jlc2V0IHBhcmFtZXRlciBvZiBpY2Vfc3RvcF9waHlfdGltZXJf
ZXRoNTZnKCkgaXMgdG90YWxseSB1bnVzZWQuIEl0IGlzIGEgcmVsaWMgZnJvbSBhIGNvcHktcGFz
dGUgb2YNCj4gaWNlX3N0b3BfcGh5X3RpbWVyX2U4MngoKSB0aGF0IGlzIHVubmVjZXNzYXJ5LCBz
byByZW1vdmUgaXQuDQo+IA0KPiBOb3cgdGhhdCB3ZSBkbyBub3QgY2xlYXIgdGhlIFBIWV9SRUdf
VFhfT0ZGU0VUX1JFQURZLCBuZXcgdGltZXN0YW1wIHJlcXVlc3RzIGNvdWxkIGhhcHBlbiB3aGls
ZSB0aGUgUEhZIGlzIGNhbGlicmF0aW5nLiBUbyBhdm9pZCB0aGlzLCBzZXQgdGhlIHR4LmNhbGli
cmF0aW5nIGZpZWxkIG9mIHRoZSBUeCB0aW1lc3RhbXAgdHJhY2tlciB3aGVuIHN0b3BwaW5nIHRo
ZSB0aW1lciBhbmQgY2xlYXIgaXQgd2hlbiBmaW5pc2hpbmcgdGhlIHJlc3RhcnQuIFRoaXMgZW5z
dXJlcyB0aGF0IGFueSBuZXcgcmVxdWVzdHMgd2lsbCBiZSByZWplY3RlZCB1bnRpbCB0aGUgUEhZ
IHRpbWVyIGNhbGlicmF0aW9uIGhhcyBjb21wbGV0ZWQuIEFsc28gY2FsbA0KPiBpY2VfcHRwX21h
cmtfdHhfdHJhY2tlcl9zdGFsZSgpIHRvIHByZXZlbnQgcmVwb3J0aW5nIGFueSBwcmV2aW91cyBv
dXRzdGFuZGluZyB0aW1lc3RhbXBzIHRvIHRoZSBzdGFjay4NCj4gDQo+IFVubGlrZSBFODIyIGRl
dmljZXMsIHNldCB0aGUgY2FsaWJyYXRpbmcgZmxhZyB3aGVuICJzdG9wcGluZyIgdGhlIFBIWSBh
bmQgY2xlYXIgaXQgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIHN0YXJ0IHByb2NlZHVyZS4gVGhlIEU4
MjUgZGV2aWNlIGRvZXMgbm90IHBlcmZvcm0gdmVybmllciBjYWxpYnJhdGlvbiBhbmQgdGh1cyBk
b2VzIG5vdCBuZWVkIHRvIHdhaXQgZm9yIGhhcmR3YXJlIHRvIG1hcmsgdGhlIG9mZnNldHMgYXMg
dmFsaWQuDQo+IA0KPiBJbiB0aGUgZXZlbnQgdGhhdCB0aGUgUEhZIHRpbWVyIHN0YXJ0IHByb2Nl
ZHVyZSBmYWlscywgdGhlIGRldmljZSBpcyBpbiBhbiB1bmtub3duIHN0YXRlIGFuZCB0aW1lc3Rh
bXBzIHdpbGwgbm90IGJlaGF2ZSBwcm9wZXJseS4gQXMgc3VjaCwgYW5kIHNpbWlsYXIgdG8gRTgy
MiBkZXZpY2VzLCB0aGUgY2FsaWJyYXRpbmcgZmllbGQgaXMgbm90IGNsZWFyZWQgb24gZmFpbHVy
ZS4gPiBUaGlzIGxlYXZlcyB0aW1lc3RhbXAgcmVxdWVzdHMgZGlzYWJsZWQgdW50aWwgdGhlIG5l
eHQgbGluayByZXN0YXJ0Lg0KPiANCj4gRmFpbHVyZSBpbiB0aGUgc3RhcnQgZmxvdyBpcyB1bmV4
cGVjdGVkIGFuZCBpdCBpcyB1bmNsZWFyIHByZWNpc2VseSB3aGF0IHN0YXRlIHRoZSBoYXJkd2Fy
ZSBpcyBsZWZ0IGluLiBBdHRlbXB0aW5nIHRvIGFkZCBhIGNvbXBsZXggcmV0cnkgbWVjaGFuaXNt
IGZvciBhIHJhcmUgZXZlbnQgaXMgbm90IHdvcnRod2hpbGUuIFRoZSBwb3J0IHJlc3RhcnQgcHJv
Y2VkdXJlIGNhbiBhbHJlYWR5IGJlIHJlLWluaXRpYXRlZCBieSB0cmlnZ2VyaW5nIGEgbGluayBy
ZXNldCAoaS5lLiB2aWEgZXRodG9vbCkuDQo+IA0KPiBJbnN0ZWFkIHVwZGF0ZSB0aGUgZGV2X2Vy
ciBtZXNzYWdlIGF0IHRoZSBlbmQgb2YgaWNlX3B0cF9wb3J0X3BoeV9yZXN0YXJ0Lg0KPiBDbGVh
cmx5IGluZGljYXRlIHRoYXQgdGltZXN0YW1waW5nIGlzIGRpc2FibGVkLCBhbmQgYWRkIGEgbm90
ZSB0aGF0IGEgbGluayB0b2dnbGUgbWlnaHQgcmVjb3ZlciB0aGUgZGV2aWNlLiBGb3IgdGhlIGlu
dmFsaWQgTUFDIHR5cGUgcGF0aCByZXR1cm5pbmcgLUVOT0RFViwgc2tpcCB0aGlzIG1lc3NhZ2Ug
YW5kIGxvZyBhIGRldl9kYmcgdGhhdCB3ZSBmYWlsZWQgd2l0aCBhbiB1bmtub3duIE1BQyB0eXBl
IGluc3RlYWQuDQo+IA0KPiBGaXhlczogN2NhYjQ0ZjFjMzVmICgiaWNlOiBJbnRyb2R1Y2UgRVRI
NTZHIFBIWSBtb2RlbCBmb3IgRTgyNUMgcHJvZHVjdHMiKQ0KPiBTdWdnZXN0ZWQtYnk6IE1hY2ll
aiBNYWNobmlrb3dza2kgPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5oIHwgIDIgKy0NCj4g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMgICAgfCAzNiArKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNl
L2ljZV9wdHBfaHcuYyB8IDI1ICsrKysrKysrKystLS0tLS0tLS0tDQo+ICAzIGZpbGVzIGNoYW5n
ZWQsIDQ2IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KDQpUZXN0ZWQtYnk6IEFsZXhh
bmRlciBOb3dsaW4gPGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPg0K
