From: Jiri Pirko <jiri@resnulli.us>
Date: Tue, 21 Sep 2021 09:02:23 +0200
Subject: [Intel-wired-lan] [PATCH net-next] devlink: Make
 devlink_register to be void
In-Reply-To: <20210920133915.59ddfeef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <2e089a45e03db31bf451d768fc588c02a2f781e8.1632148852.git.leonro@nvidia.com>
 <20210920133915.59ddfeef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <YUmDf3KdLS/4FwoT@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Mon, Sep 20, 2021 at 10:39:15PM CEST, kuba at kernel.org wrote:
>On Mon, 20 Sep 2021 17:41:44 +0300 Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@nvidia.com>
>> 
>> devlink_register() can't fail and always returns success, but all drivers
>> are obligated to check returned status anyway. This adds a lot of boilerplate
>> code to handle impossible flow.
>> 
>> Make devlink_register() void and simplify the drivers that use that
>> API call.
>
>Unlike unused functions bringing back error handling may be
>non-trivial. I'd rather you deferred such cleanups until you're 
>ready to post your full rework and therefore give us some confidence 
>the revert will not be needed.

Well, that was the original reason why I made it to return int, so the
drivers are prepared. But truth is that given the time this is on and
the need to return int never really materialized, I tend to ack with the
cleanup.
