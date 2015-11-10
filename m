From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Nov 2015 20:48:16 +0000
Subject: [Intel-wired-lan] [next PATCH S21 09/14] i40e: use priv flags
 to	control packet split
In-Reply-To: <1446852372-25480-10-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-10-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E1F06@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, November 06, 2015 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S21 09/14] i40e: use priv flags to
> control packet split
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Ethtool priv flags implementation to enable or disable packet split, which is a
> hardware feature that inspects headers and will put headers in a separate
> DMA buffer from the payload data.  The driver was automatically choosing to
> enable packet split in some cases and this gives the user the ability to turn it
> off/on explicitly.
> 
> to query state:
> ethtool --show-priv-flags ethx
> 
> to enable:
> ethtool --set-priv-flags ethx packet-split on to disable:
> ethtool --set-priv-flags ethx packet-split off
> 
> Why would anyone want this?
> 	Because some environments benefit from header/data split in the
> receive
> 	buffer, and the driver defaults to one or the other depending on
> 	environment/kernel parameters.
> 
> Why didn't you implement a generic ethtool control for this feature?
> 	Because Intel hardware is the only hardware that supports
> header/data
> 	split.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I803121e1eecc9ccb2884031fd85dd1110b3af66d
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 27
> ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, ethtool shows new priv-flags, prif-flags can be manipulated using ethtool.
