From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Oct 2016 19:32:04 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 08/15] i40e: properly
 cleanup	on allocation failure in i40e_sync_vsi_filters
In-Reply-To: <1475685046-16900-9-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FCAA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S49-V2 08/15] i40e: properly cleanup
> on allocation failure in i40e_sync_vsi_filters
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Currently, we fail to correctly restore filters on the temporary add list when
> we fail to allocate memory either for deletion or addition.
> Replace calls to "goto out;" with calls to a new location that correctly handles
> memory allocation failures.
> 
> Note that it is safe for us to call i40e_undo_filter_entries on the tmp_del_list
> even after we've deleted filters because at this point it will be empty, so we
> don't need to separate the logic for add and delete failure.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: Iee107fd219c6e03e2fd9645c2debf8e8384a8521
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 39 ++++++++++++++++-------
> ------
>  1 file changed, 22 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


