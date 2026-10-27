Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F4606A324
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=IoJqgxGv;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AxgKjiJo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1662605E5;
	Tue, 27 Oct 2026 20:44:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mOVqqLT5mcqM; Tue, 27 Oct 2026 20:44:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F29B60687
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793133891;
	b=QvFcW0hIa87WG11cnMkrWyKp+4jTJGXrqeKWyMCu+05IaDtu+f1KucPMjYc4rAwHRcoY
	 0NtaVTGPlnua+hXw69cpdLJI5GdjBIjeLdEcovxPrKzzFBaK4+fjsNFdixECv/Os7VbUt
	 rz5GjX2ESr2/KkRzWOHwA5b0Ir+bCJpRDIDHb5bMHWg7N7QzQYd3qa6wa+wTEli/7UNVO
	 pD+QR0W3tmnjiaNuSYVodXlir3IKE8cyhVeJatFP/htBFnU78UxvhdHmqF+PD/8gVrlW7
	 XHuWPcdXXzc4AXjpSTZdLHR9LYzpjEyL0vq5lrmtksF7HC8bDqnajZXzi1g+b/tAKfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793133891;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3AZ8+gLzbsPX4q2LlGdzWpB9hV3tlL03rNnx8LlvXUc=;
	b=igZCpdhKe0eV4KfyDRjtTdRhFjuOeRABUQ5Xl+9+O1jFJ0jVpe3sWCOJdc0qIJlyrDW2
	 z5gkeS60OQjsjwbXH7XaUQuxnixMuWR83WC00FreBJHurCrctKBi9hgTyDpAGtEikt0NJ
	 EHTJZ+SVD4mgvOE1n4Pjg5HPxv9tHVkPf3W2NqZcDqmP3/QdfloeoV+o9hRrz4Bm72d6e
	 vogbvHAQRqhNDKs9ArStPpU/asgiP7wJbqbPrpzSOJO/3tcz0ju02STDYKUD4tgsu04nH
	 aLKCDKWuAd2KoE1HyptWHS2nsZZHfdY0m6mz/G0I2dJjMdt4lIQRetY+6ke0AllYd/w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793133891;
	bh=3AZ8+gLzbsPX4q2LlGdzWpB9hV3tlL03rNnx8LlvXUc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IoJqgxGvRoVuFSVWhBVIY1ijnkLxOB3oBpJCTt/etBXheI6uQm2J+Hgorc4fo+zyE
	 a3ob11ASFP7BSEw3KaqTZPU5SkkzVv88YG49+t9+TeghcqYMtQswbmn852UAZTxFlD
	 AjG+r5ts58gNCPLXBAKNF2AOh5088BCJTViQdL5NaK5LPhY6HRJ/+uP6k/BvG3CZS2
	 jwpp2ZIfWfv4XglwuWo4ZehJgNP9JPJl/Xi6izGLz4awE/dpIHWEnWgBLRDz9l8J5T
	 jwtV/ufCJz2fhIhEkYH71UmnKao872SCKlkxO6pcviuvy8PHOpeYKq6EWsLhf8iPVt
	 V9lhs48qMVOxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F29B60687;
	Tue, 27 Oct 2026 20:44:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AD70B279
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 20:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9EE7B80D9E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 20:44:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-Nc_Ngheu2R for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 20:44:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 78DA680D98
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793133888;
 b=F+f24f/LW8UxX0f1h92eov8FqFoIl/3+GP00gd5zz4R2k1vvpjeU3bPcK2evjNf+YhUN
 Qq9mZF9a7CWUuMKmv57XRW+tAtXEh1v/VBM4dDlmskGF8D0grHyt9nGXccc5gpKZFTr1I
 yXX/kP2zUnwWXidAz2nki1Olg+UDPq6IHfdFepYFmwy/mqC+WldMc/3yVscu54pqwyfpS
 sq26o3Wh7vnoyJvio+FwfCbx4Y7xDAUu0Wa7SrgYvc+rkNAMZq37UuwvpICE7aSZh63qe
 uzD4eTnB3KvrWhnRov6nlFdIt38JfNegr69dKalmydcmy6gikMM9qxb4HP4EJXsnXAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793133888;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=3AZ8+gLzbsPX4q2LlGdzWpB9hV3tlL03rNnx8LlvXUc=;
 b=Ly1+rjRYogQb+f5f9mhej+8A4y25pR3BtAyvJvvhSa9kGBgKu5P2drTHFevkQHvm8Di8
 v3OLfrcDggyOJBMMt+OPQSPaCWYxp7VzkF+dwQ6S6M6SQDbV0+Ivzn0oLOotDPcVuKy4f
 CxapNBTlsRzdTz/XixarnXIxN7PCt7yp0E4RGWF8XkHsmDvqtoI/AbNnS8QZOyX4YdrzB
 OryJpuziaTgc6W4ynqF/8KpScX/GP+UT29xy55ODd3C0EHCX2+12Nag116K4MSBoR395a
 jaaXvOs88yv+UPWIyows2+Tg4+A5m22uSNRpUa/KgDVDnIgeQMsqupVC/sBTGd7av9w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AxgKjiJo; 
 arc=fail smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AxgKjiJo
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78DA680D98
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793133888; x=1824669888;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=axT1923tYYIwV60uzbG4iPf13rz6WPN9ZxBpNew5RPE=;
 b=AxgKjiJoG6j27M5rRr0l6W3Qpy9KlfK6SYptXw7IH+cVvZmp0yYBWcqA
 CvOdi3pZJPFBF/nJ4RpdNUMOOsDfLHTxVVfP2EZ/3GuKOLE4NPWOjOW9z
 vPa71O5w0PHjUVQM+e3ZRbfIl1P8IgxWeo6OYcdXTJZS1hIGrs5wKzSMx
 eHuUnMGnKUoB3u4CL8n6OZhF0YWh70rYF32R4UtS5Vobu0geWJvnS0xMJ
 vvrKh0RjFyCksSHyBnrH8n/TfWkjenb9s5FD1cOfAP8MxTCBAnNLr1za6
 4xnom38VFtv473GGTyMLdY6k7qNbNwilyZhpLfoDPWBVCUZTkWBV/evuz g==;
X-CSE-ConnectionGUID: rDWpxdlER8S361IaJ11N1A==
X-CSE-MsgGUID: eHFcRcorQjeTzhsCFO4JjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1734439"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1734439"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 13:44:47 -0700
X-CSE-ConnectionGUID: rJ9WQHNpQNaqa9Wk3jsmoQ==
X-CSE-MsgGUID: Pnwm47mTS0OEKPCvLVB5Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4590639"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 13:44:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 13:44:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 13:44:46 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 13:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEU7Pw8Y1ThGlq0MuC3aglx2kNuR6vPQddzdBXWu8uvtY9Rq+ao/wEvDWTzUELj/+bpNi+EwWOgocY0e/7RdZf5m7a+XUfSlcqXJTioOdA89K0LoiDeAG7bVIvafptjIp0MjOfmzzyWMiBQaVB1B5ZfRJRShpsrK7hPd416SAbvqCrZTkfGHnIyCdVCVVvTaAgPNqiy0VfL0RQ3OcAqTCPvY5BshURVsyp+Qt9m3ndI1qsHB+WsccTlHN9x3krBqVGeAk5E7XWh878hEF+Vdh3IsqYD/Ilmg5hITmqyoR0pWhyL5pSeungMFu2cbWgHgmdcnS9ptxGtUcVzXqNd4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AZ8+gLzbsPX4q2LlGdzWpB9hV3tlL03rNnx8LlvXUc=;
 b=QKF3+FMl6DQVoO+a2qFraeWTwwdPV7LQyz3hhy9khTLCh/wpmcaS3ch8rO4DZ1JXjPA3iouhGsVcsqy1kAy91G1WboG6YkXoo6FGkQqyhECQ7uuOMIjkXzTvZX090Qwh+mSeC0sk8a+K+MRluyz5DsCIIigiBE4Ch7W92a8GnN8+tAZ9KhWi6M4267r2IehztHSdM7qhBwSqn6fEAmaRJOX+WxyZMzZAXWeNA7ndlEn/vbT/0S95QpAmS35+Iir3hgLkwUXG4gsN8gHVQCHDy1cOC7xTaaaPclw5YzdIsMhOOKx+CAeKf8eG8emhknFqDsYEhSLefhSs+nEgvjTbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA2PR11MB4780.namprd11.prod.outlook.com (2603:10b6:806:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Tue, 27 Oct
 2026 20:44:43 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:44:43 +0000
Message-ID: <d11a602b-2704-4b8a-9a3b-a2713a0f8bf4@intel.com>
Date: Tue, 27 Oct 2026 13:44:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] igc: pad preemptible packets before reserving TX
 timestamps
To: Paul Moses <p@1g4.org>, <netdev-bot+sashiko@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <aleksandr.loktionov@intel.com>,
 <chwee.lin.choong@intel.com>, <faizal.abdul.rahim@linux.intel.com>,
 <horms@kernel.org>, <vinicius.gomes@intel.com>, <sasha.neftin@intel.com>,
 <matthew.vick@intel.com>, <aduyck@mirantis.com>
References: <20261026091549.605810-1-p@1g4.org>
 <179310342759.3134.9480442291648763504@kernel.org>
 <A-quLtOuGUuzG62X2MBCsGRnqwsSRJWaFG20X4lGiqSibD0d8k6Sb9sJzSzWWmNfpifuBH1NP-3XQosT8qRxL6HsdS-bLkKDsM5qa-xKvHQ=@1g4.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <A-quLtOuGUuzG62X2MBCsGRnqwsSRJWaFG20X4lGiqSibD0d8k6Sb9sJzSzWWmNfpifuBH1NP-3XQosT8qRxL6HsdS-bLkKDsM5qa-xKvHQ=@1g4.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA2PR11MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: 93000f08-e585-40f3-58a1-08df346b20f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|7416014|22082099003|18002099003|6133799003|261026121527099003|56012099006|4143699003|11063799006|10067099003|261021121427099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: glTpghlFu7JtJBCp6hg3MGLQebpmR34VZw/5jC5a/HRlO2pefQd6SQ8G5K+p9gR0ff+FrwCr3VTbz90GrRR+lij3UeJBbv0GoNhUDCp5ll+1U/PdbyLpwCgSjJ2wZ4heC03z7tAbsw32LUFtI52aIA1x5M9ic2BubodAmmHE2qVfOJ8raCzT2Hm39uk7834/XjnxWLkElhTmEN75JzPuqV1jPlIxonUTw3G1Bi92i3JGZC2ZrtqIYsZomc759EiLxfQMoRrP+AjDbh9TXLG/v67pQBfxt7n3A46HRIr2Oa6i2eykWao2xzHHne0ej/k807tuRC4wzMwoIaxBpVflPmO9CMjqdUl3utPJJPmvH88qDTPGjG/PMIM9DERs04UBP7lW6GnGsb7Y3A85N1gmMYdJzooLOMyk6RDHw/Xf6Fj3VHAFnYfxAeRooBYIY4qL9ORKTe/7N28Ar9SbUdAjzjQ0FwlV9UotWiom3VnCBdvvkmJ0lr1S7Mlp1rSy+TyKPHYEa/SCMXcPgPZ0uldW5OttI8Ie96j3jRFIm8kHAtRN/6RSkvNUc9rYvixm1z3kawWcT90jNlTK4Opb4cpm68cO+losDkyj4VEvXeYp0F8I0DP7QeCdz2Nx60Yrub4/tQHJ+HVEu1uwtMn5+gJ3GfR8qZgnoYkoe4bawxr2j48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(7416014)(22082099003)(18002099003)(6133799003)(261026121527099003)(56012099006)(4143699003)(11063799006)(10067099003)(261021121427099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1RqN001dkFNK2FiM3JZT2lhSUlmaDZGVjFnRUtNc0dXZ0ladHF4SHRZeVMw?=
 =?utf-8?B?bHg5dWhZcEJROW1oblpKdDl5ZjBKUFk4Zy9YaG83T1R5a1ZWSkxSQm1INUZ4?=
 =?utf-8?B?blRyZFhlVjF2QkFqTkwvWDA1OE1KUVNmL0NTb0hqRWZxeVFJVW1tRWZscGg1?=
 =?utf-8?B?bnJQQ0prNkJDZVJiUTVtOTdxckllN1lvektjd2R6bXZDWTlNWG5YWU0rU0pY?=
 =?utf-8?B?ckUwaU9iQTF4RVlFTWNKK3lHS2JObDA3S1R5L1c0K2xyYkRFK0R3cGxUWG40?=
 =?utf-8?B?MTQ2SzBNTXpKSDh5Y3pCRlhLREVFeU9TZlJKTHRiU3JlQXZNNHQrYTlBZmJq?=
 =?utf-8?B?UGgxVVk3L2MzLzUrOGVIU282TjJ3VSt0bmdTZXRhODBhZzVvUXpIeHlqR05p?=
 =?utf-8?B?S2xzeHFHM1NBYU9iSHM2YjBjR01ZYVFLMWc5ZEZ5R1JibE0xbDdMckIwVDBh?=
 =?utf-8?B?NTIveHNQdXkzTHlZc2J1VmlUM0hXMW15enlmSlNmaXo0TkovSTd1akp5aG1a?=
 =?utf-8?B?blNUVVkrQWZwOS9sZmhuZUplSkkwR0hLYlZYcUYxYXI5c2VjbncwMmJaTnNK?=
 =?utf-8?B?UXFnZ29wWXlraUJNbFQ3aGJxdTVIOEtTS2plQkhGVkN1ZHdzME1ZdVFNaWxi?=
 =?utf-8?B?alFlRWFWWTJTUGpzU1ZBWEh6dFNFdFcvQjdVbm11cWN5WWVjR1AzYlJoSkRD?=
 =?utf-8?B?M2U2ZkVxKzJJUnF1MW5HZmNVL1dVMVdrdXYxNk9neGFVWlpWTk1lL0NxVCtC?=
 =?utf-8?B?S09hRGZJQ3lEZW05cGNnZjl2aUdJUHQ2SUFzenBidnBvQlpJNjJPU2xseVRz?=
 =?utf-8?B?US85NldaUTk1THdkekh6VXpNZDROWVhnK0dsbWlGa3BKTDJ3YjFBTEJBR0ly?=
 =?utf-8?B?Rkd5UHhFQk1JNnVUd1k0bWh4OUhJdGZOWkVuWlFHTGNWcHlxWHl6bnE2Z055?=
 =?utf-8?B?dWlpSE1KVU85MFQvWmVMUnc5N3RmT3NwemlEdkVxM01xTll3VE44WGdKSGx5?=
 =?utf-8?B?TGtEdGUrUENRdVdXeW9PYWd6L2tBSHpZai9ucDlzdS9RT0I4bkNtWnJydHZS?=
 =?utf-8?B?WmNacmJ4aHA0YmRoSWY1RytRVjZ2MlpUZGMxYW5kSTRRYXhGbUpFS2pUd0du?=
 =?utf-8?B?T3AzK05aOStXbTNwWXdBUWZrVnpGYlpVS09YeGZoVHRLcGY0MkhCRFVhL0FI?=
 =?utf-8?B?SnlEVVA1dXpkYkUwNjc1MXNRQ0VNWnNBREZhYm81SlFJVXdvS2JwU2NUOW95?=
 =?utf-8?B?dDl1SWFodFozNEpidG9wUi9pQlc0aFRDeWplVENsMit6N3JGbjJ1am1MRzRi?=
 =?utf-8?B?eTlqaTE3N1Z1K25KYXFuakVyNG1zU1BNRU9aMzBRRnRJZDFtK3g4YStJOTI3?=
 =?utf-8?B?WGxkVm1STHZFMjcrMzJ0SmhrM2hGVTJrUy9xVFhpbEgrWDNUWndlQmZka1o5?=
 =?utf-8?B?dWdjS2N6U3QwalU3YXRXT093eXJjVnVQQWlTSnFCaDg5eTByYWxKSzk1RzVh?=
 =?utf-8?B?VHBHRy9xeEFaU09mbU9YbmZYYW1iMjJ2VWNDSU5sZ2pNZHlYd3NabzQ0UlF2?=
 =?utf-8?B?clg3VE8rem9LLzcrSHluUEc0Z09nNnN1TkpTTWJ5dTNBblVGR21LRGF0RnVz?=
 =?utf-8?B?d3J2ellsMUxmU1NXQ2djMXJEajV3LzZjcFBZU2hyeFpGdDdvVnZmQXFJYkJw?=
 =?utf-8?B?Rk9IUzdickZkcVo4Sm9oMFFSdkRkc1pWbjhxUlNWN3pHOFlTWlQrb01FZ1Vj?=
 =?utf-8?B?c2YrSkZ0ZThOZ0ZkNGk1VkpyRDQvY28rN3V5cGIyL2o3QnJJTm9wMi96NVJw?=
 =?utf-8?B?VlZXTkh5SUVBajNxTllteTdWanZWTEZ2UzE0bFE2MFlUUk1jWXZuNFVJL05P?=
 =?utf-8?B?cFE5L0RyZE1wdzVFZHk4RStvM2ZKNlJTZG9tKzB4Y0VFU2h6S3pqalJQL3gv?=
 =?utf-8?B?VkhIaWtLazdTM2xxSDZUWXM4ejQxM0ZRTTNGZ0o0VmIrTjN0UDRzVGRtNFVB?=
 =?utf-8?B?b1pTNVBiZGJQSDJUbjU2bzdnTkl2T3lGMU1CcUNwUHUrL2FwL1d0ZW8wL3JY?=
 =?utf-8?B?UDFuWlFRUTV2VzFObXVrZU9WOTdUdXBNQU16YzZUY2ZieTlzMFFESWg3TGUw?=
 =?utf-8?B?ZEJGN3BiUllmMW5LSHFLeVk4Y2JOUWVmWU9jZS9jbmMyTjdLVGtmYUlWaHhx?=
 =?utf-8?B?TXRCUjFtMCtMWTkzOWt2ams1eXA4UVo4TFVqRDdrSEhuV1BuVzM0MnVMMHgr?=
 =?utf-8?B?c1o1R01tNVRaT1hBREpTZWcwNlRhL3N6cVFIUkpiV1h4bDIxZEJlWDhlbU13?=
 =?utf-8?B?OHkxcURJZEphbVJTeTdSWjZpRkQ1bDBMa1BkWnVWQ25MaFZkQzVVNmdsTmZq?=
 =?utf-8?Q?k5EvvUs1E+QscIkw=3D?=
X-Exchange-RoutingPolicyChecked: 24o9ejRg+XPI5p9B1A3/EgcW5dYYAKjWi50TKg9aNbBeRv5GHRO/+lsRCzRu7Q0wH/psPfY1VAnzxMLi/JwX5w9/7ahqpL3jhhPqqdzqvc0d9Ti/ijVbikkPEtNT8v4drSG1FO0vbq2GD7MvLbfuZkGBqQ1sr9bdT2D8yEH/de9jZdBP91R0FfwJgFX8LNY/eMpP3/r65J3TqnQeI15pdLspIYLkqHyAKVPmysXVB7auWGoGSmAdDR3S2OdiMZAXg4O0wUek698ceZjTK9ftAItkTC7USn/VFOZqf+3bX5vAahuxGHpqqHm8XZM9UnDvzNEnHkzxf07gkm5ivFz2Yw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93000f08-e585-40f3-58a1-08df346b20f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:44:43.0920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oe3IdDvFeZSXr/zCnK/DXPJxW4ledZ/i69g926GU7keSFX417Zt4HyaRJnpwstXCW5Vtxdq8sWIaqYzmdIth19OLZZroTsH50cwgmDcY6es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4780
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/2026 9:13 AM, Paul Moses wrote:
>> [Severity: Low]
>> Does this description match the tree this patch applies to?
> 
> It needs to be clear that it is affected by that commit.
> 
>> [Severity: High]
>> With this patch applied on its own, igc_request_tx_tstamp() still runs
>> before igc_tso() and igc_tx_csum(). Can the same shared skb problem come
>> up here?
>>
>> When a GSO skb with a cloned header (for example with a packet tap or tc
>> mirred active) is hardware timestamped:
>>
>> igc_xmit_frame_ring()
>>   igc_request_tx_tstamp()
>>     tstamp->skb = skb_get(skb);
>>   igc_tso()
>>     skb_cow_head(skb, 0)
>>       __skb_cow()
>>         pskb_expand_head()
>>           BUG_ON(skb_shared(skb));
>>
>> igc_tx_csum() can reach pskb_expand_head() the same way, through
>> skb_checksum_help()->skb_ensure_writable(), on a cloned skb.
>>
>> The next patch in this series, "igc: prepare TSO and checksum offloads
>> before TX timestamps", moves igc_tso() and igc_tx_csum() ahead of the
>> timestamp reservation. That fixes this by the end of the series. Should
>> the two patches be backported together, since this one alone leaves the
>> TSO and checksum paths exposed?
>>
> 
> Yes, I maybe need to research how to properly denote this

Personally, I think its clear from the series context.

Thanks,
Jake
