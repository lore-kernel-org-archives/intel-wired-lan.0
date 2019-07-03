From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 21:39:33 +0000
Subject: [Intel-wired-lan] [next PATCH S7 3/9] i40e: Log disable-fw-lldp
 flag change by ethtool
In-Reply-To: <20190702122259.79070-3-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
 <20190702122259.79070-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD241@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 2, 2019 5:23 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Laba, SlawomirX <slawomirx.laba@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S7 3/9] i40e: Log disable-fw-lldp flag
> change by ethtool
> 
> From: Slawomir Laba <slawomirx.laba@intel.com>
> 
> Add logging for disable-fw-lldp flag by ethtool. Added check for
> I40E_FLAG_DISABLE_FW_LLDP and logging state in dmesg.
> Without this commit there was no clear statement in dmesg about FW LLDP
> state in dmesg.
> 
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
>  1 file changed, 5 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


