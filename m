From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 15 Apr 2016 01:44:58 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/2] e1000e: Cleanup consistency
	in	ret_val variable usage
In-Reply-To: <a17942d94a295a0db7ef205060b97313289b1640.1460517387.git.brian@walsh.ws>
References: <1455662685-7231-1-git-send-email-brian@walsh.ws>
 <a17942d94a295a0db7ef205060b97313289b1640.1460517387.git.brian@walsh.ws>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EECC5B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Brian Walsh
> Sent: Tuesday, April 12, 2016 8:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 1/2] e1000e: Cleanup consistency in
> ret_val variable usage
> 
> Fixed the file to use a consistent ret_val for return value checking.
> 
> Signed-off-by: Brian Walsh <brian@walsh.ws>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

Number 2 of this series broke some machines, but this one looks good.
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
