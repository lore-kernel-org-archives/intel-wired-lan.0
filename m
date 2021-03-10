From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 9 Mar 2021 21:11:46 -0800
Subject: [Intel-wired-lan] [RFC net-next] iavf: refactor plan proposal
In-Reply-To: <YEcRHkhJIkZnTgza@unreal>
References: <20210308162858.00004535@intel.com>
	<YEcRHkhJIkZnTgza@unreal>
Message-ID: <20210309211146.00002f2d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Leon Romanovsky wrote:

> > 3) Plan is to make the "new" iavf driver the default iavf once
> >    extensive regression testing can be completed.
> > 	a. Current proposal is to make CONFIG_IAVF have a sub-option
> > 	   CONFIG_IAVF_V2 that lets the user adopt the new code,
> > 	   without changing the config for existing users or breaking
> > 	   them.
> 
> I don't think that .config options are considered ABIs, so it is unclear
> what do you mean by saying "disrupting current users". Instead of the
> complication wrote above, do like any other driver does: perform your
> testing, submit the code and switch to the new code at the same time.

Because this VF driver runs on multiple hardware PFs (they all expose
the same VF device ID) the testing matrix is quite huge and will take
us a while to get through it. We aim to avoid making users's life hard
by having CONFIG_IAVF=m become a surprise new code base behind the back
of the user.

I've always thought that the .config options *are* a sort of ABI,
because when you do "make oldconfig" it tries to pick up your previous
configuration and if, for instance, a driver changes it's Kconfig name,
it will not pick up the old value of the old driver Kconfig name for
the new build, and with either default or ask the user. The way we're
proposing I think will allow the old driver to stay default until the
user answers Y to the "new option" for the new, iecm based code.

> > [1]
> > https://lore.kernel.org/netdev/20200824173306.3178343-1-anthony.l.nguyen at intel.com/
> 
> Please don't introduce module parameters in new code.

Thanks, we certainly won't. :-)
I'm not sure why you commented about module parameters, but the above
link is to the previous submission for a new driver that uses some
common code as a module (iecm) for a new device driver (idpf) we had
sent. The point of this email was to solicit feedback and give notice
about doing a complicated refactor/replace where we end up re-using
iecm for the new version of the iavf code, with the intent to be up
front and working with the community throughout the process. Because of
the complexity, we want do the right thing the first time so we can to
avoid a restart/redesign.

Thanks,
 Jesse
