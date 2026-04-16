Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213E9F433F6
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Apr 2026 05:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D47F96069D;
	Thu, 16 Apr 2026 05:54:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IHi1REvPd4S1; Thu, 16 Apr 2026 05:54:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9983606CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776318855;
	bh=S9WaNaQ/uFgsOFE1s6aD5beNTsaN2ql4WsVBGG/diHU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HbhQa/EuPN6zqgVQpsbqTi4JSqGDWftG/niTaQ0ie6d2NY4VClgIfvc3D4HzLYLaD
	 SWSuCxDyCDJE4cuxbXOVohsxJc8OQ0kOY97kPD85qtNxPpc9NOlLET8mUPtym8bpn9
	 UMmgJclWEnS2V1v9PyJ6H7z5eIrPpj2/vgzJuPu1wjPGsQcIOV8ZEiv7WaSVjnF9WJ
	 tOyqo6TAKuCrufT5DOLq1UglTfQu+44omXwzKd52PhwpjIPgSxl24G4ApfBYWQTG7v
	 U1mT7k6bDj/8hSinX+O1nsUA1CHnLA3lyGxzaUvihfso3PmGhEuQc8xDo3UoPBClbq
	 4bMtFCtNLIsQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9983606CB;
	Thu, 16 Apr 2026 05:54:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85A9B775
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 05:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 776E54016B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 05:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0HsBZakCN52y for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Apr 2026 05:54:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 447B44004E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 447B44004E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 447B44004E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 05:54:11 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-j7N_kwrUPIi1B6AD2q453A-1; Thu,
 16 Apr 2026 01:51:49 -0400
X-MC-Unique: j7N_kwrUPIi1B6AD2q453A-1
X-Mimecast-MFC-AGG-ID: j7N_kwrUPIi1B6AD2q453A_1776318708
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0CA218004A9; Thu, 16 Apr 2026 05:51:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7796030001A4; Thu, 16 Apr 2026 05:51:42 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: aleksandr.loktionov@intel.com
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 jtornosm@redhat.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com
Date: Thu, 16 Apr 2026 07:51:41 +0200
Message-ID: <20260416055141.19127-1-jtornosm@redhat.com>
In-Reply-To: <IA3PR11MB8986843CDCC4F6DC6CD015FDE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986843CDCC4F6DC6CD015FDE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: -hZAgPmg37_KYcU-DxBHT2DDnUn0cR_kMASkAodZMTE_1776318708
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1776318713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9WaNaQ/uFgsOFE1s6aD5beNTsaN2ql4WsVBGG/diHU=;
 b=O0LehEYAWLKEt/33/qI/UbtJGwZMbeh+mT/kbj55WQvoeNpU9r8u4sJNPDoejMSmCY6bmb
 pkPC+ngTMLRaAblybQqH+HtYeMP5Q4bViRzLGtnL/F//OpfO0HKEildHMzqDqvzqW0SS7R
 +E8Zn7DXPud2bLGIkbZgXa1o+wv19XY=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1776318843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9WaNaQ/uFgsOFE1s6aD5beNTsaN2ql4WsVBGG/diHU=;
 b=AEWFuQGF4yaUygJT55PtVMJ8hsdV6OOsV9ZGzqhoeUhmSolR0GDOr13RyEKfRkEdz6qEV/
 Yzn80uwIwFyFeWDVdQh1qgn7R3eCnc7pF6NVpyVJ+DGHjk237apBXdKNZ8uTEa51jyQy6B
 ujEhUmlaXBpXZjgOYwI5ovjxGJ6xstY=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=O0LehEYA; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AEWFuQGF
Subject: Re: [Intel-wired-lan] [PATCH net v3 5/5] iavf: refactor virtchnl
 polling into single function
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello Aleksandr,

Thank you for your comments.
I wanted to link this patch in some way with patch 3/5, but you are right,
perhaps as a refactoring, better for net-next.
Anyway, I am going to wait for Przemek and
"iavf: add iavf_poll_virtchnl_response()" merge, after that I will rebase
and I will create another version of the series, dropping this for now.

Best regards
Jose Ignacio

