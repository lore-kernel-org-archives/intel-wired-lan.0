Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E91CA9EBD
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Oct 2026 14:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 512E16060E;
	Sun, 11 Oct 2026 14:20:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1gQahmCOcPoq; Sun, 11 Oct 2026 14:20:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 731DF60614
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791728401;
	b=teKUaf2pBqnmyYUjnX/QD5MNeNZkq7M4OS4M0YjEIs6CPRgJWefamH/HFS0g8wj9mH0Q
	 18HOFoxLcOKj3WU1Uw6EEkXrN3T1j/YFaEqxZRIFvqTMu/M7xyt4/gh8qG5HMiOz+v1e6
	 bnrQ+2xYixvCNhYR5GjzNmq2LgJLRI4RSgGf52w4rgRcN5hrkvo+WhJ+WkhfGyt3icxBH
	 4QM7rllsj6ssG2ebaqewGL+VTAoApFW8aIQoZ19+j+2aHqagZ+b9pqM87jmvv910IJqwA
	 sqczjtj/yPBDmHCZwY5jUlppx169ZIBbiVCUWo5Cm6sAPRpQfqFZJvfJbiukfCDxDVA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791728401;
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
	bh=KVWZKnpTm5b+4v3vlYJy4ZlUCPBpw6PIxQZZYZSQuxI=;
	b=e0MxD+X47nJxCw9wQIPZ6KH6bKkc98kdDwtsXESqLnbM9SfowlpHJqGE9RAnaOTnff3k
	 giT+AdcTEvwN2wvFh+6Cb9XbtB8Hnn2pHmC6IUJGz5/helXRGVKcjVnLWmapvrXHz13t7
	 gqeETY/4ICflAye5PmjeZEnYD2Jd/bX8gju1yq1MOpF3eYUhNv5yd80xGSIIRzHrLuvPF
	 XQ8PBP49EbHjxm8myyZlevrDdCS5oS0bhc/Z+0PFmyCNv12C7B3WEAhTwkV7X5UjLr6vr
	 SNve9I3BrvH1RFmtCMP+C9vdIXTyMeE5ufjiKT96hstT7Ru1saq2QoF/DHvcFXulh6g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nwtN+ODK;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791728401;
	bh=KVWZKnpTm5b+4v3vlYJy4ZlUCPBpw6PIxQZZYZSQuxI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t3TpWGjXIpX3Cxxy+jWIZSFgLA1ulVYvP/SHX2s/p2lMk8hB8INE9LNlhXGddMkeP
	 PYSA5h8Gfj01Rw48Cagr3xIwAQuyHQdirjzb1orfqXYmaPbtNObyKxPdFHGwe5M3Z8
	 1CDla0c0VOzdZSAsSffxGz0vY37epnREXDGtI1FMXozOTfnfhtUi1p1SS/PFf1enOz
	 mSIRAKZxi6ihGiEgCLwfuGlmYQ6YwfBgTLXAIwmSYeRiOXBMUkV4IECveXSxu883IZ
	 RxIhJhCcvGbKF+1WWykwyW8wAXdRRw7CmDWiy1HceKhBYbKFHmjjTsRH8/vkv/hwoa
	 wJqh9SmUCkA5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 731DF60614;
	Sun, 11 Oct 2026 14:20:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 243DF75
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 14:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15A7360614
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 14:19:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6oKVFy5_Orwt for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Oct 2026 14:19:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C46C6060E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791728398;
 b=cCfS5jlj7Cnn/WidrTjThha1znkBqiWfbsHZ0Chh9Jl/g5vPoomjrz6C44Z/vmD9nD7b
 HKx4JdT8Rpl9JcVOP5orm7mkX5ox0fVZZ0puAqDmk7r3ipfzBTPrCt+nAsTrbuT1qWjHa
 feGXUHkzEGowCyw7koCnMGwFCNBZtSQjCZ0j0ejL06pYroxzT2G0FyBoxnrgJNFvd9zkC
 sltyGByPuWtoj8gaY8qWDYd3+gBmyzRNy7P6U9PcRjO1/+HSgE2Rq9gw5VKpMOaW5Oz3E
 ZhBSzPN9A2WxlaMo9RTJHA4Dj47Jk9wBNpTZ5ZKDU3xcgW3M/YXIXaah8HvwlsWfLyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791728398;
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
 bh=KVWZKnpTm5b+4v3vlYJy4ZlUCPBpw6PIxQZZYZSQuxI=;
 b=H3y++X6tuJXbCvaKt/MaOpgW3CHa4CJYH+MjCf/6xz4jPQ1pIVXF42E2kUmY+T6hya8E
 1ACxa3EZZrBRQa6b8ZuAhxjzhck7QJf9MJxeiUPtW6heH3sjTuXtxbOLV0J7T/q+LSBBP
 Kha9BtdwmMs6RH0kE8TlFA3BAUV7Piwblj7TgfxTmkD2b7nrNtBRWUSHItQvDYqD+sExp
 WSSy/oPv4y4n/yCXGcMu8aLvefiaAwE8duvDvSi1Vne6tsovsHpn2pGmbQLdoWFE0lj1V
 uvkNJ62NL0Pvu8Wh4z57OOcdyyQM580GHECEELSS3UBMpmYPJoPSntZLzsnvUGKVXXg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nwtN+ODK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nwtN+ODK
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C46C6060E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 14:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791728398; x=1823264398;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KEmeYIVTxt0i3met6HZsK7GUytoR42O3k/0mtSaJnoI=;
 b=nwtN+ODKxCclLk9FQ81QRsgsXh4qoC7NnFua2vBZ6blJ9zwukVsKnEOC
 dAh0SePVWMz/Yljx6PwlLe90ZylV8Rkc6JSWtnZxZ5RPHFbHsnq7o+9kp
 LxM7/B0CvOhrw5nw9GwB8dCsOXv2x/XG+6RtuEyVy2qCePU5QrB33wutE
 mIjbKkWnVeJSg6UhpdOnUJtTAeriqzX1aoJUbii9a+59DH5VhcDWmvmou
 dW0HNMIE63GzEs+RKNLYcXAqnZfx4Mz5AwOrBnvbfAxGVXP2OQKPVgpsq
 KzToGV9pQrPH0cuaXqpoeHz7FiZPHLiXqY6iGO2Y9dIWPhvDc9NiKla+6 w==;
X-CSE-ConnectionGUID: FVUQ3tJwRBmwemLffl1R5w==
X-CSE-MsgGUID: 01ku5gT/TCiahMIAY6TPqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="469663"
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="469663"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 07:19:57 -0700
X-CSE-ConnectionGUID: rrELL/DMQbejzouRgHjhfA==
X-CSE-MsgGUID: 15hA5loNRnaVT2fsjihSFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="2493908"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 07:19:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 07:19:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 11 Oct 2026 07:19:57 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 07:19:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rleCw5V5+QSGj8xJX10syVOiv3MvOeGcDr/CuijQkWr7iKAcS10eP7ij41n+Vd/orS2t9ZnEeyHUf0szcPbQi5Cspt/oPFfBpGEo8VGGb/qCcYKJQcFFr64gtPW/bKd2F308GdCiripug+6GhegxAN/aWfLFJcNbC/TEdobMcXwVVL6xPcgrP6/6ruTmehKWIUsLBmP3Y1NcD44mVbtCfrwIdUnlipZIjiIHPgrcVgHGcQsC7OyQbqJO6Att86hkDbsO+A07Qgx3mcXQQ4XpbfYWA3a0w7Xxi+P71gyJdV7fn/nEg1ZTZcMA9N4wuiFF5Gn+7AaA8puCfUFkGaZi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVWZKnpTm5b+4v3vlYJy4ZlUCPBpw6PIxQZZYZSQuxI=;
 b=gMl9Z0tMhfhcaokQ7Zk9Xx3aMDn51PjhZ5ho+eshnh6CNhSxWY3PkibI44WeuhBNu5e1S+Er28pQnJt0cn2lyR9K9f3DJ8fr5AT1WJf+n8Db/y8ktmk+LHcPiGMGY7DzCbP84fpzVDnPkfCyTkdWXcXamcYTJIpk+DBvGQ7ulMxCYBWb9edEnxCyEu0J+xsAux6xW98E/iYBBKGj0CSVKckDWDcANr+vxdVxqvTUhP3bupIhqNHVxqJ1heKPmTwhq6bEOyDgrwk4h6TC7bi8U9bJZeFPgR6FfDe6lgXkmpG2Pi4ie0bEsNAg4lX0SBmlTemzCz3h1fSK2x2thJ/faA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 14:19:30 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0496.015; Sun, 11 Oct 2026
 14:19:30 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-next] ice: describe generic DPLL pins from firmware
 pin classification
Thread-Topic: [PATCH iwl-next] ice: describe generic DPLL pins from firmware
 pin classification
Thread-Index: AQHdRtg20roHcbAGZkyPFmEPh394Rrb4iSPw
Date: Sun, 11 Oct 2026 14:19:29 +0000
Message-ID: <LV1PR11MB8790A956DCA100289417099290902@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260917190339.3239476-1-poros@redhat.com>
In-Reply-To: <20260917190339.3239476-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS7PR11MB7691:EE_
x-ms-office365-filtering-correlation-id: 0c27b089-1cfb-4588-de70-08df27a2a9f8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|10067099003|3023799007|38070700021|261009223027099003|11063799006|5023799004|56012099006;
x-microsoft-antispam-message-info: C5p2zlOLkiJ3UIVIbJUMSNpwaITfHdM1bQxpIp4zyOdvdYteLBTFpL0WF2TL3oMbZXbIxlMASz8xq0+769rVV04UjjoDEhqGRCTJh0F7y1BCJ5pCHciVm9OTLOGaLyCKJwi5iR0nboRZJY2bupAq3LkK0hYAWyuWIU/mKvDB6Vu+6t46O+teTjRnIRboJJCAQ4wXeohWCOuPIEnDSieBEreBsIhxZVnPw5PkImgcJzjbMrf5u3n/J2YSrlZSgkcD7CImggekfohLRv7Fo21mKOS+ChhPKcCJK0fvb940E90A9pQeC0dGdiBnTJLuXUc4bkxpZDYWM3AyMzDsObMcIUp77ZXhuSjEWbEllZYV2fJ3Ye/I0qzCwTxX4KLrEU9/DlILHCy56g1NHZT/eSJsKXDG+iZxUp6s+KE3nsPT3ALh2BhwDrBd6Hafj/1jHRjUfR6aVc9RZCGIQlqdFR89uXTZvzWZF9qHAwowpEwGMo3O0G3C1T6cXLmXnF/fIdDvRuaEeuA8ULvuypBkn1TGksa74ZDw0jgrwe30vr7xU5a4xEPtObDRxYvXfBGzz0xisb/do0fZPz0jrP58fA3sQXq7IS6xL8THCtumIlircglvA7oCK4Hz/JjL4fkd1jH+QGXgQlOwOaNwgOajtvJrpvhWIVFOLLxYGhrbOI88TpaJlrWDmgZlE/0B4H6STjJBsBt/MW+ktWk02fiA22c4+xA/4vwB/JsSMGBkfNWVXkE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(38070700021)(261009223027099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S6y94Uc26qKDFv3dTgb8vB+lQIXM6Zoma0cd6VBZp2xGmL30Y63HbPtjNxW7?=
 =?us-ascii?Q?fCsRghDF09UjZISlZKPgl2Rqz8a6eqmR3zQND7Ln2PJewWPkK4Ss3HGa2/PI?=
 =?us-ascii?Q?KUcZA27dQT4NlrO+oXHKtsZYUkI+zIyF6eE8bsLVYLyamQizjVVSCuTWWCSg?=
 =?us-ascii?Q?fitoVXxMKo2UTagdej3jChoTybjNx4TvR0YmrHf9QpmljOSRfJsoKcXYaxZK?=
 =?us-ascii?Q?jt46qJVuR387xDjlhObXbv6pM4QLoV/cGxlcghKtOThxjOjrNdqYEgjz/peE?=
 =?us-ascii?Q?oy0fZx5HqsgWiBZhSA6/lK5jsM0t1XA293gwcX4G+cxM7mubFU/EERBxlhJo?=
 =?us-ascii?Q?zIagJi2buRclF39oiHYTgUw8kTU9ObKyMOxtL4eRU+1RiOCFr9Mh5UOOB1QC?=
 =?us-ascii?Q?26ExHqskkCYf24+3RXwkvj7cADFAInSHpK4MI0IllXfhrUtq5joxckU5sAY4?=
 =?us-ascii?Q?gymwnjyBRSSRaFb/cfM5l9rwIF17EO3AzyyrBn4tKbxd1HAzbEN94WiUq89R?=
 =?us-ascii?Q?jLrXiRGZLof9UA2Z7/SX8OvWvAirkgY7cR9S43eujaRn3JoJuEq4OkG/OVOU?=
 =?us-ascii?Q?MmggxgGtS+Am6TDIo0c7YX8J5trIodT6kyfCAv2ZVF6Nc7j1YOk9v3AGq1Ug?=
 =?us-ascii?Q?0zo16uAOqv9+f7wt6TX9JTQ8dC6f32zGG4rFo2bFyLDK8yfc9ILk9SYF+e6m?=
 =?us-ascii?Q?YsPphH40yqh/xYzXbQjh5ovGEIGUVR5NNxip9rspLxWXFeMtT5+Ev5FG71Mn?=
 =?us-ascii?Q?igLZVweBiB7RBs5OnWqM/knxEqEWmPYonI9JR/s5KYhwHIN1c3XpxyROjNZG?=
 =?us-ascii?Q?8h35LXKA0qAoP3qb0iZrxOrwbesUhM92s6fVFmbelsLFpRT2NEF7jHABz3Tu?=
 =?us-ascii?Q?6Ry2PwXHMYlBUkxQtjPTpnM9bS634puAe2EXxcAVclAM6bvRVggXA4oP06oO?=
 =?us-ascii?Q?GWgGHsjaRkbOT4t27J4Y64/vwjjlPiGfwPUcw6tFGEW6wLXDGNoe36Psp9Mt?=
 =?us-ascii?Q?K42GclfhkmaoTqeDQQbW54pVnY1WiUkxkHOrrzWz/xogdtwRe4bSMufCFhjL?=
 =?us-ascii?Q?WBwZtzXZJAvZhS3DfxfDLbG+lsACKw89MdYdA2+AYmu8yMjDn/Wx2/kj85Dh?=
 =?us-ascii?Q?Co3+WEpme1AcSq4UqsE6BYqdsxdyhoWyO17+xVNnMsnBEg7hoAMUcLiUm+Xf?=
 =?us-ascii?Q?XxY2BvPjVYcYZZpPN8W5hlSQGIgM3uBCaJb2grwWDIbjUpcBiOZ+uoFzyJTr?=
 =?us-ascii?Q?1xCUsoLIvg3Npgg6/2kNHzpQPCrGQV1+mPdE+yKVTgGLK4zm3w/AKLOOeVs9?=
 =?us-ascii?Q?bMXp4M2dBDV1onUtlDsbt6BE31Wb8IJNOt88VW+vgcy7vWFTEvsFah19GGIR?=
 =?us-ascii?Q?mEOK3GCmc8elNqU2Qk8iD3UzVJm8kvc88ICji+xEEjMDgV4R2ypu1jfBYvzg?=
 =?us-ascii?Q?TQ+yLdJ3YbPmoIwL9SOxDC0slC+bIqBBIyr28uyYg3yuvcHUxwq9F2vpz+zH?=
 =?us-ascii?Q?knO/jX82ylcwBkjXjkCjIvfuEL7xzgIV57CcMBHbigF2SLCbiXWDIBdnDM7c?=
 =?us-ascii?Q?Xty0DRWzJz22k34vQhsXXX/E9+cFyynnJ5g+rqpDpqUIiGG6Q1nDOOGwU3zk?=
 =?us-ascii?Q?QbDzjcqDKmUk7rT5MtF9FOsKemg63/GX+4SHb1U8mxUKuu6cFyJE2JZbpOjD?=
 =?us-ascii?Q?NRaH5V77AUYZIbJtUVCacsDFkD8S0lrImLO5iYGG8RsjAS3mgoGQoMvQFNYR?=
 =?us-ascii?Q?oNar0PZHlw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3yIuzf8FwVEZwEWcRLL39LDjoqFq4AKi18L4uPfOS9fzQ05DwvHQd94iCNbOdqW6yvk5JuotDC5kVEgD67UCWS0SVCjnONQ/MZDT9fs2eSvH952HusVhdz3FCNlC1SzGmIO/QWUMwqG2IbjVr5zmtSR5GY+GexjYqGHXFlmKwagaZdbru9Z/stf3EcEkSuQI9cG2pl045RyasHMxr+/Sy27OoJ9D1p1Q5LMxiS4A9aMJ0FYCm9CWKHp78a5gy2+pbdxoWqeB7vscLlxHV05VnTIOjWBdaiPXmimM03mhBAmzHQwIiYwDDlbPoQ92zfitRGiqnAL8wtlitG3lOQE6zQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c27b089-1cfb-4588-de70-08df27a2a9f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 14:19:29.9651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYU8UQYmVGdds9exk0asVdvjigNoCikosx1IUQ68qTlnZRaORJyu49riFyAj8xvZQQ89SbhDb+gYR5fIyY6a8sD0fSBVKmnXOeSUantiSjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
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
> From: Petr Oros <poros@redhat.com>=20
> Sent: Thursday, September 17, 2026 12:04 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L <anthony.l.nguyen@in=
tel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn <=
andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet=
 <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabe=
ni@redhat.com>; Simon Horman <horms@kernel.org>; Kubalewski, Arkadiusz <ark=
adiusz.kubalewski@intel.com>; intel-wired-lan@lists.osuosl.org; linux-kerne=
l@vger.kernel.org
> Subject: [PATCH iwl-next] ice: describe generic DPLL pins from firmware p=
in classification
>=20
> When the number of CGU pins reported by firmware does not match the stati=
c pin table for the device, the driver falls back to the generic pins added=
 by commit 6e58c33106220c ("ice: fix crash on probe for DPLL enabled E810 L=
OM"), named "0" to "15". The same labels are used for inputs and outputs, s=
o a PIN_ID_GET lookup by board label fails with "multiple matches" for any =
index present on both sides and userspace such as synce4l cannot address th=
e pin at all. The pin type is guessed from the current frequency and no sup=
ported frequency list is exposed.
>=20
> Firmware already classifies every input pin. Get CGU Input Config
> (0x0C63) returns a type field marking GPS, PHY recovered clock and extern=
al inputs, and a capability field with the supported 1PPS and
> 10 MHz frequencies. The driver discards both, ice_dpll_pin_state_update()=
 passes NULL for them.
>=20
> Use them in the generic path. Inputs become GNSS-<n>, RCLK-<n>, EXT-<n>, =
or IN-<n> when firmware reports no kind, with the matching dpll pin type an=
d frequency list. An external input flagged as accepting any frequency adve=
rtises the standard 1PPS and 10 MHz pair. Outputs become OUT-<n>.
> Labels are unique across both directions and the 16 pin limit, which exis=
ted only because of the static label table, is gone. Labels that happened t=
o be unique before, indexes above the smaller of the two pin counts, change=
 as well.
>=20
> On an E810-C timing board firmware reports the C827 recovered clock input=
s as PHY, the SMA inputs as external with 1PPS and 10 MHz, and the GNSS inp=
ut as GPS with 1PPS, matching the static table for that board.
> A vendor board with 8 inputs and 15 outputs, which takes the generic path=
 today, gets addressable and correctly typed pins instead of ambiguous numb=
ers. The DPLL registration on such boards is fixed by
> "ice: DPLL init fixes for E810 timing boards" on iwl-net, this patch is i=
ndependent of it.
>=20
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c   | 72 +++++++++++++++++----
>  drivers/net/ethernet/intel/ice/ice_dpll.h   |  2 +
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 31 +++++++++  drivers/net/=
ethernet/intel/ice/ice_ptp_hw.h |  2 +
>  4 files changed, 95 insertions(+), 12 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
