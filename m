From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Aug 2018 18:34:51 +0000
Subject: [Intel-wired-lan] [next PATCH S93 11/11] i40e: fix
 i40e_add_queue_stats data pointer update
In-Reply-To: <20180731104148.11896-11-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
 <20180731104148.11896-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DB3B3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 31, 2018 3:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S93 11/11] i40e: fix
> i40e_add_queue_stats data pointer update
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This function accidentally failed to update the data pointer, which caused the
> reported stats to be incorrect. Additionally, statistics which follow queue
> stats in the output would potentially read non-zeroed garbage data from the
> ethtool buffer.
> 
> This occurred because the data double pointer was not dereferenced before
> incrementing the size.
> 
> Additionally, make sure this issue is more visible by adding a WARN_ONCE to
> the i40e_get_ethtool_stats function. This warning will trigger whenever the
> data pointer is not at the expected address, similar to the check that we
> make in the i40e_get_stat_strings() function.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


