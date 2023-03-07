Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D6EC678D4
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Mar 2023 09:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A067760BC7;
	Tue,  7 Mar 2023 09:54:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A067760BC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678182856;
	bh=xRDL35/QSsmb/IMbP4M6MgokMQi2ZlyZYTfl/cGiM3Y=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=1eNPn8IOX7JGkVTqG+RaivCdXBueywVdmZSk0cVJfazhgNS1KkzFFQEJ5bDbuG2yI
	 PbsHlBjNKfZnikQyAHOSiDh5DDQR9kWKsjbTtbEl7GgBfaU9gLbxLMDzrDdwrIvRaL
	 erIEOPpVwuxVksdGOFHRRqCbQKfBtsCffhqpb0IgbC2biFY3lCwrICz2fLkJ8bAd1L
	 kzRBYfEr7gMO7aswe08mEQ05ygqLEZvaeTVVVVxFP8U6eAU279QfabNK4LuWwS0mXg
	 jLSKI2lEoXY7dbIAvrddBopJm4LoyRClI8VcWVBu7mMwiqhQkyIM1phMEs5UIIIH3i
	 v//X/u4i/VUiw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EEP46tIzleot; Tue,  7 Mar 2023 09:54:16 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4BC660BFE;
	Tue,  7 Mar 2023 09:54:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4BC660BFE
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id DAE2C1BF255
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 09:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFEFD60BFE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 09:54:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFEFD60BFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jSvHfvEMQ4WO for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Mar 2023 09:54:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1637460BC7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1637460BC7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 09:54:13 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389--lN2wpGrN-eu6KMoHx6aCg-1; Tue, 07 Mar 2023 04:54:09 -0500
X-MC-Unique: -lN2wpGrN-eu6KMoHx6aCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AB6A800B23;
 Tue,  7 Mar 2023 09:54:09 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB0DA2026D4B;
 Tue,  7 Mar 2023 09:54:08 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4ACC6A80721; Tue,  7 Mar 2023 10:54:06 +0100 (CET)
Date: Tue, 7 Mar 2023 10:54:06 +0100
From: Corinna Vinschen <vinschen@redhat.com>
To: Lin Ma <linma@zju.edu.cn>, intel-wired-lan@lists.osuosl.org
Message-ID: <ZAcJvkEPqWeJHO2r@calimero.vinschen.de>
Mail-Followup-To: Lin Ma <linma@zju.edu.cn>, intel-wired-lan@lists.osuosl.org
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1678182853;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=V4kr/UEWE7UVQYnQE5hVgedBAdicBPfxuIatmPhi/jc=;
 b=Pe7s4Y0VhsyS0vSrTLaaoh+gREVJGyNiLX5b83cYi3VwolfOqOhUfac2F74Rav4PAzUKPt
 02On4KzDghDRHoq9eL58oSjteJQ9c/TUX/fwrfGBfxKZuExkke3iUFkfdrMmTGIEKNcC2J
 GIqN8ICo7yfttK6IDZF4RrQotonoiCI=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pe7s4Y0V
Subject: [Intel-wired-lan] Deadlock since commit 6faee3d4ee8b ("igb: Add
 lock to avoid data race")
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Reply-To: intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi,


After patch 6faee3d4ee8b ("igb: Add lock to avoid data race"), we see
a deadlock scenario when trying to unload the igb module.

The reproducer is pretty simple:

  # echo 2 > /sys/class/net/ens5f2/device/sriov_numvfs
  # modprobe -r igb

The hang is quite thorough, I assume it's suffering a deadlock between
the rtnl_lock and the spinlock introduced by 6faee3d4ee8b.

Any chance you could have a look?


Thanks,
Corinna

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
