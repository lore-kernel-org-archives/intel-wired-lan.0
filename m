From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Sep 2018 14:57:09 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 01/14] intel-ethernet:
 rename i40evf to iavf
In-Reply-To: <20180915003757.169108-2-jesse.brandeburg@intel.com>
References: <20180915003757.169108-1-jesse.brandeburg@intel.com>
 <20180915003757.169108-2-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ED3E8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Friday, September 14, 2018 5:38 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 01/14] intel-ethernet: rename
> i40evf to iavf
> 
> Rename the Intel Ethernet Adaptive Virtual Function driver
> (i40evf) to a new name (iavf) that is more consistent with the ongoing
> maintenance of the driver as the universal VF driver for multiple product
> lines.
> 
> This first patch fixes up the directory names and the .ko name, intentionally
> ignoring the function names inside the driver for now.  Basically this is the
> simplest patch that gets the rename done and will be followed by other
> patches that rename the internal functions.
> 
> This patch also addresses a couple of string/name issues and updates the
> Copyright year.
> 
> Also, made sure to add a MODULE_ALIAS to the old name.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> ---
> 
> v2: add Kconfig migration as suggested by davem

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


