Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9855606A327
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=hdm+/+9G;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaXb93M2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CAF340534;
	Tue, 10 Nov 2026 17:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CCUunAWtRjOr; Tue, 10 Nov 2026 17:53:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9EF8240555
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794333212;
	b=I8jCO/Cr+84Knu5aDpJIJtpc4JxrC3dl7zpp97PchDzb5/EwGWMdojNIyONAVM9b1ewf
	 1fzP0U1ogkBjz7YKQHuirP62DAb18yVDDZ3mtFZUbUF+j+epFKI2NqLgDB4iTBpV0Mf5H
	 puxFxteLacG9HUF9eulmyLSsYeIxRQDLnK4JaihqG6+PlpkEdwTlt+ELQJ4Zk7ZRHpoWB
	 i4L/u9x9GrNjPugIviCASQjexOeZUvMhRwtYoyhDYud93YyyasY6tWULptcZ2QEgPHmDN
	 3GVMBN9uxCLhfmVnVS8r/aGz/Mv00j5PYb5sz0j/M0+/+CPhnHJqzRiBwwoAuZy91pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794333212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=H4LlDob9KtsWjhJ6bgkzIx99XQ1EqBXecgkfD3zBoZ8=;
	b=DjlZ0+CgfK2xx/9hOY5xK3UTLR+FyBrdn1aLWtReadiC45EQ6KdMYPNF/IdyBe0F/O+k
	 vfEljDL00QF73ybD0g4vDXidFNSpm4RaH7cUPIE9e/FgxCmeYyjOUieAVZyJ0YzLruNl/
	 ok9BTKgtqotpr36C3hTLz38DaxzBaq5pDalxQs8BTrkGb7t/QyPMqbpy/1BP7I+LmUOIp
	 zmyYbFe3zU7sXbqpABX5nBn3RNV16rBN1t7qiilyK/jnQw2yxzPFbti8mXIJWJEoBrxDB
	 j+dkdRmXcE1bQTLyuAq5cqo/4wCT4EQzqD7ut7/8oQ+U3exCkpICeaH/4pC+C/Qoaiw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaXb93M2;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794333212;
	bh=H4LlDob9KtsWjhJ6bgkzIx99XQ1EqBXecgkfD3zBoZ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hdm+/+9G+VbB2yY4XI4b7wESzQ0C+IcskQMcIRN/rxIWMb/u/iRyfeTuh5/D0RNyM
	 zMj3wMNh/M6S16gXgGeT8Sg6hRmYzR0i5XKCsCUulp+nuULxn+pILPRGdwFbF6oLHp
	 yGRIFiOgjs+OXF+YGUve49g7zFG+ulMB++N0fucLTSXRynnlxZ5WLfpbaqnnIQ9v2T
	 cqw09L0a0XcNcyW1hgBi9n1bLXxY+rdjLJtkrxE3hq7H0bgpDfZxV1BtzHmdT0M/ZN
	 EkeYUoy8t9O+F3GSBHQvub3fdsiZ4KXLK5196P2XxBMsj1TXICkbYhupBNLwvg+nja
	 ghei0hoX0Z6sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EF8240555;
	Tue, 10 Nov 2026 17:53:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CA5528C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E64840534
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id on0U9FNP5jZh for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 17:53:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1743040A04
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=OaXb93M2
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1743040A04
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF0EC63ACE;
 Tue, 10 Nov 2026 17:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9CE1F008A2;
 Tue, 10 Nov 2026 17:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794333208;
 bh=H4LlDob9KtsWjhJ6bgkzIx99XQ1EqBXecgkfD3zBoZ8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=OaXb93M2qPN1jKc+CLbMNVqJHa6R2KifUhQQIXEM6mdwv23em48/HN7gKtNRh+D3N
 1zNSYtv4VxMnxEH1uYz0N9Cp3R1oGn4E3ion1nKZbPa7b96Uhg2+67Ixja/duVb9uE
 ctObYjhphhiHbZlFwgK86sd1iRnp3oggu4W1JullH2zWTAt7UEmgstbldbaw1T/T9j
 GVsMW90tWiEptCrU900jKzOJYux3WZAmXrglRkEb7ysZhBLiJIWQNYulWEhenwi0RL
 8Dec667jrXNrZ1o8gWKDRio1s6qW9vdyoIcYsK68kge4V6/wJAwNIP6cwmfL0wZ21+
 QDAko4JCtTKtA==
Subject: Re: [PATCH net-next 06/10] dpll: add KUnit tests for core locking
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
Date: Tue, 10 Nov 2026 17:53:26 +0000
Message-ID: <179433320676.994134.7049432410059447687@kernel.org>
In-Reply-To: <20261106121005.1327603-7-ivecera@redhat.com>
References: <20261106121005.1327603-7-ivecera@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/dpll/dpll_core_kunit.c, some tests set a blocking
  flag before dt_req_start() has registered dt_req_release().

--

dpll: add KUnit tests for core locking

This adds KUnit tests for DPLL core locking. They use a mock driver with
several domains to check domain sharing, which locks callbacks hold,
independence and serialization of domains, atomicity of multi-attribute
pin sets, and notification ordering. The netlink pre/post doit and set
handlers are exported for KUnit so the tests can call them directly.

> diff --git a/drivers/dpll/dpll_core_kunit.c b/drivers/dpll/dpll_core_kunit.c
> new file mode 100644
> index 0000000000000..a58800eda5ff5
> --- /dev/null
> +++ b/drivers/dpll/dpll_core_kunit.c
> @@ -0,0 +1,1471 @@

[ ... ]

> +static void dt_block(struct dt_dom *dom, bool *block)
> +{
> +	complete(&dom->entered);
> +	wait_event(dom->ctx->wq, !READ_ONCE(*block));
> +}

[ ... ]

> +static struct dt_req *dt_req_start(struct kunit *test, int (*fn)(void *arg),
> +				   void *arg)
> +{
> +	struct task_struct *task;
> +	struct dt_req *req;
> +
> +	req = kunit_kzalloc(test, sizeof(*req), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, req);
> +
> +	req->ctx = test->priv;
> +	req->fn = fn;
> +	req->arg = arg;
> +	init_completion(&req->done);
> +
> +	task = kthread_run(dt_req_thread, req, "dpll-test");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, task);
> +	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dt_req_release,
> +							req), 0);
> +
> +	return req;
> +}

[ ... ]

> +/* Blocks a request of @dom in a callback, which holds the domain lock */
> +static struct dt_req *dt_block_in(struct kunit *test, struct dt_dom *dom,
> +				  int (*fn)(void *arg), void *arg)
> +{
> +	struct dt_req *req;
> +
> +	WRITE_ONCE(dom->block, true);
> +	req = dt_req_start(test, fn, arg);

[Severity: Medium]
Can the teardown hang here if dt_req_start() fails one of its assertions?

dom->block is set before dt_req_start() registers dt_req_release(), and
dt_req_release() is the only cleanup action that calls dt_unblock(). If
kunit_kzalloc() or kthread_run() in dt_req_start() fails, the
KUNIT_ASSERT_NOT_NULL() or KUNIT_ASSERT_NOT_ERR_OR_NULL() check aborts the
test and the flag stays set.

The cleanup actions that were already registered then run, for example:

dt_reg_release()
  dpll_pin_unregister()
    down_write(&dpll_lock)
    __dpll_pin_unregister()
      dpll_pin_delete_ntf()
        mutex_lock(&pin->domain->lock)
        dpll_pin_event_send()
          dpll_cmd_pin_get_one()
            pin get callbacks
              dt_pin_enter()->dt_enter()->dt_block()

dt_block() then waits with:

    wait_event(dom->ctx->wq, !READ_ONCE(*block));

Nothing is left that can clear the flag. The KUnit cleanup thread would
sleep uninterruptibly while holding dpll_lock for write and a domain
mutex. Every other DPLL user in the system would then block behind it.

dt_test_stuck_foreign_device() has the same problem:

    WRITE_ONCE(ctx->f0.block, true);
    blocked = dt_req_start(test, dt_device_ntf, &ctx->f0);

There, dt_dev_release()->dpll_device_unregister()->dpll_device_delete_ntf()
->dpll_device_get_one()->dt_mode_get()->dt_dev_enter() would reach
dt_block() on f0.block.

One option is to register a cleanup action that calls dt_unblock() from
dt_init(), before any flag can be set. Another is to set the flags only
after dt_req_release() has been registered. Would either of these work?

Setting block_prio_set early looks harmless, since no teardown path calls
prio_set.

> +	KUNIT_ASSERT_TRUE(test, wait_for_completion_timeout(&dom->entered,
> +							    DT_TIMEOUT));
> +
> +	return req;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
