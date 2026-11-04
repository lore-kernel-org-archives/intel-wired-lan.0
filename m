Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7DC6072657
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=R7T7hh05;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CbZpNNRq;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dONTbNAF;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FG/uBTho;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JP9OEz2l;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CbZpNNRq;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dONTbNAF;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FG/uBTho;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CbZpNNRq;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dONTbNAF;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CbZpNNRq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD5678128A;
	Wed,  4 Nov 2026 22:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rfsl3P36OX9J; Wed,  4 Nov 2026 22:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3168081287
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793830586;
	b=EUoyoY4jFajuSwuV148WUqMZ1pc5Ss+KJITPdMOb/UkmnMicZPsMbiRaJyJjhuoLFPIV
	 wwb+VfLBSvqOMOZdfeY4TyXXNwjaWXLCBN2KXbFc9sMA11Jcc61JYSb2s8bgAUzD/UY+a
	 AZnFe7fZB2Cr2y7zzRkOKoKK8dibD5/JU3t0pWtk/+mI5TwGZAsU+ZG62ZDQpM5IOStl3
	 W4VEQTGpXhjbaMyZa3MNC51dpZiyLoP4zp1LQZHjXKAfP+FZeOxlicnEwxl5BN5Sa8XbE
	 gKCVJpVBMXIZ/no55IQM8G22xo+qBQVhgVDrJWkDauEN9w0YMuVyBwAw8J8QJGSzIaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793830586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
	b=eCz6VvrvXDyzOMyHUHYsZmOuE90S+qLdLttXo+Pk8LI5OJpsqUb9Stnm2AD1PfmV8fFK
	 DVPqZlHcjPutH4gen/eDxNs1axf9KWvHuAhQW4K7IS6cHO9W2F/lsoKiOLAxDjPSqastj
	 mViAgVjJWrIwQXQvlhShbKUmvHxXk+Ge36U0d01a/ba0Zq8TrP6DOeDSEJtGSifti43E6
	 /kjWaNL81r+Cdz/IJ7sfJ8Z8BYrjafZLNsAuiH6dyMjvljsKE4jz4lFTILCmec9nltve6
	 Ibx9NFuhXqyKIo8pMlvVY/NZVTnxaeFUpIgafDgQd9Eh1SB7B9Z9rUGXSYT69V7iNUQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793830586;
	bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R7T7hh05JkF0EzrRpkwkRsaaEGCNhY7iYJIcFrplTK8AxhLnfoGJ/hNN3YZp8O50j
	 T0egVFUt5jLnu+47gwuEl2eif0cyH6ZbRD1bZyjqoxoGYHP6bAfD7AG7Whcpskk0AQ
	 VBsNZE+OVmWM6Aj5fxOVEFZZYjIBFwL28K3zR67Dc2je1ffSGJ5sCZjfaN1Khml3i3
	 f5e1reBWEWnkI0Ya3DX2v0Wr9c/tXyhcBAq8Do9flaHg8SXuwhIagc78iXZnBtOig1
	 c5QDGCEmLTIKqsjQYhdTiEnTViOV6dgMA8L8uQWIxgclyKouwzL6GoDfH2+8lNigrL
	 SCxuXVhPlszvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3168081287;
	Wed,  4 Nov 2026 22:16:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E5647B00
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 22:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA82D6078E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 22:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G9-anoQdt3a4 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 22:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 75986605D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CbZpNNRq; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dONTbNAF; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FG/uBTho; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=JP9OEz2l; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=CbZpNNRq; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=dONTbNAF; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FG/uBTho; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=CbZpNNRq; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=dONTbNAF; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=CbZpNNRq
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 75986605D2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793829673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
 b=CbZpNNRqa7x4fCuUn6oQbasu2b3Jt+MlP4AJ2JFvq1s1nZnSScx0C7iUFQmIDT03YaeTti
 4z7wpiuz6DZCczMt6oykM6HBb/XtuCtbfvRKFRdtTeJPsmKQJ57QC75fV+ZKneieTfOKTS
 uUcptQ5IsXNbIskbN+zeoreLpxPtkco=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793829975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
 b=dONTbNAFjVGLpDcjah6Niv9GZITM1efLW0K8GfJGaaIn2bzl/mFivCe9dighpw4cwDDwi4
 50PLbvWMb8UXQQz+Z/HgmOuwaZGaVqhAgYMniiwfgtO2F2rpEc1xO0216+EbAcgaK9hVrO
 EG2Jt/xIIUy5XNPCO85X65l/fVVweNg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793830278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
 b=FG/uBThocihJOWBJo7MdStrfaqnFnq6IKmT/wmBJ+NG2ZljRcXd3kPuPRAY2WiKdbLLhKj
 TML0I5h1KbHroQRwUW2xpnT1CV449lg42PSZiNHR+sjbYz5Ts9InP7ZRgnlOydYR6PGeGA
 h4rLmliJUsWu2VYfM+nCsXQHQ+C/jis=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793830580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
 b=JP9OEz2ldW920C37f8laKsacGyxXS0ROQojuB9KqtYelML791fuZbohpYBZtb8XBwppFBX
 0nMVg8VnvDPSeN4JsvWdHwL2e+1/3uk3RIdF+109wJNnbrsYRwPjOAnBcqyYjr6d9QrCQF
 Vm1D6UBGk8WGwaBdSD5VP10rR6ad31Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793829673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
 b=CbZpNNRqa7x4fCuUn6oQbasu2b3Jt+MlP4AJ2JFvq1s1nZnSScx0C7iUFQmIDT03YaeTti
 4z7wpiuz6DZCczMt6oykM6HBb/XtuCtbfvRKFRdtTeJPsmKQJ57QC75fV+ZKneieTfOKTS
 uUcptQ5IsXNbIskbN+zeoreLpxPtkco=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793829975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
 b=dONTbNAFjVGLpDcjah6Niv9GZITM1efLW0K8GfJGaaIn2bzl/mFivCe9dighpw4cwDDwi4
 50PLbvWMb8UXQQz+Z/HgmOuwaZGaVqhAgYMniiwfgtO2F2rpEc1xO0216+EbAcgaK9hVrO
 EG2Jt/xIIUy5XNPCO85X65l/fVVweNg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793830278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
 b=FG/uBThocihJOWBJo7MdStrfaqnFnq6IKmT/wmBJ+NG2ZljRcXd3kPuPRAY2WiKdbLLhKj
 TML0I5h1KbHroQRwUW2xpnT1CV449lg42PSZiNHR+sjbYz5Ts9InP7ZRgnlOydYR6PGeGA
 h4rLmliJUsWu2VYfM+nCsXQHQ+C/jis=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793829673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
 b=CbZpNNRqa7x4fCuUn6oQbasu2b3Jt+MlP4AJ2JFvq1s1nZnSScx0C7iUFQmIDT03YaeTti
 4z7wpiuz6DZCczMt6oykM6HBb/XtuCtbfvRKFRdtTeJPsmKQJ57QC75fV+ZKneieTfOKTS
 uUcptQ5IsXNbIskbN+zeoreLpxPtkco=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793829975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
 b=dONTbNAFjVGLpDcjah6Niv9GZITM1efLW0K8GfJGaaIn2bzl/mFivCe9dighpw4cwDDwi4
 50PLbvWMb8UXQQz+Z/HgmOuwaZGaVqhAgYMniiwfgtO2F2rpEc1xO0216+EbAcgaK9hVrO
 EG2Jt/xIIUy5XNPCO85X65l/fVVweNg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793829673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w9CdwPErUt55SviF3rKSmqb1tl8IBDbw/57AfeFpaXU=;
 b=CbZpNNRqa7x4fCuUn6oQbasu2b3Jt+MlP4AJ2JFvq1s1nZnSScx0C7iUFQmIDT03YaeTti
 4z7wpiuz6DZCczMt6oykM6HBb/XtuCtbfvRKFRdtTeJPsmKQJ57QC75fV+ZKneieTfOKTS
 uUcptQ5IsXNbIskbN+zeoreLpxPtkco=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-nPOl_08aPTO2CdaX177x4A-1; Wed,
 04 Nov 2026 17:01:07 -0500
X-MC-Unique: nPOl_08aPTO2CdaX177x4A-1
X-Mimecast-MFC-AGG-ID: nPOl_08aPTO2CdaX177x4A_1793829665
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F6A81955F1B; Wed,  4 Nov 2026 22:01:05 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.42])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76C9B195604C; Wed,  4 Nov 2026 22:01:00 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Simon Horman <horms@kernel.org>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: do not classify EAPOL MAC address as LLDP
Date: Wed,  4 Nov 2026 23:00:42 +0100
Message-ID: <20261104220042.1421735-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: T-IYoBXU0H4uelamWHquTWMxzquzaichEpxY6hRlR6E_1793829665
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

01:80:c2:00:00:03 (Nearest Non-TPMR Bridge) is also the 802.1X PAE
group address used by EAPOL, and the virtchnl MAC filter API carries no
ethertype to tell the two apart. ice_vc_can_add_mac() therefore rejects
it on untrusted VFs, which fails the whole ADD_ETH_ADDR request and
breaks 802.1X authentication:

[  128.447213] ice 0000:17:00.2: An untrusted VF 0 is attempting to configure an LLDP multicast address
[  128.447301] iavf 0000:17:11.0: Failed to add MAC filter, error IAVF_ERR_ADMIN_QUEUE_ERROR

Drop 0x03 from ice_is_mc_lldp_eth_addr() and treat it as a regular
multicast MAC. Trusted VFs still get the ETH_P_LLDP forwarding rule
through the other two LLDP addresses and the rule does not match on
the destination MAC anyway.

Fixes: 2296345416b0 ("ice: receive LLDP on trusted VFs")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/virt/virtchnl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
index ca8018e3dd4288..27f0e1dee24642 100644
--- a/drivers/net/ethernet/intel/ice/virt/virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
@@ -744,8 +744,9 @@ ice_vfhw_mac_add(struct ice_vf *vf, struct virtchnl_ether_addr *vc_ether_addr)
  * ice_is_mc_lldp_eth_addr - check if the given MAC is a multicast LLDP address
  * @mac: address to check
  *
- * Return: true if the address is one of the three possible LLDP multicast
- *	   addresses, false otherwise.
+ * Return: true if the address is one of the LLDP multicast addresses
+ *	   handled by this driver (Nearest Bridge or Nearest Customer Bridge),
+ *	   false otherwise.
  */
 static bool ice_is_mc_lldp_eth_addr(const u8 *mac)
 {
@@ -754,7 +755,7 @@ static bool ice_is_mc_lldp_eth_addr(const u8 *mac)
 	if (memcmp(mac, lldp_mac_base, sizeof(lldp_mac_base)))
 		return false;
 
-	return (mac[5] == 0x0e || mac[5] == 0x03 || mac[5] == 0x00);
+	return (mac[5] == 0x0e || mac[5] == 0x00);
 }
 
 /**
-- 
2.56.0

