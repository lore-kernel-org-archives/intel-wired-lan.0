From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 19:46:55 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: make use
	of	hlist_for_each_entry_continue
In-Reply-To: <20170307231752.21671-1-jacob.e.keller@intel.com>
References: <20170307231752.21671-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A104065CE@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, March 7, 2017 3:18 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH] i40e: make use of
> hlist_for_each_entry_continue
> 
> Replace a complex if->continue->else->break construction in
> i40e_next_filter. We can simply use hlist_for_each_entry_continue instead.
> This drops a lot of confusing code. The resulting code is much easier to
> understand the intention, and follows the more normal pattern for using hlist
> loops. We could have also used a break with a "return next" at the end of the
> function, instead of return NULL, but the current implementation is explicitly
> clear that when you reach the end of the loop you get a NULL value. The
> alternative construction is less clear since the reader would have to know
> that next is NULL at the end of the loop.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: Ife74ca451dd79d7f0d93c672bd42092d324d4a03
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


