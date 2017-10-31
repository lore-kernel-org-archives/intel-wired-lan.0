From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Oct 2017 19:06:08 +0000
Subject: [Intel-wired-lan] [next PATCH S81-V3 6/9] i40e: update VFs of
 link	state after GET_VF_RESOURCES
In-Reply-To: <20171027150656.68250-6-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
 <20171027150656.68250-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADD5F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, October 27, 2017 8:07 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S81-V3 6/9] i40e: update VFs of link
> state after GET_VF_RESOURCES
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We currently notify a VF of the link state after ENABLE_QUEUES, which is the
> last thing a VF does after being configured. Guests may not actually
> ENABLE_QUEUES until they get configured, and thus between driver load
> and device configuration the VF may show inaccurate link status.
> 
> Fix this by also sending the link state after GET_VF_RESOURCES. Although we
> could remove the message following ENABLE_QUEUES, it's not that
> significant of a loss, so this patch just keeps both to ensure maximum
> compatibility with guests on various OSes.
> 
> Specifically, without this patch guests running FreeBSD will display inaccurate
> link state until the device is brought up. This is mostly a cosmetic issue but
> can be confusing to system administrators.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


