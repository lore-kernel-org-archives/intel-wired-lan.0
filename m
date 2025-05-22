Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA89EC54756
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 May 2025 08:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71C3D836D5;
	Thu, 22 May 2025 08:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MF6fEfnYnhXR; Thu, 22 May 2025 08:54:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CAA1B83B08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1747904045;
	bh=JsEDHBZOOtazqkfVbNehyiVOpjWayP5/qV2gqESfGGw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gVUXRssM+pKiFEU+JC26+7SOA5VqyDVxj+p1TEzCpmqnTV4iGnQZe7xW1u/m7Lud7
	 y9w3VEKWhfhrO0VGS5y2HALrPjFoRafmISXfuntlW6jyKfa5EngGfbuEC9EjObCyU4
	 Y/E2uAmTZWaA0FfXLlq8pPBU/RPuaiQnNwSN4FbaWnh3j8QXcM/ShFqN4w077wMYp4
	 0rBHBsBkOPYuOZkE2PKUqpocwrGYwVMF1joRq+KiL2H95TDYCjnEhMOOYrOK/npxc8
	 lRp+tvGnVoVR3ypBjbrhpI4/uf2WPpVxgpbZroyc/+JecDgttWiQYvXhZvzv4mTCkk
	 JLRmF+iZWMx/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAA1B83B08;
	Thu, 22 May 2025 08:54:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EDBDBC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 May 2025 08:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 988C4419AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 May 2025 08:54:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id axxKwuK18erK for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 May 2025 08:54:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=krikku@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E2EAA419BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2EAA419BC
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2EAA419BC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 May 2025 08:54:02 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-231fc83a33aso48229265ad.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 May 2025 01:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747904042; x=1748508842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JsEDHBZOOtazqkfVbNehyiVOpjWayP5/qV2gqESfGGw=;
 b=OggUX8zH5vN5cl04pvcQyFVvTZuiHXZ76lpSqKB00KA2T8jwndGEuRTl4Z7uHxXdWa
 Zfz7k9WFojs9lit9NY/SYmNPpFC4uwFGv66HRgio7O7Y0gK/LmCtsbXj+9ZCrwQzi0hr
 0ZRao7rcGTKrAXnRMhMUZqBvNkY1VTPP6yMEqO3JqqMdGtOd7WeXlYO5qNZm72PAhOL5
 bIdu46IZ+Zp1Zdua2KR47U9y9k+DTUgWozNClyIzGVHO9bayX7exXyTjPlEUwl497o/R
 jmnlFaZjvpKfcSyOPGBjovENsUWqQ18JawqUVn3+qNKHyJcA1C6hNDGKZMwqEz6W23m/
 pYaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsHf+E0qIdt/bibC/tZzrG+Cy8MuCneXztu3gfC+sC2Bjmm/8FKJx69wEyhp3bD2xgq0mvcQwjUe1sX5G1wvY=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yzm6tAPF17DSrnanlcAQ27e6TMouveb0W3DLv3qF6kU3glh7SCW
 SSLWYXSRR/rhLKPur7XfDGHAdbVphasYwXFt4mAf2ydylN/9JnfeZ9DkFGR7LSTyYG+5J3W6oKS
 DWA04jkSVe40JR9NsBMQw3or8mOmqX5k=
X-Gm-Gg: ASbGncurLBafxcWoZ+ZgvYo7pzs8w7nOuWj0QIuvVRxR5eXOBj2Q6Ypz0Gupo1W0u9x
 KLW/+j+7sGMhxrv3DGwAdzO4jjmHIy9cj39eN8cO1SllUk9ZZi+fQwMxJQvfodr6PuyleiLEpql
 Rep3RfCz9S6iKnpbDGwd9EGQZC1nKQaqtPpQ==
X-Google-Smtp-Source: AGHT+IHvZ7DVS9R7C0uR7/ESSCBO20xscG251oAVQCQVj4jvT3GvYy/BzbWJ4IBsZHUSyWpqWDJI+BneTq2LjzVg6Jw=
X-Received: by 2002:a17:902:fc46:b0:231:cb8e:472e with SMTP id
 d9443c01a7336-231de3b9eedmr348242115ad.46.1747904042215; Thu, 22 May 2025
 01:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250520170656.2875753-1-krikku@gmail.com>
 <20250521085851.GQ365796@horms.kernel.org>
In-Reply-To: <20250521085851.GQ365796@horms.kernel.org>
From: Krishna Kumar <krikku@gmail.com>
Date: Thu, 22 May 2025 14:23:25 +0530
X-Gm-Features: AX0GCFv7gof8BoB4Ci3vKRuBaXy9gDGycYaSQ8C2QpMFxquFvGVwWqPO6FNr8hw
Message-ID: <CACLgkEYgaqhEONPwgXq6X6WFiA767qu-WdJ7OrXZm6CYE=qiJQ@mail.gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, edumazet@google.com, 
 intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch, kuba@kernel.org, 
 pabeni@redhat.com, sridhar.samudrala@intel.com, ahmed.zaki@intel.com, 
 krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747904042; x=1748508842; darn=lists.osuosl.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JsEDHBZOOtazqkfVbNehyiVOpjWayP5/qV2gqESfGGw=;
 b=Bd1OQ+nIo25kPv45ItQY4VKe15QEN0XdDlt+UUueBcblXTKPttetvQk3DtJRMRuVQw
 7dA26CkcHQiH+4OSlpPupqxxZo87jVrujDDYiyxIiX4BTxBFBW+Icx+BitcIm9wsutwf
 mr2P8km34CjfUJXUK5eUyza8BtXBGrpttW8wCcZJ1VJ7kD4nDLXUHY9bRRZ9IpMX3+zn
 r4QmfNzcdO4HKxRm+Bop9CDG9VT0Yft/D7Uo658qf7q3rBBii2EtSZ10h0qqh1CCQJbF
 +DG4zAkYrrLU9PmwEMvX+Cp9X4NiCmz+yVY0yOxmJ8YB5CugEaQe6IY4RVHC2UdRSLrq
 FbFw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=Bd1OQ+nI
Subject: Re: [Intel-wired-lan] [PATCH v2 net] net: ice: Perform accurate
 aRFS flow match
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

On Wed, May 21, 2025 at 2:28=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:

> Thanks for the updates, much appreciated.
>
> I don't think it is necessary to repost because of this, but for future
> reference, these days it is preferred to place change information, like
> that immediately above, below the scissors ("---"). That way it is visibl=
e
> to reviewers and appears in mailing list archives and so on.  But it is
> omitted from git history, as there the commit message is truncated at the
> scissors.
>
> > Fixes: 28bf26724fdb0 ("ice: Implement aRFS")
> > Signed-off-by: Krishna Kumar <krikku@gmail.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks, Simon, for your feedback and review.

Hi Paul, Ahmed,

I have uploaded all the scripts and a README describing the steps @
      https://github.com/kkumar-fk/community-net-scripts

Thanks,
- Krishna
