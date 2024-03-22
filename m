Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0166C54E58
	for <intel-wired-lan@archiver.kernel.org>; Fri, 22 Mar 2024 01:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ECFE40511;
	Fri, 22 Mar 2024 01:48:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eywGjZuAaDCG; Fri, 22 Mar 2024 01:48:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BA6A4060F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1711072119;
	bh=xEs+nxPabscqfZYnqP1XSpV1Ny+o8wv2NPvfwWpfoJs=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GfHzT2aXfQxmnVWlrANb6pikuhLgIJnNGFn3ZDIi5Bc2OPbnblO57zgrrOB6HSlcA
	 W35mxsBxFL7oGZU90Pv7FrPDz1PhXOfa73pWuc2TsgIXv2/N6tdIzrFOFYzG38Dz92
	 jkQHwaJZ0+eswev7pHBjxwb5yMS1CH57aUR/TqPBR7QKUPwgZHSJHXV46HzeaE2SZo
	 tNkpSKdk5MNFsYcL765Wi3c75t4M1rtDQdP/Sty0GBTUQC/Un8DlrUbGT0Olnk2qCT
	 yB48Vt4hSPWCTZ7lYOhtq/2dDNEa4zGZxacBf9UFs6topiWhfK4QR+xCu/4Ct31SXc
	 L3yH1+QeEOVyA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BA6A4060F;
	Fri, 22 Mar 2024 01:48:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 31A841BF25B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 Mar 2024 01:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B9DB60684
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 Mar 2024 01:48:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H-oLG4VOM1oM for <intel-wired-lan@lists.osuosl.org>;
 Fri, 22 Mar 2024 01:48:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0A0056078D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A0056078D
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A0056078D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 Mar 2024 01:48:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8F69FCE13D4;
 Fri, 22 Mar 2024 01:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC36C43390;
 Fri, 22 Mar 2024 01:48:29 +0000 (UTC)
Date: Thu, 21 Mar 2024 18:48:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20240321184828.3e22c698@kernel.org>
In-Reply-To: <b9dc2c7a-2688-4a7b-8482-1e762c39449c@intel.com>
References: <e5172afb-427b-423e-877a-10352cf4a007@web.de>
 <F2FBADE8-EDF9-4987-A97B-CF4D2D1452E0@inria.fr>
 <b9dc2c7a-2688-4a7b-8482-1e762c39449c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1711072110;
 bh=xEs+nxPabscqfZYnqP1XSpV1Ny+o8wv2NPvfwWpfoJs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SuYk7s2UjAWtsP6/F+h81BmUN58VCzNgEdB/VXdXyezkhoLn6Lqz+ITt0UJdCIcfc
 MiXw6aa2rxAKAjEikmm/XzpOegE/dWexDUa7SrwVZVVEyfwTMPigrjfeLC+u/6G91E
 jBraP1oU9V17rWifPfU6wXvsHCGENphUzV0qbInwg+d38pnyh8NBpVfuXFxZsbYLhF
 yJzOiZWaMrBi0k7B5AA+IfOfUa1BN4GJYeg7J0M0hUJoS4m5WR9ZgGj8++Y8oYmU+y
 tyBk7Yb4Q0wEoxrpcBbdi+zKXgP3dg6BFGK8x57EMhjLsLiEMhWO6yq8+Aas3hui6I
 m+Va6UdQhsoPw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SuYk7s2U
Subject: Re: [Intel-wired-lan] [PATCH net] ice: Fix freeing uninitialized
 pointers
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
Cc: Jiri Pirko <jiri@resnulli.us>, Pucha
 Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Kees Cook <keescook@chromium.org>,
 netdev@vger.kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>,
 intel-wired-lan@lists.osuosl.org, Jonathan Cameron <jic23@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dan Carpenter <dan.carpenter@linaro.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 21 Mar 2024 15:27:47 -0700 Jesse Brandeburg wrote:
> The gist of it is that we should instead be using inline declarations,=20
> which I also agree is a reasonable style for this. It more clearly shows=
=20
> the __free(kfree) and the allocation (kzalloc, kcalloc, etc) on the same=
=20
> (or virtually the same) line of code.
>=20
> I'm curious if Jakub would dislike this less? Accept?

At present I find this construct unreadable.
I may get used to it, hard to say.

Also I don't see the benefit of the auto-freeing construct,
I'd venture a guess that all the bugs it may prevent would
have been caught by smatch. But I'm an old curmudgeon stuck
in my ways. Feel free to experiment in Intel drivers, and we'll
see how it works out =F0=9F=A4=B7=EF=B8=8F
