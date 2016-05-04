From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 May 2016 16:09:24 +0000
Subject: [Intel-wired-lan] [next PATCH S36 06/12] i40e: Refactor
	ethtool	get_settings
In-Reply-To: <1462313600-3123-7-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
 <1462313600-3123-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D59AE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, May 03, 2016 3:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S36 06/12] i40e: Refactor ethtool
> get_settings
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> Previously we were only looking at the FW supported phy types if link was
> down, because we want to be more specific when link is up. This refactor
> changes this. When link is down, we still rely on the FW supported phy types,
> but when link is up, we select the possible supported link modes from what
> we know about the current phy type, and AND that with the FW supported
> phy types.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: Ice5dad83f2a17932b0b8b59f07439696ad6aa013
> ---
> Testing Hints:
> Make sure that various cables and cards report the correct
> supported/advertised link settings with ethtool.
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 258 +++++++++++++-------
> -----
>  1 file changed, 135 insertions(+), 123 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
various cables and cards report the correct supported/advertised link settings with ethtool
