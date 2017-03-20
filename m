From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 19:45:16 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/2] i40e: correctly honor the
	mask	fields for ETHTOOL_SRXCLSRLINS
In-Reply-To: <20170307230523.28702-1-jacob.e.keller@intel.com>
References: <20170307230523.28702-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A104065AA@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 1/2] i40e: correctly honor the mask
> fields for ETHTOOL_SRXCLSRLINS
> 
> The current implementation of .set_rxnfc does not properly read the mask
> field for filter entries. This results in incorrect driver behavior, as we do not
> reject filters which have masks set to ignore some fields. The current
> implementation simply assumes that every part of the tuple or "input set" is
> specified. This results in filters not behaving as expected, and not working
> correctly.
> 
> As a first step in supporting some partial filters, add code which checks the
> mask fields and rejects any filters which do not have an acceptable mask. For
> now, we just assume that all fields must be set.
> 
> This will get the driver one step towards allowing some partial filters.
> At a minimum, the ethtool commands which previously installed filters that
> would not function will now return a non-zero exit code indicating failure
> instead.
> 
> We should now be meeting the minimum requirements of the .set_rxnfc
> API, by ensuring that all filters we program have a valid mask value for each
> field.
> 
> Finally, add code to report the mask correctly so that the ethtool command
> properly reports the mask to the user.
> 
> Note that the typecast to (__be16) when checking source and destination
> port masks is required because the ~ bitwise negation operator does not
> correctly handle variables other than integer size.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: Ia020149e07c87aa3fcec7b2283621b887ef0546f
> ---
> This is a replacement for "[PART2,1/9] i40e: correctly honor the mask fields
> for ETHTOOL_SRXCLSRLINS"
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 83
> ++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

