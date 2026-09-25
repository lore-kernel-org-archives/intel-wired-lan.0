Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75143C9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 07:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FC55811F6;
	Fri, 25 Sep 2026 07:39:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Snv5p4hALSYY; Fri, 25 Sep 2026 07:39:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 50C78811F7
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790321964;
	b=Fu1WdJR/HhrBL93X6ZyveCQskXx0mNorCeywwqfwBeBN5nwCoBMF7rlIVdn+ptP9YBhy
	 EHbtehDkwdH61CMUihikHt3s3OrzT1+Ey967VY2vn5FddqdcCsV3MZi2aaTrm/vUSZaSO
	 BeoX1c/yYFjL4DXtboMA0Y72GDv5wzhpZgcIZ8DCvF2NJHnLfUM7Pzvd1HJo0VkrciVHh
	 irCTyV3L7rlkVTpCRgD1gXiR/4SQ9msdwVYn+93iLlYiPnlS0z2byEZv9v6XZkH3WtoFw
	 XzynJGnNnUButJ8tcjn+dBoTM33lSGq5ym9AaSoaGPZg6B23OomjjmKlf0CYFVag0SA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790321964;
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
	bh=3O8H29kjc2UOTan36A8dWSEkxvQr0ETXQPQboBIdOPI=;
	b=hY/ltFtsd7KWCJQ49Wl+26yJ8/p8c07d7famSp1msZ95yOfDdPQw+WkcvU/uo/R/zXbz
	 i5xf3zj0zex7feQqMmvfuSFb8poUDr/kyU05Z1Gx+mIIxawE3GBOqCHKMDYOZJI7lZDaE
	 GLoDsOc77WbqE5VbWRKNPVxKn7fWah1RchOtfQNW9G+8U/lMABODefBwhK9n6dpHyTPv+
	 Srh73jK5WGuCETSUeNuM3GrbXPEPoQ3z2tncAKdTWq/67Aov7CSZK4DR1PSraTNSHUPdY
	 42UcJVbIJmPJK2Qa2P0NeAbEzIu/365DwlEPioHQP3Qjo5TggdgDriwzsjotx8kS9SA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=coWd7L56;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790321964;
	bh=3O8H29kjc2UOTan36A8dWSEkxvQr0ETXQPQboBIdOPI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AWcaUONjJhzCCL13EgVhFcRVAw2ddBuW0Yq1M4XIlv1OtdqmyxoiDpsxKjms8Q8fq
	 mZr8XSNHHy7GfkA8aRe5ZB8Xu2xITUsepxT6Se97O81YrU9VRYWcdfZz6Bk+/VKmXv
	 XGJscuPTavdabHQv7MA6n/sN0ZW2YZuUm8JCW1Q0CFRGZbwqQ4fG+vbeNkXuto+RVq
	 inhFtj3uasD0WkG3b6d3uIeVZJz+JdHfRj4muHCDwz8R2YA4RSsxkNxm149Uc7iPc4
	 2Nt1ryYdi+0PSPqfLxTyBuoiHH9U3wuoUV+Tznweyfzn2dAWFOJF+8c5lwb+t+M/6V
	 Rnufbp/rudnyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50C78811F7;
	Fri, 25 Sep 2026 07:39:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A10A8194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 07:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E252811F6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 07:39:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NljHogCt0Lun for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 07:39:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6C1A0810BE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790321961;
 b=D51+0heJRQmXtVGV1vSpf6WZKughX6sDv7xv4Rn7i97qt/7MbyAjkDHFw83lbKNP33g7
 wOurB6e2e7S7T4nhjiNQhnTREs3+mevWUODPPNueoRARLTdex7cBkjvoMEaiJWArm9Hus
 i/YJJsefxy5STzk6q3w/wMejGIvJ+7BNNL6PgNEdCiz7512SAg8l+7r9jQrSLDgpLqLkg
 mqafaSXvI9wc97On9Klr+vWUU/7AQi7QbhY6O9zbRW/oQqGUox/zhN6yfyfuI532Ky07e
 57eV0PhstvbwNBQ2EgyudBJ1L2SbFG95evV4Dacg6h3xjbjkJ3FA1IHsuLesPVpjlUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790321961;
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
 bh=3O8H29kjc2UOTan36A8dWSEkxvQr0ETXQPQboBIdOPI=;
 b=rO+RzECVAC1+6YLyDspcOeQkrTHw4rEI5vrNdYKHmwu7zcLj1q+msb3ZFZmukAhlbtpq
 P5M6kqxDVaLriJMsVR2aT7G2RMlfhYPYWlYidijtQEBy9gn2aMluFFcoMEvsqs/bYdlcl
 s61MOzzZep0kpbp9pSuUYq8t7ezxR8m+7Ds5beyqNVYqPkuU71W0uGNwSGR/TZaXa4tCQ
 cNyrC16jDoWOrqp9jQQNGsNgY017FZB7pt3r3Q2nPxtmEKSqjXmokrhCNoIjhf/MduZHg
 123zQpNEk/oqOU5NrOK2vXxYeLukiKSFwspnYTDIx4OXneV1X2IHfypAZ6/pnP97u+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=coWd7L56; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=coWd7L56
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C1A0810BE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 07:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790321961; x=1821857961;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uM79f/pDUYtdvWm4jNsmM05mDQSyx5gpi33/t7SmGDI=;
 b=coWd7L569aOhjQZ4IERips6avb0bVZ6i3Zgq55TWQ03l5Wrbua4YWW22
 PWLqOTihMlQg5JSVejOW/66EVzqBg6mqS6D98L6QUIWfvGHDYw+QmeNXp
 wNW6Y5VubC5OYq/I8q5ulc9Lugm12IeBT1aBWmZiNpc9UfwHoVFOeDzx0
 JL4G1VWgZK2SKyS+tYe6366id+bzkRCxMZ/TCUcHW5cJ7QyGdv7sInS84
 LOiETTbJlEkuPB/6k7+7stXjSrmNzMRTLMZtP+nqH6Qh/ouZ0TcH1vVbi
 x+laJt6PTJiRcxyhk1OSRNep9HIOyPHZTKueBIc+NIqWI8YHq7WEtyjV7 g==;
X-CSE-ConnectionGUID: Hg3mud9oS+ep3C+n2/bSog==
X-CSE-MsgGUID: OA7DACawQTCs3FObEIYN2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90324571"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="90324571"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 00:39:20 -0700
X-CSE-ConnectionGUID: HxcLYqujQXCc1O0oqOsopQ==
X-CSE-MsgGUID: pNqe1uOxRR6rQA6R6nUnHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="278971065"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 00:39:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 00:39:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 00:39:18 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 00:39:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvnNcrWOMM7CZuc+zQThMr+ygQ8s9uTUZyTbnaco6u/XvogpmJYQ44dXI4aIMFtrxZjJsHiVDTDrokI+3egr5V6UKdwgp4rdk/quLXwdnEJ9xKc9AP56R/rl7YlZ3scq8ui+rX1YEL3a7IRYaR4Upr1jt5jV/EX/hhgG1Slfk0CqV+qjZooXPpq3bjV8jvEZgxnvGvzVu02UiPraEAKuYflnvJahX0SU/j/dsDVXOQUh/GLTfm335a8NMbbVUMzJVepqqjCD8KxvENk18mEnCalePzabzJS9dBn4L2Ix/wOo8TV4ongKEiZEMYy9fsjGbqGeRjg+aJ5QiTsOcxwEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O8H29kjc2UOTan36A8dWSEkxvQr0ETXQPQboBIdOPI=;
 b=b5EEcCzddqVYXDY+9CkfBtvSEMvyDQt2GSe9kokxvWkWFWQug1pr08uWH8qGLlgcWpDJfJScWrw/4a0+qwh8bo8yvoL/pnQIv5PXxxytN1Sm6/aEDZKJNLmkIQRGUO6bS3rxXWn+SoAgYgTEl6ocIYMmBwzluy5oxG1dvTG5NTdeWkIzMB71bEP28e865ddszzhEpAuIlob8IXa7g1xFdIKKZNXPhfZ/PV0IG9F7ryPN9xyM0GLHq1uRl1Hw44we8Q1I/0xgSM4wFBH9hQHumqmhHvcJ/8a4VWEMbrP6szNwKqNZ9pX7DHzbDoJlou/LXkB/1cBGzn75kLWjRh2RnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB6195.namprd11.prod.outlook.com (2603:10b6:208:3e9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 07:39:10 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 07:39:10 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ayush Yaduvanshi <ayush37735@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, Jori Koolstra
 <jkoolstra@xs4all.nl>, Brigham Campbell <me@brighamcampbell.com>,
 "linux-kernel-mentees@lists.linux.dev" <linux-kernel-mentees@lists.linux.dev>
Subject: RE: [PATCH net-next] idpf: fix kernel-doc parameter descriptions
Thread-Topic: [PATCH net-next] idpf: fix kernel-doc parameter descriptions
Thread-Index: AQHdTIW1MOCRwHDp9kCl+cM5DLKkn7be6L3g
Date: Fri, 25 Sep 2026 07:39:10 +0000
Message-ID: <IA3PR11MB8986B7E02A2340BF1AB09C10E5802@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925000244.72480-1-ayush37735@gmail.com>
In-Reply-To: <20260925000244.72480-1-ayush37735@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB6195:EE_
x-ms-office365-filtering-correlation-id: 99df9f91-3697-4451-82fb-08df1ad816d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Fo1DsjfRRJP8zLmvVvVU5TeASlQbwKDKQ/GIKF/rJfJOTAmur5NZkS34VPUNjBC+6YkekqxAJtRKySdnAPwEiy3ymc/90T+PpitlNNCyt0vCghXdrdMZpzW1EHbFB6hJ9Ag3/6zNe6tC0fX04CKeMU7GtYI/0uTAyhOZ8ldulgp6Z7S65P+Tm1RWEeU4i35rAps0k+4eS+XwxiBYEEsG6U64m9WqKm/9AV8KrBN8x2Z3nRLbRY/UfzLUcZwPYHaoFHfQmmqlyabnMcd6QljOn0UE2Wd66eimLKpvZGVXk3VeNWShNfVEPDUqRWBWDcjfAjaOnWQp2ptXlXwViwa9rSEHYQFnXWqQYK6fSAfTbZke/DVqe0uaCk4uHQRifYttSvunHq/oS3QqapGZfaP86fz0XfJBGMet4gZ9viN5aGlwFkDnvI+i3dqwCd6T9W906QGFLdn4vxxDhiLAhDSIwDdDBNgnBj8Ptl7qbvtuel4hmTEKmN9wpYKx0fO1uK/1pvDzTu5Ku8BnNU3H7P72JZxgMo0ChTPLQk5jesgKxkPHV6np/bwxj4/ikUMiE6Zjtti/4sq5sfUz5jsdzKIHPoJ22bKa8hYI6g9V9uuU5LDXW1j+KvB30mGOG1ny95GrwpHlxMIs8IgYm1qCT9RXKVlcEaSiBehY2r/hfUcPWcvCMTQx4wKaGtDHxlSsv7+xfu+nLRprDgbjmiUa+SbDV0xBa2IDZT/ja5L6r04/29U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ADJEVcrGizUYJck1DDOcxZfdT6hKVfHAddWnfhp6m/YavnByVW2+1Wr79uYc?=
 =?us-ascii?Q?m9RysSjnfXveUOoBYatv+5w78/AbhXYd5mtOB4dGfMw77Z4+JSD5xLa/lArz?=
 =?us-ascii?Q?SvJ/H5KGmh8mn273TOcPNfzDChq6QGO8HPR+RK2AmjoTr3L+cQZ7v22qs0b3?=
 =?us-ascii?Q?8j9PTv2ivIo3hZL/qWI+8omGr+BgYssAW9+pEqk2JNgTzO/a366fXjrHXmnS?=
 =?us-ascii?Q?tC4gOoGrW/JAMCFzS7I1wYNoWPie3w0JCrbBJlM/8fgW/2ngIoJi4Wj+Okw7?=
 =?us-ascii?Q?GFTR8/Ap7HU7WQXZkkXt2+UMfynoAaEZEjO2fl0v6JHDb2u2yF09VAsUJvVv?=
 =?us-ascii?Q?pSogRTjtlWuyXxE5czOyowC9/NO+9x5BgzaGLKHWCLOINY+zp1afqyaHMZXE?=
 =?us-ascii?Q?K9pbbP9aaAT4SdWnBSFC7tWz2Evca0Xm99m6q5u5sDlBfcWZMf2hbYpf9v3y?=
 =?us-ascii?Q?hqgSt7umfG2P9NvQsDaYi6baiLHmREOv1qTZFjA6pF4sc2npEhtu0uMgUK/i?=
 =?us-ascii?Q?0xW97KEHvMUtCaYQGhqRfwi4koFyLb+HmJ1+Ok1MdEtGT8u0rTT4RTN+Fx7H?=
 =?us-ascii?Q?6u9XQlhFUy0aM46yEz1Pg212EUWdZUPdLpownwgAdnB7LFUmhKXCgGzLVXr4?=
 =?us-ascii?Q?k5lJ+Re3V5yqOL/OvbGcTe/QvNocvmYrNoLdxpa50P2MAKp2hsIBgCTUJ/ln?=
 =?us-ascii?Q?wNkDuZsens9S9ubiX5JYqdsAfghAxfTna6t5HZokKtftEYeS9tvvmpxNj4UI?=
 =?us-ascii?Q?UzSxzbqzfDxFPjuHts2TgayNYy3ZdhEIxqvzbPZMo5Sik14AH0RFjo88AtPd?=
 =?us-ascii?Q?/0Fj26YxhUIOioCKRbTkVHfRXCTIE4Xe1AS42GSkf4ERtDJq5aW96fR5RLXU?=
 =?us-ascii?Q?Ktb2mujdWNNtMAIihl3HFWwpVaQ1DFmAuSCYljeuzjHvQnJ7711T4wLSlbd3?=
 =?us-ascii?Q?wA6o/MwipFQD+31aIT6Yrd56i747kbFSTicbX+Kc7qOkEm26AM8j7m3MEk4E?=
 =?us-ascii?Q?PMLRY34zZL8VWROyt9X6NsO+TuTYOt4wxmPyb2Qd4bnk1YJuue1cIoTizwdW?=
 =?us-ascii?Q?JCv7/e8gbl7oI2VznuvfRi6jpV52th0UyuCiNhqLe877t/Ftx1NMyVY75RQ7?=
 =?us-ascii?Q?SZI/U2puUB/i/F4xOXq5tRjtnC6TTUv4MAzkXZh6VHfUUdY/QS5OsjCHcYbL?=
 =?us-ascii?Q?yg2+kJFeC2NEGbuYarKoxG2ChBlGWJx5Klsdfcm6p+mdmH8RwzrSy0aICvfP?=
 =?us-ascii?Q?yUVEiB+4h/KRDNacSLgbTDxBMx9A1cV9fR4DGGRQcoonXlakQtXUtPpxZfHd?=
 =?us-ascii?Q?piDwAe9GDrYMNBnImvCbGi6t9QodEJchGhGM9t/bV0/IIRP/aj4Lr0b1Rdfv?=
 =?us-ascii?Q?Q/sAyHWt6imPLQHJePV5oauFFpF/QxzpzGTOGovQbWZDVc/Ax/LGQlusxDzv?=
 =?us-ascii?Q?jPRBl0isa2j5GCse8obyGpnn+HwczZp1+ILecQNzPp6Ng+E/Hni/2dwdmRFM?=
 =?us-ascii?Q?KYa9DY63UXYABq+RD+4JtKh5m74DtgK7w8NcMpcPm1VSCJaS9VJjZjzwR523?=
 =?us-ascii?Q?+8Dt0k8/71SNkQ4a6erqcXkr1O6QFz5oyfa6gzMmtLn8hSU1OQscYPGVSwpo?=
 =?us-ascii?Q?J6BvGcnm2x/f88fJhOFuO1lrBLxiLWr/wSpT5MegpD/t8d4RaRNKVqXnVqsw?=
 =?us-ascii?Q?t5ETOEOXxHJCTwLCIo8NnJkJMT3DY+yiPeWndJitW9/SkIloCjicfUKvPkp9?=
 =?us-ascii?Q?WidgB37+1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EV72SEI0utL4ft0iHE0brjtmvn90DofzB9HbWMmD06E5B/X+1XLG/XYAjvmEUU6RnBffUd12gerBVVPaFcQvrviTRMXMfT7lTMutzVQ4QHI08XTjgSzON3YByfcZvopVd0qKWCyXs9w71/DreW9+TbFrI98j/f+E/aApy3N/alNgjHVMGduXzhoUcmAisoj8wk9K+/G6TLCVX0eNjGAmIKHeOFxYEmseywMMTqIIrcJHuEJyX5I2E+RJpyww8pBQLS/91fURlS4+1UpFLMkULkbxNfz15pEqOjMvlDr86+L9+nOQEJCUZAA/KAxwEz2Dg+myJpIKE7RW9D94/iws8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99df9f91-3697-4451-82fb-08df1ad816d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 07:39:10.7859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKrhh5K42L05Q08HFJ8H7kAzt9ewZVyx2t7VhiycYflGWV29QH7fcs6IQSA/wsoyPlNOkwC7nimcttJZi+gnS7sgV1aEDckGnbp09QMEAnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6195
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
> From: Ayush Yaduvanshi <ayush37735@gmail.com>
> Sent: Friday, September 25, 2026 2:03 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Andrew Lunn <andrew+netdev@lunn.ch>; David S .
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> Shuah Khan <skhan@linuxfoundation.org>; Jori Koolstra
> <jkoolstra@xs4all.nl>; Brigham Campbell <me@brighamcampbell.com>;
> linux-kernel-mentees@lists.linux.dev; Ayush Yaduvanshi
> <ayush37735@gmail.com>
> Subject: [PATCH net-next] idpf: fix kernel-doc parameter descriptions
>=20
> Remove stale @vport parameter descriptions from
>=20
> idpf_rx_desc_rel_all() and idpf_vport_queue_grp_rel_all().
>=20
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 24b91be25676..6041c3faf7c4 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -487,7 +487,6 @@ static void idpf_rx_desc_rel_bufq(struct
> idpf_buf_queue *bufq,
>=20
>  /**
>   * idpf_rx_desc_rel_all - Free Rx Resources for All Queues
> - * @vport: virtual port structure
>   * @rsrc: pointer to queue and vector resources
>   *
>   * Free all rx queues resources
> @@ -1394,7 +1393,6 @@ static void idpf_rxq_group_rel(struct
> idpf_q_vec_rsrc *rsrc)
>=20
>  /**
>   * idpf_vport_queue_grp_rel_all - Release all queue groups
> - * @vport: vport to release queue groups for
>   * @rsrc: pointer to queue and vector resources
>   */
>  static void idpf_vport_queue_grp_rel_all(struct idpf_q_vec_rsrc
> *rsrc)
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

