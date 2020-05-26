From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:25:03 +0000
Subject: [Intel-wired-lan] [PATCH S44 08/14] ice: Check UMEM FQ size
 when allocating bufs
In-Reply-To: <20200516004226.4795-8-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-8-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16597A2B946004C469991E988CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S44 08/14] ice: Check UMEM FQ size when
> allocating bufs
> 
> From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> 
> If a UMEM is present on a queue when an interface/queue pair is being
> enabled, the driver will try to prepare the Rx buffers in advance to improve
> performance. However, if fill queue is shorter than HW Rx ring, the driver will
> report failure after getting the last address from the fill queue.
> 
> This still lets the driver process the packets correctly during the NAPI poll, but
> leads to a constant NAPI rescheduling. Not allocating the buffers in advance
> would result in a potential performance decrease.
> 
> Commit d57d76428ae9 ("xsk: Add API to check for available entries in FQ")
> provides an API that lets drivers check the number of addresses that the fill
> queue holds.
> 
> Notify the user if fill queue is not long enough to prepare all buffers before
> packet processing starts, and allocate the buffers during the NAPI poll. If the
> fill queue size is sufficient, prepare Rx buffers in advance.
> 
> Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 30 ++++++++++++++++-------
>  1 file changed, 21 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


