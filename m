From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 20 Sep 2021 13:39:15 -0700
Subject: [Intel-wired-lan] [PATCH net-next] devlink: Make
 devlink_register to be void
In-Reply-To: <2e089a45e03db31bf451d768fc588c02a2f781e8.1632148852.git.leonro@nvidia.com>
References: <2e089a45e03db31bf451d768fc588c02a2f781e8.1632148852.git.leonro@nvidia.com>
Message-ID: <20210920133915.59ddfeef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 20 Sep 2021 17:41:44 +0300 Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> devlink_register() can't fail and always returns success, but all drivers
> are obligated to check returned status anyway. This adds a lot of boilerplate
> code to handle impossible flow.
> 
> Make devlink_register() void and simplify the drivers that use that
> API call.

Unlike unused functions bringing back error handling may be
non-trivial. I'd rather you deferred such cleanups until you're 
ready to post your full rework and therefore give us some confidence 
the revert will not be needed.
