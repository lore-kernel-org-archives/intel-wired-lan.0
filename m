From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 6 Mar 2017 17:43:15 +0000
Subject: [Intel-wired-lan] [PART1 PATCH 03/11] i40e: rework exit flow
	of	i40e_add_fdir_ethtool
In-Reply-To: <20170206223846.31052-4-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
 <20170206223846.31052-4-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401D2A@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PART1 PATCH 03/11] i40e: rework exit flow of
> i40e_add_fdir_ethtool
> 
> Refactor the exit flow of the i40e_add_fdir_ethtool function. Move the
> input_label to the end of the function, removing the dependency on having
> a non-zero return value. Add a comment explaining why it is ok not to free
> the fdir data structure, because the structure is now stored in the
> fdir_filter_list.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: I723342181d59cd0c9f3b31140c37961ba37bb242
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


