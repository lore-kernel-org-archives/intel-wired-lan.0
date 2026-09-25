Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AFAC9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 17:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6862481314;
	Fri, 25 Sep 2026 17:24:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lRfwt0kwEHyF; Fri, 25 Sep 2026 17:24:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D0A9481204
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790357048;
	b=f0mb/6b0Q7EnpHfF03d10/URhamM/TB4IrK9fXNtv82CNMbuaEp16vaI3T0aZFPBRKFz
	 wG3hn8LTPz4cd+gHMHM+Hk2rMNSiOM8WGuY8GukHwlO5KVBKrUwyNmXGQxV6zOtIy3lVh
	 bBaNou9ZxFgBMZsOMUc/NVH0cM4+1ZQ2A5gC9EccXzaAy8y3AJIyKdbIl/X6OgQ9H/FvZ
	 0VFpR0ObXWulYy0fMLGae9DuueevWCw+UOLolTnGbSsNqqQ0NSWBDXWbkzCGkrdvJRrOg
	 NpsvFqLBckeR07EXND8Jya2wjiPIMFOPUy7PbHmn53VjFSpEZr4Kpe9cEas2yl6l8lQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790357048;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=faooqxYJPony5EWU+tgd2K06Gdx5SmkfQ0Z/baqGBaw=;
	b=XH2N1I3yT9fcvpb/JQpi1zLqjddWnh/4DiWK906kfxNbfaXekVTGb41WvxaKUDilKHe8
	 X9XI3jSou0lhNAdS9FjBVrhD+aaCq62/HR3+zDvG8V13Lwt6aVkV+L91cUMYBejAgipFQ
	 JYqU4JLmPvedeVuUjhxyGFwXcHpYdBDvmpaQjkreMqt9370USCtAJJAts/KYLopp/rjF4
	 ADvCmpfxFxioCSlt0Y9QH2KYwVFauiApBsbssN1MyCp3PjQtSUpB7kIaONK2PXDERdY/+
	 yJJSRvANuRs1fpo9JBf1jlLebgmGahS5HDsMa3u5WNzgMz0jzob8AgK4GxZffM+Zbeg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OP4fKYYY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790357048;
	bh=faooqxYJPony5EWU+tgd2K06Gdx5SmkfQ0Z/baqGBaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LdJxnuMPhLOOym19MgADEXQ/eXfa31jAG/mS1OJkJzXJf1vPeCkAhINkhUek22Doy
	 NYxhUChrobJzylGC7xB8lGXBLmcAWvwgkR0No7uHbcMIjcNKMBJ/zHxvS21STnp90R
	 XK3CmmeXGyoaK0eSY9hnA6+hEzhj+J1lRSpUOB8keue5JbhNMU6FN/9por+VannXOF
	 QEJrdKKSTtpeL4mBSx7Iy+fGsQ9jQJ6/sAq/phbOvGxXAS6Amc+jt6m4FayMoNW3R6
	 /db2ScQL79fceuIkS3HqXaaPYwdoZAzUuwHHCNPCOu6eho+9KlQ/LrePA0Un152+p1
	 zmJXdX26VADEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0A9481204;
	Fri, 25 Sep 2026 17:24:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D6060F46
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBE3A81204
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bL7y9RqkJJ06 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 17:24:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1E3FB811FD
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790357047;
 b=IANZiAifgXWeKpYytjnHHMd5Vk4qGT27B+nqLz1kd04fh3PM99YsRoQZu9hc5qv7cX1w
 3JICUnJVqnopqQN2FxV+cNFA66ridQ6DYpECqPbefchK7tGKRnRGVStQ5KDlUHFy0Bswb
 f9H5V+xQez4qOc9qAHPZSRGHtQySweMIZDRGZuRhXEPZ5HPJihaLmwpCecWzt6gdZJh/K
 euIr6PS6SskaFCHH6htq0M9d3k9+otSWYauSl/d4IdgtARj2DDIm6hkIEjc2J9keTFafL
 1oaDqKcUZQaJPM8BGGHu9S7i1sEN2W/6tDxHgJZeaS16Z8RrLNWA3bXIaTEYXtKDhUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790357047;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=faooqxYJPony5EWU+tgd2K06Gdx5SmkfQ0Z/baqGBaw=;
 b=e2inwZFpZwbquhjGFS7bXn6r+pyeVW4U571YhLVJ8Q16KmwT5bm2/opNficN1EHADdBU
 DDlpNZ1f/EFKqL4m523BKkQqvLFqkNa6PdT123blWfldCWNsIm8Kr/onjooOJlQgxqEbj
 7Jp0TlPv42iJwrN8WhmivtLqUHQRqAnIiCLUTX96Yee6S1Lkc7Dx2/i+XtB3zitrHtP58
 qc/0CVqZybs8NgIj66M4CEpz1QDSG1JvpuIur7KLpkp9xokiDftpBWY7rSCWohdPe5gPx
 XirZgi1SfT1R1sk+0raPEaXdETevk/TG9sFmcfTIp3uKxlJBX94ncJHPprED0RADlsw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OP4fKYYY; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=OP4fKYYY
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E3FB811FD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:24:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B0584009C;
 Fri, 25 Sep 2026 17:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7ED1F000FF;
 Fri, 25 Sep 2026 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790357046;
 bh=faooqxYJPony5EWU+tgd2K06Gdx5SmkfQ0Z/baqGBaw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OP4fKYYYvntsOjTmDTHk0+6+3gfdpNbExzjWXiCYT427MOPgI+yRvKLutwkquuzSf
 ftpRKzLiz8Ctv313h7LqEiYhtZQ93aFkd+OY/K3T7mCSw0lvblIZ09xmQko3WUcoTU
 5wqFK91x0ho4zQBKq0x+ky57YL01JXS9Av/cbCNNtqlflgDrzopkEeqQ8q7kkGlyrZ
 N7RojuA5UlzwFOb0qlCw/ZyNCJMf14D9LJEthfPq8jk2sJYGOLJ1VJTK1cebcnotPK
 5wJ7XoAKzp6hxRKPuWgoOPJUqPFLjSmT95gJaM3mkO6FWbRmT4iz1Qk9L2gxfi8RJj
 U0FWPsvf7Gjxw==
Date: Fri, 25 Sep 2026 18:24:03 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net  v2 4/4] ixgbe: Implement PCI reset handler
Message-ID: <20260925172403.GV13925@horms.kernel.org>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
 <20260922113558.2288111-5-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922113558.2288111-5-sergey.temerkhanov@intel.com>
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

On Tue, Sep 22, 2026 at 11:35:58AM +0000, Sergey Temerkhanov wrote:
> Implement PCI device reset handler to allow the network device to
> get re-initialized and function after a PCI-level reset.
> 
> This is necessary for the adapter to avoid TX queue timeouts
> occurring after the PCI reset is performed via sysfs during
> its operation.
> 
> The reset codepath may trigger a number of dependencies in the
> reset of the driver, so that it is necessary to check if
> the netdev is present and running there.
> 
> Fixes: 711d57796f5c ("PCI: expose function reset capability in sysfs")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

