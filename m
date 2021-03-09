From: Leon Romanovsky <leon@kernel.org>
Date: Tue, 9 Mar 2021 08:09:34 +0200
Subject: [Intel-wired-lan] [RFC net-next] iavf: refactor plan proposal
In-Reply-To: <20210308162858.00004535@intel.com>
References: <20210308162858.00004535@intel.com>
Message-ID: <YEcRHkhJIkZnTgza@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 08, 2021 at 04:28:58PM -0800, Jesse Brandeburg wrote:
> Hello,
>
> We plan to refactor the iavf module and would appreciate community and
> maintainer feedback on our plans.  We want to do this to realize the
> usefulness of the common code module for multiple drivers.  This
> proposal aims to avoid disrupting current users.
>
> The steps we plan are something like:
> 1) Continue upstreaming of the iecm module (common module) and
>    the initial feature set for the idpf driver[1] utilizing iecm.
> 2) Introduce the refactored iavf code as a "new" iavf driver with the
>    same device ID, but Kconfig default to =n to enable testing.
> 	a. Make this exclusive so if someone opts in to "new" iavf,
> 	   then it disables the original iavf (?)
> 	b. If we do make it exclusive in Kconfig can we use the same
> 	   name?
> 3) Plan is to make the "new" iavf driver the default iavf once
>    extensive regression testing can be completed.
> 	a. Current proposal is to make CONFIG_IAVF have a sub-option
> 	   CONFIG_IAVF_V2 that lets the user adopt the new code,
> 	   without changing the config for existing users or breaking
> 	   them.

I don't think that .config options are considered ABIs, so it is unclear
what do you mean by saying "disrupting current users". Instead of the
complication wrote above, do like any other driver does: perform your
testing, submit the code and switch to the new code at the same time.

>
> We are looking to make sure that the mode of our refactoring will meet
> the community's expectations. Any advice or feedback is appreciated.
>
> Thanks,
> Jesse, Alice, Alan
>
> [1]
> https://lore.kernel.org/netdev/20200824173306.3178343-1-anthony.l.nguyen at intel.com/

Please don't introduce module parameters in new code.

Thanks
