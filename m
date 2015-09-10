From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 20:31:58 +0000
Subject: [Intel-wired-lan] [next PATCH S14 09/15] i40e: update fw
 version	text string per previous product formats
In-Reply-To: <1441065295-234333-10-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
 <1441065295-234333-10-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A623B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, August 31, 2015 4:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S14 09/15] i40e: update fw version
> text string per previous product formats
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch moves the internal fw version and fw api version info to be output
> in probe.  The nvm version, etrack and oem version info are now configured
> for output via ethtool -i.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: I05d490093a7137dbefcdef263d014d1e5c9e83d0
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 10 ++++++----
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  7 +++++++
>  2 files changed, 13 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, 'ethtool -i [device] shows proper info
