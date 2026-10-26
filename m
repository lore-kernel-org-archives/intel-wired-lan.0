Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D84606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=wa7976Ls;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pz+f2BRL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99C3A40587;
	Mon, 26 Oct 2026 22:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zbpaHkcldq-k; Mon, 26 Oct 2026 22:09:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 08568405AC
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793052586;
	b=YTo4+1rF34PLsNRj+81E2Yc7UV4MR3bnN7ifPLBIWmG5CPCes67HOm3ie0G0XIgfNFb0
	 MYOm3CHDeBMj2Ob35QGQA/fhRaV7pq1rjRN4/DvKr4r5sdfbadJp1StJW2ZM9liaN1vjL
	 b2G3mg4RknP70e3VEnoUP0qDzTtIy5QwKS7VzWgNr3viyyqJAH5qAs7FaBineoUMO16pN
	 kP+Y+WoKcXzf4b55ztgs7lqrYyxBJxwYJTGcCfuDeaVe/nq2nUSOkgc/Qsm5qLlW9zKO1
	 p8gjRja3tRsTu2LNwvdZlLAhH8MWJDgGfcrcxAPHccJd8R29uXhqTZX5JgYo0gAJIuQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793052586;
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
	bh=mFemVjxEvxsWwvVLVQYM4eGxHqn9L1F2P7Bgn1qjZpk=;
	b=EffoyId5KCAesetiJGJQw3Byem7IgLeO+W0lwGpq0JeKHRcCgx8U9HEOGR33v3DzR7Ak
	 JtIGHnVTNauy2dfSx0/xrSUKQATTEl0Mv+8267M+5kBcplnf0jQLNa+eP+Im4SCirb7mP
	 k4jnEpIucQ42YN4G4cUz+RPyfsu9D19BSbEDzFRKM/cMIj6TR9TjZOFyn23jRLnBc45OU
	 F4IQx3gV66p9oJ5z5RQ1LHJGwBHiWepBw4a7MxDV/beMMYBxGYDQTfGHDlyhNF7f2DR1T
	 o6PaO5TD08RudLWjNk6sOvnW4pJQjTOzWPWkUXxSsrE8KbHywEARlIf4QMwNvsrVHQQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pz+f2BRL;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793052586;
	bh=mFemVjxEvxsWwvVLVQYM4eGxHqn9L1F2P7Bgn1qjZpk=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wa7976LslqklPWi1OcPPLh8p1G+r3Gazc+lfmNFv2J+26PCfPXUkBKt9qwnS7pn0f
	 w4LevT0058Bq7KbMrvBtQxI2NOVKQA/cSgaRDZ5uEo9qjsJ5hps9g5Lg94U8YJV2sk
	 Pq4zrOL9f52gxx3BdLsTh9iP2AmUOxQ9l9FYOvwSCP3jEBR3M+pCfA2F+g51LlMLwg
	 rytIoD03gjzgKS3CJ9NsKOm5RjB/V/6v2w77edSpDm/PPviBIpD4oKp+GjmDo/WEzX
	 /a2A4mpwZGXBlqXrk4I/mtdg27qpduR0HKIS5f2uLiT9SCiPIWquhPRTXysNDJeTIC
	 ROTHmNlynzAyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08568405AC;
	Mon, 26 Oct 2026 22:09:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 911F94BC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 76E8A40587
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:09:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GfiV3KAb7LuE for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 22:09:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A633B4057C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793052583;
 b=c7jeujJmxRwwEfMp65FfWktvMq2dzkc+JjngHBUmE2VPV+ZA7fB97rGfodrPyKU1pag4
 QcDWQnmuu09GOA2tI60cuM2yKCbG8KCqNv59P6z+z45/86apQeTqTxVafqcZL8Rl4+ER8
 HQg6vxCLiMTXnD5CQEasLGArnhNyqC4rf6vS0QTvd4Gtk9hALrAsk/zY1D2KyNNWBMF2f
 bcIH+mrckVNvw9lzBE5nD/u76rjx9Ej1gZcWrTe7XHSVw9czt4VvEyWYE2v43WYH08Xyt
 qj0wpB383WIJ4lPiWn8Y1DKAKlRYwbh3XEc/ZeI0FZBnKE6hWgsmSZPukYU8FZkzjtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793052583;
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
 bh=mFemVjxEvxsWwvVLVQYM4eGxHqn9L1F2P7Bgn1qjZpk=;
 b=U94juI6vm7HiroIrF877vV43JGBm7O3ImtpM/Do/tNZoAuQ8LnpCEzVmqvKcJiCt2ajl
 FLxCF2xX8BqUuyy49JHVhyWxtP5K1gL4Qt/NgiWmpKtdp3bkhNS3szYyOdIcrqEU15rIX
 fhKo9AqF97e0S/m59BT2Vclw5zGadmJ0SzScHUpwej0R1Fsvbg4KPIAtlUeUygUjtLjcf
 2UznsnBGm15uuzWQYMyeFQkwC33XiEFJYsEJALY+P7qUFFtIia07mJMa/X3DzK9Cr0DON
 z713iIzHUVgjQ57iFAqb0GpatORNEEASmwzBt3bN1FWLZOS94TdK2udqQsW3SEG6how==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Pz+f2BRL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Pz+f2BRL
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A633B4057C
 for <intel-wired-lan@osuosl.org>; Mon, 26 Oct 2026 22:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793052584; x=1824588584;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=NSjuVFPgPzedaYXFeO4Qf8kTyr8pz3lojl376SZ2CjY=;
 b=Pz+f2BRL7YftHeZpOJ6PqLmePMuoGtm0Jvy0bHC4nSTho7tHLBQTK7VQ
 FcnQAZnKPRwJhpxbhcNX4KJ4f0mVb4nvlckbvCxNz6oNAZxgxqpmUE3aG
 DHpStBQ0DD3B+XtZri04mamyJkDLUaw/sYkdIeICTPW/u5J7ZB3BI8JrB
 0Kxq1GRn3zfd07rTcEfY3Us8LNe6PwFxv/2qH79reuf4dQsSedMQxoCxD
 s1euTwTn623z4671ETx/5HvS30qsyeorJzKiBI1XZBfrmgp+hGxMLI489
 T7v6pxIYQmDwvoVeD0ChwFTec62OlXvpcS0oPddwVNs1wwP95HsUg9Xpi g==;
X-CSE-ConnectionGUID: VJnDQd5eTj+Hnh9BT+xJ+w==
X-CSE-MsgGUID: n+2eVteNQz+PSIJuZYgiTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1614134"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1614134"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:09:43 -0700
X-CSE-ConnectionGUID: 5IQKSCAuSwS9GYww1LBVuA==
X-CSE-MsgGUID: BCcIAQmRRj+v7wSjPfdVXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4336729"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:09:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:09:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 15:09:42 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:09:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrFlSAF5nXPS3nw7+WsAaMvPKezK+3aasAnwh4ha3kIGnjPDVlucSSLnj0zc/pdpg9lEI0ML3tAV9SX7sMiy/iCQ/hhM/hzCh+t+Chx3vrjEXkBPjCveaHxg8EHtSbEyjob81B594ay41FZdaaV6KsTVSdezAy08F3i8x6YGJ7WNvhw2aNfVG+eKWM6AApH1NqDk+5KPf4d+a4Ncu6CuvJZxpcGggsMUPtYOs/y/8pN91j+71b/IhAuzCrzKF6VZK/oF+jexXn87p08Pa5IiUeJloEDpVhxjySmiFwzsw77rgwbdm6//dYWNUeJ84+ARbAzhIPuSaYUy0rn8S3Whqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFemVjxEvxsWwvVLVQYM4eGxHqn9L1F2P7Bgn1qjZpk=;
 b=JzbmVIvUEGpKP366YiEmNvl/dNOF05lP2B3e/LcX1i67+YF10Zko2kgaKuR8lyo7fZwVJskZ3hE/LdG6Mn93YjK5xGK3L/9m9gWPs6jU9245RAarEm9AQb7ynuJ80WXqJhxXuU0y2KyNCS/aeQYBgNFuS/3NcTrcUMElL6nuMivhzvr+TozusXxzxeOypeUJLwouYiYLVZRqvhjwX014MTqxMJ1+KwfTOjxFts2oHMEVHS71wTCdXMT9VgIvcXVqjjyDNxLR4oXmSkoTO9DdDRWTU6hG/aqCqEKHppVvXgffVyyx1Xsx0W+qu0+/CBgGlDesHFFSUpdMBtYQCXl0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by MN0PR11MB6184.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 22:09:39 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 22:09:37 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Sasha Neftin <sashaneftin@gmail.com>, "intel-wired-lan@osuosl.org"
 <intel-wired-lan@osuosl.org>
Subject: RE: [iwl-next, v1] igc: remove redundant headers include from
 igc_tsn.c
Thread-Topic: [iwl-next, v1] igc: remove redundant headers include from
 igc_tsn.c
Thread-Index: AQHdY9QlyUZMVEVVt0K29lMLA5ofwrcQZanA
Date: Mon, 26 Oct 2026 22:09:37 +0000
Message-ID: <CH3PR11MB566895B304FA8D9E17260964B0E5612@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261024162405.133786-1-sashaneftin@gmail.com>
In-Reply-To: <20261024162405.133786-1-sashaneftin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|MN0PR11MB6184:EE_
x-ms-office365-filtering-correlation-id: f92478e9-9512-44d4-24c8-08df33add370
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|11063799006|261021121427099003|261022075727099003|10067099003|261021123027099003|261009223027099003|261022113327099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info: QwyOcWGeFORaM3DvMQPEinFpQpv/8ygfV8sTbLvhz6ICMVLQOWjYw9IEouyBlx/vtmknZJZoyGwVEn8+WMDd+WiS1+L8+DsBj+CV2T/mH8lZ9QrMr8TfZIoCyfbSkZRlQWMakzAVNvbx3RCs1thbtT/CMT49rpGg8gHj+ATHhExmVC3l5z5oxgP43awu/AskPzaRG9NGpec6jiFcndiWsllaJPQ+2jocrGaE/kSOwjDrN+Ch5/3sI5zBN4YdgQy8PtDfQfVDrK88LhJguDrxPBefF0ye5AucXhgs64FkG/87x8yiL1ZbM8XlsTp+gVTD4iQkFijlMVW+LZq7j5NkF2HICMUiZqKZdQEpqaWhPzb7obi9AknMWcjjBm5cx5xYgDj/bym1Z7BV7xFrAPQNpsrrHQOw+SwKNthq/n3nAh/uT33oi2/SfKFhAjVGOccp6m/j53KuB0I4Nt9FhslUaHEdy0PISz6LQDUsDLC4PIO/rjakonZm4abF/TFA1cZeW+S9oQv5VD/DdbAF5qVeicEVyFI9hRu8xWiWJ/wPCIq5lT38jcOH37hICCdBsgPobeXFmPFR6qy1HFFPIF1ojQCvMSnp5mKDWz9rPFRmkoKNz4Wz1cDVYPG1UN/5svPqyw7Yem4Fren2y4U4RX0y4GL6RTkckQCG+5tsbwhH+A5hpLsk8GUSqETkWng1besw2TDrV1EABsqXbqnJE0a0Nw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(10067099003)(261021123027099003)(261009223027099003)(261022113327099003)(261026121527099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OXCOXrz+bYF9vlP/JcR/HUmkJxmoG7KQKCkB7wqmaerNRMnnM3MA8xOMINlV?=
 =?us-ascii?Q?STbF8IGqj4Kfe2hmHM6Tab6PynOl7CRKVJ2cp73+ydF4gJ4OdDefzL/vnWpS?=
 =?us-ascii?Q?s9w75fivKue0ycKYw6aFPWeKPB7SGbiQ9D2beG+hk5LhTfXbFsC6gQ9zivfV?=
 =?us-ascii?Q?cqpFa9T1/pYN4P/QGxFlmV+6yR9gU+o/srDHCMdfnV8S663p/j40wqd6jOPr?=
 =?us-ascii?Q?Dhx4Kn0If4uvA7rB9PYi8EAw3riI83mlxtUggPlkNgZtqhHBPkI4d2BMmYcq?=
 =?us-ascii?Q?P79FfMD9O2skODjiWBEsxp8CvEkItWg+yjKURegg5P1KYCJ+EQli0UaNdeD9?=
 =?us-ascii?Q?q5Or2UroSp8MHg8xLIvV/UUetZtpTEr2eBxxJuBbjxD8wCFgg+qOUiTrYJDz?=
 =?us-ascii?Q?vCwwHkdQXxmvUxYSwE9aPMmIC116swYrodpDU8ymF6Wu1rIRFUqWQcpd3pg/?=
 =?us-ascii?Q?x7HeY6tqN9O3I2g/s/2o+193zQxz4VzzjwwyDuUphILhysf0m+ZF6gkUv84d?=
 =?us-ascii?Q?9dDFhIQ82Q8In4Q8kDv3J6HZqSQ1QPBQqj+mRe7D2CkSAbPvbrGhtwKUhxAs?=
 =?us-ascii?Q?c/jVYNf1l/ieRvTtKTa6Xb7tZP7bu8p7d4aiblHeT27jNN+3JoQOb4XGEIWc?=
 =?us-ascii?Q?78mVgtj0OalMCs0/ciG5XntAETQMXAfQkLg/mIIGlTmYOt3AxkTMNp+qym+6?=
 =?us-ascii?Q?/XzbHcV4X+ns7bevp9Ion7RgHIMDcAW/gtYyDjkPAEE3jV+H1uiy9+qaRJ+2?=
 =?us-ascii?Q?gy6WoBDlutSWh3A9N1/dMjnkxA55lmjrlc+R4t5jlP50YLiPLA2wrNW3WgFd?=
 =?us-ascii?Q?mdx2e9p7Ovh6LmjZlNE0SlNnKYSs9CsAiZgYeNOSj6xzgFYnrvWyyVjS/bCu?=
 =?us-ascii?Q?fS3pR6E5QkwUT1HXRSqMHCKMwUbojiFsZPrXUGbCo65/MnHEwSqvY56cRrfg?=
 =?us-ascii?Q?+EupfMhFzJgLJYquMpIP4wM2GN6AyGUfwf8YGAVi2GjqKKboVtUMvkxVc74G?=
 =?us-ascii?Q?6N6CXA0RUz4vs3AzoORd2BWM9c+KvDKOSU40nOoqnHvBA77f+2fUROCRQiBi?=
 =?us-ascii?Q?iu7xb8wOIgd9fyvD4hgmpMIJv8BGLvBDjDM2Y3GF34F3Qqa17IQUAibf81+U?=
 =?us-ascii?Q?a5eI2Ql0nEFeeRnBqIdYwjWhFuDaaOLmt+rqYYslLGaXMYaLadVlkH8qr4YC?=
 =?us-ascii?Q?teFOHVaDnMH1TjmXdaYM+coqu57mvEtu0Bf/TUp9Z512LFTnYnSzE3fq5rOR?=
 =?us-ascii?Q?eJJpjL/7Z/UN150kdM20fUSxWSF852M06OHdL2YQXu1g+J96wEUoIecfXiSD?=
 =?us-ascii?Q?cr9+q8CYifF2bDTcc8Ck2hDp4pOxDhSb/ty8V2fyKgkrFmRds23tZL0DCH0/?=
 =?us-ascii?Q?InK85HOGM1mh1NDcsoG4sdj0ODyR85Ke1bhMUvyH7RxBcymamPmNaQVszkqi?=
 =?us-ascii?Q?H8CvgufL9adwby37pc+RE1nccdq2WfHzxnyERfajWQW3Lrf+mBA+zi8w5Gn6?=
 =?us-ascii?Q?GMs6TWfliI4q8r2y9MMBCPGLvH8udE2KAlJWPrslzdbraRPjKZcCxGr17vzZ?=
 =?us-ascii?Q?Kgp+OoST6aAi5ouMyFhx2xd5pP/XLzOWQVdMNnq4BaD3OPMxtF2uif9I+IXe?=
 =?us-ascii?Q?dlR6tqTKueJnngBajuesOt2ZMd7gig7XglXFZ4vLcKLY6ugnF/YPho+spoh9?=
 =?us-ascii?Q?n5N1HUcprNcEoPoD7qRv6RsVTlcyA1YHMSx0fAQp+XNlM/wwUA3ciMngc9Pp?=
 =?us-ascii?Q?jtklYzXMMpjCkTc4YjJSAyC8eZJREGc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uZyTcXeeUnpXAl8Y0hfSBqS5cFWjVhnrQStW2oeTuF7Mazpt1fFoBFfqCD6zaXV3LhjH20woxxizjEGmtMBLw/S9a3DOS8iSDOkIdhIXldIOFqiHFWcWXkDlLkZRVLcwTqM3wBIF85wl1rtDWhPpPM/h3rYch6wXSp6CkoojSDnhO7wK9pDfOOJ+ERImSYIBBjO9YjrndDTf86L2Y3S3D2swtDVsizkV7DDDHjjyCV5ob0pkJFhFQZCfbHfnwtotxTnb6ZYznvCkb4aUY5DVoiTXBR2R0777ng6t9Bk9mbOfaha1ZP9/y1vO1DKWbh2/pJ2JzWBU8w3Knx8xy8exAw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92478e9-9512-44d4-24c8-08df33add370
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 22:09:37.9480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FdeEsAxPhi/JVVKuMYu01X5oKQ2+5HOn+IHJ03D5huYmdj3kLYls83EOcFYVOF+qxVmcXvSDoLiaz5wpDpafyZk2BKLUFKGagdDzhj/YUAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Sasha Neftin <sashaneftin@gmail.com>
> Sent: Saturday, October 24, 2026 6:24 PM
> To: intel-wired-lan@osuosl.org
> Subject: [iwl-next, v1] igc: remove redundant headers include from
> igc_tsn.c
>=20
> igc.h already includes igc_hw.h and igc_hw.h already includes
> igc_base.h, so the explicit include in igc_tsn.c is redundant. Drop it.
>=20
> Also, fix a minor typo in the #endif comment in igc_tsn.h.
>=20
> No functional change.
>=20
> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_tsn.c | 2 --
> drivers/net/ethernet/intel/igc/igc_tsn.h | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c
> b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index d23a45a34fa3..868334e9e396 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -2,8 +2,6 @@
>  /* Copyright (c)  2019 Intel Corporation */
>=20
>  #include "igc.h"
> -#include "igc_base.h"
> -#include "igc_hw.h"
>  #include "igc_tsn.h"
>=20
>  #define MIN_MULTPLIER_TX_MIN_FRAG	0
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h
> b/drivers/net/ethernet/intel/igc/igc_tsn.h
> index e08f48543d99..caca3720525e 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.h
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
> @@ -67,4 +67,4 @@ static inline bool igc_fpe_transmitted_smd_v(union
> igc_adv_tx_desc *tx_desc)
>  	return smd =3D=3D SMD_V;
>  }
>=20
> -#endif /* _IGC_BASE_H */
> +#endif /* _IGC_TSN_H */
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
