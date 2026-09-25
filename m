Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2B8C9830D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 10:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F02C40A88;
	Fri, 25 Sep 2026 10:27:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sD1tK4ZNE_J3; Fri, 25 Sep 2026 10:27:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9144A40AA7
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790332065;
	b=nfVHdnZC81gkTJJ9v4rkCQFsjXzGxHsEjvJvte8/BvIjTPirU4O4U4Spaf2V8R+aHebF
	 OXnn+kZ4L5YxJ8GArCWchoEYS9OYdibYwZMH6Po7ICQ3R5JzVFCGkVyqMgyr0zzbEci7x
	 Pz4ZgfHMrEI6YZqz4KI9X/mOPGoryUMHzA2yC+aiQmPDXG26BDwpL6ChenaK9+aC6n02s
	 2k0JVU1Wb9ZWP81AkCcFnIlveFw5GRCq5tZl658IeN6razecfWbkUe2bTfzdx2Qni1lEl
	 4Q6NmX5LCxJdCoUyvzz3KUHJyEsDB1acwZaeTz3HpjmXAnMcqIK57Yf7U0BGYSVSx0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790332065;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=/gYBLqL0UgaT+xpzInzIbLMPmis73FRYOJx7nVTtoC8=;
	b=ok16THr4ow4UY+qS+hB5BXyTNLkkf8IPznRnyL7q91QuJPmedaXf5RKJSM1V7lvAQAPs
	 7hD4S9xpj+nAXD6KR+hNMzfpZeMLGuTobaGnSnpvmDoRyjrBUIMfSg2zuNjQu5acxjCDj
	 vZwP43wzxJz+VFUHkuhDwb9SxirnYbgLaZcUc0B6qFgxIiwAu6WBCN9MvOExgXO+SgZCM
	 hJCAUnDF1zwy6zIan1jRd4XSnAcRhtlZVuN9OPKJq1KwuD1BM+xE8lImSDkQuTvd8Pnfi
	 eQ/qgtftQuL39ZDYmwEFVnQVmSdveVweQxdwcYs9l8fhR5slFDtxWHFg2zpk/E8jpKw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790332065;
	bh=/gYBLqL0UgaT+xpzInzIbLMPmis73FRYOJx7nVTtoC8=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5YleuE0Cycmm/YMMT2l+WDlRkgoo2geC1SAnBUK5UQKMdANhsn/83XnrD4+E552L8
	 E3I9aDfyf/DoI/1+sHeIob5SLlkecbRYl4NebrzrsqK242jeI0+NX2FvdOkHQ8riw0
	 kwmAXbpPFvolpdthK67dBbv2mnSLtFT8IRPbgHGYg8ZoGxyo3g0xqO+pZvga7tCi33
	 08psyWvUeLMJyy0Z3TXamP3BWLHQmhp2frFKGI9s3nDpA6MnyvqtwNY2K2sw9nweQR
	 lWfvKapURWqFb/AF/RsJqWcud27VhClTPO297+Ue0oGPUl94d2upMqwdrk/rpoy0Lp
	 Pa21PpapNJYJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9144A40AA7;
	Fri, 25 Sep 2026 10:27:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2E7D32F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 10:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8A2C60666
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 10:27:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EMmSSaI90bIW for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 10:27:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DED46605FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790332063;
 b=k7PY7DgzNHxBRjo1LNuWUaPMTpSONLtKkos6nmtcYa+EL6koUeY8ZVdiXVHzW5PZTsA2
 q/hP/8W6frOWc0khBBEZHm6n4xdkPXfdNui4dtxqFTnqRtUlQOcQTkTD9KjH3dVSo1shE
 yAyVPZC1Gg4Vw/vnBD0OKSk6lU+uaOxTcDecultav7+9zl0o8TaBtO++vBHxJkfV4IEXr
 8bCd0msKwwPoUv+AYK2eea0ob9G41F1qwwdC0B2ygi5R6OOaFM6beqhf0ZG5dmqoGcYCD
 uuS8OOwR2SEsBjKHjAejf8MlIc+upsqtZ4Sh9WpJDwDamTFv+3tHFAM6e7wBbVGSeJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790332063;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:Subject:Thread-Topic:Thread-Index:
 Date:Message-ID:References:In-Reply-To:Accept-Language:
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
 bh=/gYBLqL0UgaT+xpzInzIbLMPmis73FRYOJx7nVTtoC8=;
 b=heVMkgs1v/vnDbJ0rL5ZICM2g4JkdyQW0T4Vk5t4RBGLyQJZYOhrx0zzqxG7A3YDeG4R
 5j3Rcx8lY+nqQeV1XEHRmuGjHRyGX1PG6UWIhE8gSIwDpmxcgauCMOnaku0jJo6Ub19BJ
 vBDtC4pq37Zn3Pzp19pGg3/CMwrjkOF6qFeZj3YXGu5BTx5kZnP7sySMrA5ddyaXux6wW
 KBpzZUPb/1EPVriGIHC+QqONVd8jBoU2pSS0NSJ9w4U1PfHRoIHRFG1Xzuq/BLTZBAJj1
 HzxYVI6zIvw0SmwDwJZpOQxy7du/8wBHbf4d3KXfZqCOnCDeBoZLNGrUSgT1ohMCilQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SlNFdEnr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SlNFdEnr
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DED46605FA
 for <intel-wired-lan@osuosl.org>; Fri, 25 Sep 2026 10:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790332064; x=1821868064;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=cgUb3RLed5rbDJDDlj4W0HVIdfKlAuaGW/VqvqMbwQo=;
 b=SlNFdEnrFlxSnyxRn8BaLd5f2zfgei9VO22gp8NYS6zmsQmtSZNboTOw
 3elvGY3A8AUOMqEbtp5Af316UTErnTzXFEF4dZGNxpn2DflenJwEcQx8k
 IVZHnATt5Zdl2eBhcoxAnSJHUdG4PvPa5fA7KhF/MatzklCVBK2PyQ8BR
 dIo9AamXArnvtFoPFJhh5pdPIveb9cknmt+NSi+WaVfWA59If2jUG2xPJ
 S+p+/1u7Psiwd7sxlcH8YpvpsgK4I/ihkl+cMCeJEL5eZCrmFK2MUGljO
 Osba+VB5JWJ1GiP2ZfQDVKRUt2zAzcwL6VpfsoUIHe/1VoULhs7nIWAYe A==;
X-CSE-ConnectionGUID: HTxjuGI5Rdu0fJTE5ZL9Fg==
X-CSE-MsgGUID: GttzR1jFSwWyxQmpZDrVKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101642342"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="101642342"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:27:42 -0700
X-CSE-ConnectionGUID: wVufVxaETtm+WRAmaJaLFQ==
X-CSE-MsgGUID: 5JNQifq6TfGKOwieHfERYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="270774720"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:27:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:27:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 03:27:40 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePj1D2JtIWth83jc4oQcU2VhAdO5tGczvkVuup2jWp9BSOKVMlfhmnHIAEABxM93AGH/EYr/d4IbCn+nzDD+KIq1p5x+XthcLiN5HWruXXtWCDlC0V5YluLfEjSeRkFepb9Q0ulbH/hpXkobdfGJOImKXaNL32VwLIPanVjf5hWBxvODW/zIVoNoTns9t7P290FNK5UOBvOsyInbH9cVNUA+NfJqrvCWFlurRIpxB5oAgKvevy1rb7XeVN3jKwOOppcnWnOd4GT0DhBn6JzcPEKjZ+0Wg+NF8RH5czW/OgLqTgnMwR3uZKbSjFwC8+UnGxvZr9fzavgkuQ7J5x7Xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gYBLqL0UgaT+xpzInzIbLMPmis73FRYOJx7nVTtoC8=;
 b=nq7Ia+SASCfMgaEaHLcgfPTVpnaYjlSK/bcZxjJmarkl6/gTLjgw2mRHko0hCAWoILqHq3Bax3To2iKVZ16E1QB+KBKnxSdM+L9PMzDGqxOjE30Wp3I7tYo6uVic2ue0u+wsYyMaTlazLYK1NABUvlWkTNzhE8cFhDZrFzNtmYE/jcEaTvAc2LJ6o2mZ5mDegD/m3RUGpvaYFcYPI5WVSRbbh79ZR5APyddnIp9cTpxFLxa8h/RIAYC0zZSUSLalZ2RUZ7i8wwxFIxZ+G5SCs59R45THB0XjMsIBRrX0SDFO7zg+D4Ro3NV621FbWmwamp+5L3oeMddfcP0Zn6UmRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by EA3PR11MB406321.namprd11.prod.outlook.com (2603:10b6:303:309::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 10:27:38 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 10:27:38 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Sasha Neftin <sashaneftin@gmail.com>, "intel-wired-lan@osuosl.org"
 <intel-wired-lan@osuosl.org>
Subject: RE: [iwl-next, v1] igc: Group frame size macros in igc_tsn.h
Thread-Topic: [iwl-next, v1] igc: Group frame size macros in igc_tsn.h
Thread-Index: AQHdTNZk95Hrai2Sg0mHLwpe8AHboLbfFziA
Date: Fri, 25 Sep 2026 10:27:38 +0000
Message-ID: <IA3PR11MB8986EDA537B7DFB4EA91E5A4E5802@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925101209.34832-1-sashaneftin@gmail.com>
In-Reply-To: <20260925101209.34832-1-sashaneftin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|EA3PR11MB406321:EE_
x-ms-office365-filtering-correlation-id: 357df0a0-a033-4e3c-75f9-08df1aef9f6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|22082099003|18002099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: rUSXfsz3UhQF/8ZrCcqN5T3xosMMDZiZiqI09UhO8U4czhl0GPbAfoXE8a6ifSpo3wyekqM4xKVEeJ06N8hrQIJlvaLHr8UZ9SZFTVabTgAxWstpE0lQPICVZ6QhA8HutKBm9sT1Y9uEtweSVTqMkVmrKTUfxfZOpxD00Skl4U1ba4bfu40HlmSA1IwgkxPfZInDY3ufkPO1PJf+dZQTI6KAzqbNASydSyuQRQZ8jvQF1ZzhcJzXRv33iEpgSnq6sx8Y3vAO/ADZztlyFTkOXepVqkfPIkyI8zrAr1CXKShP+1uZSIPs2C+P2pn2uS0OhihGCo5GcaBDAeC1QtoIl5sAkmaBUq5N6CXOSmKtnrJDzdGCRVio8Y9HaMm+yGU8Pbb/zq+WBseqvHnLeYmZiuMmV/Cp9160a6jQAt7WAIviC2le+vYzN4ZoW/F2JVakG+nVUJQQ3LJXW1ZQTIl271tjf7z1GmaIHEDALs51wsP3s4zhKKv6O/C6Pg3ihsdhKaXYKxMj2sHKYujBskSY+F7k/WBXHEAxnmgO3gdOMxAfBDbNIQlzJI1hU+dPrRvlJIWCeY3D6IQiNjwW1xqGQ1/raFE3rIYGyU82aWnWSx9zECJo+5UDyS+N7k5im3AbOAz91P5p0pS67x9jwOGTZeaO0hsaiZr4qZluMSEGh5DorO3kuokzDRUFaZnC8JVOnHdjRz/9qGhWjR+0RK/4yj4jxcDVZfFM68b4jMgPhBQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vE3UkhGRaQMwBnB7Ol/Ui8/93e5Z6SlDLwtqyUFWUGV6oRnyzLxiV+Od1e7X?=
 =?us-ascii?Q?zOVllckKk04yJSK8Z/jnoPAj4rLHqWoMlXFOvyleAmnMcsQWVR7lLHqOo7Vp?=
 =?us-ascii?Q?ua9MxiW0o1MFr36zLwsVzpI3Deo4T74HXdaZG8bKY2KP36EsDzpecTxDDzfr?=
 =?us-ascii?Q?FHwELwcYr5+KhziaphCIXZ23nKgivZMgc1bzzjl7XRMKkygjwvetkjqvChHv?=
 =?us-ascii?Q?KyDHrME48S4s6OgTLRbdO87gzi2cJ2ZA2jtTKPT+wplrPacC9hVI86oHiK90?=
 =?us-ascii?Q?c1PZ1z8nYoKfOJr/cTjsNKr1UjNAWpiHWwcGQdP64xg1ZvCJbuSqbVT5shR+?=
 =?us-ascii?Q?dKH3H6wmcNM47GJcyheWP8UUa2yaiXyLJe99gULlDCEi9nVOQy9n+jayiPD0?=
 =?us-ascii?Q?IvwVY1AtYKpa1Z9gFYn3hGsT4btbJfRx8BQI1uMaHiOuqaX3oarBKiLfJlMw?=
 =?us-ascii?Q?uiISpgNDKEiQvjdiw0B/WR0gmwXPzpco0y3/y8isBqCnv9sssjc5XJsXF0b1?=
 =?us-ascii?Q?87mPwKdWtKu9P8jmsR4E44LbzkTyueusqdvQry0OS0KOzTvI+PDCgJ7A8iLu?=
 =?us-ascii?Q?5e3dLErI6d6e/ZVQ+bkaL3BDkDjpjyO7yh7xGrU32wzH/KJg0fDgiPI1BQMZ?=
 =?us-ascii?Q?3uKH8Oa3kQkUJQDB2q7jPdVdTHEjaY8gOSiCw3KjGdksriWZLGVFzfidZE5D?=
 =?us-ascii?Q?ewVfJ7QMKE+ZyP+L0gH8Aa61ZIIndp35qqNOzi7I3MjpW/EwPB6YG6lwkU3U?=
 =?us-ascii?Q?fOBQMWhmZXytoOnabd0cFcIR/+ZVn0dJZlcifQivQXLBfckPF/Gkgprw5toz?=
 =?us-ascii?Q?/cJg2ishLdKZLWTd+Bo5ZEdm4XFL5sKgByYuS5rXr+Si/2VjSnOaNbAd/SA9?=
 =?us-ascii?Q?bgYyhawugxfQyx8EKf1v8BRwzM+slORNWXD4sufWihAW0vZrvvgy0SXI2+Bz?=
 =?us-ascii?Q?2+Grmyb8VAhk36YMHevWeZv5yjx5e3SCmUb8Y1SGJAXJmr+It7xUx8xmLelN?=
 =?us-ascii?Q?mK6kN8dwUbil31J+HvITKkqi7WsSuta0nVQl1esx8F/x+r1CGPeQQpcMb0By?=
 =?us-ascii?Q?UW2EMQihUOwvAdTCON1j39F5UNii0l8EbQ2Nu4UQsNI/TyQUnZbUzVZcbEap?=
 =?us-ascii?Q?+QircddGc0QJqmI7z9M87vNlfZBuGvRREbe/rT+BVl3tkuokO09KCHOysH54?=
 =?us-ascii?Q?rRNUFv4hK3N3CBBkKbYfQC0roljUrq2/PuDEpgSYemQQPgCrCaOT3/XP46e7?=
 =?us-ascii?Q?iYxemZJfVdoiNjnmFR+5rOn9tK2icYxryjcR1mXqgV2AulmH/Pfce56iSrX4?=
 =?us-ascii?Q?96ao3pyD35n+i5JnuF3N8LOZriY9/cXoOxmZpO8FKMDRLgActlHzobmgm/rv?=
 =?us-ascii?Q?VckM+St2KMdFklqCU/ahsyyHSANFX1ShqN4MzCWD2NCzr6q+ifiscdvPpPlV?=
 =?us-ascii?Q?dFoRyAxl/btWhtJDCdYManHfDJf2BF23g8dZZHvhOmre7b2P1me+OFr+Zare?=
 =?us-ascii?Q?iRiwcFpYoZEIfz6xyc9n+nYGq5izFYxd3ZgDb9qmxBuQLTf9MJvoeId79QbK?=
 =?us-ascii?Q?xhIFbDNp1Y+2OFUMED7xktRDbSUxpfA1VndvgqBYxfEaGejfaEwFQJbRQLhT?=
 =?us-ascii?Q?Oc1sXmL9FtnJp6xEMHsiY62KLQ7mBRJzS0pmwl+JFq7Zhft465vI26X+cu63?=
 =?us-ascii?Q?dLuGOeNqLnPjFEqs45wE5MebMJzZiHTfNJiyz6eR5iT1aKNOBY5h+Vtdn0US?=
 =?us-ascii?Q?iP9Iv0JCsQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AVnwSgGgwe8tJHm2qPGCUsaRah3/Q2fB6R8/7wt70SQu2ncIA/7r2wpLDUpFBjQgO0VLW/jckFFOEgkk/H+eBMCAiGYFHXczrMAYCg1BRy6MIl127e7riplKvhj8E75W9lyMH8dwgPjfTOmojtiM0TAlpdaKXA+ZRiMIJmR54fkvB/j75hxxd3Uhoql9rbqlsumUfnh2kKWPBp2s1ZywbNKS8wMMceU0DG8S3u00V1QVthYHeLfkfzJlle5ePvvKPtbBFyzHlt81hdh/W/mBzmPJB0NamyaYPyXkLcLiO60ovatmXd5C4pF56ZYIy2Z3jeCmOMp00YFNQoPLxrP7VA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357df0a0-a033-4e3c-75f9-08df1aef9f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 10:27:38.2814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Lso59CIfFh1MWGo+KKwd6ku70N0zu58I2CBPgyK3u9GceB7J4tMplBChGCaPcMsv/r0Lwt1juujrco16DW5I03UcpuE8lJXV7oeSXIJQ20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR11MB406321
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
> From: Sasha Neftin <sashaneftin@gmail.com>
> Sent: Friday, September 25, 2026 12:12 PM
> To: intel-wired-lan@osuosl.org
> Subject: [iwl-next, v1] igc: Group frame size macros in igc_tsn.h
>=20
> Move the IGC_EMPTY_FRAME_SIZE definition from igc_main.c to igc_tsn.h.
> This consolidates frame-size definitions for TSN and frame context
> descriptors into a single header alongside IGC_RX_MIN_FRAG_SIZE and
> SMD_FRAME_SIZE, making the constants available across TSN modules.
>=20
> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 --
> drivers/net/ethernet/intel/igc/igc_tsn.h  | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c..b0a4c2893ccb 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1137,8 +1137,6 @@ static void igc_init_tx_empty_descriptor(struct
> igc_ring *ring,
>  		ring->next_to_use =3D 0;
>  }
>=20
> -#define IGC_EMPTY_FRAME_SIZE 60
> -
>  static void igc_tx_ctxtdesc(struct igc_ring *tx_ring,
>  			    __le32 launch_time, bool first_flag,
>  			    u32 vlan_macip_lens, u32 type_tucmd, diff --
> git a/drivers/net/ethernet/intel/igc/igc_tsn.h
> b/drivers/net/ethernet/intel/igc/igc_tsn.h
> index a95b893459d7..e08f48543d99 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.h
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
> @@ -8,6 +8,7 @@
>=20
>  #define IGC_RX_MIN_FRAG_SIZE		60
>  #define SMD_FRAME_SIZE			60
> +#define IGC_EMPTY_FRAME_SIZE		60
>=20
>  enum igc_txd_popts_type {
>  	SMD_V =3D 0x01,
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
