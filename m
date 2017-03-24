From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Mar 2017 19:02:10 +0000
Subject: [Intel-wired-lan] [net PATCH] i40e: Do not enable NAPI on
 q_vectors	that have no rings
In-Reply-To: <20170320213859.13451.3294.stgit@localhost.localdomain>
References: <20170320213859.13451.3294.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10409FC7@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, March 20, 2017 2:43 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net PATCH] i40e: Do not enable NAPI on q_vectors
> that have no rings
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> When testing the epoll w/ busy poll code I found that I could get into a state
> where the i40e driver had q_vectors w/ active NAPI that had no rings.
> This was resulting in a divide by zero error.  To correct it I am updating the
> driver code so that we only support NAPI on q_vectors that have 1 or more
> rings allocated to them.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> I am submitting this for net, not next-queue since this fixes an issue that can
> result in a kernel panic using existing kernel interfaces.
> 
> Testing Hints:
> 	I found the issue this fixes while using sockperf with busy poll.
> 	Basically all I did is run a test with sockperf in which busy
> 	polling was running, stopped the test, changed the number of
> 	queues via "ethtool -L" and the system generated a divide by 0
> 	error.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


