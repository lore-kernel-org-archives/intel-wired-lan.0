From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Jul 2017 18:15:10 +0000
Subject: [Intel-wired-lan] [next PATCH S76-V2 10/13] i40e: Fix link
	down	message when interface is brought up
In-Reply-To: <20170714131019.52530-10-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
 <20170714131019.52530-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB2603@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:10 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Mogilappagari at osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S76-V2 10/13] i40e: Fix link down
> message when interface is brought up
> 
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> i40e_print_link_message() is intended to compare new link state with
> current link state and print log message only if the new state is different from
> current state.
> 
> However in current driver the new state does not get updated when link is
> going down because of the if condition. When an interface is brought down,
> vsi->state is set to I40E_VSI_DOWN in i40e_vsi_close() and later
> i40e_print_link_message() does not get invoked in i40e_link_event due to if
> condition. Hence link down message doesn't appear when link is going down.
> The down state is seen  later during i40e_open() and old state gets printed.
> The actual link state doesn't get updated in
> i40e_close() or i40e_open() but when i40e_handle_link_event is called inside
> i40e_clean_adminq_subtask.
> 
> This change allows i40e_print_link_message() to be called when interface is
> going down and keeps the state information updated.
> 
> Signed-off-by: Mogilappagari, Sudheer <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


