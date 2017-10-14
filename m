From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Oct 2017 01:44:02 +0000
Subject: [Intel-wired-lan] [PATCH][V3] e1000: avoid null pointer
 dereference	on invalid stat type
In-Reply-To: <20170922171348.17630-1-colin.king@canonical.com>
References: <20170922171348.17630-1-colin.king@canonical.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6C189D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Colin King
> Sent: Friday, September 22, 2017 10:14 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][V3] e1000: avoid null pointer dereference
> on invalid stat type
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if the stat type is invalid then data[i] is being set
> either by dereferencing a null pointer p, or it is reading from
> an incorrect previous location if we had a valid stat type
> previously.  Fix this by skipping over the read of p on an invalid
> stat type.
> 
> Detected by CoverityScan, CID#113385 ("Explicit null dereferenced")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
