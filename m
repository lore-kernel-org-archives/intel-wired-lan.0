From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 12 Oct 2021 22:10:12 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix reporting when
 setting descriptor count
In-Reply-To: <20211012135245.6979-1-michal.maloszewski@intel.com>
References: <20211012135245.6979-1-michal.maloszewski@intel.com>
Message-ID: <6309239359306fc8c0260301684ab0168626b239.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-10-12 at 13:52 +0000, Michal Maloszewski wrote:
> iavf_set_ringparams doesn't communicate to the user that
> 
> 1. The user requested descriptor count is out of range. Instead it
> ?? just quietly sets descriptors to the "clamped" value and calls it
> ?? done. This makes it look an invalid value was successfully set as
> ?? the descriptor count when this isn't actually true.
> 
> 2. The user provided descriptor count needs to be inflated for
> alignment
> ?? reasons.
> 
> This behavior is confusing. The ice driver has already addressed this
> by rejecting invalid values for descriptor count and messaging for
> alignment adjustments.
> Do the same thing here by adding the error and info messages.
> 
> Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")

I believe the commit that Ani provided was referencing the "ice driver
has already addressed this by rejecting invalid values for descriptor
count"

I don't believe this the the correct Fixes for this patch.

> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
> v3: Commit with fixes tag changed.

Your title has v1, but there's a v3 here.

Please use checkpatch before sending your patches:

WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#92:
by rejecting invalid values for descriptor count and messaging for
alignment adjustments.

WARNING: suspect code indent for conditional statements (8, 18)
#116: FILE: drivers/net/ethernet/intel/iavf/iavf_ethtool.c:615:
+       if (ring->tx_pending > IAVF_MAX_TXD ||
[...]
+                 netdev_err(netdev, "Descriptors requested (Tx: %d /
Rx: %d) out of range [%d-%d] (increment %d)\n",

WARNING: Statements should start on a tabstop
#123: FILE: drivers/net/ethernet/intel/iavf/iavf_ethtool.c:622:
+                 return -EINVAL;




