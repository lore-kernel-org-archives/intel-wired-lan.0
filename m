From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 21 Sep 2021 05:39:56 -0700
Subject: [Intel-wired-lan] [PATCH net-next] devlink: Make
 devlink_register to be void
In-Reply-To: <YUlBGk2Mq3iYhtku@unreal>
References: <2e089a45e03db31bf451d768fc588c02a2f781e8.1632148852.git.leonro@nvidia.com>
 <20210920133915.59ddfeef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210920140407.0732b3d0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YUlBGk2Mq3iYhtku@unreal>
Message-ID: <20210921053956.11ac7156@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 21 Sep 2021 05:19:06 +0300 Leon Romanovsky wrote:
> On Mon, Sep 20, 2021 at 02:04:07PM -0700, Jakub Kicinski wrote:
> > On Mon, 20 Sep 2021 13:39:15 -0700 Jakub Kicinski wrote:  
> > > On Mon, 20 Sep 2021 17:41:44 +0300 Leon Romanovsky wrote:  
>  [...]  
> > > 
> > > Unlike unused functions bringing back error handling may be
> > > non-trivial. I'd rather you deferred such cleanups until you're 
> > > ready to post your full rework and therefore give us some confidence 
> > > the revert will not be needed.  
> > 
> > If you disagree you gotta repost, new devlink_register call got added
> > in the meantime.  
> 
> This is exactly what I afraid, new devlink API users are added faster
> than I can cleanup them.
> 
> For example, let's take a look on newly added ipc_devlink_init(), it is
> called conditionally "if (stage == IPC_MEM_EXEC_STAGE_BOOT) {". How can
> it be different stage if we are in driver .probe() routine?
> 
> They also introduced devlink_sio.devlink_read_pend and
> devlink_sio.read_sem to protect from something that right position of
> devlink_register() will fix. I also have serious doubts that their
> current protection is correct, once they called to devlink_params_publish()
> the user can crash the system, because he can access the parameters before
> they initialized their protection.
> 
> So yes, I disagree. We will need to make sure that devlink_register()
> can't fail and it will make life easier for everyone (no need to unwind)
> while we put that command  being last in probe sequence.

Remains to be seen if return type makes people follow correct ordering.

> If I repost, will you take it? I don't want to waste anyone time if it
> is not.

Yeah, go for it.
