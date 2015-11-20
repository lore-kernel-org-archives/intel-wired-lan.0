From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 20 Nov 2015 04:48:20 +0000
Subject: [Intel-wired-lan] [next PATCH 4/5] e1000e: Switch e1000e_up to
 void, drop code checking for error result
In-Reply-To: <20151027235931.30048.548.stgit@localhost.localdomain>
References: <20151027235341.30048.46286.stgit@localhost.localdomain>
 <20151027235931.30048.548.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81D3DAC8@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, October 27, 2015 5:00 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 4/5] e1000e: Switch e1000e_up to
> void, drop code checking for error result
> 
> The function e1000e_up always returns 0.  As such we can convert it to a
> void and just ignore the results.  This allows us to drop some code in a
> couple spots as we no longer need to worry about non-zero return values.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/e1000e/e1000.h  |    2 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c |   15 ++++-----------
>  2 files changed, 5 insertions(+), 12 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
