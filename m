From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:28:56 +0000
Subject: [Intel-wired-lan] [next PATCH S85-V1 08/14] i40e: use
 changed_flags to check I40E_FLAG_DISABLE_FW_LLDP
In-Reply-To: <20171229135034.14504-1-alice.michael@intel.com>
References: <20171229135034.14504-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7237@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, December 29, 2017 5:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S85-V1 08/14] i40e: use changed_flags
> to check I40E_FLAG_DISABLE_FW_LLDP
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Currently in i40e_set_priv_flags we use new_flags to check for the
> I40E_FLAG_DISABLE_FW_LLDP flag.  This is an issue for a few a reasons.
> DISABLE_FW_LLDP is persistent across reboots/driver reloads.  This means
> we need some way to detect if FW LLDP is enabled on init.  We do this by
> trying to init_dcb and if it fails with EPERM we know LLDP is disabled in FW.
> 
> This could be a problem on older FW versions or NPAR enabled PFs because
> there are situations where the FW could disable LLDP, but they do _not_
> support using this flag to change it.  If we do end up in this situation, the flag
> will be set, then when the user tries to change any priv flags, the driver
> thinks the user is trying to disable FW LLDP on a FW that doesn't support it
> and essentially forbids any priv flag changes.
> 
> The fix is simple, instead of checking if this flag is set, we should be checking
> if the user is trying to _change_ the flag on unsupported FW versions.
> 
> This patch also adds a comment explaining that the cmpxchg is the point of
> no return.  Once we put the new flags into pf->flags we can't back out.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 22 +++++++++++++++-----
> --
>  1 file changed, 15 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


