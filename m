From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jan 2018 22:12:46 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 07/13] i40e: Implement an
 ethtool private flag to stop LLDP in FW
In-Reply-To: <20171227131821.23877-1-alice.michael@intel.com>
References: <20171227131821.23877-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7037@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 5:18 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S84-V2 07/13] i40e: Implement an
> ethtool private flag to stop LLDP in FW
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Implement the private flag disable-fw-lldp for ethtool to disable the
> processing of LLDP packets by the FW.
> This will stop the FW from consuming LLDPDU and cause them to be sent up
> the stack.
> 
> The FW is also being configured to apply a default DCB configuration on link
> up.
> 
> Toggling the value of this flag will also cause a PF reset.
> 
> Disabling FW DCB will also disable DCBX.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 47
> +++++++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 14 ++++++--
>  2 files changed, 58 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


