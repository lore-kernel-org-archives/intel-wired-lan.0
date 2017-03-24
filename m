From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Mar 2017 18:25:29 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: initialize params before
 notifying	of l2_param_changes
In-Reply-To: <20170320234535.27900-1-jacob.e.keller@intel.com>
References: <20170320234535.27900-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10409FB5@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, March 20, 2017 4:46 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; Colin Ian King
> <colin.king@canonical.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: initialize params before notifying of
> l2_param_changes
> 
> Probably due to some mis-merging fix a bug associated with commits
> d7ce6422d6e6 ("i40e: don't check params until after checking for client
> instance", 2017-02-09) and 3140aa9a78c9 ("i40e: KISS the client interface",
> 2017-03-14)
> 
> The first commit tried to move the initialization of the params structure so
> that we didn't bother doing this if we didn't have a client interface. You can
> already see that it looks fishy because of the indentation. The second commit
> refactors a bunch of the interface, and incorrectly drops the params
> initialization.
> 
> I believe what occurred is that internally the two patches were re-ordered,
> and the merge conflicts as a result were performed incorrectly.
> 
> Fix the use of an uninitialized variable by correctly initializing the params
> variable via i40e_client_get_params().
> 
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


