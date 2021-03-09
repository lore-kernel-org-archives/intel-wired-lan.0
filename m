From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 9 Mar 2021 14:17:38 -0800
Subject: [Intel-wired-lan] [RFC net-next] iavf: refactor plan proposal
In-Reply-To: <20210308162858.00004535@intel.com>
References: <20210308162858.00004535@intel.com>
Message-ID: <20210309141738.379feab3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 8 Mar 2021 16:28:58 -0800 Jesse Brandeburg wrote:
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

Oh, that's still going? there wasn't any revision for such a long time
I deleted my notes :-o

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
> 
> We are looking to make sure that the mode of our refactoring will meet
> the community's expectations. Any advice or feedback is appreciated.

Sounds like a slow, drawn out process painful to everyone involved.

The driver is upstream. My humble preference is that Intel sends small
logical changes we can review, and preserve a meaningful git history.

