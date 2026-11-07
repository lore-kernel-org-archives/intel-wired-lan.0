Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D7606A32D
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=f4I/E9tC;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTUdP6i/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DDBF60719;
	Sat,  7 Nov 2026 12:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZFnPvkQX7798; Sat,  7 Nov 2026 12:11:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8147960746
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794053499;
	b=ablpGy2zUjljG9Dv/SbC8bWR60JsNQsmbZ6qGJ4gwRXqptye/y1/ZPbrXYbJOkx9ONtP
	 YjDucT6PIG5jrPv6s7bdRSbP3PYvzxiM3OX5TBr49kQGSWSz7e7P10wp53QrCUW8Dgt5t
	 cxOP3dj7iJxTjlugUBal9/rta9pkouzcCHEBStwAgakjQF/ZTRID58WkwgLcbqYK8UjXh
	 EQuRRMgIvbPATgjXrlJgQ9jFDvtPp19AypaAXLXJmapTi+ihiMGxClxAhLCBD4aP3e1mr
	 gtzZB8rzW2HOWZ38qkFYBde2DeoBQbBRTmcRuWiGSv+tCb2wK4HOW3ABgXUelywNshA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794053499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=kqUHIunmWDUnSQI5szauZxb5jH74MIZqkvXkT+EW9E8=;
	b=AIgzvhtWUR6iCvK9V63k8KG9ggCALKlE1d+3cejQjW3q2sBM7jSm3eWyN6m/zFjjXfZR
	 xafvX6g3lhuBtYdOC54EzlEhaWouvaGnuMmNWIEylMQ2yTakreexFmYz4liV0hPpaMVK4
	 I/6xJsN7JCRAAw5pSP+SwWg2BIshOOLTNMLGe50FvW5DUipRm2pKp/AuvvmpK5BcM+/nC
	 7kUW5tVmGkGFm7sIoQGQpoeVsfXQP+OyOAHTdVIeFl0RwaKg20I60gA/SkAxQbJhpQ3pw
	 1W++b/+UxaAadyiIjodpb2qunmvHm3NV8YfVt50YE0XsTG8Hm2O4KSkJlyzS9UevW8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794053499;
	bh=kqUHIunmWDUnSQI5szauZxb5jH74MIZqkvXkT+EW9E8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=f4I/E9tC8p7tcEfNbSDxwE6TfDjS1w9+vOAjnq6q8dAa9MtB3FNixiMrstg2rdrDm
	 E1ziiKr2iXv47rsD1TIkJOnxpzLKcI1YWFVjspfA2W24o3uI7P1rw15qoNsWAQUlZU
	 Frxb3CJJJqAYl3wtnv3aOCrWfnL6kIWgkhyPfPzTIwlwu73bWbfzvXpQxnTe7X8TrB
	 eVhYkXvTF0aNx5ieO4b7A9xRHhkbAbu6kTg0mkyrjB4JwgHHmKBGPsp8Tcjh2az0gn
	 WWeJJsVBqS2wVsvD5ylplsRMoZuuKG4iTtMEEzuzMHanYqwm2tokAG0ZkNQYLMQaPx
	 CdQxYep0YR03A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8147960746;
	Sat,  7 Nov 2026 12:11:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 37E94211
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 12:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29D8C40111
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 12:11:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sTDch73PHqvs for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 12:11:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5156F40079
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=hTUdP6i/
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5156F40079
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 12:11:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D905643D27;
 Sat,  7 Nov 2026 12:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE001F0089F;
 Sat,  7 Nov 2026 12:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794053496;
 bh=kqUHIunmWDUnSQI5szauZxb5jH74MIZqkvXkT+EW9E8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hTUdP6i/vydJUv/2xHL/w0pWqYCqK3a69JbmHd+sSc+P9vhfoU6166TvrGtOkGEQI
 u8vYGcRIJoRDsljikXFbdKV+DSb7TgKFGjI0w95EhjEMt+BbpHDgAtGKJXeJc8Ney1
 5yXavaddndGeyHj944KAKGe+SaIWDJRBxSKazYNVfHwPC1ma8KhJUXX+nmY2BAt+Ox
 ko/qLOM+AxLfx/qlKyO5ecweKPdhledP5Lvu0fvPIIU/VIcZ03c++TpQBaowqfoQdI
 PkrWJ8uBt/cdy+QBiodDxBtY+IHCOVyW8ukThP+wse8/ZUjhRmjy8zDRmE5rn12CZe
 iMy3zhROf8n1A==
Message-ID: <sashiko-outbox-202878@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 06/10] dpll: add KUnit tests for core locking
To: "Ivan Vecera" <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261106121005.1327603-7-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-7-ivecera@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 12:11:36 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dpll: dt_fwnode_pin_add() duplicates
  kunit_fwnode_create_software_node()
--

commit cb6cfd6901bcce17d3e841bfa531bd7cce8efeac
Author: Ivan Vecera <ivecera@redhat.com>

dpll: add KUnit tests for core locking

This commit adds KUnit tests using a mock driver to verify domain locking,
callback serialization, cross-domain pin registrations, and notification
ordering in the DPLL core.

> diff --git a/drivers/dpll/dpll_core_kunit.c b/drivers/dpll/dpll_core_kuni=
t.c
> new file mode 100644
> index 0000000000000..a58800eda5ff5
> --- /dev/null
> +++ b/drivers/dpll/dpll_core_kunit.c
[ ... ]
> +static void dt_fwnode_release(void *data)
> +{
> +	fwnode_remove_software_node(data);
> +}
> +
> +/* Creates a pin with a fwnode so that it can be registered with another=
 dpll */
> +static void dt_fwnode_pin_add(struct kunit *test, struct dt_pin *pin,
> +			      u64 clock_id, u32 idx)
> +{
> +	struct fwnode_handle *fwnode;
> +
> +	fwnode =3D fwnode_create_software_node(NULL, NULL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
> +	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dt_fwnode_release,
> +							fwnode), 0);
> +	dt_pin_add(test, pin, clock_id, idx, &dt_prop);
> +	dpll_pin_fwnode_set(pin->pin, fwnode);
> +}

[Severity: Low]
This isn't a bug, but could dt_fwnode_pin_add() use
kunit_fwnode_create_software_node(test, NULL, NULL) from
include/kunit/fwnode.h instead of open-coding fwnode_create_software_node()
and the dt_fwnode_release() cleanup action?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106121005.1327=
603-1-ivecera@redhat.com?part=3D6
