From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 19:45:47 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/2] i40e: check current
	configured	input set when adding ntuple filters
In-Reply-To: <20170307230523.28702-2-jacob.e.keller@intel.com>
References: <20170307230523.28702-1-jacob.e.keller@intel.com>
 <20170307230523.28702-2-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A104065B6@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, March 7, 2017 3:05 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v2 2/2] i40e: check current configured input
> set when adding ntuple filters
> 
> Do not assume that hardware has been programmed with the default mask,
> but instead read the input set registers to determine what is currently
> programmed. This ensures that all programmed filters match exactly how the
> hardware will interpret them, avoiding confusion regarding filter behavior.
> 
> This sets the initial ground-work for allowing custom input sets where some
> fields are disabled. A future patch will fully implement this feature.
> 
> Instead of using bitwise negation, we'll just explicitly check for the correct
> value. The use of htonl and htons are used to silence sparse warnings. The
> compiler should be able to handle the constant value and avoid actually
> performing a byteswap>
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: 3d8db46cb28ea0afdaac8c5b31a2bfb90e3a4102
> ---
> This is a new version of "[PART2,2/9] i40e: check current configured input set
> when adding ntuple filters"
> 
>  drivers/net/ethernet/intel/i40e/i40e.h         |  19 ++++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 117
> +++++++++++++++++++++----
>  2 files changed, 121 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


