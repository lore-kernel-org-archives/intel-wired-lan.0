From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 17:50:17 +0000
Subject: [Intel-wired-lan] [PART2 PATCH 2/9] i40e: check current
 configured	input set when adding ntuple filters
In-Reply-To: <20170206223852.31177-3-jacob.e.keller@intel.com>
References: <20170206223852.31177-1-jacob.e.keller@intel.com>
 <20170206223852.31177-3-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040639E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, February 6, 2017 2:39 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PART2 PATCH 2/9] i40e: check current configured
> input set when adding ntuple filters
> 
> Do not assume that hardware has been programmed with the default mask,
> but instead read the input set registers to determine what is currently
> programmed. This ensures that all programmed filters match exactly how the
> hardware will interpret them, avoiding confusion regarding filter behavior.
> 
> This sets the initial ground-work for allowing custom input sets where some
> fields are disabled. A future patch will fully implement this feature.
> 
> The use of ntohl and ntohs is not strictly necessary for correctness, but it
> helps avoid a sparse warning due to the construction of "!~<be16>" degrades
> the be16 value into an integer when doing negation.
> This could alternatively be fixed by the following code construction without
> the byteswaps,
> 
>   if (!<value>)
>     <disable field>
>   else if (~<value>)
>     <return error>
>   else
>     <enable field>
> 
> However, this construction is confusing because the error return occurs in
> the middle, which is misleading to other readers. Additionally, it makes the
> condition for the <enable field> much more difficult to process due to it
> being in an else statement.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: 3d8db46cb28ea0afdaac8c5b31a2bfb90e3a4102
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  19 ++++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 117
> +++++++++++++++++++++----
>  2 files changed, 121 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


