From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jan 2016 19:25:43 +0000
Subject: [Intel-wired-lan] [next PATCH S23 04/13] i40e/i40evf: Fix
	RSS	rx-flow-hash configuration through ethtool
In-Reply-To: <1449705033-4968-5-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
 <1449705033-4968-5-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F980211@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, December 09, 2015 3:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S23 04/13] i40e/i40evf: Fix RSS rx-
> flow-hash configuration through ethtool
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This patch fixes the Hash PCTYPE enable for X722 since it supports a broader
> selection of PCTYPES for TCP and UDP.
> 
> This patch also fixes a bug in XL710, X710, X722 support for RSS, as of now we
> cannot reduce the (4)tuple for RSS for TCP/IPv4/IPV6 or
> UDP/IPv4/IPv6 packets since this requires a product feature change that
> comes in a later release.
> 
> A VF should never be allowed to change the tuples for RSS for any PCTYPE
> since that's a global setting for the device in case of i40e devices.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I0ee7203c9b24813260f58f3220798bc9d9ac4a12
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 14 +++-----
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 40 +++++-----------------
>  2 files changed, 12 insertions(+), 42 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, RSS works correctly on PF and VF with UDP and TCP traffic
