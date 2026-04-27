Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709E6FF8860
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Apr 2026 11:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15495404F5;
	Mon, 27 Apr 2026 11:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zymlFQnUuhLD; Mon, 27 Apr 2026 11:35:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 419D0404E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777289712;
	bh=zTmOBQOfI2cC6OKRMtTqpwmhqCYyPD1tqmAV3nNBJko=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CsAORq+olnMv4MLkm6vICtKjAq+FogjEyUla7k+bT8p1qWFRdp+ZwttL3S2j9mEJC
	 gOSGmWt8ahDiZSkNh7B7TY9cOqGu4JVL1HECfrYNTrjxgSCViiNS4ZAQ801sQj9Mjx
	 egm0GtiuKN1dF0FGdGcavE/NfRvTDQwY4sdNz+gy0XQVeshWCctK4pwbTyJJ3+8Bcs
	 Vb/j5+DDbcBEzA1KzbWfUbIaC7WmBIQStra1UzFhYrpZnQaP9hUze1V6DWHSZ3XQEh
	 h4G2VrswerwJTcRXFhEzkqtHYam87TGzt4Xjw2/wI41ZwoIJGZ+WWi4L+1yOCucjw+
	 1jOdO/K4Zrm6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 419D0404E8;
	Mon, 27 Apr 2026 11:35:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C07901B8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 11:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E8FD404E8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 11:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xOlvF-S7Ij9i for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Apr 2026 11:35:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 88AD84047B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88AD84047B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 88AD84047B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 11:35:08 +0000 (UTC)
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-5jr6GjTLMJ-8MlD7OXhyrQ-1; Mon,
 27 Apr 2026 07:35:05 -0400
X-MC-Unique: 5jr6GjTLMJ-8MlD7OXhyrQ-1
X-Mimecast-MFC-AGG-ID: 5jr6GjTLMJ-8MlD7OXhyrQ_1777289703
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20CDF19560BF; Mon, 27 Apr 2026 11:35:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.96])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A457D19560B7; Mon, 27 Apr 2026 11:34:58 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: przemyslaw.kitszel@intel.com
Cc: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com,
 jtornosm@redhat.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com
Date: Mon, 27 Apr 2026 13:34:56 +0200
Message-ID: <20260427113456.1267171-1-jtornosm@redhat.com>
In-Reply-To: <d055ed86-89d9-42fd-a881-0384ebfd24f7@intel.com>
References: <d055ed86-89d9-42fd-a881-0384ebfd24f7@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: aNGeH6cF174TYpIFpiA9m-EtOwEInvMG3MX-y9kGlSE_1777289703
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1777289707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTmOBQOfI2cC6OKRMtTqpwmhqCYyPD1tqmAV3nNBJko=;
 b=PBRNbPxTo+c0U4LkjEZeAx5nKLbGer9c9pFuzaGk7LLKcZESa39iokPQxXF7IEKfnp129o
 S/7xp4OfhIlet0GpVM5YZGj2/IfqSP9ni8FvBBYz/Lt9KI04WO+/QqsnmJap/tFK5DBhx2
 /g7dM28mxQ8dMTf0quRYg+jAOIEHGgQ=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=PBRNbPxT
Subject: Re: [Intel-wired-lan] [PATCH net v4 3/4] iavf: send MAC change
 request synchronously
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

Hello Przemek,

Thank you again for your comments.
I will try to include the new ones too in the next version.
Indeed kdoc "Return:" was already commented by you, I will try to address
all the occurences now.

Thanks

Best regards
Jose Ignacio

