From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 15:57:37 +0000
Subject: [Intel-wired-lan] [next PATCH S11 12/15] i40e: add little
 endian	conversion for checksum
In-Reply-To: <1440616461-110869-13-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-13-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5CA9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, August 26, 2015 12:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Stillwell Jr, Paul M
> Subject: [Intel-wired-lan] [next PATCH S11 12/15] i40e: add little endian
> conversion for checksum
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The checksum is not correct on big endian machines so add code to swap it
> correctly.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ic92b886d172a2cbe49f5d7eee1bc78e447023c7b
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code present in tree
