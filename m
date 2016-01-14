From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Jan 2016 03:06:18 +0000
Subject: [Intel-wired-lan] [next PATCH 01/11] igb: clean up code for
 setting	MAC address
In-Reply-To: <20160107071023.13648.94040.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>,
 <20160107071023.13648.94040.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4F133@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Alexander Duyck [aduyck at mirantis.com]
> Sent: Wednesday, January 06, 2016 11:10 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 01/11] igb: clean up code for setting    MAC address
> 
> Drop a bunch of hand written byte swapping code in favor of just doing the
> byte swapping ourselves.  The registers are little endian registers storing
> a big endian value so if we read the MAC address array as little endian
> then we will get the CPU registers into the proper layout.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
