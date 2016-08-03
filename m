From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Aug 2016 17:24:32 +0000
Subject: [Intel-wired-lan] [next PATCH S40-V2 06/12] i40e: don't
	allow	reduction of channels below active FD rules
In-Reply-To: <1469646161-30024-7-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
 <1469646161-30024-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F72EF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, July 27, 2016 12:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S40-V2 06/12] i40e: don't allow
> reduction of channels below active FD rules
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> If a driver is unable to maintain all current user supplied settings from ethtool
> (or other sources), it is not ok for a user request to succeed and silently
> trample over previous configuration.
> 
> To that end, if you change the number of channels, it must not be allowed to
> reduce the number of channels (queues) below the current flow director
> filter rules targets. In this case, return -EINVAL when a request to reduce the
> number of channels would do so. In addition log a warning to the kernel
> buffer explaining why we failed, and report the rules which prevent us from
> lowering the number of channels.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: If41464d63d7aab11cedf09e4f3aa1a69e21ffd88
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 24
> ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Unable to set channels lower than channel used for flow director rules

