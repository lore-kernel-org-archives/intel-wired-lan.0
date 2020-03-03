From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:08:46 +0000
Subject: [Intel-wired-lan] [PATCH S40 11/15] ice: fix use of deprecated
 strlcpy()
In-Reply-To: <20200227181505.61720-11-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-11-anthony.l.nguyen@intel.com>
Message-ID: <32328cc42f7744528242d582c6baf236@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 11/15] ice: fix use of deprecated
> strlcpy()
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> checkpatch complains "CHECK:DEPRECATED_API: Deprecated use of 'strlcpy',
> prefer 'stracpy or strscpy' instead"; use strscpy.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


