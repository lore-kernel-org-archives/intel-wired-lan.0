Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A36DCA5FED
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 13:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAF3D80CD8;
	Tue,  6 Oct 2026 13:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XYIevMMn6zlA; Tue,  6 Oct 2026 13:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8ED5280C55
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791292317;
	b=sXi0J8Qg5iZFkOW4RQDA33vvSFvhu6cREy1vMsGnzxt39rcpSJtL3qPjFmHQdlofJEay
	 4jiwnFQEG64cVVlJorQFkLMjPoMyPXCNSn1cKEIxU+9fxYpBDouSTAjdDXsvVe4zcffKZ
	 onTjHAFq3SoVJHQMQBH/yXcs8YuxfzyLwoSp/+4iOdELFDMHLzKbReUmieiylygYZjdTS
	 4vap4yvl/L6o9h5Vat5m9bojpuoiTBNyvDkLaJkSYZxgFKM9AsajtvbEsKtaEiVhnhp9D
	 YRAuwsRWPOixubLHVY5uSne6Jx0IgPQHrdZcQdlZiaOISmYNsD6aOsrIBgH6XuTabeQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791292317;
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
	bh=jbK8iv2IyWCGexWzaosP1bXc87tHzUUWx48XRS2ZpjE=;
	b=W2P8ajaQNTYigtOukn4S5itQu8wrvc+u6Y1wQyGyD1RXJEaklVatpjXy1wfJuOs+qeB8
	 6H24yXxINNVR6K4fUoSOO7PylLXvtqWXWm8BbMxSUVexc2SpkvfS27CMLfnzy5VDILorG
	 eHNHuVeCAw9OtgSWDU7phgq1MdKJLYtWA4/9mIYAzyOP/Bd29q7Q4PQ15bI2Txym8NXz3
	 6UB3Y/O5yBm0lIgk8+ZxOv/d0x/Wf02mD+pAYH8T8LBRg9seHgUVx+lnpIctXsjq/Worz
	 MLRNvKdSWlt/XbHkm9ZboJCOG4FmulCs1OucRFxgLz0FVysA/5ooGk4R2nvAvzoxlrg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791292317;
	bh=jbK8iv2IyWCGexWzaosP1bXc87tHzUUWx48XRS2ZpjE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hgmc7exq4DVQw2Elki4pLgBEkjwO5yt6kHftyPD3n2RBZI8iZPn5rp1UwZapgSXZW
	 PPCZQ7P0XKxkPZvwQyqKtXvIvt30XaBw0YrnUYZH9P0rs6bFjhrNk4YurZv2UFSJyv
	 gkjF+OqKjUzXP6cu7FICiOpdIDYiQ22HIC9SBdMDpiX9CYt6gM4ZQ3TXZllZIAFEYc
	 8D189ewn8/tfKlO3reONozXY4qvvU1VhQ+IX7Byda77Y2jJRmZIDYfMcG1CPKQT2lD
	 OIRurBduEu3M6vya1C/kBVvfF7onCattmeZXwAFPk4qK3LJld259EhJfmwhrVj5Fyr
	 eLNICAvhdP7ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ED5280C55;
	Tue,  6 Oct 2026 13:11:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AD04D317
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 13:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E5A5405DA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 13:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vKrcT8NBrkZB for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 13:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7ED01405D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791291906;
 b=Ico81sLCArzwx8nEgBEG687S/ItGav+7E8BC1tKnCrwMFI0TpprP/c7O1NOUsSrAMjXO
 Hm5qETgYZBAAKRD5d9zMVA/66+3z+ZKYr9q6MKIbcoBCxmMMU+vjmDzQnT8Y0bpbx5Jz7
 P4QqiWUdiipxspJmaWXsSmEcmVf0a3Ty9H+gRGbaOsKErA9rMETU1mPbapkOWwWCROctP
 uXuvh7wRBxGDem32T7KelppEMIY2i5fPCRJI00SN+LJaWtX8dBPnqIJ/K8vjG2/NYXSvW
 PbR7vaPH9FT+1aH6PDpUg3915ct/qoOyp2hRWOmtYYb+eyQx8Kd+AO+yK2K7DUGfbXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791291906;
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
 bh=jbK8iv2IyWCGexWzaosP1bXc87tHzUUWx48XRS2ZpjE=;
 b=mv3/NbpbFKm0jilwVQb7VEWV0Y3KirLjZ0kVoAZqQXjzEfveTkrVEPvTbur5zd7enGRu
 ZlB1SmAi4D8RKGGpdoNB5OggmffuTFiM+s/EGFq3nByd7Qz94rWeh1esUkikuJbX6/AQq
 pY88MoE4uondAK/Tm/vpWttdxYQNHhfEH4whvxuZEBtqtEgX0ANBtQz7HcWtp9z/oL05z
 +qWY/XcrqZbU/0Ooi7ap14hklvDVPZe3jLbvSSRXeF0k6No89+Pdvio95CbMWzxDYTuhz
 vGsNzHleyYY7ePaqV908ITSQSm1Nxl3iaA89E1V1uFShIy4G9GBrMS1cHR2hRNHhWSQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XufehEFQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XufehEFQ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7ED01405D9
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 13:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791291907; x=1822827907;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jbK8iv2IyWCGexWzaosP1bXc87tHzUUWx48XRS2ZpjE=;
 b=XufehEFQZHeFAc9cK4zE5ytTxAy94M/KSb/Z/KxC0fPplr/NntlcBiC4
 NlbzjaF/AWWIC0F5N3W8N5m3E+s7rFGX+U3vYkH5HRHX8jwuZQmtevHvu
 7Hu1XsLwAIGJhEMAm20/7uXaLPhCAYROAoMbyVUTRvDAnkZD/utM6Ojyh
 PFwquJzZoDACyX3WbOiREuoFs8cvfJ4ZuX+0/Sy9NK5MfB06TAJhcMCvn
 3CjSyyCOq77cmO/FW+YcFDv5tYvaHxzaEQdoJ1d35vzDoWZ+BajBAUlxa
 Mq29XcI8wb3zJZP2pgMcsmW94AMSgCPfuz6ecuPvjOcSujYudckbFfnhe w==;
X-CSE-ConnectionGUID: YjWSUd/JRd6SqGmgNGtHNw==
X-CSE-MsgGUID: RP0E3waCSgupfMB6TLJLNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94851743"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="94851743"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 06:05:04 -0700
X-CSE-ConnectionGUID: L0zpTzQ8Tv+d5PuJ/Tx5Iw==
X-CSE-MsgGUID: SLbGXxtiTPG1WwBqMwhhrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="285047052"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 06:05:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 06:05:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 06:05:02 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 06:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZqiISsRdfNYyJlrCbkT3WUoBe7Ev/bl0wfacPVMHCjSCnTXkkWpCSYc8kpjCuKzLGWxzUrU/XhDC+PlLMDac2kNIUnS+2Sqkk7MOarxEsZ4PXFq0rjyRME3DfMk/PEpjSmGPVOaioh475g6PJDirvR9R6e5OkVc9pypyKC8G/dFU7PTSCo+OmcBzda95WVwtRx5573pFTR3xnHVf6QIjASeoBHpVxMUrrzGH+1qx5xCpySB2kGMWpiBuRXsGGjDbDMd45x9dw4tFBLAsBxdvfOg1PScko8PliSzxBrwEBwyMHdeOkcnek4Iza/qNVlDq011I61DJUMaIVUAiX1SFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbK8iv2IyWCGexWzaosP1bXc87tHzUUWx48XRS2ZpjE=;
 b=ZoH+Gc0/1x50xcMPaLQk3+MOULUngJc5gx7KlYaoegOr0ybySdBWEH5WvduGXxKIdSMdMtW7TaYceviSuXIw03gO2DsTphj/iIayL2EpO4nKCKAkF78HQT79qSOivDmMMv47ICTDibHjyXuBpQIwoIqUmDEz5ZCWExPT5ajReZGlsGYhJoVHvreoCZnn39ahc431VnIf+m9zZpjhox1GHopi/z0tAuhQ+jR916sdZQb5IdVz4sPULJo7oh4bea+0onMdERkc2DbAYPhzUp0IvknHzSJicTj6SuCye9zoADoPvlGdHy6B/AaYhO+8Hh0VGHZD3Vf/yS9vLBoaPKLrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 by MN7PR11MB736799.namprd11.prod.outlook.com (2603:10b6:208:5ee::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 13:04:54 +0000
Received: from MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b]) by MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 13:04:54 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH iwl-net v2] ice: Skip PTP timestamp processing during
 release
Thread-Topic: [PATCH iwl-net v2] ice: Skip PTP timestamp processing during
 release
Thread-Index: AQHdVX07GVn7V0QmHkmVzjwo8jBdlrbwVJyAgAAmEfA=
Date: Tue, 6 Oct 2026 13:04:54 +0000
Message-ID: <MW4PR11MB686485C8651A824D66C6872380952@MW4PR11MB6864.namprd11.prod.outlook.com>
References: <20261006095435.419128-1-sergey.temerkhanov@intel.com>
 <20261006104525.C3A791F00893@smtp.kernel.org>
In-Reply-To: <20261006104525.C3A791F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6864:EE_|MN7PR11MB736799:EE_
x-ms-office365-filtering-correlation-id: e3ba1533-bf4d-4ec1-5397-08df23aa6a34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|11063799006|4143699003|5023799004|56012099006|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: GT6nIitAlU+NKcWAX0IN7Z25zpNc7wz6kWHjCqbUN0cPQly7bcnzyTll4UKVxzfLehi2HF7/FJfTOJu5e8kxgy14JLxgH44tmwxXDWnjTozXbNaiHWTa0dXhHiFOP8zrO4X70yarOb1gRIt80g7QbCbP6PgkaxkwIQC7kzVJKHGd0plfOyUndVw0WP6ggVLp5iepuPct2Vz6JSr8OkXiQ2Wv6Sfam4E3qNDumgpGiQXcka1+PVosqEiQiI1TVov1MTxNEQfMDWE5dXqVvRMhGRpi3nUl8scwJ8h2hK+wEGhxHKzb0dkp1i2OylX2qV80utiPSokv6A+71KGPxJhaKlBGhI/aIiA97DOHwpX54HT/Czhcr9k1C2NERi3g2BgRcnk8GCvTxHRfkTxjmaUfE9K73uvTkR+FzE/nWUCqlvDqqVTdpvVkR6O7mLkQQS151oZpu4g/BaIbIEKIVnvK7ekLJdwLyTGpl+IGkB0nGdHqu8K/x7FxUwuNQStHvLuid2m65zSUIsMS7njYIQAYjVVB12GOsXfGzYQBpklgve8JFREsPz91PLdyBD3zfkVoKPl+nbc97BTDaXwZ6KBwbEOb93LiZm4VWXBn7Dg31czylbePuzTmbwxjzDW84h++wOIyJl2kvzrHE0JbV1kYgCwoMErhiv6iJ9VSeg/2E/U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6864.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(11063799006)(4143699003)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wis1dTRBRlVId1ViNm96dkppRmJBTjBHUHVRYndxVnBZSkUzK3JtY3pPT0lS?=
 =?utf-8?B?cXlFV3ZVMld5M0lQLzBMaXEwVzZWWnNUaEJobFExMVAyMm9CSTE0SEk4QmJJ?=
 =?utf-8?B?Y1FkTmVidmtqQ1lTMnc3dFpxUTRVcnEvUUptM0RKNFpRVWZGOXJRRHViK20r?=
 =?utf-8?B?RllrNlhzRWdhNmF2ekV6LzQzY2ZXbE41OXRhU2Yzbmt3Q05aaU9QcEM2V1RB?=
 =?utf-8?B?MUtodUhjNUd2ZWhLNUdvdTZZOGpiOGQwT05yN1JJNTI1VmxWaHN1dU5WMjc0?=
 =?utf-8?B?U1FyTkpmWTRQcmFYMmxCRkd6Q1lFVTJ0ZFM5MUU1QXlIMmxZZjBmWDFrWXBl?=
 =?utf-8?B?TytleDN4dWpFbC9RckpkQy9Ob0N2NmFYTGV4amRXKzMrOW9vUVhhUkZ0R1h5?=
 =?utf-8?B?aG1zcTNIMmdtcllaQksrWSswUkh4YzVIQlF3elVrZENoWVdmZmhJRjI2U29G?=
 =?utf-8?B?RDdITU5NVGIzY3lpSGU4QmM3N2dtNUZXR0orS3YzSnZTU2lZbHpzbGRHbWJD?=
 =?utf-8?B?QVNZb3BGVGtuS2swUWYrYWdBMWpYSnNBSTlGMmJtUjRSUDI3QmVSM0M3V21r?=
 =?utf-8?B?Z0dVUXhQdkdYWk5WYUFMaU1FWG5MZEJDRmhrWnJlQnJ4MVM4aFFPN1lzVlB0?=
 =?utf-8?B?dkRNMXBQMm5yMXBaWERiWFlxMkRCZWIwcGhiam95MGwwYjZHR0kxcmZwMCtT?=
 =?utf-8?B?a2QwODlXdTQ0U3VzdCtTNThta0x1V29DeFF1M1Rwdi9Gbm9YQW1rSld1Njg1?=
 =?utf-8?B?WEdZWVBYczlCSlZwMTBaamhKakt5aWFwb016VU03Yk1kamdGM0diU2hqSnMw?=
 =?utf-8?B?NWZCOGJGaDRNUUlwdFFLdGp6YW1aUWtHRlB6bFBZMTFLTG5nR0NZdUJad244?=
 =?utf-8?B?anlhS0lVQ1RYdlNKZjZxaDlQLzdrRGk5NE5tRlVvcDlKRkRvZFkyNWRMOUQ4?=
 =?utf-8?B?cVNhTlgzdkt1SDNEcndDc1RheW82VmNZZHdWZnd0SjVPUnZHQ2FTZXpOTklO?=
 =?utf-8?B?TStaOTMrS0QxdmxjeVNLQmNGTDZLNmFla1paUzVEWllnR1ppeERKdkxaU2xR?=
 =?utf-8?B?L3dLajZER0xHS0ZnT3ZYQ05NZGVqMXkrOUZKS0FjUnRXeXJVYmRQYk5zRGZi?=
 =?utf-8?B?SWNPUG9Ia3VsRUFXQk5sUHRXUnduRnh2SFpydlgzQmw5WDAxWXZIUS90SzJn?=
 =?utf-8?B?NDN2SmZhdFo0T0V3NVp4V1dRTzJnaGMzbVBBUlNiQkRZU2h1T2ZuRENVR3Nn?=
 =?utf-8?B?VFhIVmFrQ3Nhc2ttcVVjSDErNkZwZ0ZqQ1F4cW9KdEpwcXNyaEpnNmt1MWw0?=
 =?utf-8?B?WU5hd1l0OEdpVEtEQkJDUHNEOGlrYWpkWWtReTJhbFd0TTVyOEdIL2pFQk9G?=
 =?utf-8?B?Qjd5TlZxbHMrWlV3ZEp4YlJNYTMwUVMwRzIwN0hHWEp0QmNQQzZDK3ZHb215?=
 =?utf-8?B?dEFpK3dZc2ZPektLVEJ0NDQrSHdoZEI4L3BRMHNEV2pMdVRGd3JMeXZ3dUFI?=
 =?utf-8?B?eU1JN3FITWdadkNRYmRyeGtxQ0tZc0NsYWJuRHJXVXBNNVRHVG9PTFh2N1pO?=
 =?utf-8?B?SDZkNXJUZEY5Y2t6ZUxTNis1VDFBMVlzVSs4Q0dLbmlnNjU5WDVUbFFqa3VF?=
 =?utf-8?B?eTYwdFI5UmxmT0h4blFvUXlLQllyYjBVSmR3OHRVcnQ5eEc1MkRGQ1pxYWNN?=
 =?utf-8?B?ektrNzV3eHJweVRLQXpGZEJEOVJ4aG5IT010UFZHdC82dGZJWUwwc2JWdGoy?=
 =?utf-8?B?Q1RiRW9kVWJzZ1krRmhpa3N3YXpjTFJLVE9HSFlIeFJMaGQrdU5OVzAxUHk2?=
 =?utf-8?B?aGNMeUd5YWtVUlhSMWY4WTlDWWhYbjg5cjE5dnJualZ2bjUwaHlKVnRUQVpn?=
 =?utf-8?B?c0hibHo1Ujl6ZTRmbWV2UFh6WjdiaVBTbmFNSUw2ZVRQYmNJMlRaWDZXellB?=
 =?utf-8?B?MkJJeitLdm1ZU2ZjN3kyRXlEVkFxdllMQWMwWTl0d0FJZXN2S25SdnlBUlIw?=
 =?utf-8?B?QzBkVXZDWUdTWlJVeGZUUm1RZlUzWHQ2WnU0cEFhV1pLeUdDaUx5a3RVM0pN?=
 =?utf-8?B?eHNaMGozUFJDMm54UlRLcU52dUJ4SjVsbDYrS3FEMFV3dENob2NLMWZ3N25N?=
 =?utf-8?B?aUVUSllxaGJSMVIxeFM4TkliNnlxY1RDQ3hWRHBrczFGaXBWdmpudU9FS054?=
 =?utf-8?B?Q2xRekhWaXpBK3VGeGpmR1NvTllVS3FJdWhuVXh1RXpGSFJmdWV5RW1sam5V?=
 =?utf-8?B?UHppOEZBRlRKbWI0NnRTK3o3Y3ZzaVkxNUZ6NUF3QTY0ZmhZK2F1Um0zaUl3?=
 =?utf-8?B?SG1RVWJWRDFTS2g2STA1RWVRbEo1aTQxZkhiZVZqRDlUc3dDUUhMdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2GrrU4l3btBxQYN/hCc9RXZhi/f6no3dB45OGJ9A70K8VvIAsgdocfF8TidXII4MYmEJKaxA4J+7Fndd0W4C+F2VGIKAnkFmmLhLxF8JGOk3W3QCwkaeOgL+KTQJBmaWLawPW2nx7V3uqMi27pbPfLx6vFiGAXQA/T0aSeuKt2M1x1KPA22tTPFl3i5g+S22ok43K8szWgTQ8s0Bqx2OqDx2WkYClMeXpeKZ09UxJtbT+Dfm9rRi8G5ZKsdVoJu4896ZaWnsgPjx0cugC8o5dKoUyWkIs/RVY5lruQsbicUI7StB7i5SdV8hO1dR18OU6xA0dplI+yfUdzDvCgzK0w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6864.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ba1533-bf4d-4ec1-5397-08df23aa6a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 13:04:54.2580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GlffC25fAaVVZG2n1fDHlf0QQbS68wVTexUPig99PW+lYGwTOB60O06EVuzdB/fQHoxsbhd5lpvaOowMBRMmGEGI2fJPzQ6dlTPubozwuVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR11MB736799
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzYXNoaWtvLWJvdEBrZXJuZWwu
b3JnIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDYs
IDIwMjYgMTI6NDUgUE0NCj4gVG86IFRlbWVya2hhbm92LCBTZXJnZXkgPHNlcmdleS50ZW1lcmto
YW5vdkBpbnRlbC5jb20+DQo+IENjOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIGl3bC1uZXQgdjJdIGljZTogU2tpcCBQVFAgdGltZXN0YW1w
IHByb2Nlc3NpbmcgZHVyaW5nDQo+IHJlbGVhc2UNCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBj
b250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDEgcG90ZW50aWFsIGlzc3VlKHMp
DQo+IHRvIGNvbnNpZGVyOg0KPiAtIFtIaWdoXSBuZXQ6IGljZTogU0tCIG1lbW9yeSBsZWFrIGlu
IFBUUCBUeCB0cmFja2VyIHdoZW4gc3RhdGUgaXMgbm90IHJlYWR5DQo+IC0tDQo+IA0KPiBjb21t
aXQgMjBmZGI2MGEwZjgxZDBhNzg4MzJmMjQzODY0NzJkODYxM2I1MGFlYQ0KPiBBdXRob3I6IFNl
cmdleSBUZW1lcmtoYW5vdiA8c2VyZ2V5LnRlbWVya2hhbm92QGludGVsLmNvbT4NCj4gDQo+IGlj
ZTogU2tpcCBQVFAgdGltZXN0YW1wIHByb2Nlc3NpbmcgZHVyaW5nIHJlbGVhc2UNCj4gDQo+IFRo
aXMgY29tbWl0IGFkZHMgZWFybHkgcmV0dXJucyB0byB0aGUgUFRQIHRpbWVzdGFtcCBwcm9jZXNz
aW5nIHBhdGhzIHdoZW4NCj4gdGhlIFBUUCBzdGF0ZSBpcyBub3QgSUNFX1BUUF9SRUFEWS4gSXQg
aXMgaW50ZW5kZWQgdG8gcHJldmVudCBydW5uaW5nIGNhbGxiYWNrcw0KPiBvbiB1bnJlYWR5IGhh
cmR3YXJlIGFuZCBoaXR0aW5nIHVuaW5pdGlhbGl6ZWQgc3RydWN0dXJlcy4NCj4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gPiBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gPiBpbmRleCBiMmRl
NzYwNjVmNDZkLi5jMGMxMmUyOGUwOGZhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX3B0cC5jDQo+ID4gQEAgLTI4MTUsNiArMjgxNSw5IEBAIHM4IGljZV9w
dHBfcmVxdWVzdF90cyhzdHJ1Y3QgaWNlX3B0cF90eCAqdHgsDQo+ID4gc3RydWN0IHNrX2J1ZmYg
KnNrYikNCj4gPg0KPiA+ICB2b2lkIGljZV9wdHBfcHJvY2Vzc190cyhzdHJ1Y3QgaWNlX3BmICpw
ZikgIHsNCj4gPiArCWlmIChwZi0+cHRwLnN0YXRlICE9IElDRV9QVFBfUkVBRFkpDQo+ID4gKwkJ
cmV0dXJuOw0KPiA+ICsNCj4gDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gRG9lcyB0aGlzIGVhcmx5
IHJldHVybiBieXBhc3MgdGhlIDItc2Vjb25kIFNLQiB0aW1lb3V0IGNsZWFudXAgbG9naWMgaW4N
Cj4gaWNlX3B0cF9wcm9jZXNzX3R4X3RzdGFtcCgpPw0KPiANCj4gSWYgUFRQIGluaXRpYWxpemF0
aW9uIG9yIHJlYnVpbGQgZmFpbHMsIHNldHRpbmcgcGYtPnB0cC5zdGF0ZSB0byBJQ0VfUFRQX0VS
Uk9SIChvcg0KPiBhbnkgbm9uLVJFQURZIHN0YXRlKSwgYnV0IHRoZSBub3JtYWwgTklDIHJlYnVp
bGQgY29udGludWVzIGFuZCBzdWNjZWVkcw0KPiAobGlua191cCBiZWNvbWVzIHRydWUsIHR4LT5p
bml0IHJlbWFpbnMgdHJ1ZSksIHVzZXJzcGFjZSBjYW4gc3RpbGwgc2VuZCBwYWNrZXRzDQo+IHdp
dGggU09fVElNRVNUQU1QSU5HLg0KPiANCj4gSW4gdGhpcyBzY2VuYXJpbywgaWNlX3B0cF9yZXF1
ZXN0X3RzKCkgYWNjZXB0cyB0aGUgcGFja2V0cyBhbmQgcXVldWVzIHRoZSBTS0INCj4gaW4gdHgt
PnRzdGFtcHNbaWR4XS5za2IgYmVjYXVzZSBpY2VfcHRwX2lzX3R4X3RyYWNrZXJfdXAoKSBpZ25v
cmVzDQo+IHBmLT5wdHAuc3RhdGUuDQo+IA0KPiBTaW5jZSBpY2VfcHRwX3Byb2Nlc3NfdHMoKSBu
b3cgcmV0dXJucyBpbW1lZGlhdGVseSwgdGhlIHRpbWVvdXQgY2xlYW51cCBsb2dpYw0KPiBpbnNp
ZGUgaWNlX3B0cF9wcm9jZXNzX3R4X3RzdGFtcCgpIGlzIGJ5cGFzc2VkLiBXaWxsIHRoaXMgcGVy
bWFuZW50bHkgbGVhayB0aGUNCj4gcXVldWVkIFNLQnMgdW50aWwgdGhlIHRyYWNrZXIgZmlsbHMg
dXAgYW5kIGRyb3BzIG5ldyByZXF1ZXN0cz8NCg0KDQpUaGUgSUNFX1BUUF9FUlJPUiBzY2VuYXJp
byBpcyByZWFsLCBidXQgaXQgaXMgYSBwcm9kdWNlci1zaWRlIGdhcCB0aGF0DQpwcmVkYXRlcyB0
aGlzIGNvbW1pdCwgbm90IHNvbWV0aGluZyB0aGUgZWFybHkgcmV0dXJucyBpbnRyb2R1Y2UuIEFk
ZHJlc3NpbmcgaXQNCndoZXJlIGl0IGJlbG9uZ3MuDQoNCk9uICJ0aGUgZWFybHkgcmV0dXJuIGJ5
cGFzc2VzIHRoZSAyLXNlY29uZCB0aW1lb3V0IGNsZWFudXAiOg0KDQoxLiBJbiBJQ0VfUFRQX0VS
Uk9SIHRoYXQgY2xlYW51cCB3YXMgYWxyZWFkeSBub3QgcnVubmluZy4NCiAgIGljZV9wdHBfcGVy
aW9kaWNfd29yaygpIHN0YXJ0cyB3aXRoDQoNCiAgICBpZiAocGYtPnB0cC5zdGF0ZSAhPSBJQ0Vf
UFRQX1JFQURZKQ0KICAgICAgICByZXR1cm47DQoNCiAgIHdoaWNoIGlzIHVwc3RyZWFtIGFuZCBw
cmVkYXRlcyB0aGlzIHBhdGNoIChwcmVzZW50IGluIHY2LjE3KS4gVGhhdCB3b3JrZXIgaXMNCiAg
IHRoZSBvbmx5IGNhbGxlciBvZiBpY2VfcHRwX21heWJlX3RyaWdnZXJfdHhfaW50ZXJydXB0KCks
IGkuZS4gdGhlIG9ubHkNCiAgIHNvZnR3YXJlIG1lY2hhbmlzbSB0aGF0IGtpY2tzIFBGSU5UX09J
Q1JfVFNZTl9UWF9NIHdoZW4gdGhlIFBIWSBoYXMgc3RvcHBlZA0KICAgaW50ZXJydXB0aW5nLiBP
bmNlIHRoZSBzdGF0ZSBpcyBJQ0VfUFRQX0VSUk9SIHRoZSB3b3JrZXIgc3RvcHMgcmVzY2hlZHVs
aW5nDQogICBpdHNlbGYsIHNvIG5vdGhpbmcgZHJpdmVzIGljZV9wdHBfcHJvY2Vzc190eF90c3Rh
bXAoKSBhbnl3YXkuIFRoZSBlYXJseQ0KICAgcmV0dXJuIGlzIG5vdCB3aGF0IHN0b3BzIHRoZSBH
Qy4NCg0KMi4gRXZlbiBpZiBpdCByYW4sIGl0IGNvdWxkIG5vdCBwcm9kdWNlIHVzYWJsZSB0aW1l
c3RhbXBzLg0KICAgaWNlX3B0cF91cGRhdGVfY2FjaGVkX3BoY3RpbWUoKSBsaXZlcyBpbiB0aGF0
IHNhbWUgd29ya2VyLCBzbyBjYWNoZWRfcGhjX3RpbWUNCiAgIGdvZXMgc3RhbGUuIGljZV9wdHBf
ZXh0ZW5kXzQwYl90cygpIGRpc2NhcmRzIGFueXRoaW5nIG9uY2UgY2FjaGVkX3BoY19qaWZmaWVz
DQogICBpcyBvbGRlciB0aGFuIDIgcywgYW5kIGRpc2NhcmRzIHVuY29uZGl0aW9uYWxseSB3aGVu
IGNhY2hlZF9waGNfdGltZSBpcyAwLg0KICAgQW5kIGljZV9wdHBfcHJvY2Vzc190eF90c3RhbXAo
KSByZXR1cm5zIGVhcmx5IHdoZW4NCiAgIGljZV9nZXRfcGh5X3R4X3RzdGFtcF9yZWFkeSgpIGZh
aWxzIC0gdGhlIGxpa2VseSBvdXRjb21lIG9uIGEgUEYgd2hvc2UgUFRQDQogICByZWJ1aWxkIGp1
c3QgZmFpbGVkIC0gYW5kIG90aGVyd2lzZSBvbmx5IGNsZWFycyBpbl91c2UgZm9yIGluZGljZXMg
dGhlIFBIWQ0KICAgbWFya3MgcmVhZHkuIFNvIHRoZSBwcmUtcGF0Y2ggcGF0aCB3YXMgInRvdWNo
IGEgUEhZIHdlIGp1c3QgZmFpbGVkIHRvIGJyaW5nDQogICB1cCwgdGhlbiBkcm9wIGV2ZXJ5dGhp
bmciLCB3aGljaCBpcyBleGFjdGx5IHdoYXQgdGhlIEZpeGVzOiB0YWcgaXMgYWJvdXQuDQoNCjMu
IEl0IGlzIG5vdCBhbiB1bmJvdW5kZWQgbGVhay4NCiAgIFJldGVudGlvbiBpcyBjYXBwZWQgYXQg
dHgtPmxlbiBzbG90cyAoPD0gNjQgc2tiIHJlZnMpOyBiZXlvbmQgdGhhdA0KICAgaWNlX3B0cF9y
ZXF1ZXN0X3RzKCkgcmV0dXJucyAtMSBhbmQgaWNlX3RzdGFtcCgpIGNvdW50cyB0eF9od3RzdGFt
cF9za2lwcGVkLA0KICAgd2hpY2ggaXMgdGhlIGV4aXN0aW5nIGJhY2stcHJlc3N1cmUuIFRoZSBy
ZWZlcmVuY2VzIGFyZSByZWxlYXNlZCBieQ0KICAgaWNlX3B0cF9mbHVzaF9hbGxfdHhfdHJhY2tl
cigpIG9uIHRoZSBuZXh0IHN1Y2Nlc3NmdWwgcmVidWlsZCBhbmQgYnkNCiAgIGljZV9wdHBfcmVs
ZWFzZV90eF90cmFja2VyKCkgYXQgdW5sb2FkLg0KDQo0LiBUaGUgRTgzMCBodW5rIGlzIHRoZSBz
YW1lIGFuc3dlciwgYW5kIHJlbW92aW5nIGl0IHdvdWxkIHJlaW50cm9kdWNlIGENCiAgIGRpZmZl
cmVudCBwcm9ibGVtOiBpY2VfcHRwX3RzX2lycSgpIHJlLWFybXMgUEZJTlRfT0lDUiB3aGVuZXZl
cg0KICAgaWNlX3B0cF90eF90c3RhbXBzX3BlbmRpbmcocGYsIHRydWUpIGlzIHRydWUuIFdpdGhv
dXQgdGhlIHN0YXRlIGNoZWNrIHRoZQ0KICAgaGFyZCBJUlEgcmUtYXJtcyBpdHNlbGYgd2hpbGUg
bm90aGluZyBjb25zdW1lcyB0aGUgdGltZXN0YW1wcy4NCg0KV2hlcmUgdGhlIHJlcG9ydCBpcyBy
aWdodDogaWNlX3B0cF9pc190eF90cmFja2VyX3VwKCkgZG9lcyBub3QgbG9vayBhdA0KcGYtPnB0
cC5zdGF0ZSwgc28gYWZ0ZXIgYSBmYWlsZWQgcmVidWlsZCAobGlua191cCByZXN0b3JlZCBieSBp
Y2VfcmVidWlsZCgpLA0KdHgtPmluaXQgc3RpbGwgc2V0LCBjYWxpYnJhdGluZyBzdGlsbCBjbGVh
cikgbmV3IHJlcXVlc3RzIGFyZSBhY2NlcHRlZCBpbnRvIGENCnRyYWNrZXIgdGhhdCBub3RoaW5n
IHdpbGwgZHJhaW4uIFByZS1leGlzdGluZywgYnV0IHdvcnRoIGNsb3NpbmcuIFRoZSBmaXggaXMg
b24NCnRoZSBwcm9kdWNlciBzaWRlIHJhdGhlciB0aGFuIGtlZXBpbmcgYSBjb25zdW1lciBydW5u
aW5nIGFnYWluc3QgdW5yZWFkeSBIVzoNCg0KICAgIEBAIGljZV9wdHBfaXNfdHhfdHJhY2tlcl91
cChzdHJ1Y3QgaWNlX3B0cF90eCAqdHgpDQogICAgIAlsb2NrZGVwX2Fzc2VydF9oZWxkKCZ0eC0+
bG9jayk7DQogICAgIA0KICAgICsJLyogTm90aGluZyBkcmFpbnMgdGhlIHRyYWNrZXIgdW5sZXNz
IFBUUCBpcyBSRUFEWSwgc28gZG8gbm90IGxldCBuZXcNCiAgICArCSAqIHJlcXVlc3RzIGFjY3Vt
dWxhdGUgaW4gaXQuDQogICAgKwkgKi8NCiAgICArCWlmIChwdHBfcG9ydF90b19wZihwdHBfcG9y
dCktPnB0cC5zdGF0ZSAhPSBJQ0VfUFRQX1JFQURZKQ0KICAgICsJCXJldHVybiBmYWxzZTsNCiAg
ICArDQogICAgIAlyZXR1cm4gdHgtPmluaXQgJiYgIXR4LT5jYWxpYnJhdGluZyAmJiBSRUFEX09O
Q0UocHRwX3BvcnQtPmxpbmtfdXApOw0KDQogICAgQEAgaWNlX3B0cF9yZWJ1aWxkKHN0cnVjdCBp
Y2VfcGYgKnBmLCBlbnVtIGljZV9yZXNldF9yZXEgcmVzZXRfdHlwZSkNCiAgICAgZXJyOg0KICAg
ICAJcHRwLT5zdGF0ZSA9IElDRV9QVFBfRVJST1I7DQogICAgKwkvKiBUaW1lc3RhbXAgcHJvY2Vz
c2luZyBzdG9wcyBpbiB0aGlzIHN0YXRlLCBzbyByZXR1cm4gdGhlIHJlcXVlc3RzDQogICAgKwkg
KiB0aGF0IHdlcmUgb3V0c3RhbmRpbmcgd2hlbiB0aGUgcmVzZXQgc3RhcnRlZC4NCiAgICArCSAq
Lw0KICAgICsJaWNlX3B0cF9mbHVzaF90eF90cmFja2VyKHBmLCAmcHRwLT5wb3J0LnR4KTsNCiAg
ICAgCWRldl9lcnIoaWNlX3BmX3RvX2RldihwZiksICJQVFAgcmVzZXQgZmFpbGVkICVkXG4iLCBl
cnIpOw0KDQpUaGlzIGFsc28gbWFrZXMgSUNFX1BUUF9SRVNFVFRJTkcgYW5kIHRoZSBpY2VfcHRw
X3JlbGVhc2UoKSB3aW5kb3cgY29uc2lzdGVudDoNCnJlcXVlc3RzIGFyZSByZWZ1c2VkIGluc3Rl
YWQgb2YgYmVpbmcgcXVldWVkIGludG8gYSB0cmFja2VyIHRoYXQgaXMgYWJvdXQgdG8gYmUNCnRv
cm4gZG93bi4gV2lsbCBzZW5kIGFzIGEgc2VwYXJhdGUgcGF0Y2gsIHNpbmNlIGl0IGZpeGVzIGEg
ZGlmZmVyZW50IChvbGRlcikNCmlzc3VlIHRoYW4gdGhpcyBvbmUuDQoNCj4gDQo+ID4gIAlzd2l0
Y2ggKHBmLT5wdHAudHhfaW50ZXJydXB0X21vZGUpIHsNCj4gPiAgCWNhc2UgSUNFX1BUUF9UWF9J
TlRFUlJVUFRfTk9ORToNCj4gPiAgCQkvKiBUaGlzIGRldmljZSBoYXMgdGhlIGNsb2NrIG93bmVy
IGhhbmRsZSB0aW1lc3RhbXBzIGZvciBpdCAqLw0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPiBAQCAt
Mjk0NCw2ICsyOTQ3LDkgQEAgaXJxcmV0dXJuX3QgaWNlX3B0cF90c19pcnEoc3RydWN0IGljZV9w
ZiAqcGYpDQo+ID4gIAkJcmV0dXJuIElSUV9XQUtFX1RIUkVBRDsNCj4gPiAgCWNhc2UgSUNFX01B
Q19FODMwOg0KPiA+ICAJCS8qIEU4MzAgY2FuIHJlYWQgdGltZXN0YW1wcyBpbiB0aGUgdG9wIGhh
bGYgdXNpbmcgcmQzMigpICovDQo+ID4gKwkJaWYgKHBmLT5wdHAuc3RhdGUgIT0gSUNFX1BUUF9S
RUFEWSkNCj4gPiArCQkJcmV0dXJuIElSUV9IQU5ETEVEOw0KPiA+ICsNCj4gDQo+IFtTZXZlcml0
eTogSGlnaF0NCj4gU2ltaWxhcmx5IGZvciB0aGUgRTgzMCBJUlEgaGFuZGxlciwgZG9lcyB0aGlz
IGVhcmx5IHJldHVybiBieXBhc3MgdGhlIGNsZWFudXANCj4gbG9naWMgaW4gaWNlX3B0cF9wcm9j
ZXNzX3RzKCkgYW5kIGNhdXNlIHRoZSBzYW1lIFNLQiBtZW1vcnkgbGVhayB3aGVuIHRoZQ0KPiBQ
VFAgc3RhdGUgaXMgbm90IHJlYWR5Pw0KPiANCj4gPiAgCQlpY2VfcHRwX3Byb2Nlc3NfdHMocGYp
Ow0KPiA+DQo+ID4gIAkJaWYgKGljZV9wdHBfdHhfdHN0YW1wc19wZW5kaW5nKHBmLCB0cnVlKSkg
ew0KPiA+ICAJCQkvKiBQcm9jZXNzIG91dHN0YW5kaW5nIFR4IHRpbWVzdGFtcHMuIElmIHRoZXJl
DQo+IA0KPiAtLQ0KPiBTYXNoaWtvIEFJIHJldmlldyDCtw0KPiBodHRwczovL3Nhc2hpa28uZGV2
LyMvcGF0Y2hzZXQvMjAyNjEwMDYwOTU0MzUuNDE5MTI4LTEtDQo+IHNlcmdleS50ZW1lcmtoYW5v
dkBpbnRlbC5jb20/cGFydD0xDQo=
