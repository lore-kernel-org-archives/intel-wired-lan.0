From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Aug 2019 16:28:37 +0000
Subject: [Intel-wired-lan] [next PATCH S9 5/7] i40e: fix missed
 "Negotiated" string in i40e_print_link_message()
In-Reply-To: <20190826181655.15106-5-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
 <20190826181655.15106-5-alice.michael@intel.com>
Message-ID: <5c1f4aff2b7f452e85883feeb4b0995d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 26, 2019 11:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S9 5/7] i40e: fix missed "Negotiated"
> string in i40e_print_link_message()
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> The "Negotiated" string in i40e_print_link_message() function was missed.
> This string has been added to the dmesg and small refactoring done
> removing common substrings and unifying link status message format.
> Without this patch it was not clear that FEC is related to negotiated FEC.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


