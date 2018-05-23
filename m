From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 May 2018 18:45:52 +0000
Subject: [Intel-wired-lan] [next-queue PATCH] ixgbevf: Fix coexistence
 of malicious driver detection with XDP
In-Reply-To: <20180522154429.80364.17986.stgit@ahduyck-green-test.jf.intel.com>
References: <20180522154429.80364.17986.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B771F2F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, May 22, 2018 8:44 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue PATCH] ixgbevf: Fix coexistence of
> malicious driver detection with XDP
> 
> In the case of the VF driver it is supposed to provide a context descriptor that
> allows us to provide information about the header offsets inside of the
> frame. However in the case of XDP we don't really have any of that
> information since the data is minimally processed. As a result we were seeing
> malicious driver detection (MDD) events being triggered when the PF had
> that functionality enabled.
> 
> To address this I have added a bit of new code that will "prime" the XDP ring
> by providing one context descriptor that assumes the minimal setup of an
> Ethernet frame which is an L2 header length of 14. With just that we can
> provide enough information to make the hardware happy so that we don't
> trigger MDD events.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |    1 +
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   36
> +++++++++++++++++----
>  2 files changed, 30 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


