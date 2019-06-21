From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 21 Jun 2019 01:55:06 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Increase pause and refresh
 time
In-Reply-To: <d185164e-d09f-39ab-74f0-0c483ab52e67@molgen.mpg.de>
References: <d185164e-d09f-39ab-74f0-0c483ab52e67@molgen.mpg.de>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970B1294@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2019-05-17 at 17:01 +0200, Paul Menzel wrote:
> From: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
> Date: Mon, 27 Mar 2017 16:01:56 -0600
> 
> Suggested-by: Tim Pepper <timothy.c.pepper@linux.intel.com>
> Signed-off-by: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> Miguel, it?d be great, if you could write a commit message stating the 
> motivation for that change, that means, why is it preferable to increase 
> these values, and set the pause time unconditionally.
> 
>   drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Yes, a commit message explaining ramifiations of the change would be great. But from a functional perspective across my regression systems:
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
