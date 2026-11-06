Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC425606A339
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=aSnCPyMm;
	dkim=pass (2048-bit key, unprotected) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=dCeCOJtI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DB6C80F2D;
	Mon,  9 Nov 2026 17:18:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6eHoTDM6i7xx; Mon,  9 Nov 2026 17:18:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C380680DC1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244737;
	b=J0Iuu0E5SXN8olq/xfnddli0Z5c1FAAHF9JNLMGoYghAY18zOrOTNdkEA3oEVgn5wrc4
	 RSWNZqDNwC8R/f2z4Cr+IKWgQH5aXqvclRP2kdixVuj3y9Dy2DjHaQ6USM8I9ArxfPQyX
	 pYdwl1EtP6zWZDJLB655XMYNGo/Zbwh6+AZKLKxvKDcvNdqWOPRJHypo/kM5aRj8qc2yA
	 mzYujIxn/xbyf19HHZC9D7GqeAt25j8QtJrJr56yjR1qX6txGLmT1WN3nRxxkF8e4tYGM
	 Jrr5L7rxHakby34cepHf5Tnb4BCkUD0W9OI71ZL9ua19dyl4fdNymb3FEjVTWYeRJTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Bi9ZE5309OJnPbbXWSNSV6UCV2z62qA6XmkD4gkB0X8=;
	b=UsztdDNVLlM+cmkdwYdTqhFTE9vearC+Agkv/EZqHwD/Lm7agzxWvWo0U2GTLyA310IH
	 haMcXSOE2JsEGr9klbbilrSKEKSvh7vXDRL6Dd1w5js5dQSWnHTEFhcXVhtxhUgjaTFFx
	 /yEwxD611UvfAh3eU1dOw3w7aFCHHn8x3xaORFgD5sdzIBHkmwZ/QvNwKeWt1lA0FH1JK
	 iQJu+WlkjfxkXL2qkK9pyF/EOg53UKPMjbGpahzDQLLjmC/23/qX47JXJVWEJBsTLNRIY
	 67hyYOKWhCwS2VPx0Z0RUsB41JJJ8LkJCt9uB4fereXPhwPrQXEUOf9JVHaY5KSc3fQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=dCeCOJtI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794244737;
	bh=Bi9ZE5309OJnPbbXWSNSV6UCV2z62qA6XmkD4gkB0X8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aSnCPyMmudaE//Wj9YmnYmetyJQRgqvcCrdtN/49afnvwPeRqo0ifGFT4kVd/Bo2o
	 +gZhG0w7I3OsuZphZ9GTpVegGdAm5epIfV/WgzgV3ag2bYwVPKmVhvgS+SFyHWbAse
	 PBepG6dFOiCh52g3ePo6jAWb3DwGhnG+/kHIDjC6UsSk38uQake5CdCAQ8G8naDh0k
	 /yoPU06zj1gVAWA2JTrM3oqfIUQg3JAiPK9gSCebFCRrdY8BnpSX9mMmkOsg3wgHDV
	 ZgOQkEpXQ5vjWQCPmjHRkv68zZsEnq6v9C/1ciN/bucLkHhj0EFT/F0LGPofGsbLpi
	 c2KDFYVf5lHfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C380680DC1;
	Mon,  9 Nov 2026 17:18:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 70A2F2AC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 17:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55A5F812EC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 17:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id exs6dPgwnTFL for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 17:40:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA758812BF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.166.238
X-Greylist: delayed 1347 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 06 Nov 2026 17:40:16 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=windriver.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=windriver.com header.i=@windriver.com
 header.a=rsa-sha256 header.s=PPS06212021 header.b=dCeCOJtI
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.166.238;
 helo=mx0a-0064b401.pphosted.com;
 envelope-from=prvs=5770b0e00a=ionut.nechita@windriver.com; receiver=<UNKNOWN> 
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA758812BF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 17:40:16 +0000 (UTC)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6F1RFx3287148; Fri, 6 Nov 2026 09:17:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=PPS06212021; bh=Bi9ZE5309
 OJnPbbXWSNSV6UCV2z62qA6XmkD4gkB0X8=; b=dCeCOJtI63WY9wnOCYZFhDD8O
 bkl36tMSHdsXgUJv7JbmXIeojmNmsIdkvRKJH70B6J67xNMDPrfPdroC3qLrlkxe
 7Wmovj9qZS0x2PvTvcA218l+jW0IoBkrFErBI6sChHuft7WxJdwltgcFiH5nc/1U
 0MgrGKOZo8uRTTanR57/UDTp0AexdDF6FuvGZk1l7Mo5hcYwwdHqkZymrCoFL37f
 YUVk4DG8+mrQB+2jtCqPArnBIM9zjFmLOevq5QZbPp/9UVwVKl2BfcmAtxOg+1Ji
 N1e6vCXtMQ8WQxQ51UEQYfUunLOfdr+X0A4zGV/5IFX+duCf401G/nya/APvw==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020119.outbound.protection.outlook.com [52.101.56.119])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4hs3pr9dr8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 09:17:32 -0800 (PST)
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB741580.namprd11.prod.outlook.com (2603:10b6:610:34d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 17:17:30 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 17:17:29 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH iwl-net] ice: release IRQs and rings in ice_dis_vsi() when the
 VSI is already down
Date: Fri,  6 Nov 2026 19:16:57 +0200
Message-ID: <20261106171657.583713-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0075.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::12) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CH3PR11MB741580:EE_
X-MS-Office365-Filtering-Correlation-Id: eadde2a9-e277-4c72-a7d0-08df3c29d649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|52116014|7416014|1800799024|18002099003|6133799003|10067099003|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261009223027099003|261022075727099003|38350700014;
X-Microsoft-Antispam-Message-Info: NPd4a86NxbYVwqG03tMYLgdqRq/ULm3XzocNjnBcTdc/gNcXYg2Pr5/TIXjE5ZvSvEBfoJ3PWa38QJjb/aM8wfx0Zl8SIXnhZ2AcCmkkxaK5W28oMv0cfsOAf53Y++cnuP1+fdsbSsx0cctEtUSmdtMsialpzfOj4zOFUhFaSChTbsfDcnQGL0pIWiWhGyUc0Y17iNpkN8I8VGMiFHfxsffHrNZn+++lEFuQVg02IbC8y2spYtAxd9HNp5Q/smnIAouymekBNmXR9FrgmRgiiePV0gzqMnEDtw+nMJ8NBgHaj6Et0WWoPUw2MAdtN1Y7dMrLVcY51F9RrFNxGYhMS7Pg/238s2UqSHPN1YAWT9Fix9R3vesQlFwOdHNQGFWIqW6ZnZYOC5SxITq00QGjs3qyTFDdBk1IGsTtg9TO8MFgDg7zbTMKqOl846DE5HmG5r7J/aMEHYOAsm1wsUtK8rlQ7a3v9RqFI3h+EnIS4++NV2FGs7SOwW3QXxe7DKVTEsjRz25Fhs8pMQJBR6z3zVmzigN05TVWL9fKk3pTbx2ZvnpcjsStjvYa2i/HCwKje2L2OhcrtSZ7M7Ad9BPml337cIQQfXcW+pUWdNKIRh1I+0rpZdCNYIU1IIIx9YJ0q4ZW+0Z1vYQIDeh6Y4pHUxvS6Bmh1IQbcYtmtYEqeiSglc2qODlCQNFFeK2l09SLqpA8khNhvbYRJTk99DGQjYyAj4c+7QdIMhwF3jNr5a8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB7546.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(52116014)(7416014)(1800799024)(18002099003)(6133799003)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261009223027099003)(261022075727099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7lF2Mf/8MKafN6KZJDJ6nGfWBuNa/TMvaGe4b590dcFjAyeMZUWvO5/v6AdP?=
 =?us-ascii?Q?PXFNjCfJy1v2i6mfhRqA9JbhS351/t2/IDxod1ZyH+IG1NwrrqmNFvItzP73?=
 =?us-ascii?Q?4hdBTljseTPSlvazwoP4yErnb1DW093lWh6v8A54rMMj22lMDosfk013Woql?=
 =?us-ascii?Q?xW27wLH0PVzMTwA+oiRCb38Ps4Bj3bpbB8dLysuLQbSFMgIDzhbxjwytq/Al?=
 =?us-ascii?Q?sBsmbrCwrTbKSQq5xuXDMzvosGb23h19uG1NNXgGk9oVJh8Tu5h8LARU2CRc?=
 =?us-ascii?Q?HQc/zlTVhUqjO0lSMRAsmXa7dq4iaI+/qQqhLD73uyv6scln+LYz6aZko/6j?=
 =?us-ascii?Q?zqJfYqpym0uaSAR4Ijq42fkT+8qrlCcYBAnyNGQosPjmN1H4VqAqR5mr99sp?=
 =?us-ascii?Q?6ziBSYN2XqBeeTO1b2xfDn+XzoCAZi0hndX71dbxMlUL832o8I+AUriWe4bi?=
 =?us-ascii?Q?7ymBqxX0VXaJMm+9jgKJQnnZJEoEPZoW6fKZPOmVogWdqqzckvzUQtQOJiU3?=
 =?us-ascii?Q?XqNYhSbfZro4GOqcYmaoFlj1IrRHnK2tXXDmjNgR/ABQvYh86QWfJK5jbtGy?=
 =?us-ascii?Q?6Rn5t3pnGEkmADuaix8+l0vTSqBqmHaZf26uCGxaroG+9ThgzVJlA/bJhxYB?=
 =?us-ascii?Q?JxkaqMhEZDwiP96tSRASSNXjS+3Y3DjXqdKz/QsXKIq8JyR0ppVVKAuMBFnw?=
 =?us-ascii?Q?jT3oPS+hfHlxVpQ4V3+LF8y9DwmUOrCoO0n1X2bj0WMxPWN3O8myNm8t00w0?=
 =?us-ascii?Q?MjaJgGXUcBj4BSbCUhpS20ULUMF3Vzx72v81JUzMoU8KdXj4m0iXrhvHC66f?=
 =?us-ascii?Q?8kbMRaYpyr374Hw2YACdZFvdUj4oKbwcKAHQM2lIs7+PwYgdUxRONQ+HHIpj?=
 =?us-ascii?Q?nd/8S55FEpoyKj8Gx/eZpcEobwza3qgfct6/lYCQwCosl7ioP+5tNjvi/pEY?=
 =?us-ascii?Q?qQzSn/cdjbUMShsMGmH6IiSZEQ/XP7QqD/P/p1TqIRkzXaotyL1ls3u2GJPw?=
 =?us-ascii?Q?rP4UzC1mlXNgWykIDsHfo4TvDcPknvYc6Q6sZQpBId0OqKLhetQ38rJNlckX?=
 =?us-ascii?Q?xLnCDO5NTg8buKnKHRYTG0ksCzcwvyZ2OUhWEVcHJnIZeDGGWNS2biHoBVK3?=
 =?us-ascii?Q?CnYJ/EvbPMNSIdNZZNwmGdc8hnFYEVGYYHRz03d9FwPcaIsacj8VK7pCSYqM?=
 =?us-ascii?Q?JtS9vLteBRQ8fM54NUsD2DFQ5B8qw3bMbs+bqlsCTolG7hgF3nepkHNNWnGX?=
 =?us-ascii?Q?BHXZifxKllcExsAINBY+MRdcUyMD5ZImezdLdzysEzj4dpKbGfahJJCsNNVm?=
 =?us-ascii?Q?TIdQSzHro6KWgGcA6VrxmdQ0lyx74bxftd3XKX4D6up1AwD6SyT39hDoQ/IL?=
 =?us-ascii?Q?WhK+bx7kggtGclO1RjcZOqrqmblqvJGSTdIrS7KrT3qk+36TfdlJdyteI+s5?=
 =?us-ascii?Q?jW1uErorJQ1fWevmK1gOb2zN4aCqysPkqWZAraxA0pm19nU/aGWwt7noPr0H?=
 =?us-ascii?Q?8sM8WxihRxD2zwfwHQFGyW/LrBl+8FA0xrDeCzwhwS3k0QOQ+jPDGHjP7OUM?=
 =?us-ascii?Q?nwOrymQyoTv1UkQhcZRzG/G4eUJdpY9yCVrHjd5DM6JYnzGSpZO5wo9Hjo/p?=
 =?us-ascii?Q?lH2wcdxcJS4jKq2jJy7134BI2lgi2B3V0ww7HUc5rGMqSq7gSTvPGozUhvGN?=
 =?us-ascii?Q?WiODInqqGEZ1hv1eNXFoyIZi943U+VntL+5dV6MwZeoCOGhfGg59f5KF096U?=
 =?us-ascii?Q?PjUoUzDKGvKZICbbZ2EWtCEb7onfEKY=3D?=
X-Exchange-RoutingPolicyChecked: FCddwRkgKDctJ+j8oR0A6aLHYD/NU3V/VfYE33JfE+bEDTQ4RGa6qFmfTbGy/Rfy4FsTYSV/Axbw0o5rs8CRTGK9gS1+Mo72XIjfG+wPPH/U0XeMR02neTlR6+KQnMF8nnowGYy19tZfBq6IKmlWRAUR5ZCfjcokYwjzOpXIE+dI6ZdkqLbvMwyYyH+ajW+7n6l3AK+NUszL5iaNerQnWK7dzkE1I+1B26iJpDYWJkhU1+Kn9AwaVNX2U3pDhaBiOSTM9ttDsIiz2+fHHE3vjCBkmqydG2uBHOK8U96Ww38BYWEDSiTn7w7ii92K0SKhaTyyzY09k8qzJ2nuTB4GpQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadde2a9-e277-4c72-a7d0-08df3c29d649
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:17:29.8917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u867Pwu7lsWVr/p+fXB0JUmDy0adg3BLy11sVu8bso7qqyvcrvupixPCV1OQ86B20a76OgQTtKnCi+SnlKGohCoFt9V8RmeALp+W9ZpCKVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB741580
X-Proofpoint-GUID: r7SI_5xID_JiWtMQri7ExvE-WHk1UJPO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX86+26JQcoTOY
 8qSiff8KD7cCRX2pl0t+kYLtRbAX+9F6j4/0GxTllGzkaeBlzYw8HDY+uWIRTXAya+pbIzty5cV
 paIXSRu/u9Qimx8X/9eettMyh0spXfV29exSwdBWGAVp/pvsb0MzKIiCU2Nz5YA0bJmekydmp/N
 f8VGxcB+YATP2K/nGYU/0Zy8/sWBM1sJAFkVIRrvaLeKBKbxApouChPfmkpWafSgDdQ/jqUhsPa
 //yymqGkKIfzUpt78mk853HHnXW+lHTZf9FqGJOqHZ1vU5iknt2l1GdEzjyr57o0/zlMxyf6RYX
 rd0kZ42hEgzxac8jhyzO1VpQKBM2whDn8UyP1FPeUAHB8UPHAXa0gxdwy6jVduYUm/LQ8QcCn2T
 49xPrRTlCMDRW9D/bJgRkJNkmHU9CYRDDEUqzYZgBQbwy7N+DndPYjlC1YejLzmDPyN15sABY0d
 qAM1AzNh6M73uPNN1Bg==
X-Authority-Analysis: v=2.4 cv=Iq6L47/g c=1 sm=1 tr=0 ts=6aee0bad cx=c_pps
 a=TIEeaaXQjm2sgGsZDBwmrA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=tsWWKMcrzgDGkEzjiCsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: r7SI_5xID_JiWtMQri7ExvE-WHk1UJPO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX26OgS5/rS5jK
 itELJljS9Ml5CdQXcZ26M++8oK/kFMrpVKiTPUM96pL9vMr0ixu66Q3uXKEQwiCxxwQkzEi/alR
 htLpaKWAkOlmOEkgZ5rHVAFEwMPshYN1IJ8Krl7QmPuK+yho5MEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068
X-Mailman-Approved-At: Mon, 09 Nov 2026 17:18:54 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ionut Nechita <ionut.nechita@windriver.com>

Since commit d8c40b9d3a6c ("ice: check ICE_VSI_DOWN under rtnl_lock when
preparing for reset"), ice_dis_vsi() sets ICE_VSI_NEEDS_RESTART
unconditionally, but still skips ice_vsi_close() when ICE_VSI_DOWN is
already set. For a running netdev, ice_ena_vsi() then calls
ice_open_internal() -> ice_vsi_open(), which does a full open: it sets
up the rings and requests the IRQs again.

A running netdev with ICE_VSI_DOWN set is not always a closed VSI.
ice_down() only cleans the rings. It keeps the ring memory and the IRQs
so that ice_up() can restart the VSI quickly. If the restart fails, the
VSI stays in that state while the netdev is still running, for example:

  - ice_down_up(), when ice_down() or ice_up() fails (the latter also
    via ice_change_mtu());
  - ice_xdp_setup_prog(), when ice_down() fails.

If ice_dis_vsi()/ice_ena_vsi() are called on such a VSI without an
ice_vsi_rebuild() in between, which is the case for the DCB
reconfiguration in ice_pf_dcb_cfg() and
ice_dcb_process_lldp_set_mib_change(), ice_vsi_open() runs on rings and
IRQs that were never released:

  - ice_setup_tx_ring() hits WARN_ON(tx_ring->tx_buf) and overwrites
    tx_buf and desc, leaking the previous arrays;
  - ice_setup_rx_ring() overwrites desc, leaking the previous descriptor
    memory;
  - ice_vsi_req_irq_msix() requests the PF vectors again without
    IRQF_SHARED and fails with -EBUSY, so the open fails and the
    interface stays down until it is closed and opened again.

On the reset and mqprio paths, ice_vsi_rebuild() frees the ring
structures in between, so there is no WARN, but the ring memory still
held by them is not released until the device is unbound.

Call ice_vsi_close() unconditionally for a running netdev, under
rtnl_lock. ice_vsi_close() already handles a VSI that is down: it only
calls ice_down() if ICE_VSI_DOWN was not set, ice_vsi_free_irq() returns
early when the IRQs are not requested, and ice_vsi_free_{tx,rx}_rings()
only free rings that have a descriptor ring. This is also what
ice_stop() does for a VSI in this state. The race fixed by the commit
above does not come back: ICE_VSI_DOWN is still tested, by
ice_vsi_close(), under rtnl_lock.

The non-running and ICE_VSI_CTRL branches are left as they are. In both
cases ice_ena_vsi() either does not reopen the VSI or, for the control
VSI, the only paths that set ICE_VSI_DOWN also release its rings and
IRQs.

Fixes: d8c40b9d3a6c ("ice: check ICE_VSI_DOWN under rtnl_lock when preparing for reset")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
Found while chasing the same WARN_ON() in ice_setup_{rx,tx}_ring() with
the out-of-tree ice driver on an E830 port without a module installed,
where ice_vsi_cfg_lan() fails and ice_dis_vsi()/ice_ena_vsi() then
reopen a VSI that ice_down() left with its rings allocated. The
in-tree paths above were found by code reading.

Based on net (f66469d9905b, "Merge tag 'net-7.4-rc2'").
Tested: build only (W=1, no new warnings).

 drivers/net/ethernet/intel/ice/ice_lib.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7cd2dd066ef5e..0421b0738abd1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2852,9 +2852,14 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 		if (netif_running(vsi->netdev)) {
 			if (!locked)
 				rtnl_lock();
-			already_down = test_bit(ICE_VSI_DOWN, vsi->state);
-			if (!already_down)
-				ice_vsi_close(vsi);
+			/* ice_ena_vsi() will reopen the VSI with
+			 * ice_open_internal(), so release IRQs and rings even
+			 * if the VSI is already down: ice_down() keeps both,
+			 * and a failed restart (e.g. in ice_down_up()) leaves
+			 * the VSI in that state. ice_vsi_close() skips
+			 * ice_down() when ICE_VSI_DOWN is already set.
+			 */
+			ice_vsi_close(vsi);
 
 			if (!locked)
 				rtnl_unlock();
-- 
2.43.0

